Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B36232D7F1
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 22:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787868518; cv=none; b=trRZlWDqGNgdIHcvYi5hbFYW2HBLTDOMnugj+YsZidsmqEvVh+Q4HoK1Mji/x0Qd++Rs/Ma4vtBJ3LQMhwK/zR4fqF3WE2PvH8DVFnxFzvyZk2GzBViZp3DQqECqcvaKcREqPt/r+0Oq1A5zvDB/oNbkcK99VxnW/IKhwOYFKqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787868518; c=relaxed/simple;
	bh=u8rB7E1KTIPKCvlCYRtbSGJSrJqJfo1aVYB/7J/Tu90=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=DXDQNCaxWglxwJujRYSTXr/fmzNXP2r8lHXQrM0No5XGr0oajCwFp51MTDm06ZtD7yj7MURw02Ni+RIMwJqGPjdBO7++7brXV6v8oQZLJtXt0a5sInkPubLnAVEYaeciOGFkptrkiiEHwSzr6+cORp0nReeCbvCQShuSurKaTRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PyUS3tnp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PyUS3tnp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787868516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GMxp6wSms+vw9kLz6cUgEySeuHNAMRuIDlnUVPAS7tU=;
	b=PyUS3tnpJxytOQ5GFGdGZ05FIFY7Rl0GdL6Q/kp1BDp31AfOG/qApCbKFTdp2I2vU8g8jF
	7TeD1A6SovkJIumMf9I7L/r1gK82s8Fp7iSygKYcTiOGv77WtqIJ0Z4cGRLx4kVG/1RE2e
	VNdLKDau7Qu6EENdG5SFlNFySuQDjdI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-483-4yYeBdglN9KmKFpx6HSY4Q-1; Thu,
 27 Aug 2026 18:08:32 -0400
X-MC-Unique: 4yYeBdglN9KmKFpx6HSY4Q-1
X-Mimecast-MFC-AGG-ID: 4yYeBdglN9KmKFpx6HSY4Q_1787868510
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F28C21933F9A;
	Thu, 27 Aug 2026 22:08:29 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.88.47])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 349F31955F7B;
	Thu, 27 Aug 2026 22:08:27 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <a0563aec-0ac2-47da-b03e-2e991a2aeabb@redhat.com>
References: <a0563aec-0ac2-47da-b03e-2e991a2aeabb@redhat.com> <20260824091645.415423-1-dhowells@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: dhowells@redhat.com, netdev@vger.kernel.org,
    Marc Dionne <marc.dionne@auristor.com>,
    Jakub Kicinski <kuba@kernel.org>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
    linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v8 00/12] rxrpc: Fix CHALLENGE packet handling
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2422274.1787868506.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 23:08:26 +0100
Message-ID: <2422275.1787868506@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Did you mean:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260824091645.415423-=
1-dhowells%40redhat.com

I've had a look through and I don't think there's anything that merits a
respin.  There's quite a bit of pre-existing stuff that will need looking =
at,
both in rxrpc and afs, but I don't think I need to do it in this series.
Also, the docs need updating, which again doesn't need to be done here.

David

