Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CE54A68BC
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 09:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792402088; cv=pass; b=NaprHi4KcI7vDvT66zp0uoemjqm4BEw4rUmZmhCMf/165mS1JoXn/73+PRrEwHNJaz77zFHTn4JCJOi5LutnP7KP8tcRxDXctHRnW+UvqW//zeFns7DZhbCcUlf6AJ15PDlZvO15FQauaSI8h1qzbgC+iKb3lTzEBlGBPh25NnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792402088; c=relaxed/simple;
	bh=u3uf7yLXZ1OvGsQTuvg59AbQ89pUcQbwn5wgQbUsqS0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UfxqfJgMqkVdUuSI1I+BKmn+HPHeH8hd13AtYyUwgDKBrPZpB4F7D3lU7XQbaEaBTRiCePRKkw5t4cppY05qqDuD+YOf7PWbmrfMwQ5dk0uoIhT1N9uYxXnGT62hSbdn90e9R0M976YduhvPKBGZeO+PO9+KZ0YfSIHav78iNNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BSvKaa54; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSvKaa54"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5bcdae234ecso1556489e87.3
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 02:28:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792402085; cv=none;
        d=google.com; s=arc-20260327;
        b=cgs0u9f+6o3ayG1G8HhXzPNyHj6zK/Wd8SIeMGA7nUwwVKYvpT1lYnBPwcG48jrGEH
         ltCBtFuZsudjcol0OosglsuXP6RPn6pLf/HpydSQiCG/uORhmzvMQk6UOC38Ym/FBblK
         /62IBLRNxPtFWahozxPQZFfMAy684ANcAa1ms03Jg1GE8FJwo6wXSK0kRxqhBYP3O6n5
         uofNwko9WNZE4MkjrIRLOOOJuCqWM4vGPMFT+p9WqNTM//kRr+/NEgDBRRSAd2CNGJnY
         rhEjLRo3X+hq+FaPQYlAc5unVrnyqGT1z/IB0GKhUHzr6jI0bNEC0ecmG0EJTCRy6HmY
         mocg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=z1+k57QTpXXiAL7rq7K56Q4t/5YCZXiR+RBqXNJa28U=;
        fh=NzQo0NPpfFVFfxcVusuE3PrbXQX3LadMkakk44DDJ0I=;
        b=kGQYh1k5RJQdI2Uoy6h/REuEsbDLNLl9bYE7tfqitC6tzcqVTD+R4wopSiZ3Aqe3Bl
         joSyzgDBqCajbIjasZooZ1ZNFfI0gEA7gGd87+LeOMJLbiKgAMtbw1oP6YwjaXm68UPp
         Ib52tpvmD8hzAXfYWpThzkryA7lO8ara+qSYEQo0lBSvgbqIHJ1VZK1rSrx5ZUF1p14m
         7EvoGSP5zSOJFEdptwoXBhd8CpNgS+jGPJ4lp4u2Nd0axdC+pHIzEw4Pc4IxeNPcgU3e
         XKF1a/p3rk2NCZPGlP08073BivOcayw3f9j6jRpDtZ9iiUJXHRdXQPz8yQrqTJRM3atr
         8b0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792402085; x=1793006885; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=z1+k57QTpXXiAL7rq7K56Q4t/5YCZXiR+RBqXNJa28U=;
        b=BSvKaa5441ZFK3sLa+v/3nAuYfM/B79rFgek5yeXqsOBbsPm2abQA/4dGYgYOst+a8
         6TPDdWew2YRrJLh4QXyNMX2xfEXq6ar75hFSqA4uxdZopwFoIgZPejMr+hP6Ls69ooKJ
         my85/0v1EXkZG+hmTCwiqnMRdK/jB+0HSyrzP93z2rFrjnwvEcL9CX6uNN27+lonUiTF
         c/Z82Tz3emrae5Xm9DFd2zH5h8vvhy2WhLPFZWLqLSjh5ff7jqWcUGyaZ68maCxiTK6J
         ttZ94/tpk1hzbPU456J75R1Vp3BZW/udTLI5QzAVMVFZ/t7zlXennVeNBOwF72OMok+a
         j4eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792402085; x=1793006885;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z1+k57QTpXXiAL7rq7K56Q4t/5YCZXiR+RBqXNJa28U=;
        b=MxGLVNN0cOT/IZnLWcFVW9kL31LNBS9SxM0Bh/+LqSVTrpglbLUhBkYGH2qr2gUn1z
         MQjtnUf/0n2Lixi4B7NmYNcddSKhMEvFqzVzWky5yO1KfKaDGGt2aeosi4pEOtPv4Dep
         ObUKfOQz5+4JGYOBtdQqo+MydVSahTd4pJudPJzuqEjCbX47gUVscmAQr3ML4DqxgsCs
         GI48fPV73M73X9HEb6eSbG382aimF2qhsElKpcQisi9ogSeolIcGfbbuSyXxVBvQQMd/
         5l+rPxMvqpfJyYmj9grbHqbVkCLarqEFr38pANShmdwoPqOSPRZWd88mGCvNC6XlRDsg
         jXRQ==
X-Gm-Message-State: AFq9FYIS7odDrvY50EARh6/sXeglCzge6cO2wp1BmT8r90ePdY024WA7
	aEVLYBHSOOKiVdOUe2kCM/MONzLyaiaxlvWDMuyhqczZz8QT7PwD3y2o6tcJw1LvhH/2pH0tUb8
	XmTWVQgIunKMNTyu9z+hlsPbFPaWww+o=
