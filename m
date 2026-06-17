Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10AF376497;
	Wed, 17 Jun 2026 20:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781729195; cv=none; b=cryHNV7X+BEJXVrQpNTYZLayoe587ZwQU0mLZyiMiokHF3GWzvVfmD85Tkm+/l64JlKha3O/AfawROQ1K/1EyQkr7E+bfAreZMscA8PMOnIF2LW7j35JQVfOR3aP9j4IoOyl4HzG59ZcQ7o70wCguaqSgmO6uBIfhAzOY9sf/J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781729195; c=relaxed/simple;
	bh=cIiNwSHcoDTzPIvAZfDPFdKYxhr1S+VS5uMkVd+Pq5A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sMoODgf3XpSUHxe5oymmoga0LSQJWRScvBInbAzlrwxPcvSRAB3d1JMAmCNcojXtBh0MsNceFu9bVdLr6UQSukHfgoeZJPnSCoCxGwR2sr/Rg6JobN+PIYr0Jz0BNgYdS528EntPuQ7sn1mZDuOqEVGD2TJHhBnXbtjSQ0ThALs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FA1De8wo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FA1De8wo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C53101F000E9;
	Wed, 17 Jun 2026 20:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781729194;
	bh=vVNWFmfjwqdxt2e6ldVvF0gW8p2zShG7ToMPkGF8Hf0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FA1De8woQbexsuMpG6HT4QyiZy6gY3yqhU5WhmcMOwI+rMiMCtY83dGw8rxermli0
	 GsB+BCOugSzjBqm36kyEB/q7OAdlUjDYXfqtVUfpaavLzN0OJ7o/GmK9cxbA6j/GD/
	 NoEMUCW0nxyOicFCsazxZmHJtaVc+NkBgG6sYM0uFBumqcobWHEzZd9vJwBXmT8byv
	 hMdcaWgQFQCdcZVWjUnEmpdlt5RNGhraifJ2+jhriy4HbjUUhLkJ70CCkCdGqWY3rq
	 HcVOHd36HoqIRiYUhr5EH/lHoZcISyVeP0hylFbJC2CN1ncutuG0/xiVUeecnwjpfr
	 TpUsqvgE4tVxQ==
Date: Wed, 17 Jun 2026 13:46:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "illusion.wang" <illusion.wang@nebula-matrix.com>
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 corbet@lwn.net, horms@kernel.org, linux-doc@vger.kernel.org,
 pabeni@redhat.com, vadim.fedorenko@linux.dev, lukas.bulwahn@redhat.com,
 edumazet@google.com, enelsonmoore@gmail.com, skhan@linuxfoundation.org,
 hkallweit1@gmail.com, linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v19 net-next 00/11] nbl driver for Nebulamatrix NICs
Message-ID: <20260617134633.658a8c8e@kernel.org>
In-Reply-To: <20260617044702.2439-1-illusion.wang@nebula-matrix.com>
References: <20260617044702.2439-1-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Jun 2026 12:46:45 +0800 illusion.wang wrote:
> This patch series represents the first phase. We plan to integrate it in
> two phases: the first phase covers mailbox and chip configuration,
> while the second phase involves net dev configuration.
> Together, they will provide basic PF-based Ethernet port transmission and
> reception capabilities.

## Form letter - net-next-closed

We have already submitted our pull request with net-next material for v7.2,
and therefore net-next is closed for new drivers, features, code refactoring
and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after June 29th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer
pv-bot: closed
