Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDABC221FB4
	for <netdev@vger.kernel.org>; Sat,  3 Oct 2026 17:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791048775; cv=none; b=Ahc01hfVG8oAA6SL7pkYB3nPLBMJdbwLhnYvZeW+PCis84eF6HMnf8smrDKhQEC6L8UrFG0m9QDXsfsNAPhfvUMw4ncE3oQXznTwz6iT0fIAR6xGsgodN0XMh44C5rMzQlp7jZaeSGsAXlRXMlaZbd0Z03AfFgG0MoBM4d7ENIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791048775; c=relaxed/simple;
	bh=/qv9zU8bz72r5GwFA5K1hispFWhnPd/LxDLu00K8sHs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=nPWdY5QvS7abYMYyD1RT6ghBQfItA2Kd8KeIg18QfdsWWm1mGwRZLVV5yQx6gNiC1TjmcDAUIRxK2ATIvgqhSTusLXvNh+9HKiYSChlRhH3B8Am1jJrESFt1mlZAiUTURmpDWRD6RzFNCk/jBZpwrXdndFKjLIYxQO/lh+dopos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=XbUHYZUo; dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=s9+mfNiW; arc=none smtp.client-ip=160.80.4.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="XbUHYZUo";
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="s9+mfNiW"
Received: from smtpauth-2019-1.uniroma2.it (smtpauth.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 693HWD98009882;
	Sat, 3 Oct 2026 19:32:18 +0200
Received: from lubuntu-18.04 (host-95-234-228-71.retail.telecomitalia.it [95.234.228.71])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id 904AC1208F0;
	Sat,  3 Oct 2026 19:32:08 +0200 (CEST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1791048728; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O6S5nuzyHxS2GVmDPDBhvu3UBrM83s93T24wqvFyOyI=;
	b=XbUHYZUo7SgXgmig9bqDod6FSkaWWvnbLMn79n5d4zko8EwzbWlnyZUzanRskscSbk69Oo
	xnSGKW+x6szyGQAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1791048728; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O6S5nuzyHxS2GVmDPDBhvu3UBrM83s93T24wqvFyOyI=;
	b=s9+mfNiW6yO/qMH7DTsiaBPRuXzw6Y8gDJMDFaSUNez5qBQjzI8x/HWHW4JZg1Whr//5RL
	CT7/j2Ze/7+K02B6G8eshw9Gu32zfnFdCWRNRBAa58hbUskYYe6/ivvTIFr4SaUyxqjR+W
	xTgILiNOeXIlbs9n81kykn8lj9O6xW6lMQiiQJAarDVoUhb9TJ/VRgEYZBwKb2tXEFU1iQ
	abl2Om+rvRY9C8v7Q0S8QlyqsV8lLcUvGIXyRwt4T0fmuPOMvR904whDp0+yFbjyI4gpRS
	2JUlavZx5dePw5h1A/y23QTWavBQ+hCnoH0lp0aXTIH4llFFI+1VXpBS2H0EQw==
Date: Sat, 3 Oct 2026 19:32:08 +0200
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: Ren Wei <weir@nebusec.ai>, Xiang Mei <xmei5@asu.edu>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
        pablo@netfilter.org, contact@proelbtn.com, vega@nebusec.ai,
        sashiko-bot@kernel.org, petalzu987@gmail.com,
        stefano.salsano@uniroma2.it, Andrea Mayer
 <andrea.mayer@uniroma2.it>
Subject: Re: [PATCH net 1/1] seg6: validate state in netfilter continuations
Message-Id: <20261003193208.6e43539a8381ca6bc776bd53@uniroma2.it>
In-Reply-To: <8e22f1e0a04d4a48bd990872490e21bfc61f9223.1790748418.git.petalzu987@gmail.com>
References: <cover.1790748418.git.petalzu987@gmail.com>
	<8e22f1e0a04d4a48bd990872490e21bfc61f9223.1790748418.git.petalzu987@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean

On Thu,  1 Oct 2026 02:08:53 +0800
Ren Wei <weir@nebusec.ai> wrote:

> From: Zixuan Chai <petalzu987@gmail.com>
> 
> Netfilter hooks can drop or replace the dst while an SRv6 packet is
> queued for continuation. The seg6local callbacks must not assume that
> skb_dst() still carries the state for the route being processed.
> 
> Validate the destination and SEG6_LOCAL state before using it in the
> End.DX4/End.DX6 continuations and seg6_local_input_core(). The
> seg6_iptunnel continuations must also resolve the SEG6 state beneath
> an XFRM dst and hold a reference while processing the SRH.
> 
> Fixes: 7a3f5b0de364 ("netfilter: add netfilter hooks to SRv6 data plane")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/20260720204430.1886091-1-xmei5@asu.edu/
> Assisted-by: LLM
> Signed-off-by: Zixuan Chai <petalzu987@gmail.com>
> Signed-off-by: Ren Wei <weir@nebusec.ai>

Hi,
Thanks for the patch.

A similar fix was posted by Xiang Mei in July [1]. It got review
comments and no new version yet. Xiang, are you still working on it?

Xiang's v2 1/2 makes the same seg6_local.c changes as this patch. On
that patch I suggested adding unlikely() to the new checks, as in patch
2/2. The same applies here.

For net, I would only check the state and drop the packet, as Xiang's
v2 does, with the limit already discussed on v1 and v2 (the check is on
the type, not on the instance). That check alone stops the crash, also
when SNAT and an XFRM policy replace the dst. Looking through the XFRM
dst is not needed for this fix.

The cover letter has a reproducer, but the commit message, which stays
in the git log, should say how the crash was triggered and how the fix
was tested.

> [snip]
> diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
> index 61c6a27bf202..e3d36fb0f290 100644
> --- a/net/ipv6/seg6_iptunnel.c
> +++ b/net/ipv6/seg6_iptunnel.c
> [snip]
> @@ -60,6 +62,26 @@ static inline struct seg6_lwt *seg6_lwt_lwtunnel(struct lwtunnel_state *lwt)
>  	return (struct seg6_lwt *)lwt->data;
>  }
>  
> +static struct lwtunnel_state *seg6_lwt_state(struct dst_entry *dst)
> +{
> +	dst = xfrm_dst_path(dst);
> +	return dst->lwtstate;
> +}
> +
> +static struct lwtunnel_state *seg6_lwt_state_get(struct sk_buff *skb)
> +{
> +	struct lwtunnel_state *lwtst;
> +
> +	if (!skb_valid_dst(skb))
> +		return NULL;
> +
> +	lwtst = seg6_lwt_state(skb_dst(skb));
> +	if (!lwtst || lwtst->type != LWTUNNEL_ENCAP_SEG6)
> +		return NULL;
> +
> +	return lwtstate_get(lwtst);

The route that carries the lwtstate holds a reference on it, and drops
it only after an RCU grace period. Which path needs the one taken by
lwtstate_get()? Sashiko asks the same question [2].

> [snip]
> @@ -557,18 +577,16 @@ static int seg6_input_finish(struct net *net, struct sock *sk,
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
> -	 */
> -	lwtst = orig_dst->lwtstate;
> +	lwtst = seg6_lwt_state_get(skb);
> +	if (!lwtst) {
> +		err = -EINVAL;
> +		goto drop;
> +	}

This comment explains why the lwtstate address is saved before
ip6_route_input() or skb_dst_drop() and compared after them. This still
holds after the patch: seg6_input_route() calls one of them between the
save and the comparison. I don't see a reason to remove the comment
here.

> [snip]

[1] https://lore.kernel.org/all/20260728215448.1543553-1-xmei5@asu.edu/
[2] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/8e22f1e0a04d4a48bd990872490e21bfc61f9223.1790748418.git.petalzu987@gmail.com

Ciao,
Andrea
