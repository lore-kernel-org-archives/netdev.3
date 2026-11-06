Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793977353;
	b=le5tWCLJXhUGNXELosLu/9osjsGDgS70cKN7xd8SIq3scGX7crFX7PBF5E/zKOGseqNW
	 5T8moUtJeE8gwOsbse2eeLySxQFuC11PvUFL56H3AddYf0zqtMeIl2pM4bR9r4PqnKjyc
	 AV7KB+uoPiPj/ZIdw4gLbqOlLo74AHgTzS7H6cya9/dGRCNWY6EsAqWdL5zyToNVVYSfP
	 2doXJWmfptIR4dbatDujL6V7eXQ0AyjowwKxrFTJnMGzr7XsGM1HVA1JP5oSqbflQS44V
	 /yHpbh7tTbKh/+vZO3B1Bgw77MHY/uW7M1A9ezMg3zmH3fghvSQEO8FH/tnF45KkfKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793977353;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=lcDTBznm6PCxmTI9iFN9G2u8m4G/v9BYzzES5VWgkB8=;
	b=Y7OF6+X+RyKt2Mc+5N7/VlrvCVflIN/vvFdiSZay7fk8ne8V0Fm5DH+dwtCEgaOI4fWO
	 ddBfNUkoYyqvMx9KMB93gg6/NuCqWNdsT67If9IeKg31sXCq5Bsbk7SUfoInlQTeV5f5o
	 L1aaPe2V2xqmBhy/gvedjvvDbcMKRRgtg4gvqoMClLKCMrRp4oJda2/4SK3P+SATbvnxu
	 KR0F9gk8+9Rsou2qzLSa9RZZgWFbqU25LugTclry8qiZKWLmNNXLH5wOlS7q+WazPOTbt
	 F3lKys9A7HBmHuudkoclU2BRsAo/Ekxv8gl8PgPJVAY6xJAp/0GT0vJk1kEhoA2W3oA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KBHRC6uQ;
	arc=none smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871E0606EEBC
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 15:02:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 871E0606EEBC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KBHRC6uQ
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c468bd799ecso92374366b.1
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 07:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793977352; x=1794582152; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lcDTBznm6PCxmTI9iFN9G2u8m4G/v9BYzzES5VWgkB8=;
        b=KBHRC6uQCoIJICbVcFKCA9umbJX5UqAa5jWy9K8GLNS7UHzAPrrJyPydZbj2O4TCgy
         P62RNhlkPHn11KUz6GGRoMNrUm/bWXWNMpkFuhBTr+mM7QSJEX8JOHU4fRIHFCIKGzAi
         d9xyclvtJ+Ht7ok95Z/bp5ULXtd3YcWf3pgChkUPMdRcW8X/MusUHzBdWOlFxq3xD4S+
         fMtoJHx6oHIvc5wO22XBXU5FKM9Ux5J2qdQ3gTkPjH4/HN+au7mHQICJblv3UAn4fBlf
         oDOmGbU9QN2czTBxBEtQCV2aGHmP2x4qgY1/pibcoCiz/iDBksYt0x8rR69a0xrmMfdy
         hpLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793977352; x=1794582152;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lcDTBznm6PCxmTI9iFN9G2u8m4G/v9BYzzES5VWgkB8=;
        b=Cepf/Jw25mtCmYdGGbmwa1+HQd4aXbhSy9zbFat6ryx/p20mysoN+QTgSyGx5ssU6z
         xUwEos/WdzZReTBedkq6lNHqxEatOnMyNOA0KKBVu38BPMl6+WQXUit8lodppJTPMZzD
         5W4vlXNDxplLycOQoSkVtLBSuGB3qCzEdPYZdBFPT4QjBQSjMGeK0xHItAKqcSo5zNJX
         ihcnPSmNCrFA778uCKaGTfLfqgH7E3ZIOt1DnsbT1p3T58W4oHje00Fx8PNRpasDb+KM
         LUlYEk6NWKVEV/hf+7UCLpS9rxKEpGfp6n0pGSO/v3Gx5uBpxNfl3Ga9kcjZil7c+e8x
         wnzQ==
