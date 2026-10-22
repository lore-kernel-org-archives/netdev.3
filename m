Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792684750;
	b=zZFvgc1tu6vRDQz+YgCNKdroTdZuhNb5glnju1xd2xHzgh8qloO2hD7xEWosD91c+jJj
	 4IfPiAJMOUlAhyMrAwWyXXS/+HM59GNwjiqWer39juwlBuFqWJkmFK3xzpmzRsxD8XOxa
	 KaRjiJpI6GHlti/aiu5sYhz4/6uIDea8MGPHB3sSkW8s+LjBiJf0Oldz725rw8E5s9Xff
	 iI6+cAkIBptlObyVZmiz/bUt40jgP2p8LoORdfp832OTJAtp22uB0TMU0jrs15mIH5WSB
	 bVZmpYzseqJq4EVy5tZIl+hzpwUz2AFYcmKZYEyWRcbwzpsqwXX50xtA1raSoRCNiCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792684750;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QMSzQrmHSICMNQh4Od8RtudzCGPsNDtxQcd253kx/Jo=;
	b=nSDDY4h8Z/8hKkqDDo0PUgDdEbES7PZKwrlVEctDoqLAHJhfDE4OaAMQBVnFBukz82z2
	 eB0b20XhgjzCasGP7pYp20HFfUj/8LsY3/ETHARkGmAlu7/OkuNAOl+akqjI9r2xp6X9i
	 9LrCBx6s+ot1o4ZxHLLoRAKb6XnKCIDgwBqY4ZYCKGfZ7wZoULiIbUKYXWXxeocsasNt7
	 FiOdCvt0VsGSXlPj/b4NxMNlzJq5TbrlJkP/Tp6VmQPsZm0hGOLdUqvgT7x/3l8Tbn8Xg
	 yu2NEc5v8lMjnRW3Nw+bZJARHDk3ZXM2/dbPuQRtKgaEsvWeM75xdZSa5KXnqhPUdKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gDWql9zc;
	arc=none smtp.remote-ip=209.85.218.44
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF77B606A31A
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 15:59:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF77B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gDWql9zc
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c414e5d282eso260472966b.1
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 08:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792684748; x=1793289548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QMSzQrmHSICMNQh4Od8RtudzCGPsNDtxQcd253kx/Jo=;
        b=gDWql9zcjh56bB0LpnoDFMcZwYXzDCFfs8++ZvvTqzvOOobfBPTv37W1Pg+49Bs5ky
         q/sbHpvuGOX3y1HQR85kykNPYYBbd0WWgCkbNHuYIbyZqwTiebt3fu1x7t58v2aLWbGP
         OkUr8EMRhzFBYCee437t9LWihnVZsG8Zu+nYAqJpfjI/AbbznC7lKcfKknYjgnmuB63o
         qASlzfXqvUsHHjoOrnKs+figw1lZVy+KA2NIqAANTk+5ZMeflDb++2Wn11TtJxD2T+oH
         tNm87MM1loHbUIsVHCP+CuvrK/dL2a/ys0Gmpt3bq4OgBhT1qIa2MV51JMGzc2idjRuQ
         6q9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792684748; x=1793289548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QMSzQrmHSICMNQh4Od8RtudzCGPsNDtxQcd253kx/Jo=;
        b=b1G4kUfUzv6Eb+gWUO2Sg8o8u+YORffK4u6vwelPoVKUfRNE16HLMgtcPHXhP7e4mZ
         yPIa29RN3KTa2XGhiFYM2oAvW6b8wVxoyihlUBPNv4M7HA2o+ggr8ZGGzK+KdRdZFPYA
         BMpKaf1QN9jhJXFbwtaPK7GhrQKPxrmNoMtU1QAyUaJukQiDWGuO7pT56jPx1bxz87H1
         ZhUWaicSV+ysj4DZViZLXzR7d+HrEO6RTf9YsZH6CBdPbvqxRqVIqeBLzdquggsRpy6i
         DdA5eaQVWTZRA+Nt7L4jUZLp0y1e7rMbLXLkDxYv5LUR4beC0c+997jwUDCKqUYah1YL
         Lx2A==
