Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF73470E99
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 03:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784776642; cv=pass; b=rDbPiffJ5902GtCjm9SNSY7mAhTDMa7Cf8h1VVe3/WT5Y7pk8RlJgJ1410QzAu3bKrF7xzxxAlzEUa2yL3wK4CeXAHyQHFTgLIsEPEKEVkBCOSjxFisCsOfa4g33iY9fFAXcAJotshPfXUb8C2sJKxLg/afGrFJeeAIqhFkOlZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784776642; c=relaxed/simple;
	bh=/19X+XTfIBIuI9fO1VZJyXOTsfu9qbVPKVTHHFi6RYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NzGmg5HfgKx9znwd/fiWYM80AH3NsN/kVn1H6fT1NnMI8MkRyZ3foQLpipxfw6w/rr4h9eEsw3epUEh9XHl46hcbYP6j3kdZv0SnGmdCo6n3vYymFhxBbT9SSaoUmBH6H111V5Adq8Ct2sKHha9DFw3UWFdVIjZXStWnflAGjEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tynLym2r; arc=pass smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tynLym2r"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-92ed3993c1eso10016285a.1
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 20:17:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784776640; cv=none;
        d=google.com; s=arc-20260327;
        b=gYMIzIpNfmbZg0xyITdkY4GYzzyf2fMMz/94RAPntfiFwczNMYjItBxARRUjUgc+uX
         dM6C+nqnHn3h9002VodyATMl7Fba0CtrEOV1+2bjynw7EdfJT2hZeFHJk76Nf7ccVwMe
         SPn+bXQh/0dJupx69Q1w07A76r6K93bDg2dQN7GKj8VaotJnHYWuZ2fiWQOK/8hseaIM
         JGwZ5HPqBr74KQ2/efEwmyMbLhojr5DyqqpGbDncv1h74cOZg82FWW/0NENOjCuqJrv6
         XRApeEi3VzZ4Wdc8K9giqagRd7gQ82LpeS3Lpz7J3h2sEB9ty8CNou8gh4vudmkXcMAC
         f+5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lX/zr1mEWyW9mjUIKmJHBct3N8j18Lej+ugTKOX1vbw=;
        fh=GkEpmcd3njw11WHYfxNi1kzLPF8hCO3HqXy2704SrX4=;
        b=JC6DIakLLAJ64ulgpoc3zbuewqvnGOk9VELbK8FD+FCg1tePmon49xEgMWb7J9zCxQ
         AEZKLBZB5y5wleutaAr2KQnbokqfl/DNWkkbwoykZK0uLu1TO1WXurIgAiBjVINh1ndj
         yhaowZezdA3YmK70fDBfnX4KwYIG5/Re1I2Dr75e6OZUs+NajgF0UvQzxiuIL8DwYE03
         uRqCi1jmpueekkYW94ReW4E6RcI1QRH+OHBfWq9fu9pYICucwyG2EH0GJ5u/t/zBRpE5
         qhasCqrH/OUIVt3v+AjNfMynpMhUOPIBmRi/on6J/ul2Dnm2PZak73tpYpVhfca8M9c7
         fYZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784776640; x=1785381440; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lX/zr1mEWyW9mjUIKmJHBct3N8j18Lej+ugTKOX1vbw=;
        b=tynLym2rXllbv4sr6y9eWYtwW1m9/fi+fja+83UuQ+DjVDq9ulHX7Sy1I617dZYBbX
         rcdDT5qWfkycs+3pjO4hJrFRl8WkCyC9V0VhQfmiPtTqi+S9owRO3w5aHhm7v6N4BQW/
         sNZBckt9zdn68zvVglnuaheTn+oFOuXBuvIaco6CnPDR4YwdQFFwiCU5FXBSibtDD1L6
         T9mLWro+ex5Fz20AUxrGGORWPpMpGfjDbYKni9T7fFGxqlm0IHnn2wLdBtT/mZar7hZO
         0+Louh3yWffe15EECH0shU505jcHtdaW7yZMYkcdLLUqqUPetnsncxp4803YxLnkmJli
         4XTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784776640; x=1785381440;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lX/zr1mEWyW9mjUIKmJHBct3N8j18Lej+ugTKOX1vbw=;
        b=m6iMfyyyMqzxNFMxJuKu62BRsh6qjugyFr4YqiPGFCGmF0ddsRXtC5bdcO9Ovx4J4F
         nW1QUhYMzZZBzBZ5c/WvRu6sFH0F17SGFU7XNbJaOFmec/uHqUlNenkQcxfkHfS/k+1m
         Y4ob3cA7OdKfD9fC5/Ve8XUNK1YbjE/3PsPTcrJayO/c5J078SbquDGQm4a3EOPVYLwJ
         SvW3PIvBD0Ch2QjkUOs1FDNUMlFZyfdAghARO6auIdrjLNuHQT/37wz6f1VMV8IV0tKt
         WExKd7OO83qSZv8SCiEZq1JjNz80mpcYRAK0bQodsFeUwWNZPkbIir89RD4VdkoIRQPm
         yc1g==
