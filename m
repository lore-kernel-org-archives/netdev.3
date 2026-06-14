Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352BA1CD2C
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 10:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781432779; cv=none; b=d7Vsgs6TJ5JJHxRYvDnz1LAlQYhIfMC7lDy5Jfda3P1V4dRrfzs96kP1AilRoAAdtLcWkQ0jmpZyH16Ctgnl6CH6WFsUR52YV1T5iIJLbkFEEpJ13Z3Ax/FluXoTBCeJKGVkCxrLmXOURqaeq3C0rsJfrL2vzzauaxO2VZNJies=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781432779; c=relaxed/simple;
	bh=LGxlUHvm49zlmH3DCeEICRhQwusGrsHuTiREnJ7QZrA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QqHqfZUNuA7jYLMQCmWEvvYOMXjU33KU+5xgZSI2IjNtwUPOPH4l+ktMuwGO+DZQ+OFn94jGF+1W/MhdOWPnd5Jo8zHuouV0x8Fg52thYIdUhYS1Kyf1+DKIayblA/9xEsMLdlu42JQt5+QOfwvsp0uhJc+s9OCqC8q+kAU3sfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=W0pPurYD; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="W0pPurYD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=Zxs5Ovly51mb6oje983rn9ZnoWy+J/eSB5IqeJt3VLU=; b=W0pPurYDNnKm4KGPkUfMYZ2jn/
	3b1ilu7Rgbz+OGoXLH4dVP+i3v1WY5sbLi6dvUiAVoG23GjRxelTeT8V5MLcb4b3JQAt2Y7hnqfyS
	HhkyxvcUk0B1WWGRa570/T4bRX1l8XSWF9bXmdB9BVWQXlsbUM9ecFUm01LhWd/9QlcL6IlqMFJTT
	Gwh0Q3Hd2u4/EkHibsdjmNNvXVxydKhKrks73Sn9ugXfyES5wu89qHcx0RRDAoDgE8kL1u7wJrzfV
	aCvU/cZpudVL/3MgeVkproJV4Fj4D+ASqzJguFs/DRY7Yng4Q1V22aiUXgovHeB19lKrRmp8DjapP
	5E+Fcn7w==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wYi2Z-000Ngq-2w;
	Sun, 14 Jun 2026 12:26:08 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: kuba@kernel.org
Cc: razor@blackwall.org,
	bobbyeshleman@meta.com,
	dw@davidwei.uk,
	netdev@vger.kernel.org
Subject: [PATCH net-next v3 0/4] Extend netkit io_uring ZC selftests
Date: Sun, 14 Jun 2026 12:26:03 +0200
Message-ID: <20260614102607.863838-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28031/Sun Jun 14 08:35:08 2026)

Small follow-up to the HW net selftests, in particular to add a
selftest showing that also large rx_buf_len for io_uring ZC is
supported with netkit queue leasing.

v2 -> v3:
  - rebase to latest net-next
v1 -> v2:
  - Switch to cmd(..., ns=cfg.netns) (Bobby)
  - Add mp_clear_wait for large rx_buf_len test (Bobby)

Daniel Borkmann (4):
  selftests/net: Move netkit lease hw setup into per-test fixtures
  selftests/net: Use public NetDrvContEnv API in nk_qlease fixtures
  selftests/net: Add netkit io_uring ZC test for large rx_buf_len
  selftests/net: Add hugepage kernel config dependency for zcrx

 tools/testing/selftests/drivers/net/hw/config |   1 +
 .../selftests/drivers/net/hw/nk_qlease.py     | 300 +++++++++++++++---
 .../selftests/drivers/net/lib/py/env.py       |  10 +-
 3 files changed, 259 insertions(+), 52 deletions(-)

-- 
2.43.0

