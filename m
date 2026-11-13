Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794609322;
	b=X6Zd8EfR2EUSNCvC0U+OQvZBlEHxTo6UHkVmeqe7zR6lKMGK/epY3HI1z5/C5L7TvzOE
	 H0Wi5bMTt4vJl4v74ivjHTG7BTeGM3J7yoRka1HIsfReIw+LhjAtwqTzpO0MSNXCS1Yw9
	 vMRiQgq1PkR1mAvAYJwvRh9AZwvgX+qUh9yqKDoxKDjjFOkgsOo7pgWZ7GDz3McrDV86m
	 y1wfzV+clkc/cW/J9QrlvQKCf5sMoiebEUPNmFe3jhI8R8eoE0LGURcNtWJKlbrS8DY0v
	 chG863YsrHiOhYgJacvNqE6k5T2ONkvlwGJrXcyN4wqSNLLG1OQCAahSsnvJALzV1ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794609322;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=LITKaWV7XMnQptJT0JVIP2eNuxfwTtrcVKQlo7sTeg0=;
	b=i3gcmG3CYuY7ImK37ATUN0pl1EkdToFCJ129CF57wgoSZ3wNK9JURQqOZUQ+phSPpj9V
	 Um/IAspFfHJ1ZzQG07xjHHEsLSrer33zG4KD87b+Nkdj/XhsNdI1g+G1WbIoXmJm9ficH
	 pVjd+1QiuoXBbPoc58xcKShz+B8n65jac+LfsO3gzk/krJwSexPdUkpuPo3Tz9mZRephr
	 r8/w0HxX9gBkO5YhKHJc/EYA2NQ3ll3ZTM8EZ/FwBotIeG7DsGD9B/Yiz8JYXN12EVVXO
	 cwAs/bAP0FEM7augWLt0MBcG4McWnEreFW8za20/eGTNu6V9YpKdI8Y/QM8neV6bsfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=telaak.dev;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A75606A551
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 22:35:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51A75606A551
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=telaak.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3ac78f4c10bso751719a91.1
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 14:35:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794609321; x=1795214121;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LITKaWV7XMnQptJT0JVIP2eNuxfwTtrcVKQlo7sTeg0=;
        b=wPdC40cBsEUf9mwIboY2H1V+Ipwh9PbIy/iEpC3jEfHAhFpg2LqFmwrF3MKEIS8wn2
         pkC6MZOrvlz97xwWYRmLtRJ9+LGcrN1yA6nGhWICjwh2aSk4FprBcunKiF14YR8+xx2H
         yd9pNTwyxFmqz1Hao5XUAiWjMXWh0MTr78YLpKjNjiWvFm8fZSr9nRPbXuDHQSuK9K0r
         Fum0GaYS5fB8hRFKMpr1CSLZPCIPWZirBEZ29lMlcaJShb2uidokCadHcMImHAUF1Uuv
         O5JiW6GRJIBrR0SuDY6rGYmHuJzcjj1s8YbDOUJzm59TTLqP/x/YD9ZwtBagHF5LpGGd
         llPg==
X-Forwarded-Encrypted: i=1; AL+hErGEVgZsK4R7X/bfIlFNRZW4CbONXdiBoI5bf5OBBMRnB2reOWLtJg/bt7GQc0TAKe0F1yZ7N/U=@vger.kernel.org
X-Gm-Message-State: APuU4Z/DyFkPk13o7V3RFCVTroGOkpXGbyFytaJQ0k15a3IBbwiYLEsl
	rU1bDpsJiW0jFTMEBPmNharJv6o6kg6NRvtAlL8TmDEmejQ8eQ3lUxhzy9PF1h4i
