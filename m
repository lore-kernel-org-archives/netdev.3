Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62BC4DA531
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 11:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784721501; cv=none; b=baKRuQwKGiyIretXA0fOM2ZMja6vgfZox6mfVCOZW2M9lvMx8LymdiApv99YQL8bRfPhHr+fwwLUGYZvr4CMW2UB571haysWtZZhxf1SQ+4FsuIjxUXD0gijHGLIuaucOXVAMqe2V/j6OgQD5R5BL6ONRLJLI8yK6G+ZfWqMqAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784721501; c=relaxed/simple;
	bh=RNAchHQ4qO/O72shiNlBmrd3K5EtTftrXSUsEz6u+fQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ofh9x9ZsprTAvFvYNThAlw/2ZmZpDPkPwuBFobl5Hrykwozm5VzOtmkW2UP+upy3et00oUw29pWn8CEGmDSjP09w8PjAzM7x54MRpZ2+dcZzIkyKQT4jZEgR5ngG0wfPelq8FcXqtJCaj99vT09BRPBjfgzGLqs3KLyG6iOFDaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-47f6c54e841so1314108f8f.0
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 04:58:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784721496; x=1785326296;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gS6jluprUO+rrXshsNQM8faXcPKrMbgl9BWtnXNV8y8=;
        b=Dju4UVh/bHsDGchDVqhFYs1vaseXuXLgQa1vnLjqnhLk4OySmIoDYTcyxGUYkGaGGa
         6DkBgHaPj6+m2yHVRm3Lf3Ye35Db2rjXNLPc2vbzpZ1j/CZaxyo71IUrlza3Gd6K2Un3
         KwBowH5jH62axrV2lk4MZzUDjm4BJnOjwo++GaGYiYhY9S6mKtn9IwPB+Nyphak5BVXB
         A+HL1NV3To56nkbO16ppQJxI6yzFilWQ0Pyy3lKFJaWYvthzPFKFFHHU03XOZ3x5ZM5d
         pHITwtk3BgpeAFkK/qFcUaxVZW3weBm65ib6+WpcoBRH9ap8pK2UILLg7oRTND+W6M34
         9NoA==
X-Forwarded-Encrypted: i=1; AHgh+RrWH8xN5VsAT+83YR5EeHByEQKqSEkAbJL9dHssvlvUiBsXjKXExBtDcdRWpOwKQNinDJnv2E0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUZ+X2OtAlt0BW8w+daYr32O8oUBL2JFEhf7nXvfxRwEXVu4Z7
	2tInPb2Wwi9jM/pwush3s9of+qdULT2IjSNWzKMWDAl35Eqc8Q3S3az7
X-Gm-Gg: AR+sD12fOVYbnj1VvAYD/PE+Xrixl4t/cUCMDNdPAEel+xxtH3ejU1RKdZ33Z+WqYB7
	VsJOUuusHGpo4ip1Nod2EB7DLwly1mAMtGPftsvzvy/5V/2I8dAzmhKq1zVbtBoI/gCMNbh9xDL
	/4W7Wf9op+mRpzTm/UjTjm8q2CPJkzRtf1nfpHN787Ofy+r+KrYhU98MlBa/Cdc/UzqwKv4wH0q
	o+M24xnelpKJgKo+OpUDGjixUz2zo/EwUMYttaa2RMVt6xODrfWkwNhQfwByK21y872+EG7VXHX
	BDvD+l5lDCcYmObYpfmkrNZqo4BQmQFhQxE6RpXhccLMMS2uDhdKbwAMQxfohfe5Q9d99G2nvLX
	CZhkbb8mjLQO6pIai1Kc3IB3/nqjgkoQqufn+qcvTY0b8r8nzBF+bxIoP6VmSld8Fafowwx8eKv
	RUwVkEOgcA+egxRwOGgqgOb4O3ECva7uAyE7nwK4w=
X-Received: by 2002:adf:e186:0:b0:476:6bd4:82d0 with SMTP id ffacd0b85a97d-47f622feb94mr25810578f8f.2.1784721496183;
        Wed, 22 Jul 2026 04:58:16 -0700 (PDT)
