Received: from smtp.uniroma2.it (smtp-2015.uniroma2.it [160.80.4.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3CB1D95A3
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 22:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787092661; cv=none; b=jOx0cd6kUBDwLW+khxzeyVOtTVo+qs4lYQ70+gw3bEITBB0A8jIknk1bPMxTzvcLtu/XuK1XVanTUZQC4Y71TdE/8YQCRo+K9e1LIPlb4/zgFlsQV8UfhtG1pcgxRjAxPt8lyVVFq0TLUpD3qIgVDzct+3KWWLjIhO9F5qkmnCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787092661; c=relaxed/simple;
	bh=UzS9w0sFiHAHy9w7py5Wtj7bu2/vwiNt42H3UzfTjNk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=qk+R8vyoqM963YZreWQhNJhW6kEE2jfI4tYtH6ERmxAHEDwLHHQn05HjkvsUxi2skpdPesHDB5LtZQnvqo+XTMj1gpRrABpogQ+9wyE4i9F3qGijn3d80XdlFNMfcRFjGvHNw3lrN9W70P279JHMXHs/z+rKjZmP6eA99nLD6m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=qsUzh4az; dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=eGqbQHCZ; arc=none smtp.client-ip=160.80.4.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="qsUzh4az";
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="eGqbQHCZ"
Received: from smtpauth-2019-1.uniroma2.it (smtpauth.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 67IManwB012641;
	Wed, 19 Aug 2026 00:36:54 +0200
Received: from lubuntu-18.04 (unknown [160.80.103.126])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id 60ED31205C5;
	Wed, 19 Aug 2026 00:36:44 +0200 (CEST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1787092604; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1SHU093/KheIL0OKgpv6W2TuNWpnBOPWpDSlYv4PV3Y=;
	b=qsUzh4azteG9XbRun6ZRZ9IP9lkUml1zrYp3NZJ63d/D+inRoR0Vw3YFM1JCIUYWf1bkd2
	lq8vgZla7ZtRxMDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1787092604; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1SHU093/KheIL0OKgpv6W2TuNWpnBOPWpDSlYv4PV3Y=;
	b=eGqbQHCZ1kqVaMKWotm5Qa3q6iUXGAbex+m90tSwEOybJEJ/nrdgTpz4qwGKw8vYR97q11
	t1SNkCqVC1hILN8b71WpUtj5Duf8fBpH0nPa9eedP8IWyviSfb4WzowLO5vZSo2tloyIDs
	QvjMc39Ek22M+9lFmVShxaGrk+28YV+RkJ+0vkbn4eYmS2+YII7wyvZl3lqdJV1ArKwRRy
	nsaESjJrXLAKnlbKw21f+e8kt/fGbJzvKTIk0v8kKxwr0v4BggWivxY3W/wJC0gBx2wAAw
	a/KgqTSTWcyZUK8witx6rZH4AS0N+rAabawLq6NXVHAca3rrgdwiu3lsmLYQtg==
Date: Wed, 19 Aug 2026 00:36:44 +0200
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: Zhiling Zou <zhilinz@nebusec.ai>
Cc: netdev@vger.kernel.org, davem@davemloft.net,
        Jakub Kicinski
 <kuba@kernel.org>, edumazet@google.com,
        pabeni@redhat.com, David Ahern
 <dsahern@kernel.org>, horms@kernel.org,
        david.lebrun@uclouvain.be, vega@nebusec.ai,
        stefano.salsano@uniroma2.it, Andrea Mayer
 <andrea.mayer@uniroma2.it>
Subject: Re: [PATCH net 1/1] seg6: reset IP6CB after IPv6 decapsulation
Message-Id: <20260819003644.2f1b7a9b60d0ed22d37aca11@uniroma2.it>
In-Reply-To: <cb0b571546147162dd63bd3a93952144734b1503.1786896221.git.zhilinz@nebusec.ai>
References: <cover.1786896221.git.zhilinz@nebusec.ai>
	<cb0b571546147162dd63bd3a93952144734b1503.1786896221.git.zhilinz@nebusec.ai>
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

On Mon, 17 Aug 2026 00:09:29 +0800
Zhiling Zou <zhilinz@nebusec.ai> wrote:

Hi Zhiling,

thank you for the patch and the reproducer. I reported the same stale
IP6CB while reviewing an IPv4 fix for the same helper [1].

Some comments below.

> decap_and_validate() pulls the outer SRv6 headers and makes the
> inner packet the skb network header. The IPv6 control block still
> contains values collected while parsing the outer packet, including
> nhoff and extension-header flags.
>
> End.DX6 and End.DT6 then route the inner IPv6 packet directly to
> the IPv6 input path. If an outer extension header left a large
> nhoff, ip6_protocol_deliver_rcu() reads
> skb_network_header(skb)[nhoff] from the inner packet, which may be
> beyond the skb head.

A KASAN trace trimmed to the relevant calls from the cover letter
would help here, along with the reachability. The commit is what
lands in git log.

> Clear IP6CB after IPv6 decapsulation, restore the incoming interface,
> and initialize nhoff to the inner IPv6 base-header nexthdr field before
> delivering the packet.
>
> Fixes: d7a669dd2f8b ("ipv6: sr: add helper functions for seg6local")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
> ---
>  net/ipv6/seg6_local.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
> index 2b41e4c0dddd1..4df76fa85d6b4 100644
> --- a/net/ipv6/seg6_local.c
> +++ b/net/ipv6/seg6_local.c
> @@ -253,6 +253,11 @@ static bool decap_and_validate(struct sk_buff *skb, int proto)
>
>  	skb_reset_network_header(skb);
>  	skb_reset_transport_header(skb);
> +	if (proto == IPPROTO_IPV6) {
> +		memset(IP6CB(skb), 0, sizeof(*IP6CB(skb)));
> +		IP6CB(skb)->iif = skb->skb_iif;
> +		IP6CB(skb)->nhoff = offsetof(struct ipv6hdr, nexthdr);
> +	}
>  	if (iptunnel_pull_offloads(skb))
>  		return false;

The index would need to come from IP6CB->iif, saving it before the memset.
ip6_rcv_core() sets that field before l3mdev runs, and vrf_ip6_rcv() then
replaces skb->skb_iif with the master without touching IP6CB->iif.

I measured it on net/main and on two variants of the fix, one taking the
index from skb->skb_iif and one from IP6CB->iif. The receiver is a UDP
socket bound to the VRF reading IPV6_PKTINFO, the datagram arrives on
ifindex 8, and the VRF device is 9:

                          no patch   skb->skb_iif   IP6CB->iif
  without decapsulation          8              8            8
  End.DT6 vrftable               8              9            8
  End.DT6 table                  8              9            8

The patch that fixes the IPv4 side uses IP6CB->iif for this reason [2].

IP6SKB_L3SLAVE would also need to be carried across. vrf_ip6_rcv() sets
that flag on the outer packet, and the memset drops it.

Something like this:

	bool l3slave = ipv6_l3mdev_skb(IP6CB(skb)->flags);
	int iif = IP6CB(skb)->iif;

	memset(IP6CB(skb), 0, sizeof(*IP6CB(skb)));
	IP6CB(skb)->iif = iif;
	IP6CB(skb)->nhoff = offsetof(struct ipv6hdr, nexthdr);
	if (l3slave)
		IP6CB(skb)->flags |= IP6SKB_L3SLAVE;

The fix for the IPv4 side of this helper is now at its v4 [2]. Both touch
decap_and_validate(), so your block would go next to theirs as an else if.

Thanks,

Ciao,
Andrea

[1] https://lore.kernel.org/netdev/20260809221915.2ffc1ecd0f445fcb70270e31@uniroma2.it/
[2] https://lore.kernel.org/netdev/20260817085839.946321-1-david.lee@trailofbits.com/
