Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C873ACA5E
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 10:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775645466; cv=none; b=T6fjAbAijTf8zfhTBQN3gcEJlaNddH00OBpyHF0oCzezaLxMA3+XOo1t8tG6TXAzjlLD2/FaZEc3elFUn7IySqzUgmDoBNDOFicpI0Q6Tr4a3QJMpDvaCLC383mAs0Sqawv4hDDNvs0LhkBi/DyImfVfT1a5OK5rOL4KXOZX7fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775645466; c=relaxed/simple;
	bh=sSaVPrBQUC0TMC+tWNmkepkRQpbchNS3sCaQ2MNsg50=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=qw08smB3kB9bqzR95OrnbEt89E8yvrp8Igz//pBxbOf9yvDrcuIVTLHYN9AvzWvJKhkmmDM3hhg7BUz2K5zMf4tNEDySPamWCjsxrkb/s+0lD42sjVZSb2pMBpOuX+Pe9UeswBhCDawv03Uu9flaM/GASRT8cajgPnSk6HFQE1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=deVHvWU9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="deVHvWU9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775645464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sSaVPrBQUC0TMC+tWNmkepkRQpbchNS3sCaQ2MNsg50=;
	b=deVHvWU9aGbEeyPNStWWcBh9ynamcljeqHNhWGE67t85zqOuBK4+H7ljRFRaMhCf1m9Itc
	8chzejqzgnpLakp3U5kZxplP5VCVwmme6vLUJSsi5gkQ9acDsEf4fhV+d8jVZ4QBVXCF9K
	pS+lVgf/HuGsyJKje1jS2IcuYkAyURY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-117-C6JZXMuLPNSkKOgsKZvc7A-1; Wed,
 08 Apr 2026 06:51:00 -0400
X-MC-Unique: C6JZXMuLPNSkKOgsKZvc7A-1
X-Mimecast-MFC-AGG-ID: C6JZXMuLPNSkKOgsKZvc7A_1775645457
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CE30D1956071;
	Wed,  8 Apr 2026 10:50:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.32.94])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E408719560A6;
	Wed,  8 Apr 2026 10:50:50 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <aa7aeb86-2430-4c67-9d5d-bb27ad037865@allelesecurity.com>
References: <aa7aeb86-2430-4c67-9d5d-bb27ad037865@allelesecurity.com> <20260401105614.1696001-1-dhowells@redhat.com> <20260401105614.1696001-16-dhowells@redhat.com>
To: Anderson Nascimento <anderson@allelesecurity.com>
Cc: dhowells@redhat.com, netdev@vger.kernel.org,
    Marc Dionne <marc.dionne@auristor.com>,
    Jakub Kicinski <kuba@kernel.org>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
    linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
    Luxiao Xu <rakukuip@gmail.com>, Yifan Wu <yifanwucs@gmail.com>,
    Juefei Pu <tomapufckgml@gmail.com>, Yuan Tan <yuantan098@gmail.com>,
    Xin Liu <bird@lzu.edu.cn>, Ren Wei <enjou1224z@gmail.com>,
    Ren Wei <n05ec@lzu.edu.cn>, Simon Horman <horms@kernel.org>,
    stable@kernel.org
Subject: Re: [PATCH net v4 15/15] rxrpc: fix reference count leak in rxrpc_server_keyring()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2234232.1775645449.1@warthog.procyon.org.uk>
Date: Wed, 08 Apr 2026 11:50:49 +0100
Message-ID: <2234233.1775645449@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Anderson Nascimento <anderson@allelesecurity.com> wrote:

> Isn't this the same issue addressed by my patch "[PATCH net v4 08/15] rxrpc:
> Fix keyring reference count leak in rxrpc_setsockopt()"? Just asking to make
> sure this is intended.

Actually, I think it's probably better to use Luxiao Xu's patch rather than
yours as it puts the check down into the function that actually makes the
change.

David

