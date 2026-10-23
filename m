Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792731128;
	b=ZAXDlr8CT57rUI8T1KhIL/fSvLkMaRCfExsKF1QonwNB6zYChhJhNchN/8RYRzVGyfkX
	 r6wI6YyT6JdAKG8YWtsRVlBmWTq+izji3kI6SUu4ywyIMRnhUdOxN2uvxlno2GNnwNIdu
	 XG0Tp9Q2by2JgixHl63ABV3Fqv2qqbtSVbwggxqJpZePf1v3W1VYBZEgQkGZLv0/gblLv
	 WvyoR+0Y6dY/oHFRRuTsBxZIo5md9yCoj0XCqYPm7xO2FmQKDEUF7bCcOEVU1qnd5S0XC
	 SXR/7Ji5ndbwg5kDf2LCc4rkNstegmM9wvd6HUbvRVp6YfvN7co9NqfSn6cjE8XnxIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792731128;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=m4eUhHLp14jEKzi8uHnH2gScUY1iDl3d/EjgImmk3go=;
	b=xDE0HfiWQqQLPQBlyga8bjrCcXKh7BJdXlNKvCItydyK7rs4dkA5dHCfPv8rTtqCUF4c
	 ygDcb0lbz0u0ekmEaoAG8y7/ZmC07bN8/Z7vF1mhhHwhIlRh4Hk/eHK4uGHNQW5/mE2V3
	 iLsBoESxEK06tvPD3ETcHgEk+/g0JnD0Ly72nTbAyWjKZC8ysHi0lFbHCrmNN11N8iSxt
	 TGZRxIHF+vV1OeHDYG7JNZf/qdza3ocTzFJJgn4lGnAdrax4I8kcKMJYf+rqQuByKKFOR
	 KwpSdsU45BgUwomp3s4I3Vj1AicMEB2GDA4tlKzVO+aK6T52VQ4vqKWpUj25WCJ9YzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FTvdEGT0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33847606A319
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 04:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FTvdEGT0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 533F41F031E1;
	Fri, 23 Oct 2026 04:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792731128;
	bh=m4eUhHLp14jEKzi8uHnH2gScUY1iDl3d/EjgImmk3go=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FTvdEGT0Wxsyij7WdwX3FaVHnPOWCyIiEujPXH8IHq8o2B9pQfwgTdK/NqLRVSwGy
	 6xl9sgCPeh3sDT42Jd5Cye+yN3RquBnykOVo4418+K2jHCYfLz48/p+OI7ElNdMYem
	 9F2nmCE9xUALydd23c5SeQXqyDkc5RL6ndhQFp6c2KPTJtFO2sDorBRB9Z+CwHAWC2
	 60XKTi0L8s4jcjD+jfnj8CeUVsy8S58WWc1hWxNNH+w1hsTzV77vM5qKxDQ31wA830
	 TmUg45gOWhwyMRxHJVJwKpvZf6kzS1J7GUdszwqdRcAFMSTtvn//dxwAV8UClBBQFR
	 Vl0dNkv3k/v8w==
Subject: Re: [PATCH net-next 08/15] net: skbuff: make skb_try_coalesce()'s len
 unsigned
From: netdev-bot+sashiko@kernel.org
To: josef@toxicpanda.com
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch, jgross@suse.com,
 sstabellini@kernel.org, willemdebruijn.kernel@gmail.com, fmancera@suse.de,
 almasrymina@google.com, david.laight.linux@gmail.com, netdev@vger.kernel.org,
 xen-devel@lists.xenproject.org
Date: Fri, 23 Oct 2026 04:52:06 +0000
Message-ID: <179273112692.3134.1759491419702666549@kernel.org>
In-Reply-To:
 <20261019-b4-skbuff-bug-on-followups-v1-8-41dbef50b9f7@toxicpanda.com>
References:
 <20261019-b4-skbuff-bug-on-followups-v1-8-41dbef50b9f7@toxicpanda.com>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message gets the bug's history wrong, so the single
  Fixes: tag (279877d86c82) is incomplete.

--

net: skbuff: make skb_try_coalesce()'s len unsigned

This changes the local len in skb_try_coalesce() from int to unsigned int,
so a from->len above INT_MAX can no longer pass the skb_tailroom() check.
It also adds an explicit delta < 0 test to the truesize WARN_ON_ONCE(),
since that comparison is now unsigned.

Link: https://lore.kernel.org/all/20261007-b4-skbuff-bug-on-v2-0-b9a5f732895b@toxicpanda.com/

> Before that commit skb_put() ran first,
> and its overflow check caught such a length before anything was
> copied.

[Severity: Low]

Is this accurate on all configurations? Before 279877d86c82,
skb_try_coalesce() looked like this:

	if (len <= skb_tailroom(to) && skb_frags_readable(from)) {
		if (len)
			BUG_ON(skb_copy_bits(from, 0, skb_put(to, len), len));

len was already a signed int at that point. A from->len above INT_MAX
passed the tailroom check then, the same way it does now.

skb_put() then does:

	skb->tail += len;
	skb->len  += len;
	if (unlikely(skb->tail > skb->end))
		skb_over_panic(skb, len, __builtin_return_address(0));

On 32-bit, sk_buff_data_t is unsigned char *. A lowmem tail at or above
0x80000000 plus a len at or above 0x80000000 wraps below end, so
skb_over_panic() is never called. skb_put() returns the old tail, and
skb_copy_bits() runs with the negative len. That is the same large write
past @to that the commit message attributes to 279877d86c82.

On 64-bit, tail and end are u32 offsets. A from->len in the range
[2^32 - tail, 2^32) also wraps tail below end and gets past the check.
279877d86c82 seems to have widened this window on 64-bit, but it did not
open it.

git blame shows that the signed len goes back to the introduction of the
function:

  bad43ca8325f4 ("net: introduce skb_try_coalesce()")

Could the commit message be corrected? Should a Fixes: tag for
bad43ca8325f4 also be added? Without it, stable trees that don't contain
279877d86c82, including their 32-bit builds, may not get this fix.

> Fixes: 279877d86c82 ("net: skbuff: don't BUG() when skb_copy_bits() fails in copy helpers")

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261019-b4-skbuff-bug-on-followups-v1-0-41dbef50b9f7%40toxicpanda.com
