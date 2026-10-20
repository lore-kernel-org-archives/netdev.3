Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792523008;
	b=ubFdR3jmnwU4OynuvX5q4pn3Y9C5SPSnlEZbUgi9sbO53N9e9EPBJkKxpUUIEQg9YVfA
	 s3ISwVEe7z/v/lZF+VWaiDEsrK4Y4RYF+H6QbLuNeug4V8hJXMtFVdcmvern2tjNHrdSx
	 18J0b6uIE10AHx6nk3qYkLM6/8DPO0F31HJsO33BZ9gf1RvKgm6j8SwuOUfgWMiBFEk3x
	 eCBTvmlPZAKmoP2a/9bvFpwZ35Vz0T30MeaJw4ejA5wrMnOoqRXNdkQYWDRxDrC3136St
	 kItpC2b5nNgZTEwRWkhCky9Ig4R+utWQl5C0iJqpkfrqVDzGLKONinqJviKSAxsESsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792523008;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yDyp6R6XHxt49rPY0V1CwuTyDv1VXxyGmnKmgJVZ160=;
	b=Wm91CAJOw//b41xO+01bYIFSi6JlDgyLT9KANqBSnJUDQuRFBPJb/qIyi84utaaT5+ps
	 4lO4uw/1UCQrGhGP1b9qBefNJDTus3DP0XOMdSJ7LXSxoSPY7MrPb/WtYrzfzfWmc13dX
	 OVm+9g5jl6EMDppYc+x72/MubuxNgQufL1gqFkv2lRHTjObWif93kS78C2GHU+JSjWogt
	 5nny+iOldK2+/NxNKR5f3SO/NSLAvwa6XcmoqiIWIA2A4ozeRtbnxEvb5MEicpK0uB4Yv
	 1XNe8ULjNzxYTgxE4kuIRIFybB/6HBWHHwSO5r3q/yXg30rN8Xw1GKNyodJr+3gnw2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=grische.xyz;
	spf=pass smtp.mailfrom=grische.xyz;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D6E60A2606
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 19:03:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7D6E60A2606
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grische.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grische.xyz
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48dfc0421d9so2612910f8f.1
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 12:03:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792523006; x=1793127806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yDyp6R6XHxt49rPY0V1CwuTyDv1VXxyGmnKmgJVZ160=;
        b=y81YjsmRd636OBmKmEG/pyFumct6NRA/PZth51qfiXbwXbyMNxOmEXs35oGIxudUaz
         Np8eCVfYV/DNjVFXr184HtLW/jmcG/2Y+YVbJAOh59pBDrj49mIPd+wtReeaUXayRt7c
         WWXOc95DqMYK8Qu7GU9VHdK1NeT68jju2Z1hMM7MvBY+60SCLAAeJHw4JiTTLxP/4Wnw
         C1X3uTD/MqADZuo2ymfGCvy8UtGfpCfEvgi1r+8g98Eb4aNP5mjdQaRMsL5oDe5fbqML
         H+vj9mFiY8yvKt3fjXwmNUOiv/6rwU/+7UbMjg0pOIIcvqqUI3ZnH3/35zRWplzW6oZR
         OHBQ==
X-Gm-Message-State: AFq9FYLSgZjFu7rd8PRy9BlmXENTMZZVIXTshDxeyXkznyvvBcrcRDhu
	afbSqudrQBA3ZHGjap/qK/k3bgGGpN+5XT1h7NPUNSdmMcYrAVMIHsCffJs3HvvPKaWW8fRrAUJ
	otRItObMqwA==
