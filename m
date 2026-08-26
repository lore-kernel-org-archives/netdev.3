Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA054424D59
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 14:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787753152; cv=none; b=UqIKbaYN7YE8divWqab8hBvaIjqY8s9E8G1hM6bNXbxYrOafHFTmUbnLnT4WR8WgHM0erG0rfG97yULIMP1d+KMWVrTJ785PsBaiSxgGHyqJnz9Sa+aNQaE4kt3X/8t9QxnIVLs2Gxq7XkyPzM+8jthiZQb4QnMBy4hPavC12Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787753152; c=relaxed/simple;
	bh=8oCXevYhk/nSookb8hJiRtTkWz7E2b/fXiNxjofMLJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pd7DzQHlRi1yylasE2LxXAxq3K3P1aXG2GigcE+YYKXoJdc3Gz5Qem0Cm8e84zTILSOVRE7aUUb7sW4RcvtzIkCatLvmynjKd50BgLf5JTxdFL6V+ayIg/dxUzniXqzOWynHRGwZuU/7WkZsWW1n29Ib64TkyZ6XZEYrkgffPuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gimNWy8s; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gimNWy8s"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 309714E413C5;
	Wed, 26 Aug 2026 14:05:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0437C604EC;
	Wed, 26 Aug 2026 14:05:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E3B4211C7829D;
	Wed, 26 Aug 2026 16:05:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787753143; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=cXsx1idLiQLmu5OSql9TqufiNEY1QoJGB5nGEjhmbFA=;
	b=gimNWy8sdrPKRcjYeI0andmUbYgh5R5/mjDuKhTa6Npdd9BSjbq2ZXv/O7vFp4XfpxlvYN
	zBdvQrG7krBMZQ/CGQ/jXsf+GD/uwvq0NLr1QrWQA5WqAdJQwOzS2QPJyhMwslp/aKsHzN
	9JfDNJf81MrTtAn03oaSa7csLbuu+pmQRMehfW3gCetlkdn+c//O0j+YYLQx9Erdw4Pw++
	gapElzVfnvCpFogme6oeoyCCHzLIlhJJFvgxhOq1qT9hsa9vSj+gmCtW1+krUaP5zft1za
	1wn/GhKnV+j7leqedSEVFAe9POYeQCCUQAhKoKDGlQVVat+yLNZMFgFyamofLQ==
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
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Minda Chen <minda.chen@starfivetech.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Jan Petrous <jan.petrous@oss.nxp.com>,
	Ovidiu Panait <ovidiu.panait.rb@renesas.com>,
	Jose.Abreu@synopsys.com
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH net 5/6] net: stmmac: selftests: Account for the UC filter list for filtering tests
Date: Wed, 26 Aug 2026 16:04:57 +0200
Message-ID: <20260826140500.616466-6-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826140500.616466-1-maxime.chevallier@bootlin.com>
References: <20260826140500.616466-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

On dwmac, one of the Unicast filter entries is used to store the local
HW addr. This means that we have to use promisc mode for any kind of
unicast filtering if we only have one slot in our unicast filter.

The number of slots available depends on how the IP is integrated, and
we can't autodiscover how many of these slots we have available, so
the DT property snps,perfect-filter-entries can be used to specify how
many are available.

Most IP variants default to 1 if this isn't specified, which is the case
for the amlogic variants (in this case, S905X3).

The stmmac selftests for UC filtering look if we have enough slots in
the filter to store the dev->uc list, but doesn't account for the
device's own MAC address. The dev->uc list's size we get with
netdev_uc_count() also doesn't account for the HW addr.

As the selftest only requires one available slot, in the case of
single-slot platforms, that means we erroneously consider we have enough
room for the test, when we actually don't, and the filtering test fails.

Fixes: 091810dbded9 ("net: stmmac: Introduce selftests support")
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 .../stmicro/stmmac/stmmac_selftests.c         | 21 ++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
index 14db0c0e0ba9..ae236a264e74 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
@@ -479,6 +479,21 @@ static int stmmac_filter_check(struct stmmac_priv *priv)
 	return -EOPNOTSUPP;
 }
 
+static int stmmac_uc_filter_check(struct stmmac_priv *priv)
+{
+	/* For tests involving the UC filter, we need at least one empty
+	 * slot in the UC filter. The UC filters contains netdev_uc_count() + 1
+	 * entries: The dev->uc list + one entry for the HW address.
+	 *
+	 * Having an empty slot therefore means netdev_uc_count() + 2 entries
+	 * can fit in the filter
+	 */
+	if (netdev_uc_count(priv->dev) + 2 > priv->hw->unicast_filter_entries)
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
 static bool stmmac_hash_check(struct stmmac_priv *priv, unsigned char *addr)
 {
 	int mc_offset = 32 - priv->hw->mcast_bits_log2;
@@ -570,7 +585,7 @@ static int stmmac_test_pfilt(struct stmmac_priv *priv)
 
 	if (stmmac_filter_check(priv))
 		return -EOPNOTSUPP;
-	if (netdev_uc_count(priv->dev) >= priv->hw->unicast_filter_entries)
+	if (stmmac_uc_filter_check(priv))
 		return -EOPNOTSUPP;
 
 	while (--tries) {
@@ -614,7 +629,7 @@ static int stmmac_test_mcfilt(struct stmmac_priv *priv)
 
 	if (stmmac_filter_check(priv))
 		return -EOPNOTSUPP;
-	if (netdev_uc_count(priv->dev) >= priv->hw->unicast_filter_entries)
+	if (stmmac_uc_filter_check(priv))
 		return -EOPNOTSUPP;
 	if (netdev_mc_count(priv->dev) >= priv->hw->multicast_filter_bins)
 		return -EOPNOTSUPP;
@@ -660,7 +675,7 @@ static int stmmac_test_ucfilt(struct stmmac_priv *priv)
 
 	if (stmmac_filter_check(priv))
 		return -EOPNOTSUPP;
-	if (netdev_uc_count(priv->dev) >= priv->hw->unicast_filter_entries)
+	if (stmmac_uc_filter_check(priv))
 		return -EOPNOTSUPP;
 	if (netdev_mc_count(priv->dev) >= priv->hw->multicast_filter_bins)
 		return -EOPNOTSUPP;
-- 
2.55.0

