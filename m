Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C8753D0BA;
	Tue,  8 Sep 2026 12:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788871285; cv=none; b=ZIQeAQPyYsV4uGCkRNf7RmDrF/CouZ1czi8gIKquRkfKeYMRkieVUOro7hP42663QEtavSnydkRSlV8tnA0bV9r7hosnskOGgAAutTNghlEDtXETTH/HpQVNx3LU/4NV1bARUGB2GJNkElE9RGPmaC3pBHarad3k7J/ADHh800k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788871285; c=relaxed/simple;
	bh=C11eIH1axoSmA4Nw0j+f6lVJQjSHEnEG1moY1x/Gh7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V1/iBf37XbwC9Zg3V6kdws2sG2JLkMR9flwJfCitK3/1V5bxRUACwUp6GzaGvt7Adf4jzDbj/p40YIlIqClLe718Br1rkinSygLzv9topSVa7z68A9msJywZ6+Hh/QoPZmPDg0GZuCq+Mr47qxMfXKxNOZBEHoKSEZ//Pteg5fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OfOdU1Ub; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OfOdU1Ub"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B2691F00A3D;
	Tue,  8 Sep 2026 12:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788871283;
	bh=L/DVZwU8m5QrP45hct4JLM28dfypJCWXqw1hSAF2t9s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OfOdU1UbC3xfZcSDqaNlkCC2jBte+kUPnZ2X3ar+Jx1LuA5tGaZpd72cohfJhnsQb
	 rfGwpznhtHFPVC8KOzzKXEmCTIfRbO8wiFy4g6lPrc48I4pjvIzwMqDM5fX0Qe8mHm
	 7uzAg706TO7TUiL58/LwsaqBf0fHkSOERswkhakGf0h+7cZJySqcs/dgOT2dnijVpL
	 jxcOdvRbCy5+sqflFgIc8YprB7fH8G/svwJ7k+4vP3LhFoDbA8xVtK6j0ZNo01TvLW
	 cxD1f+B9iSBcraJm22QDOMbn9/nsLX07C3gK3dkIyB+W3p5EQPjcVDafjYxuZ5FeC/
	 4O5qabpUoCawQ==
Date: Tue, 8 Sep 2026 13:41:19 +0100
From: Simon Horman <horms@kernel.org>
To: Ivy Lopez <skunkolee@gmail.com>
Cc: ionut@badula.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: starfire: fix ioaddr sign-extension causing
 ioremap() failure
Message-ID: <20260908124119.GW40544@horms.kernel.org>
References: <20260819083731.GL265046@horms.kernel.org>
 <20260907225748.167279-1-skunkolee@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907225748.167279-1-skunkolee@gmail.com>

On Mon, Sep 07, 2026 at 04:57:48PM -0600, Ivy Lopez wrote:
> ioaddr is declared as a signed long, but is assigned the result of
> pci_resource_start(), which returns an unsigned resource_size_t.
> On configurations where the BAR address has its high bit set, the
> value sign-extends when passed to ioremap(), producing a bogus
> 64-bit address and causing device probe to fail:
> 
>   ioremap: invalid physical address fffffffffe480000
>   starfire 0000:08:04.0: cannot Remap 0x80000 @ 0xfe480000, aborting
> 
> Change ioaddr to resource_size_t, matching both the return type of
> pci_resource_start() and the type ioremap() expects for its physical
> address argument, rather than unsigned long, which is not guaranteed
> to be wide enough on all configurations. Switch the associated error
> print to %pa accordingly.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=198035
> Signed-off-by: Ivy Lopez <skunkolee@gmail.com>
> ---
> v2: use resource_size_t instead of unsigned long, and switch the
>     error print to %pa, per Simon Horman's review.

In general this change looks good to me.
But unfortunately it does not apply against net-next.

Please rebase.

-- 
pw-bot: changes-requested

...
