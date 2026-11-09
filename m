Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794267945;
	b=aZauDdH7TwsXspaA3a3xvGNWq57n2v2Zss+L9MpkfUwmpIAYITbSvz7x0XbzxsAsg8Vq
	 EwocHueNeTBs88vbhW1WmuYb0n88lP4cGKwh7np5s8gQD1zzc7MGSgVI1wc6D5M3YPiBx
	 SDa/ESldz2pAuXg7H44bv7zq+JH3WK11R69HxnZdIZIUMcqdjPRH0xokvJvGxUC5PStpz
	 /SLQduxYeL1fFPpbNpUS36fLW22Zs4iY4vcLs1r/OwIn5SojKGn+W+ttnGvcaAy3046zB
	 sElEtfgIPMIkHx63fJlB0uyiE2jWJ2JRMkSByqc6HXYljub97fAo4nh/zxLbZUw99xQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794267945;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=X9fMC0zqN3ETxlJdsyr5ayEq0uPBqTA5dIHIwwyBzMg=;
	b=bL/cWLFbasUg5gbUHds2h2hhTwUunMWS3PakikGcd3H4/BZHdFCdM6sCkBtWn5HYE0Or
	 PzQRIUDvJxVJLdeGPv6Ge3Y6idS0AQIxlCV+AibC683naWAgfyibaml80fkEoHySCnjYW
	 ouMEb8cpwv2TBsNYSU9XCZLcJB7M8t6LZ23jRm16/2C2W9GKnHXo6rTjHM86geEBgZGdB
	 M++L5L9Zk8mQfEcSPrxYMz2SKBoByApeHkbAhdjR5CMh8NqS8Yt6Om2gy1hpqSV/w2tUW
	 /P3Xa/foDcJ9khU02uzOBFJWfytpvdfa9fTYroKVVG9V8TWwBxKHe3iAWA3kvycUgvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=telaak.dev;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE7560A2601
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 23:45:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FE7560A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=telaak.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2e95bd1c14cso13127645ad.2
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 15:45:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794267944; x=1794872744;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=X9fMC0zqN3ETxlJdsyr5ayEq0uPBqTA5dIHIwwyBzMg=;
        b=THIG4fkO5L+JkIb7Rdj1DQdKGZHq8YATDr5ybrLraksV55JQTCFsAMmULYkBQRo3Aq
         /fveNcndzEngxnLFzig44KQt9MkWZnwqiwlBH796GmO8zgrrxKKnl6Q6vdgq94vzDa9E
         JeXSJj9eCXw9EDWKUxf9oLDjYOZXKw7ouxylcdymSrIF+v7znLsrpgZ5FbHRmCIX7t2l
         INuuqUG10+r1QCwAdFj7EEZD5YRs1X2MNJb9kTVCqUWdJ08wknF+n5sQaFGgs4IZs8E0
         ac+vz0CF/QCwBFXCucFNnc2CRpKhV9GT2cjs7lm8QbADYugiAjAzJmeBb84Lahb5xylo
         K3+Q==
X-Forwarded-Encrypted: i=1; AL+hErGSWlZvB/bTiteO1lktm7725ozYfM35RWTUTQZQ3LZc+im0aanjgsqXCCbo3AdxLPx4g5+fk5U=@vger.kernel.org
X-Gm-Message-State: APuU4Z+wt3IeZITEQEHERubdsUN4utcwv2ocXB0u81EBYqnYKghZN7N4
	LkXOLoXmPe9KQ58zOFzHIzexKRyjDnqo3GziKkxkbgJZLdVRKV3x2yejRpfQ0nGq
