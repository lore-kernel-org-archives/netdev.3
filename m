Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D7836215A
	for <netdev@vger.kernel.org>; Sat,  1 Aug 2026 03:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785556789; cv=none; b=g4bgvxG+TVDrJocgXXoEiUUF5qcszneIVcBNB2cvWhvq42Gb95dg8mXomfmiceQxq+AYTEwg7jPYT2p8QKwCl1NUL6l6DP1OkiLjQVoY747Y1XO2KqQPq1WOvwj7+VWwdOIECFOc1nuffn+xExYUAQ7YwRsmCA7WZkF3Jw9yuuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785556789; c=relaxed/simple;
	bh=VkQMmcdU2OxJXgzqlGVZnX66U59+4GjFZVlRptupx1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UsQEznKeuAayGVblHoqMjKDL+c5zIG27mO9O9184sBllUymCNISnyrwKN6zerivsF3OXG39WVKy2bFEAibyTZGH15uPVMwZjzHbcR0TS4Y3P6UiBQUP/25l52+ipbIK1n0X+kJApD8C2XpSmNIUDBwz1ArGYD4BfZ8GWL7oIVUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r3viuEQA; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r3viuEQA"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8487214ad2bso2454665b3a.1
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 20:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785556787; x=1786161587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VkQMmcdU2OxJXgzqlGVZnX66U59+4GjFZVlRptupx1U=;
        b=r3viuEQATaFvhAe0Hlb/QBw/Apvkp4bctkviwZd6563nSZXTS+FBsA9kvc/kF8bR+L
         RgkH9JlT2ooNJYCj3xqnkOw3drAAopxd96bp6KK0FEfV3T8QpG6PBk+6Ljyc7pSn/Y77
         R9jriWUf5lNciJNow7uSpG56ePn0e0ItGyjDIdYFkbnOxU6zOibroajrM/cbxkXEwmAZ
         xzXKATecsvns/t3Z+dE40MTaEGujjbBtF0ImHK1x9k7KEDD6+Dysqcfxwxr1mSwgfzd+
         kK81thbI2bXotl2ioBuWCRw8zUoit5ej3FKJS5cpEcA6BA2bI0atLfzIktQyUETnhu/7
         YafA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785556787; x=1786161587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VkQMmcdU2OxJXgzqlGVZnX66U59+4GjFZVlRptupx1U=;
        b=hzWqN28PaT7W4xNEfKDLL/uD+dRZWMd+bOyOSut73DI2O0aPM9Ydhg202u5Zj1hNHQ
         qGWO4zrqf1u2jENh3OPtSU6sexOhhD4tSx9ATs5p2GT5lBDJy12Ix8+FoEs3RtmQ4vjY
         kVW3ovtxXE2KzeuQ+4N/N00BJ3omrqZLWmBz7uOQD6szkUZ4lP00WjqeHzg29dLZLhMT
         4KpNK0Sz92H9t3YnXYOXOWAzhLNGCLIC2r+XZ6E8WYVKkPQCGRhqJ4Qa0wP2xcGB1A1o
         kYSkbbwwu7ibVt8EbJDF04KdOQxfThRwYeyKCd26/dp/+W0B/wGf1h6JJuuS41CTiSZF
         KtAA==
X-Forwarded-Encrypted: i=1; AHgh+RpZIj931ldkRrm9izDAw10siDiZ1VHkttDGylo02EFRHg04aSLZCXkhMeejSNloBFnXSv5u4A0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTC7dP71iGu47Ezd99VbIl8H3h6QCqtYQCjx+jMwshJeByAgig
	47+lliw6i51SRRSapPjUFLBJXZcdeN6ImuRd1DL+ereezJ62gbnpBlYP
X-Gm-Gg: AR+sD13j+13kVp568HneEWVI+Vj1OS6FXKO9/lGUtFVJ2zCyvAXVgJ//Or2Qkf0dlRN
	R0rxL1F5oaYUO3NhEM+q5TI8s6LB0SNUzgfXj/R/seZckMhkJZfYIXqj6iU6ysbAxfhwWQOXb+q
	0vA7PJvQETw1a7nqG+DWwo92NyUEmRNCjZZKp1vaTGdYcdwRSXI40HVCYLwYh6waknMFt9+qcS5
	asMumkz79YkCegnEuqHUZUZaZBuQVCuMbwKzG1eR6hryvh2DAChRY+EwA9Q0KKjKntnn9GHu7AY
	ImcdB8rovq+UU+/XMtLMmz33h+Nb2R/CWRrysgIK4rwOtkVm+4U+QLeAQUqK+eqW6MrF9aOcs08
	RtQ8SbQkNkXAaR7pfM3NISd7SxpUgEIwIJ4MmmqdGq8/rztDTfyatab/njpkOelN4PXrqAid2au
	6txpIs9qeV878c4KMFkXqFXWxv2NXZBZ2MR0o5udJ6/vIjmdM/G4fHGUL/F6asyImomyc+w5rHs
	Q==
X-Received: by 2002:a05:6a00:4b06:b0:848:46ea:bbe7 with SMTP id d2e1a72fcca58-84ee4813a67mr1969176b3a.19.1785556787195;
        Fri, 31 Jul 2026 20:59:47 -0700 (PDT)
Received: from Inspiron5409 ([138.199.21.246])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ee1b049e5sm826657b3a.58.2026.07.31.20.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 20:59:46 -0700 (PDT)
From: Jianhui Xu <neuromoments@gmail.com>
To: mail@birger-koblitz.de
Cc: andrew+netdev@lunn.ch,
	andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	hkallweit1@gmail.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	Jianhui Xu <neuromoments@gmail.com>
Subject: Re: [PATCH net-next v4 00/12] ax88179_178a: Add support for AX88179A-based chips
Date: Sat,  1 Aug 2026 11:59:41 +0800
Message-ID: <20260801035941.3307404-1-neuromoments@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260731-ax88179a-v4-0-2cf1f71b1dd2@birger-koblitz.de>
References: <20260731-ax88179a-v4-0-2cf1f71b1dd2@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Birger,

I tested v4 on an ASIX AX88179B adapter (USB 0b95:1790,
bcdDevice 0x0200, firmware 1.3.0.0). And it worked smoothly.

I applied the series on top of net-next commit
df13c1df8147675470213ffff29dd5762fa321f5 and tested the resulting
7.2.0-rc3 kernel in a KVM Debian guest with the adapter passed through via
an emulated XHCI controller.

The driver automatically selected USB configuration 1 and bound as
ax88179. The MDIO path bound the "Asix Electronics AX88179A" PHY driver
(MDIO device ID 0x003b179a), and phylink reported 1000 Mb/s, full duplex,
autonegotiation enabled, and link detected. Driver information and read-only
EEPROM access also worked.

DHCP and interface-bound pings worked, and bidirectional iperf3 completed.
I also tested EEE disable/enable, pause enable/restore, module unload/reload,
ACPI S3 suspend/resume, and QEMU USB detach/reattach. Each recovery test
restored the PHY binding, carrier, DHCP, 1000/full reporting, and traffic.
I saw no AX88179/PHY/phylink warning, oops, call trace, or traffic timeout.

Tested-by: Jianhui Xu <neuromoments@gmail.com>

Thanks,
Jianhui
