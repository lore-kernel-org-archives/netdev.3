Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B53F29DB64
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 12:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790338720; cv=none; b=vEnnPLSVmvInJbx8LjyVFQQPZx97KPxcHEUKSLztL4hLsQ6UZoiyjKXN01cYeuKcqc8UUYJ1OUoQKJs6X1IOJBiD+YdDcDbWpiiuBTYh+0YD8m+5CYjae3H6iFKZNWht+6BwMSr2XVlvfkv7bLM20zEHW7Sra5LBNTm4a7lKM7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790338720; c=relaxed/simple;
	bh=w5Zl/EPNvC/XBW3ei7KCzh1t/4jW9CoaI4l+1Mti42E=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G01fFbOPu49sHbULsGxS8KDPwLhKOpVqzyqdTv8igt41u53h6W2Ehwi0dato5vTQkIrHrDyGohtIdv5ANbou2hvkNbbhiYb2aMgBZDdfqdq5ktOEK2aHjXhAey9ojZEG4sEBcKOeNovG1NuIJXVLpcsx0K4F6vHxZIcBePcEoGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OmCyWXoL; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmCyWXoL"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e69b9e16aso8814615e9.1
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 05:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790338717; x=1790943517; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:subject:cc:to:from:date:message-id:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pT/KmnLSIMqs/Cj4fywS3jj8PSkfoHHHPLTRKemb7E8=;
        b=OmCyWXoLA1DgDsDmPZauassFvnrOe/3gltaIPwqSH9hpbuhsX4V2WAwMHnXzSE05Rz
         hpBp4EhlFrNeW+3zKND0is8PoREcOEqun/J9C0mtzeekQpuzS3E2mkJKFUal9sJaqAog
         +SeXsKUspbDfDSALbwDkRk4x3tSxQf46SMcU3kD8WhMIolF4N1YMOLy9F8khhm+MmWv7
         twx/RyN3Eimqu6J68OANGUXS36ILkTmWYXGVPi17o9+gJQCVkAgBCliEa9prDdCDx0Iy
         zA0LOWJKik5Kdgx4Tn8vF8RVxRGFHTYebq2/u+W0QgzuXFAKmeUeRMPpCThcAdPRBIzY
         zvKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790338717; x=1790943517;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:subject:cc:to:from:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pT/KmnLSIMqs/Cj4fywS3jj8PSkfoHHHPLTRKemb7E8=;
        b=tvZRVqF+A2jEysI5nix1iF9qr1IivXPXNCru23mQUIHWofzVx/V5khyZqLwdDZGydY
         6NG+gGNQDW9vuriKFaOj7k0mioXo+zvVF1IsQRz9E2G6oT+4Ik1/3428ena5kd5ZOV7V
         YOxjxmociimjBDQuH/HpHI6hii0UhCHvky61HdLZ0Q8TDxkqKtkHlswS0sZr5+38amCC
         rmfv033vdYjR6pa4WOvz7kzYVr0blRahxKf2WUPkMMynQvj2YHEotHxqu/VofS/S/JMq
         kx7U41feVoNHw6i7JwfQKZ8uvpLW3IPMUO0MzMZhRHz6baXfm5jmBt2/fl/vIpfdAWng
         8smg==
X-Forwarded-Encrypted: i=1; AKwUvBzr5gzQ495RLO6HaG0Mty52OLFmpuL+RLCWtxdo9zmnqZjF/8K9MIEKio9+j5q6ZJD6Wg7jD3k=@vger.kernel.org
X-Gm-Message-State: AFuF++lPxKG7BkXeF3+RSsOXPN5c5lCOPv5CxC1VIFj9oiVcBx/tj5Z5
	Tb7hz4SUh/rRelrWvGbwUnSypyYnuSTB+e2D/IYeUIoCA6I3DVbJnJ0z
