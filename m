Received: from mail-pj2-f7.google.com (mail-pj2-f7.google.com [74.125.227.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BBD52BE24
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 20:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790110404; cv=none; b=IexIBStYNLoaSWuTNYqqGK38Ec5VRpze8EPhbgUDlif9hm76086jFnwPKPlcGEOKav9x7KUG77HhKcBYIXxbqo2uu27TYbN4CBBVNHJ+HShs8MF5hDgUR8v1nLLrLcVQzXceqfRt1I7Qmw1EYN2em1R+igOQkfAtYcwGJCixt4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790110404; c=relaxed/simple;
	bh=/5Ovrt5SIzUgxaxdFXnnNjtd+rE2C1y05J62Y3qD1Tg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VKPu1NVPjX3r1Xwdg/IYDPD/cKOBhOXfczVA12VH+gzwqedkxsfOUvMwF5msiqDl+xn/infvWNvrJys46PE2cPpIgArYLxlbU/dz8xxjy5IsE49mhe1mHxyuH5HKbCPJLYzXSLlTr27PolTTDqVVZCjPLiV+/Mw0nA6R3jHmYz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wyqwpwcj; arc=none smtp.client-ip=74.125.227.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wyqwpwcj"
Received: by mail-pj2-f7.google.com with SMTP id d9443c01a7336-2d561173f9fso1808085ad.0
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 13:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790110390; x=1790715190; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cN/bUNYr6k4szo+6LYbJD9AWHo4WOhhjO1JliVkVGmw=;
        b=WyqwpwcjFzQOBQe7yuMlBIiAYtb/Xg0D4qMydtskKUPhrI+DCwv5NJfn7303pDSWGi
         vOH4T6drnLuUbjL0HiF/9YbVpVbgF8t7fOVKAt9SzqiOnCnZXtfWkLe8NcIjZkkFoEtf
         vxbBOL3WwkqUKa6/QSTu8HeYnays6QfQCcPy5iOfk11GZ8Oz0d/uz6+BRyJTYlPA90LP
         bAJCZoDrQvYMTPxKmdSetRai5azSYLrUrmT2/XsntNV4pqq+dyGlsGVoKbpx691IVuP6
         DGQDTZAD8vs0YTTAG1LUqmUxBxLev2gKfcISk6yw30X83Oy0Y8EUYwoUX4eBgEfLZZld
         vL1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790110390; x=1790715190;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cN/bUNYr6k4szo+6LYbJD9AWHo4WOhhjO1JliVkVGmw=;
        b=JEo7tn5PSPY68JTe64LWKKkPA3WZSPz0K8y3dEX3zv3kd4fEKT27EO6AdeZojhIdyJ
         rUk2utwEi41QT4LJMjKrUW+7ZzCnVfc3CIkaVh9eufT5DxGzx0pMZGdb6TWXIM3EcrRX
         9aUp4cyqF/k4mQ7oKta2o5u9WpP4bwPjF4kZ+doYv6wk6VVACZkFRpqRKRlldjWBuXCE
         ebOHtF93Hg6xXEXEWrBGQhltoIxnAu42rkKHmkGB4Y1FbX9sLpX4kuhMFTHmkizY2A79
         K0Oh9sBa/pIjqNvZT4Gq9cwn5p0l8qujbPE8kv+4SogvrBt31jxQWiPZJBQutLHNFdfK
         fXnw==
X-Forwarded-Encrypted: i=1; AKwUvBwrYAMSrwQnoVn5YOcXC67BZwhWf0/eVr6GFw6/RSnhq3g0HRROAy7ciWPpMQyPIsBS56ErpoY=@vger.kernel.org
X-Gm-Message-State: AFuF++nbIl9DhvkYxgAMrg2UZxSfMkygDj8/oQABDcFIbH1qzWTRDBgu
	vKxvkpgJ0mN4X8wXzU5X0nyCfNIb5smOyibW6Hi4A8xtgcTvtphuhVTi
X-Gm-Gg: AYBFou2opTz5Mv0MMxLaXH2etv8XkEJ9puYgfD2H8+Fdww0ueqVxK42wTEyc+ECxnHU
	Zl5TQmM8P9BDbbHumQdAxtM1WUMlSpkWblZmA6eB3itsT+7yWSXwTc9Eb6CuxwUAjqMVbW6Fz0R
	M4dD8OOue2AzsCAb2HOyrepgRwixrmyqUVl0Wi4ODAskBhmIUc765Pa142eH9o3O2K7GQEN2Ld2
	coNCumPvnlCZ9zSlT1rJ0QbM4l0NzvztRZGz7bxOppKHYZDDSNWvf2SNtbLqT6twSIpOzak/Pod
	uFUV3aIIzgcmHu7YODNWdkZ4cehWtP0VnTluLGhRjArosIK08dTcGd3t4RMcPMm3Atkxhnc87i4
	CFwC3X/0wdAP4rvCGn/Q47FPA6kVybdcmfJNFjDfJcGqWGOB4gLLS0PNX304km7dUK8azW5x6un
	bOD7bwBCNGs0dBxA0MjgZFtmsIrjbttS+hSJ8rR+DS6KIcOPibz//hCT8jR6g7LuYbTlV9jW1t5
	1g=
X-Received: by 2002:a17:903:2c50:b0:2dd:c100:a5e7 with SMTP id d9443c01a7336-2df69e2b857mr5039605ad.59.1790110389518;
        Tue, 22 Sep 2026 13:53:09 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:49::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a60c4a8sm931315ad.79.2026.09.22.13.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 13:53:09 -0700 (PDT)
Date: Tue, 22 Sep 2026 13:53:04 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, willemb@google.com, kuniyu@google.com, 
	netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH RFC net-next 0/9] net: BPF Timestamping 2.0 for TCP
Message-ID: <arLpc9BBv_W6nw8c@devvm7509.cco0.facebook.com>
References: <20260919143732.11772-1-kerneljasonxing@gmail.com>
 <arF7FGr8rQqDw8Pj@devvm7509.cco0.facebook.com>
 <CAL+tcoDossUOJCVwZ-6U519L_bNMYngnd82e1_oQB-czA6rL3A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoDossUOJCVwZ-6U519L_bNMYngnd82e1_oQB-czA6rL3A@mail.gmail.com>

On 09/22, Jason Xing wrote:
> On Tue, Sep 22, 2026 at 2:45 AM Stanislav Fomichev <sdf.kernel@gmail.com> wrote:
> >
> > On 09/19, Jason Xing wrote:
> > > From: Jason Xing <kernelxing@gmail.com>
> > >
> > > Greeting,
> > >
> > > It's BPF Timestamping 2.0 that aims to observe the packet latency
> > > more efficiently and simply for different protocols. The current
> > > series is only focused on TCP protocol.
> > >
> > > At Netdev 0x1a/Netconf 2026, the history, background, motivation and
> > > rough implementation of the feature were exhaustively introduced[1].
> > >
> > > History
> > > =======
> > > - In 2009, Patrick Ohly implemented the basic infrastructure
> > > - In 2014, Willem de Bruijn enhanced the TCP latency observation
> > > - In 2024, Jason Xing proposed its lightweight BPF version
> > > Detailed slides from 28 to 32 [1].
> > >
> > > Background
> > > ==========
> > > Even though BPF Timetamping 1.0 is comparatively low-overhead,
> > > transparent, it's still complicated due to a few points inherited
> > > from the design:
> > > - Inflexible/fixed reporting phases (qdisc/driver/ack)
> > >   When we confirm the issue arises from the kernel by using attribution
> > >   ability of timestamping feature, we need to further minimize the scope
> > >   until the issue is fixed. That means, we then have to resort to write
> > >   a few complex BPF progs with the similar functionalities (like skb
> > >   level tag) which should not happen.
> > > - Not enough low-overhead
> > >   Serving the sensitive applications, an always-on latency observation
> > >   platform should mitigate the self-impact as much as possible. As we
> > >   can conclude from BPF Timestamping selftests, there are some blocking
> > >   and time-consuming points like where reading/writing BPF maps happen
> > >   in the extremely hot paths.
> > > - Minor flaws
> > >   There are a few minor flaws inherited from the initial design, like
> > >   missing tagging the last packet[2][3][4].
> > > Detailed slides from 33 to 39 [1].
> > >
> > > Motivation
> > > ==========
> > > During the process of the large scale deployment over the last few years,
> > > we eventually realized timestamping feature doesn't support container
> > > scenario and we need a finer-grained and flexible tracing tool (packet
> > > basis) after a few rounds of attribution of issues.
> > >
> > > Design
> > > ======
> > > - Start time
> > >   For the specific protocol, we need to accurately set the start time of
> > >   each packet first. For TCP, we chose the entry of tcp_sendmsg_locked
> > >   and the driver time as the start point, so that any BPF program is
> > >   capable of computing the delta between start time and current time.
> > > - Simplicity
> > >   Previous BPF program (like selftests) is too complex to implement. The
> > >   core idea is to make everything as simple as possible. And it should be
> > >   decoupled from BPF area and previous timestamping feature as much as
> > >   possible.
> > > - Flexibility
> > >   BPF program hooking any function with skb parameter can get the latency
> > >   value, which means it's no longer bound to the pre-embeded reporting
> > >   phases (see __skb_tstamp_tx)
> > > - Efficiency
> > >   Avoid the previous BPF operations as much as possible. Make sure the
> > >   feature achieves the lowest performance impact, which means only time
> > >   operations remain.
> > > Detailed slides from 40 to 62 [1].
> > >
> > > Implementations
> > > ===============
> > > in-kernel
> > > - Find a suitable place to timestamp for each packet
> > > - Pick the right start time for TCP
> > > - Handle the split skb due to various reasons
> > > BPF prog
> > > - Hook any functions that carry skb parameter
> > > - Read out the start time from the skb
> > > - Generate the current time and then compute the latency
> > >
> > > Discussion?
> > > ===========
> > > - Do we need a kfunc to allow users to reset the start time of each skb?
> > >   What I had in mind is if someone tries to observe the latency between
> > >   two specific functions (rather than tcp_sendmsg_locked).
> > > - Current implementation is real hardware timestamp always wins, which
> > >   means BPF prog possibly gets the hardware time that is not aligned
> > >   with bpf_ktime_get_real_ns.
> > > - After the series, do we need to implement the same logic for
> > >   SYN/FIN/PROBE... As far as I know according to numerous user reports,
> > >   a small handful of issues came from 3-way handshake.
> > > - Reusing the slot of hwtstamp might bring potential problems or make the
> > >   code hard to maintain. Can we add a timestamping specific field in
> > >   skb to deal with the latency observation?
> > > - netdev_data conflict in IGC driver. It seems unavoidable to pollute
> > >   start time when it's enabled. Should V2 feature coexist with hardware
> > >   timestamping?
> > > - Should V2 coexist with net timestamping and BPF timestamping? If not,
> > >   the maintenance should be easier.
> >
> > After netconf discussion, I was under the impressions that no kernel
> > changes are needed, so what changed? Is it hard to track start_time
> 
> Ah, you refered to the internal version, right? We wrote a kernel
> module implementing similar logic which differently finds/borrows an
> unused field of socket to store the start time. It's quite similar to
> the series actually.
> 
> After deploying it at a small scale in production, I think it's
> meaningful to upstream it. But as you noticed, there are remaining
> discussion points on which I hope we can share opinions, especially
> the future shape.
> 
> > from tcp_sendmsg_locked on the bpf side that we need kernel support?

[..]

> Sure, we need kernel support that why I'm trying to introduce the
> sk_start_time to help.
> https://lore.kernel.org/all/20260919143732.11772-4-kerneljasonxing@gmail.com/

Why can you not do this on the bpf side? There is even now a sendmsg_locked
tracepoint with skb/sk argument. Or is it mostly because you can't
distinguish between cgroups? And looking at your example [1] and don't
see why a tracepoint won't be enough. Or is it too much overhead? In this
case, it needs to have some numbers attached...

1: https://lore.kernel.org/all/CAL+tcoD36zA=TYSzKSNWV0Ypo_HRBRU_Qh6rQtPL51aXR54p7Q@mail.gmail.com/
