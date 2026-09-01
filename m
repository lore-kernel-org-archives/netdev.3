Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E491D370AE2
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 21:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788298579; cv=pass; b=QaY06vVInopFHMVd5TKbyWNh4zDOgA1IDs/GSbwjyystVBNR7FfQXb4Qxv0hBRwM1FJ/VO17aX2jIFyu3BhM9j5Ggel94mKtX1NqAlKvgTFfzDH05HfW56VJwmXCUCAtdG0wniBojrSlHJ4XCzD3af6rREQIM9YFxJ2ISTdFh28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788298579; c=relaxed/simple;
	bh=BhSc2dEq0S1dzIyqWLOPR2lN7BJ934oECopEsXOBiaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WC1Tp1p0Tm2kL0pSSsrpot7KmOxr+NcZfkHcwd3FCLL3w8KWn01KkB35o2OXtXISmdoyr25kzpLQAhI3J5YsasCtVW1ZSRwijqs2d/RM4v9sztbwc8jzqI/2EYNvZ+0Jq9L6KZyT6EFyM0Ivta4qOPLfuf14rBqMIuvEaHbHd6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=ZBupoozP; arc=pass smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="ZBupoozP"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-853f8c34ba4so536735b3a.0
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 14:36:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788298577; cv=none;
        d=google.com; s=arc-20260327;
        b=gWDO+TliILP5QOeaz1wDBMI43cFeX7YeMVh4sW+kNJybO2pxEccL7DJuPsDW/+5F2W
         ifNivEopVT+cXrSHEG6x08vSEm9T8TqaU4qPGVgtsifB1BAkj4cxmx0UrrThlw1CxqXA
         GMVzZZHp3il3i2KxktODPOctKIsHy/BVwBDVLVdCu0dIct/ukYGTyqeQZ8g87ayNY6hH
         YnNjMum8id1i3TtUGZX72vUYYLmuvNTJuBxSSce2RU4MhYmNJDi/OpEES5Vs0MJ5Shlx
         F279E2CCPtEJcmlEhd7Lb4iYinO4bCKMbx5/w1pzE/BLIMgT2cVSigpULJgmj2QPbh24
         PGug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w7Y56somwqOBcy1h3s6nwu6zCIUyPXqDJ6IVyLcjmz8=;
        fh=LRdKlYzfviwIcwNqwIZDEfz4JRyHx6lDc/K76Lfbe6A=;
        b=ZUgbPCfFVr7QgPyp0Z3908VO8PYd3yLLvomwTY0tIr3cU4107gJxRMgvdB31I8sVVm
         in4a+q4JkdCPiEGMMz71DAZF6lPk2L7MVrVZcl8p/LTt4Z78+yNuGiVBTTWwttctoJpk
         +exQzgI0DGFrjkpZuNRNnyTBcc5vU1YMMkRsLdFmvTUQ7917iIMY+3R2S+IQHF1RbFMd
         g5K1Y3JG/IQqYAKx1l5vZMw+ZSmi3zv60FHcs1lez4mLBBmxMox8t9tb7D5y2Fd1bEjw
         usQPB+gAnpkGdgtbNV9mrDp1c4AL0wd7ZOSKjkD62DFBUNxSwY/tFT++wLQc6yFOGqjO
         4viQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1788298577; x=1788903377; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=w7Y56somwqOBcy1h3s6nwu6zCIUyPXqDJ6IVyLcjmz8=;
        b=ZBupoozP6ZYyZcVHTKmN7iqHcMAf1lnQo7t6bwhL/aORzUOjopG5JX7SBAjh88oSft
         CRHvtArQAHuicGJABkIG4E4YsOkrQJPn5r3iKmadtls9cTWAmyJ0y7TsTJZ+73ZJwVca
         tcHuynfgqlLb5TuMcWBF6eUX1YLf49dhQmPr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788298577; x=1788903377;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w7Y56somwqOBcy1h3s6nwu6zCIUyPXqDJ6IVyLcjmz8=;
        b=p+0S+ZswwhFhW4Xbky8ZWl/J2XsEBmSjqE7E1T3fFuincv+Wenm5Sl6iGS9zJf8B2D
         D1AB0SM7P+aqH6JUB1p3NgjM/j+qS25v3+P58LfaIBvMuYLRKaqT/9BaykBxnGQCYB2e
         lPhjvoEykiOceYIn38P9LKdusGDqEoIMoMK0hPcaACZVmymijYZrM4QNgkXxYHR6PWqJ
         /Kv6lZxUMK0fscvQs4q+mUFycdByGixN4WS+nAwWyM9P//BUZrruBKYuB7ue7aUAULzj
         chKLbgmUuhbjqytG9ZJ7tTRzK4X0oMAl/d1Ne3VHLkU7JKPeEbpynkGsvjTChftWlKe/
         xuaQ==
