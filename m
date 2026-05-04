Received: from out-ip0051.fra.mailhop.org (out-ip0051.fra.mailhop.org [18.193.30.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463653E0222
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 16:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.193.30.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777911126; cv=none; b=fd8HeUrWHfAD4/QZOctvuBoxRqe7j34WrTF6kiOcWn/+LwFsTz+NUkCZwDUwE67KGC1e6lCNMpuKcoit645dC1zAPgITDXhP4s3H1aRXBO0Wgw+1e7zvglD+jntHdSDPtfydP/lRoJazM/Ol4Qsb+G9yx0n/A8oyegRgyjTyvqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777911126; c=relaxed/simple;
	bh=rwk1CtZyfPQmBQcVXdnCStRvL1IlJ3RuQWcqgsjMqPU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DDjzOaKcQT09NjrbcBFC7anw2AL99d9XriF9Brb3BRNGjXvBQMDAwHa8dztn7HIOpPbSLweji58OqkR70gkuoIMaMDtWiJ+F2j8otNfVNN1IWIlJuXOvu07RKAQmmCM07aAEhFHJ7NqVIL9Hla8Eh7zGP7FcSLMHRsVpMA9dTbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com; spf=pass smtp.mailfrom=hitachienergy.com; dkim=pass (1024-bit key) header.d=hitachienergy.com header.i=@hitachienergy.com header.b=LnBYXcR/; dkim=pass (2048-bit key) header.d=outbound.mailhop.org header.i=@outbound.mailhop.org header.b=DmurwB5s; arc=none smtp.client-ip=18.193.30.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hitachienergy.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hitachienergy.com header.i=@hitachienergy.com header.b="LnBYXcR/";
	dkim=pass (2048-bit key) header.d=outbound.mailhop.org header.i=@outbound.mailhop.org header.b="DmurwB5s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=hitachienergy.com; s=duo-1630306886989-947ac67a;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 cfbl-address:cfbl-feedback-id:from;
	bh=9orVYHdnXQuOz2avZekPiqkyjnG9PMJehPUQET09zII=;
	b=LnBYXcR/Ehc4LUKiXAjRB3jT1QpONMgSPheCtXgDMPDlS31ON2OibEPGOZQZvjl+BwrxQvPrdzxN4
	 Bmy+yw7alA1abOT2KkjkjCPGw4YTmIj6MAoaghZ+j2AOkt67Wig/od/qjedNjShRhVX6cqKTKtehko
	 DawNin1x3ON2gHsk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=outbound.mailhop.org; s=dkim-high;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 cfbl-address:cfbl-feedback-id:from;
	bh=9orVYHdnXQuOz2avZekPiqkyjnG9PMJehPUQET09zII=;
	b=DmurwB5sSqsye9aS8bU05hLiMFRnvilm0fgq23k8uF9Mpe1Bfbq8qLlZ/ESDNlXB7F+ELRjC968OR
	 X8l9aIIHxGyh8Ha7lSrRgtrT2uarSNkE0FawjvFuF8qkCVWKuasjZzTisMFHi+xJTjlqDvoDtZhjxC
	 NSpLRqq9MK8yYIcCff0GGvkHGPaKWRAvGPkhXzuCFlkHRJcSr2lmyfQaHMW6Gg6iW3XqwQWr7zrmxo
	 hlu4IJDv7YDzsgXl+kGIAKA1H+Y+0y0NM7XAUJMeDGYRtQGUstFG7lNrFfx78W48vX34R7G0uxPFMA
	 WyqJMabGBlq9GxJQSv8ljPydEGDuBsw==
X-MHO-RoutePath: aGVkY3NtdHA=
X-MHO-User: f42d5b33-47d3-11f1-8ef4-f54febe22707
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
CFBL-Feedback-ID: f42d5b33-47d3-11f1-8ef4-f54febe22707:13
CFBL-Address: prvs=058485b737=abuse@outbound.mailhop.org; report=arf
Received: from HPG0000000548.corp.hitachi-powergrids.com (unknown [20.62.140.138])
	by outbound3.eu.mailhop.org (Halon) with ESMTPSA
	id f42d5b33-47d3-11f1-8ef4-f54febe22707;
	Mon, 04 May 2026 16:11:49 +0000 (UTC)
Received: from gitsiv.hitachienergy.com (unknown [10.54.139.14])
	by HPG0000000548.corp.hitachi-powergrids.com (Postfix) with ESMTP id 22E611359;
	Mon,  4 May 2026 16:11:48 +0000 (UTC)
Received: from chbrn3-p-dev015.keymile.net (chbrn3-p-dev015.keymile.net [172.31.41.201])
	by gitsiv.hitachienergy.com (Postfix) with ESMTP id 9A24960B7D47;
	Mon,  4 May 2026 18:11:47 +0200 (CEST)
From: Holger Brunck <holger.brunck@hitachienergy.com>
To: netdev@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	andrew+netdev@lunn.ch,
	chleroy@kernel.org,
	qiang.zhao@nxp.com,
	horms@kernel.org,
	Holger Brunck <holger.brunck@hitachienergy.com>
Subject: [PATCH net] net: wan: fsl_ucc_hdlc: free tx_skbuff in uhdlc_memclean
Date: Mon,  4 May 2026 18:11:45 +0200
Message-ID: <20260504161145.2217950-1-holger.brunck@hitachienergy.com>
X-Mailer: git-send-email 2.52.0.120.gb31ab939fe
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When cleaning up the resources we need to iterate over the
tx_skbuf array to free pending TX messages.

Fixes: c19b6d246a35 ("drivers/net: support hdlc function for QE-UCC")
Signed-off-by: Holger Brunck <holger.brunck@hitachienergy.com>
---
 drivers/net/wan/fsl_ucc_hdlc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index adf3863463f5..68f78aeabdc3 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -739,6 +739,8 @@ static int uhdlc_open(struct net_device *dev)
 
 static void uhdlc_memclean(struct ucc_hdlc_private *priv)
 {
+	int i;
+
 	qe_muram_free(ioread16be(&priv->ucc_pram->riptr));
 	qe_muram_free(ioread16be(&priv->ucc_pram->tiptr));
 
@@ -769,6 +771,11 @@ static void uhdlc_memclean(struct ucc_hdlc_private *priv)
 	kfree(priv->rx_skbuff);
 	priv->rx_skbuff = NULL;
 
+	for (i = 0; i < TX_BD_RING_LEN) {
+		kfree(priv->tx_skbuff[i]);
+		priv->tx_skbuff[i] = NULL;
+	}
+
 	kfree(priv->tx_skbuff);
 	priv->tx_skbuff = NULL;
 
-- 
2.47.3

