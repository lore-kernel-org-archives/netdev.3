Received: from mail-oo2-f39.google.com (mail-oo2-f39.google.com [74.125.231.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168B53CC300
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 22:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790546417; cv=none; b=QdYe5qv5e/F8ehFY7h+fr1KiWozbsv/cc6lha/j9cg/3UYbFUpdU2S0CIkFASBVcxlLeBBG71sJzRcGTe4vl5HscnPGAb7k2r9qbj/jqPc+YrwsGJSkqlTXqMkj4/rybWiKiVvXbI+tIaM6SR6SgIibKL9lEVCf1Ad+SZbZ2FeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790546417; c=relaxed/simple;
	bh=gVk5Yp0fa5DC+JmIN7hJNs0tuRiH76TK6U/e7s2AWcU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g/O7npqUDhk1z8NB+ZnmXBPVeuOncIs85Bv/vpA0Jb6E/9eVGtcZX5JUPefR0HbBgOxFLLEMoV/Lq8SOsz9npHsdnty5sWxUArfg8clWvFZ0ojgGcTgVwQ3DTEPZZY4pZ0KdQ9lxGHkyPVEICXoZl9UKBbELH51Km4TnqJVBZig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eNBASeX4; arc=none smtp.client-ip=74.125.231.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNBASeX4"
Received: by mail-oo2-f39.google.com with SMTP id 46e09a7af769-80a6fbf797dso719933a34.0
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 15:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790546409; x=1791151209; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9cINQWWverkhRH4suCO77K0cLfNkdgj2lkVHlOLl+dU=;
        b=eNBASeX4zaB5bjKWwvhnEx2OlAPVLhGsQ5duqSjGt7PlpnlTCPenimPcA8OANXsIS6
         lzW/v8qWWNbDzpZa4wTGhpTpEB3b3lRus1Y9u6pWRwnz8aOPvQ2wUtACBiMUrwr515VT
         5EXM/h9Px9nxGGT88z7YDRZsGrltBhEgCkIqr+EZjDGuh+145UI0Us+hKBOU52/Qi19Y
         0qXNe00frLddsu0PkzpowZH/ydcO4K5m8Pq4+FN3bNLJZZBgIY0XnHKom7ryNjrL3f3q
         5nAgxSTw7kVKpLxM2puSiOXzKvHEqNeb4JG43OaS7kwQTOGNwUcATwvVKsnljrOkLXDx
         g+fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790546409; x=1791151209;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9cINQWWverkhRH4suCO77K0cLfNkdgj2lkVHlOLl+dU=;
        b=RnmIDqlQAYuFsYdo4VUBrj80t/gPOwEu6HCYEBBCcdVBTTwbmrVaGuaMQwBXZkSwEC
         MvNZD6vTDQ58eUR5H3sQmkyhqMw8r717/t6bn3M8jLSxwY0I/xG2k/abdH3UqUNb9VHx
         vjqGawB6bwQK5JGU80byOLR4LN1yfv/K3NhgVENmlW2n9kc9Wex4yngnm7Ftr64G0/vY
         LDNtEwx4GCV/Ai9F2caQXqyaRyVkIDc4TjhSQDETFk3o69yKlxb74bfVnVE4mohA4Bsl
         LvgtepyAvDHI7ojvn2RcXjzjtfq4qmpI8lLXZegvm7bBTCnm9/JgyKrL+h7M1Txnjm3D
         h5jg==
X-Forwarded-Encrypted: i=1; AKwUvBx6JXAQ4nGANeDqwe8GpGdW6p29olfat5cn4Pvh9f+kQu7a+foBkKDWjIzah6W5CZQBhTIl+K0=@vger.kernel.org
X-Gm-Message-State: AFuF++l32/Te5Yg/OX3n3efKfBVGjBPwISawF93tTnKezHhNeNKkFpVC
	kLop1E9+YQg4ESBGhscvl/BYcRepALKL+2ey2zBOn18d+bGmGmffhORk
X-Gm-Gg: AYBFou0O7frROoqMCHlgWIaObIATHzGLcUwtoLfz6JX91VmwzmsseRBR3Xl+jh3XSQI
	WTrkC2ZEVTpwEeIgfWcbkhanbKhLKE7leAT1YPJ1bF221Byy1xwfPgDb2/mAqM1aCHucqu/ra0s
	Mv8xPB0NiJxfFXiClMoRKx1Cp05qMrZr9pSncar5QKfS3V6coz2+zYcnCakKVBFCVUXngdS0q4R
	y067pcuzCRfVJ6v8LDt13U9Zxo3gvh9i34NUF7hAu7/EhmyaNExEu2NoFjX3cGa/SFTU2SeoQML
	7Qn3DmGMbCtDghNERAmT0IGqo+SP/PwvvDsgZnmZLrHjfY7MImXobdc6StFkW2Xl0Dbqxfpii2T
	zAs3L8nDmzxw5duWgEVREoPhaEeE1vnMEVlb8MdXq3k7TlxHGhK+F07CqjNpChTJgTNH5QmyUZV
	Ie5MoSV+OoOoDdI4q65YBEeXUFP/3J0izJBDUL1kuSswdIUnvre5rqYtUj7dRBTKA1dSYAYGkV9
	2PW9bRVLXTS6IU0bRMCZjRyJLvPq3GdxzxBmMNOWEDhXopOUc2jG4UHZNURSmcL4TgkdfyzZuPj
	haTXDqbyYdon2qqY+5a7Q+goj2wt53WypwydA/aMQN34BRag2c9UbvQzdYGbTrSsQQVQqwprU19
	Sc6m4F4xdfcQJjBbg1m3g
X-Received: by 2002:a05:6830:6d11:b0:81c:a8c5:6380 with SMTP id 46e09a7af769-81ca8c566f2mr813463a34.5.1790546408844;
        Sun, 27 Sep 2026 15:00:08 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-81b3de6f7e1sm4874147a34.22.2026.09.27.15.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 15:00:08 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 27 Sep 2026 15:59:44 -0600
Subject: [PATCH net-next v5 09/19] net: stmmac: leave the datapath running
 for normal-size MTU changes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260927-submit-stmmac-reset-fixes-v1-v5-9-feec6c14dd06@gmail.com>
References: <20260927-submit-stmmac-reset-fixes-v1-v5-0-feec6c14dd06@gmail.com>
In-Reply-To: <20260927-submit-stmmac-reset-fixes-v1-v5-0-feec6c14dd06@gmail.com>
To: Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Tiezhu Yang <yangtiezhu@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Serge Semin <fancer.lancer@gmail.com>, 
 Suraj Jaiswal <quic_jsuraj@quicinc.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Joao Pinto <Joao.Pinto@synopsys.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, 
 Ong Boon Leong <boon.leong.ong@intel.com>, 
 Voon Weifeng <weifeng.voon@intel.com>, 
 "Song, Yoong Siang" <yoong.siang.song@intel.com>, 
 Linus Walleij <linusw@kernel.org>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Magnus Karlsson <magnus.karlsson@intel.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Simon Horman <horms@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Jose Abreu <Jose.Abreu@synopsys.com>, 
 Yao Zi <me@ziyao.cc>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: Richard Genoud <richard.genoud@bootlin.com>, 
 Alastair D'Silva <alastair@d-silva.org>, Maxime Ripard <mripard@kernel.org>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, 
 ZhaoJinming <zhaojinming@uniontech.com>, 
 Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>, 
 Ding Hui <dinghui1111@163.com>, Linkui Xiao <xiaolinkui@kylinos.cn>, 
 Linkui Xiao <xiaolinkui@126.com>, linux-tegra@vger.kernel.org, 
 linux-sunxi@lists.linux.dev, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

Changing an MTU at or below ETH_DATA_LEN does not change the receive
buffer size or the MAC receive limit when the previous MTU was also in
that range. Do not release and reopen the datapath for those changes.

Besides avoiding unnecessary hardware resets and their failure paths,
this keeps live AF_XDP pool bindings intact. Preparing replacement rings
before stopping the old rings otherwise binds the pool to a temporary
RXQ and consumes fill-ring entries while its current RXQ is still
active. XDP already rejects jumbo MTUs, so all supported live XDP MTU
changes can use this path without preparing replacement rings.

Keep jumbo transitions on the existing reinitialization path for now.
The later ownership and rollback changes address that path separately.

Fixes: 3470079687448 ("net: ethernet: stmicro: stmmac: permit MTU change with interface up")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index a8e5e86e0ead..d9d676ae1c82 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -6212,7 +6212,12 @@ static int stmmac_change_mtu(struct net_device *dev, int new_mtu)
 	if ((txfifosz < new_mtu) || (new_mtu > BUF_SIZE_16KiB))
 		return -EINVAL;
 
-	if (netif_running(dev)) {
+	/* Normal-size frames use the same buffers and MAC receive limits.
+	 * In particular, do not disturb a live AF_XDP pool: XDP does not
+	 * support jumbo frames, so it never needs the ring replacement below.
+	 */
+	if (netif_running(dev) &&
+	    (dev->mtu > ETH_DATA_LEN || mtu > ETH_DATA_LEN)) {
 		netdev_dbg(priv->dev, "restarting interface to change its MTU\n");
 		/* Try to allocate the new DMA conf with the new mtu */
 		dma_conf = stmmac_setup_dma_desc(priv, mtu);

-- 
2.53.0

