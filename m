Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E3D3AFB01
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 10:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785235474; cv=none; b=uUxjHRti71vquGI4nRgC0+qFnSd1fF932sxfnmjCJAXm9HT5uQrlYHsMjMF4FoTSb3+tdplv6gNbW1c6Hc5atOWo1HMMWYrfCQE5QrYRBNBnu4YP3TUlo/Xrdwf1pMhiA/U2XDSeUHTUiwqqGkXbA0Bbmf5YybtJWMmLJ+tEuhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785235474; c=relaxed/simple;
	bh=kcNCOS+c8E4KdCDg+ZMZWO/Nq4A6FnaaUNoJswi02l0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Mis7dOahtb4c5WKrY+5XYBnrC6eKRlbjqpzhvdtJLynfAObRxhAKAp7uk6ylcInJX6Qr3JlLFWEGO/FsrgQGTV5k4Sy4r8c6NhTGDSo5nL1rQ+UENhVElGVmJAp5j7/8ZdVJCwJL8da5e2eT+DXTHaYh8aIyEbw7s0YjdaNwScc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: mail.toke.dk; dkim=none
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
To: Ren Wei <enjou1224z@gmail.com>, cake@lists.bufferbloat.net,
 netdev@vger.kernel.org
Cc: jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org, vega@nebusec.ai,
 zhilinz@nebusec.ai, enjou1224z@gmail.com
Subject: Re: [PATCH net 1/1] net/sched: sch_cake: validate 6in4 inner headers
In-Reply-To: <502a543e7f04d14a15a0f6cecab30dbdf77033d1.1784855599.git.zhilinz@nebusec.ai>
References: <cover.1784855599.git.zhilinz@nebusec.ai>
 <502a543e7f04d14a15a0f6cecab30dbdf77033d1.1784855599.git.zhilinz@nebusec.ai>
Date: Tue, 28 Jul 2026 12:44:16 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <875x1zwfzz.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

> A malformed packet can therefore use an inner header with a non-IPv6
> version while still setting the byte used as nexthdr to TCP. When two
> packets from the same queued flow reach cake_ack_filter(), the version
> dispatch can fall through to WARN_ON(1), which becomes a denial of
> service on kernels with panic_on_warn enabled.

Hmm, I seem to recall a policy that says we don't care about
panic_on_warn-induced crashes? What say the maintainers?

That being said, I am not sure an unconditional WARN_ON really serves
any purpose here? As you've shown, this will most likely just be caused
by malformed packets.

So rather than add all these new checks, how about we just get rid of
the WARN_ON?

-Toke
