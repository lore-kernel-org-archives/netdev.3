Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98C6EED8
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 00:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789174672; cv=none; b=I3FSgs9FiEfrvDFrCkGCEtqAIpdJsOxi8/yiZYCAioZZUT2ogI940STwpEwoyxzV/bB8KS/42yTmpNu5vDgjsvLZft4FPfZPnEk+P/ZbEpOS09KHi47tLruPTqWBWxG7MK39AeuufM1mur3bu7QgQ6y+q/lU1zbwjFV0qrnZw4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789174672; c=relaxed/simple;
	bh=p/lArYGCARLOYaeiP+4ojxjY6aOQJHb2+meYXe+Lycc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=jzuYsnTMe8DKpo6jfsg91XRWtck3AYfCs1XvyVVNZPErAhMsJ6zlRn6SlDZ2B6Hsf1EnAfpwJgzwbeMVh42FKqgq/X56IviyJzyrovAsUlUWGAAjUuSqM6RzgrLWX/HDI0ADJuuuHwwFsEXa9QUWSqYg8DRq3VbiMsij8iRwZqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SgXmZKHg; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SgXmZKHg"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-855c26cf490so10304577b3.0
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 17:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789174670; x=1789779470; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VEQ6r4QC5yC/0yfiNcwhkgXgfvSaDU8vXXWFX/rDRgU=;
        b=SgXmZKHgAM9C6IgcYFysJ7QWIRaSF530K85YQ087psYIXFqsAoy4+LqemRhWCL7DKT
         iRBGDGkkNB7isG+OOO3cLtTUJuzjGbd8UGOhDIu3VrkSfsGkhg4MgnX3LG6q4asmHR5I
         2jOE6Ul2bvFrZI7oSReV+ktyhqBCiULKRyvZTOBd4mA0gay7KTxedaThXwjVV9hLGJrw
         crvE32UzeSuXJ+WR1MktTiaqxik4oZ+SkSUNJL18BC41zqpjunucieneLVvbR21lobIh
         a6GVMfZv1ugQRpEU/RwOx71RsdTgTyUQOMIDQy4NMwcZ9dPkkOyhdEfjuaV7gO50/JpG
         u52w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789174670; x=1789779470;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VEQ6r4QC5yC/0yfiNcwhkgXgfvSaDU8vXXWFX/rDRgU=;
        b=KYYSzjzpCociQdt/hvx9VByprh01fwAJnQozSDu/bB7Lq6uHLlOgr4jsakUCEAA1OF
         aUi/volK41nRc0v7g1VPmMmaKGPpxTc9hK8KqvGqUjLRp3tf51TkbQgmZbmQivkTvvzL
         2+HPhK5qm7oO+zqzHbbj1QmmV/3+rXODp1CtO5+iLvDbk82Z30JJh0YKakK2KTEmRyQT
         nT+zLAQrHxUNtf5sanCPWeCCDG32dRraiSpjt8HW+vjXwAEPhJkMgcL+SwbETkImHeWe
         EMQ3RdU6poxtOi6hkM009/sYlJ7iUnC3+k//2m+NRtPtrB0MvE6EI2HrjUE4PyjNvRet
         EzvA==
X-Gm-Message-State: AFuF++kRS1czMWXOAxuFwpv7s92ptjDl4yQxmpZvhOT/Ndwmp3JDH8Xe
	6vtDgrExYdAqHAKia9VqzA9j7wiMJszTa8QV5DmJ5iIx0LQiM+OEA3M8
X-Gm-Gg: AYBFou1FOH0HQYcyh/gLooote5tZtYEUfU4y+uIz4EhpDJ7s3F920U/qTUjqUKmn/WR
	THN+sXBYC8y1/dHeCIqjzBsEZCQbHdM9cBchlIkfDpHO6iP0YNxZEMe/FcH5m0zMa2pJ19mSERf
	UPR6l47BaYMQwiYR3mTuMCc38O9gCiYUwlFb/zID4JQNJi40ptwcVHVHBYGzsakswssT0Wd0+sq
	xzwUpSJcn2TrA0tRG9xEZzM5X6WoyESNG0E/2w1QTt50gpOuuR0tQaxccWMSe8+ypvddtTAKLdA
	2oNXj3kk0SyajIJCnZiStsojzLP7mpmMMVKQEEOTtpKwmwbHjP04iBDqLMgl2wPiLueLIPZ/ZE5
	3SbdpBOZJc0uW9YQ8Sq0cc4oa/yV7+EAB3noOlEJshkWfBCJ3yboKo4chWTm4ntyeNX0bWIozMT
	Iz2Ru/75sW+ruuXRLBn7/BqZ/4Nwe3MesGp1iBBpgY3weSKZsl8VXncKUcD+qm8Sxx/xnzBmFq6
	rqvWoPKWlfdqll7T2iCHhlIHAjMudo/gauPTpUXU3bqkm6rKAax
