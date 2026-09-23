Received: from mail-ej2-f6.google.com (mail-ej2-f6.google.com [74.125.228.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B08252843C
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 13:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790169480; cv=pass; b=brKe7MEVFzrogMBMEh00owTvb/G6YSROlxWGUB5HqSdt3S8eq6262grGT9Otq/tRKhbO4IF3c2GBzZ/32x+JbZX9v4O0D1zN2qYf+6NQlBlCecxv2ww/4JV4IU7Ojjj3dLgZHx3P6aQ5GdBuQQp81drqD7FJ4be1Z8RySMRCVFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790169480; c=relaxed/simple;
	bh=DvrVvCJTQQOy2Ljw0fC6mFfv7ZDXIe713sZSc7YfmU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UXmRyvu+UBExTH0D2bnRDhFD1qMJBal8HXQ7hJhVyFUYWpZYhxqTIkelvTcz/kMG9yXoo2CnwlBEQ4bDzxs7ngAlqzUKX8R6yZcufDMYri447XPTqdJTA+8bL+QdyjryhRTkGcN7r6Ld83bf9atJx8C26v3A+rEQ6jVuwa4tGnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JEks3zyT; arc=pass smtp.client-ip=74.125.228.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JEks3zyT"
Received: by mail-ej2-f6.google.com with SMTP id a640c23a62f3a-c2939166182so48310466b.0
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 06:17:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790169476; cv=none;
        d=google.com; s=arc-20260327;
        b=aTNsrvt7u+OZurHMog0X6QHUUhDmujoaijo1i7EI3WnLfhI4ZegmCuhv1FE2rAe9Ue
         dTp2jXHETqzza7fGw+jsLPRShj0D7uaybM7cpGD5kSAHcqB2kufY0SD4uwr59ieB0Aph
         6KHdhBdiopbwR5jnNZqVmgfKiVoOTrLDqC6useznmGACatqcZPjcCsU8CAzcZMLuDK5X
         6Sc5W9SFOMNwiq628SOvfOK+/5lJZOJvSwJXkWOCEPSkPbmdjXJvoquhVKUru4FDAazN
         o+s5bzFiKgV51UvGnK4iTfMluiLHbNSr8/XgtdA9XvBRaOypHo/z/j8BEWVup/xLuIUq
         /rjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=DvrVvCJTQQOy2Ljw0fC6mFfv7ZDXIe713sZSc7YfmU0=;
        fh=dSN9Js51CUMDxRUuWVIXs2oNyfSh4eqt8dw3VgkKzoA=;
        b=Ke64r0z82mhfvTZu+2wH16eezwYmNW3g28M33CYG4iY3RndIvV7buAfhRRBzZQdRcp
         FDT7vT3ItMbnpU8fiJGjbf+FxQM2LGa+bDtPwj16hIslE00YsGBfSS22B0r1nlwv39r9
         rXl1cq0lZGAnRpxTtoZwai297v5kBNYmsw41o3SGUVK/D9aON8E4xgYI3qExx4xZUjc4
         mrss0R9IUDGQTDy4UDhgGq3zI+BV/qI7zOlO8kOY9TlHCG3rrxg/u0sfdHgFxiDLK9wI
         ewN9IAjKEDTvZxYH9ojLlokzW55ueEF2FZCruuFarQgcZw2QyvdRMWH0ibR0G/9J/vgO
         mS9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790169476; x=1790774276; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DvrVvCJTQQOy2Ljw0fC6mFfv7ZDXIe713sZSc7YfmU0=;
        b=JEks3zyTKMevzI4WFusqHT1XBVoTE1QsMGne8r7dt0EIly1YMue8Yno7PA4WBVcy7c
         P+cuWtNuDyks0uJNgxI2ZtWH2lMy4luPF8Dr66MNfEfmAIMMcDxjbdvakiWS8/QfNNys
         0WiNQU1z67kNKE0+gvBOchxLnsr9g1ilrqwtjGiOSQx9B7HBawpEP2MiBbRnGhlSsYSG
         afPFKXlu2GCsuLBBAKLF5Dfk6itSZQhZ1L2XwvLbeQG8mUQdpSmDS5TU8mgS1uLILpr8
         kk71Wmxev1ywODGNWUQl92Ncj6NySLZpTNWGKmUwUDyWMvYcpZkMpb9bsnVlHRrfeUMR
         u5vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790169476; x=1790774276;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DvrVvCJTQQOy2Ljw0fC6mFfv7ZDXIe713sZSc7YfmU0=;
        b=Eb6wUEH5AI6iCtT1gUfeGUOIJolTv3UWp9ksmkxz8u8o8t+5a/XVekch0Nb4GPs/Hk
         mjSSxelywNCDlngxGUlJYe1qESIxuPPRkI/rVpgxbsLKLmmHsmAvKMTS0Z2yOFpzFB8K
         7vgmWfPh/339PQUhwhQtKtFVGZKlwWhqQe/BfQOF/+1QuU2yVG5siSNSoH2xX85Y+stT
         G912BhJbsfRgZfCeD4FKd3wxapyJreUkwMfgx7gXWBY4BD2jbqcxT1CcHE00caU9aLDQ
         xMSXEnjRozqE0ARMCQXFWhp5yRi0kHTaqVDC7UYl9ROr6aHJToDjUiLXH54ZjRc36+8L
         MvxA==
X-Forwarded-Encrypted: i=1; AKwUvBxFVxIUjpO19kMmJyqJi7+JRx9cGKKVxVH45PHf/HbpsvdlciCT0oT1K+pc3UnXF3JoMmo+QBk=@vger.kernel.org
X-Gm-Message-State: AFuF++nyfm3OTG8mUBQTb6vBsZY52F2ztY+zvzEfdG6RnFO5blBkz+h8
	xJcDxVfTL+NK5Jk1yxEKWEoNm8MMAqvoexRJOlVp+3VfDQ9/2HR094Tgi2nQAcR3v/HLl677xYQ
	hzC/Xz2Xumk7nqR28Fsc+q2zzoJzAvCc=
X-Gm-Gg: AYBFou2pCVogYTklLsmbSG5PMqL09SWhKCElJ3SNdLOYGjlVnOszCfSuV6Ha2Zieasv
	RyaXIvim2hF0KHDcqziAGpArYt6wXBhLQUkJFGarBD1S7vFXGD5HZcZvN5I46kUW7JMwUiEd4zy
	LqZJKo1iZswiqRym9H7PkmxC5+JUyfMm0aA6ay8FuSgez5xvj6NjtWLbkyeAsczWyGOl5soH+x7
	rUAPCn2EhSjhWM64zaLhzc0Xh8W1Ndvbq3S+lOrZQR5/11s5QhVJ8r0WjKW21WKGdDQ9nah9RVP
	HxSgNKLC4tLvqx/4ATWONstjIJZGfCvcahKPomlp5Kng7nNca5hLjFiUHXoP/ekDHooh
X-Received: by 2002:a17:907:9409:b0:c25:8e4f:6d84 with SMTP id
 a640c23a62f3a-c2aadc98eb9mr212676466b.2.1790169476343; Wed, 23 Sep 2026
 06:17:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923-qcom_xpcs_nord_emac-v1-0-4b1c682af70f@oss.qualcomm.com>
 <5135e15d-b6ac-476c-9a7d-b7d64e4eed5c@bootlin.com> <arOtU15iv5CWPUEu@oss.qualcomm.com>
In-Reply-To: <arOtU15iv5CWPUEu@oss.qualcomm.com>
From: Coia Prant <coiaprant@gmail.com>
Date: Wed, 23 Sep 2026 21:17:44 +0800
X-Gm-Features: AclHuK-Nd-SsXdAr_w0eePSBz9cFeJT2YpbrMeoFm4kjMm3oXLxfgGRct4bNM9Y
Message-ID: <CALj3r0gAaQ_CoS5_9Mmf5HY+Fu5_e74fbb+r0LstafMhagHx6A@mail.gmail.com>
Subject: Re: [PATCH RFC net-next 0/9] net: introduce Qualcomm XPCS support and
 add Nord Ethernet plumbing
To: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Serge Semin <fancer.lancer@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Richard Cochran <richardcochran@gmail.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Jan Petrous <jan.petrous@oss.nxp.com>, 
	"Jose.Abreu@synopsys.com" <Jose.Abreu@synopsys.com>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, 
	Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>, 
	Shawn Guo <shengchao.guo@oss.qualcomm.com>, 
	Zhangfei Gao <zhangfei.gao@oss.qualcomm.com>, 
	Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Content-Type: text/plain; charset="UTF-8"

Hello,

Thanks for the RFC. A few comments.

XPCS_ID
-------
Is 0x00000030 documented for Qualcomm, or is it derived from
NXP_SJA1110_XPCS_ID + 0x10? If it's the latter, it's a magic value and
I'd rather see it confirmed against the Qualcomm documentation or a
register dump from real hardware before it's used for platform
identification.

Non-existent MMDs
-----------------
Returning 0xffff on reads and silently discarding writes is what a
floating bus / unimplemented feature looks like, so I agree with that
direction. My pcs-xpcs-rk does the same.

Structure
---------
pcs-xpcs-plat is itself a platform glue driver, for SoCs that don't
need any platform-specific handling. Adding another abstraction layer
on top of it to cover Qualcomm would be glue on glue. Generic, Qualcomm
and Rockchip differ in power management, address window size (2M vs 8M,
...) and MMD redirection, so they don't share a probe path.

Pushing that into pcs-xpcs-plat would also drag every existing user of
the generic glue along: they would suddenly depend on GENERIC_PHY,
PM_GENERIC_DOMAINS and whatever else the Qualcomm path needs, or they
would have to carry per-platform branches in a driver that is supposed
to be platform-agnostic. A per-SoC-family glue driver, the same way
dwmac-intel, dwmac-rk, dwmac-renesas-gbeth and dwmac-rzn1 are
separate, keeps each integration self-contained and leaves the generic
glue alone.

Would it make sense to take that route here? My pcs-xpcs-rk does the
MMD redirection through a custom MDIO bus; maybe the Qualcomm glue can
reuse that idea directly instead of extending pcs-xpcs-plat. Happy to
help with the generic parts if that's useful.

Best,
Coia
