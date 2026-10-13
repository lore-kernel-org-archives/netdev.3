Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7AF39FCAE
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 07:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791877994; cv=none; b=RCGn9JDE/U2byogZ8acp8iWTW1pwmSMysHGyOdhC5hTgoL/JqHZBiLqssHK/su6J2aGju5Pol42VYNGM3HG6kPsCp3DgN9DoQ3w/MSQP77ebaDpjL5HFjv4lrJtA1fGf9aL5B/JtJ0VIYkSWRvwGmN5bWZCAGVvV03L+SHm6rlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791877994; c=relaxed/simple;
	bh=WuHNmevhveRDHZGym3/oQRSQlxTmg4usKoYghVaaSLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NRrOXwQBQFAldkxsWAff5uoTjV1ssnud/IrrMwdS5VH/6228xPXzClHRskSohxAw94R7TrEofIA/fTyJPGhBbaQ3b8EjtvUmycKOJ7na65LrSnrSExzBxxmljtr5w+d/3tdsmvi+RiHYPPNdGdUnRwpdllM5JY+3mazpwGJBc0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F1YSRPVs; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JdYQwNa2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F1YSRPVs";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JdYQwNa2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791877991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=32p4bkVSjbVJjkHnuQaeCCBADq6jSYClg9R5pRBhYMw=;
	b=F1YSRPVshJzKzfBwTPhhrhKCKWXivgj7kTkrlSRCS9pbSgOdFokhjutwMWyvSDLB5ocSdx
	orB/q3HqwGSKmsmAmai7KOlqnxzw+I+vcdwxKMgkw+h77on20UaYlcPpkZaV9tnbiZtzye
	BMQVFyd3NnvHj9X0lnMY37GB2qbmmwo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-MM3LY7o8NmeX3MMFeV1MfQ-1; Tue, 13 Oct 2026 07:53:05 +0000
X-MC-Unique: MM3LY7o8NmeX3MMFeV1MfQ-1
X-Mimecast-MFC-AGG-ID: MM3LY7o8NmeX3MMFeV1MfQ_1791877984
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-487038bc9b8so2092282f8f.2
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 00:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791877984; x=1792482784; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=32p4bkVSjbVJjkHnuQaeCCBADq6jSYClg9R5pRBhYMw=;
        b=JdYQwNa2Cu830inBPoJbsM18y1KN/KRhx0lNJuu+kR2H0L9AlM6H3yYq+lndZ5W/1a
         QSzL3Ff4mLxo/9mtQ6d19C9nZAU9YEFVpaReI/X9Jke+hYcrt+ZJWECBJALGBqxFSqqU
         jINMcOwQ7iWkhQ8l92+tzGOBrkf4/5JjR5smW+bakiUbUgE25O9UkdPuv5pwuSnAPcGn
         S8bvpEKyvIRQSimcPVeQb4JLU1+qZsiRkZbaYBXfB0YxKvGt9bMDCnMipvYofaYmucCd
         tcHR0AmxPYqQZ73n/YOMqEUicahITgp9LzaL7NjIcHBbdZ2jE7hAxj4ph+WryAdnrCxU
         ZpvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791877984; x=1792482784;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=32p4bkVSjbVJjkHnuQaeCCBADq6jSYClg9R5pRBhYMw=;
        b=ulYvK7CdqfCT7o/3M0MJFhONTfptewdUZIGIYuqVK3uhmxitMBWY39htExuex90B4P
         lyCWw9iVn+80yBtVhi4Tc5bemcvSg41HTF5Bb444Z5jHqrdwbZKhW2CCafdTcr0bTX+F
         vIhqsLWqzXEm1GBFjeST36yybI9dtP35dbTrZyuao0qd3ycwzu21uviSRD8RU42eDBbl
         PXs12Sj/lYMZ6xnCPeo7ecxEbvS6ccvF26ucNORHQWCcNCHqnLQKjI27C0fDymc1d1Xd
         BA33lh6NdxfYqHtOFhD9Oiv8SXneDC1FpQzlQ1jPRjeUusHPrdW7NNauK3HES3QeIJpj
         HcVQ==
X-Forwarded-Encrypted: i=1; AKwUvBw+WxwcJjY3JYOSMILKDEXa+hgDYbwZ5GQ5C++K60i5mi7jQtjyg9Ct55zVxvKstuPsh1oL+U0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJsIC358dbzJP/WtH2WJzZA/gndipqc7ikTf2nvoPba6xu7JU77
	JM4ZMDHPrNNrsU6UI1UJx/8K5NLwt5eI5XQmG7SnE/9d7LdRW+26XBuhO95agJfV5RsAYmYEShj
	eW/ctQpr6jZ+nRCyUGqisppNxBJx6vVwI8XCbpDyn6daxKoTHTuqvNQD6wg==
