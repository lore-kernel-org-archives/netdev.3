Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D95748BD20;
	Wed,  3 Jun 2026 19:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780514733; cv=none; b=XDggO3YulYyzpNHhWkRJt6BvifQup3yMC4Hv3R1uzMxywQ8LSW7UET50hK1G98ADpyUZR5OvvE6827/1tW0S3sByglGBC5ALK2ggOO93PlW+3h23PCfMVvayk1SXQ02u/ybL5kl1z17//JL7aCDFA49XAIH/CN2DIZ0BqnuolwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780514733; c=relaxed/simple;
	bh=oZJmKrfVUhKAP2ux7o5/6wjxX2l28Y6F3vWZn+NRC50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kLVaKZj2eguze1oNCNFXQqGPJTvyu6S/X72SJnIziKyFJ+b3IiVC43YulCw465q36Mfu80PO/WBCnLUbRpJ8Cd+E9pQmnMYYTK98Vh7fJaoAk6uPew6k1f1sdYtSXbPl7lkqDDMOszDmT9U6jpDb7EmEBRs2E8q+L4oNkN0Ki7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=JgsngWnz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="JgsngWnz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kckqd65ZT21RVDKYMVhVILlgGIghfO6ggPEv4FUM5wI=; b=JgsngWnz5LCesZF3vXpEyQo0mm
	ynJ3yVl1gVYwGZgug/HhYcEJI42IhfXqj4hQLS3d531WhrA0ggBCFmivmhISiRZXFWjXqH/R0gZj/
	giPKtx3Vr8JSk4jQv99JrkHZbqhhcvhoEYpFJjoHGr4K0BDrxmEAgoxVDHk+GKce4D9U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wUrD4-005voa-2B; Wed, 03 Jun 2026 21:25:02 +0200
Date: Wed, 3 Jun 2026 21:25:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	johannes@sipsolutions.net, corbet@lwn.net,
	skhan@linuxfoundation.org, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next] docs: exclude driver and netdevsim bugs
Message-ID: <a0f191f4-3c09-4919-bc79-0b716d1ecc6f@lunn.ch>
References: <20260603162943.2406080-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603162943.2406080-1-kuba@kernel.org>

> +Additionally, netdev does not consider bugs to be ``net``-worthy
> +if they fulfill **all** of the following criteria:
> + - bug is in a hardware device driver;
> + - bug is either a missing error handling or is part of the error handling flow;
> + - bug was discovered by a static analysis / AI tool;
> + - bug was triggered/observed only with kernel changes or fault injection.
> +Fixes for such bugs should default to ``net-next`` and should **not** contain
> +a Fixes tag. Networking or driver maintainers may redirect such fixes to ``net``
> +at their discretion if they consider the condition to be relevant enough.

I would also stress what the stable rules say:

	It must either fix a real bug that bothers people or ...

Many of the bug fixes we are currently getting don't meet this
criteria, so are net-next material.

   Andrew
