Received: from mail-oi2-f29.google.com (mail-oi2-f29.google.com [74.125.231.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE72B3655E9
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 23:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790119675; cv=none; b=cTJny8Xo0rwZ+lNFeJbL0S6MCuWvfGd8em2oo2m8mIJFRizJ0KLmQbHAz7YRdMwaHVlQ0srraOvpciVn4plyzcyAni6dzPvkwu/HOpN84wgxwygySz+NdAPQwTLfd8/3V0jq8LCW3O48Z2StVz90AXSH3VvQcYKxX57cN5SXNoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790119675; c=relaxed/simple;
	bh=0LGURl3KOzcIf/uzIsA7NYSodW43r248TxGYIjWU/fg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JJaD0Wk8yxIMtIWOVlvW+u47YaYaoBadrSXZUzRy5RtOpr/SQzlBQpSfmWcFsBU8xtsrbn4fjs5Tygyh7NKZBoJ7A2ZQWWT+x9B2abAjcDOSbKskcFPqsKlOEUvJNoE/RF7p3Z4UnGAzDqQ71uRF4QQjZ9jvavGeaPKbZ1rGS8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ji4TKtVI; arc=none smtp.client-ip=74.125.231.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ji4TKtVI"
Received: by mail-oi2-f29.google.com with SMTP id 46e09a7af769-8144632e066so299680a34.0
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 16:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790119666; x=1790724466; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jPMMzPerF76ev1rgt9IqVi5wI7uHr29cgpQnNd/IeQk=;
        b=ji4TKtVIPZb4cE3FS42ZRO/Js8RwqPH92vYBfi8AO3yqDCg8R33oTZa1EhI2h/Ortr
         Xy7MJjqZpJY3zCkt9wuvSTfVPsIiXMAf7wQkfApbn9l9bCLtblgB+njQi9tPmfWPvgWj
         osLsObRNF0NELIwBaJJqEwrdMhIg2m9qjl06H0nSTOQmj7r2TETgCGMcHpu5b/Qeazwx
         ManpEj245xTEsPlqmL2V+nvujeDF7U8x/cSfkdvrkkBQphqcBWvfZ9Ld6Og48faQUTBC
         8IlWM9A/W8OctToHMMLjEjJC3PG5ErfPuAUCfTi+HTpbOxANUOxNrMzoc0BZIs6kYmug
         3CDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790119666; x=1790724466;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jPMMzPerF76ev1rgt9IqVi5wI7uHr29cgpQnNd/IeQk=;
        b=lujTOAU1dxtlsGdyk5rorg1e7AxuY6f7T4m5vBMDGVvQ7ZQ7gwxhbzpX62z5XgHD/B
         vsWeOIpmlRahlBJ2CQ8rZ7Bs4lL0quL2YCaMRxwCce+TDJWMrtWTSHbFBW4jnDpXAjMI
         4ApV1+5xOrzML0LXKhom/UIcIyQUS94N+h/u/OecIljpDxqdaWFvwevC+hcbBht3hqbl
         Q4Yvfn8TDR5fdZerKxUjqU4N9BeBVq5YCSKsNTayO9jTS+BnzbE7U+5rI6HpkrfTDwcO
         ZtHrzk12168KohWST0mt/NZVWzJdXSyHyujhRpHyuw0zAc+T8YQC0xU4dTGJLHJ5PCYY
         G/pA==
X-Forwarded-Encrypted: i=1; AKwUvByHShbs5oFNrijau+0xi4L+RTxoOwNQjfwYQFvBinYHJesfEdH4KQwu0jS48X3I6YeCQPPCJI8=@vger.kernel.org
X-Gm-Message-State: AFuF++mhqRU7Z7iFbC3EOFjuii429yPJ1YT1N1DnImNK+2QrCSkrgvKy
	IEvvMmEVVSDQIKxscDFtnt6+CLoAODPNLcVD2F/PMs37XcSrzH8vAgwZ
X-Gm-Gg: AYBFou3ylBT3Pl2vJF6WPGBh9e6+3O/fjmUnETpkdrn6Y+bD8msKhfHKJCgpk4NjrUa
	9c2fSWouf7QNeiwMFV4ZBC0y10K5RZ01jsMByGDMsgHtifH0v21ejCpK7Oz+bLFLCdmuq99mguP
	Kl9lp3a1gNafkCK4TCPwfTyvKAJVRbfKRUvWsl5Hld0Zm54J2LpDuHfpvrRFDnYV/636okHHdmo
	rET8NTHXRClNiVT5mJuMb9Xq/dmMG5CVd51S83sQrldnHr/d+6RF6fwFWDgaYqHU1S/4+rFNirO
	KV0OxqYNUHVzkL+rLxv4N3Q8HfbBAZIgkXO/SBqvZVEotLW5vpLUuGI7+qMOKByFabClCGCzAgl
	JwfzBFZk4WE39LU9dfetTIz0IGZeiBUqAd2bVsKvQNmA7lIMKbceK376LXtwx8xjiTbP6PiO//R
	EOEj0f1sNqg7nv3tZQ7JKl3+id9XuCFuaVOeY+YgJclWohRhQUUdesIYBlg0Kgrm8WiOFA0Svud
	/FRfSWf8HVwqSDRJ24WxpX4cAYVtxXTdlWIEHXfSs0H4eNen4BYhzIkrbt6Pko3fJdmY0EEooGt
	1EJ9KkEKq8RyNOm+gvBp0oyS0mvtJqaeH9dhl6QbTJjE6lBzR49h85ktkhyHXXNY2qsRoCQAEP7
	g6XN6u1PYDyxPmX2XOtGegA==
X-Received: by 2002:a05:6820:308d:b0:6cd:3ffc:e329 with SMTP id 006d021491bc7-6d2d2621293mr774668eaf.71.1790119665547;
        Tue, 22 Sep 2026 16:27:45 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-81603fc87cdsm1243053a34.13.2026.09.22.16.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 16:27:44 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH net v2 0/2] net: stmmac: fix failed MTU reopening and
 hardware resume
Date: Tue, 22 Sep 2026 17:27:39 -0600
Message-Id: <20260922-submit-stmmac-reset-fixes-v1-v2-0-d92e609be996@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42OwQ6CMBBEf4Xs2TVtJUI9+R+GQy0rrLFgupVoC
 P9uwR8wmcvMTt7ODEKRSeBUzBBpYuFxyMbsCvC9GzpCbrMHo8xRWaNRXtfACSWF4DxGEkp44zc
 JThorb+urNa2xzkJGPCNtt0y4wEAJml+YIXfyaQWvtZ4ljfGzjZj0Vv7vX5bCunIllQdNpNS5C
 44fez8GaJZl+QLBbXFw3wAAAA==
X-Change-ID: 20260921-submit-stmmac-reset-fixes-v1-7c98b92d29a9
To: Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Joakim Zhang <qiangqing.zhang@nxp.com>, 
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Tiezhu Yang <yangtiezhu@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>
Cc: Richard Genoud <richard.genoud@bootlin.com>, 
 Alastair D'Silva <alastair@d-silva.org>, Maxime Ripard <mripard@kernel.org>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

Keep the stmmac datapath coherent after failed MTU reopening or hardware
resume without changing the interface's administrative state. An ordinary
down/up must release the resources still owned and open a fresh datapath,
without disabling NAPI twice or releasing already-freed allocations.

The phylink prerequisite permits an ordinary close to terminate a
suspended instance directly. Resuming phylink solely to stop it would
reconfigure and restart a MAC which has not successfully resumed.

The stmmac fix tracks running, suspended-with-resources and released
datapaths separately from IFF_UP. A failed interface stays detached until
successful resume or administrative recovery. XDP, AF_XDP and debugfs
paths which are not excluded by detach also respect resource ownership.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes in v2:
- Drop forced netif_close() and retain the interface's administrative state,
  as requested by Maxime Chevallier.
- Separate queue quiescence from resource release and use explicit datapath
  state instead of a napi_disabled argument to the release helper.
- Handle repeated suspend/resume after failure, preserve PHY/PM ownership
  until ordinary close, and allow a fresh down/up recovery.
- Check XDP/AF_XDP cleanup, descriptor readback and asynchronous reset work
  while the netdev is administratively up but unavailable.
- Explain the generic phylink suspend-to-stop transition and why restarting
  phylink after a failed MAC resume is not a valid substitute, in response
  to Andrew Lunn.
- Combine the two stmmac error-path fixes so every user of the new state
  has consistent resource and NAPI lifetime handling in one patch.
- Link to v1: https://patch.msgid.link/20260921-submit-stmmac-reset-fixes-v1-v1-0-87a4e431ee00@gmail.com

---
James Hilliard (2):
      net: phylink: allow stopping a suspended instance
      net: stmmac: keep datapath state coherent after reinitialization failure

 drivers/net/ethernet/stmicro/stmmac/stmmac.h      |  11 ++
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 116 ++++++++++++++++------
 drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c  |   8 +-
 drivers/net/phy/phylink.c                         |  17 ++++
 4 files changed, 120 insertions(+), 32 deletions(-)
---
base-commit: 17741334d00bf5ebd37f8c1c36bc9c146a351deb
change-id: 20260921-submit-stmmac-reset-fixes-v1-7c98b92d29a9

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

