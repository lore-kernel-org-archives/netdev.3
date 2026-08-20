Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9605B253340;
	Thu, 20 Aug 2026 22:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787263388; cv=none; b=blhJqXox2oN8A5nvAA8H4A8SvFbHMMkv3wN4bgQN7bXYVvQxxEbXEhrV6aWY8spgZClOSRsx2aIUMW5uc+My6zxt7Gb3y9uadonpeLE/64ufYOPMQNAKEVldxxNnmYQBgwdPqwHfiae90+ZopVLjhf/cODgtHgGgrCRY8fQeNP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787263388; c=relaxed/simple;
	bh=Z+qG1MVfTdCueXPAF+cS20lMMjifLDyXO3y2iby3Fc0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kDCAEemIdtn8ccdGoL2FUmh7zrVgOYfSidByJYCyQenZXRcyIX3gMgRxIUqCLvg8TtMkNZlhLDZr1SQkJAyUv5I9W2PrDM6ePTUeVdzrlK3b/bVK85xfkQs4ncPOjfBYq+i625mE1MIQE71lV3xqrp1wQXC0sNCag64vf9lM2S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=qO3bJY7W; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="qO3bJY7W"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=EUFDvQueKTA0Kg8VM5wig7vU2XqvnDG0jtKGl3w49sU=; b=qO3bJY7WGiLEn2SC8qZVrAuggx
	WC+FVisbhWy8ypbZjPAEWjUo1fuU73UumCHVsgGYRUOgkX9C0Qyvivny1F8XcKkvSVPIzxpuqfbi2
	vHouHl0NW5RLngbGl/hbW0AOp7M8Rj5oW/yXbKwXttATpKE4X269y0mne7CamXdqf3aNWN/ZH0hlt
	zunkX9Dq/hYpU7Wlu2hXQgGXgcQOqwLNpuenkH/vxRfUN9MlUNeJGo0jZ1hWhpZIA2Qceg+zDgAO/
	iOR6z9iqQAnBqLRM7cKszpwoNnQTAR5FfkQ3M6xmaxDYu1TqxedIZUgKkI9mCSincQkKpuWoy6MPo
	sZFQERfA==;
Received: from [151.115.150.205] (port=51212 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1wxAqm-0000000AJER-0jCk;
	Fri, 21 Aug 2026 00:03:04 +0200
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
Subject: [PATCH] net: gue: reject invalid REMCSUM offsets
Date: Thu, 20 Aug 2026 22:02:10 +0000
Message-ID: <20260820220210.3122690-2-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
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

The REMCSUM option carries an absolute checksum start and checksum field
offset. gue_remcsum() passes them to skb_remcsum_process(), whose
partial path stores offset - start in the u16 skb->csum_offset. If
offset is less than start, this underflows (for example, 1/0 becomes
0xffff).

A forwarded packet can retain CHECKSUM_PARTIAL and reach a
NETIF_F_HW_CSUM driver which trusts the metadata, leading
skb_copy_and_csum_dev() to write two bytes about 64 KiB beyond the
destination buffer.

Reject reversed tuples in both normal and GRO receive paths.

Fixes: fe881ef11cf0 ("gue: Use checksum partial with remote checksum offload")
Assisted-by: Codex:gpt-5
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---
 net/ipv4/fou_core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/ipv4/fou_core.c b/net/ipv4/fou_core.c
index ab09dfcdecbd..c4b8b7293994 100644
--- a/net/ipv4/fou_core.c
+++ b/net/ipv4/fou_core.c
@@ -97,6 +97,9 @@ static struct guehdr *gue_remcsum(struct sk_buff *skb, struct guehdr *guehdr,
 	size_t plen = sizeof(struct udphdr) + hdrlen +
 	    max_t(size_t, offset + sizeof(u16), start);
 
+	if (unlikely(offset < start))
+		return NULL;
+
 	if (skb->remcsum_offload)
 		return guehdr;
 
@@ -308,6 +311,9 @@ static struct guehdr *gue_gro_remcsum(struct sk_buff *skb, unsigned int off,
 	size_t start = ntohs(pd[0]);
 	size_t offset = ntohs(pd[1]);
 
+	if (unlikely(offset < start))
+		return NULL;
+
 	if (skb->remcsum_offload)
 		return guehdr;
 
-- 
2.47.3

