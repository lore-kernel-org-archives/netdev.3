Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66ED94E5359
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 20:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789675211; cv=none; b=o97hesK29ZZAETA6FxsQTWPk9yZ49cLD0iiBe74+0gYRABpV6jpy2o9HnVlotwrJrEKJ7/D6CAz5e2Evxyz6+f0rmsuJv11T6idPOLQtqnZl7y8yX5x2I/ohK9ZU3ztq6+C5qIIRrn39EL3AyFTiFbtyv5yLfo0fK5z9Y7BFJlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789675211; c=relaxed/simple;
	bh=qQt4cO6gcM8mr7BbKnuuxQVqoSliQpL2hRO0tN5IJCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JoOkzMGOdNIKfoi73Ry7qcM/ywHu6e+DTf/fgeNOsSqboFiCtdDSaMve5NDTwwVbNgjJixVUwJB4xG0tQrWkJYJi2CbPo8kdATB/BhtYAoxU0RTruoeCY4+5mERybEN9KVjInQpbtYMtjUUXoTv17BTGeCNk49cGTeDfa3X08Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Le7/uLIr; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Le7/uLIr"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912e4b11so120345e9.3
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 13:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789675208; x=1790280008; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OaaciFVIl9v1eXFkeR+gZr+bpmUH+PehdgPs/XwqD9w=;
        b=Le7/uLIrUEhNx3iTyQ3zrYKZLv3UXt0J81gccVaZ9mx7jsktm+H4/N1xkqGkWi+nSu
         URoNatSCzusME69Sx2JWL/TTZhBGXJkONwyy12s6AZ7Zr4ERsHyznQ8MgZIBE4GNicXw
         GF01wCGSxwF+icgEcNCHXhWjJJ2t+EhsB+pMzMFudnMoQ2e7wQ4USDAdeIreNtcmi85M
         /uBzseGj9PVRkJNMVbfoyV8Oo95TXh6KRyovMXX9fcMPqPH/mpofwFVZGa+/ZqjeQQis
         WhBYjDI7lPArSGqYBnvRFyheHdAXVWtCNDlTno76M2SmQTsjtsn+F9rcMIbvGF3M0Lq3
         TftQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789675208; x=1790280008;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OaaciFVIl9v1eXFkeR+gZr+bpmUH+PehdgPs/XwqD9w=;
        b=MCOCEt6qFz2X8MxQ4byWNEslNiO2oe4jxSaNffYX+wcp+qv/N3WxxOKx0T+qJ/BGnN
         NqT5X9LQcdJ+wfv8KU8kcGeYsLbAGyNsNraZZQg5K2tejlfQEdHU7G33RtMNsrjXgMZN
         eJASw7eCX9DWodph+X20sm+UMdvpkoXd3Mgf8DOOpm7QglODgSv9koUsWNzAQBba9R0L
         X4HK6nnQRHHFugybaXD3k8SM8aghW25L8xw7HEl63PHeKJwAN1Wt/afNP2Byl1FKvZ/w
         HlBK7B7jV1W+jSmAw4gRt5WpRNAzdIlLhsSvC60/MD/JVYWyJ2wOpUZZF+u/E7ddp5BX
         Oi2w==
X-Forwarded-Encrypted: i=1; AKwUvBwoD1TS8+TBRW/Rh4l8Z996Zq8naI/u+ZLjQdSYi5sAL/0Le7g9dcFnyGyPbKXm9ea94slyXZw=@vger.kernel.org
X-Gm-Message-State: AFuF++nvndjw3vEiQ+ogHayLSmNvD9teU0kKyrcgEkeFwAWYWuV8rFpM
	Kg6bbaBtgEe2SyThkhwauNi16s7NQil4LrLVlT+hQRz+jus4Mkib/sCw
X-Gm-Gg: AYBFou29fKseX6vga9xH5LZelDXiGeo8uSEscmvCK4PNzAdVbPqfHQRRGqzfj08bfQF
	bU5TuHahnUW6z/APnm/pEEHBr2Ajbe6nxAKCV4sgK/+D84I2trFdCWyrBngTSf76FDq1eBrub4n
	N+gqG5MANnlVqXUbuyHd5Lnxf01x2T6FDdF3DWBFw2CpPfpXwC4v9/VoxBSm+Xib3V+E6+dWwU3
	YJVm56yDoM9gJx0MQ5G3E60uFETRkTXBweWmgOyWNmbS+te52ImC+dDCZWMvbA9TU3clIDOJMEJ
	cecjHHsjbipmtTRF1Xi7ou6xOpQm1WwKR13svL/tUlY/OpUOF5rsjBhN+9oNOrKW3UelnOn+1WP
	TxAvnftjiV7uvsbB/Oyf60AzU21iAyRcM0sFAxCRAMWfh5NQCc6pvVqmA9Xr7qgCT7pMLTiQF0v
	xLQTyCilawTbsrUOxQAPFW770tGPqth4TPBR1g7tK4wNysD4KRzao52U+lyMT2kq4CY0uW124vr
	KWwJZTPeczSB8xDYRMKOB18LatGZIbh2BG+ez8X77dxviiQXw==
