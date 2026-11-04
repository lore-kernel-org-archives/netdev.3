Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793780734;
	b=aUD/R2LB26nqJTFDZXNPEwNSP6M7IXLPH5fqPgidq2p5FANtyH8qWnmOiCPWsGRCaxdT
	 t/BhyFswQ8LylY4rEdLdPdS/yVZelt/zNoW+vM9ezDcCResCgN2WXd2rWSLwP4IfoCxqS
	 lqZZmRbkSAbJb/asdPZSubC2knlBzmwN/uFglsH5vvngVgRqSySB4HK0lHxo6oF/htegV
	 pnESkgjKRWBjwGmynnlY5PVX1d0wuHrpd0FPmMVMCPlYkE+XgIUg3czlT8PMlKGxcp19z
	 wFLW406UUv/64ZqtBJuZ0TNLo+h4WF3xrOagSSG8AEQ+HeqXAywrPSzYoC4vFuzHWZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793780734;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rxxWOir1eLyoN3YvCU9ZlQIZgB4gaoERImUZzmrTYyc=;
	b=lcqKDy+S/rWdTjdw2eDAiF/Ci9IzonHXmN/SKDzwuiVRRF/najSU4U98Em77vTwA3S+0
	 3GisXB0RnmeD4zUZwkq64xA8A+JlIOTboiSKMqVnwxkL9tVM1Oz3poyaDvcE1g/9YcAk2
	 aJw48MzVE7PEjP4ue8fxrcwkmpNlogoRkq8+p6vvD5Kgnb+WFUrcG0wauNCxR634Inj9c
	 1Qm+U2PePDqXaGyd8Yv2dmAIKdECkJpojk3x6N6a6i5/EWBchsky6fSIgtnkqBxFYXJDH
	 fiYusM92/NL6dBkrSAH1UQ/NJgCx7i8EQFFHfEbiH10/PMieQc/AF9JNXCsomRbch1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wa0rj6lX;
	arc=none smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E551F606A32E
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 08:25:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E551F606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wa0rj6lX
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6b2237b596cso853440a12.0
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 00:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793780732; x=1794385532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rxxWOir1eLyoN3YvCU9ZlQIZgB4gaoERImUZzmrTYyc=;
        b=wa0rj6lXsIdA+z2Ac9aNZVpvYG/LiC36mJKBmp41iCojudTm2YuCW3EvFA8PdLbIWb
         ABKLxTd7/n+kh1mSegoGCurrsEwME1cpKZaa/fX2hDbqlHjl2SHkSQd0G4Ip6coO1Ck8
         tcb3mG6fjOQXNpfafB2bUGwnGPOXIeyvS2XL2/4riPinHUnv5mdTZGk8KFE1HHcVDloh
         yogmj1a4hAFguXHALo+guHlCxpGm2QRz28a+j90fYmeLuV1nFa8jsoKYxJzYCDQi/WO7
         zzeUy3Hkyw9oEetFYgSYd/n/QcYwvQjfU3zFOQVMSs/HxGc7tEjHq8NSHSu4fW3Z7dVt
         YYOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793780732; x=1794385532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rxxWOir1eLyoN3YvCU9ZlQIZgB4gaoERImUZzmrTYyc=;
        b=L/ZD1OvBj/UCZSU8SUG9MtViE46Ln5+9s7VSdiEm0yWEQ4C3ztv59VNUx4Osl91KsW
         z/qUYs+hOD9MhyTRTv6Q4AAYdnkQSu6mxG0oInlZjyrdS4una4akUDp5Vf2mLbKzNOzx
         zNwC/yrLBZrgtdpvLanYk2VGeEcZOnp5JxvIIPwJ1+h4NtqFPnvo3UPBmlgUhGtYNOhf
         Jk/AY4Nr8dCkqRIB/UsxhWZrU2hPodYbRLXZ20I+Eb4MIV719gW/KBSYyOTPIDMNzAoo
         XhtmfNILSq4B46oSQUJntu/Bo+G7n7RZaXNMr3fNUT7sDRlEYPNQiPAP3y30lh1v9YI2
         Mhig==
X-Gm-Message-State: APuU4Z+9RQS8Db/OpL/7Bc2KhxcHYZFWuqra6+KTf+FlsyTIYcD0cuww
	bAZXx++LwFIfYYfWvcF9X0LhSSeudX4psxmIHkQHGlXJDEmb+yw4SiuRNlNijeBA
X-Gm-Gg: AYBFou0Yb2MQvHCjOSh8HvCjaxQqulAF2inB4jcAlcjqvQ3hRT24J9xIxyevYjXXmm4
	f70x5HAIk15T8yKtibazf9bIlo9M6zqCanYWk81eUKsWq23I65ENJtCtIgB8suwAElf6p2ExAq6
	P0qBH6S86DHELKDFO3gxii/M3bKbuRFc2Fe/G91VgRmEmM45tKMRrUKN0MKVrngaAfFxvFHI5VV
	7z1ncgGkYERE/12bbnSU0EbALI0bxTgj36ggnaKB7wiTvLHL+Hl0kQK21cS/3p3uN8fAG4cakU4
	jqsBScfxWDTI2jfIqYPfKH7/GwVrJutAvSrNbuRvlOxjIrOZFV/IfxEE4dn7A5HTvmeD6K3N8z7
	2DdJIAytCfeBCPEdKjKRmovrJs9bBqyLTnfjLsqaMg6DPY/Ywxibzlxohi5dKGMMQxYV3Qq68jf
	EqZfNoK33GyPFP3qiw1UXVbDr7BWUUCnQ1LYKSS2kYfXR+RqG8ni/1diHBK91ksUGcpr4SQxjOJ
	Q6OyAEYMBYUUgh4keKqVhgSTnNVE9NLaY5V8xOBVD3mPQQBDnXVeTrCdA4RQ6TifdQ6ks/oZCPr
	ORwaPGz2CWTZL33iy4nvhcD26h+govCSKtpg2pE8ooz0O2byh3w9SkzQksJyE6Kt2vyXzajpMjB
	25O5obj9kavLeSF8fqTSPMvQifHxzeam3JQYmxPv0lFqf3oqX0v4HhiG16LLXIsvu3vYWSGxz85
	xG
X-Received: by 2002:a05:6402:14c4:b0:6b3:b3f9:c418 with SMTP id 4fb4d7f45d1cf-6b4d428effdmr9322697a12.12.1793780732121;
        Wed, 04 Nov 2026 00:25:32 -0800 (PST)
Received: from desktop.home.arpa (2a02-1810-1e16-ac80-48ed-b9ce-6098-90a2.ip6.access.telenet.be. [2a02:1810:1e16:ac80:48ed:b9ce:6098:90a2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b55ac81386sm483243a12.29.2026.11.04.00.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 00:25:31 -0800 (PST)
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
Subject: [PATCH net 1/2] net: dsa: realtek: rtl8365mb: use IVL in VLAN 0
Date: Wed,  4 Nov 2026 09:25:13 +0100
Message-ID: <20261104082514.2139278-2-stijncleynhens@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104082514.2139278-1-stijncleynhens@gmail.com>
References: <20261104082514.2139278-1-stijncleynhens@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
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

