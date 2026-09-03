Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24CB4A4833
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 12:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788439012; cv=none; b=jMFnEmIioZxfmu89aSIfagACcG+wC8i/nR4vG9QpX/sEeUcmqeoPs4cwtvqoSL2QdYau1Ad0UF6gLsdjuTV/rsLaSTHCoObF5vBJ1oEFjWsiqQJh376e4VQd+h6sbqHiiKkSgAorHKU0OLG8fjFRPoOTQV1jbxyuIB979lVuWeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788439012; c=relaxed/simple;
	bh=ghqOiytwdKV2QgPHAJ66vgnviwKhQoqEJeoZvkld8UE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ncgQCHwdapIYnjMNM/HevwH8vpPq1KXq1TsJcAWwqWtU0yiofpyIgEO6Os+EaG68hajTq4/UFSDzdTm8HbA4TpWzwPc7aHFlQ+unFsNpepkScTMcCPtHoVChMDgtazJvV/hDkg/tEET875LCgj7bIUE2EMCEz7Iz/iwYYlQ8Zks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=T2xnsh6p; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="T2xnsh6p"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-499ae1c6471so15174555e9.3
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 05:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1788439009; x=1789043809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mnwb6hERpnN0nOzAPeu6lXZdqPLOGboK0OSUAEKDpNw=;
        b=T2xnsh6p7x27qeHPkJQr/rtiB/3wuwXstdgL0KnajXKDtogvihzpRNlthjSpHW4Ktv
         8Oq2CdaAcOZyKBi3Nlgcns7GYLzy1boBiZID25QjrIP0u7bZb401H2pY6/cG37PnpTn5
         rKRVGzMxb353wEx9L3EVxiJ+O8kTpDw2acLE1o7QUTxhY2EmMvkIUQwO27s5+UE1LmRW
         pzkWIqorHhXpbkrfXSxaJnziMkDht4pEt6vTpM3gXRJjM8F1bIp9aBh6bXsDC1JkgugT
         8VNpJU+H9OlKprfEGZDnrDZX4qrHPlVFIPUUiTN1XVwiwH6irmTeUFGlePjTBC3OiFRL
         uk8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788439009; x=1789043809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Mnwb6hERpnN0nOzAPeu6lXZdqPLOGboK0OSUAEKDpNw=;
        b=aE96RX62MRwV6nd79abePmeZEK1PjkvsQXVCbOwYADopNL98r5nCVsRBt/HqKo3I67
         la688JwhKNwjQuscSzAJJkj1+8Yxnl92ofspXGdz03Nzr7NN5sQE5dE9ZZx09pdRtPzh
         p3oj+1mv6PBldjEua7kw4PCM001xq2ofryS08sTSdnvQ/B6wOt0n9djMjgcFLaudv3YH
         ctDiqMl7CPM7z3vAGRnVt3MqqrYcDiCcJ8BA2qPhuBZygHUUMzcHg83aIefecSszFuut
         khuzpudVkjmczapVeJ6H9gL5r/wKbSW76KwVPE1aFuI7EkTZjZoMJFlL9kOKjX93jgmG
         SEYw==
X-Forwarded-Encrypted: i=1; AKwUvByciFCn9nmsA+/kro/G1UOaoRRI2CbbBnzR2/iZlfsK2saVEWCU5pL4VRgZjNKDZAg3Rbvtdy8=@vger.kernel.org
X-Gm-Message-State: AFuF++n6T+ZnPXM/z73ut1O/mA752afXM4yxrQoF+Q5yMrSh7VoOBc73
	pKhbDI6CHb3NKm2KIbqRVrhPhgghuxzwwvpGi6sfhOdoXSk+JZJYDE3S3bv61PnJahs=
X-Gm-Gg: AYBFou3lzLWUOg8BtXzbvrX64xfybGtEvoXIiegwPtxwrZgtRCVjiWNtMm/P3rqvfpO
	mwnWFQCaq41PotGbjxGK0MUMi2J9NYHrV+hCYcWy28nPyeLKIrscBXsqpiD01mZCVH6Yx8HHfEG
	1kRFKswrs8BUjA5V+qXd9llLrONiQ0CFmYTtKFj/XiqVGAOu1Wz9wHFtAzETwWMFfzTK9+TfH/r
	JmgVuad1Se9Cg4CA56e0oEyTpT1+QVFMwaHqB3Ye0yBPF8Q97b6aeZZEm5FT7gLtS2rCZmklCRg
	Ih84xEEQIN7OxtZ0FzlWxlC9y3QM+vwXmzQJMHxLUC5UMUGddTzi6DioJFbwYqSn6XWNoKVZR/x
	3f8/4GbhfwkuUQVTjgdYtIYy7MFD/IBCbsP7pwxqDVV8TXprfEJJtX5iDcmrJ36cOpiFpAPAqqb
	Yt/OVeOZnILEEEB88yepg7KLT9K5R+d3cwHDuwUJk9VQePhzmEpjs=
X-Received: by 2002:a05:600c:3b11:b0:49c:dca4:94c with SMTP id 5b1f17b1804b1-49ce5843baemr202157645e9.13.1788439008740;
        Thu, 03 Sep 2026 05:36:48 -0700 (PDT)
