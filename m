Received: from stargate.chelsio.com (unknown [12.32.117.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4ECE3DB641
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 15:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=12.32.117.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790263404; cv=none; b=DHlkN0K5/fhD7vH/asvMbHslopEx00H6k372HDHrDf1iivEojOeplLw5NY/z5U8/VhlXbBbqvDFqcqmnZG4ycVF6Sh78VMCI2lzwZss4R2KIE0LqEV3gPtLxcxucJjsxhvotcrDWfbMjFU89vc6yDuv6eJi0q5OicwLO9uMmNxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790263404; c=relaxed/simple;
	bh=dFFjLeKjrjAReaI+IcVEGZ5+lDpQkqBRUBEDWvwtBTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ve/UjisENJCu+lM/tlRbAjRuyQ8ACQYe99daX8nVNrp/yVklZa6I6iIMPgXBi3R63zzIrBgESDjIWoEOTJXm/eJZN8FZpUm1wgisWXqmjnmrZZP5ORXoo7KVNdNvIvAo/6v1RhNAk+p5FKOc8i9jSRrxpaPdYdlUVn2ScoRktfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com; spf=pass smtp.mailfrom=chelsio.com; arc=none smtp.client-ip=12.32.117.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chelsio.com
Received: from localhost (bharat.asicdesigners.com [10.193.191.14])
	by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 68OFMqQo000570;
	Thu, 24 Sep 2026 08:22:53 -0700
Date: Thu, 24 Sep 2026 20:52:37 +0530
From: Potnuri Bharat Teja <bharat@chelsio.com>
To: Simon Horman <horms@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>
Subject: Re: [PATCH net-next v2 00/11] cxgb4: Add T7 adapter support
Message-ID: <arVAPX3CaFHKQZg8@chelsio.com>
References: <20260921233041.61093-1-bharat@chelsio.com>
 <20260924125557.GE13925@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924125557.GE13925@horms.kernel.org>

On Thursday, September 09/24/26, 2026 at 18:25:57 +0530, Simon Horman wrote:
> On Mon, Sep 21, 2026 at 07:30:30PM -0400, Potnuri Bharat Teja wrote:
> > This series adds support for Chelsio T7 adapters to the cxgb4 driver.
> > 
> > The series extends the driver core to recognize and initialize T7
> > devices, adds support for T7-specific hardware resources and firmware
> > interfaces, updates PCI initialization and resource management, and
> > enables adapter operation through the existing networking stack.
> > 
> > In addition, the series updates several auxiliary components to support
> > the T7 architecture, including PTP, ethtool, filter management, CUDBG,
> > and debugfs. Support is also added for T7 multicore debugging and
> > diagnostic infrastructure.
> 
> Hi Potnuri,
> 
> Unfortunately this patch-set does not apply to net-next.
> Which means that our CI did not run.
> 
> Please rebase against current net-next and repost labeled
> as either [net-next v3 ...] or [net-next v2 REPOST ...].
Thanks for letting me know. 

I will repost them.

> 
> Thanks!
