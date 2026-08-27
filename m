Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8844322EE
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 10:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787825956; cv=pass; b=Vkp4VN8w/bKKt9c3CTkbcMOohz2OY2Or/Sm6ezY7MFlVvrzkG/WJiNfAEQ8S/A+HV1XJNkNjChEB5ndjlh+xZfuWdyP4lgpV427GABn9wjgXeAJSiuOSL2eHef45TuxkxmwRCUnPwoGr4WsIIHMu6S2fCuI5gaWyIuAI3QfXRKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787825956; c=relaxed/simple;
	bh=6qj/65Z+1ZPPWofxXA6mm5Qgq8bVGBO/ohXFA0XzNeg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=acL+Ok0efqr/32/UqwzToSXJPpOU7l64Dr7tg3blyGyuH9yCzVhy7Prpy6cRkK+JVKF4FrBiXIfPL4KCRjuVw6X7iJ6NtDANiRlaMeVN2dbSp1ScQzMa3rNocSbKEIHwbUz0uVuqKGJrApkWH0A8gGy3u89nEtt6h8Xw4fcgHmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ejXxQP0I; arc=pass smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejXxQP0I"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3968e063f84so1112341a91.0
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 03:19:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787825947; cv=none;
        d=google.com; s=arc-20260327;
        b=TPGaUaltcj4+6W9CC1mmV/S/DMlSpDapupdEclYY4YP1LPcZdxKlmlkVjfMr8XL7pG
         LoeAuR/nPaYovrJSEf/j6fX5AUjt5kI2b3qAKfIlw+iXJs4GnsvENen/qYodoL7eCOT6
         f+tGCRH1Uc9Fak+KzET15wkqNEtsfAtBhvteTerOUV30Ok/kcIw1hDfu+ln11EXBgzYz
         PtzS1c1JBZK2Puiz2qQwu2hfNHqSQZaCRt0TrkQejgMmQ4DgJJ30tVjJhfY63DPvu2KJ
         OMEWyxzcpKS7uunFK2nDJA9aR5wFK2hqWNzouWeWIXLfEDVRihWyxzZJZNF9iIINkfAR
         Ucog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6qj/65Z+1ZPPWofxXA6mm5Qgq8bVGBO/ohXFA0XzNeg=;
        fh=h3gvfLEz4LzqkgXMZH/60Lw5sQXXOIq55DrrFvTKVcA=;
        b=pog6cXVh/YQJvQLG47boPxs7HX3EXfOvRZB29B5cUAwZ8ze6UDbkU9VKgOEsZlT2pN
         fAcdQcXonRR1htJrLKLQ1ndAvIdhUiD0bZRZ4/10UQ+hJOWQKdGQxrmQk56JSG1r47xl
         g9LAPjBvR7yCayC2dO73kifbzAyzYzIzLHj8pYpU0LdKOv35yRjDX3XYAFPZIYMpjlJ2
         zDbXyGbjn6Z+KXsI/z6DSuoSFxSWQ6SFqIGbVIDMJjEWAn0+Ns+F+7/Fq6UAZX2/+Grm
         JtvgRJNQx2CQk40AM4qSj991hQl2ojkLh3PrYswV4nxRqd91J7hKS/vhCy+boAJHFabj
         NrMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787825947; x=1788430747; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6qj/65Z+1ZPPWofxXA6mm5Qgq8bVGBO/ohXFA0XzNeg=;
        b=ejXxQP0I7CCaWAmjObCJflM6Fr4/acFXFEyKPohnicj0nXHAAL0RIGBwNddaON1hLI
         HamQOTUgBAaW6qObdpLgIBAQPrlJY7G5dxseAuHebz6YBZ4p0rMktb2VL6GTi6IEGTlM
         IOmr0XdC0GPodkMYhU0TE59viVifs9IH3x2mEdtaCO7tsC2iE5Grf9WWwWn7MoJ41jwo
         2NzJOFl7ywkmJY+gK05sYvrPZX8vARGf9bYDbBcxkMDo8bxyg8emArxLAEebWycRE16N
         ph3VPW8B2FFCLgPKMTJW+CGrFtmLQKAHZMgYVQNbx4OKJkb8Tk7ujQmiEXHOBLDkVODc
         npEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787825947; x=1788430747;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6qj/65Z+1ZPPWofxXA6mm5Qgq8bVGBO/ohXFA0XzNeg=;
        b=FOA6uo3SJxUvZC3W3yVZnO7YK22lXZnoQVpi6wbE5h98KRZZlehsXrAUp/S60aghM0
         9Zqan+pnvKkci85z4nwUimReXrBCaqVSbbr5lOA7/GCWVMznMfSGeDyE7nV4O3ZFc/il
         6rQ0KHb1qMDWSjvS7BDfdF0MEAnNchCc4FLraAfhwgaHt6LTN08m9EED0sC8ZuyktXr4
         jyBLjMFoAwsTVF9cSPnnK0xkPxtDVOwHDBXMj5qRQnCnvx9HRY7MYAzfiXVEq6oUNtny
         N5Q+zQGXFxkUR8DjGwmbMd10wHU9CQhTV8ltOvDY2cavyqmFIY1FqSn3/mU4qBkVxc6T
         Rcig==