Received: from remote-01 ([84.17.55.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448e72d2asm12828927f8f.8.2026.09.03.05.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 05:36:48 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: chester.a.unal@arinc9.com,
	daniel@makrotopia.org,
	andrew@lunn.ch,
	olteanv@gmail.com,
	nbd@nbd.name,
	lorenzo@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: linux@armlinux.org.uk,
	dqfext@gmail.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net v5 1/2] net: dsa: mt7530: populate lpi_interfaces to fix EEE support
Date: Thu,  3 Sep 2026 12:36:43 +0000
Message-ID: <20260903123644.23800-2-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903123644.23800-1-f@lex.la>
References: <20260903123644.23800-1-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

phylink_create() decides once and for all that a MAC supports managed
EEE, and it requires the tx_lpi ops plus non-empty lpi_capabilities and
lpi_interfaces. mt753x_phylink_get_caps() leaves lpi_interfaces empty.

So ever since the conversion to phylink managed EEE, ethtool has
answered "Not supported" on every mt753x port, and phy_disable_eee()
has locked userspace out of turning EEE on. That undoes what
commit 06dfcd4098cf ("net: dsa: mt7530: fix enabling EEE on MT7531
switch on all boards") arranged: EEE off by default, but reachable
with ethtool.

Leave the speeds above 1 Gbps out of both bitmaps. PMCR folds
SPEED_2500 and SPEED_10000 onto PMCR_FORCE_SPEED_1000, so
PMCR_FORCE_EEE1G would govern LPI on such a link, and that is
unvalidated rather than known unsupported: MediaTek's SDK driver sets
the EEE force bits for 100 Mbps and 1 Gbps only, and the unit of the
wakeup timers is undocumented with the port clock at 2.5 times the
rate.

LPI stays off until userspace enables it, but the EEE advertisement of
a PHY that advertises it out of reset comes back, since phylink stops
force-clearing it.

Fixes: 9cf21773f535 ("net: dsa: mt7530: convert to phylink managed EEE")
Signed-off-by: Aleksei Sviridkin <f@lex.la>
---
Ports that support neither 100 Mbps nor 1 Gbps are skipped because on
MT7988, EN7581 and AN7583 port 6 is 10 Gbps only and shares
PHY_INTERFACE_MODE_INTERNAL with the user ports, so the interface mask
alone cannot tell them apart. MT7531's internal PHYs keep the
advertisement mt7531_setup() zeroed and EN7528 keeps both bitmaps
empty, so EEE stays fully off there.

Two pre-existing things this patch makes live, neither addressed here:

- The unit of LPI_THRESH is still unspecified, as the comment above
  lpi_timer_default says. Before the phylink conversion
  mt753x_set_mac_eee() wrote tx_lpi_timer into the field directly, so
  the raw unit has always been what ethtool showed on these ports.

- mt753x_phylink_mac_enable_tx_lpi() sets the PMCR force-EEE bits
  without checking the resolved speed or interface, relying entirely on
  phylink never calling it above 1 Gbps. A check there would make the
  driver robust independently of lpi_interfaces being right.

v2, with the full argument for leaving the higher speeds out:
https://lore.kernel.org/netdev/20260824024117.46154-2-f@lex.la/

v4: lpi_capabilities is mac_capabilities masked to the two speeds
instead of both asserted. Every port that reaches the guard today has
both speeds, so nothing changes; it only stops the bitmap from claiming
a speed a port cannot link at.

v5: comments cut to one line (Maxime Chevallier); no code change.

 drivers/net/dsa/mt7530.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 2b7be091c056..3e61eb3c2b1e 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -3172,23 +3172,31 @@ static void mt753x_phylink_get_caps(struct dsa_switch *ds, int port,
 
 	config->mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE;
 
+	priv->info->mac_port_get_caps(ds, port, config);
+
 	/* The EN7528 GPHYs report EEE capability, but negotiating EEE with
 	 * common link partners (e.g. Realtek GbE NICs) results in an unstable
 	 * link with dropped frames. Leave the LPI capabilities empty so that
 	 * phylink disables EEE on these PHYs and refuses to enable it from
 	 * userspace.
 	 */
-	if (priv->id != ID_EN7528) {
+	if (priv->id != ID_EN7528 &&
+	    config->mac_capabilities & (MAC_100FD | MAC_1000FD)) {
 		u32 eeecr = mt7530_read(priv, MT753X_PMEEECR_P(port));
 
-		config->lpi_capabilities = MAC_100FD | MAC_1000FD | MAC_2500FD;
+		/* LPI above 1 Gbps is not supported */
+		config->lpi_capabilities = config->mac_capabilities &
+					   (MAC_100FD | MAC_1000FD);
+		phy_interface_copy(config->lpi_interfaces,
+				   config->supported_interfaces);
+		__clear_bit(PHY_INTERFACE_MODE_2500BASEX,
+			    config->lpi_interfaces);
+
 		/* tx_lpi_timer should be in microseconds. The time units for
 		 * LPI threshold are unspecified.
 		 */
 		config->lpi_timer_default = FIELD_GET(LPI_THRESH_MASK, eeecr);
 	}
-
-	priv->info->mac_port_get_caps(ds, port, config);
 }
 
 static int mt753x_pcs_validate(struct phylink_pcs *pcs,
-- 
2.53.0

