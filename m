Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83413375F99;
	Tue, 31 Mar 2026 08:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774944726; cv=none; b=VHz4c3hy6VSOxAmmVziM4SwhYtu0e6ctMFZImiM706WdFbOCc+TPWiwhyGRzcNBTwFePRMPvBa/DxAgNuYNH4mVan4R3eTGyCNrucETQBEz+kCGAiAGzhHUk7Bn5+xccf0G4/aJ9griYcal5wG4T+o7aao4f7lGiXn9dkWA6pF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774944726; c=relaxed/simple;
	bh=vwdgJ0CdE0LrXhHCL6opPBq1j9u58ZLvZ+dt+syz9Nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RgnuZfypXXClzSvdb9+Fd33/PuhmmQTzlTNbqTITnXqQ2Ryg6HMZTl+mHQLBRRIcMqrb3CicX+RWgSX5yGIOJbe1so5+g5+cuLPcnP/E9zi/KCtMcG9syUbQn5NXCrjuvtzkSelpaGw01PxNAnqTHOjQUn0946CES9GFaj0NhPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-4a-69cb81c61269
Date: Tue, 31 Mar 2026 17:11:45 +0900
From: Byungchul Park <byungchul@sk.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
	kernel_team@skhynix.com, harry.yoo@oracle.com, david@redhat.com,
	willy@infradead.org, toke@redhat.com, asml.silence@gmail.com,
	almasrymina@google.com, przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, intel-wired-lan@lists.osuosl.org
Subject: Re: [RESEND PATCH] ice: access @pp through netmem_desc instead of
 page
Message-ID: <20260331081145.GA54972@system.software.com>
References: <20260224053546.62757-1-byungchul@sk.com>
 <20260226010811.GA16777@system.software.com>
 <af90b7e6-de47-485d-9e1b-31612456ef9c@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af90b7e6-de47-485d-9e1b-31612456ef9c@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsXC9ZZnoe6JxtOZBt/+i1qs/lFhsfzBDlaL
	3Rd+MFnMWbWN0WLO+RYWi6/rfzFbPD32iN3i/rJnLBb/b/1mtbiwrY/V4vKuOWwWxxaIWXw7
	/YbR4vbSq0wWlw4/YrH4/WMOm4OAx5aVN5k8ds66y+6xYFOpx+YVWh6L97xk8ti0qpPN42Rz
	qcfOHZ+ZPD4+vcXi8X7fVTaPz5vkArijuGxSUnMyy1KL9O0SuDK+bJvJVrCAv2LVgn9sDYyr
	ubsYOTkkBEwkzp88xdzFyAFmb7ggCxJmEVCVWNy3lxHEZhNQl7hx4ycziC0ioCNx/uYeoDgX
	B7PAPyaJ7XfvgCWEBQIlzl04wgYyh1fAQqLzVBhIjZDAdEaJNc8WsIDU8AoISpyc+QTMZhbQ
	krjx7yUTSD2zgLTE8n8cIGFOAVuJowc+MIHYogLKEge2HWeCOHMeu8S8J1IQtqTEwRU3WCYw
	CsxCMnUWkqmzEKYuYGRexSiUmVeWm5iZY6KXUZmXWaGXnJ+7iREYZctq/0TvYPx0IfgQowAH
	oxIP742qU5lCrIllxZW5hxglOJiVRHh9eoBCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeY2+lacI
	CaQnlqRmp6YWpBbBZJk4OKUaGCU7hUL8rt3cfuejZU3xXt1b2kkrCjg0+VPmsJwUsuO57zf5
	z5H9PP6n+oVUVblKV5ayy53PYT365MhK6bOZ/XzC29dkuTZvSnh+2I9Rvp1JmqvIU1l8rWfM
	fAe/gzNiPC5du+OX8JzD7XT/YdniDh/5n1VCh2dtSjNwuvLcdFXI0n/+j3O3K7EUZyQaajEX
	FScCAJfF1c+uAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmkeLIzCtJLcpLzFFi42Lh8rNu1j3WeDrToOeVjsXqHxUWyx/sYLXY
	feEHk8WcVdsYLeacb2Gx+Lr+F7PF02OP2C3uL3vGYvH/1m9Wi8NzT7JaXNjWx2pxedccNotj
	C8Qsvp1+w2hxe+lVJotLhx+xWPz+MYfNQdBjy8qbTB47Z91l91iwqdRj8wotj8V7XjJ5bFrV
	yeZxsrnUY+eOz0weH5/eYvF4v+8qm8fiFx+YPD5vkgvgieKySUnNySxLLdK3S+DK+LJtJlvB
	Av6KVQv+sTUwrubuYuTgkBAwkdhwQbaLkZODRUBVYnHfXkYQm01AXeLGjZ/MILaIgI7E+Zt7
	gOJcHMwC/5gktt+9A5YQFgiUOHfhCBvIHF4BC4nOU2EgNUIC0xkl1jxbwAJSwysgKHFy5hMw
	m1lAS+LGv5dMIPXMAtISy/9xgIQ5BWwljh74wARiiwooSxzYdpxpAiPvLCTds5B0z0LoXsDI
	vIpRJDOvLDcxM8dUrzg7ozIvs0IvOT93EyMwapbV/pm4g/HLZfdDjAIcjEo8vDeqTmUKsSaW
	FVfmHmKU4GBWEuH16QEK8aYkVlalFuXHF5XmpBYfYpTmYFES5/UKT00QEkhPLEnNTk0tSC2C
	yTJxcEo1MFZJ/BGR7nnGw7xGzjaM657Tlut/3/ob9/B+4b/l5Jkmc4ztcLPrwocb/kXwd+w7
	+L/dc/Zfc+sN5ZffmWWw/Xr6y/LN944ewf2rJu48tFb7kvfnM5Jv6h6f/ncjbUHmJtPfRkls
	D+eErPi0aF5jVkHfWV3W3Xw9CbzKIQWWJb3S79pfhzAu9VViKc5INNRiLipOBABVjmPHlgIA
	AA==
