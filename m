Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3789A373BFE
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 08:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791794072; cv=none; b=G4eHIDJkueqjoMso1gSWKouEUXS7IbClbWDqEQNJLJUqoKcpVay8ZgA99E7ER1eleaLxL+XJG6dQO85uesC+YXkxUfarpyTkljEXURbjeh4muMHFB0IJVHGnCJokdSpzBUs5O5uT+pzISyALgq/h/4yFzPNdRP/NhXcjBFWUCH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791794072; c=relaxed/simple;
	bh=x/pVy5iv6pkKCODTQWrEjvHqaXtp8U2mXH9axWGSQwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fJukD7W3F/3kLe0IEyrlLH0WKFVaq9ef90N+nhJhRwQ0kraCjhy3Ht+mrSro/NHbp+gXqWHv2B1MQV/GNJuGqnk2yZZGA2iVTFj9Ulqo5qRsxG5mQNk6kR71tBxnKMpkBCVIgW+jH0fg3oLb9OGSBmDv87pc9ERacykXCXYx42E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iFCDtOGw; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFCDtOGw"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cd3310348d2so1574320a12.1
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 01:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791794070; x=1792398870; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lpzhDm950D3WodhvZMeQKGiGTZ9bQ7TVv/mvg3cXh7I=;
        b=iFCDtOGws3lYLKaLyvsbIWA8RR13VVTIEMa23CHoRZBgGeAT6zk4wl6UzXPQvd5G3N
         e/uL+78+t4O2LkCxkEjL004abZbYmtbQ3bUBlZMKgW+oLhEq1dNdxY0/oJS1X4do7BhC
         GqI67eNessWDOdG5Y6O/gjca9MLxMnWRx9bjRI5Gc0WED2q0ymVqZJbe1Ri+GFUrnPKr
         UBqR9szpxUXQ5CwXTkhXCcyyMIQ4lydzgxp225MyDRTFn+zOGmPfQKuDNCPY7IvUShqH
         4BxW36+hNlpux+C77TFq42Poy+9Z/sKPU3gC2vz7LddgXRhBd2qk11RLghGaPIwUcG9+
         znqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791794070; x=1792398870;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lpzhDm950D3WodhvZMeQKGiGTZ9bQ7TVv/mvg3cXh7I=;
        b=FvWXGKjGFpqc580K0F/L7Fdn+wQx1/rbX71VbPl4AhED56WZsNjuMjp2EJApcptvIh
         XoZQzxMF7dKcoU6EKLGtvmTPlBcBxlU4WFZRSgM2n5p6GDrfSzXn0h/AdhwoVHYcfsAd
         8nBTJZ6C63rFu1HoPPjcHboJKsfwBYMyjijIjIGBin41pI4cvET/q32Mp9kFUSshO0rP
         MdDydGJI/ys9Ykide/qtf2wc3s3vZGdxnWSNGJL/TV7LxrKcX4RyvkIRwEy6BTt72hAJ
         L1oVHFRUuVCBbU/D8FmmolHhZePV8kqjXKlF1jcx40uVrM3L5QHckaqAVXqOO/jAF9Yq
         3CZA==
X-Forwarded-Encrypted: i=1; AKwUvBxD+de/ZPAiM/y22zbO+VB6JER0xqb6tus77AdH+wSs3KEn+6LuG7Lu+w48CR+DgH9h8cNwTtQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYLUyGVidMfUDJv9SfDunxmSS9f4uGFDe+uIDcXeBeX5x9OEpoJG
	O8A2Kvfdp/EKM9a0ameXuLLjsSFZ4UwV5YXoje+nAsvXvwhf0s3TdYFI
X-Gm-Gg: AYBFou0tiytovGPXrUELybmahia8gu49qWfa/VvKJTB1eQkBGAhh72/Mf062qCiiA7g
	06LpIgNWhDwHVR69U0LphtsqKHFaBu6q3PM3PvWj/NRDTitctFWXbrq8yokZKcUCodVlfHIoZQF
	Bz3xORVe2iZPhxrg5DUN+Y1IIxqAT2xIaHjS7G4zL2GNfp+lEyiQa5XkHIT017VMlOfQEvpqqq8
	BIjYw7jHv5d/Ieg4Xz4n4cC5K1NJPB9mFHF+myIOkFeWuRS6w7bdf+CaY57IoE/vTORlYNK0J6w
	wAKsCQkfg1lNk7EgY9HT12QE9g6tpqUxdzaU0401S/43QIlk+GOaIW6JCEj7/ys2auNwgXpubH9
	Lo0cBlaFKpTxRbmMkei6zqhkcKZMPn3WT4lkVttOA9Sxf6LoZz4tx505MheSMO/ZBDAIVGAuf6k
	KB/WNHomKcHmNtDDqYJV9u+X3tXV2n8VqzFI0GJMTTINNGveVHK4X2ybbkZB5LnnHj7MhroakbR
	9v54owH74lSx/OsTZiLA3cbUDsgtRdH9AT2