X-Received: by 2002:a05:600c:4691:b0:49c:fc6e:a3da with SMTP id 5b1f17b1804b1-49eb733cb1amr100153915e9.25.1789675207535;
        Thu, 17 Sep 2026 13:00:07 -0700 (PDT)
Received: from ?IPV6:2a02:a03f:a75e:9a00:5f07:c6a0:e93d:34d? ([2a02:a03f:a75e:9a00:5f07:c6a0:e93d:34d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd17051fsm102448785e9.0.2026.09.17.13.00.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 13:00:07 -0700 (PDT)
Message-ID: <32ef3122-2cca-4e40-93a3-2e02a4f96ae3@gmail.com>
Date: Thu, 17 Sep 2026 22:00:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] seg6: keep room for the mac header when growing the
 headroom
To: Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: Yuya Kusakabe <yuya.kusakabe@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stefano.salsano@uniroma2.it
References: <20260917-seg6-maclen-headroom-v1-1-02ccec50f096@gmail.com>
 <fd0ffc06-f1c5-42d6-ae16-b592208c6d69@gmail.com>
 <20260917182826.452d987261004173916e9722@uniroma2.it>
Content-Language: en-US
From: Justin Iurman <justin.iurman@gmail.com>
In-Reply-To: <20260917182826.452d987261004173916e9722@uniroma2.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/17/26 18:28, Andrea Mayer wrote:
> On Thu, 17 Sep 2026 12:12:11 +0200
> Justin Iurman <justin.iurman@gmail.com> wrote:
> 
>> On 9/16/26 23:38, Yuya Kusakabe wrote:
>>> [snip]
>>
>> Overall, LGTM, thanks. However, I think we'd need a v2 with the followings:
>>
>> - use max_t(unsigned int, skb->mac_len, dst_dev_overhead(cache_dst,
>> skb)) instead of max()
>> - apply the same changes to ioam6_iptunnel and rpl_iptunnel (all in one
>> patch is fine)
>>
>> Reviewed-by: Justin Iurman <justin.iurman@gmail.com>
> 
> Hi Justin,
> 
> Agreed, rpl and ioam6 inline do trigger. Single VLAN device per side,
> reorder_hdr off on the receiving one, plain ping:
> 
>    BUG: KASAN: slab-out-of-bounds in rpl_do_srh_inline.isra.0+0x3d3/0x770
>    Write of size 18 at addr ffff88810deeba7e by task ping/447
> 
>    CPU: 0 UID: 0 PID: 447 Comm: ping Not tainted 7.3.0-rc1 #364
>    Call Trace:
>     <IRQ>
>     __asan_memmove+0x38/0x60
>     rpl_do_srh_inline.isra.0+0x3d3/0x770
>     rpl_input+0xd3/0x5e0
>     lwtunnel_input+0x18d/0x420
>     ipv6_rcv+0x452/0x460
> 
>    BUG: KASAN: slab-use-after-free in ioam6_do_inline+0x2d8/0x5e0
>    Write of size 18 at addr ffff88811480fa7e by task ping/432
> 
>    CPU: 0 UID: 0 PID: 432 Comm: ping Not tainted 7.3.0-rc1 #364
>    Call Trace:
>     <IRQ>
>     __asan_memmove+0x38/0x60
>     ioam6_do_inline+0x2d8/0x5e0
>     ioam6_output+0x335/0x970
>     lwtunnel_output+0x1b0/0x440
>     ip6_forward+0x16a7/0x16f0
>     ipv6_rcv+0x452/0x460
> 
> ioam6_do_encap triggers too, with three VLAN tags via tc push:
> 
>    BUG: KASAN: use-after-free in ioam6_do_encap+0x202/0x5c0
>    Write of size 26 at addr ffff88810de227fe by task ping/453
> 
>    CPU: 0 UID: 0 PID: 453 Comm: ping Not tainted 7.3.0-rc1 #364
>    Call Trace:
>     <IRQ>
>     __asan_memmove+0x38/0x60
>     ioam6_do_encap+0x202/0x5c0
>     ioam6_output+0x3cc/0x970
>     lwtunnel_output+0x1b0/0x440
>     ip6_forward+0x16a7/0x16f0
>     ipv6_rcv+0x452/0x460
> 
> I would fix dst_dev_overhead() itself rather than patching every
> caller individually, that covers all callers at once and protects
> any future user of the helper. dst_dev_overhead() already returns
> skb->mac_len when dst is NULL, the fix would make the other branch
> consistent:
> 
> --- a/include/net/dst.h
> +++ b/include/net/dst.h
> @@ -455,7 +455,8 @@ static inline unsigned int dst_dev_overhead(struct dst_entry *dst,
>   					    struct sk_buff *skb)
>   {
>   	if (likely(dst))
> -		return LL_RESERVED_SPACE(dst->dev);
> +		return max_t(unsigned int, skb->mac_len,
> +			     LL_RESERVED_SPACE(dst->dev));
> 
>   	return skb->mac_len;
>   }

+1. That's even better, thanks!