X-Forwarded-Encrypted: i=1; AHgh+RrgpeaiWMr/IJFcYqa6NEl+2hA6bFJGsA4WqS+ihx4JGXybFb9AnkzmLKLsPtNoA213op0EVZU=@vger.kernel.org
X-Gm-Message-State: AFuF++kLeLhuiHfldzd31LmHSHWXEEpfLqE8ItMYM0Unnl7ElIkTyAF7
	lwRXu6xJKBmA2T8F5TJgEpuFcyBlgol+7yn6UYUo6rY50qI2tGUEjUEBgqMXGKWsfX8y0fmpXrR
	iqbvrMkYtt5Sul6Z1/ccUD7dPDSz8mtc=
X-Gm-Gg: AR+sD10ycXwoM+OB7iRr6HoYDcGh1WUnkVHgFx5jfjNQzv8vkmA9a4VGEqx7yeEAQPj
	X3vKCe+RwJMMg1rm2rhjUOu7q4mwHuLAfQlFSz5Zh/vo2YeYAfwbfRBgQ/wxvLSQiuSpRSsNSEK
	ITnWthaiPo9zdcSeP3NmtMKNbg/37f5hreUBEFARjzzSWTQLCVceotNHhEfQl65BhNhkSSLg5A3
	AtOIn5Ux73VTBKv18x2x7dB8rblbW3cQgdrh1QwpejL1uBLsU/l4XdDMTR8P7KBOFs2Jt9QqlI4
	1R0W9hoyd0DZgaDyzRAXXqEiSUJoXdXjzITmOXVxAPbrXqzpISnq4OFIm/TZOrQNV5klmLuGwwV
	ZtI5jumLaQjAnsLLsc01cEEH/wMs6hmdtoF9gLLbfJMlPSK7xiJTasfU++HcwIbF5H6+dfRc=
X-Received: by 2002:a17:90b:3a05:b0:37f:fd1f:d30f with SMTP id
 98e67ed59e1d1-3966d44312fmr29209094a91.12.1787825947210; Thu, 27 Aug 2026
 03:19:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824-b4-fix-pcs-lynx-an-v2-1-9bb1dec96f0b@gmail.com>
 <20260827085533.2a3ocp6llvhzczps@skbuf> <CA+DkFDboHq+fw1bYdQR_2M9hM+Vp6W=jR0VYCO8u7KXWVq9F4A@mail.gmail.com>
 <20260827094812.52skjha73d3fddod@skbuf>
In-Reply-To: <20260827094812.52skjha73d3fddod@skbuf>
From: Patryk Biel <pbiel7@gmail.com>
Date: Thu, 27 Aug 2026 12:18:55 +0200
X-Gm-Features: AcwNN1WeOsZsxNO08-yfxpLxcwO7f39Zgvv2ZGhmdsOEBGKWZNaNyPRgbqIvBds
Message-ID: <CA+DkFDYx2ATtdvzKKJ5kNrhb+qJN2opcxi63ujFGauXR9mBa7A@mail.gmail.com>
Subject: Re: [PATCH net v2] net: pcs: enable autonegotiation for 10g-usxgmii
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 11:48=E2=80=AFAM Vladimir Oltean
<vladimir.oltean@nxp.com> wrote:
> > Looking at the lynx_pcs_link_up_sgmii, once the neg_mode
> > differs from PHYLINK_PCS_NEG_INBAND_ENABLED, the IF_MODE register is
> > explicitly programmed with speed and duplex values. I browsed through
> > the manual but did not find any similar register for 10g-qxgmii. This
> > may just be due to my limited understanding of this area, but is this
> > intentional? There is no need to epicly program speed and mode for 10g
> > qxmgii with in-band autoneg off?
>
> Yes, I suppose there should be.
>
> I also don't see a register in the MDIO address space.
>
> I do see QXGMIIaCR2 field USX_FORCE_SPD, but that's in the SerDes
> protocol converter wrapper space (which is handled by
> drivers/phy/freescale/phy-fsl-lynx-10g.c), so that's a bit unfortunate.
>
> Looking at this register, it's not clear to me how individual 10G-QXGMII
> ports could have their speeds forced individually to different values.
> The single register handles the entire multi-port protocol converter,
> it's not like QXGMIIaCR4-QXGMIIaCR7 which are per port.
> This is something else I'll have to ask internally.

This is exactly where I ended up with my research as well, and I had
similar thoughts. I would be grateful if you could let me know if you
find out anything more about this.

> > Given all of the above, I just wanted to add that I'll be on vacation
> > for three weeks starting at the beginning of September.
> > So if you'd prefer to send these changes yourself before then, please
> > don't let me be a blocker.
>
> That's fine, I'll also have some vacation time during the same interval,
> you can submit the work to net-next when you return.

Okay, great. I'll prepare v3 then and submit it once net-next reopens
after the merge window.

Best regards
Patryk
