Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578103ADB89
	for <netdev@vger.kernel.org>; Sun,  9 Aug 2026 09:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786269374; cv=pass; b=Rmvo8oorNAqe9/o71tKaAHKERTA0crv/jnB0NUbRP4+LShjip6GtA2GS02EYojNt75wYs7buy/AKCHez+0mQeqLSNYrBRC8yvvyK4cGJ9piG97RMnE2YeuCHsRcsFwHeZI4rzd1C1Ulpi4S75nla8qoGGySWcAas+Za1Nu6cNE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786269374; c=relaxed/simple;
	bh=6NbThvuy4rPuJReAEm9UjzLDU20SOkwlmj/LwAEe8jk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R3j7U6KsLMkIe6hiS2JK06bbU4xZZNWP44/eJAOcr1tXHdm1tcGXHuBMj5XYju8+IU681NzBMIuVg8/1/SfSEPX2oxTSVEDx91bWmgYv2HmM3Bw3qGcCnfBxEi1m23zcSgCNbn+Hz/JBYBVrVuvbSmMFcOfBvjhqkcboVtDPt94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=zSDZJftM; arc=pass smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="zSDZJftM"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c966b9ee9cbso467797a12.1
        for <netdev@vger.kernel.org>; Sun, 09 Aug 2026 02:56:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786269372; cv=none;
        d=google.com; s=arc-20260327;
        b=WNqGHNObYsGDiSt79o9XSH+lQEVOTTEtVq0IpyPgt0Bq5QpnFe4mBEcUfIBejsOYGk
         n6NGEaQn3Uoh2U3r1xQ5kIEKGdFsG6e8rurJNE0kr6puYiaVcRrsEvU6kfy90mm9/ZgV
         rwLFKVJ6IXf9FKPW58upz5X/1gJ/aa6lWxxvm++KdxJ5SG574Y+ZEcGn6o6kAI+AXMQq
         iLcTNRTLDmQx2TR3nnoNuskOM4cTyEuvo9o8tEGFacLLdqEf/t4oeP51w/6OaN9uPaZi
         i8H2o8DZdD91iCOoSRtadJWcKY1n121xgQWju7Bc+mqt8yzE4sQqlJukfx4Vb+I9nveM
         PFqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QAtBNemFKTwUgi//CJ+v9MoC5iBu5RDcY9yA9uNjhrE=;
        fh=ZDJSkp1J1dhwnfwy1Y+SdCVOLDAANM26ud+W4oCxoU8=;
        b=STvNETj7EjS6WIBztX8v5NVoRTKdrU5+Z/lCwDRdjooe+IG+QTb/eeO4sCFqw30KWi
         Q0U5HDiLkZD+k5vt5EhcHhHkrY7VXJrAp1t2KO11rdb2cuC33NChrbN1XeezDreYLkQz
         2zWFlROxPAbAndgwO2WzUMuLzal2BjAJfM2ZqZ/o7LTKueKRemjR5fj867MRPHzTU0Wk
         S+g2e/eL9eSEHL4HR3AH/61V9aPjQ9BN6F7mTwHEUDZTEd0SvqSCWKLhf+O/6kPzC6+0
         WLEYIcCkxoorJ18lcKkf8Vm6eQxT0g4RqTUAw4aLuGMGjP/6dfIji7bvp5hYovOVdeaD
         PgLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1786269372; x=1786874172; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QAtBNemFKTwUgi//CJ+v9MoC5iBu5RDcY9yA9uNjhrE=;
        b=zSDZJftMp5vlMR6/4SSUPKfRe4PCeZ8ffgvwbxFLe8EL51dd72yXpHA8YFfFu0uPYH
         rZDBxNAyIyUfIhOPd2iS4eSm0doY32LmRzIMVPrOh3KJURBxhXbNdxrc2Lh6LFgIQxGi
         o7F58Yt+yUpfGNvQ3W/gGvkKtleHHFngYkBXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786269372; x=1786874172;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QAtBNemFKTwUgi//CJ+v9MoC5iBu5RDcY9yA9uNjhrE=;
        b=rbTI+SHeKB9imQe8zH4jysSTYyUIypVw3Fmvgbhr3meNQ8XO+lKLecOQTWNeEzkpkK
         dgQCMVNCEa1yBQTOAzd13saj34KVQh7XMrh2Brq3/pnOEMng8QHhrt7Hs2ZkfkB8a9Sk
         AECvlQnS6EPXl0Z7ReWhb0YnUmlx/k5otkQQgaQ2vQfpw3csH0G4GZ+kRYrgnj6kjVnj
         rd+4/Qvhdt19pMKMYWIV4la05YXTTgJvCnCbRrySDAooL5FyH0g6FRe6p855uf70gF+T
         EcBGqVmMXIhYl+Sr1wkANN45XlungOJh3jMGNnnqYzjNJ8+N6fjpbBsw/djwfJOAOY6w
         oX8A==
