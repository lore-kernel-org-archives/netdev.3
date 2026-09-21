Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C11A4AA562
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 15:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790004279; cv=pass; b=LADuj6QjFpeqtIv/ZgGW9xgDvG2w8iksRM5i/Qc57CckiRAXowaGCnkpBYeAl2iQqy/G5N/FKQ4ChmFn3zikullhIuz4FOKpMahBErvnFY+Jp0KwIFb15I+6KlS4XHkrkCtD6oQ94IYVQE8H9ZUWgqfLRHv9UrktV00ZnQFUrTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790004279; c=relaxed/simple;
	bh=fVkMbtrDFgg9JhiC1LwbHU+t/WNuxQvV8nWO3zEnhqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GZJrjQ4roc3lr8x1oKWB3Tv2Uws9hHxxjjboGB5gDf0b8mzOWvSGGrYzhwcveI8dcVzeeyf5CLKxCWUMVu8+HkHftCaAmQPIIhmOcAszEDw+Ek3fXeZy+dHX6B1zPHZGoDXm9gGJHt2Ph6ZnvmfgqyJmBg7ZhdWaO73Vl0xOEYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cQoRKykJ; arc=pass smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQoRKykJ"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a5b2864f1cso27136131fa.3
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 08:24:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790004276; cv=none;
        d=google.com; s=arc-20260327;
        b=PuQbQLy1w0EbiKvReQgVHe9OlCs85R2IJlBYs6M1rIYrN+wbLNcTJPQL+mbAlUxrqu
         ETadulzodXHtGXqgW1vv5A0iMiwAH+9xQP3Bn3sBuqXAnc8VYjsEm8EgEJckMvKLD6yz
         jll6j2G6mr068O4ooi3XkrdB34C7LNofj9UJVYFTl/9mjb/6ND9afpQGALN11GI7mYsf
         1/l43xvvWOL2gSxsrJE193BX4Y/O+yPx8o8ggqp1yZxrJOWe4qJ7ag5tIEYrIVqI+jLG
         Gc71dKtVsCTuWIpJUFAprce/5WSAnY4IZLxYkbN6zXMDFbqGHegTNKdyzf30gzeVt0TO
         ApTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=L3IcGGSo5+j0HvIrQfCCVAwZ7s4gKZX9RwrmAX0fXMM=;
        fh=bE9EU1G7kkur4o25BTq148uXPzsMBQxUcDOUv9gwWgQ=;
        b=da72BgE4YtCW2eZkiRnzeogB8ofqrh1Hor1NFp9NAVqKYf5BBsz5ttwzR/XqWT4DZr
         LbGtb2arLUI5/YEV9emsUJxjERldd33nNit1aRQTPnVbRbdy+5r7aXEWdTxAv/YVycn7
         mwS8clXradt/kaiU1HCSopTGai2Uh3ocXvwr8WLlxEQYc1eOAunUgolEFS1GzxG/Z7nE
         3+7dECRf7R82JdMbEpljEX1npMxGMe7UY4YzbQHWtOTOGC731WzrdHEusz+uoRqr5MWo
         hWutMQT4sOn8+b8v16bwq3PJCnDC1RRcNtmCA96Req8X7Wn/A2+5qfSylCYNnvqx8hIa
         VgnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790004276; x=1790609076; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L3IcGGSo5+j0HvIrQfCCVAwZ7s4gKZX9RwrmAX0fXMM=;
        b=cQoRKykJFqFyI9NigTnPCxeRN1VP1Ou79d7z8LN0sQVBAb3eOJCjlisTu98bQpUjEP
         6J2SIyrGd6sKnzDGj1ylmrd1zSzIP8/Kqpdj5jyvKZIzuR39nEPXQ45vi5TDlcozpEOp
         yvkO8I1+9RFwGUQrOfXuKnEttydrjoRMXvlDrSZSZjmXec4ken4RT0S2WJg1TvM32/+u
         6cYKCBZwyDCyR8i/kCt91Nu4lyRFRK9Rq+t9VgnmFGgwkGiTeaU3M2jbQ7uQEga/8DbT
         CedNXLSET7HzY453SzdOMpT7b9jJNuQuuwrxmAxV6JaeqG/SZSPe+5qRJXI4tiimoDsg
         YV/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790004276; x=1790609076;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L3IcGGSo5+j0HvIrQfCCVAwZ7s4gKZX9RwrmAX0fXMM=;
        b=ypUePTYOns3goELj6EMOmheaLLTGSzy5qbIt406wjTNt3FszUnx0hm4F63fWcsoQ62
         7zkmQFND1mP4ZzuRHNuIdE+VP63klzDYFKdI37LXfX6sVdE7Hkju0jyPCVgibF54u3Mw
         Uui0kk1mkfvp+n2YGIWoHZnBD5eWDUzfbLNcOV5rNvtw2L1hxeQogDaCuOfwHYluF9ml
         LeaFio94KVL49vyYGzCAqQvgG9xlsTIHizvYjQ/Hr4HKsz4pCtg/+Gd3jOQR1B0BXenm
         ZKHL6qf6PusLe64+zre3M1tQyk+qgBQieH/CS96YrW+YE1akUyyzwkaXiXpyWvXKEhm9
         5EIA==