X-Gm-Message-State: AFuF++nIFlImZDABgXd6BAToD87qAS0SmbKiB9J5oEFlmXKlW/DeDf8x
	8zgYm8k9VaurNxT/rUNUjGiwMxrBxrxo9PUv0U/upUjIZidyDAZRMngL3f2Vtvfxw3zEQ3gW4pO
	mXlCOq4P6bJAT9sQ+N0vojju2kxUZeY4B7q9Dmus1
X-Gm-Gg: AR+sD13wfk8ewYj9ndbEMHChlHaxDOH7i3nQE1zDGfOodoR7MuEcX23bqWJXcjPXy7K
	XKn5U/PdU9Z6WIotLs316dL2xhx7BK0/ntp8h/335kXTvVYQoxASzaS7uJOKDQEngw2UKehL7Fi
	oj3aha3Yp6T+VgH1ixvVQkcTzQye2Ulox6avYBiA6sCSepBmAN6JgA2ZQCEwivZNA9CCoaziYqN
	lsaStaeuDMqyswJgwHU6pADy6d7uXcg3QThjrmRVk/sA1XcQSZWQrBMJJFIvNb3Q6hr5LrdnZUq
	RRRZILyox2yRv4gohEnshjJwUOqgatf+Uqubvf0soxPcEC0+bCGxyn7rD2CUp0kaNE/C5r+txe+
	6C8xGP5BwgOu31AAYL/SP/SmSqT+s
X-Received: by 2002:a05:6a00:398a:b0:82f:50cd:e586 with SMTP id
 d2e1a72fcca58-85ed398a7c1mr796851b3a.13.1788298577057; Tue, 01 Sep 2026
 14:36:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260829081229.81708-1-jhs@mojatatu.com> <20260829081229.81708-9-jhs@mojatatu.com>
 <20260830110317.3357a4ea@kernel.org> <CAM0EoMk6t2FB_3ewLHrh8rqnaj_ecO2L2w7BA0xRUXGJSoqJeA@mail.gmail.com>
In-Reply-To: <CAM0EoMk6t2FB_3ewLHrh8rqnaj_ecO2L2w7BA0xRUXGJSoqJeA@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 1 Sep 2026 17:36:04 -0400
X-Gm-Features: AcwNN1UdCDS7xhrP4FPNJOCPZrFUIeoV8IqdAGHm31OPul5mAuiSmzrrqCFB1MA
Message-ID: <CAM0EoMkwAc0Ver1p68an+Mji-QqCPxubxa4f-wgnAxQK0x6_+w@mail.gmail.com>
Subject: Re: [PATCH net v2 8/8] net/sched: ets: clamp quantum in parse and
 fallback paths
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Victor Nogueira <victor@mojatatu.com>, vega@nebusec.ai, stable@vger.kernel.org, 
	toke@redhat.com, chia-yu.chang@nokia-bell-labs.com, 
	subramanian.vijay@gmail.com, petrm@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 30, 2026 at 2:59=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Sun, Aug 30, 2026 at 2:03=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Sat, 29 Aug 2026 04:12:29 -0400 Jamal Hadi Salim wrote:
