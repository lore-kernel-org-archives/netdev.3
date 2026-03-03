Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF21E4E3788
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 16:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772555035; cv=none; b=Di8l3MJbYLebWlbzHIrmkleXVpVOBm5aNqZuJ7ZqoUHerQG+QS/TKXtJ3GeXkSF8m4gn1dQSZI8jxpmIUUQlptLeERiJYayURKrwm85+0OAsI35c83lkJmLgblnjp68iPNAq2Rl8DUcX+0IiYmXjCLjb1AFrdcLcxjEKUn0DinU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772555035; c=relaxed/simple;
	bh=8G3v3PE8hzY4kHYbTMAlFZglWTeWb8+M9yyU291CPnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XBAOMFUWHWi8O0eQc8/kGiXur753W3AJepFvburKmVRR4PSaOBvz7QUOdU4atdPAt8b6ZOy+2166zZ8H6+hz3SfPQnfLxtQmAonpgFSpoQ/IQ1mVxGHQvHQn+eaq1Ecq5zVH6T/tOupKVaq82BXNSgBhKfz7DMrMYO86FN95KoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DAwg4Ryn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DAwg4Ryn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E1B4C19425;
	Tue,  3 Mar 2026 16:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772555035;
	bh=8G3v3PE8hzY4kHYbTMAlFZglWTeWb8+M9yyU291CPnw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DAwg4RynLKENND6EJLF76NrswdhGlmHVMrkqrHBH8n4JipvKqlZawZrIxpiPB14lz
	 e7uL/gJjdcFrIXomJ4qm/kLMaeuU454K7ryl9JQomVU8KvSNyY7ZfZhtcMPyIiBapg
	 jN6qvUWSvHCfhalDA6/zKc0fSXXq5cbWrRmM1V2D2XQbNPNV5v2Lyo4VtZTWLO4RDY
	 m9QGfHn2mJdMY0x5Yo17md+FpVAo2KlyfdNdWvmv5fmtzUt2VS3IT39DfpCAVfF28Z
	 wCGjPBPdGCTIKv3rqSWcZWJ1H0+Kzscj2529O5cYn4gNAJSSXZUGuBP1oYZUxwZJ9s
	 qhEZ5qI+TDvoQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 1/5] nfc: nci: free skb on nci_transceive early error paths
Date: Tue,  3 Mar 2026 08:23:41 -0800
Message-ID: <20260303162346.2071888-2-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303162346.2071888-1-kuba@kernel.org>
References: <20260303162346.2071888-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nci_transceive() takes ownership of the skb passed by the caller,
but the -EPROTO, -EINVAL, and -EBUSY error paths return without
freeing it.

Due to issues clearing NCI_DATA_EXCHANGE fixed by subsequent changes
the nci/nci_dev selftest hits the error path occasionally in NIPA,
and kmemleak detects leaks:

unreferenced object 0xff11000015ce6a40 (size 640):
  comm "nci_dev", pid 3954, jiffies 4295441246
  hex dump (first 32 bytes):
    6b 6b 6b 6b 00 a4 00 0c 02 e1 03 6b 6b 6b 6b 6b  kkkk.......kkkkk
    6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
  backtrace (crc 7c40cc2a):
    kmem_cache_alloc_node_noprof+0x492/0x630
    __alloc_skb+0x11e/0x5f0
    alloc_skb_with_frags+0xc6/0x8f0
    sock_alloc_send_pskb+0x326/0x3f0
    nfc_alloc_send_skb+0x94/0x1d0
    rawsock_sendmsg+0x162/0x4c0
    do_syscall_64+0x117/0xfc0

Fixes: 6a2968aaf50c ("NFC: basic NCI protocol implementation")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/nfc/nci/core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index 6e9b76e2cc56..40fc397858ce 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -1035,18 +1035,23 @@ static int nci_transceive(struct nfc_dev *nfc_dev, struct nfc_target *target,
 	struct nci_conn_info *conn_info;
 
 	conn_info = ndev->rf_conn_info;
-	if (!conn_info)
+	if (!conn_info) {
+		kfree_skb(skb);
 		return -EPROTO;
+	}
 
 	pr_debug("target_idx %d, len %d\n", target->idx, skb->len);
 
 	if (!ndev->target_active_prot) {
 		pr_err("unable to exchange data, no active target\n");
+		kfree_skb(skb);
 		return -EINVAL;
 	}
 
-	if (test_and_set_bit(NCI_DATA_EXCHANGE, &ndev->flags))
+	if (test_and_set_bit(NCI_DATA_EXCHANGE, &ndev->flags)) {
+		kfree_skb(skb);
 		return -EBUSY;
+	}
 
 	/* store cb and context to be used on receiving data */
 	conn_info->data_exchange_cb = cb;
-- 
2.53.0

