Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51AE459AD0
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 19:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785526061; cv=none; b=NidqzUYYFCXNLxsjoWmNAzElgLZgMuMZC6esxmN1JRvK16bDImlAHY/SRaiUDoC8FnXzphUcO7Tpkt8BBsI93xZPOwXA6tfxppIJw1bjBnhsOU9GXu9c4cxRYLEBz+bdj7akrx5IolzjoHO66MMTkuhZcgFM4kkf9ZFvo8QLxNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785526061; c=relaxed/simple;
	bh=WlYH4h1EO+QhPQs8N1wR1kmbirn4A94e5IuEBHI1C1s=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=uB4a4Td2hKyUBNY0+OY86fCUaljJ6VUo0i/Q2O/JCLRfjRoaOFrPyIZUsWRhmnK7H5zmcUs+RT9dOEoDAwXHDh6tdjKiFlUPO66FhQqdX/3DE9NNrNiXtKOeR630Tmptr1mt5IT7cCzsc15GpnLZMrN8Gnuu7hgYoGUstNzBghg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g2ZJZCiT; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2ZJZCiT"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-81e83f1f15aso16776447b3.1
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 12:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785526058; x=1786130858; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=P/71Eqm6eZkyzzsysSAa7b8sFQPr1CSpNZAPUkARlTM=;
        b=g2ZJZCiT+3OitEOoZJdirmYltmwwwLYw3eW1MgMs0CvuMDzxcXJF7ZVDah/oszVTo4
         Dbv6ju4syawuFmQ4ZYLM9n4kTGilJa2qhe3KDBrPQss66YIF1xggiucEs2V3S0RKo8e9
         iMzjrH6IinY0wQC7t5tDJvZiHSxH8pUymJvq+MMhpzjBQvqws7tg6yYmU0+DvGAAOJqr
         ulWRejs6VourOFzzhGY18/Cn0fG/VevJR05XsvJbSnnzMUOQJRr67iRGytAjKyiLfz9k
         9bCTnu6UhBqONA4jJD0GQ/AYHiEA8V1tplVp2YS7yz8KBUsTMIhWykfeqn5ffsRV8X4D
         UBKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785526059; x=1786130859;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P/71Eqm6eZkyzzsysSAa7b8sFQPr1CSpNZAPUkARlTM=;
        b=idSlTi0TJQLF814wmqYcSiHGwMI+1B3jvklaDkAoUR/Mzq7GmW9nQgYpxsQYdnxzTy
         kU3qx9wwPksWqBcix51NWc8zrOSAg5gTucs2iIz551QXvaO11sZygYigQ9dJf59VBRZQ
         KkZrqWOjyldeGQPRxoNhi8mAeCK+AhW/0f3jG8qOdLKknphDvylWZ9Pylpx9Ar4m0cN3
         vpckleLyzI9XZFx1UUwbVwgLvPhp2S39DetBJx/cUFt+BswcUz1MbUvHmu5FJ1UW/H7J
         0pJYv7MvYHCyrubwOYI7H6N/SEghU9UcNHvkEnYrh1Kfr6fKcHpY+OW5anDLjp9a/fpv
         kZeg==
X-Forwarded-Encrypted: i=1; AHgh+Ro5gA+o9FPnR0xMaHkBtVRR5JP79gzdcZ/Y3iJ/eO4+QLYNGW1M7FYZRz6DHlirRSFoVP/Ma+w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6JWitH5/4zht2kipAfiKT9FrzgeFbTwpJIGP2zzBdeZn3eukJ
	dVYKUtxJSl0KJAFxoJgQUYl5zRbEmHKt3wTJ04OdjaDPyMxDoEk91u/n
