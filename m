Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D604938B7B4;
	Mon, 20 Jul 2026 20:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784579569; cv=none; b=bUy1uotpwCF5isxFXSdtvawYGsjiQQPPLDDPwhnLaZR/R8CLkAYu+M2clG1c+s1ZIalQdTAFhLsM6JfCP7fdRtVou3dwMc16h88H10lZ1LB96HHh271VVyJkCKzhCowJ4Pel0sbuyqQDWr6E0VIW3W9wr+srOpnZeMlTQ94EIJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784579569; c=relaxed/simple;
	bh=OogUHoiydvp0MI4vsSEd9xb56slD1b4xli0Jov9td+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+Bklx/uacz2rTVc8DMZ0nl0VPEYCR0sCEwNRsboiSo3gP0qdCKxnYk/eA2rBQ5SA0TcLuvxz6Oo7G7/DOnd5Hpag+CBfHqpqSoOzUNXvcRuvkY8ZkUEQW5Ydr7a1zLhcVmp+rCDH4UyAiPznWRUzSKsDB33S3OV/gWJx6telbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=AytsrEQL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="AytsrEQL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8P317kWPQT+2Buz2mUZHBIuBf1SsRX+l1nU0jAPQY0Y=; b=AytsrEQLQc1Ak+oU0KAd3tNJvJ
	3ohDIE1CzqHUu+AHz9wnA72xmoCm3H1DAvqCI72FOAjwMrdNcYpPzsVg69rEhIQV4RML0Xe3Nl0mH
	r5PzG2Wv3iPDJcYLcQ+jUc9tH3+GWNXr17meLHoOEVTeGWrckUVjM01IdRWDsJbMTraM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wlufC-00DJso-R5; Mon, 20 Jul 2026 22:32:34 +0200
Date: Mon, 20 Jul 2026 22:32:34 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Cc: Simon Horman <horms@kernel.org>,
	"parthiban.veerasooran@microchip.com" <parthiban.veerasooran@microchip.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v3 2/3] net: ethernet: oa_tc6: Improvement in buffer
 overflow handling
Message-ID: <b86c8bff-6f78-42c6-8de9-ae280df5c18b@lunn.ch>
References: <20260705-fix-race-condition-and-crash-v3-2-3e51841e4d08@onsemi.com>
 <20260710142019.1619159-1-horms@kernel.org>
 <DM5PR02MB33693344BE338A70BC70FDD283C32@DM5PR02MB3369.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM5PR02MB33693344BE338A70BC70FDD283C32@DM5PR02MB3369.namprd02.prod.outlook.com>

On Mon, Jul 20, 2026 at 07:09:22PM +0000, Selvamani Rajagopal wrote:
> > 
> > [High]
> > Now that oa_tc6_prcs_rx_frame_end() returns int (and can return -EAGAIN
> > via oa_tc6_update_rx_skb() when tail + size > end), should the
> > "previous rx frame end + next rx frame start" branch also observe the
> > return value? That branch is not shown in the diff, but in the
> > resulting file it reads:
> > 
> > if (start_valid && end_valid && start_byte_offset > end_byte_offset) {
> 
> 
> Andew and others,
> 
> I don't know why my v3 submission is under "Archived" flag. "state" is still new and I was waiting
> for it to move to "Change requested" before submitting the next patch set. May be my understanding
> is wrong.  Hope I can submit the following patch. 

You should probably repost it.

The last couple of weeks things have been falling through the cracks
due to vacation and conferences. Reviewer time has been limited.

It might also help if all the TC6 developers work together and review
each others patches. Patchset having Reviewed-by: is more likely to
get accepted without one of "big" reviewers looking at it.

    Andrew
