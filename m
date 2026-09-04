Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C22A503BEB
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 17:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788541784; cv=none; b=Dtbxq40z41FB7uN2qsGTThB3AyfI1Yrj5BDFtWsCd7ieuO64wBZco4gonwVUs1wwfKK1Z67DI5NOhWFb+2cyC40aQ5fv3KY13Sj2CL5TBOYlC1ttCtxKqNTW0XrgbJkuHrJlFHp279n4jgQB62Onxxiuibfc+qKr/MtdWoepTA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788541784; c=relaxed/simple;
	bh=VpUBv6NqPuaxAaa2PFMzt142Sfp50UkMNvLa8BRM+cE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Tl9xSuTqpjLMEXgmpt+bMmDIjttX7beVNlVhisltIO9gRczXCF/bBgRoL6yIQPQV9BVfPnZK35F2NVTLdywQ/Ds0/oosyiqLiZqMxNaqFbQP310z9PqkOeNPdABMiTzIEfFDOvUfrExmmhQmp4k3cJk6aarD6cPLr1VmfZLQ/8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WLFCC+z+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YEWMdtcY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WLFCC+z+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YEWMdtcY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788541781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M0mhCecfkd0CiyLlUKZRl2yAWss2xveqdG1CcOWYKi8=;
	b=WLFCC+z+/TXGgfu3CZ7neMNwMxryE1iDC6S/E5l3RRzRWvsi1kWdXFl+E4rWagidAZojx6
	CpV18BY0ZVupxgL8qWQ+5TsnenI4cRnmM04Aup32iZ2mRKCeytDcOluy7cDd+WbyYQ5Qe/
	5cQWJJZsZGMWPFHhwZNv81koEykfYU8=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-VdrL1nZXONKxeAS22JppWQ-1; Fri, 04 Sep 2026 13:09:39 -0400
X-MC-Unique: VdrL1nZXONKxeAS22JppWQ-1
X-Mimecast-MFC-AGG-ID: VdrL1nZXONKxeAS22JppWQ_1788541779
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-836c416b236so23193877b3.0
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 10:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788541779; x=1789146579; darn=vger.kernel.org;
        h=content-type:mime-version:user-agent:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=M0mhCecfkd0CiyLlUKZRl2yAWss2xveqdG1CcOWYKi8=;
        b=YEWMdtcYFH4MVuuG8uSCfCiR/OvP8ctUdjaaTOvbgqlxfax0cj9EU5jiCRQSKJ8bio
         hU8wgkTng+iG4HpGCw53On98YWHBbf8inJ4XedQtIFnW2+Aay9i7DrEij4OO3NBXHWeX
         3NHwA7huifSjic4hM+LkhZD4gII9btOBCvTGUeI5oxSc6nJbQMr42nN6kR1+v7dEzYs5
         TbW9Eq2o9mRDKsHbjcyhOIA/4PbDlaAD1OMQlTeCPmnps22pCuAMsGiyfG6IrGRUfuiY
         JsQzmA78mUYlkxy3j89vuwOvOWfJud5t5xtxYYSkhGK0j4MKSC7vwqR+tUsZ+VQHv3gq
         fpKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788541779; x=1789146579;
        h=content-type:mime-version:user-agent:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=M0mhCecfkd0CiyLlUKZRl2yAWss2xveqdG1CcOWYKi8=;
        b=ae28Qj7ackSxTy11LXr8cFzSyKJMYuRT/yS7FRpyw5a/DNZgWGDtC0r3TkiRomTp+c
         K8n3QE+DpdblfieJWxfk85Aqe1mLToDwC2OmmmheU8W3p1XHwjRP5FMAXoSOkQEOLdyp
         RTkuc0Q1wr+m5aSsacpEjXCjhitSUqzYozYBoUmIcWgZh804p/Z5X+OaTUUXZPmKOcRP
         PXq4YRVRwyYjlU7/ivjF6T2W9ygNXsQOZbUX1L/G+33fo9MqhZwU9SqoPfRJmcnxXxyS
         p3k2Wuf8rC6kze12NOIWecg9Qz8ZfRMeMCr4Kh8INdQDiZEAvLgqmaZNWla2Pke6Azww
         Tkpw==
X-Gm-Message-State: AFuF++m1K6fTHGRdx8v72lg2U5eQ1+7LNMslAc+nFu5WeGlwfqAri0ri
	aeeB91yyT3cQ25xfwvJUe+KLdAuhpYQoXDRtKP4L9FJIOJkWjOwX5yCu90RDdywtUSmO/l3SNmk
	qZqaCVJA2IEH1hJ6d6t9o6sOpIlmCSXwXFoDNtG10gzgXRJENLSpXIIC1OA==
