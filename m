Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793805572;
	b=Q/5R8hID+qdbc2QccqghksOP8Dwz1wkfDpQN8eIst4hnazyWrNvOr/1aDGn2882kQIuQ
	 n4st98yTyKY9lT44nY58XFJBntc71qi7vGeO4mus0zGLGqcf3VwC1nhadL/j702yVXtZn
	 kCKydzJaxrRnVmRhO42IR9my4wLs7Wd/yblU2RhoeCeBILHKd8q7yJst7IL1k9zvIf5Fa
	 ZBHcZuQ159zGDx2HpyO94fZs/zybC6CMDgBf+2i5CSJ7o0RVHukuqK9UUFcIIaQnkTHNm
	 MU4yMYe5UAquL+gN7shcYqPwNcr9tv/1nUDswmAXYcDB/KX8+0WaAUklK/bKZX1mjUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793805572;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nxrZJxHUg2O9j8zi4wkVtSZmuc/DWB6+tE9tT3nYX8c=;
	b=XWXy+mHK2foJ0AMO7Oej2+vaNUzQLCaRabx7TIyCtM7y7JRp9x8JX22Ie4DbDJraU75P
	 S5/frZaZviDpuINH3rSfBNWxuHjsFCXY3/yVKxdy+NRbkvYWj6zVybCe+99XH3GgJzTrt
	 ADfX+BC+O7YSfmkSyTBknQKRCUNNUIWJEsTsuaCfvrpA7naU+hSML7ViQepfgkiMH/Rj/
	 ghkde0NLA+dzoYHbMiLIXarCZgHiixWeR14GB1qA6bs6NkI2w3szaqIuSXNlKoC9y1oOc
	 5KdMXgINYxtIOVH7BxxQBNAljcp1Dj8rr9TRjBU1tf4pxVBuhyuYzgXm0CMtBu6/oAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=grische.xyz;
	spf=pass smtp.mailfrom=grische.xyz;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C0B606EEBD
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 15:19:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8C0B606EEBD
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grische.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grische.xyz
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a5087a5348so7036575e9.0
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 07:19:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793805570; x=1794410370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nxrZJxHUg2O9j8zi4wkVtSZmuc/DWB6+tE9tT3nYX8c=;
        b=XdvarR6OKNUUCVBveZ5MtXbBHskVhvrPQyB56nJ/SCcDYBuuqs8SErcbP7Y/Dk9coT
         6VjnSfEZwe/pobj6EHEIFsooiyZfzJ7+ccufTGnarXvQe4v8Nn3uquc3zJZnP1+qj5zO
         DflI2ywfR5/DKw1T6VZ3wGr+8c3Vk3wG8JMXtgQD6bGGoWj/3vtCJIjt5PIjNEx8RRqh
         hHEK+gFG07L0jQewEyIVM8sHDQkIDnFl+Yv9/rdhTBPyU3wa5T3pNZ/8MhLFXj+9GEsp
         +gExRqSZ4nQsJXBqaK7oZkQJJFbaURbePtJHy75nWr+L5tc8iO0lNzh/b4c2GUP/E1PX
         GJiQ==
X-Gm-Message-State: APuU4Z+j5li45Sl5At6vLFErA/9KpdcLq6EH/0s3LzYAuthDZbMIRhGV
	10Ltw4A7NGhkhGUh4n2FicrUwEVD9+SjX+vrE4N8yyyrBzy1xLg2QXStgoSdRqb1dwpcXCJ3qiF
	R4biaLlVmTwKG
X-Gm-Gg: AYBFou3VVxSfyXPHJzwHbMwi8FG/cg2G0qHPJVVKCPOtI01CSh2QrlHoofaDpCXfYW2
	1YUQUDO/MhA8e8vI2+hHKdjYf5/bqXBnkbEiEH05OcIeilXnO58AZ++qzA3ukGyBqpMpLyZ7Rbj
	eg5W8IbvZ78E9vhAwmZoyPRtvGYyGNgPfkUI0nhXBkaKTtbA/5P1RXmWJGR9mSUgk+nFgNK/4Lg
	ZIODG2MbYPaFJvNwgTVJAXth6Bwmcv8bR/iG8H0U7Q8AWhzH4GqZmBzgg5dfKyZw6sVFMtq72E2
	HpsdV4vzQPPC52RDX9QhINq9HlxCUUWECPlsynkXbrEyjWAukBhGX2A32TWR/5GkaFRfu5xXsX/
	OBxDst6fjqLFBYkPhFKx40kpGervCHIoFMh3M7SU7xPn2D9iwlz02yPicOexjyhrjypW6BkKjJi
	Ho1poP1+e96AjnyxccDCYDOctiVyyDIyfQ8+06xfWtKTp98oqUYHotJ65Hfd1xuwGT5uiSHvbwn
	eVZ7xHOq1IGOIRleSaFVqs8zWB7+nKnavYX8EsXYQ1bvG9+9sojMvvZzvbr5mvFRfHA4Dm/FY3b
	Bwh/7nzxUeS7eLUV1W0OOteHJA==
