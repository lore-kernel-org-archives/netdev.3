Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E8742D74D;
	Mon, 20 Jul 2026 14:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784558815; cv=none; b=H4DxYvj7V94xzYd+tfyui2LSDmBDukA02xt5eNtpRouZQ09kUDpALDvpe4L0XWHRQzwOsE37Eff2zq0O1U/gWYLBXaWddaBN+FPu/TGSBfCbeEzYL5aXdA+rHOtLYAGYW56adDg07N4D8GKwnmK1dix3n2ZM2HAGs7nsBB4yifA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784558815; c=relaxed/simple;
	bh=MmkkCci7vAQOuzMABsY75YwfppPhMTrtpba8IaLjgjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q5jyzuTFUqr08evL/nnozA2mdV5UKB48I4jb0nyBRVI8EvYKp1tp080mq1x1Fgv5GX0S2R0eGj54KxnpAcVEHHmPEzcrd5J0xfTefH8VTcfTrg0ckWV+h5yDcXVdkU0mg5TeYMdbtCFMw2phOazFWp1eGPxsaisDR88IprncMho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=LQTgNtlW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LQTgNtlW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MuZVjOcXedZXPFO7JW1iwQVuE+ELoWb4+EQHcBM7sC8=; b=LQTgNtlWYAwuwYVvhHneXPND+C
	yePY3KqOhQLYFANE7MNoMAHMW6T5FH2Sc65P/IBnYokpG4ZSlbPRnMmQNoN4dAU6AqZGXimPiiXrA
	g0MVipKiVqfMN9nD3H9prVQdtuqNfbXFIJ2LC3cwZYtoSCZwX0D1DzpnusUF27BhFKuM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wlpGG-00DHEu-4y; Mon, 20 Jul 2026 16:46:28 +0200
Date: Mon, 20 Jul 2026 16:46:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Breno Leitao <leitao@debian.org>
Cc: Pu Lehui <pulehui@huaweicloud.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] e1000e: Fix out-of-bounds MMIO access by validating
 BAR0 size
Message-ID: <63312141-eb7f-4f8a-9cb1-84f417c08b5c@lunn.ch>
References: <20260715035850.588070-1-pulehui@huaweicloud.com>
 <al3uh7OU2OtkEkSY@gmail.com>
 <ffc0a0d8-6560-4589-9570-04f40d817009@huaweicloud.com>
 <al4Z4_tFbyQM-ogu@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <al4Z4_tFbyQM-ogu@gmail.com>

On Mon, Jul 20, 2026 at 05:53:37AM -0700, Breno Leitao wrote:
> On Mon, Jul 20, 2026 at 07:56:20PM +0800, Pu Lehui wrote:
> > 
> > On 2026/7/20 17:47, Breno Leitao wrote:
> > > On Wed, Jul 15, 2026 at 03:58:50AM +0000, Pu Lehui wrote:
> > > > +/* Minimum MMIO (BAR0) len, the largest offset is lower than 64K */
> > > 
> > > Why "the largest" in this case?
> > 
> > Hi Breno,
> > 
> > Thanks for pointing that out. I meant the maximum register offset accessed
> > by the driver.
> > 
> > IIUC, common e1000e NIC usually have a 128K BAR0. But since I'm not 100%
> > sure if older NIC might be smaller, I picked 64K as a safe lower limit
> > because it covers the largest register offset used in the driver's codebase.
> > If my assumption here is off, I'd really appreciate any corrections!
> > 
> > And for this comment, how about the follow?
> > /* Minimum MMIO (BAR0) length to safely cover the maximum register offset
> > accessed by the driver */
> 
> Thanks, Would something like this be a bit better?
> 
>      /* 
>       * Smallest BAR0 that covers every register the driver accesses
>       */

I would actually reference the highest register. It then becomes
exactly clear where this number comes from. Better still, use the
register #define in the test, along with this comment.

	 Andrew
