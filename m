Received: from mout-b-106.mailbox.org (mout-b-106.mailbox.org [195.10.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645B7485934
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 09:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790586127; cv=none; b=dZb7Wrzz1Hyiy5smVL+Wz45N6HXa/OLg45m3zn0JBLzFRenTLxEFz5rEZy8Fey2O9iQA4BSJwKCGSZJU3ngBqGM0v3rbd8VvQrhwQLbtSkJbu81BRhHnOM9NHuDkdWo43BY293B5jdI44MsCXUO9k2ZMrOCbJ5GEM6Vqvv96Fhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790586127; c=relaxed/simple;
	bh=KpDbosgzFURQlG4Re7sBNnDrAAwCRcvEDfEtveW0l70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O+Fz8stAJdR1J0b5f24CewjSmjewc38x0w/x1dxlfxoYFyP4RkyWiEcOzBDIneADWs85PGcn4GKcVny24UROjesq1ajQptxWEkq1YB0ZKOnZ+jH+lo5lqGqoDAWSjl+a8ErmbL8w/IEi24L+5QASQtmy+ZyIXl3RW6ah/GR+kQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=zu+VZrmW; arc=none smtp.client-ip=195.10.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="zu+VZrmW"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-106.mailbox.org (Postfix) with ESMTPS id 4htZtT0Wg1zNll4;
	Mon, 28 Sep 2026 10:56:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1790585809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pQCXLeyQhc4kKC3F89Lil+fvvhoG4qFEfP8XB0RWdYg=;
	b=zu+VZrmW6pFDW/nHHkp2gXkbV53MfOedf4bHgYXI4JANzsJEAJr4ty0Gc0iv4m0N999Ga/
	o84WWmf/hYPtrFrMOGOwSHv1RAKQ24XUZDKK9o2sgNBGJ68zmyvr6uXR5nh5sEAIvjvXPL
	frme5P4fEvoWceiIJsqHh76pdMBm1QxsYntwHaNz9la3g2ZHZ65sCq3H9yYPuonbclh4hS
	RdnBdpyYbJnOuVh3s7oCqYIgLR6RLNIF1N0UEdtAPAYKaGAXIbbWtVti/3W9KXp9zzMp5d
	6p5KQW5k/e/TfZHFnL+3PxYABSq73v/U070K6Ouoofy2Zr4NHHvngAucUtDLvA==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: Ralf Lici <ralf@mandelbit.com>
Cc: David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org,
	Antonio Quartulli <antonio@openvpn.net>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>
Subject: Re: [PATCH net 1/1] ovpn: avoid caching stale IPv6 dst after FIB changes
Date: Mon, 28 Sep 2026 10:56:38 +0200
Message-ID: <20260928085639.151005-1-ralf@mandelbit.com>
In-Reply-To: <20260918202718.36933-1-ralf@mandelbit.com>
References: <20260918202718.36933-1-ralf@mandelbit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4htZtT0Wg1zNll4

Hi David,

Just following up on this. Does my previous example clarify why storing
an old dst with a new cookie defeats reuse-time validation?

If so, would you prefer that I pursue the kernel-wide lookup-provenance
approach described in the RFC, or keep the fix self-contained in ovpn?
The same late-cookie-sampling pattern is used by several drivers and
callers in the networking core, so I think fixing it generically is the
better architectural choice.

If changing the generic interfaces is not acceptable, I can rework the
patch as an ovpn-local fix, although that would duplicate IPv6 routing
details in the driver and leave the equivalent pattern elsewhere
unchanged.

Thanks,

-- 
Ralf Lici
Mandelbit Srl
