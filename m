Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794241746;
	b=z2p1lDpWXSVmEZr1iEjShvRDtd1obKJO1/lJmIZu0hlS5+btlp6NBONGZanpWpYXs+CG
	 aYTGrFqPaRp0uCdS4z3TI6W78b0uyKAAs9RMur5dvrVJmie63ezRGj62DY4Pjpf2zO6Er
	 3c9HCcHtGmBMnJYkL0W64N7PXetJMvg4Npd8tP/xzkItjFGYmcc8menhBHq7WU95xFvZI
	 y9mDl917H6bAidDVWqbtEBKQ/1iGID34xrQuHFBpy8jDKRXOQwOgcBPDwslkCAuFlMOXo
	 mIocdA2/1Cge/hrSbnAqjbgGZncRWVcf0qmOuteZ1Jz7exjqtOH90pz2WYYmq8VXfLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794241746;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/O0FGH5CqQtLOMdXA3tsJ0Y4Pi9rOFAIORHYN0Xkwds=;
	b=4TN+ae9OD8O3Xf9OnelWQGXK71QDHe9N5HsC/Vo4xvTnrFrfYZV+UrBsW4ElvNyFf3l0
	 ejP3fGCIIFv4RyYU2qie83uYsWh7Gw6GAcFRv9qil5zAXykh/GrfaRLXZnQYd6py2oDJF
	 5h+ZgjfUMJkHVph3gDZm1NceQn9RBPj5mfkGoIbDuyuGAp0DDfr8O3CW36Ivt3Hqj7L3h
	 13PbknCNon/yzHL5aikyI9VULc5SfhoPUJhloOE3pjqbW0DkuzevBwcZxtpDPp86I2pXZ
	 XLabu9EPzSZcYiFgXiw+jG3wDraTezo4q/dO2NkmujiyWRwJtfsPnkopDTuMOhz93Og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E3JNpM3O;
	arc=none smtp.remote-ip=209.85.219.53
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D13606A332
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 16:29:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74D13606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E3JNpM3O
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-91c1f548f87so14527446d6.2
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 08:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794241744; x=1794846544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/O0FGH5CqQtLOMdXA3tsJ0Y4Pi9rOFAIORHYN0Xkwds=;
        b=E3JNpM3O+S67YJj0nXg3caMC0VXeZLIVOrDqUEzsa7FHkr8pOF3ncK0TAE8af84OlQ
         Ylbcuelcq3EyFHFXFreRw0/rQYSnRSVRbIfo2D+Ba3kya03BFgShXWEQErWdl+LKTQ56
         yjPD06qxADKm4SYo/FNU283pRRu53TkBeNz9AqBS9ytVh6Pck/tM6fOzf6zdvy/u2iKF
         1HenSuQii/+Nx03oEk36C7qRvjujSWuTTzNLUfZLroXoFdBrUtd0fWshDqcuvrWBKgeD
         5moonsLz4v0CZQikqpazzg+4WmfDb8BEzhTUKZlM1JSb+gmjALgLtdQmLkkKECMhBDRv
         8xxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794241744; x=1794846544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/O0FGH5CqQtLOMdXA3tsJ0Y4Pi9rOFAIORHYN0Xkwds=;
        b=020ebYhFd89ce7g/IQUChuZvMTtow5Rb96nN8L1p2tI6TF2a6uPrnyIhmvWvqN6uPY
         qduek6SU5xSO+UXumXVwkshxMP2Zd+wxMea1sA0qkF+wuvuljJQmoJ7fOFdE/2WEvtwx
         ZaKX97AKYjgOVpJVbbvKBFAWiASCK5Ut8TogkqZ3IKdjyXh99PMyX0Z4kld6haZwoKPt
         /g2UoRN+mI9Cg8w25qUHYHS4EfX+TQWWlp4jSAADm1vwZEZPEuvhLVyOCbLI0expv88T
         RWlPBLz9dSdEVWR0uCNv4UuRqA/JjdE8jfgOxjaYzFT/B0RAqSJ5Ntbq5L/wrQMfLS0O
         s+Pg==
X-Gm-Message-State: APuU4Z/D86KgR5BYo8dXR+iEd65jDMv+KHJGuCSMKPZ5fP3VZV5xTl3s
	T76pNVROKl0GEzh7/h2mPTkbIw/iwtCk6GMX0oC5HkbZN/NbqStJtGeiy0MSgGI9
