Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434495;
	b=i7G45KkiOHdmTUd2K7/jFP6lCe2nq6o+Kzq6rI1XYYIXBjK+CTdyLPbg3RhD9YxPIqbj
	 uFf1CnF3XHekQmIXa/35JrDA8IfKW7sqxxF7zW3gYOF96sNDe42zxOtT80l/5ax0g2H/n
	 FxRYSeTZ6p2r+L75G6ImM8La+0Nc0a7KGZ8vQICE5qXbs8WFWCV7U3Ka6yAX6VCljTK+R
	 la8mv4YwfMmG7dlYklCI2Zgd9g+EngIQ7LMgRbGpowAzwtUJfIZnl27VRaz9JOa+XAve5
	 K63cc0kv825C1w18dkmxOYT2I+naVlqHcUC8nm4t++DjEcGvaS/BfSpEHiIK8dK4QMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434495;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PN800ywekWk9XeZU1A46yK2GvDU4OTLmLYi6Rpi1abk=;
	b=MMBq+mddwkYw5xYFyE0K/amZ9j1SI61ArYw5Lpnv2hedMbBHNDGThxMlGuYEQQOWzl5X
	 xini7GdPVc5QBA9/2I+VZMGxoa2xxocnQFOEI/15/2dJlDs7FvrSVcDstuwduCLGI6RYC
	 HCobI+kX6YJH/iZH0SBh2synmC8rX76vyA5CHhUqbFWc5p4z+Cd90X3khy1rUsFme/uXf
	 5EJwZy3FM9QiWzPJmB7VyqLJOUF3Exr7tpg+h0LwFwaNaphA8hOX7zG+aFBXuuylZqpHx
	 pXKabrwItMiK9dSYFt5eo4A31kCOR6Cf3qTOVyqBJQM6RGXeaNBel5a+XLuEMOjJ5Jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Rl+Mh9+m;
	arc=none smtp.remote-ip=209.85.221.169
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D7260A3807
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 22:01:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16D7260A3807
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Rl+Mh9+m
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5e9528732b4so2265753e0c.0
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 14:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794434494; x=1795039294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PN800ywekWk9XeZU1A46yK2GvDU4OTLmLYi6Rpi1abk=;
        b=Rl+Mh9+mXU3EKkMv5CtlZZ8HRUvdg1jNFjsPEN0uJUJ+jMwCKivCIqN8sNEvuPhQRV
         QcbaJJCIk/ePxDM0LP01+iJrIoIFGQ/0VpI0ARDxHbkeIsibUyivY/4BmLjBymUIPLl8
         kT+euTSiEcyRLWMZ2uatL8/flVYaFUueTc36wi2nJXrRgss6tv5IhPSz5vQX5ZrYUfi/
         8kcXssqoySRzmGdjC5bp0nXKO8x2RDSy6CtqGM2/4ycP2NY5NkYa+5gjx6KrwVu2oyoM
         gWCet2LY9fdGUUNhSZdEo0saHVBLMzRDi3zV/1Y1w0d3DJHHhSBvXMlPp6X5CoAsGHxs
         f9Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794434494; x=1795039294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PN800ywekWk9XeZU1A46yK2GvDU4OTLmLYi6Rpi1abk=;
        b=VQdHD1L8On9H5llw3/Uiq+TCUxma/l0AezlCiTBLrvoODiERm6DsHJxBVQ8SlPUibV
         javnuXZlzlDYhVIvodLzHKGiZW/G33XLDKF9wp8AcC1w0l1B34P6gB+miS0NzoZrp9b0
         dabbAc3T23fdsIa9liVsgey+6gO0LuXCkdv2oRxzmMNsUPgLR7oTIpHO38mUOxr1S2oC
         P5xcmDhNWNj2LIr+rWCJX9wxopqR+tA8dUgXrtn1Gx85OX9yNE+dw9EZROI3PR/dJtUw
         ep1yl2xAfDBBQf8XUb54Ze3ICh3kGusccOM4RuYpzx0H8wab1HW6ARIKrj9sVprUWV1F
         UIHg==
