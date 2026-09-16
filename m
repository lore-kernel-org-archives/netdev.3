Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BC54A99DD
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 23:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789603022; cv=none; b=rq+CouLkAB+CSSAjkfdMyoY/3pIl9c9Mq+jxbV7YiWTG05g0W1w+QyhPQJUUpl1PvNRLnPM71InkSUv7IXfM6CxP48DGYkKlgvZ1lHy7RQLNMKyMU5R7bJDbmwtIvHqqKBGh81+fMso+rdcnq+0ND4lvcej+7mD93c/1dRT4Lxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789603022; c=relaxed/simple;
	bh=VGvZ2McX4R5AmpM+aD65U//d38njXDMp/8lXGO8s9fY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rcwGsEMKzjrVHKH/SY2tFQ1TpSoqDqKfp1NxHUyozyZG1LoU20QzX2mqb+4nmQydRxddXbDuj9+BWbj12lurTsSl29Ez2W49zh26DcldJPn66JLj/J3wjAMi2fx47yXZLpuUMAdkuGsZYD8UDthCH3rOsJcBTw7CI3mi45moJLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L1hfraDg; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1hfraDg"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-482f63546c5so184909f8f.2
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 16:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789603019; x=1790207819; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:subject:cc:to:from:date:message-id:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RqA/0fr84svz/HOqoCjORMcBVPzXHKYkGVcKqp7/wRg=;
        b=L1hfraDglk5BdW6YWihQ50AqrP4vcNrcDQPMCeT55kTyhQfjquN0wS5bob4Almk6SB
         /ipLB6Ju+6KWkQKioXpu/Nj6DZUypa+8NwgIMi+osPdw8CPwK3j3oDMR+2S+UxhOVK2G
         tXlzeFWEeFBNnRQlhm5ehtdj7K1+PPtnMh6yo4MZF39AE2+9FJrx9tLX+sJGiLMxrGqh
         S6oGCEj16lNXyZX+LKwErapwpdMpO7Qi0R6dt2elaJiT5FVPL1DTnpGteHaqMXQ3RL39
         uj2bBIwNpRE8Pa4QswCYq9xm1DhOf/chjn2nTVsCIphNdF2DfmUzS5bzhCilFkncOzwp
         VqNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789603019; x=1790207819;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:subject:cc:to:from:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RqA/0fr84svz/HOqoCjORMcBVPzXHKYkGVcKqp7/wRg=;
        b=yNvK1zL7PlRpY24KeFr4XP30ulRx+yKZnxcXUVDZ18q1qziI52P6NGxTEwg5BLT0fZ
         79ShqDXb65/CY+W1Up7tAdD5XLdU+4TnGGg8k32z8zSVPKKKYP6HJOzTIurjfHHS9qTW
         kTbMClRQTUykRBwDRsyrUG94ARG7KGZU0TVQ0OW/TOVIXdRi4bjK3pX22lvVc928TvqP
         zENrp0wZhiuI7fFz8cx8MIY12TqyjVrRbPNmaxtVfY0Qf4CLlLvk2S4dVK+rdUtEDXY/
         7WZ4s3AJ7/SqfrJH87mL6h7OAxD2uetHWshzrgrlu6E58m+t5ZXG3bNro2y26nwnls1V
         D1Rw==
X-Forwarded-Encrypted: i=1; AKwUvBzgo1LMFBF9GGh81Qnq7nDsTEmd7jp0sSOS4msrr/fCbczPp1DYh4c0ZYxhvOhmw5An6krM/AU=@vger.kernel.org
X-Gm-Message-State: AFuF++mS4RsaN+d/43hRvoCd2mtRma1Bq6MclY2ZeW9Vd2NJlXl/QzRZ
	mTNPkQtecokDul0Az7ty//wYjzV++vfuHFSf0r2H8G6AiyvN6vRxMXEM
X-Gm-Gg: AYBFou3VVZyXEBnwZcccpBZy500sbbYFmGkRV7t2gGyXyE71RNMKYkqmlG4fIlOTycd
	5xWxAQzg3NYlDH/crYYD4AwEr39DYHSTIENMZPW99RaTmJOWKiS2FCltGFnEfOGo3v8LMxX8ZdO
	F3c04hiYoCfQeePZnwCc8qRSGHbLPWN7JlMro2dWPSJb5Zqyu+MxVEP3tfRpLk8iN6CqKd4C2wI
	6E1ih5Vz+k/pQStba8FVbMvG0lKIjRPICtCazfpitn0i+ZJ5oetBaWJF1EcxKpc8wEMpqu46feB
	vbMzre9DiP3hseN5//AgO3N6pnPs3/GcEBVbs8weCIQW3FORJv2hpGx1NH7iIqEasAjEYy79qlJ
	l3nQH385FantmfHTnOv1EEDqkBo9XFfR80GXIDGLu0lE092yPFTrcPvJ8Tw9H/gIlvCc08JNuA5
	Nhr5tf5FboFZiK4Jga39sl4NUuGkoon1eZwuBwp44vyP10LLMhDUNUeuq95RYuZVBtJ6Hps3Jgy
	n5qH9uqsZcVkXh+BhUqppJ0tpM895ymffllZ68VfrapW3o=
X-Received: by 2002:a05:6000:18a6:b0:487:b00:3853 with SMTP id ffacd0b85a97d-4870d16b717mr5872158f8f.27.1789603018764;
        Wed, 16 Sep 2026 16:56:58 -0700 (PDT)
Received: from Ansuel-XPS. (host-79-26-252-140.retail.telecomitalia.it. [79.26.252.140])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf33d93sm9643791f8f.22.2026.09.16.16.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 16:56:58 -0700 (PDT)
Message-ID: <6aab2cca.142fb78a.207455.5b1d@mx.google.com>
X-Google-Original-Message-ID: <aqssx5dMEgQaR1jD@Ansuel-XPS.>
Date: Thu, 17 Sep 2026 01:56:55 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Daniel Golle <daniel@makrotopia.org>,
	Rosen Penev <rosenp@gmail.com>, Sashiko <sashiko-bot@kernel.org>,
	netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v3 1/2] net: phy: qca808x: accept the active-high LED
 polarity mode
References: <20260915223138.321307-1-donggeunyoo.kernel@gmail.com>
 <20260915223138.321307-2-donggeunyoo.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915223138.321307-2-donggeunyoo.kernel@gmail.com>

On Wed, Sep 16, 2026 at 07:31:37AM +0900, Donggeun Yoo wrote:
> commit a274465cc3be ("net: phy: support 'active-high' property for PHY LEDs")
> added PHY_LED_ACTIVE_HIGH, but qca808x_led_polarity_set() still rejects
> everything except PHY_LED_ACTIVE_LOW. An LED node carrying 'active-high'
> therefore falls into the default case and returns -EINVAL, which
> phy_probe() propagates: the mdio device is left unbound and
> phy_attach_direct() falls back to the genphy driver, so the PHY loses
> every qca808x-specific feature, not just the LED.
> 
> Accept the mode. The register write below already handles both
> polarities.
> 
> Cc: stable@vger.kernel.org
> Fixes: a274465cc3be ("net: phy: support 'active-high' property for PHY LEDs")
> Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
> Assisted-by: Claude:claude-fable-5

Reviewed-by: Christian Marangi <ansuelsmth@gmail.com>

-- 
	Ansuel
