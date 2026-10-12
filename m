Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE243F326A
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 15:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819267; cv=none; b=KzodqF7KjZE1GtV/TiTPR3idDELCDckKJL95hOMorOpyXZrXNK+WRmaFNl9za23kdRXeIyd1CuLtOY8MbelQnmgrD67SWWsCvv+Z/Kq6D3eQY1s/WFOhke9YVyKyZbxw3W2xRD36Nx8xDE6h9YUqFlFCLXitJsb13HiXfzHPJS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819267; c=relaxed/simple;
	bh=xLZf1kGF5shHGn7VtBPMlBDgabDY+duTErr45LXA/HU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SxeI3TvM6w4RxBuZ8XPEoGu49M0vrhke8s+xgdsJ/3lRcQdMDJx7kw8qSKACUQV1RGtyAsKn/6BTC74CZga4ggcnrJq0zV60yLo5nXK+AIyeyhdR8g8z7NoQvrkhbV0QjTplOpQBkImMUGLY/7s4Xrpbc6fa2hdL/Ic8UZEOzvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Aa7vCdax; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dWEm03IS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Aa7vCdax";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dWEm03IS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791819264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=myjUzaBL+K2P3k1wyYvU0ibyOmHh6KLF5zYoWPKwyNU=;
	b=Aa7vCdax0jt26GX0lhvl+02jp5klLaPYOG+wbPfm21MYx9whg3l5DDiY0eq1UVN8NSS03j
	h22TqV1kH68Bs2G2zKt8gN6iYDztb8yBN9xK2hR68EcOJJVP3T/slbDEbhJWMU/IEfLw4w
	CU0S60lNo78xpcHHG0sOYkYE6cRjj48=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-5Dm4HGBXPpm3vvEHdslA3Q-1; Mon, 12 Oct 2026 15:34:17 +0000
X-MC-Unique: 5Dm4HGBXPpm3vvEHdslA3Q-1
X-Mimecast-MFC-AGG-ID: 5Dm4HGBXPpm3vvEHdslA3Q_1791819256
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a0228f4a1bso11521195e9.1
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 08:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791819256; x=1792424056; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=myjUzaBL+K2P3k1wyYvU0ibyOmHh6KLF5zYoWPKwyNU=;
        b=dWEm03IS9flsws4+jYlAFsTth5Ljj/bBuenEQdM7qFv2LqehHU7yMueDtxwfWm0bjQ
         IwZsjk8yn5cFxtiWzoi8RWzyoRIlAQCo4GSUTRLyaJJ1vn59D20LoA0Ql0PyM84q1XuX
         JMkTXIxzPoLIN4qpdEJGP1lEj/oVaHHIptTs2ulh1IDg9Hqm1YgShVRRghS3veeo8ExJ
         cbcWtWrDdmapXIEoOz3VG+Zk5zHocnddgKQRhdGkGmCfBcgxorMHsDVbGRpptKdqUe1+
         Ms1RqiOjbwqc2rqqK99vc09GjDXC4Go/2HfEQzhSWCgRynBBcIPoodMKw0G9lii6zaG9
         1f2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791819256; x=1792424056;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=myjUzaBL+K2P3k1wyYvU0ibyOmHh6KLF5zYoWPKwyNU=;
        b=WyjxmcP+JM96cN3kwlDTDU1tL7NjqXMc8d9BCt7nOt2G21K/Si6Ftp99IjyCRK+x0q
         paAI03ihX+zK30UgGh6TYYw1kezKi/XV34k7ZqNS/qICRp5Qtw1+zKsaRwkccweQBpSO
         KplEx4s7XyeEGdRD93226T+5L3/kspfHLjcxADo/6Nsdx5u3YezyY6L3bpkJtLdFbQDs
         om8WjK9bdu/H0RaTqPVt8Z8fttIPRG/o/eza11fvgT07Xeyc5NyRvntb6EHGmeb8ITyf
         WamKt+0xW1g8Tbgi6jUbTL80urqhKh1tyusazJxdNbF1FGOCGA94PWp82EOXpk8m6zo4
         /E4g==
X-Gm-Message-State: AFq9FYJKIP9jS0IRVaxYxo1LEsk+gFrVgMpdgkR/aZ/04L+x7C3AVguv
	1VtbtQqXGmKR05c0ab4+ph1ElLhHsLnBmfdp2vz7K8ZM67rBv9ABuyg7Es74l4Q/oy30ZbjDmR9
	ZoEZ4cAJTBfLTr7vWwEymBn7O1EHvO3iHngHoBg+BH5VddmuD78recv+j/Q==