X-Gm-Message-State: APuU4Z8Yp2On9CNa2NRAKO+rqvKTWPfqTJ0qmyVMUiVrl0WriQew3xiw
	x04SAMunOYCRkRs6Q6H9Wc4z+9/B6lP+ej7JQWKYF3TS6RkFmNov26jtuXPtslm2
X-Gm-Gg: AYBFou0bZkV0Vu1FFARICzVl7sneRe1c3ld7cIlW+3Oi6auqOjKmayTsD+y4NgvHcaZ
	MqJ60NxvLiy9WXct22rewc2G5AhJtj61E8r1bxcWyhaOteyg8+UyVsO6JKzrs1pgL263KClassi
	q3/H9BTnLD5OS7CC2BBg5LU5QWtQe+ogBGl4Iu0l/wTyPZNTU+kacKfoB4qLTQRI9E0Vykrdfxj
	BuIshpPO2V39k0jbc9BFD8fYGBdjRnhFialtbpGCy6yVdjLauD5uLTZ3ZF0tDuyr2PKd/BgfxSL
	Jy9N4qAJX/uVPL6i2/aqnFgYAyxM72znYCAFTOeCRrDbWDrektKjbw7WAAOEJt9aNufxALBrJgH
	6nFh34t3u//y8aSoGMTAlUVaCEj81Y2e1DXWqCYc6pb1oBHWfKWccAbxsP/GtXAxRG3cDTIOdpy
	y15jytwHLJNNjp9z0LM4HyID0DmaBFvV+8GVpHZ+MNIe2DMLVWMLnBUAFl6tpviYpk0z6DoBOA1
	0qOYRihF3Oj0u7bgsRuctNrvgECqNUWQFqvU2w6vbkB6JvJypuNYVWf4maRO6tTHdCxwUbrdElY
	wtjFvsnPH30BcxyVh6vRI9xSptR7m2yxHWZ1qQOslxUodmgELWZZthsTtOjumTEUoZZC4CaF8Wd
	6Zse/vCXYvdTTBtBBMR0DRXQ5R/IqfdMLgu+xDxWsnxD2n5xRTHSQb9GPHaOQkGZ+D8kjjzVvJK
	pZ
X-Received: by 2002:a17:907:9805:b0:c2a:cf73:63fe with SMTP id a640c23a62f3a-c4d3449c402mr242731966b.6.1793977351894;
        Fri, 06 Nov 2026 07:02:31 -0800 (PST)
Received: from desktop.home.arpa (2a02-1810-1e16-ac80-898e-1938-27eb-b890.ip6.access.telenet.be. [2a02:1810:1e16:ac80:898e:1938:27eb:b890])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d356a2ee4sm84905766b.60.2026.11.06.07.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 07:02:31 -0800 (PST)
From: Stijn Cleynhens <stijncleynhens@gmail.com>
To: netdev@vger.kernel.org
Cc: Linus Walleij <linusw@kernel.org>,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	=?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin.sipraga@analog.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Mieczyslaw Nalewaj <namiltd@yahoo.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 1/2] net: dsa: realtek: rtl8365mb: use IVL in VLAN 0
Date: Fri,  6 Nov 2026 16:02:24 +0100
Message-ID: <20261106150225.3700205-2-stijncleynhens@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106150225.3700205-1-stijncleynhens@gmail.com>
References: <20261106150225.3700205-1-stijncleynhens@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

DSA installs the FDB and MDB entries of standalone ports and of
VLAN-unaware bridges with VID 0, and the driver writes them with
Independent VLAN Learning. No bridge VLAN sets up the VLAN4k entry of
VID 0 though, and it defaults to Shared VLAN Learning, so the switch
looks up and learns frames classified to VID 0 by FID. Lookups never hit
the IVL-keyed static entries, and a learned entry for the same MAC sits
alongside the static one.

Set up VID 0 with IVL, like every other VLAN the driver programs.

On its own this has no visible effect: standalone ports do not learn and
the driver does not control host flooding, so the unused static entries
only meant that traffic was flooded to the CPU. The next patch, which
moves VLAN-unaware bridges onto VID 0, depends on it.

