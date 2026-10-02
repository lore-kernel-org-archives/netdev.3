Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EF5495AD7;
	Fri,  2 Oct 2026 11:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790942345; cv=pass; b=UukcvgdaxDniYny1hvxBy5Pi6SKLywdxB+iHZwUg33dW/ZzneWA6qQ0Jnwo6HHjnOhGDmsoxB8aCZ+m256QUXIw6QuFdq/CBBM1H5sfo9G/zetFgyC/4z7RJQTJaetnj/qqE6vdy29ydrcX5/LdLkqzGAzDT62E+JUfZ7YlKEaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790942345; c=relaxed/simple;
	bh=mOcH5tmIHzimQjgIZ5jz25z9oLQxGZE5KliHORyh240=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yo+sP/FLGkMXnGSIFTzLscglQOwLv9sHYBy+itya48wCoFW/98dOcz3fH39HZGqDmjeWST0JKBs5atX+XF13UYYoF3A59bFEcWkrcIOaWqO8yAVARgGCsSBHnS0gWyuJlQSctiHUz+I4eChIA9rX/MBV4M6P2Oa0GRQOxLFXBwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=cgfHMg55; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="cgfHMg55"
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.pengutronix.de [IPv6:2a0a:edc0:0:1101:1d::ac])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 37467202304;
	Fri, 02 Oct 2026 13:58:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790942332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dzy8UX5955NKUmqtRtc6b5E+os/kK1wPB116shjCwlk=;
	b=cgfHMg55gFAGx2sMdWafJ0Yy2pURjQ12ffWbbSFudvYk+Isz9LIV9SLli4E+SriYzM2h9N
	mEcb1NYw9lUaDUaRiOsd3CRQ7HhNg7xb2AIOeio/01P5Pn1vLQC/2DBnakeRilFwN9pwGS
	CKOW1AGHQ7hkrMoFm0dzBBxfrdOUm7Ynj6jpzEWLGS7qgN7TJzi8CaVwfHenKbfaJj66/4
	sMuZHo9RJ6/w64SST9JJmw+pkk94Y+P4sHLPE46sMU3kAVFk0jZ/3gHa/B8sZZU4uqxXIw
	DHtr78i3ThO27cEmXJ484wCSw5WmrnuPnO3Fo7eP5u5WavjeweSD0jtIooPekA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790942332; a=rsa-sha256;
	cv=none;
	b=fWqz476gmxGgIfBzM/R2dE0I/uHgmhAJtwZMOJRHFG4n9VabMR9zB4kYKvIbwEmaaQ2od5
	jpZuqjb7Bs31VtagzXz4e8c0YYKeQbnU+1PhUtCHCk4rFApE+5jolmEYCnh4zJyu7oH359
	Cqi469K53zeKbYeUlq2ZJdc+aRej4eg/lDubRG8JB1GLkJW48+uCLJI5t4brD7r3d9QwQC
	lQpqLuEKab+OucRUF8jOC5q98Gypxk5f6nhKe1gC+zcWhteCDiaook+n53sTbn+1kvSKn1
	s3rfVr3orYqrIUM81XxrNXk6h1Y0PeTGHp0jYc211RBibXRW1fkmdJmINDLnag==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790942332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dzy8UX5955NKUmqtRtc6b5E+os/kK1wPB116shjCwlk=;
	b=D6cAGNlCZLvit7y7vYLF3ARNCkNT9mv9vgYOTcjsgaNiutmtAeL528sbroXifJ7Tz0LD+z
	AixwHdVtvxOq2y0D38apPtSOuLIJ8OiBcxBpMCH6QPp98rrrxpqXycWYEqTncu1+M9gBGN
	YaPevnlPlUxjDH6WqD1hsjsC2xiZLS936ZmOtunbsP5P6lNSI64hQa48OeXQRD4lUQd379
	yfptYoAXb5cgw/TgnEp2au/JGLc61VoTE5BKnobkSeXt+RP1+UC+B7OdojGYq9Io94H4Xc
	buSB+HmN3GC3mDegfKVHeu2MrXKv+eYf6WXZMN2VlodEcUlAcKfA71jt5lNFfg==
