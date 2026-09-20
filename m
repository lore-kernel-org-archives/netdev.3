Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CD747D47F;
	Sun, 20 Sep 2026 22:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789941741; cv=none; b=Ol2gx6fHQk7mfiunLutBC3ahgG4ZD5xafPZVfblJOJTlRQyssCik5UVeNum7NLI6odwUeuKCIgbFOGm/SrbGMMbd7LHtghF8U9DCaNl6jEmBI2jCJBIlwzlKpLlyv8VF1ciCUfWMubtYXG9Vn4MWKC7mkOJaO+lToTeJXyXp580=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789941741; c=relaxed/simple;
	bh=MGhod7jwTE2sHM4ZHqTj3gOiIT3xI4WoeE2P6tVlLAU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YNA2Gq0UM8rmyXYnJlI5M5of8sxmxeJYVaqRYjASXd/KrKIJV/YSvUSlv+RHZ6ylpV/vxOwyHDsblPuDl17bccnvOaHX3E25Jsyb213q1aQQXvnnRHVsNebJIuHKMj9ENdo3ozIBMSeB3f2huu8/cQoDVqdyd85pvTvLkk2hWCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5gDLXhh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5gDLXhh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D10051F00893;
	Sun, 20 Sep 2026 22:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789941735;
	bh=AMLrl9DKEa0aCMNy3E93fGQESYzEskMsL1ImE+OJsE0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=X5gDLXhhXaNMIIB4V3+gf/bE8VwuANiq4bDarVVhTbS+3E37H1Kr4NBDuwus/FFRS
	 pKaHNkQfGEJrvTP9wiNSlPXcdc6QnYYncqfJQQfhsRI4KiGdeyb6s1IvO5xozQp8dp
	 tt1yuCtNinZ1iEuDIPkGj/htiFIKHYvoatIAA9yNqp+SmsJc6O85moBJ7NgVi3z5tR
	 IEEReedQfRsoXPb2thcinA+l+Tkik/bYnRDbNq0DVWG0242Hjxsj8eO3jy1JdB94jv
	 al8/iJ7iUNDb8KYdPl3T7+WyHja1FBLvOTbOwZxHZoXVbLhehKF7RwZR5dOua2GjGw
	 cOaix1ardck1Q==
Subject:
 Re: [PATCH net] seg6: keep room for the mac header when growing the headroom
From: netdev-bot+sashiko@kernel.org
To: yuya.kusakabe@gmail.com
Cc: andrea.mayer@uniroma2.it, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, justin.iurman@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 20 Sep 2026 22:02:14 +0000
Message-ID: <178994173434.2160803.11042494148021854491@kernel.org>
In-Reply-To: <20260917-seg6-maclen-headroom-v1-1-02ccec50f096@gmail.com>
References: <20260917-seg6-maclen-headroom-v1-1-02ccec50f096@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Incomplete fix: the out-of-bounds MAC-header rebuild that this
  patch closes in net/ipv6/seg6_iptunnel.c is left reachable in the two…

--

seg6: keep room for the mac header when growing the headroom

The three seg6 encapsulation helpers now ask skb_cow_head() for the pushed
length plus max(skb->mac_len, dst_dev_overhead(cache_dst, skb)) so that at
least skb->mac_len of headroom is left for the following
skb_mac_header_rebuild().  Fixes: 40475b63761a ("net: ipv6: seg6_iptunnel:
mitigate 2-realloc issue").

> diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
> index 61c6a27bf202d..0e60bbca19ca5 100644
> --- a/net/ipv6/seg6_iptunnel.c
> +++ b/net/ipv6/seg6_iptunnel.c
> @@ -153,7 +153,8 @@ static int __seg6_do_srh_encap(struct sk_buff *skb, struct ipv6_sr_hdr *osrh,
>  	hdrlen = (osrh->hdrlen + 1) << 3;
>  	tot_len = hdrlen + sizeof(*hdr);
>  
> -	err = skb_cow_head(skb, tot_len + dst_dev_overhead(cache_dst, skb));
> +	err = skb_cow_head(skb, tot_len + max(skb->mac_len,
> +					      dst_dev_overhead(cache_dst, skb)));
>  	if (unlikely(err))
>  		return err;
>  

[Severity: High]

Should the same change also cover net/ipv6/rpl_iptunnel.c and
net/ipv6/ioam6_iptunnel.c?  Those two files were converted to
dst_dev_overhead() by the same series, and they still have the pattern this
commit message describes.

rpl_do_srh_inline() in net/ipv6/rpl_iptunnel.c:

	err = skb_cow_head(skb, hdrlen + dst_dev_overhead(cache_dst, skb));
	...
	skb_pull(skb, sizeof(struct ipv6hdr));
	...
	skb_push(skb, sizeof(struct ipv6hdr) + hdrlen);
	skb_reset_network_header(skb);
	skb_mac_header_rebuild(skb);

The net push is hdrlen, so the rebuild needs hdrlen + skb->mac_len of
headroom while only hdrlen + LL_RESERVED_SPACE(dst->dev) was requested.

ioam6_do_inline() in net/ipv6/ioam6_iptunnel.c:

	err = skb_cow_head(skb, hdrlen + dst_dev_overhead(cache_dst, skb));
	...
	skb_push(skb, sizeof(*oldhdr) + hdrlen);
	skb_reset_network_header(skb);
	skb_mac_header_rebuild(skb);

ioam6_do_encap() in the same file:

	err = skb_cow_head(skb, len + dst_dev_overhead(cache_dst, skb));
	...
	skb_push(skb, len);
	skb_reset_network_header(skb);
	skb_mac_header_rebuild(skb);

Can these three sites then run skb_mac_header_rebuild() out of room in the
same way, writing skb->mac_len bytes through a negative u16 offset?

include/linux/skbuff.h:skb_mac_header_rebuild() {
	...
	skb_set_mac_header(skb, -skb->mac_len);
	memmove(skb_mac_header(skb), old_mac, skb->mac_len);
	...
}

Both paths look reachable with the trigger described in the commit message,
a forwarded packet that entered through a VLAN device with reorder_hdr off
so that skb->mac_len is 18 while LL_RESERVED_SPACE() of a plain Ethernet
egress device is 16: rpl_input() fetches the cached dst with
dst_cache_get() and passes it to rpl_do_srh(), and ioam6_output() passes
the cached dst to both ioam6 helpers, with AUTO mode selecting
ioam6_do_encap() for forwarded packets.

Before the conversion series, all three files asked for len +
skb->mac_len; dce525185bc9 ("net: ipv6: ioam6_iptunnel: mitigate 2-realloc
issue") and its rpl counterpart replaced skb->mac_len with
dst_dev_overhead() exactly as the commit named in the Fixes: tag here did,
so would those two commits need their own Fixes: tags in a respin?

Would it be simpler to express the requirement once in the shared helper
instead of open-coding max() at three of its six call sites?

include/net/dst.h:dst_dev_overhead() {
	if (likely(dst))
		return LL_RESERVED_SPACE(dst->dev);

	return skb->mac_len;
}

The dst == NULL branch already returns skb->mac_len while the dst != NULL
branch can return less than that, so folding max(skb->mac_len,
LL_RESERVED_SPACE(dst_dev(dst))) into the helper would cover all six call
sites and leave a single reading of its contract.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917-seg6-maclen-headroom-v1-1-02ccec50f096%40gmail.com
