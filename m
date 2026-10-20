Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792455962;
	b=cQ/+pki/wv641oTZerKreElTwVMrKD4itdNaqIvp5G3taUs/MFgY/OOuceQikx4nXdFr
	 lv8khZ75pXkUSjhJWEUTZwHQwnWg7g0PfB7EYnBArQubwAUafbJzq0JXsu3PUzR4+A7xc
	 luP2h+nIaGP1BOCtPWdpO1aeA1rhAy8Z6Kxlm0ZCOlrjHtIfhR4edspnHAeqffPjiaYL1
	 fcNvz7UQhre8is38Ub4HlwFh3DFUZXddPn30IQl4wchcJ4a5+4dI4MvOj1qrtUC7J1gZR
	 YPYE8Av1yHCThogNb2Y2Ba4VuJKBwldKnisLuJ4wgPrzmITrjcNS2ng5qda0efFJfAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792455962;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=AjWh4JhuzhVnE3zyAcaivyIWZxR4nepC/Fj6RmaJ8Uo=;
	b=cHs7BrQO/UnYlSKharr2jPYlJw+0/Gx2B+S3slLgK+kb51igawzipznBbg/0FanVojy3
	 HPOSKd2aXQX61/JAUB/yNJFLEUM6vUe8MCDBSU+7exfjquSQYIx5olZ6XV1S42pyNcOQv
	 H2BdNg1QE9mlDsj1MW4Auv8H2+HWA4AAHdmZSJ+7HfxEW3OB6ytb8nXVmc9plsqaoMx3w
	 3lMhC+pg/r0foHot7wfQuu3Draa0MoRaWYTsMRsdcGRqYjLLwVOhgiD/It2aAIjqJh/Ru
	 vPCochf2BuzAhQPaVnz3HxT3QyG3vvYotIRsRSacZLlMgwtSRvW8U0ygPKMW8qRwHUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=blockcast.net;
	spf=pass smtp.mailfrom=blockcast.net;
	dkim=pass header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=nfpj9EY1;
	arc=none smtp.remote-ip=74.125.229.5
Received: from mail-dy2-f5.google.com (mail-dy2-f5.google.com [74.125.229.5])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A92606A31B
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 00:26:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7A92606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=nfpj9EY1
Received: by mail-dy2-f5.google.com with SMTP id 5a478bee46e88-3535a54c09bso2419743eec.0
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 17:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1792455961; x=1793060761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AjWh4JhuzhVnE3zyAcaivyIWZxR4nepC/Fj6RmaJ8Uo=;
        b=nfpj9EY1gDxC9/qh0zc6v9MX2kifMaYDp9aNP8AHWUta+3q/P0Qksv8kc8QOTaqW5H
         1icUjqoQczIXLtQ2STeafTK8tppIkTayvtknFC1a/HYUfKGaufFZ7Fpl3yTbadUvpkoY
         5V6/a829N9LECG0QPIsC/+pfK528UyJnCAlO+nBx0xtQBraRdaIx46DFbU3wi66P91B4
         jL7fCLFXu8Law6Qg6d0iUOWlKCgrUNyL3R0gg5IOUuOfvyodCw8kiGP75urkGyjHn4NJ
         mPTuSvstmVi9qa2isk7MZ+U8CyDFaPv1HD17OuZUcI7UgLlki4/TXnjB24GcOnrUebD8
         5ANg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792455961; x=1793060761;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AjWh4JhuzhVnE3zyAcaivyIWZxR4nepC/Fj6RmaJ8Uo=;
        b=AGcaoVOyXqIMZuUqzaZwOQXCKUpGt5Ggxo1zzGPZ9IvaxWvcEUeHD/YpXz56gEmoPw
         H+lN7vn6ycLezw13cDBuvoM2DyRHj+/fG+u1TVci9A+devYTQIkaIn+zDC+9Qm+S/iti
         y1mlcBien/1NGVrVjrR1yUd3Zss+z6x02QKwheEUkxhGu0EEZVhjbb3Dhi2UnGljNYvZ
         iLS2lPsyDRWx9J7aGLfuZ2sStt7/C+bDJguYhozkjxeC5R/befmljdZgOAy76nTPfd/T
         5fZVB3DEE60pt2yjnh8K2VsV9As5Es23aN3C5l4aOmUNZSUCTvpdX8FTXi4qlf8dRcu7
         IWZA==
X-Gm-Message-State: AFq9FYIgDxkoNf2zpJ5oKR9RPGOUHJYRhHrY5jpkogw97j8Lv3bbaOit
	HzI68qVZZ7s1mE4oGRJspNrWnKrnNRQzzR6N11kZkuMsnEREQ1Pj4clxBYJD1Hn8yJI=
