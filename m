Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792731119;
	b=kOtnys/rdhV3snT2wdupa6s3zcGunZOvuv11jSgTkRwqOGKVz6m9jAXehpJlPPR6Sn7r
	 4Ytvb8qJGbmMsE55wsjqRUYaVd7SSj7zQSMrG3fSZVzaQx4tphsUk3cG0lF6JHZmjZlnf
	 Yah/YXQN7Cv2CisD33WmpRYnDHNnruZPC3bvwzb5YSmOM727iFuYJbE94RjymNz/hexM5
	 wBjZ3z8s1YrncRe9YNnPplY6FcX3QOCpNnTVTePmEUmjKNoDu9iEXeSv08PGtYkrFqswe
	 QEq/Cjc116YaEartWxhurhV1UNgVT1CB23AobvBUj6qSsye4rgnafM5C0JS3XH2ZNQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792731119;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=l5UCn3s3YyxcyE6vweegr4A1rPRcjt6h9F7KPsMd5KY=;
	b=mN2Tl2/UerD/XE57+IRxbuki6prRjkIGkhfnVMVHYEtJaa6emX07T+TT/9ZrJ++4J7hV
	 r2m8cIOhP+zF74LOpqJjepibu7CNfehnhnK6aAVVGNTxJ/JKjmgUADrg31I3W1HxYKb1w
	 6eHWqpVE9ppvBqHCwNWZ28ebJUJ/ETCA6xgLL/ECEJ73gCrrAxaHC/NtvvpgV3rT2DBT6
	 0mwhApkuFKsmD74Y7XH2/ITUYkGMCWmIfIemcKLquc5dmZ7DxALOSQPDTqQcrRoZorfNl
	 bhDfKLbct8f/Nbi86QP1O8BZW7zMqeUgFY+V8ZOqxt5FY9DG3+yWu0Hqlz975IA8LOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g9IF7uFF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A5A606A319
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 04:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g9IF7uFF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48EF11F01825;
	Fri, 23 Oct 2026 04:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792731118;
	bh=l5UCn3s3YyxcyE6vweegr4A1rPRcjt6h9F7KPsMd5KY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=g9IF7uFF9+WPeewAagqf7C9jK+UL4Yc9xwbzrV2wTgTEZHIsI3StVz8RYNbRqLD1y
	 ZT/z/gtLR8fmAUx8n1LLfM+C9U2C0s0iAoOqTE2eIrLCwS710pc4j+WCR7k6JpEXBi
	 jybOBH0KSK6ReliEUHAaEcrL7hDF2YXHjUI3b52ci6q/qjWqiykJtkMTiqDnBskIDo
	 tq1A+WGsMnhTQ3RmAr3ikdjzDWGycUSMt0zu3QzuiWBdQVfcurM1AuhUjja3xFQAFw
	 abrc4XwH6LfzBGCKAbUY92A1FlhoYh3+SzUJX5SgFL6HeeykSWmDYZpB25LXRyy0ae
	 vW8LVJ3g00YTg==
Subject: Re: [PATCH net-next 01/15] net: skbuff: make skb_copy_and_csum_bits()
 report unreadable frags
From: netdev-bot+sashiko@kernel.org
To: josef@toxicpanda.com
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch, jgross@suse.com,
 sstabellini@kernel.org, willemdebruijn.kernel@gmail.com, fmancera@suse.de,
 almasrymina@google.com, david.laight.linux@gmail.com, netdev@vger.kernel.org,
 xen-devel@lists.xenproject.org
Date: Fri, 23 Oct 2026 04:51:56 +0000
Message-ID: <179273111683.3134.7255247218847744918@kernel.org>
In-Reply-To:
 <20261019-b4-skbuff-bug-on-followups-v1-1-41dbef50b9f7@toxicpanda.com>
References:
 <20261019-b4-skbuff-bug-on-followups-v1-1-41dbef50b9f7@toxicpanda.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Missing Fixes: and Cc: stable tags on a data-integrity fix.
- [Low] The new comment in skb_copy_and_csum_dev() reads: "On failure the
  rest of @to is zeroed; leave the checksum alone so the frame goes out…

--

net: skbuff: make skb_copy_and_csum_bits() report unreadable frags

