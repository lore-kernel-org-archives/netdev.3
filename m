Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EB640DB3A
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 16:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785342787; cv=none; b=BTVUuE5WIz4983Gn5fvu65atTOiWpr+nCqdmDqGYt/unaaMVZw1RlMN/gK+2S6TloFUn55T8jX/glflEPWRsR/8E1WGyR4aKaYRhtPMmvIJhtg4EILAXeTQ2gAXgO+leT7R0UWSzrellZaqQBrXP0RG668uAwt87MjjQvP77fL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785342787; c=relaxed/simple;
	bh=/4XUSjwFIMzU/ofJvehDBkb4qTc5c53Yt9jPhCQa1Zc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jxlNsyiTjC3omz7PrL+A8RZEc0uwm6hNv/Wd/9AL0/7vJIiVoTIxpf/3Bvu2HAuxUT/5+9aAKZ2nDwUMS5nR74Jqsg+6k9pX8W7MhIw0+gNYRZAwyT/ydJi8qeDOE5hVqfzcOOkKIpfCut4H3uCH1Ti2BASe5ChyxacsQzTmQDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qgn5PVBQ; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qgn5PVBQ"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-384930ca5e2so994504a91.3
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 09:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785342785; x=1785947585; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fArv74sVKQZ0CBDPXzKJ26kTPH49bXsdYCIt+szposY=;
        b=Qgn5PVBQ8pu96bgenzbkcQs1VTplQN7+cQWi6I0EwLy8YNPqig6KVtHIOrb131Ic9B
         P1fFR8BgQBd8DsgbWH/sE5qBo3srTeyDrpbA5u4aZkbcIjygSLrFM5wxW1NNkFgQhgvT
         myw79vus+8Ccc+neTEKYopYkA4HVrf+hiEBfxoaKAeHiET7YiQ64oQNDPC5rOKjPx6SR
         O6frWIcYJWbfFxQtWKyK2tIslhVEvbvuxRuosYkS1WzmHVzLm2wayrSx6R09i3BtDBjw
         /3jSInR8+HtvlJh++OVgB7Yl7K0QbUm1aHWXZu0f0utZaT+Qv0TjvszsuPeSzAMvSjqR
         Ib5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785342785; x=1785947585;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fArv74sVKQZ0CBDPXzKJ26kTPH49bXsdYCIt+szposY=;
        b=PLL/jSDWf3ySgLUpACLukaHuyBcOZiGeUNGw7gZr47EbWV93a52H3pH9A9LUTQONuJ
         nkwgM2o9Py68890bm401LEhxJS2Op3DCHeSKCkzYDITE/ZB49UMvHiI5rweg9KoFqQZK
         HRUqdcZ3oKe/EHhSTcdD2LaxIkvWz1qDRVawJPT4GoagyHSYUDVHO6wRYr84oBYQIKAh
         izncn385PRm+g0PNhXKA1p06zZBE+iQFEZIyPAfm9CWzlIKgGMU1t/utD1FdkYS6f3ty
         6i5YtmFgeZVWEvztJFQ1vVTEnlyt8TxlR7olZ5ihEpjNQgrTkS4Tbz/zNSRJU7OKDD+v
         W6iQ==
X-Forwarded-Encrypted: i=1; AHgh+RrhjLlbYZl0BLm/5bWW2lrQmJeME0weOoxugRt8DHZFxV+QltYdMhH/YY0D3rghzy8cSfS09fs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTxyjeiTyrpKHciiEZFZrtFHmzpnCqy/+BcXO0OWI5WSSGlr9m
	6GjP54F0Y1qJBAwgueNm236RlRl3VVrksCKl5taJoWXZC2SZEdwBX0m2
X-Gm-Gg: AR+sD10BkLkJKMZwGBnT4rm21wt5B6vNuAOE/SotwIDULaqemapPbmSXQ4IJ35Rf27e
	5Tn4QG3rmPOqLd2Ztz4sKcwV+NF8QV+rf7B/PXiVXnZYQfGyx9lyMaXjb0D2ZaeOJfF4FYQjMzH
	fVGSjH4be4SrkEKaVsEsmc4CdGrR4LijZr263+jimPecUivfMkadnGShBLxHDAhUri6VxYbprwK
	S/Qq1UbfHnrLIYMSSGDFulDFN9doPVRgdjDt/F/SIh84zgIVPOxn1BiJl7gBfLXVF8bdPBSx4Lu
	7UfOr88ro44B/k2mtEllfgkaYD8r+IAK3KyVe0UEAGpzgQrSdXenbUwwRefDlewqCAlM0Ap+fMg
	VkZpeJd7Keqf1HlS5p+eh3p3uIXkDQsqiYj0JXGIk6y3gVh3xu8H6QJP2i/Dr4BncZzQveb+xHk
	nBjWCOT8lsoY++f7y6mR7eGNfDchpm+3++DP99MKRT9ZWHfbm+coUU32LDiBUCWQsp6rsxcummI
	5rkj+o2Mw==
