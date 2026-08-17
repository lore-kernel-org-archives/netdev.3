Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA723BB12D
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 20:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786997974; cv=none; b=DOGqKy+KBDSEEIwkSnHnKAKbGzQmMd2ZstU6jOohzHwNBjzXEd+E5bmEBXRi51EF9pmiRIC4tsIFCRJHA83vhXMjRiWEXqaRlA/a+0NSlWg0F3b2Zs9JnryZOVBuiYZ/A8BDOWoex+iO0Rp+XaLbvi/7sMF0jeaRBXh/8PJU0Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786997974; c=relaxed/simple;
	bh=5yv6BOByIuhB9xiurumezIs0785zJdR2sXB3UiuIbJ4=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=XcVmnlTnlWXQtJMTx8O2wOb/lHTxxvBA5AxOADXddWb0KTu9kFbyYo5rnU50SCPHoEAve1zIJ7PI8tYHpIMepAid0jqGifSuIXD7KI4tOW5fq+TXkLwFBIoG+bXe6HI6M4+1dbsoo1mBaYGX3vSCA8YkMgv99DH0FvX1QgS4Fgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MHqWzDSM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MHqWzDSM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786997971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5yv6BOByIuhB9xiurumezIs0785zJdR2sXB3UiuIbJ4=;
	b=MHqWzDSMQdmSGMFxBvhDMD3XzxrBUh9Le7nKfO3cyzO4l6ATlLGN7LkJ+LXK3PoDpPkZlY
	a2aQXUvBhf3tcRxnqCBUxKZrkAgGhk307eai765lbGozELrhSJvVTQHyVX2TshhmckfVeC
	efYcWk9Clp6PVfihjrTtWQzLSoH8e+g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611--cuoYhSIM5KUd3gTlqlcFA-1; Mon,
 17 Aug 2026 16:19:28 -0400
X-MC-Unique: -cuoYhSIM5KUd3gTlqlcFA-1
X-Mimecast-MFC-AGG-ID: -cuoYhSIM5KUd3gTlqlcFA_1786997967
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 626471800344;
	Mon, 17 Aug 2026 20:19:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.48.6])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AB66E3000239;
	Mon, 17 Aug 2026 20:19:22 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20260807180518.0287b58e@kernel.org>
References: <20260807180518.0287b58e@kernel.org> <20260804172639.2844491-1-dhowells@redhat.com> <20260806091511.46a2fabb@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: dhowells@redhat.com, netdev@vger.kernel.org,
    Marc Dionne <marc.dionne@auristor.com>,
    "David S.
 Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
    Simon Horman <horms@kernel.org>, linux-afs@lists.infradead.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v6 00/10] rxrpc: Fix CHALLENGE packet handling
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1843917.1786997961.1@warthog.procyon.org.uk>
Date: Mon, 17 Aug 2026 21:19:21 +0100
Message-ID: <1843918.1786997961@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Jakub Kicinski <kuba@kernel.org> wrote:

> Blah, doesn't apply or pull cleanly now to either tree :(

I posted a v7:

https://patchwork.kernel.org/project/netdevbpf/list/?series=1144661

David

