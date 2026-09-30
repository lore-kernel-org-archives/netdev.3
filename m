Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C714766AB
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 09:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790760531; cv=pass; b=lGa7RzcifGhlmA/R2CG6bdfQdC2zrmGQFWy9pajXa41zP6GzeIB4jShi+EObtC2KoWPMGs7Tz6tMh7aw2Bzy2QB5jxZnQkAR0is+UmDREkl9U5FrRKfqbu0H7cTNwP4ro82Juo8MzVTPj0pOiIChikjZDOH6Df1vyyyUZ20pGIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790760531; c=relaxed/simple;
	bh=T76WpZqN4/IbfvVy7lfZnov8gBZtsqtmd5Xf4GGb2zA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WT+au0WJ8vTVm2To2D2OcGOkGrIxgON0kTB//bmWXgTWn3JiFTfTgULsca2YyRAbDRjFPQuCa9wI6NZldQeDCcTwlgihVlZXQoOaYs3zPGd6JqpteAYMnPuKeEfi0Z1zg4gcRFIHLy7Dr25G3UWaOSfl1MrtmDzwZOxb2Aj2u8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=csPXx9PI; arc=pass smtp.client-ip=74.125.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="csPXx9PI"
Received: by mail-qk2-f43.google.com with SMTP id af79cd13be357-93ca7aa84e4so38283585a.0
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 02:28:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790760529; cv=none;
        d=google.com; s=arc-20260327;
        b=r1+n8C40QYoDTd5nzYcTasawcMz0o28JQr4mxecrM8ar2O4y6gzlkSqWYnZPh0dkrw
         PZQxKaguyIHxOFxoiAlgZhdMLJlylUVqLVg/K4AJvmWnibU567EVdVKWs8Cs09t4X+T4
         Jv6yNZR+ocO77mSIwlLX6RaKoJ36OJ0CZc1T8DJ9Dvu5xBh3zXoA9CReAyJPePkR2R+H
         Stn8WAhd0LYmGec6gb6RjGODpqsWXxJML9W4UnGI6AykYtHMTcbg9nyVDSI+N4lG8Ljn
         ik/AGZlQLv/FPoaAp7adz4DqpqDKo3hDKOzYTGKGLbLwzOMbI9uWXQSOre3Zl13kM9PK
         7F5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3CrBLtpMFVR2oAWbasjUDCmVfxEQqEwO1Ii0xLBkEWM=;
        fh=L4y89p4WCOKTj39FX0TReEazaS5BXgBCygpkXI05lhg=;
        b=FABnb+1uL588tM/iToraJeqXwxxcmTWkQt6AhFdJPHJIULhUO9NqaMpwLt7MFZlI2v
         9PWml05EB3AZ7+BIP9SR264elDktLaCkQ1JncpxzaYdOtD/gOzeVksqlGjemnbGNBfex
         NmvkEU6YWyt9YlCMdSZsxBK+DQd/ItjomSvhlk2gRhSJ9haK6kRmGrux1fCkvr6xmmXP
         5346ya9HmgdGwawf3jS3EUuJvkP1VcPBBK6SLoBH/fYDQJ4xFN6pwYG9P0BreeeT1t6O
         iBpCz1/2pmZWowVt2T2OvsKhJyObP3jhlOx946cNOI1saqz0JJp/LgonJQ2M3FrRXJ4M
         uHBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790760529; x=1791365329; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3CrBLtpMFVR2oAWbasjUDCmVfxEQqEwO1Ii0xLBkEWM=;
        b=csPXx9PI33IfZIyeegqy8FuLVXHHVF2+Q04RIhl9A/cX9W/A03lH++6mLJOFcFW0I7
         kzxYnbCdv0TqXsExV0SnnbR+bGeaPnVG9bQWKkBFNu+3RTWUXUu+tE+Zmxt54h5jM/Yo
         5Zl9Bn3YM43UBoOXe6vcHc64WGRWZhTvlq18caQYoRXWVngnDwM1sHUKgBSeSD1PdlBj
         IF+AN8jID/yvH/9WfZ0mhkvCtjyC7IC1IQGw79uFhXg+pHEPkvIdBzQAEQAhwbuQ5F/l
         QNYmDnx3v0N+QI1rieQ4GvBSz6rAHV3TMgP1uuGcjfSVUpvvT+SN4HvggPe7l9ECN2Fu
         OKxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790760529; x=1791365329;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3CrBLtpMFVR2oAWbasjUDCmVfxEQqEwO1Ii0xLBkEWM=;
        b=ZcUlgY4sSOMm+pIHmaIbjaopOi2J5fNVC5lNoK15pia6UTUTv4OalXMzYSyUZK41nD
         EMNEraVFaM9BjHbDItG+yQR4BpAJ241WnWdwG5N96FpFGs5PFm79bo+9AcPxXNgyNSJ0
         Y+ESLJk0nmx9NCTMOatzhtrhoUV778q8aGxltzk8QsIrWIBZJ4Mdp/VFycOxRbYoeSUi
         44cqY6xP98Vl4f8GmagIR6n7F8JQMazWnCwIpZEvhGfFO5tnvFnUwgwHc39aqbAR0zV+
         E4Vv9zLmS+ZKnlmacz5elL96NejOUdirEejCAdzwFgI+C/zIEavC90u+eVuoPouxUtY/
         hbrg==
