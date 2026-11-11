Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434497;
	b=cPE22/rpF1LoYu6CrFp5qckj01wvSwKXbk5JugTDA+dKm3O+JkeBnk21J2WdCuEZoZd5
	 Q7VAfFphNBF1b7OTMPgIkeOF4Y/FCwZKzlUeirgnND1f1lEIEsqHcJyaAqkbQ4VXVXpOL
	 UprKaP+/OTiPWee4QfcLv477zZ2UnrERAoSdwQ0X4VMsvLV29pI8WrohT0cNdktr1s9dl
	 ssbSkXjKh0n4ehwVn1rLEMWB+qVOoymnpYHoOVqd18yT9Pm5Zi402gLNK1RRQIdi1Wb2S
	 62DdYFkhK0d5ogU5x7/dKSkdBQaZ4PFvoX8rla5uphAW57XHf332CJIpc9DKmhyM8pA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434497;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=aGRCzrOyLm5RcQrXArj7+bIIsdtxJpzMcLjLki4ZcpA=;
	b=0HCuLk7ut0s0st9/gNsGngSIG0x4JZk5+a0HA9OrElS2BocYiSr1AnPezPuZxSuTQ8Wu
	 NAlkHv0JUkP0P9OszHAmKee7TwWDL8XkEinYihhbHKhL/Qr+qTYngMQq1BENbTlnP5L/U
	 VgQ+rOrCimsZdslts7Qr5nt5jQ5BRUblbo5OLKnCpAnyjXH6rqrsM/3kzrF4HU4kojc/w
	 nJfWTakOyugXioI+kSweBD+5FxbPbUp8soiW7EYQIiHfUxkjKuUsluMQl5bdUbLuK+1be
	 yHSpItNJ7urDsl9O/3hJnPTUBZ/SNWcuOnjhjJY9NrRFdAhGJPMeh+O0InXacS+Gczw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GcXgxU1T;
	arc=none smtp.remote-ip=209.85.221.175
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B781606B34B
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 22:01:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B781606B34B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GcXgxU1T
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5ec20398b05so2108220e0c.1
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 14:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794434496; x=1795039296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aGRCzrOyLm5RcQrXArj7+bIIsdtxJpzMcLjLki4ZcpA=;
        b=GcXgxU1TEaoOwaQ7FaxKHoS5/K0blKwcO56rckk9IDy3SjnQHN3Iw50VBqitaHeg7y
         lgkgpGefeWc+bcvNEPmTDesPRvuz3qAL6pJ+xUI6GRDwZwPXrR+X9/mZ6uvLRQ8i/FE0
         SOVhNtRg07R3g/sKIqXh+BcByQgtKnyNgMIrlsBRIJq+MpwZM79DNBOZfNgasvRuXvHU
         CRsUb1pODK+FvcUbtvembZdiH06na+XlvqjfCb54SF8T3N8Y7lGxeNBikZTHFizpzPlY
         7oKDg85rgh7JMpclRR4R5y3lPDfv5nvnrS2R4+LtfIr90uAZosvQ0Wfmla/FhvqEROLB
         cbBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794434496; x=1795039296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aGRCzrOyLm5RcQrXArj7+bIIsdtxJpzMcLjLki4ZcpA=;
        b=tx2ImQV8Orv7rEfZfYnZICW+UqHtYs9MOyMq3VyoL1yFVbn9mVOW8oGlc38DVyJejO
         9hNwLTkAryRQqThjJNQFGkv/iBKrIN3e2Zgh/uBDV65riK8oo80MKf/yUI/pM7VjSlJw
         zru1d5kebGa4yrfymNFfNEyBe7qGl/KlLs9ZMWF17djArhlOMiAWARV9e++1BGYssNgm
         GhhfahftCnrBIiInBcn3iUTeugDIEdzB4wWdZ/R+NI93R/qDf4RrT7Vx/JgMyfDZMzxR
         XaV3QSVrnOD/6V0lcXwT/ch07SAh8zuyk8yn+Rdmue8sSGR+KH1rAerOJgp/A73rNMdR
         hm6w==
X-Gm-Message-State: APuU4Z9opgNf2K4AUvLpDDlkt/4oduQaKS/BL0RP8HBfoVjTN20oghod
	kxCMhGPz+82Ym5t+icXHv5ROHgQiYPvQbiw7ilSQkw5hby4xpwHmyLQP+lz8Qf8x/6h3
X-Gm-Gg: AYBFou2ciAZo8ib2/tK27BTIS4DsaTEg8HReaigQv69VdsTJznFv9W0brGgnV9P4g5A
	3LkWv6DFTTQXEyjpcCjeqxx++xjgd2AnY/KU4RC4PZPhk4RTHQ7HbyIyE0hdAZ4Apk30NpJOe5q
	rXh8zhNgErie1pCClnEV7I4TchgvK4I3GEqOFbWopONPYkW99i3Oa12ZyCJ+80WYd1qshZjjybP
	OReJrUZhIhnGCMHa6VhLE22+LwdUYJyomLEmi2Kxukx/6YKD0/oss2Gscmo0WX99vki3vOSJoOn
	ChNd7nsbv4oxSrigeUxYvcInDE4gKA4JQBWkBkqrPcwukx0D2DPKYIqsgEQdCuhp8NFHF7fbZN6
	L9jIJ3m3QvMJr3d4cy+XKCcsLedVrfw1THHG1A3VN2Nt6YIRwM1JzrdW0KR0HSMjydjGB1HoRjZ
	goZibyhTrsalcVmF5JsP+TRZlguuUrd8IPbBaljQ3Gwnu9Zct33RoPlVr7B4yAHaKfkGtQ9hwOA
	LbcOaMKfr1nnDofImHwyumZPaCSQQGMNzjEEkNHcyE1cHKXscuOzas5NWqDFPXVBJOtYVXXeYJb
	34nH3P7kSwtsXvQpifFRTYwyhM5O
