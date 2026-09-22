Received: from mail-lr2-f19.google.com (mail-lr2-f19.google.com [74.125.230.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F7526ED41
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 01:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790040087; cv=pass; b=lscaV/hwAOBOamqldHYDdTtZMA/f+yzPwwMco8N2MMwmSJ09Jg5MUW7PsTdFbpe/2a2HnHbqGKnDH6F2r3dVmApfiyaQiCWq3x/o5EQE58PhXeLovJwsTiA+Hklfs8wAj4zojvvaCouEepDX5GGNC3OOVUB0aW2AQGfDHcAWknI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790040087; c=relaxed/simple;
	bh=XGMLc8O9wQ2kbJfaKvLL4ZU0r7ZfUppVx0yg76psbQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HKOsjL39Bnq0r07hJul6cEadDu6/QLP2QSkXxsOKmunI9E2cnJG7/d5VqfFLFy79jCAHANLqKrbxsWyVh6GRax/hBKP3mdg1Q/NR3S3DVXXF+bENgNIzaULrHuchHt6wbd0EoN5MBdZnHhhS70FnFpPaJJk75YZ1f+yHYov0LS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TYaruLXm; arc=pass smtp.client-ip=74.125.230.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TYaruLXm"
Received: by mail-lr2-f19.google.com with SMTP id 38308e7fff4ca-3a30521edd8so12992511fa.1
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 18:21:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790040084; cv=none;
        d=google.com; s=arc-20260327;
        b=gluS9bgAq+W9oYZOxbUh+MrakVGoQ+AatE9r/6F2KHcojaTPHetr49ValRAjtAHxbG
         9wcq9bH8OvjxU47POnyDonlRZzfBYR+jPpSRmb5lOm3GC8nL4DoSamvlYLLon3NPizAj
         ZFyL8cZ5pyWgmldSGhvsxsxlZ4UDubdkuL5XhjdUYUM1l3sejvijrhTGGQa9ve89P62C
         28CijX7re7V/eoOLedHSyRp+LG1hU6Z+qa5w61Xvcwv6K4X167nWnn7KjguTSBFYR1If
         GbL4XJ8gtZvo6FmlmDCb/9UgnjKP6SqzaA6Q088REPnem1dCX5xSnuOG3EQUP4/1N8CQ
         kQuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=94viYqPCx5bKufuoQHb0p4ULNgGNRu66+Yp2unVMzo0=;
        fh=h/Jq51OIG6AenGYVtCY7J+iK7XdaDo7x5xa0CmTTi2A=;
        b=ruZvg7zvIoDqs8lw3yKfdehNHvHyhy1OZA9cjh2mAwQqUQgvn4yW6/6SNuSy7M0MJi
         BknkY57e/7YlH4AMzsK7+avBmgVhctqSJKVXbUwfB5C5RCpc773hn38fUfL9uq/I61fL
         2O1DdHvCYrOtfhOUQW1sfRh49WIeO/XancTrztIaOBrv4RgflpjKOoAyd1omNmU4SrBk
         o9gd1t7r/o94RvoA+e8BypkHOe0ITkXaVU/LfJBulZ4skreKClrKy7MWlUQOyAYE9lCN
         Y85rz7wux7aMKHTMQlx5md1r8DBOp/vV7rbkZwg2Ux7cQyMLKDemSl1npknK6HKqNyTq
         1ymA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790040084; x=1790644884; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=94viYqPCx5bKufuoQHb0p4ULNgGNRu66+Yp2unVMzo0=;
        b=TYaruLXm32cjbK09Y8AFa9Sr+6I/mt2WCO/dXA9/SaYoUu484R0cMCC+iQinzvJBIE
         qvXs45OaG4zhJ46liBEwXLmItviQkX+BQkjcO0FYWLOFYO3tr5WL7URddb/zsWJKcJy9
         RiEY0d7A+gS5zgyvL+cggenkrH4PACg7cV2Byy39ZZjElJ6Cifh9zePC0ko9F/gyNzUf
         IOHlo9pLM3M9qjCmYJxYTJ9rE5wDfCeSKPqgCFpr/YTeZpFF/WLq9bkh6rlnK9Z266gP
         d38d9BDrBWfs/CMdEINRcz+oIb6E3hz2KV7xbQn/jiErrtdULWizbduWa24Z068B72yx
         gGpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790040084; x=1790644884;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=94viYqPCx5bKufuoQHb0p4ULNgGNRu66+Yp2unVMzo0=;
        b=MEdY0XsrPqX8iNeZzM+o3gCPuwmumBsf85MIOx8VXs7U7gyzMRkYiVMqtgU2fkMPcI
         Hoj3+OqrnPU+wG2WzCsTXsWj/GDO0PyQWrcrFJeL0EtmC3R6Nlmh4YY4DqNI5CYeCJim
         eywPo7t7c4Q+W09xpdHXfWReTL09vHObExaEzlSCC7QvH7EjanCi2+8yFlGVMfULMfMJ
         8qeRiRDpvMB5KlyzVMRtez8+UANxpW++hWyOcHWyUtQ0tMxGFwuleoRkEcAZrt+KF7ng
         SUUgk9pFffIRX/Lrgp3ORB92fugnBJWKDfQ3PyFfB1I96IWAr0nRsXye5r77ru6FAx2s
         r0pg==
X-Forwarded-Encrypted: i=1; AKwUvBw5jeV5x3z+uUNL5JMB+CQBubb1pdChtaGFdvyNEXJ0oxyPXz2bdZE2MRwsbSXbf4lV9Jv9h7E=@vger.kernel.org
X-Gm-Message-State: AFuF++l+Y67sfeEEQvZ/dwg39d6pamHYww1qcmcWcSnQyqMnEAA42ird
	V0ff2P93T9jSrOxUBWlPzcbzb5Qm0OEpcRT9j8s6ZZMI9B9/pdPdzbX4AafYTLZBnBBB8iWB8yP
	wwOYvrzMqjJxaj6GZFY90ye/l3ZTiegk=
X-Gm-Gg: AYBFou1jqYn0grK4xJfzMW7Vi//yTd/0nGefoFMqT0gqlekoRhQjj5+m7v0VBQdrESK
	DfgyzfLcbf91u1cGerSLVzCeXwWv9EUcUfEmzsT/QQjvIE+avOeX0sBdL2cGqr4UWVzIymBwg4v
	rHt4GnJMdvGgqC4Ey5Y/WXNoJuweoWMlA6RoqZSftO1ya3xEUOh9pP9jTPmuGlmA0cT6xAtz5oU
	Kw/P9FiloPAZRzhr9+nkiK0I9tTb0zonaUSqu9DeXgJ3dw7wu2Bv4mOhdx7hih94AwKlFMEiHnr
	nDVr4IZTG3rIZtQkW39Q61D5jcYdo8P9zVHqQvXXhdE4O6SV1tnB1PulfGXVik6FOPpMStlY8Q4
	d/eJudvtcFTqlvzAvpKyFh+VJ5yJGRdIrEcMgWOCsIwY1H8lTIYRXTa8KWnR1jP6G9upwFTpBBU
	/YXr4ZHlBktEBSeOFIYGMTc6c3M9+fFJPKQ0M2cVo=
X-Received: by 2002:a2e:be95:0:b0:3a5:a4bd:bff6 with SMTP id
 38308e7fff4ca-3a624b2c4f1mr2510321fa.0.1790040083589; Mon, 21 Sep 2026
 18:21:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260919143732.11772-1-kerneljasonxing@gmail.com> <arF7FGr8rQqDw8Pj@devvm7509.cco0.facebook.com>
In-Reply-To: <arF7FGr8rQqDw8Pj@devvm7509.cco0.facebook.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 22 Sep 2026 09:20:45 +0800
X-Gm-Features: AcwNN1VMDqn6pXKiQJd98KeFM-hSrB1bZg4TJGtFZHqIc4Kp7X9yqfd5UwiOtQ8
Message-ID: <CAL+tcoDossUOJCVwZ-6U519L_bNMYngnd82e1_oQB-czA6rL3A@mail.gmail.com>
Subject: Re: [PATCH RFC net-next 0/9] net: BPF Timestamping 2.0 for TCP
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, willemb@google.com, kuniyu@google.com, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Jason Xing <kerneljasonxing@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 2:45=E2=80=AFAM Stanislav Fomichev <sdf.kernel@gmai=
l.com> wrote:
>
> On 09/19, Jason Xing wrote:
> > From: Jason Xing <kernelxing@gmail.com>
> >
> > Greeting,
> >
> > It's BPF Timestamping 2.0 that aims to observe the packet latency
> > more efficiently and simply for different protocols. The current
> > series is only focused on TCP protocol.
> >
> > At Netdev 0x1a/Netconf 2026, the history, background, motivation and
> > rough implementation of the feature were exhaustively introduced[1].
> >
> > History
> > =3D=3D=3D=3D=3D=3D=3D
> > - In 2009, Patrick Ohly implemented the basic infrastructure
> > - In 2014, Willem de Bruijn enhanced the TCP latency observation
> > - In 2024, Jason Xing proposed its lightweight BPF version
> > Detailed slides from 28 to 32 [1].
> >
> > Background
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Even though BPF Timetamping 1.0 is comparatively low-overhead,
> > transparent, it's still complicated due to a few points inherited
> > from the design:
> > - Inflexible/fixed reporting phases (qdisc/driver/ack)
> >   When we confirm the issue arises from the kernel by using attribution
> >   ability of timestamping feature, we need to further minimize the scop=
e
> >   until the issue is fixed. That means, we then have to resort to write
> >   a few complex BPF progs with the similar functionalities (like skb
> >   level tag) which should not happen.
> > - Not enough low-overhead
> >   Serving the sensitive applications, an always-on latency observation
> >   platform should mitigate the self-impact as much as possible. As we
> >   can conclude from BPF Timestamping selftests, there are some blocking
> >   and time-consuming points like where reading/writing BPF maps happen
> >   in the extremely hot paths.
> > - Minor flaws
> >   There are a few minor flaws inherited from the initial design, like
> >   missing tagging the last packet[2][3][4].
> > Detailed slides from 33 to 39 [1].
> >
> > Motivation
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > During the process of the large scale deployment over the last few year=
s,
> > we eventually realized timestamping feature doesn't support container
> > scenario and we need a finer-grained and flexible tracing tool (packet
> > basis) after a few rounds of attribution of issues.
> >
> > Design
> > =3D=3D=3D=3D=3D=3D
> > - Start time
> >   For the specific protocol, we need to accurately set the start time o=
f
> >   each packet first. For TCP, we chose the entry of tcp_sendmsg_locked
> >   and the driver time as the start point, so that any BPF program is
> >   capable of computing the delta between start time and current time.
> > - Simplicity
> >   Previous BPF program (like selftests) is too complex to implement. Th=
e
> >   core idea is to make everything as simple as possible. And it should =
be
> >   decoupled from BPF area and previous timestamping feature as much as
> >   possible.
> > - Flexibility
> >   BPF program hooking any function with skb parameter can get the laten=
cy
> >   value, which means it's no longer bound to the pre-embeded reporting
> >   phases (see __skb_tstamp_tx)
> > - Efficiency
> >   Avoid the previous BPF operations as much as possible. Make sure the
> >   feature achieves the lowest performance impact, which means only time
> >   operations remain.
> > Detailed slides from 40 to 62 [1].
> >
> > Implementations
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > in-kernel
> > - Find a suitable place to timestamp for each packet
> > - Pick the right start time for TCP
> > - Handle the split skb due to various reasons
> > BPF prog
> > - Hook any functions that carry skb parameter
> > - Read out the start time from the skb
> > - Generate the current time and then compute the latency
> >
> > Discussion?
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > - Do we need a kfunc to allow users to reset the start time of each skb=
?
> >   What I had in mind is if someone tries to observe the latency between
> >   two specific functions (rather than tcp_sendmsg_locked).
> > - Current implementation is real hardware timestamp always wins, which
> >   means BPF prog possibly gets the hardware time that is not aligned
> >   with bpf_ktime_get_real_ns.
> > - After the series, do we need to implement the same logic for
> >   SYN/FIN/PROBE... As far as I know according to numerous user reports,
> >   a small handful of issues came from 3-way handshake.
> > - Reusing the slot of hwtstamp might bring potential problems or make t=
he
> >   code hard to maintain. Can we add a timestamping specific field in
> >   skb to deal with the latency observation?
> > - netdev_data conflict in IGC driver. It seems unavoidable to pollute
> >   start time when it's enabled. Should V2 feature coexist with hardware
> >   timestamping?
> > - Should V2 coexist with net timestamping and BPF timestamping? If not,
> >   the maintenance should be easier.
>
> After netconf discussion, I was under the impressions that no kernel
> changes are needed, so what changed? Is it hard to track start_time

Ah, you refered to the internal version, right? We wrote a kernel
module implementing similar logic which differently finds/borrows an
unused field of socket to store the start time. It's quite similar to
the series actually.

After deploying it at a small scale in production, I think it's
meaningful to upstream it. But as you noticed, there are remaining
discussion points on which I hope we can share opinions, especially
the future shape.

> from tcp_sendmsg_locked on the bpf side that we need kernel support?

Sure, we need kernel support that why I'm trying to introduce the
sk_start_time to help.
https://lore.kernel.org/all/20260919143732.11772-4-kerneljasonxing@gmail.co=
m/

Thanks,
Jason
