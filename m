Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C3D3D3D09
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 08:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788336328; cv=none; b=IF59IHHKdt7cVO6PFPWaKH7nyKUzeyOVWvZyzT89A1KV1WRRRP4wB9fCgEVFKibmFFL3YtCZPKiIAjGd9qfFeHsVIZh3jsD8D6xcddev64mRDGi1y1vby59ViYMfJIjn+Y62OqqiZUGkXYgHh11P6dK8pFNp2Bz1vDY6Br1aLyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788336328; c=relaxed/simple;
	bh=Plh657AhjTtUUbMJ/5T/QAFeBNvoXLLEg1/3G7jrrqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VB7p2+ekYUXqkzvDfcHjwJiXGObUaOtyAGjNEhLOGDGe8GnY5jgPMTvGZ0oetglUo9WwvV0kTiGIcHoglY8BV2zAsD13n8BQEc39nol/LgS1wvaTsqM048UeVmUuXbCsVD9aoA6BKHfk+uoWGifl1OooPEvH1jQw2XI1vWSXnvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=cn0hKy/q; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="cn0hKy/q"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4998b5a63e2so7215725e9.1
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 01:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1788336324; x=1788941124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PCu/YU+1fYdbICpm8C465sZb+CGw/CHGy5Mn4qOYcAY=;
        b=cn0hKy/qJQR/A9kPeE86iQXZ3SJL0UwaUMTJJOjgGWolliLndwBMFwZLmATpLDk2r7
         7sdLLEWr0qGlJ/AmK4xT/VZ+Hyw2c4jznlDpzImGqY9X2QUedB1mCLpxg8FO3h2XDkAK
         3feQSo+uxKdD5yYY5gaRlmWZZMi2p7YYzDYQMr/dU/SmjrIHeQEY/YHJmzk7HOJzGW50
         IPst6XHLkFJuktioXq//jKOxj1lY6CRXFk1hfCFD92yNVJ5ngWfBwr8aQ9jLz0ZuEasd
         PX1ufKBM9SzI4JZdyca78MRLD7Ur2L+Y9dU++89PW4ygoq4UtG/OCp+6OjU2SXGj0PT9
         u+8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788336324; x=1788941124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PCu/YU+1fYdbICpm8C465sZb+CGw/CHGy5Mn4qOYcAY=;
        b=HXm85W4TqdEO6sbXnyJFv7Bm5xOB7zUwOZsj2RmwQDlRGRamcYd2Q0l0mv4pa1JrLd
         8nukKxpRulYUTHr+d0B89lBmsV6artUOtQwqBBIYIoA2RstTHKSUf233Nj/mM3zpy53W
         kVO6YYTqDUvTChj1dVwUyRrkoYh58V8GwPg6sfpb3PxqkmnVMxDsCvUjlkIR5N6UE1KC
         qBvPRtQRgPxH/ZGMSKNL374ZjBLzyjGHkDmM5zcUMMj++qZ4wLMAdVxw7PvWTIhv6NDl
         pIoqTt7VGqlWqvM4GfQpXx7bikKJir5Et1L91eMclVhBTq0FYqeX9HB8urqKU6TWTm6U
         Ea5g==
X-Forwarded-Encrypted: i=1; AHgh+RqdVERSnDZXfwx8SXFe8Z4tx2RgoWmqvVTBlvrKlFRcZQhNLyqyY/6X4hGjUYF152xu2tsdXMU=@vger.kernel.org
X-Gm-Message-State: AFuF++kYDVkHE3oOrL+Y4lCxcI4/wFBwk7SVZhL61ld0r4XSXTxcXpeX
	qTxAGDBMuoWH7j+re5uNPc8AcGT/7Pk8cvCTw1MZgyIZXsztRgRns/n+q94JyOkzhww=
X-Gm-Gg: AR+sD10ClhxAqIgu+42UreipSvzD0Tnk2yw5MLyvGZ25mfSqWm3jeGSsJvXJmidl1qa
	v4s06YAXsj+/D6MtvOOQfSqer0NqmSm825XoEJNn28ikzP46wW1CpOl+ALFXHHE3aQByrwNsfM8
	U3nqPA4cAXJLhFqY+5xSqUxRzD4cep3Id4n0eYMX0WOG8EycYmR5HODDvUSkY/CfcM/NYZlouoa
	jRclaKrBwTdQRHEgieotA+sIP2PMXd+Shbrtcxc+AaukClnB5TegoknTlGXzjRdBf3O/oFsS/Ku
	BOO2vrU1s+C6bIA6KQg2wx8rGaY/FqDTcPJHKHGXfM1XEtnj6XlLFpCk8HLhQxjPChz7J446O97
	CSS5K6ZFKitMpDS7bm7Npg/+VBvUexd2308+WgElSmQUoE1purKrLY9gKn1ddoAk4wY86S7CAY4
	fRLaFYKn9byv39KVJAtsjOI0AtQyAYhTwiS9QISgY=
X-Received: by 2002:a05:600c:63c6:b0:49c:eb16:9fd with SMTP id 5b1f17b1804b1-49ceb160bb1mr1759475e9.3.1788336323878;
        Wed, 02 Sep 2026 01:05:23 -0700 (PDT)
Received: from remote-01 ([84.17.55.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce309e418sm72781715e9.13.2026.09.02.01.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 01:05:23 -0700 (PDT)
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
Subject: [PATCH net v4 1/2] net: dsa: mt7530: populate lpi_interfaces to fix EEE support
Date: Wed,  2 Sep 2026 08:05:18 +0000
Message-ID: <20260902080519.2211373-2-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902080519.2211373-1-f@lex.la>
References: <20260902080519.2211373-1-f@lex.la>
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

 drivers/net/dsa/mt7530.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 2b7be091c056..a188a391b650 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -3172,23 +3172,38 @@ static void mt753x_phylink_get_caps(struct dsa_switch *ds, int port,
 
 	config->mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE;
 
+	priv->info->mac_port_get_caps(ds, port, config);
+
 	/* The EN7528 GPHYs report EEE capability, but negotiating EEE with
 	 * common link partners (e.g. Realtek GbE NICs) results in an unstable
 	 * link with dropped frames. Leave the LPI capabilities empty so that
 	 * phylink disables EEE on these PHYs and refuses to enable it from
-	 * userspace.
+	 * userspace. Ports that run at neither 100 Mbps nor 1 Gbps are left
+	 * empty too, since LPI above 1 Gbps is unvalidated.
 	 */
-	if (priv->id != ID_EN7528) {
+	if (priv->id != ID_EN7528 &&
+	    config->mac_capabilities & (MAC_100FD | MAC_1000FD)) {
 		u32 eeecr = mt7530_read(priv, MT753X_PMEEECR_P(port));
 
-		config->lpi_capabilities = MAC_100FD | MAC_1000FD | MAC_2500FD;
+		/* PMCR folds SPEED_2500 and SPEED_10000 onto
+		 * PMCR_FORCE_SPEED_1000, so LPI above 1 Gbps would be
+		 * governed by PMCR_FORCE_EEE1G and is unvalidated rather than
+		 * unsupported. Leave it out of both bitmaps: lpi_capabilities
+		 * gates on the media speed a rate matching PHY reports, not
+		 * on the speed the MAC runs at.
+		 */
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

