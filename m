Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7C439021A
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 22:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791326275; cv=none; b=PEawf+hfwaCntrQRC36+1xNX7wfDZVN8YZUcyf8DDK2/budZzqSR+bRebJQEnoR/X7tyD08JQ0F9LkLSmhsL2d6FiohRy5u4UahG7u/DLjgi9xIDW9u7N7hSjNj4AkaE0UgfV3MArggslee8BZvVG1GS/86TFdy6hiOabVmjGOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791326275; c=relaxed/simple;
	bh=LW9atCm9VFD0cTrIJK+qGBXEbKr4PZeE5YdpjeiW/ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Br2OdVBXe8CNd/gpAWd7bydTL0sEjxKjQipRdlnDu8N9H8gbRGCtLbsD67p5CCIgYWLFHx00UI5nQrOBF83b/P4iWhrreicO7UAECtqKCojDSe0tvShwytvyscuquQsRv6ApgwbjFNRFHnfgwpE90gOumK2PWdbnaABHCPeBVGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X0UNl7xq; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kx3dSTNJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X0UNl7xq";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kx3dSTNJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791326272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MbgSlPJhc2ANdcXNYY+nH9MC+4qUtrv82MenWaQtLwQ=;
	b=X0UNl7xqF+M8aSAWAuaDCbn2sorM71zXNfnef2AH+/8bFRNw2uJjnIRRYrvWLvQ21b9HqP
	iagzFAttmOQYHr9jC9qCcmrADKmSluW3xQf/D/W0c7deZTSBs0/vWoQB++RE92GhxOzXkF
	GoAcfKqifJgXiTvCReWkAsnnyuxgDxE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-SbpdL3KxN4ipBHRieOgVeg-1; Tue, 06 Oct 2026 18:37:51 -0400
X-MC-Unique: SbpdL3KxN4ipBHRieOgVeg-1
X-Mimecast-MFC-AGG-ID: SbpdL3KxN4ipBHRieOgVeg_1791326270
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a1721559b4so23887985e9.1
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 15:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791326270; x=1791931070; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MbgSlPJhc2ANdcXNYY+nH9MC+4qUtrv82MenWaQtLwQ=;
        b=kx3dSTNJ5c8MoMTWkHw4/w1XZ7vhk+wXwacD3+TXZtGsAWnY9BIm84oxYAdSlrmvl6
         sVg529Xk9BCLvD17GYQAB6yEjRj2bqokuPhFYn+z1flfzThQOZ6eaLCMv74+dBprNF1J
         YFq16ibNLsyFETMTpofxld2jEnjjwglafJGW1YtfRISv9ZTF+l/+s9wdO/yz4qbzC2Ku
         w76iTQ3M8pC0XPznr+NqN5A1i2g/2rPCGIbel9YU9yJR65terqCbqP2qHqsY38aHzeUC
         MvBxWBwCesPLKp2SL00anQ/6IfuzZcFmRqnwb3ZKzl1PnTbNu+FE5AykNLy38FlPZpr9
         8Aow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791326270; x=1791931070;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MbgSlPJhc2ANdcXNYY+nH9MC+4qUtrv82MenWaQtLwQ=;
        b=bd3Zdw4HkvWtkmmAxHRMF+MdoRKNB8gSu2aBHoKZa0UgcmcMCMOKecn6D736w0tIb6
         g6+23jLU5HpxVe7T3kUDSC9i/4Y/QqQO6KgN5ayN9pDVHMGiVG8okzV4xPLq1R8Nx9XX
         BMTtMM5jYYetbJtPoLSViyzgrZqGpqY6hVn9pQoZGXiUoh6hvjQCp7V/sS9tH0vJUw5q
         CFvg19P8YfT0janFITlHukliPTpbTARSaz3lTb014+xg7VbR3Ze6EXIcYuIzSXyMR86l
         nQbe68C5OcCTqfo1CY8vxN0wZv70wtTop3gs3YgP1P1oZ+8dC6WZml61SU0Gu4idH5kt
         8PTg==
X-Forwarded-Encrypted: i=1; AKwUvBy8PsBnPrW0Z6PlO8NYmZoOxA14PUy/165517mc97+TBv//spRd2XesCMClqpujH4Bv//P88Fg=@vger.kernel.org
X-Gm-Message-State: AFuF++luFLNPy6xPRwJsbwIE+NemYeVN7uqxWmIiQb+O8MGoPnMOLGS5
	i5CuUHsKvyCpkCVQ231blwSVz8Xa/F8KxcqSw3PcvsAqJl2DzlPOMrfa952V0+KBaHJi3wfGbGu
	M2xWa2K/ZDwnJt6brmZNrE7n+srW6KveFKfnziav0MoZHZG54QbEeIJ3SOA==
X-Gm-Gg: AYBFou3cHCw6vSGsqCx5YDeNzjRpPuBIhqbU6/+tlEmMcCOLpjXN+lEdVF0JzjqeBzU
	31YV+FgsQg0Cs+CwiVMzWOLDygzTLPs9IbAk8PtbsXyKjqETcXmwnKD0i+N8P9+LiEZSm+oGXtl
	DakwqM9L/yNd0l+bWAECHEfXc7E2KVWAo1/W3aQXMevIuasHl0iPHa2GhQsubs2DOUNczKjVq1f
	CnDxrH8vg+vidTp2DfkozJRlv0KFkxvGFleNRgsC40s1ByA692QYWnt7feItc1LBT6+3V0QaKJO
	JwUeTL6XgxQOjkR2fYgd7oMCcNBzSGSpHs0uQ4/nGuL0+OOAA6aw6Fpr31ldcU+a1GqSFfc=
