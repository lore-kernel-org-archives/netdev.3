Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885BB480DD2
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 19:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791227127; cv=none; b=EVnCbjGrDTYm4z1yq3uhNCM59Rz0YRLy84CTrOaBlN5jwBxP2Skyg9oHIgWlMOvo5W02ztrY4jggzi69G7RbMYvJ2t2Y0LwE62iSLrL6m6wbqBXyumkUOmD/wvIK5IsCBbBcAFHQGsONDysL/zUiQuYAQtE0kBmNcP1Sh/dngsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791227127; c=relaxed/simple;
	bh=175nGo8AlzGi7Kq4YgHmF57Bf3sUbWDZgesKoC1sABY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=quf4YTOIPw4MR4cqPQFsbQK1t1s8ah9TvXSxIh35RD5dFRb+b1+PP6p+HkmNyBzgUgTDRzaeRw3v+LxBOkCYKSiv374ci+wqtwBDujDKdmG9elpZknqU40eo4KBsCN06BPjNmx6fb1hR5sNnTsKxX2WuuEUGzw0lEKwmeYgFSAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fbuFtdKA; arc=none smtp.client-ip=74.125.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fbuFtdKA"
Received: by mail-qk2-f43.google.com with SMTP id af79cd13be357-93ca50c8ba6so252823385a.2
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 12:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791227124; x=1791831924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zPHnIYBbCayxMoJCPrlDTfFp1FR5Ql/EZ+xFQdJmHw8=;
        b=fbuFtdKAeqNY0h575UzhsupNCB4BrqvgHAEyXKGdGOpYEUhweC+RWF2w4S5vEIcoKh
         PEA+RgtH/o/+3YDOTcB6AV/+NR+QU3DOqnRbWYFXnTgXo69/KJOjsy8weuv84S1uoc9s
         zvr3CPsW6bpPml7PzEip7sl/JBuEbZF6gGGUB4nkUVFOcV5gs1PNPr1k7++ZndZBqUwH
         EfRpdkgE0bw5RslXxcsgavA9PhHQdHAxGBU3LvFMHIjsXd62cvSNsrTpsmjdgrOMXP+z
         rxRIA5KfIfXzLPoc0yxY74hDJAAZHnarf56KXgvpg1I/BeUZWmnOMpxphFdv4IVN0jJE
         4swQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791227124; x=1791831924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zPHnIYBbCayxMoJCPrlDTfFp1FR5Ql/EZ+xFQdJmHw8=;
        b=hI75bK/5nP8MRv1+0dlXHbVS0t+CBE4O9lFhSALXku1Y1eedj+QLnSViywgrpdPiaY
         Sv4FarQroy55WXZcBSb9vumP+8AjsePwRxIBDvGbPfwB5ydne5IsFYrPiuFEtLmNSNbb
         9BThtE46bvly3tSuV4dqv1wA39uq7nfU4dxWeWrM83N5Xzqdid/nQL5Tbg8DRbHfrhuP
         gbhK1Grl1RPuAgPsAkP1Y/33m+ne0Q+mqfllVFcIzNM5oNG8AIRDipkdSIEgbQZhJjZ2
         kswTrmkpPWsvvGgvqoFEQTA9HbcMh0eSZyGeQVWPLP3FiPyDsOldhJwRblzJWlJzd6Zu
         al3A==
X-Gm-Message-State: AFuF++nYwWill5g+a6KpO28G9OogWitPpfVEvOic1YIvftRzaygSwdLT
	F63AvrtPV0OhDK6nwGWKW+NO9+L/LG/HqtqCIfTJjLoPMZrCywN17dqCmsBNEeePd1g=
X-Gm-Gg: AYBFou2lApTqEVqDa7CbDriatxAMrciHR+W1GAJjpt6tpdjz2Id609cCse0vSWh8Wv1
	hu8uxWB/M2xyRV3FHJOK+dUp+2Z4/EorWHZbM3XIbyvSOrx0sPpAb4GBuSwjyR/7mvI45HUdFsF
	El5gc4vX0sVjlD5C/3Ji2jEy31suJZG5Jio4DinqBPIHZhdit42YdYNQ0he2ue1G8HbEWuUZNNg
	GTsoH3LDT1gG+5BwfdDo38aWwfa5RrvvOFii/ExGSs4bI9JhQeZGN+VDRgQUrlF85r7L4b+DBTv
	EbCsCg4JjGyXUHn7FPMop2L2EPeAb8e48ybQ5XIM4FGRGEEVf/iRhPJeCMSNWr22vzajkGaJd2E
	V1XfZxKSftwFvP44UmxwAVQDCn+P7XL6d0xhuRRfJ2kQeHQ773CZluVhqU10xOtDGeYIuY9kwa9
	7+BVZzXQXXC0FA2Ln1pK4mC4ocdokcNVhTkPMPJQEV7qtiUUC0l1roGw3GXbtJLLqMxDiuF8qf9
	etWYqE46guIYUP8Cppq36Jv3zrxYn8yBFF6XYVKjrkMgkkbUX/p1oZtTyzx4eflLsJyxbzYZJKA
	lATvOg7Gw1PB73T1PGRgSX7OamAEPdPCqag6XvbbbyonA9/T
X-Received: by 2002:a05:620a:7087:b0:93a:2e8:5af5 with SMTP id af79cd13be357-93ce7a80f36mr2181764485a.6.1791227124283;
        Mon, 05 Oct 2026 12:05:24 -0700 (PDT)
Received: from wsfd-netdev58.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93cca263708sm927117785a.31.2026.10.05.12.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 12:05:23 -0700 (PDT)
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
Subject: [PATCH net-next v16 01/15] net: define IPPROTO_QUIC and SOL_QUIC constants
Date: Mon,  5 Oct 2026 15:03:56 -0400
Message-ID: <dc4b829cd94b7f6a0834ea43e35141884f9e409c.1791227050.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1791227050.git.lucien.xin@gmail.com>
References: <cover.1791227050.git.lucien.xin@gmail.com>
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

