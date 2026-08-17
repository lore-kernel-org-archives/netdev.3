Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666123EC829;
	Mon, 17 Aug 2026 23:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787008858; cv=none; b=p+bDwCFW40UjnFCk1iI64asbcYjxgtDAeYJ1IAvPzbZfUdRJCuOADLpKD9f2WAyXFtJwY2HD6FemsYwNORcGLllQcCtqe+tRd3KgE+5DckE8KiIS6lFrVPBhXjrVkaFIJyV3TthyhNh5ODOrGblvcGr3CPNAXr1aDb5xEd9TgP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787008858; c=relaxed/simple;
	bh=Fn19RvwJZ2TWUoZ0laVo83QO24Q/hT7D43ydE8Dox9k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p3y8z1ugPf4hx0RubjnpYBcFJI9cNBWRFfxRDe/p7U7JktJ8O0rvghzCw6pxqHPJllc+L84W3PXre0G/Ndi1luZ4uAKxoHKoH9Jhq3dbyzMQEdqcT+bE8AMiSu59CCbopnG+lhMr9dGXznQetVuRGI1nzl1VXMKaTlGZP+aIHfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jGOGTcHQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGOGTcHQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B07B51F000E9;
	Mon, 17 Aug 2026 23:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787008857;
	bh=t6sSdOIVaOQsDyJoonVjj789Fpi4FBX87ZLuLkiWERU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jGOGTcHQYhKZY6ELX7zPCKxc6XZySJXECcbs3ycTboswtFEBFQ5BbNgKaRxBb2MOi
	 yYZBfNMJDTPMhCfA5lTwJvoYrBKLiCXK18Tc4m+MtpbmUAZQ9KjURfnkHSot3wgc2s
	 U5oQncr8EU5rVKQagwCjNi0oa9i0aNLYyDgN4i8PHFpi2vzbsYXmM3Ai61N8ZA2P/M
	 0sb6vdHWFF1HkXxTjw+CC/Rs4q8uG0exTq6kPOgx8kSH6+0TLnU70lWvNsejOfE+4K
	 fbkhiObJB8L6AzoP2rpX3bvu+NDaRJVPnOWdDbnopZDrkqpnOAcOW+Xtajawwubv11
	 umgYrms36ZpAw==
Date: Mon, 17 Aug 2026 16:20:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Sunil Goutham <sgoutham@marvell.com>, Ratheesh Kannoth
 <rkannoth@marvell.com>, Geetha sowjanya <gakula@marvell.com>, Subbaraya
 Sundeep <sbhatta@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] octeontx2-af: initialize lmac_bmap in
 rvu_mcs_set_lmac_bmap()
Message-ID: <20260817162055.1efb0569@kernel.org>
In-Reply-To: <20260812060730.6181-1-kmehltretter@gmail.com>
References: <20260812060730.6181-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Aug 2026 08:07:30 +0200 Karl Mehltretter wrote:
> rvu_mcs_set_lmac_bmap() declares lmac_bmap without initializing it and
> only sets bits for valid lmacs with set_bit(), which ORs into the word
> without clearing it first. Bits for invalid or skipped ports keep
> whatever was on the stack, and the garbage is stored into
> mcs->hw->lmac_bmap.
> 
> Initialize lmac_bmap to 0 so only valid lmacs are marked.
> 
> Found with Clang's -Wconditional-uninitialized.

Applied, thanks!
