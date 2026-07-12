Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFECE381EA6
	for <netdev@vger.kernel.org>; Sun, 12 Jul 2026 22:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783895469; cv=none; b=G17+Xdpo5HWgBWd1UE2YYBLwteWKQ+OlMncvk1C8HiatYlf2mhRgoyokHZhajlmacWb8VaNNQjHViYAF+rGoXsFJ9K/tNfgltm/QiMJhCavWLxxPqw9G8le3yKrBMCSBybovp/tW8aFg+StGStEEhgl6xQ+IAUf8PXDmXOghgV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783895469; c=relaxed/simple;
	bh=r/9cZmwMbzZYu/sWa1YyedHNy8cyXT0ISxuu1zNc3ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tPmSfABaM6HM41iVScPkI8vVPVjRvmpfgVEAKjBjXzA7AiDH3HhvD7F+10KbJamiP1f36nh5m68SmY7XL7+SZSsN9HeW6h+PROw2XxD3i4+d00K40zkF0PvHkTo3ihHNirUfWh9AcbhusjPKNcwN1/DHq7s4J0Yn/t0TrjS449w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q/VBMPof; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/VBMPof"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8454160043aso2436676b3a.3
        for <netdev@vger.kernel.org>; Sun, 12 Jul 2026 15:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783895464; x=1784500264; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=m0aMkvFlpD7qcpmPu98mFfzTGpFjwWgjgBJW3Blyf0I=;
        b=Q/VBMPofibzRLl7W83W6Q32uq2aBqdj9vc7HiBaKbx+t1EG6Kt8jDYbzGF+5FIn/fW
         FgWSbju+gEnMoEA3bVmJTheNmBTgGS7fe+381Mw2VkhjPU7cjbrxaOROeH+9nH56fDfi
         ZDSRP7t2wgt+4YhBT2pG61xm/fakaKt4eAfpkWNQDnXT5qU839Ke7PTvFoIBcy906u4s
         EiArTIyIUuIcjOD8cXIZZWyxw/+LTGDGdm+LlRgUonorrAYl7lOtV8EYwbKNzfa4KXue
         4l3s8oP0vIbe5aAIluTUbPAM7f8wgpOGr6mN2L4gufXqoO9mHVz0thOpPWhFDLEi0VVU
         I+iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783895464; x=1784500264;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m0aMkvFlpD7qcpmPu98mFfzTGpFjwWgjgBJW3Blyf0I=;
        b=evqz1ras6EBUTaJE0owjURoRGvbW8fmeY5H/uZeOBL9s65vSA7viGY1Riv08W3bvyo
         QSVz0cJnoEuTw0DP2NIAJXTNBCylbcWfLqAJBjPwjYW99kNHp4Z5kbIXUeP+TF7vWtze
         oulm5b7yr5gtzBRJ46O59tNjFcltLu0eMEvRo2PvBlaihteRHYou0kLOzccEZJkhf5/y
         IdnIQEWmlh6Uae2LXK/eh0mmzDZ8WwwGytymA20bChppDaoajVANY0b5771/hEvMvxA8
         xWdqX74aMcpTwuDT+/4uRinwr4tprMtTi6XLDtSLQSnxJ+JFKPOriVnTk7ppj2Zd00vr
         8K+Q==
X-Forwarded-Encrypted: i=1; AHgh+RpUwpDy5Cb2myRGj6BQqpl0QA1boihD8xPhVMvdwpK0IfWR9W55P4+evsvu+my/WtoksO5Dfy4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRM8APEJS0a4Pq1rwwAHXYfdPX3y9HPLGoY/bur3eMsdDpSYFw
	AJ/coVtYVANuXMvzVJJ4lG5RIi60u5/DWMTkFmpyjAvpC2ZRC/n7gmZO
X-Gm-Gg: AfdE7clErivp1TtzJpLFEK5rwCQwTO+UsTdUGbMy+rw/GdPrUp4BFCre2NHShTTChSw
	wNgFctdhKZhbbGVSnQTCDSLggBizMQssZ96n+I+jGlbujvDW1TKNES08GnK0XCWvp14DSIr+CVB
	y2iZcQGSfv0xibSSidjmOBzV0Qgf8F2OKy+vAo5nW3UADiAkXdLsZ0O4c2CowUQwDu8SgQNa2lf
	sY+K2tlJDeHTdmX709K6omOfgsXoYFe+F7MXesvxun3cGOsmmXcO8D9ozTNyJIw7dL5dnZ+tU1e
	cMrRrQRSBvAozLLvG9XfRP6OYu4EcuIQxShe8ZckqkQKeqhEoyVu43oz6hDMSnkSf60cN5y8sol
	AabAZ0TpE77KV8LZMR9yohTFaPkzwUiOjVmW9ABH2nPVEBfkHK5Dj+gLmJT3jHp2M
X-Received: by 2002:a05:6a00:3e24:b0:847:86b0:888c with SMTP id d2e1a72fcca58-8488971d94bmr6700212b3a.48.1783895463640;
        Sun, 12 Jul 2026 15:31:03 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a3b8d3310sm345744b3a.40.2026.07.12.15.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 15:31:03 -0700 (PDT)
Date: Mon, 13 Jul 2026 06:30:19 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Inochi Amaoto <inochiama@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Yixun Lan <dlan@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, E Shattow <e@freeshell.de>, Han Gao <gaohan@iscas.ac.cn>
Subject: Re: Failed to reinit phy of spacemit-dwmac when reset-gpio is present
Message-ID: <alQVRx2vCWnqCDEs@inochi.infowork>
References: <20260712045233.800748-1-inochiama@gmail.com>
 <bc78469c-3f45-4234-88b0-49f050d651db@bootlin.com>
 <8689bf7d-e00d-4097-bd3c-4d7d7844d1d2@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8689bf7d-e00d-4097-bd3c-4d7d7844d1d2@lunn.ch>

On Sun, Jul 12, 2026 at 03:49:43PM +0200, Andrew Lunn wrote:
> > > --- a/arch/riscv/boot/dts/spacemit/k3-pico-itx.dts
> > > +++ b/arch/riscv/boot/dts/spacemit/k3-pico-itx.dts
> > > @@ -196,7 +196,8 @@ &eth0 {
> > > 
> > >  	mdio {
> > >  		phy0: phy@1 {
> > > -			compatible = "ethernet-phy-ieee802.3-c22";
> > > +			compatible = "ethernet-phy-id001c.c916",
> > > +				     "ethernet-phy-ieee802.3-c22";
> > 
> > Indeed that's merely a workaround :(
> 
> Despite is being a workaround, there has not been much progress on a
> generic framework for dealing with clocks, resets, regulators etc,
> before probing PHYs. So this is probably what you want to do.
> 
>        Andrew

OK, I think I should accept the fact and let this workaround
solve the problem.

Regards,
Inochi
