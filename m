Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C5D22068A
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 23:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745625333; cv=none; b=H9LV1D7m1KzR8t3dLLAkWWH4PXl7oW3GIG78m6Sz6r39UiFOyhr9hHLIB0sxZk34vBlKPa65tfQ85/Dmp7DsW7Pai35u5UnyIuELoP2Jl4yK2jVfFtlGYKYvcl3pQa0y2C6lyaBo73rLSxX52G6QyzZg/615xUWvTGc2feuQ2W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745625333; c=relaxed/simple;
	bh=781WOoJagzyv7h2jmmqmvDHBmAYphoXcBb1b49E31AU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Aluyt3w/FA4EYYNPWLfMRa0RfEYFVbIafdoDVrn7m+uaqVWFFjQnULoZUSAfJNKcx/Jrtg3koYa1MnO0Hqb4wbv+mhcYPeMBB3cFAOC16Fx25E3R5AZBoGZnMu/mRT+rdxvlNDb1PPQ83fPY+aJH162J10NSXDct8xgCknQiIBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uOegJ4Hj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uOegJ4Hj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C58FC4CEE4;
	Fri, 25 Apr 2025 23:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745625332;
	bh=781WOoJagzyv7h2jmmqmvDHBmAYphoXcBb1b49E31AU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uOegJ4Hjr977EYyPoMO3tjoeRXr9EpkuwV6bsJZumwPQwY+pG0rYZcney00OsQFLm
	 IjoBd7gurQW9MrQ8IfYqn8DNewSvhyiTqCfJyg7Uc6/t87mQ4vQmxOLr0fDrzKAuXz
	 2xQmsb8HN/Y0ff3Kqr6DOii8NCLFHG0VMhR4PhNKINSyJHEaulWUcLipc4s2C2QAup
	 rKwSbucpJCYkxvNTw14lpQjxHqYXbyXbAVsfODXw7KLVOgW4q3lB6u6oPy1rOmP6+Q
	 aZw90h/nvmsOMSOozcjOQZH6d1CDgQo8roaWj5CoDCfaM9KMdYJv+mTE+lFzxWvXWH
	 cXrJE6WCwH6YA==
Date: Fri, 25 Apr 2025 16:55:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, sdf@fomichev.me, dw@davidwei.uk,
 asml.silence@gmail.com, ap420073@gmail.com, jdamato@fastly.com,
 dtatulea@nvidia.com, michael.chan@broadcom.com
Subject: Re: [RFC net-next 00/22] net: per-queue rx-buf-len configuration
Message-ID: <20250425165531.7926490d@kernel.org>
In-Reply-To: <CAHS8izMYF__OsryoH6wyvv8wf57RHWHH8i4z8AggYZVvNqH2TQ@mail.gmail.com>
References: <20250421222827.283737-1-kuba@kernel.org>
	<CAHS8izMYF__OsryoH6wyvv8wf57RHWHH8i4z8AggYZVvNqH2TQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 23 Apr 2025 13:02:52 -0700 Mina Almasry wrote:
> On Mon, Apr 21, 2025 at 3:28=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> > Add support for per-queue rx-buf-len configuration.
> >
> > I'm sending this as RFC because I'd like to ponder the uAPI side
> > a little longer but it's good enough for people to work on
> > the memory provider side and support in other drivers.
> > =20
>=20
> May be silly question, but I assume opting into this is optional for
> queue API drivers? Or do you need GVE to implement dependencies of
> this very soon otherwise it's blocking your work?

Completely optional, I think it has to be.

> I think it needs to be the former. Memory providers will have wildly
> differing restrictions in regards to size. I think already the dmabuf
> mp can allocate any byte size net_iov. I think the io_uring mp can
> allocate any multiple of PAGE_SIZE net_iov. MPs communicating their
> restrictions over a uniform interface with the driver seems difficult
> to define. Better for the driver to ask the pp/mp what it wants, and
> the mp can complain if it doesn't support it.
>=20
> Also this mirrors what we do today with page_pool_params.order arg
> IIRC. You probably want to piggy back off that or rework it.

Yup. I added the rx-buf-len-max size reporting because I suspect
applications will need to discover the NIC capabilities.
