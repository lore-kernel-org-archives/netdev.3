Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA71433F8DC
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 17:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791308000; cv=none; b=gAaY38zSgO7h5Xjah673SlnwVwsHvisirMwDV6itn7toQx2pTWi6jRSpwPCwANi/ae971oORv8iq4nY0tuw/0o0gSSlW/DpKBqYWXBIiNMNKzB4lzNp6RXCvprgI4qmloqnYBQh5xNhoZ4Ks56VDKZtwJqyQZoa1EI08EZoI8U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791308000; c=relaxed/simple;
	bh=H1lfUv8lZxLYx5JGsjCazmYH2gGjI45FEj2BuG/W9QE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u5Qf/CTgxp8Fa16EdRiJ56TE6PlQkWz3ts/S6SWiVkbLXAJ4uki2w7aFPFJfUckCuGdtu1F5MMwmI7kdl+0Lvm1EWaE7Psl5zEOET/rCzOUMCpZkBZz8X7yfkO6S1KUcWD8ky7PZS4JRuph7Tn7dtJMrPrDHQg/8chu2Q2Z9y7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Fz9ZY0OR; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Fz9ZY0OR"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48af4d4e61fso655295f8f.2
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 10:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1791307997; x=1791912797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vI/CREtYlaKCf7QQt+Wn+NAvceTNfQIZHGOmhJieQwk=;
        b=Fz9ZY0ORb1P2pCcSHH1kIlDpttDSuV0LwH7BU5/2eHKThNrWZNBvkRSOlxgq/SzFtK
         blI+3usjGrdZqS5g1C4lmx5unKWCCZzl3vMmuZwRsBG+OfjqdUooxOddd1bJPorvTdWg
         sI66JcU5SbRa5kMD81krBkCsv2yqKuL1TMEySu0P2xsVaDv6RmaNO/RQ7XUKvTW8t1y7
         2G0oizMJNdkmJNECJuT32S9HvkfTqtyhNb12izvha9AuxtNqh046TBNZNL78DRN9Cd4M
         qU7tC6iaKPQuQ0fCZ0X/eMA2tVtPc7LGIdsBo8CB5tMCNAH9ZexbS2ZIsYV6bPlaIi5x
         YxKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791307997; x=1791912797;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vI/CREtYlaKCf7QQt+Wn+NAvceTNfQIZHGOmhJieQwk=;
        b=eQuk6l32LygcSTpHUU1BgO8yeEb2nXeAs2jp00XPikwNDN38XHApHBiwJoTLaAkCnT
         FnTuMUR/zZuFrr9IaLyj4fXgKCYwv/qWeLKygJoqI/5bX8Ke5PzfkC7G9XS85qgbM+Oq
         5WuvG0aPnowkiPiyTyd22MEDF300LprT9WYAAdLfR6ZroPDBddL0FChRfFtZyDqNuv+f
         QIzGdqUSUOEtuxA/JuQfviE+GcNy8+HxYAAOdZ1oeFm0ysd5WAxxQkt7++/M1kp3SvEW
         kc7f9JE0Y8eZ/J2wEJP5lWuo4TU428HKMB9FqEHhApu1EZEc6i5Uu4qaYOiKuajIEzXT
         1OHQ==
X-Gm-Message-State: AFq9FYJH5NIklVgO4mgXkINtv+LXGhXySSjEFA2fE5dvWcK+p2m++XrW
	K6zi0L5FXIOqq3HqPiLMzjsQnUK2r+fUrpcq1x0TrFTG2LuttQdVcKSt/lOJnTdp54OsGcMkVSF
	3cioj7U3Nfw==
X-Gm-Gg: AYBFou1A+Kw7hN2zEj5vT2kOfkzow45fAXTJ1AnVmfCAM9I4btiV5pL8WHTdo77V8+M
	wy486WgwdYhQXhjoifIgLarf8jrqNxbyMbTf5HwuEtoW2mbpdVneFnR/B27Ani90d60QSX2Dui4
	GP03yKEvjC2lOjgejjizjTLzajLkqDt/e+m49wVWpLlwwX0s9RpErAgyzyPYFsetg2Nr0IjQLM2
	CdgP5HvAL63sA1zuUOtY54wSGnDgAufoGTfvMM5a7TD6Fa4kHq1eYY9IC2xOZuNyl4Y0sjaZfxD
	6rkM+0J+XxBje3VjjFHAzFoBYA+6SV++8ILj3Lfcl7RplC9iYWXbTnDeFzS6jePPho6K0aih/N9
	z7e/RmqYpB0mkz6n5SF79fYxmBaLeP1pVkcVxmw1g/qIHQBRETRzeSa8H+SC/5YQBqQgeXx+/oT
	Okh2riyv3asJ5aHwg5IR1JgWMFglAXCfjW+Igf4wt0pxrT7LzpM/nMJAMXX5lhiKozd49T6LMEb
	iE2HadYIwdhw00=
X-Received: by 2002:a05:6000:26c6:b0:48b:10c8:2180 with SMTP id ffacd0b85a97d-48c7279001cmr297088f8f.33.1791307997130;
        Tue, 06 Oct 2026 10:33:17 -0700 (PDT)
Received: from D90XRJJJNQ ([2a09:bac6:37af:d2::15:413])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71d1272esm714121f8f.27.2026.10.06.10.33.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 06 Oct 2026 10:33:16 -0700 (PDT)
From: Tianyi Gao <tianyi@cloudflare.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	toke@redhat.com,
	lorenzo@kernel.org,
	horms@kernel.org,
	bpf@vger.kernel.org,
	shuah@kernel.org,
	hawk@kernel.org,
	kernel-team@cloudflare.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	linux-kselftest@vger.kernel.org,
	Tianyi Gao <tianyi@cloudflare.com>
Subject: [PATCH net 0/2] veth: fix peer NETDEV_XDP_ACT_NDO_XMIT after GRO is toggled while down
Date: Tue,  6 Oct 2026 18:32:35 +0100
Message-ID: <20261006173241.65945-1-tianyi@cloudflare.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Toggling GRO on a veth device while it is down leaves its peer's
NETDEV_XDP_ACT_NDO_XMIT flag stale once the device comes up. XDP
redirects into the peer are then rejected with -EOPNOTSUPP, or, if GRO
was turned off, accepted and then dropped with -ENXIO. Patch 1 refreshes
the peer's flags in veth_open().

Patch 2 extends veth.sh to check the peer's flag after GRO is toggled
while the device is down, in both directions.

Tianyi Gao (2):
  veth: fix peer NETDEV_XDP_ACT_NDO_XMIT after GRO is toggled while down
  selftests: net: veth: test peer ndo-xmit after GRO toggle while down

 drivers/net/veth.c                  |  1 +
 tools/testing/selftests/net/veth.sh | 46 +++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)


base-commit: d5a007b9b457c915ab1a53227e8939e4018aa97a
-- 
2.55.0

