Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAB63ABDA5
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 15:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787065539; cv=none; b=pXMQFQDACIWCwzAw7SSgS8WP0bySLRGE5lqlDOChmHVmDcbt634rX7jS+wi5Fk3HIExq8RKEJ0xsADGMdokX4e+0ycA4zxL/b8kdGJxpo4U6Y8sxorWUFmccwbeqQYo0K09M/SXqBKhzYU4ASuWvAPwnrni33aEjUO4hHXgJ5ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787065539; c=relaxed/simple;
	bh=ghqWI+BvNnNz/bBjWd1mBZH1HXB43bhiaod+xw/2OA0=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=Rw1iNB8O0se0bvgOfbQrW4tzOol4urow1ftLLfKNnm5yUXszPD5dW4BDHdMj7mMRBu9WVKVDxp+68UmAprn/OsNpxUMajzlf/V7DYmH33CFwmEcAuNep3cldwHzqoqzvJtlW6Qnr5cfOfkx7JDTHdecz61VBceyjZHGiGp5hoWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V85EyvW2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V85EyvW2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787065536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ghqWI+BvNnNz/bBjWd1mBZH1HXB43bhiaod+xw/2OA0=;
	b=V85EyvW2AkM7zGvFFRoxvLfvOdKzp2hUjpa/VRUklei4xpv+5+Xiv9aa2PC45iMBHRTYBB
	5az7u5TTFi6zrGnBkma+wdhQf9ZVbLEmxqtvVOMHr4LIxlfVaOyTzrvgntA4977EBBRWVj
	kvgOU612CBGWGHv39NFErX+GOIWDqGY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-Xj3tybnUNAitiOJ96qj2oA-1; Tue,
 18 Aug 2026 11:05:30 -0400
X-MC-Unique: Xj3tybnUNAitiOJ96qj2oA-1
X-Mimecast-MFC-AGG-ID: Xj3tybnUNAitiOJ96qj2oA_1787065529
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BB2651955F3D;
	Tue, 18 Aug 2026 15:05:28 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.48.6])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EE031180034C;
	Tue, 18 Aug 2026 15:05:25 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20260818074910.5618ecb9@kernel.org>
References: <20260818074910.5618ecb9@kernel.org> <20260817185802.0aa4c9ee@kernel.org> <20260812110129.979970-1-dhowells@redhat.com> <2038699.1787058233@warthog.procyon.org.uk>
To: Jakub Kicinski <kuba@kernel.org>
Cc: dhowells@redhat.com, netdev@vger.kernel.org,
    Marc Dionne <marc.dionne@auristor.com>,
    "David S.
 Miller" <davem@davemloft.net>,
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
Content-ID: <2090400.1787065524.1@warthog.procyon.org.uk>
Date: Tue, 18 Aug 2026 16:05:24 +0100
Message-ID: <2090401.1787065524@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Jakub Kicinski <kuba@kernel.org> wrote:

> Let's do a full v8 if you don't mind.

Ok.

David

