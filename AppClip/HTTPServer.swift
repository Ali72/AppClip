//
//  HTTPServer.swift
//  AppClip
//
//  Created by nixzhu on 2017/7/13.
//  Copyright © 2017年 nixWork. All rights reserved.
//

import Foundation

public class HTTPServer {

    var socket: Socket?

    public init() {
    }

    public func start(address: String? = nil, port: in_port_t = 8964) throws {
        socket = try Socket.tcpSocketForListen(address: address, port: port)

        print("accepting...")
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let strongSelf = self else { return }
            guard let socket = strongSelf.socket else { return }
            while let clientSocket = try? socket.acceptClientSocket() {
                print("cliend socket: \(clientSocket.socketFileDescriptor)")
                DispatchQueue.global(qos: .background).async { [weak self] in
                    guard let strongSelf = self else { return }
                    strongSelf.handleConnection(clientSocket)
                }
            }
        }
    }

    private func handleConnection(_ socket: Socket) {
        print("handle connection")
        let parser = HTTPRequestParser()
        do {
            let request = try parser.readHTTPRequest(socket)
            print("request: \(request)")

            var htmlLines: [String] = []
            htmlLines.append("<html>")
            htmlLines.append("<head>")
            htmlLines.append("<title>Success</title>")
            htmlLines.append("</head>")
            htmlLines.append("<body>")
            htmlLines.append("<h1>Server is working!</h1>")
            htmlLines.append("<p>\(Date())</p>")
            htmlLines.append("</body>")
            htmlLines.append("</html>")
            let htmlString = htmlLines.joined(separator: "\n")
            try respond(socket, htmlString: htmlString)
        } catch {
            print(error)
        }
        socket.close()
    }

    private func respond(_ socket: Socket, htmlString: String) throws {
        var lines: [String] = []
        lines.append("HTTP/1.1 200 OK")
        lines.append("Connecttion: close")
        lines.append("Content-Type: text/html")
        lines.append("Connecttion: close")
        lines.append("Content-Length: \(htmlString.characters.count)")
        lines.append("")
        lines.append(htmlString)
        let string = lines.joined(separator: "\r\n")
        try socket.writeUTF8(string)
    }
}
