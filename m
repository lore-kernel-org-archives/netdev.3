Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898EA3659E6
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 23:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769123119; cv=none; b=GyUqImc0qMQhB8oJkW6vy0I9GiBnjGbE7Bej+qbkl5+jb0s0aWecPDpQtTtkcu4UBMj36YuWotY0IqLJTJb0AT2lhUFpZShgEOalZrbjlkWklnyVm0t0u3ktvK8TiaznQyp2HBd9LpQ6rEjqvloMRQptq2O+TKWcU/3UnzJMjrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769123119; c=relaxed/simple;
	bh=ocwNHrEUptzDbaFRMVLaMoCqpqPD0xIEDSrpqsbab1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JrMty0q2W14ePnjIxF5Bnzc08a2qS136BSVcz9dHRF+A34Q0lGJwtcvdmYF1QdXuGEE2HbvYryo39XsJOTy4QHjtXX+yaVwP07DPtOHfWz7Dibojkrm46kWV8WgQjT0n8dCBbvWARGanyTQz8sjT+jKdOhZTcyr1uK0cnGrk+/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=UCGO+15E; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="UCGO+15E"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=J8tQrEhZbeoFvQqFHvHJYAEjRPSBAOBLpPFYFV+Wf4I=; b=UCGO+15ERyEPZ8Elu5/53sdRB0
	napAOFvo4u3EgpIpo61rh/6xM1fbL8VVmGt826SsrCIY40W0RzciDMw+uzWR/Mk+S4xamSEHiIGhZ
	ra3qb+MuKlAXS8VLRfGTh0hioIysLG/EgX7sRg/FaG+U3Oh1thb/heimarwb3PSjYUhA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vj3jT-0042ZC-CH; Fri, 23 Jan 2026 00:04:55 +0100
Date: Fri, 23 Jan 2026 00:04:55 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Paolo Valerio <pvalerio@redhat.com>
Cc: netdev@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	=?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next 3/8] cadence: macb: Add page pool support handle
 multi-descriptor frame rx
Message-ID: <840fd286-779e-4130-b544-913116c97a29@lunn.ch>
References: <20260115222531.313002-1-pvalerio@redhat.com>
 <20260115222531.313002-4-pvalerio@redhat.com>
 <4c74c2c4-7a47-45ff-be17-485e0702cc37@lunn.ch>
 <87cy315lru.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cy315lru.fsf@redhat.com>

On Thu, Jan 22, 2026 at 11:24:05PM +0100, Paolo Valerio wrote:
> On 16 Jan 2026 at 06:16:16 PM, Andrew Lunn <andrew@lunn.ch> wrote:
> 
> > On Thu, Jan 15, 2026 at 11:25:26PM +0100, Paolo Valerio wrote:
> >> Use the page pool allocator for the data buffers and enable skb recycling
> >> support, instead of relying on netdev_alloc_skb allocating the entire skb
> >> during the refill.
> >
> > Do you have any benchmark numbers for this change? Often swapping to
> > page pool improves the performance of the driver, and i use it as a
> > selling point for doing the conversion, independent of XDP.
> >
> 
> I finally got the chance to get my hands on the board.
> 
> On the rpi5 I simply run xdp-bench in skb-mode to drop and collect the
> stats.
> 
> Page size is 4k and stats include the driver consuming a full page
> setting mtu such that rx_buffer_size + overhead exceed half page and the
> other way around for 2 fragments.
> 
>              |    64     |    128    |
>   baseline   |  533,158  |  531,618  |
>   pp page    |  530,929  |  529,682  |
>   pp 2 frags |  530,781  |  529,116  |

I was more interested in plain networking, not XDP. Does it perform
better with page pool? You at least need to show it is not worse, you
need to avoid performance regressions.

     Andrew
