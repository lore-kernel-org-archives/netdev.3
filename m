Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562C2442FD6
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 13:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785246614; cv=none; b=uYm4we7/pCItAkeMNO/CsvbmgN24gqJBzCrTSXZPVrHdnwP4U2JJu8Lvl9tU8JKTNWaXHi273D0MXcLdub4X07Vl/apE3ujUTXYxjMriwpxKNmhYdWmv2rV3t1KRrumEOOvPfWDOX2ILlT9rQizRtyqYDsXl0o9Wbaye8tzKLPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785246614; c=relaxed/simple;
	bh=cYyqhGbOtch0OMgoH5rHeZBCWMljU1zPnzPnNokH5T0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=azwjkBxEZGfThVPoFcWfdoLvLMoQnXGKuiojUyOWtHW3rMPECzJxEq6o97LuDNSELCh1o6iUg+PzMTZZ2HSvYqnR37ePfUT5B9N2ZRkUQcnXLnjHgXQT7OGPGeheY2DK+C+3byLOaD/jc0urdNIALN7CmawGdK6wAvXhvMLD8a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NKly///z; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=klvVJMLg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NKly///z";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="klvVJMLg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785246612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WVLPzsih7jHwttgXCjqiYK0PPNx9XxtuzrfSgVm0vvg=;
	b=NKly///zSg8QgZMqD8uQzsvEqvuHllwPqDYKa94NpzjV+ck/NHheTwYiJhH+oqV0SetcIb
	98WhIaVXkfhJWP9DhzZ9BCg8rI8hsIaxpiUiGnz7sc771vFQJlcBcRqJfY/saXqZ5FT8Ft
	IVftwGjqbDDQAE1N/EdYCbHwMyF9LWw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-4EDGYPciOX2HVFqcKCKJng-1; Tue, 28 Jul 2026 09:50:09 -0400
X-MC-Unique: 4EDGYPciOX2HVFqcKCKJng-1
X-Mimecast-MFC-AGG-ID: 4EDGYPciOX2HVFqcKCKJng_1785246609
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4954dcd6131so40333835e9.3
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 06:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785246608; x=1785851408; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WVLPzsih7jHwttgXCjqiYK0PPNx9XxtuzrfSgVm0vvg=;
        b=klvVJMLgvidmZUxK1n/ase5GCaehMp9vohMQJr1OYp1SGZnsEP2h8HIaFcdaiIAxq9
         4kBil6CzBCpqnLMMIILeseYgUosMcqeJimzN/CLN3Jc7App1AoEhRTjPhaObVg7/AjST
         kRV2zOpKH/Iep1ZNPeMWH0wIwxLVXiXHLKnP7PQJ78fGsuS3YkCwgqLXx7v+nt3s+fLa
         /y6KdNdHBVVAohp1FWwO6l4zxYLlWWoRRDbFy2RyPbjNvsKDqLYiT95RVOx9aoGlVlzA
         NeRnBKHUPhtpKzfdfnkebFnfn0yZ1ae5pzs4fOWnPeM6rLShHZ3VmL2zirwkcWeshHsV
         a/cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785246608; x=1785851408;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WVLPzsih7jHwttgXCjqiYK0PPNx9XxtuzrfSgVm0vvg=;
        b=YJ6EEEha7jHSExVEOaVPiAhP6YVb0Xd85f2bW3P7l72Ucur92NRZNhZ8ApjAXLyewX
         hDyGSAYvvqLAcy1kDutAK6qcQ+ml7D/mD9GzhnwSbfD37oDI2dW7mO9EONErCr35cGae
         PoQ6xCzx7etaFGR8SWdiczs9STOd786jTnGqhK4ITo18llPP3vEXyB0eRLvPFI7IeOZ4
         bdxRvmzE5zSTncu2XANTFu0ZglGLiYOL+ht17/fMg+hTR3jO8twFyj0W0z+Q1CPFSk4n
         R+/Ok5cYwMNY+vtUeOKXLesAYAOo08/CBCYq/pPcDE3YukbtOYNnf1hQabfKeuoywB/l
         UlLg==
X-Forwarded-Encrypted: i=1; AHgh+RqxJFHGy3MGVpR/wDMezZihHZnlnMJo5/J1Zb6KzAwD5et1jM/2lLy+3gZj9EeqmHnzzDzuKVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YztDYnDVPZIK6vCRhBCdXJDacy5Y0BqlPXw+UA/uxiKCmfRLAMY
	uIkvSmL+e5CpNhy9oIUC5fN78uwyW8T5JlASsfcR72hJUiEJFbHgqkmt+qrRCnN2t+G2K/33spZ
	GMuutQY+5/lJUqHqAIQkrb8iL9lL0PdXohy0BOu5HVaEjZ9irxhUb6vkYlQ==