X-Forwarded-Encrypted: i=1; AHgh+Rqn78gbeEF8xzRcUzTBz2TXVriUwDXCpZJAczyqKPxQbXZOGR9HGXYfE0RehgAjWcf6kvPHDFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOpfxGcMTavhHOlYxMAi3edyFGGE8oj8RY2gEQ9XD58okKPw8Q
	pG56qKp2P7pPk14ZlCWPXvdOrHDj8eprqn9r+y+D2jLgTlAc3uKwJUbv3Opls/bo8FY2KrfFlKh
	i1Yw0V18ZrGVGfpmHPocSKUy6S0yK3bP5Yg2DTPW6qBmtVl2FP4S/hf2G
X-Gm-Gg: AR+sD11pLMMzm+AFSC1rTpj2pLKI5nsUJQroui/Dot75OOdgTV2/AnVc+4KZWgu3n4k
	fqM3WQuYmoVEpWKWMczmSkL/S+7r+9kYk/Miwihc/X0S32mTk7BiC/p/e6d+QfeslNAMgv9pnQE
	+bHpRas5iPJtUs9HAqlffvIyiy4D13bjpf19RC5KJyk4l0MIo3l+dKuksNBHi3VUDuUGJfTFuC2
	bd8ucAxdAJI9OWkjnj0yjjWRCcGIO847nmbBqjfXRExkPQu5ZWbhR3cDq/3if50d9yYcd16sXQT
	JM6AO9U7JYrBA/ZZGAEqacRagWU1UYiL9iYaPQcBDpRJaVjrNoQVbFiWRDwlmL8MRyJCzVw=
X-Received: by 2002:a05:620a:6310:10b0:92e:6338:cedb with SMTP id
 af79cd13be357-93103728115mr110555685a.73.1784776639229; Wed, 22 Jul 2026
 20:17:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714013940.4068189-4-srikar@linux.ibm.com> <20260722100842.602fd5d2@kernel.org>
In-Reply-To: <20260722100842.602fd5d2@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 23 Jul 2026 05:17:08 +0200
X-Gm-Features: AUfX_mzXeD6cj2fqrkt8d5aPZRvpbpGrPEZnPgET9lecz9ToCyfFIPgNk-oFujE
Message-ID: <CANn89i+o3rT6Jnx_6SK2vdmeuHVkZwTJXD++Kua9ZCJb-wVFHg@mail.gmail.com>
Subject: Re: [PATCH 0/2] net: Use synchronous wakeups selectively
To: Jakub Kicinski <kuba@kernel.org>
Cc: Srikar Dronamraju <srikar@linux.ibm.com>, LKML <linux-kernel@vger.kernel.org>, 
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

On Wed, Jul 22, 2026 at 7:08=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 14 Jul 2026 07:09:41 +0530 Srikar Dronamraju wrote:
> > The scheduler assumes in several wakeup paths that a task using WF_SYNC
> > is likely to yield the CPU shortly. However several networking wakeup
> > paths unconditionally use synchronous wakeups even when the waking task
> > continues execution.
> >
> > During wakeup, with WF_SYNC flag set, because of the assumption that
> > current thread is ready to give up, the wakee thread will be migrated
> > from any core within the chip to the current LLC. If these operations
> > are frequent, and wakers are actually not going away, then it will lead
> > to load imbalance and hurt performance. This is especially true in
> > architectures where LLCs are small and number of LLCs per chip are more=
.
> >
> > Running vllm workload was run on Power10 system
> >                                   No patch      with patch %diff
> > Inference Time (sec)              17.84         16.35     -8.35%
> > llm query bandwidth (tokens/sec)  14.78         16.21     +9.68%
> >
> > Lower inference time and higher tokens/sec is better.
>
> Somewhat related recent patch:
>
> https://lore.kernel.org/all/20260708133815.3419465-1-usama.arif@linux.dev=
/
>
> Maybe other maintainers will chime in, but I'm not convinced
> by the heuristics you're adding. The behavior will be workload
> specific. The extent of networking involvement should be letting
> the scheduler know that we're waking from IO, not leaking scheduler
> heuristics into networking.
> --
> pw-bot: cr

In any case, adding code to the fast path in every network system call
is undesirable.