Fixes: 336e3e4a1ab3 ("net: dsa: realtek: rtl8365mb: add FDB support")
Reviewed-by: Alvin Šipraga <alvin.sipraga@analog.com>
Signed-off-by: Stijn Cleynhens <stijncleynhens@gmail.com>
---
 drivers/net/dsa/realtek/rtl8365mb_main.c |  8 ++++++
 drivers/net/dsa/realtek/rtl8365mb_vlan.c | 31 ++++++++++++++++++++++++
 drivers/net/dsa/realtek/rtl8365mb_vlan.h |  1 +
 3 files changed, 40 insertions(+)

diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
index da06f952a..b90e46c16 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_main.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
@@ -2232,6 +2232,14 @@ static int rtl8365mb_vlan_setup(struct dsa_switch *ds)
 		}
 	}
 
+	mutex_lock(&priv->vlan_lock);
+	ret = rtl8365mb_vlan_4k_setup_neutral(priv);
+	mutex_unlock(&priv->vlan_lock);
+	if (ret) {
+		dev_err(priv->dev, "Failed to set up VLAN 0\n");
+		return ret;
+	}
+
 	/* VLAN is always enabled. */
 	ret = regmap_update_bits(priv->map, RTL8365MB_VLAN_CTRL_REG,
 				 RTL8365MB_VLAN_CTRL_EN_MASK,
diff --git a/drivers/net/dsa/realtek/rtl8365mb_vlan.c b/drivers/net/dsa/realtek/rtl8365mb_vlan.c
index 8d49ffadc..58948e76f 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_vlan.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_vlan.c
@@ -322,6 +322,37 @@ rtl8365mb_vlan_4k_port_set(struct dsa_switch *ds, int port,
 	return 0;
 }
 
+/*
+ * rtl8365mb_vlan_4k_setup_neutral() - Use IVL in the neutral VLAN
+ * @priv: realtek_priv pointer
+ *
+ * Untagged frames of standalone ports and of ports in a VLAN-unaware bridge
+ * are classified to VID 0, the VID of the neutral PVID. No bridge VLAN sets
+ * up its VLAN4k entry, which by default uses Shared VLAN Learning, so the
+ * switch would learn these frames by FID while the driver installs its FDB
+ * and MDB entries for VID 0 with Independent VLAN Learning. Use IVL in VID 0
+ * as in every other VLAN.
+ *
+ * Context: Can sleep. Must be called with &priv->vlan_lock held.
+ * Takes and releases &priv->map_lock.
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int rtl8365mb_vlan_4k_setup_neutral(struct realtek_priv *priv)
+{
+	struct rtl8365mb_vlan4k vlan4k = {0};
+	int ret;
+
+	lockdep_assert_held(&priv->vlan_lock);
+
+	ret = rtl8365mb_vlan_4k_read(priv, 0, &vlan4k);
+	if (ret)
+		return ret;
+
+	vlan4k.ivl_en = true;
+
+	return rtl8365mb_vlan_4k_write(priv, &vlan4k);
+}
+
 /*
  * rtl8365mb_vlan_4k_port_add() - Add a port to a VLAN 4K table entry
  * @ds: dsa switch instance
diff --git a/drivers/net/dsa/realtek/rtl8365mb_vlan.h b/drivers/net/dsa/realtek/rtl8365mb_vlan.h
index 27a526b61..809034009 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_vlan.h
+++ b/drivers/net/dsa/realtek/rtl8365mb_vlan.h
@@ -28,6 +28,7 @@ int
 rtl8365mb_vlan_port_set_framefilter(struct realtek_priv *priv,
 				    int port,
 				    enum rtl8365mb_frame_ingress frame_type);
+int rtl8365mb_vlan_4k_setup_neutral(struct realtek_priv *priv);
 int rtl8365mb_vlan_4k_port_add(struct dsa_switch *ds, int port,
 			       const struct switchdev_obj_port_vlan *vlan,
 			       struct netlink_ext_ack *extack);
-- 
2.56.0

