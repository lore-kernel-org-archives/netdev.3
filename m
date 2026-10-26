Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793044807;
	b=ZL4mW3bwLHdQ+rYMFf1hMETicKNvTMKoGD15UQdaymE8nrc2oEelvVvNkNbD5XAmpK0M
	 ujIu/RYhIz9lyG1dmD28brwOD2VxGApJSdvgmElPd9i0403oTWTJARhOhAH2A4SR+vPLA
	 Stv7klSKA48WoMdoV9JVrAYiYGvfyFJu1hOr573fzP+wgvkUgyfO5oM3zFSQZvgTAbUu5
	 vaNTSliK3/MMhkrrgEx3shRkqfjDngfWv2K2YSG+XN6foNwXA358NxVoaOLfjKAyVIFI/
	 4A6BXrg6NowpPBQaND32AWtXg6Wiiyxd47VK79Ak7quBJ5X8dEGEk2QhOc3XqpTaFiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793044807;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=OqJOMVomNicsYATFLXth48258BoA3r2b05um3WvwiE8=;
	b=DTvKc34WXDsGDqiT6NDevwBdGZBaLECiPxEmKz5SqULgzURul+6Ek91ZbpuG0Mi83IIx
	 SR31OYP395yPDxnDb22wPZPTfdHLcImjFwfrPKKZn6B1YnydxjzSSkUjbZLa6dEwHg5N1
	 6VArYQwzSzHkAA239K2BXfh5fiINody5N1BM3XLEaxWQcJA8qAiaCw4fN8tQuT7REtRnw
	 FlzXaWBIFNJxP3Zb+gXrffWrXGfiV/6OAuPeAos2AWhFTrTlUeca9W6o7RkjYQrvebvji
	 4vsq1XANFv6Rt/p7oAvI3WpMr/mbtqLEgL8U9RoLNeLq2DX02I7/UQ5D9xBXrrAYWqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XXcyv2nZ;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B57606A320
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 20:00:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13B57606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XXcyv2nZ
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a35a60499eso21111265e9.0
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 13:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793044805; x=1793649605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OqJOMVomNicsYATFLXth48258BoA3r2b05um3WvwiE8=;
        b=XXcyv2nZUxMLT3b8CpbfRTDpwPPEA+QSGEUubHtCgE6ChP1KO4fNwJuH8bIwwsRkdi
         010r3Kb86fX+bn+lCD3GFBMpGMapAdhRll68dNa/PmsU7eoywaOr8ET1gOtaN9YbIIJ4
         49fvoiZOBJgCmpn42tOZFm82oGe71dWn4zEhTwQM7pd328o9XDgjxj1ELNgHKaTwx6/s
         OrxolxpKKhT1jGW/+kzVeeaeOdr4389fDx/57eV1vGjhsK0Eb3rdv4QtZSjgv+yifgX5
         iMKes8XULRl24WFVsfynUpO6DUXjAUtjgmDXQ5uBTBwPpCyV4xeBUSHwm+NC1JuFFLdV
         nwdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793044805; x=1793649605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OqJOMVomNicsYATFLXth48258BoA3r2b05um3WvwiE8=;
        b=ff9OmS9gT/DTrdMkzpBrP04ZR4XiTwdmD7rsbWR7/LDR+wWHYkDEdycPhLPZam1xs+
         f6HL1MAdw7X6TkXjhwD6xRvgyN5CDUuJPFuewwHg4supJ9QwEi6Yw8f9GngE7AOeivoa
         5A63UUiKKCezRE4KG/Ar/JvMNl2f5lJ0FCzqoMtOsqYtcmiIpmT/7GyVzHbSDkleq4GN
         03VgdN2Zc4op+9vl0YLOiX5KXdmGohZIjb4sJ/yzKXFvC5QOBSQsjfdCP2zV4tVkX0Dd
         2QLXCyAZ9+OmK/JOe6AyeXKGVkYOwjxgdiI0dRjpzMg1T5vabVPzhGQ5zy51FttO1Gw1
         Qgcw==
