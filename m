Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C635449502C
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 22:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788302321; cv=none; b=EZd/3cman14i7VuwpCwX0GYrypyS15jOWeQj6NsLHkPVHS8LURwPEgGVqpHkQRnYjXOf8hdH5cdKDXWpSUItB6X854lVvdOt7UxuV0mw9JwXGJjkXlCNdgfoCR4Ogem+m/ycIyVwm7gQOqYYtZcROXMGttsWy25ljcGKhpFJU3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788302321; c=relaxed/simple;
	bh=Ry/pCSbAg9IFWBqweSINURybPeMFrk6KtXk8s0Xs7Gg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I+C1coXD7yh+zNRMZlm/fDdFHPKcNpWu4YheKjZ46Uzp7D7iacVMgeu5tpQtN+e67BEVolbM/UaEFLe7+fm2YZ3k8DSazUm+vPWValiQmbxhpbeu4LfvFdtjfQB1u/pCyqvYW3G3bVfuY3QrCEfFBIQb/+n1Jez+ZwLi+BDQB8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oBCqchN1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oBCqchN1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39BC91F000E9;
	Tue,  1 Sep 2026 22:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788302317;
	bh=5zrTCXVhWm9k/Yb5xrKQmhPcrd9co2TVKdSxoqXSNFQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=oBCqchN1dlea2oD/2zSwApXLrNCRSlBfNIkTZRRA3XUi52M5p1eiAoZuuw2GpXtVP
	 IlwwuDD+egpw9dl6ZRdxV5HFNwIqNVhfUEetxJEnCZ/Qd2ZpFgKPp1c+4fTyN2ERfp
	 XuncETzLqkmhAylCUb3OxoUIE9Foybn4k6HoKxkoXaplzdgkHM/m9Bpef7LcFd4oxp
	 j5iKwlhP3VWj3JIkLFEVBjw5+Piv5ceTMbRKg6i5NUiMQ8q7i9GgZsPbs5NZnNqVk7
	 fQ4kZmgen9edNqrsRUkwy3HqiTFHfKxvbtUITEfoM6/v0PBr5F1qk8gXUxtwB0tR/A
	 y/HmqRWKTjwLQ==
Date: Tue, 1 Sep 2026 15:38:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <joe@dama.to>
Cc: Linus Walleij <linusw@kernel.org>, Hans Ulli Kroll
 <ulli.kroll@googlemail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?=
 <mirq-linux@rere.qmqm.pl>, netdev@vger.kernel.org
Subject: Re: [PATCH 2/3] net: ethernet: cortina: Count dropped frames as
 NAPI work
Message-ID: <20260901153836.13cce5fb@kernel.org>
In-Reply-To: <apcw3tpNHStCCCc/@devvm20253.cco0.facebook.com>
References: <20260901-gemini-ethernet-fixes-v1-0-ee6b09675876@kernel.org>
	<20260901-gemini-ethernet-fixes-v1-2-ee6b09675876@kernel.org>
	<apcw3tpNHStCCCc/@devvm20253.cco0.facebook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Sep 2026 13:09:02 -0700 Joe Damato wrote:
> > +	if (work_done < budget) {
> >  		napi_gro_flush(napi, false);
> > -		napi_complete_done(napi, received);
> > +		napi_complete_done(napi, work_done);
> >  		gmac_enable_rx_irq(napi->dev, 1);
> >  		++port->rx_napi_exits;
> >  	}  
> 
> Hmm. I could be wrong, but I think the above code could be simplified by
> calling napi_complete_done and letting it do the gro_flush? You can check the
> return value and then optionally enable interrupts. That's what most other
> drivers do, IIRC.

Good suggestion, otherwise exiting busy poll will falsely enable IRQs.
But to be clear that should be separate patch
