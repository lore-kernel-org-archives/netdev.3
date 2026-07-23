Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DBA32B132
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 08:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784797060; cv=pass; b=jlSS+1jRxlmcBVyV5j7JVuWOqZcvQW3HYSWBXS+YQpY8GahXm+DajCq1tiSX7BkQkN+FrNKfata1zcMGhFAuMQQS9gr4D3s4YQhDSxUnKYMTFUF6+S7a5G9BONeHlMX9WDPFCvkkHavs7V3MWYNxJ4B4FNNX5UMN6fZ0pmP52Cg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784797060; c=relaxed/simple;
	bh=k+mAbwDpC7Nt3eygOUnsr+pIas5Ut/V4Zucp+rzEMoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n8iOlP2b2KQrY8iSiSgDJvfeHaic7RPKVf2PvIujByNxCI/CaXlqJuZIl0VNttvT6ntCnrU3Sw6bYHMDvUdg+6Vjhz1qCbhJpMZk8uUOZivtic6kCiXQFF9iTQEK5lrts05lNF19Be/EFaDgihK2bOfPVjQ3TndKHDpAUuaM7bs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nkqizbe6; arc=pass smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nkqizbe6"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-92e5c92c389so30579785a.3
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 01:57:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784797057; cv=none;
        d=google.com; s=arc-20260327;
        b=orqyPGeOhhZiCs/97U8LICu2i3TNkDesQJJ9GtHjHfRTXc2k6RzLsXEZQ22dgC1eMg
         NP9UXVvWzEgdttrtJFLPc4A2mO/uAOySAIXths4fI0TlSRzM3KDfLNTdAmMpBmuxm2Z4
         BL8C1F1+d9b3uliHR9tUdQNjlMEv9RlgqJPKs/0p5EEv/uOe2qjh/WmYdy3+X9yfWKhv
         XcCuT5mWFHcU2Ysn3NbmVRdXrrZiAfQzNNbYnr7jVy9pR4K1oGMZKIDdYUmNEWDUL4Ly
         iM+J3ZUlpk1X67miIyZis7lulsmrBN3IRO5ieEaDXbC7JZlMkn0Ht9309SuAwZZBDeZt
         WMwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k+mAbwDpC7Nt3eygOUnsr+pIas5Ut/V4Zucp+rzEMoc=;
        fh=CEqGy9nhJiPSyC4nLLZUbTOMVAd3IhSPTUb+UQ69kR4=;
        b=an91DCFBFnnGeAnoA6cOBXTqlLKE4KBCSVQ3YwdfKUMbnxzsrERhcEXrjkAO6ht4XX
         w0e70JZjrDHQ0HUpshM5GY/pUk+3PLgd5eDMZYkC+bzpTIBz9sUll/HMH0caxoIbZgGr
         yPW/CIIYP0pxp6284mwIPfy38eY195XWOm7mISfXO+VoO+OBZsOPEqRhhGPvVO0XwsSQ
         TZXYkMsRqS1qWCHatO1vY3TDBIEC/vaH4EIrV2B6NS7VhlWe5rUoy9zRvAfl5VSMcsq2
         UfRMQzBGzUMMUmrA/42JjaLvLW9pmTuqmG33+ehPFLzRwB90GSIAmmIX76v6RQECf5XE
         DuZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784797057; x=1785401857; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=k+mAbwDpC7Nt3eygOUnsr+pIas5Ut/V4Zucp+rzEMoc=;
        b=nkqizbe6io3Z+qQ7pDq3p2DrYUB1jpV3ZQ/3bahMEOrR172doFdTXbQpioW56i0MDi
         DxlC/F5Lpe7PCcsWElRseepPLcHrzYpQsJsOAOKAhiYeEJ+Q8FWLRw62ZyjBcRa/PdTD
         pco49e6FpR7J71KwQDLPffi7lrUe6WJY2/42K3a0N0U7rfbYX8EBizvhKr+Ya+vdxTnH
         RwOCft20Hu9aR6OKIOJiLmG3ySnZGS12T3uhXLvSgIZtV74E0LK31QPPcPz/Y+CrWMo2
         7d/p6WIQ8wdpHqZ22JbY843c/IW8na9HpTVuowM4b4Iw/142jgm0+FchtNllfc4HbTTM
         AXgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784797057; x=1785401857;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k+mAbwDpC7Nt3eygOUnsr+pIas5Ut/V4Zucp+rzEMoc=;
        b=WhqLrESNLn3Sok/HpY3i4WG47KUgzPegcPCNB8kdxVvsDcAf2tOr3JUj2rvMi4VAtW
         2yRJBHuLoKej/pYk8dr87h2uRIfFV6QLG9azV1J5FLKIR9xGOtvjf7d3IxsG9T7zmxEv
         GHVum5nbt+htNKAGbeUB5RDLAGudbOqcUYcMnwuNRRtf/apkyjsuFdsqVvpPWjhWpEV1
         rlQYXZAdcbUb/ajxSAd2Q+JSpJOIVkem0AWpbX0YfZeFimLT++92WpfugOSZGCLgGzh5
         TkZuGYt8whLj2agl5gFt4W7U9QpRQcvevTPSkxYsvidD23lVtFFUN+eOl4sftzzMLsBL
         ee5g==
