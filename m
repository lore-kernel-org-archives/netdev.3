Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A824582E7
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 08:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790324807; cv=none; b=AVRkE6vXwi799nwLmYPsxgPnNzdCoavyNFlsut7pBG7YzQ/A7kxvRJJkR/SSIQk4aodHjY3CqUjlSU3htgXeeJWmhNXkjE+aun+3ZjOlmusYMtsa28lEIQvHH078UJdr2PvWj5PV+16VBrJTv4kaUdolYAkeDFLNUnl/5YOPgc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790324807; c=relaxed/simple;
	bh=FsP2TXZ3qjaeMFDT0rvuX0F/s009IIR1rsBwIsepWW4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d9GrRbhlfzYrrD30/tQN4Nzhf4bkNeTtWTA2pkKeytrgAWjSZjmufPxOvrJaTiRlezXFnC8ysd2MMw/8RJSHgAzSa9aWiapk4sfSGxuTNcbZvCAjIOastoMDiFkPgQ1zeZI1mzwsZkmmMwzFFwZj/cQgAtbbPNsUv1LvP4bNcKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=a5tLgnYc; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="a5tLgnYc"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-4887f690df6so237031f8f.1
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 01:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1790324803; x=1790929603; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9Krj4nGjzLocure3/yPi5CdWbov31+36/X35bUtBK+Q=;
        b=a5tLgnYc0jftFFe6DXNdUzDNVEPDt1dqiVWQ4kdDrtQgOyPUFdJt7h7zvMYu4GGgu6
         O9+Gxdy/rwalrY1um8kBOebVnLDnK0arGSabr/F9D1PXIexGSP8/p69BP0K5bX8OHuDX
         6htRPWZyVpsFkL6fVKO2ZUwhRMuQuAdCpJo6udl03vHLNXXfWBGsOYvXVLRj1DgcwD6G
         YMTs5iDFe9Wq/CI5/V3EhtqKiBTaU0PCfoWZTpMVXiYmEToEyQySEtfiemAdv9t0HvkP
         ADDHws1wRDOwOoq3Y71LPq6M8dqvw6ScPtmJpKUTa9ekSuog59AkxmiXAXeKBy91h2ES
         3XXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790324803; x=1790929603;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9Krj4nGjzLocure3/yPi5CdWbov31+36/X35bUtBK+Q=;
        b=y1I1Mq3iFxWH9s5YtPROKWbpFJT7LwBx5PDRymJX+6Gchg8GjgZrHyDC/vV92c2fu6
         3qXP8Do4CCbvC6Gm20Lp/w5E5ZV4hXnDTZOwKd0M+SEAQnKd9vesilGiLmD4ebnacWR1
         WQ9ORVUpkzMEMjlAaQH/py9YHt5BNPQgHjCvDCLW5T1NFwyHUQlcHavAn6Mt8LkHNKec
         CJyusNIuKDvlv4VPKBnJ4A5tZo/8Rd2cDaEAJ4laQAd9MSFGF3kKQvvMDMXVGuDUwuZf
         G/TY3ruMVRcChhwZn8i8HzEPEBHjeVnAUV0Pbhm6WmoB3Upp6TxrRrdY8HJDBJAm8wnY
         q1LA==
X-Forwarded-Encrypted: i=1; AKwUvBw+pUjBk5txMPKrIN9YlpfudZpu9YDpgeZrCSsBUFDGlEsMFCab67e6hZyw1lX788qMCHeU0YQ=@vger.kernel.org
X-Gm-Message-State: AFuF++msY6srhjcaDvru3hG1D3MMQBZyh5zK1+BZDkPSOi/1Sv4tujWm
	Sh0qvZLfQroizVEaqbTdLv6ZhAKZTZ+CjrK7bHE+Ap/DyorhURmmy9oJJfT2d2jgkMY=
X-Gm-Gg: AYBFou1eZB8MfBSkjELBFzPsk0L3Q8RhVqR+vIitQ3eJR2gYXZk/BW3uxA2A+TVh4HI
	/tFtq6fKhJhc/7MxwIN27zEYTF/dD60kVFRdgXhy/f6uW6X87FUpOFoIoFmeRdCWFpEzLBFX2UD
	Y+YOUWW8isCFGLdA55QQVQkDOmardFTMbjc5zxI2bC8W9Fqy0nb2VAUEXBAWfCSCnNnA+CypYh1
	3MoOd8WRuu1BQvS2luF5omY+zDH7NmtweThDtSQLhtf8m9LQ7hELKOzjDxWu4YGXfK8TVmmQqps
	LlRkQFu6NtTpidPNS9dD2PyjsklBh49sVfbKQF9PqY7Yq6KrCsr4/VLDZJEdJvRqRy6/8J7byAY
	hG91Wkj7N8tn9rhzyYArypQLM972QNzU16/4DP5t++uGhDNGCZt3nnQU/7eVOocVctdo4zMTGhW
	gc08wNLLltlzgK4B5uUcTFFK4eA7QvOGL/chW753KU8Qv5iZHFt3I7odr9QdzlVa1+Eii/qnPse
	nxK1PFl+BrWqULvGA==
