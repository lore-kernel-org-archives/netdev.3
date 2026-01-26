Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5DB31354C;
	Mon, 26 Jan 2026 10:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769422191; cv=none; b=Q6v+wapmCfoEJsTe2q8HtPWQ4kvhM9Ys1qXfxf+OnCkd2a6DBzJXeIBo7DYO+t1zJTgcIRyvKJEv4RUHY2KsndJD0/YlHaTCb3ZzDRjY/k7f4vxggoWpv+mjRTjjC/XexuT0sckWNooIAAgD+LDR+D969zPWCcadnC9BTVutESk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769422191; c=relaxed/simple;
	bh=EqxYhk3eOK2oVjIDJzcbmtWjJuaTxw29jJAJZKAfBF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m6fQbvSgfGMcokPejwFrXrbvChDBbakXptjSvW1PWsmhkwR/zFvv+mDo85zhBSrZ6OVjWz1uk6pgF2eNCmsMD3MfC2h2ltlw1mhFUfgPu08cIvqR44xJd0vvxWmV0ABOhp1B4Cdop0g0Ozxr7Z0pqfjqPxYK8f+uKGmUf29vZ4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OYtvyX57; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OYtvyX57"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C13C3C116C6;
	Mon, 26 Jan 2026 10:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769422189;
	bh=EqxYhk3eOK2oVjIDJzcbmtWjJuaTxw29jJAJZKAfBF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OYtvyX57BzmaZzbtQtSPIK2oUdpnl3bHRmMp6JO45v1s1iSTKyIZ1+TzzUJEtwJnt
	 vMT+05piGhM8hTRybMDo6uIHOmYpG/daMhJpHWw7dNGNOwA0eo69kFs9wJs8ipiVIw
	 eB0D7qqPjlUNtXAn57IBcoiyhp0YSukmPKFOlbv/uWB7n1hBplNVKzzwFAHRINa3zC
	 7okw/87c2RwpNxQ+t8uDU3tDDPUvbpG8UeB/0zEb/X64SSGAJehSg2kM4UyBncV9s0
	 v2HPazGYR5eZCBwoy3T4/cWh86+jO3C6zH4l5QS2SvU2pWwe4z9mI+GUjEopgh/5Lp
	 anjUAN4AU8imA==
Date: Mon, 26 Jan 2026 12:09:42 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: Zilin Guan <zilin@seu.edu.cn>, michael.chan@broadcom.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn
Subject: Re: [PATCH net] bnxt_en: Fix memory leak in bnxt_alloc_mem()
Message-ID: <20260126100942.GI13967@unreal>
References: <20260122092623.479177-1-zilin@seu.edu.cn>
 <CALs4sv3STBARmMOZiBSXHtFkXd3E_hJwjWJ0x8zJ1_cYYw=ioA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALs4sv3STBARmMOZiBSXHtFkXd3E_hJwjWJ0x8zJ1_cYYw=ioA@mail.gmail.com>

On Thu, Jan 22, 2026 at 03:14:08PM +0530, Pavan Chebbi wrote:
> On Thu, Jan 22, 2026 at 2:56 PM Zilin Guan <zilin@seu.edu.cn> wrote:
> >
> > In bnxt_alloc_mem(), the function allocates memory for bp->bnapi,
> > bp->rx_ring, bp->tx_ring, and bp->tx_ring_map.
> >
> > However, if the allocation for rx_ring, tx_ring, or tx_ring_map fails, the
> > function currently returns -ENOMEM directly without freeing the previously
> > allocated memory. This leads to a memory leak.
> >
> > Fix this by jumping to the alloc_mem_err label when allocation fails,
> > which ensures that bnxt_free_mem() is called to properly release all
> > allocated resources.
> 
> This fix is not needed. The memory is freed by the caller of bnxt_alloc_mem().

That is an anti-pattern as well. On error, the function should clean up
all resources it allocated.

Thanks
