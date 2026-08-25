Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932FC3515E8
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 09:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787650302; cv=pass; b=C55ofCoBL4yJqXJshAZikYUcbZ76bRK3xAjOCUANbO4RUI+ESEvqXSfnFW3+XCFWIwApHCxT6uw5zZasen1ZkwaBomNCcSjpYGIp2E2oyt0IQIgg/kzT2rURSuNkyrB/WMPLQoSOc7JuPj19fEn+IdCS8kHfHV4SRD2C2yQlTBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787650302; c=relaxed/simple;
	bh=CMEzlB4ZaonET/uJcOWybrvEkigqtlDxLiPB6jIDVRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CZg++NufzXbw2TbKlPzrMXRCI5IlwLL732j/T3u0f9/lV/g5K5sLMqolVffYtvblrXWXLU/TBiCvOCEEj7OHjv/vsFAn0TcNnsYONs0q5r1EUHo4mBtlWFSc5ApagvQN/N+jcZZKKhWcjudffS6ZIQDrQtKTadMXFZZ8P4H1F00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=e2U4eB7u; arc=pass smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="e2U4eB7u"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-84830c774a0so5020075b3a.1
        for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 02:31:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787650300; cv=none;
        d=google.com; s=arc-20260327;
        b=IGENDkibkp8M+5uKxjCaobsc+FoIn1I2PLVg0BElM4YuYFQT106iNl3kUCiJ0HXDUf
         TSUlimFA5TRNLb1uXe6i113kB70t+5z7Rd2cjDWU7qEm6ZeIqfhU8U4XUBtm/HPWOsKI
         KNTtvW+PmPHMWkCAFjtQrqV+aVf6Z7ZQM4AFusP/eRAdmvOK2maLp/GSZGD4F7P+/e65
         pHehB/mE27bWflvuBkMTxjqNTm0uI2ntU1ieRwU/7N4U6SBw1Z5oNO8G9RebC7HT0V0g
         N3+oJXVCa52Eapy7fRvRaRhfyP4kHGR6FyoBskw1BklGeUwfDn2hyM9bMG0VXUX9B3NR
         +ePA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CMEzlB4ZaonET/uJcOWybrvEkigqtlDxLiPB6jIDVRw=;
        fh=iqd+DubFVZ9g08SjqsRYBFtrnrkoI7Y7XGL3dtRv1Mw=;
        b=QwHEwBsGhc5YINtm8xGmHv/49YTkODT0xr4cl+5nxkqWlEWUbsfhTbsDhvM/PP8z7m
         VlS+XoRyEKToggWaEdzKaVc0eyQaWkABWlCORFm2s3THGHjjcE2gnqP/eJ1B+JTsW8f3
         qHFQNoOHAF5E9LiI/7pVsTRIRzlAlJRA3khdhiCHKY5m+xn2fDDCi9CV34FJWmrPiZR+
         8s1znkuJN+vlggNW0IMflCOOnImAhAuuLJJbpFCo6oZBmrw2BrgCgs/I6y9WVS0+EZ7E
         FR1n7q9Wo6mEeEM2fgKQdeC44h6qzHUbI542auXZG40AmKDspu7J0r79cCZqyUO2UsoD
         8bVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787650300; x=1788255100; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CMEzlB4ZaonET/uJcOWybrvEkigqtlDxLiPB6jIDVRw=;
        b=e2U4eB7uOq+XrBUO1s9tv1VCp3dAvscjbqwctCZ5d2ietARdHh5g1WTatffh26DSBX
         Z40vm6rFi8z3s3Y7REXx5QrEPbwEoaQaAXmRFbdHToxzSfvgiClAzMhAD2gord9HhCs0
         E3BdX/ChlN4R7Ano0LCbkZa1rpX4+nFXwPyWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787650300; x=1788255100;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CMEzlB4ZaonET/uJcOWybrvEkigqtlDxLiPB6jIDVRw=;
        b=Ys2KaVkX1k71ogEmyT5DXhIZACDBdrkQ9Cg87kI+jIq1xcuMfJWAbzMjR3H95Y0t0P
         7wBqZWOoMds3ciwXlrfQtNefv/8qa4lUrEKM9ZDuG3PslHpJ1M5tZWBgYF4EUR9jo8N5
         m6UTZFo1i6wIwvQisLOR7GFkckiCcSDocWON+YrJL/pZyYWdrMWTzHXbMsnsc/zOI1cj
         DTDQGmJXO1OQBHpxmktx3tR1xndiOm6u3QnxyTicpg8/GRtOl5BVy/EEvpicjsghTTMD
         ShuGQ3Mv8J8TGG3iiAa6GNLQvXYBDgX7kCbnDSqwM/w/J8RY2ogAhH7yARtGMdEHLdPi
         GkYg==
