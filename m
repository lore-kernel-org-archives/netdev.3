Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792960659;
	b=P2ntb4L9WhBRSlEsY2BBZ4ME8iGB7opU8qwgFmsmE6Daef7/C5mO92rXpL9zhhBe1wbO
	 VGM0p8xtDmzBpOy/Jksc+wFpnQ8w+OP5ZdZgz0yKAyIMpFp8T846dw5U7KxmYPLUAx5or
	 v37TR/AJXKHsJfkNjSJ9W1GzK2ICAERaE8jLXrFYNulbl+ARioRf50s+UwVADcxgzoO9h
	 Dq+pBIN0yMhuMvOTvxm5QXGVteyVl3A7d1FjHrUdS70ULiWx13dFAanWMCk0rqGUyAYg1
	 fBA03tAxEVSg1yzmE0CAJ6X9Nk5bebuthbeX03BoGMVxeC/yhBJMG+IG3L4TU3Ubpnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792960659;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=PlSoCgfZlJoJONbpF7eAC0swlGll9EuLKZNtFVx8kFY=;
	b=fd3IzHsIs/yRqoort9TJUYftKRRtz/XnrQ+JJni8qCvyad0D5VMmF4dyPP383dZlBrVB
	 GapjB/c1L7o8KfhZ+eqdeZlUCyikNFkwdSbllDT//a6iXLxRqnj+WLFDy7RFDSIhnzf2T
	 3GGFECswEN2UWi2JG8oLjbr2zSN4HX+DdJKi3zoPK1aT1J6RNJsq92h8nIAAj8ZpTgICW
	 0oLuyFMjXrWUxamTSrAEgR9IZppHMvQAxNC7DP7J4x7Q/MkOxMKGJU0NLJQNHtxIK6Fa0
	 QrLPdntIToztJ6BOQ2wtV1dQe8yS/t50dBZYt2MmajSgZgltiOL7x31zYGNoGQd5gRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sIrHI2r4;
	arc=none smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CA1606A31F
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 20:37:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4CA1606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sIrHI2r4
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b3dd83e779so3985128a12.1
        for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 13:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792960657; x=1793565457; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PlSoCgfZlJoJONbpF7eAC0swlGll9EuLKZNtFVx8kFY=;
        b=sIrHI2r4IV8xPByba3hYp1R2EYUFnxRGVkulGhm9zb/Jf37VgwwUgOrjQwkuave9Ol
         mGNnib2bM3hzA7nHquurCIQ5BIE/czH4jb4AT8wYTT7j2LDk26kYUD58mFNq07DD6Oi7
         Cf0t/yg6NhwuowvcW5Jsg2qf0mqFQAwJoyEA5N1/RWPMw7fO+PwsJ15IEQlgZPM754Ir
         cjE7BgLBadpA/YbPsXai7ZKxvuAbA6njvuh59ctI+bR+FSP/l73n7mNUEgg+SzocrAli
         N1N2bFY1S0i/ft0ge2+7GVmp/fV2Tp0XTZkmy/9e1gdm4tX79Kt1zVeQ78qZjXay2Y2p
         X7mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792960657; x=1793565457;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:subject:cc:to:from:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PlSoCgfZlJoJONbpF7eAC0swlGll9EuLKZNtFVx8kFY=;
        b=eFybYD+l9New0gS6JQfdhBliy/XBOK3JFMUgh35IkBoFG/0RqkWAD7nKMgdDSeGgl9
         vG0sPvLAu1XRuhBRCVejW2cVCuhn+TLsEJ2nFvM5vDivv6T71Z1Xuvcq8u0swgYva/l6
         8PKSc9c5vC2bIlwNnzb2uVleZaHNnYRHYEG2Z9J0DPILOoqTcuVML1meiPCf+XALAo8B
         eQWKlUMN3InQYtEXpxPQSViniClA0U0KipyKQY4aAm1qpMnYJW8F3Bjf06TE+74QlOQf
         bUm16A4867RYh6QnQdLw/1FKTBb1WC9d3sbGT99L4zpPrRlqJljF7ZolJS4/pkPG+Qce
         kdkg==