X-Gm-Gg: AYBFou0l76e2cF8Mg9Oz5+ad2OSVFnJmL4I9Vc+BY6IhME9KbISDn07lT6/Tl12H+P4
	Ur6PP2QrkOmnhjmKXyP1kddvBckZjguvtDAhxjawUMEusm/GmH3R2If6PN7Zfn0LjSxtg6WjLNu
	GMDHMGrLsfS9rJrG1m1KuiD8wxKX5S8nz9DftVR65f6xq/ordhryu9dBNjD+DVTo62ubm33y6GE
	drFuXhvVsNXj09aEjBfYXuaCxgQrHfHSliKQbJiRwA0OAReeJrTCo8J7EVq8q8l6MTVwPUTj9gN
	rVujG2pguKzmodHw9Aqn20zJ+51EW2nFolfU1VJ755YKCKJPiTiYftN5+w90X5z7AMl7w+4vhQv
	7FICm3Af1T/x6iHQr9He8deZuF9n3gZATY96cLMKwAoH9eSH7o+vQLL32FL2o9XczvqGOPloOtw
	zKFEdA2VozMdryBjvwQrl4GCfDkcsyac8YtDiFARIzagCwVwAb8Gr5Cy4ouKWpNjRdIS7kFOH6G
	lJb2CGCDMaburN7bqJSioUA4idRrG0CTYcPZczEIofK1/IPW+A58LwBr5g/TBfF
X-Received: by 2002:a05:7301:1522:b0:35b:244b:ca8c with SMTP id 5a478bee46e88-361a23515eemr14210448eec.33.1792455960694;
        Mon, 19 Oct 2026 17:26:00 -0700 (PDT)
Received: from devbox.ts.blockcast.net ([69.25.95.32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3608258aa66sm44748072eec.20.2026.10.19.17.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 17:26:00 -0700 (PDT)
From: Omar Ramadan <omar@blockcast.net>
To: Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net v4 0/5] amt: relay tunnel lifetime, validation and request-path hardening
Date: Tue, 20 Oct 2026 00:25:52 +0000
Message-ID: <20261020002557.3984927-1-omar@blockcast.net>
X-Mailer: git-send-email 2.43.0
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

This series hardens AMT relay tunnel lifetime, validates gateway input, and
keeps unauthenticated Requests from consuming relay state. The fixes were
found while reviewing the AMT IPv6 outer transport work; that work is not
included here.

I am using the existing IPv4 AMT relay and gateway implementation in a
multicast delivery network, where gateways on access networks send IGMP/MLD
membership state through a relay to reach downstream receivers. The fixes in
this series come from exercising that deployed control and data path; the
series does not claim to add the IPv6 outer transport.

The first patch closes the gc_wq re-arm use-after-free and makes teardown
safe for RCU readers and delayed group/source workers. The second rejects
Queries and Data from 0.0.0.0 before relay discovery and revalidates deferred
Queries. The third requires exactly four bytes for IPv4 netlink address
attributes. The fourth makes pre-Query drops visible, avoids counting
successful reports as drops, and uses concurrent-safe TX statistics. The
fifth keeps Requests stateless, authenticates Membership Updates before
allocation, keys state by address and port, bounds per-source admission, and
silently drops failed endpoint admission.

v5 changes:
- Defer group/source node freeing until their delayed work is synchronously
  cancelled, with separate GC links and owner-pointer invalidation.
- Preserve the original GMI expiry for Request-only intermediate tunnels.
- Document deferred Query revalidation and rewrite the patch 5 message to
  match its authentication and admission changes.
- Move the unauthenticated Request endpoint scan out of amt->lock and remove
  the ICMP response for failed verified tunnel allocation.
- Add the tunnel liveness checks to the lifetime fix and restore the dead
  locking comment.

Validation: GCC W=1 object builds with IPv6 enabled and disabled. The full
W=1 build is blocked by an unrelated existing unused-but-set warning in
net/netfilter/nft_compat.c; the AMT object itself is warning-free.

v4: https://lore.kernel.org/netdev/20261013175407.947606-1-omar@blockcast.net/
v3: https://lore.kernel.org/netdev/20261012125943.558629-1-omar@blockcast.net/
v2: https://lore.kernel.org/netdev/20261009201455.1904698-1-omar@blockcast.net/
v1: https://lore.kernel.org/netdev/20261008003606.3666617-1-omar@blockcast.net/

Assisted-by: LLM

Omar Ramadan (5):
  amt: fix use-after-free when a Membership Update re-arms a freed
    tunnel
  amt: reject a gateway Query or Data from 0.0.0.0 before a relay is
    learned
  amt: require an exact IPv4-sized IFLA_AMT_{LOCAL,DISCOVERY}_IP
  amt: make pre-query report drops visible
  amt: harden relay authentication and teardown

 drivers/net/amt.c | 550 +++++++++++++++++++++++++++++++++++-----------
 include/net/amt.h |  31 ++-
 2 files changed, 447 insertions(+), 134 deletions(-)

