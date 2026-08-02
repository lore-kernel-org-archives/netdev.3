Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0952E03EA
	for <netdev@vger.kernel.org>; Sun,  2 Aug 2026 03:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785641306; cv=none; b=hgaqK93U0tVNGEETwB4AIwcMtjzaab6G0ndtNkqCoAS4zWyJJOPbjjl/feAEUUV4asLILq5xtGK1ANTYr+B8+wovqWXUjUHfkHcPjJ5CJog4NhqJDATj1iNGUf4dk9v3vJnotUY2zh60QBRTQBZPTTbE/58zDYqcYejZqYY6G8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785641306; c=relaxed/simple;
	bh=zVW9y8ku2uvDPevPqPFRUhCMmyFyJ7Yqdg2TMwGw9u4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=uOL4S1/KwVRVMiCLQQeNpYwSlMLUqRPxXKQs89zWhvvSxLRqQG89SyDiBbtdkduhzlAln8p0lbeSqNifXXK/mBHb3q9ATw3unQUkhoeOw8QZ3U9kIaMkbB/DN57RO8hdmwhFcuifXOgbIraMZjuBYv269h6lh860/3HvVo4TRps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GPm/Qn/+; arc=none smtp.client-ip=74.125.227.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPm/Qn/+"
Received: by mail-pj2-f1.google.com with SMTP id d9443c01a7336-2cb3f5bb19aso6575355ad.1
        for <netdev@vger.kernel.org>; Sat, 01 Aug 2026 20:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785641305; x=1786246105; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=TpANIRIXCFEaCO+NoYgeEquheHUazRAsrSjmXdnDLkw=;
        b=GPm/Qn/+ajQIxPFAcut+9aW2WJFPy70NDWjQ/dx3sk/AK35IYp12HwPJyfX1gPK5B9
         Wsm8ez83eBCOq7BcICvdJRH63dveQ/r9xqBuAKhbazHKYUEzcA6Pa1wk6U4aCAvegjFZ
         DmpDb8HVWCG5Ju/KCwiY5s0RtbI57fFvuykIu7q/xFXaSKOIMwPaKctox2/SG7AMyidk
         NbCjl6YrvDyNh4DQTE2Kc5TckoB2ew46GAtfsWeURi9bgs2nAV8TvRBUVgxGprgm7PDN
         +GBpeE+xfR2un2ZW703FB20+gXIhCmSv/wVKZvDRxcO1BmPMAjn2gIe8o3JDyScnk6r0
         lTfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785641305; x=1786246105;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TpANIRIXCFEaCO+NoYgeEquheHUazRAsrSjmXdnDLkw=;
        b=r/QcEao5YRjQoDclnYHKdyo5pa/4E2IkxSsotAdUPMz7WLKMdrU3CsRlWC3PoW29Hr
         6GQKWrxOlBMNdgAvoZrBcqMZAgUkqNPFt4AZkuii9cPyz+MmhCHl+ho/E2jTweC6jo+Q
         rLrQVqgq5R+6D0cN38n3yqjMdtvaE4Ios8v9oopKU7oJknYEQyYQmpZp0q8Wb/ri0QS6
         IuD9PKBXyOof+TW90AqujsQHo7jtKaHW9VOrz7q2MvlmV3C0dk+gCZv+W98MeZuFC0zl
         BDjoPhXUBJHNkoDdPL5FWCAZc4dJbSuEqn4/tdptfAJZxW8OOpV6AaMj6sRE1q2jT+O6
         c9tA==
X-Forwarded-Encrypted: i=1; AHgh+RomJp815/BkjF2lvwPUezOBUiHtxISX667CIymUNloWCE4cdFp/79UyZhFGJscy/XMdcEZQiRk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6xqBe4qleHl/FsSetDj4zk2PPBNRkY4ufvJDIBNKxLAUcUWss
	42a86qhWojg/Ky5oXgoIqzVhzIHomYzOrhNBKlvkrne1Te37GWEa1vJ7