X-Received: by 2002:a05:600c:4ece:b0:4a1:7033:5b55 with SMTP id 5b1f17b1804b1-4a18043c431mr3023555e9.21.1791326269807;
        Tue, 06 Oct 2026 15:37:49 -0700 (PDT)
X-Received: by 2002:a05:600c:4ece:b0:4a1:7033:5b55 with SMTP id 5b1f17b1804b1-4a18043c431mr3023435e9.21.1791326269231;
        Tue, 06 Oct 2026 15:37:49 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a178a17ac9sm101729495e9.1.2026.10.06.15.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 15:37:47 -0700 (PDT)
Date: Tue, 6 Oct 2026 18:37:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	edumazet@google.com
Subject: Re: [PATCH v3 net 0/3] net: always dissect GSO packets in
 __virtio_net_hdr_to_skb()
Message-ID: <20261006183410-mutt-send-email-mst@kernel.org>
References: <20261001191140.2818991-1-edumazet@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001191140.2818991-1-edumazet@kernel.org>

On Thu, Oct 01, 2026 at 07:11:37PM +0000, Eric Dumazet wrote:
> This series fixes a bypass of untrusted GSO flow dissection in
> __virtio_net_hdr_to_skb() when VIRTIO_NET_HDR_F_NEEDS_CSUM is not set,
> and adds a kselftest covering VLAN-tagged GSO packets without NEEDS_CSUM:
> 
> - Patch 1 fixes __skb_flow_dissect(), which computes key_control->thoff
>   with min_t(u16, ...). This truncates skb->len and returns a bogus small
>   transport offset when skb->len modulo 65536 is smaller than the
>   transport offset. Offsets that do not fit in the u16 thoff now fail the
>   dissection instead of being silently truncated.
> 
> - Patch 2 initializes skb->dev and skb->network_header before calling
>   virtio_net_hdr_*_to_skb() in tun_get_user(), tun_xdp_one(),
>   virtnet_receive_done(), and raw_verify_header(), removes the
>   '&& skb->network_header' condition and the unvalidated
>   'else if (gso_type)' fallback in __virtio_net_hdr_to_skb(), and moves
>   virtio_net_hdr_match_proto() after skb_flow_dissect_flow_keys_basic()
>   so it validates the dissected L3 protocol (keys.basic.n_proto) rather
>   than the outer L2 protocol.
> 
> - Patch 3 adds kselftests in tools/testing/selftests/net/tun.c verifying
>   that VLAN-tagged (802.1Q) TCPv4 GSO packets without NEEDS_CSUM (both
>   flags = 0 and flags = VIRTIO_NET_HDR_F_DATA_VALID) are accepted on a
>   TAP device, that mismatched GSO types and truncated TCP headers without
>   NEEDS_CSUM are rejected with -EINVAL, and that a 65540-byte frame is
>   accepted.
> 
> v3:
>  - New patch 1: avoid u16 truncation of skb->len when computing thoff in
>    __skb_flow_dissect(). Patch 2 makes tun_get_user() dissect IFF_TAP
>    frames before eth_type_trans(), with skb->len up to 65549 for a GSO
>    frame carrying a maximal IPv4 packet (Sashiko).
>  - Patch 3: truncate the TCP header after 10 bytes so that the test
>    requires the transport offset found by flow dissection, and add a
>    65540-byte frame test (Sashiko).
>  - Link to v2: https://lore.kernel.org/netdev/20260928144254.3361044-1-edumazet@kernel.org/
> 
> v2:
>  - Patch 2: drop the pre-dissection virtio_net_hdr_match_proto() check
>    inside 'if (!skb->protocol)' so VLAN-tagged GSO frames without
>    NEEDS_CSUM are not rejected before flow dissection (Michael S. Tsirkin).
>  - Patch 2: clarify the changelog regarding why skb->network_header was 0
>    in those callers and why skb_reset_mac_header() is dropped in
>    tun_get_user() for IFF_TUN (Michael S. Tsirkin).
>  - Patch 3: add selftest in tools/testing/selftests/net/tun.c based on
>    Michael's reproducer.
>  - Link to v1: https://lore.kernel.org/netdev/20260927195536.2489079-1-edumazet@google.com/


Not without trepidation about the amount of stuff we are shoving
into virtio_net_hdr_to_skb which, believe me or not, used to be 50 LOC
of trivial code in 2019:

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> Eric Dumazet (3):
>   flow_dissector: avoid u16 truncation of skb->len when computing thoff
>   net: always dissect GSO packets in __virtio_net_hdr_to_skb()
>   selftests: net: tun: add test for VLAN-tagged GSO without NEEDS_CSUM
> 
>  arch/um/drivers/vector_transports.c |   1 +
>  drivers/net/tun.c                   |  23 +++--
>  drivers/net/virtio_net.c            |   2 +
>  include/linux/virtio_net.h          |  60 +++++-------
>  net/core/flow_dissector.c           |   9 +-
>  tools/testing/selftests/net/tun.c   | 136 ++++++++++++++++++++++++++++
>  6 files changed, 186 insertions(+), 45 deletions(-)
> 
> -- 
> 2.56.0.rc1.315.gc6ed9934b7-goog