X-Gm-Gg: AYBFou2I5Ts/ppfA/Vu2gjW2YKhHLaSQ1LJoQ5N1rDoTdiqNldVCNUnYaskT/ODZn1O
	4PLmeWk3R1wtiPyiG8Nh7hfyru87tSjxOPv8vs2URVmUsHKO9Lo6imMzW73shXM+xxSsbsR9qzE
	XjLVGrLTERf251Nl2XgbqP1hSRC39+Cc2sKmAv693zuHkjv/nLUchTZTawM/WzrUYjXilTWNUiy
	UFBlZip5N0aKe0i0t3S+pvL3/aSgK2MhBRUmsZ+Q9G/8oyWVk1x0lshnY3tZJuiD6WXoB4X7lnH
	l2FRU9hKo6bSqLFq80aqKdFVVdJOJKzoDs7f27WAY5d/bqM6Vrlc3T5OotbHpHkk18xzH82YX0m
	Tz7VmAWN/xjuE2u0n52XGTw31JmzWmy072Ey8+ybB3pfI6PFVnJQdG6ht33Dwe2b2metfJZO4ms
	y8btQzP8nWgQfH8g3vFnsTI1JYkSXqOTIscnRKVnE+VE9VOeBY6MCQWgiiRWKWlAyhlEXfLplgB
	Itbj5K5BRSAFc1j8w5HR9eYUTFWHy9hA2Z9/T2wgL5m5BooOwuSV37/dFAFDov39xseEn6mnby3
	isXzkg2Van2be5sikB75skwWi6dPwkTG6GwiWvHnFgi3dYBV4FN+ALdHUtB1znP2ooO21X8vg5D
	6Sar4iSfC4XGzuvqhYnyBKNgzctVx8fHdl8nlGLFS3w3m/g9Nt9qpBHeTW7ug
X-Received: by 2002:a17:903:3845:b0:2e9:55fc:ded2 with SMTP id d9443c01a7336-2edb9283d89mr7682615ad.52.1794267944448;
        Mon, 09 Nov 2026 15:45:44 -0800 (PST)
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com. [74.125.82.42])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb6dd2247sm2531055ad.58.2026.11.09.15.45.42
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 15:45:42 -0800 (PST)
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1931ff67a29so303128c88.1
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 15:45:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFjEVYEV2Cw4S4JrOScSixOeGittUw3RD0YOlfjYMfvqCCWpqE+uNqwEVL8ud2V6hhg85MXjjE=@vger.kernel.org
X-Received: by 2002:a05:7301:6790:b0:36a:1904:60a3 with SMTP id
 5a478bee46e88-3751ef79800mr1511776eec.15.1794267942134; Mon, 09 Nov 2026
 15:45:42 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261108-mxl-gsw1xx-reset-v2-2-46c1da093893@telaak.dev> <179426744353.994134.16211561618771955131@kernel.org>
In-Reply-To: <179426744353.994134.16211561618771955131@kernel.org>
From: Joseph Telaak <joseph@telaak.dev>
Date: Mon, 9 Nov 2026 18:45:30 -0500
X-Gmail-Original-Message-ID: <CAPY4CJ5oMoZoJ9ivcOBe97MmT5t0wa4aj1dc8BS_YXOsbPO0bA@mail.gmail.com>
X-Gm-Features: AclHuK-cQP4T-VAWBA1r5t7qJjfPj8sdhzoAjpgY1zmdvVatkQxJQLIbryTxlWU
Message-ID: <CAPY4CJ5oMoZoJ9ivcOBe97MmT5t0wa4aj1dc8BS_YXOsbPO0bA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/2] net: dsa: mxl-gsw1xx: reset the switch
 through reset-gpios
To: netdev-bot+sashiko@kernel.org
Cc: hauke@hauke-m.de, andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net, 
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, daniel@makrotopia.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> If CONFIG_RESET_GPIO is disabled, does this lookup silently return NULL even
> when the switch node has reset-gpios?

Yes, as for every driver that gets its reset-gpios through the
reset-gpio fallback. A platform that uses reset-gpios enables
RESET_GPIO.

> Would a gpiod based lookup, or a gpiod fallback, make the documented
> property work whatever the reset framework config is?

v1 did that; Daniel asked for reset-gpio instead, so v2 uses the reset
controller API.

> Does this full chip reset conflict with the slew rate binding?

It does: a board that adds reset-gpios gets the power-on defaults for
the slew rates it does not set. v3 will say so in the binding.

> Does each deferred probe then repeat the full 250 ms + 1 s blocking pulse?

Yes. The switch is not registered at that point, so the cost is the
delay, and only when the conduit defers.

pw-bot: cr
