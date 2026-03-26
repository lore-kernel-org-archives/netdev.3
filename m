Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5263FB7C2
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 13:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774531177; cv=none; b=ir++mywYNoPhhk5riX9Yqfu5hJePXo5VQpcV18m0AsgN7a08uL5lUpc7SxLykjQvSIJ8lIoQjChp12JRVZzj6iuzt1cEe+z9puhn9kK0kRMBzE4NASyBXgfCyX43989ZQTQFdS6mlZ/fT9KqRoL5htuKDBu3nGSD0L1nijJeQBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774531177; c=relaxed/simple;
	bh=wiH6DsMqrg29tzFgP11flkS65RZZkVoC9406w0ZzAqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p9sl92VEk8OWNGQZ17srET3hOyM1WVdPymU+qnL5gHjYFLPO81Zay1xFI6mQIFYIHd1guwsaldVnF+GqmrzQMl7D1Yot+FzgzPS+JX79niFo9Wi51Usq3yrIsmbbzDch9aS14t3QsJhA5bfSr2kJOtT2JpJNWrtdfNaxUi50E04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AyqugGaA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AyqugGaA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774531175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=loVxfrzyxYdQdW2xqgUXj+kDQbA4pbY0Yb3C1QbXM7A=;
	b=AyqugGaAZZO9swh8rwWFjEzVXG6z6sSKaX1Aq2CItmtyDdcX6YHNRzkC9BKUI4jUYMLGTM
	+oNf3cRlYu130n2xBwOP2enEuUA8DJMjzN4R4BII3Q8xlvZJjcbtvacftUV8UfjaQt+Emq
	soao35Gk7vd1xFwJzqCkZl1TS5wbbCo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-38-06wbql0-MUi0Ryz0epRE0g-1; Thu,
 26 Mar 2026 09:19:32 -0400
X-MC-Unique: 06wbql0-MUi0Ryz0epRE0g-1
X-Mimecast-MFC-AGG-ID: 06wbql0-MUi0Ryz0epRE0g_1774531169
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 417C41955D84;
	Thu, 26 Mar 2026 13:19:29 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.33.121])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 14E373000223;
	Thu, 26 Mar 2026 13:19:24 +0000 (UTC)
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
	Alok Tiwari <alok.a.tiwari@oracle.com>,
	Simon Horman <horms@kernel.org>,
	Jeffrey Altman <jaltman@auristor.com>,
	stable@kernel.org
Subject: [PATCH net v3 08/11] rxrpc: Fix rack timer warning to report unexpected mode
Date: Thu, 26 Mar 2026 13:18:33 +0000
Message-ID: <20260326131838.634095-9-dhowells@redhat.com>
In-Reply-To: <20260326131838.634095-1-dhowells@redhat.com>
References: <20260326131838.634095-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

From: Alok Tiwari <alok.a.tiwari@oracle.com>

rxrpc_rack_timer_expired() clears call->rack_timer_mode to OFF before
the switch. The default case warning therefore always prints OFF and
doesn't identify the unexpected timer mode.

Log the saved mode value instead so the warning reports the actual
unexpected rack timer mode.

Fixes: 7c482665931b ("rxrpc: Implement RACK/TLP to deal with transmission stalls [RFC8985]")
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Jeffrey Altman <jaltman@auristor.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Eric Dumazet <edumazet@google.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
cc: stable@kernel.org
---
 net/rxrpc/input_rack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/rxrpc/input_rack.c b/net/rxrpc/input_rack.c
index 13c371261e0a..9eb109ffba56 100644
--- a/net/rxrpc/input_rack.c
+++ b/net/rxrpc/input_rack.c
@@ -413,6 +413,6 @@ void rxrpc_rack_timer_expired(struct rxrpc_call *call, ktime_t overran_by)
 		break;
 	//case RXRPC_CALL_RACKTIMER_ZEROWIN:
 	default:
-		pr_warn("Unexpected rack timer %u", call->rack_timer_mode);
+		pr_warn("Unexpected rack timer %u", mode);
 	}
 }

