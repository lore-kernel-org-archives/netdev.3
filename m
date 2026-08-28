Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB533A4F4B
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 07:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787901183; cv=none; b=C/G6fIgC93bPBRwHbjokSkzV8dNxeNEaTSK+FQRc5p42wv0xbS4XXYR0P55o2vb/yVUPt4WDNzQ8/iOnsajOE6YWgPYr8uAW/+UiPRcaDZK+Y1Y96GYLtZiJlygxbFiC+MuQKMSAVOf9fOsqJUY71gYtum82xUTmEj0EAmBp/Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787901183; c=relaxed/simple;
	bh=iCJUfJv4ZhUZHmTzZnX6JEu4X2v32p8EQHUJrJkO+yQ=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=dfZdD0mlLU6BVLqHg3e8P7mIbxEH1fOYOw6IrPw8X7P6k+oFkcMkUlOl0WmlQyIBaJEgYNC4OoydQ4rejZnghfEscQSFG4nlH7vjxReVQm3+lcISJVNvYTtaLtDOr3nid3MOG6RXrGNwAkHl/2dbMwHB2jrCq1x+prHpuSMZQtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KVioHxX1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KVioHxX1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787901180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AJ5XTjPGWuvp0rDtOzuNKrCwaKf5Txk4jMJiBlh5BW0=;
	b=KVioHxX18fby+wq9kJ31I6QMMeU+nggCYWTF+Np6p2nZo5BToI0CDVAV5J6ixsrnM2J+N/
	lrHklPtPG1/FZQHitiFzjQkllrLQR0GQdeflNQbDxfa1GzEAF1KL4u28ENBa9YI0DgSeOM
	IS6/fYxgYfFMRPXSkXkwjLzIKoZ/RZc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-412-cftgXQacPLiPo0_h_lKG3g-1; Fri,
 28 Aug 2026 03:12:55 -0400
X-MC-Unique: cftgXQacPLiPo0_h_lKG3g-1
X-Mimecast-MFC-AGG-ID: cftgXQacPLiPo0_h_lKG3g_1787901173
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A060E18CC4AF;
	Fri, 28 Aug 2026 07:12:53 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.88.47])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AD77226C;
	Fri, 28 Aug 2026 07:12:50 +0000 (UTC)
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
Content-ID: <2558720.1787901169.1@warthog.procyon.org.uk>
Date: Fri, 28 Aug 2026 08:12:49 +0100
Message-ID: <2558721.1787901169@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

Actually, sashiko has a point.  It's theoretically possible for userspace to
fabricate a ticket with an encoding type that's supported by the client but
not by the fileserver, in which case, yes the fileserver would be unable to
use the proposed return channel if someone else tried to contact it with a
valid ticket.

Note that this is an afs layer problem, not an rxrpc layer problem.  Each
rxrpc call is tagged with the keys to use and are grouped into virtual
connections by those keys.

To solve the issue, it might be sufficient to ditch the appdata key from the
server record if the fileserver returns RXGK_BADETYPE and the caller's key
matches the enctype of the server's appdata - but that leaves a potental race
in which two callers try to talk to the fileserver simultaneously.

Probably the afs server rotation code needs to be changed so that, when a new
afs_server record is created, the caller creating it holds off other callers
until at least one probe is completed successfully - and if not, it removes
the key and moves on to the next fileserver.

David

