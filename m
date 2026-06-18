Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CA62D3ECF
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 13:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781790519; cv=none; b=lDx70xcqyQFDrUAMntD1mvK624nBqLGafhTQjJw2ctdXuljBIkQyZApgvgHadNd7IKmUn4vNNAYJxrrODW/tmjqgSrZMRY/GlWFBXTlFMmtugevWCvWgX9vnM0cLAgD0rGIEfai2fKWf0Yp2bIWgYtUCKJ9isQxNnU+UJIzKsLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781790519; c=relaxed/simple;
	bh=8nwdQtBPYv4uOmSu6Wkd/1b8WQrwpc4CCxSg9N/B0PE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uJBbjppnu8LcWMyjwDwwKoaTyQnBIn+ASmlvDSvwiavjtRMAA/a4fA6ml3onrOmZCpdZUweRQDZwN/ioVZhSQJbFYJCC+3UFQyw+xYM4ky0vDanYT6StUDJZSpVeLgA9xCBtrEnheHSuiIgD3daVKpBEmnni8sAQINV3lwTdsjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cPS7pexw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cPS7pexw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781790517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=85uWVUY9V2s5UjhcsvLOsswYy01tW6tr9ulaUKagkw0=;
	b=cPS7pexwR1MJxPqTQ1eoqPWYl0M8y78UaiMBp+09Ta4gHEOsDIjpi9z8Ci2DWMjshFmK/L
	EBdkH5LUXGU5aNThPvDdT6UthDEpt+xT8WdxhBHx5ITD/lilk00ru40o7tG+M4MNr+eLhV
	di8jdWanksRSoPdP131y/mVO7mT8aoE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-259-TlpAD894MHqqvBbofW8guQ-1; Thu,
 18 Jun 2026 09:48:32 -0400
X-MC-Unique: TlpAD894MHqqvBbofW8guQ-1
X-Mimecast-MFC-AGG-ID: TlpAD894MHqqvBbofW8guQ_1781790510
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2EDD1184EB54;
	Thu, 18 Jun 2026 13:48:22 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.50.44])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 36CD61956088;
	Thu, 18 Jun 2026 13:48:17 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@kernel.org
Subject: [PATCH net v2 02/10] rxrpc: Fix leak of connection from OOB challenge
Date: Thu, 18 Jun 2026 14:47:53 +0100
Message-ID: <20260618134802.2477777-3-dhowells@redhat.com>
In-Reply-To: <20260618134802.2477777-1-dhowells@redhat.com>
References: <20260618134802.2477777-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Fix leak of connection object from OOB challenge queue when response is
provided by userspace.

Fixes: 5800b1cf3fd8 ("rxrpc: Allow CHALLENGEs to the passed to the app for a RESPONSE")
Link: https://sashiko.dev/#/patchset/20260609140911.838677-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Eric Dumazet <edumazet@google.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: stable@kernel.org
---
 net/rxrpc/oob.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/rxrpc/oob.c b/net/rxrpc/oob.c
index 05ca9c1faa57..3318c8bd82ad 100644
--- a/net/rxrpc/oob.c
+++ b/net/rxrpc/oob.c
@@ -210,6 +210,11 @@ static int rxrpc_respond_to_oob(struct rxrpc_sock *rx,
 		break;
 	}
 
+	switch (skb->mark) {
+	case RXRPC_OOB_CHALLENGE:
+		rxrpc_put_connection(sp->chall.conn, rxrpc_conn_put_oob);
+		break;
+	}
 	rxrpc_free_skb(skb, rxrpc_skb_put_oob);
 	return ret;
 }

