Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D253333D6F9
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 01:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791338214; cv=none; b=itcVVJkoWwNaSm9oRH6uknkJx4+9tE319oy99mVQcPKr6Fvq1WiIKCJ+raoN7TGhR1HkD+UqCqyEUcJ88bbYXUDQt85ycF8A0hfBqYhqDUW43a9vO7t/l+OPbPOg2f/8DU5SDERf5uDeEmTof5KmFY6xBD6mjAss9OUQlgCLsvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791338214; c=relaxed/simple;
	bh=aaoTkzvGraljyhIZpjL82TahsK7uxoazLyixX/8oTGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fu1xVQOabVAZ9P45TpU+DY7wPAlIzNTazqZQjELOlFi30MjhNQDt4MbokMjsTsJEDGiJaHXtMLo9STnzXan9DPJUcJtllHL9ZlqwlZsYrSRMya0OIPaCmB/FIASwoOHxOR915iR3s/xC4h4asal1d9jHRBVAntQA5bTAH7jKBzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr; spf=pass smtp.mailfrom=snu.ac.kr; dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b=y6OhR2d2; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b="y6OhR2d2"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3a4c80d3d5aso1669602a91.0
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 18:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snu.ac.kr; s=google; t=1791338209; x=1791943009; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1ydTs/xapg98AneWzvg1UmYdjd9wqdEiZ1v4vRT6sJY=;
        b=y6OhR2d2m+kPGSMpzLRpu72k9x303GXzOQbLbVIJV6Nh30ylnetL9thCHXjGDWGzdW
         KgW91FQbabUvOaTqYJmK5T/bq30O2p2t3169/sEpQUMGxxfF4LoL4nvq819rNhaZgk3Z
         fJMrFUPwWofs7mAzExYn4bzpD6Yc4ZOvssU50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791338209; x=1791943009;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1ydTs/xapg98AneWzvg1UmYdjd9wqdEiZ1v4vRT6sJY=;
        b=RdhZmv7Rh0fpo1jsha28r3JRJstc+A8Y0qozZpZEEws3FYOG8djPR04jZ1dX3/Mv9E
         ij7abxr29C2sPPIdRMGIScBm6Jkn/GbwfiNvns6JNyx5U8qIwi0t6GGG9dc2aCNzQCb0
         IgCovLnBUFVuv23fGkyxCPg4kximl2c72j3IW0/YtMbYiOzLKvN/iYvXadQG6rugrEwn
         avM4ouLEdsFngkB1D3diT+uKqKFiqqWgJ34pK5xHlglN14GZdZpUSAz4FlsUQyXNd4+8
         MxOnVE4wRvJmql1bTtZ6sV6nt2trrwQPbvBrE+PKyNvE9nnXDYOhrO/EFU8/+HyD2ooL
         2zkg==
X-Forwarded-Encrypted: i=1; AKwUvBzKFHNKY4QX+ua8swdqh4VvKs2bA6eoIUuw+BAs2JQ5VA1AV6tfyaL5AYgpiORbuE6SwIcKcBs=@vger.kernel.org
X-Gm-Message-State: AFq9FYKUTFCmEeeAQy269Bn8VVLMMzYwRXVnrI+8i5OIpreJ4r9R9CVO
	DOD4MdqYyFZ8UO4ea4lRdM14NHu199pjmVN/w0bcrCGF9mEKlx7rdYHBGjNze9c3bNc=
X-Gm-Gg: AYBFou2UnYwGuyIs7Gy2mKsfLdEBCb8hDYHKqFmjSBEwp+r16b+j2hjnpkwKeU+Gats
	XgSScGjsanGGxjrPRNBlB4kUp4Nx5r9k7YuE4Lzp4cRUgFbhmSkxPL09Gg8dQajzPGVwOvWgYUe
	w5yyTGO5gpC7Bd0sNGlO9v2l6o2d0gXY6oTHFSnuJmq6dNbxezxratgtmqo7xpi/YzlW0smldU8
	PWPrr6nSO2U+lR3mIR/0zsxhAwU2i4uYyLHDcuW3ewaQGj6PRmMMXpyABvcvl7lHeNNCQdAZpMt
	S15wof8puClnxXqbxspFIBG8T+whZA/acmWZZ0obrakkdgXy2weh09J2EgRkRhX7F3dNcb1bPsb
	XFfOWfSYL5bzPccChlYwyhOLALx+1dkVOywzep0qchLcqW1WAWcmdFrb5ax+VYjFmrULB5ZQhri
	NCWRXoszshE4quQG9mioud/FvRe4+XvEQQOYU2DhodWtOqA/+43ZFo79e8GAfleqaB
X-Received: by 2002:a17:90b:4a44:b0:3a5:37e7:7118 with SMTP id 98e67ed59e1d1-3a8a0741012mr737133a91.16.1791338209145;
        Tue, 06 Oct 2026 18:56:49 -0700 (PDT)
