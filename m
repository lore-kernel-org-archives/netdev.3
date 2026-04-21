Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B8826AE5;
	Tue, 21 Apr 2026 02:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776739831; cv=none; b=tN+yQ/il4OqPFWEvLnkiO8HLCp9G6TBDr33QXDJNPaZPRl39Bt7HAaHFqIaxRDZjdjemH7avoG27Jc28XQ5islxpB5r8NoT9kNWS4+Obv7pqFhsVQO+4OCwOLJE9D/itB4D5vc5/MgvxJ78NuxIFMpLkrH+gTlIBLJZo0c3Flqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776739831; c=relaxed/simple;
	bh=rbePez9ZhtXH+jIKDhPyBN2yKXTltFhNJX3au3kkxx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YK0zc8WVww+ejmUhlxdVbY/kqa6hjVjVoVTyHYT1ADorReuvqQT1MihVP3N7Ljs8p87ABGpWh0ibGZfHjZWyd3fxvwX/Q7xmiQzzt9HrlmGbdezYCb3ZOMy0qtrSAMacvG8fDg3h5EnKYix7TDXvI+T9Rb9jgXkkLyapOd6Su6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=HCQ8J+6l; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="HCQ8J+6l"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7ExLCOXyYkhZAnEw7z/hNQHFHdaRS+6JgG7peazhLmk=; b=HCQ8J+6lPE29tJbVlThj+uRomL
	v1Zmoe2UnTzDnleAG+qySpx84yEcz/cMJKEtG5ElMRvC7HcHlq2bW1qyhHCszN9sUZNp8KLIa/URY
	pvgvc+knclQamMmildt5snFDutSEltA6DylR4WgBTbwoCBfC4F6fjuzOQWToVqlG3dUM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wF1Bt-00GpzM-4F; Tue, 21 Apr 2026 04:50:21 +0200
Date: Tue, 21 Apr 2026 04:50:21 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ashutosh Desai <ashutoshdesai993@gmail.com>
Cc: netdev@vger.kernel.org, linux-hams@vger.kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: rose: use pskb_may_pull() in CLEAR_REQUEST length
 check
Message-ID: <c42cb19a-2be3-4edd-8ec1-4e2d4fc9591a@lunn.ch>
References: <20260420015723.462479-1-ashutoshdesai993@gmail.com>
 <48f45bdb-6edf-4676-a96e-4530634cd7c0@lunn.ch>
 <20260421022712.690822-1-ashutoshdesai993@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421022712.690822-1-ashutoshdesai993@gmail.com>

On Tue, Apr 21, 2026 at 02:27:12AM +0000, Ashutosh Desai wrote:
> On Mon, Apr 20, 2026 at 15:04:30 +0200, Andrew Lunn wrote:
> > Did you review all the other comparisons on skb->len in rose?
> > Do these need the same fix? Are there other places non linear buffers
> > should be considered?
> 
> Reviewed all rose files. Thanks for pointing those out - yes, the two
> spots in rose_route.c and rose_loopback.c have the same issue and need
> the same fix.
> 
> While reviewing I also noticed rose_link.c: rose_link_rx_restart()
> accesses skb->data[3] in the ROSE_RESTART_REQUEST case and
> skb->data[3]/skb->data+4 in the ROSE_DIAGNOSTIC case, with only a
> ROSE_MIN_LEN (3 bytes) guard upstream in the caller. Same linearity
> concern.
> 
> Is it recommended to send a v2 covering all three files?

Too late, Jakub just posted patches deleted it all. See the netdev
mailing list.

    Andrew
