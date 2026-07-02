Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0824DD6FE;
	Thu,  2 Jul 2026 14:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783003261; cv=none; b=heezNrpD80aKvd5BCjzhTLKtPzMSj84S1PMKFb1X0Ku2ptktJNavxS2SRrZQrH8qIk4CR/a9VHxO+4iRHChkRsN+MUn5chVIQkIUSB3voKibtif30GDlFa5Ztoh/ds09SJ3euY0Daz6X8ysl54V+EfGWoapRSkFPbGgVdtMU0o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783003261; c=relaxed/simple;
	bh=E/oRgPMsdlQ7uMHNveYlDy998LZbZETfvfmx8ApDbrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bdCkOHUMfZMNkH9T6umibWDETArpGKDyWFTZoEBrmm1D777KHfb+Y79wL9sxZ117zDwGn941MhjP3Y9+h8BwfcD6pdSZ9xW/buEutS6sd7t1U3HeCaFFMHFjDEvAFO93fi9OE2mBWKZykn33doHeIIvcmCmI44SEjgQ9EuGAjts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hm02p6fj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hm02p6fj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98E461F000E9;
	Thu,  2 Jul 2026 14:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783003260;
	bh=BSUGjZhMVgTM11JN5H9hsBczgsCpi82B3AuTguh9in4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hm02p6fjnlEnaYi8LIyKuaKkJeMlyl6lZZN3yFPc3ZWSdUCjOZZqqceCK3AB+psl1
	 buAexgo7/P/7HFNkm6FD2LF1NvTFeBMTdu0FLL30wGCeebccW2WMO2PXApK/WJxhAH
	 2QzFL9gS1S5iPfPhYF54bXa20bV8Op25b7+83SkSO+ww95Jfs0kuYT1vJY9DKnVBPp
	 yuuGVGfc3LcDWPTgFrq9mwklN5xL/QOEXTo39WHe3ZvjiNGiqbQMB5F210jEPFScrq
	 IOBvbcxMt0xmfkouaIcQDwSx8edf9vMXjuib7M/rQRLDoLF9GyCEc8vXT8fbuZMTm0
	 gTko2oCaowVsA==
Date: Thu, 2 Jul 2026 17:40:52 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Manish Chopra <manishc@marvell.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Sudarsana Kalluru <skalluru@marvell.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-net-drivers@amd.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH 2/4] ice: use kzalloc() to allocate staging buffer for
 reading from GNSS
Message-ID: <akZ4dBzkuoKPkIZT@kernel.org>
References: <20260701-b4-drivers-ethernet-v1-0-58776615db6e@kernel.org>
 <20260701-b4-drivers-ethernet-v1-2-58776615db6e@kernel.org>
 <d2c75404-a87f-4bb6-b17c-c921d08a1f15@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2c75404-a87f-4bb6-b17c-c921d08a1f15@intel.com>

On Thu, Jul 02, 2026 at 03:49:36PM +0200, Przemek Kitszel wrote:
> On 7/1/26 15:57, Mike Rapoport (Microsoft) wrote:
> > ice_gnss_read() uses get_zeroed_page() to  allocate a staging buffer for
> > reading GNSS module data via I2C bus.
> > 
> > This buffer can be allocated with kmalloc() as there's nothing special
> > about it to go directly to the page allocator.
> > 
> > kmalloc() provides a better API that does not require ugly casts and
> > kfree() does not need to know the size of the freed object.
> > 
> > Performance difference between kmalloc() and __get_free_pages() is not
> > measurable as both allocators take an object/page from a per-CPU list for
> > fast path allocations.
> > 
> > For the slow path the performance is anyway determined by the amount of
> > reclaim involved rather than by what allocator is used.
> > 
> > Replace use of get_zeroed_page() with kzalloc() and free_page() with
> > kfree().
> > 
> > Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > ---
> >   drivers/net/ethernet/intel/ice/ice_gnss.c | 5 +++--
> >   1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/ice/ice_gnss.c b/drivers/net/ethernet/intel/ice/ice_gnss.c
> > index 8fd954f1ebd6..7d21c3417b0b 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_gnss.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_gnss.c
> > @@ -2,6 +2,7 @@
> >   /* Copyright (C) 2021-2022, Intel Corporation. */
> >   #include "ice.h"
> > +#include <linux/slab.h>
> >   #include "ice_lib.h"
> >   /**
> > @@ -124,7 +125,7 @@ static void ice_gnss_read(struct kthread_work *work)
> >   	data_len = min_t(typeof(data_len), data_len, PAGE_SIZE);
> > -	buf = (char *)get_zeroed_page(GFP_KERNEL);
> > +	buf = kzalloc(PAGE_SIZE, GFP_KERNEL);
> 
> nit:
> from the code it is clear that we read at most a page, and @data_len
> stores the actual amount needed
> 
> comment:
> I don't know why we limit to a page, it's outside of the scope of this
> series, but likely you have removed the limit (which will go into the
> loop - single AQ call is likely limited by a PAGE too).

Not sure I follow how the limit changed. buf remains PAGE_SIZE regardless
of allocation API.
 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Thanks!

-- 
Sincerely yours,
Mike.