X-Received: by 2002:a05:6122:1d12:b0:5e9:176f:a548 with SMTP id 71dfb90a1353d-5ee1bf5e39cmr1711028e0c.0.1794434496006;
        Wed, 11 Nov 2026 14:01:36 -0800 (PST)
Received: from Ixchel.lan ([70.49.63.180])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c1fffe63asm4557992241.4.2026.11.11.14.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 14:01:35 -0800 (PST)
From: Vlad Banea <montrealtango@gmail.com>
To: netdev@vger.kernel.org
Cc: hkallweit1@gmail.com,
	javen_xu@realsil.com.cn,
	nic_swsd@realtek.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org
Subject: [RFC net-next 5/5] r8169: enable RSS on the RTL8125B
Date: Wed, 11 Nov 2026 17:01:14 -0500
Message-ID: <20261111220114.3863505-6-montrealtango@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111220114.3863505-1-montrealtango@gmail.com>
References: <20261111220114.3863505-1-montrealtango@gmail.com>
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

The RTL8125B has four RSS queues with the vector-map interrupt model:
RX queue N on vector N, TX on 16, link change on 21, and at least 22
vectors. RSS requires the type 3 descriptor. The RTL8125A has neither,
so enable this for RTL_GIGA_MAC_VER_63 only.

Hash on TCP and IP only: the RTL8125B does not spread UDP flows by port.

Signed-off-by: Vlad Banea <montrealtango@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 27 ++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 85e2c03fa61d..a313216998d2 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -78,6 +78,7 @@
 #define R8169_TX_STOP_THRS	(MAX_SKB_FRAGS + 1)
 #define R8169_TX_START_THRS	(2 * R8169_TX_STOP_THRS)
 #define R8169_MAX_RX_QUEUES	8
+#define R8125B_MAX_RX_QUEUES	4
 #define R8169_DEFAULT_RX_QUEUES	1
 #define R8169_MAX_TX_QUEUES	1
 #define R8169_IRQ_DEFAULT	1
@@ -880,6 +881,13 @@ struct rtl_vec_map {
 	u8 max_nvecs;
 };
 
+static const struct rtl_vec_map rtl_vec_map_8125b = {
+	.tx		= 16,
+	.linkchg	= 21,
+	.min_nvecs	= 22,
+	.max_nvecs	= 32,
+};
+
 static const struct rtl_vec_map rtl_vec_map_8127 = {
 	.tx		= 8,
 	.linkchg	= 29,
@@ -1835,7 +1843,8 @@ static enum rtl_sfp_mode rtl_get_sfp_mode(struct rtl8169_private *tp)
 
 static bool rtl_hw_support_rss(struct rtl8169_private *tp)
 {
-	return tp->mac_version == RTL_GIGA_MAC_VER_80;
+	return tp->mac_version == RTL_GIGA_MAC_VER_63 ||
+	       tp->mac_version == RTL_GIGA_MAC_VER_80;
 }
 
 static enum rtl_dash_type rtl_get_dash_type(struct rtl8169_private *tp)
@@ -2965,6 +2974,20 @@ static void rtl_setup_rx_params(struct rtl8169_private *tp)
 {
 	tp->num_rx_rings = 1;
 	switch (tp->mac_version) {
+	case RTL_GIGA_MAC_VER_63:
+		/* The UDP hash types do not spread UDP flows by port on the
+		 * RTL8125B, so hash TCP and IP only.
+		 */
+		tp->hw_supp_num_rx_queues = R8125B_MAX_RX_QUEUES;
+		tp->rss_data->hw_supp_indir_tbl_entries = RTL_MAX_INDIRECTION_TABLE_ENTRIES;
+		tp->rss_data->hash_types = RSS_CTRL_TCP_IPV4_SUPP |
+					   RSS_CTRL_IPV4_SUPP |
+					   RSS_CTRL_IPV6_SUPP |
+					   RSS_CTRL_IPV6_EXT_SUPP |
+					   RSS_CTRL_TCP_IPV6_SUPP |
+					   RSS_CTRL_TCP_IPV6_EXT_SUPP;
+		tp->rss_desc_type = RX_DESC_TYPE_V3;
+		break;
 	case RTL_GIGA_MAC_VER_80:
 		tp->hw_supp_num_rx_queues = R8169_MAX_RX_QUEUES;
 		tp->rss_data->hw_supp_indir_tbl_entries = RTL_MAX_INDIRECTION_TABLE_ENTRIES;
@@ -6236,6 +6259,8 @@ static void rtl_set_irq_mask(struct rtl8169_private *tp)
 static const struct rtl_vec_map *rtl_get_vec_map(struct rtl8169_private *tp)
 {
 	switch (tp->mac_version) {
+	case RTL_GIGA_MAC_VER_63:
+		return &rtl_vec_map_8125b;
 	case RTL_GIGA_MAC_VER_80:
 		return &rtl_vec_map_8127;
 	default:
-- 
2.53.0

