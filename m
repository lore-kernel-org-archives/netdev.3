Received: from mta0.migadu.com (out-65.mta0.migadu.com [91.218.175.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F4C3A4F58
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 01:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790214525; cv=none; b=PsEpy28w+puWyCPi6vWqBea9Wiia+2RXjL2VF3c8rldqBKXsuEzP+tiVe9VjPozGz4/xY/C+khG4wLgFKUb/0g2wNV8qE3Vb/kfGd0h1X4+irvIL2A5kSTZVQuXFtMlvPZ7E9Gfxe0zCJEFm7c6HKIiPSDFkU74oS+B2zVvP09U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790214525; c=relaxed/simple;
	bh=iRr8SffShJ1oq9NlkGJ+0e0damwpcx2FCOJTg5mJhtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pOXWUjbJ/WZUG549Cq2skB+Rk8yrHUSGnZmoqtE9JIFGLhGCFkYSdC3nl8l4khTTj/RuTI6ibhfAnRi96ypUIRcdvAgdpXcXgs40eH+0NcibfJAnCXvKVrc1YMpoEdzqe2XUxwS1Sc5kD4lP55tXs5jLK1KSTpHcedgEqsw04GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tgCzWHrx; arc=none smtp.client-ip=91.218.175.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tgCzWHrx"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=iRr8SffShJ1oq9NlkGJ+0e0damwpcx2FCOJTg5mJhtc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790214521; v=1; x=1790819321;
 b=tgCzWHrxyNz3HHCDc0ziEK/zkFIdC7+//qHbKcc0iEPbqDmSyZoVTnU9EoXrnG46KXOXmSVs
 YCV64Qijk7/DS63kvMHU3uzGamwAEx+sYkqRgh8GL7eX8uFu8PCXyQeSSWwY1DICBWzs102wAuA
 M4S4D2uCiTYlPEDitSHXpchg=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 7e083c7940206ab8;
	Thu, 24 Sep 2026 01:48:41 +0000
X-Mizu-Trace-ID: 7e083c7940206ab8
X-Migadu-Flow: FLOW_OUT
Date: Thu, 24 Sep 2026 09:48:33 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com, Zixuan Chai <petalzu987@gmail.com>
Subject: Re: [PATCH net] vlan: ensure sufficient headroom in
 vlan_dev_hard_header()
Message-ID: <arSBcaIwhIjbg4De@fedora>
References: <20260922113924.3165190-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922113924.3165190-1-edumazet@google.com>

Hi Eric,
On Tue, Sep 22, 2026 at 11:39:24AM +0000, Eric Dumazet wrote:
> Callers that only reserve ETH_HLEN or less (such as llc_alloc_frame() or
> br_send_bpdu()), or skbs allocated before dynamic device/headroom
> changes (e.g. toggling VLAN_FLAG_REORDER_HDR or bonding/team switching
> slaves), can reach vlan_dev_hard_header() with insufficient headroom and
> trigger skb_under_panic().
> 
> Use skb_cow_head() in vlan_dev_hard_header() when VLAN_FLAG_REORDER_HDR
> is not set to ensure sufficient headroom for the VLAN header(s) and the
> underlying device hard header.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: Zixuan Chai <petalzu987@gmail.com>
> Closes: https://lore.kernel.org/netdev/cover.1789987105.git.petalzu987@gmail.com/
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/8021q/vlan_dev.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
> index 2859cbac3f266b7c4e3f44f41280d33ab69c5270..3598ad0779f050d25c6110de476fe9613137f983 100644
> --- a/net/8021q/vlan_dev.c
> +++ b/net/8021q/vlan_dev.c
> @@ -55,6 +55,9 @@ static int vlan_dev_hard_header(struct sk_buff *skb, struct net_device *dev,
>  	int rc;
>  
>  	if (!(vlan->flags & VLAN_FLAG_REORDER_HDR)) {
> +		if (skb_cow_head(skb,
> +				 dev->hard_header_len + dev->needed_headroom) < 0)

Should we use LL_RESERVED_SPACE() here?

Thanks
Hangbin
> +			return -ENOMEM;
>  		vhdr = skb_push(skb, VLAN_HLEN);
>  
>  		vlan_tci = vlan->vlan_id;
> -- 
> 2.55.0.1082.g2b9226bbc0-goog
> 
