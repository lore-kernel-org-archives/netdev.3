Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE82C337BAB
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 18:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784052244; cv=none; b=rNMTsXZIPptZ/DXR6gwb+9wfVLGSIvsN78o63upXO1O3dw/7P/aE5SoG+eTIiPhGGlMP/GJwlqIfUr2wvuDPJsyQ38nq35AHpiyf7JKWI5kFXQdwfVbQHmraKTgZQsGkhUL0pvMcTBcPOFvnNYDxFILVjk+lkkbhrVX35Chkt/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784052244; c=relaxed/simple;
	bh=HO8Q8vDJJ6X3nKLzA8Ugjl0nVKU6c/2LRMY5qr2jOPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pFGjBA2Hy03nM07D6yMEGLbIM6m0SaySyMELJ8rI2wr+IXr8kSiSVG6nBZ8k/PRql4NsdCQUseqG+tBp24CPisWrwsGndPdXEW/yMvTpv+hRoUKRVvt9LZap6+jYZ6x9ZokD4Z6lfuiDIlAXPLwLPKVUQhgAMcRbA9x9q7UW7Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A4f7LP12; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A4f7LP12"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCEC21F000E9;
	Tue, 14 Jul 2026 18:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784052243;
	bh=aOuzucrNKHJIcV2zJQgz693DKy+bvRbE02cKNhl4zt0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=A4f7LP12myIhTqFeScXgUNtm0Q3huz748IfPLofSOIs7KJ3vAPyBsth45eAPemnuE
	 sZWXKJ1KwkeCbP+j5aBxjJXFvnnPIuk/qHP4EXxTh66tvaMqJBc0vVoaGEz13dHFk7
	 dWWZ5sECp6ZVxQt/I90pvOocDkQLCebu+hunxBtQPd5EWUr3QxDwnK9WhFQCTJmDaE
	 tZyYv8FVMP/2FRZriylBIz4NM6Wazn3LzzFQ7gTlClFJ8EpfldykqcOaGPYyUQkoBH
	 kEOWlsrhLl6SatZ6Q5yH8M+UfCjNtH+7YRxfAZ/D2dJ8+gkUcazMW/NXl1yUOXDpRn
	 idPRdyiCtNm0A==
Date: Tue, 14 Jul 2026 19:03:59 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH v2 net-next 1/3] geneve: pass geneve_config pointer to
 helper functions
Message-ID: <20260714180359.GN1364329@horms.kernel.org>
References: <20260707145331.3717941-1-edumazet@google.com>
 <20260707145331.3717941-2-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707145331.3717941-2-edumazet@google.com>

On Tue, Jul 07, 2026 at 02:53:28PM +0000, Eric Dumazet wrote:
> In preparation for converting geneve->cfg to an RCU-protected pointer,
> update helper functions to explicitly accept a const struct geneve_config
> pointer instead of dereferencing geneve->cfg directly.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  drivers/net/geneve.c | 140 +++++++++++++++++++++++--------------------
>  1 file changed, 76 insertions(+), 64 deletions(-)
> 
> diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c

...

> @@ -1306,14 +1313,14 @@ static int geneve_build_skb(struct dst_entry *dst, struct sk_buff *skb,
>  }
>  
>  static u8 geneve_get_dsfield(struct sk_buff *skb, struct net_device *dev,
> +			     const struct geneve_config *cfg,
>  			     const struct ip_tunnel_info *info,
>  			     bool *use_cache)
>  {
> -	struct geneve_dev *geneve = netdev_priv(dev);
>  	u8 dsfield;
>  
>  	dsfield = info->key.tos;
> -	if (dsfield == 1 && !geneve->cfg.collect_md) {
> +	if (cfg && dsfield == 1 && !cfg->collect_md) {

Hi Eric,

Sashiko.dev seems to think that the cfg guard is purely defensive.
Which does seem to be the case.
Perhaps it is an artifact from the development of v2?

>  		dsfield = ip_tunnel_get_dsfield(ip_hdr(skb), skb);
>  		*use_cache = false;
>  	}

...
