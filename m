Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.80.4.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793154457;
	b=o6UfQI799U10R2BZ6ghjvMWBSqnSx90DugjjCGmg6vN6Ke9wCo+7HGqKh8IHfFqRl1Xh
	 DYcjh+wgP7J8FjFO8xK0k8ai9kWYim2GyYFbi3wBz+mRKA8EYbPColJ7scv4YlVo0LmMx
	 o9CvNnc7y4nnXJM3xYTh28Ro2NoVtaYXRElcGR7ByEq5hUGWuhXazCDhQ3/jmUct1ocph
	 mVTG4OQjpdNSeqsYZA02KTVMXxCooeUxQgLF3BGFKu98FPEh3ssfGWMkgqdhvW9YWC0+Z
	 an5O+dJMrvemEjvzqoiidagvUcHEcVA/IbR+JvoSy5rnKaZoUx2ZWrtZHsgk7yXNukQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793154457;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:Date:
	 From:To:Cc:Subject:Message-Id:In-Reply-To:References:X-Mailer:
	 Mime-Version:Content-Type:Content-Transfer-Encoding:X-Virus-Scanned:
	 X-Virus-Status;
	bh=34MEbCK2dZfz1OeFw4rZYBVHQDkLVXHqDfjhJIGlAaE=;
	b=IbPPl0lIS8JUHM9QFbmklyn8CGbADlyvcyCgTDrEsBOJR5IJLe4prRL/BlvpxGY1zdNB
	 RXpEnE33gd0P5ge7PTc22bHDaNHkawt8fQCFBQI+GfYx0uhpAAvJMbXFOctjwLtFMi1PV
	 VnxykyrDq1Iaa1Oh6kefA5c0OVxKYjx2dTohoxwttTIumnbtlTgCZnyzVYbyFBFngnGpa
	 ezavFmGhbbcwF01/A4SuTJk/uqFKuakip1GJFHlzfrj6oGZ0rpGc1ySRvNjt7FFTNzSzk
	 WEAySrlVv7rrrcnLp2gPNkqcfN+ET1YWEtcEhhrcGHSyeGkl1fnOHQs539HZsTHsv3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniroma2.it;
	spf=pass smtp.mailfrom=uniroma2.it;
	dkim=pass header.d=uniroma2.it header.i=@uniroma2.it header.a=ed25519-sha256 header.s=ed201904 header.b=GPh0y22A;
	dkim=pass header.d=uniroma2.it header.i=@uniroma2.it header.a=rsa-sha256 header.s=rsa201904 header.b="KDRN+1/x";
	arc=none smtp.remote-ip=160.80.4.37
