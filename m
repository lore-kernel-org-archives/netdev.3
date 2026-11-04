Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793780733;
	b=GHUbO/J3vzBqUzD6Ws9UKUzMPQ6pcLfQyY/42E4O4Us5+gr43GyZCS+z8W/h3P0/BIhx
	 xJ9mOk+jfeTdscb7H6BKgNIURFpqR2aNitjpAoei54dDKCwNYuJA6hDdCkOr4RBxxrFGx
	 q8aA3MNN64sTUc3MbPY/en2ngOChQHUMKQUhCRt1477w46rPYhMh+2BUuhdaWNsdTnisv
	 5b75T/VpqJwCP3C3JnOs8pttNM0to1cEx+HZjNJqrcmU2fyirb0N2+oM8yyRTSTi/Ysup
	 /hebJ3HNVncwrZ1twC2pqSNMf0cHI/g0DAJFmbP/smz2y3zKHIfqus/82FRw10h39Fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793780733;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=YUgy6QisfbO0Ff1caes8uOGp4z1pNB6eutk+Z/JiFus=;
	b=E4pdMqTUTBJCSc6pM2agWPpXbuCJKGm9VyMecI2QdFnUmaSE9hSRk4SE7dsiCl9TE/p4
	 XcwE1L2hagARyZhc3N75DA/0MPk4hlKiBRQf7Ew5u3vNlpTN17nIrfIpxFH5MkAM2lugR
	 59VmHU+Wxse21f+Nj9oe1k0xlbngvoRx4uWnXnWe7ixv92p9jvMkSZPTRK1Rx+jhfC4GE
	 99YRKBv+j5ebtGH0ruUL0vP+oAz165J5S2szg9rWNgYEWXZJezI7wpd4w04WNKtc3emRQ
	 lPuuQ3GIwsMmeYDS5L+HFuX9vp0zzKGZ6sJsxelMV4grz/1mMkJZo4DdEjm2GCN5Diw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Tbiu7CRW;
	arc=none smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AF2606A328
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 08:25:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45AF2606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Tbiu7CRW
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b547d6c07bso425168a12.1
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 00:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793780731; x=1794385531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YUgy6QisfbO0Ff1caes8uOGp4z1pNB6eutk+Z/JiFus=;
        b=Tbiu7CRWgD+/9m3CNtgdOnD0RLzxojVz8GkGmenqWLg18iTt/BEiVanrxcWWPzP09b
         ur79v7mYhm22QpAmlOwx7P6sKcZx9Sxf6DYdVCtfVhIRrDiTv1il68F8UYtDeLz0M3Ug
         cpR4TldbDnreSarMLpeJICk+KZmvs5bSE8TqhLyipC6wWt/1Ss5QdL57JXh7A9lC4jrw
         bReIyXUBW8A83jivw78RAmu2rpFuUKsKZdJfgg3veFBs9N0D1QBslHYMfMH1ZHn0wvpw
         IfLv43UPY++WjdO4x3u522bwgZ3lc2UHewGJXOlijB0CgO7WvcNYKifnwHtm8vqlXdYh
         mzMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793780731; x=1794385531;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YUgy6QisfbO0Ff1caes8uOGp4z1pNB6eutk+Z/JiFus=;
        b=DVmTqtGdObeUnQFXp6KCmRtRXowb3C48da6pV15vu8WGX6JccEVVLXfDBT2ksCWmcZ
         GLacKMUAllja6WgV6e/7STQ/zfxzULNBmtCIUJSyDUxt11xe8pbL2yqd2mkNtZl+xVZM
         jm7u0l9jlBJdBNWfWLsaKCC0pcBotJ/uhc8+e1tW3cgahj73H2yCeTp5TdZwFrUGUMhX
         XwOh9mbae1cW/+/R4gC927Vu4ISMoPPut9+NG4EbLQZiYuIWKXPw2c+xJgTCnDFg0lLj
         G6Zbjc2ruERQsEfT3c5zdpyDeJ6GRxNlYwr/DR3JudLbS6+sH4i2aAnEL0iei2VYAcrk
         BQDQ==
X-Gm-Message-State: APuU4Z/AtmVBdpycWPrU8BHXumMRE032fy5u0jAlI9snEEha1qEXfy5S
	YR8MXukGZOBHe5CdFtkGcrxAoxtP5ePGRut5zXRetl/xBdJgtGIpDJeNuKztQu7G
