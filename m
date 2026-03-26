Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AB92D5935
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 13:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774531137; cv=none; b=MnvdvVOhjYyRifiMwvVPN/w9MF1kg7Tb60RpO8e2VnujZcDr+Ntovp1RQieV23OMiRWyVu6Y2kZxitorAHY2CQ+RNaEAkxy43/naPKjOCzf1TzOZqvg1agLugyH1nI/C4xo8TnrgWRsUo3Kc0d161YHXfbEu5s+FN8bFbZeSs+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774531137; c=relaxed/simple;
	bh=lb0GZ4LjZYME6LIEZSDsoau/6K8K5XJGRSMiunj2zEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZTv3+TEv6aRqz4lixDWqucWf58VukO9XQ8R/JfgZTbTXVHRClr/Kpcb98obvFPaxPHIQCVVqZg+DKczUiHrIeozc7NBU12MvUhBb/zJGRS5yrISXbSo5mpL2KdntImwz5mcvRHEbMBfqxrooWQJt8xGyoRJ3QfJ0pAnpcHQp0JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DiKk5KdO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DiKk5KdO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774531135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hXfYTLAZKbXpNf47trMTcMM/l7RhE1yxWdNYJ5ar7ck=;
	b=DiKk5KdOu4QDjfMZ0NVoDdfnb9zOFHcsgtUbNjscwlbh5x+Mz0rrBf6anfQnZVYuWmnYR/
	a6UZf74DyI/ri0DPM7QEbSIp7vVVRmMyN0iiJLRtxYy4RHIuIjBZZHbpwNuNYSHJc8n6/c
	hN//zRmcKgVBrup5WqArIu34cbzByE8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-228-EoAQyj13PUS2elco2fO-cg-1; Thu,
 26 Mar 2026 09:18:52 -0400
X-MC-Unique: EoAQyj13PUS2elco2fO-cg-1
X-Mimecast-MFC-AGG-ID: EoAQyj13PUS2elco2fO-cg_1774531130
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 02D0818002C8;
	Thu, 26 Mar 2026 13:18:50 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.33.121])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F3BEA1800107;
	Thu, 26 Mar 2026 13:18:45 +0000 (UTC)
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
Subject: [PATCH net v3 01/11] rxrpc: Fix key quota calculation for multitoken keys
Date: Thu, 26 Mar 2026 13:18:26 +0000
Message-ID: <20260326131838.634095-2-dhowells@redhat.com>
In-Reply-To: <20260326131838.634095-1-dhowells@redhat.com>
References: <20260326131838.634095-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

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