> > > ets_qdisc_change() falls back to psched_mtu() with no floor for bands
> > > without an explicit quantum. With a crafted size table qdisc_pkt_len
> > > reaches ~2 GiB, so a zero psched_mtu on a headerless device makes the
> > > deficit-refill loop spin under the qdisc lock.
> > >
> > > Move the floor into ets_quantum_parse() so explicitly configured quan=
ta
> > > are also clamped to [256, 1<<20], not just the fallback path.
> > >
> > > Conditions to recreate the bug:
> > >   CONFIG_NET_SCH_ETS=3Dy. Requires CAP_NET_ADMIN (namespace-local via
> > >   unshare -Urn suffices).
> > >
> > >   tc qdisc add dev dummy0 root ets bands 3 strict 2 quanta 1 1
> > >
> > > Fixes: dcc68b4d8084 ("net: sch_ets: Add a new Qdisc")
> > > Reported-by: vega@nebusec.ai
> > > Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> > > Tested-by: Victor Nogueira <victor@mojatatu.com>
> > > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > > Cc: stable@vger.kernel.org
> > > ---
> > >  net/sched/sch_ets.c | 12 +++++-------
> > >  1 file changed, 5 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
> > > index 25fcf4079fec..6cc902a03838 100644
> > > --- a/net/sched/sch_ets.c
> > > +++ b/net/sched/sch_ets.c
> > > @@ -83,11 +83,7 @@ static int ets_quantum_parse(struct Qdisc *sch, co=
nst struct nlattr *attr,
> > >                            unsigned int *quantum,
> > >                            struct netlink_ext_ack *extack)
> > >  {
> > > -     *quantum =3D nla_get_u32(attr);
> > > -     if (!*quantum) {
> > > -             NL_SET_ERR_MSG(extack, "ETS quantum cannot be zero");
> > > -             return -EINVAL;
> > > -     }
> > > +     *quantum =3D clamp_t(u32, nla_get_u32(attr), 256, 1 << 20);
> > >       return 0;
> > >  }
> > >
> > > @@ -632,11 +628,13 @@ static int ets_qdisc_change(struct Qdisc *sch, =
struct nlattr *opt,
> > >                       return err;
> > >       }
> > >       /* If there are more bands than strict + quanta provided, the r=
emaining
> > > -      * ones are ETS with quantum of MTU. Initialize the missing val=
ues here.
> > > +      * ones are ETS with quantum of max(MTU, 256). Initialize the m=
issing
> > > +      * values here.
> > >        */
> > >       for (i =3D nstrict; i < nbands; i++) {
> > >               if (!quanta[i])
> > > -                     quanta[i] =3D psched_mtu(qdisc_dev(sch));
> > > +                     quanta[i] =3D clamp_t(u32, (u32)psched_mtu(qdis=
c_dev(sch)),
> > > +                                         256, 1 << 20);
> > >       }
> > >
> > >       /* Before commit, make sure we can allocate all new qdiscs */
> >
> > Does this run afoul of one of the tdc cases?
> >
> > # not ok 39 41f5 - ETS offload where the sum of quanta wraps u32
> > # Could not match regex pattern. Verify command output:
> > # qdisc ets 8004: root refcnt 5 offloaded bands 3 quanta 1048576 256 25=
6 priomap 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2
> >
> > https://github.com/p4tc-dev/tc-executor/blob/storage-dbg/artifacts/7999=
38/1-tdc-sh/stdout
>
> Yikes. I will resend with this fixed.

I was waiting for nipa sashiko to say something but nothing happened.
Gemini nipa had nothing meaningful to say - So i will send v3 with
just the tdc test fixed.

cheers,
jamal
> cheers.
> jamal
