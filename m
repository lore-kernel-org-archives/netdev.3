Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8B8428473
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 15:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782921407; cv=none; b=sbG5GB9Ck83je/whBJi7HQqlB5NGowpiUL/3dWQGrJeM5deEjmJrNwKmsxYk/QY6OIfT+1clkl1HyUiz9X5s6TZeeFiIPI4uZ55cXmdtk4R4eipoLYWjB8cNe5HbxAmxgudQzpeFLcxuVhB64rTY5/0PAYF/MoDZgKFRO4f8r/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782921407; c=relaxed/simple;
	bh=57ey67hWvO5U/kn0nxlQhqFzPN/Dxz0QYwEsRDD0uB8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BcPAtpwP3m0XR5B2GS+TEXJuPHRITW5SRuUT5T16RCDzAN6nP7W/hSaAaJJY8stdn1GOmLhuh0dwge5uywuk1ytHN1hHyr9zsgV+0zRaK1tOOhuW7CiWavjlBm5nWAE2FrKahhSCmB+G9SvBCa3kSj1Y9QOtVRG3sa3sRwReDRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JjVYmzOw; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JjVYmzOw"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-37defb2f231so381239a91.2
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 08:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782921406; x=1783526206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C9PL4axf2RFqD282BjFUYGSKthclDTO+jjsbE8FxL5o=;
        b=JjVYmzOwH+f3PRsm80S3rBWqER8gxGo3sFtIwagEC1wCLNUrCUO3A4NCd+lHe2Mfsw
         juO+vPNfw4dsizo8MIrPdY8CznwFbIw9onPUS7Wk3VhM3aWSxBibyRKMIXjqMKKtR5cO
         vTgqoGJBsTh+HgEGckXBIN4xq4xrOWcI3gqgI+i5zMAPeIbx8dheFNYopnIrY+rWAEH5
         0kQbs36mH6tAVfikJgbbfw/YCFSlHy4fJ2lCsZ6lXrj8tQGXmak0jCASlU+B1Fow0XgP
         6QrxNE1cMLTxMS0Hu5zdaneR9qVO1a0aR1bXVMk2xQ9TWHXPCDQocTyPVExYcWKtGE1b
         AvYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782921406; x=1783526206;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C9PL4axf2RFqD282BjFUYGSKthclDTO+jjsbE8FxL5o=;
        b=awdPS9QbpweKv6Up/YyjTc1uWUQZFuCJcNs5hgLWlnnYYRbHpgVcz5KOCnTD5raDHG
         SMGgt9SqwEYFCGjUA2QkE0v+hCh+2eSAYgP6o08rDNy4hFAA++O/cgz3C5i6cFUhPOfI
         yQxsYMPMAJmLsSDK2NRggE4U0vIRj2c42iSkWY+s83nD0vnfry8+QOdSAzJmFrEn740d
         vnCIJumdmD71cZ/z3wClxcrGVP0Axm/VkwWoZoYdmfb9rh+tmX+8rqVGAdQeJdYy+tDp
         1qZ+nn+sXwkIIp6AhNmXZWTxmwYwNxtWj+Gw8DnbNBm3zjWTp3CqY0DUUoDHyTx3MsLk
         FqjQ==
X-Gm-Message-State: AOJu0YyjGQoZIkXjPZ3RGuZsTn/AYtjhQGj56AN5qq0r+6jy3blUhefB
	D8Jx1LcV/cjFJXevApdsFHaJaVuc8tdDh9hQUWiQOpOzbhw95NL2OQll3PxMvWhN
X-Gm-Gg: AfdE7cnK8zGOfzXOvFsO8iko5dR7WSKi6Z2aA4EGJOVNp2Kllg0d/yX9Y6lOwa97SbI
	N/YX/cu2/rDr3sgN0zEI+gBFohYgO2PBN+RjZNy5pPtzh3aLQI0m5aD+6OsT5oRzab0u9b3DUW1
	kApjkzHy0DhN/L9d0qosh6JwtaDB0fbEytg4uL4FszDtTL9W1GUFNQ+h/WvGAjyn3mZjx56If66
	DrATlzf5Nb+5wsBrbAk3+uQMjEcAlIDnTDqADeHdtXlfeLzlmrzCP4KCdh+Z9DRckUwekhvb6Dq
	fW3erVqk112mvolMKDHcXaEo2zGy6B7OSyx/ArQ0jE02vjVusGXN5Xc3Vpnppz7Rhhv/S4VP1yg
	szhu4QpHUsP/VxfFDS1tpm6CI6jZwtyB5B59Y1sqYyFyVgFMT8nvj1CKylptnZWOADY3vLyTw4a
	BJsI9/u4XvzZyGv3/JO9Wize2ymn/4mlPFdo75pw==
X-Received: by 2002:a17:90b:5206:b0:37e:1430:769b with SMTP id 98e67ed59e1d1-380aa1fbf23mr2123971a91.24.1782921405783;
        Wed, 01 Jul 2026 08:56:45 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76a0:d30::4cf:38])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-380ce0cb40dsm142785a91.13.2026.07.01.08.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 08:56:45 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 0/3] net: dsa: motorcomm: Add LED support
Date: Wed,  1 Jul 2026 23:54:03 +0800
Message-ID: <20260701155519.273212-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2: https://lore.kernel.org/r/20260629183137.541341-1-mmyangfl@gmail.com
  - allocate LED structures only
  - eliminate double locking
v1: https://lore.kernel.org/r/20260618202716.2166450-1-mmyangfl@gmail.com
  - set up polarity correctly
  - do not set up .brightness_get() to prevent dead lock

David Yang (3):
  net: dsa: motorcomm: Move to subdirectory
  net: dsa: motorcomm: Split SMI module
  net: dsa: motorcomm: Add LED support

 MAINTAINERS                                   |   2 +-
 drivers/net/dsa/Kconfig                       |  10 +-
 drivers/net/dsa/Makefile                      |   2 +-
 drivers/net/dsa/motorcomm/Kconfig             |  17 +
 drivers/net/dsa/motorcomm/Makefile            |   5 +
 .../net/dsa/{yt921x.c => motorcomm/chip.c}    | 218 +------
 .../net/dsa/{yt921x.h => motorcomm/chip.h}    |  14 +-
 drivers/net/dsa/motorcomm/leds.c              | 586 ++++++++++++++++++
 drivers/net/dsa/motorcomm/leds.h              | 118 ++++
 drivers/net/dsa/motorcomm/smi.c               | 157 +++++
 drivers/net/dsa/motorcomm/smi.h               |  88 +++
 11 files changed, 997 insertions(+), 220 deletions(-)
 create mode 100644 drivers/net/dsa/motorcomm/Kconfig
 create mode 100644 drivers/net/dsa/motorcomm/Makefile
 rename drivers/net/dsa/{yt921x.c => motorcomm/chip.c} (96%)
 rename drivers/net/dsa/{yt921x.h => motorcomm/chip.h} (99%)
 create mode 100644 drivers/net/dsa/motorcomm/leds.c
 create mode 100644 drivers/net/dsa/motorcomm/leds.h
 create mode 100644 drivers/net/dsa/motorcomm/smi.c
 create mode 100644 drivers/net/dsa/motorcomm/smi.h

-- 
2.53.0

