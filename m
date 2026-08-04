Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B0D3EDAC9
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 22:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785881670; cv=none; b=u/Mxz8DlsRFJgq9RYYJ5epzL4N6MSiaY13ilnfAGo9KeG4ZQ9ZO7EltCWW8ifZ6zRGey8ODXnyB8HFktFuc2hD083PtTuQefYZspi2q/mP2PAH+j2XI9syKIy/bIww67rQJkHg+/IHJm/Dhm8QCI5k87NhrfTZV6NbXhW+V7SK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785881670; c=relaxed/simple;
	bh=d/6I5mE7wKZ54JY8JigfzcP9itrXBO+fVDjh4g4MUa0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l2H8B4QLoI0Ities4Ha6n24Nn+QktXBHmInMQRUiTg0jTtsstwfHqnUD8NAfEePQTnVuBGDKUy3VpYuQHSDWG1o6etaV6UmA1TYAJlNyabJehFPW9CvDdujF7c6McbRZuM9VZMIJNhWaJhRHq3DP7akwleXyn7hq5YiClhAS+04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OzxZO806; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OzxZO806"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9D471F000E9;
	Tue,  4 Aug 2026 22:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785881669;
	bh=Ktqovc+lxDsREFegvleHGmLzqwtF/O4V72Ce1vxAsas=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OzxZO806s/U8yG1THKDeyEokGM53o3vTecIFgqApjZdYCioHn9j8DBHdRWllTFwHm
	 U3RTLEUwWyp19FjdMqsXWKwVMXh89UjytFvz55wxtIJz0ERnNBx9BGQ5pLQHc/diiF
	 2MqhcEbUtsVz4sVeSMJkxYlkzI3XY/ymkKrXUT/KkzHJE527Neh4YQGTec/ngadX2A
	 b2IJ8mRB5KIAAj/x0CyQfPBUeSZZJA2fN8nKUSl4BimBa7aLsxFtu9Ahr35CxaVgpR
	 DjokoIg/bX0n146uH3vHydbs2lbtwrN8ufTvUR56urzsA4M5fVXv6ZWWqAXCUJTC0Y
	 dRHgjqV1/+CxA==
Date: Tue, 4 Aug 2026 15:14:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Sven Eckelmann <sven@narfation.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Simon Horman
 <horms@kernel.org>, b.a.t.m.a.n@lists.open-mesh.org, Simon Wunderlich
 <sw@simonwunderlich.de>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 00/15] pull request for net-next: batman-adv
 2026-07-28
Message-ID: <20260804151427.48602ee8@kernel.org>
In-Reply-To: <dbd0dc17-d097-4254-b6f0-59eeb6e69579@redhat.com>
References: <20260728133918.643267-1-sw@simonwunderlich.de>
	<5248054.31r3eYUQgx@sven-desktop>
	<37153ad1-5c96-49fc-adee-2a7678414428@redhat.com>
	<4072288.fW5hKsROvD@sven-l14>
	<dbd0dc17-d097-4254-b6f0-59eeb6e69579@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Aug 2026 20:32:21 +0200 Paolo Abeni wrote:
> > Sorry, I am lost. There is stuff for which people have actual PoC code. Afaik, 
> > nothing for an RCE but enough to locally be a minor annoyance. The things 
> > which have no "Reported-by" are things which I have problems with on my 
> > installations.
> > 
> > And about the others: The "bla: avoid CRC corruption due to parallel claim 
> > add" + "prevent CRC corruptions after claim flush" were a problems I had (next 
> > to another which was not yet posted to netdev) but has a "Reported-by: 
> > Sashiko" because it was also reported by Sashiko when posting other bla 
> > patches and I think I've stolen the example from the commit message partially 
> > from the Sashiko report.  
> 
> I'm sorry this is getting more complicated than really intended. The
> rule of thumb is that real problems actually bothering users go into the
> 'net' tree, and other stuff goes into net-next without the fixes tag.

My rule of thumb is "there is no such thing as 'worth backporting but
not worth net'". People tend to send to -next fixes they didn't bother
testing.
