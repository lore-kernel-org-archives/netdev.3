Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E495237A4
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 12:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788955726; cv=none; b=nQB9Ej72g6QmQ9/fznFQ/WO7ktiW2j0YyelPMvGAtRYG3HPq8FEGBs+CrIGQCpjm2cIK34kGFqa3i+lWmtmLXETecSjncWBL3uFGVHIfOYa/BxAQ5DVL/9C+ZvNUq1n6FKo4BSrM3SzD5D3TAF4dkVDXMKyx/rMi20dEhWoQ5SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788955726; c=relaxed/simple;
	bh=bZxxw56AVwtZnpwP8MD7EMIUl3KPinsdzlvWzVY7qAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WvDHanMFHo9GdezJ9HUstEgXSYHEoA3M4tKyPW7C72nI3Ufk/msiDxsbZXEn0VLrc3EVKEDFeC0YZC0wp+RbF97/oFduoPZttJI1aA3t9kOfXFsBQltCZpmCsHlcJPQQmd06hwbCEX9Xcf8JHIXe3YR8MslHzU2Qlh4rcOodDsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eJK7nNTR; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJK7nNTR"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49d0b98d6d0so37551975e9.0
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 05:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788955723; x=1789560523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bZxxw56AVwtZnpwP8MD7EMIUl3KPinsdzlvWzVY7qAg=;
        b=eJK7nNTR30g6iX6af2Yfv07WlKO80eEddQhnCvuZZEW1YFjDbLmV/rPEJCIbGJQIyt
         aPrh70qmtCoLMPgpeEYFLOrSYROZX9u9qOV8w8/iNxMHtBqta6Tma50+SMUVdjm62HGd
         ogGOFY2jxBXGscMsV03EkkD+HtDaSTLDDH6h+bTFnAPoh3lWrzMh6OvkrpdBt9iECgQH
         cUylNyc4zCkb4TQngjDCStJBjcCm/Gpw8ioe9SSDyM03MyD73U6X5L5gTd3/5il3S/bC
         BQNd1MYTAS6y69DOjqvDlmdI38zYwHTalrYlP7SEQGd1w6Aq+j91gMTNUsBoioEIUA2Y
         kzGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788955723; x=1789560523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bZxxw56AVwtZnpwP8MD7EMIUl3KPinsdzlvWzVY7qAg=;
        b=b7Vvf3pRHvATdav5odu0ZqgCgF2dXX3HOLACD3xUHWkabMijClC11lTXA6xkUZfO6U
         D1lzZNpcSaZZHapUyIl664m3wf0juYHi6v2n/iCbvUHWx69yUKY2I/6vlZTFWXbhhP7f
         8jZmUmxEreN6oaonEAK5SQl0kDnRiJ/vr6h3peKDDxVQB/BvNr6uMGoq7NY+R8DScObm
         gk5pNczhzgp9AsgZKZeYvIs+7IQFrKeP64lHBcaoVK3NBDA8ekBv83tI0f0/bOPZaHY+
         IJNU8LBNWrEZK/X6ViYKxZVQAOr/lxfhPkWW5LVRTZ3a8fj6cA2oy44z917Sb/sVXGC0
         e8Qw==
X-Forwarded-Encrypted: i=1; AKwUvBxXKEzdl2Eae84I19ohhN7JWvfc5gb8HI1GEDQhvDaxFCk3IQ3Te6VzGbK6zoq1+f/J3waI/lU=@vger.kernel.org
X-Gm-Message-State: AFuF++n2vP2efjXARfdgCTuyGsuY0MUnNJwzp20dz1WigwfnbXiHYwBg
	AyZir3v9mdH+Fu6ld8k8RikePHIwpYkOcnZAUa4kxe2H45+ePVBChJYd
X-Gm-Gg: AYBFou0r0UNXKPUtSU4T+sRkReMjLcIrml4WFJxrTDTPuCODYLo8AkWUtoTddg+hPWU
	i1tZJi8Qe4pIBF/c3ioS6UCeF21yjajq9Dxa4UNSPQNKO02VbwdZy1NJbFp3C2Vi42mDh8LR3Nh
	8RpQgFEB4kjcZtNKKR+/joffNiIzn61n07ycbn5bsToFOTn1mj7RCaOIA3Ix24tjK7V11QM1aRC
	C4AYQbn0DTrPo7kdqPwU+WTF9Xvqo/5kQGz0LBQS6w63ZTtJ3U+V8wp6Yw2e4NfT3AsFN7GF5Nc
	P3wNtx7IYr71usSULZ5GqaWW/JEaUpUukU37xNecNRH5PUHn6sB3UXDnV0sk0DblrkRW52JVw+t
	nDi1eADG9LkJktyZHBOeZXLCQU6jwWNKou2XFDEffBnXMV/np+lX/dGYI6qWsN6lDW7QmKRowIK
	IGcF4ZJGQppRGSZaUxik76kbC7lPH8tc7ZBOtsOkO0NC+65sgTsoMoHuA2Tac/jn0DwutZPKmMw
	8ohrvA1HbN6qxzSgwwZ
X-Received: by 2002:a05:600c:628c:b0:49c:e1cd:536 with SMTP id 5b1f17b1804b1-49d17a8745bmr123017595e9.12.1788955723370;
        Wed, 09 Sep 2026 05:08:43 -0700 (PDT)
Received: from VivoBook-ASUS-X712UA-M712UA.lan ([2a00:f44:c51:e108:176f:2adf:3ca6:dc52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee60bae6sm655154905e9.9.2026.09.09.05.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 05:08:42 -0700 (PDT)
From: Stanislaw Pal <kuncy7@gmail.com>
To: Linus Walleij <linusw@kernel.org>,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	=?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin.sipraga@analog.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Johan Alvarado <contact@c127.dev>,
	Mieczyslaw Nalewaj <namiltd@yahoo.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: realtek: rtl8365mb: let the SerDes PLL settle after the data-path reset
Date: Wed,  9 Sep 2026 14:08:38 +0200
Message-ID: <20260909120838.33380-1-kuncy7@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907191945.806751-1-kuncy7@gmail.com>
References: <20260907191945.806751-1-kuncy7@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Withdrawing this one.

The evidence behind it came entirely from a single Archer AX55 v1, and
it was never separated from the chip-reset patch it was sent alongside:
the cold-boot counts I quoted were measured with both applied, as Johan
pointed out on the OpenWrt side. Since then the case for trusting that
board has got weaker rather than stronger. It is four years old, it has
one confirmed power supply fault behind it, its cold-boot behaviour
differs from its warm-boot behaviour in a way Alvin rightly reads as
out-of-spec supplies, and Johan cannot reproduce anything like it on an
MR80X v2.20 with the same IPQ5018 and RTL8367S.

The 98 ms wait may still be right - the vendor firmware does take it,
and the constant is in the vendor SerDes init table - but "the vendor
does it" is not on its own a reason to put a delay in a driver, and I
have nothing else left to offer for it.

If someone reproduces a half-alive SGMII link on hardware that is not
suspect, this is easy to bring back.

The chip-reset patch is respun separately as v3, retargeted at net-next
and without the Fixes tag, for reasons set out there:
https://lore.kernel.org/all/20260908174403.420507-1-kuncy7@gmail.com/

Sorry for the noise, and thanks to all of you for the time on it.

Best regards,
Stanislaw
