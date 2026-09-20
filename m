Received: from mta0.migadu.com (out-22.mta0.migadu.com [91.218.175.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0F8320A34
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 02:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789873008; cv=none; b=mi/6aOJpH/qh+IC0H//IQp2Nj5of/jQTHncPiucd3qe74fOh1TN0gyTxvYiksrXpgAVf4xW9WsmXP6wiC/n2KhSD8ZwDe6HoF7QMdCMaVQ9XMC8+hG3h2v2c4GAGUfqWFlrFLVYiDeH+XkzCcvfkgeGg1+szXlRndwFgsZbrQiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789873008; c=relaxed/simple;
	bh=Bco5cIF9YtJ73wsQY2eBCJPnbm50a31lAwWnkS6/+s0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d36+QD3I76MaHm1ZdEMb8Tjl/Hyafu3loizK2RjgPtCyZ+gz/8I6TjHpI/RG49r6pM+ljvJ9HwJmsNnFEbj/aoPEotl4HvLnZhGHeAEA5F6skhHDZ/0oepPtLhy9bdfsRdjVsrcwmYPWVMPS4QaFz2nEQjdbJbU7FTI7AdltMag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MHxV3E2H; arc=none smtp.client-ip=91.218.175.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MHxV3E2H"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Bco5cIF9YtJ73wsQY2eBCJPnbm50a31lAwWnkS6/+s0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789873004; v=1; x=1790477804;
 b=MHxV3E2HMAekHMLXjAFvT3Ty0ULisrSKEWgeOE7/ITdd0ZtQ92kTZhZq5CZNGcijVv80j1no
 2H++EKeemfgeu9+PU2K2ri5+oD1LMBkMs2GGB9R/gyi6Kt1QoE10jrjsE1QlDB+LwDr5AObUF0h
 3fRWie5P8uS25xAaSsXkrq8o=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id bec7489f1fff1ce1;
	Sun, 20 Sep 2026 02:56:44 +0000
X-Mizu-Trace-ID: bec7489f1fff1ce1
X-Migadu-Flow: FLOW_OUT
Date: Sun, 20 Sep 2026 10:56:33 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Sanghyun Park <sanghyun.park.cnu@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Stevens <dlstevens@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] vxlan: use one headroom snapshot for neighbour
 replies
Message-ID: <aq9LYXO9RTt3OXW9@fedora>
References: <20260918032842.502409-2-sanghyun.park.cnu@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918032842.502409-2-sanghyun.park.cnu@gmail.com>

Hi Sanghyun,
On Fri, Sep 18, 2026 at 12:26:58PM +0900, Sanghyun Park wrote:
> vxlan_na_create() samples LL_RESERVED_SPACE() to size the reply skb and then
> samples it again to reserve headroom. A concurrent vxlan_changelink() can
> update needed_headroom between the two reads, creating a TOCTOU race. The
> second value can exceed the allocation and make the Ethernet header write out
> of bounds.
> 
> The race is reproducible on the unpatched kernel. It occurred when
> vxlan_na_create() generated a neighbour reply while vxlan_changelink() changed
> the link headroom. KASAN caught a four-byte write two bytes beyond a 704-byte
> skbuff_small_head allocation.
> 
> Snapshot the headroom once and use that value for both allocation and
> reservation.

What if `vxlan_changelink()` extends the link headroom and we need a much
larger headroom, yet we only allocate a small skb from snapshot?

Thanks
Hangbin

> 
> Fixes: 4b29dba9c085 ("vxlan: fix nonfunctional neigh_reduce()")
> Signed-off-by: Sanghyun Park <sanghyun.park.cnu@gmail.com>
> ---
> v2:
>   - Improve the v1 changelog
> v1: https://lore.kernel.org/r/20260831054614.2069896-2-sanghyun.park.cnu@gmail.com
> 
>  drivers/net/vxlan/vxlan_core.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
> index c1d54339fa2b..3390e341d1e5 100644
> --- a/drivers/net/vxlan/vxlan_core.c
> +++ b/drivers/net/vxlan/vxlan_core.c
> @@ -1958,13 +1958,15 @@ static struct sk_buff *vxlan_na_create(struct sk_buff *request,
>  	struct ipv6hdr *pip6;
>  	u8 *daddr;
>  	int na_olen = 8; /* opt hdr + ETH_ALEN for target */
> +	int headroom;
>  	int ns_olen;
>  	int i, len;
>  
>  	if (dev == NULL || !pskb_may_pull(request, request->len))
>  		return NULL;
>  
> -	len = LL_RESERVED_SPACE(dev) + sizeof(struct ipv6hdr) +
> +	headroom = LL_RESERVED_SPACE(dev);
> +	len = headroom + sizeof(struct ipv6hdr) +
>  		sizeof(*na) + na_olen + dev->needed_tailroom;
>  	reply = alloc_skb(len, GFP_ATOMIC);
>  	if (reply == NULL)
> @@ -1972,7 +1974,7 @@ static struct sk_buff *vxlan_na_create(struct sk_buff *request,
>  
>  	reply->protocol = htons(ETH_P_IPV6);
>  	reply->dev = dev;
> -	skb_reserve(reply, LL_RESERVED_SPACE(request->dev));
> +	skb_reserve(reply, headroom);
>  	skb_push(reply, sizeof(struct ethhdr));
>  	skb_reset_mac_header(reply);
>  
> -- 
> 2.48.1
