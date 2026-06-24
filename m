Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D766E32779D
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 16:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782319126; cv=none; b=Cj3cxkffwjfkBlqPWeoU6h8BLlI0K2IvpKBwp8G0uK/bCfMMhe9Emy2uXGX4zoc1LdEjQW3WQ1hYj6SS9QXgIyDedrGSBP/JlP4QGO4fo61Zt55hxr7HIWLb1nZ1VTGUYH0C/PSUbYEOzRlUCFWMvnIBsTxyxWDlWJjvxvdZSwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782319126; c=relaxed/simple;
	bh=8nwdQtBPYv4uOmSu6Wkd/1b8WQrwpc4CCxSg9N/B0PE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hKnkd2kjeyygK4hyBwfLdP0gyCWdlABFcTiu5sSLzCxfQjyoxiLrTZXCIXhNKCT/Vc813xBBy+ztcBpXIT8haenczFyKtIn0yjb2nZwvy7/fiISnVRyVQFSNk+eoruDE2xFvovg4ZQu7zhn4OnJok7gEkhkLHODGJ+nFEcuQsDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PJk8W6XZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PJk8W6XZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782319123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=85uWVUY9V2s5UjhcsvLOsswYy01tW6tr9ulaUKagkw0=;
	b=PJk8W6XZH9Lhw+UpjgG5SYbmQ74v9tLuMD8U2cTODnrUzznRd7MBOcOea1TtZB/eD218pO
	SWPCBjNMA1rcbOZY5Ihz3zOIcRxlmd+/HZmn6jJuleTGdjYrpRz0RgdxCldtJ1jf2l6f/b
	D4l5xOxJJMVVF8flw+x6efHHguBIkRo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-262-wdc5jPGhPi2bVFWzAogCzA-1; Wed,
 24 Jun 2026 12:38:40 -0400
X-MC-Unique: wdc5jPGhPi2bVFWzAogCzA-1
X-Mimecast-MFC-AGG-ID: wdc5jPGhPi2bVFWzAogCzA_1782319119
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F24241801373;
	Wed, 24 Jun 2026 16:38:38 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.49.152])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A45211956041;
	Wed, 24 Jun 2026 16:38:35 +0000 (UTC)
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
Subject: [PATCH net v3 02/11] rxrpc: Fix leak of connection from OOB challenge
Date: Wed, 24 Jun 2026 17:38:09 +0100
Message-ID: <20260624163819.3017002-3-dhowells@redhat.com>
In-Reply-To: <20260624163819.3017002-1-dhowells@redhat.com>
References: <20260624163819.3017002-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

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

