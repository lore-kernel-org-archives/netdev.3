Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0F252FE21
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 10:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790072077; cv=pass; b=s0oNmAPn1vJ2fYcXLmrlIAqjtxXoYELkILFATTBC/l6jnJJT2kX4QJIQuWm3TvKSTClcJya8uGS1Ho082RojE55FSCjlYc6eo+8hIC1Rc7DSOBoeb+1Gn88eEZrDDdPnB8gv/NSzFrRrtyelAyNN9nX0U0L63YbO17RJnaTIjWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790072077; c=relaxed/simple;
	bh=MP7qOWwL+P1a6ht9RviQn5PbhcTDg1vQhBcP5eyXfGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BjdT72UhmwhCYodI7fFBDizJx9nx5xyCtru14Lfrh/ebXEQh6svjZUjbFtjPf6xklfOE+5qNdOIVANg7jx5pB6GOdUz4J2GRTRKvGn49NdvUyfjqfhWNBKixEqdTFSB3V9q15hVFydwo9E+lG3rOKUNI1cvUAdhOwKx09yKGFsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ABLRxbfE; arc=pass smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ABLRxbfE"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfcbe208so47091836d6.0
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 03:14:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790072074; cv=none;
        d=google.com; s=arc-20260327;
        b=b6RsJC+Afqtst0nezumwxdLpKe/+B34giANYwPo0sp/uPv760jUM0anuOieRYVLjvN
         skWvIKqqSMVtqL8ZoyJAsznnJCkCp199NrdelT6Fgu6y3QnJQ5TUJHVZcWgj9ETd2d0Z
         bIGBMB3sgdgjc+xIGX/8N7SgafwMuJOTBmXxBmamXcDmKyr0BWayR3UElvGvQ9gzuutI
         VhH8ceeAtbyu5q/+tVyefSw84Bz3vizVi51BiFnO9XYvKZky/14+eK9oYH+awHOtOksw
         Q7yWMR09C+TvUi6pmU6onPCFoGfapARfbh8Y3rhhNVzE6itDZLBU1rrR00NQhaQYDJ6m
         GAAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2ESDSZM667q7EB0r3pmeL1vJBKH8ckNK36jbuGzw9rQ=;
        fh=FeJ4mrkn7RtV5Q6LoqKIsVRYOZC+Z+GWVT2AyMp2ch8=;
        b=sUSB1cOkRSiwQtZJ/CcEDDOlRIRYz6czuS1LkdwR5RX01I5loQyzDnzJiGEeqAw4Vq
         6Mz/2uCdrKmj7hzGGMxl+qDeokzr7+g97y7rNfjazAMfWfYU4zwpYyK6F9V0ibXMGahX
         wmsueLB7TjepcZkBTXMkiY7tZlIzZokGqLXnAhL9GHj5iSkRzvAx9r+NtoqUdPuhRR94
         dfZDiObBUr9qTHcAWIR/YcU9Q0iGiaDngP/fb2ojR5j2v8/+BtdIWD8ihjmiSpsabRjO
         S47ySB70TjaulmiHaDzRMO/unV8cXUoKYzqfn3zEN4zuhUfePxi1SBGf3OCDhS+0KeMC
         mW1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790072074; x=1790676874; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2ESDSZM667q7EB0r3pmeL1vJBKH8ckNK36jbuGzw9rQ=;
        b=ABLRxbfE6NZ7sOy0INwd3XY4Y8s168Ra8wxGTqzrQIAqw3hou6Rq23TKQfmnHBAk4X
         v6L5jxxM+78pAkKkVrqsf+veesjFiiVPt1Nep3U00Qni+c0cyjFj0uYJGrUSfewG8tEk
         Zf33LvNghY6aF4qFJ/unoVK1XAkMLk84VEVKgrcVJmXrk7yaoFNLBl+IQxIQW8TzO/8J
         Or6asyop9L0UhvpjcU2RvrwYTH4zND9/xJckQizoWSri9lGro6occWnxQ453vWCybkQ3
         89ypd/XfD/SNnBwxfujW3QDPgn1lIyfdwNb58dmF2FPOa8jygoN1f6YPsbBzLHlJwARU
         Ga8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790072074; x=1790676874;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2ESDSZM667q7EB0r3pmeL1vJBKH8ckNK36jbuGzw9rQ=;
        b=Dzttawodzx6swExGQo7K6A4E6AiwCmptvRfK9jawLUQFPfx1krxhF+OMo7N2kuNPgd
         TnpqrJklfY+xg/fHtFObtKRXN3RDKut2yY8iHRydgUY+xpfSKYTpRTZIe7oTrIp8a40A
         JiPmwX/qvCh0w7jeM08vq+EZ7EVCrklyonFNBJwly7WqFr/1krS4wOTVJRtJMz1308Dc
         ULBWqyHqLvfMq/+HZ0TW52ltCvJy8hNZg1LS/aXagEtylOZlV36urH78JZiPjKQZrt6B
         FAv66inw++3Nv4MtTT/DnF8HQz0C5Cx1RrZudpRPQTJxPgfVTmcSyNga4Jml/jvFlzI1
         LHEg==
