Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA7350255E
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 22:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791583446; cv=none; b=sDbrAbmLPqP6fKA1WQHaw6/HY9cw6L7b3MKbfK8sszII6RagYkU5XcSYOyAfZd2kLapIbdr3YsOG2uir1G23ykNJZr5z5TStxK5nWp5awCjaZbyPuQZfdKV10ptKfZt97CoCe1+Y9nAjtdYv2giHFvRs2UjanQDLG+0LSWtLyXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791583446; c=relaxed/simple;
	bh=tHszEtQ6qUPfNkfp/Y3nptpIWt+shu7FTTyhBIFxA3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bYQwW3jyd/KqPL2dLesXKzLQrtVetJcFUPMjzs54sPhUs2d2A+D/ORP+m9XumhKJSDpooQSo8SPbabfe0s3lzgIjRBNpJ0pM4fsq38LsOjDQND91LgGxbA5r3gq3XTRpyYJXpd7mAEQQYlHFpMgsk2ROuLlsytHshm/edqfxdbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=alAeGzM1; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="alAeGzM1"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-35829219da8so114392eec.0
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 15:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791583444; x=1792188244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Oz+mubEJi9OTuwRjam7n0ruAb9lpR9EULifx4BafNbY=;
        b=alAeGzM1hy9XS6SGy9x2/oep749Ae41M7wq6Lk+uWiQgKsya8pBLPrS12odbI3Ks86
         +db/4pZkxitmn7UaQ0uspROUA5HeBtax74QqwDube7H7G7KDFt2nYlkN+24IfMj2pGsn
         5vtMmvmyRctLxT6V9+JALs5OuQujUKu6pZ37SdrDF2WReFe7poYAPfa+/CW2zyWL1RD5
         I2RoRPoCIWiFZxRxA+sB4a3nNGJpYY610WdEFPi8Gj8PldTRnGttH9t9s8G7YWhFztgE
         d3sTbKrpiHa+chc51+hKzmq8wKwqLifZMkYKY6ZN7ahBSFfaJZZ/qHLfj2WFDa9BDfzF
         sM4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791583444; x=1792188244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Oz+mubEJi9OTuwRjam7n0ruAb9lpR9EULifx4BafNbY=;
        b=I79/bBDJWHidxvX+OYFGHp4yJlrI4bpj1CX2wUSzRQroqy/37LB1qpepqZbN34gRS4
         nbpf0UusSmrLn5k2u3dTiKvDY9YTCXswBgjK+RmpjmXzEUw0u4XlvLOTfW8P0prQnS+j
         lE18m/7LFwTbniOBmjF53YY1BKXjbocn1lRr7zmVgQkbI9a5PUxsODvg6dH4O9GyJGXy
         3waXCXI2Ix+lzMnzwRNQe46TEQVZqeRH6uQBZDGHmsodiHnY4B8Y8Gd9W0S0VeTLFPeW
         bWWrGztgEP+W+Nf6ssPNFNye2k/VneXJufpj8LMu2C7JJYYgsfHv2PnxkkmtEAgTzF4v
         ULfA==
X-Forwarded-Encrypted: i=1; AKwUvBwbWCU0TC8gxYMm6GZHmnRHBkYlQgC/aNdjJZ8pyXNfNQL5pAVHRDryMOjnehFKdMcrGEeLHEQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJvo4ZbI1MiCvd0PYK9LIRjk1k5QAoj1pcncPWp1PFCrL8KL+Hf
	0AB7sf3M0UVYlUNCyfc/KNMMJJmiuarOar9mAHHrdWFdvy+yky8E8RJs
X-Gm-Gg: AYBFou2Z9G+1JE6yE+tqbhcpSksbLzwIQgXI/46bi6cOiJ2FBIlJzvurHn4O0kIM2Z9
	jiHyDPayMf+MQQHgOOgUZfnJzB8cZCtwrnaJK1J8xzYPG31AUbRcAsfKiSKt98toAis7bpNt52l
	XHU8ofQJh9VDMcETbFjlKcaeH2hUf8neQp0E7ZB16JD6BAA608tHW7SNq+936EPqEwKOszrScE4
	zV1ifmr9WsY0Qc/QBRHNRfc6ydcPI+siJcV/kAfEL+IENR+7RgTRr/L9WUgO/lac1Gyxb1VUx84
	q9zNEjqkFs1b7w4CFdUQlzPSVwfxL42KGWePPONT7uqlaXLh2g+lavBed4c9lKJDgted+e8f3OA
	yaZ8ipj1Gxz7x/XrKWSEnGVIUoNs+a6TsdSetWveHVdsVzYUFHvFQAganhBSJODmfaZZFNUSLoU
	o6NdeBUoDHgMa7R4WEn4MCxe/MJh/bMtDz2qC4eqlYkQRk7wJUJK/6QkunMLGATCkSKbsyJ4CgC
	l5FSfD5GUvRIr0VW9jmu4X/Czyr+kp7zwalaKjWt3A=
