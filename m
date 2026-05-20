Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160853F23C5;
	Wed, 20 May 2026 18:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779300211; cv=none; b=N9F0Vg24jCWa4jESN5i1ZvCE2GdTMpwZ2JodVoTIqotn1lRoQo0bt1Bnwq9eMBaEg65kops88yUuiqf7hl4RQthz9IHY2UPRtgDn3iUrt40VL/nsookjKlK7XdgpMMFUDHZGPwp2JIkDTi6SAbacr9RbkdYjs/AkG/nNxtHmgus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779300211; c=relaxed/simple;
	bh=rudgk+mg3/2rutSrlrlxvWavMk9JFqXDGu+KqmHIUbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rnGVJzg6j5/MpJ2s3PZgqQsWb5zcEZxFi0LjvDHbKAFCjIiHcPvmtlVd9C8zuLgE3OI4j4CWPf+gO8434xuudrNHHOgkZB7yyb8XoKMRzXnEqWSlu87vtMEIXzo8WMd3b+iXifKOR/toYdDgHIrtot35p0G1dl8rJL0c+7J1dSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ib+QDmV4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ib+QDmV4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02D891F000E9;
	Wed, 20 May 2026 18:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779300209;
	bh=Rz7yAa3qcHc0KU19IaAMOIyX78z/nUqety1iBnItnZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ib+QDmV4vHjejSXodfCLFHpFhSOs+Q7oQQu/WZ9yi2afqDpljP/Ifrgc92lGA4LwA
	 cedndEcxNrkxi1X9WIBdPKLJSeqMZkRF2ZUX+Q/mxb/lib18Ht49BItxiqEUyQU2Bf
	 Z5uLcJBnmLZEBFuOn+x4ju/Got0rXky9wDz8IyuUEi3opEBlpmkNvDh3B4kOoPY1rp
	 m2BVniLWCBGuos0/Wf8sXPNR1C0tp5Qlf+KSM/oHXFTz8ya+X6Yb+w4NRmEjYG7Hac
	 5RaZfqd1Z/1aa0ZxmjaKUDoPfOx7OP1ZWEdjWq0PeFc1ypeYjOEVtHB7iuEqhINpCb
	 oWVM2dINzb8RQ==
Date: Wed, 20 May 2026 19:03:24 +0100
From: Simon Horman <horms@kernel.org>
To: Cyrill Gorcunov <gorcunov@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com
Subject: Re: [PATCH v2] ice: Fix wrong dsn read in ice_adapter_put
Message-ID: <20260520180324.GC988238@horms.kernel.org>
References: <agQ_xZUp3Sq905O_@grain>
 <20260517125307.287246-1-horms@kernel.org>
 <ago_YTTWiZs6G8_5@grain>
 <agrjuAlzsV0RqAwU@grain>
 <agsj4Rrexhkqao0c@grain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agsj4Rrexhkqao0c@grain>

On Mon, May 18, 2026 at 05:36:17PM +0300, Cyrill Gorcunov wrote:
> On Mon, May 18, 2026 at 01:02:32PM +0300, Cyrill Gorcunov wrote:
> ...
> > 
> > Thinking more I think I got what sashiko meant here: the pullout of the
> > adapter when it been in recovery mode already, and reading register state
> > is obviously incorrect here too, instead we have to save the state upon
> > probing in some flag and use it later. I'll update the patch.
> 
> Here is an updated. Actually even in recovery mode the ice_deinit_devlink()
> may call for rd32() with undefined result as
> 
>  | ice_health_deinit
>  |  ice_config_health_events
>  |    ice_sq_send_cmd_retry
>  |      ice_sq_send_cmd
> 
> unless I miss something obvious... (i don't address this in the patch).
> Please take a look once time permits.
> 
> ---
> From: Cyrill Gorcunov <gorcunov@gmail.com>
> Subject: [PATCH v3] ice: Fix wrong dsn read in ice_adapter_put
> 
> When registering an adapter instance, we read the PCI configuration
> space to fetch the DSN and generate an adapter index for lookups.
> 
> However, if the adapter has been physically unplugged, the PCI space
> is no longer accessible. Reading it returns a zero value, which results
> in either an incorrect adapter instance being put or the proper instance
> not being put at all. To fix this, we will use the previously known
> index instead.
> 
> Similar applies to recovery mode detection -- if card has been in
> recovery mode and physically removed we're not allowed to read its
> state from hardware registers but rather provide state flag for
> this.
> 
> Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>

Thanks Cyrill,

I agree that this is a good approach.

I might suggest splitting the patch in two:s
1. introduce and use ICE_FW_RECOVERY_MODE
2. Address dns nread in ice_adapter_put
