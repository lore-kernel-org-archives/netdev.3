Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4831395AF6
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 15:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784646762; cv=none; b=GoWquQtBJgRFoxtTPf2IBk2uB7smdgAqYHWf5We5OCUsYdLspasWsmruaOgKP/wlnBZN5YffPZDbUWZb5WXn0h/j3h00e85S8VUORZbDB/NRM++3I2ok3Ihr/qY/CVl6dGU4XHMTX7xPDg3Sh/W9El0m/2o+0BAF47duhTn0h1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784646762; c=relaxed/simple;
	bh=K+Fn/zS+yilIxwqRj4xxL03genFT4FwfCOTQvQKYjQo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rCyxtqGN+OGSUgzgQ4iljD+Bq9ySsLNLavmRZt2SP6RiWX6Uj+Wpz2MfCAy0sXAQcLo/5mA2/IaVoZePDKzShBApYcGlQDeEJNHK7iKDsw9oob3lpo4NNEALA6brTKQdpzaIa3EuTLS74Bk+Muz4JY3SDBQBiFaUQUkUVGtvFvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zta5yEPX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zta5yEPX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F3571F00A3D;
	Tue, 21 Jul 2026 15:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784646761;
	bh=TIAUQwc98Z9ARw9IDAG2umdiqvpOuJyHvbfgbIxRls0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Zta5yEPXc3GSz0gTgFXXcKL783EwKkRjTJaTHkdFUF14vsWKOD7yOBHqUeEoOVMFd
	 UYmsUSWz+xAuN5yl2r9hl350MCKodurztzlUHgQ3nwyj2Kq2jb+Xl9oQs2FdHCTed9
	 AAjkcguGYvr73kAGOdgyWNruM3YeKPe0vPwoYU9dZvbp5q0/4zh48JCIAsrDG+ej9b
	 uy57EMFp+IZfQris7hZ6eNK6F7f5XVlTdK2pLGLXOXyieNO3rmYNYYh0oyydsjMCGK
	 pRDLxvqLmUi9AkH0TjdcMtkUsZ4KoOgypKNLYT5vd2UHhxW3oMcD8WU3s7O/+oRCtN
	 +FLRRxzTbkW0g==
Date: Tue, 21 Jul 2026 08:12:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>, netdev@vger.kernel.org,
 edumazet@google.com, ncardwell@google.com, kuniyu@google.com,
 davem@davemloft.net
Subject: Re: [PATCH net-next] net/tcp: Prevent inlining
 tcp_syn_ack_timeout()
Message-ID: <20260721081240.1b88db50@kernel.org>
In-Reply-To: <6c01c713-14a8-43c2-aaaf-2fcf622f7e4f@redhat.com>
References: <20260708180837.9507-1-emil@etsalapatis.com>
	<6c01c713-14a8-43c2-aaaf-2fcf622f7e4f@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Jul 2026 15:24:52 +0200 Paolo Abeni wrote:
> On 7/8/26 8:08 PM, Emil Tsalapatis wrote:
> > The tcp_syn_ack_timeout() function gets inlined by Clang,
> > preventing tracing. Since the call is not in the fast
> > path, prevent it from being inlined.
> > 
> > Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> > ---
> >  net/ipv4/tcp_timer.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
> > index bf171b5e1eb3..f7215d53bbda 100644
> > --- a/net/ipv4/tcp_timer.c
> > +++ b/net/ipv4/tcp_timer.c
> > @@ -748,7 +748,7 @@ static void tcp_write_timer(struct timer_list *t)
> >  	sock_put(sk);
> >  }
> >  
> > -void tcp_syn_ack_timeout(const struct request_sock *req)
> > +noinline_for_tracing void tcp_syn_ack_timeout(const struct request_sock *req)
> >  {
> >  	struct net *net = read_pnet(&inet_rsk(req)->ireq_net);
> >    
> 
> What's the point of tracing such function? It just increment a mib. If
> you want to discriminate between TFO and non TFO syn ack timeout,
> possibly adding another MIB counter and incrementing it in
> tcp_fastopen_synack_timer() would be better???

FWIW we seem to capture the 5 tuple when it happens, not just mib
counter. Internal commit (form 2019) just says we want to know when 
syn-ack is blackholed, unclear under what conditions this happens.
