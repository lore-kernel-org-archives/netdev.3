Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C445E42464A;
	Thu, 16 Jul 2026 13:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784208282; cv=none; b=maxHJozNpOM0RagCFWcSh69qm5B2VKSveI551HYINRNrvMnRQGtESQfBLwcC8TepuRM2O+Zi7rfuD2jGtt5rTCa3l/EJh139U9uFJKycl/Y4xy2pLdOklnYRk4wp+3GKDlteLs51/j8NiCW/TYqis8b9cgMGZFBi/T6tcH5cgkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784208282; c=relaxed/simple;
	bh=a3XQInlL9iMip60IWIabzRlyneU4Wvag7baOmJzgooQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QIBXlgc8224t3qo1MpuS2VwBMaUbkmEJSkU2ATi1YLh3a8+jCZd/1GSxxEA+v4P5q/ZFKWhFGfJQpbc586Y6y+hqoKX54Q08LQNg8EqUgYsKkkEEXd8tPezk/pCHSzpfwWE0JrpaLmSt+nAr691wlOD8MdTbwW2iuUmigihKgxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4R9u8Gfn; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4R9u8Gfn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=UVUGeWKcjuvu2VddxwH1NYIYreCDdp4kMDYJKf4bfDY=; b=4R9u8Gfne2Dr6gxFsUV4tcRpZH
	T68gBp0uPzLU6/wvy2Pk8SN1K8nj0g5XMC/zuul3ywgaNOHu+lawbnEzsXQGYYNrkkXpiKYTCsKp6
	MqWAMQ+mNaqEuu7jQlepXs+9RHw/LOySAKqmELzLsJmrmzY7atmwIL0PitDPVIgnXZfw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wkM4c-00CXBM-MC; Thu, 16 Jul 2026 15:24:22 +0200
Date: Thu, 16 Jul 2026 15:24:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Dan Carpenter <error27@gmail.com>, netdev@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	MD Danish Anwar <danishanwar@ti.com>,
	Michael Grzeschik <mgr@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Yibo Dong <dong100@mucse.com>, LKML <linux-kernel@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: net: rnpgbe: Pass an expression directly in rnpgbe_rm_adapter()
Message-ID: <062f9181-e494-4576-bedb-36de488c11ca@lunn.ch>
References: <7958e26e-a4f9-48ee-8d79-3797016944c5@web.de>
 <alScHkiC3EmGzOlI@stanley.mountain>
 <8110bb3f-70d9-4f0f-82f2-ffe1262b2962@web.de>
 <aleFN4Z2XT3NP3od@monoceros>
 <85ad473e-b2f5-4458-8973-a643f90eda5e@web.de>
 <alikx3W3NX7r9o99@stanley.mountain>
 <95abcefe-2211-4abb-9af2-7e8d7f4a9b76@web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95abcefe-2211-4abb-9af2-7e8d7f4a9b76@web.de>

On Thu, Jul 16, 2026 at 11:48:43AM +0200, Markus Elfring wrote:
> > In C writing if (!p) and if (p == NULL) are always equivalent but weirdly
> > the NULL doesn't have to zero.  It's part of the C FAQ.
> > https://c-faq.com/null/machexamp.html It's just a bit of fun trivia that
> > doesn't really matter unless you have a time machine.  Even if you invented
> > a time machine, the code here would still be fine because we have a NULL
> > test before dereferencing the results of our pointer math.
> Which expression evaluations would you interpret as pointer dereferences finally?
> https://c-faq.com/sx1/

This is all interesting, but nobody has yet explain how this function
can be called such that we have a NULL pointer.

    Andrew
