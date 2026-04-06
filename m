Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A076D8472
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 14:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775484381; cv=none; b=a12TLYW0ZZ0xXPWGveGsJXx0Jlob0qlVAi7nB/ngSQggjOCeyCbeEx8pwnw0dR+F61dnkbEkU2vTZLmLuiDXqj3Domvfq+nTnmpuptsXLq/lpAL8dCiOru6/zd4Z2lW/HUnYxubHg8mhCwRzytSfmAubDzFgZjtlRBolTYfrR5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775484381; c=relaxed/simple;
	bh=lSOhJktgpXKPmVSgZ1HfGR78lmK+3sPi09aFmGX56q0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iphpt35OqHmDuSsmL9M8OW2kE6Xuyg18twMHzowCuxyLb6NqTG7PrmgCTxoyJutIeqI3nYkNM8JElzUoX0nL6nrYlLeYuMS1Ns/rqVON+QIjzy962d+HfaJc0qlJGvlqBaUNDsQ82jxcVcoxs/Z/MoaqzQ/kDfKi9HzTQW5j3+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AG7paG2F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AG7paG2F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C230C4CEF7;
	Mon,  6 Apr 2026 14:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775484381;
	bh=lSOhJktgpXKPmVSgZ1HfGR78lmK+3sPi09aFmGX56q0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AG7paG2FM97zut6Ait4Vs9oVl0bVsbqvUMoTJdkG9GcrMOE+LVmL1NCho4pjItkAi
	 GsHNFBkYtZGbu0UfS/lLqHWNhdlUqggZWm2uICusyTcRkhLx8hR34suFlBn1YzCyVf
	 Dj0zTvtLlFVOanXrdSrTzfYbOXoRwO+zHS4tEG+15ErwBpcmJDlEgHxfgqx/QLEjkH
	 ULhlyOiVF6Pwvf1cbSVj5l5/74pB72e1i4BSFy0IfUp6riyqwYG8B53Ep24jQB6NDu
	 Az6wHh8QM1MhWk7NrXgiOYW0IFjja5Ho7lPRkwhd+pAhRrUw2lZwQtUUW6evlruVsS
	 CrItt9ADHf3iA==
Date: Mon, 6 Apr 2026 15:06:17 +0100
From: Simon Horman <horms@kernel.org>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Cc: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH iwl-next] ixgbe: fix ITR value overflow in adaptive
 interrupt throttling
Message-ID: <20260406140617.GC395680@kernel.org>
References: <20260327073046.134085-1-aleksandr.loktionov@intel.com>
 <20260327073046.134085-11-aleksandr.loktionov@intel.com>
 <20260403131857.GB113102@horms.kernel.org>
 <IA3PR11MB8986472BF64AFBF2191A381EE55EA@IA3PR11MB8986.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA3PR11MB8986472BF64AFBF2191A381EE55EA@IA3PR11MB8986.namprd11.prod.outlook.com>

On Fri, Apr 03, 2026 at 04:12:02PM +0000, Loktionov, Aleksandr wrote:
> 
> 
> > -----Original Message-----
> > From: Simon Horman <horms@kernel.org>
> > Sent: Friday, April 3, 2026 3:19 PM
> > To: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> > Cc: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L
> > <anthony.l.nguyen@intel.com>; netdev@vger.kernel.org
> > Subject: Re: [PATCH iwl-next] ixgbe: fix ITR value overflow in
> > adaptive interrupt throttling
> > 
> > On Fri, Mar 27, 2026 at 08:30:45AM +0100, Aleksandr Loktionov wrote:
> > > ixgbe_update_itr() packs a mode flag (IXGBE_ITR_ADAPTIVE_LATENCY,
> > bit
> > > 7) and a usecs delay (bits [6:0]) into an unsigned int, then stores
> > it
> > > in ring_container->itr which is u8.  Values above 0xFF wrap,
> > > corrupting both the delay and the mode-flag on the next readback.
> > >
> > > Separate the mode bits from the usecs sub-field; clamp only the
> > latter
> > > to [0, IXGBE_ITR_ADAPTIVE_LATENCY - 1] via min_t(unsigned int, ...)
> > so
> > > overflow cannot bleed into bit 7.  Add a WARN_ONCE() when the raw
> > > usecs value exceeds U8_MAX so out-of-range ITR computations are
> > > visible in dmesg during development and testing.
> > >
> > > Fixes: b4ded8327fea ("ixgbe: Update adaptive ITR algorithm")
> > > Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> > 
> > Somehow - perhaps because there is no m/n notation present in the []
> > in the subject - Patchwork has treated each patch in this series as
> > it's own patch-set.
> > 
> > And in the case of this patch, it didn't apply - I assume because in
> > order to do so an earlier patch in the series needs to be present.
> > 
> > So CI didn't run on this patch :(
> 
> Good day, Simon
> 
> I have a bunch of simple /* independent */ patches for submission every week.
> Whis way you'd recommend to send them to ease /* and accelerate review */ ?
> 
> 1. submit one by one
> 2. submit as a batch by one git command (with the same internal main ID tag internally)
> 3. imagine a cover latter and submit as a patch-set 

Hi Aleksandr,

I would suggest 3 and lean towards small batches.
