Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F125D4A4409
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 13:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790170657; cv=none; b=HL7nUXmT+/p7UU0FecKdoOQcy3HI5Y/vPndB6U0CAFADbtUsCI8uezh+Oq1JO+yXMEXDTOwHW7vYf+V4QQquMcOXcfJKHYREnvyJOFTpD4xbalDa1JjTPrJaoB9bBPz4TS1hT/Tbcet8FTWv0HVsngqZyfjm1wYLSaPLTCHXsO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790170657; c=relaxed/simple;
	bh=rP8aHHu5Bkp8yoYoNyYcWejJ2NBAV1DEmgmqAtzlFQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RjivbhTYp3rfap6U6nSkbzZJWeOF2pn0feccuSNBCJmauZy0BnnI8MryLRsEZnyhAfD3eXdHFihIQIpaYrc08WpYnLHxup2bRq/bwQEaXrTnk2C66uwpk9jK1qrPLrYqyb9kQamc/1EtbR0ZDWWEQ9IKOPj2i2kBT+R0E5r4mJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LyVAaVgg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LyVAaVgg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790170653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D6J8zcfjJGXzyEQooABwNDMn3L1SBB4UGC/mafu55wA=;
	b=LyVAaVgg9D5Bass+I7SRmrHPutpYLlsY3pRywuVVakW1FOU9V/EI7IglV6vJ+N8ydNMrba
	h8U74/IeCmjf6Gfx2Tt0iHyGZiO7GGg+Tg7Xexz0VHA0LSmpKQ8RSCNRhCuTlMh0KdgdKH
	2sXybeoxDFBsYRJLP0jycjgdPnwP/8M=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-558-TObKH2AWNTS8I9FtVwtQ_A-1; Wed,
 23 Sep 2026 09:37:30 -0400
X-MC-Unique: TObKH2AWNTS8I9FtVwtQ_A-1
X-Mimecast-MFC-AGG-ID: TObKH2AWNTS8I9FtVwtQ_A_1790170649
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C5E6018011FE;
	Wed, 23 Sep 2026 13:37:28 +0000 (UTC)
Received: from warthog.com (unknown [10.44.32.54])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B679A1800473;
	Wed, 23 Sep 2026 13:37:24 +0000 (UTC)
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
	Jeffrey Altman <jaltman@auristor.com>
Subject: [PATCH net v11 02/17] rxrpc: Fix rxperf test rxgk key kvno to be 0
Date: Wed, 23 Sep 2026 14:36:49 +0100
Message-ID: <20260923133706.1496540-3-dhowells@redhat.com>
In-Reply-To: <20260923133706.1496540-1-dhowells@redhat.com>
References: <20260923133706.1496540-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Fix the test rxgk keys in the rxperf test server to have kvno 0 to match
other implementations.

Fixes: aa2199088a39 ("rxrpc: rxperf: Add test RxGK server keys")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeffrey Altman <jaltman@auristor.com>
cc: Eric Dumazet <edumazet@google.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
---
 net/rxrpc/rxperf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/rxrpc/rxperf.c b/net/rxrpc/rxperf.c
index f1f41151589c..26f97e1dd388 100644
--- a/net/rxrpc/rxperf.c
+++ b/net/rxrpc/rxperf.c
@@ -586,7 +586,7 @@ static int rxperf_add_yfs_rxgk_key(struct key *keyring, u32 enctype)
 	for (int i = 0; i < krb5->key_len; i++)
 		key[i] = i;
 
-	sprintf(name, "%u:6:1:%u", RX_PERF_SERVICE, enctype);
+	sprintf(name, "%u:6:0:%u", RX_PERF_SERVICE, enctype);
 
 	kref = key_create_or_update(make_key_ref(keyring, true),
 				    "rxrpc_s", name,