X-Gm-Gg: AYBFou1gLL6gZ7l4HlOHnX02I9mD2k7d0QpDAOz47IWwz6YB7FymXkuo1cexT4NGELw
	iY8KmN+HrheWZJDi3Hma6OuV51LQCA1v1ZfELU1uWi35N/nJF7yxR0Lnma595xlq8TGB+aHS35T
	mNDst5xn1SKhuR8Gsi/byavulFmeO2Gb5JZeD7uh3Hg1Dh+aPXLmEc4E7958rviq/fUO/uiF7n6
	9/NDfeM504e6OytOjL9KcNGTBt2cheqlm3CLyGZ9CCrnC32kxWQGPRSUtD39nqcRxrjtE2XsO60
	tRLXR3o01vNCH2Roj9JSbhpA07dYBK0jQXBiBRtoYuzxAWsEhOiQ9NlF3iZ97SNrY5jzTP9IA+X
	tLegKpzSE0MRlPSff5G7t8k1gJiA5GV2DxT3ZJembjWZIJpGnIUNtVjGVMYYhP1tU0fVU28FYtj
	vp7YOtNt11jEHUMMFW8q5OGqr+KjdPwk2qgAVfFSHfOz3R6Z2eAPL0LPwhbN76OHts24U=
X-Received: by 2002:a05:6000:1865:b0:48d:f7ef:cd1d with SMTP id ffacd0b85a97d-48e07bb2cc8mr29021791f8f.9.1792523006337;
        Tue, 20 Oct 2026 12:03:26 -0700 (PDT)
Received: from lake ([2a02:810d:d09:1b65:a3ee:29e0:454d:c31e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e25828cbfsm279157f8f.23.2026.10.20.12.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 12:03:25 -0700 (PDT)
From: Grische <opensource@grische.xyz>
To: netdev@vger.kernel.org
Cc: maxime.chevallier@bootlin.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Grische <opensource@grische.xyz>,
	stable@vger.kernel.org,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Aaro Koskinen <aaro.koskinen@nokia.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 2/3] net: stmmac: dwmac1000: don't discard frames with only a checksum error
Date: Tue, 20 Oct 2026 21:03:17 +0200
Message-ID: <20261020190319.884375-3-opensource@grische.xyz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261020190319.884375-1-opensource@grische.xyz>
References: <20261020190319.884375-1-opensource@grische.xyz>
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

Return discard_frame only for L2 errors. A frame with only a checksum
error is then reported as csum_none and reaches the stack as
CHECKSUM_NONE, so the stack verifies the checksum itself. This matches
dwmac4, whose Error Summary check does not include the checksum bits.

Also drop the per-frame pr_err in enh_desc_get_rx_status(). Once the MAC
delivers checksum-error frames, it can be triggered from the wire.

This prepares for setting DMA_CONTROL_DT, which makes the MAC deliver
checksum-error frames instead of dropping them in its Rx FIFO.

Fixes: 1b746ce8b397 ("net: stmmac: don't overwrite discard_frame status")
Cc: <stable@vger.kernel.org> # 6.6.x: ee0aace5f844: net: stmmac: Correctly handle Rx checksum offload errors
Cc: <stable@vger.kernel.org> # 6.6.x
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Grische <opensource@grische.xyz>
---
 drivers/net/ethernet/stmicro/stmmac/enh_desc.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/enh_desc.c b/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
index 051253601225..5c43d32a2f22 100644
--- a/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
@@ -195,9 +195,6 @@ static int enh_desc_get_rx_status(struct stmmac_extra_stats *x,
 		if (unlikely(rdes0 & RDES0_OVERFLOW_ERROR))
 			x->rx_gmac_overflow++;
 
-		if (unlikely(rdes0 & RDES0_IPC_CSUM_ERROR))
-			pr_err("\tIPC Csum Error/Giant frame\n");
-
 		if (unlikely(rdes0 & RDES0_COLLISION))
 			x->rx_collision++;
 		if (unlikely(rdes0 & RDES0_RECEIVE_WATCHDOG))
@@ -209,7 +206,11 @@ static int enh_desc_get_rx_status(struct stmmac_extra_stats *x,
 		if (unlikely(rdes0 & RDES0_CRC_ERROR)) {
 			x->rx_crc_errors++;
 		}
-		ret = discard_frame;
+		if (rdes0 & (RDES0_DESCRIPTOR_ERROR | RDES0_OVERFLOW_ERROR |
+			     RDES0_COLLISION | RDES0_RECEIVE_WATCHDOG |
+			     RDES0_MII_ERROR | RDES0_CRC_ERROR |
+			     RDES0_LENGTH_ERROR))
+			ret = discard_frame;
 	}
 
 	/* After a payload csum error, the ES bit is set.
-- 
2.54.0

