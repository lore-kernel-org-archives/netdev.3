Received: from mail-ej2-f7.google.com (mail-ej2-f7.google.com [74.125.228.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26323B9DA7
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 19:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791834489; cv=pass; b=pDZiCejpPGBSvcjx1mvY5nHD4xLCAkn2WNfXw7qiR+G7Yyw7EHIFoLQCcMXjHb+18VOCd5fz8b0yZptr2NKiqVwHgujAlPlrE5M7+Iy8F5i2bkpPyh02FxvNrnH7Yh7Y8Tthb60nd6RYCij1tGQ6vWo2TXNBzEhVZjH3o/CIGRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791834489; c=relaxed/simple;
	bh=UUoBuGmd8fFx8whvNQfzDXZoaxMzirKFYCsoIfjrUgE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=abN+IP2AXh/bPGfswgEzrvZOIBbi8hHCmqiGrHeb2LCqLSv7BwtcgTwqzfLVbfb/8Is0pua9xUU4BnSlOl93D0oH1QLWEj0LCg7ss6OInXk8ilv3FL/v8ohMO5n8ro4vAc9nEYBiUNof1MNPi3F3ylsOsNHye2x9CvoN5mtZWPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PbfXMxYo; arc=pass smtp.client-ip=74.125.228.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PbfXMxYo"
Received: by mail-ej2-f7.google.com with SMTP id a640c23a62f3a-c2e15e7ab2bso177452966b.1
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 12:48:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791834486; cv=none;
        d=google.com; s=arc-20260327;
        b=op0csw//SOfiI8wEuJzciLVvhhOfW49Vc/MIkmqd8GMOjVnyLxC6XsCfOnbq+x65Xh
         5Hdj8Q3GCWUvBnZX8ndc3I/nFh6f69DshILQj+ekCOMCGiPHjRVSb0HQMF1JRd1z4N5Z
         yzN0iPxHQTxVInXIBPbWPnTZUIy05OZBumY5/AIoryuO7xAInE0tQxdKFtEEpTY2tUwh
         8fgfRT/5Sr9k+WtwlV21b6XbzPhYBIiZzXFdafXIkc1knGGxbhy8igdiXvEsIioKDO1f
         +aqKJWpZv7SN9onWunus86xhPbf+qprNx6hFB2QyRRm3cikML6MHXxY/HrAjPT1Wf5az
         qeFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=hePjOQgDk2oAPjPtpp2sw4T2GMv65ZXd7JkCbKndfRI=;
        fh=GCH9w4ggtMdlkBSiUPWk3fb09w1ukqMCFce5UcvqJtI=;
        b=cwoBMZZDyV6HVeIiK5vEddgPve1F6+18PYAteSeIEqMJKRqsc5WOy/C0QCvpdB0AIW
         jWtth+1VpmuERob/0O8F9SIyEByYjEOPnqPvM2/r59DcCgpU/MdnuVto0n+LISXku67P
         h3qoftyqH+VYkbLIYzmfBZCldnqocO++qT1dXK/6LmYBWSVcyIAvWxJuMhfa07OYV2s0
         1qG87Tx7uxJ+cH03xhWwvC5iAru9ugbd3du0A15Y2gr2SNJInXzSSnrJ0felRp+yUUzY
         dZjIFc7++J3Na51XrvvVi+X3VIFAzWR/jq6IZS5P5odXwI9dBQKOyist1Vh4e3MyRwoO
         OEcA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791834486; x=1792439286; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hePjOQgDk2oAPjPtpp2sw4T2GMv65ZXd7JkCbKndfRI=;
        b=PbfXMxYoV+IJF6WFfYZACO/m2TGUiukl+htKnJ3c3arVPN7w8DiFr79bHOG2XR6U5y
         x30gxpDgXdwMQlMTN76JFPdGylJo3bQmBSZjoYxk/EyhfoTiId7bXMELzH197SEtpH9/
         KEBbiwL/x+v15i2bgvu2kuEtKZn60JcpMiUu9xXXwAvMeJW5OWK2WfocRE7n+Rxz5n7k
         X43nul5EkCvnxhnxYNLlSGeOaQOM1H0IIYrRIXBCZi+1jXvIlor3kDEoN54vhQtt6B40
         zz1GKPGRvTAX3HDqSHkt1A7549o3VA7x228AZOAxtswbuY87vHALOakHDwRbJcOtLRrW
         TfiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791834486; x=1792439286;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hePjOQgDk2oAPjPtpp2sw4T2GMv65ZXd7JkCbKndfRI=;
        b=wvvF9RatqqNvI4+A0JfxMoEYBUxJpKIqj44hHnZSd5Nj6GeXEJtNvZws1g6gRmOfHz
         8BfHZ17mbl75eEuKu4rhq+MPIQhOyW/PeVVsypHoIqPFctYDeam+q83josnu5OE2Okay
         KG3jrWt1yZCifwpizFjS5NE9JhEboi7qvA2cNJFCjkhmH4+TTfinBXvnrCDS7U58if1K
         m64IIg03NXzGc665b0nEhcp0L0wNWfvve/KgxKvBxmgB9clPznFu6rBzF8kkCOLQhrsl
         mHNSlkf3IqhPdj1iHBZdRxS5RHe0dO38/rG+n/N88mnM7aWrca6bLPs57VKOZYs15E/Q
         pnXw==
X-Forwarded-Encrypted: i=1; AKwUvBw1Jw0c4Je4uvOVlUffYYKWAvj2wNgD0sOP9KSIpL4lHiJfUWw/UZrlCUClD6fkzFvf4oT4U8M=@vger.kernel.org
X-Gm-Message-State: AFq9FYLYIVV2WJYgSHPgW+wJDXewufPCV+ZBDzgOO8/RwZ7MeMS2eCuE
	3L6hpFO5Y35XlVs+COVszEhzBLY48GQtuDQOIbtsYabs5RpbRXo+3lYXkIYnh8TRxQHR3w1hJOA
	8xbqs91Or98TqLbcASEPutA9tVCswlYg=
X-Gm-Gg: AYBFou2fCVlXfzltGtaJLvY4rbPRXaDvVJcYeXGuxZRgMM4Nzq9iHNUdw5OcdAAtVze
	Ms/zCXtdt5pNS2d9s0Lg4AZaTdrbrgrmlVAjy2RMk0nIJ7fb5bj6D6DXcRenzUw/t2Ar8HhsTew
	BHKVQDk7u9HsTxWi203u5mtJr5bOGDwMIIzYxTRz5kDDIEuTkK3SWVlbMNFYezvygAz+cp6pe+N
	VEp4MUh7i6BLscczh5JS68Uej6US6e0MUnW22+nEc6c7FtuPCn/vVM8GyjvhuiEtUX6PBUfAXxV
	Gl3P/eoiOqt9uK68raDkbMF6bOpMflhNdAq0A3wN70uP3QV3UZ8M86KxJg==
X-Received: by 2002:a17:907:7b8d:b0:c2d:d9f4:2c85 with SMTP id
 a640c23a62f3a-c31aa0c129fmr992438966b.41.1791834485955; Mon, 12 Oct 2026
 12:48:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260919-s32g_serdes-v3-0-9d68868c1e89@oss.nxp.com>
 <20260919-s32g_serdes-v3-4-9d68868c1e89@oss.nxp.com> <6aabb56e-406f-4d13-9fd8-54822202039f@bootlin.com>
 <assmUIvWMuZsp8OO@lsv051416.swis.nl-cdc01.nxp.com>
In-Reply-To: <assmUIvWMuZsp8OO@lsv051416.swis.nl-cdc01.nxp.com>
From: Coia Prant <coiaprant@gmail.com>
Date: Tue, 13 Oct 2026 03:47:58 +0800
X-Gm-Features: AclHuK-mWeAUUjbT2q4HaMO7I1jbUFx_FPbAu9P_i7ekNoCvSs5mbKy3dUi7DkU
Message-ID: <CALj3r0gQkUARS1e+2CGB3JsrGJ2XrzuoChfz0cWYRpK4kq1Uxg@mail.gmail.com>
Subject: Re: [PATCH RFC v3 04/12] net: pcs: add NXP SerDes XPCS shared core
To: Jan Petrous <jan.petrous@oss.nxp.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>, NXP S32 Linux Team <s32@nxp.com>, 
	Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Bogdan Hamciuc <bogdan.hamciuc@nxp.com>, 
	Ionut Vicovan <ionut.vicovan@nxp.com>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Clark Wang <xiaoning.wang@nxp.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Chester Lin <chester62515@gmail.com>, Matthias Brugger <mbrugger@suse.com>, 
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Richard Cochran <richardcochran@gmail.com>, 
	linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	imx@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Jan,

Thanks for the pointers. A few thoughts.

> Yes. The S32G accessor is the same DW indirect scheme pcs-xpcs-plat
> implements (page into the viewport at 0xff, then the low address byte
> at a 4-byte stride), so there is no reason for S32G to carry its own
> copy of the XPCS code. The next version drops the shared core, exposes
> each XPCS instance as a mii_bus from the SerDes PHY driver and creates
> the PCS with xpcs_create_pcs_mdiodev(), much like the RK3568 glue.
> Details in my reply to Andrew.
>
> The part that does not fit pcs-xpcs-plat as-is is ownership, not
> access: the XPCS windows sit inside the SerDes subsystem register
> space, and their bring-up is ordered against the PCIe lane and the
> other XPCS instance, so the bus is registered by the SerDes PHY driver
> rather than by a standalone snps,dw-xpcs device. The accessor itself
> is a few lines; if Alex's pcs-xpcs-regmap is merged first I will use
> it rather than open-code another bus.

On the transport split: I think the cleanest path is to split the MMIO
accessor out into its own module, say pcs-xpcs-mmio, exporting the
read/write helpers. Then pcs-xpcs-plat can call into those exported
symbols instead of open-coding the page/stride scheme, and S32G can do
the same for its indirect window. That way nobody carries a private
copy of the accessor. If that turns out to be too invasive for plat,
keeping a separate pcs-xpcs-plat copy is workable too, but I'd rather
avoid it.

If Alex's pcs-xpcs-regmap lands first, that's the natural place for
the S32G accessor; pcs-xpcs-mmio would only be needed if the regmap
approach doesn't fit.

> S32G needs the same kind of thing: skip the generic soft reset, and no
> EEE registers. I will start with the existing PMA-ID mechanism, since
> that is what TXGBE and FBNIC use today, and switch to a callback if one
> is agreed in the Rockchip thread. I'll Cc you on those patches.

On the shared-core duplication: rather than copying the whole XPCS
core, I'd look at how the existing users express their quirks.

Wangxun has a genuinely different PMA ID, so it can branch on the
ID before the reset path and keep the generic core untouched.

The older NXP devices do the opposite: they fake the PCS ID at the MDIO
layer so the core sees a magic value it then interprets. That leaves
the magic in the core and a fake ID in the glue, and it doesn't scale
to a third user.

For S32G, I'd prefer one of these two approaches:

- A flag in struct dw_xpcs, e.g. DW_XPCS_NO_RESET, that the glue sets
  and the core checks before the soft reset and EEE paths. Works when
  the quirk applies to a whole instance regardless of the PMA ID.
- A platform callback, e.g. plat->pma_config(), where the glue can
  return early to skip the parts it doesn't need. More flexible, but
  also more surface area; I'd only go there if flags aren't enough.

Either is better than another fake ID, because the quirk stays visible
at the point where it matters instead of being hidden behind a made-up
value in the transport layer.

One question: how does S32G relate to the earlier NXP devices already
in pcs-xpcs.c? Same IP, same PCS ID, same quirks, or something else?
If they're the same family, it would be good to clean all of them up
in one go rather than adding a third mechanism on top of the old
fake-ID one.

Separately, I have a plan to propose platform callbacks for the XPCS core
at some point, regardless of whether S32G ends up needing them. The
core currently has no way for a platform glue or PMA to limit or override
parts of the generic behaviour, and I think that gap needs closing.
The exact shape can be discussed once RK3568 lands. Happy to Cc you on
the related thread when that happens.

- Coia
