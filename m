Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.167.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793586342;
	b=U0OlCNC8db/v3uGKqAG+9/AZ40YASSzZfTzjDqcmc5ma2SXKudfp3oD8kv3ai1LQLT5T
	 ykjrnhmOUePVLgTpes+oefU2WoRXLplYjZkLZxQXg3odqnxASiK8y9YQoOddTC8pN8Q2j
	 FtlgamRrMhQn2yYc8gJ+24o4ZrPyiPEPw+xY5IJgPu2/uchkzHEoqwGoBzQ+JYYbwjmk1
	 YhqjAayL5TnLGOwlLCkax9Z2SEt/NNiJFoiB/ucLrAoZSVUQUWYUFlw31UuE0dO71khDc
	 EmfALmU3nnf0p9Tvv5oaTBMXuDSAnoWSKBRl8F42tFGqNMQTEavGVdEXWrY32cymuiQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793586342;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=0m11DqAQsWViOluQPYNzPkQX9NkHKluVITQUvXZ17kE=;
	b=4lAOcMswx0RKBUwE7Iwq+cLh3xh21Ac123VqKIbt27WKLGDSmgAGQgThdfMz8Szy6q+b
	 JwxPnYmmqnJd3hmcXoiAzyWYxITXPhbNE0cxb+/mXp7YN6V/ug1svYh54srVfqVEOC7km
	 UfPFwyCp9wYA7vkOZfZCFemAPY2GHMll4WLz8SqKSqv633dSYKbU1CXyPubL3ykqXq6Au
	 dA5Zqj1hzw7xo26LvGN+LOhytgyfVdyi5hpm+GhKzG+7a40NtMx9xqGT8EGc3M/jS/D/h
	 rXtUkaMZIOpQ9BpnJ1EmAx4ahKj9c685I+2nUPnwK6BUv4hoGc2ZUBXfMzkiFv0PRIw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ugDCsvDY;
	arc=fail smtp.remote-ip=209.85.167.50
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261B6606A327
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 02:25:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 261B6606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ugDCsvDY
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5be3d5927ceso2075107e87.3
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 18:25:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793586340; cv=none;
        d=google.com; s=arc-20260327;
        b=QxVrL1NcrqDiNbagX5hmf8MeXC7S4DSprrctzLfaIXu3f5XgozS4K+PBc5O4cykXJJ
         Q4f4s8LVWf4OtrrWtg92JBIcfUTjwynsjJyWinjhQtC7zpTdC1wSlGJifQri96eistwS
         1tF3j336b1zySiJYhU5sqWbFeOmPM/uej0oCc2A6OHXnmBe+rrCvJ0MGNToBA19D9/xq
         CCNJ/kmwbI57nYwiAQftXlpp9S4LLFv+4DZCTfhOBqdg1L/cwb+A1BsNoZEcpucIQCdn
         Y5LHahmotpUFv+Sh9rhmhDeFDGf3WJMAYB1dy/a8y1Xi5n6g9GRKTqtETCeH8Nw2o6v3
         C/HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0m11DqAQsWViOluQPYNzPkQX9NkHKluVITQUvXZ17kE=;
        fh=ujgt4mqab1YQFPRIYjkas9JltfrXAKmt7Uz7Ha2oxjc=;
        b=aCmQeZqoIYR6vbJUccVPcIIxf8XyxwMc+k4cOmcsW6K/ZYlhSj2Wdp0GJ5Pisw67k9
         pia6AiOmFlPTWqQaqtqiOd1yZclaNLjE6IRWseMWiZWfARNeW/4u7+iORC/m50de8A4P
         3YR9nx7m5RZAlw1WuFDyEpXNVs0gw6QyNXQQ8afw8FIgFkcOykmErtQOstusret9OJ6A
         EDp/ryMmWoGB8Dl0sEls1r7tWaTkQCYQtglWL6ARgBHMi1/68QZaN1FRaASs7cWMC8fs
         JEmb7BzXh0Ey99ItU0JSbhuraavLG2KUeXjZocinrkA/lvls45uWYcjkbVj0TLXf/Tif
         sVZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793586340; x=1794191140; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0m11DqAQsWViOluQPYNzPkQX9NkHKluVITQUvXZ17kE=;
        b=ugDCsvDYCkDc501EStBD45BR0hKilJ3mHh5PLVzf5klKd9eNQ8fs3jIePlTP0KNAPt
         r5EOByLZmYdmqZO0W7i0VzKXiB+0qwLpqz19LfLPF5WJEU+UOWoJfrFEFqWtVTcBcdiO
         Tlwwd/Uf+ihgzH2fBeoSDDPZ3lZjk4bXPpSKc0I5mR1pFeRxHgeLLD5R8ZS1mxu0kOV2
         BwCpFUQHqwcxEKUL9mvZXZJoeUuLNygu5SgxQecFGOYDKPXe+0mVis5idDsh0w8q5nzV
         Qd9k+zsIG5Jm9agqPdNs43nJzKTLXs25BjQN1v2kKT+jyshNQ3Aa8/U+ONAzCvLzWUj/
         GKxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793586340; x=1794191140;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0m11DqAQsWViOluQPYNzPkQX9NkHKluVITQUvXZ17kE=;
        b=vvliYpqj6Bf6DwqOdLXtu5JpsZxTMHnbEMFRciuNEQ+sghmhTkAdfFjbsMkV6TrgID
         M28TuEAtxj0E4kwrNa3qlxjDmhFCdd9vV/Q96+aKPSOLhp2pOudKnwppuuZcFgFik1ko
         oT8mnrINyot7ThJuKuedKq7HTP/QiU4QF91Qh09l0VjigxDFjpYOZ7znqhzhDkkvHSed
         RzYz2zQCkn3R9qwpKUQqIPsOSod190hOXajBYaTeNQa7vSXwo5ONWb+MPYJhorFFWto0
         nzKo2JhC1NP2XXyj3RFboNlBUppyqEgajHa5Zzj1qc+CQaQGssHoHdzksnTd2/e/nnXR
         JCGA==
