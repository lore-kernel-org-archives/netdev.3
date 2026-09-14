Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAB5345EAF;
	Mon, 14 Sep 2026 04:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789360642; cv=none; b=a+yvEZId3mL7KONP7ddSvSB2ZREkGAsjdGLJYgIIZUSdPRAh24cjMXGtywY/M6eimC/esjHYfmNouIEor58FauYg+s6/wPRrhNqvNZR47D2ZLz3t6TLgzuK4AXpXZHAzldafnLIbkEqAvHayoEvmeGGGkeKPfmF1aLjFSmHkI7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789360642; c=relaxed/simple;
	bh=oVjoYYJsh9sx9UnRVBAfZUCV4JwzYvz3yzh3tHthHzw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NrkRYB+LXvK79M6ubAdaO65HO9H0JpoolHPSJ/XQZvmW6G1kLMdBA61Y4Fp93w2tuDw5YNvF93GvpEbU/2ofiK4+vJVucFMFmP1J/NNJfORQajmiYNYBT0VV/1HhkWKbW22mERG38eYgHJrdSRbVwib72Db4gjQ5LpsRGBqhM0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j58BwwL1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j58BwwL1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCFCD1F00893;
	Mon, 14 Sep 2026 04:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789360641;
	bh=5JhhalYJ1APUkHgDah6mzfzadR+6ZgC1IsHJCZafa7s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=j58BwwL1U83+KV9bNFghotM5yK6KJVCxJ7aQ7AMD3RHXdyZFtpt3JWTU0cEcqGJlH
	 RJ9j7udzk7L2oducZ4Ruv6gL8Dh7qFRT09mgl9LImnj153sFaltr0YYfeN+8tz3UwL
	 COXBxYi8aHcvlbMz8Q6YiWEhzDMbIPMPV2gJcn43DF6eMSFsdhNbiUmLFjnZhOqmBJ
	 5fChGd7jplmrzNo6c1dJn3x1tE/xufjlC+lZrqKXeIY5SgMWzh++J+dZCY5UkFDasV
	 7Z9WBk+xMc2yI66YacXkAFZeDPyEe1mYsJRgUK7yut5Lu+HlOgLXJwCthQUPCR1ZN9
	 uei/2PwLAhwBg==
Subject:
 Re: [PATCH net-next v2 3/8] gre: make gre_parse_header() report a drop reason
From: netdev-bot+sashiko@kernel.org
To: littlesmilingcloud@gmail.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, horms@kernel.org,
 idosch@nvidia.com, linux-kernel@vger.kernel.org
Date: Mon, 14 Sep 2026 04:37:20 +0000
Message-ID: <178936064042.22033.10502810106599240452@kernel.org>
In-Reply-To: <20260913034937.875068-4-littlesmilingcloud@gmail.com>
References: <20260913034937.875068-4-littlesmilingcloud@gmail.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 0 · Low: 1

- [Low] The new interface comment added above gre_parse_header()
  (net/ipv4/gre_demux.c:65-68) states that a NULL @reason means "the…

--

gre: make gre_parse_header() report a drop reason

This replaces the unused csum_err output parameter of gre_parse_header()
with an enum skb_drop_reason pointer, adds SKB_DROP_REASON_GRE_INVALID_HDR
and SKB_DROP_REASON_GRE_CSUM, and converts the ip_gre, ip6_gre and
gre_demux receive paths to kfree_skb_reason().

No Link: tags were present in the commit header.

One question below about the documented meaning of a NULL reason.

> A NULL reason keeps the meaning a NULL csum_err had: the caller is not
> interested in it and the checksum must not be verified.  This matters
> for the ICMP error handlers, which only get a part of the original
> packet and must not drop it when the checksum does not validate.

[Severity: Low]
Is the phrase "the checksum must not be verified" accurate here?  With a
NULL reason the checksum is still computed, and on the success path the
skb checksum state is still modified; only the reporting of a failure is
skipped.  Would "a checksum failure must not be reported" describe what
the code does?

The same wording is added to the kerneldoc-style comment below, see the
inline note.

> diff --git a/net/ipv4/gre_demux.c b/net/ipv4/gre_demux.c
> index 96fd7dc6d82dd..efd5f60a9c591 100644
> --- a/net/ipv4/gre_demux.c
> +++ b/net/ipv4/gre_demux.c
> @@ -58,26 +58,43 @@ EXPORT_SYMBOL_GPL(gre_del_protocol);
>  
>  /* Fills in tpi and returns header length to be pulled.
>   * Note that caller must use pskb_may_pull() before pulling GRE header.
> + *
> + * @reason is only written when the header is rejected, so the caller has
> + * to initialise it before the call.
> + *
> + * A NULL @reason means that the caller is not interested in the drop
> + * reason, and also that the checksum must not be verified.  This is what
> + * the ICMP error handlers need, as they only get a part of the original
> + * packet.
>   */
>  int gre_parse_header(struct sk_buff *skb, struct tnl_ptk_info *tpi,
> -		     bool *csum_err, __be16 proto, int nhs)
> +		     enum skb_drop_reason *reason, __be16 proto, int nhs)
>  {

[Severity: Low]
Does the new comment match the implementation for the NULL @reason case?
gre_parse_header() is exported, so a future caller may rely on this
contract, but the GRE_CSUM block below still calls
skb_checksum_simple_validate() unconditionally and, when it succeeds,
skb_checksum_try_convert() updates ip_summed/csum_valid on the skb:

net/ipv4/gre_demux.c:gre_parse_header() {
	...
	if (greh->flags & GRE_CSUM) {
		if (!skb_checksum_simple_validate(skb)) {
			skb_checksum_try_convert(skb, IPPROTO_GRE,
						 null_compute_pseudo);
		} else if (reason) {
	...
}

Only the error return is gated on @reason.  The two NULL callers,
ipgre_err() in net/ipv4/ip_gre.c and ip6gre_err() in net/ipv6/ip6_gre.c:

	if (gre_parse_header(skb, &tpi, NULL, htons(ETH_P_IP),
			     iph->ihl * 4) < 0)
		return;

still have the checksum of their partial packet computed and the csum
state touched.  This is the same behaviour as the pre-patch csum_err ==
NULL case, so nothing changes at runtime; would it be worth wording the
comment as "a checksum error is not reported" instead of "the checksum
must not be verified"?

> @@ -87,8 +104,8 @@ int gre_parse_header(struct sk_buff *skb, struct tnl_ptk_info *tpi,
>  		if (!skb_checksum_simple_validate(skb)) {
>  			skb_checksum_try_convert(skb, IPPROTO_GRE,
>  						 null_compute_pseudo);
> -		} else if (csum_err) {
> -			*csum_err = true;
> +		} else if (reason) {
> +			*reason = SKB_DROP_REASON_GRE_CSUM;
>  			return -EINVAL;
>  		}
>  

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260913034937.875068-1-littlesmilingcloud%40gmail.com
