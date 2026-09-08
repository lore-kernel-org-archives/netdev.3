Received: from mail-qk2-f3.google.com (mail-qk2-f3.google.com [74.125.230.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391A54A3D25
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 08:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.195
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788857460; cv=pass; b=OuJCydXoD0Z4ThypSnsrAjjndRhwtYjqKvOHyGZEemRYRz/NO+8mEvdPVDUt8pwghBJH/g0qLfuVy5qrwV8vj9tKs7LaJV2B1vPko/1bcVR415UICCINguqG14TJmO/WuKWdMn1iD3trh5gsnSSvA14bp98NtntjsgGFS++xIOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788857460; c=relaxed/simple;
	bh=CGqXD/HGmKRCkAcVzchiZAmsA+ENuFZGucxFrmkngpE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZvxBJIPx33lJGpvBmthjYZdDi9ndAHwQz8DC+Z46RBz6k9npI6j+VQ2vSePssnazxv/VnKpswXTiEwcFavJ2fhFt7DbqZwZmHi6DnKTPdVmxJV7MdNJJBOUWYas41xLjeySp+lVV/0El6JqYFBsvRIdk2vMawoAsytvz/4vCrVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ni59OuiV; arc=pass smtp.client-ip=74.125.230.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ni59OuiV"
Received: by mail-qk2-f3.google.com with SMTP id d75a77b69052e-51bfda2cd53so30895301cf.0
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 01:50:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788857446; cv=none;
        d=google.com; s=arc-20260327;
        b=RzEOZp5ROOM6YBQL6Shr6ltZQxw0xzIgyGRVyKEwgKfKZ8ynzrax0fU/djnybyWDCO
         py9BqLfv30ccwLBK8ImhUG15O+2RCkCdGcpJT0k1l508zfoql4OJVYO7fcHhmleDVNce
         fdqa7jb124fRAF98pAhS09XiLmByhfGf9xSYXVFz7rv7/2OULfn9VARGTiZ3qKKfc20z
         TEtDG/uqSTqylh3iIHxRjNDRBY3s+uDc4/wzHkY9pDjDqDqZz8q3HJE9kUwR63Bot3eo
         IIGDsTTDZ9SefHlj6Lv3dCa4Zd+Q5mm71iE4o8841ogQ3eE77RTmN3n8cQeGN2K07XN2
         kbew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9cEtLfffg/kw3sWTeXa6T8mgAqOFBiKyBtqY3VJ3nng=;
        fh=bUPsMGTAilBoy8+BbQeORnzwMfTleRjmho55PvHeEbE=;
        b=XsedDvUYcW6cJ74tFhTEa8EVNulq4IDuEU0uw0Q6RV2eiqce5D37HpXZS0mrPocyUP
         pDT/0rnoHbpwJepZMwWujLtKtVIjwt1YGrq9bWWrvGJzBLL1Z1d8HpmWnXOqednaPISy
         rXTWxcfi/940IEwZn2z0m/iY2RuuhH4Fm7YQTuR9P206V1xb4EPjfuRzOx1PrW7YIgI8
         8CYdQ91re5K2CQ1f9SkVdj3vYNL4z7vz0rzrn3uP79Ij5EqisFlDl8Z56uVYdqHJujgE
         frJXdGyJB4nDI4vKl8rb0/6JJ+vQanUE9LzpwufpERr5zFtKp7MrhNCd4lP1eul/d5Rj
         Y4Rw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788857446; x=1789462246; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9cEtLfffg/kw3sWTeXa6T8mgAqOFBiKyBtqY3VJ3nng=;
        b=Ni59OuiVemW76Sb6I/FErsEX0AT9eHkyJGKVkRBF4gOrTgYLZTR3KNZDfkwVmblfzH
         3TXqVoxIb9z7rbpu0uNqI+/vu8Nlv5o2g5+iyWq2pkZka8MpZdFgP2DlMZD2d2ICOOcG
         QjQVcG7fPynE+/QeMhs1PicIBy20ppv3jxckmGqaWAGuRG4JUlEGHp/vpeZZZevDBG8N
         P1oo/TdHM74SVpv6q4PMiF4EKdQdiA73b3uuO5UH58NBur4rc5AFiqxX1Fp1Du2lJiJf
         F0Ezzej4ln61Or0h0DVdF7rOhC83nB+Y1b+Y+hfdKzm7Av9skqRHFovfjrCseUPIIuMx
         pu1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788857446; x=1789462246;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9cEtLfffg/kw3sWTeXa6T8mgAqOFBiKyBtqY3VJ3nng=;
        b=BxUhdU1Yypo6WNzvuVSJCYcfaROLNqTejBUyI/R8ITVuC7DRvDEtFFdskiWvnMQneD
         dDM6vB9V600/8VoqwSjmQ86drCUzJoheCMXcgrp/nPhjPWBRMdhkAIf+X3OdPaYmO0yH
         ZdkkxKfamZiMvqNv9lj9G4wjwoEKzqoBYSPKAUnHM8eEa9QxuXVyPjHe0mWuxmgO/dXj
         aBEQsg+x9QDs1l4YWQsiyhmpJyYW7zEq1ed4OkP3WVHDnyKIXOQ/HTG099b3EDxpuwLm
         Qib2PtuIIgT770FVdpyuT0WT/W+g/bKBKWiN3We0WeMO0O0z66d0CReZfRAe/68PS91f
         XW0g==
X-Forwarded-Encrypted: i=1; AKwUvBxQD96kPmkXB7C1+LONyoe73r3hZ8aH6Ub4hKxmWmlwe86gNbFu3YNGVNnMyz3z09bvr9/3Hjg=@vger.kernel.org
X-Gm-Message-State: AFuF++kA9KKdzOuk0cVadiHULk/HtkHCDKJC4B/JLxXRx0MNRrrAGpHp
	CvlrF4MjDUNlkW/QonVfENvbALcNF0Z+oRNif1Qk9A3um7UsGpWkl2VDBh1GrW2AUL/kfH1qqmg
	l4H66Mc9jLgsHTnsm6y+808N6G4k9y4w=
X-Gm-Gg: AYBFou0j4RSg49p/4JykP37lw/aB/2kL9+4/+ATPtX/jPD2eD3clN6SJd6Csu0Erkl7
	PpSkwhedrT8/oILG8kCiBNTVQ0/Ay4RugStnL9pLz2I7hlkCU5uj/mmQ330QWMQPkRkyEqISVsb
	lVBYzVr7Q4GYC3lBCVpPvvmzO0icE+ZhB/aJltYeCNRLxAlz3xf4AhF5cUK8BuzgB88AlNhvX//
	gGV5VN/F9gJCQDsy96WUs0Kex8m1jN9D7X2mtpRT4MXeGGwpjdvvCHvoURAOznBTg0m33U/iyDw
	eUTWar+yhvhVn26qk/YwoT42ewCQ661Dw888DC25gEdPtIiA0pTs11GD
X-Received: by 2002:a05:622a:1a81:b0:51c:d52:6049 with SMTP id
 d75a77b69052e-530548e0cb2mr324384441cf.28.1788857445984; Tue, 08 Sep 2026
 01:50:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1788262122.git.petalzu987@gmail.com> <2ce8f3e4bbed6060afb0aee33dc4e1d9ae021280.1788262122.git.petalzu987@gmail.com>
 <ap2ksmdL1FFulLnF@lore-desk> <CANn89iKeNgRxhkUvxeMmyAJGcT+3hpbWaM+VubQ2sBVGSDeouw@mail.gmail.com>
 <20260906224300.21884-1-iprintercanon@gmail.com> <CANn89iLjMMsKLYkv8J3uX-FvzfMvkzi5wtLfY4pZYW2G9C601Q@mail.gmail.com>
In-Reply-To: <CANn89iLjMMsKLYkv8J3uX-FvzfMvkzi5wtLfY4pZYW2G9C601Q@mail.gmail.com>
From: Zixuan Chai <petalzu987@gmail.com>
Date: Tue, 8 Sep 2026 16:50:33 +0800
X-Gm-Features: AcwNN1WeS4iFq3lXexGjuviPPr6gR7f1GhJaAw3tlggAZtAVtoDnTlyVgWhCCmM
Message-ID: <CADTzad+RD6z0C+0xCoDx8QCm_UztuPncjfPH_87Ce2QJzE8Naw@mail.gmail.com>
Subject: Re: [PATCH net v4 1/1] ip6_tunnel: snapshot encap in xmit
To: Eric Dumazet <edumazet@google.com>
Cc: Artem Lytkin <iprintercanon@gmail.com>, Ido Schimmel <idosch@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>, 
	Ren Wei <weir@nebusec.ai>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Eric,

Thanks for the update.

Does your SIT tunnel series also cover the ip6_tunnel encap/headroom race
reported here, or is this still a separate issue?

If it is not covered by your series, I will prepare v5 with the fixes
Ido requested.

Thanks,
Zixuan

Eric Dumazet <edumazet@google.com> =E4=BA=8E2026=E5=B9=B49=E6=9C=887=E6=97=
=A5=E5=91=A8=E4=B8=80 14:32=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Sep 7, 2026 at 12:43=E2=80=AFAM Artem Lytkin <iprintercanon@gmail=
.com> wrote:
> >
> > On Sun, Sep 06, 2026 at 07:54:34PM +0200, Eric Dumazet wrote:
> > > The general answer is : convert tunnels to RCU based configuration.
> > > In my quest for RTNL-less ip link dumps, I converted SIT tunnels to
> > > RCU configuration.
> >
> > I have ip6_tunnel and ip6_gre done the same way, after your geneve
> > conversion: the encap and header lengths in a config under an __rcu
> > pointer, changelink validates and then publishes, fill_info without
> > RTNL. Seven patches, built and sparse clean, waiting for the nebusec
> > fix to reach net-next so I can rebase on it. I mentioned it on the v2
> > thread two weeks ago:
> >
> >   https://lore.kernel.org/netdev/20260824194741.215979-1-iprintercanon@=
gmail.com/
> >
> > Two things I'd like to line up with your sit series. Your patch 2 and
> > my first one both touch ip_tunnel_encap_setup() and the encap ops in
> > ip_tunnels.h, so I'd rather rebase on yours; is it close to posting?
> > And you put sit_parms under RCU as well, while I kept parms out of the
> > first round because it keys the hash. If you'd rather have parms in
> > from the start, I'll do that instead of a second series.
>
> It was ready last week, I can post the series right away.
