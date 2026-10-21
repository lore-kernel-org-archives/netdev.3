Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792591148;
	b=mZ67h92lze5GkQ/HTYkTchQpz27H2TA1mzNNDPApdn38Gucc5wMUaJYp3NG8wA9HTxif
	 kabLzOVYgDoYUqNNNhzHE+qqsJn9WIbkVUUX95NQvcPESjb+yLLtGSqhSQCWhYi3rQWzA
	 3M3NuaoC66KXhaj8d1PbhiTdY4cp/+2FVmDinrEQrtZGt+W7B0QFBlv1AegM9xh3ESODt
	 1cRk2KCGsVLzH8QroSmPsKjEFhJxmn8rIxzbjphA5gHJP2+kxTvq2jLWI4E1MqtbYcers
	 p8NWFlYP8yRJHlwOTTGJ7hH5YQQx8R7zu3a8M3V6QnAfAOrX5i5Cgfp7v7LLL7w9HRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792591148;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=CF7NxGfQqwUb06gUqk0YXRYtqxZmJkrr71gFRploMIo=;
	b=x9hilN6eTCI33UbZI9QhqcXBNBJpKol8k4k0tOj8STUxSywUgFWzNz4UHUsEUFYaxndH
	 /206+aHKvAb+vi81qmTl4gZurd1ZQ9ePwlV+fJriGBixJ4dYfrui4DYYffdBkif7rFCIg
	 DKKCRrkACvmGt1w6FE3y7PhpYEUSKbcKSEMfDE49oYXByhVGqFaYDO6MKp20k29kfK+No
	 pKirl00QBNuzJbgOgfGI/m2qXfJZUq3HPCzBrfj/nzCbXfc9pS8lqZFvvs/fcvCbYJwME
	 MuWPmpgeF6aMzKDTfuM+0PeaxrwoYGD4pO4qqneu86aFzNeE/9o5xZOhnLsAXj74RFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=Vto8D6lq;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2137606A31B;
	Wed, 21 Oct 2026 13:59:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2137606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=Vto8D6lq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=CF7NxGfQqwUb06gUqk0YXRYtqxZmJkrr71gFRploMIo=; b=Vto8D6lqNg+NPFt78gCjRqpyju
	CEs6ABHzkAKT9YyuuBVfQdP7BIZzyvBzqgOJIlx5mX29sYYnybxNpCcagyfX7Ffhfkj5y5yH8dnd3
	mCvuVaGX4YNgSqC+Wwx4zIiO92saNqA51Cu0CNe+wQka38Qe0GQRT2gpO1D9czcOee3w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xJWqH-00C5yL-QP; Wed, 21 Oct 2026 15:58:57 +0200
Date: Wed, 21 Oct 2026 15:58:57 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Christian Lamparter <chunkeey@googlemail.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: emac: release DT PHY resources on teardown
Message-ID: <51f35c9c-190c-4ac7-a3e0-c681068fecc9@lunn.ch>
References: <20261020223002.1749284-1-rosenp@gmail.com>
 <59c8f008-9ca0-4620-9a54-e73da131ab6c@lunn.ch>
 <DMA6QT4SYA41.3VGVOVAWYQMS6@gmail.com>
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
In-Reply-To: <DMA6QT4SYA41.3VGVOVAWYQMS6@gmail.com>

On Tue, Oct 20, 2026 at 08:11:02PM -0700, Rosen Penev wrote:
> On Tue Oct 20, 2026 at 6:05 PM PDT, Andrew Lunn wrote:
> > On Tue, Oct 20, 2026 at 03:30:02PM -0700, Rosen Penev wrote:
> >> Disconnect PHYLIB PHYs and deregister fixed PHYs during both probe
> >> unwind and driver removal. Without this cleanup, unbinding a DT-based
> >> EMAC can leave its PHY attached to the freed netdev, while fixed-link
> >> instances retain their registered fixed PHY.
> >
> > This driver is quite convoluted with its PHY handling.
> I agree. I got this LLM to convert the whole thing to phylink. It tested
> a bunch of stuff over serial and ethernet, which works. That's net-next
> material though. It'll probably get rejected.

What is important here is you have the hardware and you have tested
it. That is better than most LLM generated patches which sometime
don't even build, and most of the time are never run on hardware
before submission.

If your patchset for phylink is up to mainline quality, post it.

We push back on LLM generated patches which are of obvious bad
quality. But we have no problems with good quality patches tested on
real hardware.

     Andrew
