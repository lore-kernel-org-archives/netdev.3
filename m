Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69E33F413D;
	Thu, 18 Jun 2026 15:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781795085; cv=none; b=GKgJYBUck4ANHiv2/kPqcJQeuCJ55WRu7pDsBE47N5hJATo/4ZEYdi+pgN/tTURX42B6mxB2WykV8Hix4duv9NGaHGrb5CqroEmx1sleKKZX8Vo5pxDZ9NGBiTOzqXnFkmy0JfFMoXEOcHzlcWjkkSyPPYuXr4xj9eUp+BiyCWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781795085; c=relaxed/simple;
	bh=eht5A27flNYH8LC7yP1gAdHF8+i1+qONiH/qebsPSwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h+NdaMmAVVxCp+5UMfeesspBwD7fAAjR3D2H1yULRaermU/Q9iikTA4jkTPOkTPtZEqndrJII8BkVL3NtAAALMe9PgBzepLFif02g/fKNBapXv+4WyDXQMOQe1AFFWJVcMoOKcVs9hXf1Ih+FXDyy7TOtMqN8FqLtVhU4TIhMn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sFNDf5Hm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EgX+buRF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sFNDf5Hm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EgX+buRF"
Date: Thu, 18 Jun 2026 17:04:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1781795081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TtzwdMwL964Lb3xG1jhFx51fMmCfM4SGQ9WL7Sc1jI8=;
	b=sFNDf5HmwIsU8cP/9NCjqMXHxPuL+emJ2zLQ/uftIhqgHHR4Gr1vpgUNApB9FFHM9bi/OS
	dqKYz4FZxNvrJJrtcl2HaZBnxBoNIFUo3lyGHkLU/bCZBvubwLZ6+Vkv4dhUDpOzTD6R4x
	OxW1ixyFdnH99eoASy9HoA1ixhxbr0pS7StTWF+cfGfveCLXJhrCce/E2B2PhbKXvU8TQe
	FMQuisAIAgMpf/R21SO4Fa+raZQ8fgG8LRFjKAhFEr4zveWnpbv+W0Jmwmx8PA0U9R1Z/s
	WykDcpYD86tx/NGL/8V+H4qtp/+TcOQ4be9+10X+9AIGF00pvFt3IPPYlvmZGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1781795081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TtzwdMwL964Lb3xG1jhFx51fMmCfM4SGQ9WL7Sc1jI8=;
	b=EgX+buRFLE5tfRsXz0Rg7NfDdY/I1P7WBQFQO/A1BGYli6dXmyFJ0kOcSs5GCD0XwNkSdw
	8RvXmfHgZfcMiFBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Zhou, Yun" <yun.zhou@windriver.com>
Cc: marcin.s.wojtas@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] net: mvneta: re-enable percpu interrupt on resume
Message-ID: <20260618150440.cLDwgyDM@linutronix.de>
References: <20260618104351.3456161-1-yun.zhou@windriver.com>
 <20260618125128.h5g-StPH@linutronix.de>
 <06d0158e-bf4c-4ad1-8ad3-c8176003ab11@windriver.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <06d0158e-bf4c-4ad1-8ad3-c8176003ab11@windriver.com>

On 2026-06-18 21:56:12 [+0800], Zhou, Yun wrote:
>=20
> > But if the thread is idle then you have one enable too many, don't you?
> > Well you have the NAPI callback which does disable on the local CPU and
> > this resume which enables it on every CPU. So this does not look right.
> >=20
>=20
> The enable in resume is intentionally unconditional and idempotent
> (writing MPIC_INT_CLEAR_MASK on an already unmasked IRQ is a no-op).
>=20
> > The interesting question is what happens to the enable_percpu_irq() from
> > the mvneta_poll(). Is it lost? And if so, how/ why?
> >=20
>=20
> The enable_percpu_irq() from mvneta_poll is not "lost" =E2=80=94 it never
> gets a chance to execute. The sequence is:
>=20
> 1. mvneta_percpu_isr: disable_percpu_irq() + napi_schedule()
> 2. PM freezes kthreads (on PREEMPT_RT, softirq runs in kthread)

But napi_schedule() runs in ksoftird, doesn't it? The per-CPU IRQs are
not threaded. That does not look optimal.

> 3. NAPI poll cannot run =E2=86=92 enable_percpu_irq() is never called
> 4. mvneta_stop_dev =E2=86=92 napi_disable(): cancels the scheduled poll
>     but does NOT execute the completion path (no enable_percpu_irq)

napi_schedule() sets NAPIF_STATE_SCHED.
napi_disable() sets NAPI_STATE_DISABLE and waits until NAPIF_STATE_SCHED
is cleared. So if NAPIF_STATE_SCHED was set then enable_percpu_irq()
will be invoked unless it leaves somewhere early.
However, if DISABLED was already set then it disables the IRQ source but
does not schedule NAPI. This is probably what happens.

> 5. Resume =E2=86=92 napi_enable(): resets NAPI state but MPIC stays masked
>=20
> The unconditional enable in resume covers this case. When NAPI was
> idle at suspend time, the extra enable is harmless.

There is no desc::depth counting here, that got me confused. But that
per-CPU irq is not optimal. Is this a SoC limitation or a design choice?
Having a NAPI instance with IRQ per queue and those configured and
spread among CPUs should cause less trouble and is what others do.
In fact is the only net driver using per-CPU interrupts.

> BR,
> Yun

Sebastian
