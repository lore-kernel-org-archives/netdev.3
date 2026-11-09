Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794241745;
	b=1prEg1zax/sYTABOPiUjk63KOTxMN7+jtAH0ykX+u6rt3GCOfBqy89g+XgxBAeAqqYCV
	 oJln/Ex1eAQfslQ6+Phh5QELT84NnqJIDWZHCAH9ag5vRaAXOrilTgdLcy12GuFjYCtIU
	 r8Tu8vILqdP0B8NoJKup8h3aANGTqMVR3htUQNzIiRatMfHhBte1xd3me01QDX4h4DsXf
	 eEwHXrjcuB46yTUacSlcUJiKsPZNkrApxHEzX78YrLtgtnVyDT3BiH+X3ywMe/+1//or5
	 86skyZNL2GDrXA705y6D+izZfIrhiMgSkFufuX6qN2KszttcJ3CBy2ie0I4zEyVWt6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794241745;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=+wKoAl1FW1vm+tW9zY3P0e+1MhwDN+CrAKa0Yn3hR30=;
	b=s6ZguiDi39emDOTrBIqJaPJtv0NjkIpVAJdE7UD00PBze3BJMV3ZoXBraCkr8z9vsdy1
	 tsjjZ6/yYszDUn9Toh3GA8ifQ52TP4wA6g5YssSnpc0DLj+oSuRcMmM8GEWKirqOxZCcO
	 /HLFIOQegK/L0H0R3mPgY1h30tPqgIrooSVbfmbB1ifUi9pr3DtmJ58ZyL5jDe7aKR8sm
	 jsOTc/Nphkg55W41t41e0DHK4Se7FDzU6T4fpeRVxPY0gqHIiiWuVouwOAZp1v/30AHRK
	 wMHc2OrGdlLtmxEmeWjaUGmeQeFpComA7cV78UnhZ/vKonhxwZHRwjcGsQKwefzKVgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="HEEkgg5/";
	arc=none smtp.remote-ip=209.85.160.171
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FE3606A31C
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 16:29:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2FE3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HEEkgg5/
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-53381e53b80so12724861cf.1
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 08:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794241743; x=1794846543; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+wKoAl1FW1vm+tW9zY3P0e+1MhwDN+CrAKa0Yn3hR30=;
        b=HEEkgg5/cY8PYosLb0AsSR+DQ0fzsVsInS9+B88MSMW826OfI39ny+CrRdc+A/LODL
         bcbVmYxIx3CWsZuC6N3wxhobNnlm8AkY+PNI9fc1EMmmgfbJJq6MUnKG/zg7GODwpWPh
         AQont3wNsKaBr9XiAljFJpNWGDHORCMXTeXuQoUbrz7dtKoYuwHN/4y9X2cRubG0oPyL
         fmCUzX7/agt5VYDxBy16GhH2BfUW/MvANTmZcESwlwD+wqaGmr0kKVti15WmVqpwi/M0
         rqP68PE0aV/SdMrIqPg5Ggp3lPLZs4E2VWrzVs/MV1t18dWq7RRv+o5pffiyWt+lCSYK
         xmBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794241743; x=1794846543;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+wKoAl1FW1vm+tW9zY3P0e+1MhwDN+CrAKa0Yn3hR30=;
        b=xw4NycMCxUVdt4IClsJAWCn/wipAJLfMCKP33XLdugq5uRjRlqRBr7ncTkSzFTMvMF
         Na+zSoGPIdQhliEG7sS+xsqD/EVhuJkO0g9rBXrY9gXtJQ56PLzAnkRxQA1KA6HEyxpg
         Fbk5e90L1QhGixPUfmjNfI74TCBSWPQbd4E+b1169VF7vPEEQ4/9LkTc3W2nFmAh10Yd
         HSAUyNICpBURNdNcD4kpwHdXL6gMDWeq+ZXRhrUoc7y9/X4D9OTjzPe4stw+B3UIcZK+
         Dp4J4EOuFj0rvUQ9n1BHMK45cM/RHjTeYW8P9sZ+KVB35yoejPOMGsAPZOV9xk9l7jpt
         625Q==
X-Gm-Message-State: APuU4Z8CJK7NKVQ1KNH2EPRRrTAubDnO71JmjltpeoFjdwA0IqA30egz
	+sE6WYUpl0wOM1EZrW+SkgAmMt5enHUqURD22ecBmPNmlBLpsY1wCK7eeDLVIyqA
