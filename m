Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91853254A8;
	Sat, 22 Aug 2026 15:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787412789; cv=none; b=kAxAxSXSYlAcPLIz5MTCJBmbPB930rAg51Z0fC8aSGd9wLSN3w0qWOqKX+mvZp/qZyqaP5BQKrtXoWalaw9LUAb/Qk9RkOhQp7E4X0ARWvT7op4PFXkJVveURuUTtduIBgbBN+9k35n98gMs0vtGibX9a4qoXEpzhnmcBr1DCdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787412789; c=relaxed/simple;
	bh=q4OrMVf+sYXd8BnR8QnAhy3qsAG2MLWLhaLPbPW/P1A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W0nLH8PcKEszmw+SJxcAQKT29on5dDtJWvcx0vCYZSJ911bkBTaP8QjUcfQxgrOgUb4+8esFWYxYweAfXYJb4iz/SH4HKHO3Xm6r043j3vimjhbIjz0PUT37yDf399PXIONu1YoGwxiPQSzoSjygHWP7qeXDuSVVvvblNv+BCAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TAIkjK0J; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TAIkjK0J"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 0CF424E41342;
	Sat, 22 Aug 2026 15:32:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C3397604C4;
	Sat, 22 Aug 2026 15:32:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6B82211C77AD9;
	Sat, 22 Aug 2026 17:32:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787412772; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=5v3cIjOCiE/XMNl5DoFmxJvCALd+lwRUASJR0O4POfM=;
	b=TAIkjK0J+tkwnhHpkKE4jytUtCstKMwZQIDq2DhElD8iSGunRYnYxxkUIU2y6xew3jkux5
	HJmM59lAcBDIb04YvxuPtvE3DwqXOms9T7sStYEeUvnuUx9xld6Ep1iygx+lqw4E4Wpstg
	t/0Qu4cd9t6WlLqTmaRsfMYsIxONF0im/m8mDo/t53L2tE3SUEQtiEyT4y6epU/XqTv8Z5
	O/OWVtmx/x5ssIL8Vtig7XwqVIeoEx69jl4kfVibDIQFVKb9FAK2etDu7teKLTLbky+1SM
	m9MdtJl+xGfOE2zDSlUr6qWGaitxXNTAbMgZMSO0weWHBphTx6T+FTRw2wNfiw==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
Subject: [PATCH net] net: stmmac: selftests: Pass the IP proto mask in the TC selftest
Date: Sat, 22 Aug 2026 17:32:43 +0200
Message-ID: <20260822153245.423259-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The stmmac TC filtering rules have recently gained sanity checks to make
sure the passed keys and their respective masks are aligned with the HW
filtering abilities.

The stmmac selftests failed to pass the mask in the match data for L4
filtering tests, and are now failing consistently with -EINVAL :

$ ethtool -t eth1
[...]
23. L4 DA TCP Filtering          -22
24. L4 SA TCP Filtering          -22
25. L4 DA UDP Filtering          -22
26. L4 SA UDP Filtering          -22

Let's pass the ip_proto mask in the l4 filtering tests match data. Found
on imx8mp, which now have passing L4 tests :

$ ethtool -t eth1
[...]
23. L4 DA TCP Filtering          0
24. L4 SA TCP Filtering          0
25. L4 DA UDP Filtering          0
26. L4 SA UDP Filtering          0

Fixes: 5536d7c84363 ("net: stmmac: fix l3l4 filter rejecting unsupported offload requests")
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
index 1df26c217f9a..e9be4d7cbb82 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
@@ -1489,6 +1489,8 @@ static int __stmmac_test_l4filt(struct stmmac_priv *priv, u32 dst, u32 src,
 	keys.bkey.ip_proto = udp ? IPPROTO_UDP : IPPROTO_TCP;
 	keys.key.src = htons(src);
 	keys.key.dst = htons(dst);
+	/* Match the full IP proto field */
+	masks.bmask.ip_proto = 0xff;
 	masks.mask.src = src_mask;
 	masks.mask.dst = dst_mask;
 
-- 
2.55.0

