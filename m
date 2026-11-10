Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=94.136.29.106
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794306235;
	b=pGHsqpqJtpMDXaupCKL5+fQH3CCf8OM8OTepgWCbu62quHt04OqoF7TrkV2B9bSSkAE9
	 YlfL3aNMyg9JTE4o3Sir2P2CAm58kOLmrbf0rM5l+fkYRX8IJ5ppML88MZRVNh8LjtQS0
	 VwYkDCEhzOSNx88/PZ8fWndtWu6etm0uMJBpuNc5FUZNTUm9Jlmjbf/nLME7wEMPmy59U
	 gHjJuwCBZQ4qrrB/l+CKpE+CD2IOQ1rECrJltI6kYPpFbiMjZT6Aea6YZw4a6XAgAkjQ0
	 DqhIpQufHkBwNc5PZxA67iC/2BZJg7OmD+bQKuCwKHNswHLf6wWBjC6kPBsqk8SxNXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794306235;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent:
	 X-Bm-Milter-Handled:X-Bm-Transport-Timestamp;
	bh=h6kwJieY+oGcWyDMxdNXVOCZPKC8m+HXb6SspZnkgEM=;
	b=KyrnqiIZBZoB5kR0KIX0LdnN6BjQHCfO3ZwUWm+AoCeN9vubFHkV40j2sCnhLoymJn5B
	 R5XsgXDbhCsRG49DR80VW86suENeV/dR7xe4sd8Ovcee8kLu1UkX9RTUwg3OwKG1G5WDA
	 GFyBXEuGtTLAhd8iYL7u3ZonNJm3OImkwbo78aXNGycuM3RhOvrpr7t+1IDZB8zRLOCK6
	 PvJBwXCyHK8jGt8djMo/QK0cMI5czEi/zu1guCeQuN5knIBIt5HMcjbyiVoxBscnR+2gl
	 +tKVJPQWmeL8Y5wadzKUydzm5MGYjU3uFdwQhqoUKb+invtvRUGNE6rNHlmIk8P/GAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=proxmox.com;
	spf=pass smtp.mailfrom=proxmox.com;
	arc=none smtp.remote-ip=94.136.29.106
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B044606A41F;
	Tue, 10 Nov 2026 10:23:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B044606A41F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id D3522421B3;
	Tue, 10 Nov 2026 11:23:50 +0100 (CET)
Date: Tue, 10 Nov 2026 11:23:41 +0100
From: Gabriel Goller <g.goller@proxmox.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: David Ahern <dsahern@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Nicolas Dichtel <nicolas.dichtel@6wind.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] ipv6: Add NETCONFA_FORCE_FORWARDING to
 netconf messages
Message-ID: <avLwfaWRs5Gsdy3z@luna.proxmox.com>
References: <20261104-ipv6_add_netconfa-v2-1-6f660990062f@proxmox.com>
 <20261109090505.GA1495012@shredder>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261109090505.GA1495012@shredder>
User-Agent: NeoMutt/20260504
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1794306229935

On 09.11.2026 11:05, Ido Schimmel wrote:
> On Wed, Nov 04, 2026 at 10:46:10AM +0100, Gabriel Goller wrote:
> > Since force_forwarding was added, changing the sysctl sends an
> > RTM_NEWNETCONF notification of type NETCONFA_FORCE_FORWARDING, but
> > inet6_netconf_fill_devconf() never emits the attribute. Listeners only
> > receive NETCONFA_IFINDEX without the new value, and RTM_GETNETCONF
> > replies and dumps omit it as well.
> > 
> > Also send a notification when disabling all.forwarding resets
> > force_forwarding on an interface, which previously happened silently.
> > 
> > Fixes: f24987ef6959 ("ipv6: add `force_forwarding` sysctl to enable per-interface forwarding")
> 
> Fixes tag on net-next is only valid when the blamed commit is only in
> net-next, but maybe Paolo / Jakub will agree to strip it, so wait with
> v3.
> 
> > Signed-off-by: Gabriel Goller <g.goller@proxmox.com>
> 
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> 
> There's a report from Sashiko [1] about a pre-existing issue:
> all.force_forwarding not being cleared when all.forwarding is cleared.
> 
> # ip link add name dummy1 type dummy
> # sysctl -wq net.ipv6.conf.all.forwarding=1
> # sysctl -wq net.ipv6.conf.all.force_forwarding=1
> # sysctl -wq net.ipv6.conf.all.forwarding=0
> # sysctl net.ipv6.conf.dummy1.force_forwarding
> net.ipv6.conf.dummy1.force_forwarding = 0
> # sysctl net.ipv6.conf.all.force_forwarding
> net.ipv6.conf.all.force_forwarding = 1
> 
> [1] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261104-ipv6_add_netconfa-v2-1-6f660990062f@proxmox.com

Thanks, sent a patch:

https://lore.kernel.org/netdev/20261109-ipv6_reset_all-v1-1-815dfd508246@proxmox.com/

Gabriel

