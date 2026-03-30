Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945AF30E84F;
	Mon, 30 Mar 2026 12:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774874833; cv=none; b=qsXZuzsTNsPNllk5wwbumu6QEDdAVxNY0UOv4vWMN9+cK90Agl/KHkS04EvcqlSwRxu//DBOTnbSZvsKlly2D/1xeJqPEubxQVbp/zokyk/GJEJ018wsGzfeGGDEFvfnVvFmu2MyqWqE9d41HbJICs8yuJ4yUt7p7ca0ctSsvm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774874833; c=relaxed/simple;
	bh=WMuniRwk7KpMUL+kyEbqy+DZXfpJIvxnyIoPffxwcC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YLObRtjjyeiNuP9pqNazTYx84+mu8G7y/ObUhBY4GLE1Ql5K3Lzo0kg6u0aaojKxkmWmhCtHcRrq2e7y5d7OqVCSYopF4OOdLBItcbgDB/Y4GkOBgKqfnNTl0hMgdgrLxARIOP1QFBPOt77vRiV6Prv53Bhl0/5KE/lcjHLcUe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=sQvo0YJ2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="sQvo0YJ2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=GL5CWlLyR6lWA0gUv9SvGsvHrjp4P6AcIV65PcsG49k=; b=sQvo0YJ2RLF72T1ViiyRRfxS6k
	/YbS4PlhQ2t20w/hf7wHnc1L7aWItSyPSi7+vdZag5IKBuzcL0pTEpABm9DU0fz6HehGQ1SraDxXv
	TRufpe6GbjYrVSDYjLLrswMmYC57ht6f3iktmooNljKVCUVpVdhXMBqITa2CXX9rC2gI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w7C1I-00E23J-AW; Mon, 30 Mar 2026 14:47:04 +0200
Date: Mon, 30 Mar 2026 14:47:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] FDDI: defza: Rate-limit memory allocation errors
Message-ID: <4cfa0b04-1cf8-4ebd-89f6-e5d50399a9cb@lunn.ch>
References: <alpine.DEB.2.21.2603291252380.60268@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2603291252380.60268@angie.orcam.me.uk>

On Sun, Mar 29, 2026 at 01:32:34PM +0100, Maciej W. Rozycki wrote:
> Prevent the system from becoming unstable or unusable due to a flood of 
> memory allocation error messages under memory pressure.
> 
> Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
