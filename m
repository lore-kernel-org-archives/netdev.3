Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D30E3A8745
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 14:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788271761; cv=none; b=VIn4fvy5Z8dsFjr2f+wJVQHiYQ2f8Uc3DHaaL21u2Vfn9TrDDA5lpnc07KaEunuOApNPvszRUJpAjhuFA56pm00DLGjutlJCMwCGFxud44r71qlPMfhLeqlwWBPjoWZqDT9lEMp6Qi/BSCUFKZ8sBJdDR6md8FglLBNHcRkmaQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788271761; c=relaxed/simple;
	bh=C66dzNAiLxzxkCBjY2wVJtqAWhkFkdYcJ7WYBjNLEpY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aKpMD/asYVG+5qU0HEEsFD6ExFRtu1+4vRQ83VaXBgdC3LA9SXZ2tjmLWHAPcF7IYH+FHAJFewqlzfM/XdbKvGH96sTcKumhfZuVeqJ6iBijcuS++60uWGDLLRvLbevQ2BRRkf74aagZG14HmYqiAEowJrs7RQ2pAqG/K94K/38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ci6WrtA+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=To7Qgh6o; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ci6WrtA+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="To7Qgh6o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788271759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b9vPZOgd6NLyUWZKoe/EId/qc/H8rWYiebMVzAAsIXQ=;
	b=ci6WrtA+cT4ORP24QlBjUDVlHyUZI/uSTeJUJu8cvptsFkhXLxtguxymYWUFNp89B7tocj
	7AD8FP3kMn5kqgp22bWyFsO9FYsorN6iB6jzTTbClmLxchw3NNko4OGzR/PzjEGdeES80t
	Ha9bcyHY/0l0BYzyynhtyGpNSOYQBzk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-uoBvhoOHPy6lKRdIR_t2jg-1; Tue, 01 Sept 2026 10:09:18 -0400
X-MC-Unique: uoBvhoOHPy6lKRdIR_t2jg-1
X-Mimecast-MFC-AGG-ID: uoBvhoOHPy6lKRdIR_t2jg_1788271757
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48437090e74so694620f8f.2
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 07:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788271757; x=1788876557; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b9vPZOgd6NLyUWZKoe/EId/qc/H8rWYiebMVzAAsIXQ=;
        b=To7Qgh6o32tahncczO4jcO+dcvNd2BcxpbUbhLpasdNU87m2mlpYif2H1qDhfMo+lY
         bidk4auBiSOBNhgAYBsOfIEfVPCKq1G/yR3UFobNpfrABjgFVaAlHCqlGFuURoJ5svJn
         +kJoMtxVlZpRdH26I3PSy0ZIwByA6WCHgnvBnZLWFp6rjmnvnKysDc5pgspzfjD9FsKm
         SWeoWigxN5OItEJrer5WFh/bHn9hZ1moEQ7xDmFXs1ooSqf+tHI0dv3R4a8kL44HCJ0D
         +4Hx1TKcnQc2DV+75Cw11GDCUQk1CYRcGZnFIhPrNeod8Rsi5gKsuLjNOcMkcphg/x7j
         91rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788271757; x=1788876557;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b9vPZOgd6NLyUWZKoe/EId/qc/H8rWYiebMVzAAsIXQ=;
        b=gvf9HNy+x/9NEpaMjgA/AY6EPfZR6ykm+GEpK6qwpCToe9apJ3QsrV0MaUSGuirnbP
         kvbDhlgKkUbQtnTv3M43RWQUS4BOVtbBON1j+LtkNpvDfC7qU5D525eUEQ9tQkNUJnhL
         1CclSuxqRoF5yZjHTk4+41oeHPcOFhsobJxSe9YxpjqtCI+XcXK5MUFVXq89YuO37djX
         lZn74YnPpES0np0A7L7S91W0seLmDyq22Vo2as4C8D6tFGi+rVVsVRZzOQnXRQjHi/oB
         SzVQCNlobNG4hzRcL9MPa+0KGHaWPnKHfBxfxBZWK++XRDGTK3yGLUFihUJQklvJsJe7
         eDqw==
X-Forwarded-Encrypted: i=1; AKwUvByae4YHIJmBzwWUsSWiix6YunFfkagVUH3vyiUo2YZ+w3rcdo2tDkcaL6neNCO6Dv/UG1cr98Q=@vger.kernel.org
X-Gm-Message-State: AFuF++m1Cqx4MqdG1GUkTvNxHibQYgL0dEH/8A9oBDdwfiXfb5l0Ss0k
	6PDNo1ptFZXHfqGve/rVj5R2hiWiCe6E+cjlj73v51DdM4vYjPHi/+n0pr1SMXJtfpiIYd4ZwvF
	FFvCQfeNGEiAMBpzjWpE9D5CSXxblGsEK7/klRwkFmIkSxMzWJyTvxxNqhA==