X-Gm-Gg: AR+sD109u2L/2Q+B7eAkRPH3ePLKIZ3U60iLniOqtAPRcpM8i/B/NyvveShjxP81ZET
	Ytn62gjNb+fQyOTkwCY3o43l3o0frG8kPt/NjbUj2KsAhnTs+K5VLHVnVgeG64YXiKb4QU7dUzH
	Gg7OVj0C57+cXciOrDs7FetYpu6MPrTKa/0vlP4EC14qpEPzyzp992kfTNlvKzVyQFxT//GGdoa
	Eb1S/fK2WuDiFoyPqAd2BYlIggJPeqMcUxMBzu/t/w7KuKZMUW1MongWuUsGR28b8hmkZ8ruB/V
	J/k+8BKBJ8z10SKsbHF7JRDla6dId+M7WM9PMqWwzk2JjJ48QytsjRqBO7o84ox9lcUxP/PImWG
	d1uXY5eZZYcN9KP9hoeOeWCattktYWlsK1aIHf0mYYbD7Z2qbAwSJ453BObJLIm58RwEvSJtgTm
	M+dbucxCwbCb180qgtmwI5jPeyWdYka60NatNrMyqW5axMywsIn2m648LaimtJUw==
X-Received: by 2002:a05:690c:b86:b0:81e:4acb:c0a with SMTP id 00721157ae682-81fd4d31d4bmr14405067b3.2.1785526058615;
        Fri, 31 Jul 2026 12:27:38 -0700 (PDT)
Received: from ?IPV6:2600:6c5c:6b00:316::23? ([2600:6c5c:6b00:316::23])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fcd164474sm13204967b3.48.2026.07.31.12.27.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 12:27:38 -0700 (PDT)
Message-ID: <e62e8603-a61d-489c-8df0-2c9ff98a1c02@gmail.com>
Date: Fri, 31 Jul 2026 15:27:37 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Matt Vollrath <tactii@gmail.com>
Subject: Re: [PATCH iwl-next 0/3] iavf: defer loading netmem_desc
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
References: <20260731124109.99065-1-tactii@gmail.com>
 <7e9a5228-d257-4adb-b472-b110f60e3618@intel.com>
Content-Language: en-US
In-Reply-To: <7e9a5228-d257-4adb-b472-b110f60e3618@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/31/26 11:13, Alexander Lobakin wrote:
> From: Matt Vollrath <tactii@gmail.com>
> Date: Fri, 31 Jul 2026 08:41:06 -0400
> 
>> In a few places libeth and the iavf driver inspect which page pool is
>> attached to a netmem_ref. This forces an immediate load of the
>> netmem_desc struct for each buffer in the Rx loop.
>>
>> Defer or eliminate these loads of netmem_desc from the driver fast path
>> by using the page_pool ref in the first cache line of iavf_ring instead.
> 
> I was thinking of this when implementing the current design, but:
> 
> Do you have any data to prove this actually helps performance?

The optimization was profile-driven, but not on an iavf. I was working on
a libeth port of e1000e, because I'm an obsessive optimizer, and this quirk
of the interface fell out. I'm working with a Xeon E3-1240 v3 and I218-V.

With a mirror of the changes in this patch series, on my platform, it's a
net zero overall change in Rx performance. This is not surprising, because
the cold read is just deferred until later. The time saved in
eth_type_trans (where the payload is first read) is instead spent in
skb_gro_receive and pool puts.

The additional thing that does make an improvement, which was omitted from
this series, is prefetching netmem_desc early in the loop. This makes about
22 cycles/packet, 3% difference.

I left it where it is because I don't have hardware to perf this on, and
didn't know if anyone would even be interested in looking at something that
I can't produce data for on the actual hardware. For iavf the prefetch
would be conditional, only when the EOP flag is set, because in this case
netmem_desc will always be needed either for GRO merge or pool put.

I can't guarantee that this will be worth 3% on an iavf platform. In any
case, it'll be a couple weeks before I can work on this again.

> 
>>
>> There are only two paths out of the Rx loop where netmem_desc needs to
>> be consumed:
>> * The "very rare" case of libeth_rx_sync_for_cpu calling
>>    libeth_rx_recycle_slow and indicating that there was no data. This
>>    could be similarly factored out, but not by this series.
>> * GRO merging a frame into an existing aggregate stream. In this case,
>>    the cold load of netmem_desc may overlap the payload prefetch started
>>    by iavf_build_skb, which is now no longer dependent on netmem_desc to
>>    start.

I see now this isn't right, anything going to GRO will end up back in the
pool in the same iteration, and netmem_desc will be loaded. It just
happens later.

> 
> Thanks,
> Olek

