Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F446411F9D
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 10:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786618470; cv=pass; b=FjbqkeGyimvI342ZHzUeVefZAZ+Qami6g+m4UV+nyNC9fu1ey6ZlZTJ4qiaYM3s5qI0lfMaDdw10Ma2ugzEUEAkHog+NGVupuOe9f6vNhbZctrFoPWgc3Hup1BriFCwO3hktrskP510pHqu8T47yyqWEAt5KimuOIgJmZbLhi2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786618470; c=relaxed/simple;
	bh=5E8lDhTSGdjryohzQJuTz4NjAIscyItLw5M5ZySDIfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m/8OroEYaunkrhfIZnhz5wVVqYYwWBc8OqMZCy2TRMqF6+qie+G+ZdX4MCiWIIb3VK937rdAUAVj6gJmSp0hsCJ/0kAhB87sx8x9EGOlp/Piz6yHff4jRHKqECiB/uxklBGPtZoNODiyl6WJVrZfctuTlfe6PM8xiV7X9DuaP2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ejUyZDGm; arc=pass smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejUyZDGm"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cbedd5aece4so642389a12.0
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 03:54:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786618449; cv=none;
        d=google.com; s=arc-20260327;
        b=DgMO7AOVYPFLWy2P5NMiwAUTCQeLuE/JjbC6T0WrKnODIdvMWuCtcpN3HbcIvIfYHC
         cfZ29G7A9SnW7lPbGNJj2GBVBhTHX7vJuUPZ5TTR9G8/IzNgRvTtG4XgYZmSuKpENsRz
         naWlkaqn0NFQBSle/Iez8iViSVLoJ4svT9h3Z6LERRr0SLw6o65x6GjfFZ6GIf9GHfa2
         SnK2kL+E/3fewrtScyJ+LZiJsp8ODiRuYIw+PyRryeX1Esqx7FMMys1hojDMLfTSC4IE
         7FeeLcElnkU55z3d8Ao23GEeJUGVAtCjCj1oSYl1ZnoX2pUKDxWzLoBV7BxnrkF46qJe
         DgrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ucjmi31stySKpq8sayBZo6yeaMDgZDDCZ61xnVduxj0=;
        fh=QM30ayeULyk+lS88V808eIbA6UuZjsd6//f5UHCDrDA=;
        b=H/V2dPqbKcsrBBVz/QmG4PzWZLdOHJgIhxE639wP84xbvmYEZBAthha5aNKIy6awq6
         zxumqLBhm3wKyWx14xox/3zn7QIT+UAMOjuAryMoliK19fGKwap57VENTGeu7ekHqHsn
         AfO5rsbJ3ZlTlFisBytK1FC/CTic6UF8GuIGBrVwOgss/M0BS2aFn7ayU0tY5fxkBLJb
         nkwRq7jpSP5qoC4BVB1DpKgfYrc5s7F2JKK6mLp8BSpRXBh06N0JsHfwNxiEJCIVX+Aq
         /iKJpwprJSuhfHoioobHdkNqBA+dHjILnVJ+u5yrof8M6V0AGNIhQuAyf4NWRx7/57JG
         BW4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786618449; x=1787223249; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ucjmi31stySKpq8sayBZo6yeaMDgZDDCZ61xnVduxj0=;
        b=ejUyZDGmPD84Ur4iHftFFFNYWDpuH9Oy+1HsEwZ382OURmUm+mYyQdiY3U6OhiZmp/
         B9DRSMTUSI+g1r/ceMrdJsZBuGgt4GGcrE7UzDjnKnP/7LwjqVVQNjn+0X23AnlfBWIP
         8gCDfFgmmY3HFJ1GLlud6ZRKmrRCi+zYs06qJvxaqp8NnPNkr6hFnSypIpp1uIoGBkKX
         dU0m3b12ft5vdJsEHc/6ljjHFsdVLKjh4sj3p+iuT9bOVSw5zL8hXTCbGvimiMvhlTQC
         R2LrmMk6yEH8afsCHxJiaUqq6y2v447w2yi30sMbDO0MkJfG9l/4ZHXDNamOHAmKbrnp
         xa/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786618449; x=1787223249;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ucjmi31stySKpq8sayBZo6yeaMDgZDDCZ61xnVduxj0=;
        b=EEBngjdQvoQH/0Q2FteEvAEKR5RB0ZWOPiu2aZ5lPw/cug6HQVOepX1NO6fpF5COMp
         JWkURdFIjX4G7q74zd+aaN9xkagFDQvm1OgQ9LDhcESLoKS2l+h9aBvwvwUdX7k8DKy+
         3bmX52wRWW1EAXAjk0OyevZ6btAuIxDAHKSBiz0Uknn///yKYkWREfGNlz/hELrWuM21
         I0qKUFPXncTCkYjjZJgJR/rDMIihu2rmKRCaNtpzwAkpyD2JWXbeXfTo550dYNqYc9UY
         k5vje6vVCrRiRpUK2m96nH2H1vpJlxlajpGM+aO+/rjqN26uwYkFQFS9wuH/c7ZfW8a6
         p0Kg==
