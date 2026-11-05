Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793900540;
	b=m41ogLlp2Vh1s+zHGinoH7TN/AA8N/dHS3XMYfgpAnQpqRIwUEQDcO3TE0GPqXr7qOYL
	 tAznT0U1VPI0tfrV2JZ+FJ1+z24UVLGGqnUMcHNrtDwXjXH/rNQyhsg47xInCXR6Lk+tP
	 4Tw2oI5X5cNpm6zuIoOf0eaOcBK2vXO196ILUHYXxL8m1UDW+Akk+SM2xQwMnVDjTr+H6
	 KyCHaqnQQWDSJO0nC4660yCVIxD9WLcCioycQKn/Dw/ApTQcAtczouuHyLlvqE5GibTe1
	 7SYES5pQrg5y3gnF6g/jXoKGzhuP1t+aj1Yvym3f2KyBEbOSjK/R2Zr4Uh+RvtK+3Xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793900540;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=7mW/W2zUvZRbJ83TvA9tsndEDGm8qEAN4uyhPOEw0Pw=;
	b=NeuTGMhWPCnJCzqPKMpBfoZrO7sgow7POyEiNNITXgcjpIfJSIx46SOaear1WMHfmonI
	 dp9094uz/tV0EofVkt8mC6Ne4DHFu8yLIpM+u6jDLwCrEbilpu+oJTiEMy+oELr4iF7ED
	 lEdBTOwXGjKslvD5emtHGUJ6Ztj2F5jVs6XUaNtiyBgDpS2VxCrKiYcM9VbRf9EPxxsIu
	 MSuVRcj7ev2V47W30pwjl0+mzR5Uwtw1iAUiaGq2H4zMIvJJASpd4BIt9KwNo1Xht1sRJ
	 DiVKi+aGtxa45DfY77HorTI79JzVvTvJQMEmyPks6VpQarJagJP1bgXePZWYK96WwrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KG+S64On;
	arc=none smtp.remote-ip=209.85.128.182
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B259C606A326
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 17:42:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B259C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KG+S64On
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-8b0d91601bdso7728017b3.1
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 09:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793900539; x=1794505339; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7mW/W2zUvZRbJ83TvA9tsndEDGm8qEAN4uyhPOEw0Pw=;
        b=KG+S64OnRQhNJdrRc5VVrIRK3+SoA7zTQ5EbgjknSenrZM2eiyYZMO/r/TAj/d+Skj
         gGo2gP5DbB2IeEzu+qNLnUHhkoYGnKNuw/bvaNrDCEBcwY7BnhxnWaEUs/emwJKiMDmd
         yY3QJagIryIqNXdPI9SL+p3NysHQwappzMzT4XDR0aTRXEPpjPdRsrS6ifPXAr+fBvqJ
         a17hi43V/wsqgvkNYcz9Ax+xRFGj0KexoF8Swy9UTQmA5K27NtNTpTC4QQuInu9RVyOh
         yfpPjhIIF4qiYWZET622OR3UNiD03z1yA/U9Gou3p/MEiwYasQd06s2ijEpkg1DgSXG6
         k92w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793900539; x=1794505339;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7mW/W2zUvZRbJ83TvA9tsndEDGm8qEAN4uyhPOEw0Pw=;
        b=xcnDSv7nFxozJM71HI6dDhqZZMfFxJKxcd1Xmyk7tAq4z6gfL1KwmqnY0vfM+5cNNw
         nwjXeEOCUrzjRU2Myq5+g2qRUyaSQBN6+U4FF9LNz3eAjVEDzjekT4n3L51Tj4Bj7rJa
         AR9pKJlhUlURyRW8MJlJvfV100hMe2D0E+ePmfbBEA6QJgcYRD+QmHgyYj3mRtJfthot
         2t2wE0U5Qm4dnDvLS6gqitANtISjepGNRQMlUuyjnfeJW6J5+8kl9n+a4r/c57e2gJ0k
         9ycj1DyPhurF60QazFPm4FSpsEZj6o9DgPrrvNBJP+fbqn3Fsvn2vt5Q6dQVALB4Pe6R
         26aw==
X-Gm-Message-State: APuU4Z+ehkH90vGwex2SnD5waRicny7+2eYvfKBKdkJ2WLeLpOtgwi2m
	iEGKj+vtaiREQyDda1Iu6j5RG2X27HDiFeDkaAc1w1T7tNcD3S/zpycj
X-Gm-Gg: AYBFou2dfOrzd6NRtNuPNkSJQ1ZqKCUQAkj2aFqPCg+zWvRXmllcUpZVFtyw9alQXq3
	VotztYaAu4X3z/BmbPDAzehaR8VXe9hG8DIjbm6dgY5qPvOWyLGJPKRhDMLhZe8gKdP+g1ktikU
	9WX0j8kKtYpP+3lEqnAEPIoBKq8cRf8BzbdZyh3llFX/nD00cbIMoiXXeBRzjl9g4KuiD4gcMnw
	uI3yVrr6PiEVaaDiBGCLksetXgz/nx5fuRrfqOu65HpKtddsyvOtS/+TdmhIpV2TOhqv21yGssD
	11NbCs0+Xx09dYTZKNAqpb92/MI7xbto5K5srTbVpot3ZxAdlUa3eHKe014jKXTjzuBXsKYMAJW
	IzZMdmvnjgwKHYz+riLeIMGeG5+fTvr/+IfZ4ZeFyPR3c1JcKEd+KeDQVEwbMcfNjpefpACKkAK
	fVdoHyAEsktvqT1a/cTEFuUUvE8Y/A5wjtD+QnXIxmbFH1fQFDpfBMEhZ0uBnrZ6RIQfocoLUSZ
	1qIgMtyruCUw8EECYTri7R7rRQvK52zXVJ5jruBDk7s93o8CMrN7ifmCMXyaU72JeWKpDaLLIWr
	qr36EZIDyx4Afh8LFCJD66nUZ1YDPpBDHu79vfASUqniwMbzoA==
