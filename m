Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F87413796
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 18:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790533269; cv=none; b=jtOfGdcZTneH4hFvBRDYKM8Pg846wBkzVd42WpytT0i8qWTwPUS+vAHPT7FSpH+oKtxTsYLtlIXr8gzxcQ15QdqoqZWEf48BTo4Q/Gq0oxR6FiHC92giVPPI6pxH9RLUg/FRwMT6jnZKJKUaLU9p49zRb5t63L07WL9v/W5MqH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790533269; c=relaxed/simple;
	bh=4YOrl/IUsekq59nwBYHthtg6XHJ8tNkyhaHdzuM8Rx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GdYK+YsIh9bdoSu3wlD14XjrSHtn6txbhgw5LswJ3gYeqSEVjL9SDTQC55CEUAZ1rScYDgsovEpsbwVRpk/lVO6UPsCUJVdPBtzZYdkTkiEQ5zKdmUxhr0ztiGbbll6dshZI6R1xw+Ixts2YCwhe69g15qkMjpmKS0pDCTT1GYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bRJV58aM; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bRJV58aM"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e79a408deso13631375e9.2
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 11:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790533266; x=1791138066; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F4pCtdS0O2A3/bCUoBgVtLu5+xYbTigEwA3u5CZgM14=;
        b=bRJV58aMF3AGG7XcYJkLSsBAUMlOgvDRO9jmlokvzCWVcyPGr6apYzRKjIP4GCHfGW
         yHsGWkq9oewS35dom9EYD46LOICO+RKNXTcx++pJaqpX3fCVhrhdjeJ+EnBuAljP2HRR
         T9hg3Ll9Vfb07ma8iSht7yikqTYmaDyO/euAETPJ/go/QCORlvgfEVSQBFDzoejFf9yA
         CXdZmxTOMEjOFipgPwcMrK5ka/XAd3VL0YuHNXrZyGKj2yZbCaiZxI+sCdd7zLfdNxZv
         WEBvfNxRFSeXjV+SNjNKpdixAkq4aie5+1OtyuxXqUQhOwnRmDtLemeGkMSXLYH63ak6
         CR6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790533266; x=1791138066;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F4pCtdS0O2A3/bCUoBgVtLu5+xYbTigEwA3u5CZgM14=;
        b=AfBHrlL2GJMGARo0Lx2mGXONWu6D/I+oKNd18H5HnBl1Bf9VGfyqOI09p0OkOchGly
         NgzHTq3GYKNr0r6L12HB/02MwRgvwCc7Js4qa1oviZ+claoNQBPln/V+EKQShQ0dPXoI
         3cxPgW1aISBsd8LnP6h7mIEqq9a0MwWRRN5HvbiYczzVNxoFl6xPDooy1FBV35Uu+Y2K
         fV8Hc3XnRhcYps3F+wnlwwDyFKX3H3boLUxQY4rUXZWB88B5SHcgMs2sBkNo1eHjMsy0
         8DcnKAW9tRocWWEel0+1mf8Kc6OVTaY4vFKhtMpG02xeaE+d6/tPkawFUOmm62AffRry
         9gEA==
X-Forwarded-Encrypted: i=1; AKwUvBxLQpwd2PHaNHP0iBFPV5jXIBhUvlUYZXlRBD3kFQqoiE7IYK9OzTowBX2lmdfQTKFyTHPLqGA=@vger.kernel.org
X-Gm-Message-State: AFuF++kdGpBHAVOThwDRUpsgvoCHxTOHVAI/qrMRVlD7L1mfy5PcJKqt
	E+owiLVgYX2/BR1OytphG6XmwIQwV404+aDiG9JYTl+lbp531xWyU/YNS5FdaQ==
