Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699223385AC;
	Sun, 13 Sep 2026 20:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789330227; cv=none; b=RungXfEEw7FZZj2T5wRYWjW9HqoDFGdIUtNiMH8IOh80C9z/1hNcPX7K/WE6xMCwux+tcP7Nz3CXNBR4eCUVl5R9Izf3VHIROSVeGMNei1jtyU42kxKg0cUJHbNmD0dDoV5KllKiRtpQmWPurZalrxWVEHZwxigMwYhbRCsNOtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789330227; c=relaxed/simple;
	bh=FAmAMadU9FycGEA1u0bIGT56HkOb1bpX2X/hpCy0hWg=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=nteey72ADnt7Pk/zRg+n5wuw+Cla3lSX+X7FgLiWTl2DukESdhfIy7+qe4/u8t6hF7Q31t1EF3vYhJLWJqhIzySbaTM9q5SPQy92T77q9yn4B4QFAr32LkVTMpD8tagA+9c0YkRAa/NKS9kER0I7ch6ntyl9klf3WTCNj6ryoe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=BpB+emZI; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="BpB+emZI"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A1C4CA90F6;
	Sun, 13 Sep 2026 22:10:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1789330219; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=kR6mLL+YtmOzK+o5Sm/gsP9zVRbGQvaawUFopwdJirk=;
	b=BpB+emZI4YTPjY2vGDdKkZp90n+G17pQhbLaDG+ViJKaKcs2G2sWe6wnMjDT7XZr5BB4BE
	HyCT0xwvh2Jx0kBgyYqdVm8qA4g2xQVzXQOxBbk3eoXwbVh2P0IMokud3s9bkc35f3TeAK
	lb6Jj+LYwk6Pt4qWGpK7C12W3ljKfe2ceewHv5AK2EtyovKxlq7jU4bxbICkC41QnqK7Yl
	L07HmyROBEpzipWqNGcicbtoX/r+nUO/r9ZuXdJ67bTQRrzvNfazbhfFap1cBFryeurYWB
	y+ZV/XDInn+QpA0H2kIXJZEbbe0qk0MpX8GW2HzqmVDoeUc1/Zrn/A4miUl7+A==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 13 Sep 2026 22:10:16 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Linus Walleij <linusw@kernel.org>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>, Simon Horman
 <horms@kernel.org>, Russell King <linux@armlinux.org.uk>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v13 3/4] net: dsa: microchip: Support Microchip
 KSZ8995XA / KS8995XA
In-Reply-To: <20260913-ks8995-to-ksz8-v13-3-327b16d309eb@kernel.org>
References: <20260913-ks8995-to-ksz8-v13-0-327b16d309eb@kernel.org>
 <20260913-ks8995-to-ksz8-v13-3-327b16d309eb@kernel.org>
Message-ID: <5ad3cf85fcc2a5bd64dbea0acab27ff5@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 13.9.2026 21:56, Linus Walleij wrote:
> This adds support for the Microchip KSZ8995XA also known as the
> Micrel KS8995XA switch to the KSZ driver.
> 
> The KSZ8995XA shares family ID 0x95 and chip-ID nibble 0x0 with
> the KS8995MA, so hardware detection cannot distinguish them. The
> legacy "micrel,ks8995" compatible is therefore treated as KSZ8995XA.
> No KS8995MA users are known, and KS8995E has no documented SPI
> management interface. Neither MA nor E has been verified with this
> driver.
> 
> The helper macros are named ksz_is_ksz8995xa() to make it
> possible to add E and MA support in the future.
> 
> Wait for the self-clearing per-port PHY reset bits before continuing
> with switch setup. Poll each port for up to 600 ms and allow an
> additional millisecond for the PHYs to settle.
> 
> The KSZ8995XA has eight global TOS priority registers with one
> bit per DSCP code point, providing two internal priority levels.
> The registers are ordered in the opposite direction from the
> other KSZ8 switches. Describe the two priorities in the chip
> data, then augment the DCB helpers for this.
> 
> Practical testing also shows that its packet-size control bits use
> the same semantics as the other KSZ8 switches. The polarity in the
> manual appears to be wrong and makes the switch hang on big packets.
> 
> The legacy KS8995 driver also matches the Micrel compatibles for
> KSZ8864 and KSZ8795. Add these to the KSZ SPI driver here and use
> an exact tristate dependency to make the drivers mutually exclusive.
> This transfers ownership atomically, avoiding module probe races and
> gaps in driver coverage between patches.
> 
> Assisted-by: LLM
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---

> [...]

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
