Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794404716;
	b=GN2/sEqm6Sj9Hn8TXT3+ztqSbBlf5Lh5TIuSbm3BeVIIjw23zVNDGP8Nv2OExS/wHRZZ
	 ZKVIS+xbqDguT+EV/kfEIux90YLZ7RkqE25NlhU5FH2GEHO4O3QJy7HuUY61wUB2xlez6
	 8SBGWQHvimEY+WTulWbjRhztHNAqroEOXsUuK+RIA5dh5d2NEjP/CjFZyxIRIXXy86Tr1
	 iYXVEZdap9/wK6fSfxXbsi/GNl8dcb5K6dq6YIz1wMr4JP8XHtxRtbC/jlyEDhHPMOLJY
	 KCfjzladocR29hG7+npARLVDcZw0tSvcxnfV7BxwEfSRAsJXlUdVx2e+IyujO2CwZmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794404716;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=JqaDTrKtx8/Db8fINpAFpkl/BzAhzi7fu660X6wjeKA=;
	b=jWIT+oUJsXSRPac9HZd5kDS0WVLmHQbU9gFAkheqc3OpuBxuHlQcoD9qoAZ8Gq7X0A8X
	 ycPis3DViUNcQ2xKAgI1XiM99GdR+VjIiLoeW2j6+61kpjuptv1XBJQW8uuNmzI3II0HP
	 FqO7bGTO9KaGpQV1d+8Dh+0nbCaCEoRgyKl9b7mzkcrAoQY/ZbeWXeSRIRHuDUmWwEOsk
	 WXXyktzM3Ir/HIvGhzEcBGC+9flw/ENr5zotMNACwnwWTql+N5KMc16Wnrfy/H5EYrhfA
	 GxOd5jiBNIHeO2d9qWFWjPS/JPzWBROi62QBLMjHAJofPxnmGR84+7GzEz/oT1SK1kA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=wcsaHS3m;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30830606A326;
	Wed, 11 Nov 2026 13:45:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30830606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=wcsaHS3m
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=JqaDTrKtx8/Db8fINpAFpkl/BzAhzi7fu660X6wjeKA=; b=wc
	saHS3mPAyJ9prqPvG1zaxtBdalEDupa+F24FGd3PfOZr7LpjXXKBwuvaEEtoKYJNIFj+0A0cwIU3I
	KptTPPpfjAJ4A/D9W+EH9hTfCXNGuxK3z4DPJQCl3HoAAToN54r+nRjAfYTysBfKZobOsV1TPPqpR
	d4MFNBEflhuwYyM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xR8dC-00Fl3m-2D; Wed, 11 Nov 2026 14:44:54 +0100
Date: Wed, 11 Nov 2026 14:44:54 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: =?utf-8?B?7ZWY7Iq57KKF?= <engineer.jjhama@gmail.com>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Trevor Gross <tmgross@umich.edu>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] rust: net: phy: make Device generic over a
 lock context
Message-ID: <6cec94de-b65a-443b-88ba-97a6489664e9@lunn.ch>
References: <20261110-exp-phy-rs-maybelocked-v1-0-3023cc9055e9@gmail.com>
 <20261110-exp-phy-rs-maybelocked-v1-1-3023cc9055e9@gmail.com>
 <CAGAB664Z1avii3rw6pSu4wT9eCmwYJ4R08ix2Z_YNm9KeEs-EQ@mail.gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGAB664Z1avii3rw6pSu4wT9eCmwYJ4R08ix2Z_YNm9KeEs-EQ@mail.gmail.com>

On Wed, Nov 11, 2026 at 10:02:04PM +0900, 하승종 wrote:
> Sashiko's review of this patch was sent off-list [1], so I am replying
> here.

The netdev's own LLM reviews are better than Sashiko, so we tend to
ignore Sashiko. The netdev one also does Cc: netdev.

> 
> > Can calling genphy_soft_reset() on a Device<MaybeLocked> cause a data race
> > on struct phy_device fields and bitfields when a Device<Locked> callback
> > runs concurrently?
> 
> The race comes from the caller, not from this series.

You might find the netdev LLM reports this as an existing issue. Lets
wait and see.

     Andrew
