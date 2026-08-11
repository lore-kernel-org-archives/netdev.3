Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56AA3403E7
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 21:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786484822; cv=none; b=Qt5gZXv99175xZA2dMdRrasEFainwVpIbEbEA1LTM3tD4MlaMU0q7EBtx8FZB890XT+frsOFJgZ2f1u++gE+PfG/RQI5JYkohf9zXKdbvhMuqpiy5W+Rsj1rY+tPe0KfRsZW/tpjLfNof7hkqwfE8QNK7dMG4cftWXlqT8m3v28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786484822; c=relaxed/simple;
	bh=rh3m1Cqo9mCNPPwXdaSvQmTI/rlxBSq+XzBXjNmFPQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sPixv6Ft2dXF14dYX00wsNBhhEN34LEYZIHkmoBrK1v7NtYpyKBYgeK80pGM4xwE9irUq1z68+dK6fYeg60vYHTdfwJSi7ujhEUwqpH8rm68E7R2vHegtqKnhGZShvN619HUgayEv+34tNhJrvnNR3no8FbPe6+8aFYgZdnYtUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T6WT8UMj; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6WT8UMj"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4957952e0f8so370755e9.2
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 14:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786484819; x=1787089619; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TgndDYlcvXxrotByazHMiHza1kewS9hYlmxpzQFlVp0=;
        b=T6WT8UMjrQ8kh8l08SNDpELA3BVLQGdVy9KofzrVsidiHdMqyFiAIySttQ0Z7ptoQI
         L6J+vm/y39r/aG/Qi9uySXYWWIXvHaI/dHH6DHDDQ+tUwBzoCyWe3COMdSlFvZWDjxnW
         OQLHSaokRGHJtdYH4W//UtSjmFBDP/Og7QD3h8JarNU18alf2JCqMwjYP4711YGPAiRh
         80RJ5WQAnSYtTHkS6jeQ2VctcJXVs9yCd9YL/DtKbvzwEyCQ3LeN/OrkLOfaot6P9uTF
         DV0LEQ6SOHK35hEu9n7sxeNJ5qWr8UMmy44fOoEYb1eTuoLKEVwCR5oIAPQrLagFbp+W
         vfsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786484819; x=1787089619;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TgndDYlcvXxrotByazHMiHza1kewS9hYlmxpzQFlVp0=;
        b=KuagRBqDJeSaEMZqK/CDggfVV9KaTbFPNNRXOy1LpTqDclK7Wx8U18y/OCRPsvgFLm
         EbAmwIwEh0h/NyM2+uN9o+8k56qoachhaXATOnq9+McccJ/c4Z1eenmlgaCY0KHkYLpr
         ZdzOC8MtDa/RZXwczWXA5pkUJdWPif5gtTlXQ7sUvqrpGJNqnHNnwYH+jDgLJbEfpF9b
         J9u5O+qvmRMC+lZv6LPIbCVBSP/4fSGk0GapCSNQSfYncXH5YWU1WlbV/U5fw9lWD/OP
         GnIPb9WrUElnn+Pef0RSEYYHxU6GVKZdtJNFEmIZGb6XoN98GnIepidVgQvLdUaIAlh7
         LIjQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrc/9SVn+LKKdY/EfdklWc5BpX9wG2/GDdl34ra3B0LUreupMZgK05HrxfMq80BkGxCaT6H0/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGpmpzJAUjx1jtIfpHrCj2bwVE450SE6xvl8wuS6n2XAXhkvRO
	/XptWZ4J3CCZoPwIoedQhX8dkDn5UsXg+XKVbqCZw4XV8L1AUHo6CkxS
X-Gm-Gg: AR+sD10pJF/6ioRW4b+0HbVMjYP8guMhP+GPZrj09Vme6D+qtI6nS4gm1fpR7lBhVEI
	Y0l0wnOk11JSPWN3c72i5c+XNMOKIjFIY7BzOHxN+NpVNdKMZTt08gKW2D9lnGyYG4sQhhSy99I
	eJfg0HcX/dszGaLkgqZFO8fYVAZoRpLYL2ALA6swSqalkFYFWfP5etFV51psjeIy92qXvVnpQeG
	3UA3Hogy+L94sR4oKFyU7lgDTJFggHOs0BFD4Jt2atMRTOaoCBro3JhdXJ6GNJuPFJisKhvneRm
	btm8TzJ2/oc1maY2dATn7cGrhjLBeeLxIgkABAqpA+tL0DMQw7KdSz4dtYplER+YnJRdsnYJlJz
	oX88PbPmUP0gnKm3ntrPlDtNwVWzWu/RTSioJMH6yfEi+5a7OwPMe2t9H7Hi7c1IFZ10y9chdJ8
	fMuo4X/rXpskbnD6V4selgcSIAH9nOhmZ3XGHsjGe3sFk6DTAR