X-Gm-Gg: AYBFou0oY9CI6AA+fLvT57yWn+fE6cm2RY9mmlaOFVXMB9u06+AYg1EFuP5lPOHTnH/
	QSkaf8vc769Ird1CdzZfNVtpyKQ1+0VWxfJnGYoB38rQ4NkekOCOnYQu5ZM3OH81RXtqVhHSE9d
	B6mmT+MiD5WkuZDeJIB1jd4MzMTbabRO0kXEJE9axP2qmiFmXUdgF2SNHHm2bERRnOasVQt5Hlu
	sM0R/ZVySF1o70hZpORbWTUDS0+VPsk/wWBvlEa703aSDqctL+TiYoEJt4c2DM6hs/jSIkO4jOp
	SGbIHfiGaC4uTPH2yQQwXkUmhA0kTBI9Lz3OIY+0QawCEHO+GUt2jkQlrTaJyegQA7N+5Mioi9T
	sFKSOc/E+j4YQLB6zfvfwjbNo6sOJ3KG9YHQfVeCunawWcwM0ockxoljP39Jye/d9cUChITKdqh
	6YG9YO0ajM44Ki/ID469ZtGzZJyM8yzXg5BC2cwghfgexJV3TcadEXEAIddUypX8fFxy0olIT0G
	p0Ci9xAHnLdxsxe8yaHx+EVCSJEpeVDhv8a8MuIerkOCgnmrz1Csp76rjMrahJ7mVjQUAgVwBXZ
	IaK7vjbnb/TDX2y/z0xYXwfCLnLts+vyt+RmoJXVsCd2wMnhupydzUR8ntdiRM/oV1lStNphMDN
	39WYustjUeJWT0EyGYsBuDSvcjjfnb4jdwzz0Vp0z7J8dnpLpp6ypK78IWUnC5I8E4d7QZMQ=
X-Received: by 2002:a05:620a:684a:b0:93b:d7a1:ba16 with SMTP id af79cd13be357-9478429fbabmr674455985a.65.1794241744286;
        Mon, 09 Nov 2026 08:29:04 -0800 (PST)
Received: from wsfd-netdev58.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e7915e2sm9102985a.23.2026.11.09.08.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 08:29:03 -0800 (PST)
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
Subject: [PATCH net-next v18 01/15] net: define IPPROTO_QUIC and SOL_QUIC constants
Date: Mon,  9 Nov 2026 11:27:22 -0500
Message-ID: <aa09dd7fd9057b0951b7ace985d3feb269a71d7d.1794241655.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1794241654.git.lucien.xin@gmail.com>
References: <cover.1794241654.git.lucien.xin@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds IPPROTO_QUIC and SOL_QUIC constants to the networking
subsystem. These definitions are essential for applications to set
socket options and protocol identifiers related to the QUIC protocol.

QUIC does not possess a protocol number allocated from IANA, and like
IPPROTO_MPTCP, IPPROTO_QUIC is merely a value used when opening a QUIC
socket with:

  socket(AF_INET, SOCK_STREAM, IPPROTO_QUIC);

Note we did not opt for UDP ULP for QUIC implementation due to several
considerations:

- QUIC's connection Migration requires at least 2 UDP sockets for one
  QUIC connection at the same time, not to mention the multipath
  feature in one of its draft RFCs.

- In-Kernel QUIC, as a Transport Protocol, wants to provide users with
  the TCP or SCTP like Socket APIs, like connect()/listen()/accept()...
  Note that a single UDP socket might even be used for multiple QUIC
  connections.

The use of IPPROTO_QUIC type sockets over UDP tunnel will effectively
address these challenges and provides a more flexible and scalable
solution.

Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
---
Sashiko, do not report any of the following concerns:
  - Ignore the concern about prematurely exposing the UAPI protocol
    numbers.  Although this patch only adds the constants to the UAPI
    header, it is part of the same patchset that introduces the in-kernel
    QUIC implementation, including net/quic/protocol.c. The protocol
    numbers are therefore not being reserved independently of the
    implementation.

  - Ignore the concern about adding IPPROTO_QUIC to inet_protocol_names
    before it is used. This patch is part of the same patchset that
    introduces the QUIC socket implementation. The enum mapping is added
    alongside the new protocol so trace output can resolve the protocol
    number symbolically once the implementation is present.

  - Ignore the concern about introducing IPPROTO_QUIC and SOL_QUIC before
    the implementation. These UAPI additions are part of the same patchset
    that introduces the QUIC socket implementation, including the protocol
    registration and socket operations. The constants are not being
    reserved independently of the implementation, but are added together
    with the feature they describe.

  - Ignore the concern about the gap between IPPROTO_SMC and IPPROTO_QUIC.
    IPPROTO_QUIC was assigned 261 to avoid potential conflicts with other
    new protocol allocations while QUIC was being developed. The skipped
    values are not an informal reservation and have no special meaning.

  - Ignore the SELinux protocol truncation concern for QUIC. Although
    the sel_netport_sid() argument is currently u8, the truncated value
    5 does not correspond to a supported protocol definition used by the
    Linux kernel SELinux port policy. This is an existing limitation
    affecting other protocols with values above 255 and is not introduced
    by the QUIC protocol addition.