X-Gm-Message-State: APuU4Z8UUWhFO/Qp6y/5XbUpTW8P5aITmH0z/IrCgVSd8ORMAcdBY8dC
	JUtO3ybqLV3sdLW2fSGGvvkIAGq1+oKhg5lHKF3e+yEUz2MhDU4xZHBngk4cA521L+xn
X-Gm-Gg: AYBFou3nF4s+lI87OWcVOmTHxMf3YSGiF3XTw6G5Ox7lL5Jyb0ZdriBXLFfjecWg/kb
	qiqgYxAaEHd93yNkyzGedQrPGtd+y1VNmw6nU1lb6kpleG1t6hiA9hsiAniLIFKUaU+nlFSOfjl
	HeXk9b1upQygN/B7j9SJtQwE1fEk3WGQumOu+tiqolUCAQlYZ50IpnG5hDQIxzzkIkkmve3YtwI
	PbCy86XGMREc1k87QufpWt50e2Xr8d3uWDMB5na+9D0ad4xK3DltInSM6gltuYw4bHwzA6FtEfe
	tRteJlJ9WyrNgLRuYXxJjmGKAQKRki45+vh4fS24AAQC+RpuX1E9eGL1of6rHTQtdu3T1tCqh7b
	dZOoQftylk9qo+BMoImuUG7NA6tqM6Q+Oeb4ypLH/oFuIWeN/BCrjE6e8Xn9t2FXjCLaaHo5i2a
	hs7Nt1UYRxVMze1bDJG87lX1qf8msu6Z+P1/Ft3AxoSMGwOd5vBqqBeDUk2NN0F2fIw5Q5Fcwxi
	bkqRqeM/3Iim52FPBQdCJVtG8rOEFeUy+A3setHliGKKqmBUJoohZ9+X/AEEfOqMZ5x/BuBfYRq
	DBJzEdx5SRuDrT8ffCoVYCugDPlz
X-Received: by 2002:a05:6122:d25:b0:5c7:fbb5:6ea0 with SMTP id 71dfb90a1353d-5ee1c3e566dmr1829463e0c.4.1794434494109;
        Wed, 11 Nov 2026 14:01:34 -0800 (PST)
Received: from Ixchel.lan ([70.49.63.180])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c1fffe63asm4557992241.4.2026.11.11.14.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 14:01:33 -0800 (PST)
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
Subject: [RFC net-next 3/5] r8169: make the RSS hash types and descriptor type per chip
Date: Wed, 11 Nov 2026 17:01:12 -0500
Message-ID: <20261111220114.3863505-4-montrealtango@gmail.com>
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

The RSS hash types and the RX descriptor type used with RSS are those of
the RTL8127A. Make both per chip, set in rtl_setup_rx_params().

No functional change.