X-Forwarded-Encrypted: i=1; AKwUvBxAvEkYkF+M3HfC/1V6HKNjqew9j24RD53DJSZ8G6iQjImuJ5iTaGW+ge22E4kMJsCNYjpFHBo=@vger.kernel.org
X-Gm-Message-State: AFuF++lvrPCLFTsnmZaykl7oEAzbw2XiSD+nDMevYFsKNFLBtU0YXjSS
	x/4oTZwW806B1xsnBDMWnxpeqWWehOYigO+rGxLYbsZSoLNGesqAIr92DoYmVUtd7gqxgRmmzHz
	LDD5sHSLESOsmsmgHLJu1WkMF/j2kBXo=
X-Gm-Gg: AYBFou083s9j4tn984jLhMExPLbs9q8aZMeN6ZSfnjUPKQU2vqqXGJzj7ocDsNcKEAp
	NnNnsptosOLlFClly4UH6gO3ZlMRKEUb6Z5guWy3trvahT2nmrvMhD7Ol80DuwLzzfim7IQ8/I+
	j9ZV5KnfLT3JxqRIgfSifLbZxgXYKobLYM0weQJx+IdEZG1Gt2yF71s8YNkSRx6+WK2cm3pTc1p
	IdoXOTNwPCG/dmyFvyXkpBb8WiLlaIeJ6kI6j4uxfb2zikTOKeUnB3s7brLUqBTexOwF8r2bEgi
	V885cptgp2FJFdo4FcYZfHDb/lVB7iVZkgtcOaU3pvLFDzH0MQMvrEakGC4SNPA1U1lk1G9nNfU
	VbFLQuPa7MnWG1fSPDDfBMnYsVUaqfIey7DWfky+wDtzeKEp06dsotGzPjUZ+4WxSlh49FU4L8S
	RtKNlD2b+keYxN468CRkPJEByMZVT+fvLD8ejQA1OrjGrewDQY9/M3wntvoEwDBeSX+rY3m7qbw
	w6PQwXDa4t0Zkuxqzt8OIVZn+t8BMXmBTyEPo3rLQ==
X-Received: by 2002:a05:620a:6606:b0:939:d459:4810 with SMTP id
 af79cd13be357-93ca96930bcmr109030985a.26.1790760528632; Wed, 30 Sep 2026
 02:28:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260927051743.71460-1-jain.sm@gmail.com> <20260927051743.71460-2-jain.sm@gmail.com>
 <20260930084943.GB3401365@unreal>