X-Gm-Gg: AR+sD132TRIqI1nE8OjnNPoXwjDLwp9wn/L7MUoESVl4vyxr4Np/Xra6DUDXkmonlnj
	w77qZRmK4bfjIIVW3FOIauz1LlqK4TBeXasSq8rTgiZ8L1QabhdOviilMivImYzBh5kNmN217au
	ety6ciyS4PEKPtxtCW7jWTpUYiDW6ThiK5oM/I8ajUtySd+WANAMiaJE4ZVIwU+7Im6Tjf42WJZ
	xBkS4rFvP6cZzaU/itctN2gEuUTaAdWijPA0Fd/Q/9q3GuiPQFepi5/fr17jU4SMtGXSv0/V3Su
	ja9nvwDvZB//2andzs2tH4HbHm2gtIX+9KvTpRUXrY7fL+U/x4TDlxYKEHTS61lwg982YPb1rHS
	F6OiqwtDyArHGrl9OxOtm45g7hAKypBi4w3DgmM7KFOb8ksC45zMDDOnBBbGhOKJQBzb0GG2Xu+
	wEUg==
X-Received: by 2002:a05:600c:46d5:b0:495:4a22:d684 with SMTP id 5b1f17b1804b1-496c6439428mr31470275e9.10.1785246606622;
        Tue, 28 Jul 2026 06:50:06 -0700 (PDT)
X-Received: by 2002:a05:600c:46d5:b0:495:4a22:d684 with SMTP id 5b1f17b1804b1-496c6439428mr31468965e9.10.1785246605194;
        Tue, 28 Jul 2026 06:50:05 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496c45c297dsm76861475e9.7.2026.07.28.06.50.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2026 06:50:04 -0700 (PDT)
Message-ID: <4b5f67a2-5624-4adb-812a-bd87d99416ed@redhat.com>
Date: Tue, 28 Jul 2026 15:50:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 1/3] net/smc: bound the wire-controlled producer
 cursor to the RMB
To: hexlabsecurity@proton.me, Sidraya Jayagond <sidraya@linux.ibm.com>,
 Jakub Kicinski <kuba@kernel.org>, "D. Wythe" <alibuda@linux.alibaba.com>,
 "David S. Miller" <davem@davemloft.net>, Wen Gu <guwen@linux.alibaba.com>,
 Wenjia Zhang <wenjia@linux.ibm.com>, Eric Dumazet <edumazet@google.com>,
 Tony Lu <tonylu@linux.alibaba.com>, Mahanta Jambigi
 <mjambigi@linux.ibm.com>, Dust Li <dust.li@linux.alibaba.com>
Cc: linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
 Ursula Braun <ubraun@linux.ibm.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Stefan Raspl <raspl@linux.ibm.com>,
 Simon Horman <horms@kernel.org>
References: <20260723-b4-disp-0d07164f-v5-0-6a9e235dbc4e@proton.me>
 <20260723-b4-disp-0d07164f-v5-1-6a9e235dbc4e@proton.me>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260723-b4-disp-0d07164f-v5-1-6a9e235dbc4e@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/24/26 2:23 AM, Bryam Vargas via B4 Relay wrote:
> @@ -246,8 +256,13 @@ static inline void smcr_cdc_msg_to_host(struct smc_host_cdc_msg *local,
>  	local->len = peer->len;
>  	local->seqno = ntohs(peer->seqno);
>  	local->token = ntohl(peer->token);
> -	smc_cdc_cursor_to_host(&local->prod, &peer->prod, conn);
> -	smc_cdc_cursor_to_host(&local->cons, &peer->cons, conn);
> +	/* bound the wire-controlled producer cursor to our RMB (used as a raw
> +	 * index by the urgent path); leave the consumer cursor unbounded -- it
> +	 * indexes the peer's RMB and is bounded by peer_rmbe_size.
> +	 */
> +	smc_cdc_cursor_to_host(&local->prod, &peer->prod, conn,
> +			       conn->rmb_desc->len);

Sashiko gemini suspects the above may cause a Null ptr dereference:

https://sashiko.dev/#/patchset/20260723-b4-disp-0d07164f-v5-0-6a9e235dbc4e%40proton.me

/P

