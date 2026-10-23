Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792750042;
	b=izdUZI+BCHcOfvrl9Lb0kb11ID26aMZUgHIMqyflYlHFd16GjpDFrKemybkD4viRAUUY
	 YUcMssOmu2EFbwoFcfcpblohy5Bd/IdR5O+lplDuD0UrPC51FZMlznYcAtHNxNjprVbtG
	 ZsLrNzC77oNaV51KEJP05RDoxf+DSxgICHIjMY0Rx0Nv9JRmzIrsuMX/dGTopfqAaXzwn
	 umAYDfMreJX/avGKygS28YqUm/zw8+bEeW97ZONLenHmSGEU2TDU863aesSiUGv6Ra5bd
	 yR1kvXNRWbxjav2J/BbFLCsAMkXSDIA0Sx7EJ6NduRzjq0FMo5Z1qkQ5E4NZa+INE5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792750042;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=XQ6Qd7ctqTH9VpQVAVjBYXB1YUNZlX9qcPa7bFOPumQ=;
	b=nrXDFyvs92Nll7W8/tpVhjwq+9nB2xl+duGdUA6ep4Y0LCANLI2NvMPePwzT2D10OY79
	 W2bOIL4vPxeHIlTLTLfi3Ij61tqSzReZYdBZszj1RGPoyDqseA42eXS4R3JConshDSdFd
	 mlXth3AdNiKH7yuDndad/piMzfSN+aS2Emd5vOHhvbuR25VE6y+1npuU80z5Gd2PgOml8
	 0LmSg7P8ilbi/RxOpro7dbKcIuOgazBEZZDXA2Eig2YKLeh5n01h4daBGaCy8sE4xPd+s
	 8Sbo8TN6LUeijXhPOgbkExdDpbAObRkWLoVDangp03W827TAJp4VHlwV3chtmj2FoXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TXGxo9xu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D458606A31A
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 10:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TXGxo9xu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 858C11F01825;
	Fri, 23 Oct 2026 10:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792750042;
	bh=XQ6Qd7ctqTH9VpQVAVjBYXB1YUNZlX9qcPa7bFOPumQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TXGxo9xuwO/LJzFcJ2SARJZzMcVZVlzPkIyh9HqrUqED2y1v/ooZ3YQn94qYOMeuX
	 NfBMB1F2gKrN0DGQKV5JILer8vNKixFxsyhj4fuMlCBFCIAnD26WEzTHF1/g2rNr7h
	 ercPN5RVLGRm7IVVDFn+/IA/hC+iJ97GNAzXs08ZSLP8QAa5m4aTHxSvLY5GiBLlNZ
	 RwqesT6E1rPQepE/w01UfIAZhubALyZJeiYlZn450+TCXoOsyCsKdIvOli7Kz1FNNC
	 2fpEq3o3zUcOxv2Xdh2PhAbEJtxVVfsIjS+I1zfwIR2mp10LNrwf6Pxv/wkgWeYS5a
	 h+d6ZObz3a2rg==
Date: Fri, 23 Oct 2026 12:07:18 +0200
From: Antoine Tenart <atenart@kernel.org>
To: Dudu Lu <phx0fer@gmail.com>
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: xps: bound the cleanup loop by the old map's
 num_tc
Message-ID: <atsw048yjNvNmFmk@kwain>
References: <20261021155538.67867-1-phx0fer@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261021155538.67867-1-phx0fer@gmail.com>

On Wed, Oct 21, 2026 at 11:55:38PM +0800, Dudu Lu wrote:
> __netif_set_xps_queue() walks the OLD dev_maps to free its entries.  The
> per-row trip count uses the NEW num_tc while the row stride uses the OLD
> dev_maps->num_tc, so when dev->num_tc was raised without rebuilding the
> XPS map the last row indexes attr_map[] past the allocation:
> 
>   BUG: KASAN: slab-out-of-bounds in __netif_set_xps_queue+0x1458/0x1ee8
>   Read of size 8 at addr ffff000014f69458 by task insmod/112
> 
> The loop frees entries in dev_maps, so both the trip count and the stride
> must come from dev_maps->num_tc.  The map is sized
> XPS_CPU_DEV_MAPS_SIZE(old num_tc)/XPS_RXQ_DEV_MAPS_SIZE(old num_tc, ...),
> so iterating the new (larger) num_tc reads past the end.
> 
> Fixes: 255c04a87f43 ("net: embed num_tc in the xps maps")
> Assisted-by: LLM
> Signed-off-by: Dudu Lu <phx0fer@gmail.com>

Reviewed-by: Antoine Tenart <atenart@kernel.org>

> ---
> Tested base
> -----------
> Detected on Linux 7.3-rc4 (commit 93f51579e7df), arm64 QEMU guest.
> Re-checked against mainline f47d223627f8 (v7.3-341): the affected code
> is unchanged between the two, so the bug is still present there.
> Checked against linux-next next-20261021 (commit 9a482184d910): the
> affected code is unchanged there as well, so the bug is still present in
> linux-next too.
> 
> Reproducer status
> -----------------
> A reproducer was written and executed on an arm64 QEMU guest (KASAN); it
> fires at the claimed sink, and still fires on a kernel built with 4da3b7b8b50f
> applied.  The guest has no ndo_setup_tc NIC, so the reproducer stands in for
> that hardware with a small module that raises dev->num_tc the same way an
> in-tree driver does.  The reproducer source is not posted here per
> Documentation/process/security-bugs.rst; it is available on request.
> 
> Triggering conditions
> ---------------------
> CAP_NET_ADMIN to set the XPS mask.  dev->num_tc is raised in-tree by the
> drivers that implement ndo_setup_tc (the Intel i40e/ice/ixgbe/iavf, mlx5
> and mvneta families, among others) and by the mqprio/taprio qdiscs.  The
> QEMU guest used for the reproducer has no such NIC, so the num_tc change
> was driven through a small module; the defect itself is reached in-tree
> on that hardware.
> 
> Notes
> -----
> Built and checkpatch-clean: this patch was applied on top of 7.3-rc4
> (commit 93f51579e7df) and a full arm64 kernel (defconfig) was built with
> it -- no new warnings or errors.  scripts/checkpatch.pl reports 0 errors,
> 0 warnings.
> 
>  net/core/dev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index e76762e29360..3023f0ca4713 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -3003,7 +3003,7 @@ int __netif_set_xps_queue(struct net_device *dev, const unsigned long *mask,
>  		goto out_no_old_maps;
>  
>  	for (j = 0; j < dev_maps->nr_ids; j++) {
> -		for (i = num_tc, tci = j * dev_maps->num_tc; i--; tci++) {
> +		for (i = dev_maps->num_tc, tci = j * dev_maps->num_tc; i--; tci++) {
>  			map = xmap_dereference(dev_maps->attr_map[tci]);
>  			if (!map)
>  				continue;