X-Gm-Gg: AYBFou1esuUZn6CbRgACSFPAo/qtBAmjszCla0q/tqd8FAAiYJFi/zKUBDpPEaTLeFG
	LFwY4IKRA4dGUVEXVHxpAMwudwE5IfATY7QvSCn3HHo3gxjFp0prJpG8rrinutR/MDu6aEZtswR
	zmiyL2+ipKO+RCklKCVPTU5/DNvLaO9sLRRscEdqdOG29MHXNzKl5zk2Y1sQbYHIVfCZVPFKmc0
	N5UrKOWMJe90kvjexmYon3GU2TRpB6CGB0ndzaWnhsF/LSziq/AG+3bXVuYn0zd8aMPO9Wi7xzu
	uP0oKDcryFfRN4o00AD3hNC7sFXWX+VZE/jDmzUGQTFCs2haCIJbX3s3Ka6ftt0w8HYrkHnn4Aj
	6dTPUAKMwXZCrxLBWsHHKGg2s9Ld2twuXtg2sjbz2bmnVfcgDQlTuoWeyhF8ynNDpjPoQ1QQNzO
	5s5iansWrd5fuEGkRcQn/ajrLCQ3LVEhX4CzYZ36/7dQw7ORNQrqdy/Q0Aqk2JiyCB13+a/65T8
	vKfzYxs/aYO5yt5L6DMB2JmaZsgHRG2JO2zHSkc2wdjOmHoLE+gTzAXWXvI1w36ZpHIQ50UqqAZ
	7SVxqKFWuBDSTkoIECQYslzSSebFyU//b/Mm0MkZt5HYp2CM
X-Received: by 2002:a05:600c:4ecf:b0:4a0:108:3b54 with SMTP id 5b1f17b1804b1-4a001e8c316mr30649455e9.32.1790533265719;
        Sun, 27 Sep 2026 11:21:05 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fef60da94sm160803085e9.4.2026.09.27.11.21.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Sep 2026 11:21:05 -0700 (PDT)
Message-ID: <4bd67243-eccc-4c4d-896e-e88770b1967f@gmail.com>
Date: Sun, 27 Sep 2026 19:21:02 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] net: devmem: decode DMA addresses for TX
To: Stanislav Fomichev <sdf.kernel@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, hawk@kernel.org,
 ilias.apalodimas@linaro.org, axboe@kernel.dk, sdf@fomichev.me,
 bobbyeshleman@meta.com, almasrymina@google.com, kaiyuanz@google.com,
 linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
References: <20260922204348.717198-1-sdf@fomichev.me>
 <20260922204348.717198-4-sdf@fomichev.me>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260922204348.717198-4-sdf@fomichev.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/22/26 21:43, Stanislav Fomichev wrote:
> On 32-bit architectures where dma_addr_t is wider than unsigned long,
> page_pool_set_dma_addr_netmem() stores page-aligned DMA addresses shifted
> by PAGE_SHIFT. The net_iov branch of __skb_frag_dma_map() adds byte offsets
> to the encoded value, so the NIC is programmed with an invalid DMA address.
> This can trigger an IOMMU fault or DMA from unintended memory.
> 
> Consolidate DMA address encoding, decoding, and representability checks in
> netmem helpers. Use the common decoder from the page pool and net_iov TX
> paths so both interpret stored addresses consistently.
> 
> Fixes: bd61848900bf ("net: devmem: Implement TX path")
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>   include/linux/skbuff.h          |  7 +++++--
>   include/net/netmem.h            | 27 +++++++++++++++++++++++++++
>   include/net/page_pool/helpers.h | 10 +---------
>   net/core/page_pool_priv.h       | 14 ++------------
>   4 files changed, 35 insertions(+), 23 deletions(-)
> 
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 421f6fc45451..3740d4b15b70 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -3833,9 +3833,12 @@ static inline dma_addr_t __skb_frag_dma_map(struct device *dev,
>   					    size_t offset, size_t size,
>   					    enum dma_data_direction dir)
>   {
> +	dma_addr_t addr;
> +
>   	if (skb_frag_is_net_iov(frag)) {
> -		return netmem_to_net_iov(frag->netmem)->desc.dma_addr +
> -		       offset + frag->offset;
> +		addr = netmem_dma_addr_decode(
> +			netmem_get_dma_addr(frag->netmem));
> +		return addr + offset + frag->offset;
Looks like just page_pool_get_dma_addr_netmem(). Just a note, but it'd
be nice to rename netmem_get_dma_addr() into something less confusing
as well.

-- 
Pavel Begunkov

