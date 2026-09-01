Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA2840681D
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 14:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788271571; cv=none; b=QeSfvj9/0YeLqaGzDq0yAmrZcSheo5OUkR7DEeCZTos7FQFOpU5W4+bqSnuvhiTqMepqKQ36Nk0K1SGZMIOIgKMn8IR+WWrrTV5gzXnAa4h4X0Yim6jHoJoeiN5XvJBIvtvvSMrGbJ9gYzGuCwex4FureZ8M8hPpx96wVDxMH4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788271571; c=relaxed/simple;
	bh=SgwD3wWY96UMdD/fOd5W3tOGifSkfDvuwVKz8MZDNjQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=UhTQDiynWi2J9jhw+Vdn7+m4WqXbzuOneGtj1NvyiMBX47ndNpi1gu2W3BJCc9ZYYDwJQOyBt3CIXiQcU61GgMTNAP+70EcxcZen/0RwaOrrP+KzGhN5pQQKyGWpDmLKOqwfEqQQVnmhRnyIuEXVY7rNwqnl9x3nt84bUaylAqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K9uQRAn+; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K9uQRAn+"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-866e57f63a3so11176307b3.3
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 07:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788271569; x=1788876369; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5lSbV3WqhosfQnjNgDrl2jnEdo6wDJR4cvwjRytfZyc=;
        b=K9uQRAn+k71QtZNvSzsBKx7/DCfdJCKMWGVIWixYKN+FmYxGQJn1oamJ6mbUQVcNKN
         DozhuVA2pm80fKADaD2BEk93PRLCCLfwnSRCoreU8dOde9BcJaPWH0wWRIrrqnwX0sNW
         qNtb7yt3/lfCcmdznN7y7rXgC86kz7TID5MKpCih8KALdeA8/Fbr9Kn0BW5GWI4iDOy6
         oqvd0Sd+qVYUxLY28SEA0xn9rWmIkZ97a18ybuXWqy+1RNxM/6VWz5qgqxv4AYNLPUFJ
         TroAbKUuWLryMnvh4/t/Dccf62saFgQtih+xs4+KsFDlkxQn7ARYmwQ9bAUWQKuP5dP6
         3vaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788271569; x=1788876369;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5lSbV3WqhosfQnjNgDrl2jnEdo6wDJR4cvwjRytfZyc=;
        b=fKWX+bXyC8M5e9JKlnUzW0/A9H3k5w/JmXuSb+Cf8QIcIfaZeYNtKo0vsVgOY9VJD0
         kF1FbjUuKCUJhWmTiEEbpG/UIC2z/uDexdip/pim4UW7lu077bRpWBh9T5Lne8PmG99T
         u5iZs+MhIGzxmImoYNsvkyHgt0Ggw7SpWeyj/idIwaLde6X3ENuDsqdiZc+PqYXlGspA
         Vl18cX+tYywRXBgrDnT3PsbCDiOs4aTOB8C3Se+BPK/P+lP2ceXaRgsXXfI1p2sO8zKJ
         cLcXvK3V+52/8+P1TbROVb2mqyOuThbaNI76iIZvr4S8UJR/kfz3nkzT7BB14lKJDYkO
         fLnQ==
X-Forwarded-Encrypted: i=1; AKwUvBy02IdJDC61CB+MzRuyDGI6/eR5kfEl5nWS2RoEgmOVM3tQY1JW2FPIvzIqCNv3WIoW2OznzWs=@vger.kernel.org
X-Gm-Message-State: AFuF++n/LdqtcWWl/X+lUmLuMCJjkk7143voleSOoqCCZa1qZR3+ElVN
	MvRz9Np1301Ex3QKltSxN0eOHuzpJY98wXgNKZ0Dvi90WNzK7QZiLZJU
X-Gm-Gg: AYBFou1sfKe7ECcZHPx2KYW/s/0Tumjq3dY+TnujkvrLhkeXp6oEUw7gzzZPEnAlv8Y
	c11mSzpYvLLHQOGfTE1VqOtnWXv0tWuDFEsoFdz3kNPwWMNHKFmlJ/x1WwAwBW7VRT4+Y4CXS54
	upP2w1yHIbHcF53y/YpKukYvnujCjHYGB9rrsFkWtla/phHGYsHyTkaDN6F92kVl855f5/Yi1NH
	t6xJGaicxG576Hqqp75U1KOfIRwkv8yxIZQ2YMVr9xI21oLJhYC4AM7Dv4NZjMNfY/Ns8d1a+45
	O/Aw7JS3c01wwdLJYlMGXPh+E+2SesHPhx0EB2olBduyU/MXAvqtkCGID4Er0xZ/w0eIYTG6OOb
	To6wSQHqTnwLSwRlT1BwViUanU7FF+bhasxQIu0rQBubsTX1icMzorc4JykaQahmY6WdsKth0WF
	4R9Fev8Ln3/Zn3r+pMLF3ag0WtUvm5oKhJ1GAEIl1DWFz3NZTSPtg7g4ISGYpH5jd6bOQtUmhFb
	dhnjtdiMppiAmus/+wI9SOPfzI+LouvyiZOfJhyRg==
