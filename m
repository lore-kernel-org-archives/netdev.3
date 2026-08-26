Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBD33B1009
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 07:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787729879; cv=pass; b=TIFC+sC8nvGhCBnPL9hT8Tq2XefFWzlJrTh7k72VTzwooG8Mqd39s1m12sE1ek7n0QNmsyrRisTJe105vq5A0ixo1ujeh1K2HWdvw9PfGwym46DcPVDcMrohMFG5crBMcl8mzEKCziXDA9lyuF40FXstOoEzZEsAfL9PQo3Z1lU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787729879; c=relaxed/simple;
	bh=9CuXYFzJQHAR17ILcQOe+oHq0lNbAHdDhUVd9fK4cL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uTKQSjKjulb70g6Sjh7JD0qKE7RK9mBoFjoFoOp4NaAPA/4i7WUA6ir4jZqplTMJiI/JaDc6fJzM8hzTLQZbYOrsWpXu1ws5WCnZglzLS6hwR/eJ6ECx3ZwKlNkYQFsnSjGlb73Edn09GBFVXa6rzoO+i2lvCJQpSiofxXdAh6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=opolCsl+; arc=pass smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="opolCsl+"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cc1cc1b42b5so79305a12.2
        for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 00:37:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787729877; cv=none;
        d=google.com; s=arc-20260327;
        b=WLr7FE6UhVGU128sH+VvqarbGgP/2Vc7vilnWKUCtQOwGxOU3Egz34QWtiYHi+Yqvo
         ysHIGi53UO10uayUTndVAgWtvrDbE9ui+jJ9Y6lPXiJgqD/UybPC3OBNU9EsnEkTM01l
         oYXJqCj7pCelV2tBa0z4QdX6oDTbjofviknpDN/mvW5iUFBv9qDZ2G4qrIrqmSvbC8OK
         rlvoOenwkwqYjCATsIxJy1WOSkwLULSJ7/fW0YQpOvYhBR1dUziSoBaDVBuswPM8ePgr
         geHlWc0nQ7xEwFdnBKPDmK90Wl28Zz3xr+W/0Ha09tr8DveMo73fZT6RO/QNTAstcakI
         d6+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cGZNn07Vu/vgmEPOOzUhXRmihjve6EKaqA0p2De97l4=;
        fh=28Bqdfq2mtjeRk6h22xE81BGCGXLnjOJl7KkQWqyWFs=;
        b=Z+2bBgUC0ziB1L5qwd6OUBZ+1hIJbcrFJ3jxuzDH0J22wNHOyhNb8/IBemlj1WKN3z
         2z1nsaAEM8EQ1kchADWBRr0CT6nbzEIS/bOVK0maP1rI7gHVtIgClUjVDdC4zGTaGpHb
         e7fkWX2x+GAPwOr3xfQynJ1qae1zrFHQrRHvUCgMnKYNgUc8LBx7PIOpr1nU5zdch4P0
         TGQNRCX1yq5lIsixtwNGZp1ZKVWSPukJfCZy6U10XUwUJRmMs8n5URvycdj+HV9IjdhS
         ZchuNsBvtcIQJTIjzmjU6VSyQeoEkmazgt5yYIhCYJdwMc9ntN8R8WbG2hYxZcymsBTF
         q8nw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787729877; x=1788334677; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cGZNn07Vu/vgmEPOOzUhXRmihjve6EKaqA0p2De97l4=;
        b=opolCsl+9khXkyUb81daVMv0Djq+Zzg/XOtEbWibPbLnafUSuZpWZ//aN5Utk7Im6m
         U55jEnZUTf4R1Wd4bca6SLq5VxeZprAdkeTKja9EMZwvruTXcUEEOmWvKWqCzuiY879h
         K4arQADHrfbbIkSubz6OOSuIK/sQlG7TvZ1oI9yP2MXyPsYPSJqj0iMttXucwzRbZ2ha
         73BD586b4sAJaw7Up5WNyASdiSHhjOcwFCbgove5clDghq3sfqEt03U1g7THjv3jw+KC
         9zgLRWF85ioMT6uxQzHtt7BhIYR14kiXA11khRARVdc8WPI5BLHiK3H0SIMKv6SEFFzw
         tiHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787729877; x=1788334677;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cGZNn07Vu/vgmEPOOzUhXRmihjve6EKaqA0p2De97l4=;
        b=km3+f04OZKYmSNOdJ6GmofWpSvEPlRALrRB8UgXz2hO4veeDXjXUeB5jXZmJYaphKP
         046r3XCt/WgH2R1ZqdVde0ckZldpMp5BHI64BCDJZkEFmDpcDBU8jqVQ+8gwotEVD9No
         kZikKupQ8oZiAs7Io/clWrywgqfBHgaUzOH8qR39EHY1dJQ0f68Sv+hkooSyHYX+cqgX
         iUeKa9hIgkyJr/RCI5AGHVO2l41z2ci5BKOM+yWmiMypbr2ut2fo51wMzzpzJWVXAHcY
         QZlJEgorEdirnOjcWzs6dTpvXIWV3vKSJamPug0o8jQEgjBEaL37kBgGJ5Yjmpkujh4l
         BnVQ==