X-Received: by 2002:a05:690c:dc4:b0:884:a163:8992 with SMTP id 00721157ae682-884b3f503admr27160217b3.54.1789174669850;
        Fri, 11 Sep 2026 17:57:49 -0700 (PDT)
Received: from gmail.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-884878dd12csm16748527b3.28.2026.09.11.17.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 17:57:49 -0700 (PDT)
Date: Fri, 11 Sep 2026 20:57:48 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev-bot+sashiko@kernel.org, 
 willemdebruijn.kernel@gmail.com
Cc: netdev@vger.kernel.org, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 andrew+netdev@lunn.ch, 
 willemb@google.com
Message-ID: <willemdebruijn.kernel.342ae29687e94@gmail.com>
In-Reply-To: <178914679956.219967.16464715915916154727@kernel.org>
References: <20260910171131.2532487-8-willemdebruijn.kernel@gmail.com>
 <178914679956.219967.16464715915916154727@kernel.org>
Subject: Re: [PATCH net-next v9 7/7] selftests: drv-net: extend so_txtime with
 hw offload
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

netdev-bot+sashiko@ wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
> =

> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 0
> =

> - [Medium] The new `beyond_hw_horizon` variant hard-codes a 70ms txtime=
,
>   but `_dev_setup_pacing_offload()`=E2=80=A6
> =

> --
> =

> selftests: drv-net: extend so_txtime with hw offload
> =

> Adds two hardware pacing offload variants of the so_txtime driver test,=
 one
> on fq with an offload_horizon and one on pfifo_fast, plus a new
> beyond_hw_horizon testcase with a 70ms txtime. Also raises the receive
> timeout and switches the final empty-queue check to MSG_DONTWAIT.
> =

> > diff --git a/tools/testing/selftests/drivers/net/so_txtime.py b/tools=
/testing/selftests/drivers/net/so_txtime.py
> > index a097fae0b335a..66a87205e02db 100755
> > --- a/tools/testing/selftests/drivers/net/so_txtime.py
> > +++ b/tools/testing/selftests/drivers/net/so_txtime.py
> =

> [ ... ]
> =

> =

> [Severity: Medium]
> Is the beyond_hw_horizon expectation guaranteed on all devices that pas=
s the
> capability gate in _dev_setup_pacing_offload()?
> =

> That helper only checks a lower bound on the device horizon:
> =

>     horizon =3D _HW_OFFLOAD_HORIZON_MS * 1000_000
>     if link['max-pacing-offload-horizon'] < horizon:
>         raise KsftSkipEx('pacing offload max horizon too small')
> =

> so a device advertising, say, 100ms or more is accepted. In
> test_so_txtime_pfifofast_mono_hw() the root qdisc is pfifo_fast, so the=
re is
> no qdisc offload_horizon gate and the immediate-send decision is left t=
o the
> driver's own horizon check, for example in idpf_tx_splitq_set_txtime():=

> =

>     /* beyond offload horizon? set overflow bit only */
>     if (ts > now + horizon) {
>             tx_params->offload.desc_ts[2] =3D
>                     IDPF_TXD_FLOW_SCH_HORIZON_OVERFLOW_M;
> =

> On a device whose reported max-pacing-offload-horizon covers 70ms, the =
packet
> is paced in hardware, arrives on time, the receiver exits 0, and with
> expect_fail set by:
> =

>     expect_pass =3D args_tx !=3D "a,70"
> =

> cmd.process() in tools/testing/selftests/net/lib/py/utils.py turns that=
 into
> a failure:
> =

>     elif self.proc.returncode =3D=3D 0 and expect_fail:
>         raise CmdExitZeroFailure("Command succeeded (expected fail)", s=
elf)
> =

> The timing_sensitive escape only clears expect_fail under
> KSFT_MACHINE_SLOW, so on a normal machine the failure is unconditional.=


This is a good point.

With the replacement of configurable limit dev->pacing_offload_horizon
by boolean dev->pacing_offload, the horizon is now always the
max_pacing_offload_horizon.

The test fails, but perhaps for the wrong reason. Will take a look.
I have to take back my "all false positives", though this is fairly
small. =
