Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E0D3019D7;
	Wed, 18 Mar 2026 15:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773847126; cv=none; b=rVo6BG2gIVlDl2OmetAoOdw1UwkmzLBY3Q8Hu6T3ZfjZcnBjuCs8B1J7cjN6nhGGxS8v2S8q8FvwM8cE9VI3cntXtGAxdIye6RnadTwvY8K5TB4jXNqxV3afGB37Iz2Ig4vnjzSoUFPZzNDPjLPa19fMk5bqZmOdVP5ED460Oqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773847126; c=relaxed/simple;
	bh=2nBxS0U9/2i2CwQhkSs7sIJph5hX1qEpMmRI0wYhxu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XYQSVtGY2ZgdJY5YVPRfEERCghDtqZrP3RdwDR0pa53wWyOwc4wKmcnOV4Fe/TgWpTGhHAd5tFpCUsUTWRKBx3K/iaqhP8PLOtwGZtUHjqaux/zG0ExsUgTiBGdsmocQpjQ4+Ls0+JXmKrSFBNFOe2bXUbnkmm3r+wPDGl3Fg2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6yahNeG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6yahNeG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50242C19421;
	Wed, 18 Mar 2026 15:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773847125;
	bh=2nBxS0U9/2i2CwQhkSs7sIJph5hX1qEpMmRI0wYhxu8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T6yahNeGhUWPLaUTwOxeb3tid3+SSavAO4xpqAniJ7Jg56vcb9QlQVPgKH5hScoxK
	 cib3k/HS0765AA9ppgKPO9DksfKl/d+avR4vifxcDDHgHFsELT/5qWDs0A8xgxRPqN
	 IC1OYohZevcJb99NhMr3Zah6TWH/GCaEdmGy+i3kom4EV+LGCXBdUTSGVURtNSAw+r
	 lwwEd7ArpUaI2LGABT2UKw8TmVteKwLTdeXXUyB1f9sbVyJVZ5Vwh+tcO0BDZd7xvz
	 l7vm7BuHby2nnyE2ui4pwHCe93CTsVvLYY8il+X7wTD0acOKbp8EDN7iZKqV8XIN1M
	 A7iXakKkj8G3g==
Date: Wed, 18 Mar 2026 15:18:40 +0000
From: Simon Horman <horms@kernel.org>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, sgoutham@marvell.com,
	gakula@marvell.com, bbhushan2@marvell.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Linu Cherian <lcherian@marvell.com>
Subject: Re: [net-next PATCH 3/4] octeontx2-af: npa: cn20k: Add debugfs for
 Halo
Message-ID: <20260318151840.GD1753385@horms.kernel.org>
References: <1773665859-4036-1-git-send-email-sbhatta@marvell.com>
 <1773665859-4036-4-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1773665859-4036-4-git-send-email-sbhatta@marvell.com>

On Mon, Mar 16, 2026 at 06:27:38PM +0530, Subbaraya Sundeep wrote:

...

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c

...

> @@ -1204,6 +1210,20 @@ static void print_npa_pool_ctx(struct seq_file *m, struct npa_aq_enq_rsp *rsp)
>  		seq_printf(m, "W8: fc_msh_dst\t\t%d\n", pool->fc_msh_dst);
>  }
>  
> +static inline char *npa_ctype_str(int ctype)

Please don't use the inline keyword in C code unless there is a
demonstrable - usually performance - reason to do so.

Also, I wonder if the return type for this function should be const.

> +{
> +	switch (ctype) {
> +	case NPA_AQ_CTYPE_AURA:
> +		return "aura";
> +	case NPA_AQ_CTYPE_HALO:
> +		return "halo";
> +	case NPA_AQ_CTYPE_POOL:
> +		return "pool";
> +	default:
> +		return NULL;
> +	}
> +}
> +

...
