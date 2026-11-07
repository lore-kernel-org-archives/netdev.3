Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794043631;
	b=EYtI6TYE0z2aGxcArB48z4D9wLJZ0cvoIfkvclZL460xDsLyeFf7adQLICfsTvyHj0jL
	 vWI58J0AFovc+Ts1woADz/w7H8D447iS04qev9rLV82Z3oVYEk8l2AuEaSc2TijkF5uMY
	 ddz6eJ2aN5x9CalZP/EYBrjOOzZt20Qk6IVspQZNsJ3XssEApbZRId2TEmWpRK19d6kAL
	 vROr49Ak/5Ze+DHB6ha1VzMPdP+ilqRZTk/voSHkfU1ZiwJwzqueJgFhxx/+33uI+PLJO
	 qygU+AR6L9f/j+RtM1fQJqjwtP1pXIC+yPp6oXW1sxfx//KoQfpAoFEs0nBW+7OnuMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794043631;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=648Fmrq4vssciW2Xkc98+yh2q0DAP5HyeqVB1vpYGDM=;
	b=KeJZiNXe4Os2NEg311t0RqVMt+0fzgmTLQiC4YXMqXsZ8b5FRcpaP5flV+HSfPnfz+Dm
	 t2l7ebrNXFfwinPC+LUVCPM5Wb+Xk/WDoftYnLFNKrVcVYtOIleJcwtMHtY9zxQbC3Gog
	 e3wOOlIniDIU/rMc97W4tt6OKWyumYI8Zbv1BBZplRsse0v97+4lFI69+FQvL5PqifHQy
	 t86LIZ6uVzcoLJ+6PV5xRO30KvFR1lg24OMScxJmHnvF1f3WMrjArjLv4n1r7qrUQatXS
	 6riA85V0rPuI9NfmAOqRS7x/ItAXfOCBgQ7eSaPO4+c9UApUDpICTCEeaw7wg1ywwTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UNoo1uum;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8D1606A326
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 09:27:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB8D1606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UNoo1uum
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-490c1d337d8so899569f8f.2
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 01:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794043629; x=1794648429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=648Fmrq4vssciW2Xkc98+yh2q0DAP5HyeqVB1vpYGDM=;
        b=UNoo1uumizjnBzCBR3G+p+evTFMTh7MxIWlk03wB5vCRpOpsCOJHi+csM9K2eaqZ4y
         prTpob9Wgs/PM0niu9dYDFFXNX05kE0ZLEVIukqAuc62K3+YYOQGk60aY47QzbF9rCQq
         4IgJ/3gRf438GqlZikGGGZmff/qbIa4jHXJEvAbww3LN8uqj56o7ADDr60/yWKQQh9SV
         Sah45MI/QzUMkKox6mPF/0gHObdbXyheyelVo3/1hgUZbYnt0b//4ohMFpUx1NZUDJZQ
         4W/x1K4YXtqLQGGTbqIPzJyqJ1g+Bx23RYsGq7VvCb+gQKOyyzaQYZ+NYXgdKRGPmt9N
         6hew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794043629; x=1794648429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=648Fmrq4vssciW2Xkc98+yh2q0DAP5HyeqVB1vpYGDM=;
        b=V3rpg6ePO3ovE8TU/mVf7/QUoH9stN1WpOCf4g5oIJYhv6nV+3WOVtM21phu1FmiKk
         iW7o17eGxDztHXvkZyv8sPTmVq6tKvpM3Ch9eWWJ2L1ydkfkh8Cp0e8Yw9qLmLfzb8ih
         +HlRapgSN7JnuR+EdCykBYOmlWjYBlyODLy/IC6Wm0ySoJCxF4zPsl352yA6O3Rkn1Ah
         dmS7mHLGRNLishRVpFAI1nYFrFXCzlb8JknCUc9B4lnuHq9ROFDTRTfqoK2YmxW8Xycl
         eC6dDG/f8JW4GFecYN8TEtiuCW1KjpfPCClbPpkdUSTqVTiivztFar8wUOg9vN5cwvhr
         eOKg==
