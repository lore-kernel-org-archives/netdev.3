Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199343D9035
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 08:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785401133; cv=none; b=Uim67ocE8D13a18QPDAGuDtMKmK2hbIGoSRpkb4nDl9hJje6D30RUAH21eUBZvn7MbBlWhvlYUWZCKvG4QIfmwINE2Ix95FTnHFwiHL3h7Tv85MxmgX/peve8clHFdi6vXHky3VjQxAqeKCwZ1oWJhMJ0LayzhkOhPmuEcS1VR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785401133; c=relaxed/simple;
	bh=sC9lPD1w0NqaXrCcspRVIT6YfcbV+JFCEhrHkXgg8FY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KQPV3qqxmnanfWlxZmAIzJysGuAf4GYGoS5SwcbOrVOSaubGiBFqPOIskR8H7OBapIErxkb5ImmjWtgb2zhFCv0B+v/ImxHvITdJ8dphPxva+96qElQttdxrUfSzWjD6RiMOSy75VEQ34oS3xzFHu8pDNeF2y0cPfZWZQsUBvIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TquS0iOn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nbwRBdCO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TquS0iOn";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nbwRBdCO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785401129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KUB53N8ZW7olaQibApR60mfiLMJvQ7kWg88nhg9lW2Y=;
	b=TquS0iOnkQC7aGx1liw1YefBUEMLemPCkKI/m2a50rPB2IFsb3TzuuCLrJDXh4RQ5lh0sM
	I7syJW7OJ6itk3vqo+60XqQu+6VYmLhqZJI8uyH0meHWz9flSlvf72tUFWlqaaU3xlABW0
	C5BAffAN/itSynWMk4ccorUWYmAbD10=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-TkahmgoKOhSdEw4zBMg4ag-1; Thu, 30 Jul 2026 04:45:27 -0400
X-MC-Unique: TkahmgoKOhSdEw4zBMg4ag-1
X-Mimecast-MFC-AGG-ID: TkahmgoKOhSdEw4zBMg4ag_1785401126
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49571407d1dso12922925e9.0
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 01:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785401126; x=1786005926; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KUB53N8ZW7olaQibApR60mfiLMJvQ7kWg88nhg9lW2Y=;
        b=nbwRBdCOcTangZpKTpm45qKbap7OVzTqhldDy/yDR8G2Z+yRceg3/ihjkukhUj1XZU
         Az9O3/s9jLqx8SyfkPdNiKcasKS6BZkiR8IVka8fEfg3Rj/EQ//nShKzKqXvzmn+O36z
         PzqLNe1IPiWzV4SzDg3mmNV2dkTozj2CkqWNEnM6P7SM+VOLsPHAlivhHGMES8mwTjnP
         2tDMl3VfOmDm/LbKTxXbHx2UKcEzWdHsx694TGZu08bNmwiSiKvv6uSijwhgl697ms3n
         8jQCklXQBm0jIkux2/XbgsosGDsrxXMW/HS/NOpP9UyaaJYjmN6vOfOb9K2ZxoCKsUB4
         2QEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785401126; x=1786005926;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KUB53N8ZW7olaQibApR60mfiLMJvQ7kWg88nhg9lW2Y=;
        b=IvpafIpPMa5oXLgVuTbyEzQvaGlhEnhim551oGUD/q6/I4P2boWo0bSg8vLkEC8Sk2
         Exu86WvS3ZKQWQw4HzeXWZwXjEBqkJVgXry2NerogJpcnbuKZVwerApD225R3z0af2Yb
         4kqc2zThkiYOFVgvG3J2HsuCP/degaXe+22283k1YFstrMLJNm1SIsv/3SuSTrMrqzel
         eu31vhSuqguykjU5PwqN6MyTVvuoJtUZW8oRSRa48O/95QiixiSPBy/dt9wa5Cl7iW8J
         3wFTglH88ulxOKPAPjCck6Vmreb+TxkuiC95FhXglqJg2AZ0OylXaWBaLiVdMYXawe8/
         rHng==
X-Forwarded-Encrypted: i=1; AHgh+RrTcnK6HzwDHKcY6gu/PjOMOvtRhtYfSEvUDVimR7TM5awpGAvEFuYklrfE0A3r8rH6jNdDdkc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPNefJ4POUADdYlYvh/Ctx1J8Y9TrSux4hvKPxNLXvEWi6HlWS
	os8SgKm1irwzrRIsY1kkGJfprZjQFyagpgIk+SwfCiii54wqPE2owY/O73kVCKsrHu8CA4EzNGB
	9MoMRRvLaR8EmGp1+vJMUwmRbutveT/3R2a90cQK85zcy7FTh9qu2eqmIbw==
