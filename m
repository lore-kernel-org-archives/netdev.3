Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5C43AE198
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 18:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776970056; cv=none; b=e2meTpyMfPrX0AbV3jzh3Z78tWB/oq4Ukt3YSJ3dy4gIXXSvlb0zIyIXz6A/H2Hd9cGgu+kQo5cpkUPWqA8sBV//NyTL9l09xqMTlgHLYYm8wLIqoM4wNP4Z4iXRsTsCyp4b+3NRBGN9hk1lcp2TpGKMYWXASzzTOjPTWdxIYdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776970056; c=relaxed/simple;
	bh=r2EUKti5X+cSY4oxvJ24FqW/upiD6X5/jN0JpRv7WIc=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=p9+qX7ILtue4gCbeCaBjChz7kbVI2Odx3tFUGZeZ05Qw+amDLb3DxtVyqPy8daQ9hGMD6lGwcQGTwbPtiRoOYLFU4Bto72xe0x43figf2kKz6e7YiUmwPnCSx+IeBL7SywJA/VRHfYeQBeUQaLyiO7IG8YoX6Mq32Ef3cqXx8PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RmrAoPNY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RmrAoPNY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776970054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+WcMHP0SJX909nPyJJt2pzIVEyAC20C/POWxuMPBr1Y=;
	b=RmrAoPNY7G5xxVm4PNxurK+SUfp79byjeJjGmB9uijaXpzMN+rJzjmK4QvEjxE1kxiE5it
	iHtEZuyG1NIdiRuR7hMFzOYr5JOvx+PG08q7p/NYs6bJPTf/FRCBM2E/X3rHAUVTOq+zaM
	1K0xXU+WTGK600UpPK7x+3SRJTpwDvU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-cfQHFzUvM_S7Ein0UKnh-A-1; Thu,
 23 Apr 2026 14:47:30 -0400
X-MC-Unique: cfQHFzUvM_S7Ein0UKnh-A-1
X-Mimecast-MFC-AGG-ID: cfQHFzUvM_S7Ein0UKnh-A_1776970048
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8E64218005B6;
	Thu, 23 Apr 2026 18:47:27 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.48.17])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 22292180045E;
	Thu, 23 Apr 2026 18:47:23 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20260423105639.6e0a0a7e@kernel.org>
References: <20260423105639.6e0a0a7e@kernel.org> <20260422161438.2593376-1-dhowells@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: dhowells@redhat.com, netdev@vger.kernel.org,
    Marc Dionne <marc.dionne@auristor.com>,
    "David S.
 Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
    Simon Horman <horms@kernel.org>,
    Anderson Nascimento <anderson@allelesecurity.com>,
    linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 0/6] rxrpc: Miscellaneous fixes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2990992.1776970042.1@warthog.procyon.org.uk>
Date: Thu, 23 Apr 2026 19:47:22 +0100
Message-ID: <2990993.1776970042@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Jakub Kicinski <kuba@kernel.org> wrote:

> Have you had a chance to look thru sashiko run for this?
> 
> https://sashiko.dev/#/patchset/20260422161438.2593376-4-dhowells@redhat.com

It wasn't available this morning when I looked.  I know there are a couple of
things to fix from other checks.

David

