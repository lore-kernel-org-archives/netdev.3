Received: from mail-pz2-f1.google.com (mail-pz2-f1.google.com [74.125.228.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3FE2DF3EA
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 18:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784659165; cv=none; b=e4RG7mvmW7//4eQy3bKKCkCCDdqxEKP37/5b5Tqk/PrX3FTMFhdfx/lBKQkIS1rniAbZmwhJTka+373RBCeDWxeZZ0f/QOSuxHLg0uEOct0qQM6NYaj0XdpGCCEd0fumWdYtSLJAaIxvptHUvEWN+EE73inwj9em3TbdccY+U4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784659165; c=relaxed/simple;
	bh=YyqUHAQufPap2wIBxW8yQO0iBXCogrSPdJZUjddL2yE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Ca8dkdEZYm2AH71VUF+M/9zTqrneY7YZY6zftAQe6gh57W7+ege44xBE98HbeWn7opc/7Y7Azdx2sChPwfApnucj6xbcsRUYmYsKY4oiNPco6oME7iuSbXMgRcffqaRWvKTZ0W3CXsDBi+7x22wNYUb2pbj/uNTKFtXm4fsKpGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ntIK7684; arc=none smtp.client-ip=74.125.228.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ntIK7684"
Received: by mail-pz2-f1.google.com with SMTP id 41be03b00d2f7-ca7a25cd87dso7029210a12.1
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 11:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784659163; x=1785263963; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=dD0DYUkH4io7g5v9/QnwJ9sas0tI0cyqhrv35uBUJNY=;
        b=ntIK7684UqUgBSPRZlsCYZhuL8NBr4U9hCECsPEZbSOQg7bqEO9M0n7iBpJEROgLup
         Fku9KmUKBgwN33KoXWARvF3TRQllhwF6VRNrAw8VLVFWiuzu7wFlDQ0R5ywQWrXpJdIt
         +/Ev7bHCklEBhcZfqfhIdoaRUlbFGMQjzZIFGaiukt6AtmB7Hb42TSY+FesqKj4GgDQL
         WJvN5Up7eFPOZ/057gnUnR+aXxwUZii6TAKQEE+0UDGrZ2PeTiVT1fSOZRZLexyKsZMH
         SiqdWxSPsy3Sf1oejW5Ny4qp9Riu9fGYS3bhkqaGQzMbyxFSS3qa/0K3FwPuJPLSdGAa
         5eQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784659163; x=1785263963;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dD0DYUkH4io7g5v9/QnwJ9sas0tI0cyqhrv35uBUJNY=;
        b=Tj08wd0Lx52PKwH/3fFdZRpReipaq6qolGXL/27YhCOv+8BuauK6a8kXx9I8nQwElP
         iGkpwIwHllai/hZZ5zPaP9zLp9nsnhTm/WQG8BOT3Wl31TCqg+jQJ3k7A9MkzoeS9Cqf
         uSWJbHMAhtv0bXmqUrN+c0rfzzyhhW7tB3lR4fenGXbmFsu9Ivp6J4xUojqCAjk6zPvA
         R/RPFgfgCiLQ/gi6OBUIu+JZHPhkfkSq6arx6wdOGGFK/EdsAxUOehAi9xN6Q6EAMckx
         9PAYtelNchkFsEx4pYsopxUMIi0vijqtf9wX7uMouZnpiEO2n6qpkq3xtb/VIZlz3Z6Q
         uKOQ==
X-Gm-Message-State: AOJu0Yx7I/qF/GqlqDYWtPwdN89IcD4Hb+y+Fi1M1NF0pWlro+re9TVJ
	LhiMentXGQK1uxR0oO2u3NeFFXUu8TrFM85eJU11QwxaUUABKlcrg4ij
X-Gm-Gg: AR+sD10XjchmOvdFtHLlO6QNgTt0oG0t7mttuPPopjNPSxUwbOuHFNc+m1SYLjZJa40
	+NEF30BqrygpyRyn1JYw56VkKmN2hwUHW3RUc4/klUXrCasx6DLbcHpRCf/OXWNiwqQsNPVnCuA
	NBR+fANMigHVZud3/OYA67TEA/11nLGikPTHgxQ8zMH9nlZIDRV8rhbbXwRdFfRIGJn360CB0pm
	HdSMDJyzN5de7og2PMH+M1MxgaA1ofPMbiE1cr2vr7ULUBsak6R8LLSFeaCOCR9K80Bup7DUufz
	3HWDJDPkIOdl82rscP5VjYF+fN0TLIZAja2mDN2QezZ2cNQwDoZCy9oVYBeE5zguGiuNKsftZ8t
	sqLrgvM29smQqKII/PyyHqO3eNxyjVLXLRLpJZbnny0nlMU2nuFeE/guZvjazkPBryutto0I=
X-Received: by 2002:a05:6a00:9517:b0:848:2f77:e2dc with SMTP id d2e1a72fcca58-84c2952d1ddmr19433753b3a.69.1784659163088;
        Tue, 21 Jul 2026 11:39:23 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2401:5a0:1000:10:233::14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e17604d76sm125835b3a.61.2026.07.21.11.39.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 11:39:22 -0700 (PDT)
Date: Wed, 22 Jul 2026 02:39:18 +0800
From: Coia Prant <coiaprant@gmail.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Jakub Kicinski <kuba@kernel.org>
CC: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Serge Semin <fancer.lancer@gmail.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] net: pcs: xpcs-plat: fix runtime PM initialization
User-Agent: K-9 Mail for Android
In-Reply-To: <c666a262-579c-4e23-9172-c35fc9b3f3c5@bootlin.com>
References: <20260704214808.1566710-1-coiaprant@gmail.com> <20260720172433.77b83dc7@kernel.org> <7BA9366A-3243-4A46-BA8F-BB170C8AD912@gmail.com> <20260721064910.217a6af7@kernel.org> <c666a262-579c-4e23-9172-c35fc9b3f3c5@bootlin.com>
Message-ID: <AE3574FD-4B74-411B-9213-1B95EB6BF3F2@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On July 21, 2026 11:00:23 PM GMT+08:00, Maxime Chevallier <maxime=2Echevall=
ier@bootlin=2Ecom> wrote:
>
>>> 3=2E Should we add a =2Eremove callback to force suspend the device on
>>>    unbind? Otherwise the clock might remain enabled if the driver is
>>>    removed while active=2E
>>=20
>> Embedded experts would have to chime in on this one=2E AFAIK this is a =
bit
>> of a gray area=2E Some users may want the link to stay up, eg to allow
>> WoL or avoid link training, maybe?
>
>Avoiding link flaps/training is mostly a concern at boot time if the
>bootloader set everything up beforehand, but I'd say for unbinding,
>this should be OK and would mirror the probe=2E
>
>Maxime

Hi Maxime,

Thanks for the feedback on the =2Eremove callback =E2=80=94 I'll include i=
t in
the next version=2E

One more question regarding PM dependency: the current pcs-xpcs-plat
driver uses runtime PM to manage the CSR clock, but the driver works
fine without PM only if the platform doesn't have a CSR clock at all=2E

On Rockchip, the CSR clock (PCLK_XPCS) is required for register access,
and without PM enabled, the clock is never prepared/enabled, so the
driver simply won't work=2E

That said, I think in practice, almost no one disables CONFIG_PM in
their kernel builds these days =E2=80=94 it's enabled by default on most
architectures=2E So forcing the dependency (e=2Eg=2E, `select PM` or
`depends on PM`) wouldn't really hurt anyone, and it would ensure
the driver works correctly on platforms that do need the clock=2E

Do you think it's worth adding `select PM` in Kconfig for
pcs-xpcs-plat, or should we just leave it as-is since PM is almost
always already enabled anyway?

Thanks,
Coia
