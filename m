Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F87E33A71A
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 16:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782319174; cv=none; b=sxdnD29cmyPhgkfGNs7bSX72yszbB8J4nUZODOw7bbPY0ePsaixyDhFcpnHSiF407lyNtuTzBwNPiA7hf1NNDQ5FkUTfPyDClEbPM2pCxhSc/K7p0RjnfyHdumu5Anr9fcfWHk05MsgUpVStTgu4ZyJRNoLpu2O9t4AWGGnLUNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782319174; c=relaxed/simple;
	bh=ouf00cILEL/4LzoNJQwSsUo2J7Jfm13IomvyrvDvvLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SsY+sGABv0hQcVQEgQYZlUvOcUIZSijJx0p2jxg5+b8fVVb1mSBspaSHj171OCRcZLRZbS+5O8QYZDGoKle7UJWwXwcOSd7waQ0fWznAdI/j7KQLfuqzQggNw1Ak5BoBpk3gFKXW+Uvu7BoNGDUX+dROoJjrBzszFfZcVZJeKYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P0kKeU0S; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P0kKeU0S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782319172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w8hvdAbEtufhYAEgmIVDbv4uWxsJh9nhzvfdHSxY9Ak=;
	b=P0kKeU0SHGxdD0HnQSJ1XkdV6rdZ9DfxgXom//bu02+P7ewJZ0FBGymbI4TJfPW/8douaf
	iidzePHjpH2r1EY9XzkpJ2dSwda/5dw2QHk/eFDZAxldS5GddkQFRCb6/Tx5+7R2wFDpMb
	tpfcCYRDFkQYlST5jQUsmkcMIR/5G5U=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-463-7FzQr6IqMwCaL-pAOvU-Jw-1; Wed,
 24 Jun 2026 12:39:27 -0400
X-MC-Unique: 7FzQr6IqMwCaL-pAOvU-Jw-1
X-Mimecast-MFC-AGG-ID: 7FzQr6IqMwCaL-pAOvU-Jw_1782319165
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8E95E1800603;
	Wed, 24 Jun 2026 16:39:25 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.49.152])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3873F1956041;
	Wed, 24 Jun 2026 16:39:21 +0000 (UTC)
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
Subject: [PATCH net v3 11/11] rxrpc: Fix rxrpc_rotate_tx_rotate() to check there's something to rotate
Date: Wed, 24 Jun 2026 17:38:18 +0100
Message-ID: <20260624163819.3017002-12-dhowells@redhat.com>
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

Fix rxrpc_rotate_tx_rotate() to check that there's something in the
transmission buffer to be rotated before it attempts to rotate anything.

Fixes: b341a0263b1b ("rxrpc: Implement progressive transmission queue struct")
Link: https://sashiko.dev/#/patchset/20260618134802.2477777-1-dhowells%40redhat.com
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
 net/rxrpc/input.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index 9bd0f1b92463..73cafe6bfa9f 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -237,6 +237,9 @@ static bool rxrpc_rotate_tx_window(struct rxrpc_call *call, rxrpc_seq_t to,
 		call->acks_lowest_nak = to;
 	}
 
+	if (after(seq, to))
+		return false;
+
 	/* We may have a left over fully-consumed buffer at the front that we
 	 * couldn't drop before (rotate_and_keep below).
 	 */

