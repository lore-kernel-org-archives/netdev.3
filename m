Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269C5367B70
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 06:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785219003; cv=pass; b=rl+3EL/gV9TlBHUKiaV+tpfYN2s0xtvon6vxJK/EoazH1UdghK2iPUSPlbTL/W1z03waDHRoQw0tmW5GrT19w5WqW5DQacJg8YLWABsHXIb7PN4WaoUUuRuNjarIa360vxJ7GkuTvQ//LDPSnsi5FUcz4uDKSprZABqfWOmHl7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785219003; c=relaxed/simple;
	bh=QO9q8hGMb6wDMhpK8mlOmRixW52ZyX0W9RelPfDdfsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ExtXqGH1baF06zuhOrOL+IDHUfWBGX18DFO24t1v0GX9swoyiI3ZEzwe1NdcIV5OZ5AgsqkpJ29Gl+JsZoCmY2zJ/kFq0v6tp3wKF3HWVR8KViz55VOSUH/hVUExtvGouAD4WJKRt0KROuVSbyzj5y/GLSWM/WB5zjaGdlBpKj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/28D55b; arc=pass smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/28D55b"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-39ca300db70so30618141fa.2
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 23:10:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785219000; cv=none;
        d=google.com; s=arc-20260327;
        b=fXC+No4ejJvK2yQy0GeXkQyxUAzvQyibXZKoD9iWel77pI4juPgh7HNhzYTrP+81Vl
         UcuZcIeWtcbHFzJKnzYSV78uZWt2Araa07hSbXWTcedFerefeyClQtEU0ARbq33t1y6j
         Im5FDwwH5KlxH4YBmVUmxl3pkGG+BvlUABFULNIGP7IKEG/x9oQiKd8WpJO1U9KuJa8h
         l33RvlAo+RAKnrvnViw2u4bA919aUVRyV3iaoua96nE1IMdSBfbcbbXsfP/SxZJcvRbq
         xO78l52V7BPcZcBJq52cAlFuWMTvcIuxgQqv4g0cO1328lHYImmEch/ZFLqcMZqJoImO
         qY0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QO9q8hGMb6wDMhpK8mlOmRixW52ZyX0W9RelPfDdfsQ=;
        fh=QqPYftU9nZEqJBlanC+unMSpwhnH5mIKTRsimbl0M3o=;
        b=MsIGZCMEng3z6WwE9l0TfoILCPdvC1gkKv53/ARLdbVXZ5LwVyP1IuANIcfyyXFw8l
         Jr1UPpriZUrIfTdWhEtBQfYvzqZhbJupnk0CKckKJ2w+djzTkebDBZVwaD4jnO6l6zqt
         7BCglGpac0JPkRxZBeBdzO8RIlCoNbvG3YXQCdejTxlMhULmVNSZyCh2tIYXTQjrurb5
         y1XxWjPgNzl6/Pvmtx2bPxERc2UnNgdGJgOzoxpo3PQ4nz4kab7uF9H3xzcrL06MrNIx
         BpnkwZTn8hG1bfYRX1Sm7CMkyJLKT4VtwFkYCq0nS6O3mdlJgoBd0TH7ih0Ahp85xLKp
         p5lg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785219000; x=1785823800; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QO9q8hGMb6wDMhpK8mlOmRixW52ZyX0W9RelPfDdfsQ=;
        b=K/28D55bSqiQyJHd/eaIGAlCuBvzw6PTnr3GyVEgTWwAxtaBwxBrbeo9IJT1i977zh
         Wa5nkTlz1dAgxmnS/xGEPsakMUIp+OqcYlO8Qs9INpqw0f00sSXYbb+cKrvKHHHe8eKC
         wOTpv5ZH8FCU+4zLSZTRfoa+K3mdUyuvpRsQkLGEQZtoNMDx0iRwluDXMS8WkAJIu74B
         uWsU/y0krI+pv4mP+TL/XPwTGwYjpAXzU9Kz2Lz3elm74aWRsZs/X+RQJ7ukIapGsb8p
         ZB/7Yrbk9pgrBFDU5E4270CdsnolXRl8n5L29fzWGAHdO180Xwp1T2PBHejznlRSlcA9
         E17g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785219000; x=1785823800;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QO9q8hGMb6wDMhpK8mlOmRixW52ZyX0W9RelPfDdfsQ=;
        b=W0a0ZVQ1WArBMPXgIfgVELe/UoYfTC6d0+BlVNjGl5G6T/WPWqdWs1lNnCtVyHu1tq
         iy1a4D26Qbdg7EBc/BP2tWHUaQz204/QfALACsuXMqJC8momwy/gy+rZpMqX27iHj03l
         N+PT8EjqauIjketjUZRF6lvtVf997Kn19ZUOhscHwOiJEqw3hAQW+eclZOertT+mgUwR
         +eEicsul9i3J1xY7CqDacZGwvSHexmNkQO0q2pPlnAmCnulbrvkV1PgjW46OzERwLAjM
         dMWjKKtWihRqbrOGWSsRx3qkR6CO4YWnaxyK0+KeNU+hJJCiEMEtbI3Z4x0IPuY8lypo
         LSMQ==