X-Received: by 2002:a05:693c:821a:b0:357:ee3a:267a with SMTP id 5a478bee46e88-357ee3a2dd9mr962923eec.2.1791583443330;
        Fri, 09 Oct 2026 15:04:03 -0700 (PDT)
Received: from DESKTOP-1E7V4GR.lan ([190.177.131.57])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb2fd33sm8279558eec.28.2026.10.09.15.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 15:04:02 -0700 (PDT)
From: Cristian Papa <pcristian292@gmail.com>
To: benjamin.larsson@genexis.eu
Cc: Landen.Chao@mediatek.com,
	andrew@lunn.ch,
	angelogioacchino.delregno@collabora.com,
	arinc.unal@arinc9.com,
	chester.a.unal@arinc9.com,
	cjd@cjdns.fr,
	conor+dt@kernel.org,
	daniel@makrotopia.org,
	davem@davemloft.net,
	devicetree@vger.kernel.org,
	dqfext@gmail.com,
	edumazet@google.com,
	krzk+dt@kernel.org,
	kuba@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux@armlinux.org.uk,
	matthias.bgg@gmail.com,
	naseefkm@gmail.com,
	netdev@vger.kernel.org,
	olteanv@gmail.com,
	pabeni@redhat.com,
	robh@kernel.org,
	sean.wang@mediatek.com
Subject: Re: [PATCH v2 net-next 7/7] net: dsa: mediatek: support EN751221 switch
Date: Fri,  9 Oct 2026 19:03:48 -0300
Message-ID: <20261009220348.4531-1-pcristian292@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <4310cd4d-d9e5-4bc4-bdee-7f6f6b3a2409@genexis.eu>
References: <4310cd4d-d9e5-4bc4-bdee-7f6f6b3a2409@genexis.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 20 Sep 2026 12:33:21 +0200, Benjamin Larsson wrote:
> Thus I suggest that dts property also is added and that the calibration
> is performed if that property is not present.
>
> The original SDK and production units seem to have a fixed setting and
> user testing also indicate that a fixed value results in a working
> trgmii link.

Some of that user testing may be mine (fixed RX taps on an XR500v in
Matheus Sampaio Queiroga's airoha tree, airoha/kernel PR #54 on his
Gitea, https://sirherobrine23.com.br/airoha/kernel/pulls/54 - viewing
it needs a login there), so here are the numbers behind it. One unit:
TP-Link Archer XR500v v1 (EN7526G, on-die switch plus MCM), running
that tree's driver on Linux 6.18, not v2.

That driver uses the same PLL frequency (362.5 MHz) and TX drive values
as v2, but the rest of the sequence differs. v2 sets the MCM TX delay
to 0 (it reads 8 here), writes RCK_RTT and 0x7a14 on the on-die side
and disables SSC on the MCM; that driver does none of that and instead
writes the full vendor MTRAP word (0x01017e8f, between TOP_SIG_CTRL 0
and 1) on both switches, where v2 only changes individual MTRAP bits,
and the vendor CKGCR value (0x30f0 = 0x1e02) on the MCM, which v2 does
not touch. So the taps may shift with v2.

With the 0x55 pattern, sweeping RD_TAP from 1, all five lanes pass up
to tap 37-45 for SoC->MCM and up to tap 16-18 for MCM->SoC (one boot).
The eye with real traffic is much narrower. With all lanes on the same
tap, iperf3 through the cascade and the RX CRC counter of the receiving
port (same result on two boots):

  SoC->MCM (MCM port 6):    clean up to tap 24, nearly dead at 28
                            (1-6 Mbit/s with CRC errors), dead from 32
  MCM->SoC (on-die port 5): clean up to tap 10, CRC errors at 12,
                            unusable from 14 to 64, and a second
                            narrow eye around 72

Tap 1, the lowest I tried, was clean in both directions, so the lower
edge of the eye never showed up. The midpoints of the 0x55 windows
(19-23 and 8-9 here) are only 1-5 and 1-2 taps below the last clean
tap measured.

That driver uses RX tap 4 in both directions (for SoC->MCM the 0x55
sweep still runs, as a check). With it, 12 boots (8 warm reboots and 4
power cycles of about 30 s) had 0 CRC errors on both cascade ports
after 6 s of iperf3 each way, 29k-101k frames per direction. One value
(4) works for both directions here, although the margin to the last
clean tap differs (about 20 taps vs 6).

Separately: an out-of-tree U-Boot port for this board (since fixed)
left the on-die switch's PHY auto-polling on (AP_EN in PPSC, 0x7018).
With it on, 8 of 240 TFTP boots trained no SoC->MCM lane until the
switch was re-probed, and a stress test found repeated tap writes
landing in the MCM's 0x7a04 (4 of 4 boots, 0 of 4 with AP_EN off).
Clearing AP_EN before registering the MDIO bus gave 120 of 120 boots
with all lanes trained. In v2 the on-die switch is set up (and reset)
before the MCM, which should clear it, but I have not tested that; it
may matter if v3 touches the MCM earlier.

Per-boot logs on request. Happy to test whichever approach v3 takes.

Thanks,
Cristian
