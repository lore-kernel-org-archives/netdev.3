Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE533AD52E
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 20:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787863980; cv=none; b=FU4TScEgKoS1XxG6uGh7DsziEnrqRN5orkUv1FL1fuvNeD/IKV8tngsL6ha7PCSKEn5pwSpZLqJzJY//xezVpI1JHBhOGHUqIJJZFMP4nnHzPM66G+UJ9QMuVjW/Txy2b3DpehyD4/C/zKsbWAeNVFzjrTAtkqk9DRiFRNKGftA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787863980; c=relaxed/simple;
	bh=0Chqx6WH1u0Mf0GyWh6BMIsSMTThTfRsXV0B0hMBHZc=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=FNdplKUaXA/RJSAyOmWwvrS83qwx5Ntvg74kKCCje1fJUaN9fsWkWN9QYxk4iYn8+ptRWMRwsjFDQSekHDXdEgRox+A79NnJwkkWm7+vLdo8v37ri4QtmORgsisOe1uiEnOPj/gbZPTVyWChmJ9EYrZ/8OjIuJePeNnB5oCM2b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MEuwtep8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MEuwtep8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787863977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WQ79GLnxP2mfq88wFmbxlLH55XhZEIIm9+qkuFVWJbg=;
	b=MEuwtep8/oQSu5D8r0hHgrZA0YhpINFF+RcMGUmo071YHz5PaUswALfEAonn2rrmuUktmr
	1NKYvXT7v4POZPEGKCd+/5cpy1Gp7XpfgcbLusxdcMR5iBgQNmNwpec7id7f05X8y9EutF
	u+YdV6nkvGp3TqQBCRG7OB7AM4qdP5s=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-256-RIEQwW_RMeC_M2kvR9_5EQ-1; Thu,
 27 Aug 2026 16:52:52 -0400
X-MC-Unique: RIEQwW_RMeC_M2kvR9_5EQ-1
X-Mimecast-MFC-AGG-ID: RIEQwW_RMeC_M2kvR9_5EQ_1787863970
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6DFDC183F9EF;
	Thu, 27 Aug 2026 20:52:49 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.88.47])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8056F1955F72;
	Thu, 27 Aug 2026 20:52:46 +0000 (UTC)
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
Content-ID: <2416733.1787863965.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 21:52:45 +0100
Message-ID: <2416734.1787863965@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Paolo Abeni <pabeni@redhat.com> wrote:

> It looks like  some of the comment raised by sashiko are new,
> especially on patch 9/12:
> =

> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260812110129.97997=
0-1-dhowells%40redhat.com
> =

> Do you think later follow-ups (i.e. in another series) would be ok?

Hi Paolo,

That's a couple of weeks old and about v7, not v8 of the patches.  I think
I've addressed everything in it that's not pre-existing

David