Received: from smtp.uniroma2.it (smtp-2015.uniroma2.it [160.80.4.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63714606A31A
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 02:27:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63714606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=uniroma2.it header.i=@uniroma2.it header.a=ed25519-sha256 header.s=ed201904 header.b=GPh0y22A;
	dkim=pass (2048-bit key, unprotected) header.d=uniroma2.it header.i=@uniroma2.it header.a=rsa-sha256 header.s=rsa201904 header.b=KDRN+1/x
Received: from smtpauth-2019-1.uniroma2.it (smtpauth-2019-1.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 69S2QX6m024901;
	Wed, 28 Oct 2026 03:26:39 +0100
Received: from lubuntu-18.04 (unknown [160.80.103.126])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id 7B564120F34;
	Wed, 28 Oct 2026 03:26:28 +0100 (CET)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1793154388; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=34MEbCK2dZfz1OeFw4rZYBVHQDkLVXHqDfjhJIGlAaE=;
	b=GPh0y22At6mVsERDow/gFvzwfXlfUYGty8KPBIyLFfKkycJ5S9C2ao5aGOwvdWvspV94KB
	P1sGjEjrFjkqBCCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1793154388; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=34MEbCK2dZfz1OeFw4rZYBVHQDkLVXHqDfjhJIGlAaE=;
	b=KDRN+1/xnVsBaGMZsTf7NSz+4l0uI4ECkbBWRfhvYWJFJjJuCEDFASQrZlOiWORl5otUm6
	V6XVcc7ldFZTcdl2o09OrMbSI/EO3ra5MOp3RwTN+Sakdj/hGzUzhtHQqXtOp2f8AVVpKV
	1VAfY7av9uAWlhCJ+xBQ+kB4yAPHijdxoDfUHoiw9FYPKpniCerLHfbVvK7DGWGblh4UTi
	CdW1CEu4trjpjdBUNjo9f6sgCXSud6L02/x+dYTs8KSa8MdpkRUX3VARp57llSxJwXLr+S
	XcdPHblpXCNr0PphG6D/0Z5Y2AV7CqsQAD+HEevFyO6YlEsAw0qHgJ5qwTn09A==
Date: Wed, 28 Oct 2026 03:26:28 +0100
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: Ren Wei <weir@nebusec.ai>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
        contact@proelbtn.com, pablo@netfilter.org, vega@nebusec.ai,
        sashiko-bot@kernel.org, petalzu987@gmail.com, liuhangbin@kylinos.cn,
        stefano.salsano@uniroma2.it, Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: Re: [PATCH net v3 1/1] seg6: validate state in netfilter
 continuations
Message-Id: <20261028032628.93fa08eb5018c417f47bdba8@uniroma2.it>
In-Reply-To: <6edcb09db8ec3dda9e26ab5c5be45769907011d5.1792660496.git.petalzu987@gmail.com>
References: <cover.1792660496.git.petalzu987@gmail.com>
	<6edcb09db8ec3dda9e26ab5c5be45769907011d5.1792660496.git.petalzu987@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean

On Sat, 24 Oct 2026 15:23:04 +0800
Ren Wei <weir@nebusec.ai> wrote:

> Netfilter hooks can replace or drop skb_dst() before an SRv6 continuation
> resumes. The continuation callbacks then assume that the current dst still
> contains the expected lwtstate, which can lead to invalid state access.
>
> Validate the current dst and lwtstate in each NF_HOOK() okfn wrapper.
> Drop the skb when the state is missing or has the wrong type. Keep the
> direct core calls unchanged when nf_hooks_lwtunnel is off.
>
> Fixes: 7a3f5b0de364 ("netfilter: add netfilter hooks to SRv6 data plane")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260720204430.1886091-1-xmei5@asu.edu
> Assisted-by: LLM
> Signed-off-by: Zixuan Chai <petalzu987@gmail.com>
> Signed-off-by: Ren Wei <weir@nebusec.ai>
> Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
> Acked-by: Pablo Neira Ayuso <pablo@netfilter.org>

Hi,

Thanks for the v3.

On top of what Paolo wrote, it would be good if the commit message also
said how the crash is triggered, what it causes, and how the fix was
tested.

> [snip]

> @@ -60,6 +61,21 @@ static inline struct seg6_lwt *seg6_lwt_lwtunnel(struct lwtunnel_state *lwt)
>  	return (struct seg6_lwt *)lwt->data;
>  }
>  
> +static struct lwtunnel_state *seg6_lwt_state_from_skb(struct sk_buff *skb)
> +{
> +	struct dst_entry *dst;
> +
> +	if (unlikely(!skb_valid_dst(skb)))
> +		return NULL;
> +
> +	dst = skb_dst(skb);
> +	if (unlikely(!dst->lwtstate ||
> +		     dst->lwtstate->type != LWTUNNEL_ENCAP_SEG6))
> +		return NULL;
> +
> +	return dst->lwtstate;
> +}

seg6_lwt_state_from_skb() and seg6_local_lwt_from_skb() return a pointer,
but the callers only test it against NULL. IMHO they could return bool,
with a name that says what they check, like skb_valid_dst() does. For
example seg6_skb_has_lwtstate() and seg6_local_skb_has_lwtstate().

> [snip]

> @@ -557,18 +573,15 @@ static int seg6_input_finish(struct net *net, struct sock *sk,
>  static int seg6_input_core(struct net *net, struct sock *sk,
>  			   struct sk_buff *skb)
>  {
> -	struct dst_entry *orig_dst = skb_dst(skb);
>  	struct dst_entry *dst = NULL;
>  	struct lwtunnel_state *lwtst;
>  	struct seg6_lwt *slwt;
>  	int err;
>  
> -	/* We cannot dereference "orig_dst" once ip6_route_input() or
> -	 * skb_dst_drop() is called. However, in order to detect a dst loop, we
> -	 * need the address of its lwtstate. So, save the address of lwtstate
> -	 * now and use it later as a comparison.
> +	/* Save the lwtstate address before replacing the dst to detect a
> +	 * dst reference loop.
>  	 */
> -	lwtst = orig_dst->lwtstate;
> +	lwtst = skb_dst(skb)->lwtstate;
>  
>  	slwt = seg6_lwt_lwtunnel(lwtst);

With the check in seg6_input_core_nf(), seg6_input_core() does not need to
change, so it can keep orig_dst and the original comment.

> [snip]

> @@ -667,12 +691,13 @@ static struct dst_entry *seg6_output_dst_lookup(struct net *net,
>  static int seg6_output_core(struct net *net, struct sock *sk,
>  			    struct sk_buff *skb)
>  {
> -	struct dst_entry *orig_dst = skb_dst(skb);
>  	struct dst_entry *dst = NULL;
> +	struct lwtunnel_state *lwtst;
>  	struct seg6_lwt *slwt;
>  	int err;
>  
> -	slwt = seg6_lwt_lwtunnel(orig_dst->lwtstate);
> +	lwtst = skb_dst(skb)->lwtstate;
> +	slwt = seg6_lwt_lwtunnel(lwtst);
>  

Same as seg6_input_core(): seg6_output_core() does not need to change
either.

> [snip]

Ciao,
Andrea

