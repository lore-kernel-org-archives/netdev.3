Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D6F48986B;
	Thu, 24 Sep 2026 13:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790256580; cv=none; b=ciET3iconjVNLvlP6EH0mzyQCxGd5ObnrMecdsh3ZEliXwy+uAXK6WUOu6JnMAgChsifEvz/FcCV5mp9Q8+XIkZdwVaGrWWX9xYBrlbx/d+fSztrhapes487IX03qndxfOkzWRjnMOS8tjxEyzR1iwiieXeTJG0L8uRZfmf551o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790256580; c=relaxed/simple;
	bh=Wn0h0nC/v6/vZwYyh+YABKKYnd3PJ8mwkZdXdeLwO0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f2+UkYemCXP+3Lk3lZMjnpi+0q/gv58ndlnCDX18Pdp/+VvSAMmtviNRHj+3W5RA3zE/olLHo019ae3CrgawVJB4NHK7Oz+1Gw9mw0U7nn+kARA341OylDIJ6/Asb1qfXwair7VVsN6hpCm3fsIxHFGjAp1HtkvIgOwIukSrQqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zk1XZmo6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zk1XZmo6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABABA1F000FF;
	Thu, 24 Sep 2026 13:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790256569;
	bh=67y9kaimjq2VniwiKCMsp2XrFz2PUat4wCUfkM8Rkeo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Zk1XZmo6es6B2zCBtqV6RxhHUZZsHXE6DUuDA5K67pSDuVndyy+xpfJd3mPO3P0dV
	 hHkKhUyB9kPa9surDnpm9sCcJKBYd7t2y0O41oktqo90Piwy3UynTdsew7AJjhQ/pE
	 1cLgDrGftxtuzSCBbVClWva9S2zN3By8ao8CbL9rgTOhhsb0qVGY6IQ1KjM66SWxET
	 d05diY8fZaDyN6dSPS/iJq7p2Eu3Df0gLj+b+Y20Jyb93ePQH/t4dTCnLZddbkTIx4
	 mxl+/YwcikHh1Nv3HE09OMo3dl8pVzwUFtCCZwlTr7xGpbwhx101IDyED8mqSDxOCB
	 xWPtzjBQ5KMbQ==
Date: Thu, 24 Sep 2026 14:29:25 +0100
From: Simon Horman <horms@kernel.org>
To: Linkui Xiao <xiaolinkui@126.com>
Cc: aleksandr.loktionov@intel.com, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Linkui Xiao <xiaolinkui@kylinos.cn>
Subject: Re: [PATCH net v3] i40e: limit the DDP profile count returned by the
 firmware
Message-ID: <20260924132925.GF13925@horms.kernel.org>
References: <20260922091123.506598-1-xiaolinkui@126.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922091123.506598-1-xiaolinkui@126.com>

On Tue, Sep 22, 2026 at 05:11:23PM +0800, Linkui Xiao wrote:
> From: Linkui Xiao <xiaolinkui@kylinos.cn>
> 
> i40e_aq_get_ddp_list() writes into a I40E_PROFILE_LIST_SIZE buffer, which
> is sized for I40E_MAX_PROFILE_NUM (16) i40e_profile_info entries plus the
> 4 byte p_count header. i40e_ddp_does_profile_exist() and
> i40e_ddp_does_profile_overlap() then loop over profile_list->p_count
> without bounding it, so a firmware reporting more than 16 profiles makes
> both helpers walk past the end of the on-stack buff[] and compare against
> whatever happens to follow it on the stack.
> 
> The same buffer is handed to the firmware as an indirect admin queue
> buffer, and the admin queue code copies all of it into the DMA bounce
> buffer before submitting the command, so its uninitialized contents were
> visible to the device as well.
> 
> Zero initialize buff[] and reject the list when the firmware reports more
> profiles than the buffer can hold, instead of answering from a list that
> was only partially read. Both helpers already report errors to
> i40e_ddp_load(), which aborts the operation.
> 
> Fixes: cdc594e00370 ("i40e: Implement DDP support in i40e driver")
> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
> ---
> Changes in v3:
> - Zero initialize buff[] in both helpers: the whole buffer is copied into
>   the admin queue DMA bounce buffer and copied back afterwards, so its
>   contents were exposed to the device, and entries the firmware never
>   wrote were compared against. (Sashiko AI review)
> - Reject the list when the firmware reports more profiles than buff[] can
>   hold, instead of silently clamping the scan and then answering from a
>   list that was only partially read. (Sashiko AI review)
> - Dropped the Reviewed-by tag, as the code changed after the review.

Thanks for the updates.

Reviewed-by: Simon Horman <horms@kernel.org>