Signed-off-by: Vlad Banea <montrealtango@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 29 +++++++++++++----------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index a77bbedc8c02..cc253728109c 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -858,6 +858,7 @@ struct rtl8169_rss_data {
 	u8 rss_key[RTL_RSS_KEY_SIZE];
 	u8 rss_indir_tbl[RTL_MAX_INDIRECTION_TABLE_ENTRIES];
 	unsigned int hw_supp_indir_tbl_entries;
+	u32 hash_types;		/* RSS_CTRL_*_SUPP bits to hash on */
 };
 
 struct rtl8169_private {
@@ -884,6 +885,7 @@ struct rtl8169_private {
 	unsigned int irq_nvecs;
 	const struct rtl_vec_map *vec_map;	/* NULL: single vector only */
 	enum rx_desc_type init_rx_desc_type;
+	enum rx_desc_type rss_desc_type;	/* layout used with RSS on */
 	struct clk *clk;
 	int speed;
 
@@ -2906,6 +2908,15 @@ static void rtl_setup_rx_params(struct rtl8169_private *tp)
 	case RTL_GIGA_MAC_VER_80:
 		tp->hw_supp_num_rx_queues = R8169_MAX_RX_QUEUES;
 		tp->rss_data->hw_supp_indir_tbl_entries = RTL_MAX_INDIRECTION_TABLE_ENTRIES;
+		tp->rss_data->hash_types = RSS_CTRL_TCP_IPV4_SUPP |
+					   RSS_CTRL_IPV4_SUPP |
+					   RSS_CTRL_IPV6_SUPP |
+					   RSS_CTRL_IPV6_EXT_SUPP |
+					   RSS_CTRL_TCP_IPV6_SUPP |
+					   RSS_CTRL_TCP_IPV6_EXT_SUPP |
+					   RSS_CTRL_UDP_IPV4_SUPP |
+					   RSS_CTRL_UDP_IPV6_SUPP;
+		tp->rss_desc_type = RX_DESC_TYPE_RSS;
 		break;
 	default:
 		tp->hw_supp_num_rx_queues = R8169_DEFAULT_RX_QUEUES;
@@ -3066,14 +3077,7 @@ static void rtl8169_set_rss_hash_opt(struct rtl8169_private *tp)
 	rss_ctrl = FIELD_PREP(RSS_CPU_NUM_MASK, ilog2(tp->num_rx_rings));
 
 	/* Perform hash on these packet types */
-	rss_ctrl |= RSS_CTRL_TCP_IPV4_SUPP |
-		    RSS_CTRL_IPV4_SUPP |
-		    RSS_CTRL_IPV6_SUPP |
-		    RSS_CTRL_IPV6_EXT_SUPP |
-		    RSS_CTRL_TCP_IPV6_SUPP |
-		    RSS_CTRL_TCP_IPV6_EXT_SUPP |
-		    RSS_CTRL_UDP_IPV4_SUPP |
-		    RSS_CTRL_UDP_IPV6_SUPP;
+	rss_ctrl |= tp->rss_data->hash_types;
 
 	rss_ctrl |= FIELD_PREP(RSS_HASH_MASK,
 			       ilog2(tp->rss_data->hw_supp_indir_tbl_entries));
@@ -4272,11 +4276,12 @@ static void rtl_hw_start_8125_common(struct rtl8169_private *tp)
 	    tp->mac_version == RTL_GIGA_MAC_VER_80)
 		RTL_W8(tp, 0xD8, RTL_R8(tp, 0xD8) & ~0x02);
 
-	/* enable rx descriptor type v4 and set queue num for rss */
+	/* set queue num for rss and enable its rx descriptor type */
 	if (tp->num_rx_rings > 1) {
 		rtl8125_set_rx_q_num(tp);
-		RTL_W8(tp, RTL_DESC_TYPE_CTRL,
-		       RTL_R8(tp, RTL_DESC_TYPE_CTRL) | RTL_DESC_TYPE_RSS);
+		if (tp->init_rx_desc_type == RX_DESC_TYPE_RSS)
+			RTL_W8(tp, RTL_DESC_TYPE_CTRL,
+			       RTL_R8(tp, RTL_DESC_TYPE_CTRL) | RTL_DESC_TYPE_RSS);
 	}
 
 	if (tp->mac_version == RTL_GIGA_MAC_VER_80)
@@ -6142,7 +6147,7 @@ static void rtl8169_set_rx_ring_num(struct rtl8169_private *tp)
 		tp->num_rx_rings = rounddown_pow_of_two(min(rss_queue_num,
 							    tp->hw_supp_num_rx_queues));
 		if (tp->num_rx_rings >= 2)
-			tp->init_rx_desc_type = RX_DESC_TYPE_RSS;
+			tp->init_rx_desc_type = tp->rss_desc_type;
 	}
 }
 
-- 
2.53.0