X-Forwarded-Encrypted: i=1; AKwUvByNn2FQOvCu+Zq7exez+uArBuWNxVYaduhsx1sS2T6fZLUtMFakiL4gdd5zUP3LDN0dFXz0vSU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLjIraiQxQ+4+1AZRuHL65UIrO+C8KJLN254JD2F5MXHrEe9dpJ
	BGNoh2oMMNwoTXKox2QagZZb1QTTxTFws7r4nZxuKtnKlpBemRuhNbaI
X-Gm-Gg: AYBFou3RHnmrZF4PqH4BSs+XS3Me+cXPcz7sDtBFoMpYbdAVzhBtLURQ0wiouGnjOyS
	KzCYbMRCtXx4SaEuOpc7FjK6t8TGfgVQ7rwkmIyLKSa+Mgve406JgxWkWgoDsAr6dqOhBlI7i5H
	vrMokl875v3Bxp9+nVWM33kr0NllIWgZy4mld3fzxJKC67J2wpDrfDIJGd2OLKmN8CkG9GnfUId
	1oe4GUW8u0zDIACiAfdnlIMKF/8ckUO6R3u8mUN7Txsr8E4r08f9Crsr8UkRqCajJWwDgBAyRDI
	Up+dZiHJwXSivp6s1lfXfk9Hgogfa4/u4gWvn9KQYUibd4qDcerQK1SZi7EpRJb/TIoxeKYR0Wl
	TgF3qdf7Dipgn7EJkGEB6Ft4cHQRJY4OWYxQUSpX5v88LnZ53KVPWHxbudHcV8sLMqyAPl4jk3w
	oRryjZW8z++Y+fQTUCu4bLZGngI+cg6pYOIIMQyXQ4UByZQyXezHKfuHT9fmE30ZUoYZV1GBWGt
	j61hGEoTtPkOAIm0gI9VGDadVKZAuGpyZ0JwKOIAlUcRkQQS1UlCMN/IK+uuvfIUTqzS8Il7CUB
	0g==
X-Received: by 2002:a05:600c:198e:b0:4a2:84c:52f3 with SMTP id 5b1f17b1804b1-4a35ac9d1c2mr162802625e9.6.1793044804393;
        Mon, 26 Oct 2026 13:00:04 -0700 (PDT)
Received: from VivoBook-ASUS-X712UA-M712UA.lan ([2a00:f44:c12:cf67:2c6b:7fab:6853:c855])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecd35c2sm18068821f8f.39.2026.10.26.13.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 13:00:03 -0700 (PDT)
From: Stanislaw Pal <kuncy7@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/3] net: dsa: qca8k: drop MIB autocast frames once the request is over
Date: Mon, 26 Oct 2026 21:00:01 +0100
Message-ID: <20261026200001.13573-1-kuncy7@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179304303832.3134.328719975361344250@kernel.org>
References: <20261022192933.384898-3-kuncy7@gmail.com> <179304303832.3134.328719975361344250@kernel.org>
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

Thanks for the review. The sequence is right: a frame carries nothing
that ties it to a cast, so after a timeout the frames of the previous
cast are taken for the next request's. v2 will poll QCA8K_MIB_BUSY
before sending a cast, as qca8k_mib_init() does for the flush, so the
switch never has two casts in flight, and the handler will record the
ports it has seen in a bitmap instead of counting frames down, so an
extra frame can neither underflow the count nor complete the request
early. What remains is that a frame of the previous cast which was
still queued on the host side can serve the next request; its counters
are then one cast old, which the commit message will say instead of
claiming that every late frame is dropped.

v2 will also carry two fixes for the issues you found in the same
handlers: the MDIO fallback of qca8k_bulk_read() storing each register
one byte after the previous one, and qca8k_rw_reg_ack_handler() reading
past a short frame and past its 16-byte buffer.

pw-bot: cr
