Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1C0322A;
	Thu, 23 Jul 2026 02:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784775140; cv=none; b=McU9uhjoj4cw9hSCvwlox3EodtRnR902FUM2qtxReIu4V9CSns1/FrJZZOS9LPmIh3M54MgJUmFRo9/tTuOud30wO0PayY2Gc/pCvRTfO97RcROphgyB/qnS3Dze/hIT6hbVjvNeR2lgdu8+wipH4UDqad8M6DF4QkHj/s5btsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784775140; c=relaxed/simple;
	bh=E74OmOvMMYRhM7N9VH9QQe3ZTr7v6j7DFaDOcQy6AwQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G65PoACeIe4WwmAYW4XT2EI3o+3AxhQxJ7SMDmokeY2qEKhINmnBmW5D2+17NmqqzPH4eDMfGrD2lpOhT6w7AaQKSaKGKeHa9rn92Nk6Rf2o9cML7V3t6HjXABe5Fg/zz2Bb8fU12Ml45+bhqkcR46eIa4NwQbKcW4wYiJzd6MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=XDqSUu3F; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="XDqSUu3F"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66N2ok3W3161266, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1784775047;
	bh=5i/AwC/Z5RQee4dCKm4XzSAggFU/49vhxFHo7i852jw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=XDqSUu3FH9KLwyqpM4DeTx2sCuBM3jfnKJSqAwsQi0/MVySSxpchr4lSUWvhcisqU
	 8UkoUlEuf/UCDOCQyDcku9jlEdme9cXXMeJnuUNh86y6uEiLHJsKVvHhhv7BrMZySE
	 iiQ5bky4+RJGnUkALF1yj8vFRll7dUGzz9boXtSlzGXctaBWInpNeGorbpZ1RIQ0yw
	 A2GSiE8dhN7+YwrYDz8uj771dDMFwbVKZbaikZSuKPnGOHtTDp83bLXusVBU2YWAem
	 ynrrwS447oqA6pYNkNFESJuq3v51sKlq4+elnUe6PTMQhg+GlzA0FQssjujGPFfVIj
	 ZQQSferf6VHoA==
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66N2ok3W3161266
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 23 Jul 2026 10:50:47 +0800
Received: from RS-EX-MBS3.realsil.com.cn (172.29.17.103) by
 RS-EX-MBS4.realsil.com.cn (172.29.17.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 10:50:47 +0800
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) by
 RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) with mapi id 15.02.2562.043; Thu,
 23 Jul 2026 10:50:46 +0800
From: Javen <javen_xu@realsil.com.cn>
To: Andrew Lunn <andrew@lunn.ch>
CC: "hkallweit1@gmail.com" <hkallweit1@gmail.com>, "nic_swsd@realtek.com"
	<nic_swsd@realtek.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "maxime.chevallier@bootlin.com"
	<maxime.chevallier@bootlin.com>, "horms@kernel.org" <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"daniel@makrotopia.org" <daniel@makrotopia.org>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "enelsonmoore@gmail.com" <enelsonmoore@gmail.com>,
	"daniel@thingy.jp" <daniel@thingy.jp>
Subject: RE: [PATCH net-next v7 2/7] net: phy: phylink: add helper to modify
 pause
Thread-Topic: [PATCH net-next v7 2/7] net: phy: phylink: add helper to modify
 pause
Thread-Index: AQHdGYHgldnQo8efzkOeDwGAKMGQbbZ5w2cAgACcxgA=
Date: Thu, 23 Jul 2026 02:50:46 +0000
Message-ID: <65141a327af44b938ba2fb94e3344da3@realsil.com.cn>
References: <20260722022906.271-1-javen_xu@realsil.com.cn>
 <20260722022906.271-3-javen_xu@realsil.com.cn>
 <8a90be50-8a45-4a27-a0a7-adfd1156c30e@lunn.ch>
In-Reply-To: <8a90be50-8a45-4a27-a0a7-adfd1156c30e@lunn.ch>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


