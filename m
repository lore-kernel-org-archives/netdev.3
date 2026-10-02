Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C774D9550
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 14:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790951765; cv=none; b=PulEgiw4kVsvCPV8OOSevwLcTX5efcwd4VGkyTXUOB850gxAwW2fMWy21ditcloWpUAQEwGKqxcaCWlACqdautlDrowNE68E3az/qupBghUP5UQbVn48kG99jQfSBkiiVZb45uzNdK2vPiwQl9VDRoV3bceD4P9S6f/Ywtg1Je0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790951765; c=relaxed/simple;
	bh=BCGicS7Y6bDVCOIyWVuqM71qCFRkkaCxCz33ZwbKG3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J4ZwSVuIIeDZSYKNMbJULqsuOAYFArlbBhcNRR7Ppf2A1xbVJT5yzKZWNLTjs2bTM4VVKDCRhVVfieaWp8yP347FYyZxS+eFx+I04LBU9wk0pXLG2oUIqcGrf4GCcaUh3URGQAOvKxb28/UaZeZ3d/ScQOgcFjbbt4PxD/MAYzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citymesh.com; spf=pass smtp.mailfrom=citymesh.com; dkim=pass (2048-bit key) header.d=citymesh.com header.i=@citymesh.com header.b=NiuC9VWt; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citymesh.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=citymesh.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=citymesh.com header.i=@citymesh.com header.b="NiuC9VWt"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49fff72474fso782945e9.3
        for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 07:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citymesh.com; s=google; t=1790951762; x=1791556562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=veTkOzmo6163gdZSR/5amkh40A+qHj9V4VaoR7YYeV8=;
        b=NiuC9VWt5xHXMXqzn9CY9HVJW9IPUVLAY5WMt0v4yw3ZNrFmW53HTmIftq5LE0OE/v
         Ggpo6zN08OeMUtxBBT0S4uUy0ChsmN0gdf7kQnQlOcRF+NmhbkNAqJSjKm+SqFtxA4Lp
         hvuXO5RSCzjh/ho0+N57SBIcY9F7lvyoSyIHpDAY9kzxgMiv27oTEh1bmeDDR+7Y9slA
         edxUYMc/gHnOqgQoa4P1VMYXsBarVD2vLMYOgm4ZkSBTfN9UpGhDObGJdmeGTZK5VOxJ
         B4ySDK69dO+u3DL4xqJd861LZWu39i0hxk0cauTPcTvDEHGUDIB2tYAp87MbuhRcY0+a
         pPlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790951762; x=1791556562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=veTkOzmo6163gdZSR/5amkh40A+qHj9V4VaoR7YYeV8=;
        b=YEX309p8P7ShYDlDEEN9+XK92NiIHIW6DLA+lSrealJyNT3KVTCVKQq+4asGpGUPH5
         laQlVZ4Jz2k/MDP5E26Ouxh7cjSrILeSbnBW1jseeuEqlYL4e+LvdpFhBY+ZD2ckkCMz
         zUDtggGnIwDSnjMeiUWbByxvaH2Hm62Enai1RMOS+2rGvgjk/z3EWhhUH/Snr3GVTxpR
         GFdR06hOieDwlVaQmLkIJiXT2Uzq5BvyosQQXLYKG9Dg2Z/ueAeSdlBR5c2xY2TDnOIX
         xhaTUqoGGXE/XYa6uARwO4JX0uDnplurwD/fCOhrPeG9P/Q3Dj6nuejMDZ8nZPdKjyJB
         LF1w==
X-Gm-Message-State: AFuF++nAPaV86J/p20IOCiT+4ZN3BQIIdM6GG8GHlem9X3Yt99NNLrMR
	u7VPyMC6mGW0k4U6fAThEfrW5y+ZTV7pbXi3t/JXelooTZyEteeY7aaf60zDzomghnrbUpmjDlN
	JsdQ99Fhrog==
X-Gm-Gg: AYBFou2E0R0PSGGAAG4WiVJUmbMFSGUb/A27meTjDN5F+w8eBdnPhJJu+twPcXAuYTm
	hYy69dnUvd8SsrZ1Hft46T8wjphySB0IzahR+4xLnl0E14o84fQix2uH5Z+QZaeNe6ETBqUTHRh
	DWmBa1v7ZW8p2xVpnuoNhcm113jkmXe30n9g1I6KNoNMbRPlPtuEOX/k9SOaxiGc3k3SL78idNt
	PN8cRkdSybGGtlCeO1/TErYxvT0211J8YkdNm0jxJYEzbcruyoCpNZ1/tG0dO1RXG5wHhNt/ZhC
	lQIKWMoBtPqZppoNZpktDi1jL6gb2edXO9nvZIrH1ii7BVARgVuo+WrKM833qgIwyKycqT1Z1eE
	/v5ru85GMbhyWZgFBjGdHp889qnj83zymovMiIe4jqjCE+HbivRfZoecuPdU124JvpcPdwFIuQR
	5xzxWFvdCDnaO1tMPt6OF591vb6yo4HndRH6L9hnaNFi7nGPboLTM9g8ChFOGu2xtQCgg=
X-Received: by 2002:a05:600c:1387:b0:49f:ffd0:9a9a with SMTP id 5b1f17b1804b1-4a02769cc07mr51779325e9.25.1790951762007;
        Fri, 02 Oct 2026 07:36:02 -0700 (PDT)
Received: from koen-nuc11.. ([2a09:bac0:1000:2ef::4e:6c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e49f67cbfesm8715315ad.28.2026.10.02.07.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 07:36:01 -0700 (PDT)
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
Subject: [PATCH net-next 2/4] net: rmnet: optimize rx deaggregation memory allocation
Date: Fri,  2 Oct 2026 16:35:27 +0200
Message-ID: <20261002143529.3217189-3-koen.vandeputte@citymesh.com>
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

Currently, rmnet_map_deaggregate() uses alloc_skb() with GFP_ATOMIC to
allocate new socket buffers for individual packets extracted from an
aggregated frame. Under high-speed receive workloads, such as processing
large 16KB frames from a USB modem, repeatedly hitting the generic
kernel slab allocator introduces unnecessary lock contention and high
CPU overhead.

Replace alloc_skb() with netdev_alloc_skb() on the deaggregation path.
netdev_alloc_skb() is specifically designed for the network receive hot
path, utilizing a fast, lockless per-CPU NAPI cache. Furthermore, it
automatically provisions standard network padding (NET_SKB_PAD), ensuring
that the newly extracted IP headers are optimally cache-aligned for
efficient processing by the upper networking stack.

This change significantly reduces memory allocation overhead, prevents
slab allocator contention, and improves overall throughput when receiving
large bursts of aggregated traffic.

Signed-off-by: Koen Vandeputte <koen.vandeputte@citymesh.com>
---
 drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
index 2eafb1d969c1..ccdfde3711db 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
@@ -390,7 +390,7 @@ struct sk_buff *rmnet_map_deaggregate(struct sk_buff *skb,
 	if (!packet_len)
 		return NULL;
 
-	skbn = alloc_skb(packet_len + RMNET_MAP_DEAGGR_SPACING, GFP_ATOMIC);
+	skbn = netdev_alloc_skb(skb->dev, packet_len + RMNET_MAP_DEAGGR_SPACING);
 	if (!skbn)
 		return NULL;
 
-- 
2.43.0

