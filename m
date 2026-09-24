Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799F441D23C;
	Thu, 24 Sep 2026 19:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790277788; cv=none; b=dqnKGcxrUlinZIYmmj5/aTkgnspAL53GPhp4fhWdc4HuCTu+hic8D4QiPZrfKXM7lFyTdTggF8hEydDTtJFWV0fyOywxGt8Ju0BpUURz+dI99tTMpZHHCPA7DZ82y+VVdr/ZRK4KHVS/GDohV34Wo5jPNv47QwN56k/TFQtLBoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790277788; c=relaxed/simple;
	bh=4RZIde4HZlu/jfkCQuuEP6lea7dO1CSw2YAsrBBwRJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Noyr7NlvWJG/oooJ7fjpu6fUIi04DARs93GAxDCB3bxcq8kGKOYe7BNw8f8Xlbryqrp5Dmfo9mGkimKaJtpR9DAvHs1O1C9up6lLVe0mNw2jweycRttgafFUYU8uSqMss92IZtsDIrJ/cECMBzf294BG8q5SsCv12945oKt8n04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bsR0eXtE; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bsR0eXtE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=LnfvAt80In+PiEn7KhIg1bAlTRviYziBSMsKJ2SXDnM=; b=bsR0eXtEWu7BCoGJkej3059qVa
	jBIRnNfzFLdBIfNlhPTsRQwyssXx0HN9RC2q88xa7NFbeKQeFm2EKtviG+saibQTL2ZJ+jF19XIS3
	B5kfEEx7S4Rjxp3Vznu9YsOnWKM/Iwjtlepy6LNpJvUwO/HqAC1cvdHhcHv/bTTL5mQ4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x9p1r-0074L7-Ox; Thu, 24 Sep 2026 21:22:47 +0200
Date: Thu, 24 Sep 2026 21:22:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Sagar Taunk <sagartaunk@proton.me>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
	Matthew Maurer <mmaurer@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Carlos Llamas <cmllamas@google.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5] rust: net: netlink: validate attribute
 length before casting to `c_int`
Message-ID: <87ee2f12-4a82-4cc4-83c4-a6cb48243a2e@lunn.ch>
References: <20260924185809.18216-1-sagartaunk@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924185809.18216-1-sagartaunk@proton.me>

On Thu, Sep 24, 2026 at 06:58:25PM +0000, Sagar Taunk wrote:
> `put()` trusted an unchecked `as` cast from `usize` to `c_int`.
> When the length exceeds `i32::MAX` that cast wraps around to a
> negative value.
> 
> This ultimately resulted in a kernel panic when the reinterpreted
> value via `__nla_reserve()` and `skb_put()` became enormous.
> 
> Validate payload and header both fit together in a `u16`, rejecting
> any payload that wouldn't leave room for `NLA_HDRLEN`.
> 
> Fixes: 5eaa5fbb6e6c ("rust: netlink: add raw netlink abstraction")

Seems i was too slow giving you the link to the Documentation.

If this is a fix, and needs back porting to stable, you should base
your patch on net, not net-next.

     Andrew
