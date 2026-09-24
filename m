Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D6030DEA3
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 08:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790240046; cv=none; b=mG82ozB1FZGReHi96ErCFf8RYxk+necl3XpwV9gQplaIbjt/v9S4M0+QNwHGKGMk/j46q3zDHpBY+oA9i9tBqORhgaw9ZfEnpIL2f90o7OROdTf7Ybe3gg+L7cnl85QHVVSO2+R4DaBLdQq3Fu+hkFnHYNnwTUkbVjnWdga6mX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790240046; c=relaxed/simple;
	bh=vXsA8onEphTPMBeepzop7491JLND9beylCZQUYRa/9s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e59BfJcxTJJWfPbus6xPtb/R8wmrxgY5+rrCWus2s1zRd5mxDgXYT/q+02iqXNsCspS4r0GNF0PPg8h5UPvg8/4sJbaEmwBmRIaVS4NSuKTvDDkrz+b3r60Umb/3lO/Ah+iPvK0Nx0m0whY3mgg/XWmDAYJQgx2lb6miA12kVHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=LqbjLpMK; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="LqbjLpMK"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e7bcb94d3so12519335e9.2
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 01:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1790240041; x=1790844841; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YLnZwUG2MBgLZpqGTzUMzHxGyh6dXv6V+NePiVAKHBk=;
        b=LqbjLpMKvROjquwB9jxrXy2kExvY2imvTRcDnTuHsenhBVfltERJWno289v+iKmBJ0
         yUqkWFM+EFSFkDhphVs6tMb1P9AWqlMdUS/5QOyQM9/h7C+yCLOJZ7lCjjbQe+RHTCMA
         r/UI+7MgH45kl88MOtfb8JtOXg8eB4ONJMqxo32cayOKyu/UkHG87iGnwScfJVP691mX
         vOloPmc5qF53eBOKxUSJjqEumbi5ZfQcrMUaOaypXmtXdPklzDOPfmBXXVEFkITPNP49
         OK6K3F+y4PcdWOsVTPW7EuxflHrHUrB/SnW9+UwP9e4GDh13UiccwX5gI6sLw2MNo8km
         zU+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790240041; x=1790844841;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YLnZwUG2MBgLZpqGTzUMzHxGyh6dXv6V+NePiVAKHBk=;
        b=2dktvewr3ifwzDM6q8Q81FJNSRnE5z1pZxR+MKHY9mHUHeGNiadbsXE/+MfUQfY1MQ
         4+ZLXUF4BTCzB1eLaolHdLONdRV/+MVP36jc50+kpptrsZCAzjgtnQadjK4061PqJ4b7
         x0Lfu2W9scSIpwmA8r0/j+S35CYjHhW3Wi/SOeDrTMKZLZCkmZTZtj+Qo6D405fe787u
         XylY2m4dy+Tnv0UIPggZ7nwBlblCLjN5ozTymtzWJx31zBV/AUo3qZfFXRnX3Yi1ibnb
         12sP1xCrTFBaTIKkmNSNo3Efi1m1TCmsA16V89BsYpL3inllOcZE4CBjz4x5dl/+SF2y
         1qIw==
X-Forwarded-Encrypted: i=1; AKwUvBxO2PGOdIIMrLjjdMuDUw7/WFnbXbdaOrNVgQBTMiOiuZUEibFxa76UfrB3xjhj81iuG6V6B64=@vger.kernel.org
X-Gm-Message-State: AFuF++ngcETYbTlN2yCgvny4H5TkMn2o3757yFRreM3dp5soSMFiUghC
	C4ZIcqUXzdICT+IvemS3nmeBcI+eA2NS6lmM8FVQeJdw5Y+Kl7gx7oBydh+L97DSkjo=
X-Gm-Gg: AYBFou1da1se4j/lKcwRT7/zCD4fWO6zlZa5sGd3jg9WscRoHpQ1ZjswOtPoGccvtGl
	Ub6KXFML1rDndSwtYID8CiU77ns72ObbNmflIZi76caH9S69BCwjAs7uBR8U1LLuAjuteY9bima
	ZKzAEDDoD8qqKnARdBgMoo2PKKTCarmRClzAkDcf7BUPZbUJ3j9fiLfvoak3wO6ucfcIVKu351s
	ymmAcZVdtiWoUe5S4tAIs4tWYyKtaes/Q5DYvCvjG5tbjtVSeMZbN/71+9Iq8h8u/Vd+uMUgAgb
	PBoGIDyS5kSV+eG4STIBPrJ19ljaQ0zTrjMfD9VUVj8v+EGBjo1m6WNUkJU2CxzSAYnuXNA+8TP
	R3zCt8wbEIPpkqP1R9SLGGHhvluUUtn64lIhPPPZJpZtbQIBjIcAQoWIOoYUdeFroQihwZVd2GK
	Q4zFP4a+N0AhHCF3SYdSSCziZ9hFb++lfl4e9JJZgk4bZ3ERHWruulc0JP8PNb16QUo7ItRMurV
	h+oHnOFhH5AQYYh/g==
X-Received: by 2002:a05:600c:8b22:b0:49e:6fd2:a45 with SMTP id 5b1f17b1804b1-49fe66d81fbmr28966805e9.16.1790240040664;
        Thu, 24 Sep 2026 01:54:00 -0700 (PDT)
Received: from localhost (82-67-6-57.subs.proxad.net. [82.67.6.57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5cd4c8dsm64643045e9.3.2026.09.24.01.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 01:54:00 -0700 (PDT)
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
Subject: Re: [PATCH net-next v3 3/5] net: stmmac: sun55i: Make the delay
 step configurable
In-Reply-To: <26334006-a2af-49d3-8f26-18cd44118c6b@lunn.ch>
References: <20260923-allwinner-a733-gmac-support-v3-0-15735155a789@baylibre.com>
 <20260923-allwinner-a733-gmac-support-v3-3-15735155a789@baylibre.com>
 <26334006-a2af-49d3-8f26-18cd44118c6b@lunn.ch>
Date: Thu, 24 Sep 2026 10:53:59 +0200
Message-ID: <1j4iff9gig.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On jeu. 24 sept. 2026 at 04:30, Andrew Lunn <andrew@lunn.ch> wrote:

>> +	 * Correcting them would break the DT ABI of the published DTs.
>> +	 */
>> +	.txdly_step_ps = 100,
>> +	.rxdly_step_ps = 100,
>
> Could you be a bit more specific about what published means?

DTs like those ones:
* https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts?h=v7.3-rc4#n88
* https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts?h=v7.3-rc4#n87
* https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4a.dts?h=v7.3-rc4#n106

On A523/T527, only gmac1 is supported by the driver addressed in this
series. gmac0 is another (dwmac) driver.

If I take the 1st example

&gmac1 {
	phy-mode = "rgmii-id";
	phy-handle = <&ext_rgmii1_phy>;
	phy-supply = <&reg_cldo4>;

	tx-internal-delay-ps = <300>;
	rx-internal-delay-ps = <400>;

	status = "okay";
};

If the information we've got about the A523 delay steps are correct, the
actual values would be:
* tx: 540ps
* rx: 2120ps

So I suppose in this case, the phy-mode is more likely to be rgmii-txid,
isn't it ?

>
>       Andrew

-- 
Jerome