X-Forwarded-Encrypted: i=1; AKwUvBzKPz9DADDG8rOuU/ZyVg8fKgVKeTZQ/YnhMpeJGONVxEoZv65y4E6UABsb+CQyr7Y5s6lPTW4=@vger.kernel.org
X-Gm-Message-State: AFuF++noWF9rYqXtX448a5UjnfQTCC4SQsZDdi3IhM+O2k9DZKz1kHnL
	vUegIBQGOYCAS6C7ZlLVaKL1VVWfMng3ZYXr2j6BwZmwboZqkqS4IJ1ejpJDuMXEOn9k6cc0x6b
	i74VZBTozDS2M6vKGyyYKKV9eu54SPXg=
X-Gm-Gg: AYBFou09RAekD1Ns7M0+D2C62OozSaZifMt3uHmD18CMeEtGt0WM3mu6xOcV+ghQkzb
	hEzgzN9QWBRC0MqkaSr8OdGOQaF6FbfDeq6ZZU71Og/S8Ux4NsW0t1pfN9yqMAMozt4m4vVYWxT
	D89ACiFwHocy7Oo8xPp+pDo6kMMIe4LqMUubTqy7ByWkrpO8xTrIAWCgMV+gULymuWzUj3VuMAh
	ArO/tA1ZnTM8lyDWHUT4VJACT1NobLsCnQuDsYukhTYosqaVgimIYECrNDBhd+FslrvpwM7d9nG
	JBusOfQtpGJ3J8gAqa/lRnhFYeIYq1QQlgbB2acYQPexsCr/n7Sn0Bc=
X-Received: by 2002:a05:6214:d63:b0:913:fa79:99c3 with SMTP id
 6a1803df08f44-913fc94b160mr46562816d6.43.1790072074583; Tue, 22 Sep 2026
 03:14:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915123812.14747-1-ansuelsmth@gmail.com> <20260915123812.14747-5-ansuelsmth@gmail.com>
 <20260921134410.13a7173c@kernel.org>
In-Reply-To: <20260921134410.13a7173c@kernel.org>
From: "Christian Marangi (Ansuel)" <ansuelsmth@gmail.com>
Date: Tue, 22 Sep 2026 12:14:22 +0200
X-Gm-Features: AcwNN1WQadm9kZulSu2D2w98S17OkpHd-MeZLtXiKqWwHyLw9Fh6tPwUuh65TfY
Message-ID: <CA+_ehUyFH_ZSsjhp-U9WBFoRZR-ZMWnNQ5pY5vAy1LxUU5hSsw@mail.gmail.com>
Subject: Re: [PATCH net-next v22 4/9] mfd: an8855: Add support for Airoha
 AN8855 Switch
To: Jakub Kicinski <kuba@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Vladimir Oltean <olteanv@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	"Chester A. Unal" <chester.a.unal@arinc9.com>, Daniel Golle <daniel@makrotopia.org>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Simon Horman <horms@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
	mfd@lists.linux.dev, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il giorno lun 21 set 2026 alle ore 22:44 Jakub Kicinski
<kuba@kernel.org> ha scritto:
>
> On Tue, 15 Sep 2026 14:38:01 +0200 Christian Marangi wrote:
> > Add support for Airoha AN8855 Switch that provide support for a DSA
> > switch and a NVMEM provider.
> >
> > Also make use of the mdio-regmap driver and register a regmap for each
> > internal PHY of the switch.
> > This is needed to handle the double usage of the PHYs as both PHY and
> > Switch accessor.
>
> GCC spews warnings:
>
> drivers/mfd/airoha-an8855.c: In function =E2=80=98an8855_mdio_register=E2=
=80=99:
> drivers/mfd/airoha-an8855.c:438:48: warning: =E2=80=98-phy=E2=80=99 direc=
tive output may be truncated writing 4 bytes into a region of size between =
1 and 61 [-Wformat-truncation=3D]
>   438 |         snprintf(mrc.name, MII_BUS_ID_SIZE, "%s-phy%d", priv->bus=
->id, addr);
>       |                                                ^~~~
> In function =E2=80=98an8855_phy_bus_register=E2=80=99,
>     inlined from =E2=80=98an8855_mdio_register=E2=80=99 at ../drivers/mfd=
/airoha-an8855.c:469:9:
> drivers/mfd/airoha-an8855.c:438:45: note: using the range [-2147483648, 2=
147483647] for directive argument
>   438 |         snprintf(mrc.name, MII_BUS_ID_SIZE, "%s-phy%d", priv->bus=
->id, addr);
>       |                                             ^~~~~~~~~~
> drivers/mfd/airoha-an8855.c:438:9: note: =E2=80=98snprintf=E2=80=99 outpu=
t between 6 and 76 bytes into a destination of size 61
>   438 |         snprintf(mrc.name, MII_BUS_ID_SIZE, "%s-phy%d", priv->bus=
->id, addr);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~
>

Hi,

 I also didn't receive the email for the AI review... Did it broke also her=
e?
If everything else is ok, should I send new revision or maybe we can pick t=
his
and I can send followup for this warning?