X-Gm-Gg: AYBFou2U2y0ra+m1+JT/LC6s7C4pOg/5DMUWRyXRIfHFQd8NUWnzSVHISpIvIE1Cw27
	tfebbCjbAz+JngO6ylbRe6mCdSJWisH/L+FawYpWxQWGzKIbzWidaPz2A9vaPU5UYzRtpq0LMOV
	cERmvZVI1hIHW9qALqG2300vf/kVguLuMpUl24m0VBFRSlzZjKOi7jqo4US0k1LhneBQKPe74zy
	BBLwIKsyeBfckZEtyaYTQBxJ7DW9hdVRsz/hDfwwBkMhY7gI3yqRxrUPgNXJMwlpX8eai6hY9Lr
	YXhplYwyLjQ3UFMD1OEGw9WRgAWaGUCVXLpFNfqi9aTpQIJbCme5c20mVQRqqQekK1J8GrjgVdV
	d8VRE6coIVkCdG2xsELFENXoqruStXqWR5rmJ7ovvZDeiwYPg4Z5jYQeSBGPSY/o11kYSUlA1bg
	==
X-Received: by 2002:a5d:5e01:0:b0:482:e2f2:19c9 with SMTP id ffacd0b85a97d-482f7987c40mr51900099f8f.2.1788271756603;
        Tue, 01 Sep 2026 07:09:16 -0700 (PDT)
X-Received: by 2002:a5d:5e01:0:b0:482:e2f2:19c9 with SMTP id ffacd0b85a97d-482f7987c40mr51899930f8f.2.1788271756069;
        Tue, 01 Sep 2026 07:09:16 -0700 (PDT)
Received: from [192.168.188.218] (ip245-45-231-195.pool-bba.aruba.it. [195.231.45.245])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48442d7ec2esm5063012f8f.37.2026.09.01.07.09.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2026 07:09:14 -0700 (PDT)
Message-ID: <a86aa34a-8bea-46d2-a785-6c423ac00b1d@redhat.com>
Date: Tue, 1 Sep 2026 16:09:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] udp: revalidate socket family before publishing an
 IPv6 cork
To: Daehyeon Ko <4ncienth@gmail.com>, netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Vladislav Yasevich <vyasevic@redhat.com>, linux-kernel@vger.kernel.org
References: <20260829132125.1160893-1-4ncienth@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260829132125.1160893-1-4ncienth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/29/26 3:21 PM, Daehyeon Ko wrote:
> udpv6_sendmsg() prepares the IPv6 flow and route before taking the socket
> lock when a datagram is corked.  IPV6_ADDRFORM takes the same lock, but it
> can convert the socket to AF_INET while the send path is doing that
> lockless preparation because no cork has been published yet.
> 
> If the conversion wins the race, udpv6_sendmsg() later publishes an
> AF_INET6 cork on an AF_INET socket.  Uncorking through the IPv4 socket
> operations then interprets the IPv6 cork as IPv4 state.  The IPv4
> finalizer writes a 20-byte IPv4 header into the 40-byte IPv6 header
> reservation while the retained IPv6 dst routes the skb through
> ip6_output().  ip6_finish_output2() consequently consumes the unwritten
> 20-byte tail.
> 
> An unprivileged reproducer triggered the mixed state on 12 of 10,000
> sockets.  KMSAN reported an uninitialized-value read in
> ip6_finish_output2() on three fresh boots, with the allocation origin in
> __alloc_skb() through __ip6_append_data().  The same process recovered the
> 20-byte region from the TX timestamp error queue; one of three fresh boots
> contained recognizable stale heap data.
> 
> The route prepared by the racing send is not published in the socket dst
> cache.  An implicit send on the IPv4-mapped peer required by ADDRFORM
> delegates to udp_sendmsg() before the IPv6 lookup.  An explicit native IPv6
> destination reaches the lookup, but leaves connected false and therefore
> cannot call ip6_sk_dst_store_flow().  Conversely, a native connected send
> can publish an IPv6 dst, but ADDRFORM rejects that peer with EADDRNOTAVAIL.
> The same reasoning covers the non-corking explicit send path.
> 
> After taking the lock, revalidate that IPV6_ADDRFORM has not changed the
> socket family before publishing the cork.  The existing error path releases
> the invocation's prepared dst, flowlabel, and transmit-option references;
> there is no socket dst cache entry from this send to reset.  With this
> change, the serialized controls retain their existing results and the
> forbidden mixed state occurred zero times across 20,000 sockets.

I understand that with the above you intend address sashiko concerns
WRT cached dst:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260829132125.1160893-1-4ncienth%40gmail.com

but I tend to agree with sashiko that the race is still present.

/P