X-Gm-Gg: AR+sD10AmyRPIxXqsePPce6VqbCt3jwnw/PG5h0TJiF8wYSM2wffwowcu3t6hkUaSL0
	z+1nlF09AayhBAy5vyWgGzXzaGfkIels74YQI/rvyTuwwGXECppLy3cIzWyCahPN5v/Z1TnyfOW
	udzldPjElPgLWr1iaZ34n5laAnhu9sT+gvFmZx7LeBLkjM4MZmTDnOj6e4N6ozGO6iOtgvmi4Px
	wLj+yVEIuUbAMP7HsYPP02xxYERIU9y8xvQWfGZQ1GRUYnBec2+4Ei88rPmIDKarsLjYKrPIVv3
	Si5UIlZ7zvUaqCTFwAxIzz07H+cdwFeRkOCiz6PFpBxlhWvlAFK74wjH8UBxeRS0cGFp8tb+AhB
	a9ItlmmekTb8P33v4T4+o0fJSSy3NJPNdcONzNTelQuwAMFd/61+G8FHyXK+xdljbugnVcMhHXc
	vPIQ==
X-Received: by 2002:a05:600c:4248:b0:493:f78f:cd70 with SMTP id 5b1f17b1804b1-49800ebefc7mr12654605e9.18.1785401126008;
        Thu, 30 Jul 2026 01:45:26 -0700 (PDT)
X-Received: by 2002:a05:600c:4248:b0:493:f78f:cd70 with SMTP id 5b1f17b1804b1-49800ebefc7mr12654155e9.18.1785401125431;
        Thu, 30 Jul 2026 01:45:25 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-498010aaceasm43139675e9.12.2026.07.30.01.45.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 01:45:24 -0700 (PDT)
Message-ID: <049f7b53-8bbe-4ee8-a347-6c07ee11c1ac@redhat.com>
Date: Thu, 30 Jul 2026 10:45:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] tcp: honor BPF_SOCK_OPS_RWND_INIT on the
 active connect path
To: Tejas Birajdar <tejasbirajdar@meta.com>,
 Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>,
 netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260723214208.3655474-1-tejasbirajdar@meta.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260723214208.3655474-1-tejasbirajdar@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/23/26 11:42 PM, Tejas Birajdar wrote:
> BPF_SOCK_OPS_RWND_INIT lets a sockops BPF program pick the initial TCP
> receive window, e.g. to advertise a larger window up front in environments
> where that is known to be safe. Today it is only effective for the passive
> (listener) side; on the active (connect) side the value is computed and
> then silently discarded.
> 
> On the passive path tcp_openreq_init_rwin() inflates full_space when the
> program returns a non-zero window, so tcp_select_initial_window() can offer
> it:
> 
> 	else if (full_space < (u64)rcv_wnd * mss)
> 		full_space = min_t(u64, (u64)rcv_wnd * mss, INT_MAX);
> 
> tcp_select_initial_window() only clamps the requested window *down* to the
> available space, so without inflating the space first the BPF reply can
> never raise the offered window above tcp_full_space(sk).
> 
> tcp_connect_init() calls tcp_rwnd_init_bpf() but never inflates full_space,
> so on connect() the requested window is clamped back to tcp_full_space(sk)
> (~64KB at the default rcvbuf) and the program's value is ignored.
> 
> Inflate full_space in tcp_connect_init() as well; tp->advmss is the mss the
> listener path uses (both are tcp_mss_clamp(tp, dst_metric_advmss(dst))).
> Read full_space after tcp_rwnd_init_bpf() so a program that also adjusts
> SO_RCVBUF is still reflected. Compute the inflated value in u64 and clamp
> to INT_MAX to avoid overflow (full_space is int, rcv_wnd is u32), and
> apply the same overflow fix to the existing listener-side computation.
> 
> Fixes: 13d3b1ebe287 ("bpf: Support for setting initial receive window")
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Tejas Birajdar <tejasbirajdar@meta.com>
> ---
> v2:
>   - Do the inflated full_space arithmetic in u64 and clamp to INT_MAX to
>     avoid overflow, and apply the same fix to the existing listener path
>     in tcp_openreq_init_rwin().
>   - Read full_space after tcp_rwnd_init_bpf() so a program that also raises
>     SO_RCVBUF via bpf_setsockopt() is reflected in the offered window.
>   - Re-ran the sockops BPF/RWND functional test and the full in-tree
>     packetdrill regression suite on the revised code (details below).
> v1: https://lore.kernel.org/netdev/20260722170033.2763794-1-tejasbirajdar@meta.com/
> 
> Functional test: a cgroup sockops BPF program returning
> skops->reply = N for BPF_SOCK_OPS_RWND_INIT was attached to the
> connecting socket and driven with packetdrill on the active-open
> (connect) path (advmss 1460, negotiated wscale 8). The offered window on
> the first post-handshake ACK now tracks the requested value:
> 
>   req_segs   offered window (bytes)   = req_segs * advmss
>   256        373760
>   1024       1495040  (~1.43 MB)
>   4096       5980160  (~5.7 MB)

The still present, sashiko reported, integer overflow in
tcp_select_initial_window() looks real to me, and the last value in the
above table is greater than the overflow threshold, so I'm wondering
what I'm missing here?

I *think* you should additionally take care of tcp_select_initial_window().

/P