X-Gm-Gg: AYBFou2IRKFjWKVYoO9qf3exn88847Bt2BabjuT70PFbLulf2L+zXIQpzNlxKM6dObZ
	ejVLO0dRLc+/rInhj36h5eUcJeF8eYH5SnusHinovcmvMvQAVpH44OHjLhSCleeGhUziF9T/ftM
	AAm+n5UFnwr82CtQl+nJhFIXTC/mfKkIakAwsFj4M6hs6ZKYQCq2YhCFvkU6cJ4BF8+v9Os5boI
	jfLR+ZtDvoZeekb6QUKnejskZoFkLJ+ICAmSntoctNXDdWC36JTVorxLHC5l2L8ZB28rz7wQs0n
	yac7iX6YLWQONtS6DU5gw9xR1hZsLbRJz/TpeGErx2D968ERwqR5voYfgDl6UtB9GL2CamH79qo
	1KH6mJsfDFGTafT08gkatVEKgrU+MQR1e+7LJg8IVaOBhTofQsyh8457rCb9kXe3RmRpbXkrUAc
	rEiacbsHRBJDYBWgTTKB3oIeBnfIjMwk+2/jMtyMey9R8uygJkygJP2hhE/n1UIX/Esh/NyiuEd
	IxVVHXsNSVuu6HUPqkjbT2wGM1zuh+J95s84LIpspLX2QO6TCegBtyY4OecSqjNiwRSFV+7HPjS
	txyOwKTAoCFn/8fJVANYw10FdhT+jleukNWTilW8O5VP/iBjY0CMzFOhpfHEsKT9VIihqaW1Ggk
	Fj1dnZlzw8qt2vygx5jM6RL1LE1vYg8xo4HoYW79AjC1EpXKVR66t55PnnsUlvpqSqBMr/fHB
X-Received: by 2002:a05:620a:8386:b0:944:14f4:a5cb with SMTP id af79cd13be357-947841072aamr598073685a.12.1794241742598;
        Mon, 09 Nov 2026 08:29:02 -0800 (PST)
Received: from wsfd-netdev58.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e7915e2sm9102985a.23.2026.11.09.08.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 08:29:01 -0800 (PST)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>,
	quic@lists.linux.dev
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Metzmacher <metze@samba.org>,
	Moritz Buhl <mbuhl@openbsd.org>,
	Tyler Fanelli <tfanelli@redhat.com>,
	Pengtao He <hepengtao@xiaomi.com>,
	Thomas Dreibholz <dreibh@simula.no>,
	linux-cifs@vger.kernel.org,
	Paulo Alcantara <pc@manguebit.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Tom Talpey <tom@talpey.com>,
	kernel-tls-handshake@lists.linux.dev,
	Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Steve Dickson <steved@redhat.com>,
	Hannes Reinecke <hare@suse.de>,
	Alexander Aring <aahringo@redhat.com>,
	David Howells <dhowells@redhat.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	John Ericson <mail@johnericson.me>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	"D . Wythe" <alibuda@linux.alibaba.com>,
	Jason Baron <jbaron@akamai.com>,
	illiliti <illiliti@protonmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Daniel Stenberg <daniel@haxx.se>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	mef@scarletmail.rutgers.edu,
	paul@jakma.org,
	Kuniyuki Iwashima <kuniyu@google.com>
Subject: [PATCH net-next v18 00/15] net: introduce QUIC infrastructure and core subcomponents
Date: Mon,  9 Nov 2026 11:27:21 -0500
Message-ID: <cover.1794241654.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.47.1
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Introduction
============

The QUIC protocol, defined in RFC 9000, is a secure, multiplexed transport
built on top of UDP. It enables low-latency connection establishment,
stream-based communication with flow control, and supports connection
migration across network paths, while ensuring confidentiality, integrity,
and availability.

This implementation introduces QUIC support in Linux Kernel, offering
several key advantages:

- In-Kernel QUIC Support for Subsystems: Enables kernel subsystems
  such as SMB and NFS to operate over QUIC with minimal changes. Once the
  handshake is complete via the net/handshake APIs, data exchange proceeds
  over standard in-kernel transport interfaces.