X-Forwarded-Encrypted: i=1; AKwUvBzLYOFwY3PUWTx5U9eLnZy7p40y2m0VKH3xaUl1dyUU+0R8Hgni6E1w/QCxikym2j2US1VvsOQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKViahYLmgdpYVJr3r2G+PdPOZzQ0FA/KGkjtuxUiIU1um/3OxU
	w0Cjvx9PRKQGxHM6VBIhgA8m3z3C0mgoaUQbiKS6wpIAmDFx88an2hmt
X-Gm-Gg: AYBFou1x4d2+leDaUU4oHzRljO407QOCizZv/Z5MST+ItrqzdQAtttOx85PsXMcSPax
	dUqTN4chlZdXfPBzMOKrkD8nf8jfcg6Za7qYs78s7/o4XVM/HGFe0a1qMdimUjk5XdaIxXxU0oi
	cv/pFyvLEPhCLxWH0PFD7dveM8+y1uMq7cFBATzFSENxGUFs1kOT+/AyGL6Z+IJDNnkmvTjr9E+
	Dg6QAzROoicu7C0N6y3YLEHNwVZ8J86qra7g0W3dw/D3+iXGmhnmuxj+3ugaY7+GgyydUExhQiD
	KZRZLynrqKW9o2f8m/iWoCUL6HQya/RoNqKADx5v5tn+bZ7Ici+HLOjAOWFOMtYhYOcwXtkK9SA
	PQ1wYeSwNam8L+yA2oFNwD0XU8n+TVo9Hc24fnRHVEKM2R6LO1LLRqU9atcQYOVC0C9yK2DGsoi
	fVpemNB5o24zTJR+Tspd/40c3nXWVi+w3easLm15M5oDI52AdSzv2CHvuUbbwdfGWatb0n9FF6r
	RzNem9tIkWXhZY0m+hCP37UQC6W5xoKNsypWHAW10uSrAoYmHKc7fzwEPM90RVCcPytaLsspP7M
	9MGTfklobRDXenooYLAr8LOjDd/q/XPNS4CAj1Fmadc+OJXw5kof+URjX/fQIirL0dUT4j1OJHr
	k5ej+rw+b9z2qxWpRRP5JifalKK/oh9TpjjgP9+ElSAjj
X-Received: by 2002:a05:6402:4008:b0:6b4:5d8c:95e2 with SMTP id 4fb4d7f45d1cf-6b45d8c97c7mr3366886a12.4.1792960656746;
        Sun, 25 Oct 2026 13:37:36 -0700 (PDT)
Received: from localhost ([2605:59c1:3500:c210:a19e:c679:44e8:e9a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b4458dd28fsm2693713a12.3.2026.10.25.13.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 13:37:36 -0700 (PDT)
Date: Sun, 25 Oct 2026 22:37:33 +0200
Message-ID: <e16c174c12a32614e0f6cf08301d344e@gmail.com>
From: Selby Mashiki <mashikiselby@gmail.com>
To: Sunil Goutham <sgoutham@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Selby Mashiki <mashikiselby@gmail.com>
Subject: Re: [PATCH] net: thunderx: fix fwnode_handle leak in bgx_init_of_phy()
In-Reply-To: <20261025203159.455100-1-mashikiselby@gmail.com>
References: <20261025203159.455100-1-mashikiselby@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

Here is the additional information requested by the bot:

- Discovery: Found via a static analysis script scanning for
  device_for_each_child_node() / fwnode_for_each_child_node() loops that
  exit early without releasing the child fwnode_handle reference,
  followed by manual code inspection.
- Triggered vs. theoretical: Theoretical (found by static analysis and
  code inspection, not triggered at runtime).
- Hardware testing: Compile-tested only (-Werror); not tested on real
  Cavium ThunderX hardware as I do not have access to the device.

Best regards,
Selby Mashiki
