Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4620C281503
	for <netdev@vger.kernel.org>; Sun,  7 Jun 2026 18:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780855427; cv=none; b=LPV3jE+f/strHVSl+Mcd+LdrIrc9JZwlO0118dLRDqTXf5ADe3KOcnePB72DWyxDHEC358F/XD79rcVEb56V6jCyBQJv9O31WaYg4wCy4e8H+KkN9hM07Dm21ExwRZkeagsJPkL4BskzmhqlARgVHcabbYpyPBImlTyUDBNz6Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780855427; c=relaxed/simple;
	bh=Oq9uMBA7F1231B6O729WkmXV78Ehl8cbE8bTwDhokAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d88qAVkPQHxxlRS3XcQfMCh/enYYQ09nWm4rnUE7Ik9hsc5thvDiyIFMm2XQ71tPAGlvSVv++RJ3OwEkKHgvkVQZfUbIZDH2ZupORTm2XVYc31/sCd0NR8JopMcDYfAxj6tKd4TTiVr+iJYdsQ4zlpMv2dZp8BfUH2vSYwkU5o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f3MEM2CG; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3MEM2CG"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-915767ea2d0so277338285a.1
        for <netdev@vger.kernel.org>; Sun, 07 Jun 2026 11:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780855425; x=1781460225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=36vd5FRxf1iF0JtG6WtjCmp2BwAM71UYEOie/h60d3k=;
        b=f3MEM2CGUp7ob3mOFbo4SLwHPUyRNi+cZ9PSqVtwmiMU6cP53MZ9QVAfnb4VE/OKUM
         mxMCxS0C91t6UG8j+ivrcU0QeaehJ1jMKTk+jS45Az0l8IHbe9h8WB7PGGmVLi4jCkqc
         4FpugGC94Ixi+Smb9dRoSG4J3o5Y7zC+LJf5wYVr3HMmfq12biVMX0wGPP6/qmbaQiXP
         vPYpjs3BciOg2CVsVL96CIhuKBwbYQQLwLRI/C0AJfwwr6LoZJHdDPFsA+i7uC/rZuWV
         /AlsA/DRSzUtNdiuDR69FazW9FASw+6QOD4s5N7iiujleLPc4+7uvsvEjQxr695+dHjy
         AjGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780855425; x=1781460225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=36vd5FRxf1iF0JtG6WtjCmp2BwAM71UYEOie/h60d3k=;
        b=hRtFjdgnONIWIGgn27TOZ+/2GXUj+JNQtCz9Xa2FJsnLDz1M8L7QKp8R6ouXNgD9UJ
         6cAWpKEVEmFwECklJyR2aZF0kLOhkv2uYeCAlZi3kw+OdmfV4YAWVfedxLF4zWeXX+Yz
         PcqYPlj1CHVQJRlMJEYBWU9R6njUty9dC/boRLbSyL0pF72RQh3RtPyYSL33uGvJn8oy
         sB3wjTyUijLURL6I2F1YnCRG0afU3tmJIf9C+5GJ5In2bvTFIT6XZptZzq+LpqVcA9JI
         w+BkXHkzx9RXN47339QRQfaHfdjeoakihzdAxlNxxfjiUSfruJ9Na3+8JUtrfBGG0fXs
         SAtg==
X-Gm-Message-State: AOJu0YyDEbfVyiXwKneLrzdDH/9WIY6UhliFOqo1bh+3dnATNdTTK0v1
	V0hZ/cmW3RXHZ6P4L/Evv5fPTKb13OoFzjWKUwf+JxclZCFJKdKMPv1Vf7vul4g+
X-Gm-Gg: Acq92OF6r5fmwjrdd9+NW2uLsDEwX7s6KOUEIpb6mXFw36ljF501dV6Juan1LMG9wi9
	Y5iDbemvReXvxGqS9+/wZxdITHiotOs0LNX8J4aNWQ9uFVl/O61t9qxQ4gv75GzITpM2IMhSurT
	BoN1/9/ZTF3TFlvTV8vxrnITthVuAmF1pEL6RwibK5alVniJ8mO7Eo0CXbLExgEcvQ09u+O363X
	bI1YTzq+bCBV7E3SVu6VGa1Tztnfa+kat/Yxd88r4CSUtZAZ44wZw67KSqBAtrp+OEVExBapKaU
	6PUgtRJrOMC1iKzJq7ClhHP5Yd0YxAK1an6TIHZe9obMIquM+8++9D2buUHcwj7WrljCyCpvwpI
	IjpShjYTQ5W0UZnDSTqgsWSnxjQQXyQKKfQqX5Yq+JVTqsfp/XImfcjORcxcwkxHl9cgI2GGDmZ
	RErXNVe3+dmrnTkhFugmxFkH9DySWMO58d5sU5CkMrm7k+MNPihwGhqhkNVbedgrpQ6Vc0XSzQs
	8IcfLbnvkmWhZL5PeVvYVO1TUT1q24drOO6EHgeonctzWpJuVZiakOR2aPJV2Tdna0slME0cc5d
X-Received: by 2002:a05:620a:2910:b0:915:8594:68dc with SMTP id af79cd13be357-915a9e05dbbmr1997918785a.55.1780855425365;
        Sun, 07 Jun 2026 11:03:45 -0700 (PDT)
Received: from wsfd-netdev58.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a2359ecsm1489771785a.14.2026.06.07.11.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 11:03:44 -0700 (PDT)
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
	Steve French <smfrench@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Tom Talpey <tom@talpey.com>,
	kernel-tls-handshake@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
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
	paul@jakma.org
Subject: [PATCH net-next v13 01/15] net: define IPPROTO_QUIC and SOL_QUIC constants
Date: Sun,  7 Jun 2026 14:01:23 -0400
Message-ID: <686819eebb82be0eed7beea4f468284288c37536.1780855296.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1780855296.git.lucien.xin@gmail.com>
References: <cover.1780855296.git.lucien.xin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
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
v11:
  - Set maximum line length to 80 characters.
---
 include/linux/socket.h  | 1 +
 include/uapi/linux/in.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/include/linux/socket.h b/include/linux/socket.h
index 1a4d0d128a13..77bcab269b3c 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -401,6 +401,7 @@ struct ucred {
 #define SOL_MCTP	285
 #define SOL_SMC		286
 #define SOL_VSOCK	287
+#define SOL_QUIC	288
 
 /* IPX options */
 #define IPX_TYPE	1
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
-- 
2.47.1

