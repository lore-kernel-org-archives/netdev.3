Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4E3223DE7
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 16:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776874130; cv=none; b=dESb/c2cFeB+Lec/XI//mBDJ+yo9DkXAUxGAu0xikH2MBJqOjAiMXmnae6q0c1AtPGJbxw7XFQjAlosYaFftYDWPp5mvJzLEWFh6pBDOknEuxQQbJ0x5qA8YPaGwr31o7AMcGoWszrNGSqrUJksHNycptGJgZQu1UkFsufSAi7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776874130; c=relaxed/simple;
	bh=c7RqXZTsAuQCbAHJyujAtCjuvkTwmAMh65Fzy8OwYcs=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=GCN8s7wU+zRTjtUs/KnNxfpeJWpTflwxcQjmfSR1KDaDqS/8+fG1kHe8MtISh1btYgyZSRP0zYchicNvomsJi0JwnurmIVRan12FuVrJqYmC7stdjbNTo07B+HktTUtpCcuq2iwiC8lUmuvYpqY17/mZtLmrSnV09zxSc18DxpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E4OH3zmw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E4OH3zmw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776874128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c7RqXZTsAuQCbAHJyujAtCjuvkTwmAMh65Fzy8OwYcs=;
	b=E4OH3zmw5yAzWQiYNqIkUlUHANGPzKu6gZOioGpMJH+6YOYsLhGS5OgGo7GtVbyhGLdrf5
	br7ObcI7JSMJLs/A3vAzYY2y2CTnchCcYl5KCZY7GBv3dCYA0dS6fknCMg/4vLVaFAtQTe
	QEQjgwh3XH1u1/7Wj5rzQfDu+Vr5yLU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-340-5U4O846gOP-VeOdUlLtuzw-1; Wed,
 22 Apr 2026 12:08:44 -0400
X-MC-Unique: 5U4O846gOP-VeOdUlLtuzw-1
X-Mimecast-MFC-AGG-ID: 5U4O846gOP-VeOdUlLtuzw_1776874123
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AE3CE195609F;
	Wed, 22 Apr 2026 16:08:42 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.48.17])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9984F180047F;
	Wed, 22 Apr 2026 16:08:39 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CAPhRvkyFrKO3O=D9YZoWWVwykCZ1-fXkzA9NyaJ8aaX9b-pcXw@mail.gmail.com>
References: <CAPhRvkyFrKO3O=D9YZoWWVwykCZ1-fXkzA9NyaJ8aaX9b-pcXw@mail.gmail.com>
To: Anderson Nascimento <anderson@allelesecurity.com>
Cc: dhowells@redhat.com, netdev@vger.kernel.org,
    Marc Dionne <marc.dionne@auristor.com>,
    Jakub Kicinski <kuba@kernel.org>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
    linux-kernel@vger.kernel.org, Jeffrey Altman <jaltman@auristor.com>,
    Simon Horman <horms@kernel.org>
Subject: Re: [BUG] rxrpc: Client connection leak and BUG() call during kernel IO thread exit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2593153.1776874118.1@warthog.procyon.org.uk>
Date: Wed, 22 Apr 2026 17:08:38 +0100
Message-ID: <2593154.1776874118@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Do you by any chance have a reproducer program for this?

David