Received: from [192.168.88.241] (78-80-108-129.customers.tmcz.cz. [78.80.108.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c6287csm5980178f8f.25.2026.07.22.04.58.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2026 04:58:15 -0700 (PDT)
Message-ID: <71f4649d-2d94-4ae6-adc3-b3f12cc13bfe@ovn.org>
Date: Wed, 22 Jul 2026 13:58:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, netdev@vger.kernel.org, dev@openvswitch.org,
 linux-kernel@vger.kernel.org, AutonomousCodeSecurity@microsoft.com,
 tgopinath@linux.microsoft.com, kys@microsoft.com
Subject: Re: [PATCH net] net/openvswitch: check Ethernet header length before
 key_extract()
To: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>, aconole@redhat.com,
 echaudro@redhat.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
References: <20260721143602.64677-1-blbllhy@gmail.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 xsFNBF77bOMBEADVZQ4iajIECGfH3hpQMQjhIQlyKX4hIB3OccKl5XvB/JqVPJWuZQRuqNQG
 /B70MP6km95KnWLZ4H1/5YOJK2l7VN7nO+tyF+I+srcKq8Ai6S3vyiP9zPCrZkYvhqChNOCF
 pNqdWBEmTvLZeVPmfdrjmzCLXVLi5De9HpIZQFg/Ztgj1AZENNQjYjtDdObMHuJQNJ6ubPIW
 cvOOn4WBr8NsP4a2OuHSTdVyAJwcDhu+WrS/Bj3KlQXIdPv3Zm5x9u/56NmCn1tSkLrEgi0i
 /nJNeH5QhPdYGtNzPixKgPmCKz54/LDxU61AmBvyRve+U80ukS+5vWk8zvnCGvL0ms7kx5sA
 tETpbKEV3d7CB3sQEym8B8gl0Ux9KzGp5lbhxxO995KWzZWWokVUcevGBKsAx4a/C0wTVOpP
 FbQsq6xEpTKBZwlCpxyJi3/PbZQJ95T8Uw6tlJkPmNx8CasiqNy2872gD1nN/WOP8m+cIQNu
 o6NOiz6VzNcowhEihE8Nkw9V+zfCxC8SzSBuYCiVX6FpgKzY/Tx+v2uO4f/8FoZj2trzXdLk
 BaIiyqnE0mtmTQE8jRa29qdh+s5DNArYAchJdeKuLQYnxy+9U1SMMzJoNUX5uRy6/3KrMoC/
 7zhn44x77gSoe7XVM6mr/mK+ViVB7v9JfqlZuiHDkJnS3yxKPwARAQABzSJJbHlhIE1heGlt
 ZXRzIDxpLm1heGltZXRzQG92bi5vcmc+wsGUBBMBCAA+AhsDBQsJCAcCBhUKCQgLAgQWAgMB
 Ah4BAheAFiEEh+ma1RKWrHCY821auffsd8gpv5YFAmfB9JAFCQyI7q0ACgkQuffsd8gpv5YQ
 og/8DXt1UOznvjdXRHVydbU6Ws+1iUrxlwnFH4WckoFgH4jAabt25yTa1Z4YX8Vz0mbRhTPX
 M/j1uORyObLem3of4YCd4ymh7nSu++KdKnNsZVHxMcoiic9ILPIaWYa8kTvyIDT2AEVfn9M+
 vskM0yDbKa6TAHgr/0jCxbS+mvN0ZzDuR/LHTgy3e58097SWJohj0h3Dpu+XfuNiZCLCZ1/G
 AbBCPMw+r7baH/0evkX33RCBZwvh6tKu+rCatVGk72qRYNLCwF0YcGuNBsJiN9Aa/7ipkrA7
 Xp7YvY3Y1OrKnQfdjp3mSXmknqPtwqnWzXvdfkWkZKShu0xSk+AjdFWCV3NOzQaH3CJ67NXm
 aPjJCIykoTOoQ7eEP6+m3WcgpRVkn9bGK9ng03MLSymTPmdINhC5pjOqBP7hLqYi89GN0MIT
 Ly2zD4m/8T8wPV9yo7GRk4kkwD0yN05PV2IzJECdOXSSStsf5JWObTwzhKyXJxQE+Kb67Wwa
 LYJgltFjpByF5GEO4Xe7iYTjwEoSSOfaR0kokUVM9pxIkZlzG1mwiytPadBt+VcmPQWcO5pi
 WxUI7biRYt4aLriuKeRpk94ai9+52KAk7Lz3KUWoyRwdZINqkI/aDZL6meWmcrOJWCUMW73e
 4cMqK5XFnGqolhK4RQu+8IHkSXtmWui7LUeEvO/OwU0EXvts4wEQANCXyDOic0j2QKeyj/ga
 OD1oKl44JQfOgcyLVDZGYyEnyl6b/tV1mNb57y/YQYr33fwMS1hMj9eqY6tlMTNz+ciGZZWV
 YkPNHA+aFuPTzCLrapLiz829M5LctB2448bsgxFq0TPrr5KYx6AkuWzOVq/X5wYEM6djbWLc
 VWgJ3o0QBOI4/uB89xTf7mgcIcbwEf6yb/86Cs+jaHcUtJcLsVuzW5RVMVf9F+Sf/b98Lzrr
 2/mIB7clOXZJSgtV79Alxym4H0cEZabwiXnigjjsLsp4ojhGgakgCwftLkhAnQT3oBLH/6ix
 87ahawG3qlyIB8ZZKHsvTxbWte6c6xE5dmmLIDN44SajAdmjt1i7SbAwFIFjuFJGpsnfdQv1
 OiIVzJ44kdRJG8kQWPPua/k+AtwJt/gjCxv5p8sKVXTNtIP/sd3EMs2xwbF8McebLE9JCDQ1
 RXVHceAmPWVCq3WrFuX9dSlgf3RWTqNiWZC0a8Hn6fNDp26TzLbdo9mnxbU4I/3BbcAJZI9p
 9ELaE9rw3LU8esKqRIfaZqPtrdm1C+e5gZa2gkmEzG+WEsS0MKtJyOFnuglGl1ZBxR1uFvbU
 VXhewCNoviXxkkPk/DanIgYB1nUtkPC+BHkJJYCyf9Kfl33s/bai34aaxkGXqpKv+CInARg3
 fCikcHzYYWKaXS6HABEBAAHCwXwEGAEIACYCGwwWIQSH6ZrVEpascJjzbVq59+x3yCm/lgUC
 Z8H0qQUJDIjuxgAKCRC59+x3yCm/loAdD/wJCOhPp9711J18B9c4f+eNAk5vrC9Cj3RyOusH
 Hebb9HtSFm155Zz3xiizw70MSyOVikjbTocFAJo5VhkyuN0QJIP678SWzriwym+EG0B5P97h
 FSLBlRsTi4KD8f1Ll3OT03lD3o/5Qt37zFgD4mCD6OxAShPxhI3gkVHBuA0GxF01MadJEjMu
 jWgZoj75rCLG9sC6L4r28GEGqUFlTKjseYehLw0s3iR53LxS7HfJVHcFBX3rUcKFJBhuO6Ha
 /GggRvTbn3PXxR5UIgiBMjUlqxzYH4fe7pYR7z1m4nQcaFWW+JhY/BYHJyMGLfnqTn1FsIwP
 dbhEjYbFnJE9Vzvf+RJcRQVyLDn/TfWbETf0bLGHeF2GUPvNXYEu7oKddvnUvJK5U/BuwQXy
 TRFbae4Ie96QMcPBL9ZLX8M2K4XUydZBeHw+9lP1J6NJrQiX7MzexpkKNy4ukDzPrRE/ruui
 yWOKeCw9bCZX4a/uFw77TZMEq3upjeq21oi6NMTwvvWWMYuEKNi0340yZRrBdcDhbXkl9x/o
 skB2IbnvSB8iikbPng1ihCTXpA2yxioUQ96Akb+WEGopPWzlxTTK+T03G2ljOtspjZXKuywV
 Wu/eHyqHMyTu8UVcMRR44ki8wam0LMs+fH4dRxw5ck69AkV+JsYQVfI7tdOu7+r465LUfg==
In-Reply-To: <20260721143602.64677-1-blbllhy@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/21/26 4:36 PM, Cen Zhang (Microsoft) wrote:
> When a packet arrives on an ARPHRD_NONE device (e.g. TUN),
> ovs_flow_key_extract() trusts the user-provided skb->protocol field: if
> it is ETH_P_TEB, the packet is classified as MAC_PROTO_ETHERNET and
> key_extract() is called without ensuring the skb has ETH_HLEN (14) bytes
> of linear data. key_extract() unconditionally pulls 2 * ETH_ALEN bytes
> for MAC addresses and parse_ethertype() pulls 2 more, either of which
> triggers a kernel BUG in __skb_pull() when the linear area is too small.
> 
>   kernel BUG at include/linux/skbuff.h:2848!
>   RIP: 0010:key_extract+0xa7e/0xd90 net/openvswitch/flow.c:933
>   ovs_flow_key_extract+0x419/0xa70
>   ovs_vport_receive+0x222/0x390
>   netdev_frame_hook+0x3e0/0x630
>   tun_get_user+0x2d0c/0x38e0
> 
> Fixed by adding check_header(skb, ETH_HLEN) in ovs_flow_key_extract()
> before calling key_extract().
> 
> Fixes: 217ac77a3c25 ("openvswitch: allow L3 netdev ports")
> Reported-by: AutonomousCodeSecurity@microsoft.com
> Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
> ---
>  net/openvswitch/flow.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/net/openvswitch/flow.c b/net/openvswitch/flow.c
> index 66366982f604..a0f9d788d284 100644
> --- a/net/openvswitch/flow.c
> +++ b/net/openvswitch/flow.c
> @@ -1035,6 +1035,13 @@ int ovs_flow_key_extract(const struct ip_tunnel_info *tun_info,
>  		return res;
>  	key->mac_proto = res;
>  
> +	if (res == MAC_PROTO_ETHERNET) {
> +		int err = check_header(skb, ETH_HLEN);
> +
> +		if (unlikely(err))
> +			return err;
> +	}
I'd suggest moving this check closer to the place where we're pulling
the header, i.e. into the key_extract() function itself.

Best regards, Ilya Maximets.
