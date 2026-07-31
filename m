Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CF83B05B0
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 07:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785483755; cv=none; b=WJPPVrCoOEDViLff0UT3+h1v9oLrVXda1J+tYRQF07VR4vRiI3EC4a/7W3+v63s3KS8IE89Bvi+iTjf1N0SAo8kX860vetf12yHkJPbJ3UpqQbEAM/l/xXuKYy02vv7Qq8b44twxPRvzesmH6+rtekWF0OY+50orqwUgv+WHt6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785483755; c=relaxed/simple;
	bh=q8XpgHCUOvT3D/2ywHlOhi5pXNd87Ng5kB+Y/RltCu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ota4xstZsvOyby4Cze+pJzrRycPbp0YFVpdZ2cmnbfUJTIcYdgsFUIuyrykIvVsZtiOpLE1k6LM8xwtxY2CwTuIJe5+3SzL2QXQkgaj+W6XFvfJ5pCDPei5vm2R/t0HaZgb1k2h46mZk77ecjNQho3up6nuhy19n4nZowOEy6y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iG2cYPrS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iG2cYPrS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 456A71F00A3A;
	Fri, 31 Jul 2026 07:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785483751;
	bh=FFaIEiqXOswkD09MczFoBFv4NcZyzjzVaslzhiJM1+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iG2cYPrSQTmIoIiXxlGyq/dr1E65vN8rmQ2biXIScv20KLIrl88oYuA/44ZeYKgng
	 KbXm5tfQx8X8EQ2WM3EBPsEBoQAQxKfkOOfAop31WAC7urz5exYh2Ds1XqKgdc3q+f
	 6436hx5knnraXPlWjMJCb7VMzcrrPbqfQ3f1a2/56ofwaqHVd65kfVvEPhcvBt+A11
	 hC09HOD0evhsxl5meqULrLvsROI5DgptRiDR1XXVwBcoBVqriH5x6AyqV3geYtci+d
	 rTv7JWmeoqM3kaCX54rnaB5Cl8ju3d1LgcUQuJA7uKMGDhJWMYgBXZCEZV50V4IOyK
	 G49fUzZzZVZ0g==
Date: Fri, 31 Jul 2026 09:42:28 +0200
From: Antoine Tenart <atenart@kernel.org>
To: Kenneth Lee <kennethbwlee@snu.ac.kr>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, rhkrqnwk98@gmail.com
Subject: Re: [PATCH net] net: ip_gre: use checksum-aware trim for ERSPAN
Message-ID: <amxPmrfUFbSUNmgE@kwain>
References: <20260730085220.985948-1-kennethbwlee@snu.ac.kr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730085220.985948-1-kennethbwlee@snu.ac.kr>

On Thu, Jul 30, 2026 at 05:52:20PM +0900, Kenneth Lee wrote:
> ERSPAN currently uses pskb_trim() when truncating packets to the device
> MTU.  For a CHECKSUM_PARTIAL skb, that helper can leave csum_start and
> csum_offset pointing at a checksum field outside the new packet length.
> The skb can then reach skb_checksum_help() during transmit validation,
> which warns when the checksum offset is beyond skb_headlen().
> 
> Use pskb_trim_rcsum() in both ERSPAN transmit paths.  It rejects a
> CHECKSUM_PARTIAL skb whose checksum field is no longer in the trimmed
> linear data and returns -EINVAL.  The existing error paths then free the
> skb instead of transmitting inconsistent checksum metadata.

Can you include a description of the MTU and kind of packet that
triggers this?

> Fixes: f192970de860 ("ip_gre: check packet length and mtu correctly in erspan tx")
> 

Extra empty line.

Wasn't pskb_trim called before this commit?

> Found-by: Sechang Lim <rhkrqnwk98@gmail.com>

This is not a known tag,
https://docs.kernel.org/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes

(You should used Reported-by: here).

> Signed-off-by: Kenneth Lee <kennethbwlee@snu.ac.kr>
> ---
>  net/ipv4/ip_gre.c | 4 ++--

Looks like the IPv6 counterpart has the same construction, can you
check?

>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
> index 169e2921a851..16f80620f6d1 100644
> --- a/net/ipv4/ip_gre.c
> +++ b/net/ipv4/ip_gre.c
> @@ -576,7 +576,7 @@ static void erspan_fb_xmit(struct sk_buff *skb, struct net_device *dev)
>  		goto err_free_skb;
>  
>  	if (skb->len > dev->mtu + dev->hard_header_len) {
> -		if (pskb_trim(skb, dev->mtu + dev->hard_header_len))
> +		if (pskb_trim_rcsum(skb, dev->mtu + dev->hard_header_len))
>  			goto err_free_skb;
>  		truncate = true;
>  	}
> @@ -723,7 +723,7 @@ static netdev_tx_t erspan_xmit(struct sk_buff *skb,
>  		goto free_skb;
>  
>  	if (skb->len > dev->mtu + dev->hard_header_len) {
> -		if (pskb_trim(skb, dev->mtu + dev->hard_header_len))
> +		if (pskb_trim_rcsum(skb, dev->mtu + dev->hard_header_len))
>  			goto free_skb;
>  		truncate = true;
>  	}
> -- 
> 2.53.0
> 
