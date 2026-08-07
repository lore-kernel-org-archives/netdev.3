Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09BF36195B
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 20:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786135749; cv=none; b=ApbC9JLdRGwiGLU4nyNVhc9PwBojDi+U6VWaJdmmWRMk5iSLLdolJjkvEVOnM/zQ+JVShIyP6TVaaOMlr6qslvFleidLLQR5qr+J2RtqjsQEI+PxWR3dGdUhoH8rOhTP0fEl4il0vswcA4uI/XGjbOGYU8Bb3jXsryF944W9O9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786135749; c=relaxed/simple;
	bh=hPfLP0hNorT8EBMoNPQqNYVzZGRJ/RFzthEnahRhP5M=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kGh1cA1KQ8Ghs4tprSDGblOtoOSMlvrHMo2cp1oiPzYJpcfNkZYEvv/Gkm5meEeC/AOBixhldV6VEfj8HzZiD/cyb4CVkelLNVza0G0QciXKwnIl8NvswfzijIhPAaDcoeZWcsgqxwh8Sp1+CGfcgZ5ysCBz6ejut+9SofJoRGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sQZ9SSUz; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sQZ9SSUz"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47ffaa8ebbdso1694793f8f.0
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 13:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786135746; x=1786740546; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:subject:cc:to:from:date:message-id:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hMUCiIk8VKHfw+lDvF1xcsVZxv/BobscGATfjEcSu3g=;
        b=sQZ9SSUz92YYydrsguNsMUdM9asNKlahxaWoS/C1CLFi+n+B+6axBRy0am452THdVh
         QkjrY+Uu3OQkLIE4juPmncSCEzwXBUVAMUvSQEDUpjkCUGLr0mmoC4Dg6DNWs7u64Y8J
         ZgTdrASJIeTVtzlpWKaHLZEoQ3uRkJNRdTZqOz6+CIVImdsyZgJbGWYeHyP/aeqs6vLe
         0ocK3FMIcPcL54O/pm8nYvImYoEqA8sbuLBfj+vG4m4N5hC5I1RS5U/+IeY3JcaOTxk4
         0cGEk6RIICsdJ4BAk9wGN4Kvec45WAb0B3ixvP1vfO8hSOO6xlmFI/zG6BA+TU9fOZIi
         GmyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786135746; x=1786740546;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:subject:cc:to:from:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hMUCiIk8VKHfw+lDvF1xcsVZxv/BobscGATfjEcSu3g=;
        b=EcpqrPiZAAjKTEZ35n8VRHoLxxivWaMily50VrYLuj6DQJN8K3lYMdMESUQ7DtnaNx
         Mh+F1Dr5/MpVQg46m2XqDrHzimQPsVDYQ1ZloxsYBQHVH96ixgn06kkEKe6fh8x3Gi3F
         FB0E4yFdrictcF1nolmBKHBe5SyuWeih4OGgM10JJVe/leT58ouSQ4n4uRN6LgQXO+zd
         0R5BjG4wvYwPrxFK2PNN8AdPZByYiHDnL4V33mCOjI0IP/02vXPZJsgJfylKL7cmFLxt
         PrY7DYfSbp7fVWCJa+HyNTBXIArIGOKy5XuJxwFF11CIzj+TClM8NCTDrDZq2PQ0an+y
         kDPg==
X-Forwarded-Encrypted: i=1; AHgh+RqSbpASsrENF5qBWcPxUy3RuyIoAmhHXlw3wrhngSBPqsfUMfmmqibovY3+gvmMkg5ZtkKKn3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpB6iinFrPA9rgwWHF0PliWumyOS6lBu9aBrdHDXAPwx5EjQ74
	Lsgcgihk/0utz+gfm8uLWPlKZNHqHLCYejIhYBb5SS4CrqVI62CQzpWC
X-Gm-Gg: AR+sD13z0t1cYStKsJZrioVH56md/CTILgyjesS4WlU+OOMFmGvpOVEd7AIvaGjovXN
	NPddFTl8G553bWvAI09PI0SKImS/i28ZolEpg3JzINAEQ+noX6gjG4vnVGy+CwDokfXgv5Y/1Js
	IhGYrsWtP71rieRycUWoIFzVg9JLQaJGkh7h/2nXRSMw6Ug9IGSfcs7uEldjqAjsd0ecVuhEsxY
	bSL+xfSVywL4BR6CQ5TnkBEM58NwRw+sUd6/7ikEf6KcsZfQZSRKCbCgCARh/zTZw61cr/tWmqM
	5lam27fUgKYMSMr7Ikx8LiUxPzdUADucBeGOuyFwrYsY6e1VW+R5eRNGF9CqHHVYnt/AwIf+TOO
	SZfUNdcnt2WSanqlF8ZAlskvfLKPgU8gF77DW32s7n4ijTUbA/0WrfIBR0sbnh+cY3k8sL0wgdc
	ShShmaoCpmm8Oi/+ky0wKiSHuYPy6NPwfmkHIgwN7ZSLcs9fF85EGgtYiBCM2FN5OpWBSULSNJk
	r1uTiUZwVujU3o2wUkoD9LvcPAEgQu/aAh+
X-Received: by 2002:a05:6000:41fa:b0:47f:fa17:ae0e with SMTP id ffacd0b85a97d-47ffa17ae68mr22949317f8f.11.1786135745578;
        Fri, 07 Aug 2026 13:49:05 -0700 (PDT)
