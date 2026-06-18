Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3D93EF65D
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 12:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781784078; cv=none; b=XwlDmeRQSukfBQ3qQgTyrk17BV4xddowJanLFIsAOex5/qXtOZXwPjAsknwJcSYdMUNjTbXczAvgURvUUzSUKj8B84PPtjN1fxWqPKziTSx74zLmvW8EMnylrVSnGYZP2+1wsSvihTaOszWHZfAYChMg53aWOayZ43bCDLY9Qig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781784078; c=relaxed/simple;
	bh=jXscxMsn96G0U77w2caDn5Gwti+xjKKXwzTdX8ngFgw=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=HISSZ60hV/+TOjABU7Y0HOPzTr0ToAU/PK/rzfuhp6LCzPmU65j//VhhHWs8fJ9oFVGZ+2lrLUsf2R0QSkBj6v6+qZQDva4H3tTVTAUhkHhn37poTvmNGtMSLl+EpEDdpxReKpNjEXzRDMudtJbCSSqk5VX78VVEI3QQkA4UEbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gs96gnwu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gs96gnwu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781784073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jXscxMsn96G0U77w2caDn5Gwti+xjKKXwzTdX8ngFgw=;
	b=Gs96gnwuyKpAm3mZXVW5rkuHBpkN0dJtAbjf2CjwJjHCI9Lb50dozdL1qvDN+tlM5qiq5Q
	qQr55/fZHpB5P1qXvpCWOoFMYax0dCPmfFoyGsVPg9tTyZZ5BqE0cuz9e+J0ienR1THIee
	Q0mR8Heml/OUDiN6zY2aLfaag6YCCyc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-6tX5MKSQNtKMtByoald2bA-1; Thu,
 18 Jun 2026 08:01:08 -0400
X-MC-Unique: 6tX5MKSQNtKMtByoald2bA-1
X-Mimecast-MFC-AGG-ID: 6tX5MKSQNtKMtByoald2bA_1781784067
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0448F1800BD2;
	Thu, 18 Jun 2026 12:01:07 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.50.44])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C189D1956043;
	Thu, 18 Jun 2026 12:01:03 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20260616155749.2125907-1-dhowells@redhat.com>
References: <20260616155749.2125907-1-dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
    Jakub Kicinski <kuba@kernel.org>,
    "David S.
 Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
    Simon Horman <horms@kernel.org>, linux-afs@lists.infradead.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/5] rxrpc: Miscellaneous fixes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2418212.1781784062.1@warthog.procyon.org.uk>
Date: Thu, 18 Jun 2026 13:01:02 +0100
Message-ID: <2418213.1781784062@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

I'm going to send a v2 of this patchset, so please don't apply.

David

