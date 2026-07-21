Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DFB331ED2
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 10:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784631325; cv=none; b=lrrI65XbKw8UuNE5ZSLraxhIwvB63ClNk+u7tBTkCTcz1hKy+HTM+hX2zQ+T722FSDEJo2ezFQbfcuIy2mv4YgtgiCaBxF3Ja1nUEbBDCjw+mJAq4Et1CL93H/+Ula5V1noWBHrv+BXVwkaURuAr8a84JmFgE1H6suzzEVNT9+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784631325; c=relaxed/simple;
	bh=/SzLQcE1OQdrNsT+zEZFUFXumQRVYUTyIGtOuiqGebk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QgEKVvbsQ0xG9GtzA/7w/OT7ILpD/rdGWtnCzbsPWb823+grB7l1WVQc2Lzvu+WLY7qZLW5OVQAd5SOUfIHATTLD1WjirbhW2XikeQAJ6HxeVSK+Y31aMJ9sOh/hO6QnMbgdJnrCgd41deylUARN6NDtbKWA4vhb939WQ4n8dJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VroLsdEM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VroLsdEM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784631322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1bUvSGmbIPm69AKuylTIIVt+7rRP29lqoU1p/pLMXjE=;
	b=VroLsdEMvdSNR9D/kOcf0tCKl5jR5Ora8c0qwpFw1h26hUbd1xjucoHoBOYxTd2lQ0xI+K
	IhFbxpesX+rwLxu9gCjLg2CLgX9TQvrQ58IbMXLkOYRapQ5mJ5htbAZsUxa2x/d56bF7c6
	+oHpY7dJshBtdicwRl4yRNHWmjKqzpA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-ObozKGiEOvGIsLdAObkNHQ-1; Tue,
 21 Jul 2026 06:55:19 -0400
X-MC-Unique: ObozKGiEOvGIsLdAObkNHQ-1
X-Mimecast-MFC-AGG-ID: ObozKGiEOvGIsLdAObkNHQ_1784631317
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E9D4D180058D;
	Tue, 21 Jul 2026 10:55:16 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.106])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E304B1955F74;
	Tue, 21 Jul 2026 10:55:12 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: lorenzo@kernel.org
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	pablo@netfilter.org,
	fw@strlen.de,
	netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org
Subject: Re: [PATCH net-next] net: ip6_tunnel: use tunnel parameters for fill_forward_path route lookup
Date: Tue, 21 Jul 2026 12:54:57 +0200
Message-ID: <20260721105458.196550-1-pabeni@redhat.com>
In-Reply-To: <20260708-ip6ip6-route-lookup-fill_forward_path-v1-1-863b9647102e@kernel.org>
References: <20260708-ip6ip6-route-lookup-fill_forward_path-v1-1-863b9647102e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

From: AI Reviewer <ai@example.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev/
---
--- Patch [1]: [PATCH net-next] net: ip6_tunnel: use tunnel parameters for fill_forward_path route lookup ---
commit 40b6b6aa3f042df26b7e3c0a15bf2f7d4b9e9df6
Author: Lorenzo Bianconi <lorenzo@kernel.org>

net: ip6_tunnel: use tunnel parameters for fill_forward_path route lookup

This commit updates ip6_tnl_fill_forward_path() to pass the source address,
output interface, and flowlabel from the tunnel configuration to the flowi6
struct. This change intends to align the hardware offload route lookup with
the slow path implementation in ipxip6_tnl_xmit().

> diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
> index bf8e40af60b08..557d8637ac57e 100644
> --- a/net/ipv6/ip6_tunnel.c
> +++ b/net/ipv6/ip6_tunnel.c
> @@ -1847,6 +1847,10 @@ static int ip6_tnl_fill_forward_path(struct net_device_path_ctx *ctx,
>  	struct ip6_tnl *t = netdev_priv(ctx->dev);
>  	struct flowi6 fl6 = {
>  		.daddr = t->parms.raddr,
> +		.saddr = t->parms.laddr,

[Severity: High]
This is a pre-existing issue, but does reading the 128-bit IPv6 addresses
locklessly here risk torn reads if ip6_tnl_update() modifies the parameters
concurrently?

Since these addresses are read again later in this function to populate the
path tunnel information:

ip6_tnl_fill_forward_path() {
    ...
    path->tun.src_v6 = t->parms.laddr;
    path->tun.dst_v6 = t->parms.raddr;
    ...
}

could a concurrent update cause the hardware offload metadata to point to
new endpoints while the egress route was chosen using the old endpoints?
Would it be safer to reuse the fl6.saddr and fl6.daddr values for the path
metadata?

> +		.flowi6_oif = t->parms.link,

[Severity: High]
This is a pre-existing issue, but should the route lookup also include
t->parms.fwmark?

The commit aligns the route lookup with the slow path, but omits
flowi6_mark. If a tunnel relies on fwmark-based policy routing, leaving the
mark as 0 might cause the hardware offload path to resolve to a different
egress device than the software slow path.

> +		.flowlabel = t->parms.flowinfo &
> +			     (IPV6_TCLASS_MASK | IPV6_FLOWLABEL_MASK),

[Severity: High]
Does unconditionally applying the flowinfo mask here bypass per-packet
dynamic routing constraints?

If a tunnel is configured with IP6_TNL_F_USE_ORIG_TCLASS,
IP6_TNL_F_USE_ORIG_FLOWLABEL, or IP6_TNL_F_USE_ORIG_FWMARK, the egress route
might vary dynamically based on the inner packet. Since
ip6_tnl_fill_forward_path() provides a single static path for hardware
offload, shouldn't it explicitly check for these dynamic flags and return
-EOPNOTSUPP, similar to how it handles unsupported encap limits?

>  	};
-- 
This is an AI-generated review.