X-Gm-Gg: AYBFou2mIMprK7qu6IekGduBT6/AZtvV1fML2IqSAlFpOJ1IDM0JQffhLRE9qn08M1m
	4e6Ch+dcQbYId9A4bkLB2pgutl96kMbp/Uyf1zl/ydD6jH5/kzdX/AMlv3uwRJuaB8p7rUhIVSP
	/XugIDlIIFIK4ASSz7H+8457K+XklC2Ji3YAOSV6VdhWmjc031b2+q/A4RefOWXOF5QkbjyN/Jt
	RIJmepaeY24KgABWY/PCZcBXUAfCTxEI14xu3VNd9KrtJENMU/iX8NozBjk778++HCz0ct0/wwQ
	0SH5HXu5rfybjOsb05nPBaNwAwrkT8gcQgrChwIumB1cjSiNfPQUz7ic/zGUjNsSrYWxQt48xXg
	TlU43LK0p0OyTnOPfqdCrGA7P1Kwpn2ngQHfFlCy5vEQRYBkeyFGcXVxZVjrMZIGVvKQypz3A2R
	XwcgvA
X-Received: by 2002:a05:6512:ac3:b0:5bc:ddab:bbba with SMTP id
 2adb3069b0e04-5be50a5eefdmr2138627e87.38.1792402084949; Mon, 19 Oct 2026
 02:28:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013130250.3643916-1-her@sorah.jp>
In-Reply-To: <20261013130250.3643916-1-her@sorah.jp>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 19 Oct 2026 17:27:25 +0800
X-Gm-Features: AclHuK-PcSiAZ-iAYI-BpTGj4Aa6-a3IDG9aso8dzNTYHWTUKjSyud-xY1exu_0
Message-ID: <CAL+tcoC3BQL-ziYc3Un6zmp3ewJYWQKa7PFpXh=Y0qroLFatcA@mail.gmail.com>
Subject: Re: [PATCH net v2] net: gro: don't chain linear parts larger than
 gso_size into frag_list
To: Sorah Fukumori <her@sorah.jp>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, willemb@google.com, 
	lixiaoyan@google.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 9:17=E2=80=AFPM Sorah Fukumori <her@sorah.jp> wrote=
:
>
> skb_gro_receive() chains an skb into the frag_list of the held packet
> when its payload cannot be attached as page frags: when its head is
> not a page fragment and still holds payload, or when its head and
> frags would overflow the frags[] array of the last packet. Since commit
> 5eddb24901ee ("gro: add support of (hw)gro packets to gro stack"), that
> skb may itself be a GSO packet whose linear part holds several
> gso_size segments. skb_segment() cannot split the linear part of a
> frag_list member across segments, so segmenting the aggregate in
> software, e.g. when forwarding it to a device without NETIF_F_FRAGLIST,
> hits
>
>   BUG_ON(skb_headlen(list_skb) > len);
>
> Fully linear GSO packets come from generic XDP. When the program does
> not support frags, netif_skb_check_for_xdp() linearizes any nonlinear
> skb with pskb_expand_head() and skb_linearize() and keeps its GSO
> metadata. GRO on the device runs before generic XDP, so each aggregate
> passed by the program carries all of its payload in a kmalloc'ed head.
> A tunnel that decapsulates these packets and runs GRO again through
> gro_cells then builds the bad frag_list. This was first seen on a
> router that forwards TCP received over VXLAN, with a non-frags XDP
> program attached in SKB mode to the underlying bond because one slave
> lacks native XDP:
>
>   kernel BUG at net/core/skbuff.c:4917!
>   RIP: 0010:skb_segment+0xbb6/0xf40
>   Call Trace:
>    tcp_gso_segment
>    ipv6_gso_segment
>    skb_mac_gso_segment
>    __skb_gso_segment
>    validate_xmit_skb
>    __dev_queue_xmit
>    ip6_output
>    ip6_sublist_rcv_finish
>    ipv6_list_rcv
>    netif_receive_skb_list_internal
>    gro_complete
>    dev_gro_receive
>    gro_receive_skb
>    gro_cell_poll
>    __napi_poll
>    net_rx_action
>
> It reproduces with three network namespaces: TCP sent over VXLAN on an
> IPv6 veth link to a router namespace that has an XDP_PASS program
> without frags support attached to the underlay veth in generic mode
> and GRO enabled on its VXLAN device, and forwards to a veth with
> tx-scatter-gather-fraglist disabled.
>
> A program with frags support in generic mode gives similar packets.
> skb_pp_cow_data() rebuilds the skb with up to about a page of linear
> data in a page_pool head_frag and keeps the GSO metadata, so once
> frags[] is full the next such packet is chained through frag_list
> with more than gso_size bytes in its head as well.
>
> Refuse the merge when the linear part to be chained exceeds the held
> packet's gso_size. tcp_gro_receive() then flushes the held packet and
> the skb starts a new GRO packet as its head, whose linear length
> skb_segment() handles.
>
> Fixes: 5eddb24901ee ("gro: add support of (hw)gro packets to gro stack")
> Cc: stable@vger.kernel.org
> Assisted-by: claude-opus-5-5
> Signed-off-by: Sorah Fukumori <her@sorah.jp>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks!
