Received: from flow-a2-smtp.messagingengine.com (flow-a2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F43AB67E;
	Fri, 31 Jul 2026 01:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785461904; cv=none; b=k0S77E08EbVE9d9S+jJfJpccP+2ar0lu/VsIDIzC6FV6F81AYLi554dPY0klGEpo0bW5h5hwJOTR6qht2pYs85HoT/InygYt3SiKOe3S06awYwGVJBmGt3+cly+9ZC4az2jNLhjSxbM9U+vUL6qr2RwyT1a9GABAaQgdyY1wYxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785461904; c=relaxed/simple;
	bh=g/2KP0v/IRZNLP16+gchbBhlRL/ji+bSb/PFUnAAHSg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AW/6gogtMrzbr+3r4XBV786HtWveSympNe4weEk1XMwrj2miRhirshrinD9EcsjJadbFWVmLlpuwpd6hEsjXwujEeghSN4EQP44HDORonRXjejp6plHgkKC/xQy1VywI8T9zooAJUyDUjP3rZ8Hcq+E2PpbOtL3WhI7yhUf0mZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=YTPGhjU7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IWhXa0wd; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="YTPGhjU7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IWhXa0wd"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id B6E96138031F;
	Thu, 30 Jul 2026 21:38:21 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 30 Jul 2026 21:38:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1785461901; x=1785465501; bh=MnjeNo91OC
	vm0UJq12ftw5fTQhBWfVQJuzvJP6Veb6U=; b=YTPGhjU7CA6YV1wVARHw4TWd5u
	hZhBwBAGiKRrAT5V7u4og0C6RAV3JsXmKCnfo4neVj3CNYS3H8N46G6vIfRlhUgS
	ZqO+RgbXCwgWHw9oLFpCTvieAN0EfHK+/KMhZaqXkEzwkkkf2sfkH/SdzI+4Fp7D
	kGxvMAV+rUoeeeiu+wke2VVa76k13qaHuB2ETyzwu8o259Ijd0S6YJkmjQmIM1PD
	57KukiB8Il6WmZrWl2Fj31cvh+6Jek2aIVLY8sI2rBYI8n59zGuHh8i5kVUNBDYb
	ZWhBP1cfYn7tW6AGOW89aoKM/PKi1Usy+nZ5SU06usPYqQT6y8gaEO+rUvwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785461901; x=1785465501; bh=MnjeNo91OCvm0UJq12ftw5fTQhBWfVQJuzv
	JP6Veb6U=; b=IWhXa0wdnDGUSBjQtf+VaOTPl+pq4qiKg9+IaFGZc4nv9TOyhho
	JDd2ahrZezIaltw0Ay+3QXKfQL2AB0yYFeomXeSgsHBWt3somDCP4tHO8G3b9c+u
	10CgrYsyTjQ3cE7zTW8/v0tuSPDygyNLgUpSt3xKR9Haj/9hHW5Siw/AFEZhHhE+
	TajpC4TJQWReeUQeGWCN4wswkSyGetVptUTAcuJH6HrRhnsDasHfZ30Wf9zoTm09
	pjrZwPrCSSWaiXfg8DR+uPvPJwbLLSb4E0Y5tUYs2101aRn5D14dZCoLtxnXhr23
	l1cN9Gm39loZ+tMFHnkfrHKjxnVg5Hyg4Kw==
X-ME-Sender: <xms:i_xrauLlUKYDCk9ZoVA0yfAO1K8Ye4H93-NSSiEhkAjAvyh6K33n-A>
    <xme:i_xrakor2UbCxwcvCiYn2fzev2XJ8fhDcmniRXXnWkjkaq6tyTstsxvNAIpOEjkRL
    3y_PKiCRt1WktMtgpW9Z1ypTpqaXfNH6HViJe2Qem7sy1p6jnUjlOk>
X-ME-Received: <xmr:i_xralgGkNG2WthTC2sPXpqCqguqC9wNrpG8JK_pF5sBw0IJK5kGDch-3FrXq-0KqBtzNE7n3qP0r4KbymYo4RKZTsR51jwMgQTU5N1DzIK1>
X-ME-Proxy-Cause: dmFkZTECo8XnZE4AM1C6TCD3fMUlv9VVwm+1j3Fw0mN6tz9PYAhtnVsMxhzUL3k3YLWRnX
    MczmWAs3+kwTX0vW3auecvvcUor7eT0EtFu4/VSrrIlD3oD4D5XyW7DGuKdBPeTDtfX9gB
    iWZDNEp0nq3WbY14CH2W3aLY7izHGFM1AcmsQn6cyr/ld+OYK+9a1iCRWIoVkHxu527KjQ
    8Ne/MkS7TXenn+EThyxD1Gc5HmQ7xEGmlunJ2QkQQ5Mnan23eUP1eTAxXtV48/DaFmlx5G
    A8ADMFNrFwf0X8jhYMd6SCpMSpPcON1UskJhEdE0S6cnR444MdmV1ZziXqasV34KQkcGPq
    kQ1m3cT45JVDy4GzqwlWjMxxSjh3xYLkmAHAckoaIxXolfVkSAfW5NYNi4/X4rwloW5p86
    SjooGhk3caCuSFFkWPa/GqiAQ1FNo2QIcFcfYhtYpYYRwYf/v/kwIVk9WZlQJPGDMyZDQe
    0EZ0qqCUbFRi/AAJuKWiANtXAupWgcJTHd6EAPjipcKhWH+tWuYEQQy4IsNt/hlMdKjtXD
    dkddqdDEyvaltJk2Jq4RSkA+lsvYDnF43xOWuqdPGJjWZqiLSS8hyNVlK+5OJNryWhn7SH
    LppczYojR1/frMDbMSAq05qG0S+Rd1kY/0ySs9P7RlrCP80G4KDAtIXfCz3Q
X-ME-Proxy: <xmx:i_xrajYPjJqYHBx54KvgwoQU_1fZnQqyyyqHWINqwLM0N8rmA_Xu_Q>
    <xmx:i_xratk7FE2mKmKclL2vJ6EFGYgzHeYBkDsRmFXTDyeZhg2mrqIE4Q>
    <xmx:i_xrapzvppWOGePAkoYygTtfedj8DYm7HYUnEQvtQCdsFLb8hQicaA>
    <xmx:i_xraj8z1722JZIYxUiaYFhX4ehqaybwyYYFvMFDdc1Nv33-3_9V_w>
    <xmx:jfxranZMzO-hQCWcKe3tTr2bUakpfHzgZHvVHXfDyEcEaFQt2Y7WVhx0>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jul 2026 21:38:12 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: Frank.Sae@motor-comm.com,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	maxime.chevallier@bootlin.com,
	heiko@sntech.de,
	linux-rockchip@lists.infradead.org,
	attinagaoxu@gmail.com,
	alchark@gmail.com
Subject: [PATCH net-next v4] net: phy: motorcomm: enable the reference clock for YT8521
Date: Fri, 31 Jul 2026 13:38:07 +1200
Message-ID: <20260731013807.1488843-1-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 42310a24389c ("net: phy: motorcomm: Enable optional clock for
YT8531") enables the SoC-provided reference clock for the YT8531 in its
probe. The YT8521 has the same need on crystal-less boards but goes
through yt8521_probe(), so enable it there too. The clock is optional,
so crystal-clocked boards are unaffected.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Gavin Gao <attinagaoxu@gmail.com>
Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
---

Changes in v4:
- Rebased on net-next/main (Jakub Kicinski). The YT8531 clock enable
  landed meanwhile as 42310a24389c, so v4 now only adds the YT8521 path;
  the include and the yt8531 change are already upstream. No helper, per
  Andrew's and Alexey's preference on v3.

v1..v3 history:
- v1 https://lore.kernel.org/all/20260719034555.3623003-1-gahing@gahingwoo.com/ (YT8531; superseded upstream by 42310a24389c)
- v2 https://lore.kernel.org/all/20260727205602.1188008-1-gahing@gahingwoo.com/ (added YT8521 via a helper)
- v3 https://lore.kernel.org/all/20260728055659.1211459-1-gahing@gahingwoo.com/ (open-coded)

Tested by Gavin Gao on a PicoCOM RK3576 board with a YT8521.
 drivers/net/phy/motorcomm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
index 3396a38..c5a2cda 100644
--- a/drivers/net/phy/motorcomm.c
+++ b/drivers/net/phy/motorcomm.c
@@ -1065,6 +1065,7 @@ static int yt8521_probe(struct phy_device *phydev)
 {
 	struct device *dev = &phydev->mdio.dev;
 	struct yt8521_priv *priv;
+	struct clk *clk;
 	int chip_config;
 	u16 mask, val;
 	u32 freq;
@@ -1076,6 +1077,11 @@ static int yt8521_probe(struct phy_device *phydev)
 
 	phydev->priv = priv;
 
+	clk = devm_clk_get_optional_enabled(dev, NULL);
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk),
+				     "failed to get and enable PHY clock\n");
+
 	chip_config = ytphy_read_ext_with_lock(phydev, YT8521_CHIP_CONFIG_REG);
 	if (chip_config < 0)
 		return chip_config;
-- 
2.43.0

