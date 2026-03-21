Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78071339B1
	for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 08:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774080936; cv=none; b=MaZXQQ9/KAUv//RaNHl7g3w+TAbPD6LiYPmWJzCVhx4dQ253ny1KsKuDZI2YU77W2unvk8ZdgUr35ROHR2n9ZoyNGPNl6C5ylLliZN+rkpK5NvhIGSw1EVX3DsY2ofNB7PEDBew9Lb6um/Xejz+Zra33CGCNHiowmBcOw/pIanw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774080936; c=relaxed/simple;
	bh=qSoKoXhHAQVxvYxUQe/FTpPwNMb0VM5aHpUQnidyiJk=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=KCMtQXKfPpSRUj4Wuc+b8XWiFu0WYK2gSYrZ3aaTVMgBwFVhbpaY2rotceOarC6lM/dGKYLdG/Oesx2H8+HItrqvJ15dbDXE/ls6+kancwIPlLvIO7S4Z2pDG9+D/PfGtyF5rVYfRof1KrEHpF8x8DZM5LhUx6StH2bKz5QqmSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E7pAUbbQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E7pAUbbQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774080934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qSoKoXhHAQVxvYxUQe/FTpPwNMb0VM5aHpUQnidyiJk=;
	b=E7pAUbbQiPIXVLlHKZTJWoe4iLn0m3JDVqLmZE6r+GsOOuDeT+YAVEVbvulQEAVJLaOC/9
	zMmW2xAe1mt2ycmhSiNVlfbMpi39HqLRj0yyj/fGOVIQ8fWLYD1KtyzkGFVR7ajnO9qfJ2
	/+vS/isXwGfgJiNMoXkO2Ai3P/8OkVI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-qkvoBXYFNCWunmVZ6t3P3Q-1; Sat,
 21 Mar 2026 04:15:30 -0400
X-MC-Unique: qkvoBXYFNCWunmVZ6t3P3Q-1
X-Mimecast-MFC-AGG-ID: qkvoBXYFNCWunmVZ6t3P3Q_1774080928
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E957F19560A2;
	Sat, 21 Mar 2026 08:15:27 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.33.121])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D11A4195394A;
	Sat, 21 Mar 2026 08:15:21 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20260321014543.3892478-2-kuba@kernel.org>
References: <20260321014543.3892478-2-kuba@kernel.org> <20260319150150.4189381-3-dhowells@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: dhowells@redhat.com, netdev@vger.kernel.org,
    linux-afs@lists.infradead.org, horms@kernel.org,
    alok.a.tiwari@oracle.com, davem@davemloft.net,
    marc.dionne@auristor.com, linux-kernel@vger.kernel.org,
    security@1seal.org, stable@kernel.org, pabeni@redhat.com,
    anderson@allelesecurity.com, jaltman@auristor.com,
    edumazet@google.com
Subject: Re: [PATCH net 2/5] rxrpc: Fix use of wrong skb when comparing queued RESP challenge serial
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1433904.1774080919.1@warthog.procyon.org.uk>
Date: Sat, 21 Mar 2026 08:15:19 +0000
Message-ID: <1433905.1774080919@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Jakub Kicinski <kuba@kernel.org> wrote:

> The review under --- is AI generated. It looks legit to me.

I saw that there was one on patchwork, but I couldn't access it.

Thanks,
David

