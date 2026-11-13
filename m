Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794563806;
	b=UQBgcEVS6E6ox66sh24pjlrQyrOxKV7XRNgeJviYgfyB3eLOBeLu82VBj7nTW0m94R7T
	 mmoTyGRA6rMCN4763IhCbGzSca/PKG9h00VmgtPFLZ+9iE0x6etJFA+KXbGhcjf+WouRu
	 Y8Fb0D1R9a5Wux83ecGCNFXX4Co0Umw3OUMwmyNkYTqMkuQKSW8CuYXooEBVSfqUREdqC
	 XB58jEIEemBgzVQlgWkLwkmGw2TQWS6EXG2eH4H8HwcVMrncOd2LgoSDgglEFDoAVsnCC
	 zyIVVqOhcIYYqzfO4uxz+IemJJ3xJR7m6echlxNobvQblHrBCmVM3jr1xfAtfQJa4WQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794563806;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=kluHAf30lOQTvYGq+YH2c2fBsSTyc5d5qn0rYtZKUsw=;
	b=VRPeU1o0bE8C80Q4xYVBUxe20GyZlIZQdySUaEpp/8eHBwqYRZ+5pN+LpgcMr7zcQj/T
	 zoaGBS5fbz9Jg6xCsgGBzie3Dl8/5ywf2T4UGy3HzfVQtYWEqxNPgGYBxYSWBip5PdBbb
	 XH4kEbr0aSf1X00f/H2DbFKLi/Tkk/vYXCUGRzX/ZQIMdPy/T355g2iBEkDV2xaoVFv8c
	 jb1NlsX3UetfremB89QnjKYWXNH7JBD7WVtu8t2CINmFTu4QSrXFAkrE1BvtdAw5UP86t
	 8RTnohDnpBFIgTGyqJy2XeQUz8iGl4ynS6JnmoWmUM2XG466LlSXGTGZSJovk4AOPZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p7wzYuMY;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E497D606A333
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 09:56:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E497D606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p7wzYuMY
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a35ac4475dso4011925e9.2
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 01:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794563804; x=1795168604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kluHAf30lOQTvYGq+YH2c2fBsSTyc5d5qn0rYtZKUsw=;
        b=p7wzYuMYn7brPyloBx7mav2Z9jHCXjOnldCsKhPHo8MSBai+ow1PAU0djODR5o38dJ
         x74xWoL2nYvNOhHW9Ep9BJ4gEw733A/AWPy+Yx6UCXA5GcXMLP/kVyMoAxoEfkj3MX/l
         sB6cKjkU48UH2zhF2ob95aKfByOQVKAENq7BF0jj8U2HAHyXqWrFNsitIBApShyesq34
         P83vj6qH0eecVK7TXgVgZnhrZ1Rp0e8GNY+plEUZFK72hDhMSeHKiGGC+0aREJax8LEt
         wSFCxlZ399jgRaACJZGG+NAHtDlL7KeKeUYpeO6c13pCDh+NCX288O21ifmemvFI0Vdn
         RqIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794563804; x=1795168604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kluHAf30lOQTvYGq+YH2c2fBsSTyc5d5qn0rYtZKUsw=;
        b=0c5gSI6p1+zyKvdPOzj8LQoGfRg1y9nxyfeoPzv/4nK6W0oGw5By7XyINDd/iT98fv
         q8E9hVOwnxfp+N9lRF3acNK5PipMy0Rb+BOzrQsp/cWHgU4GedmRMS0OawP0gXrX6OMK
         HpQ/Qy+hogZodTMQG0vpXVaetb9VAXguU8u9feiTcgx8+O3OoA/JXT2mQPas9TBWPNOe
         67EVJrWrSdgbqyKhOASxy17SkKf2lhmWMlmedYZXtmpHLzncot6m2xb4KnXV0dOT7hKB
         a/HTsMSjwSyPKgPmgBhBURdbOQY+o54ON8xxgzonHdt5SRPX7HfPlwFR9ECEB/7aCs6m
         gTBQ==
