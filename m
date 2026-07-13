Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D239538F230
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 07:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783928383; cv=none; b=cmP4jxkAGHOZ2bgEjv9shJxA+EW1JycKgBpMDpepCZTEHRr4q9yWCUOoPRI5i1uSrouaV8BRZXtG14av/UjxRfo5BnZYvcYxyDqir41n/oskpuvQfn7mpJmCo0ijhPSJxrEg2Tq622L/0orA2OJGStFNXkJ5X/X76l1LentLpN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783928383; c=relaxed/simple;
	bh=6lwcSV41YpdLrLCyYlP8CD8NVH4zA9wWk2JtdWagEEQ=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=YgROClXscbJ8PNWUdytKpAlY41SXCiteCuOHb0gHiEsup3nCpzG1tiHMyNmPywFpPFGusCAOM+Dg9XMOvwEzu75q2wNsD7LK8pKRtgabocnou3T70XVbMKXtwM2aSDTuq26GVVslcgpV0l5qk+au4qN6/XSAi7CBuT7+897k0kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hQgWxcz+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hQgWxcz+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783928380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6lwcSV41YpdLrLCyYlP8CD8NVH4zA9wWk2JtdWagEEQ=;
	b=hQgWxcz+4bJgiLl76SVfu++jcYoWUFlRcH1FoXNZvctfpgjQaw5KxNnzPYQB1tjNPtIH3i
	21PHoX2MnReJPKcK28KD41HWuRbC2T0txOjinzHalsvKBtb+S8F6MvDJoBQcq1bLDX2+ai
	GgTzxg2lVT/kSs7SVH1EInhlGp01MiA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-544-qJmo9o4xNPW_QfIb7z9k6A-1; Mon,
 13 Jul 2026 03:39:37 -0400
X-MC-Unique: qJmo9o4xNPW_QfIb7z9k6A-1
X-Mimecast-MFC-AGG-ID: qJmo9o4xNPW_QfIb7z9k6A_1783928375
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2AAE91955DA5;
	Mon, 13 Jul 2026 07:39:35 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.33.159])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4AF78180058F;
	Mon, 13 Jul 2026 07:39:31 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20260710192220.1922433-1-dhowells@redhat.com>
References: <20260710192220.1922433-1-dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
    Jakub Kicinski <kuba@kernel.org>,
    "David S.
 Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
    Simon Horman <horms@kernel.org>, linux-afs@lists.infradead.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 00/16] rxrpc: Fix CHALLENGE packet handling
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2171084.1783928368.1@warthog.procyon.org.uk>
Date: Mon, 13 Jul 2026 08:39:28 +0100
Message-ID: <2171085.1783928368@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Patches 1 and 4 got obsoleted by fixes from someone else that went upstream
via a different path, so will drop those and repost.

David