In-Reply-To: <20260930084943.GB3401365@unreal>
From: shashank Jain <jain.sm@gmail.com>
Date: Wed, 30 Sep 2026 14:58:37 +0530
X-Gm-Features: AclHuK80YDh2K2zmzx7GH9vHBnXfwb5V53s7GWLI9C8EOorIStLoRwfAijUqhKo
Message-ID: <CA+FWx=k7LbhYcA7CMDcQ1Wq5ysjKqc1R=9HT=Q9Z0CQLVp6NUQ@mail.gmail.com>
Subject: Re: [PATCH net 1/2] lib/dim: fix 32-bit overflow in dim_calc_stats() rates
To: Leon Romanovsky <leon@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Simon Horman <horms@kernel.org>, Tal Gilboa <talgi@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Tariq Toukan <tariqt@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> How does this 32-bit overflow differ from the overflow that can also occu=
r on
> 64-bit systems in `nbytes * USEC_PER_MSEC`?

On 64-bit the multiplication itself cannot overflow. nbytes (like npkts
and ncomps) is a u32, and USEC_PER_MSEC is 1000L, so the product is
computed in a 64-bit long and is at most (2^32 - 1) * 1000, about
4.3 * 10^12 (42 bits). DIV_ROUND_UP() adds at most delta_us - 1 to that,
which also fits. So on 64-bit the product is always exact.

On 32-bit the same product is computed in a 32-bit long and wraps once
nbytes exceeds 4294967, i.e. about 4.3 MB in one DIM window. That is
reached at normal line rates, which is what the patch fixes. With the
u64 cast and DIV_ROUND_UP_ULL() the 32-bit results are the same as on
64-bit.

There are two other limits, but they apply to 32-bit and 64-bit alike
and the patch does not change them:

- The counters in struct dim_sample are u32 and BIT_GAP() takes the
  difference modulo 2^32, so a window that carries 4 GiB or more is
  already undercounted before the multiplication. With 64 events per
  window that needs a very long window at very high rates (for example
  about 86 ms at 400 Gbit/s).

- The rates are stored in int fields of struct dim_stats. bpms is bytes
  per millisecond, so it only exceeds INT_MAX above 2^31 bytes/ms,
  about 17 Tbit/s.

I can add a sentence to the changelog saying that the 64-bit product
cannot overflow, if you think that helps.

Thanks,
Shashank

On Wed, Sep 30, 2026 at 2:19=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Sun, Sep 27, 2026 at 10:47:42AM +0530, Shashank Mohan Jain wrote:
> > dim_calc_stats() computes the per-millisecond rates as
> >
> >       DIV_ROUND_UP(nbytes * USEC_PER_MSEC, delta_us)
> >
> > where nbytes is a u32 and USEC_PER_MSEC is 1000L. On 64-bit the product
> > is done in 64-bit long arithmetic, but on 32-bit architectures long is
> > 32 bits wide and the product wraps as soon as a measurement window
> > carries more than 4294967 bytes (about 4.3 MB). The same applies to the
> > packet and completion counts, although those need more than 4.29
> > million packets or completions per window.
> >
> > A DIM window spans DIM_NEVENTS (64) events. Drivers count events per
> > interrupt or per NAPI poll, so under sustained load a window can easily
> > carry more than 4.3 MB: 64 full NAPI polls of 64 MTU-sized frames are
> > already 6.2 MB, and drivers such as mtk_eth_soc count one event per
> > interrupt while NAPI keeps polling with the interrupt masked. On 32-bit
> > users of the library (for example mtk_eth_soc on MT7621, bcmgenet and
> > bcmsysport on 32-bit ARM, or virtio_net in a 32-bit guest) bpms then
> > becomes the product modulo 2^32 divided by the window length, and
> > net_dim_stats_compare() makes its BETTER/WORSE decisions on a value
> > that has little to do with the real throughput.
> >
> > For example, a 1 Gbit/s link at line rate that moves 5 MB in a 40 ms
> > window gives bpms =3D 125000 on 64-bit but 17626 on 32-bit, and 5 milli=
on
> > packets in 2 s gives ppms =3D 353 instead of 2500.
> >
> > Widen the products to 64 bits and divide with DIV_ROUND_UP_ULL(). The
> > results are unchanged on 64-bit.
>
> How does this 32-bit overflow differ from the overflow that can also occu=
r on
> 64-bit systems in `nbytes * USEC_PER_MSEC`?
>
> Thanks
