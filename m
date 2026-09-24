Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D2A1DDF0
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 22:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790287795; cv=none; b=jbXFFhwPXMZF5BB9adxxjVKxSUcH1fDRRgOCby6PaCnQfEMUNl7MPyNi1iWpr8EwIBvk46hmOkCUP/bFHT4t6dn1iBvTT2KgApTRqKNYpLZ6aOgGZGfQyWbB9uRRFGYJPCBt+3MQ7v+c1Hhv8g/EO0ydWqQDw+e9iHzreYgMvA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790287795; c=relaxed/simple;
	bh=ua5hCotJkDRLxL6MtHNRbzMdW+af3BbYZ5RRCCHzMqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LzjokyI9ljGg5mH7nAanudBqhmNS7yZzW+C3Ym6palCNfr051pKejBwWa3DHEjUFPtohyCHP53lVBqZ6xYwI0yyrINiHZFFY+tylxH4DDdXoQVBPyXsrkQ+FjAiwGztLFDnqPe/vpfrXXBbIyldkVluDoKOBLXSEp7ixZFJGCq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=b4ZfmG/W; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="b4ZfmG/W"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912e64ccso1862715e9.0
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 15:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1790287790; x=1790892590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3n2L6oKjUBMsf2M6+iC+gtuR7pgT/wMDKQMXpRgjibk=;
        b=b4ZfmG/W7TBj88lvjVhOHhzerS8kOf0jR4eBAuJPSSQnJYSLJjmmPohJzi3PE02pAR
         rlBJ+oSXZ7f64zptYz47zHM+BgYX9d4R+wbXgPscBjjdjU0fRM5jiPCpZ2ZEMXi9JgZY
         4m5uS2QJCoTgCgNC+/J3GHpAu+B0w0/4owAL/f0CyuVQVsTg/d5bJklcUmmUtZma4ZMo
         9w6Qk8yE3FK3pHCNjDWdCf5BijWwt+us3t6ZVFfBfYYUrFMb1lOaEp+/RYxwr7OORHY4
         sSDS1qXAB4ePKzMwSoltV6Ai4+/b1jFIIfNsrEi7gbOo9TDLEQ52UwOqpe4bNbTc/Xu+
         JMtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790287790; x=1790892590;
        h=content-transfer-encoding:mime-version:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3n2L6oKjUBMsf2M6+iC+gtuR7pgT/wMDKQMXpRgjibk=;
        b=OHpBv4inshvem7C4xr+qmVvflLrJLgmh+s99Au9WK324ODB//cfD4iOqNg39o9yCo/
         xEpsLWqbf0xzLsM5wPZvPjTjMhoKVrAkf3QZqXigcnflSScy0sxiKaLGDS/YxnWt5m1v
         bsaLnZpdE5j29cxymkOE4Hx73f2t5r96bEadO1VtzJESEgLO8VvZ/lu4Nch2DGVCsaLA
         MMCNZtCN1MSYnXFvtr3z5EUAAiuNNIHVjCTxel+LC72DOXv9oIdyoANTR/j+7G8JHynP
         sK/HXnBqe1zRv6dHkZg5saCp2nuvXF/R8CCHBQ8r88PHaSVJgPVfVn2YeM5ZC9xPjr0v
         yz0Q==
X-Forwarded-Encrypted: i=1; AKwUvBxAyU6vaRqKRVxAGsTGr8WU3GycYUGYpme/u3uXUB0Vy7eUk/1LcOjZ1YxTgN32+w1vbwD4gEE=@vger.kernel.org
X-Gm-Message-State: AFuF++lgqklFzexEyurovJpO5z6XU3MIeXYsqjqg21eQNIrXm6HD1c5N
	8RI3f94w4tVMzIXmEGJ4IXaCqt+GeRRsPYtaimlnL1VtJg6Ei5xk1BarkLxjvNyfH8s=
X-Gm-Gg: AYBFou3tkzI3Rd5U6I0FxSZQVXOQ+TKM2xOviHfeaT/C3t7bwODHy+KX7Ap3zxvzJOu
	UB4IXZWzRmmp+m0qkMbQwoPdI/Woea1UzBAM07g2nuedaUAMwx/h/YMy3ZhYE9l/xRmE8uNpYhr
	tswgdF6FBNYXdzuluGX7b1KUGRH3gysoMzSRzZXwEUpBmzR2uU95Ql7hWmbRiBJc4X7A1kYZcDq
	HgkQyHGM68ai5TkryYoRziWM1Jr8Iu5gg2kLgkRazEUdX+dGkMogV1x6H1YLCMlg+JhHMcatKbr
	mxV7ADJIjOpictJUEWagJaEkqmx6ksGBe3rRGt/senmKWQVtKxCXR70ZvpdCIO1JZw6sLmqvb1J
	keW182Ir4xxuOdvUNcRrcPsCo143AqCTWR5ABxQFOq5FVLIZV3IsVYnhE4SJOo0IDmTBr/zq3yy
	x2qkjDFR/a1QjapUKWNO5ew7omnV2rDcxpjjgcsVlqeLmvIvjacin9VHhDGCeK
X-Received: by 2002:a05:600c:198f:b0:49f:bd3c:bc23 with SMTP id 5b1f17b1804b1-49fe6707f90mr67454905e9.30.1790287789856;
        Thu, 24 Sep 2026 15:09:49 -0700 (PDT)
Received: from remote-01 ([84.17.55.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ff044406dsm10994725e9.1.2026.09.24.15.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 15:09:49 -0700 (PDT)
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
Subject: Re: [PATCH RESEND net-next v17 07/10] net: phy: phy_link_topology:
 Add a helper to retrieve ports
Date: Fri, 25 Sep 2026 01:09:47 +0300
Message-ID: <20260924220947.2135287-1-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910170103.1029108-8-maxime.chevallier@bootlin.com>
References: <20260910170103.1029108-1-maxime.chevallier@bootlin.com>
 <20260910170103.1029108-8-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 10 Sep 2026 19:00:59 +0200, Maxime Chevallier wrote:=0D
> --- a/drivers/net/phy/phy_link_topology.c=0D
> +++ b/drivers/net/phy/phy_link_topology.c=0D
> [...]=0D
> @@ -65,6 +65,14 @@ int phy_link_topo_add_port(struct net_device *dev, str=
uct phy_port *port)=0D
>  	struct phy_link_topology *topo;=0D
>  	int ret;=0D
>  =0D
> +	/* Ports can now be queried without rtnl for ops-locked devices, which=
=0D
> +	 * we don't support now as port retrieval is done under rtnl.=0D
> +	 * We don't have phy_port enabled devices yet, let's make sure=0D
> +	 * we are loudly warned about that when it happens.=0D
> +	 */=0D
> +	if (WARN_ON_ONCE(netdev_need_ops_lock(dev)))=0D
> +		return -EOPNOTSUPP;=0D
=0D
With CONFIG_NET_SHAPER=3Dy this dereferences dev->netdev_ops, and=0D
mtk_eth_soc calls phylink_create() before it sets netdev_ops=0D
(mtk_add_mac()). On a board with an SFP cage on a GMAC, such as the=0D
BPI-R3, the cage port is created from phylink_create(), so probe hits a=0D
NULL netdev_ops. This is not only theoretical for OpenWrt:=0D
NET_SHAPER is selected by IAVF, and the filogic snapshot builds=0D
kmod-iavf, so the stock kernel for these boards has it enabled.=0D
=0D
I found this by reading the code, not on hardware: on my board the=0D
cage sits on a DSA user port, and DSA sets netdev_ops before it=0D
creates phylink.=0D
=0D
Aleksei=0D