X-Forwarded-Encrypted: i=1; AL+hErFIkegWdu/UXTYg/ADz2bu5pC09zNz5m2v6TsTH1U46cdoqteoLKMahzfzzsaC1Lg4juPQX2YQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/rVlDSQzaTaaC65TzqkzqBc7QRAizgI7MJsvI6qqKEau05DL6d
	gE+R4QWcNypa9MoGXDvkYA+e8N4J2iShUaeNxesxJG7tCj5K16gR3wjw
X-Gm-Gg: AYBFou0s431w9Kn80s5/vIMyVlmaERGNASV+TgqYOJaR0+g/dQb2IkoHoZBr+069szR
	PEBgfOcltb3JgAcyBc6h3KIEtSPLloVPNN1aNZL1dulklKb/zSeedVsKRhp6UUwfzFxg25K3CHd
	MXina2r0Zm8dCCl9Ul4rYeP8aIOJU9LtssB7KUoq3N4u941MOKApFI3i5g3yXflYn/Iq3+KmxfC
	oO9ML71HB+aToRz4TrlpCDmf/c7dVYyokcKcTBxmhBoDOVNW5ERR2deEPVed5EGOqucS8TAWocC
	NERwmaB6oZTERHeNgeuMbKLRY48Ed5c7iz1XNn4FvkXuXKUMU0SZwa6masgevfGaNwHUnQBXjVJ
	v7EZTdQOxiXU5BqLztJTfHafm5iM6HaMzcovbJ5LnofYrFiujKwgTjrF09MpK7PvBk9PrlV3CZb
	+kC+ZkRzb/YIzIhtQjZo+zTRnMp7JvL5mVe8ExUIUUD4uT3T0zarHiPt9kGJDw2cPt5mB2UQX+c
	7kDHWEIEeYpu/Kfg0W88EaAIbEMHTZrUcpiXKTiJGl663UvTmWzNm7T+pXGlogC9gM95WiHpjDQ
	CThrV7yA26JGMNSBy2waQbzDVG3vZiH4x2tFAI9DElk4SNuqR1nZDB+PuocLMXAX23/8XGBwMHT
	lHUMyRbX81yEm
X-Received: by 2002:a05:6000:184d:b0:48a:fba3:d5b1 with SMTP id ffacd0b85a97d-49280216912mr10880993f8f.55.1794043629072;
        Sat, 07 Nov 2026 01:27:09 -0800 (PST)
Received: from VivoBook-ASUS-X712UA-M712UA.lan (user-31-175-184-45.play-internet.pl. [31.175.184.45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d7701cf9sm7492724f8f.39.2026.11.07.01.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 01:27:07 -0800 (PST)
From: Stanislaw Pal <kuncy7@gmail.com>
To: Alexey Immoreev <luixo-public@luixo.me>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Yongzhao Chen <yongzhao.derek@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/4] net: dsa: qca8k: read each register into its own word over MDIO
Date: Sat,  7 Nov 2026 10:27:03 +0100
Message-ID: <20261107092703.13274-1-kuncy7@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261107031005.2525-1-luixo-public@luixo.me>
References: <20261104210757.467964-1-kuncy7@gmail.com> <20261104210757.467964-2-kuncy7@gmail.com> <20261107031005.2525-1-luixo-public@luixo.me>
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

On Sat, Nov 07, 2026 at 07:10:04AM +0400, Alexey Immoreev wrote:
> > last three bytes of a three-register read are never written.
>
> Small wording correction: I believe this should be "last six bytes".
> The four-byte stores start at offsets 0, 1 and 2, covering bytes 0-5
> of the 12-byte buffer.

You are right: three stores at offsets 0, 1 and 2 end at byte 5, so
bytes 6-11 are never written. I will fix the sentence in the next
version, or it can be adjusted when applying if no respin is needed.

Thanks for the independent check of the callback.

Stanislaw
