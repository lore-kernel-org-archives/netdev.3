Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADF43515CC
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 02:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787538090; cv=none; b=LzCmZ2eTHG4YXkJOVX8aeV6tHydCV+2SBrw8Pc08q1bu/GzDAQJ1o8aE+00sH3T2uNXaQ1Q22XwcCX15t6qj6mvvPToVwbXoEeDfWOqAOP8jS8SFsOBLlJuoII45GxWU7h4GFM5FWnj7F6DI9SAndp4yb45LOcoBX+R9G6AMvvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787538090; c=relaxed/simple;
	bh=q8YhVJrZvS/QQQddF/6UPO+8G8SkN4sVGbcI8HfrVjU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=tlHH2/OPqWGx+MY8xxy9MG/xyv95g4vFDCq9FgjHHzKPXyfd5CLXgLUXFjO8MT9/JuDK+erIrDU3pz1nG3NQvagykjCmfo8Ia6ZySsB1VDUkhoypwgx4Gq2/V9D/k6wbTkQfSJQrMcBBAqiynAq+EZBm3CRTj7TIvDCdNn8q4Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oVNOcv5w; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oVNOcv5w"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-836c4474028so33957587b3.0
        for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 19:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787538088; x=1788142888; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xHVdt5IiHgW6qoa9feoKqRdTj5+Yw/6Pwu6Ox8ZTric=;
        b=oVNOcv5wbzvaJ/p87n71tBUQtcnncv5HWWkiCRJKyuZ9OKbecp1FXLpNBEoEwuqnkp
         UN0NWz0u1MDx9Ahft9gFjbKe0+6SAC8FosczyTXzrWaPqR+M/cjlNYRCxeZTjh798Op0
         tGU59jHZZarj18dGPNmZJrqxfV22HHRnJR56+d/9rHhDWwceiCyE/KU6eWmW3s7bfMgh
         GZRLqd9eJO7TCxmNGRtQRbg5fNJ0GtOcOJNpz7aYdb1WKMBz0adUIdlzZYXMJ3p02vHN
         RVOv0ysWxE7gHJvFFHOMaBqmnP/rt35g1PsZad9x2An8gAB7CRQf7llhdkyCfgOcUKCH
         qtBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787538088; x=1788142888;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xHVdt5IiHgW6qoa9feoKqRdTj5+Yw/6Pwu6Ox8ZTric=;
        b=ew1IR1PXTtFbFqM9shZacBc6EokodSKSHtLwhM9T/wxmqJ26+Gx/EPcYjFGkvkLLy/
         NairXeQ5lrP4Wnnm07vfQvsIO7eIlXvUiujZ9gacbSB73vmTdZccsyfsVEM2d10G+KKh
         JDImtCehJZU53bU6+AnZ4vWqtR57ApfDu43+QU5AXWEAXc0kJP4a8SOINdpKi9Yssz8K
         Jup1ygoAvcOCx+a9NBtRvSAULx07zajEyMDx9NzrD8lp2P8+DDFp4YjVDyMTYeQw5nRG
         j10fPrvjGS2DnIYv12i9H5n2yfJj3Zhv2ZFtkNXVuJZBLAuon1/QktmluS7AR02P6d+L
         JjKQ==
X-Gm-Message-State: AFuF++ny38NYRFvHBdBuMWEXZr2k+XWUve09VZk7wopa6rBn29n8owzH
	KEWGAjOw687vnmJHtsLDKXsGrerijzlu8YRnxiTv4/Zyim0hrfQXeIht
