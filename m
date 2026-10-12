Received: from mta1.migadu.com (out-200.mta1.migadu.com [95.215.58.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B22B440A2C
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 09:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791797298; cv=none; b=eZ5C0oHnt39/lBQfYB9QhlthI+jMMQMSv3NBXHRR2I90hZt3nycXmv6/B4igjeEfc2/oSw2gursrhGtmpyYvCnY9z8EF29kWFo2Vz1SaBiFB643L6O7AModqhpDVnTiGMgdR9GadYZYe+6P5ss5U0Zox+Kjj7m5gyThUMSY6Jjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791797298; c=relaxed/simple;
	bh=pH88RZZhMUO+72nSU0zMXA1Vsw+3gSUAjVT/E/uSjCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iunMnusFS9VDrCpl/tVSnipNzk0w8YhKHanxsE/J5LhUwVgZDtLWMcGSZGb7pqk/fry/V5tOdiNxQFkiVVET/3lkwE9GSTRsfRvohiqYPRGe1iyeomyS4zNBRC1vI4YAIh4/7RyplVTpSMbL6OgUhH7LITAiwc/ceUaCIZW7Coc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AB3Kg6zP; arc=none smtp.client-ip=95.215.58.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AB3Kg6zP"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=pH88RZZhMUO+72nSU0zMXA1Vsw+3gSUAjVT/E/uSjCY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791797294; v=1; x=1792402094;
 b=AB3Kg6zPzCKD4q28IOfvYaCNzlVLZtnK240tJUcHbtnWZdisrScorFNs7HdThIq2SsySAt6x
 58eElE4wn8y6oLjGpnGQVwzlJ4ZFLbXvhROjqHyFtQHszS/uu3zJZ26twjvjXFo1G1YVUdlNBNk
 NLrRm2Ba7DxI7XEVqJVBAsQ4=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id fb9bf159fe42bfa0;
	Mon, 12 Oct 2026 09:28:13 +0000
X-Mizu-Trace-ID: fb9bf159fe42bfa0
X-Migadu-Flow: FLOW_OUT
Date: Mon, 12 Oct 2026 17:28:06 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
	Justin Iurman <justin.iurman@gmail.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Ahmed Abdelsalam <ahabdels@cisco.com>,
	Stefano Salsano <stefano.salsano@uniroma2.it>
Subject: Re: [PATCH net-next 2/5] seg6: handle a consumed SRH in SRv6 End
 with the PSP flavor
Message-ID: <asyoJvcaU14ip-d4@fedora>
References: <20261011192310.55-1-andrea.mayer@uniroma2.it>
 <20261011192310.55-3-andrea.mayer@uniroma2.it>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261011192310.55-3-andrea.mayer@uniroma2.it>

Hi Andrea,
On Sun, Oct 11, 2026 at 09:23:07PM +0200, Andrea Mayer wrote:
> With the seg6 inline mode, a packet can carry more than one SRH. The
> SRHs with Segments Left 0 are considered consumed SRHs, and they can
> come before the SRH to process (Segments Left > 0), as in this packet:
> 
>   +------+----------------------+----------------------+---------+
>   | IPv6 | SRH, Segments Left 0 | SRH, Segments Left 1 | payload |
>   +------+----------------------+----------------------+---------+
> 
> End without flavors skips the consumed SRH and processes the next
> one [1]. With the PSP flavor, End should do the same. When the SRH to
> process arrives with Segments Left 1, as in the diagram, End with PSP
> should then also remove it [2]. However, End with PSP alone currently
> looks only at the first routing header of the packet, finds Segments
> Left 0 there, and drops the packet.
> 
> Make End with PSP alone skip the consumed SRHs, and any other routing
> header with Segments Left 0, and process the SRH that follows them. If
> there is no SRH to process, the packet is dropped as before. When the
> SRH to process arrives with Segments Left 1, End with PSP now removes
> it even if consumed SRHs come before it.
> 
> Found by manual code inspection and reproduced in a VM without kernel
> changes or error injection. A following commit adds tests for this case
> to srv6_end_flavors_test.sh. Without this change, the new tests with a
> consumed SRH fail for End with PSP alone. With this series, all tests
> pass and KASAN reports no error.
> 
> [1] - https://datatracker.ietf.org/doc/html/rfc8986#section-4.1
> [2] - https://datatracker.ietf.org/doc/html/rfc8986#section-4.16.1.2
> 
> Fixes: bdf3c0b9c10b ("seg6: add PSP flavor support for SRv6 End behavior")
> Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>
> ---
>  net/ipv6/seg6_local.c | 29 +++++++++++++++++++++++++----
>  1 file changed, 25 insertions(+), 4 deletions(-)
> 
> diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
> index da8225591fe3..26cd4facbe36 100644
> --- a/net/ipv6/seg6_local.c
> +++ b/net/ipv6/seg6_local.c
> @@ -775,11 +775,14 @@ static bool seg6_pop_srh(struct sk_buff *skb, int srhoff)
>  		skb_set_transport_header(skb, thoff);
>  
>  	iph = ipv6_hdr(skb);
> -	if (iph->nexthdr == NEXTHDR_ROUTING) {
> +	if (srhoff == sizeof(*iph)) {
>  		iph->nexthdr = srh_nexthdr;
>  	} else {
>  		/* we must look for the extension header (EXTH, for short) that
> -		 * immediately precedes the SRH we have just removed.
> +		 * immediately precedes the SRH we have just removed, i.e. the
> +		 * EXTH that ends at srhoff. We find it by its position and not
> +		 * by its nexthdr, since another routing header (e.g. an SRH
> +		 * with SL = 0) may come before the removed SRH.
>  		 * Then, we update the value of the EXTH nexthdr with the one
>  		 * contained in the SRH nexthdr.
>  		 */
> @@ -807,7 +810,7 @@ static bool seg6_pop_srh(struct sk_buff *skb, int srhoff)
>  				break;
>  			}
>  
> -			if (hp->nexthdr == NEXTHDR_ROUTING) {
> +			if (off == srhoff) {
>  				hp->nexthdr = srh_nexthdr;
>  				break;
>  			}
> @@ -823,6 +826,24 @@ static bool seg6_pop_srh(struct sk_buff *skb, int srhoff)
>  	return true;
>  }
>  
> +/* look up the SRH to be processed by the RFC8986 flavors. As End does, a
> + * routing header with SL = 0 is skipped (e.g. an SRH already consumed).
> + * This function returns NULL when no valid SRH is found.
> + */
> +static struct ipv6_sr_hdr *seg6_flv8986_get_srh(struct sk_buff *skb)
> +{
> +	struct ipv6_sr_hdr *srh;
> +
> +	srh = seg6_get_srh(skb, IP6_FH_F_SKIP_RH);
> +	if (srh)
> +		return srh;
> +
> +	/* we take the first routing header without skipping it. In this way,
> +	 * seg6_get_srh_pktinfo() reports SL = 0 and not a missing SRH.
> +	 */
> +	return seg6_get_srh(skb, 0);
> +}
> +
>  /* process the packet on the basis of the RFC8986 flavors set for the given
>   * SRv6 End behavior instance.
>   */
> @@ -837,7 +858,7 @@ static int end_flv8986_core(struct sk_buff *skb, struct seg6_local_lwt *slwt)
>  	__u32 flvmask;
>  	int srhoff;
>  
> -	srh = seg6_get_srh(skb, 0);
> +	srh = seg6_flv8986_get_srh(skb);

Hmm, here we always try skip the SL = 0 SRH when multi SRH exists. What if
we want to add USP flavor support in future? Then we will not able to remove
the first SRH which SL = 0, right? e.g.

   +------+----------------------+----------------------+---------+
   | IPv6 | SRH, Segments Left 0 | SRH, Segments Left 2 | payload |
   +------+----------------------+----------------------+---------+

Thanks
Hangbin

>  	srhoff = srh ? ((unsigned char *)srh - skb->data) : 0;
>  	pinfo = seg6_get_srh_pktinfo(srh);
>  #ifdef CONFIG_IPV6_SEG6_HMAC
> -- 
> 2.43.0
> 

