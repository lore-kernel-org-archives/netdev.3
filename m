Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889544E06F4
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 14:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790951774; cv=none; b=U9Lklno/j9CzSbSsf6EWbpgCAtbOHQ2h0xnAHkgGD5Ro7VT0QpuLQ9Pln8ZDGbrYgmDPhz6UIDgnT7N9JPy0OT60rWCwsoBq0R1PrlWiGsqaQC82zPmVGdhUdmzrRc/jyFN8BSaxm7xNZGWfQgjcd2bjbTx9Mmh7jp1exMaqU4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790951774; c=relaxed/simple;
	bh=zQ91ICwZjqU5P6aGDiyYlfRLUyuW9YOMBnxwHcCrIWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IHfMJEMQB8ZQvjJ6f4+v3IYYoZnkTHyK91fbuZxpNp6aHOFVlhoZSeU40nJufJSoQKHCLxP879RGHoeMKmSvz+2RYC99wYJdROCQZvdc3jlYulo3rm2LIqxNAMaatJzVhOnKhdisZv4w7akyA23rIMcY2nu6vulvGcsir/JfgLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citymesh.com; spf=pass smtp.mailfrom=citymesh.com; dkim=pass (2048-bit key) header.d=citymesh.com header.i=@citymesh.com header.b=csMiBWrf; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citymesh.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=citymesh.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=citymesh.com header.i=@citymesh.com header.b="csMiBWrf"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e7bcb94d3so58854785e9.2
        for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 07:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citymesh.com; s=google; t=1790951770; x=1791556570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vRr2guhba+ML772UP06zlXanMDzKKDE9ikuGJMi6gS4=;
        b=csMiBWrfJny0At18LFc/FsnrAKIvY5f82ci08BhQOWdj2bZLahhcwP/ayVPkj3i0Xe
         iA+L9ZQjfnS+3AmhIAd9Ns+dOpzKO0Ea9/mPo/eMzo8iA3Oua/jJM3Dmr0B77aWQPny4
         absRgQqzM9wZZ/BztWu7ndeoKg8lRyD0Ap+ulKI8ZkqTaRZ+1xmXZh2rnia4pMM39XKJ
         9cHhDULWouL7lcPd1az60Y9kxW7Jqb/YuPChEElxKMB3uk9odGKqaMoGtpQAbWfxt7dP
         UI5mTMPPe7wUmSMuJa04Zr+Rivo98cIOezntsVGRjOFUxs2WdRGCUdZwhQmaC0Fvfpb1
         TRoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790951770; x=1791556570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vRr2guhba+ML772UP06zlXanMDzKKDE9ikuGJMi6gS4=;
        b=0fndIeEVxBkdi7ADsHwDrIB050x3zlVn0VvQqMweWVEbQ18wNu9MmAUdo4Qn4eW8f3
         bRGMkd0sJO2SfYaN0Lz98iUaybgdC5f7NQ1fnERrS4z5qJ6+xN1tBJ7mNeF1RFwqVdGz
         tyl4+HtDaSHkqU4DJoYtcqO7Dmsa8/mxmDmV2hwF3JQq2Vtg873bWrT+VpRRDo49nUaG
         ygiEz87WDFGVWr+epUFKgWvEpeD4xde+gKufDy3UC+UG+RmIu/7GAC4PLwUQJIiO9rTO
         cCnSoUi6hX+9xobsFHPkDkHd53v13wkBoWgH3nX58xh/7XMkejp3/FEykVjWXWuFicex
         segA==
X-Gm-Message-State: AFuF++nbXy0GHsz2Kxp/gZVCx511xOYpvBTj9k7Rq7AwfZETXt4R97Cq
	v/hHk6rbuiYSSmP6vPwafFarfdivAO4N+jWauh44xU0BX42CXxDxjy5P/EBA1RN2S/x/QK0G1c2
	bKw5H5Sc1hA==
