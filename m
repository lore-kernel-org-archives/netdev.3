Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792731130;
	b=T2yYLjrl2LC/SWrW4X2CFDOD3sdJOb1jmFqwGGDr+o8lrZfOu4Ox6Xz2TYuUGTWmmSqJ
	 NzIH35yob8LvUCQkMxW/83NOrDrs9hhucOyikya9Y+PUmcf8s7glVgKEDyPJb+BqCcImZ
	 JzXjCzMObiKjjm5/zhUqEa7qFNKzhlnJMCS9PFjBbRgBRa5ErRkTP06ITYEV50rPB5kqV
	 JtUcDGTlKjfpEwh5MHgIpXYxQT/P0kvrrwgqyMJ/TZ7KEBY/wvS8q24vVxHhPWaHdKNDk
	 NMoewS+w3b9Tg7lwF09mkJa2EUjivRArb9OpTJwOFUFOLs9jdtn1KeCHVH1pus4Sd6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792731130;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ALJG1SS2iy0WNzGYJ2ykwPhdXMhJmbb3CoA1YF8ffNc=;
	b=GRjSU3vOJU18ikg9b5nwekL/4DFoqMdNkMxmSoEgGdKsrT01kEM3c2z2FgZtcNXdbSf3
	 MauQYYPvsNHbYhX44O1tFwUuXl3Mz/U7HNEO3WLwuLG2y6jXD1Ae6It71OqVT8qEPdB5Q
	 yYa/O9DdTEyBaH7mH55OFYkyIe+ZpkaRW4AOvkBhIofkS2tCcbWVJGnjpiGth7vCp4PCF
	 wqPf0T3RrAOqoB5obvDCM23ITrSAO5VTcbfAS04/HOODyZRo0+6+7q3naxTNiUB1GJDt1
	 9HzlqBtYXjNGtWQs9QORI/8C3BIs8Soli3vWqXmBPX7Q7D+RUueQHbWCpPc72CAQgXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LBiOMtrD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556D7606A319
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 04:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LBiOMtrD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC8131F01825;
	Fri, 23 Oct 2026 04:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792731129;
	bh=ALJG1SS2iy0WNzGYJ2ykwPhdXMhJmbb3CoA1YF8ffNc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=LBiOMtrDWCpmJO/ji86Cm00kxg5nINn6Ygjd5c3AQDkNrnU1kFrfmscNk06E3Pllm
	 OOf4zfyBdEEeDqjVeUn8Q+eUF71szWkujD/7zYvOuUSd+DzyyeTym8udRVjUdDBmFn
	 hkja5jzp7viOvPROAMFnWXTePG3v+VngBOu3XUHJSy6M7/nm3pxc5J0/sNgSM9wdhf
	 i/qQl8vhcojaX76gM2RTVgRT/lL/bDsHtetipEb+ognTO7kEWTZxhxaYVyKZ+jmfJd
	 K+wurkGehCZVpXLsNjKas5F7UkTKzAqORqvEBQEBKPNpOVLIDLwroUbGm+ZFiaVXHD
	 FZpL/xAHtvnZg==
Subject: Re: [PATCH net-next 09/15] net: skbuff: check csum_start against len
 in skb_copy_and_csum_dev()
From: netdev-bot+sashiko@kernel.org
To: josef@toxicpanda.com
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch, jgross@suse.com,
 sstabellini@kernel.org, willemdebruijn.kernel@gmail.com, fmancera@suse.de,
 almasrymina@google.com, david.laight.linux@gmail.com, netdev@vger.kernel.org,
 xen-devel@lists.xenproject.org
Date: Fri, 23 Oct 2026 04:52:08 +0000
Message-ID: <179273112823.3134.12241973533522574538@kernel.org>
In-Reply-To:
 <20261019-b4-skbuff-bug-on-followups-v1-9-41dbef50b9f7@toxicpanda.com>
References:
 <20261019-b4-skbuff-bug-on-followups-v1-9-41dbef50b9f7@toxicpanda.com>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] net: skbuff: incomplete headlen underflow check in
  skb_copy_and_csum_dev()

--

> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -4103,7 +4103,11 @@ void skb_copy_and_csum_dev(const struct sk_buff *skb, u8 *to)
>  	else
>  		csstart = skb_headlen(skb);
>  
> +	/* skb_headlen() underflows if data_len is bigger than len, so check
> +	 * csstart against len as well.
> +	 */
>  	if (unlikely(csstart < 0 || csstart > skb_headlen(skb) ||
> +		     csstart > skb->len ||
>  		     (skb->ip_summed == CHECKSUM_PARTIAL &&
>  		      csstart + skb->csum_offset + sizeof(__sum16) >
>  		      skb->len))) {
>

[Severity: Medium]
This only closes the hole for the non-CHECKSUM_PARTIAL case. If
skb->data_len > skb->len and ip_summed is CHECKSUM_PARTIAL, csstart
comes from skb_checksum_start_offset() instead of skb_headlen(), so it
can be anywhere up to skb->len while skb_headlen() has wrapped to
about 4GB. Both the headlen comparison and the new skb->len comparison
then pass, the csum_offset check passes too, and we go straight on to
skb_copy_from_linear_data(skb, to, csstart) with nothing bounding
csstart by the real linear area.

skb_copy_and_csum_bits() then starts from int start =
skb_headlen(skb), which is either negative, so the linear part is
skipped and the frag reads are shifted by data_len - len bytes, or,
once the difference exceeds INT_MAX, a bogus positive value that lets
it copy from skb->data past the end of the linear data.

The fallback isn't safe either. skb_copy_bits() also begins with
int start = skb_headlen(skb), so sending such an skb down the existing
fallback, as the changelog describes, bounds the writes to @to by
skb->len but not the reads from the skb.

Since the condition you really want to catch is data_len > len,
would it be simpler to test that directly before computing csstart,
and memset() @to rather than calling skb_copy_bits() in that case? Or
should skb_copy_bits() and skb_copy_and_csum_bits() reject
data_len > len themselves?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261019-b4-skbuff-bug-on-followups-v1-0-41dbef50b9f7%40toxicpanda.com
