Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C140047604A
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 14:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789395416; cv=pass; b=oxM5ciJO2Mc5NvZpBfKMek0a4w1Tm966zdfnlbfVPhgtm2JVMxBpAwlUv5BI3CPXfqq6ClCmojLGGza4xT3tLwRuyvHiw6IkAGEbW+jCZ2xA39fjAcKQAXgffNLkjUfjSQRwe3QP8yeZMRzVBVP03uoLL7mXrW8wl6LRyKYdDIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789395416; c=relaxed/simple;
	bh=CpAMjQAXkhZAhSQaDcxi40ms3MRJ4Y0fZlOO6i/E3kU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LWlCXHCejSZCUGYUeeDxeKi4nVVcGlye1i3GLm8wZpoT8HEZjcDkLWAYqO38kukYj41K9FnnoBR4Jit8tNSBWNHm4kt21F8wpjU7yJnmNM2wi5EL6ez7siqCjl7a6SXtnQ+5hOmLAnAsrvKI/5/9JMR4aVJ8qHeKuuck1gycK5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ETbXGnXc; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETbXGnXc"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66e4aa8d881so1608588d50.1
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 07:16:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789395413; cv=none;
        d=google.com; s=arc-20260327;
        b=A75QBq3m/G98sJq7W79tPRjGqtLYnCVbACYcVuarA1ClTqzvsoaeae8TiMnsO/0Bod
         iDoJ0vwleuBHJbw9fiHVOY3ALpohgTFUXrgKJsTafVetjwv9yzytKHHisk55TM2Tjrw7
         3BrN/7UmzBcn3gkTFyfTMCOLWii7CEuN4EpYXSPFwmlSMdwTDnPAkA2OFYlrD/vfSNut
         meuTeJ7pbaVSBsGIcYJe2e/NgWEvulKOvsu05v073WT03fMV+E8m6zLCuStLRYorMi7b
         CK4lGB8ALUUr/GlBxjMEaOPnG5n8QS0NaqDe5JPuMRU7W6HmTj3wTwZ8gH0xOC5eiBPy
         H2YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CpAMjQAXkhZAhSQaDcxi40ms3MRJ4Y0fZlOO6i/E3kU=;
        fh=vhfz8kbh8E4HOUxSfkgLdMSuLadFMr+uwJQxgAs+7Ow=;
        b=daXGlYHj0f4c4pjZSguDz9VA69e/wdpGLOTdklL4gb/m8V1+b/PrLN1TUxFY+Ta4rB
         jdpfh/5qkw4ZCAWnQcqCxRxlo/rvHRNS2/5Bcj1NM61k0iJ/gTisGcpoCwBFPzjeYAuO
         NGRg9EAkpMPAeoSkCGn+3PbcGzhrNpuWUyqIMYsWaqAkoQQe5ZHgdfMv0mYIxk2+wqTm
         zRQ52w45Pyejps3XvbsiUIaaFa/SfVIgKolbQ9AzbThlySnyYtKwrI+fq41faoBINCAU
         VedUyoRQb1nLy54sydc10CCbN3OL4xsrAH+rdVOMeXkqjhhzMBrYqlSKKPFBGw9bibS8
         WMHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789395413; x=1790000213; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CpAMjQAXkhZAhSQaDcxi40ms3MRJ4Y0fZlOO6i/E3kU=;
        b=ETbXGnXcub177GSbAH6jQd0MIMb1fVUoC5tayZqtgYk03K7nsBK6ATfg5Xo/hSwXJU
         h69np5KvZByeYOGuLPUQsnUrPq27zCad22NnmHtSeS2qNVSq9sqd5FVpfzrzkvUagTIz
         TQJb99Lsj10BHIxnZBxjzM09tfVweQqPj2n/w9Sq0yEOdw6xURnRNws4vwcBTAxLfJUm
         TZAvu7Fl4lHGxpAiAS1xrjtRWDyRoH1dhiJKCXHUXCwCAaOHYo2T7Abm4bI/kO8MG1Yt
         AvFj0sXcjDlooulPyo1WhdJNoifnvj1x0Dh83iK58PA0uZIfp5Tr1yrWXNpu9aQMNUo+
         2hsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789395413; x=1790000213;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CpAMjQAXkhZAhSQaDcxi40ms3MRJ4Y0fZlOO6i/E3kU=;
        b=V7hm8dxMFGWCsg/lvz9izpuqskW2fzYql4EnCdo/JThU4BluGoAKZSzerdkLiERxAY
         F4DZ4AZAM8JutwuqGeG5hS/G9fDwzR0rIJ4G3NF0G3ZTamhALsVN15yVhwOM4o872CLZ
         xTdbyhZvZORLvF7ICggd1mryJdsHmpkFoVWdKOdFyKwcgYkbZwXXymLhCtGOudQ1s3hL
         5LMz4R9Wxnb0Rhz5EJM2XmP/IwcauNLVnjsicMyTmPHkw2uPXzqrCNjHsZPTOQnsHWam
         j9gDdGgHeJXFq8xqssuBsHJR7Ilzhboml/R9AXWKq0f+wd38IsQuS04FijETcbZpOlxU
         yDnw==
