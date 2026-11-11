Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.188.251
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794439261;
	b=pUgNCCPTMpyBhIMpUq1D9PSicb3t4vf9OohYdoChLcef2hcVGHh/07d+jsvjHr1ui370
	 B18rJMhgM+SpwD8PW0cziAM2oWbtlP2rVFBHmhaR7Nt8OUkR56g4iuMnnb7cNWlQr6r/O
	 +w9D/PyyDQA8ipsucHQS5bHOS7zjwu+rwG2NEGjdFpi4KO9C50aDonxpT5VdVNzmUy/t7
	 w0bJukX/mMqgsF4tk0EIZxlICMLGRaDhAE+c5ZJ1552zR7oMkfXzJxLUZBSoOS/CNtWzs
	 Ej5gGhz01i4WTDtxh3a3aYyIThtVT0h95SOasxaeW8dfUL6QyNpN9X4oanR8NJgQeLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794439261;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-Get-Message-Sender-Via:
	 X-Authenticated-Sender:X-Source:X-Source-Args:X-Source-Dir;
	bh=Pcu/qurc8LOzKOzYvBAZ4lc5a9bQj8hHVRwsMcQj/pQ=;
	b=UF+m0+NkQdUAD3fOO5mFFGF69pADyjZUSOTOIA1C0gU2jbIpkp9pMtaiveVgLJTSErjn
	 YMW4ESH4MYNzSblC0ten0axBTD/2tTBgmFp3/1PgKkzgbSEb391iRfrgwwluJxuog6QKI
	 FzFj1kKiK1kWn7rnP+xNPnFDtcuhioGiajY7kQh3hdMJ381O85WD62x6IQG9Q1nW2CQQT
	 yonBo4qwum/AUgpoX5PTkKwwAIutmt56oRqahpmCDmG303DA7MtAdQyxZ9s5pllZpywIp
	 GzmuNvFokaIv0uCbl4eAxzz4wnCt9xLAaiap1VGPTYZ/UVmRapTFaZ/ziEdBaSZxkjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cyber.gouv.fr;
	spf=pass smtp.mailfrom=oss.cyber.gouv.fr;
	dkim=pass header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=MOrLFFQX;
	arc=none smtp.remote-ip=51.159.188.251
Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E19606A321;
	Wed, 11 Nov 2026 23:21:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3E19606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=MOrLFFQX
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Sender:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=Pcu/qurc8LOzKOzYvBAZ4lc5a9bQj8hHVRwsMcQj/pQ=; b=MOrLFFQXMLUTdjwXLUQaDfq8wz
	5DDlGpQPvH09hAh6Ig1NQCw+Z3RIhmXzUWMbRTVuPrC8xEnHla+xBFCHwyX96VswsVXaiRa2XWFHC
	HZafAPZBGj/t7259i40LI2aB0x13KtrfQ9qETdOt3/kHDtq7z7L+YRvJGJb27Qg4V4cw1CiOZ2GcS
	gfjR2pFcUuFJDkLDjgFlqU9dJP1/chcFdlU3e2x1JD4bnxEaFIz4JhEFqNGAf9DVenVPVpoPABtt4
	twi/nhY6F6DYTwmUPU2Rcn2cKgErHCAzvrrS5dnyII3D605bB2Rcc/VFocWzHTSOP7T7HoWLeHSjG
	Uu4k4bBA==;
Received: from [151.115.150.205] (port=46196 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1xRHcg-0000000EP1N-43OM;
	Thu, 12 Nov 2026 00:20:57 +0100
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
Subject: [PATCH net v5 0/2] xfrm: fix IPv6 atomic fragment policy handling
Date: Wed, 11 Nov 2026 23:18:51 +0000
Message-ID: <20261111231853.2504833-2-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

This series fixes two IPv6 fragment issues in XFRM session decoding.

Patch 1 restores upper-layer protocol decoding for first fragments.
Patch 2 restores ports, ICMPv6 type and code, and GRE keys for atomic
fragments, while leaving them unset for real fragments.

Changes in v5 after a review from Sashiko:
- Patch 1: unchanged.
- Patch 2: use the IPv6 walk offset for transport headers before
  skb->data, preserve flow-dissector offsets otherwise.

Jérémy Jean (2):
  xfrm: fix IPv6 first-fragment protocol decode
  xfrm: fix selector matching for IPv6 atomic fragments

 include/net/ipv6.h      |  1 +
 net/ipv6/exthdrs_core.c | 25 ++++++++++---------
 net/xfrm/xfrm_policy.c  | 54 ++++++++++++++++++++++++++++++-----------
 3 files changed, 54 insertions(+), 26 deletions(-)
