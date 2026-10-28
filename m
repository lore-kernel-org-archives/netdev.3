Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793195888;
	b=q0K8byXWe0eDWmlM8A7qpfzopGgKKUHP3xMoqMLhdwHv/mY8jNNH/ji7137S/obAi/5w
	 MPuUEVGDiEOYqqUDHVtBbxa/RukjYuGIw1bFBaB3Pzfwkvo20oJg9mMgZfGVEG0pd4ua5
	 RuaU6a4Q8iMVAPQNjDySX1o9LdC+rq6I/6qqpFm2bqcOVK3xzGImJ/uS/6SFditQE7fV6
	 4dUnwlAntoAgy8TelWa4RS/RNbDOuRrJDkeHiHMxVH1U1DC5Hk8Uok9ZeSDDatSb8bDpL
	 ZiJlWVf7kul1Je/4pAz3wm8MroHiw4QKPudAd09WMuHJOQsKwLr75vUiF48MRqa8K2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793195888;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=GGRsKTAn8IeetVf0W9FghBtAZl4UYxsMc6UB2iDRZlY=;
	b=jI1KPAmKxVBj/bpGKjrcj2lc+QMRPJyF2y6MdiWLpdNxDE9ReAKqS2eQuXv6yO++EmKr
	 fMSs/TdcWA/eR5WsW6Tlu+XbNKZpoN4PxWfQk1I8FWD67tkLH8inVPwLKh3HXfdnqfQBH
	 WiMFqxbQBiljwdKcoCeyXyION/iH9hyByvwO4ZJ9zrBcRBwTihsbCNmomPGshlyz9LKhF
	 AieWSp4OyRj1S3KSpmzMC+vaPOx+XiC5kFpNXIu549CONcSoNEZXxReVJUEV+f2Ld9G4p
	 KcZHvG6A1lVyh/Mq3CKRS3yP4n/Gy1q+m8t1wEEq+yFjjwffYTg5U3xpfCPFGtxnZ5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=me9cRhOG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF452606A31A;
	Wed, 28 Oct 2026 13:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=me9cRhOG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8BA41F01825;
	Wed, 28 Oct 2026 13:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793195887;
	bh=GGRsKTAn8IeetVf0W9FghBtAZl4UYxsMc6UB2iDRZlY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=me9cRhOGJ9KCZcPC0hq/CdqhOngzj4vTSpqfxRJ8fQAK4Aaf3ykBgE83Ejove2huD
	 zN1vJHq4yp3aTXU1AbDWcNmdELYjJWzdDzeJVd73HO6Hz6fVvnN7Qw/QDSBaIUA+IM
	 BNTiSutsWv5QLhmvPfaQlHiUsmqgc/kCz8M0IGrC7e6r0P6gtpLua8x0lGyOx7PneR
	 dDJofbn1F8oUB9VnL5eXs9F1bPZ5wQAnRkqBy9LGsjyeSJHpi14UlvciRRJG1ZDPek
	 xPtY53cwrtkyVy4oMEIPzR8Fz2HV86wZWmKMiCC0x7aIhOMpLjtBJdSdPbRbbIpahb
	 bb9R9t3wy1VOg==
Date: Wed, 28 Oct 2026 13:58:02 +0000
From: Simon Horman <horms@kernel.org>
To: Vikas Gupta <vikas.gupta@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bhargava.marreddy@broadcom.com,
	rahul-rg.gupta@broadcom.com, vsrama-krishna.nemani@broadcom.com,
	rajashekar.hudumula@broadcom.com, dharmender.garg@broadcom.com,
	ajit.khaparde@broadcom.com
Subject: Re: [PATCH net v3 1/2] bnge: cap RSS contexts and RX rings to the
 RSS table size
Message-ID: <20261028135802.GT257209@horms.kernel.org>
References: <20261026092757.9168-1-vikas.gupta@broadcom.com>
 <20261026092757.9168-2-vikas.gupta@broadcom.com>
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
In-Reply-To: <20261026092757.9168-2-vikas.gupta@broadcom.com>

On Mon, Oct 26, 2026 at 02:57:56PM +0530, Vikas Gupta wrote:
> From: Dharmender Garg <dharmender.garg@broadcom.com>
> 
> The hardware supports at most BNGE_RSS_TABLE_MAX_TBL (8) RSS contexts.
> They are stored in vnic->fw_rss_cos_lb_ctx[8] and back a 512-entry
> (BNGE_MAX_RSS_TABLE_ENTRIES) indirection table and DMA buffer, so at
> most 512 RX rings can be served by RSS.
> 
> bnge_cal_nr_rss_ctxs() has no upper bound, so with more RX rings it
> returns more than 8 contexts: bnge_setup_vnic() writes past
> fw_rss_cos_lb_ctx[], bnge_set_dflt_rss_indir_tbl() and
> bnge_fill_hw_rss_tbl() write past the indirection table and its DMA
> buffer, and the pad computation in bnge_set_dflt_rss_indir_tbl()
> underflows into a huge memset().
> 
> Cap the number of contexts at BNGE_RSS_TABLE_MAX_TBL and the number
> of RX rings at BNGE_MAX_RSS_TABLE_ENTRIES, so the sizes derived from
> the ring count always fit the arrays.
> 
> Fixes: 627c67f038d2 ("bng_en: Add resource management support")
> Signed-off-by: Dharmender Garg <dharmender.garg@broadcom.com>
> Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
> ---
>  drivers/net/ethernet/broadcom/bnge/bnge_resc.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_resc.c b/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
> index 4711dd4945ff..b540eed12fc6 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
> @@ -182,8 +182,9 @@ int bnge_cal_nr_rss_ctxs(u16 rx_rings)
>  	if (!rx_rings)
>  		return 0;
>  
> -	return bnge_adjust_pow_two(rx_rings - 1,
> -				   BNGE_RSS_TABLE_ENTRIES);
> +	return min_t(int, bnge_adjust_pow_two(rx_rings - 1,
> +					      BNGE_RSS_TABLE_ENTRIES),
> +		     BNGE_RSS_TABLE_MAX_TBL);
>  }

nit: I expect that min() is sufficient here as the return value of
     bnge_adjust_pow_two is unsigned and BNGE_RSS_TABLE_MAX_TBL
     is a non-negative constant.

That notwithstanding this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

...
