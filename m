Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.188.251
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793996973;
	b=MKFzJqP9/s7iekI/JMeYirEiqJpWFzHtIiWG8W6FE+9JkZsGag9So8jMLYXZVBPlBi0D
	 LX73qp/c41KIqU75gAfMP4sWueCEF63WgdPYVpQr+2sKm6thUWc1NsQrfaN+/Pm4tCr9Z
	 WetK5jfn1zyORW+lIsQRmrRQsjHhoGUcHOD2xmRCFgMIUTFMIU8aaConIM3c41im//UDM
	 w+tz7L43yudXDtZE7lMaZy+LA1C3XF6fnQOLOeMTpF34MXCXqq/26cX1SsmtZ+p3uWLev
	 ncO6CYqzoyZhrp8Q3hWuMCuyxjX9MJo5gMrJQuwuASHi8FBr0syNfsMqOKgh/yMdn9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793996973;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-Get-Message-Sender-Via:
	 X-Authenticated-Sender:X-Source:X-Source-Args:X-Source-Dir;
	bh=LH81aPkbnDvZZo8DvAABTNQbDZ1akAYY8Sp5kZVJyb0=;
	b=FHSvcIvRgxOkVySI3lS4M7FcP8Zw3QaIuGxlfou173VlbGlt/wLGZ4cJc6jxgC+Nl9PV
	 8hdNai57mOUQDvzOF3f2fi2xoxWI/dZGhPLw0L+BYsLYogs28B+/m4uMZ9+7394cINk1R
	 epfd8OtUZwyc0kC/VXryfWaz97BBLbrnRk9lHxWBWfwMHBFgCeueLPazQtY3Ifwly5/DF
	 8zu+miDT52TReKBMLOiNU5yzPWlqyFlpXwayGkB9oHBSZUadknvllu0XXtZxDcAMdUdlq
	 HgTRlgBEPxLb7R/kK4OiooNHm83CQgZDK+OBSafnfpJlM8apy0LcROnh636x69G537w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cyber.gouv.fr;
	spf=pass smtp.mailfrom=oss.cyber.gouv.fr;
	dkim=pass header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b="JvtpcEz/";
	arc=none smtp.remote-ip=51.159.188.251
Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D66606A326;
	Fri,  6 Nov 2026 20:29:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28D66606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=JvtpcEz/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Sender:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=LH81aPkbnDvZZo8DvAABTNQbDZ1akAYY8Sp5kZVJyb0=; b=JvtpcEz/nYixPY5J8Jp5gQMmS0
	ZtKbKiGtsr0nniZ3TLOSy4IMonPGRdcdmp5mcr98tyD/IGifx1eQQqDkcQzlGXh2uXJ5jR0TI72Oa
	I+31XSmHwwru9wkhlRBZC+pu2wV063IClFeY4p7JyaXwQ1N6xE5f6dQgTmnN2CXjCVXYLEsVN3z7c
	zFc5BlISXNhGhCguXKHqkkpjdWb+34/CabJYtDcYR/6c1cJYBVbZr5ep5oMhQc5GvG4ALA00YSDAJ
	kOS3Z5zSv7SBHtxS+sgJ2x/I4rU4HtFa0E2tt/AtA2OsvTy4PmNfNO17QoH2m4OWhGOCVgS4KdF8c
	95eBSWRw==;
Received: from [151.115.150.205] (port=56674 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1xPQZ4-00000001I6n-2L0I;
	Fri, 06 Nov 2026 21:29:31 +0100
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
Subject: [PATCH net v3 0/2] xfrm: fix IPv6 atomic fragment policy handling
Date: Fri,  6 Nov 2026 20:29:04 +0000
Message-ID: <20261106202910.723098-2-Jeremy.Jean@oss.cyber.gouv.fr>
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

This series of two patches fixes two IPv6 atomic fragment issues in
XFRM session decoding.

Patch 1 restores upper-layer protocol decoding for IPv6 first
fragments.

Patch 2 builds on Patch 1 and restores selector fields for IPv6 atomic
fragments, while leaving them unset for real fragments.

Changes in v2 after a review from Sashiko:
- Patch 1: Leave ports unset for fragments with BPF flow dissectors.
- Patch 2: Include the atomic fragment selector fix.

Changes in v3 after a revew from Sashiko:
- Patch 1: unchanged.
- Patch 2: Safely detect atomic fragments.

v1: https://lore.kernel.org/all/20261101230745.2043474-2-Jeremy.Jean@oss.cyber.gouv.fr/
Sashiko on v1: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261101230745.2043474-2-Jeremy.Jean%40oss.cyber.gouv.fr
Sashiko on v2: https://sashiko.dev/#/patchset/20261103225842.3204446-2-Jeremy.Jean%40oss.cyber.gouv.fr

Jérémy Jean (2):
  xfrm: fix IPv6 first-fragment protocol decode
  xfrm: fix selector matching for IPv6 atomic fragments

 include/net/ipv6.h      |  1 +
 net/ipv6/exthdrs_core.c |  6 ++++-
 net/xfrm/xfrm_policy.c  | 52 ++++++++++++++++++++++++++++++-----------
 3 files changed, 44 insertions(+), 15 deletions(-)

-- 
2.47.3

