Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A37D2C0260;
	Mon, 22 Jun 2026 11:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782128065; cv=none; b=iX7VI4CIwb0Tdcl7ARtETtJCGuG5xi+NKPw395e7uuOg83pFb1rzAwUFAj3GRS9HzYj/PhfLAhEeNkOhZiBeVR8N9u2KMuLNK13BRK8GAIF/rKbQGo6ADIz/oiDTV3d+6IQJXk+SFSFU+asGU0LWMw29JAFgzsk0MVPqVkJAzjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782128065; c=relaxed/simple;
	bh=8GsnyOIFXzb4TqaaDS3uXsdYZCjWxu0esHdTEhXVSOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r8ta2nSDsLYu8oEXh+fhwXjqu4IldTP92VzEaIza6WCfwEwmpoITupxzY4mWFfyGWmxwCNsbisO7ZhEtSCLX/D4XChLQk2nHp+f4hL1ROC9YTI0VG0y3/K54P8+EV7xEB2+oa2tbkn2YYbkFu9XYXIiAJLEDDKI7dlAR7p2tXaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=APoEj4Ny; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="APoEj4Ny"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00E091F000E9;
	Mon, 22 Jun 2026 11:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782128063;
	bh=/A3vADDqKy+2FXKvl4UZBKYzGOCuP5pisLV8KH9oGEY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=APoEj4Ny+oUijEwR5iQnNPsmgnr7A9+H2T9EYrWGL4bhcRUv9XZQK8/kuZfvBlbxJ
	 evBaShc0E7egTC/wkPQGhWmlTIjHu+f/gCSTbkStVCPEBPjn3kcBW1dvEPgNMJeRSC
	 WzuHTbnSZHy4yqpqFs7uaiPatVvvM/OQhLRZ3wXND3HMTx3XTwt1OOvQwIq8l2/Fts
	 2Bpc4pAGrovDHNLgEhdvGlXBy6pbszG+nO+tvw34tF3vp6DHSgyWTLtC83h1Av6zws
	 Ic8WzOyiP1oHuPSL/AvPnqw8T2uGHwsBORfoOWOYzexVRieHtqakDXyBN/AK/0jt84
	 hJUYioRxYpMyg==
Date: Mon, 22 Jun 2026 12:34:19 +0100
From: Simon Horman <horms@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, sgoutham@marvell.com
Subject: Re: [PATCH net v2] octeontx2-af: npc: cn20k: Fix subbank free list
 indexing for search order
Message-ID: <20260622113419.GB827683@horms.kernel.org>
References: <20260619095100.1864440-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260619095100.1864440-1-rkannoth@marvell.com>

On Fri, Jun 19, 2026 at 03:21:00PM +0530, Ratheesh Kannoth wrote:
> subbank_srch_order[i] is the physical subbank at search-order slot i,
> so each subbank's arr_idx must be i (its slot), not
> subbank_srch_order[sb->idx].  The old logic mis-keyed xa_sb_free
> and broke allocation traversal order.
> 
> Populate arr_idx and xa_sb_free in a single pass over the search
> order after subbank structs are initialized.
> 
> Fixes: 7ac9d4c4075c ("octeontx2-af: npc: cn20k: add subbank search order control")
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> 
> ---
> v1 -> v2: Addressed simon comments
> 	https://lore.kernel.org/netdev/20260619091341.918165-1-horms@kernel.org/

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>

FTR, I think the issue flagged in the AI-generated review of this
patch on sashiko.org can be treated in the context of possible follow-up.
I don' think it should impede the progress of this patch.