X-Gm-Gg: AYBFou1wO4SnYcnwWiXImoPfinPgunnPPD/UgBmufdooursAFmDidrRGmR3eFd7c4cR
	+N6iOllw/HI9ME95m1EvnHDK8RQk6SfkAZFIUC5D2V0y1aiG+sgiUcDVC7Id8ZQ5zPCoSBpYIB0
	2hozEKvOjbHgGUXqbmTMzKOQp/ezBKXEsHyeIS0KcDgvSjGawJhJi//lseicW6Ne6VjA79e0aLK
	g48b884z5uKznI0LWZ7x4Vn8xGa/zmFvu4mlJyEEXQMErH4MvK0q4IW/aW5QxL7Iv2/8FcdaIoK
	F/598NAqxAjWgo+cybfN8UHfMVXBU7psoKqaZ280WPobLM75hiDn3c/XFV7y5IHie1lkbB1Q2Sb
	ptmeYGupL4/0/51GTUiRy+KL3ljjjUk4CIw6L+gDv+NMoBTFlNJt2lCLWN2JDd8WdgIU1yeu+BP
	Dv4E3yGYjGZt0MYpFUOF0BRHlfieONLuCwM2IfLHrJkUi4BWTdv4CizUMCNLzv5wZt7GRk18BrK
	bLh7s6rGNNqp/BJT6BCtdAN0gYLeOVSTs2pMLWozsKWxt4=
X-Received: by 2002:a05:600c:c494:b0:49c:fa21:1c81 with SMTP id 5b1f17b1804b1-49fe7bab979mr84434895e9.22.1790338716731;
        Fri, 25 Sep 2026 05:18:36 -0700 (PDT)
Received: from Ansuel-XPS. (host-79-29-83-136.business.telecomitalia.it. [79.29.83.136])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fee915f3dsm57440585e9.1.2026.09.25.05.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 05:18:36 -0700 (PDT)
Message-ID: <6ab6669c.232cdbff.15fa39.f0d3@mx.google.com>
X-Google-Original-Message-ID: <arZmmhkSyvse_YVK@Ansuel-XPS.>
Date: Fri, 25 Sep 2026 14:18:34 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC PATCH net-next v2] net: pcs: airoha: add support for Airoha
 AN7583 SoC
References: <20260925072712.23419-1-ansuelsmth@gmail.com>
 <12d6e310-3aa9-45f1-925e-e3c8f2f0efad@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12d6e310-3aa9-45f1-925e-e3c8f2f0efad@lunn.ch>

On Fri, Sep 25, 2026 at 02:07:52PM +0200, Andrew Lunn wrote:
> > +static void an7583_pcs_setup_scu_pcie(struct airoha_pcs_priv *priv,
> > +				      int index, phy_interface_t interface)
> > +{
> > +	u32 xsi_sel;
> > +
> > +	if (priv->phy)
> > +		return;
> > +
> > +	switch (interface) {
> > +	case PHY_INTERFACE_MODE_USXGMII:
> > +	case PHY_INTERFACE_MODE_10GBASER:
> > +	default:
> > +		xsi_sel = AIROHA_SCU_PCIE_XSI1_USXGMII;
> > +	}
> > +
> > +	regmap_update_bits(priv->scu, AIROHA_SCU_SSTR,
> > +			   AIROHA_SCU_PCIE_XSI1_SEL,
> > +			   xsi_sel);
> 
> I suspect the AI will be here soon. xsi_sel is initially a random
> stack value. IF interface is something else, you use that random value
> with regmap_update_bits().
>

Doesn't default address that case? Anyway PCS for PCIe here is quite
special...

It does support 2500BASE-X or 10G/USXGMII, but 2500base-x is handled by the
USB serdes and 10g is handled by the PCIe serdes and this is internally
handled by the SCU reg.

This is modelled by the presence of the PHY in DT.
- no PHY -> 10g
- PHY -> 2500base-x and configuration done by the USB PHY
 
> >  static const struct of_device_id airoha_pcs_of_table[] = {
> >  	{ .compatible = "airoha,an7581-pcs-eth", .data = &an7581_pcs_eth },
> >  	{ .compatible = "airoha,an7581-pcs-pon", .data = &an7581_pcs_pon },
> >  	{ .compatible = "airoha,an7581-pcs-pcie", .data = &an7581_pcs_pcie },
> >  	{ .compatible = "airoha,an7581-pcs-usb", .data = &an7581_pcs_usb },
> > +	{ .compatible = "airoha,an7583-pcs-eth", .data = &an7583_pcs_eth },
> > +	{ .compatible = "airoha,an7583-pcs-pon", .data = &an7583_pcs_pon },
> > +	{ .compatible = "airoha,an7583-pcs-pcie", .data = &an7583_pcs_pcie },
> > +	{ .compatible = "airoha,an7583-pcs-usb", .data = &an7583_pcs_usb },
> 
> Device tree binding update to list these new compatibles?

Yes since the AN7581 is still to be merged, I just posted the driver for
reference for anyone that is currently using AN7583 and the updated schema
will come when it will go out of RFC.

> 
> 	Andrew

-- 
	Ansuel
