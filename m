Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792563036;
	b=0YK5HQKlDtw1o1OhDqu7yFjAZPAtKRQVeGfGZqOvxr4nEFprJDAO1Til4Vwm8S7bB5Cf
	 xmpJhNWY0HbAALBQkFFkY4xQaXJpkIr85WNvRO9O+d38Knfh49Wpa5k88U65dagoj/Afo
	 RQdmgW+4l/8eZN96WXL3RWc/2hXh+PAC4cPRjxUhMbiy3Vg2bu6LU65atQZXaLjH2bQ5s
	 u/ox3wIspv1nzsr34DupTL8XNLEwdkxmEJ1XKxlSr0dEeRjfgufRlqvdapyx8B1Fwardc
	 VGdrVy958fKuuceqbzPEnTNlIVAOEQleaXCsAnsqQSLbwlsi+xqc4EUgar2Zu0W8VcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792563036;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Organization:From:In-Reply-To:
	 References:To:Cc:Subject:MIME-Version:Content-Type:Content-ID:Date:
	 Message-ID:X-Scanned-By;
	bh=GuuDOm0BjSie9cFo6lFAftu5W8QXWJ6WU57HDoPu4Ao=;
	b=3pJAzDu4v2/tELZPUio03Pp6zmors8vfCtukQn8rixlUF7jL7l9ZmIswgs+QQ9nP0OUM
	 8j72wsCBK7scH7ClJVddStJU59BgrneN/iHN/UPgE3Z6dD1TzRbM0mYyhNowYG04ZQaDS
	 WrDPhXjRcd/kvAPJbtpfir1izGc89cOJmAVEtsjMo3gfQruoQZ0ODRwncAuGOrzjAfY9s
	 kzWEF6Uaa8BhGwY48fBKWDz1w7l+yYzSnkEDJMgGsgTw+VBF2zohZ4aLjto8NWtQ4UbVc
	 D7SlSRWaHQ10TByMIqI3HoPPSp4WCPOJfZH6yPB89tX0wfF+IaSkjE4NSO8pLtN5zJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QLO1qDkZ;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4673606A31A
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 06:10:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4673606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QLO1qDkZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792563034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GuuDOm0BjSie9cFo6lFAftu5W8QXWJ6WU57HDoPu4Ao=;
	b=QLO1qDkZq/GkM7DkTTZoiu9aFqRMnKPjasc6inQuuBbjxdHwkY4UJrLgK+i/2C+Mvwyabq
	p1DcnwpR/LqPikmMFllwMeHNyQT+REBnVWM1vGLxiyc45JgvEeMPnTH+vL36QtA3u8Nc8q
	O7psu6CiY17ErHGyBRm6+Gy9UMrLl4A=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-LqN27gqEOv-3PX80p2xKgw-1; Wed,
 21 Oct 2026 06:10:31 +0000
X-MC-Unique: LqN27gqEOv-3PX80p2xKgw-1
X-Mimecast-MFC-AGG-ID: LqN27gqEOv-3PX80p2xKgw_1792563030
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2D8EC1955F0F;
	Wed, 21 Oct 2026 06:10:30 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.48.29])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2DDFA1800446;
	Wed, 21 Oct 2026 06:10:26 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20261020201258.290827-1-dhowells@redhat.com>
References: <20261020201258.290827-1-dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
    Jakub Kicinski <kuba@kernel.org>,
    "David S.
 Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
    Simon Horman <horms@kernel.org>, linux-afs@lists.infradead.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 0/3] rxrpc: RACK-TLP fixes
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <311751.1792563025.1@warthog.procyon.org.uk>
Date: Wed, 21 Oct 2026 07:10:25 +0100
Message-ID: <311752.1792563025@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Note that patch 1 might better go via net-next.

David