X-Received: by 2002:a17:90b:43:b0:3ab:330d:6e47 with SMTP id 98e67ed59e1d1-3ab3a9528fbmr5159947a91.10.1791794070567;
        Mon, 12 Oct 2026 01:34:30 -0700 (PDT)
Received: from ?IPV6:2620:10d:c085:21e8::1189? ([2620:10d:c090:400::5:b3cd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab38f4863esm18191720a91.11.2026.10.12.01.34.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2026 01:34:27 -0700 (PDT)
Message-ID: <d6fe0569-ecf2-4c63-b507-b70f7c7cdb0e@gmail.com>
Date: Mon, 12 Oct 2026 01:34:25 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 5/5] eth: fbnic: bound the XDP Tx completion head
 to the ring
To: Yehyeong Lee <yhlee@isslab.korea.ac.kr>,
 Alexander Duyck <alexanderduyck@fb.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org
Cc: kernel-team@meta.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 davem@davemloft.net, Eric Dumazet <edumazet@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Dimitri Daskalakis <daskald@meta.com>,
 Bobby Eshleman <bobbyeshleman@meta.com>,
 Daniel Zahka <daniel.zahka@gmail.com>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1791775409.git.yhlee@isslab.korea.ac.kr>
 <99790c3eceac9ac0bc9afbd90e8adb9789a08c50.1791775409.git.yhlee@isslab.korea.ac.kr>
Content-Language: en-US
From: Mohsin Bashir <mohsin.bashr@gmail.com>
In-Reply-To: <99790c3eceac9ac0bc9afbd90e8adb9789a08c50.1791775409.git.yhlee@isslab.korea.ac.kr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/11/26 9:16 PM, Yehyeong Lee wrote:
> fbnic_clean_twq1() walks tx_buf[] from ring->head to the head the device
> reports in the Tx completion (FBNIC_TCD_TYPE0_HEAD1_MASK, a 16-bit
> field). head is masked to the ring, the device head is not, so a head
> outside the 1024-entry ring is never reached and the loop does not
> terminate; it keeps releasing the same buffers to the page pool. A head
> that is inside the ring but past the posted tail walks over descriptors
> from an earlier wrap and releases their pages a second time.
> 
> Return without cleaning if the device head is outside the ring or outside
> the posted window, the way fbnic_clean_bdq() already guards its head.
> fbnic_clean_twq0() masks the head difference to the ring and is finite;
> twq1 did not, which this brings in line. A head equal to the tail is
> accepted, as fbnic_nv_flush() passes the tail to drain the whole ring.
> 
>    Oops: general protection fault, probably for non-canonical address
>    0xfbd59c000000002b: 0000 [#1] SMP KASAN NOPTI
>    KASAN: maybe wild-memory-access in range
>    [0xdead000000000158-0xdead00000000015f]
>    RIP: 0010:page_pool_return_netmem+0x2a/0x3f0
>    Call Trace:
>     <TASK>
>     fbnic_clean_twq1.isra.0+0x20c/0x410 [fbnic]
> 
> The loop was exercised by passing a crafted completion head to
> fbnic_clean_twq1() under KASAN; no hardware is involved. On a kernel
> without soft-lockup detection the repeated release trips a page_pool
> use-after-free before the loop is otherwise noticed.
> 
> Fixes: cf4facfb132a ("eth: fbnic: Add support for XDP queues")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
> ---
>   drivers/net/ethernet/meta/fbnic/fbnic_txrx.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
> index 7a9bd91bcc41c..3a148eb4e560f 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
> @@ -661,6 +661,12 @@ static void fbnic_clean_twq1(struct fbnic_napi_vector *nv, bool pp_allow_direct,
>   	u64 total_bytes = 0, total_packets = 0;
>   	unsigned int head = ring->head;
>   
> +	/* bound the device head to the ring; see fbnic_clean_twq0() */
> +	if (unlikely(hw_head > ring->size_mask ||
> +		     ((hw_head - head) & ring->size_mask) >
> +		     fbnic_desc_used(ring)))
> +		return;
> +
>   	while (hw_head != head) {
>   		struct page *page;
>   		u64 twd;

The device can only consume descriptors up to the tail published by the 
driver. A completion head outside the ring violates that contract which 
can be hardening but not a bug fix. IMHO such a defensive hardening may 
not be a good idea.
