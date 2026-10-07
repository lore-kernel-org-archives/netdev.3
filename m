Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A32430CCA;
	Wed,  7 Oct 2026 18:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791397688; cv=none; b=cfrUZQGzmCzIFUJOpeazRea6bAQG47klEKDpGMcFwNi6MWT/mx+Z0/VQQAYVmt5tvL7RP774uCO3Ill1/IBNjAcNlxJpH4IfJZtTpmtMcVkxPU09rYSGemUPXINRUinr0aeX4Nyam193bW7+/OYV0ZzqTENZa/VvbyaIbIB2p+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791397688; c=relaxed/simple;
	bh=6nJnWIVkp3NZzdOu95QF+LRXEa3N0wPLCRO69S6Nuls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lg5Svjw8gIhbcKd87IPrvDUemIM9UaPIKN0FFtVf5naE3grQKV7ieTQETb8AiCLku8RCwsxI/osaNM+DmlJUf+ftC//c5dXmtw8HYZXcDZYUmlbuVkDB7fn6+xVPXOAyr5JsVnPsIMyHxNBEce2cvW53wB1O+88gtsfCvFxgB4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dTdaCHyx; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dTdaCHyx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=fI1D+NI+FFsPEpv4UzZGCRSeI03RhqdghV6rGdRdVg8=; b=dTdaCHyxa4m8zFBwMVBpkRU1z+
	fhyOKKVl5xzg5WTweCROZKAxp0QHE+Iv4wCRNWUSm5/KnjXar/mee8WJFpeylZWXjWIjSewg3I9xm
	m2W0a2vXWuXYsDaLkFe3UGlUKQgAwSquHXf8W6/1jHTFNnXV2XOikEa5ss183Yh+ol3Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xEWMo-009V4g-83; Wed, 07 Oct 2026 20:27:50 +0200
Date: Wed, 7 Oct 2026 20:27:50 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Chris Snook <chris.snook@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: ag71xx: align the IP header behind DSA tags
Message-ID: <d89d6b2f-3ff3-4f76-9b77-7e59d16ed482@lunn.ch>
References: <20261007174449.671416-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261007174449.671416-1-rosenp@gmail.com>

On Wed, Oct 07, 2026 at 10:44:49AM -0700, Rosen Penev wrote:
> The receive buffer offset includes NET_IP_ALIGN to get the IP header
> aligned behind a 14 byte Ethernet header. Most ag71xx devices use DSA
> switches whose tag sits in front of the EtherType, which moves the IP
> header by another 2 bytes. Every access to the IP and TCP headers then
> traps and gets emulated by the unaligned access handler, around 6 times
> per forwarded frame.
> 
> Take the headroom needed by the DSA tagger into account when choosing
> the offset.
> 
> TP-Link Archer C7 v2 (qca8k), median of 3 runs, Mbit/s:
> 
>                        before   after
>   routed up               743     855
>   routed down             660     749
>   local receive           554     572
> 
> The unaligned instruction counter no longer moves while forwarding.
> 
> Assisted-by: LLM
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