X-Forwarded-Encrypted: i=1; AKwUvBxSj8RjjD/Sbbojr3lFLAl199GKKG6U8c+D8ickiRyFfxSv88+NBXu8ycgm5fOCzdl6njWWwbo=@vger.kernel.org
X-Gm-Message-State: APuU4Z8x+sEWvV+IU17BZbsEvgsMq1qPX0aMbVuqwwSYXWG7V0uiHWew
	vgBaIY/3zxpbzmw5fLtroteswhY90Ekga3+82qJ/wB/3b0mzlsgpWFkpFXK0lEpz+V01ZtgBxKq
	6nBeQG8uDVrqgzopFOH8RU/4sb8/Xs1E=
X-Gm-Gg: AYBFou10Cn6QEJKMeI7FXeoTRxPbGSL0HPtunL0mIgouLffQhA4BGyQvnZJ3b6/4pOt
	9pXw9sHtcPMPgcOAb62600jLfhmqRzOJCQEThg5bZPpN9G5rGVaA9HLbu/ydhAxPN/otTYcc71E
	4B3JzsM7qggeeHEYI+ekgogsDtd1mQ/6lP8I3WOuewVP9RYjUbsqtzt2ITJyVsyVYkdzy/DAhq8
	+Z5DQKHpoidXP9yFNUT7fKLRHNJDnjNWI7QEEPyYQar51J/rrEw6aw+6ehsC8BsTa4ny8QOUgmV
	NGgjjzth69bROAd/GNryxxLPqB5q9vECcHN3M8GrwjTVvRbazss5cyEShIi8tdUPJdi3p7Nyh5b
	RYyjFBWvizLAMh7T1bghzp+YoihkFaluOxH9vJzdQK4WlTihdsNIqtzuqJTh6pMlDxlwTgGItfC
	1I5csoXDOWSwADNcWxnw8QJ7qgvg3P1edMXNI7K45NYxlW3TOeQLcfOPdhOMRNhYMTELM8s3mO6
	SFlN5cB+1s=
X-Received: by 2002:a05:6512:a94:b0:5bf:b246:87a2 with SMTP id
 2adb3069b0e04-5bfd957b610mr2907633e87.10.1793586340194; Sun, 01 Nov 2026
 18:25:40 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261031133455.3070233-2-rsalvaterra@gmail.com>
 <CAL+tcoB6vg+-w1JZdND_cTN_zPeh76_+-W_NU34jkunJUFwrrA@mail.gmail.com> <CALjTZvbPacWO+NY62fbFdQEAJemD57zmhdYy+v+BXpxFgntcNw@mail.gmail.com>
In-Reply-To: <CALjTZvbPacWO+NY62fbFdQEAJemD57zmhdYy+v+BXpxFgntcNw@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 2 Nov 2026 10:25:02 +0800
X-Gm-Features: AclHuK-ou4PfE1lO6DM3P8nj553WJIIK4Nvl4HbobZUxI6ExZLuUtqWgm0YgoO0
Message-ID: <CAL+tcoAnw=5vP_s5qTOo8O-8uBntph4MOAxYE3fnw3+K0jhyDQ@mail.gmail.com>
Subject: Re: [PATCH] tg3: make depend on ZONE_DMA
To: Rui Salvaterra <rsalvaterra@gmail.com>
Cc: pavan.chebbi@broadcom.com, michael.chan@broadcom.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 3:41=E2=80=AFAM Rui Salvaterra <rsalvaterra@gmail.co=
m> wrote:
>
> Hi, Jason,
>
>
> On Sun, 1 Nov 2026 at 05:48, Jason Xing <kerneljasonxing@gmail.com> wrote=
:
> >
> [snipped]
> >
> > The blamed patch seems correct, so I think you need to root cause it
> > instead of adding a global dependency here.
>
> I'm sorry, perhaps I misunderstood, but *I* need to root cause it? I
> never claimed to fully understand the implications of the patch I

This is not how things are going here. As long as someone proposes a
patch, they should at least know what they are doing.

> sent, nor the intricacies of the tg3 driver. What I *do* understand is
> that a supposed "fix" from Broadcom has left the Ethernet controller
> on my late 2012 Mac Mini inoperable since the 24th November 2024, when
> absolutely nothing changed in my kconfig. That is, by definition, a
> regression. I'm entirely available for testing any patches people send
> my way, if whoever fully understands the driver and the hardware is
> unable to reproduce the issue. However, asking the user to fix a
> problem created by a patch from the hardware manufacturer is=E2=80=A6 an
> interesting approach, at best.

I see what you meant; I thought you were trying to make your first
contribution to the kernel :)

With that said, maintainers would pick up this and probably send a fix
with your credit (reported-by tag). Thanks for your report :)

Thanks,
Jason
