Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50FB42F707;
	Thu, 30 Jul 2026 13:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785416889; cv=none; b=hpPmG3MFSGCWqWpmyJ4t/HCercdvxDL43MabgVA60KAyUicWC8BX5uV3nftjWKDUIwBA0lu9cmD0Rv02IXXs04FP7B2P+E3YdOXcLqgjV+cBBJz8xGxTqU9ghYZ8+fl06sxLUSGbAX8jDLB47zJl6bhnNFaeux0tu2v4HmcA3K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785416889; c=relaxed/simple;
	bh=lLbbYgjI26srYjleM1KDoyoyUaTluBQqehul74XRbgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P02M2gE45KTvbdlBPmBRy8idJua3FJ7YVFFntu+7JgqrpJlUiJ8u0p7UIALFRVpp+AWwlJRBzQivnix0DHWxNgTn0asc8nK4HSAU02M3aiEcDgQa5pDWI9c/ZnYXz4wjvE3WOJclvQ/LOUbPvNmwiaDcLoz0NwQciD/msrCMzoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=ulTnAn79; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="ulTnAn79"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lLbbYgjI26srYjleM1KDoyoyUaTluBQqehul74XRbgo=; b=ulTnAn79rXEQaZxAsJmLzFuG0I
	stTt2QyXwn9yFvPn7ohmu+uppj6vQPCP2v09aDpNxDG+KPfCakMDo56KTXOuOkA4Ej4uTGjJwnBkn
	Ye4+F5XeS5nLItD1RKw7ZDNRIEr6NW22HZss0fuydqcHx5T55XYQt58F1reFV6SnG21f5K0jVNzgI
	6sTZbSYi+tU8JhkQQUVIQ2znA1Ba++mtQF93AlTRNJoyf5MK3Cdv1e2P/xrrAakjY236rDWP8dB3t
	vIQgYXmZfy3vqW3rkl5l7sx8C0S3rlIUqdMUBiwMKDCBLvIGHsQeiIUcAIvxyuHHdr2KW3APi5xv5
	+eE6tVfQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wpQUL-009GCE-2q;
	Thu, 30 Jul 2026 13:07:54 +0000
Date: Thu, 30 Jul 2026 06:07:49 -0700
From: Breno Leitao <leitao@debian.org>
To: David Heidelberg <david@ixit.cz>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sdf.kernel@gmail.com, kernel-team@meta.com
Subject: Re: [PATCH net-next 0/2] nfc: llcp: Move to .getsockopt_iter
Message-ID: <amtMjiKCFJGY6DAY@gmail.com>
References: <20260708-getsockopt_phase3-v1-0-d8394f2fc554@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708-getsockopt_phase3-v1-0-d8394f2fc554@debian.org>
X-Debian-User: leitao

On Wed, Jul 08, 2026 at 04:51:57AM -0700, Breno Leitao wrote:
> Continue to convert the protocols to getsockopt_iter callback.

Hello David,

Have you had a chance to look at this change?

Thanks
--breno
