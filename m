Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A1F2DEA93;
	Wed, 16 Sep 2026 05:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789536986; cv=none; b=Rz6T9qZm6Szqh/4zB4sLVQKNRWXhMN98OYFrVNQ9OEiVAbYZ+HB6KAA0YvIwciiTP3wRiTBv8uPxYTvjvAlOIYWjFh9d5xfYUIHJ6zKjHJ9qA9VEViTd4fC4LYlrkB7p2nlF83r1MzJF5u/1lsIUImPexJU6/AZJS3ynr6QvP0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789536986; c=relaxed/simple;
	bh=6CSki8oXQ9r96gPmio9pI3wDPMyJ9FCJU/vdVVPjIb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qFMNaeicf1CqG1ZSHs2pkAI6NIZUbZl1X3ZuGlqti54aAF5qYicXTGvZErrwGw/yxcRHoeEMxPoUzDgPftNl9K89DET/1RUICcZC6Jj6cTDUIS/WC0CAKSL02QOO9inoHJ6zkwYq+N/fmjU4u2k0Zf7cge0RmuzMBX2MslPTBj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mx9MoT6G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mx9MoT6G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 713381F000FF;
	Wed, 16 Sep 2026 05:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789536985;
	bh=6fNqwUyRYw4wI/6pMel3zHowqqHSYPYMRGW/eYkFdJU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Mx9MoT6GuA+YrKibM/ey2OM4T9XPqeYVVLBDTzXhe25iw9xP8BQ/O+2JY8aFOwdaz
	 ZPBZiPyVSjd9mxcHlbwpNK8sEAYDyamn4/1SdUDYmIf7rsqjrnbMDYz7YSMyr6Aqsv
	 NzklMDFGV/dEPTfCvWWmE+OZZnt/wxdReK/CTDaQBPDykyyT3dKabnmyqChDvPsdA0
	 5e2sfnYugkuJbuDeE6p9dvidugD3anwUxlZUbu2kRq8f+9OUgk7f3DOWyftGu/eqbt
	 KytbrFcF7BraNAqX+fqKLfCvmwhDdSqfRNwQu+IdNRYsPf6nRO9R/zUelTm7Iy/zGj
	 MwsovY/Tm0JIw==
Date: Wed, 16 Sep 2026 08:36:21 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: davem@davemloft.net, gakula@marvell.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, sgoutham@marvell.com, andrew+netdev@lunn.ch,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net] octeontx2-af: Fix memory scaling limitation in
 SR-IOV mode
Message-ID: <20260916053621.GS13683@unreal>
References: <20260916022111.1083017-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916022111.1083017-1-rkannoth@marvell.com>

On Wed, Sep 16, 2026 at 07:51:11AM +0530, Ratheesh Kannoth wrote:
> The original code used DMA_ATTR_FORCE_CONTIGUOUS, which could exhaust
> the CMA pool when a large number of VFs were requested.
> 
> Fix this by switching to the DMA streaming API. This is equivalent on
> Octeon platforms, which provide full I/O coherency via the SMMU.
> 
> Cc: Leon Romanovsky <leon@kernel.org>
> Fixes: 73d33dbc0723 ("octeontx2-af: Use DMA_ATTR_FORCE_CONTIGUOUS attribute in DMA alloc")
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> 
> ---
> v9 -> v10: Updated commit message as suggested by Leon
> 
> v8 -> v9: Addressed Leon comment.
> - Used kzalloc instead of kmalloc.
> 
> v7 -> v8: Addressed Leon comments.
> - Replace __get_free_pages() and __GFP_COMP with kmalloc()
> - Drop GFP_DMA32 retry loop and dma_capable()/phys_to_dma() mask probing
> - Use dma_map_single()/dma_unmap_single() instead of dma_map_page_attrs()
>   with DMA_ATTR_REQUIRE_COHERENT
> - Remove defensive parameter checks and dma_max_mapping_size() from the
>   allocator helper
> - Move MAX_PAGE_ORDER validation to qmem_alloc()
> 
> v6 -> v7: Addressed Sashiko comments.
> 	https://lore.kernel.org/netdev/178863855246.219967.10510865726694393307@kernel.org/
> 
> v5 -> v6: Addressed review comments.
> 	https://lore.kernel.org/netdev/20260901015621.2708182-1-rkannoth@marvell.com/
> 
> v4 -> v5: Fixed compilation issues.
> 	https://lore.kernel.org/netdev/20260831024210.208447-1-rkannoth@marvell.com/
> 
> v3 -> v4: Fixed compilation issues.
> 	https://lore.kernel.org/netdev/apTpKcN_S1xIwRbZ@rkannoth-OptiPlex-7090/
> 
> v2 -> v3: Addressed sashiko comments.
> 	https://sashiko.dev/#/patchset/20260825045616.3723078-1-rkannoth%40marvell.com
> 
> v1 -> v2: Rewrote patch as per sashiko comment.
> ---
>  .../ethernet/marvell/octeontx2/af/common.h    | 45 ++++++++++++++++---
>  1 file changed, 39 insertions(+), 6 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leon@kernel.org>
