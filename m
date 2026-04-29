Received: from out-ip0051.fra.mailhop.org (out-ip0051.fra.mailhop.org [18.193.30.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950163F167C
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 11:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.193.30.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777463016; cv=none; b=N5j4wECOXxzEgUs7wSecYSYhE9l2iJtdl5sONGJBgMU0b9EY5C5CAaj87dySoRZHHbqBlmqamgw//RJ17Nc4PeZ7VCAKZRZFh5Ut2eJHjBZ5YNlS6OdP9/Mr2z2OwPwHNwuhULZO/YjV9MgIA0ZT4f2rqpC75ZmXYPgDZodMwHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777463016; c=relaxed/simple;
	bh=W7k6MOnzF2VkPeJqh6DYOFZ51EeiqvwO8qLmU0xZ36g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o6osbjn+yDZ55jk/LT21jfMl8OPAShIjvx+2NtPAn82UAgPkdtB1vGOPTacB37SwizFR5lI39axS6aYpjBmSCyHlb4oJ6nJNM5dGnVgsFFG8WQMRv2HlszTzWHHXcJw84C/ZhJhQE2bPz/YtmWJFyW8eIkUSM4zT1i3MOCPMI0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com; spf=pass smtp.mailfrom=hitachienergy.com; dkim=pass (1024-bit key) header.d=hitachienergy.com header.i=@hitachienergy.com header.b=H926n2b9; dkim=pass (2048-bit key) header.d=outbound.mailhop.org header.i=@outbound.mailhop.org header.b=Vx8BPvPz; arc=none smtp.client-ip=18.193.30.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hitachienergy.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hitachienergy.com header.i=@hitachienergy.com header.b="H926n2b9";
	dkim=pass (2048-bit key) header.d=outbound.mailhop.org header.i=@outbound.mailhop.org header.b="Vx8BPvPz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=hitachienergy.com; s=duo-1630306886989-947ac67a;
	h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
	 subject:cc:to:from:cfbl-address:cfbl-feedback-id:from;
	bh=L8KWtdPE2JalTOCUmy3pa9Xkw2o8VCxZ9+OBKyymtC8=;
	b=H926n2b9084WhnKU73lnQXCUjVF6sG0DxcBH6lxl1HZhfY1U6pmXpQYXcQkmEsWSApd6JYFahb4+e
	 FweGDJoGSvAhLMNDYZiDlmquhdxTZzH/aQELS1wSqr3NdxdvYiuwx583NwcY8Vkkyms7efeKr/xDUJ
	 SdHKOQKcKaSmZizY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=outbound.mailhop.org; s=dkim-high;
	h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
	 subject:cc:to:from:cfbl-address:cfbl-feedback-id:from;
	bh=L8KWtdPE2JalTOCUmy3pa9Xkw2o8VCxZ9+OBKyymtC8=;
	b=Vx8BPvPzgz4zCdYNhQrPybF7CqI7xpCkYHHwcLe74OUrGXSdINl+BzTU1NeN0pOgZKXQQeVVz8oCA
	 B/KkaXbk1dkQ4KPBysJAwNAvlMX3Xw9uKjxcBJ8J9vMghb2ymnBP2PkcA3XuWDTszTpsslSBxlrbfj
	 RpsxY9HkkreCTDXxuPNQzcov+OlPr3vg3u/Rqe9DgeAMNYAES/vKKlgpcbVfG4fkNkTV41dCzsOPDM
	 RhWkH2715bw9bnIyyFdCeJr5Cc3rIT15rvNo+mdzp1eIwYSBf6lDAsZwQDmW/lAFBzViVYbi041pGy
	 54bGl+APHR1AxGzSiVObzq3p7HonR/w==
X-MHO-RoutePath: aGVkY3NtdHA=
X-MHO-User: 775d39e3-43c0-11f1-8259-bda8640e0fbb
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
CFBL-Feedback-ID: 775d39e3-43c0-11f1-8259-bda8640e0fbb:11
CFBL-Address: prvs=057955d709=abuse@outbound.mailhop.org; report=arf
Received: from HPG0000000548.corp.hitachi-powergrids.com (unknown [20.62.140.138])
	by outbound2.eu.mailhop.org (Halon) with ESMTPSA
	id 775d39e3-43c0-11f1-8259-bda8640e0fbb;
	Wed, 29 Apr 2026 11:42:18 +0000 (UTC)
Received: from gitsiv.hitachienergy.com (unknown [10.54.139.14])
	by HPG0000000548.corp.hitachi-powergrids.com (Postfix) with ESMTP id B5BD5158F;
	Wed, 29 Apr 2026 11:42:13 +0000 (UTC)
Received: from chbrn3-p-dev015.keymile.net (chbrn3-p-dev015.keymile.net [172.31.41.201])
	by gitsiv.hitachienergy.com (Postfix) with ESMTP id 412B6637F985;
	Wed, 29 Apr 2026 13:42:13 +0200 (CEST)
From: Holger Brunck <holger.brunck@hitachienergy.com>
To: netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Cc: andrew+netdev@lunn.ch,
	chleroy@kernel.org,
	qiang.zhao@nxp.com,
	Holger Brunck <holger.brunck@hitachienergy.com>
Subject: [PATCH 2/2] net: wan: fsl_ucc_hdlc: fix ucc_hdlc_remove
Date: Wed, 29 Apr 2026 13:42:08 +0200
Message-ID: <20260429114208.941011-2-holger.brunck@hitachienergy.com>
X-Mailer: git-send-email 2.52.0.120.gb31ab939fe
In-Reply-To: <20260429114208.941011-1-holger.brunck@hitachienergy.com>
References: <20260429114208.941011-1-holger.brunck@hitachienergy.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the driver is used in a non tdm mode priv->utdm is a NULL pointer.
Therefore we need to check this pointer first before checking si_regs.

Signed-off-by: Holger Brunck <holger.brunck@hitachienergy.com>
---
 drivers/net/wan/fsl_ucc_hdlc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index 8155e92af14e..15bfb78381d4 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -1250,12 +1250,12 @@ static void ucc_hdlc_remove(struct platform_device *pdev)
 
 	uhdlc_memclean(priv);
 
-	if (priv->utdm->si_regs) {
+	if (priv->utdm && priv->utdm->si_regs) {
 		iounmap(priv->utdm->si_regs);
 		priv->utdm->si_regs = NULL;
 	}
 
-	if (priv->utdm->siram) {
+	if (priv->utdm && priv->utdm->siram) {
 		iounmap(priv->utdm->siram);
 		priv->utdm->siram = NULL;
 	}
-- 
2.52.0.120.gb31ab939fe

