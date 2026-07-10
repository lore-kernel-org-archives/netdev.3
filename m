Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DA63859F7
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 19:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783711381; cv=none; b=IZ9xiRoAn8BlSQhvbcWZ5dyO653w9X+i4xbTBNdwmCDRLxxikoMloQR3xOGfjsmB+cdwTugUt+L3v8QdUsNsKOlLYlSfoFLpNe/PSraR1VzO66D1N5iwl5k026DkRa7AfEH2qiaQ7MdYN9tYcrn+God594PbbatkrC6lDgLlbr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783711381; c=relaxed/simple;
	bh=Jwc5fJ9xrRVYizICnQ5yAooHRkTMnng50fBKpa7UdCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Igg9Uz/YiopuhhVEj3ueb37Sr9xYsMRuj1hPd/2368BRgXBjjZxRR/5QaT43v30BVLYZP4vbf9fihFmMXO1liyQqKpNhQ4yCBFL29/hambwCITgM1UdmrdGJNmQV9bWhoKen27So810ohhfUu5YuN83l5hRAtfdTllB6t3OivmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bOjmDvMf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bOjmDvMf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783711378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CJbYCTF46Xtoig1WDNcBh4wAMxmGdrepxhiioBEnY2E=;
	b=bOjmDvMf9Y88kyrPwAUwe6ERwZIPcObRTO7BYRvCL7/Sdg778y5v07WDxuZdkssb5efVyo
	Yq6ESh9+BFFWBh5A528Eq2vttj/V0fJL1q9S6dz6NH+x2vebnXbCucoRQF38vcAPTeqORu
	WTKm2CFcEhqW6Su2yWfkoGHhlumyQ3c=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-527-Q7lNyi1qNrCTSaCa3M1a3A-1; Fri,
 10 Jul 2026 15:22:55 -0400
X-MC-Unique: Q7lNyi1qNrCTSaCa3M1a3A-1
X-Mimecast-MFC-AGG-ID: Q7lNyi1qNrCTSaCa3M1a3A_1783711373
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 40B701955F70;
	Fri, 10 Jul 2026 19:22:53 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.33.159])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AE9633000B4D;
	Fri, 10 Jul 2026 19:22:49 +0000 (UTC)
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
Subject: [PATCH net v2 05/16] afs: Fix afs_fs_fetch_data() to set call->async
Date: Fri, 10 Jul 2026 20:22:07 +0100
Message-ID: <20260710192220.1922433-6-dhowells@redhat.com>
In-Reply-To: <20260710192220.1922433-1-dhowells@redhat.com>
References: <20260710192220.1922433-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

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