X-Received: by 2002:a05:600c:1f93:b0:4a1:de8a:603a with SMTP id 5b1f17b1804b1-4ac17ffb002mr392967005e9.6.1793805570362;
        Wed, 04 Nov 2026 07:19:30 -0800 (PST)
Received: from lake ([2a02:810d:d09:1b65:4366:70cb:bf82:f8ac])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fec8d8e29sm4639812f8f.19.2026.11.04.07.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 07:19:29 -0800 (PST)
From: Christian Schmidbauer <opensource@grische.xyz>
To: netdev@vger.kernel.org
Cc: maxime.chevallier@bootlin.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Christian Schmidbauer <opensource@grische.xyz>,
	stable@vger.kernel.org,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Aaro Koskinen <aaro.koskinen@nokia.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 2/3] net: stmmac: dwmac1000: don't discard frames with only a checksum error
Date: Wed,  4 Nov 2026 16:19:12 +0100
Message-ID: <20261104151914.2651241-3-opensource@grische.xyz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261104151914.2651241-1-opensource@grische.xyz>
References: <20261104151914.2651241-1-opensource@grische.xyz>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On dwmac1000 with enhanced descriptors, the hardware sets the Error
Summary (ES) bit of the Rx descriptor not only for L2 errors but also
for an L3/L4 checksum error. enh_desc_get_rx_status() returns
discard_frame whenever ES is set, and since commit 1b746ce8b397 ("net:
stmmac: don't overwrite discard_frame status") the checksum status is
only evaluated for good frames.

Return discard_frame only when ES comes with one of the L2 error bits.
A frame with only a checksum error is then reported as csum_none and
reaches the stack as CHECKSUM_NONE, so the stack verifies the checksum
itself. This matches dwmac4, whose Error Summary bit does not cover
checksum errors.

RDES0 bit 7 is not in the mask, because depending on the core and on
Rx checksum offload it reports a timestamp, an IP header checksum error
or a giant frame, and enh_desc_get_rx_status() cannot tell which. In
threshold Rx mode, a giant frame that fits one buffer therefore reaches
the stack with a verified FCS.

Also remove the pr_err that enh_desc_get_rx_status() prints when bit 7
is set. Once the MAC stops dropping checksum-error frames, any host on
the link can flood the kernel log by sending frames with a bad IPv4
header checksum.

This prepares for setting DMA_CONTROL_DT, which makes the MAC deliver
checksum-error frames instead of dropping them in its Rx FIFO.

Fixes: 1b746ce8b397 ("net: stmmac: don't overwrite discard_frame status")
Cc: <stable@vger.kernel.org> # 6.6.x: ee0aace5f844: net: stmmac: Correctly handle Rx checksum offload errors
Cc: <stable@vger.kernel.org> # 6.6.x
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Christian Schmidbauer <opensource@grische.xyz>
---
v2:
- Drop RDES0_LENGTH_ERROR from the mask of Error Summary bits. The
  length check further down already discards such a frame.
- Explain in the commit message why RDES0 bit 7 is not treated as an
  L2 error.
v1: https://lore.kernel.org/netdev/20261020190319.884375-1-opensource@grische.xyz/
 drivers/net/ethernet/stmicro/stmmac/enh_desc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/enh_desc.c b/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
index 7ece8d4157a8..d0622f2605aa 100644
--- a/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
@@ -216,9 +216,6 @@ static int enh_desc_get_rx_status(struct stmmac_extra_stats *x,
 		if (unlikely(rdes0 & RDES0_OVERFLOW_ERROR))
 			x->rx_gmac_overflow++;
 
-		if (unlikely(rdes0 & RDES0_IPC_CSUM_ERROR))
-			pr_err("\tIPC Csum Error/Giant frame\n");
-
 		if (unlikely(rdes0 & RDES0_COLLISION))
 			x->rx_collision++;
 		if (unlikely(rdes0 & RDES0_RECEIVE_WATCHDOG))
@@ -230,7 +227,10 @@ static int enh_desc_get_rx_status(struct stmmac_extra_stats *x,
 		if (unlikely(rdes0 & RDES0_CRC_ERROR)) {
 			x->rx_crc_errors++;
 		}
-		ret = discard_frame;
+		if (rdes0 & (RDES0_DESCRIPTOR_ERROR | RDES0_OVERFLOW_ERROR |
+			     RDES0_COLLISION | RDES0_RECEIVE_WATCHDOG |
+			     RDES0_MII_ERROR | RDES0_CRC_ERROR))
+			ret = discard_frame;
 	}
 
 	/* After a payload csum error, the ES bit is set.
-- 
2.54.0