X-Gm-Gg: AR+sD11COS+Ruvdqe9l8OMPl4uESAkeMijn4DTfHaACL/ZBuwM2NOV1w76wrfBo2qz9
	FL1HneppsGSVJ2VsBt40NggX9GYAs3fjnaUiG8WlPWMI1zjV0QCrx87OCD6p2jE5lPfrdlP737t
	9h6zghYi0tprk7+br7JROXLI/jAUOgP2GmsKBKmtmBpvEtR/HBDry0jC7NkqzMsKcdqis2PwMmH
	jItVNaR/EmQ0HuiwgkET7Kvdy4hKVdv/CJ9NEeKQfA5qofiNpxjYyhRUxh+wL/sjC+60EZ9BPWN
	kpZ9W97ftq+Fl8UcA1xJnqh/hYkBgxT/XEI1aQ4I2BOZrtNpYzOzAk0oCH5Qx6uso/jDmNqld/R
	m43TgGttF+ip+sCQWz7bUCifz/5GZO0dVpX0pWE18pMBGoTYvPwc6UeM+0U9x2WqJKxtEFoFO5q
	hNspVfynl+l7etrEbLvCrLbZ1rBQvbHXCMuBDqnyg3u6FeMqjWZzZOK3Ofy71O+pYGinI=
X-Received: by 2002:a17:902:ea0c:b0:2cf:6f7f:55d8 with SMTP id d9443c01a7336-2d0523f76edmr54404665ad.37.1785641304908;
        Sat, 01 Aug 2026 20:28:24 -0700 (PDT)
Received: from ehlo.thunderbird.net ([103.213.4.16])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04ae19ba5sm23124875ad.17.2026.08.01.20.28.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Aug 2026 20:28:24 -0700 (PDT)
Date: Sun, 02 Aug 2026 10:51:37 +0800
From: Coia Prant <coiaprant@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, Vinod Koul <vkoul@kernel.org>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Russell King <linux@armlinux.org.uk>, Shawn Lin <shawn.lin@rock-chips.com>,
 David Heidelberg <david@ixit.cz>, netdev@vger.kernel.org,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-renesas-soc@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_03/10=5D_phy=3A_rockchip=3A_naneng-?=
 =?US-ASCII?Q?combphy=3A_add_SGMII_MAC_selection_for_RK3568?=
User-Agent: K-9 Mail for Android
In-Reply-To: <0cf1f734-69d4-471f-aa22-e1a2e7d0341b@lunn.ch>
References: <20260801142244.679437-2-coiaprant@gmail.com> <20260801142244.679437-5-coiaprant@gmail.com> <0cf1f734-69d4-471f-aa22-e1a2e7d0341b@lunn.ch>
Message-ID: <7F609DE6-F3C6-487E-9113-449F5BE05D94@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On August 2, 2026 4:58:39 AM GMT+08:00, Andrew Lunn <andrew@lunn=2Ech> wrot=
e:
>On Sat, Aug 01, 2026 at 10:22:27PM +0800, Coia Prant wrote:
>> On RK3568, the SGMII interface can be routed to either GMAC0 or
>> GMAC1 via the GRF register pipe_sgmii_mac_sel=2E
>>=20
>> Add support for this selection by introducing
>> the "rockchip,sgmii-mac-sel" DT property=2E
>>=20
>> The hardware reset value is GMAC1 (1)=2E If the property is set to 0,
>> the driver routes SGMII to GMAC0; if set to 1 (or omitted), it
>> remains at GMAC1=2E
>>=20
>> This is necessary for boards such as the Ariaboard Photonicat, which
>> uses the SGMII interface connected to GMAC0=2E
>
>If SGMII is not selected, what MII is used? RGMII?
>
>Can this setting be implied from phy-mode?
>
>	Andrew

Hi Andrew,

If phy-mode is not "sgmii" (e=2Eg=2E, "rgmii" or "rmii"), the GMAC works i=
n
the corresponding mode and this register is not touched=2E The reset
default (GMAC1) remains, but it has no effect in non-SGMII modes because
the register only controls SGMII signal routing=2E

Regarding inference from phy-mode: phy-mode =3D "sgmii" only tells the MAC
driver that the interface is SGMII=2E It does not specify whether the
SGMII signals are physically routed to GMAC0 or GMAC1 on the board=2E
That routing is a board-level decision and cannot be derived from any
other DT property=2E

Also, the PHY (Naneng Combo PHY) is initialized by the XPCS glue driver
(pcs-xpcs-rk), not by the GMAC driver=2E The PHY driver has no way to know
which GMAC is using it=2E Making the PHY aware of the MAC ID would require
significant changes to the PHY layer, which is out of scope
for this series=2E

Therefore, an explicit DT property is the cleanest and most maintainable
way to describe this hardware routing=2E

Thanks,
Coia