X-Forwarded-Encrypted: i=1; AKwUvBwf2ECq7Vi20QNKunFBMotn2DjwximKCp4SdOGvZ56YyUJp/l8oF4uUdzCvxCbFcBiQxcshzGU=@vger.kernel.org
X-Gm-Message-State: AFuF++lZvEjQzOAqVxyUvIjkCYSNt1u3hwYzxrviXj0n9cfmHva1LC47
	jAlHnYdzXE+8UySceErf4Wuh8FrFo2jH9Oa4TcI/3cU3I13L6tHAUkGCVDn/u+Eq3H2lDe3yclu
	ZoqcDdJRdfi3oUgbsidkYjRyZwi1GueA=
X-Gm-Gg: AYBFou1Qosk9CeEFQWLa1kE1zB4bojKV0qGoISIYQ7GrEBmT4LrdUjrvgSS8DjqIxA+
	O3rxOky/mTffabQPnFThX7q7kMrSHUFjB689PiZLuldfSZ9bNkSnAHrnfZs4HzqjGxnbnhIkcFP
	FHtR7j7fRPFDUYu5Oew5KHQQdT/sb6hPKqKyZH6ipYb9vEkLgTOOp0Yuf+spOGlJbVRHWT4f2s7
	SX8O+UNVAu5cRXS0SVy81ERBvRKRSLaQYQamBIh4ZAO8tjR6D0OTU3d0kDj6pjh9KBjsBHkeNeO
	yhzRp7Rbaks1Fqi0Ly/5bQxU6Iv7nK/1HBL1gl2oOy49CXplSvfRVE+2u+eAQ7CLC75Uy0NZu3M
	olBa97LwoZNMyypHW5cr/8IyBgs75yWxstSpguub2vxHsHAExsJqTtH9HLnxK5uzFgiMVgWL/rK
	uPrtwJQkmVc0PW7oQbFG0QmzgIRlk=
X-Received: by 2002:a05:651c:54d:b0:3a1:8dd6:aaf9 with SMTP id
 38308e7fff4ca-3a5fbf32d5amr23385811fa.8.1790004275723; Mon, 21 Sep 2026
 08:24:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917153923.904124-3-bestswngs@gmail.com>
In-Reply-To: <20260917153923.904124-3-bestswngs@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 21 Sep 2026 23:23:56 +0800
X-Gm-Features: AcwNN1VVTW-G-tYVzMWlBy3I-0oQzwQRNZQ4azMiWAQGx7Mm8VmFuFMIZMGo3_g
Message-ID: <CAL+tcoCD9baTVJFckt8yXaTHEqU4BQ=cKCUxtyUHO2MqfLimFA@mail.gmail.com>
Subject: Re: [PATCH net] veth: manage XDP program pointers during channel resize
To: Weiming Shi <bestswngs@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, co+65e5c76b187f08b2@bugs.sh, Xiang Mei <xmei5@asu.edu>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 2:50=E2=80=AFAM Weiming Shi <bestswngs@gmail.com> w=
rote:
>
> veth_set_channels() tears down XDP resources for removed RX queues
> without clearing rq->xdp_prog.  If the program is then detached or
> replaced, those queues keep the old pointer after bpf_prog_put().  A
> later channel increase can re-enable NAPI and run the freed program.
>
> Clear the program pointer after taking an RX queue offline, and publish
> the current program only after bringing the queue back online succeeds.
>
>   BUG: unable to handle page fault for address: ffffc90000256048
>   Oops: Oops: 0000 [#1] SMP KASAN NOPTI
>   RIP: veth_xdp_rcv_skb (include/linux/filter.h:779
>                          include/net/xdp.h:696 drivers/net/veth.c:820)
>   Call Trace:
>    veth_xdp_rcv (drivers/net/veth.c:941)
>    veth_poll (drivers/net/veth.c:986)
>    __napi_poll (net/core/dev.c:7787)
>    net_rx_action (net/core/dev.c:7850 net/core/dev.c:8007)
>    handle_softirqs (kernel/softirq.c:645)
>   Kernel panic - not syncing: Fatal exception in interrupt
>
> Cc: stable@vger.kernel.org
> Fixes: 4752eeb3d891 ("veth: implement support for set_channel ethtool op"=
)
> Reported-by: <co+65e5c76b187f08b2@bugs.sh>
> Assisted-by: LLM
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks!