X-CFilter-Loop: Reflected

On Thu, Feb 26, 2026 at 10:13:14AM -0800, Tony Nguyen wrote:
> On 2/25/2026 5:08 PM, Byungchul Park wrote:
> > On Tue, Feb 24, 2026 at 02:35:46PM +0900, Byungchul Park wrote:
> > > To eliminate the use of struct page in page pool, the page pool users
> > > should use netmem descriptor and APIs instead.
> > > 
> > > Make ice driver access @pp through netmem_desc instead of page.
> > 
> > Hi Tony and Przemek,
> > 
> > Is there something that I'm missing or something wrong with this?  Your
> > feedback would be appreciated.  Thanks!
> 
> Hi Byungchul,
> 
> Nothing wrong. I plan to apply it today.

Hi Tony,

Sorry bothering you but could you tell me where I can see the patch
ready in a tree, maybe yours?  I failed to locate it.

This patch is very important for the project removing pp fields from
struct page to go ahead.  Thanks in advance.

	Byungchul

> Thanks,
> Tony
> 
> >       Byungchul
> > 
> > > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > > ---
> > >   drivers/net/ethernet/intel/ice/ice_ethtool.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> > > index c6bc29cfb8e6..c16e54dbe75b 100644
> > > --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> > > +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> > > @@ -1251,7 +1251,7 @@ static int ice_lbtest_receive_frames(struct ice_rx_ring *rx_ring)
> > >              rx_buf = &rx_ring->rx_fqes[i];
> > >              page = __netmem_to_page(rx_buf->netmem);
> > >              received_buf = page_address(page) + rx_buf->offset +
> > > -                           page->pp->p.offset;
> > > +                           pp_page_to_nmdesc(page)->pp->p.offset;
> > > 
> > >              if (ice_lbtest_check_frame(received_buf))
> > >                      valid_frames++;
> > > --
> > > 2.17.1