X-Received: by 2002:a05:690c:a012:b0:8b0:e13c:2852 with SMTP id 00721157ae682-8b328db53bfmr17577147b3.7.1793900537616;
        Thu, 05 Nov 2026 09:42:17 -0800 (PST)
Received: from ?IPV6:2600:6c5c:6b00:316::23? ([2600:6c5c:6b00:316::23])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b33f5f2e0fsm795357b3.4.2026.11.05.09.42.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 09:42:17 -0800 (PST)
Message-ID: <2c861cd8-29b5-4779-98e0-0be49a04023c@gmail.com>
Date: Thu, 5 Nov 2026 12:42:16 -0500
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: reset transport_header for ndo_features_check
To: Eric Dumazet <edumazet@kernel.org>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>,
 Alexander Duyck <alexanderduyck@fb.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
References: <20261104175517.2395704-1-tactii@gmail.com>
 <CAL4WiiocQ1-jpdkYi1u_5T3J7oXK9qXnKDV+316Nd9KtDvsOKw@mail.gmail.com>
Content-Language: en-US
From: Matt Vollrath <tactii@gmail.com>
In-Reply-To: <CAL4WiiocQ1-jpdkYi1u_5T3J7oXK9qXnKDV+316Nd9KtDvsOKw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/4/26 13:16, Eric Dumazet wrote:
> Le mer. 4 nov. 2026 à 18:55, Matt Vollrath <tactii@gmail.com> a écrit :
>>
>> ndo_features_check() can see a transport_header that does not point at
>> the L4 header, while ndo_start_xmit() for the same skb sees the right
>> one.
>>
> 
> The change looks fine to me, but this is net-next material: the bug is
> very old, there is no report from real hardware, and the patch changes
> what every ndo_features_check() sees. Please drop the Cc: stable and the
> Fixes: tag. For 6.1.y, send a backport of 5f0764cb1c81 to stable@
> separately.

I'll be proposing a different series which fixes transport_header at the
source instead of patching one place where it matters that it's wrong. It
turns out there is more than one place.

I've sent the backport of 5f0764cb1c81 to stable.

>> Commit 663ead3bb8d5 ("[NET]: Use csum_start offset instead of
>> skb_transport_header") made csum_start authoritative because receive
>> processing overwrites transport_header, and resets it from csum_start
>> "just before we push a packet with partial checksums off into the device
>> driver". That reset, which now sets inner_transport_header instead for
>> encapsulated skbs, sits in validate_xmit_skb(), on the non-GSO path
>> only, after netif_skb_features() has called ndo_features_check().
>>
>> So the hook sees a wrong transport_header for a CHECKSUM_PARTIAL skb
>> (after GRO, or from a container or VM) when no stacked device (VLAN,
>> bond, tunnel) ran validate_xmit_skb() first and something earlier
>> pointed the header elsewhere:
>>
>> * IPv6 forwarding with a destination options or routing header:
>>    ip6_rcv_core() sets it just past the fixed header, and only hop-by-hop
>>    options are stepped over before forwarding.
>> * br_nf_pre_routing_ipv6() does the same for bridged IPv6.
>> * seg6 inline, rpl and ioam6 point it at the header they insert.
>>
>> A hook that bounds header lengths with transport_header can then leave
>> offloads enabled that the hardware cannot handle. For example,
>> i40e_features_check() limits IPLEN using skb_network_header_len(),
>> which returns 40, while i40e_tx_enable_csum() writes the real length
>> into the 7-bit IPLEN field, so more than 468 bytes of extension headers
>> overflow into L4_FC_LEN. Rather than make every driver measure from
>> csum_start, give the hook the headers the transmit path gets.
>>
> 
> Only from validate_xmit_skb(). ip_finish_output_gso(), some qdiscs and
> netpoll still call netif_skb_features() without the reset.
> 
> The changelog is also too long, something like this would be enough
> for v2:
> 
>      net: reset transport header before ndo_features_check()
> 
>      For CHECKSUM_PARTIAL skbs, validate_xmit_skb() resets
>      transport_header (inner_transport_header for encapsulated skbs)
>      from csum_start, but only after netif_skb_features() has called
>      ndo_features_check().
> 
>      The hook can therefore see a transport_header left elsewhere by
>      the receive path, while ndo_start_xmit() sees the reset one. For
>      example, ip6_rcv_core() leaves it after the fixed header of
>      forwarded IPv6 packets with destination options or a routing
>      header, and seg6, rpl and ioam6 point it at the header they insert.
> 
>      i40e_features_check() then bounds IPLEN with a 40 byte
>      skb_network_header_len(), while i40e_tx_enable_csum() programs the
>      real length, which can overflow the 7-bit field.
> 
>      Move the reset before netif_skb_features(). Skbs that are not
>      segmented in software reach ndo_start_xmit() with the same headers
>      as before, and software GSO parses the headers itself.
> 
> pw-bot: cr