X-Gm-Gg: AYBFou1DByQi7K4FerSK0Vs9cXBbAYlKJ8PomYMgs9alfcvK56BHFAdIdQExM2tgWHz
	L4kyjpM6uDzXbFmQJCuWZha9zdo2uCdbzSVTT/mI+pPH4wEt4RCUDpiK5YYWhroaPiGZoFyrVGW
	ytMZE93rH/Wu1L9LIw76JAkpy1eDa9fPeCJDC8iYWsn3saTmPON9YoVaCx1oHyfLKVkWEL/kvld
	BjvQAtUR1fTBWMaUPETmWFU1Hql+VlaPbZcN6Z2rL8E+ihAxTxolaVKgQXqNwY6JykpX1lhL6ms
	ILFL8uc/1PY6VtQQP6qLFCrToyJ81v4eKC/YqZzGHbMzx6DW2I83YL3EZiL2wx4x2S23aNBWuGy
	Qi/eedhtn/w3tFCLQolUKa7/1OfUwmtNBz1/lKA3oozJtrNqrYHZJ4DNoAQxlTmJuSyBUKgXCvw
	==
X-Received: by 2002:a05:600c:19ca:b0:4a1:7e76:d02f with SMTP id 5b1f17b1804b1-4a18e4ac650mr226794325e9.14.1791877983808;
        Tue, 13 Oct 2026 00:53:03 -0700 (PDT)
X-Received: by 2002:a05:600c:19ca:b0:4a1:7e76:d02f with SMTP id 5b1f17b1804b1-4a18e4ac650mr226793815e9.14.1791877983291;
        Tue, 13 Oct 2026 00:53:03 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bf2caf4sm377412975e9.10.2026.10.13.00.53.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 00:53:02 -0700 (PDT)
Message-ID: <aa01ab1c-da2c-4638-816b-f535b635379b@redhat.com>
Date: Tue, 13 Oct 2026 09:53:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 0/3] net: phylink: wait for a PHY that probes
 after the MAC
To: Aleksei Sviridkin <f@lex.la>, Russell King <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Conor Dooley <conor@kernel.org>,
 Florian Fainelli <f.fainelli@gmail.com>,
 "Chester A. Unal" <chester.a.unal@arinc9.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20261006124731.1528963-1-f@lex.la>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261006124731.1528963-1-f@lex.la>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/6/26 14:47, Aleksei Sviridkin wrote:
> On the Keenetic KN-1012 (MT7981B with an MT7531 switch), the Airoha
> EN8811H behind lan4 has its PHY driver built as a module on the root
> filesystem. The switch sets up its ports before that filesystem is
> mounted, so the port is validated against the generic driver, fails its
> phy-mode and stays dead for the uptime. DSA does not retry it.
> 
> Patch 1 lets the PHY node say so with needs-host-firmware. Patch 2 makes
> phylink poll for such a PHY instead of giving up, for a MAC that opts
> in. Patch 3 opts in DSA user ports of switch drivers that set a flag,
> and sets it in mt7530.
> 
> The poller can still lose a race against an unbind of the PHY driver,
> between its readiness check and the attach. That window is phylib's:
> any phy_attach_direct() caller racing an unbind has it. The attach
> guard series [1] closes it.
> 
> Tested on that board with the series backported to its OpenWrt 6.18
> kernel, together with a940003f44e7 and 07d995873960 (the mt7530
> .get_stats64 atomic-context fix). The kernel had lockdep and
> DEBUG_ATOMIC_SLEEP on. Local debug parameters, not part of the series,
> drove the error paths. They fail the connect after a successful attach,
> ignore the opt-in, fail the generic attach of a PHY with no driver, and
> add a sleep after the switch shutdown.
> 
>   - boot: the PHY driver loaded its firmware at 8.7 s. lan4 attached at
>     26.3 s, when the port was brought up. Link up at 1 Gb/s.
>   - port kept down for 10 s with the PHY driver bound: no poll and no
>     attach. "ip link set lan4 up" attached it a second later.
>   - opt-in ignored: the old behaviour, the generic driver took the PHY.
>   - two injected failures: "failed to connect late PHY: -EIO" twice, a
>     second apart, and the third attempt attached. Link up at 1 Gb/s.
>   - failures that do not stop: four attempts and one "giving up". No
>     poll after that, also not after a down/up.
>   - four failed generic attaches with no driver bound: nothing logged as
>     a failure and no retry spent. The port attached once the driver
>     bound.
>   - switch unbound while the poller waited: nothing oopsed.
>   - reboot with a 3 s sleep after the switch shutdown: the poll ran
>     every second up to the shutdown and not once in the sleep. On v5 the
>     same test polled 3 times in the sleep.
> 
> No in-tree device tree sets needs-host-firmware yet. The board is
> supported out of tree, in OpenWrt.
I'm sorry to give this feedback this late, but AI flood forces this
workflow on us.

The above looks like a significant amount of complexity for OoT driver,
and I understand it could be solved with a different kconf?

/P