X-Forwarded-Encrypted: i=1; AHgh+RrFPVpwV3Y3MGmCqcL2xzkssJEqjun8JzMK6mrsXksphJlVnqSjhoaFEb7XhCJBoKaIOZjILEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwscMp8S/+/RHYgG60n3V8SGpcgB+Dc58e9h+45fDh26pBCSJve
	HxnepwrhOia+4iXAr/PkiVho2/p/AvmFKM2YaPolvgVvG3KqwqMAEsv6n0hM4RfZtYi6Nx5m/4e
	AR4LdjX+c1tTbdYvc7G3K6CMrR3Ns6qE=
X-Gm-Gg: AR+sD13Qi+bRodjmPjoiPlK4Z5lqiAqJ41ZUSO249+ecpvIxvRY9fhNOj0m+x2BakuP
	sZFyiu/Rn1jSES7WpeBZnEQ7W0ASvtI1s0zOE8VXksJoCWooTKgZ5g33j8zFJ/aVmu/CEBjs5Ji
	iQtmLh0aW8R+TF1U/5gL/uxDBEa7VF1qu/Ot7JDTVeVFv7H1tpOH0n5djCH95p8c+Q6lgru83El
	fi0z3sKYKMSSWLoJdWO8AFC/zkiSWp3cWY4rZZ3lphPMlb+rVY9WxwtvrWE
X-Received: by 2002:a2e:bc89:0:b0:39c:9aa0:799f with SMTP id
 38308e7fff4ca-39f51eb3a29mr1809001fa.33.1785218999991; Mon, 27 Jul 2026
 23:09:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723143908.4019-1-maimon.sagi@gmail.com> <118da808-b9e0-4e5a-9094-9c6dc3740ff4@linux.dev>
 <20260727140320.54185eb8@kernel.org>
In-Reply-To: <20260727140320.54185eb8@kernel.org>
From: Sagi Maimon <maimon.sagi@gmail.com>
Date: Tue, 28 Jul 2026 09:09:33 +0300
X-Gm-Features: AUfX_mzwOmtm11WByCwb-riod8IH7BnzyeHpAMIpDdotpH_ZpdzxrofTgYxGi0c
Message-ID: <CAMuE1bHMe3BHz6YoAgXXtP+TpBEos6jaHFpBNPYjFHXKVxd4_g@mail.gmail.com>
Subject: Re: [PATCH v6] ptp: ocp: add CPLD ISP support for ADVA TimeCard X1
To: Jakub Kicinski <kuba@kernel.org>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, jonathan.lemon@gmail.com, 
	richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the feedback.

My initial implementation actually exposed a real I2C bus to user
space. However, following Vadim Fedorenko's review comments:

https://lore.kernel.org/all/c6aff5f7-e087-4bd9-b159-7adeb82e19f4@linux.dev/

I changed the design and switched to a sysfs-based interface for the
ADVA device only.

From your comment, it sounds like neither of these approaches is
acceptable in its current form. Could you please clarify what
implementation you would consider appropriate for this use case?

Specifically, would you prefer:

exposing a proper I2C adapter/bus to user space, or
implementing the required device operations directly in the driver and
exposing only higher-level controls?

I'd like to understand the expected direction before respinning the patch.

On Tue, Jul 28, 2026 at 12:03=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Mon, 27 Jul 2026 12:02:53 +0100 Vadim Fedorenko wrote:
> > I don't like the idea of having a buffer in a global structure. And it
> > doesn't look like you can actually serialize access. Imaging 2 processe=
s
> > manipulating this i2c bus. I can be that mutex will put them like:
> >
> > 1. process1 -> write cmd
> > 2. process2 -> write cmd
> > 3. process1 -> read result
> >
> > That means the data will be a mess.
> >
> > That's why it is a really bad thing to allow direct access from the use=
r
> > space. Is it possible to add a property per command?
>
> At a glance - adding I2C support via 2 magic files in sysfs is rather
> odd. Either expose a real i2c bus or make the driver sends the
> appropriate commands. We are opposed to raw device write interfaces in
> netdev.
