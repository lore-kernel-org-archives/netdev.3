Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4084F7999
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 23:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789603063; cv=none; b=rXl4PWHMx8YQ7EU/7KPvXtBfTfBHE2qvrNJuIqTftQA9fgC8otjID9hMXOj1HNkPU4DHOTikZubqPaeAAQ81t5LIX0H27D6qM2D14lWsy4q91AK5x/hFs2UE0Nwvdgxqs7vA0X6GDY2gXYLy2uYXph0ochsCj+75mh/tdFFfSfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789603063; c=relaxed/simple;
	bh=HuNThuRtR/b8nPXMJCUZcQGR9ZTengwNPThxjxcEuCc=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xn8buG9Fslbo06TXS+TCmCOwJfHsJxvkBf/gpyN3KozE5f4IlFqA8g3VJayQqQZGpeyX2scs3G0l8DqzWgCOBJhtEW4rCPCcn8+TYpVFnOXqgd6JymkHBzfYatl5vmxwo2gquwDBfQnD69zFwifkItUCh3vonb00LtWKanldGPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NGBsJfFz; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGBsJfFz"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e69b9e16aso2686315e9.1
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 16:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789603059; x=1790207859; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:subject:cc:to:from:date:message-id:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i76bBjRt7lWeVEtpRfqzBf+audkyQA+RhPrniCN+9Qc=;
        b=NGBsJfFz/lcCy8QUv77zpZ1ZV6NviWsbn7L7473f9UL0u31xf3YNyyr8QMleRnXvXR
         9fVNK0e6/Jl3wdqUtpWQ70fjSauoXGy3HQlOhJ3c0gTjuyjMycuPsmyLnJ0XrY5yk4rq
         Q2mpUV7ZMG80GTpFsYvRPR3UmA+FZUatedTW9bczCIoP8ZHiJLFTsUrbeTUU3iF0tLS4
         ZIjWi3noHwU/A67+EnC38cy2XZ+irqK20Xr5bN1APrU1+GQd8hTtXXl9OU1XQHaIIXEu
         7JpP6ZKFIOm3f46g7Gd0R2yRxGotZzL83Bedn0YWxdGM52nd11a2ZStFweK8go9Ic7P7
         U9UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789603059; x=1790207859;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:subject:cc:to:from:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i76bBjRt7lWeVEtpRfqzBf+audkyQA+RhPrniCN+9Qc=;
        b=ZTBvTA1YdlXL2exCaPLCJG3g39vimcjo2g6j58XqwUIC5PfYL3bF9kAC+cvidvYRy/
         1kzmY4zqUoL1kxFwRxtQvkjN1mxPnns412kwDlrz3qDcWLgocq7FtLdvt1JxFjvtqp6s
         jWfY+cxo8M++S0cckO1TXykFjRc3LB5l83Gw/2NTkFj7j/oqJS3RnIU2uWyJ+qdwuE6U
         Yekuqs246c+WEKbUi4kKDiU13N09GMJ/K/euEnb77iVwi6Q/BEoJVilSNsNT96YINxWw
         uDXUwNDknmSp9nlRbW6ZvsfX11Sa0KSedAafk4Gd5Wb74kiW97x3AoM8GoLJO9RUgE1S
         R+og==
X-Forwarded-Encrypted: i=1; AKwUvBzfDRfLUP8XR8RA59SBXRr+gIwCFPqdPSe6wWkGXgUoiaQlfX6rWusdx2GqP2N7l0E23ZrPAl8=@vger.kernel.org
X-Gm-Message-State: AFuF++lpskF1UrAw0BikpkqfKItJiPHlgaRGTiuUOlm6Q42hjRb+O+X8
	NyrgA1JdcYVAIfbQSk5I4pwr2B3uuXyo/KuNbAw2L4T3jbyHlukfULL2
