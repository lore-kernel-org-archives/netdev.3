Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298903A5E70
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 08:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783930252; cv=none; b=Tv32BtU+4dLUh2ZFXj7HLtpb72Pu5sqOCT7n/xz2WBJpM808JUipZ68n05mxQLW64UGBJGXBOAGCECmUPAikHA+8jmpTzPwfJ+/1IeM/EtVpFBGt2byB85rjhZtMHtUtoSDpTw8D1DUF8ostGvL17c7LbUJKcLqS3r7wR6YVfz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783930252; c=relaxed/simple;
	bh=Jwc5fJ9xrRVYizICnQ5yAooHRkTMnng50fBKpa7UdCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pRyHaM5Le7USKvGS/MF5XwgI/5o52jpUBAfIFezpi1+xhVyeUzwnz0BFbywPM/YqeWgaZY2vBLdnc4VRMF6EKTnkuZ29PBcw/J6+S8ulKrUEFhbwrfep5+6R1319LkQw5ltSvxs+si88CsMtDEn+Eqt8LI8AMqBmItD2KjreTLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KVnR5rTq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KVnR5rTq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783930250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CJbYCTF46Xtoig1WDNcBh4wAMxmGdrepxhiioBEnY2E=;
	b=KVnR5rTqkQ5Pqyjqwg+Ud3Wammt3f0mcdcaUO6hQ8XOEgks2Rc6TY8FIrOBfWjKbHJS9+T
	qWu22uoTcdeC5xH9Ym5HVKEtz5QxUr3wLG/nn9e9HxIsRXbALmZ4nFzsCxz3zPjbHAj5Zm
	7jqUtfw6AqgeNlyYW0geB+xWww32h9Y=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-JZFpb0L8P4aVcdFTGB51KQ-1; Mon,
 13 Jul 2026 04:10:46 -0400
X-MC-Unique: JZFpb0L8P4aVcdFTGB51KQ-1
X-Mimecast-MFC-AGG-ID: JZFpb0L8P4aVcdFTGB51KQ_1783930245
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 133851955F21;
	Mon, 13 Jul 2026 08:10:45 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.33.159])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B4FBF195394B;
	Mon, 13 Jul 2026 08:10:41 +0000 (UTC)
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
	Jeffrey Altman <jaltman@auristor.com>,
	stable@kernel.org
Subject: [PATCH net v3 03/14] afs: Fix afs_fs_fetch_data() to set call->async
Date: Mon, 13 Jul 2026 09:10:09 +0100
Message-ID: <20260713081022.2186481-4-dhowells@redhat.com>
In-Reply-To: <20260713081022.2186481-1-dhowells@redhat.com>
References: <20260713081022.2186481-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Fix afs_fs_fetch_data() to set call->async on an async operation as does
afs_fs_fetch_data64().

Fixes: eddf51f2bb2c ("afs: Make {Y,}FS.FetchData an asynchronous operation")
Link: https://sashiko.dev/#/patchset/20260702144919.172295-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeffrey Altman <jaltman@auristor.com>
cc: Eric Dumazet <edumazet@google.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: stable@kernel.org
---
 fs/afs/fsclient.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index a2ffd60889f8..626e1d37b915 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -477,6 +477,9 @@ void afs_fs_fetch_data(struct afs_operation *op)
 	if (!call)
 		return afs_op_nomem(op);
 
+	if (op->flags & AFS_OPERATION_ASYNC)
+		call->async = true;
+
 	/* marshall the parameters */
 	bp = call->request;
 	bp[0] = htonl(FSFETCHDATA);

