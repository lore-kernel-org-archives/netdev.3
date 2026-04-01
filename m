Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988073F9F35
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 10:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775041007; cv=none; b=AhpuL35qgAb9utUjGqSYudh9fMNsfAjusLsWCFQai9xDbaIPArgNLml1r+KlqCiUUIlamethA0hebS8JGF8jB2RjhI1MEmXRepZWx75YnZhNSvoBwOwft7F3J3I1LCMrnBiVc0rwj7ekJtyacmIwpq12jgzC/e9ab/s63/kKQys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775041007; c=relaxed/simple;
	bh=lNi53xaZ2dGL9nGQo2Q5PUubxeSgR378CvFt6gObZgc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o+h0KUKi3NbjBm6+fGHnueY2DCv7g2Xn/ok62inN9y1FvCSbrAyx4UF46RWQzGHF7+FgPGhpeWrtu3q+DE/G7nxQxkexMpqkm9Zmeq/CrbThPMfBUrd9vp351rzuw7RO5oRi/0/Ui89XiUWV059nNlfcnFRUs3SW2G1oeIhTh58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C+3x8tDk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C+3x8tDk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775041004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YaIw1S56HP9C94n6EHAzBdJx0jJ6g47etF8yPJICPVc=;
	b=C+3x8tDk3Gcod1MoIgmqYw4CH0eLlds2nBc8NwEh3OffWOdAoU1kDJbCRcQ8+qksljK9XT
	PPPQ0oXkr/oLepW/tnrAwTeRPIuisBpWY/PCateX7fe69eVR1JjVWYrmmvxmR7KqEvg9vS
	ddQJzJ2rBQUaFDj3s2qna5L+zN/yvOc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-445-Xi3PbgFeOVW-ynxu1hpL2A-1; Wed,
 01 Apr 2026 06:56:41 -0400
X-MC-Unique: Xi3PbgFeOVW-ynxu1hpL2A-1
X-Mimecast-MFC-AGG-ID: Xi3PbgFeOVW-ynxu1hpL2A_1775041000
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D896C18005B8;
	Wed,  1 Apr 2026 10:56:39 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.35.245])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 33D811955F2B;
	Wed,  1 Apr 2026 10:56:35 +0000 (UTC)
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
Subject: [PATCH net v4 02/15] rxrpc: Fix key parsing memleak
Date: Wed,  1 Apr 2026 11:55:55 +0100
Message-ID: <20260401105614.1696001-3-dhowells@redhat.com>
In-Reply-To: <20260401105614.1696001-1-dhowells@redhat.com>
References: <20260401105614.1696001-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

In rxrpc_preparse_xdr_yfs_rxgk(), the memory attached to token->rxgk can be
leaked in a few error paths after it's allocated.

Fix this by freeing it in the "reject_token:" case.

Fixes: 0ca100ff4df6 ("rxrpc: Add YFS RxGK (GSSAPI) security class")
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
 net/rxrpc/key.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/rxrpc/key.c b/net/rxrpc/key.c
index af403f0ccab5..26d4336a4a02 100644
--- a/net/rxrpc/key.c
+++ b/net/rxrpc/key.c
@@ -274,6 +274,7 @@ static int rxrpc_preparse_xdr_yfs_rxgk(struct key_preparsed_payload *prep,
 nomem:
 	return -ENOMEM;
 reject_token:
+	kfree(token->rxgk);
 	kfree(token);
 reject:
 	return -EKEYREJECTED;

