Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671FA43C067
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 14:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784903509; cv=none; b=dkOLLaHBqGoddf5jp1ciZOFwnN7qwhx1iflMN8PVCKjuZ01LHCpGW9U7ze8oC7lC6QT9FGeG6laggQ0Zo8UOkqM1yGvKxYwXMSgAiAx4vikiPIsVgl4hiAqMycgF3Cm9cgKJt/DvWcBZuTdnNCOZUiTVspiN0vdiPPNy/FZkHqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784903509; c=relaxed/simple;
	bh=GzVx9YiqdDdcYfoWaGXRQFddGcC6d0JJsO8fI1gajBY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f1IPZsHBu2WfR9IR3lxOafZPKiNuI6cHhHhcBP+GptZ4Sal6Udtf4HB8BaofmAcEBtq/l8B5B58VtIGXp1POg4edL3nbsq/wcGLDTKf63DQqpu/YtKkz3bf2FmDD8xpBcBYcxZoazzw5HJxtL+IIsoe5LxEkeGtDaXvc5RX2P70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mZtiF1ow; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZtiF1ow"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4758bd3731bso448524f8f.0
        for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 07:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784903507; x=1785508307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9IqVF2cJIKIMbhzyT3GSr2FYGdQegDZUwKZVuJLzwZk=;
        b=mZtiF1owkE3YTR6Eto5ZsRw3vhFjBCF7r9TRVhMxKj2vVogqTThTXrtjMlt/ZhhKAb
         9mVdDEQoUjtwS1uw5wP8cFswuGGgAs9oV9Oc5SzlGt8BeV1D8tshoovT6wYROBcEPVv+
         vvSqttYqZ7ls24ChvNgqq4qFmrIqJG4iXlQsVdg28d7elnQFUqBCz8Olcf9PVShFMPZx
         SckR9ADycjCspoStyUPTZTgZ4cVjyV1vwnUm3CAGnr4CdPp/BO5RpHvfrnrcZH5JD4+s
         8rtmT4eTCtaELkZfAXcG/XBiGagBz+3iNbDIeBrNZ5wVnCAmj9YhXoaI3Q2tDAlEOfxN
         FAVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784903507; x=1785508307;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9IqVF2cJIKIMbhzyT3GSr2FYGdQegDZUwKZVuJLzwZk=;
        b=GpAeo1n5ajGjQfkLIl8Kvr/q78eOkkcvI82lSd9QmSffzeLCFt3zZsIYS2qIfYDyQD
         tSg14V649IMRO6O+jIGhHaM4IpVaTz9eizz9y11mPeslWYdfDU1Pu6jzb7XbpAigxItD
         6jCP5y7d+WJcuPFcuLOy2NbK/0TiEsXVpRRY2T3sSw8op+ZQ6gpJYEaUJoSFPAMIWxAk
         LvG5gA4PcaVQkHK03rQEldmg3JTTSzESsQ9qfOH9Oxp7Zw8LdK9+Xqg1x0sp7p5E/p+Z
         W+NN6/ML8KGRbU5rh1xnCi96S6+ZW9kJWc9jpwhg4kk2oZye6ihihp6dbR/l9q37lCdX
         Y1ew==
X-Gm-Message-State: AOJu0YwExu4A9zfelFuYhLKC1M9fQ8Q6yj19uQj1kUrKA/EXwSU0PthW
	HFLgDNQ5tIOWRcYYPnAgT71Vfz7kOw6LODQAbDJ/7kDy5bC5bjR+eF43
X-Gm-Gg: AR+sD119MYlBD1xColJeFwx6tXjFl5bdvEDXphslMEDvQB5/PHr5joKEvSypRKGcCbQ
	cQoIi8NtG2PPhZ15C6AFv1QKG6PZVNbjPlvVu3mLQaIP7tDWB8CcGGGqSNYjwxHVTUAYjp+EpCx
	J/AclfPCdPGZD4ZMVh92JB/LA9MVLKNPioJo9GJtfQQk1OPbrczGQw4Mk0Are5SSqzQLDBfYxMy
	yoYNrtmWhiruUkAkpjWnhcJBlbOgI8fbNr9NA6Jn3HqWGiX5OQFjFcAQEBOXSgnibyA6udNZemM
	KePtLsivAH/nK6eZhzxjjEiw6B1e8eWve/9EzzTZEe24+9ErJnnWpKHp08ShE2E0na8Tv2TYviB
	NP2gq74BoqKASE7XyQBiv3lnOU5tpIENAi4EwvueC3h1YX1aTAoCTlQLVBPVq16XCVvNxEmtYOK
	ow5xNdb2fKGaDGeCRZjVuuKwpf4XK/lJqibChs/Eei/i+Lr6fUquDoAl73Ws+64v99d1IoOfs=
X-Received: by 2002:a05:6000:2483:b0:47f:90f1:68c8 with SMTP id ffacd0b85a97d-47f9cdaf542mr1184583f8f.1.1784903506416;
        Fri, 24 Jul 2026 07:31:46 -0700 (PDT)
Received: from labdl-itc-sw10.tmt.telital.com (static-82-85-31-68.clienti.tiscali.it. [82.85.31.68])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f864305f5sm23898298f8f.17.2026.07.24.07.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 07:31:44 -0700 (PDT)
From: Daniele Palmas <dnlplm@gmail.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	Daniele Palmas <dnlplm@gmail.com>
Subject: [PATCH net-next v3 0/2] Improve wwan qcdm compatibility with user-space tools
Date: Fri, 24 Jul 2026 16:28:16 +0200
Message-ID: <20260724142909.3270824-1-dnlplm@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Historically, Qualcomm diagnostic port was a serial device, so user-space
tools were developed using tty specific features. One of the most common
tool is, for example, ModemManager libqcdm, available at
https://gitlab.freedesktop.org/mobile-broadband/ModemManager
which requires tcgetattr/tcsetattr and the possibility to get exclusive
device access to properly work.

The wwan qcdm is not really a tty device, but, besides the lack of tty
functions, it behaves as a standard serial Qualcomm diagnostic port, so,
as c230035c2f2f ("net: wwan: core: implement terminal ioctls for AT port"),
this series add support for terminal ioctls also for qcdm ports and
implement the exclusive open mode feature to improve compatibility with
user-space tools.

This is an incremental change which should not affect the existing tools
using wwan which do not rely on the implemented features.

V2: fixed race condition highlighted by Sashiko at
https://sashiko.dev/#/patchset/20260717081935.2071083-1-dnlplm%40gmail.com
V3: simplified patch 2 according to Loic's comment at
https://lore.kernel.org/netdev/CAFEp6-2UiSja11A6nLKqRX8A1eE=P4euEs+fbpKZxPE8fTX2QQ@mail.gmail.com/#t

Daniele Palmas (2):
  net: wwan: add minimalistic IOCTls support also to QCDM port
  net: wwan: add exclusive open mode capability to AT and QCDM ports

 drivers/net/wwan/wwan_core.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

-- 
2.43.0