X-Forwarded-Encrypted: i=1; AKwUvBzi71QF29UF/u7xnYX8vzpjx0b5QFHhgnkDBWwCWld8ejidobAxF1iNLcpDw8gi4TSSjqGaZ3Q=@vger.kernel.org
X-Gm-Message-State: AFuF++mXEOwvGki1jJilerlr3oEc8ydGbgZdtyUFRN/Fqr0+yQ8maUZv
	iOyw3iqEcyz/BwjdHHudLSOCymdDUsvYj8euxzKaEGhlhzqw6XZGItK6PyCEJm8Yybqx9VMaZxB
	0UZqASX6CLVKpjXrlADpLaFJ6UqiDEAA=
X-Gm-Gg: AYBFou2Ubnyoe3Fs/gfNIFeA2ZrdhJnwY7/FZ8Zf55/k+CzG5mK3bIsB6EtcFOmcRA5
	nCBf8a4UJBUmcfPBXIszhZvGGMWW0XsobukxyM+qrveFAyJLiq60i8e8DxjnKfNeOsRvbri5U/9
	EPqOCUT1io+lgLjpw/PX6Tq36UywhKD4OpJPZoB9yArvbkGgG4av25WRMC0M0Gfig+YET2GAgwq
	N1fpXsoBzNvqBjYs84frfq82A7nST9TaD02+AE4IvxKhBV0GPmuY8M1RdNeLbuH/Se4LkVuW8XJ
	FKyogrING8h1DrT7mcSdWB5pp2EYxKZQhoiuwdfZlsAOlDERsiQQsQ0itg2o87Z+5rELzzr59Ob
	myK9Ow3zHiijKtDaLn3XBhsfMbw5f+Nwz/ULE+tgdjHUjysOyy9Kc4jNPDzqdQx57zSDyKb8Vjn
	ghV/Gg8vxUfd+Se1YfogWKLCELj/85fA==
X-Received: by 2002:a05:690e:4190:b0:671:1a19:9d89 with SMTP id
 956f58d0204a3-6714dfd2516mr664118d50.17.1789395413647; Mon, 14 Sep 2026
 07:16:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911103511.171722-1-chrismelnu@gmail.com>
In-Reply-To: <20260911103511.171722-1-chrismelnu@gmail.com>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Mon, 14 Sep 2026 16:16:41 +0200
X-Gm-Features: AcwNN1UkXKHgXuNmvAg9QFbsPvsNOPEuEr-x3_4WEtx0b2M_Yl9nWkPUROOSXi4
Message-ID: <CAOiHx=mJZKk9dT93am0o58Th+yPo2aGj6T4aFWkyeQphPwu4YA@mail.gmail.com>
Subject: Re: b53.rst: is the 5325/5365 "no tagging support" section still accurate?
To: Christian Melendez <chrismelnu@gmail.com>
Cc: =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, netdev@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian,

On Fri, Sep 11, 2026 at 12:35=E2=80=AFPM Christian Melendez
<chrismelnu@gmail.com> wrote:
>
> Hi =C3=81lvaro,
>
> Documentation/networking/dsa/b53.rst still lists 5325/5365 under

Huh, I wasn't aware of its existence.

> "Configuration without tagging support", saying they "support a
> different tag format that is not supported yet". But
> b53_get_tag_protocol() assigns them DSA_TAG_PROTO_BRCM_LEGACY_FCS,
> which seems to have an implementation in net/dsa/tag_brcm.c
> (brcm_leg_fcs_tag_xmit). This looks like it's been true since
> c3cf059a4d41.
>
> Separately, ds->untag_bridge_pvid (b53_common.c) is only set when
> tag_protocol =3D=3D DSA_TAG_PROTO_NONE -- which I guess no longer applies
> to 5325/5365 -- so the VLAN workaround described right after
> (removing the default VLAN 1) may not apply to them either anymore.
>
> Is the doc just stale on both counts, or is there a reason 5325/5365
> still belong in that section in practice? I don't have this hardware
> to test against. Happy to send a fix once I know which parts still
> hold.

That documentation is indeed stale. The required tagging is now
implemented, so VLAN 1 is now usable, so the switches should be usable
as far as their limited feature set allows (e.g. you can't disable
learning).

Also the configuration examples look horribly outdated. I don't think
neither creating the VLAN uppers for the conduit (eth0) nor adding ip
configuration nor adding them to the bridge is needed, or even
correct. You also don't need to up it anymore.

Finally, I noticed this file is missing from MAINTAINERS (which is why
I didn't know it exists), so if you do send a patch could you also add
one adding it there?

Best regards,
Jonas