X-Received: by 2002:a17:90b:4ad0:b0:38e:11ba:992e with SMTP id 98e67ed59e1d1-38f6a544ac8mr6261749a91.35.1785342785061;
        Wed, 29 Jul 2026 09:33:05 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:4f::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f7f12bcbcsm1672033a91.6.2026.07.29.09.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 09:33:04 -0700 (PDT)
Date: Wed, 29 Jul 2026 09:33:02 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net] net/mlx5e: fix BQL reset on SQ re-activation
Message-ID: <amorPql8QJRbCNJW@devvm29614.prn0.facebook.com>
References: <20260728-mlx5-bql-v1-1-99a0ab77ede7@meta.com>
 <756e9c86-38f3-4a94-833f-afb0559397a3@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <756e9c86-38f3-4a94-833f-afb0559397a3@nvidia.com>

On Wed, Jul 29, 2026 at 03:32:56PM +0300, Tariq Toukan wrote:
> 
> 
> On 29/07/2026 0:47, Bobby Eshleman wrote:
> > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > 
> > mlx5e_queue_start() deactivates and re-activates all channels but closes
> > only the queue being restarted. mlx5e_activate_txqsq() then
> > unconditionally calls netdev_tx_reset_queue(), zeroing the BQL counters
> > of channels that kept their in-flight TX WQEs. The next completion then
> > over-charges and trips the BUG_ON() in dql_completed():
> > 
> >    kernel BUG at lib/dynamic_queue_limits.c:99!
> >    RIP: 0010:dql_completed+0x23d/0x280
> >    Call Trace:
> >     <IRQ>
> >     mlx5e_poll_tx_cq+0x668/0xa60
> >     mlx5e_napi_poll+0x5b/0x7b0
> >     net_rx_action+0x15a/0x580
> > 
> > Reset BQL only when the SQ has no bytes in flight (sq->cc == sq->pc).
> > 
> > In the case that reset is skipped, the outstanding WQEs will eventually
> > complete and rebalance the dql. The dql->limit is carried across the
> > reset.
> > 
> > Fixes: b2588ea40ec9 ("net/mlx5e: Implement queue mgmt ops and single channel swap")
> > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > ---
> >   drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 4 +++-
> >   drivers/net/ethernet/mellanox/mlx5/core/en_tx.c   | 3 ++-
> >   2 files changed, 5 insertions(+), 2 deletions(-)
> > 
> 
> Thanks for your patch.
> 
> Overall the fix LGTM, just one comment below.
> 
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> > index 4a8351f95b27..44834890a409 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> > @@ -1940,7 +1940,9 @@ void mlx5e_activate_txqsq(struct mlx5e_txqsq *sq)
> >   {
> >   	sq->txq = netdev_get_tx_queue(sq->netdev, sq->txq_ix);
> >   	set_bit(MLX5E_SQ_STATE_ENABLED, &sq->state);
> > -	netdev_tx_reset_queue(sq->txq);
> > +	/* Reset BQL only when the SQ has no bytes in flight. */
> > +	if (sq->cc == sq->pc)
> > +		netdev_tx_reset_queue(sq->txq);
> >   	netif_tx_start_queue(sq->txq);
> >   	netif_queue_set_napi(sq->netdev, sq->txq_ix, NETDEV_QUEUE_TYPE_TX, sq->cq.napi);
> >   }
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
> > index 0b5e600e4a6a..d0ad1b8d6988 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
> > @@ -909,7 +909,8 @@ void mlx5e_free_txqsq_descs(struct mlx5e_txqsq *sq)
> >   	sq->cc = sqcc;
> >   	/* Do not update BQL for TXQs that got replaced by new active ones, as
> > -	 * netdev_tx_reset_queue() is called for them in mlx5e_activate_txqsq().
> > +	 * netdev_tx_reset_queue() is called for them in mlx5e_activate_txqsq()
> > +	 * if the queue has zero in-flight WQEs.
> >   	 */
> 
> Please drop this hunk. In this path the replacement SQ is always freshly
> created, so cc == pc == 0 and the reset always happens - the qualifier
> invites the reader to worry about a case that cannot occur here. The
> original wording is accurate as-is.

Ah makes sense, thanks. Will re-send with the change!

Best,
Bobby

> 
> >   	if (sq == sq->priv->txq2sq[sq->txq_ix])
> >   		netdev_tx_completed_queue(sq->txq, npkts, nbytes);
> > 
> > ---
> > base-commit: b515dc54795ef370be3cb396e7c12ad91686b6d1
> > change-id: 20260728-mlx5-bql-84e02a5a46c8
> > 
> > Best regards,
> 
