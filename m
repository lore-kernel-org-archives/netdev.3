Received: from outbound.ms.icloud.com (p-west3-cluster5-host9-snip4-1.eps.apple.com [57.103.72.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3224017D2
	for <netdev@vger.kernel.org>; Sun,  5 Apr 2026 16:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.72.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775407342; cv=none; b=raylt8voHQGxdy+1TDaO3SirXlQHSq3LQxF6Wu4nha7urkC0164ogm0nnn/OpfnLvGnRrHGHGyVNd6mOGCb8Guj48pj6oxCb7ibdcWkvA0QruFgcZ3YXHeygAqxVvVW/ABHCqlc4v6bKkmuLmei9HDcAh+JOTkjn7ibmnyN2soY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775407342; c=relaxed/simple;
	bh=Y0UQaiHmPnncAF/zZh73pPUIUWDh5M4/Wvgn6QhVFwg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FD+JiDl2snm2QPbB8/wK7k4VAZYw4qZz6pCaFY87TGiFH9ZNXKVUZadOjmFF6rLe/ZCq2BpiOtO6i/Hg8D7DNjsw3bFarjR9PRvqkwlGGoCbYjtIuJDumEn0lkyLjr/72H/BJi3rznBnzWcpt+uv5zANirF6BWxyYoLuCXQ7gCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=XrZMsvlF; arc=none smtp.client-ip=57.103.72.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="XrZMsvlF"
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-3a-10-percent-2 (Postfix) with ESMTPS id E77BF1800210;
	Sun, 05 Apr 2026 16:42:18 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1775407340; x=1777999340; bh=Zh9QbdXIogGNv1FXpgmqUGlv02EpGeQeAagJ0ahOZdc=; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=XrZMsvlFkCZgbouqeNcqOU0tYuzgiN1cK+EVuW80QihcHbWrMI6BYhqjN96G6kv1jxlV61ZOUXoxiq/60mep7ELeZLSRUT9GnaL1dkd0lxRvlOdRlV+t478BstGoui8JxDfEzLvwrveRHZTvRRVxHz2efoLyxWUrRP59QGvUS2kaDrvjwUdSh4qZ6+grKK4kOKkhD4UrEV/aOC308uTQyDl1IkmHIjK6XtqAF+juh7kRDTG1aLNMwuDqlqLlZ7hVWxekfEJ5MwlrNHeyOCQOs7Jx7HmfnhfFyL7CBhfOhOsiyAAHhZTs2qRGNALCFJScP6TBFApLlQWYvgxjq8p0HQ==
Received: from mainframe.tailfb0f7b.ts.net (unknown [17.57.154.37])
	by p00-icloudmta-asmtp-us-west-3a-10-percent-2 (Postfix) with ESMTPSA id 14C1618000B4;
	Sun, 05 Apr 2026 16:42:16 +0000 (UTC)
From: =?UTF-8?q?Lek=C3=AB=20Hap=C3=A7iu?= <snowwlake@icloud.com>
To: netdev@vger.kernel.org
Cc: linux-nfc@lists.01.org,
	davem@davemloft.net,
	kuba@kernel.org,
	krzysztof.kozlowski@linaro.org,
	stable@vger.kernel.org
Subject: [PATCH] nfc: llcp: fix missing return after LLCP_CLOSED check in recv_hdlc and recv_disc
Date: Sun,  5 Apr 2026 18:41:58 +0200
Message-ID: <20260405164158.1344049-1-snowwlake@icloud.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA1MDE3NCBTYWx0ZWRfXwaJMLvmjHcyM
 iteWLSB+zPYt1yn2ijBwWygUkQry8C4NmplEgDOVY/6FMSe98v8sslioWSv80zqZhUb54BejvOd
 3Vx4sniSAmJc8DOCetJCPBe3/tDxiLM4Xvw7i6sAlWjhHyxoxlFD4G9G9SXcYGTdy/pScRQNAfE
 SI32/Nj0dUyEBsicw+FuPcX4Ns8F3ySav5GMxtBdXLFsGu/m5NZxxeMn6FsVDEVdnzQsTyn9CuK
 U0zxTLDjqhbJX407w8a7n4u5l40dMTTghpEKGTOpx5tF41AbYVn+ZndWr7Zsavt46lTtf67d6GM
 RjHQBaM880CH5taldXh+SIi7A3mUJF4IT0wUsAJn2YlvPqRB6JrweyqkQ9l/Fs=
X-Proofpoint-ORIG-GUID: 5kUpoHUTrgNbkz3uJq1YuumaqrWNyYtO
X-Proofpoint-GUID: 5kUpoHUTrgNbkz3uJq1YuumaqrWNyYtO
X-Authority-Info-Out: v=2.4 cv=Z5nh3XRA c=1 sm=1 tr=0 ts=69d290eb
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=M51BFTxLslgA:10 a=x7bEGLp0ZPQA:10 a=LbuW6tbUWPcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=UqCG9HQmAAAA:8 a=aHyeSshMfSEOfJyjs9cA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-05_05,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1011 phishscore=0 mlxlogscore=999
 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0 mlxscore=0
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.22.0-2601150000 definitions=main-2604050174

From: Lekë Hapçiu <framemain@outlook.com>

nfc_llcp_recv_hdlc() and nfc_llcp_recv_disc() both call
nfc_llcp_sock_get() (which increments the socket reference count) and
lock_sock() before processing incoming PDUs.  When the socket is found
to be in state LLCP_CLOSED both functions correctly call release_sock()
and nfc_llcp_sock_put() to undo those operations, but are missing a
return statement:

    lock_sock(sk);
    if (sk->sk_state == LLCP_CLOSED) {
        release_sock(sk);
        nfc_llcp_sock_put(llcp_sock);
        /* ← return missing */
    }
    /* Falls through with lock released and reference dropped */
    ...
    release_sock(sk);            /* double unlock */
    nfc_llcp_sock_put(llcp_sock); /* double put → refcount underflow */

The fall-through causes three independent bugs:

  1. Use-after-free: all llcp_sock field accesses after the LLCP_CLOSED
     block occur with the socket lock released and the reference dropped;
     another CPU may free the socket concurrently.

  2. Double release_sock: sk_lock.owned is already 0 — LOCKDEP reports
     "WARNING: suspicious unlock balance detected".

  3. Double nfc_llcp_sock_put: the refcount is decremented a second time
     at the end of the function, potentially driving it below zero
     (refcount_t underflow), corrupting the SLUB freelist and causing a
     subsequent use-after-free or double-free.

Both functions are reachable from any NFC P2P peer within physical
proximity (~4 cm) without hostile NFCC firmware:
  - nfc_llcp_recv_hdlc: triggered by sending an LLCP I, RR, or RNR PDU
    to a SAP pair whose connection has been torn down.
  - nfc_llcp_recv_disc: triggered by sending an LLCP DISC PDU to a SAP
    pair that is already in LLCP_CLOSED state.

Fix: add the missing return statement in both functions so that the
LLCP_CLOSED branch exits after cleanup.

Fixes: Introduced with nfc_llcp_recv_hdlc / nfc_llcp_recv_disc
Signed-off-by: Lekë Hapçiu <framemain@outlook.com>
---
 net/nfc/llcp_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index 366d75663..db5bc6a87 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -1091,6 +1091,7 @@ static void nfc_llcp_recv_hdlc(struct nfc_llcp_local *local,
 	if (sk->sk_state == LLCP_CLOSED) {
 		release_sock(sk);
 		nfc_llcp_sock_put(llcp_sock);
+		return;
 	}
 
 	/* Pass the payload upstream */
@@ -1182,6 +1183,7 @@ static void nfc_llcp_recv_disc(struct nfc_llcp_local *local,
 	if (sk->sk_state == LLCP_CLOSED) {
 		release_sock(sk);
 		nfc_llcp_sock_put(llcp_sock);
+		return;
 	}
 
 	if (sk->sk_state == LLCP_CONNECTED) {
-- 
2.51.0

