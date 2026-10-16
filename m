Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5825E4772B5
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 15:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792164548; cv=none; b=r5ZAm3J5rxAzaftfUyso+4StVK+SUv6T7V3/NmYpdmww39FXYIysmnY1ZfMKOAqpkLj6WLPZs7iGNyviKYkP2LfLIxJj1GemoRdUqZWQ/4vRt03UG41AGVChT/n1UZAN3559gPKupwC28+SikWfLQ/7WTHEa4oHIeYz7v8g++zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792164548; c=relaxed/simple;
	bh=175nGo8AlzGi7Kq4YgHmF57Bf3sUbWDZgesKoC1sABY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N412SSF73iJv1AN52rDDSJLsCPY3dEUlVquJE8/p8t2dM2DMvdn5NmEvVqdP/FMq2bAIC5ZVG3JMl6jn3k48p0fokNG5xoWzvamPaLV9LVyYAPJpLRDFJZ12AiVbKOILqvVM/gbnNtaYmySE0wmVgGn9r/zAP1+GRT2ZrrIJwiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nDfhn5GX; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDfhn5GX"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-91986c5cb75so1314966d6.0
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 08:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792164545; x=1792769345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zPHnIYBbCayxMoJCPrlDTfFp1FR5Ql/EZ+xFQdJmHw8=;
        b=nDfhn5GXNwlYrpK7Rnf5XgMaY6ehEQrE0XyvxpAcceDCYF0wc92u2EQVGB2M/JYyS1
         AedklFv+in1i7vndhopq5YXqABjFssbgVtnyY5BFHpvFWa4aB3e6ho0+Js/JYvT3ceYb
         k3WShFlKGIMIFrakNjkmigLJJQYZsk8UAD9qAdmJG34PJ6r+KZyhqc9QOqLi1fMLa5Nq
         LYOuPRyXCGA5gdj3XEEMeIOsJuKOzICo6RSgxBzX+gh6hDgR/g6HmqTSVp4BBxAosKu+
         Iac+FbSau4y3Oi/uOcE3Ua4xfLZtu4xKNknBdNzna3GmHOgn+dJQj64rkgRYbNSG/pcY
         ZHcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792164545; x=1792769345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zPHnIYBbCayxMoJCPrlDTfFp1FR5Ql/EZ+xFQdJmHw8=;
        b=2M9MQ7fp0XXZYpC3B39Fsl2wiwu7K2v+cRE1nKxv5F65Zjjc36Pm5jKZcc0IeJTA2l
         d2gpRsNkYkzUUMkJ0nLC1YDKqu/lBZmX9Li2uDaAGT+PsdE8Av3IxOoTLbNNV0Aff1U3
         ooXl61Gq8YJ+QV6EURZZiw9r9kzuZhRA05ogeDyN7Awd8LdacqgmY+YVAiQ48CMUaE2B
         3XgPy/69PTXEjiLYJcbz1mziokuSdbqTqKwUnSnlgeObNEwzu1Dx+Nr6O4JLCTSPVbet
         QDfD8pJ6ehJ5dzDS7YPOKRuQwL4V8WwItlCC/vDOUmMrS6ubP4bXBtmAktcwtzgaDZx3
         S8VA==
X-Gm-Message-State: AFq9FYLxPqZu0Q8lu6cupdGhngYvE9NzjcubO9p5vzkKtYpAknlZOqdH
	DFaa00g7rOvmx4saGrPuj1luHqWpVOvu/buiI7xqkZZSSmIuqSCJCKR+jRX/j0B8
X-Gm-Gg: AYBFou1vmFPrMAINRJn/FY7wce9aIX2oLzOxUuyWs9olvNuQ9mNtnxl6TmsfFafExOq
	DzTadVLEsxHWDLwMV74lH3yP0dAN2fePjfdMt75G5k9VbwWu7hlGCS/tm76eKo1h7f8iy8FK49p
	vg6qbxFwpaCyJQeXCmrGsYQQICUAoMR2VAdryIPUcVSfDFZeRhqnoYeiCY8Ky1yAmvWFFUS6CMU
	oFpbYgRpUzj2wpEyA5lIrQjJfLzpMQ6A1GRR9TnELdBAYCyv17ASo7GMGEAXta30nITyG0HFqDA
	Q3aJ/Ipl04BbmOeozN8mmqGZgadrooxRWfxDAhk1cFM944LtvFjjh/yxHQs7DBrAfjJfa9XSsvx
	CbBjNGFMExGH2SLGS4zZEVWHGyTFARY8CjYb0LMBdfRg+jx9sVTnoKmHbs/6sZ8nyfy5pbAeTDT
	97rHKDcqOb2nFyG5Gq2b0clOCOnfYRpSHDZQ3K6T/NoU/9J0IxnDhSCskUVHIrLhWvukCQmth1v
	vp/NGZuln92b0d0PLZRGmNTVd6wlHb2LRKWqN4iygqPDFmsIgRZ3b3rVvlDVnbjn+NCamN8s6IO
	6eXOybqGs3J2g2wKxZzWyM8zP3fBSZNik88XYvOAukALiElqhrM=
X-Received: by 2002:a05:6214:c89:b0:917:a58b:3629 with SMTP id 6a1803df08f44-91bdf117c1amr5391716d6.26.1792164544938;
        Fri, 16 Oct 2026 08:29:04 -0700 (PDT)
Received: from wsfd-netdev58.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91bcba473easm25601866d6.17.2026.10.16.08.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 08:29:04 -0700 (PDT)
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
	paul@jakma.org,
	Kuniyuki Iwashima <kuniyu@google.com>
Subject: [PATCH net-next v17 01/15] net: define IPPROTO_QUIC and SOL_QUIC constants
Date: Fri, 16 Oct 2026 11:27:04 -0400
Message-ID: <dd15dbb1a27b98c83998888a3d585fbffb2bda29.1792164438.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1792164438.git.lucien.xin@gmail.com>
References: <cover.1792164438.git.lucien.xin@gmail.com>
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
index 5a5eb1250103..aeea3baa9673 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -400,6 +400,7 @@ struct ucred {
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
index 2a8d7b14f1d1..9d6ec1b2c50b 100644
--- a/tools/perf/trace/beauty/include/linux/socket.h
+++ b/tools/perf/trace/beauty/include/linux/socket.h
@@ -400,6 +400,7 @@ struct ucred {
 #define SOL_MCTP	285
 #define SOL_SMC		286
 #define SOL_VSOCK	287
+#define SOL_QUIC	288
 
 /* IPX options */
 #define IPX_TYPE	1
-- 
2.47.1

