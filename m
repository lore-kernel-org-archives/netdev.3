Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCE6EEC0
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 21:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776978749; cv=pass; b=n4BU/kwOf4S60+Z0bujT9GgQAsrbVQwpcacQbZopgowwwZt02mFpGJrjF0v1DZHL8LnhTzRDn/QhQKYA81JCtQGSL3NT0pczBOJ2KKkiEVbRK05r3Y6McmgEGBpRMRLTAHJhndm0GB5166ZPHIUOliqoLQLrC8rZHNAHOyehogk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776978749; c=relaxed/simple;
	bh=VTnEex8ZFMx1YfOB7NMNnEnvejgMwLrLX1JYYpBygGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j/VbKg+fDYM2cw5bbMIeNfXt7p8/QJHI/HJXZUoNnwpPKP9nKejWfKR1gNWkvHXO6SZpbyFO7AZzim+0iiSYyx2Cd37YGpAQHdAamAT4vtyXE0Y4L5UNU6v9QuaktRnDIUQ74HhSOeUZCeKDUA42UkZjcqt8PENlrlcodAmE+5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=TjXmjdGL; arc=pass smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="TjXmjdGL"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-82cebbdbdccso4436017b3a.1
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 14:12:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776978747; cv=none;
        d=google.com; s=arc-20240605;
        b=X1iQNjTxccUMqNytNRitb0wxhLkiznqCGogCoySJ8KCVsuuacNqkSgHI3bSwTrlZSx
         mN6qkp0KU9XMbtEk9KdIZPEEE8kae0aWC6EsGct1P98/10aGqp/IMKeUFVDAF8mTL3Ir
         64shV2LOHiE3qo/iPuEt7kM+yaMusZ0yosGiRetW7a07mdNCSC6kDbcI1A4OJnEHMkMT
         u1NiPHMzl5NxNEPL/BO+qD5q8EFwAia3CTPLKJr5NJqXmzqAv2mCFqZQE9yOOx0caYXt
         +N3aNtlEE7sb7VRm+zpQP2u9uKEvaFXzPrkWaOVHK2508dSrppniOuMPmI07Np7oz7Ua
         aPZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eGcK/enn2fESJTFKEHva2T8i1G8zJ+hzXP6ZXMfCiOQ=;
        fh=nlkgO3bAkym8YB2pd34HvDTkgN6aQkTN0gpjP2RzgI0=;
        b=Ni666cwiNUFU2LflZhDh89zvLNCfbubw9DPzBHpy26l1TU/kNDc7vXfWFw4jerYOYk
         7E8i0h6JZdHpPE0KbVYFhKzIqDXIUwhOqXWwzanssLBr8q/EIYVAdXDZxyc3AtBIwpML
         kl6Gbf5akxuHbOkoHpK5YOrahgrKsHVthZMIzexD5KUc/9mpYcmVGPh/NZNP6/moDPVl
         7r8OHBpK2w1/K+E6ngq80pyJOWtriaXAPLHyPAntPPACYdqrY8ZeXeNeYWgWBJQ6CaeM
         IVy2C1CtrE3MC2MpZ0Jx6DMfQszzXDNdeB3wOiW6z9MD0vXzsIeYHmpGR4VVeU46qMDO
         taBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1776978747; x=1777583547; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eGcK/enn2fESJTFKEHva2T8i1G8zJ+hzXP6ZXMfCiOQ=;
        b=TjXmjdGL4F6DUFLF6khuZnQEjaeme8VOrY32iVeX90xf+IZf54RKcylvBL4gwcCk2Z
         hJU2EaROD16+PE3RBWrdHqhuc8PFiQZEYVROSLbxJb9MSDYziM5LY0BFRKK/iBgTvNum
         fRffJ1JOJk0Ss28hYq1UKxiLv84Aw0wcdkf1q2NtkVyGZy7Dk7szwZ9e2EQIDBD+Cnrz
         oJ95NHvWYmDBI/8TBdtjfnE43X8MMOUl0ZP7y+AK7toqV3HyJKDkZCBg5ngLVyI+4gWd
         2IHqkmPA9dh/GxfnXq/HT9DwC3kMsGHJMUeioblyuriqyArKh02gKf1GBE6V0ZAv0cap
         2M1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776978747; x=1777583547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eGcK/enn2fESJTFKEHva2T8i1G8zJ+hzXP6ZXMfCiOQ=;
        b=i37tQ8g2BBTLiDisXyOItFmThcZHQHZnoVJR4gRF330GivJlEcbsDi9hlG52lp7qTj
         sXsxcV7xSDY4Mgbhi4W6/WSHNhWV1odJ2fvXWQWrOGGsEf5X3wauYL3cTXTPPWgU+edl
         b8+/33nUKvShvi5hBDCrYWn5a3Ie2VrN0tqgoqbuusXQhO28CanHSb0g1erMZJ/DqHbA
         dlOwAbmye43MXzzhrfjtoQcbxaBaJAcU1bkIBvPnc7vCHWMBGxPR/dVnL5bbUPh7IqnO
         4tpBuF6C+gyI4FpK0LYw9CtW6RD1QkUCOoEwgFR7rN9rR8yDZhNLqkA3uEK305Sk2z4n
         8ILw==