X-Received: by 2002:a05:600c:3b8e:b0:495:4126:1e55 with SMTP id 5b1f17b1804b1-4997c11024emr1666045e9.2.1786484818882;
        Tue, 11 Aug 2026 14:46:58 -0700 (PDT)
Received: from skbuf ([86.127.220.200])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997abebacfsm16561195e9.10.2026.08.11.14.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 14:46:57 -0700 (PDT)
Date: Wed, 12 Aug 2026 00:46:54 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>, netdev@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH V2 RFC 2/2] ARM: dts: BCM5301X: change Luxul XWR-3150 CPU
 port from 5 do 8
Message-ID: <20260811214654.v7elo6smkknsyax4@skbuf>
References: <20260811193658.14304-1-zajec5@gmail.com>
 <20260811193658.14304-2-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260811193658.14304-2-zajec5@gmail.com>

On Tue, Aug 11, 2026 at 09:36:58PM +0200, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Northstar devices have 3 CPU ports (each connected to a different
> Ethernet interface). This design was meant for dual IMP setups when
> WAN traffic goes to port 5 and LAN traffic goes to port 8.
> 
> For practical reasons we label only one of those ports as "cpu" (the
> rest remains disabled). It's because of Linux behaviour (and it's
> probably a bad thing since DT shouldn't "care" that that).

Did you see ds->ops->preferred_default_local_cpu_port()? You can define
all CPU ports in the device tree as such, and let the driver select
among them.

> So far the choice of "cpu" port was based on how vendor decided to setup
> given device originally: which of three Ethernet interfaces got MAC
> assigned and which port was used by vendor original firmware.
> 
> Most vendors decided to use CPU port 5 & relevant Ethernet interface.
> The problem is that only switch port 8 provides full functionality.
> 
> Change the choice of "cpu" port to 8 and make the third Ethernet
> interface (connected to port 8) use MAC designed for the first Ethernet
> interface (connected to port 5). This makes Linux use switch in a
> feature full way.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
> This seems to be a slight abuse of DT. Instead of describing hardware we
> make it steer Linux into using a more appropriate switch port. This
> isn't strictly a setback on its own. It's a change from one choice to
> another.
> 
> I'm not sure about that MAC however. We say that the third Ethernet
> interface should use MAC that was designed for the first one.

So the NVMEM is not provisioned for multiple MAC addresses for gmac0 and
gmac2? Can they ever be used simultaneously? Even so, I'm not sure
whether that would cause any problems (depending on whether the switch
supports address learning on IMP ports, it might not). Do you have a
specific concern?

> Is all of that acceptable?
> 
>  .../arm/boot/dts/broadcom/bcm47094-luxul-xwr-3150-v1.dts | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/broadcom/bcm47094-luxul-xwr-3150-v1.dts b/arch/arm/boot/dts/broadcom/bcm47094-luxul-xwr-3150-v1.dts
> index 8e487f60a2cc..7969f0f331b5 100644
> --- a/arch/arm/boot/dts/broadcom/bcm47094-luxul-xwr-3150-v1.dts
> +++ b/arch/arm/boot/dts/broadcom/bcm47094-luxul-xwr-3150-v1.dts
> @@ -81,6 +81,11 @@ &gmac0 {
>  	nvmem-cell-names = "mac-address";
>  };
>  
> +&gmac2 {
> +	nvmem-cells = <&et0macaddr 0>;
> +	nvmem-cell-names = "mac-address";
> +};
> +
>  &pcie_bridge0 {
>  	wifi@0,0 {
>  		compatible = "brcm,bcm4366-fmac", "brcm,bcm4329-fmac";
> @@ -136,7 +141,7 @@ port@4 {
>  		};
>  
>  		port@5 {
> -			label = "cpu";

label = "cpu" doesn't really do anything and just confuses things.
Labels are only defined for user ports. Please remove this property as a
follow-up (or preparatory) change.

> +			status = "disabled";
>  		};
>  
>  		port@7 {
> @@ -144,7 +149,7 @@ port@7 {
>  		};
>  
>  		port@8 {
> -			status = "disabled";
> +			label = "cpu";
>  		};
>  	};
>  };
> -- 
> 2.51.0
> 
