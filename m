Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF5E3D7A0C
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 09:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784193150; cv=none; b=gJ5DPhusrdJXrL0fcyT1SXg7VcsnYI/SbfSggn4CCiizz5zMA9aVsEHkn0qpTVitVCEOjfkeWaVxNHaukQhbRP7B8EIWqDwV/PpoqdzD6GYEQixye7hwJDr3OIooP+hRYxnTmWoKb5VtVq4zd3ozO4o/LXhlPzYwlU4Ua75m+1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784193150; c=relaxed/simple;
	bh=h533/s68PkW/dTRQqtEhMLD26L4Imx1KV6XCi6Spb/M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AAT78+7ze6lVb9MGSeawXW1rtFbulB2bcb2pMwFQgSBmqN82iHuCaI6JMCePehHKN0FcdHBPshAf0bIGXkjcNowDJR9mqQyX+k7xpo6ncu1fKVdjJFa/pLiC7XMwrQcgoMXJg8N+tSW5yjPYKXxBMkdG35NGXX1YT1O3P8/4Zuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tencent.com; spf=pass smtp.mailfrom=tencent.com; dkim=pass (1024-bit key) header.d=tencent.com header.i=@tencent.com header.b=molEfoTU; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tencent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tencent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tencent.com header.i=@tencent.com header.b="molEfoTU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tencent.com;
	s=s201512; t=1784193139;
	bh=cZzj3HYQJKx8gtuyJN2jviMgDkTVbUaJ8m4ySFDZLE4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=molEfoTUPN52F5nAJZMy7Uwuvqk0sDXLqeNlDNjetRPCsPq3+2Nw6WZbIzdYk/HAU
	 Gz9N5nvVVcmf5JUiTS86b6DnF0pV5yUr4IyuK8+NzDvUP0bkiSG+7ClpVlmLwboYsK
	 tQuFM27PGToNT/urV2bPGXj84VI3NWcWaHR/GVTE=
X-QQ-mid: esmtpgz16t1784193135tc698a91c
X-QQ-Originating-IP: zyLiXb/SlMT+LvdM5maz7tsR5nsrvqeisB9yO7HQxFs=
Received: from JUNVYYANG-MC1.tencent.com ( [21.36.98.151])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 16 Jul 2026 17:12:14 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11565686538516819325
X-QQ-CSender: aigbot@tencent.com
Sender: aigbot@tencent.com
From: "=?gb18030?B?1uzIuMC2vvxBSUdCb3TTys/k?=" <aigbot@tencent.com>
To: netdev@vger.kernel.org
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-sctp@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jun Yang <junvyyang@tencent.com>,
	stable@kernel.org