X-Received: by 2002:a05:690c:e3c4:b0:854:5db3:4ed0 with SMTP id 00721157ae682-85d6f3dd5aamr124890337b3.31.1788271568230;
        Tue, 01 Sep 2026 07:06:08 -0700 (PDT)
Received: from gmail.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85e679512easm74673717b3.48.2026.09.01.07.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 07:06:07 -0700 (PDT)
Date: Tue, 01 Sep 2026 10:06:06 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Junnan Zhang <zhangjn_dev@163.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, 
 "Michael S . Tsirkin" <mst@redhat.com>, 
 Hangbin Liu <liuhangbin@gmail.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 zhangjn_dev@163.com, 
 Junnan Zhang <zhangjn11@chinatelecom.cn>, 
 Shouxin Sun <sunshx@chinatelecom.cn>
Message-ID: <willemdebruijn.kernel.2ca4f939269a3@gmail.com>
In-Reply-To: <20260901074214.57717-1-zhangjn_dev@163.com>
References: <20260901074214.57717-1-zhangjn_dev@163.com>
Subject: Re: [PATCH net v3] net/packet: fix network header offset for non-VLAN
 raw packets on VLAN subinterfaces
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Junnan Zhang wrote:
> AF_PACKET SOCK_RAW sets skb network_header to dev->hard_header_len in
> packet_snd(). On VLAN subinterfaces with software tag insertion,
> hard_header_len includes space for the VLAN tag (ETH_HLEN + VLAN_HLEN =
> 18) while min_header_len is the on-wire Ethernet header length
> (ETH_HLEN = 14). A non-VLAN SOCK_RAW frame carries a standard 14-byte
> Ethernet header, so its L3 header sits at min_header_len, not
> hard_header_len.
> 
> packet_parse_headers() only corrects network_header for VLAN-tagged
> frames. For non-VLAN frames it leaves network_header at hard_header_len,
> so the IP header is found VLAN_HLEN bytes too late and
> inet_gso_segment() fails with -EINVAL.
> 
> Observed on a virtio_net NIC (KVM guest) that advertises
> NETIF_F_HW_VLAN_CTAG_FILTER but not NETIF_F_HW_VLAN_CTAG_TX, so VLAN
> subinterfaces use software tag insertion (hard_header_len = 18). An
> AF_PACKET SOCK_RAW socket bound to the VLAN subinterface with
> PACKET_VNET_HDR enabled sends a large IPv4/TCP frame exceeding the path
> MTU, with gso_type set in the virtio-net header. The user frame is a
> plain [ethhdr][IP...] layout without a VLAN tag;
> vlan_dev_hard_start_xmit() only attaches the tag metadata via
> __vlan_hwaccel_put_tag(), and validate_xmit_vlan() on the physical
> device later inserts the actual tag bytes via
> __vlan_hwaccel_push_inside(). With network_header stuck at 18 while the
> real IP header is at ETH_HLEN (14), inet_gso_segment() reads a
> misaligned ip_hdr(skb) and returns -EINVAL.
> 
> For non-VLAN SOCK_RAW frames on VLAN subinterfaces, set network_header
> to min_header_len so that the L3/L4 header positions match the actual
> on-the-wire frame.
> 
> This fix is placed before skb_probe_transport_header() so that both the
> transport header probe (which uses skb_network_offset() as nhoff) and
> subsequent GSO see the right L3/L4 offsets. It complements
> commit 01fdecc0480d ("net: packet: fix wrong transport_header when sending VLAN-tagged frame")
> which only covers VLAN-tagged frames.
> 
> Fixes: dfed913e8b55 ("net/af_packet: add VLAN support for AF_PACKET SOCK_RAW GSO")
> Signed-off-by: Junnan Zhang <zhangjn11@chinatelecom.cn>
> Signed-off-by: Shouxin Sun <sunshx@chinatelecom.cn>
> Signed-off-by: Junnan Zhang <zhangjn_dev@163.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