X-Received: by 2002:a05:6000:186c:b0:487:27f6:a4dc with SMTP id ffacd0b85a97d-488716b2633mr7795054f8f.44.1790324803297;
        Fri, 25 Sep 2026 01:26:43 -0700 (PDT)
Received: from localhost (82-67-6-57.subs.proxad.net. [82.67.6.57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a349fa1sm7326486f8f.8.2026.09.25.01.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 01:26:42 -0700 (PDT)
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
In-Reply-To: <491f043e-6dc6-4936-a490-31a3362c5b6e@lunn.ch>
References: <20260923-allwinner-a733-gmac-support-v3-0-15735155a789@baylibre.com>
 <9cc61625-47c9-4bdf-97f0-0528f661a399@lunn.ch>
 <1j7bkb9h5k.fsf@starbuckisacylon.baylibre.com>
 <5fae3b42-552a-458a-9710-927360e58c37@lunn.ch>
 <1jv77u8yak.fsf@starbuckisacylon.baylibre.com>
 <491f043e-6dc6-4936-a490-31a3362c5b6e@lunn.ch>
Date: Fri, 25 Sep 2026 10:26:38 +0200
Message-ID: <1jse2x91oh.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On jeu. 24 sept. 2026 at 18:02, Andrew Lunn <andrew@lunn.ch> wrote:

>> It is not the PCB doing the delays so rgmii-id it is (in DT) - got it.
>
> Yep.
>
>> 
>> I dunno what is sane or not, but the allwinner dwmac drivers do set some
>> delays. sun8i-dwmac and sun55i-dwmac do so, even before this change.
>
> As the document i linked to says, doing small tuning delays is
> fine. We strongly prefer the PHY does the 2ns delay, if it can.

Understood.

>
>> If I understand correctly :
>> 
>> """
>> When the MAC implements the delay, it must ensure that the PHY does not
>> also implement the same delay. So it must modify the phy-mode it passes
>> to the PHY, removing the delay it has added. Failure to remove the delay
>> will result in a non-functioning link
>> """
>> 
>> IOW when the gmac has *-internal-delay-ps set and honors them, it should
>> also amend phymode seen by PHY to make sure it does not add its own
>> delays, should it ever be fixed ?
>
> You need to differentiate between small fine tuning delays, and the
> 2ns delay required by the RGMII standard. If the MAC is just doing
> fine tuning, you need to still pass PHY_INTERFACE_MODE_RGMII_ID so the
> PHY adds the 2ns delay. If the MAC is adding a big delay, you need to
> pass PHY_INTERFACE_MODE_RGMII to the PHY.

The PHY is one concern but the series here does not really address this
topic. DTS and board specific concerns will come later.

It is really just the MAC. So, how does the MAC is supposed to
make the decision to amend the PHY mode ? is there a threshold you'd
like to recommend for this differentiation ? 

>
> If you have the schematics, it would be good to confirm the strapping
> on the PHY, and add a comment in the DTS file about what is going on
> here.
>
> The other option i hinted at was use phy-mode = 'na'. I'm still
> considering this, it has some advantages.
>
> The problem with passing PHY_INTERFACE_MODE_RGMII or
> PHY_INTERFACE_MODE_RGMII_ID to the PHY is we have no way of knowing if
> the hardware is honouring it. It appears the board you are working on
> does the opposite of what we would prefer. I guess there are going to
> be other similar boards, but are they going to get a similar level of
> review and the issues spotted? Are they going to end up passing the
> wrong PHY_INTERFACE_MODE_RGMII value to the PHY?
>
> By making the PHY reject PHY_INTERFACE_MODE_RGMII* it makes it very
> clear something odd is going on here, and care needs to be taken. It
> will be very much in your face for DT writers, so they are more likely
> to get it correct.

We do need the information that the link is RGMII (not RMII or GMII) to
setup the MAC properly though. Aside from that, It is all fine by me.

>
> And if in the future we do find out how to control the PHY delays in
> software, boards using phy-mode = 'na' are safe, no change. Other
> boards which got passed review could well break. Been there, done
> that, don't want to repeat it.
>
>> > But this PHY is going to cause you lots of problems.
>> 
>> We don't get to choose I'm afraid :)
>
> Yes, you have just the first victim.
>
> It would be nice if somebody reached out to the vendor and asked if:
>
> Can the RGMII delays be configured in software?
>
> if not:
>
> Can the RGMII delay strapping be seen in software?
>
> If we know the strapping we can at least return EOPNOTSUPP if the
> requested does not match what the hardware is doing, and we get a
> clear indication of a problem.

I'll try to reach out, just in case. I have the schematics but without
the PHY doc, it does not help much.

Just to get back on topic, The problems you mention here are more PHY ones
when net support lands from this board in DT (I'll remember to Cc you of
that one when it comes)

For the MAC part here (and its bindings) it does not change anything,
unless I'm missing something. This series just adds support for a
another MAC variant in an existing driver.

>
>     Andrew

-- 
Jerome