Received: from Ansuel-XPS. (host-87-19-255-168.retail.telecomitalia.it. [87.19.255.168])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021e8b09sm9756544f8f.23.2026.08.07.13.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 13:49:05 -0700 (PDT)
Message-ID: <6a7644c1.df882948.3a7741.2280@mx.google.com>
X-Google-Original-Message-ID: <anZEvaEjN5i9h5ww@Ansuel-XPS.>
Date: Fri, 7 Aug 2026 22:49:01 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, llvm@lists.linux.dev,
	Daniel Golle <daniel@makrotopia.org>
Subject: Re: [PATCH net-next v11 03/12] net: pcs: implement Firmware node
 support for PCS driver
References: <20260807131301.192060-1-ansuelsmth@gmail.com>
 <20260807131301.192060-4-ansuelsmth@gmail.com>
 <235c60e9-f19a-4336-a569-ddf5e5462fe5@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <235c60e9-f19a-4336-a569-ddf5e5462fe5@infradead.org>

On Fri, Aug 07, 2026 at 01:29:41PM -0700, Randy Dunlap wrote:
> Hi--
> 
> On 8/7/26 6:12 AM, Christian Marangi wrote:
> > Implement the foundation of Firmware node support for PCS driver.
> > 
> 
> > 
> > Co-developed-by: Daniel Golle <daniel@makrotopia.org>
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  drivers/net/pcs/Kconfig          |   6 +
> >  drivers/net/pcs/Makefile         |   1 +
> >  drivers/net/pcs/pcs.c            | 240 +++++++++++++++++++++++++++++++
> >  include/linux/pcs/pcs-provider.h |  65 +++++++++
> >  include/linux/pcs/pcs.h          |  75 ++++++++++
> >  5 files changed, 387 insertions(+)
> >  create mode 100644 drivers/net/pcs/pcs.c
> >  create mode 100644 include/linux/pcs/pcs-provider.h
> >  create mode 100644 include/linux/pcs/pcs.h
> > 
> 
> 
> Please address these warnings:
> 
> WARNING: ../include/linux/pcs/pcs-provider.h:39 function parameter 'pp' not described in 'fwnode_pcs_del_provider'
> WARNING: ../include/linux/pcs/pcs-provider.h:39 Excess function parameter 'fwnode' description in 'fwnode_pcs_del_provider'
> WARNING: ../include/linux/pcs/pcs-provider.h:62 expecting prototype for fwnode_pcs_add_provider(). Prototype was for devm_fwnode_pcs_add_provider() instead
>

Yep, they slipped in the rework. I already fixed these, just waiting the
usual 24h.
 
> > diff --git a/include/linux/pcs/pcs-provider.h b/include/linux/pcs/pcs-provider.h
> > new file mode 100644
> > index 000000000000..5df48022bc6e
> > --- /dev/null
> > +++ b/include/linux/pcs/pcs-provider.h
> > @@ -0,0 +1,65 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > +#ifndef __LINUX_PCS_PROVIDER_H
> > +#define __LINUX_PCS_PROVIDER_H
> > +
> > +struct fwnode_pcs_provider;
> > +
> > +/**
> > + * fwnode_pcs_simple_get - Simple xlate function to retrieve PCS
> > + * @pcsspec: reference arguments
> > + * @data: Context data (assumed assigned to the single PCS)
> > + *
> > + * Returns: the PCS pointed by data.
> > + */
> > +struct phylink_pcs *fwnode_pcs_simple_get(struct fwnode_reference_args *pcsspec,
> > +					  void *data);
> > +
> > +/**
> > + * fwnode_pcs_add_provider - Registers a new PCS provider
> > + * @fwnode: Firmware node
> > + * @get: xlate function to retrieve the PCS
> > + * @data: Context data
> > + *
> > + * Register and add a new PCS provider to the global providers list
> > + * for the firmware node. The relevant PCS from the PCS provider
> > + * is retrieved from the passed xlate function.
> > + *
> > + * Returns: A pointer to the registered PCS provider on success, or
> > + * an ERR_PTR() encoded error code on failure.
> > + */
> > +struct fwnode_pcs_provider *
> > +fwnode_pcs_add_provider(struct fwnode_handle *fwnode,
> > +			struct phylink_pcs *(*get)(struct fwnode_reference_args *pcsspec,
> > +						   void *data),
> > +			void *data);
> > +
> > +/**
> > + * fwnode_pcs_del_provider - Removes a PCS provider
> > + * @fwnode: Firmware node
> > + */
> > +void fwnode_pcs_del_provider(struct fwnode_pcs_provider *pp);
> > +
> > +/**
> > + * fwnode_pcs_add_provider - Registers a new PCS provider
> > + * @dev: Device of the PCS provider
> > + * @fwnode: Firmware node
> > + * @get: xlate function to retrieve the PCS
> > + * @data: Context data
> > + *
> > + * Register and add a new PCS provider to the global providers list
> > + * for the firmware node. The relevant PCS from the PCS provider
> > + * is retrieved from the passed xlate function. While at that, it
> > + * also associates the device with the PCS provider using devres.
> > + * On driver detach, release function is invoked on the devres data,
> > + * then, devres data is freed.
> > + *
> > + * Returns: A pointer to the registered PCS provider on success, or
> > + * an ERR_PTR() encoded error code on failure.
> > + */
> > +struct fwnode_pcs_provider *
> > +devm_fwnode_pcs_add_provider(struct device *dev, struct fwnode_handle *fwnode,
> > +			     struct phylink_pcs *(*get)(struct fwnode_reference_args *pcsspec,
> > +							void *data),
> > +			     void *data);
> > +
> > +#endif /* __LINUX_PCS_PROVIDER_H */
> 
> thanks.
> 
> -- 
> ~Randy
> 

-- 
	Ansuel