Subject: [PATCH] sctp: don't free the ASCONF's own transport in DEL-IP processing
Date: Thu, 16 Jul 2026 17:12:12 +0800
Message-ID: <80818E6580896D22+20260716091212.43126-1-junvyyang@tencent.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:tencent.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: ONiEFPFYK9ddlihmWBp8NNNp7IlmNC6DTPRUQGR0yOLCAE9VJQapdvhH
	GiYKDruRe67/TKyr9rxu+vSAU/dI/Xj3VphWHEp/xbA95akJIFUUsOb5kVQiAowxxvLQZlt
	Hou3bdsb9AaCZa+36/9MsDlRKWqZFI4IPUGsmbFZv/tqBkGT4Gj/j4Q6AmOUN7bORpiRQij
	xKKRRLjef8Zg5vtaQknbdef82kAi7HZg4EYKjl6Djqo0rN0mY5oN1BjZJoMFz223iiIVG1a
	esmCjWpfw77zRI2i/qyMm4vU9c9honJM7xvSfdckxdSgs78wiicXcc3aQErhsUBeplbg1IJ
	Xf8RzF4iIRu7RaB8mXyrOste8EPxFVpNomecQZtUc9LHMJhuGOH0DFFr+0olYY0InUP1LoQ
	R9AsfXeMEiuZDoaDM1SYhgFTp+ggLiuYib5P6SHu5SKcG3lptihPDRcZSoOR9DrqivjpD94
	lHG3QxtgLgjLBZnIpUyQpbmT3lH3Y3GcxfvBGAqa5gYCrHjAP8JQBqmSrZ2nS4EuUWdpC8u
	8I/Sw4166Hai62AKrtpEzikLxzvypKfNbKMPZocpItb6Ds15uvnVmHpAlKMog85NcvHNsPT
	huZI1zDnXE5ev2u2bYbKR2vsgzb+BnXJ0eWNo93Gt06/MAt1s+aGQW+bWf/zDI0R1ZBJrK3
	aLBHwHGLFQ//Slg2n5iPWtYjY7jp0GVY2Uwge7epYu8aSlID1Ne1jgmhGQYaiosNXNbPvxZ
	MrYl/MhopBOW5h8XZSyDOv57MFki0a4EWE4yHm7Z9Y/AJs/37jOa5UGxNQSqI+ZrMgUtHwD
	+qKhAA1q2eSlHs7xt7gm3ZcLlNVIRqBM8grk0VX6LQChlI9Q+S5WVtBytRjPmY3JZHUN5c8
	zRcLvldsPmEUcEKV2wGiOGET9821I7vLK86nPrmc9zFer4vrjH73L06fMvt1gv5byD/W37i
	q+iO6+JgXIxt+pQ==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

sctp_process_asconf() caches the transport the ASCONF chunk is processed
against in asconf->transport (== chunk->transport, set once in sctp_rcv()).
For an ASCONF located through its Address Parameter by
__sctp_rcv_asconf_lookup(), that cached transport corresponds to the
Address Parameter, which need not be the packet's source address.

sctp_process_asconf_param() rejects a DEL-IP for the packet source address
(ADDIP D8, SCTP_ERROR_DEL_SRC_IP), but nothing protects asconf->transport.
A single ASCONF can therefore carry, in order:

    [Address Parameter L] [DEL-IP L] [DEL-IP 0.0.0.0]

where L differs from the source. The DEL-IP for L passes the D8 check and
calls sctp_assoc_rm_peer() on the transport that asconf->transport still
points at, freeing it (RCU-deferred). The following wildcard DEL-IP then
reuses the now-dangling asconf->transport in sctp_assoc_set_primary() and
sctp_assoc_del_nonprimary_peers(): set_primary() dereferences the freed
transport (->ipaddr, ->state) and plants the dangling pointer into
asoc->peer.primary_path / active_path, and del_nonprimary_peers(), keeping
only the pointer that is no longer on the list, removes every real
transport, leaving the association with a transport_count of 0 and
primary_path/active_path pointing at freed memory.

Reject a DEL-IP that targets the transport the ASCONF is being processed
against, mirroring the existing source-address guard, so the wildcard
branch can never reuse a freed transport.

Fixes: 42e30bf3463c ("[SCTP]: Handle the wildcard ADD-IP Address parameter")
Cc: stable@kernel.org
Signed-off-by: Jun Yang <junvyyang@tencent.com>
Acked-by: Xin Long <lucien.xin@gmail.com>
---
 net/sctp/sm_make_chunk.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
index 8adac9e0cd66..b14251214896 100644
--- a/net/sctp/sm_make_chunk.c
+++ b/net/sctp/sm_make_chunk.c
@@ -3153,6 +3153,12 @@ static __be16 sctp_process_asconf_param(struct sctp_association *asoc,
 		if (!peer)
 			return SCTP_ERROR_DNS_FAILED;

+		/* Don't free asconf->transport; a later wildcard DEL-IP
+		 * parameter reuses it.
+		 */
+		if (peer == asconf->transport)
+			return SCTP_ERROR_DEL_SRC_IP;
+
 		sctp_assoc_rm_peer(asoc, peer);
 		break;
 	case SCTP_PARAM_SET_PRIMARY:
--
2.55.0

