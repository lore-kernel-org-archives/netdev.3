Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1E44A64CA
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 12:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788439020; cv=none; b=OlVFcE13f/l128aanmIp74ZM/A/dXKyVZVvZmNwb5q5UMZU/0n/ihaIeLnDRwtR7VlwouduadPxvrWlD8rate1fdIQn0Tk1efEQ6bTPDgjatKV8r3uMCSwOuQONsWEfuewvjULcMB1mQ8CD4bT3qeASvdqM0RAQcdt1ALsIlKxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788439020; c=relaxed/simple;
	bh=9QRth4a5u37wDzisjjIulmQr2wC9EG52Fv0U2cVh9h0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qzS+kPjfcTZMy90JXdp9Wt80nQIAT7QDF7Rt0vxlAjeDbitdFU6oBrCZOghvM0fQ11KY8ekRmsfVe9WNZ3Sn2ypkzmFrJCnhsfem+F7Fd8ho0uS5zkneIY9W41yB66MD/KpfNTnzlSnphvpALbtjdiu8SHRCLkwYNR7cFDUEBWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=QPllLDtW; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="QPllLDtW"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4998b5a63e2so23442965e9.1
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 05:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1788439014; x=1789043814; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wd071ju3O6nFMLZPxIJUW/f01EIUe1MklVResj1uZjo=;
        b=QPllLDtWY72Bt8XoKKau6BPrbAAiarmuqE1rHwjVVlbgTvxFpQe67RlWZZ64c7SPZZ
         k7E6r0Y5EUAB9fgNROoAIVdjeRdR7IWPfqUdUw1JJXhOraJZNCvZj67lu+5F6b/atXPC
         YB/agWyHWoINGgWhcoLEB2ClJJt/IbxhJcJmHXQPWA5gF9eGQsf2R3cT6FI9rW8IAahp
         AeVnwHxkZkb51Hwhjkp4Zof22XfGzyQP7mFzwMXgU8Xpl6NnS1/lczp1aQkfRTsy0eIY
         BtQwGkQHiBfg6yggYFR9lnfIfSqpgXSquHRsd4zHKCGP6dBZVRM6p/PV2kgLJDBQmlcW
         yOkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788439014; x=1789043814;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Wd071ju3O6nFMLZPxIJUW/f01EIUe1MklVResj1uZjo=;
        b=n9qJ67c03hTZnN36Fw1n1JuQh9aonqvWGiXSpzpuBoL44PdLsF8K1kD4F1k6fzYY4J
         oxIH3RIBZLrmV1pyWWUNDDY1d90ScEmkhjrFAyeYs1bKPat6jh0xJqK9R6xue6Heo70n
         VodL1OK1D+ko49yi7ZfS305mWiY+AHdccEOnDA0Ruczf6HaTpyjKAJS5SMcK3xsDvLjN
         Odn682E58/8TKegUXq5/sidu1DT0o2tmLx7lnGBoyXWpDvf87fwYWw8zAX6nExOYerqy
         dIkZmkIjWSY5ZJC30wqMCxD8UqQalqRURB4SUiM/xq9IAsvxGga8ZnwpImoywQBmB68H
         BxCw==
X-Forwarded-Encrypted: i=1; AKwUvBzPAuYo3g8Y4o+DKei/IHXxyILkZFDwMEouQKrumRfUIz2YMwchxW06eAa6vUhpL2cKHOJLrzw=@vger.kernel.org
X-Gm-Message-State: AFuF++mZpHpDAmM6jcerRv7UiZJNDPV6ShDEH4xhBlKAKOqvBpjwkS0T
	hVN86Sh812caTfPPYbEscdUz+deC18KM7zPpvl9AXm8ZIWfXuwsf25/GkrVIsN6D8/M=
X-Gm-Gg: AYBFou3SkdVI8J0yXaZ60wmSj7fww9sqjxxtGB6F3VDWxUUa5tnGXCkllUqosi1R5J3
	MSPCDvTYO71DIVTS3HF5AWX7MVW8KymeUFMy9+QRU7wOBmgJd/JtJRyZYopNw3ur/TYb9hHi88f
	QIyk+D5Av7UJPskT/oR87QTNn7aU3Ues2L6yX9hFnSaTn0aCQqu3ADSO7tiBsy+2eHtt9ulhnDC
	e7fVjzlievVsa30RkYb6DdvuELY2wumBKA+9MbxBzGNZ5a4uf/HuUGn309GPrQ+FGex3f5oZpUR
	u8e5P4h5ziD0NTU6JHTVLz1xR1Bt4osBTEWV6gXvV0lUJ2VqVdlcwtK2BpB5fyFeaI9+msu6Whz
	zZSF6NPMoofYoBT0Aw1JCs9yFXVXX4fiMrqFDnTETbfdTqNxWy1Koc0wDiwM7NJmQIND4rSLIxC
	nscksfZocAmUB5egDl0AHXfNgU6eQmDEIpPTAeT1FOjBPWlnZeNHQ=
X-Received: by 2002:a05:600c:c490:b0:499:60bf:c6f7 with SMTP id 5b1f17b1804b1-49ce581f1ccmr175363685e9.13.1788439014414;
        Thu, 03 Sep 2026 05:36:54 -0700 (PDT)
Received: from remote-01 ([84.17.55.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448ed2edfsm13223248f8f.23.2026.09.03.05.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 05:36:54 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: "Th\u00e9o Lebrun" <theo.lebrun@bootlin.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 0/2] net: macb: fix the link speed the taprio setup reads
Date: Thu,  3 Sep 2026 12:36:50 +0000
Message-ID: <20260903123652.23900-1-f@lex.la>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Two small fixes in macb_taprio_setup_replace(), both in how it obtains
the link speed it scales the schedule with.

The first: it hands phylink_ethtool_ksettings_get() a stack variable
it never zeroed, while phylink fills only what the link mode provides
and even reads one field back from the caller. The second: the speed
check is written as "<= 0" on a u32, so SPEED_UNKNOWN passes it and
turns into a 1 ns hardware limit that every entry then exceeds.

Compile-tested against net; the driver has no test surface, and no
macb board here.

---
v2: both commit messages rewritten to name the uninitialised-memory
    case first and the link-down case as the one that happens; the
    grown declaration keeps reverse xmas tree order; the error text is
    "Invalid speed %d, link-down?" (Théo Lebrun). ethtool_validate_speed()
    was considered for the check and does not fit: it accepts
    SPEED_UNKNOWN by definition, which is exactly the value patch 2
    rejects (Andrew Lunn).
    https://lore.kernel.org/netdev/20260902080528.2211468-1-f@lex.la/


Aleksei Sviridkin (2):
  net: macb: zero the link settings taprio reads back
  net: macb: reject an unknown link speed in the taprio setup

 drivers/net/ethernet/cadence/macb_main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
2.53.0

