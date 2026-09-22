Received: from smtp.uniroma2.it (smtp-2015.uniroma2.it [160.80.4.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4085A53D0B1;
	Tue, 22 Sep 2026 15:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790090033; cv=none; b=DmVexpCUgTT5pNXQOWL/w4IGMrWlvc6ZqReBhbbOH3g6aAzhVvg+QkElZo3M8tEM/1YXg3ioMg1xqiL9G5P7XxNrnIzlIBTMwIpQIwicz19ExeXRXjIKew0V8srCpc732j1CfEIUAJGbc28WYRVNlnXNgYsnyr09v40C32E0ZvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790090033; c=relaxed/simple;
	bh=/2xq9DPwE3L16cCd6eTM6rYKcsdwWDIewQrrLjuSvN0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=FU3LYMbzSBFTE9iMS6cOh4Vsz4f35lAQkSUSWiP7LM1DU08WFaxRkMKStqimNkFyXpc+8gGbdXElFu0CzHXRP84HbVcj6pT+XlQsX0yeLZj/5MvcbWhrmLZNLz9CMJ7IIPIghMEfxErix2leGkOzvaP44sHl2j5AqcVbMZKStd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=gnBPh8az; dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=rKHuWOaA; arc=none smtp.client-ip=160.80.4.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="gnBPh8az";
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="rKHuWOaA"
Received: from smtpauth-2019-1.uniroma2.it (smtpauth.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 68MFDHNt020020;
	Tue, 22 Sep 2026 17:13:23 +0200
Received: from lubuntu-18.04 (host-79-20-84-28.retail.telecomitalia.it [79.20.84.28])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id 7B2311228F4;
	Tue, 22 Sep 2026 17:13:13 +0200 (CEST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1790089993; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qFrsjbh7CASY9oxnwYk+AY/nluAsH8IF18Z0KsHOg/Y=;
	b=gnBPh8az478OkyzGrNQ/woLFKvhU7iZuz/SOrMc3aFqnpFVOSceFBibUBNfwOsd2b5DXSf
	Auvyo/RAhkR/oICQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1790089993; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qFrsjbh7CASY9oxnwYk+AY/nluAsH8IF18Z0KsHOg/Y=;
	b=rKHuWOaAeWB+ONo+aL6gmWOxtvkSkCiYoKOvjxMnZIuioU3zw0Y1+5Xlya5YH145Syn+RI
	JcCduhM3L2TGSQ9svXuI7uFqmJlAS18O+W52J40HbZ34R6Vgjj5KkdOga71MXXKegP9/sE
	jdRyvyYrgAQQzLK5R+e4wTU1Y2VI0UmHTkldwvZDe+4EJfxKp6im9uSR8ao9vuFphcr+fi
	zsuEzZXZB7x+hITqo9Zg+IyIovNSiBnudyDTxUc0y91RJ6lDQnIAvQEKwVMblEPKNSc4Gi
	de4hEmEN3TCEWnRkSetlh7IYeaqWoc59+TbelKuP8yoZnAqwLYM5j7recN9QMw==
Date: Tue, 22 Sep 2026 17:13:13 +0200
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Justin Iurman
 <justin.iurman@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: Re: [PATCH net v3] net: ipv6: keep room for the mac header in
 dst_dev_overhead()
Message-Id: <20260922171313.3a094ae86725b0898f92ec11@uniroma2.it>
In-Reply-To: <20260922-seg6-maclen-headroom-v3-1-7b2f982ef79d@gmail.com>
References: <20260922-seg6-maclen-headroom-v3-1-7b2f982ef79d@gmail.com>
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

On Tue, 22 Sep 2026 05:49:56 +0900
Yuya Kusakabe <yuya.kusakabe@gmail.com> wrote:

> The seg6, ioam6 and rpl lwtunnels size their skb_cow_head() request as
> the length they are about to push plus dst_dev_overhead(), then push the
> new headers and rebuild the mac header below them with
> skb_mac_header_rebuild().  That rebuild needs skb->mac_len of headroom,
> but dst_dev_overhead() leaves LL_RESERVED_SPACE() of the egress device,
> 16 bytes for plain Ethernet.
> 
> Where the mac header is longer than that, as it is on ingress through a
> VLAN device with reorder_hdr off, the rebuild runs out of room:
> skb_set_mac_header(skb, -skb->mac_len) computes a negative offset,
> stores it unchecked in the u16 skb->mac_header, and the memmove that
> follows writes skb->mac_len bytes about 64 KB past skb->head.
> Forwarding plain ping6 traffic through such a device reproduces it on
> all five seg6 encapsulation modes and on the rpl and ioam6 inline paths;
> skb->mac_header comes back as 65534 on a 704-byte head.
> 
> Return the larger of the two.  The helper already returns skb->mac_len
> when it has no dst, so this only makes the other branch agree, and it
> covers every caller rather than each call site in turn.
> 
> Fixes: 40475b63761a ("net: ipv6: seg6_iptunnel: mitigate 2-realloc issue")
> Fixes: dce525185bc9 ("net: ipv6: ioam6_iptunnel: mitigate 2-realloc issue")
> Fixes: 985ec6f5e623 ("net: ipv6: rpl_iptunnel: mitigate 2-realloc issue")
> Suggested-by: Andrea Mayer <andrea.mayer@uniroma2.it>
> Assisted-by: LLM
> Signed-off-by: Yuya Kusakabe <yuya.kusakabe@gmail.com>
> ---
> Changes in v3:
> - Fix dst_dev_overhead() itself rather than each of its callers [Andrea]
> - Drop Justin's Reviewed-by from v2, which was given for the per-caller
>   version; the patch no longer touches the files he reviewed
> - Link to v2: https://lore.kernel.org/r/20260918-seg6-maclen-headroom-v2-1-4d370af55b2e@gmail.com
> 
> Changes in v2:
> - Use max_t(unsigned int, ...) rather than max() [Justin]
> - Make the same change in ioam6_iptunnel and rpl_iptunnel [Justin]
> - Reproduce and verify the fix on those two as well: unpatched, rpl
>   underflows in 12 of 16 probed configurations and ioam6 in 3 of 13,
>   both reaching about 64 KB past a 320-byte head; patched, neither
>   underflows in 18
> - Rewrap the requests so they no longer exceed 80 columns
> - Retitle for net: ipv6, now that the change spans three files
> - Link to v1: https://lore.kernel.org/r/20260917-seg6-maclen-headroom-v1-1-02ccec50f096@gmail.com
> ---
>  include/net/dst.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Thanks for the rework,
Andrea

Reviewed-by: Andrea Mayer <andrea.mayer@uniroma2.it>
