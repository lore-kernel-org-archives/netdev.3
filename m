Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21ED2F7EFC
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 15:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779809752; cv=none; b=ClGOQJl17qB9QfGwEm84qk5tDmPV7jfNUQmJCy24dA5HIWtKXnoRcIUvWGNRsJN9v12nUFqJnEpUWUEFfiHFoigX9VENRa8nu07SfDTnxpAfcsrIHf3c1P85aBDO0uHo/TxT6Y2ZgdDDpLY+wUJv62ZM7foDiAu7oALtGcVt5yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779809752; c=relaxed/simple;
	bh=UoCuzmBB83dK/LER91Ai/anaQOjvm5k84g0yAx4MkjY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=moDB4pAtnwAVok/cTeNdt8qHQcSopR9U4AegGKUGq1VT0Hra1+Mq+SOpOQIyfl/YVnSDWdguUC083KzgkxBUlmLEswKWoX2mMseMuNkg0bXXlzUUWxx9Hw2oybxoa27QSfuhSIFvtSFkoD2MDD4eopl8lS7tGVV4/JhSNLNoTJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KwsGTp8f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KwsGTp8f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C38371F00A3A;
	Tue, 26 May 2026 15:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779809749;
	bh=XDuAUppYRkvnLOtZZRx6YQYTHmfPq/arMOwRwzMrESc=;
	h=From:To:Cc:Subject:Date;
	b=KwsGTp8fcq5PdXKkhdovg40rHvyQ3DiTu3J9sHEwfYDEwSNohzE8bmUR5H8/oOE+P
	 3Tms4dsXT+k9OEKsoMwUxI3E7IprrdeEbOhhT3YGq48FSYKSDBupvT91mK4yctV4VV
	 32smillL8waycBYFctcxR/SqeRX7zeoSW6+dKlWGRxNCmA4D+1E89NFmQMW/Mb2HXS
	 Pb9la3qlUvfcq6Xx1ekYczk+qz9KHqCtMet8Yw/mM+hMxkg8LZKM3wik22rm8/HSvL
	 gQFsZlYlMvQ9PaakV7cIvCH8zaMzzL72Sq4aeHJIWR+YaFo2o2ZYEm/V+MdQrge57x
	 TYFRQphexnFuA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	o.rempel@pengutronix.de,
	kory.maincent@bootlin.com,
	maxime.chevallier@bootlin.com,
	haiyangz@microsoft.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 00/10] ethtool: more bug fixes
Date: Tue, 26 May 2026 08:35:23 -0700
Message-ID: <20260526153533.2779187-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Last week I sent two patch sets - one fixing bugs in RSS handling,
and one fixing CMIS / module handling. This set contains the remaining
fixes. There's a concentration of fixes around PHY and timestamp config
handling but not enough to break those out as separate sets.

Jakub Kicinski (10):
  ethtool: coalesce: cap profile updates at NET_DIM_PARAMS_NUM_PROFILES
  ethtool: tsconfig: fix reply error handling
  ethtool: linkstate: fix unbalanced ethnl_ops_complete() on PHY lookup
    error
  ethtool: pse-pd: fix missing ethnl_ops_complete()
  ethtool: tsconfig: fix missing ethnl_ops_complete()
  ethtool: tsinfo: fix uninitialized stats on the by-PHC path
  ethtool: tsinfo: don't pass ERR_PTR to genlmsg_cancel on prepare
    failure
  ethtool: strset: fix header attribute index in ethnl_req_get_phydev()
  ethtool: eeprom: add missing ethnl_ops_begin() / _complete() during
    fallback
  ethtool: eeprom: add more safeties to EEPROM Netlink fallback

 net/ethtool/coalesce.c  |  6 ++++++
 net/ethtool/eeprom.c    | 10 ++++++----
 net/ethtool/linkstate.c |  6 ++----
 net/ethtool/pse-pd.c    | 10 +++++-----
 net/ethtool/strset.c    |  2 +-
 net/ethtool/tsconfig.c  | 15 +++++++++++----
 net/ethtool/tsinfo.c    | 19 +++++++++++++++----
 7 files changed, 46 insertions(+), 22 deletions(-)

-- 
2.54.0

