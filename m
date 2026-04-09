Received: from mout-y-209.mailbox.org (mout-y-209.mailbox.org [91.198.250.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF35423AE62;
	Thu,  9 Apr 2026 02:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775702994; cv=none; b=dtEkRYaudX7R8P+aiAvwzSBGjkRWCvxMcDOEVflmNbWQq/4vXiaqrUdmn5OIFvK/GQsIQSPNvTreMx2H8aKur1hmOhedGyogf/t7YEu2bNYvNYcRlVmqRwBMCoIj8TuNE3OYUbUhZ3af7M32S9Awu3jvczvPYLHow2KZKZv+Ipc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775702994; c=relaxed/simple;
	bh=VDpg76iMCzf4+gMtwmFt572TNM9cHILHN8eYLf+KWc0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jupg6iY30+hR4h1FFHLeUtFgsgTweA0D50qlGbAAYCx57404jYnM3xY1ZmS0GMoSKMo3PQz//s3Gr8batmVEfz1bsIEenmRK802e8W32cTQVFnI6ASfLR4z1/2A3R3MsiSDlzXgkjuIE6i04nsZylsot9rprUs9lki0+09POm+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=iq8fWhmz; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=MvCZIK0y; arc=none smtp.client-ip=91.198.250.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="iq8fWhmz";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="MvCZIK0y"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-209.mailbox.org (Postfix) with ESMTPS id 4frktP41GVzB14V;
	Thu,  9 Apr 2026 04:49:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775702989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=b1kwRhqJY6Ur/GoyreVcZna5Az/OPx7qJRntuWs9ETY=;
	b=iq8fWhmzD4gCQir0nWRweA4iY4pWdtI2cwk4SjUx2wT2Yq7OP9S7YKWtnbAe25ltvybnsJ
	u40Z8gjU7vmx0souqfHjpFUO3/twNhLdcivAsaiavWJnEv69BsJPpnH2GVWUkFBT7L6toR
	itkiLOqNHimlKhG1072XuQk6J6hkxLySdcMNMiRm36y6Ryv8wHR8EXxbkLqRyAyo/xsvid
	yGVJb0rfOT7HMZWB3hCu0WUH+pUUjw++Qn/QYB0yI7gNp0iVmE3ey8Ej+pWez2ldlXsMHm
	6E1pJ8UsC7OF+fiMxldt6n7KOEW6P7H82tk1uYpZWCrsCd1lWqCilFgtY5Iu3A==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=MvCZIK0y;
	spf=pass (outgoing_mbo_mout: domain of mashiro.chen@mailbox.org designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=mashiro.chen@mailbox.org
From: Mashiro Chen <mashiro.chen@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775702988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=b1kwRhqJY6Ur/GoyreVcZna5Az/OPx7qJRntuWs9ETY=;
	b=MvCZIK0ymvWQN5Q0zpUSZ2cKOQGtfJ2pi/J2UVfBTcc/S9BZT8U21SxwN+lEQL4Xr7yP31
	kfjUTdbAT4ZrWN3kTUAmNHo2kXfy5ZxlO+ctQMPkhByNTgX98PUCqgYHjaC/7kWGhboh5A
	aLcfzwGzYcYdeVe44cbYhlV3bJScZwykFauAAnpBJC1Hefb9rFnpQmPffwh3HzSLknV+p0
	Vst+kqg+ckUglfzpUBmATqb+Aoj842ReIc5XiomI+o8nIZlrmzLNnMk8brVsbVehBMwqQZ
	eM+bMdJj41VXTTJBvVRiLMfLkl+Q38IsrWHLRgrN/CB9zMQzaIGzXLdY8FgXeg==
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jreuter@yaina.de,
	linux-hams@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mashiro Chen <mashiro.chen@mailbox.org>
Subject: [PATCH v2 net 0/2] net: hamradio: fix missing input validation in bpqether and scc
Date: Thu,  9 Apr 2026 10:49:25 +0800
Message-ID: <20260409024927.24397-1-mashiro.chen@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: uodpcbght8arxobjmodwb7iisesdkh9e
X-MBO-RS-ID: 8b14f452c988ab37bc4
X-Rspamd-Queue-Id: 4frktP41GVzB14V

This series fixes two missing input validation bugs in the hamradio
drivers. Both patches were reviewed by Joerg Reuter (hamradio
maintainer).

v2 changes:
- bpqether: no code change; add Acked-by: Joerg Reuter
- scc: drop the upper bound of 4096 per reviewer feedback;
  only enforce the minimum of 16

Mashiro Chen (2):
  net: hamradio: bpqether: validate frame length in bpq_rcv()
  net: hamradio: scc: validate bufsize in SIOCSCCSMEM ioctl

 drivers/net/hamradio/bpqether.c | 3 +++
 drivers/net/hamradio/scc.c      | 2 ++
 2 files changed, 5 insertions(+)

-- 
2.53.0

