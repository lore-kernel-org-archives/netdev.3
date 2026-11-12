Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794505453;
	b=zRiCIuzbH+jplVgNFNK5uu09pykEeIVmlpe1F9UOSufjFfBZEMiGnYXmYGVmcPY4O8Ij
	 reDVzbrF0yOmEbkV+oL9JEGlhvHFfuox8SZ+4qYiTXNrQ2068ObBoJh4KLQ86LrBjB5T2
	 DT2H7O4xHOQv+/Q2VmBGkjM68zdcGrYN+NkVY6//A7tB6nNx/KxOXqcrOFxHllKOjxCnN
	 I3Z8x3V357SDpEB/mF6qPhfGn3sgEVV6WhkcOJNVqUudItQr3P3K2NtuXu/3vufyEWPg1
	 EFMqJR+ChoFQF1NnM67BPDp7meAeX9gTTr3oSnPBms44ko3vV2OX0PjE4/+zwY2hmZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794505453;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lrob9qv+VazU3d/PrmIK9skaKz2AB1VT250mGCPx/d0=;
	b=MpC3RRNfE7H0Oxi34+DtBuMBC8zAJluHc5bxmgh7qMk2FjrtPMdmtsW9FpmRCLvruIgd
	 +WhOs+CW4NOtr9lKSb5/JiRVGX83JvrK6IDSDvQDpjgd7FjFDNN6JjdSEAyql0yRBCjcH
	 GV62Yl7DAYX85HdGcUXVrG2AWy4j030Aa3x+ovg6vcv8tn7zpCYPa9O+Icrkp4Fw5wUEb
	 1MdPjt5cf2wUbCB3NOoQ4Zr/d9AT3W+zHBcasyAKb4rfrWBDx5mSLyV3LRbd0BcjupFbA
	 nW5zFIuKZZ4/lRTlOH3Ujy8mR9KEaVCyYjUZD4ebPq5G0F70kvroTNmAPGwkP9R6ZVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m+dulpYm;
	arc=none smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0249606A321
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 17:44:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0249606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m+dulpYm
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c4d2b741ed9so724916366b.2
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 09:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794505451; x=1795110251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lrob9qv+VazU3d/PrmIK9skaKz2AB1VT250mGCPx/d0=;
        b=m+dulpYmXdlynuPe1wdh9qEspo5Ziu2CO0ZeyexvZZnhqGjn8hm3gm4ntv/V6E0y/j
         v92qfCSfn+Tc1r7tUIGTt7fePZgkpLPorPHlv16m0SKp7dClCjHucS8lVRshFM9QRC9z
         OPiFPkC7Kncv7AFVvAkDdvhPNifLE4Nv7p0MQ/eGRQ4/5cR7R6NC3PZwc1mycKTarBqC
         vp96sg6ThQgP/OI7LnJ8RX6jZlUMv4GLAfSl9FNS61FYCnzkS9pHoZ2iU/kn+14nlEsu
         NDIZgVDUipga+HU5e6vqy8vHuDevVn4+1iX9UgenBndWHWkYuOlP8txSKEFu+Kgs09Di
         RRVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794505451; x=1795110251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lrob9qv+VazU3d/PrmIK9skaKz2AB1VT250mGCPx/d0=;
        b=oKzhRBXVGwGpB58ccy11v0DQhaM3ivB4NcOp84dO2KUaMHWlhht8qECpa1UFFtjBJq
         rMcw/XRAItiO5ZsbpFftauhsC1p5BWLfiuck/fzlkvzLDJPZuHyZjuoOScvI0qBck+MI
         A6UVdMJRbIUSwwB0WXi3NPMr84I83gDCdeHYdA6rsefNU6zu2/8jL8L64+ryk9ypGmJY
         Qx4nit304c4Rwn19OMBtBeCtWjtT5F52DO266B3LyObo/VASGy/f4k02I7LzqSE8Sodk
         FfJEp0iWNWfQV1D/+Or8InKNK7sRT7fPRoeWeVZmADKonfrKVS/V0whaNvj/xscSO7PV
         +nwg==
X-Gm-Message-State: APuU4Z8iRT5q0tQBd6M+CTCGsml2Qumqfbysl+6THEZ5kGbvLKPg/nMP
	NkNMr0TRfjoaVj25FLxUvYvNHVMMIWuny/us+uXy1kImDt76dIiaNVLm
X-Gm-Gg: AYBFou0s2d9iACPaKTxyH3gsFMC84uvU/yGvbfYkSFes7jq1N3r7qgEStcXSsSWqh6u
	+d14v0Pvl2RCbYnmitL1IepM0+gb9BThgQTTu8oMj4fmQuwXvQfEk2PJ+qsX7M4CighQLt/KYC0
	74h90wGg31U7KbP927wg4ZUVG/PuxVyrBf4LNrHZpyY9MQMRAovT++VzWQf2wwU+yd5/HD36+H0
	a7eeaUzA3RIj7264aNnBPJRz+pOsWLQljr0jAN4JuXvzUhCs9AvwHqFHwfbsK5dbcKbalEufnQt
	YYfeItcm5+N4wIsMwVS3wQXLkz1ZE1z679WTZKjxzJXtkq70bEQkxhDawM7Cxp/htyrynQO4qr9
	9GwsXmGOP8O9eKPsem8oF0iuhgCjhrtRGLF0gJFnfOV7DtedwaiExGQxYOrWS/9+lmhEpesJ3vc
	SXsujIVczyFFeB0fwG57LYLKiqmxnSxt6ucfqwmuqbKITh3n090CHIsOHwtzIcdGvNfJMWe3iFO
	BvGWQJkMgBZQc1Y3Y2Yj+VCiQrWEH0gcoH1/tzMqxMeWC/Dv60C08NNxU6Ur7ioH+wyr33qP1OQ
	kN/lroP5FyyGwAlEKg/XDMFxC9pH+yS358CU7/QB
X-Received: by 2002:a17:907:7b8b:b0:c50:62ca:6f7 with SMTP id a640c23a62f3a-c5066aee469mr588548266b.25.1794505451147;
        Thu, 12 Nov 2026 09:44:11 -0800 (PST)
Received: from kordpc.lan ([2a13:e746:396c:c600::8fa])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b79146sm2042066b.68.2026.11.12.09.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 09:44:10 -0800 (PST)
From: Kordian Chmielewski <kudzo51@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	bcm-kernel-feedback-list@broadcom.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/7] net: bcm4908_enet: TX ring and DMA fixes
Date: Thu, 12 Nov 2026 18:44:08 +0100
Message-ID: <20261112174408.391972-1-kudzo51@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261112091323.3c685f8e@kernel.org>
References: <20261112091323.3c685f8e@kernel.org>
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

On Thu, 12 Nov 2026 09:13:23 -0800 Jakub Kicinski wrote:
> The AI review just got posted, please make sure you look thru it before
> sending v2.

Thanks, I went through it. The points on patches 1, 3 and 6 are right,
and v2 will fix them: the early ring-full stop in start_xmit() in
patch 1, the TX DMA that is not waited on before its buffers are freed
and the slot->skb race in patch 3, and the comment in patch 6.

I'll drop patch 7 rather than move it to net-next: its trigger is not
reachable with the driver's own settings, and dropping the frame did
not keep the DMA running anyway.

The review also found two older problems, a missing TX interrupt and a
failed RX refill. I'll send fixes for them separately, after this
series.

And I'll drop the nickname, as you asked.

I'll send v2 later today or tomorrow, once I've tested the changes on
the hardware.

Kordian