X-Forwarded-Encrypted: i=1; AL+hErFBvUClxBP1Pma7lMbGfKchMkeCTBmwTk+Pu0ymNh9SU/bqVB40pOJJKUgSsjGDVNMWZcH9q40=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Bly2M3iI/M0DtuBA2QNEf3mi+eP+zJ0Ips3cJo0gqWZUYQeJE
	hqwuay1Cq+GgcuuiML4P5eX6FrKeIhNu2T0Yajlg2haSEdlbYs8uKbAv
X-Gm-Gg: AYBFou2Xt/UDQ3W7+EOAlBQ6ascUHxkFcCPCSsh6hBQONKbuEu2gKpw7mLfYmte3nlw
	fUThEROjT2eJaCfs/xLkRf4QkmCa7ix2Ca8Q9/Wk/jKl6PWNQmnnzoaEl4nwVBUVRzmLse2HcGn
	tnFIzfk/yXktlG4X67oyU2rJaYSjLiWdztCgKeMI6KsbKfMZrX9n+eiH3T3svPkQnUsb1zqhOAA
	6vxgMVSGasppv+jLstK1fOajlkz7H0yE00OWNmevsqsNDpRTGhCdDHG9O1VR4vMuUzCByVVKN3R
	Ye83tIIR+dJN69FxteyEH62ShCfNXYcgbPEhq2H10heeL2zCZnje1bX5nCKwUWMZT0AMk/+MQ70
	wXcT1foxEHHeOpMFwaDAO6m5+25vHw/E6XDBUoQKIOvqqpFHbF12wZHAGA7s3BEIemRhHiMo3Sc
	DXtkjXylXa/2e0de4Y2JQCJEuAnFp0ccnt+h1/C1v9HE8QmHqWYwYTxuqMxNcyDQ8mdlqQlw2Tj
	vcoFuKI0esMX6jFBqO9Ckxoj6+4Dttnx83EvApg2oJ1NZN8PdOYOl2LcXw+f/wpZsiU5PlS9ohX
	qdEJMRwLMjcQaEVbFqTV4fD0Ov2BgexXH/FJz308PKl814Rd6o9F/l2qxP/5FOMRO0c/YvI2dJ/
	1v1pgEtQFxemrGmtM2/nN2yEG71IE4jnXePkDsP/ip8LyGvaC7MP+JHWdGpbtIE2SKO+0NXA8uS
	52ODb5F9PB3yclqAgs
X-Received: by 2002:a05:600c:6286:b0:4a1:7e77:c382 with SMTP id 5b1f17b1804b1-4bb55a5d634mr37035575e9.5.1794563804181;
        Fri, 13 Nov 2026 01:56:44 -0800 (PST)
Received: from navid-pc ([2a01:4b00:a856:6220::a11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb571d7e87sm28500015e9.3.2026.11.13.01.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 01:56:43 -0800 (PST)
From: Navid Ghahremani <ghahramani.navid@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: linux-arm-kernel@lists.infradead.org,
	arnd@arndb.de,
	stefandoesinger@gmail.com,
	krzk@kernel.org,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 16/24] net: phy: Add Sanechips ZX5201 PHY support
Date: Fri, 13 Nov 2026 09:56:39 +0000
Message-ID: <20261113095639.1667143-1-ghahramani.navid@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <95e7fc97-2bd1-4b68-a9ef-246302ed9ec7@lunn.ch>
References: <20261014072109.1759502-1-ghahramani.navid@gmail.com> <20261014072109.1759502-17-ghahramani.navid@gmail.com> <788c9b01-473e-4c45-b6f0-b2ba054da8e9@lunn.ch> <20261113003655.3665572-1-ghahramani.navid@gmail.com> <95e7fc97-2bd1-4b68-a9ef-246302ed9ec7@lunn.ch>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andrew,

Andrew Lunn wrote:
> https://www.sanechips.com.cn/en/Products/WiredEn/fixedNetworkTerminalEn/1558027080778723330.html
>
> This says it is RGMII.

Thanks for the links, that settles it. I will treat the link to the
ZX5201 as RGMII.

> So picking SERDES is probably causing some of this confusion. SERDES
> implies there is a PCS, and the PCS is doing signalling for SGMII or
> 1000BaseX. With RGMII, none of that exists. The registers might be
> controlling clocks, or regulators etc.

Makes sense. I will drop the SerDes name for those registers, work out
what they really control and where the RGMII delays are set, before
the networking patches go out again.

Best regards,
Navid
