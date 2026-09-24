Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F51747DFA8
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 15:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790263660; cv=none; b=BGVsTR3mPZ0SmiOReZb1sJdx+9rdynzucT7g33lw5PvbA6UihCO5JKDZSAEOwE77ERjj3lXlvxTmn5+sz17wNKN+x+4MJbiLaEr8ET5WTC48ss9R6g2+6EYSdDgwMSdj+n7NsK6zJsqvx7T4SxM0psGfpR9xPLptYBd03DgZEhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790263660; c=relaxed/simple;
	bh=cyaiCXoXZGoECX+KF+a09pG3FdGWCh+dGbVZ3Xuigsk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fDCJAPr2exadbZSliyAeENdCcBnd/YFrKwp1fbAQWnoFj9oKXPjC1Oj8xk9G3eqILHV1XZMfKyHP6550cy+1nBpmriL7Ei0eLNsKcc3G9mkbePxVTj6Pl7m2kfTCfvl0VNbBpWg2Oeed9iCgE1GlM0XkSwd41IextYt4E+ZN6o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=lwUg61YC; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="lwUg61YC"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-485b1d2874aso1760291f8f.1
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 08:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1790263656; x=1790868456; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eRG6Vx+KfGB0F8iXypxpZOtK+1xBSwz+daslPav1QJE=;
        b=lwUg61YCnPbWPTNR+ceR/SH8BXDTu4hQND29qsQWkJuB1uP8erKDlq1FkD6Ns91l1M
         P+fQARvMZ9DZyw3a8UfqX+kD9csamCJzhq5LEoXhMzOTxZgUWiMmrVrLVAKtOdnx9m4g
         o2eVASspo33Omous6O8BU6mYA2hQD6NKG2+sYJG3pcCjcOoZ/woID3mzfq5PO89YLzKH
         +OHKd5uWXxREG/u4R9PSE75v9bO7RK8iXKTkyI++6OsrCRn6a8YkLSdTOn9I7GzvJ/+3
         OicEDVljp9b6ZjuNorxxiUxmZAXzEnJ6oGIZar9nM8DLlNj4eNK/n5lITYjeIoleY0So
         w50Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790263656; x=1790868456;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eRG6Vx+KfGB0F8iXypxpZOtK+1xBSwz+daslPav1QJE=;
        b=WDuN9LBUp+pmap++tgU1xzRv4/DofziE0zXp93BgWBkoVfVGOBH20FFuh5eWG0nwQd
         l5anRAQCB5+fwUhOP5ES6bZB+tqi4nrBioo14aSWFm31L7+WSGnT9WLuFqIKfEUQme1C
         WesFKTzm8pzFd5NyvHzj4sUta0RsqYZ8OOTmpdM47KnaCRPTw1gdkhe97ZxNzjpofgXA
         IPH+vDsR+aeCvIT51x8jipOnjF+yypzPFCBn9tFCntTNQaMjMZsoAEiIMPvDnb2HvGmS
         hGcfwcR+fgr3sQ6jiMaE+q31aF2dq+XBFLqCXgMo+DqFCih2fl83dk7nYLsHVV0xclc7
         NBIA==
X-Forwarded-Encrypted: i=1; AKwUvBzXDPpQhox4JVdyeWi2rlCRZLA1cOgrm2MkkpD/T3jjNMWxL2jPWTd2+jq/zSDyaSph5ivm2pM=@vger.kernel.org
X-Gm-Message-State: AFuF++luq3ZNY7kHNlU5S+WiUP8vA37Pn6hbMTUbSh16iv2cjdzYhsqM
	Mmdp05v4rc9AlpYO02WgbWk8DywjtrQpM4dLjKrUcdzmrsC9YvDtw3SvzsSKVJvZ4TA=
X-Gm-Gg: AYBFou0GPicX3pc7eiUPvebn2SsRsRoXdn2GET45yTDg2VSoLORHFZnF1dGdYFBTxsu
	26brivYi4yLCsVU6p83tnSebNfExQg8PHNUQuNmtvebO2GAL/7j2BeiCyshaMVB2BQv77b94roJ
	r8Lwr0uwvp1RNxHRE5iFOxaz3HBpdV1d2eVIYa6kYh5QuJC7E8vHkXW/7pejC4z6lH8S7Qc5vvt
	h9AA99KEMm8kz3Jyzg1yXFXUKxnWoyKPv3k/vgbbCWM/DCeV2mhuQIKK69D5R3poKLO+mahhjQ5
	z2Ylz6MAmmvjivUWsfQ23D8WX3wIGfBMNq91UUaSRtwuVCdAFHQNo/sG96KIuLYTmm15eVkSp0j
	XEBS86Iq6UXKsf0Vagd/H6FOpqPrzMy5XLRC8A3bKuyV3Lb3642PGPkwqr1hMuCXCWwrq4znTPW
	QLO0kwLMGQ1hQf5DSmzaZ+ngpEYAG5MZUopFYTO3s3iqSvlhdw69vDiXzKYVqlyJiZHqiR717KL
	nDnn5TKWtAEC7MgTQ==
X-Received: by 2002:a05:6000:1886:b0:486:e8fa:f9b7 with SMTP id ffacd0b85a97d-488716c12f0mr5112120f8f.13.1790263656324;
        Thu, 24 Sep 2026 08:27:36 -0700 (PDT)
Received: from localhost (82-67-6-57.subs.proxad.net. [82.67.6.57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-488682668dcsm16823010f8f.1.2026.09.24.08.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 08:27:35 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, Richard
 Cochran <richardcochran@gmail.com>, Maxime Ripard <mripard@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, Andre Przywara
 <andre.przywara@arm.com>
Subject: Re: [PATCH net-next v3 0/5] net: stmmac: Add support for Allwinner
 A733 GMAC210
In-Reply-To: <5fae3b42-552a-458a-9710-927360e58c37@lunn.ch>
References: <20260923-allwinner-a733-gmac-support-v3-0-15735155a789@baylibre.com>
 <9cc61625-47c9-4bdf-97f0-0528f661a399@lunn.ch>
 <1j7bkb9h5k.fsf@starbuckisacylon.baylibre.com>
 <5fae3b42-552a-458a-9710-927360e58c37@lunn.ch>
Date: Thu, 24 Sep 2026 17:27:31 +0200
Message-ID: <1jv77u8yak.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On jeu. 24 sept. 2026 at 14:54, Andrew Lunn <andrew@lunn.ch> wrote:

>> I've changed the phy-mode to plain rgmii which seems more in line with
>> what the PHY actually does.
>
> No, it is much messier than that.
>
> https://elixir.bootlin.com/linux/v6.15/source/Documentation/devicetree/bindings/net/ethernet-controller.yaml#L287
>
> rgmii-id is very likely to be correct, if you were using a sane PHY.

It is not the PCB doing the delays so rgmii-id it is (in DT) - got it.

I dunno what is sane or not, but the allwinner dwmac drivers do set some
delays. sun8i-dwmac and sun55i-dwmac do so, even before this change.

If I understand correctly :

"""
When the MAC implements the delay, it must ensure that the PHY does not
also implement the same delay. So it must modify the phy-mode it passes
to the PHY, removing the delay it has added. Failure to remove the delay
will result in a non-functioning link
"""

IOW when the gmac has *-internal-delay-ps set and honors them, it should
also amend phymode seen by PHY to make sure it does not add its own
delays, should it ever be fixed ?

>
> But this PHY is going to cause you lots of problems.

We don't get to choose I'm afraid :)

>
>     Andrew
>

-- 
Jerome