X-Gm-Gg: AYBFou1v5StwdEHYfXbK3J1c2aHtQzk9wCjHBzsx7ERBEF68xfFI1seXE5C4yTXk/wl
	+07qZEvawae3dq64dWoY6WD80Xn5iWSPK5K77m2DReEdSZp5EuMmF53jTPpaUeQLgljmT84/pig
	ivHB0ddyOjS37cPmpQf4kDe48Y2vvcZoIlWZobaJqWDIOyHiV/eqAlpnBctHxq+AASOawXiA92u
	LpxbXDh95nGkyAv9TQNYH9Jx4oQ+rXDdmZBbSsJiOkc6+5KDGEMLjYLrswaHiaMswB8ukwFakTy
	e4i626E8MU2wJStj01Nim2CJk+nDihCaDXMj5699BBNCUD6a+IuoIpCXG2XSLYFjyWiratrvIf9
	Av0qsYD3Ou2srtE9QAiwh0AzW1qj7fatq29oiAYGvIwcLHbQMLK/Fbb8cK3sMY4Z2RLcjNeexRp
	xyyYFc2jqqTdiiCw/H+kwrLb583WfjUJu1PhM+Atk6xBYC2R9oiwKyqMiHUUN5z3HqjNCxUwR8n
	/v5YcT4n607n/hi7mz86bUf/mIZiBaD63fQL3OtiUiCo3s=
X-Received: by 2002:a05:600c:3150:b0:49d:25b0:cc60 with SMTP id 5b1f17b1804b1-49eb73321d4mr54015475e9.29.1789603059482;
        Wed, 16 Sep 2026 16:57:39 -0700 (PDT)
Received: from Ansuel-XPS. (host-79-26-252-140.retail.telecomitalia.it. [79.26.252.140])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd17051fsm30297125e9.0.2026.09.16.16.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 16:57:39 -0700 (PDT)
Message-ID: <6aab2cf3.a47bfe04.3d08b3.8af8@mx.google.com>
X-Google-Original-Message-ID: <aqss8DLZEsJZLhwf@Ansuel-XPS.>
Date: Thu, 17 Sep 2026 01:57:36 +0200
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
Subject: Re: [PATCH net v3 2/2] net: phy: qca808x: keep an explicit
 active-high LED across the reset
References: <20260915223138.321307-1-donggeunyoo.kernel@gmail.com>
 <20260915223138.321307-3-donggeunyoo.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915223138.321307-3-donggeunyoo.kernel@gmail.com>

On Wed, Sep 16, 2026 at 07:31:38AM +0900, Donggeun Yoo wrote:
> With the previous patch an 'active-high' LED node is accepted, so
> led_polarity_mode can now hold 0. qca808x_config_init() only re-asserts
> QCA808X_LED_ACTIVE_HIGH when the mode is -1, the value that means device
> tree asked for nothing, so an explicit active-high does not reach the
> register.
> 
> That matters because the bit does not survive a reset. phy_init_hw() runs
> .soft_reset before .config_init on every attach and resume, and
> commit f203c8c77c76 ("net: phy: qcom: qca808x: default to LED active High if not set")
> records why: "on PHY reset, the Active High bit is not set resulting in
> the LED driven as active-low". The polarity written from device tree
> during phy_probe() is therefore gone by the time the link comes up, and
> the LED runs inverted.
> 
> Re-assert the bit for anything other than an explicit active-low, which
> is the one case that wants it clear and gets that from the reset for
> free. Name the unset value while here: led_polarity_mode otherwise
> holds a PHY_LED_ACTIVE_* value, so spelling the comparison
> PHY_LED_ACTIVE_LOW says what it means where -1, 0 and 1 did not.
> 
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260908105959.70453-1-donggeunyoo.kernel%40gmail.com
> Cc: stable@vger.kernel.org
> Fixes: a274465cc3be ("net: phy: support 'active-high' property for PHY LEDs")
> Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
> Assisted-by: Claude:claude-fable-5

Reviewed-by: Christian Marangi <ansuelsmth@gmail.com>

-- 
	Ansuel
