Received: from mail-ed2-f1.google.com (mail-ed2-f1.google.com [74.125.228.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B1234FF41
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 13:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785506244; cv=none; b=fZk0Hh+0Ld4FvpSdKChTKxRyi0j2z8vKU89CdIv631JX27MjKOf8IRUv2onNCmHX9Z2YnpST4GWWbAJN3ujXyBpwyun8fvRaOwH+4CF62Dvaf6fisO/jqwMZbX9JM65qRwadCZ/aM7xUEdllfnzY4J3YTT8NE5m/isIXV6jiM+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785506244; c=relaxed/simple;
	bh=7hsM6fcu0pEPUPz97H0nRxglo95j3WaLtyLCpkBKIMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dplzoir1GANQ0uHCSbbNIAEneeZtPKQZgzNhTxnkfRtYEYwa9RwgFBwLwWkGGTF0eVoCdg2+sK6CTgROY76F/v9o7rIop0IUdgVVnyxvGe9F3ulvSBN2BASct85S6EQPlsms701kEVaPfSsywe4vSRC6qowYMchDq5X7gOqJlxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.228.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed2-f1.google.com with SMTP id 4fb4d7f45d1cf-698ae23957dso572955a12.1
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 06:57:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785506241; x=1786111041;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Gtlysq/63qw63DwWS/ulj7SAPlOMwreDbZEnTCykOx8=;
        b=l9pR32RBblT8XxxF1vUah3sbalVVFD+3/ZunCOAJY8iKvHgf61v8A4czRIxo45vt4P
         bUOmB29rxYHqV9JXplCY9XAGhhu7O16GgTycQANJjbacXijQYWqjRAeh5rNXSKm1G27o
         u6y8x7eiE34cCmDvC8kxtvug72w4cWOif3nLcJxI1BKhaxR/rKM8hvJGHjzWCVLMc9w6
         hoHz+LYoXNPfBjdJBqO84zWjC8OUH/bFnP+zZHMgznf2sp/LO+e7Zlt1SYf1LDL2OYm2
         qz4oyCbCy93h65rARWNIMVUw7jo1T+atOqTqcHimCetwjicfI5UxlCmErIQEmrnCUy/R
         y0UQ==
X-Gm-Message-State: AOJu0YyZ68ky47/1kClC7++df/t1CWmB1RQoZQghEJgSWj6uQidarb1v
	Y0JYRTIArV3F4F1HmXiuzXy6UkOQjKTMXjKU3Hh2TKJvHd01cCgUGQaC
X-Gm-Gg: AR+sD12015jy5siahqrkDWMBR1DoqGp2153weRhVjjHxMwYRZy0+P3wMDeL/BZBkp1r
	xSMU2XX3BIIeLSVMxKx216hVzniAZ+bfXaqAIu5lmXbD5BhJIJInreE3CLrbNCDKTjccuRJyDf+
	uJTmH5eLm7sxe/eYbfu0u/f/AYtaUymK+RgTz84M8m51nPCCR5cAJfvjUZ0CGlh+qXTySu+7joh
	9F833U5YapSPm4oY6HFHt1cI+vcL+u3X4f/lRcBb2ErsdwXIpTaZIhmPbKdPkjxTIcMymUidajo
	0rO4JTTgJCaA5n5FV3BcL3qr5x7Q4EycBAe/RAKKeKfrnyKDCRZAJp/BI00Y/fyou97Xhv9uIPz
	bWYw4KCuu44wyXiujsoHcjEF35vj/DmaYZohFxZUL3bhAm+Q6p3w9WRWMm2fRcT8LPvjVQotroO
	btjvUOtGmeYKdmwd+NDHeySZP6zPyN9uIsvObv3QE6JETgGkUj5qV/FB1OSaYwQiAsqmz2KOSAt
	mZpPnxRwyA1aXQD5eUrEDZXvQ==
X-Received: by 2002:a17:907:a091:b0:c15:f005:63fb with SMTP id a640c23a62f3a-c1fd2342c95mr124283366b.3.1785506240667;
        Fri, 31 Jul 2026 06:57:20 -0700 (PDT)
Received: from [192.168.88.241] (78-80-108-129.customers.tmcz.cz. [78.80.108.129])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fd3c5b608sm160575566b.8.2026.07.31.06.57.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 06:57:20 -0700 (PDT)
Message-ID: <0ac6ed8a-aa9d-41f9-8a5d-cc7500a5f10d@ovn.org>
Date: Fri, 31 Jul 2026 15:57:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5] net/openvswitch: check Ethernet header length in
 key_extract()
To: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>, aconole@redhat.com,
 echaudro@redhat.com
Cc: netdev@vger.kernel.org, dev@openvswitch.org,
 linux-kernel@vger.kernel.org, AutonomousCodeSecurity@microsoft.com,
 tgopinath@linux.microsoft.com, kys@microsoft.com, i.maximets@ovn.org,
 davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org
References: <20260730222006.118652-1-blbllhy@gmail.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <20260730222006.118652-1-blbllhy@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/31/26 12:20 AM, Cen Zhang (Microsoft) wrote:
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
> Fixed by calling check_header() in key_extract() before accessing the
> Ethernet header.
> 
> Fixes: 217ac77a3c25 ("openvswitch: allow L3 netdev ports")
> Reported-by: AutonomousCodeSecurity@microsoft.com
> Reviewed-by: Eelco Chaudron <echaudro@redhat.com>
> Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
> ---
> v5: Separate err declaration and initialization per review.
> v4: Update documentation and move variables into the Ethernet block.
> v3: Use check_header() per review, fix format issue.
> v2: Moved the check into key_extract() per Ilya Maximets.
> Link: https://lore.kernel.org/r/20260725043128.193164-1-blbllhy@gmail.com
Reviewed-by: Ilya Maximets <i.maximets@ovn.org>
