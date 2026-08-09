Received: from m101-out-mua-6.websupport.se (m101-out-mua-6.websupport.se [109.235.175.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D39D2853F3;
	Sun,  9 Aug 2026 11:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.235.175.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786275995; cv=none; b=FfAplGMxVghs4tKCpid9C2CokJ7MWWaH8tWHuWkHn9aOn+ULKVpA55CyM0I3X0oxHqTD9608d9JK71LQ4ebROy7eripaEb6U11fAsXF/xdMl1/Fxlmso3o6a9+Yqp8X5ug1n4g4n3/oNRFbt8hyO/lsKe8xqlo/PtTR2ST8hzjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786275995; c=relaxed/simple;
	bh=jZ/WieJvBgGTLDA53hrBTiwwMZpkQl/Y9Fr8ZYtB0L0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V79Ly1S70sneamA3Dl8Xo4oePFfmNzUbuBSinvmukX3ZGsKUp1nUPpxEPaXwRwNirFXGIcrqAEKgXxrrW480QxVJnB8kBDvN52qLLKj0GKwo2p0H2ox56B5c8nrFPZjbzMD4dL2W40XtRDFolfV64h+cadaRt9i781fnEM2vS4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=palvencia.se; spf=pass smtp.mailfrom=palvencia.se; dkim=pass (2048-bit key) header.d=palvencia.se header.i=@palvencia.se header.b=jtEcCMM8; arc=none smtp.client-ip=109.235.175.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=palvencia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=palvencia.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=palvencia.se header.i=@palvencia.se header.b="jtEcCMM8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=palvencia.se;
	s=mail; t=1786275984;
	bh=Cko3zHK3AZ44CP9iv+bawq/dcdWlNtCNj2kBh7j6SUc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jtEcCMM8dze1O2lHaItcxTfsrT3zJ50rtcdIQPjgCHN0yx10+VdlMvSuZayxbOTUq
	 bFebBddWlbbVp6MERktEFtiU6L2muwqRqLEa0feAg5mWdxlq3ovorobf6/SJqAjvsw
	 h4ZFP3blh8gHCV6+CM2jcRj5xvLUqgK12KZ4/7upyXtpWaorMMlN0fKjWdrws+2seL
	 pwl+pOJrbZKcOBoVrpF0ri5o1U6CjO2J3LB0ecnTorxJCywxho3BtsX9g71rmIDOYk
	 aON7B4BljLnfPWGXe3W/xJs/VG34WS1yZDnm4Ubv6WxJxBxVhWjAXzBvmu8sSRZMY9
	 naxwCBxkD9R/g==
Received: from m101-u6-ing.websupport.se (unknown [10.30.6.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by m101-out-mua-6.websupport.se (Postfix) with ESMTPS id 4hHx1D4s79z1pGK;
	Sun,  9 Aug 2026 13:46:24 +0200 (CEST)
X-Authenticated-Sender: per@palvencia.se
Authentication-Results: m101-u6-ing.websupport.se;
	auth=pass smtp.auth=per@palvencia.se smtp.mailfrom=per@palvencia.se
Received: from rpi (unknown [193.180.91.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: per@palvencia.se)
	by m101-u6-ing.websupport.se (Postfix) with ESMTPSA id 4hHx182yG3z39Jw;
	Sun,  9 Aug 2026 13:46:20 +0200 (CEST)
Date: Sun, 9 Aug 2026 13:46:07 +0200
From: Per Larsson <per@palvencia.se>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, Heiner
 Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, Liu
 Changjie <liucj1228@outlook.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 6/6] arm64: dts: allwinner: a523: x96qpro+: enable
 Ethernet support
Message-ID: <20260809134607.65d66069@rpi>
In-Reply-To: <20260803101452.2993721-7-andre.przywara@arm.com>
References: <20260803101452.2993721-1-andre.przywara@arm.com>
	<20260803101452.2993721-7-andre.przywara@arm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Out-Spamd-Result: default: False [1.90 / 1000.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,outlook.com];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCVD_COUNT_ZERO(0.00)[0];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:35790, ipnet:193.180.91.0/24, country:SE];
	RCPT_COUNT_TWELVE(0.00)[19];
	BAYES_HAM(0.00)[50.10%];
	HAS_X_AS(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	LOCAL_OUTBOUND(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,sholland.org,armlinux.org.uk,outlook.com,vger.kernel.org,lists.linux.dev,lists.infradead.org]
X-Out-Rspamd-Queue-Id: 4hHx182yG3z39Jw
X-Out-Rspamd-Server: m101-rspamd-out-5
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-purgate-size: 613
X-purgate-ID: 155908::1786275984-BC6051C6-6F571976/0/0

On Mon,  3 Aug 2026 12:14:52 +0200
Andre Przywara <andre.przywara@arm.com> wrote:

>  
> +&mdio1 {
> +	ext_rgmii_phy: ethernet-phy@1 {
> +		compatible = "ethernet-phy-id7b74.4411";
> +		reg = <1>;
> +		clocks = <&ccu CLK_EMAC1_25M>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&ephy_25m_pin>;

This should be &ephy1_25m_pin, right?

> +		reset-gpios = <&pio 9 16 GPIO_ACTIVE_LOW>;
> +		reset-assert-us = <10000>;
> +		reset-deassert-us = <150000>;
> +	};
> +};
> +
>  &mmc0 {
>  	vmmc-supply = <&reg_vcc3v3>;
>  	cd-gpios = <&pio 5 6 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>; /*
> PF6 */

