Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794354330;
	b=alQaoooy7Odnw4ND3lJUPBPmWjSgEnOlQzp1Y97ezjrkkinMao/kc91f3QdKz5ZGxevT
	 B8kpxuqPeMRWaaRN21PgAIanq1M7bpmTRWzvibXidsYkXyS3/bFENhfORGVlRCT0R+Nu5
	 6dLUu+BNxVNafrCxzlfybeowYXBxBs1+Ea3o4U3oRb6q9kbDES/eqM1c0cz5aAxLqu/cd
	 tZLLwy4pKfAq9eVgahgXRhXoep5gMGIQJ0YrUlEYHl1fWrupBy8uA/Tv5au4WLB6aorxR
	 uam7rMVGYwZy5TMLhuVar8WN8z5bBthboZSWXJxms/f4H9YoOAvgYiIrMFfvi/Fm6KQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794354330;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8f/qN8yAC8+iTxgP9ikdx8LsPCCF4I+j0HVDju2YBDI=;
	b=rFDzm59jrv2xU/3Oc8E7Up4ftDy0Z/eUBDnuBbyVcLDJdMlIvFgfaHmUv/sWmbD7sMgs
	 AkSsJ8VyZ3ychrPj/BFkKHiN2DUKPUQtN6N3YqRCwwij8k4+iRATaeeAGiShpLpBiDq3T
	 T4MZm9ttcM2xVqFXoA5bntvDK0ZAPApvcOfYygl9tBP8RJd5SD5iN4RqGQrq3oj+PJGeq
	 METzLoMbYHHx1e3sINfw0t/3t53/x/yzqMATWDvHewyQ2+e1UlX46c8nrpyDOCQXR9IBG
	 mrShz5bLxAentrcbs+/EiOhZbJb/VdFPVw7s9Y/fyJE+r9RAUrgQjQT4eIXCjJfV8ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O50OpKyp;
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556B3606A333
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 23:45:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 556B3606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O50OpKyp
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1b3beeaf6f9so468983c88.0
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 15:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794354329; x=1794959129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8f/qN8yAC8+iTxgP9ikdx8LsPCCF4I+j0HVDju2YBDI=;
        b=O50OpKypaUE+KMuX+D1C242+pyYHwfxQt45uMVYwEQykjWryvEfKbRcEBROXG5HxQN
         SozfFFIgaiHRFPHJmrKL4SsJ1a3OeLNhvZ5yTzR56kaymuax4zPHuT+qseQ5QidzXV0G
         P5qlJn1UgG9aOci/JIXjZ3h/RhiaTOIuiSpqPD0sa2MJIa6jNsmwvGuWGhcht+7Xo2Eh
         e6k63THgVx6d+/KA6s0MP6d29RCEH22erbYrnx9oyRBqDy+KLNAFcdidqRbUw/XLllg6
         36H/ijpRtQAFAY+jZVncu/s2Jj4K8ymkfEUxZCNu6seD+hPbmr/FFaMecFPQRfk4Mq2M
         6FIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794354329; x=1794959129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8f/qN8yAC8+iTxgP9ikdx8LsPCCF4I+j0HVDju2YBDI=;
        b=EQpkGnyMNPJRryyLzAg5MKhsUE9F6XSDoqB0BiyWNzTj1c5+e9vr6HhhJjPSWaFKsN
         4uFY0V7xYv8WP2Vb+IrYWqDYtD88f/fcmrCgyHqWqjWrv3J10rASMM7gVACMM/voJTh6
         fD7DnNGzpZRpeDEL1KFYPKx5++sn3BbgOQNe6lR4OSHtnwLf6/5ChzUkxLSeIMLU+J/x
         WihDuZl4CrzMyRxepom7r08Nu0TYPOhC47FE0Gdm9LgQB77lNlP3bb0Sc9xvoeNxAurl
         Ek2e63PQnk/yjXk0i2lbMzhsRj/4Ml5rSTbu6jNXPpJyL2kZSeMqhGaFets5ifWnN2cD
         24Aw==
X-Gm-Message-State: APuU4Z9yjOOImdJ7fcfzlMu+Xr3FPwYYTJ0vhON4C22sqEgO6oCWgWLE
	gWEcydkmKVx39n7WKRmQ+3nusBa6+tvcKNctS1Awurx9C2M2OlGXc+jjpHKG/Q==
