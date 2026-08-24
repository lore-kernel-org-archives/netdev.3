Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7523374169
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 02:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787539224; cv=none; b=Xhy/WMTNk0yqSkhaw52CoPYgZVrFthl4iVeg3ufy8K14YbGd1/W7j+ekPJOO683yXQycf3GwfxtxKfyNO6Qwf5L1roAaF5o/BkWkX2YPYHHfrOGyPTE6JHNq7ca3rJKM/ahElAGncIls9jyZVxGkBtcixpO/oLS8FbsosveXa8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787539224; c=relaxed/simple;
	bh=AYu3qPUBsFTn43fSjEMlrPrBNFTqVVASAlsfrSCV2H0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SZGqRUB9+kXQPUGxT7nsreb5BToIhCq2wLGmgoSxNoyMCyoCkinkjuM3jUORRGwOf09haOuHj4p62AID1JlMIdOZcIiL0oUhC/kzXlsfBzK7l8Fj7baAGn04WqXlNvR/GhZ3wj/UxmllNvpR6b+uX9sr7uYTTcQN2FkpY0EaUWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=FUwz3SRz; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="FUwz3SRz"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6a10d02ff43so5928188a12.0
        for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 19:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1787539219; x=1788144019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AYu3qPUBsFTn43fSjEMlrPrBNFTqVVASAlsfrSCV2H0=;
        b=FUwz3SRzBVeJhpzqxWioCq9fi3hNv0lJAuT81vmVeaQVBgvtXXdZps6B32kCEUUP/o
         l0985An/horW03r5jaw+IiNbcLERMUMsg5veOxu7FBaxxl0SrNwpdjhPprsbLjHSo5+b
         iGjO+oTN/cPe1NPuvl/or+sNBUAo+LkRhpVZb7VYfM4sRzgPVKqEjSa1TxafAvPokSud
         3c/joNxviU0Tru7HE3Nl8XGAWKHba4Wzgl8EybLjbzM23g3TqMDuimxcdTNMnxBTRHa3
         RzjegSCR1VnrDTkH+3mqQM+E7KHybRJSU01xh0HWqL5Pv+y515JA/viLj/dVu89XHeXG
         wZdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787539219; x=1788144019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AYu3qPUBsFTn43fSjEMlrPrBNFTqVVASAlsfrSCV2H0=;
        b=C6kDU14/orVTQKS7doGmITDjmwU+JNEssQ8gQoPcvSCvYuI/5w/0RwYN1aKsVIE2g8
         H/HidhB73ZuqpJ74UJqNoCmTG5zqod3VQ3vEuzvzNdfFVaFxrL0xw2qZ/ellt68iJkat
         qJIfVrM7tLZ9XgSzH0YJuayfjExywUexXlT041e0IYUn5DTIDsCg6AlWhYK6mOcEYi6i
         ahgOPrCF15h6VKdVIzW/s2OfNhDKnUFAnXkhVVb/J72KsdJku0eJ7dASMr2kea5CeDA5
         Qb5TYb+yvldC/Ab5A+lZtn9L/XrJYjOYbmFgrAFdalRnpHGriXIm76tTIShuyC1PFY9c
         6ELw==
X-Forwarded-Encrypted: i=1; AHgh+Rp3QVRQPHg9p0NFrV7HjUgxVevytPPy7RgVN1fAj2rSvynhDS1PdMIRzRO5Y6H3S6rKKbdPlE8=@vger.kernel.org
X-Gm-Message-State: AFuF++lBEk8LcCWBahH/1Wt7bDm5Z97OW/mT4j3Rr5GEM+atDUpK3HOY
	+vrmwHCc2aaULmdrZS9rjqjif/CjP/oK8lDGBBbeMLfn4uc4WYmZS07G2M2jRHzMCEg=
X-Gm-Gg: AR+sD11SAKw45vXdSD6diwmcgfdCErWvfhXBilfc2uuIczn+EOt+sz3rYtEcTOzyc+v
	FDRxiA9Ufnga/+D9ajdq57Vka+vmg8Eu6sbXHg4eSfa7HgYXA9tF6YqXuJIOQW8IWOZwI/MetHz
	NXCffXxIhWK7yFxUpUr5LRHHggAKbacYKXqT74CQHaiivQ/ZgNnAtHjeLzRdeMvtbQqLXGJLcwZ
	07l8+e0ZvG5bhWNoC92S1Li/wr4v0Ayc6Q8tG/z71LRU81Abf0iIOY/lI+Y7IHvFcH4j9F+KGjd
	PxyTfn/XzzNW5GTJuV+JWkRaffYW8yo02lw32QiWoN5xD6CalaEntRFZ8W0iUSMRPdeCSYw5tyT
	Cm6rS9s6AIPXiRDnutZz3/W3s8lJ/xBlAmGgIuDZRTJ+k+9qmDQ37f3HL6PulUXWVHXq3F7SZ5E
	8hZ3r1nHDHFka+I4abYeaUOqZ4OWdROQ9GCOwPJ5aO/IA0hrwRVnDyfT0y8A==
X-Received: by 2002:a17:907:980d:b0:c20:56e8:5457 with SMTP id a640c23a62f3a-c246a359c6fmr2233438066b.6.1787539219351;
        Sun, 23 Aug 2026 19:40:19 -0700 (PDT)
Received: from ownbook ([195.181.160.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2496738e7esm1121017466b.46.2026.08.23.19.40.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 23 Aug 2026 19:40:19 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksei Sviridkin <f@lex.la>
Subject: Re: [PATCH net-next 3/3] net: dsa: connect a late-arriving PHY at ifup
Date: Mon, 24 Aug 2026 05:40:15 +0300
Message-ID: <20260824024015.39701-1-f@lex.la>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <c712cd5d-d4bd-413f-82a8-6303ff3e6526@lunn.ch>
References: <20260822155259.87146-1-f@lex.la> <20260822155259.87146-4-f@lex.la> <9557daed-f039-434a-ae64-ac849b9860be@lunn.ch> <20260823000549.6095-1-f@lex.la> <c712cd5d-d4bd-413f-82a8-6303ff3e6526@lunn.ch> <20260823123729.74290-1-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Another option is move the firmware download into the bootloader.

I went and looked at what that would take, and it does not help here,
for a reason that also corrects something in my own commit message.

The firmware is not what makes this PHY late. air_en8811h is a module
in the rootfs, and on this board it probes at 6.25 s, while the port is
already dropped at 1.878 s. Moving the blobs earlier changes nothing
while the driver itself arrives that late.

Even with the firmware preloaded, en8811h_probe() calls
en8811h_load_firmware() unconditionally, and that starts with
request_firmware_direct(). Nothing reads the version register or the
ready bit first, so a preloaded PHY is reloaded, and a PHY with no
blobs available still fails probe. A bootloader preload would need a
kernel-side early-out to have any effect at all.

And it would be gone before then anyway: the failed bringup ends in
phy_detach(), which asserts the reset line, and this PHY has
reset-gpios. So whatever the bootloader put in the MD32 is wiped at
1.88 s.

U-Boot does already carry the whole loader, in v2026.07, which is what
we build. What it cannot do here is read the blobs out of a squashfs
inside UBI, and mtk_eth_probe() takes the switch branch and never
connects a PHY on this board, so it would be new code either way.

None of that argues against your main point. I am dropping this patch
and sending the phylink and phylib fixes on their own, since they stand
without it. If the phylink hotplug direction ends up wanting someone to
test it on hardware that reproduces this, I have the board.