X-Gm-Message-State: AFq9FYJeOdkU32ZELako+gpzRdUMcUR+vo62DHwSAGvyZGcATdsQlI8v
	rVVaEzzhWJb7Z9ThtPt9D7FsPz4RfGJJYMDfUkg0j+sFyieMDUOLD92W
X-Gm-Gg: AYBFou1nrieQLQrM0JJJFYmnUQdWRbtueUVHad5TVvjGYKDv4aEF6YFQubGzPPYNbOK
	gP8GWNTybFKHZbypnnH46mdOKIX8DoZPY3evOLMApjkE1o5fNIciLLXd5Yg+oKtg1I3lYaznQpM
	SANSgPxc/52Mg5VZPE/6LBZrzrx12qHQvyveB8bk/i0q1mrge7bhPCCeQq1aIVLGFl40rTSNl6t
	nagIaFd3oee6MryAf3rOJq/dm32bQpZbpHhpqMbr0O/x126FYZCLMVU4V0IA0OjxWD6P4oNDJBD
	AtWwToM26sgZ33ubsVKlggAcV+9Lj1ZMrcR8k0LaPwbsN5QKw9p46ciIjSI0NO+KDMiqbvqugGM
	Y5C2Srz2f+MbG8uJ27bOL5bijq8KFfiTT5sn1CTuQTCphv9VzSzfL3tyCIpXdB7OQr9Z8tjsDde
	oWB8bgz6d6Dv8fZFzZdXPw9OvFOTufodWqIrEqvzLV9CoQLq3pokbAHpt3ECIFe8mXf0IB40Hbo
	Hn2/jM3RKQYW3Dc/rdBj7X0XVAzNXx0fbGbHpdzWbOmB4wp1hzxl7Y5UC91Mw388rIwN4VXZvil
	/rPlhV6sflkf5P4gWOg7wDCOZi9KpWbbm8jHhDqcZdd4/uXTUQ1vqtnyKA==
X-Received: by 2002:a17:907:9693:b0:c42:9ded:6a8a with SMTP id a640c23a62f3a-c46795f0e10mr599649466b.16.1792684748139;
        Thu, 22 Oct 2026 08:59:08 -0700 (PDT)
Received: from CCM-PC (31-208-243-52.cust.bredband2.com. [31.208.243.52])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b4030db05esm2020088a12.10.2026.10.22.08.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 08:59:07 -0700 (PDT)
From: Yongzhao Chen <yongzhao.derek@gmail.com>
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org,
	ansuelsmth@gmail.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux@armlinux.org.uk,
	florian.fainelli@broadcom.com,
	linux-kernel@vger.kernel.org,
	hzyitc@outlook.com
Subject: Re: [PATCH net v6] net: dsa: qca8k: preserve port state across MTU changes
Date: Thu, 22 Oct 2026 17:59:04 +0200
Message-ID: <20261022155904.1051-1-yongzhao.derek@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <179265824122.3135.15072303811434404600@kernel.org>
References: <20261019173716.198475-1-yongzhao.derek@gmail.com> <179265824122.3135.15072303811434404600@kernel.org>
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

On Thu, 22 Oct 2026 08:37:21 +0000 netdev-bot+sashiko@kernel.org wrote:
> Can this write bits outside of mask into PORT_STATUS?

Yes. The qca8k regmap passes the raw value to its update_bits callbacks,
which OR write_val without masking it. My previous register model
applied val & mask and hid this difference. v7 passes
port_status_value[port] & mask for partial updates.

> If ports 0 and 6 are both CPU ports, can qca8k_port_change_mtu() return
> an error after the frame size has already been committed?

Yes. My previous test called the driver once per MTU change instead of
going through dsa_switch_mtu(), which calls it for every CPU port. v7
records the committed frame size and returns success for a repeated
request with the same value, so the second CPU port cannot reject the
first port's commit.

The NULL PHY call in qca8k_port_enable() is already present in the v6
base. From the source, a user port without an attached PHY reaches it,
but I found no in-tree qca8k DTS with such a user port. It is
independent of this MTU change, so v7 leaves it alone. If it is fixed
later, dropping the call looks better than a NULL check:
phylink_bringup_phy() already calls phy_support_asym_pause() for every
PHY it attaches.

v7: https://lore.kernel.org/netdev/20261022155837.760-1-yongzhao.derek@gmail.com/

Yongzhao Chen

pw-bot: cr
