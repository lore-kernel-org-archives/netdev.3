Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DD448E0C6;
	Fri,  2 Oct 2026 10:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790937150; cv=none; b=nT65r6qGXC7NJlP56HbGQimcL0j5kEqj9hxzR4o85Rq9kNauUTMM8b3w6D1WKg5dFFTTQUfYZ/Q3rwNFNdGGtdJZ1FFQakj2YnuSMcnGKZ+vj7gAcSN0YEZS2qDFWRpU0LHRD/QXr+ktvEDpK+5wPvCrnCI10Hi201bbBZTYY14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790937150; c=relaxed/simple;
	bh=2BiUoj3F8GdqNwJCoTRVtFybiAQNTna7nMnCjdzUqvs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k8nqKgX8atCO+7m1WWvHVJ0OGkriNE4L61EAK/JQsZY50rvpYwK9I41ecEVcdz3+hLrd0P5Flk6/rmWIpfOKWZyvVJupABcOks30hhDzBeT4VtdWtitW+1hbNwvuOqmXiv3heQTiHGLrOX1r1/xZrkRqHmT4DCSPokyZnHR40Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oR12Ow6x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oR12Ow6x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AE471F00898;
	Fri,  2 Oct 2026 10:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790937148;
	bh=kBd2oVzxJtTDvatf9HRPTe082Us0jeUGadi5NXD0xDY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=oR12Ow6xD/5YhwTN9WtP4AAC0HrW/dOyVz3XdeQQ0MqGShfKPLxCU/bTYsIXfqB15
	 Sz2V9axPzX+p/Q8rBO54aiWbrv3D/zPRdGjYPhOvV4rFkS94ZMSBZxrYjuuzR3FWW+
	 8phfmrBZSvWZlnhD0Wfft+vcNCYbZTTalFCq2Tkg5iF7vK9///OyCyvrIrl+yo/R2Q
	 NOIeaGVpbfu8XbBvMrV9IB1Fu49I0lypslanQXBUD2gSBw/EOls95f8N1aGSQAkH9+
	 ZfJsCZw3gfrOPmfkxrOIpjWl9/GzRKE32u6OXp7vlTPnyD4xCMVthFxUAJuf8rDE1T
	 NTS8QxLC7Xo6w==
Subject: Re: [PATCH 12/16 net-next v2] netfilter: ipv4: guard
 ip_route_me_harder() with CONFIG_IPV4
From: netdev-bot+sashiko@kernel.org
To: fmancera@suse.de
Cc: netdev@vger.kernel.org, horms@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, edumazet@kernel.org, davem@davemloft.net,
 edumazet@google.com, ebiggers@kernel.org, ardb@kernel.org, krzk@kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 02 Oct 2026 10:32:27 +0000
Message-ID: <179093714759.434549.2698814184548027577@kernel.org>
In-Reply-To: <20260928193046.6698-13-fmancera@suse.de>
References: <20260928193046.6698-13-fmancera@suse.de>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] In ip_route_me_harder() (net/ipv4/netfilter.c), the new `if
  (!IS_ENABLED(CONFIG_IPV4)) return -EPROTONOSUPPORT;` check (lines…

--

netfilter: ipv4: guard ip_route_me_harder() with CONFIG_IPV4

This commit adds an IS_ENABLED(CONFIG_IPV4) check to ip_route_me_harder()
in net/ipv4/netfilter.c. When IPv4 is disabled, the function returns
-EPROTONOSUPPORT and skips the IPv4 rerouting logic. The goal is to let
the network stack build without IPv4.

> diff --git a/net/ipv4/netfilter.c b/net/ipv4/netfilter.c
> index ce9e1bfa4259f..f2d9e0110b779 100644
> --- a/net/ipv4/netfilter.c
> +++ b/net/ipv4/netfilter.c
> @@ -30,6 +30,9 @@ int ip_route_me_harder(struct net *net, struct sock *sk, struct sk_buff *skb, un
>  	struct flow_keys flkeys;
>  	unsigned int hh_len;
>  
> +	if (!IS_ENABLED(CONFIG_IPV4))
> +		return -EPROTONOSUPPORT;
> +

[Severity: Low]
This isn't a bug, but would it be clearer to do this check before the
declaration initializers in ip_route_me_harder()?

As placed, the initializers above the check still load from the dst and
from the IPv4 header when CONFIG_IPV4=n:

net/ipv4/netfilter.c:ip_route_me_harder() {
	struct net_device *dev = skb_dst_dev(skb);
	const struct iphdr *iph = ip_hdr(skb);
	...
	__be32 saddr = iph->saddr;
	...
}

This doesn't look reachable in practice. With the rest of the series
applied, every in-tree caller sits behind a Kconfig option that depends
on IPV4. For example, the core netfilter menu in net/netfilter/Kconfig
now has:

	depends on INET && IPV4 && NETFILTER

The callers also always pass an skb that has a dst set.

Moving the IS_ENABLED(CONFIG_IPV4) check above the initializers, or
deferring those assignments until after it, would make it clearer that
nothing IPv4-specific runs when IPv4 is disabled.

>  	sk = sk_to_full_sk(sk);
>  	flags = sk ? inet_sk_flowi_flags(sk) : 0;
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928193046.6698-1-fmancera%40suse.de