X-Gm-Gg: AYBFou3ncW8NdpEOKk7gxSqEQlr4N6O7c5FR8iA9fx8L4elBpW0hVzP0s8F0l3myi1y
	47ka3lRcwt53O7/HGLz6cFv1o1g8nGEK1camokbsgLkBPAegS7Iey4MOgI8vlJq/DKjhA/hisR1
	wqxtNzWvPfUHe7nSV4hphF/6Y36e7XnPnxlev7g4+JEDTCDYUKJpm621KoF2eXb6qQv3yhKTl7P
	/VIyDYwVijzGhCqkmmfQhCoM8xn9SAgIAVsjDM8rPTGlWHtzejRmnlIhWwh7gfu4d3/Zt3L54IN
	1rLq3wcA383zlZWxu8zTvKKgCnvzmHEt/JxNUOM488kzyZKVNdONQelJMgP6faVoYD1yYDXHgIX
	5SRaq1A5OkmvkwIH9J7AlD+ZAW4bS0b8FW5RENcSTrOZJoxbzxvj8WhI0PuoeG6+3huoFEetEr3
	GkBrKOgtYgWjec7++BdB0U4aSSRCkJSX9Ff74iek/CMtz5T6iuL39xSCP6b8PMGJtdc6dSlqmCx
	PDAl1kXoPDfQmBU56LZHNyOy+VEbD3FCzAAKRYFKtK6GtgGkH1nw69oWhXjmoVvHL407tvDB1Da
	YXhAP1WkFXLnzvxpG6oRTt4qjGGycNRI3pw8YvJ0P2IDrGdHaGw3o6We8r0MHq37IeXX1zYST/c
	0+LFN6CHMZNWN7rAdJiqb+4zK7vdTbnDFZwbIm5Atstv+H8yhfuiCS56mvNT8iLrvs4Fm8xne3Y
	QU37AjEVUvokMVofK2UU9J4Q==
X-Received: by 2002:a05:6402:234f:b0:6b4:2960:d383 with SMTP id 4fb4d7f45d1cf-6b4dcc50022mr12617929a12.8.1793780731417;
        Wed, 04 Nov 2026 00:25:31 -0800 (PST)
Received: from desktop.home.arpa (2a02-1810-1e16-ac80-48ed-b9ce-6098-90a2.ip6.access.telenet.be. [2a02:1810:1e16:ac80:48ed:b9ce:6098:90a2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b55ac81386sm483243a12.29.2026.11.04.00.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 00:25:31 -0800 (PST)
From: Stijn Cleynhens <stijncleynhens@gmail.com>
To: netdev@vger.kernel.org
Cc: Linus Walleij <linusw@kernel.org>,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	=?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin.sipraga@analog.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Mieczyslaw Nalewaj <namiltd@yahoo.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 0/2] net: dsa: realtek: rtl8365mb: fix FDB lookups in VLAN-unaware bridges
Date: Wed,  4 Nov 2026 09:25:12 +0100
Message-ID: <20261104082514.2139278-1-stijncleynhens@gmail.com>
X-Mailer: git-send-email 2.56.0
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

In a VLAN-unaware bridge, DSA installs FDB and MDB entries with VID 0,
but the switch classifies untagged frames to the bridge PVID and looks up
VID 0 by FID, while the driver installs IVL entries. Nothing matches, so
a station that roams from behind a user port to behind the CPU port (a
Wi-Fi client moving between access points) stays unreachable until the
learned entry ages out.

Patch 1 makes VID 0 use IVL; patch 2 depends on it. Patch 2 keeps the
neutral PVID (VID 0) on ports of a VLAN-unaware bridge and only programs
the bridge PVID while the port filters VLANs. Tagged frames in a
VLAN-unaware bridge are not covered, see patch 2.

Tested on OpenWrt's 6.18 kernel, which carries the rtl8365mb backports up
to v7.4; the code these patches touch is the same as in net. On an
RTL8367S-VB (TP-Link Deco X50-PoE, with the family D series applied): a
station learned behind the uplink that moves behind the CPU port answers
10/10 pings right away, its stale entry replaced by the CPU one, and
switching VLAN filtering off and on at runtime keeps traffic flowing. An
earlier revision of patch 2, with the same logic, was tested the same way
on an RTL8367S (Deco X50-Outdoor), 0/10 before and 10/10 after. Both
patches build without warnings with W=1 C=1.

Note for Mieczyslaw's RTL8367S-VB series in net-next (v8): patch 2 adds a
vlan_filtering argument to rtl8365mb_vlan_pvid_port_clear(). The family D
path that series adds there reads dsa_port_is_vlan_filtering(), which
still returns the old state while filtering is being turned off, so it
should take the new argument instead; otherwise family D drops untagged
frames after filtering is disabled. Happy to send that as a follow-up
once both are in.

Stijn Cleynhens (2):
  net: dsa: realtek: rtl8365mb: use IVL in VLAN 0
  net: dsa: realtek: rtl8365mb: keep the neutral PVID in VLAN-unaware
    bridges

 drivers/net/dsa/realtek/rtl8365mb_main.c | 147 ++++++++++++++++-------
 drivers/net/dsa/realtek/rtl8365mb_vlan.c |  40 +++++-
 drivers/net/dsa/realtek/rtl8365mb_vlan.h |   4 +-
 3 files changed, 141 insertions(+), 50 deletions(-)


base-commit: 787268686c64be60023743b527645a907e38ccca
-- 
2.56.0