Received: by dude04.red.stw.pengutronix.de (Postfix, from userid 1058)
	id 25CBB380BA7; Fri, 02 Oct 2026 13:58:52 +0200 (CEST)
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Linus Walleij <linusw@kernel.org>,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin.sipraga@analog.com>,
	netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v1 5/8] net: dsa: realtek: rtl8365mb: store the egress queue count per chip
Date: Fri,  2 Oct 2026 13:58:47 +0200
Message-ID: <20261002115850.962676-6-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261002115850.962676-1-o.rempel@pengutronix.de>
References: <20261002115850.962676-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Store the number of egress queues in the per-chip info structure and
advertise it through ds->num_tx_queues, following the ksz driver
(struct ksz_chip_data.num_tx_queues).

The queue count is a per-chip hardware property, and this driver supports
several chips of the rtl8367c family. All currently-supported chips expose
eight queues, but keeping the count in chip_info lets the QoS code that
follows program the priority-to-queue map via the ieee8021q helpers for
whatever queue count a chip carries, so the 802.1Q collapse is correct
rather than hard-coded to eight.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/dsa/realtek/rtl8365mb_main.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
index 87ec924a0611..0924d31790e0 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_main.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
@@ -708,6 +708,7 @@ struct rtl8365mb_extint {
  * @extints: available external interfaces
  * @jam_table: chip-specific initialization jam table
  * @jam_size: size of the chip's jam table
+ * @num_tx_queues: number of egress queues exposed by the chip
  *
  * These data are specific to a given chip in the family of switches supported
  * by this driver. When adding support for another chip in the family, a new
@@ -720,6 +721,7 @@ struct rtl8365mb_chip_info {
 	const struct rtl8365mb_extint extints[RTL8365MB_MAX_NUM_EXTINTS];
 	const struct rtl8365mb_jam_tbl_entry *jam_table;
 	size_t jam_size;
+	unsigned int num_tx_queues;
 };
 
 /* Chip info for each supported switch in the family */
@@ -735,6 +737,7 @@ static const struct rtl8365mb_chip_info rtl8365mb_chip_infos[] = {
 		},
 		.jam_table = rtl8365mb_init_jam_8365mb_vc,
 		.jam_size = ARRAY_SIZE(rtl8365mb_init_jam_8365mb_vc),
+		.num_tx_queues = 8,
 	},
 	{
 		.name = "RTL8367S",
@@ -747,6 +750,7 @@ static const struct rtl8365mb_chip_info rtl8365mb_chip_infos[] = {
 		},
 		.jam_table = rtl8365mb_init_jam_8365mb_vc,
 		.jam_size = ARRAY_SIZE(rtl8365mb_init_jam_8365mb_vc),
+		.num_tx_queues = 8,
 	},
 	{
 		.name = "RTL8367SB",
@@ -761,6 +765,7 @@ static const struct rtl8365mb_chip_info rtl8365mb_chip_infos[] = {
 		},
 		.jam_table = rtl8365mb_init_jam_8365mb_vc,
 		.jam_size = ARRAY_SIZE(rtl8365mb_init_jam_8365mb_vc),
+		.num_tx_queues = 8,
 	},
 	{
 		.name = "RTL8367RB-VB",
@@ -774,6 +779,7 @@ static const struct rtl8365mb_chip_info rtl8365mb_chip_infos[] = {
 		},
 		.jam_table = rtl8365mb_init_jam_8365mb_vc,
 		.jam_size = ARRAY_SIZE(rtl8365mb_init_jam_8365mb_vc),
+		.num_tx_queues = 8,
 	},
 };
 
@@ -3262,6 +3268,12 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
 		goto out_teardown_irq;
 	}
 
+	/* The rtl8367c family this driver supports exposes a fixed number of
+	 * egress queues per chip; advertise that count to DSA so the QoS code
+	 * programs the priority-to-queue map for the right number of queues.
+	 */
+	ds->num_tx_queues = mb->chip_info->num_tx_queues;
+
 	/* Start statistics counter polling */
 	ret = rtl8365mb_stats_setup(priv);
 	if (ret) {
-- 
2.47.3