X-Forwarded-Encrypted: i=1; AHgh+RpThKECBAg48yyde6o6seBJlz5FXqVeLfDpHGVjRMAvkNrdksAYj36SWXCQjQiS8jms2Y4gpBs=@vger.kernel.org
X-Gm-Message-State: AFuF++miUtCgOOH9aknmXFVneuLgeSRIjxHEqg9rQcrYoA2dRcY1uFNI
	TJ6NoR4+7+ZesGYCbGQphIwcXlfeQEIB9u1fDHa7mNKHwPbyuE8SqdaWQdx3PfFFW8H0H9GkVwd
	hFP3dYAG8+pSQ/k7J1Mp7Gn+ZE4+QIHA=
X-Gm-Gg: AR+sD12953YVzaSTftbcgQaOjVQi/IP9GNdYdm3LfmvqakPu21jQ6R5ODXJnD9tVvzu
	CJbaelbTPAQ4ULIvOFq47jIFYCZWyrjmqZL1968ZXDaZBwqMkOGJuYJnVw5D814h78kM6GuED4N
	OPn4kh3o6h7tafk+izVFrWCH7ey8Zg3xDfJRbqhcznSa7xhdGWFKI/jGaLp/rttRtLsMRm0otak
	RjrsQcuocgVl8vKwsipP413QwHpEK1HQ7Ln6tJlpSrQv8wKAkCQG7t8g82zDiBKkmhmQhp48qPq
	vJCwsgRnIGBxEfmYw904yP79jbeSD6L4w6tyVbtFj/LcUg9ggTgqdQD/xT8bDwLh22JP8hPQsFW
	H0fwhZBG3t0tS2twnx9SNfxXctmiY71LQES7z4S+BWdpPcoNUfp+IB0qxNCtq
X-Received: by 2002:a17:90b:3848:b0:396:40e6:f631 with SMTP id
 98e67ed59e1d1-3966d178358mr9759975a91.3.1787729877180; Wed, 26 Aug 2026
 00:37:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824-b4-fix-pcs-lynx-an-v2-1-9bb1dec96f0b@gmail.com> <20260825214928.rz52tysloa5yxq2y@skbuf>
In-Reply-To: <20260825214928.rz52tysloa5yxq2y@skbuf>
From: Patryk Biel <pbiel7@gmail.com>
Date: Wed, 26 Aug 2026 09:37:45 +0200
X-Gm-Features: AcwNN1WHuKVl6DR9BslvEaf71jNgZRLqGnoUgCLRf7zJzgSBCHgdmAmIKxkSAv0
Message-ID: <CA+DkFDaHQVE8g2iDUrSbRcY6-xihJQpRNommh57B8wRnePZa1A@mail.gmail.com>
Subject: Re: [PATCH net v2] net: pcs: enable autonegotiation for 10g-usxgmii
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Vladimir Oltean <vladimir.oltean@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Vladimir,

On Tue, Aug 25, 2026 at 11:49=E2=80=AFPM Vladimir Oltean <olteanv@gmail.com=
> wrote:
> There are multiple differences compared to U-Boot does. I haven't yet
> been able to definitively determine the cause for regression. I'll debug
> more tomorrow. Preliminary testing shows that any link timer values > 0.8=
4 ms
> will cause in-band autoneg to not complete with this combination.
>
> To be clear, does your board work with this patch?

Yes I tested it, I can provide you any logs you would find useful.
Below is just a short log from interface bring up and simple iperf3
test:

root@tru-:~# ip link set up swp0
[   60.159618] mscc_felix 0000:00:00.5 swp0: configuring for
inband/10g-qxgmii link mode
[   63.308354] mscc_felix 0000:00:00.5 swp0: Link is Up - 1Gbps/Full -
flow control off
root@tru-:~# ip addr add 192.168.10.2/24 dev swp0
root@tru-:~# iperf3 -s 192.168.10.2
-----------------------------------------------------------
Server listening on 5201 (test #1)
-----------------------------------------------------------
Accepted connection from 192.168.10.1, port 44470
[  5] local 192.168.10.2 port 5201 connected to 192.168.10.1 port 44484
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-1.00   sec   111 MBytes   933 Mbits/sec
[  5]   1.00-2.00   sec   111 MBytes   934 Mbits/sec
[  5]   2.00-3.00   sec   112 MBytes   935 Mbits/sec
[  5]   3.00-4.00   sec   111 MBytes   934 Mbits/sec
[  5]   4.00-5.00   sec   111 MBytes   934 Mbits/sec
[  5]   5.00-6.00   sec   111 MBytes   934 Mbits/sec
[  5]   6.00-7.00   sec   111 MBytes   934 Mbits/sec
[  5]   7.00-8.00   sec   111 MBytes   934 Mbits/sec
[  5]   8.00-9.00   sec   111 MBytes   934 Mbits/sec
[  5]   9.00-10.00  sec   111 MBytes   934 Mbits/sec
[  5]  10.00-10.24  sec  2.25 MBytes  77.7 Mbits/sec
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-10.24  sec  1.09 GBytes   914 Mbits/sec                  recei=
ver

Will also try to find out what could possibly go wrong.

Best regards
Patryk