X-Forwarded-Encrypted: i=1; AHgh+Ro5Ta7CHQortE/0hlIkpd+duNhb5c3w4WM0E4jkWtLfmOQbfs1EeS9GO/Ek6LekWThmu2BINZ8=@vger.kernel.org
X-Gm-Message-State: AFuF++n4rtAPqXoEpDwt23SZ20tAM6FwRXd/xa/nmjGPbQgS5YzDcV9m
	j65JZ8Q6RctFETuBLvP5bKKpW8SrRld56/H8RlnQWLXZshw+UBIdnIKhTA3g2A/Zhfr2/olGdXN
	XAlebv4c2/CBwwT1NzeiN2v2mir7ON2fOOwxyrB+BQ20PptbtNiinBfeX
X-Gm-Gg: AR+sD100Lq3ODUpauv8+SvTPnQ+xCJBEUB/B4AMHIo0O6JJxIVv0q6VB4Ynmxwfx/Ac
	XNSzZS3yVlRHSA+XWwx8/DnZIMPm/uQXUHSqFbh8V7s3p3avYRIGEsBWm5Ek9waNIvNSzdPXoCn
	cUdmAdtUZRkYAT7U4+cde4iI4gO2868+y/9qcqYLEqTJxz08z8v5MdYch/imIpWIcbdGXZvC7Hy
	kZ8OBlonVJa6TVz+g12g6BClr62a/UcGuQBNOHG0UMve3g6AHJgHDwXgtK23l9WiwTDvoG3VW+Y
	kusiWgPevnxNGAYo9PGoSNmVOOuRXqLDxgynhyaIIYkLgA==
X-Received: by 2002:a05:6a00:2ea0:b0:847:99bb:b6d0 with SMTP id
 d2e1a72fcca58-8523c9474b5mr8271340b3a.15.1787650299952; Tue, 25 Aug 2026
 02:31:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM0EoMmHMFQ+mATPoHv-5uyN9++Lch7MDjHsC7eu=NVapRB2bQ@mail.gmail.com>
 <tencent_F7A4E81EEE16CD5078266CFC2E396F8C940A@qq.com>
In-Reply-To: <tencent_F7A4E81EEE16CD5078266CFC2E396F8C940A@qq.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 25 Aug 2026 05:31:28 -0400
X-Gm-Features: AcwNN1VWdkDx9dWOFx3pZjPP8y6SFe_tWqO9NYvifaz2LxZvXKLi1-Qnqd5Ktfs
Message-ID: <CAM0EoM=+X_aiWqmfOETA+NJr1kT8_T6rK1_dj-topdzxRAS6+g@mail.gmail.com>
Subject: Re: [PATCH v2] net/sched: act_gate: Limit the max value for cycletime
To: Edward Adam Davis <eadavis@qq.com>
Cc: Po.Liu@nxp.com, davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jiri@resnulli.us, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, 
	syzbot+0054fed3dc9085390f51@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 5:01=E2=80=AFAM Edward Adam Davis <eadavis@qq.com> =
wrote:
>
> On Tue, 25 Aug 2026 04:25:04 -0400, Jamal Hadi Salim <jhs@mojatatu.com> w=
rote:
> > On Sun, Aug 23, 2026 at 12:07 AM Edward Adam Davis <eadavis@qq.com> wro=
te:
> > >
> > > If the user passes a cycletime value of 0xFFFFFFFFFFFFFFFFULL,
> > > an overflow occurs during the assignment of cycle in gate_timer_func(=
):
> > >
> > > cycle =3D p->tcfg_cycletime; // overflow, cycle =3D -1
> > >
> > > Since the local variable cycle is declared as ktime_t (i.e., s64),
> > > the assignment overflows.
> > >
> >
> > Review the sashiko feedback. At least two of those concerns look legit
> > and need to be addressed:
> > 1) complaint about timer disarm on replace 2) INT_MAX being too narrow
> I haven't received any feedback regarding sashiko, and I didn't quite
> understand the points made in item 1); could you please provide more
> details?

You should always look at patchwork for reviews from the AIs - i just
happened to have cycles and peeked and even my responses are best
effort. Some maintainers forward AI reviews on a best-effort basis
(Jakub forwarded you the v1 review), so you may end up getting radio
silence if nobody has time. So, going forward, the first line of
defense is to look at patchwork 24 hours + after you post your patch.
Address those by sending a new version or rebut them on the list.
> Regarding item 2), if INT_MAX is too narrow, do you have a suitable value
> to recommend? S64_MAX?

Handwave: The safe bound is one that keeps base + cycletime <=3D KTIME_MAX.
To be verbose per sashiko:
cycletime is an unrestricted NLA_U64 consumed as ktime_t (s64). A 200
s cycle time does not overflow any s64 arithmetic, but your v2 rejects
it. tdc test a721
(tools/testing/selftests/tc-testing/tc-tests/actions/gate.json) uses
cycle-time 200000000000ns and expects success; your v2 breaks it.
sch_taprio uses INT_MAX but its semantics/tests differ. S64_MAX is the
actual overflow boundary (U64_MAX is what makes the s64 go negative);
but even S64_MAX + a non-zero basetime wraps in base + (n+1)*cycle

> cheers,
> Edward
>