- Standard Socket API Semantics: Implements core socket operations
  (listen(), accept(), connect(), sendmsg(), recvmsg(), close(),
  getsockopt(), setsockopt(), getsockname(), and getpeername()),
  allowing user space to interact with QUIC sockets in a familiar,
  POSIX-compliant way.

- ALPN-Based Connection Dispatching: Supports in-kernel ALPN
  (Application-Layer Protocol Negotiation) routing, allowing demultiplexing
  of QUIC connections across different user-space processes based
  on the ALPN identifiers.

- Performance Enhancements: Handles all control messages in-kernel
  to reduce syscall overhead, incorporates zero-copy mechanisms such as
  sendfile() to minimize data movement, and is also structured to support
  future crypto hardware offloads.

This implementation offers fundamental support for the following RFCs:

- RFC9000 - QUIC: A UDP-Based Multiplexed and Secure Transport
- RFC9001 - Using TLS to Secure QUIC
- RFC9002 - QUIC Loss Detection and Congestion Control
- RFC9221 - An Unreliable Datagram Extension to QUIC
- RFC9287 - Greasing the QUIC Bit
- RFC9368 - Compatible Version Negotiation for QUIC
- RFC9369 - QUIC Version 2

The socket APIs for QUIC follow the RFC draft [1]:

- The Sockets API Extensions for In-kernel QUIC Implementations

Implementation
==============

The central design is to implement QUIC within the kernel while delegating
the handshake to userspace.

Only the processing and creation of raw TLS Handshake Messages are handled
in userspace, facilitated by a TLS library like GnuTLS. These messages are
exchanged between kernel and userspace via sendmsg() and recvmsg(), with
cryptographic details conveyed through control messages (cmsg).

The entire QUIC protocol, aside from the TLS Handshake Messages processing
and creation, is managed in the kernel. Rather than using an Upper Layer
Protocol (ULP) layer, this implementation establishes a socket of type
IPPROTO_QUIC (similar to IPPROTO_MPTCP), operating over UDP tunnels.

For kernel consumers, they can initiate a handshake request from the kernel
to userspace using the existing net/handshake netlink. The userspace
component, such as tlshd service [2], then manages the processing
of the QUIC handshake request.

- Handshake Architecture:

  ┌──────┐  ┌──────┐
  │ APP1 │  │ APP2 │ ...
  └──────┘  └──────┘
  ┌──────────────────────────────────────────┐
  │     {quic_client/server_handshake()}     │<─────────────┐
  └──────────────────────────────────────────┘       ┌─────────────┐
   {send/recvmsg()}      {set/getsockopt()}          │    tlshd    │
   [CMSG handshake_info] [SOCKOPT_CRYPTO_SECRET]     └─────────────┘
                         [SOCKOPT_TRANSPORT_PARAM_EXT]    │   ^
                │ ^                  │ ^                  │   │
  Userspace     │ │                  │ │                  │   │
  ──────────────│─│──────────────────│─│──────────────────│───│───────
  Kernel        │ │                  │ │                  │   │
                v │                  v │                  v   │
  ┌──────────────────┬───────────────────────┐       ┌─────────────┐
  │ protocol, timer, │ socket (IPPROTO_QUIC) │<──┐   │ handshake   │
  │                  ├───────────────────────┤   │   │netlink APIs │
  │ common, family,  │ outqueue  |  inqueue  │   │   └─────────────┘
  │                  ├───────────────────────┤   │      │       │
  │ stream, connid,  │         frame         │   │   ┌─────┐ ┌─────┐
  │                  ├───────────────────────┤   │   │     │ │     │
  │ path, pnspace,   │         packet        │   │───│ SMB │ │ NFS │...
  │                  ├───────────────────────┤   │   │     │ │     │
  │ cong, crypto     │       UDP tunnels     │   │   └─────┘ └─────┘
  └──────────────────┴───────────────────────┘   └──────┴───────┘

