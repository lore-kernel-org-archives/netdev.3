Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083832C21EF
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 01:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769132057; cv=none; b=kbXTaLI9OrLkqJJdqWtAvdmdtCqvpF0YHznHt7jIKrdWs8q2qp2KOyYzMGAOhKtI1L5T2Hm+p9jPCs9yNhVrrAYQOU7VlvPjyH9l16SUq8may2+uJwLndQRyqq9W2jYR21yU/7xUvdNOUJTm7lt7eccVm2iIZNIG5NA/DcFxqT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769132057; c=relaxed/simple;
	bh=3NUYJCPlBRrrHA8iG6ku0Bn98IXK0/3pgg2s+mYYlVg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GSK1WtYWbP5Z/32jwaPlqOntjuDcivkz4Z60ZLN9BwVE1W7fPNSYMd7431M20cirNjaTdWkcIOKv9nOgK3yBRLbCIeNa+RbeQJZGnX6pTSja6GkfBz0luJMOKXwTzXGu8Rfybclpw8QbKW0SBrlEHeu19hXvMjwQpZLTQdbggug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ouqwo04l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ouqwo04l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D648CC116C6;
	Fri, 23 Jan 2026 01:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769132056;
	bh=3NUYJCPlBRrrHA8iG6ku0Bn98IXK0/3pgg2s+mYYlVg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ouqwo04lbzGVfXOcHn/JF/3g/Uen1cU6yRmn5czfId/UkXzyzCfCO8YS6tZqsWLoR
	 78L7zh0Y/uwkQTyhUUgYc0/acG9/tBhjPJnQfpaXzAADtFzSmBvywsEaL7qB8U1cWb
	 uOUXhdKhzF+3mImuGglMokcS3WgnyGLrWpfuTYLvHS2LXKebi/aratlidvIG78pKU7
	 xtQnC2RBVm8wpxZFz72Z2V5d7oKrWtPzqVfXEYpNPpWwiKYryvGKbbbV/7jJpwKqXq
	 MHtYLmcwThTJ6gP4HWkfUBG5mCvsTZhy2PtGTCRFoK4tDCsCNXfFj/q1xS6ZF94W5/
	 /QAEfZ3WdXJbA==
Date: Thu, 22 Jan 2026 17:34:14 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Willem de Bruijn <willemb@google.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] net: expand NETDEV_RSS_KEY_LEN to 256 bytes
Message-ID: <20260122173414.52ce472f@kernel.org>
In-Reply-To: <willemdebruijn.kernel.166500a9f06b7@gmail.com>
References: <20260122190349.2771064-1-edumazet@google.com>
	<willemdebruijn.kernel.65df45c3b4fe@gmail.com>
	<CANn89iKtX7Omh7qXwt7A1=Q3nQ4VgVOAzWfgNBO-t0xWP7RKpQ@mail.gmail.com>
	<willemdebruijn.kernel.166500a9f06b7@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Jan 2026 16:16:43 -0500 Willem de Bruijn wrote:
> > > Iff respinning it may be informative to explain how drivers intend to
> > > use limits beyond standard Toeplitz. The tunneling that Jakub
> > > mentioned. AFAIK there is no Linux control API to configure the device
> > > RSS block in that way?  
> > 
> > How the NIC does header analysis and RSS computation is up to the NIC vendor.
> > 
> > They provide some knobs, but not a way of using user-defined RSS
> > hashing for some particular encapsulations.
> > 
> > Some NIC use a TCAM, and they do not use the RSS keys in sequence.
> > Say if one 4byte member of the L4 4-tuple starts at offset 130, the
> > NIC will use rss_key[130-xx] :rss_key[133-xx]  
> 
> I see. That is no longer RSS as defined. But that's moot. The point of
> the sysfs interface is to be able to share keys across netdevices for
> consistent behavior. For whatever algorithm it uses.

Perhaps stating the obvious - the first ~52B of the key still have
the well defined semantics. So for normal traffic / non-esoteric field
configuration user can still use the standard calculation. Unless we
bump the limit, however, those NICs can't use netdev_rss_key_fill().
Well, they could copy in just the 52B and then append some extra
entropy after but nobody bothers...
