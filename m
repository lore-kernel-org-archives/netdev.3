Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3FC3D8133;
	Tue, 21 Apr 2026 14:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776781008; cv=none; b=en6+IZN7iWCeCLjYz2ijqgtX0EhjARGndOWNIXH3x9CYU+Gp8ZNGV7TjtxT8Legz9UmnalwyhpfpopiJdAuU9nLFp71ulP554nPFvD6e+EDq6/dybUsZQHFEV5WISJfT6E71lobDRFT/mxxakeDzUCOkkrFGgb6kZzk/kmFi1wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776781008; c=relaxed/simple;
	bh=ZoRXCD4YDAw0pn5x3iJt3HilnNlR1YeyOWhFZ//kxpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mMCdpMw5fqejVEeNaguFVKeEX+0rIrGMfrUTljrRgepYV4lKL7IjrpR0vZtsLIV2PJwG+jNniJfbg7vQLqq0sjL5ZDKjrmmF8Zs0zERH6E06/7zXURUrcHLoa9Fx1Zqgw2X4/YP9L1C3N0cy0MIvo86j3uShS/NvBQK07wNw3bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c1mtfrnk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c1mtfrnk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 606FCC2BCB0;
	Tue, 21 Apr 2026 14:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776781007;
	bh=ZoRXCD4YDAw0pn5x3iJt3HilnNlR1YeyOWhFZ//kxpQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=c1mtfrnkZWNaGutLk9hw2dhHhWHgMmrY5m3O3X31MHX6rjxuBblbNXgmeU8cbjUf6
	 c6DH/dsPZ4dQDOEmwyWipnQt95Xa+ujG+X1jRxwJJoqo6KBO0t7VshC+VeCYLAo5aR
	 xDujiLQPfEBTH1qaYCSrpqH3U+08/qEg99yJqeuaSjZrpDA06J2kSypePLW958iSNL
	 sP0sBqYRRI6PIAYmUlJ18fQu6HG76AUnq2SrPkd9V9D/OxT/yvVXnvRKgjdLSm4/nq
	 PyQISZOQfITQqNtl2/CCxW///67be1WmsEhkyYOb2sqoUMptwm/DjOy4EGE6qSSDEu
	 oodwKdwIcPDOQ==
Date: Tue, 21 Apr 2026 07:16:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hugh Blemings <hugh@blemings.org>
Cc: hugh@blemings.id.au, Paolo Abeni <pabeni@redhat.com>, Mashiro Chen
 <mashiro.chen@mailbox.org>, netdev@vger.kernel.org,
 linux-hams@vger.kernel.org, horms@kernel.org, davem@davemloft.net,
 edumazet@google.com, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 net] net: ax25: fix integer overflow in
 ax25_rx_fragment()
Message-ID: <20260421071646.472c39c3@kernel.org>
In-Reply-To: <e2a47378-9008-45a2-92e3-d1f374b5e766@blemings.org>
References: <20260409025026.24575-1-mashiro.chen@mailbox.org>
	<20260413204921.70463-1-mashiro.chen@mailbox.org>
	<805a8583-6a84-4dfb-a4d4-53f80f50effc@redhat.com>
	<e2a47378-9008-45a2-92e3-d1f374b5e766@blemings.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Apr 2026 18:45:39 +1000 Hugh Blemings wrote:
> We'd hoped to have a period of a few months to do an orderly exit from 
> the tree to minimise the impact on the (admittedly small, but non-zero) 
> users that build trees/make use of the in kernel support.

Sorry about the CC, I trusted get_maintainer.pl too much, clearly :(

If you only need a few months I'd strongly prefer to delete now.
We are getting multiple "fixes" for this code a day, and if we don't
delete it now we have to process these fixes for 2.5 more months,
until the next merge window. IOW even if we delete now you have
2.5 months until 7.1 is actually released, and of course LTS is
available, too.