- User Data Architecture:

  ┌──────┐  ┌──────┐
  │ APP1 │  │ APP2 │ ...
  └──────┘  └──────┘
   {send/recvmsg()}   {set/getsockopt()}              {recvmsg()}
   [CMSG stream_info] [SOCKOPT_KEY_UPDATE]            [EVENT conn update]
                      [SOCKOPT_CONNECTION_MIGRATION]  [EVENT stream update]
                      [SOCKOPT_STREAM_OPEN/RESET/STOP]
                │ ^               │ ^                     ^
  Userspace     │ │               │ │                     │
  ──────────────│─│───────────────│─│─────────────────────│───────────
  Kernel        │ │               │ │                     │
                v │               v │  ┌──────────────────┘
  ┌──────────────────┬───────────────────────┐
  │ protocol, timer, │ socket (IPPROTO_QUIC) │<──┐{kernel_send/recvmsg()}
  │                  ├───────────────────────┤   │{kernel_set/getsockopt()}
  │ common, family,  │ outqueue  |  inqueue  │   │{kernel_recvmsg()}
  │                  ├───────────────────────┤   │
  │ stream, connid,  │         frame         │   │   ┌─────┐ ┌─────┐
  │                  ├───────────────────────┤   │   │     │ │     │
  │ path, pnspace,   │         packet        │   │───│ SMB │ │ NFS │...
  │                  ├───────────────────────┤   │   │     │ │     │
  │ cong, crypto     │       UDP tunnels     │   │   └─────┘ └─────┘
  └──────────────────┴───────────────────────┘   └──────┴───────┘

Interface
=========

This implementation supports a mapping of QUIC into sockets APIs. Similar
to TCP and SCTP, a typical Server and Client use the following system call
sequence to communicate:

    Client                             Server
  ──────────────────────────────────────────────────────────────────────
  sockfd = socket(IPPROTO_QUIC)      listenfd = socket(IPPROTO_QUIC)
  bind(sockfd)                       bind(listenfd)
                                     listen(listenfd)
  connect(sockfd)
  quic_client_handshake(sockfd)
                                     sockfd = accept(listenfd)
                                     quic_server_handshake(sockfd, cert)

  sendmsg(sockfd)                    recvmsg(sockfd)
  close(sockfd)                      close(sockfd)
                                     close(listenfd)

Please note that quic_client_handshake() and quic_server_handshake()
functions are currently sourced from libquic [3]. These functions are
responsible for receiving and processing the raw TLS handshake messages
until the completion of the handshake process.

For utilization by kernel consumers, it is essential to have tlshd
service [2] installed and running in userspace. This service receives
and manages kernel handshake requests for kernel sockets. In the kernel,
the APIs closely resemble those used in userspace:

    Client                             Server
  ────────────────────────────────────────────────────────────────────────
  __sock_create(IPPROTO_QUIC, &sock)  __sock_create(IPPROTO_QUIC, &sock)
  kernel_bind(sock)                   kernel_bind(sock)
                                      kernel_listen(sock)
  kernel_connect(sock)
  tls_client_hello_x509(args:{sock})
                                      kernel_accept(sock, &newsock)
                                      tls_server_hello_x509(args:{newsock})

  kernel_sendmsg(sock)                kernel_recvmsg(newsock)
  sock_release(sock)                  sock_release(newsock)
                                      sock_release(sock)

Please be aware that tls_client_hello_x509() and tls_server_hello_x509()
are APIs from net/handshake/. They are used to dispatch the handshake
request to the userspace tlshd service and subsequently block until the
handshake process is completed.

Use Cases
=========

- Samba

  Stefan Metzmacher has integrated Linux QUIC into Samba for both client
  and server roles [4].

- tlshd

  The tlshd daemon [2] facilitates Linux QUIC handshake requests from
  kernel sockets. This is essential for enabling protocols like SMB
  and NFS over QUIC.

- curl

  Linux QUIC is being integrated into curl [5] for HTTP/3. Example usage:

  # curl --http3-only https://nghttp2.org:4433/
  # curl --http3-only https://www.google.com/
  # curl --http3-only https://facebook.com/
  # curl --http3-only https://outlook.office.com/
  # curl --http3-only https://cloudflare-quic.com/

- httpd-portable

  Moritz Buhl has deployed an HTTP/3 server over Linux QUIC [6] that is
  accessible via Firefox and curl:

  https://d.moritzbuhl.de/pub

- NetPerfMeter

  The latest NetPerfMeter release supports Linux QUIC and can be used to
  run performance evaluations [10].

Test Coverage
=============

The Coverage (gcov) of Functional and Interop Tests:

