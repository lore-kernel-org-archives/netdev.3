Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E3653A3A4;
	Tue, 22 Sep 2026 11:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790076313; cv=none; b=Y9okXRhwmi7JdF2RZRnuR8SI86bcEyYJUutP+kZ/tU0T46irf+mDlo9d7n+cZq4sr7vwthJpLjh7D7XBcUlPuMm0SlPyl6KksNAPxxtP68ezf1Ru7e3BWrDsV1Dk8OnZzjGQuPrIuxGXsEOySrfH7IP5qMCviVxIfugw487ACdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790076313; c=relaxed/simple;
	bh=TgalchcoibnoyVEs/hoM7b/geNJQO8Ppvnp0vL5xEVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cV007DXMVa/9AtvCSqpbZJ5//suXsZuq+pvrwhr8PYzsFZKgyJZC8YEP9L0+bXHXx4vifi0JeYCNPXCcfR630AeEzpPSKOkUcjAG8bmDoEZbSRjulVKvgxUwG2UE7bx3obfh6KEn36YjtYaNTuCDL1XaPGjHQwapNBTMMVHL8C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 614E042212;
	Tue, 22 Sep 2026 13:24:52 +0200 (CEST)
Date: Tue, 22 Sep 2026 13:24:50 +0200
From: Gabriel Goller <g.goller@proxmox.com>
To: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Cc: Andrea Mayer <andrea.mayer@uniroma2.it>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Justin Iurman <justin.iurman@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] net: ipv6: keep room for the mac header in
 dst_dev_overhead()
Message-ID: <arJlHYp_IfNJG7jg@luna.proxmox.com>
References: <20260922-seg6-maclen-headroom-v3-1-7b2f982ef79d@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260922-seg6-maclen-headroom-v3-1-7b2f982ef79d@gmail.com>
User-Agent: NeoMutt/20260504
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1790076291622

On 22.09.2026 05:49, Yuya Kusakabe wrote:
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

LGTM

Did a quick test and could reproduce the issue:

FAIL seg6 inline nsegs=4
[    3.557169] BUG: KASAN: slab-use-after-free in __seg6_do_srh_inline+0x34b/0x620

Couldn't reproduce it after applying this patch.

Consider:
Reviewed-by: Gabriel Goller <g.goller@proxmox.com>
Tested-by: Gabriel Goller <g.goller@proxmox.com>