X-Gm-Message-State: AOJu0YyKTSw9oZ4ZMU8GYgSmokLyd4LXB55WmdryPKdtSQKNuuARtmrV
	J2EzgJDGFNpJXNy0toUd8MZf8egd6oN0EnSrIakWBM3H2as8+OkXiTn4nnoUbxzDq6Dz2yl0Xyi
	EL8JqAk3voMam/owkxsn9eb1HfOwdHYdz290bw2gw
X-Gm-Gg: AR+sD10e7dMcZmROjU4o+y8MNtlbJa31pBbJ+87rJZFlbzOnmFEHspoDWPzgwK/IjgB
	1fjRrQfUrcHAPxdiT0FhXMf1dogxB9YrIaTG53/Q96NscjwVRoR25f/nv/gteSIhHUaeGYASQzo
	QUtw22qLZDt7eeEllaqts1bEoZnpWJKLF8x8E+Jst0/gSiktiWam4zLztlLIOWljUYmRdKU1/HW
	8WVgZSDT78g6sWtlMp1dwlhWWiMQ5LkArjKUeYkBuCFUlQxNNYeL3h8g/9m5shxHyMxUlyBmEUT
	+mpzzTxnY5nE+4OQoS5OQIXcoRSjtlhuOLHqIm432kJr1A==
X-Received: by 2002:a05:6a00:8d81:b0:845:e9ff:5d97 with SMTP id
 d2e1a72fcca58-84f2e025254mr43501422b3a.12.1786269372512; Sun, 09 Aug 2026
 02:56:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260809091657.879929-1-jhs@mojatatu.com> <20260809094325.2069096-1-zhanxusheng@xiaomi.com>
In-Reply-To: <20260809094325.2069096-1-zhanxusheng@xiaomi.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sun, 9 Aug 2026 05:56:01 -0400
X-Gm-Features: AUfX_mxoa5eix2-K5PWwzIzpo1d79ch7RQPsOafp-mOlSRe7tulfa1m60BYdmkM
Message-ID: <CAM0EoM=6zZVucSOUDi7pJiGhkoeTJ-PN9M18DnPWSpfH4GP6=A@mail.gmail.com>
Subject: Re: [PATCH net] net: sched: gred: fix 32-bit backlog wrap in gred_enqueue
To: Zhan Xusheng <zhanxusheng1024@gmail.com>
Cc: netdev@vger.kernel.org, Zhan Xusheng <zhanxusheng@xiaomi.com>, stable@vger.kernel.org, 
	vega@nebusec.ai, Victor Nogueira <victor@mojatatu.com>, David Ward <david.ward@ll.mit.edu>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 9, 2026 at 5:43=E2=80=AFAM Zhan Xusheng <zhanxusheng1024@gmail.=
com> wrote:
>
> On Sun,  9 Aug 2026 05:16:57 -0400, Jamal Hadi Salim wrote:
> > -     if (likely(sch->qstats.backlog + qdisc_pkt_len(skb) <=3D
> > +     if (likely((u64)sch->qstats.backlog + qdisc_pkt_len(skb) <=3D
> >                   sch->limit))
>
> bfifo_enqueue() in net/sched/sch_fifo.c has the same expression, and this
> patch does not touch it:
>
>         if (likely(sch->qstats.backlog + qdisc_pkt_len(skb) <=3D
>                    READ_ONCE(sch->limit)))
>
> Same u32 backlog, same unsigned int length.  sch->limit comes from
> tc_fifo_qopt.limit, a __u32 documented as "bytes for bfifo", and nothing
> caps it on the way in -- both .init and .change are fifo_init(), which
> stores ctl->limit directly.
>

Looking at the code, I can confirm you are correct. I notice also plug
and sfq have a similar issue.

> The gred check is the newer of the two: it came in with a3eb95f891d6,
> the commit in your Fixes tag, while the bfifo one goes back to the
> initial git import, so there is no useful Fixes: tag for it.
>
> bfifo also has more ways in than gred.  sch_red.c and sch_tbf.c install a
> bfifo child through fifo_create_dflt() -> fifo_set_limit(), passing
> ctl->limit and qopt->limit straight from userspace; tc_red_qopt.limit is
> likewise documented as bytes.  Since this is heading to stable, fixing
> gred alone leaves those paths unchanged.
>

I should have paid closer attention instead of focussing on the bug report.
Since i already submitted, we can wait to see sashiko says - if
requires an update i can include the others; otherwise it will have to
be a followup patch.

cheers,
jamal

> Minor, and in the other direction: __fifo_init() does
>
>         u32 limit =3D qdisc_dev(sch)->tx_queue_len;
>
>         if (is_bfifo)
>                 limit *=3D psched_mtu(qdisc_dev(sch));
>
> which also wraps in 32 bits, but fails safe -- the result stays below
> 2^32, so the limit ends up smaller than intended rather than unbounded.
>
> Thanks,
> Zhan Xusheng
