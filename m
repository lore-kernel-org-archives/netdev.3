Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39D93A9D8A
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 06:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780381547; cv=none; b=iINm/wb7VRD4G5kX1Sh9+1rqtP95g4OnUb5E+9cJsWQOeGVGlcXnaREcGvSo+zt89NwiY5ecjXoAUSD/AfKE2v4lz7M1CclJqHSbuZ8QdDdrL8fVENFff3ya1zoT/7UsNnhEUIoVQamz9fxfJZrEuCbynGWUdF+Q6Kog35Bcy04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780381547; c=relaxed/simple;
	bh=CUwnaLkgD3rNarISGJXRHJVairBNTxswrYoxXERGcMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L7Xl1E0kl+3+9HPP3Rre+0H2ZIIi0tfP2zuar/Tg/WZ+ey5+VppXaYu9OKbCeZAkWfMIg+k0E9gbB1HfZmW5dIL5GV5juinkFA6yVM84x31vLSr2ZnQsaQuie+b/9iPQLUNyZuNRAYed5QIf5PCzXfm3BgFIcj3agvH3VjdNCZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OWJjgvw1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XxvOV1z+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OWJjgvw1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XxvOV1z+"
Date: Tue, 2 Jun 2026 08:25:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780381543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NpRoKQWo4tUvZ4Uy1mJqaw1FRck62ay9Y+tEHcAD97o=;
	b=OWJjgvw1hYot/KFJfDtpykcch6ycrKkCec3BRj6UoMDXRFQVcIiR9l/sCA7dD/O6WnI8kD
	LaJeAx03NCbXeNLwhVGdlB01Gfn7sOkOu9knA9rnSPcmKdo8LR+VjKZD6mjTCUs7Qv+t3T
	X/vUE2712q/DtGbYLB72iJoMb84hZhKZkSALkgK/Mv5dS2xjoYMwtvwCP2aF8qUFD+bWIA
	wlnOISTrlCFqSaxeXnIbBkU0whUbhWtVWtmZpZqs35dqyMcpxlqj7Mrbtjv2fQRO7I9sQt
	/DbsNtAk3Y4heNn+ijogjsfLRWEYBKCEdiefBsu70hYGHPHg08TEC3mkSPJhkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780381543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NpRoKQWo4tUvZ4Uy1mJqaw1FRck62ay9Y+tEHcAD97o=;
	b=XxvOV1z+ohKAfIZbpYIuDk1OynvDdPbiXRtE7vLnfuYIVNt8jrkGWLiQbzN0vu/2B/4cJv
	8pjOTJvrfaMB6rAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
	syzbot+e809069bc15f26300526@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 net] tcp: Add preempt_{disable,enable}_nested() in
 reqsk_queue_hash_req().
Message-ID: <20260602062541.YjOI6sV-@linutronix.de>
References: <20260601182101.3183993-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260601182101.3183993-1-kuniyu@google.com>

On 2026-06-01 18:20:55 [+0000], Kuniyuki Iwashima wrote:
> syzbot reported a weird reqsk->rsk_refcnt underflow in
> __inet_csk_reqsk_queue_drop().
=E2=80=A6
> Fixes: d2d6422f8bd1 ("x86: Allow to enable PREEMPT_RT.")
> Reported-by: syzbot+e809069bc15f26300526@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/6a1a7bcf.0a9e871e.332604.000b.GAE@goo=
gle.com/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
> v2: Move preempt_disable_nested() just before mod_timer()
>     to avoid unnecessary latency as much as possible.
>     (tcp_timeout_init() calls SOCK_OPS bpf prog)

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