X-Forwarded-Encrypted: i=1; AHgh+RpLxAmwTrCr/xqW+cDxio6XoeTiRiKC4ge4yjkNqyniaaKL4za03vZBRWxFFrO02Z6J2hDhRpo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmlIMSM+pSC78+Yv5l4i0g6PTajRXZiWRZd66KgXIYr9T0ef0j
	5q4IkmLkE++66ynnsNlPmbrwwrstXIhDbLPV0tqWx23QcseFinZP/xAFNBM8fNvxX4d2CFPXUa4
	1X3xtZhQb76uw1Jjf89cShMr8Hc1vW0E=
X-Gm-Gg: AR+sD11v6hpMyvXUeJuIhWFqqPfhrH9HxDHAwlG2rOrMOgMlNXoG3iK8HWgk19u/4Hd
	uIOEiBTqGWOTtFEcruFznMZ0SARnz4FA03y9sqxMYW2biki8t/lsQfxil9xHleRvRV7MQpcFNbi
	rCgsi0zS4lyhh417D0boMxC6l7aVEzE1z5LmiXGtoFtKfm2FL44iJjmUfv4CfC6A5ZUs/tn7g+p
	ZRcW4tDaSU+L2qg848uJT2K5jvXG/X5sqPGvHq9S9LqgBqzFZOvdCXEJBcPJRVrzAN7+UjTVxSA
	ksUOYQ5/EqkQFpcsXu4c0hZVCYIpckFTBecjzocI0jacmnYNWdhsRmQUKCSnQw==
X-Received: by 2002:a17:90b:53ce:b0:38e:4f42:d0d6 with SMTP id
 98e67ed59e1d1-3931f9126e8mr1840719a91.12.1786618448460; Thu, 13 Aug 2026
 03:54:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812132755.32585-1-zajec5@gmail.com>
In-Reply-To: <20260812132755.32585-1-zajec5@gmail.com>
From: Semih Baskan <strst.gs@gmail.com>
Date: Thu, 13 Aug 2026 13:53:56 +0300
X-Gm-Features: AUfX_mwvfJgoJzaqHfueN-LQn7bH3GneBJt2tzTAZG8zD1CSNA7ePCjt5jSH6b4
Message-ID: <CAAsRjRn4Pfv3LzQtVbeBzw49fN3Fk+M4JGwKkKq6pvo5Uk-fpQ@mail.gmail.com>
Subject: Re: [PATCH V3 1/4 net] net: dsa: b53: deal with Northstar devices
 using CPU port 5 or 7
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Jonas Gorski <jonas.gorski@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org, 
	Hauke Mehrtens <hauke@hauke-m.de>, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, 
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rafa=C5=82,

Tested on an Asus RT-N18U (BCM47081 + BCM53011 rev 5), with a local
DTS change enabling ports 7 and 8 like your 4/4 does for the R8000
(the in-tree bcm-ns.dtsi state). With patches 1 and 2 applied:

- The op works as designed: DSA picks port 8, the conduit is gmac2,
  the 1/4 warning stays silent, and management over the bridged LAN
  ports runs through the port 8 path with no issues.
- Trap delivery is restored: 20 of 20 BPDUs injected into a front port
  reach the CPU. On the port 5 topology the same probe measured 0 across
  every front port.

With all three CPU ports enabled, GMNGCFG ends up in dual IMP mode
(0xc2 read back). In that mode a tagged frame whose VID is missing
from the VLAN table is delivered to no CPU port at all: an 8021q
upper on a standalone port receives 0 of 7 tagged probes, whether
the port 5 conduit is up or down. With port 8 as the only enabled
CPU port in the DT, where GMNGCFG reads 0b10, the same frames were
delivered. So the preferred CPU port alone does not revive
standalone 8021q uppers on DTs that enable all three ports.

The same effect touches 4/4: the R8000 today has ports 5 and 7
disabled, the single IMP configuration, and enabling them lands the
switch in dual IMP mode through the same driver path. If its switch
behaves like this BCM53011, standalone 8021q uppers on the R8000
stop receiving with 4/4 applied.

On the RT-N18U the boot firmware provisions a MAC only for gmac0,
so gmac2 comes up with a random MAC and the bridge inherits it,
changing per boot.

Best regards,
Semih