X-Gm-Gg: AYBFou24Wrt6wTwOIGseSM4EDgyvJXTGOJ87G1lBgfPc+EM2AZBtabIRxjV9aqGnT0I
	1WetsaHl/vrLjTpfk7nls9uI1KQ9DhTAk0PipHLs5vUprFdv6xS/c2aJYUX8/AG97CKR7Y90bB/
	ZuOkU8fNooI8tHxAVlzZLJpe2t9RhE2ZoUjXESu+G4N8gAC3luNz28anKqaxKV8+uHlCWqa9YQu
	uzIacRduOWARuFHLiXm9Uc0QONkRIHkR65RIAyhboMCgiRu7O7C+kzMobllCMGMAND9vD8FCjy4
	mhupkbVd6OifhWlyZuN5FXxlhZ4iegQWPk6CMTHKpt3JDbOkMPQjLkwR9+e5R9OjT1xgzQyVmTx
	rnAfypXTuXnOEzPcUdXqCVKzxlBd9
X-Received: by 2002:a05:690c:c501:b0:873:5c6b:a2fc with SMTP id 00721157ae682-8735c6ba821mr10953797b3.42.1788541774072;
        Fri, 04 Sep 2026 10:09:34 -0700 (PDT)
X-Received: by 2002:a05:690c:c501:b0:873:5c6b:a2fc with SMTP id 00721157ae682-8735c6ba821mr10953157b3.42.1788541773402;
        Fri, 04 Sep 2026 10:09:33 -0700 (PDT)
Received: from aconole-thinkpadt14gen4.rmtusnh.csb ([216.212.25.12])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93988e9f80dsm122480885a.24.2026.09.04.10.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 10:09:32 -0700 (PDT)
From: Aaron Conole <aconole@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org,  davem@davemloft.net,  kuba@kernel.org,
  pabeni@redhat.com,  edumazet@google.com,  dsahern@kernel.org,
  horms@kernel.org,  sbrivio@redhat.com,  gnault@redhat.com,
  laikabcprice@gmail.com,  aroslavdudkov622@gmail.com,
  rough.rock3059@datachamp.fr,  stable@vger.kernel.org
Subject: Re: [PATCH net] tunnels: Drop stale dst when building an ICMP error
 for PMTUD
In-Reply-To: <20260902190112.4126199-1-idosch@nvidia.com> (Ido Schimmel's
	message of "Wed, 2 Sep 2026 22:01:12 +0300")
References: <20260902190112.4126199-1-idosch@nvidia.com>
Date: Fri, 04 Sep 2026 13:09:31 -0400
Message-ID: <f7t1pb9j644.fsf@aconole-thinkpadt14gen4.rmtusnh.csb>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ido Schimmel <idosch@nvidia.com> writes:

> Bridged UDP tunnels such as VXLAN and GENEVE build an ICMP error packet
> around an overlay packet if the packet is going to exceed the underlay
> path MTU. The ICMP error packet is then injected back into the Rx path
> with the source and destination addresses swapped, so that it will be
> delivered to the overlay source.
>
> If the overlay packet was routed to the UDP tunnel or locally generated,
> then it is already carrying a valid dst entry and this entry is not
> dropped when transforming the packet to an ICMP error packet. This
> causes the IP layer to reuse the dst entry, leading to the ICMP error
> packet being dropped or routed out of the UDP tunnel interface in case
> of forwarding.
>
> Prior to the blamed commit this could not happen, as
> skb_tunnel_check_pmtu() did not build ICMP errors for PACKET_HOST
> packets. Such packets were instead encapsulated and, unless the DF bit
> was set in the outer header, fragmented by the underlay.
>
> Fix this by making sure that the ICMP error packet does not have a valid
> dst entry, thereby forcing the IP layer to perform a route lookup.
>
> Adjust the bridged PMTU exception selftests accordingly. When the
> local sender in ns_a pings the overlay destination with a deadline
> (-w), ping exits on the first socket error before any reply is
> received and returns a non-zero exit code. The test therefore only
> passed because the ICMP error was never delivered. Use a packet count
> (-c) like the ns_c line above it, so that the ICMP error counts
> against the packet budget and the exit code depends on whether echo
> replies were received. This passes with and without the fix.
>
> Fixes: 8930424777e4 ("tunnels: Accept PACKET_HOST in skb_tunnel_check_pmtu().")
> Cc: stable@vger.kernel.org
> Reported-by: Laika Price <laikabcprice@gmail.com>
> Closes: https://lore.kernel.org/netdev/20260614-master-v3-1-9f5060ba1ed1@gmail.com/
> Reported-by: Yaroslav Dudkov <aroslavdudkov622@gmail.com>
> Closes: https://lore.kernel.org/netdev/20260901081825.287173-1-aroslavdudkov622@gmail.com/
> Reported-by: Charles Bordet <rough.rock3059@datachamp.fr>
> Closes: https://lore.kernel.org/netdev/aHVhQLPJIhq-SYPM@eldamar.lan/
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---

Thanks for the detailed analysis.  As noted, it was a very obscure and
subtle issue.

Reviewed-by: Aaron Conole <aconole@redhat.com>

