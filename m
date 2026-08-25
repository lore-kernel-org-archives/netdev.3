Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939C73F44FC
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 10:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787653265; cv=none; b=goc6hHsHaETyCG1QS3/MdFVGM9q3hWZ5PA/uAMrhxx3NEUTyWRjOJmynf5T8PLks944s6dXYtrd3/Ek0kTAHpDxbCUEJPZlZCG7PxdTsZ20yQoE5cnBjNB0Trem0oiO7gR5w55iqxt2losSr+2QLa2vyaacumNI+3f9GtLF8sr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787653265; c=relaxed/simple;
	bh=iGQ4XBERW+BYgzxnrEmIdO0AoKUdrh1q+GZNB0APfAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DT6wL7bor1Qc3YnN0mTSpDGYO9PlCdcw4B30mDrO8ARe9w7seemU0PWBHI/bDvvLSq9BjSijr8/XLNZHk4KDFdKeW0zzelEoUZcgf5K/GY+U8PUa1LQrJi8H+ECsrpXEc6vsF6ZBHjhXZjrJmDjduQr+eqVChgLuTqzd9hz7aR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cg29tUf3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IINYQnqi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cg29tUf3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IINYQnqi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787653262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VAl9X89w/F+ab03ZX8lVul3F4+W9aUePi+y3S/ulBJM=;
	b=cg29tUf3aR8SYVR0as8WT2/lj3WiifYXZAF6McsXQ/ASZNfovlsCC8sHouFWhiA7Pa49zb
	l3oyTx2NlS5jrOcbp+nE5F0KL0B2CdErzDj3nRjPT52+mGTjnLyWvGNaSsaeU3le5yI19B
	t2DKSxghfYb2nHaTXNs1rtl77ndDXrA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-wcq1uz8fMzWkdgx6uiuP9A-1; Tue, 25 Aug 2026 06:21:01 -0400
X-MC-Unique: wcq1uz8fMzWkdgx6uiuP9A-1
X-Mimecast-MFC-AGG-ID: wcq1uz8fMzWkdgx6uiuP9A_1787653260
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c15ddb61f13so417758266b.0
        for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 03:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787653260; x=1788258060; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VAl9X89w/F+ab03ZX8lVul3F4+W9aUePi+y3S/ulBJM=;
        b=IINYQnqi0Phc3svWmCPz7KbIMohsBk+8VK978Xeil9iGdTbCpWxr7vcfOVTs6yPjG9
         dZU50DulDc8WR5hgH6Wa8znypdl4VdNY3g7oHwsuD+Fd+PbajCUj30q5jcxcxYJDZoiH
         Uk6Cbe2UOjXYMMHIY4jX55xTsH3f4Oj0mtw4nx7EZM7C1yddtn77V5OvMPtzxt7Wbs0S
         LSwvts9FyJrDqrsvcfqG4XM+mC7jpgMBbcQxCJUDMhZ1Akhr7Wz8abzHm5+lPQsGHp9y
         IYZVTywy8FsiJ9o7nnhGeqpbIqQzM28eL9yKxby0iIyLHCWsEIjw7nna0pO3EmTOzgmd
         9kwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787653260; x=1788258060;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VAl9X89w/F+ab03ZX8lVul3F4+W9aUePi+y3S/ulBJM=;
        b=K0okydmF8ATOqR9ptWYDsDDj4U95FJ3YS/SMaJphZtpJsF1teNTYQzJz6kwewcMTE9
         7ylX4sxgKoIb8I+CtChWi5Tmu0w5atn4DF9pL7HTQn53Mb3yWzn831f+DoS5/FqiZD9w
         RBI3RZGjhBCqx9B+T9FIHX8/XJ4Iz4A5MliKcabqM6jMru1C7TSyj7kBWnIFy3Okr6O/
         kFCpz3qYayohmi5ax2A79V6/gvzJaU3K+sRsJyMBMsOYbUkIJ08O5wW9E8Cv1IFoOSBx
         qhs+USG6eJTA8Smu6D1sKng26slBMxZCWNzeaM7afmwU90nsNP3B5JDq1zIU4HzduBRY
         Tf6A==
X-Forwarded-Encrypted: i=1; AHgh+RrgRGNHy0zOVv6IZ5tWf/DMgjqAQqiko6dypjd5qbv1DWACbFbOAZwk7LflyEEFJValcMb5GM0=@vger.kernel.org
X-Gm-Message-State: AFuF++nBGb01s2Nbpyw8fnbQZw9r2KTr/Msjdm4iOXgwzuj5aUwqojAh
	onmvd+5eBb6L9wj7O1OJ+hNtaxUyFKd57d/IVpVbXDw4S/UbYLM2BegB9NaPZtLXRgny5e5Ts1R
	V1kJKn+F94pSefuB7VhO50VVYUpL8b16bkF0GeD7U+UH47WDN+WsFcUzmJw==
X-Gm-Gg: AR+sD10QhHh9m4ovM343ILw5qCW6lcx2NYLQGzDHtCC3ZI2Cal2V0CZq22/D3GPiG5Z
	HtJSpWWiroXrqaaYaO8rmIlVUgdiwa96x9NBJm/ecELcFPkWN2XthYFVlmn9XCho+y5KCbOPzym
	irn/3caH6rnnrurdoMMf1nQFS01gOvA9qnILdFi1fxorbN7Hq495hkGXcElCjlS2PZHDeuVDDzx
	NS5GGmMa59vcQHv2SPWblXbmn6Zz4aYxn+py0kKTVKFc9HB1RALQavzvu3iZQkuc6sSYeU+h0NT
	y4K6Fqvvcv9LncEkNC4xlVaeAc54R6M0DXdcg2bcRg+tgyF6XETrJeJvlSmEA3FRqwTSHDgH7WE
	FW9L8G99BSqho5JPh5qL7mvQY2cSpLN7omYcy+xAvnHK0bDU9LDTYaJHyRlap746bWNWOTdxB
