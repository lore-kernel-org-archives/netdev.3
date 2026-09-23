Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31FA496D59
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 13:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790170650; cv=none; b=qo0FhbMIpek3grT1LIQoSktZv+9KqBsxbfkogHqYd/Z7LQpIixHTLtAsk8KWnIW0DaB9VjUa0ZGXVbJ/XbYp8dYc9I9hLymRg07v280CVrlmBFUcOQshvz2q8xUgIxrEcY9gvr7X1PYXGVXghTr+OKxEogann653Dr3kxGQcGvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790170650; c=relaxed/simple;
	bh=FWaRv3kf9APlFjcIzyaybvvNmgnIfAt26p/skW9RPu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U25VV4lQ/NuMHOQn2mK+VGXnvpfhIUdViCC5oYRycG5FTfIO8wv93aCLZJb8tn8wuWONhHy7wmtxjVmqFMl7ggeV8NxwwqHH5BIHG7iB6/SOgre78WrlU96GVSb+hojaAIT5CsZjQ4egRaPF9WmqrUIW1YNAvJX5kvq6CpgtVaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GCizIUfS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GCizIUfS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790170647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s+c9Y0t5SKsPrOe0nx0dWN7zTgZlRH54f91QGpPHh3Y=;
	b=GCizIUfS5U/eb8LNeoV4gIH89beNMQnU3OzSr7tX7PNSgCdnetn6wVCi+s23mtEH9iZUwr
	0ckI5pl4nSAhhSAEjfVCaoMqKXFYNaGfnk1n2Ei+xfgVfFbDdjq9GndryCASkd5SinRJ/k
	/i1M2SNMJAvXYZInAQC6R+siNx38J54=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-215-W9A4yalKMG6elUo2_AFlaQ-1; Wed,
 23 Sep 2026 09:37:26 -0400
X-MC-Unique: W9A4yalKMG6elUo2_AFlaQ-1
X-Mimecast-MFC-AGG-ID: W9A4yalKMG6elUo2_AFlaQ_1790170643
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2A084180074A;
	Wed, 23 Sep 2026 13:37:23 +0000 (UTC)
Received: from warthog.com (unknown [10.44.32.54])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 159CE418;
	Wed, 23 Sep 2026 13:37:19 +0000 (UTC)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH net v11 01/17] rxrpc: Revert "rxrpc: rxperf: Fix missing decoding of terminal magic cookie"
Date: Wed, 23 Sep 2026 14:36:48 +0100
Message-ID: <20260923133706.1496540-2-dhowells@redhat.com>
In-Reply-To: <20260923133706.1496540-1-dhowells@redhat.com>
References: <20260923133706.1496540-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

Revert commit c34d999ca3145d9fe858258cc3342ec493f47d2e:

    The rxperf RPCs seem to have a magic cookie at the end of the request
    that was failing to be taken account of by the unmarshalling of the
    request.  Fix the rxperf code to expect this.

Actually, this isn't true; it's just that other Rx implementations ignore
the extra data in the request and so my test programs are sending too much
data without noticeable consequence.

Fixes: c34d999ca314 ("rxrpc: rxperf: Fix missing decoding of terminal magic cookie")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Eric Dumazet <edumazet@google.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
---
 net/rxrpc/rxperf.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/net/rxrpc/rxperf.c b/net/rxrpc/rxperf.c
index b8df6d22314d..f1f41151589c 100644
--- a/net/rxrpc/rxperf.c
+++ b/net/rxrpc/rxperf.c
@@ -483,18 +483,6 @@ static int rxperf_deliver_request(struct rxperf_call *call)
 		call->unmarshal++;
 		fallthrough;
 	case 2:
-		ret = rxperf_extract_data(call, true);
-		if (ret < 0)
-			return ret;
-
-		/* Deal with the terminal magic cookie. */
-		call->iov_len = 4;
-		call->kvec[0].iov_len	= call->iov_len;
-		call->kvec[0].iov_base	= call->tmp;
-		iov_iter_kvec(&call->iter, READ, call->kvec, 1, call->iov_len);
-		call->unmarshal++;
-		fallthrough;
-	case 3:
 		ret = rxperf_extract_data(call, false);
 		if (ret < 0)
 			return ret;