X-Forwarded-Encrypted: i=1; AHgh+RplpeZ839BEQEhi9jF2fYwjh+eB9244C/EsFTVFxSz7B7p2skRFlYIINaRcE9rCr2+Xx1A2aTo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNZkxLkYICDxJMe8QuFoLKgs/YRktdY6Iq/S+wsB2NFMF0Z7Xe
	pN7Mo8pBNYqD/Z4NNPvO7F8nqb1wYq5egobbpniEJ5z89IyusV3xmuHkzIS5g/eMciuI9piC70L
	0BgHcnSqEnxEgjdgruEFD+p5+I9L0PtuUGkS/zpwj
X-Gm-Gg: AR+sD12auBqXsM9DnW+gucDIViaHj5o8c5+AC+EwXvYs2I4i8stlVy85BMK1zF8oSqk
	5c0XLBT7818An9Zhc6/moB6vnlTK9Gs3M4QD3f6ZPhcBjTBl/DNxOXj8A1tqLWIBv7lR8kaJYna
	99Y0BQu6wiqm31gZ6gg7x6nSwxDpefkYA+Jq3shyeds8QNkXPbKc0QcNfZDNm4PVyrx/l8g5CAT
	XwhmM4u9IMIwjgpzHgvwzYD4w2BC/qrV3YQa13+6h/jZUaFAutnvUZ6DJxV7PHtbQ8vF2OBYJ4g
	AVUkCr1Bb3XsFuFSs96M5Vo6K9gd2I1BCLLLGu+FvRRdYKT0WaZDxA7L2dSkfLAhJFTHtZB05fW
	0/KeBBOh6
X-Received: by 2002:a05:620a:7002:b0:91d:6ac3:565a with SMTP id
 af79cd13be357-9310384ea71mr224800485a.12.1784797056679; Thu, 23 Jul 2026
 01:57:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714013940.4068189-4-srikar@linux.ibm.com>
 <20260722100842.602fd5d2@kernel.org> <CANn89i+o3rT6Jnx_6SK2vdmeuHVkZwTJXD++Kua9ZCJb-wVFHg@mail.gmail.com>
 <amHVtLnO7R2snG4L@linux.ibm.com>
In-Reply-To: <amHVtLnO7R2snG4L@linux.ibm.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 23 Jul 2026 10:57:24 +0200
X-Gm-Features: AUfX_mxWlHYNLqiASSsj3rGfpcdsrPcMJJIzd9oToDn-9kvT9hgRQbrZdMm_ISg
Message-ID: <CANn89iLBzPOL=9oRAn-+RJncL+0By80gfvVqVe9RAwY2XJh3yA@mail.gmail.com>
Subject: Re: [PATCH 0/2] net: Use synchronous wakeups selectively
To: Srikar Dronamraju <srikar@linux.ibm.com>
Cc: Jakub Kicinski <kuba@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	netdev@vger.kernel.org, David S Miller <davem@davemloft.net>, 
	Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Dust Li <dust.li@linux.alibaba.com>, 
	D Wythe <alibuda@linux.alibaba.com>, Jon Maloy <jmaloy@redhat.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, linux-sctp@vger.kernel.org, 
	Mahanta Jambigi <mjambigi@linux.ibm.com>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
	Sidraya Jayagond <sidraya@linux.ibm.com>, Simon Horman <horms@kernel.org>, 
	Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>, 
	Wenjia Zhang <wenjia@linux.ibm.com>, Willem de Bruijn <willemb@google.com>, 
	Xin Long <lucien.xin@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 10:50=E2=80=AFAM Srikar Dronamraju <srikar@linux.ib=
m.com> wrote:
>
> * Eric Dumazet <edumazet@google.com> [2026-07-23 05:17:08]:
>
> > On Wed, Jul 22, 2026 at 7:08=E2=80=AFPM Jakub Kicinski <kuba@kernel.org=
> wrote:
> > >
> > > On Tue, 14 Jul 2026 07:09:41 +0530 Srikar Dronamraju wrote:
> > > > The scheduler assumes in several wakeup paths that a task using WF_=
SYNC
> > > > is likely to yield the CPU shortly. However several networking wake=
up
> > > > paths unconditionally use synchronous wakeups even when the waking =
task
> > > > continues execution.
> > >
> > > Somewhat related recent patch:
> > >
> > > https://lore.kernel.org/all/20260708133815.3419465-1-usama.arif@linux=
.dev/
> > >
> > > Maybe other maintainers will chime in, but I'm not convinced
> > > by the heuristics you're adding. The behavior will be workload
> > > specific. The extent of networking involvement should be letting
> > > the scheduler know that we're waking from IO, not leaking scheduler
> > > heuristics into networking.
> > > --
> > > pw-bot: cr
> >
> > In any case, adding code to the fast path in every network system call
> > is undesirable.
>
> Yes, I understand adding code in fast path is undesirable. However as
> mentioned previous reply, we need to differentiate between blocking and
> non-blocking API. Doing unconditional nonblocking, is probably even worse=
.

I suggested that applications choose what they prefer for each socket,
once and for all.
(This can also be a cgroup/BPF setting)

Flipping a socket bit at each recvmsg()/sendmsg() is a bad idea, you
might break old application expectations.