skb_copy_and_csum_bits() now returns 0 or -EFAULT, hands the checksum
back through a pointer, and is marked __must_check. On error, the callers
in skb_segment(), the ICMP code, the IP append paths, sunvnet and sunrpc
take the failure paths they already have. skb_copy_and_csum_dev() returns
early without storing a checksum. With this change, software GSO of a
devmem TCP skb fails instead of silently replacing the payload with
zeroes.

Link: https://lore.kernel.org/all/179148235783.434549.14322374227477832817@kernel.org/

> Link: https://lore.kernel.org/all/179148235783.434549.14322374227477832817@kernel.org/
> Suggested-by: Mina Almasry <almasrymina@google.com>
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

[Severity: Medium]
This fixes the silent payload replacement in the !sg && !csum branch of
skb_segment(), but there is no Fixes: or Cc: stable tag.

The commit message says commit ab9414ed70bd ("net: skbuff: don't leave
stale bytes in skb_copy_and_csum_bits()") is what made the replacement
silent. That commit carries:

    Fixes: 65249feb6b3d ("net: add support for skbs with unreadable frags")
    Cc: stable@vger.kernel.org

Could stable trees take ab9414ed70bd without this patch? Devmem TX would
then send a zeroed payload under a valid TCP checksum, and the peer would
accept it.

Other patches in this series carry Fixes: tags, for example "net: skbuff:
reject a negative length in skb_copy_and_csum_bits()" and "net: skbuff:
check csum_start against len in skb_copy_and_csum_dev()".

Should this one also name ab9414ed70bd (or 65249feb6b3d) in a Fixes: tag
and Cc stable, so that both changes are backported together?

> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 93c2f440b9ec..a2b52a5a61a9 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c

[ ... ]

> @@ -4006,9 +4025,13 @@ void skb_copy_and_csum_dev(const struct sk_buff *skb, u8 *to)
>  	skb_copy_from_linear_data(skb, to, csstart);
>  
>  	csum = 0;
> -	if (csstart != skb->len)
> -		csum = skb_copy_and_csum_bits(skb, csstart, to + csstart,
> -					      skb->len - csstart);
> +	/* On failure the rest of @to is zeroed; leave the checksum alone so
> +	 * the frame goes out with a bad one.
> +	 */
> +	if (csstart != skb->len &&
> +	    skb_copy_and_csum_bits(skb, csstart, to + csstart,
> +				   skb->len - csstart, &csum))
> +		return;

[Severity: Low]
Does this early return actually make the frame go out with a bad
checksum?

It skips the csum_fold() store, but nothing marks the checksum as invalid.
The sanity check earlier in skb_copy_and_csum_dev() only bounds csstart
by skb_headlen():

	if (unlikely(csstart < 0 || csstart > skb_headlen(skb) ||
		     (skb->ip_summed == CHECKSUM_PARTIAL &&
		      csstart + skb->csum_offset + sizeof(__sum16) >
		      skb->len))) {

For CHECKSUM_PARTIAL, the field at csstart + csum_offset can therefore sit
past the linear area. That puts it inside the region that
skb_copy_and_csum_bits() zero-fills on failure:

	if (!skb_frags_readable(skb)) {
		/* Don't hand the caller a buffer with stale bytes in it. */
		if (len > 0)
			memset(to, 0, len);
		return -EFAULT;
	}

For UDP over IPv4, a checksum of 0x0000 means "no checksum". Wouldn't the
receiver then accept the zeroed payload?

The same applies to a CHECKSUM_NONE UDP skb sent without a checksum. The
headers are copied intact, only the payload is zeroed, and nothing marks
the frame as bad.

The commit message makes the same claim:

    skb_copy_and_csum_dev() can't return an error, so it leaves the
    checksum alone and the frame goes out with a bad one.

None of the current callers (ep93xx_eth, ec_bhf, ksz884x, 8139too,
sc92031, via-rhine) sets netmem_tx. validate_xmit_unreadable_skb()
therefore drops unreadable skbs before they reach these drivers, and the
remaining failure case needs an skb whose lengths are inconsistent.

Should the comment and the commit message be narrowed? Alternatively,
this path could store a non-zero value at csstuff that is known not to
match, for CHECKSUM_PARTIAL. The code is unchanged at the end of the
series.

>  
>  	if (skb->ip_summed == CHECKSUM_PARTIAL) {
>  		long csstuff = csstart + skb->csum_offset;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261019-b4-skbuff-bug-on-followups-v1-0-41dbef50b9f7%40toxicpanda.com
