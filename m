Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050D21DDC35
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 08:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784708610; cv=none; b=sz6g7RwMxV/jmpHrGshU1azojFLm2ekDvTmRjMqrHnYHQqWJ0zqx5yFzVF2gCOVYFNX4vY3bZrVXxeZj+hH0oRTX12G8RmMt82UWQ5jT3J4Pn/CEf6CvyCu7iR8jsRjxz41eTxmwWyhR4gL+BDLZCbmAqG8+saRUEqJf8Rb3fcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784708610; c=relaxed/simple;
	bh=L3Z8i3FOorkEh185dcAB5RM0vQHvkliZbf8ekHkOM40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YQp60k5JevKfnNa29pa0xFjfsR3E/0MxZNGRuMRV//cLc08XDf91HZygiB9Z6mkqe6IRTsVuh0CAHv8vNHZ/s9N3vihaeMFF5YuEpzGCZvXMd+xIyMUt59n5HSQYJWQLx7WSBCw9iJ5Uk/wX5dK+h25k1SbNekeMIBZKAEY3c7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hr4Tl5JB; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hr4Tl5JB"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49548aebcd8so34412665e9.3
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 01:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784708607; x=1785313407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L3Z8i3FOorkEh185dcAB5RM0vQHvkliZbf8ekHkOM40=;
        b=hr4Tl5JBvAOqrf/4PFzrFkbb0aZjTub2Z8a7iFnq/vWLS0XKEmWCgkjFs7Nauc6XH6
         SOPkcJDanwCIua8+LJbX3EGJGPy6sdl/nQFX/oJkWQl/P+Sh7WgF/F+r8NQUo87AQM+r
         aF80jJICZTps6PFdjuvsCwuzzrr/neDOb4KMIrSDgX1DE/1qoK9mRXQT1gcE6hT4/6Gv
         Ztq1flyrT/8pBiewI3AzM1C+glVJ8O3BEeQcfyzX4i8zfVa2b6bj9uBz1Tc+k5h1NdkB
         68zgfNCSAs6Ll/EUONVa8NWrpSsJfri1MH4BopwRH/mfIw8r/3pN4QLUVSbB/RncRfxE
         S/0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784708607; x=1785313407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=L3Z8i3FOorkEh185dcAB5RM0vQHvkliZbf8ekHkOM40=;
        b=iXj3Y41A0dmylKZ3QrDOmjcmmVrVdZzdXQUesNTIm5H+zXkohxwZ7NzJ00/T78jV8B
         U0gZIchrHNKkikMhF8xrQy8mBG4dtxDqKwpMZLInfG1zGuQi76rDoZPkcZLTjEBDd+xV
         vp/6+Q83gZ0cklvzRcFZvBoXefM8L8Gxk6jrtETf8AP7fajFwi6QyMZX5AFKVwZjU7qx
         gC62zQXNfX43vQi9plndM6nQ2/9O5up5uMSGb4v6sm+fkVF3xncpbyBmjr1BD6z4Pe8g
         a094Q80dEoLkjDu3BwOY+/hKKW5YXeZX7LZi7Ss2Yw2BnoZnwpjPSJo8qgssbBlX5wgH
         2IIw==
X-Forwarded-Encrypted: i=1; AHgh+RrMoeFCoWvoKlZYWhMaMwMS96nmWvHsWi6VI/1yR+kD6yovpA/tNUug+ERwZXFpfuk/Kf/N82o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqNYGeTdRNm+/rQGOQM4To2flB2BYO+/U1kBvdO4EzynwqrLkR
	n+cLSk5U9RcKA3LeEcNAluSjccIxlTsrsfX3nE/VyNQdxnHMYFUBWP9+
X-Gm-Gg: AR+sD13xKhDUBcscVVZd334ODijLwUMfZSlUjBTD6GGp+MCirk3nGAZsFcrakvCjB+m
	KBDthbYYtotV5LJ+edS10ZSWReZYS8+LbbBNgN9lCdHXQVauVroxgpOpwhLdfgbEmk73dcutqM5
	0rkEREtR4fhiOoNdROPitU7PnmIPE8Lnm67jSw7HLk3XdwRenHUf8BtK7yirY9Oe08lRXn8jzpo
	AUzeS6OoLYqTH2kawfmBpOKud+AizXs2dZCXT121/4V6E93Xkit0vJPqFqrlW2JDk+NwQz5Aj7e
	couPGu1S/Gb2nbpnX/X43UzeJs3683D+xZVBogRPi8zEiyPISWr5PolTJCGao9v2GD5Cti6f+VM
	x2WFsquxbl1WmUzk7d7fiLiiyNUeeuT4pkrn1maes6jANbM3oaf3zH696YdbEdqjWiCrjnzBQnC
	kDEVhtvGUWr1OFHfMCwaTrtFRXdOOdDnEF3L4P8OiKSvU49++V1M0THA==
X-Received: by 2002:a05:600c:3b91:b0:490:c6c2:52 with SMTP id 5b1f17b1804b1-4954a3d0065mr296436935e9.3.1784708606780;
        Wed, 22 Jul 2026 01:23:26 -0700 (PDT)
Received: from VivoBook-ASUS-X712UA-M712UA.lan (public-gprs192625.centertel.pl. [46.134.91.178])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-495653bfabesm142309565e9.10.2026.07.22.01.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 01:23:26 -0700 (PDT)
From: Stanislaw Pal <kuncy7@gmail.com>
To: Johan Alvarado <contact@c127.dev>,
	Linus Walleij <linusw@kernel.org>,
	Alvin Sipraga <alsi@bang-olufsen.dk>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Mieczyslaw Nalewaj <namiltd@yahoo.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 0/2] net: dsa: realtek: rtl8365mb: add SGMII/HSGMII support for RTL8367S
Date: Wed, 22 Jul 2026 10:23:21 +0200
Message-ID: <20260722082321.13802-1-kuncy7@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260711-rtl8367s-sgmii-v6-0-88f7944ddca7@c127.dev>
References: <20260711-rtl8367s-sgmii-v6-0-88f7944ddca7@c127.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Johan, Luiz,

Here is the tag, as offered.

The board is a TP-Link Archer AX55 v1 (IPQ5018 + RTL8367S). Its
CPU-facing port runs fixed 2500base-x, so what this exercises is the
HSGMII path of 2/2 on top of the SerDes plumbing added by 1/2; the
1000base-x path is not reachable on this hardware. The trunk has been
carrying traffic continuously for days, with zero FCS errors and zero
drop events on either side of it.

The final cold soak on the healthy power supply came out clean this
morning as well, so the cold-start failure I reported earlier in this
thread is settled as a failing PSU rather than anything in the driver.

Tested-by: Stanislaw Pal <kuncy7@gmail.com>

Best regards,
Stanislaw