X-Received: by 2002:a17:906:4fd6:b0:c21:3fa7:5a6f with SMTP id a640c23a62f3a-c246a72cb16mr4011655866b.24.1787653259805;
        Tue, 25 Aug 2026 03:20:59 -0700 (PDT)
X-Received: by 2002:a17:906:4fd6:b0:c21:3fa7:5a6f with SMTP id a640c23a62f3a-c246a72cb16mr4011648166b.24.1787653259301;
        Tue, 25 Aug 2026 03:20:59 -0700 (PDT)
Received: from [192.168.188.103] (ip46-47-231-195.pool-bba.aruba.it. [195.231.47.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24962bbea6sm1608140766b.27.2026.08.25.03.20.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 03:20:58 -0700 (PDT)
Message-ID: <5524d562-db44-4edc-bcfc-65a3da7806a0@redhat.com>
Date: Tue, 25 Aug 2026 12:20:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v16] tipc: fix NULL deref in tipc_named_node_up() on
 empty publication list
To: Tung Nguyen <tung.quang.nguyen@est.tech>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 jmaloy@redhat.com, horms@kernel.org, tipc-discussion@lists.sourceforge.net,
 Xiang Mei <xmei5@asu.edu>, Weiming Shi <bestswngs@gmail.com>
References: <20260822091216.131278-1-tung.quang.nguyen@est.tech>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260822091216.131278-1-tung.quang.nguyen@est.tech>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/22/26 11:10 AM, Tung Nguyen wrote:
> User-space applications can bind a large number of service addresses to
> one or more sockets. Each binding of a local-scope service address inserts
> one entry (publication) into the TIPC name table. If the number of these
> publications exceeds TIPC_MAX_PUBL (65535), protocol service types
> (such as node state and link state) are no longer inserted into the name
> table. This causes two issues:
> 
> 1. User-space applications subscribing to node or link up/down events
>    stop receiving notifications.
> 
> 2. A NULL pointer dereference can occur if an address is assigned to a
>    node after no slot for a local publication is available:
> 
>    BUG: kernel NULL pointer dereference, address: 00000000000000d0
>    ...
>    CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 7.2.0-rc4-default+ #5 PREEMPT(full)
>    ...
>    RIP: 0010:tipc_named_node_up (./include/linux/skbuff.h:2251 net/tipc/name_distr.c:195 net/tipc/name_distr.c:221)
>    ...
>    Call Trace:
>    <IRQ>
>    tipc_node_write_unlock (net/tipc/node.c:428)
>    tipc_rcv (net/tipc/node.c:934 net/tipc/node.c:2189)
>    tipc_udp_recv (net/tipc/udp_media.c:389)
> 
>    Thread 1 (tipc_net_finalize) | Thread 2 (named_distribute)
>    -----------------------------|-----------------------------
>                                 | ...
>                                 | list_for_each_entry(publ, pls, binding_node) {
>                                 | ...
>                                 | __skb_queue_tail(list, skb);
>                                 | ...
>                                 | }
>                                 | ...
>                                 | hdr = buf_msg(skb_peek_tail(list));
>    ...                          |
>    tipc_nametbl_publish();      |
> 
>    If 'tipc_nametbl_publish()' (Thread 1) fails or executes after
>    'named_distribute()' (Thread 2), list will be empty. As a result, NULL
>    is passed to 'buf_msg()', leading to a NULL pointer dereference.
> 
> Fix the first issue by allowing protocol service types (node state, link state,
> and topology server) to be inserted into the name table unconditionally. On a
> link-up event, if the link-state publication cannot be inserted due to a memory
> allocation error, force the link down and restart the insertion process.

I'm sorry for the late feedback, but it looks like the above would allow
the user-space to force the kernel to do an unlimited amount of memory
allocations for addresses?!? That would be dangerous for the whole
system stability.

> Fix the second issue by checking for the node's self-address publication on
> either node-up or node-timeout event. If the publication does not exist, insert
> it into the name table and publish it to the other nodes. If the insertion fails
> due to a memory allocation error, force the node down and restart the insertion
> process.
> 
> To facilitate the implementation, five major changes are made:
> - The maximum number of local user publications is reduced to
>   (TIPC_MAX_PUBL - 1) so that the local node-up publication can be inserted into
>   the name table unconditionally. This ensures that the maximum bulk size
>   calculated in tipc_link_set_queue_limits() remains valid. In addition, the
>   local link-up publication (TIPC_LINK_STATE) is inserted into the name table
>   unconditionally to ensure that users subscribing to this event always receive
>   notifications.
> - Remove cluster_scope_lock, which protects the name table's cluster_scope list.
>   Use nametbl_lock instead to protect the list from races when multiple threads
>   concurrently call tipc_named_publish(), tipc_named_withdraw(), and
>   tipc_named_node_up().
> - Move the sc->lock acquisition out of tipc_service_insert_publ() and into its
>   callers.
> - Add an output parameter (*err) to tipc_nametbl_publish() to detect memory
>   allocation errors.
> - Add three fields (nt_stop, nt_self_node_exist, and node_addr_set) to struct
>   tipc_net to synchronize the insertion and deletion of the node's self-address
>   publication.

The change is quite big, hard to review as-is, and it looks like it
could be split in several patches, according to the major changes list
above.

Sashiko has more to say, please see:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260822091216.131278-1-tung.quang.nguyen%40est.tech

/P