https://d.moritzbuhl.de/lcov

- Functional Tests

  The libquic self-tests (make check) pass on all major architectures:
  x86_64, i386, s390x, aarch64, ppc64le.

- Interop tests

  Interoperability was validated using the QUIC Interop Runner [7] against
  all major userland QUIC stacks. Results are available at:

  https://d.moritzbuhl.de/

- Fuzzing via Syzkaller

  Syzkaller has been running kernel fuzzing with QUIC for weeks using
  tests/syzkaller/ in libquic [3].

- Performance Testing

  Performance was benchmarked using iperf [8] over a 100G NIC using
  various MTUs and packet sizes:

  - QUIC vs. kTLS:

    UNIT        size:1024      size:4096      size:16384     size:65536
    Gbits/sec   QUIC | kTLS    QUIC | kTLS    QUIC | kTLS    QUIC | kTLS
    ────────────────────────────────────────────────────────────────────
    mtu:1500    2.27 | 3.26    3.02 | 6.97    3.36 | 9.74    3.48 | 10.8
    ────────────────────────────────────────────────────────────────────
    mtu:9000    3.66 | 3.72    5.87 | 8.92    7.03 | 11.2    8.04 | 11.4

  - QUIC(disable_1rtt_encryption) vs. TCP:

    UNIT        size:1024      size:4096      size:16384     size:65536
    Gbits/sec   QUIC | TCP     QUIC | TCP     QUIC | TCP     QUIC | TCP
    ────────────────────────────────────────────────────────────────────
    mtu:1500    3.09 | 4.59    4.46 | 14.2    5.07 | 21.3    5.18 | 23.9
    ────────────────────────────────────────────────────────────────────
    mtu:9000    4.60 | 4.65    8.41 | 14.0    11.3 | 28.9    13.5 | 39.2


  The performance gap between QUIC and kTLS may be attributed to:

  - The absence of Generic Segmentation Offload (GSO) for QUIC.
  - An additional data copy on the transmission (TX) path.
  - Extra encryption required for header protection in QUIC.
  - A longer header length for the stream data in QUIC.

Patches
=======

Note: This implementation is organized into five parts and submitted across
two patchsets for review. This patchset includes Parts 1–2, while Parts 3–5
will be submitted in a subsequent patchset. For complete series, see [9].

1. Infrastructure (2):

  net: define IPPROTO_QUIC and SOL_QUIC constants
  net: build socket infrastructure for QUIC protocol

2. Subcomponents (13):

  quic: provide common utilities and data structures
  quic: provide family ops for address and protocol
  quic: provide quic.h header files for kernel and userspace
  quic: add stream management
  quic: add connection id management
  quic: add path management
  quic: add congestion control
  quic: add packet number space
  quic: add crypto key derivation and installation
  quic: add crypto packet encryption and decryption
  quic: add timer management
  quic: add packet builder base
  quic: add packet parser base

3. Data Processing (8):

  quic: add frame encoder and decoder base
  quic: implement outqueue transmission and flow control
  quic: implement outqueue sack and retransmission
  quic: implement inqueue receiving and flow control
  quic: implement frame creation functions
  quic: implement frame processing functions
  quic: implement packet creation functions
  quic: implement packet processing functions

4. Socket APIs (6):

  quic: support bind/listen/connect/accept/close()
  quic: support sendmsg() and recvmsg()
  quic: support socket options related to interaction after handshake
  quic: support socket options related to settings prior to handshake
  quic: support socket options related to setup during handshake
  quic: support socket ioctls and socket dump via procfs

5. Documentation and Selftests (3):

  Documentation: describe QUIC protocol interface in quic.rst
  quic: create sample test using handshake APIs for kernel consumers
  selftests: net: add tests for QUIC protocol

Notice: The QUIC module is currently labeled as "EXPERIMENTAL".

All contributors are recognized in the respective patches with the tag of
'Signed-off-by:'. Special thanks to Moritz Buhl and Stefan Metzmacher whose
practical use cases and insightful feedback have been instrumental in
shaping the design and advancing the development.

References
==========