X-Gm-Message-State: AOJu0Yz52vPcnB/JHY8Ll4glpF1zrtwbDrS3RpET4RRm8OXBiVK3AW92
	mPp6QpstJ74AntZswJ8ocdeN537yujxm2W5gZAXVOLKAmVDNZ1LrfX50e7wjVnlbOwFR6P+Chvm
	Xw3tsR18MSimQ5DWDnPwBXqTJRnVpSFxKkjrZuJ2MSrVaPL2bWcU=
X-Gm-Gg: AeBDies35KRGzFjjAc57ZksaeKR4bJnlCtezu/3RWupEpnk6plo537webj2s3O98Byq
	FBaWblX222zDQF1TA1PQJD1zQqr2llzGqCW/W3WHdB0BladC1h1xJSKlbO9NK/ChIDgsX2H9Lgf
	UtztJ4IM5exSqAc7YZ2BrnprENjKOiPSFTzWrq/QTgB4ITm2v9TWSkCeLvKiyDrqk+W9ElFVPyR
	ENsk4j3xSfBQ2UnVQf+kjKsSkg3p6+yOAhFljopKj9dP3Voi1NiNgOEyrH+L4ROQmV3pzvkN882
	I1M+HxMgAHEOrJbIvDU/yllDUpepeQ==
X-Received: by 2002:a05:6a00:94e2:b0:82f:6cb3:645a with SMTP id
 d2e1a72fcca58-82f8b55537amr25069162b3a.31.1776978746973; Thu, 23 Apr 2026
 14:12:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260418032027.900913-1-stephen@networkplumber.org>
 <20260418032027.900913-5-stephen@networkplumber.org> <20260421131039.GA651125@horms.kernel.org>
 <87f5e94e-d354-423d-9976-6cf3fb0710b1@redhat.com>
In-Reply-To: <87f5e94e-d354-423d-9976-6cf3fb0710b1@redhat.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 23 Apr 2026 17:12:15 -0400
X-Gm-Features: AQROBzB3RrrF9FSgytPC07qAqFpCesRoo7ihrFljDXNuoFrfc9SP0fzUHU4ndnA
Message-ID: <CAM0EoMmnHfUiKP1PO19sHJZpeGN5tdL7ds=_8Nma7Y-4XoSczg@mail.gmail.com>
Subject: Re: [PATCH net v8 4/6] net/sched: netem: validate slot configuration
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Dave Taht <dave.taht@gmail.com>, 
	open list <linux-kernel@vger.kernel.org>, 
	Stephen Hemminger <stephen@networkplumber.org>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 23, 2026 at 3:50=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 4/21/26 3:10 PM, Simon Horman wrote:
> > On Fri, Apr 17, 2026 at 08:19:42PM -0700, Stephen Hemminger wrote:
> >> Reject slot configurations that have no defensible meaning:
> >>
> >>   - negative min_delay or max_delay
> >>   - min_delay greater than max_delay
> >>   - negative dist_delay or dist_jitter
> >>   - negative max_packets or max_bytes
> >>
> >> Negative or out-of-order delays underflow in get_slot_next(),
> >> producing garbage intervals. Negative limits trip the per-slot
> >> accounting (packets_left/bytes_left <=3D 0) on the first packet of
> >> every slot, defeating the rate-limiting half of the slot feature.
> >>
> >> Note that dist_jitter has been silently coerced to its absolute
> >> value by get_slot() since the feature was introduced; rejecting
> >> negatives here converts that silent coercion into -EINVAL. The
> >> abs() can be removed in a follow-up.
> >>
> >> Fixes: 836af83b54e3 ("netem: support delivering packets in delayed tim=
e slots")
> >> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> >
> > Reviewed-by: Simon Horman <horms@kernel.org>
> >
> > I acknowledge that Sashiko has provided feedback on this patch.
> >
> > 1. "Does rejecting negative dist_jitter values with -EINVAL cause a
> >     regression in userspace ABI backward compatibility?  Since the kern=
el
> >     previously accepted these values and silently coerced them using ab=
s(),
> >     existing userspace tools or scripts that happen to pass negative va=
lues
> >     might start failing to configure the qdisc."
> >
> > This is intended and explicitly explained in the cover letter.
> Jamal, given the uAPI implication, could you please double check that
> the change is fine?
>

It should be fine; at least iproute2 will never allow the kernel to
receive a negative number.
Stephen brought up the fact that strtod() could return a -ve number
(but at least iproute2 makes sure negative numbers are not carried
forward to the kernel).

cheers,
jamal

> Thanks,
>
> Paolo
>