X-Gm-Gg: AYBFou05E+B7UyQOlHK/LRJPKoFcWFfx8BTlwt1nQxZlpZ0QFAqj2A0GZO5ukTjwJ8q
	MRSEDDQmvV67tu35oF4iPzzJIMYQOXNxkuWauNM0t8eG2bxMpepEjvE4QeDqBJ4hR0HOnbl248F
	7TeD0h5xGjWJzljcemoE4ODolbg2HrPp/Sy3KhFjGulzc2JBNr89dADbzX92qJI5U0EVihdB8hn
	66Z16V2+6M11FcxSv/gJndCP2rnqalwcDRjv/rPrY4qVirOp7dVqSg1oQ0apARUiuoXfa3oyk0n
	oNXhxTDtxcomqMsZRfgRJ2kmdBi7ndJk4TKZwCCr9cOwkOEyg6Z43POWtqEmKR9Y0HJ5yOFEwQI
	9jtBMYCwvyF3tFPM6nJJf6kMuhgKYU878NnzRuHSF3Xr4qfSd807GBw8uyKAi6Vq1p99fqOKMrS
	V53L9La3Oz05d5ePhyNNF6QUyU5Us8vEuLm0btz73+2bcct1X6RpTqFmsLvR9WyPGkND3/lxkX4
	txQAH2Ia+6uqZ4tQkXkJg8ovKfC9RgnTZJFnUq8FC+uxJ6EjPYKUbCERx4fWCpgvfuu65nfog9o
	gImDeNoJEOZXwOm0lUE3hBhOTDcoLdo=
X-Received: by 2002:a05:7022:5f05:b0:1b3:ac34:bd59 with SMTP id a92af1059eb24-1b3c036b32emr494459c88.45.1794354329146;
        Tue, 10 Nov 2026 15:45:29 -0800 (PST)
Received: from eldorado ([2600:8802:b00:1f88::287])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b20c55sm9145881c88.8.2026.11.10.15.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 15:45:28 -0800 (PST)
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Daniel Machon <daniel.machon@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v2 2/4] net: sb1250-mac: Advertise and honor RX checksum offload
Date: Tue, 10 Nov 2026 15:02:58 -0800
Message-ID: <20261110230300.2769327-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110230300.2769327-1-f.fainelli@gmail.com>
References: <20261110230300.2769327-1-f.fainelli@gmail.com>
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

The driver already trusts hardware RX checksum status on supported
chip revisions, but does not advertise NETIF_F_RXCSUM. Consequently,
ethtool does not report the offload or allow it to be disabled.

Advertise RX checksum offload in hw_features and enable it by default
when the existing hardware revision check reports support. Test the
active feature bit in the receive path before marking a packet as
CHECKSUM_UNNECESSARY, so disabling RX checksum offload restores software
verification. Hardware can continue computing checksums while their
results are ignored.

BCM1250 pass 1 does not support the offload and retains the existing
software checksum behavior.

Acked-by: Maciej W. Rozycki <macro@orcam.me.uk>
Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/broadcom/sb1250-mac.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/sb1250-mac.c b/drivers/net/ethernet/broadcom/sb1250-mac.c
index 1843b52e96f5..546415d3134c 100644
--- a/drivers/net/ethernet/broadcom/sb1250-mac.c
+++ b/drivers/net/ethernet/broadcom/sb1250-mac.c
@@ -1142,8 +1142,8 @@ static int sbdma_rx_process(struct sbmac_softc *sc, struct sbmacdma *d,
 				 * the kernel
 				 */
 				sb->protocol = eth_type_trans(sb,d->sbdma_eth->sbm_dev);
-				/* Check hw IPv4/TCP checksum if supported */
-				if (sc->rx_hw_checksum == ENABLE) {
+				/* Honor the RX checksum offload feature setting. */
+				if (dev->features & NETIF_F_RXCSUM) {
 					if (!((dsc->dscr_a) & M_DMA_ETHRX_BADIP4CS) &&
 					    !((dsc->dscr_a) & M_DMA_ETHRX_BADTCPCS)) {
 						sb->ip_summed = CHECKSUM_UNNECESSARY;
@@ -2214,6 +2214,10 @@ static int sbmac_init(struct platform_device *pldev, long long base)
 
 	/* This is needed for PASS2 for Rx H/W checksum feature */
 	sbmac_set_iphdr_offset(sc);
+	if (sc->rx_hw_checksum == ENABLE) {
+		dev->hw_features |= NETIF_F_RXCSUM;
+		dev->features |= NETIF_F_RXCSUM;
+	}
 
 	sc->mii_bus = mdiobus_alloc();
 	if (sc->mii_bus == NULL) {
-- 
2.53.0

