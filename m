Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64291443C16
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 22:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790287288; cv=none; b=TJnn6D5mym2h+5h5Wf2qhBWXWa+kDAuO1PKM0zDmazA35u9le/oHyEC72vzaa1fxREuWqGWXONXhvAq8z+tseseItjsBAse0iqUPobGBlc1c6NsOciAgH5YEsz6SBKwVJWGOlHV2/YspOZnfOOVp8/ic39vgJVd++2pSo9YvTh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790287288; c=relaxed/simple;
	bh=JYMGTgV+V84S3zGh47hfcrq7KdlrCh0v20XsSsUpdOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hqW+DPIC8/JWnxK+51qW0URaSS+C6zw7iTEnJnm4i/HB/af3MVsxUWs60N8luk3D294l1sOPAFjXKN3oL48nFT5tFxJdRw8CsDVyvDyZJueGy/TjYahTZgExWZT3OgpW5asD0Rttso7ylpHT7kIDH/WMnsyVq8GoSgPSme/0l1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=Mlk4oIRe; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="Mlk4oIRe"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e69b9e16aso3032585e9.1
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 15:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1790287284; x=1790892084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rI7xlaCb6dszd5Hc5HrUUMLQKgpiUexV2xDY/RII4IU=;
        b=Mlk4oIRe9k1qFVrhRluswQ0t25DDFoJ4c5lq7BOQOtXWhPSAswgmSpk+zQOQThoEl5
         uDrkLSlFP1NJJuMqfEE8nszKd7uUfxizPjMPi5zFuPQcsEIdvwW5cfkEl85hhhfEuLgR
         Md6klDmxdhbkaXPu5xg7/S8n/fuOBTgxJ2Zgn5Mh3eJQ5mx5p+waS7oPjGOe7xdJdG8J
         ZNluk2YYqT2tVMT+W9zZbZg7EmpQIq1nIlcK0flHkXiZctZHDEcgALCptWcTobWYkzbN
         K08kjv4i0nF+krXi8DXxVp5dsmSlNQjKtClgREYwYLLg8dVeyKOYIKK/0LxovxdC88gp
         FHvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790287284; x=1790892084;
        h=content-transfer-encoding:mime-version:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rI7xlaCb6dszd5Hc5HrUUMLQKgpiUexV2xDY/RII4IU=;
        b=lvpQOggUlbdepT+WQIJD2W9Dy4ptNj4ORyiWYbtq2PLg/gH6QoM9bvPqUIKfjOBwci
         HD4XR2hqdXbSHFX+AYExv9D4+6s8xuphI4pS9VDEuA1mhauks9jjeLSqTZhVsWsj1o/V
         kmVj+Tnse6Ifwz7mWd0a6b5dbJ8zl6vgAEjxcFRjwWp04ILlhagV0JAkIgcq/YYZPcVf
         7gZd+Sle7xzTFdojB5UD20NI2+6SitxrWMlLo35KdeC05wsn8k2qbGDFgESA60UXNon6
         nALYoqeeXHB3h0I0LqyFCjnrP6lN/gMjpoPO5UJ/T0wa9e2OuFJQ76CaArlHAgtj0wF4
         Ck0A==
X-Forwarded-Encrypted: i=1; AKwUvBwi35VwKl1CWrMSH3G1dwg0TqP4t0aIG6o7HNY9AAneVvAu97DrJJS8jskIewAJJqPjyv/2cv4=@vger.kernel.org
X-Gm-Message-State: AFuF++lyD9W47lreWXbW/W42+iQv2S/RR4q1A5VQDPU+PbatUzDLE5KH
	nZxQ+elQcEhuEneE1c+m5SNGUT6AwCQsM9JvB1VZ4ZjNDF54ZIDWibWYigOS+5VdrdE=
X-Gm-Gg: AYBFou2llNtHTyy2ejWRDRfIZ+FLC/2akEmzp3/L+jN5vqHfgPpUdAESXBfLpXpgdkN
	ZqFCdjr2aXDQtjpMrQK8G9+YCA23RdNwpY8CDvl+44x7ZbsqEaFz1xbX3zGsvwhYsWDCRLedFnm
	QMstG1ZiPXV1wYG/NkWc3mev6bGFWJ5NA2Yjr0a+aa4XgBUnbD9kpJrwL9xZTwjjkq3Y4Zy+QzW
	X24h9XfIdoZ7l8gTeLV2O3DsGo7xzoiTUm6nQht0QTzeJfk90dcSUjGoXE1opWneFVo80JLtaxh
	HSSLGaegzw8KXbQFraEeGVWJAMoKDxZ83Yf66YYY4XTvfGRYfOw1ysqd57Pu2QJNsJJJykBd48o
	IWnaQhraFCHik4Pu7FcQZCnPMCB7CLUYb2V5fNION9KQA4l808Zk8KTb8Fb8cFU8Hf1Jes4tBAT
	ul+B5/1wCAW6OI7IzxEdz6smmYqkOUoqGo+ncXAkSJdjbNzKZj2w==
X-Received: by 2002:a05:600c:1d06:b0:49e:69ff:c6b1 with SMTP id 5b1f17b1804b1-49fe7bcc25dmr57484695e9.31.1790287284491;
        Thu, 24 Sep 2026 15:01:24 -0700 (PDT)
Received: from remote-01 ([84.17.55.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fee911e9bsm21338675e9.1.2026.09.24.15.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 15:01:24 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?utf-8?q?K=C3=B6ry?= Maincent <kory.maincent@bootlin.com>,
	Marek =?utf-8?q?Beh=C3=BAn?= <kabel@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?utf-8?q?Nicol=C3=B2?= Veronese <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>,
	mwojtas@chromium.org,
	Romain Gantois <romain.gantois@bootlin.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Dimitri Fedrau <dimitri.fedrau@liebherr.com>,
	Frank Wunderlich <frank.wunderlich@linux.dev>,
	Pietro Ameruoso <p.ameruoso@live.it>
Subject: Re: [PATCH RESEND net-next v17 05/10] net: phy: Represent PHY-less
 SFP modules with phy_port
Date: Fri, 25 Sep 2026 01:01:21 +0300
Message-ID: <20260924220121.2129632-1-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910170103.1029108-6-maxime.chevallier@bootlin.com>
References: <20260910170103.1029108-1-maxime.chevallier@bootlin.com>
 <20260910170103.1029108-6-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 10 Sep 2026 19:00:57 +0200, Maxime Chevallier wrote:=0D
> --- a/include/linux/phy.h=0D
> +++ b/include/linux/phy.h=0D
> [...]=0D
> @@ -724,6 +727,7 @@ struct phy_device {=0D
>  	unsigned irq_rerun:1;=0D
>  =0D
>  	unsigned default_timestamp:1;=0D
> +	unsigned has_sfp_mod_phy:1;=0D
=0D
has_sfp_mod_phy lands in the same word as interrupts, irq_suspended and=0D
irq_rerun. It is written from the SFP state machine under rtnl, while=0D
irq_rerun is written from phy_interrupt(), so one update can undo the=0D
other. A plain bool next to sfp_bus_attached would avoid sharing the=0D
word.=0D
=0D
Aleksei=0D
