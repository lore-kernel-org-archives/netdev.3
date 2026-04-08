Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF943BF68D
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 12:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775650392; cv=none; b=W1sHgjRKmiv55YvAWN4DOfTEJzLd0YbNDscyxQAynLEp6ED59MXyqX9stOwgRNOTWHn6ZtJuPqjZTQzQLarrw35K5g32eS6TTbDvGkl9LwJwzXef7xJSLnqSSsYB+i81VxSI4g4tkNpyHfa9ckt7ck3c9SZznZ0Ax2hCAxO7uX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775650392; c=relaxed/simple;
	bh=lb0GZ4LjZYME6LIEZSDsoau/6K8K5XJGRSMiunj2zEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VOtpjF08zm1bZCVXgrIip4hNxJB4F+CJeK7oZ/LwhdfgmxjvpnijrrNRc17QXA17iDYh15D9N3ciKmH7UxddEiv3D+gCwA+mTUruoEA9/6Jn7Ed7BOyaaNEKdGc1ZjZJHsMF6tE0dQNcczG/jlTWZMzAgku6lPkVAdTAls/Zw+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CQcmrDuu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CQcmrDuu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775650389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hXfYTLAZKbXpNf47trMTcMM/l7RhE1yxWdNYJ5ar7ck=;
	b=CQcmrDuuBvvtlL3Go6/ETNnBQAbOFQe4RQpLSIk782L/YBHSKibJbhMuRAp7XHxNsKYXkm
	xMud52huKFmG2ZCvEOCvZy9D8p2tXKpSySHsNzbewzXLVFPYPQUkAaXBgcNUpgkRNfZkmd
	xUBToufZ/x9aUI5lLDO5z3HwzTHMmAI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-130-dUWjyVVEMKSNktTtESDVEA-1; Wed,
 08 Apr 2026 08:13:07 -0400
X-MC-Unique: dUWjyVVEMKSNktTtESDVEA-1
X-Mimecast-MFC-AGG-ID: dUWjyVVEMKSNktTtESDVEA_1775650386
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BF7AB195606B;
	Wed,  8 Apr 2026 12:13:05 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.32.94])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AAA3E1955D6B;
	Wed,  8 Apr 2026 12:13:01 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jeffrey Altman <jaltman@auristor.com>,
	Simon Horman <horms@kernel.org>,
	stable@kernel.org
Subject: [PATCH net v5 01/21] rxrpc: Fix key quota calculation for multitoken keys
Date: Wed,  8 Apr 2026 13:12:29 +0100
Message-ID: <20260408121252.2249051-2-dhowells@redhat.com>
In-Reply-To: <20260408121252.2249051-1-dhowells@redhat.com>
References: <20260408121252.2249051-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

In the rxrpc key preparsing, every token extracted sets the proposed quota
value, but for multitoken keys, this will overwrite the previous proposed
quota, losing it.

Fix this by adding to the proposed quota instead.

Fixes: 8a7a3eb4ddbe ("KEYS: RxRPC: Use key preparsing")
Closes: https://sashiko.dev/#/patchset/20260319150150.4189381-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeffrey Altman <jaltman@auristor.com>
cc: Eric Dumazet <edumazet@google.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
cc: stable@kernel.org
---
 net/rxrpc/key.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/rxrpc/key.c b/net/rxrpc/key.c
index 85078114b2dd..af403f0ccab5 100644
--- a/net/rxrpc/key.c
+++ b/net/rxrpc/key.c
@@ -72,7 +72,7 @@ static int rxrpc_preparse_xdr_rxkad(struct key_preparsed_payload *prep,
 		return -EKEYREJECTED;
 
 	plen = sizeof(*token) + sizeof(*token->kad) + tktlen;
-	prep->quotalen = datalen + plen;
+	prep->quotalen += datalen + plen;
 
 	plen -= sizeof(*token);
 	token = kzalloc_obj(*token);
@@ -199,7 +199,7 @@ static int rxrpc_preparse_xdr_yfs_rxgk(struct key_preparsed_payload *prep,
 	}
 
 	plen = sizeof(*token) + sizeof(*token->rxgk) + tktlen + keylen;
-	prep->quotalen = datalen + plen;
+	prep->quotalen += datalen + plen;
 
 	plen -= sizeof(*token);
 	token = kzalloc_obj(*token);
@@ -460,6 +460,7 @@ static int rxrpc_preparse(struct key_preparsed_payload *prep)
 	memcpy(&kver, prep->data, sizeof(kver));
 	prep->data += sizeof(kver);
 	prep->datalen -= sizeof(kver);
+	prep->quotalen = 0;
 
 	_debug("KEY I/F VERSION: %u", kver);
 
@@ -497,7 +498,7 @@ static int rxrpc_preparse(struct key_preparsed_payload *prep)
 		goto error;
 
 	plen = sizeof(*token->kad) + v1->ticket_length;
-	prep->quotalen = plen + sizeof(*token);
+	prep->quotalen += plen + sizeof(*token);
 
 	ret = -ENOMEM;
 	token = kzalloc_obj(*token);