X-Gm-Gg: AR+sD13Z2gbsxD87fg5ULHs/CGqbo2aa+2CC2bNrKIfgR4FvBzAWx9Q50Qnl8DdedS7
	lKsEucYyQNgWW/1ZT1/4C/EtvFZzzBFa0nUiZpYUxiqMETTbJbKC498P5k5EbFnoe0Fqsu1xTEe
	G+EsiCPFsc2lBpVSjp2Dvn/ZKq2iwsz+l4N0h6qCeO6gfxMF3xbN9nLQ26zfDDDANqWcIWOBHoI
	ZnIUJgELk9Jkqf67z+qVHWw7TuHR6nVJEC3T8641+9h1482tr9BpuU0xv45f+6Qn4dURq5hRHKj
	7y9mka3MmpnQ/dCDY+YwPQBf0ECnZjt+/zW2HQQgdL2YO2WesCKVxx2VHDT35niUJr3KRp9zGcw
	vaHI7ubY39Wiu2O4bwbW4eT/AHPNUCnT93Rb4FH6J1912EX2Ppqb9G/hAna5SiHayUBMqp4263Q
	zI9jaO3s4zHfnBgDg33V8QaZtinT89Bx7dnNsU3HCyrTMoY/oTUwM/ybYpG+cg9gcm4B8phG95t
	PDNX1k68WN0YPXwA28SbFX31HbMlx413Nv3AVHFmw==
X-Received: by 2002:a05:690c:2503:b0:847:d0cd:11eb with SMTP id 00721157ae682-849f2a38e40mr84787637b3.9.1787538087832;
        Sun, 23 Aug 2026 19:21:27 -0700 (PDT)
Received: from gmail.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-84cac01868dsm26303247b3.42.2026.08.23.19.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 19:21:26 -0700 (PDT)
Date: Sun, 23 Aug 2026 22:21:26 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: JR Lanteigne <root@dnim.dev>, 
 Eric Dumazet <edumazet@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, 
 Miroslav Lichvar <mlichvar@redhat.com>, 
 richardcochran@gmail.com
Message-ID: <willemdebruijn.kernel.150ff949d6753@gmail.com>
In-Reply-To: <178746246095.3786864.2262454553798466512@dnim.dev>
References: <178746246095.3786864.2262454553798466512@dnim.dev>
Subject: Re: [PATCH net] net: fall back to skb_iif for the timestamping
 pktinfo if_index
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

JR Lanteigne wrote:
> put_ts_pktinfo() resolves the interface index of a received packet
> from its napi id. The lookup fails on drivers whose napi instances
> are not attached to the delivering net_device (e.g. ti cpsw, which
> keeps them on an internal dummy device) and on kernels built without
> CONFIG_NET_RX_BUSY_POLL, where skb_napi_id() is always 0. In those
> cases SCM_TIMESTAMPING_PKTINFO carries if_index 0 and applications
> cannot tell which interface produced the hardware timestamp. chronyd,
> for example, then ignores valid hardware timestamps.
> 
> Fall back to skb->skb_iif, which is set for every received packet.
> On aggregated interfaces this reports the aggregating device instead
> of the physical one, but only in cases where the napi lookup already
> failed and nothing was reported at all.

Interestingly, the referenced commit explains that it added this
method because the skb_iif reported by IP_PKTINFO is insufficient:

"The index is useful with bonding, bridges and other interfaces, where
IP_PKTINFO doesn't allow applications to determine which PHC made the
timestamp."

I don't mind adding a fallback. As long as possibly passing an
aggregate (or tunnel) device cannot cause regressions to existing
users, notably chrony and linuxptp.
 
> Fixes: aad9c8c470f2 ("net: add new control message for incoming HW-timestamped packets")
> Signed-off-by: JR Lanteigne <root@dnim.dev>
> ---
> A userspace fallback for existing kernels was proposed to chrony
> separately.
> 
>  net/socket.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/socket.c b/net/socket.c
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -900,6 +900,8 @@ static void put_ts_pktinfo(struct msghdr *msg, struct sk_buff *skb,
>  			if_index = orig_dev->ifindex;
>  		rcu_read_unlock();
>  	}
> +	if (!if_index)
> +		if_index = skb->skb_iif;
>  	ts_pktinfo.if_index = if_index;
>  
>  	ts_pktinfo.pkt_length = skb->len - skb_mac_offset(skb);