>
>> +/**
>> + * phylink_update_mac_pause_capabilities() - Dynamically update MAC
>> +pause
>> + * @pl: a pointer to a &struct phylink returned from phylink_create()
>> + * @mac_pause: the new MAC pause capabilities mask
>> + *
>> + * This function allows a MAC driver to dynamically change its pause
>> +state,
>> + * such as losing/gaining Pause frame support based on MTU size.
>> + * It recalculates supported link modes and triggers renegotiation if n=
eeded.
>> + */
>> +void phylink_update_mac_pause_capabilities(struct phylink *pl,
>> +unsigned long mac_pause) {
>> +     struct phylink_link_state *config =3D &pl->link_config;
>> +     unsigned long old_pause;
>> +     int pause_state;
>> +
>> +     ASSERT_RTNL();
>> +
>> +     if (mac_pause & ~(MAC_SYM_PAUSE | MAC_ASYM_PAUSE)) {
>> +             phylink_err(pl, "Attempted to dynamically change non-pause=
 MAC
>capabilities\n");
>> +             return;
>> +     }
>> +
>> +     old_pause =3D pl->config->mac_capabilities & (MAC_SYM_PAUSE |
>MAC_ASYM_PAUSE);
>> +     if (old_pause =3D=3D mac_pause)
>> +             return;
>> +
>> +     mutex_lock(&pl->state_mutex);
>> +
>> +     pl->config->mac_capabilities &=3D ~(MAC_SYM_PAUSE |
>MAC_ASYM_PAUSE);
>> +     pl->config->mac_capabilities |=3D mac_pause;
>> +
>> +     phylink_set(pl->supported, Pause);
>> +     phylink_set(pl->supported, Asym_Pause);
>
>I don't know the phylink code very well. Could you explain why these are
>unconditional? It is not obvious to me.

Thanks for review.
The unconditional phylink_set() is required precisely because of how phylin=
k_validate() works. It acts as a necessary "reset" to prevent the permanent=
 loss of capabilities in pl->supported across MTU changes.
Consider the following scenario when MTU changes:
1. MTU 1500 -> 9000: The MAC loses Pause support. mac_pause becomes 0. When=
 phylink_validate() is called, it correctly clears the Pause and Asym_Pause=
 bits in pl->supported. This happens in the function call trace phylink_val=
idate()=3D>phylink_validate_mac_and_pcs()=3D>phylink_validate_mask_caps()=
=3D>linkmode_and(supported, supported, mask), where mask represent the capa=
bility.
2. MTU 9000 -> 1500: The MAC regains Pause support. We update mac_pause bac=
k to 1. But if we simply call phylink_validate() at this point without unco=
nditionally setting the bits first, it will take the current pl->supported =
(where Pause is 0 from step 1) as its input. The Pause capability will be p=
ermanently masked out and never restored.
By unconditionally setting them here, we restore the baseline to 1, allowin=
g phylink_validate() to correctly decide whether to keep them or clear them=
 based on the current PHY/MAC capabilities.

>
>> +     if (pl->phydev)
>> +             linkmode_and(pl->supported, pl->supported, pl->phydev-
>>supported);
>> +     else if (pl->sfp_bus)
>> +             linkmode_and(pl->supported, pl->supported,
>> + pl->sfp_support);
>
>These lines are masking out pause if the PHY or SFP does out support pause=
.
>But where is pause masked out if the MAC does not support pause? That is
>what i'm missing here.

If the MAC does not support pause (e.g., mac_pause =3D=3D 0), those uncondi=
tionally set bits are correctly masked out during the phylink_validate() ex=
ecution chain. Inside phylink_validate_mask_caps(), the mac_capabilities ar=
e converted into an ethtool linkmode mask, and the actual filtering happens=
 via linkmode_and(state->advertising, state->advertising, mask). And mac_ca=
pabilities is from pl->config->mac_capabilities, which we set at the beginn=
ing of this patch.

BRs,
Javen

>
>        Andrew