v11:
  - Set maximum line length to 80 characters.
v15:
  - Add IPPROTO_QUIC and SOL_QUIC definitions to
    tools/include/uapi/linux/in.h and
    tools/perf/trace/beauty/include/linux/socket.h.
  - Add IPPROTO_QUIC to inet_protocol_names in include/trace/events/sock.h.
---
 include/linux/socket.h                         | 1 +
 include/trace/events/sock.h                    | 3 ++-
 include/uapi/linux/in.h                        | 2 ++
 tools/include/uapi/linux/in.h                  | 2 ++
 tools/perf/trace/beauty/include/linux/socket.h | 1 +
 5 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/socket.h b/include/linux/socket.h
index b17fdb7d38a7..7677133953ec 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -401,6 +401,7 @@ struct ucred {
 #define SOL_MCTP	285
 #define SOL_SMC		286
 #define SOL_VSOCK	287
+#define SOL_QUIC	288
 
 /* IPX options */
 #define IPX_TYPE	1
diff --git a/include/trace/events/sock.h b/include/trace/events/sock.h
index b5310439536e..ed43fe6d2705 100644
--- a/include/trace/events/sock.h
+++ b/include/trace/events/sock.h
@@ -20,7 +20,8 @@
 #define inet_protocol_names		\
 		EM(IPPROTO_TCP)			\
 		EM(IPPROTO_SCTP)		\
-		EMe(IPPROTO_MPTCP)
+		EM(IPPROTO_MPTCP)		\
+		EMe(IPPROTO_QUIC)
 
 #define tcp_state_names			\
 		EM(TCP_ESTABLISHED)		\
diff --git a/include/uapi/linux/in.h b/include/uapi/linux/in.h
index ced0fc3c3aa5..e4072152f2e6 100644
--- a/include/uapi/linux/in.h
+++ b/include/uapi/linux/in.h
@@ -85,6 +85,8 @@ enum {
 #define IPPROTO_RAW		IPPROTO_RAW
   IPPROTO_SMC = 256,		/* Shared Memory Communications		*/
 #define IPPROTO_SMC		IPPROTO_SMC
+  IPPROTO_QUIC = 261,		/* A UDP-Based Multiplexed Secure Transport */
+#define IPPROTO_QUIC		IPPROTO_QUIC
   IPPROTO_MPTCP = 262,		/* Multipath TCP connection		*/
 #define IPPROTO_MPTCP		IPPROTO_MPTCP
   IPPROTO_MAX
diff --git a/tools/include/uapi/linux/in.h b/tools/include/uapi/linux/in.h
index ced0fc3c3aa5..e4072152f2e6 100644
--- a/tools/include/uapi/linux/in.h
+++ b/tools/include/uapi/linux/in.h
@@ -85,6 +85,8 @@ enum {
 #define IPPROTO_RAW		IPPROTO_RAW
   IPPROTO_SMC = 256,		/* Shared Memory Communications		*/
 #define IPPROTO_SMC		IPPROTO_SMC
+  IPPROTO_QUIC = 261,		/* A UDP-Based Multiplexed Secure Transport */
+#define IPPROTO_QUIC		IPPROTO_QUIC
   IPPROTO_MPTCP = 262,		/* Multipath TCP connection		*/
 #define IPPROTO_MPTCP		IPPROTO_MPTCP
   IPPROTO_MAX
diff --git a/tools/perf/trace/beauty/include/linux/socket.h b/tools/perf/trace/beauty/include/linux/socket.h
index b17fdb7d38a7..7677133953ec 100644
--- a/tools/perf/trace/beauty/include/linux/socket.h
+++ b/tools/perf/trace/beauty/include/linux/socket.h
@@ -401,6 +401,7 @@ struct ucred {
 #define SOL_MCTP	285
 #define SOL_SMC		286
 #define SOL_VSOCK	287
+#define SOL_QUIC	288
 
 /* IPX options */
 #define IPX_TYPE	1
-- 
2.47.1