X-Gm-Gg: AYBFou0WhqyS86p1adCHqiQFYZW/5oFQk6qDUl8E0Gdnsj39gYiB6lw6pvA15xOIvJq
	IsWBl3qMxVaH33gT202sza7ev3jD2goNwKxMO5VcvqvXiWQfN54lmV89GfmRcfc9zTDEN06KL6r
	Q7yshSQDS2VWAVlFpZodIFkiF+GG6f6tMJelJX0WQ379WiNXtlTYbvWOjx1ZQNv29zwFUQQemxm
	GsTZXgcf4k9pWUnftTqvxczG/WHJrojQy6Z2HiFyXOoP1fGrGqGWQIYaW7aXnH2XIRycSEDXF/K
	sAOKWNSQHG6RflzzgLHmS+7soN/CjXsns+e41TxoseKH8sWAJ0YttQ5qFabNR7nOQmwmhEIFpek
	x4x99sebSXnmZibA/rJXcjehD1WMClbjzvjmdZjtf1Kb7BkVp8L7oybRWkma5Fw1hn1OtD6ypdU
	yf8lZFIolx/tuGtHr2xW8xVON5fbEiTQq4hRYnTvhX9xrmSD1nDpwU1acEeGcSlgLuok0=
X-Received: by 2002:a05:600c:1911:b0:49c:ffab:551f with SMTP id 5b1f17b1804b1-4a0275657a1mr50439615e9.22.1790951770536;
        Fri, 02 Oct 2026 07:36:10 -0700 (PDT)
Received: from koen-nuc11.. ([2a09:bac0:1000:2ef::4e:6c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e49f67cbfesm8715315ad.28.2026.10.02.07.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 07:36:09 -0700 (PDT)
From: Koen Vandeputte <koen.vandeputte@citymesh.com>
To: netdev@vger.kernel.org
Cc: quic_subashab@quicinc.com,
	quic_stranche@quicinc.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dnlplm@gmail.com,
	linux-kernel@vger.kernel.org,
	Koen Vandeputte <koen.vandeputte@citymesh.com>
Subject: [PATCH net-next 4/4] net: rmnet: optimize rx handler by replacing skb_linearize with pskb_may_pull
Date: Fri,  2 Oct 2026 16:35:29 +0200
Message-ID: <20261002143529.3217189-5-koen.vandeputte@citymesh.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002143529.3217189-1-koen.vandeputte@citymesh.com>
References: <20261002143529.3217189-1-koen.vandeputte@citymesh.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rmnet RX handler currently calls skb_linearize() unconditionally
on every incoming packet.

When receiving large, hardware-aggregated frames
(e.g., 16KB or 32KB from USB modems via qmi_wwan),
this forces the network stack to allocate a massive
contiguous buffer and memcpy the entire scattered payload
out of paged memory.

This severe performance bottleneck is completely unnecessary
because the RX handler only needs to inspect the initial
4-byte MAP header to determine the logical endpoint
and route the packet.

Replace skb_linearize() with pskb_may_pull().
This targeted check ensures the MAP header is safely accessible
in the linear data area while allowing the bulky payload to
remain untouched in paged memory fragments.
This preserves the zero-copy architecture for aggregated frames,
drastically reducing CPU overhead, cache thrashing,
and memory allocations on the RX hotpath.

On a slower embedded board, this improves throughput by ~10%.

Signed-off-by: Koen Vandeputte <koen.vandeputte@citymesh.com>
---
 drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c
index 95c3e3934fd3..a2379df69a6d 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c
@@ -217,7 +217,7 @@ rx_handler_result_t rmnet_rx_handler(struct sk_buff **pskb)
 	if (!skb)
 		goto done;
 
-	if (skb_linearize(skb)) {
+	if (!pskb_may_pull(skb, sizeof(struct rmnet_map_header))) {
 		kfree_skb(skb);
 		goto done;
 	}
-- 
2.43.0

