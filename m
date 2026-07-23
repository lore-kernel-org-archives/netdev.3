Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854733F482A
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 08:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784795433; cv=none; b=ltbCFd5iHv4lOp9Uyyk7VUcd+lngzj1aLoIFyw52so8G61LtqhIfFsO7c3dO76AeYgJaulyzTi74kIwsTaD53kvYZBjl8cwtNE/uHun/+yqumU0pfY7+DUCyvVU/DJS7c6PlwMLq5f2FgZggsfhBOFmjfPmnNCwTj+on0HTjgb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784795433; c=relaxed/simple;
	bh=EdtlgouwjE6PR1qMsv0ll2MXmtDVQzsi9qgPTx2xGzg=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=qSJ8u24suJ0ZsqmuhK9TSBIUBYAXZn1nlvF9J9kfeljebH3jgqjnhqppDl4aFXHSDAO5MLFz9olFGAu2UVjk0mu1JlofxXO8e2cu4smKLiOCcmP4wWvUGslec8DtL4meotlX7Gf6R8LwHHcuU6/pkost9JjkuqgRQi8+tjBksCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FMBES00T; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FMBES00T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784795422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IT8SQNpl1pxYcuaeydIc7Bn006Mph0lEM+xqjhpWhZs=;
	b=FMBES00TdEB4n9VXO9MRnw7ST4MlkWQBb5QB4JCTIeAB9noW3mM2nkqDSAMMj+TjUuXj58
	L3qrvkIRPjF6hHMsPH8r5z8blbEeUpWupkMd1hSAn3H04BqHWYHtCYvBpLL2tqDthI8Jnb
	VRxSOUhP0QPtQgUgxZ0M/fgp52+dk8c=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-20-3VXM-JLXMjWKfP1zH7ecUQ-1; Thu,
 23 Jul 2026 04:30:18 -0400
X-MC-Unique: 3VXM-JLXMjWKfP1zH7ecUQ-1
X-Mimecast-MFC-AGG-ID: 3VXM-JLXMjWKfP1zH7ecUQ_1784795416
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DF39D182FA2E;
	Thu, 23 Jul 2026 08:30:15 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.33.159])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E32BE1800623;
	Thu, 23 Jul 2026 08:30:11 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20260720145631.201053-2-horms@kernel.org>
References: <20260720145631.201053-2-horms@kernel.org> <20260713081022.2186481-15-dhowells@redhat.com>
To: Simon Horman <horms@kernel.org>
Cc: dhowells@redhat.com, netdev@vger.kernel.org,
    marc.dionne@auristor.com, kuba@kernel.org, davem@davemloft.net,
    edumazet@google.com, pabeni@redhat.com,
    linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
    stable@kernel.org
Subject: Re: [PATCH net v3 14/14] rxrpc: Remove OOB challenge/response code
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <423992.1784795410.1@warthog.procyon.org.uk>
Date: Thu, 23 Jul 2026 09:30:10 +0100
Message-ID: <423993.1784795410@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Simon Horman <horms@kernel.org> wrote:

> [Severity: Critical]
> Does removing these constants from the UAPI header violate the kernel's
> policy against breaking userspace?
> 
> Any userspace program that includes linux/rxrpc.h and references the
> removed RXRPC_OOB_ID or related constants will now fail to compile.
> ...
> [Severity: Critical]
> Does this change break backwards compatibility for existing applications?

Yep.  I explained my justification for that in the cover.  I don't expect
anything outside of my own tools to use the API, plus this particular facet of
the API has only been around for a short time.  Further, the underlying
mechanism in the kernel is replaced here, so the OOB challenge-response API is
no longer effective.

> [Severity: Critical]
> Can this sequence cause memory corruption and an out-of-bounds information
> leak via RXRPC_RESPONSE_APPDATA?
> 
> Looking at the remaining sendmsg code in net/rxrpc/sendmsg.c, an inverted
> check incorrectly rejects user keys but accepts the keyring:

This is the same complaint as was raised against an earlier patch.

David

