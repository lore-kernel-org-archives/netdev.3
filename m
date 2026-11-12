Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794498326;
	b=yPQ1sNs1Bz5EePsy7nFnCf/ChYdYjho/CXl2fKLPpV28UE4B/zjh0GCUyjRpuuP/RLsI
	 bqiADud0z7a+iZckwYI1DRW8bjU8AVXl9q/pCklO+gwG/gox6QO7H2wgKtPUKQrapCyyg
	 hZB+VFFvpdsg+qilt/VdZYQ9Odjfe08VFgzhB7lE2OSELHiJBY62vnERupqLQeEncMIwL
	 SCePHErdAb8IDPrd2/yUlI+8vyqO1jtWQMDp2fTWT6MPeV6jGCe9bys1YIfgMS3jiBenK
	 7++WLndg1qLDHsKpqkwIBXI/bgY8ad2xSynHAYlYxpk6xlNGZTW3P78abGWG5LH+dXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794498326;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Debian-User;
	bh=mG5gDx/67UU3AgmMdJmswI/2okj0+XAvB5F0Goll0v4=;
	b=afCcAA8SE9JrGaUUFXDw6Ypalt/cYViL33eSvWqByV8CkizRg3ySVjW+Ro81QCHHw+Mj
	 +BkazaXwXPSq5ohrjWs+OoG7SelWeWc0KLyDMGmAal4Hkn9M9VIt0M89xCK1YZSWhw1NM
	 i8AYtNEv3eEMu2uU9s2mPgz2qXQJsF05FoxXsne4qbGisFo+V5pCk+H8eBVtFvv9Vgq5s
	 Mf0jCTR+KBKlDqx6RFbf1wPSqVKlXbQhP/EhTe/BiPamlownb3ItDLkJb7Tc4du3lTwCj
	 DQ85NWXXxEA4ZYjDAKYxrIy4ZugpzYQ45mycnHygX961NJOWXNte8MKpsdbsgMwAwNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b="NH4IESy/";
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2726F606A321;
	Thu, 12 Nov 2026 15:45:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2726F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=NH4IESy/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mG5gDx/67UU3AgmMdJmswI/2okj0+XAvB5F0Goll0v4=; b=NH4IESy/nIyn6a1iPbOdqiVHv9
	n/qNen9EyzPvEnABOMZzYpFv95DadCxORW/DKmTdM8FqFmLbAdjL6hetDSahh+7l0i6LBJgeyG/fY
	f1UpH0+LwW9lXgQxKltm0HhxbKvoX5o14Ry7CUWLX0J9JIAREmingQOBwWhbG6Gri3js9r9C1uQwe
	MMDkNiJwxZOmSolOs9gZHZ2X+adFZfdv+hLaxBfVVCFSYulvIM+Nch/3hE7AkC9qwdRa7s4RjfCxM
	QnOYHfbZTuIvKn9+iP/w210lYiTuerI5vtcpI2nvyrgsluhzJYx1jUIInshrrP94yX9w8KLlaV1K7
	x6FdAEjQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xRWzF-00E4iO-2Q;
	Thu, 12 Nov 2026 15:45:17 +0000
Date: Thu, 12 Nov 2026 07:45:13 -0800
From: Breno Leitao <leitao@debian.org>
To: Gustavo Luiz Duarte <gustavold@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH net] netconsole: harden the enablement through configfs.
Message-ID: <avXe0feXzRL33bzs@gmail.com>
References: <20261112-netcons_double_cleanup-v1-1-d5ff8167e05a@debian.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112-netcons_double_cleanup-v1-1-d5ff8167e05a@debian.org>
X-Debian-User: leitao

On Thu, Nov 12, 2026 at 06:04:58AM -0800, Breno Leitao wrote:
> ---
> Given this is not super critical or hardly faced in production, I am
> sending this to net-next, even with a 'Fixes:' tag.

My tag ended up being 'net' instead of 'net-next', sorry. This patch was
made on net-next, and that is where we should have apply, ignoring the
`net` tag.

--breno