Received: from 1c1aead48890 ([49.142.45.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a89ab84fa7sm2045718a91.4.2026.10.06.18.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 18:56:48 -0700 (PDT)
Date: Wed, 7 Oct 2026 01:56:43 +0000
From: Seongjun Hong <hsj0512@snu.ac.kr>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net/mlx5: allocate DMA pool structs on the
 pool's NUMA node
Message-ID: <elnyg2237rbomihddfd6b2vjoqonvdyl5fgcnzyquzn4kk5u6g@t3jm4ppczv5i>
References: <20261006-net-mlx5-numa-allocate-pool-page-v2-1-0dc4c2eb1376@snu.ac.kr>
 <345a40de-5353-477d-8be2-8c4e6468875e@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <345a40de-5353-477d-8be2-8c4e6468875e@intel.com>

On Tue, Oct 06, 2026 at 02:57:28PM -0700, Jacob Keller wrote:
> On 10/6/2026 7:16 AM, Seongjun Hong wrote:
> > The mlx5 DMA pool structs (mlx5_dma_pool, mlx5_dma_pool_page and its
> > block bitmap, and mlx5_frag_buf_node_pools) are allocated without a
> > node hint, so they land on the node of whichever CPU happens to create
> > or fill the pool, while the DMA pages they describe are allocated on
> > the pool's node.
> > 
> > The pool, page and bitmap are dereferenced on every block allocation
> > and free. Allocate them on the pool's NUMA node as well, so that all
> > of a pool's state lives on one node.
> > 
> > These allocations happen on the control path, so the performance gain
> > is expected to be small; the change is mainly for consistency.
> > 
> > Signed-off-by: Seongjun Hong <hsj0512@snu.ac.kr>
> > ---
> > Changes in v2:
> > - fix typo and specify the structs are allocated on the control path
> > - add a prefix net-next to the subject
> > - Link to v1: https://lore.kernel.org/r/20261005-net-mlx5-numa-allocate-pool-page-v1-1-01f4283932b4@snu.ac.kr
> > ---
> >  drivers/net/ethernet/mellanox/mlx5/core/alloc.c | 11 ++++++-----
> >  1 file changed, 6 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/alloc.c b/drivers/net/ethernet/mellanox/mlx5/core/alloc.c
> > index a92cf545bdaf..dcd281c4691d 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/alloc.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/alloc.c
> > @@ -110,7 +110,7 @@ static struct mlx5_dma_pool *mlx5_dma_pool_create(struct mlx5_core_dev *dev,
> >  {
> >  	struct mlx5_dma_pool *pool;
> >  
> > -	pool = kzalloc_obj(*pool);
> > +	pool = kzalloc_node(sizeof(*pool), GFP_KERNEL, node);
> 
> This removes all the benefits of kzalloc_obj() here...

Do you mean type checking on compile?

> 
> But I guess the __alloc_objs API doesn'thave the ability to add a node?
> It seems like we'd benefit from having support for the node parameter..
> but it does seem tricky to add. kzalloc_node_obj() could potentially be
> added. Staring at the implementation I have no idea how complicated that
> would be.
> 
> Still, this only really changes two allocations and they're pretty
> obviously correct.
> 
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> 

Jacob, thanks for the review.
As far as I know, there is no node-aware variant of _obj APIs yet,
so kzalloc_node() was the only option here.

> >  	if (!pool)
> >  		return NULL;
> >  
> > @@ -127,19 +127,20 @@ mlx5_dma_pool_page_alloc(struct mlx5_dma_pool *pool)
> >  {
> >  	int blocks_per_page = BIT(PAGE_SHIFT - pool->block_shift);
> >  	struct mlx5_dma_pool_page *page;
> > +	int node = pool->node;
> >  
> > -	page = kzalloc_obj(*page);
> > +	page = kzalloc_node(sizeof(*page), GFP_KERNEL, node);
> >  	if (!page)
> >  		goto err_out;
> >  
> >  	page->pool = pool;
> > -	page->bitmap = bitmap_zalloc(blocks_per_page, GFP_KERNEL);
> > +	page->bitmap = bitmap_zalloc_node(blocks_per_page, GFP_KERNEL, node);
> >  	if (!page->bitmap)
> >  		goto err_free_page;
> >  
> >  	bitmap_fill(page->bitmap, blocks_per_page);
> >  	page->buf = mlx5_dma_zalloc_coherent_node(pool->dev, PAGE_SIZE,
> > -						  &page->dma, pool->node);
> > +						  &page->dma, node);
> >  	if (!page->buf)
> >  		goto err_free_bitmap;
> >  
> > @@ -278,7 +279,7 @@ mlx5_frag_buf_node_pools_create(struct mlx5_core_dev *dev, int node)
> >  {
> >  	struct mlx5_frag_buf_node_pools *node_pools;
> >  
> > -	node_pools = kzalloc_obj(*node_pools);
> > +	node_pools = kzalloc_node(sizeof(*node_pools), GFP_KERNEL, node);
> >  	if (!node_pools)
> >  		return NULL;
> >  
> > 
> > ---
> > base-commit: 8b4e7209c842d8cb9516f1f5ef0a88aa2d8831a6
> > change-id: 20261005-net-mlx5-numa-allocate-pool-page-2ee20a04147e
> > 
> > Best regards,
> 
> 
> 

-- 
Seongjun Hong
