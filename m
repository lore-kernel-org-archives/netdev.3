Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5746A42B75A;
	Mon, 10 Aug 2026 18:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786386608; cv=none; b=MRx06M0NHXvcVbsH4054STuPR1Em1BfbP5YHRzz+3TAvWdMa5LH08qPMtBd0gO999yF144xFJ6hkTaAPn3UecX0ET+//JLybRcwrvZZieVqjFWJJlnmGYeFM6Y+I9n0jgQ5lUULLW3XESq6GFPZWe0+hrrN36cUGRJgvxG42+Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786386608; c=relaxed/simple;
	bh=CpfbGa+7VrTvmL3jMx8exR8urivsJ1BjOPJraOKhvKk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DsEt69aWpUNey8P1fwcuSx7aF1FztTLqzF6e9D38ikrofzQ6mUkA+2I0IpJw0AGfp2K+AZsg6xExMCstmENDJl4gq0t/ffFwB715FzgxcWMJSBuB7L55Cqa7YOKtJJRAt8G+7J7xOrjUP6gcYFmOzZJtK/e/B2ObomxDShS59p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IwRisyY5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IwRisyY5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D72F71F000E9;
	Mon, 10 Aug 2026 18:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786386607;
	bh=LZrEHh/Y9r1TMRvgpMvVb1VcenmdbI5n6ZulKyBmD1o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=IwRisyY50RrLKhWR2ia0H83Y8cg/Qm2Ib/crQvfQaIyERlplqUgjX2jjwUIMWfc93
	 jq/48VDP07UHqlcv2KH94qleQBYdktsxXDd5jQwMMwgZnak0YyHeBkV1HZKVO/GBct
	 FTKmPpAtgbYdEO87WZyN2NUAS4BSDZ9SbknyBaEhFGoyYb2eU0QyFYyCn131loJv5w
	 XtR0jWoJR7NM6eoTf66se6SYU3vhsAHTDdO/pXGv5+CAER8qTcEpm0xnSM+THeGnG+
	 38mlW8ZM/8anSUok63AkC8f5diB3HyDatAedUBOYi/FqAvlxn9nZLKKPpACJXo8rkO
	 WMWKpXOVeyeBw==
Date: Mon, 10 Aug 2026 11:30:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Christian Marangi <ansuelsmth@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] MAINTAINERS: add myself as QCA8K maintainer
Message-ID: <20260810113006.25bc0e6a@kernel.org>
In-Reply-To: <caa0b7dc-7f99-48ca-b65d-5d62c0203045@lunn.ch>
References: <20260810143740.652804-1-ansuelsmth@gmail.com>
	<caa0b7dc-7f99-48ca-b65d-5d62c0203045@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Aug 2026 16:53:33 +0200 Andrew Lunn wrote:
> We normally target net for such patches, since users wanting to
> contact Maintainers are often using older kernels.

Very true. Tho in this specific case we may take it via 
net-next to cheat the patch count numbers in the final PR 
for this release ;)
