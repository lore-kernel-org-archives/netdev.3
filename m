Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F33253D0B2;
	Thu, 15 Oct 2026 14:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792074561; cv=none; b=CnGo2dfERzzBY0QsOalOdxRNzEgaPoQFEghwZac31C0wHbRpidJsh5A58ycRPZVopzNiH8NjxdBDQJjkwG20cwPADM/bHrQM4N0Ynz/aydqcPM27uGa9O1h8mf0eznQc+9x1S2w32PbMrVFoNPzivZlxwKgHLkj6I4JzdbRy7Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792074561; c=relaxed/simple;
	bh=A5nDdccgfCQfDSj+RAmNTz7/+pNvFJA9qRMtNCj39fI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=csYI0TRGX8Ok224eJbcgEkO6/p/YmH6viwR3TuThAUpMQ9bH8hx7TpLwbZ6bey/n6JECCO+ydvq/KsXmgJPaBRswTFM2zJoqJioGne98xkEkPZ6kFYIT2+FtcQHOH4LxSz6cgmejIcGtkTndorhSnjIC+GsLowHUjfgvdqemyMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=OaQIJ7FC; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OaQIJ7FC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3T8jsjimlPYmV+tD4QRG5lYuy3+/ugIN8lPbZZkki4o=; b=OaQIJ7FCqZVADicDoNC7/3aO4n
	ZjXJ/h/lER1blofO+L/kZN3LcXMfabcPI13+zhvEhXJh3Fc97en2mXkzSebiK+9Wr4CoG6RCJB0bh
	1J+pOoDdP96Qzuk9LB3AEqEsyzPMPGP2xBsEZ21qzYMsTXkxwdP9GcpRMDXjMR94jaqI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xHMSA-00Axi3-8J; Thu, 15 Oct 2026 16:29:06 +0200
Date: Thu, 15 Oct 2026 16:29:06 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: Iyappan Subramanian <iyappan@os.amperecomputing.com>,
	Keyur Chudgar <keyur@os.amperecomputing.com>,
	Quan Nguyen <quan@os.amperecomputing.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2] drivers: net: xgene: Fix dma_unmap_single()
 size
Message-ID: <6046e419-2a1d-4e01-9f0d-f718ba8bfda9@lunn.ch>
References: <20261015124547.29996-2-fourier.thomas@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015124547.29996-2-fourier.thomas@gmail.com>

On Thu, Oct 15, 2026 at 02:45:46PM +0200, Thomas Fourier wrote:
> In xgene_enet_refill_bufpool(), the skb->data is dma-mapped with length
> len which is set to XGENE_ENET_STD_MTU which equals 1536. However, in
> xgene_enet_delete_bufpool(), the same buffer is unmapped with length
> XGENE_ENET_MAX_MTU which is 9600. This may erroneously unmap other
> DMA buffers or cause other issues.
> 
> Change unmap length to XGENE_ENET_STD_MTU.

I don't know this driver, so i could be wrong.....

map/unmap is expensive, because it needs to flush/invalidate the cache
etc. So the hot path part of the code, dealing with real frame data,
sometimes only maps/unmaps the length of the frame, which is less than
the length of the buffer, particularly when jumbo is involved.

So you could allocate a buffer for 9600 jumbo, but in the hot path
only map/unmap part of it, but when you release the buffer, you need
to unmap the full 9600 size of the buffer, to be on the safe size.

Please look at the driver and consider this. As i said, i could be
wrong...

	Andrew

