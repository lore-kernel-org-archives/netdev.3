Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792731132;
	b=ZSsT1403eAok8DX5MCe6SyAnUrdRlRlQF90wSbZXhF7hswT79yT0GtQZ3HdfmIzhcE7H
	 DVMSNS6xGnY5DUcoYO0w+IMnN5byR6xR1Ek58ZhVcc+nUye0QBJzvKeZqjXlA9NQA+dwL
	 DH/Pu0YNVeNlSg6PYClKxeuZQ7xU8/NyvCrPc+fUDKbNJZ1zlIoEFc8p8bCla61ejCTvW
	 Oi+WMIAiONOESDpsLwvNOem4wTQAfC+peiD16QBKzLp8XrXzX+s3vmWqKgMkTFfSh61la
	 /fGXy6CHn9EPQ/4cE5aw+ULqw5drkc7WA18byCPZiiMKjgxmoD8eGczqnIlq1yA0fyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792731132;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=agkvCklKmEd8Wp6mVSMBoVqEMTNMmcycBQEcregNfVo=;
	b=xE7UlAqIT2aKutfCBenewbZwJVHNUmm5bVXO0JIyppHEFt1MSU/vh4He+jB8LvZ5/D8c
	 w7uDJMIl7/w90GJ6gnSDxaDE4qyrr0yGzboT8R62XiL47HbtaRBzqYE4szP2tatF8OJd/
	 ST3y+Hfoa6R0G0/nL3atm3linQEc+9N6QctwsyHxqsWvNWF5+AIdjq1LqVmEhrKrWa9xz
	 hJ94C02PzSgXzA/WL+J8yzq4hswuHVrsT5udzD6/iZB7724JLYg3mUu6qLSqrCPl0fvLI
	 KYXH+qd90wYc/T2qdizXJq5L9I5Zp6PBvVCLOsavBTem6v23X1JcXrnkKNE6/3nF1MA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=egaoWeXY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C4860A260E
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 04:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=egaoWeXY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 959C41F01825;
	Fri, 23 Oct 2026 04:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792731132;
	bh=agkvCklKmEd8Wp6mVSMBoVqEMTNMmcycBQEcregNfVo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=egaoWeXYUJlTrjLH3F6bQMXw18UbNdnbpS+dRSabHlQD9C/AeZOtHA9cr0o/UxpQU
	 tmTHIqaypY0rM6WJSD3sGo7DnT1Zkr8pWqM0qo0GLWqTb1vJbqm1LLavuOtc6ORwyI
	 kOLvXSjea4i2T8GXpLijTp9Fsh1/aEDZDShjnmghI9kkbFwOEsVxY0fNKf/0L01bxz
	 +7UJ4e08bNKe/mS9VtdtX26PgFbKT316nG6h4msxi9zsqOnIW14ym2aEp7Sq/yXrcF
	 oo3uzlQddM6jfX0uSqrGMxXJGIFIGpXL6Rdb4be6b/dOGBF+ErgxMYRdS70/6rL6od
	 n8owJ7ZO8cU7A==
Subject:
 Re: [PATCH net-next 11/15] net: skbuff: refuse to segment a nested frag_list
From: netdev-bot+sashiko@kernel.org
To: josef@toxicpanda.com
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch, jgross@suse.com,
 sstabellini@kernel.org, willemdebruijn.kernel@gmail.com, fmancera@suse.de,
 almasrymina@google.com, david.laight.linux@gmail.com, netdev@vger.kernel.org,
 xen-devel@lists.xenproject.org
Date: Fri, 23 Oct 2026 04:52:11 +0000
Message-ID: <179273113115.3134.9365887081510077540@kernel.org>
In-Reply-To:
 <20261019-b4-skbuff-bug-on-followups-v1-11-41dbef50b9f7@toxicpanda.com>
References:
 <20261019-b4-skbuff-bug-on-followups-v1-11-41dbef50b9f7@toxicpanda.com>
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

- [Low] The commit message for "net: skbuff: refuse to segment a nested
  frag_list" says "Nothing in the tree is known to build such an skb;…

--

net: skbuff: refuse to segment a nested frag_list

This adds a check to skb_segment() that rejects an skb whose frag_list
members have frag_lists of their own. It fails with -EINVAL and calls
DEBUG_NET_WARN_ON_ONCE(), since the segmentation walk would otherwise run
out of members and dereference a NULL list_skb.

> Nothing in the tree is known to build such an skb; GRO flushes instead
> of chaining an skb that already has a frag_list.  Check for it up front

[Severity: Low]

Is the first half of this sentence accurate as a general statement?

IP fragment reassembly appears to build exactly this layout. When the
first fragment already has a frag_list, inet_frag_reasm_prepare() moves
that frag_list under a new zero-length skb:

net/ipv4/inet_fragment.c:inet_frag_reasm_prepare() {
    ...
	if (skb_has_frag_list(head)) {
		struct sk_buff *clone;
		...
		clone = alloc_skb(0, GFP_ATOMIC);
		...
		skb_shinfo(clone)->frag_list = skb_shinfo(head)->frag_list;
		skb_frag_list_init(head);
		...
		skb_shinfo(head)->frag_list = clone;
		nextp = &clone->next;
    ...
}

The result is head -> frag_list[clone -> frag_list[...]]. That is the
nested layout the new check in skb_segment() rejects.

The GRO part is correct. dev_gro_receive() sets:

	NAPI_GRO_CB(skb)->flush = skb_has_frag_list(skb);

Reassembled skbs are not GSO, so they don't normally reach skb_segment().
The narrower claim seems to be what's meant: no in-tree path builds a GSO
skb with a nested frag_list.

Could the commit message say that instead, and mention IP defrag as a
known non-GSO source of nested frag_lists?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261019-b4-skbuff-bug-on-followups-v1-0-41dbef50b9f7%40toxicpanda.com
