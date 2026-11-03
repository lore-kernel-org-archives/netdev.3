Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.188.251
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793746742;
	b=OjDO7aCygOhLiq+diZ2IgmztFLp21By9PRWyfWl4PFdv8Q1E5vbYgbgpWc0EtAjKaMb1
	 NPiwqD5O+6DkKNDSmoRoMzk4gu1rkkIRUv77H0hkToXBVScKB5TQseVC12phTiHbDYY2F
	 qmTUuZVWRjKoJmeG/BYRhN/Npb3ETsVkN2+Csoe0tTcq4EyVHdBbqLL7ut0avQK5cmhy9
	 wspzP3OMy1STn+zFKcVhscHwAw+MJfyF7L3bF9SuzEFNyrRU+tO5L+oDbMPDfDqt2NSat
	 QmBOul5RHsY00ZdoXpuD1oxIW3RDBciBOVP1Iz27N32t+8tGFQGCOh57AJ4YEskMonQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793746742;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-Get-Message-Sender-Via:
	 X-Authenticated-Sender:X-Source:X-Source-Args:X-Source-Dir;
	bh=kLBgHgSAv0ahGdfn3+Ux23ygUDOs1fRH18Z3UkUGkxk=;
	b=kmQaz+v/OIkjpgJMuc+AFnvzBE6rq8n0Klf83Djm6jpMMGRnMtg7JP/9U08tPAiwln+J
	 QG5Izl6q2bHoxcpukHSBNwO/YTrNnFAXnC6Os06lowpodVU8+rapdQFKWCsT6TkIiorDq
	 n/ox3gULI9bC6yqVs3m3E0tw5O+CqVaM3MDGmojdgVbur0JM7yglmwA1dLkuP3X9v49mx
	 tF02v4CKda1W83q5elYfKa5fL9pmbUeMYgkb11y0kIJ3VGQCgd5/xcn7wLfqBKPaVVglt
	 /7DAvuDdcYoY70guF7q+RoDfw4K79beRw5iYDTZheaq1h+NoYsR61A1mTMRGZXTkzIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cyber.gouv.fr;
	spf=pass smtp.mailfrom=oss.cyber.gouv.fr;
	dkim=pass header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=UU5gq2lW;
	arc=none smtp.remote-ip=51.159.188.251
Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6905F606A31B;
	Tue,  3 Nov 2026 22:59:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6905F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=UU5gq2lW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Sender:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=kLBgHgSAv0ahGdfn3+Ux23ygUDOs1fRH18Z3UkUGkxk=; b=UU5gq2lWp8coaj7oVgNwCBCQIO
	M99y41hcdJ/KOJXaRwrjQZ1O5IwBF4vCWkJNL19tgceQFMHxl6+TBgifTkqV0Lrh28YcMOs4BH7Km
	v6/p25ha/6f1vjwtuA9jv1/9sejDhjE+OwxblxFiunc9pAZIzxoy+6CW973U1xYHDDTYc7lHwoZVu
	JOWnSm4hUNR1mD6069NUo4aQRBFEPDGU0y7rPJQLyJj7QmyZfcEVlksjGnOli4MLgbpb5peGfadMP
	vI5bCVYLXheEHTz7vucJecmnL6BYuvCieLcDVP7H6JLPG0kl3wVhIkr0Uj2H9Qf6viTmswBMpmjPO
	q/IiUe7Q==;
Received: from [151.115.150.205] (port=38596 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1xONT2-0000000Fyyx-3sWS;
	Tue, 03 Nov 2026 23:58:59 +0100
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
Subject: [PATCH net v2 0/2] xfrm: fix IPv6 atomic fragment policy handling
Date: Tue,  3 Nov 2026 22:58:40 +0000
Message-ID: <20261103225842.3204446-2-Jeremy.Jean@oss.cyber.gouv.fr>
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

v1: https://lore.kernel.org/all/20261101230745.2043474-2-Jeremy.Jean@oss.cyber.gouv.fr/
Sashiko: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261101230745.2043474-2-Jeremy.Jean%40oss.cyber.gouv.fr

Jérémy Jean (2):
  xfrm: fix IPv6 first-fragment protocol decode
  xfrm: fix selector matching for IPv6 atomic fragments

 net/xfrm/xfrm_policy.c | 53 +++++++++++++++++++++++++++++++-----------
 1 file changed, 39 insertions(+), 14 deletions(-)

-- 
2.47.3