X-Gm-Gg: AYBFou2zv6do+8YvaY4QyJnuLP6ldsBkh4tZTPhBsjK3r4PL8w1KGD7DDg2lwTUv7pU
	Kq6cmFtkNLgydMHRbZ9kSTuj1iA04YJjyQ3BRoFoO5bcGylZ+3ZckYvMEz7geHkAqaQZPYUgYlg
	CjDd+x5TwLknyIcCuvLd3k23w2v4HZrFkSXDVUwwI652UKjj8dLjoaUWHQMT9+MUjyDhf+pBnUV
	/8FMt2CC5wRO50jFwvY1guU20g6N8sHhacj0LtGXb7+qwSrAAGrbcsNmr8oIAtZzFr8FesgNTNs
	ms/rsaDgEQEF2H7lnr89ISuOQxS+Wwg+E9LPU/k5z1joge6vSL36bobgmoLq2De1MpMldrCCTQJ
	ZlCbFcgrF9Kdh3AsJN0OkwSFXuFeIZEc0Mis89EMwfKEWQ/uKfM00j0pthJ/k5Gx7BBN0ZnWPpg
	==
X-Received: by 2002:a05:600c:698d:b0:4a1:97c6:d2b4 with SMTP id 5b1f17b1804b1-4a197c6d614mr112401485e9.15.1791819255803;
        Mon, 12 Oct 2026 08:34:15 -0700 (PDT)
X-Received: by 2002:a05:600c:698d:b0:4a1:97c6:d2b4 with SMTP id 5b1f17b1804b1-4a197c6d614mr112400725e9.15.1791819255303;
        Mon, 12 Oct 2026 08:34:15 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a190344032sm299361335e9.15.2026.10.12.08.34.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2026 08:34:14 -0700 (PDT)
Message-ID: <baf77454-2a6b-4f10-836b-9e3612fbeed2@redhat.com>
Date: Mon, 12 Oct 2026 17:34:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] lib/dim: fix 32-bit overflow of epms in
 dim_calc_stats()
To: Shashank Mohan Jain <jain.sm@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
 Tal Gilboa <talgi@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
 Sashiko <sashiko-bot@kernel.org>
References: <20261005014411.78626-1-jain.sm@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261005014411.78626-1-jain.sm@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/5/26 03:44, Shashank Mohan Jain wrote:
> Commit 0843b2389064 ("lib/dim: fix 32-bit overflow in dim_calc_stats()
> rates") moved the packet, byte and completion rates in dim_calc_stats()
> to 64-bit arithmetic, but left the event rate as
> 
> 	DIV_ROUND_UP(DIM_NEVENTS * USEC_PER_MSEC, delta_us)
> 
> DIV_ROUND_UP() computes (64000 + delta_us - 1) / delta_us. On 32-bit
> architectures that sum is done in a 32-bit unsigned long and wraps for
> delta_us >= 4294903297, the last 64 ms of the u32 microsecond range
> that the function is meant to cover ("u32 holds up to 71 minutes").
> epms then becomes 0 instead of 1.
> 
> net_dim() and rdma_dim() only wait for DIM_NEVENTS events before they
> call dim_calc_stats(), with no time limit, so on an almost idle
> interface a window can last that long. With epms == 0, cpe_ratio is
> set to 0, net_dim_stats_compare() returns DIM_STATS_BETTER instead of
> DIM_STATS_SAME when bpms and ppms did not change significantly, and
> rdma_dim_stats_compare() compares a cpe_ratio of 0. The algorithm can
> then step to another moderation profile based on a wrong rate.
> 
> Compute epms with DIV_ROUND_UP_ULL() as well. The result does not
> change on 64-bit, or on 32-bit for windows shorter than 4294903297 us.
> 
> The issue was found by the Sashiko AI review of the original patch
> (see the Closes: link). The fix and the test were written with an LLM
> assistant. The dim KUnit suite computed the expected epms with the same
> DIV_ROUND_UP() expression as dim_calc_stats(), so it could not catch
> this; it now uses explicit expected values and gains two cases with
> delta_us of 4294903297 and U32_MAX. Without the fix both new cases fail
> on UML i386 and on qemu i386 (epms 0, expected 1) and pass on UML and
> qemu x86_64; with the fix all 10 dim cases pass on all four.
> 
> Fixes: 0843b2389064 ("lib/dim: fix 32-bit overflow in dim_calc_stats() rates")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260927051743.71460-1-jain.sm@gmail.com
> Assisted-by: LLM
> Signed-off-by: Shashank Mohan Jain <jain.sm@gmail.com>
Sashiko pointed to yet another 32bit overflow, and I prefer
avoiding a stream of incremental fixes, especially this late
in the cycle.

Please address even the latter, and prepare a net-next series,
moving the kunit test to a separate patch.

Thanks,

Paolo

