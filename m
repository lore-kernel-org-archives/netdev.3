Received: from flow-b1-smtp.messagingengine.com (flow-b1-smtp.messagingengine.com [202.12.124.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE732D7DC8;
	Sun, 19 Jul 2026 03:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784432809; cv=none; b=Gj/Jxo0t8K+O6NDGDez2rxdCD1sNsiiKo18aHR3jx6zKch8A5c550Z7E1sEL9BXtkXMX7+kxsZGvF6wx6YNQI7bhdwGYavCqRBb5dN5HrQuybd5qXXfZvb40K2Lyjn7UvluX8wv/reM0fBKOxp3UIy0DoJfpJ38vd89qAp9oZmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784432809; c=relaxed/simple;
	bh=1H8JbL5ZiH143JendG6AvLojn/94HkrnSgvjOpiDlIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=skibX/A/fjJzu3FeqwoZb/Y3Hp/k22eFFNcPtrO1Qy59dxTnongk5PC6wl9FM500NzmScYDfPsFwIknuOFH/40cGQ122qtmhQsF9QfxwIX09gZFK5T7HL+xgDWrrnaxhaesNjL8cso3W7k2SHjhl0VcE9tNCQcDaw8ZrY73noI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=Z6Vsg8Ow; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KsacrUQn; arc=none smtp.client-ip=202.12.124.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="Z6Vsg8Ow";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KsacrUQn"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.stl.internal (Postfix) with ESMTP id 28CF5130009F;
	Sat, 18 Jul 2026 23:46:47 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Sat, 18 Jul 2026 23:46:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1784432806; x=
	1784436406; bh=OHtgDO4iANSGYS0dotrlCjZ5i/qoruq7hbwefKWAtmg=; b=Z
	6Vsg8Ow3IirzzCOQkLKWzA/oD82GWIZ8RlDp9ZVzq7z1XwRefjS+akcRuZiJyVMU
	OWz3jlyTb1GJyY758J54cetuAU7jHlGd2jU11rgFFvujlsl1bmAB9E+chpQpvQ4N
	yNipPcceI2aHAhbjcXWOORUjReAqkHe4Pty5Bjoh6Ctfztyyu2ZufAio7snYxLw+
	C24dsZL/Xqm9el0hzAwKbiMSqNRNmi+oYO5ezvu/mtTrYd0/W7LW4/1kpKaKYhQh
	//NWQYQtW8Thz/aJcUfl1oERdpP5GVjmWG5AbXS2c6tl4zOUuELIibqiPtbqXme9
	oMy9mNU5jWHDZGW0nCzmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1784432806; x=1784436406; bh=O
	HtgDO4iANSGYS0dotrlCjZ5i/qoruq7hbwefKWAtmg=; b=KsacrUQn4eF/zW455
	Mm65KRH9BkQdNzri1dIxORKcgVmaW7+D8FDdbcRzcdLhuxUDXXidnHhbHOIiefF9
	p/n3HYrM+egkByzmCQLBBTbFDlvs3Pc2xDsJBW+jlObk7DO703yqC8TU9n2Sd21Q
	2vYBVIWqOS4hKB7/OAVvLRwNegeGfBVmGNdAvcqhglaI4kWDUhAiAz0JXca9F+AD
	UBzECGF1bP2OUhxhhMqDGnP/H6oHivWJDamx5e1IK05YOrGkxSk1IHzMcOdcthSC
	BbTCrklzjhy784OGQ2m5lx1tBPQgBf+KDVhraIHOSdf9YGAe9LQulUUfokYO1J/j
	wSRPg==
X-ME-Sender: <xms:pkhcah2kV_nEp6kd4TotHFKzfwMRk4EN3xEs8SaeKsY0GuszaVJaZg>
    <xme:pkhcauds6aote_O9_Sj2mK39_TSNU-HtS-q_zYEO4hXBlYAJPE74-c-MI9-GEEVWy
    8tOoRlYBeUD7egHgSus9VZmGnQ-IeAMKef7MQEeXd6uzPUMadOvnD8>
X-ME-Received: <xmr:pkhcauIJH7F9-IN4zEprZoaXTBstpl2k8ttMuDqVKQQGDs7oQG5DdRWwZoTNMbpLAYfzKZBqzl32AH1pKyE>
X-ME-Proxy-Cause: dmFkZTEvqSoJQqnPvukA/0nUn+XxJpYTlQNqXc2syNunyqumVYApwogtjNKdZXBpfO8rfR
    2Jx9JWiQHq2J5RmDUNfmbiSy7usanwZFiMdgwJ2HFO8oSvpsoMVUC1S7AfuWMXX9S4I0wK
    5sBL/nJc1wAe+EOGyIiJ3+1YF5WnPBu7Az9KD9wwDOjxFoeCuBSLONC1xQ/IDpqZZASB3i
    9aFIr9Y/79Hz1Vw4/wx43mF7b6lG4Xdmr3Qv+xi8VT374sGoR0MR15sTySeCXiHMBr56eK
    BMsIhNpmLtm3HXQXTdxlBIws6XSX0UisPcNoyzVJduslnTJDNWaprHMRJzqSkV4N2LisXI
    da9fUmFx6/KR9ZMe3ZBM18y+hf1OXvDZ8U4U6wC6YJleQ8hv9VSEnRVVsc4/9jg0t1LGCh
    116u9bE7sbcMUukrtOCYzOzsqIRNQG3ZBeBSMy33OYZA0B8JIdKvAngV+DhCA2RqfHGnUX
    cIeh8xMElXFdcUQR575d59ITd6Hel2TG52jAEiwcVi7/4XYGoFUILBxJUQSd5k3CkMaDxq
    uO5sh8ftqHGAVIfkYaJ8DEKJB19JbLZ1x0ucib5madw/lMTnovz4hocb7LyX8hw7ZSGxB+
    Hyn06azB0myWgSSfmA0CokdHWz0qYuwejw7VBZSsaF3mNo7nmzgCRxsTHD7w
X-ME-Proxy: <xmx:pkhcasrg3co0Ohm9gvmunatMLX0iddoyRKh61q6Dl0uAMewAnNYrQw>
    <xmx:pkhcass8kLcA2302yol_YRtDC5EqELNDih43Eas73u4-PVe0zL6wYQ>
    <xmx:pkhcamKQ1uFUFOjVO18x1VKOaehrS4rGuvKt0WJxCGM0H-2zx76O3w>
    <xmx:pkhcarpoWX7ibiSbui233ne9vBuBd1cj3BfsTBnB5YQ3tUzSayRwlQ>
    <xmx:pkhcaqXFda_eRBoIGyjmJJkk62L7-aJ71__-3sD4_dFFnCCndF6Vs5UB>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 18 Jul 2026 23:46:42 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: maxime.chevallier@bootlin.com
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	heiko@sntech.de,
	netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] net: stmmac: dwmac-rk: enable the reference clock for output mode
Date: Sun, 19 Jul 2026 15:46:40 +1200
Message-ID: <20260719034640.3623173-1-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <da7d4ee0-8122-4839-b807-5d23ee6aeef7@bootlin.com>
References: <da7d4ee0-8122-4839-b807-5d23ee6aeef7@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> You've taken my review into account (thanks :) ), but you're failing to
> address Andrew's comment.
>
> The PHY should be the one requesting the MAC to output the refclk, in
> that case the MAC will act as a clock provider [...]

You are both right, and I am sorry I missed Andrew's point on v1. The MAC
should not own the PHY's clock.

I have dropped this series. Instead the motorcomm driver now enables the
reference clock itself, which is the consumer that needs it:

  https://lore.kernel.org/all/20260719034555.3623003-1-gahing@gahingwoo.com/

The device tree names the YT8531 explicitly so the PHY is instantiated
without an MDIO ID probe, which it cannot answer before that clock runs;
the DTS goes to the rockchip tree. Tested on an ArmSoM CM5-IO: the PHY
links at 1000 Mbit/s with no dwmac-rk change at all.

Thanks for the review,
Jiaxing