[1]  https://datatracker.ietf.org/doc/html/draft-lxin-quic-socket-apis
[2]  https://github.com/oracle/ktls-utils
[3]  https://github.com/lxin/quic
[4]  https://gitlab.com/samba-team/samba/-/merge_requests/4019
[5]  https://github.com/moritzbuhl/curl/tree/linux_curl
[6]  https://github.com/moritzbuhl/httpd-portable
[7]  https://github.com/quic-interop/quic-interop-runner
[8]  https://github.com/lxin/iperf
[9]  https://github.com/lxin/net-next/commits/quic/
[10] https://www.nntb.no/~dreibh/netperfmeter/

Changes in v2-v18: See individual patch changelogs for details.

Xin Long (15):
  net: define IPPROTO_QUIC and SOL_QUIC constants
  net: build socket infrastructure for QUIC protocol
  quic: provide common utilities and data structures
  quic: provide family ops for address and protocol
  quic: provide quic.h header files for kernel and userspace
  quic: add stream management
  quic: add connection id management
  quic: add path management
  quic: add congestion control
  quic: add packet number space
  quic: add crypto key derivation and installation
  quic: add crypto packet encryption and decryption
  quic: add timer management
  quic: add packet builder base
  quic: add packet parser base

 Documentation/networking/ip-sysctl.rst        |   39 +
 MAINTAINERS                                   |    9 +
 include/linux/quic.h                          |   38 +
 include/linux/socket.h                        |    1 +
 include/trace/events/sock.h                   |    3 +-
 include/uapi/linux/in.h                       |    2 +
 include/uapi/linux/quic.h                     |  242 +++
 net/Kconfig                                   |    1 +
 net/Makefile                                  |    1 +
 net/quic/Kconfig                              |   37 +
 net/quic/Makefile                             |    9 +
 net/quic/common.c                             |  565 +++++++
 net/quic/common.h                             |  220 +++
 net/quic/cong.c                               |  292 ++++
 net/quic/cong.h                               |  143 ++
 net/quic/connid.c                             |  311 ++++
 net/quic/connid.h                             |  191 +++
 net/quic/crypto.c                             | 1321 +++++++++++++++++
 net/quic/crypto.h                             |   95 ++
 net/quic/family.c                             |  441 ++++++
 net/quic/family.h                             |   48 +
 net/quic/packet.c                             | 1088 ++++++++++++++
 net/quic/packet.h                             |  109 ++
 net/quic/path.c                               |  596 ++++++++
 net/quic/path.h                               |  193 +++
 net/quic/pnspace.c                            |  273 ++++
 net/quic/pnspace.h                            |  201 +++
 net/quic/protocol.c                           |  403 +++++
 net/quic/protocol.h                           |   57 +
 net/quic/socket.c                             |  692 +++++++++
 net/quic/socket.h                             |  242 +++
 net/quic/stream.c                             |  427 ++++++
 net/quic/stream.h                             |  133 ++
 net/quic/timer.c                              |  154 ++
 net/quic/timer.h                              |   45 +
 tools/include/uapi/linux/in.h                 |    2 +
 .../perf/trace/beauty/include/linux/socket.h  |    1 +
 usr/include/Makefile                          |    1 +
 38 files changed, 8625 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/quic.h
 create mode 100644 include/uapi/linux/quic.h
 create mode 100644 net/quic/Kconfig
 create mode 100644 net/quic/Makefile
 create mode 100644 net/quic/common.c
 create mode 100644 net/quic/common.h
 create mode 100644 net/quic/cong.c
 create mode 100644 net/quic/cong.h
 create mode 100644 net/quic/connid.c
 create mode 100644 net/quic/connid.h
 create mode 100644 net/quic/crypto.c
 create mode 100644 net/quic/crypto.h
 create mode 100644 net/quic/family.c
 create mode 100644 net/quic/family.h
 create mode 100644 net/quic/packet.c
 create mode 100644 net/quic/packet.h
 create mode 100644 net/quic/path.c
 create mode 100644 net/quic/path.h
 create mode 100644 net/quic/pnspace.c
 create mode 100644 net/quic/pnspace.h
 create mode 100644 net/quic/protocol.c
 create mode 100644 net/quic/protocol.h
 create mode 100644 net/quic/socket.c
 create mode 100644 net/quic/socket.h
 create mode 100644 net/quic/stream.c
 create mode 100644 net/quic/stream.h
 create mode 100644 net/quic/timer.c
 create mode 100644 net/quic/timer.h

-- 
2.47.1

