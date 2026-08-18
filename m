Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D622E9730
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 14:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787065102; cv=none; b=Cv9WFgwiDSBkWDdwfGBZe4EYvjPjDCaL28BlZH0Wfm+D9QnmsKVKYAxGGVAMINuRXlqKGPJem5fJiLoGauW5y7x1QF6DVnT+9fLTvnAXEAuqitgRJhKZHnDAzL6UHcUBKGhRVZm4iPXf5GbCpvLkSacbvxRD+m7DUbmOnEUN0dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787065102; c=relaxed/simple;
	bh=Y1ahR0u2/env9FisCP5isvGH0a0FVaE8JTFV2Jboh6A=;
	h=From:In-Reply-To:References:Cc:Subject:MIME-Version:Content-Type:
	 Date:Message-ID; b=uz2LGSPJjXVKuraPuLL1HECU3Gkf4o6rJ70X9JMN2BzatmI6rYS5q8w4ueUPMrzxZ/nwH2awwpopE3DiUArW3RODnzvYmG1x4u4AKfCYsdZv6V6M3qdwExWCWItF8qUOVV+MHgI5+WA7E7BgUZnmSceRAgZS3CwrLEVsdIBtwMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jTHaQKaq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jTHaQKaq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787065099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5IZxb/lGp+0IQSFY1Nm5DpLhj/RG0poVGuMMmt84GFE=;
	b=jTHaQKaqTdcJLBrwNtNE6AAoSECJpR9RRUCIcB8DH5K5IuTD6lv6dFE8Af9oXESQbhhYPV
	iMFnIOQGuHHs+bKCt/aLP6J//TbQQAi83CgmUotUqNYbp3amvUCnbz26t2nX5fl24DCIDQ
	JhL3+GuNIIwn8K9dESen9/8LWeLz+iM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-SAAYGx9XOymSQ3Q8JGUiiA-1; Tue,
 18 Aug 2026 10:58:14 -0400
X-MC-Unique: SAAYGx9XOymSQ3Q8JGUiiA-1
X-Mimecast-MFC-AGG-ID: SAAYGx9XOymSQ3Q8JGUiiA_1787065091
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D0DC018002F8;
	Tue, 18 Aug 2026 14:58:10 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.48.6])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 225E6180049F;
	Tue, 18 Aug 2026 14:58:07 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <2038699.1787058233@warthog.procyon.org.uk>
References: <2038699.1787058233@warthog.procyon.org.uk> <20260817185802.0aa4c9ee@kernel.org> <20260812110129.979970-1-dhowells@redhat.com>
Cc: dhowells@redhat.com, Jakub Kicinski <kuba@kernel.org>,
    netdev@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
    Simon Horman <horms@kernel.org>, linux-afs@lists.infradead.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v7 00/11] rxrpc: Fix CHALLENGE packet handling
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2089212.1787065086.1@warthog.procyon.org.uk>
Date: Tue, 18 Aug 2026 15:58:06 +0100
Message-ID: <2089213.1787065086@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

David Howells <dhowells@redhat.com> wrote:

>  (1) There's a missing key_put() in afs_open_socket()'s error path.

Actually, this is preexisting, so it needs fixing, but isn't due to this
patchset (it was added in d98c317fd9aa78dfa45e47deb6536cd35783afd1).

David