X-Gm-Gg: AYBFou3bVC6O9IoFLsH+1rwRVIfcxZTdIf5BgwIA4FJnrcDgXJoe7plTtr2PB1j1bB1
	YHmXR1PHa4Z6F4xzzQ/cI7y8cSSNjWfhRVrORPeuRnEB96FBaRtFog54fxEU/FpkOIsRwoGQ95L
	T6vICMhab2m4J6e+W5cjftsI+hbCXE3q+teL2XDyH34dxG4qKubWaIadQEL+QzV4Mreuo+LlTTy
	mMlTNN2yMU/Q4vJJJCAl4EjNB/kttuF1ftECSMmWfgMqGZLFM7/4q68Fvrs5LRf1dxPGsJYJ4Yo
	K3wcLkPJWtupr95l932CnFbUdwhlEpC80IaRugJW8JFDJd+eH3lcduCDYje5ghPo4jsIGe98KOO
	9gV+K9o7sL8QAQS1uuIwaRwVF2blBFwJzBqQvsA3s1niNexecd8Ch2NVyVzScN63Sbs8Vt4LGbO
	WUMOiKHst/b3BxV95A2XHp9LTvbrOFJFHkzNL7fIUwggq+ID+amCdeLHQruyckbyqXRU8rXkfA9
	x6wWTM81NxnVcLQXXAPDfiZ1RwqVdjUdo1zx4EQ0gRpk4hR+kMh3lxj9Y548gzVhe1t6EuJn6cN
	FvQP2jitwrRZkLmIQM36myVfikSUQ4QPfE9lkuxfpOvee89wFTZTdrCV3bjIDIlQjV2Vmpbdepm
	pQFdWWM61n1lkGsE1K/zWeessHJK9C052S+UlBhAiR1lu
X-Received: by 2002:a17:90b:17d2:b0:3b0:c11a:9026 with SMTP id 98e67ed59e1d1-3b1b0ba91aemr3941048a91.55.1794609321563;
        Fri, 13 Nov 2026 14:35:21 -0800 (PST)
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com. [74.125.82.181])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d27d26sm11203113a91.13.2026.11.13.14.35.20
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 14:35:21 -0800 (PST)
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-3720addb068so2383768eec.1
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 14:35:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHVRVOJSMnQZddtfHuAO9C2hMAmjdf/CI3LFm9u3y8Md663UHBFQOD18JX+lrhtCLgD/jIxm24=@vger.kernel.org
X-Received: by 2002:a05:7300:85:b0:376:e950:873e with SMTP id
 5a478bee46e88-37965f9ad51mr2968029eec.12.1794609320230; Fri, 13 Nov 2026
 14:35:20 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112-mxl-gsw1xx-reset-v3-0-863e82074893@telaak.dev>
 <a2f45802-b75b-4a19-9508-2d1b5ebe473a@lunn.ch> <avcoghKd4CU13QI_@makrotopia.org>
 <9804b024-236a-4791-aa55-d83a71b2598c@lunn.ch> <CAPY4CJ6jQTNE=ZtyBysaxuOxG1Pb9zFsYcyas8isfXte2=OiKw@mail.gmail.com>
In-Reply-To: <CAPY4CJ6jQTNE=ZtyBysaxuOxG1Pb9zFsYcyas8isfXte2=OiKw@mail.gmail.com>
From: Joseph Telaak <joseph@telaak.dev>
Date: Fri, 13 Nov 2026 17:35:08 -0500
X-Gmail-Original-Message-ID: <CAPY4CJ4gB42mW6UW4Qk6r1+u2_AA=58WTFCvRrea2cedPuAcBA@mail.gmail.com>
X-Gm-Features: AclHuK92955TDOieITeTuWAvZpOeGFZi5VRbt4O1JwbW-bk85arSJHpEKRZecOs
Message-ID: <CAPY4CJ4gB42mW6UW4Qk6r1+u2_AA=58WTFCvRrea2cedPuAcBA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 0/2] net: dsa: mxl-gsw1xx: reset the switch
 through reset-gpios
To: Andrew Lunn <andrew@lunn.ch>
Cc: Daniel Golle <daniel@makrotopia.org>, Hauke Mehrtens <hauke@hauke-m.de>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, Nov 13, 2026 at 05:16:51PM -0500, Joseph Telaak wrote:
> I'm testing the other way now, with the PHYs described at 1 to 3 and no
> reset from Linux. If that works on warm and cold boots, this series
> isn't needed and I'll drop it.

It doesn't work. With the PHYs described at 1 to 3 and no reset from
Linux, neither LAN port passes traffic, after the flash or after a cold
power-on. The same board with this series works.

So the addresses aren't the whole story: U-Boot leaves the switch in
some other state that the DT can't describe, and the reset clears it.
On your earlier question, the driver already writes PHY_ADDR from the
DT, in gswip_port_enable(), but only once the PHYs have been probed.

Since GL's own firmware resets the switch from Linux too, I still think
a hardware reset at probe is the right fix. I'll send a v4 with the
cover letter corrected, this explained, and Sashiko's points addressed
(the silent skip with CONFIG_RESET_GPIO=n, and the repeated pulse on
probe deferral).
