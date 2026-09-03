Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607823630BF
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 23:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788477961; cv=none; b=C/iDW1lh+U4NjtimM5HeTBk5QI4t7zvZkwKlo6auH9YhBl8zks1Pq5o0GI3q6FxOcR3Y6Jx7jm1j9nX1W65vU4dEqs2aBuC4IqriagoVuJ2TKfgYdWNBwNLqx/pjDcKKLo2utLcSJXlOIGa7Ip0NtT6bo1fBekkAiP/816bb5lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788477961; c=relaxed/simple;
	bh=oDKXyVyWsb2G5zLa/FRwpUE97dJ2/SCPP38RHeWltzU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EPowMNF/IBrG0eRgy8osJ6EFC6aW3v8IqK302WzFJ46mHD5RBIeqixHnGeTcYRfgZ8i+HcG9fW6yxs1PPvRgfNn6LPSjo2mdQmrUOiD2ni2MexOmfmGW0RyGsIhHu856jsauKcWD9Ons+El4AtjUYQHZx4AS/8d9NvEYBUNjQnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KqAB+jW4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KqAB+jW4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 526ED1F000E9;
	Thu,  3 Sep 2026 23:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788477959;
	bh=EIHDkLIlWv8dC8AntA5JVQgeAcHvFlAslv/XDaxPTPI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KqAB+jW43Ok7vli8pgIy+nVe5ry10H8KxmZcXIRi2paGbb4bmL5F7MzX1HxsJqhUj
	 9u7YgX+bSuDPhO7GKNnLndY/ONLfW40SjuL+6MDkC4yHmUsoPtCgYXcYmCwrloG/l/
	 YSWnCqi20Qac8RsrEtpdIi7oDY2M/klMCxIJP4xlBCmnQj3C1XmOmsMsRciOKEYd/h
	 rJkumR/DCV9O2M+eO/Nq/kCLLmn/0MDC5npit6CY7WqjaF0uJLh5Szi+UASsx9NJFi
	 K+j93D3iAo32NtpG92iO90jFSB+nfhMUgIz5pYRZ3Qtuy60XoOgJCaMBi8J2W5NU07
	 GiZlc6jRfDpDw==
Date: Thu, 3 Sep 2026 16:25:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Alexander Lobakin <aleksander.lobakin@intel.com>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org, Madhur Agrawal <madhur.agrawal@airoha.com>
Subject: Re: [PATCH net-next v5] net: airoha: add HW GRO offload support
Message-ID: <20260903162558.2679c1d1@kernel.org>
In-Reply-To: <apmWLtgcUXRrOTFj@lore-desk>
References: <20260831-airoha-eth-lro-v5-1-6b0f50401121@kernel.org>
	<fce0ee5a-476a-4867-9dd2-08e55993bd90@redhat.com>
	<aplpllPidmCjhSmA@lore-desk>
	<1ef90408-99b6-42fb-a7c6-7e5bca20c46d@redhat.com>
	<apmWLtgcUXRrOTFj@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 3 Sep 2026 17:45:50 +0200 Lorenzo Bianconi wrote:
> > Lacking more details from the vendor, I think you need to use a
> > pktdrill-like sender, explicitly sets the segment lengths to some not
> > mergeable (like, i.e. 200-300-400) but otherwise fitting a GRO packet
> > (i.e. same hdr except for the sequence number and push flag allowed only
> > in the last packet), ensure that the aggregation timeout lasts long
> > enough to receive all of them, and check if the engine really aggregates
> > them or not.  
> 
> I think in the example you pointed out (length 200,300,400) the hw engine will
> create a single TCP packet composed by 3 segments (with gso_size = 300) while
> sw GRO will just push sigle skbs. I agree this is just a GRO approximation.
> If it is not enough I am fine to switch back to LRO implementation.

FWIW the gro.py test covers that and many more cases..
