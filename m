Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083173DB62E
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 08:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784796075; cv=none; b=JChYUUJ/9qzm01z5UlS8bwsgC0V9VfMMpTlMoITRoyvt0K1zJN7EMOoV47CCR2Fg38+omScktmpkH2QCX47v2rGPHFlCFPa3RmVcOOrSZQvRtY9RxlL32UwTf6SlbnGC9pvttF6vprpp96PcMU5vuxY084lsTk8iNbbWbmQnWFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784796075; c=relaxed/simple;
	bh=/48HeoFhecviQlxgqiNi98Ekc2O+OBGDJY2Rpwy83yY=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=N9hlBPqdjiauRrSHN9Aa2RRpFU/WK2MQY14pKwoo8go+XWL/Ig8sFfMcYqwTVhKiS9NtfwFZFy6GZfknrFmDCYbPIPvupTRDClu7plk+HILbFbBQNdoR8fpkah6WyLGhQJI82+ivJUbgpBMy5U2uKsGeUybZEAQkh/WuBlVBZrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R/bBrX0B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R/bBrX0B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784796072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QI37KCs9P8o/C93vezUvCAHvKukaX8d5IuhkuYLmz8E=;
	b=R/bBrX0BGr45l6QxtHWiR2uDA56aZFAgJn9w61NsSHozVjtNSVCB22X3lmCqieFGRw7o1r
	bsJi4py/TkB4Vudn96yqfwZK8joXI4IGSZXkNeQUA0ufNATr5qPFmyp9Jq/ELQSxYEHB4P
	QvhnFjj8F9TD5RZRkp9c34zEID2Ruyw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-2QJOjvYwNHeuvl3JDczdVA-1; Thu,
 23 Jul 2026 04:41:09 -0400
X-MC-Unique: 2QJOjvYwNHeuvl3JDczdVA-1
X-Mimecast-MFC-AGG-ID: 2QJOjvYwNHeuvl3JDczdVA_1784796067
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D3EE7195FE23;
	Thu, 23 Jul 2026 08:41:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.33.159])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7D594180025B;
	Thu, 23 Jul 2026 08:41:03 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20260720145222.192109-1-horms@kernel.org>
References: <20260720145222.192109-1-horms@kernel.org> <20260713081022.2186481-5-dhowells@redhat.com>
To: Simon Horman <horms@kernel.org>
Cc: dhowells@redhat.com, netdev@vger.kernel.org,
    marc.dionne@auristor.com, kuba@kernel.org, davem@davemloft.net,
    edumazet@google.com, pabeni@redhat.com,
    linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
    stable@kernel.org
Subject: Re: [PATCH net v3 04/14] rxrpc: Fix packet encryption error handling
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <424690.1784796062.1@warthog.procyon.org.uk>
Date: Thu, 23 Jul 2026 09:41:02 +0100
Message-ID: <424691.1784796062@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Simon Horman <horms@kernel.org> wrote:

> >  			ret = call->security->secure_packet(call, txb);
> > -			if (ret < 0)
> > +			if (ret < 0) {
> > +				if (ret == -ENOMEM)
> > +					goto maybe_error;
> 
> [Severity: High]
> If secure_packet() fails with -ENOMEM, does this jump to maybe_error bypass
> rxrpc_queue_packet() but still return a successful write length?
> 
> Looking at rxrpc_send_data(), the user data has already been copied into txb
> and 'copied' has been incremented. The maybe_error path handles this:

Ummm...  I'm not sure how best to deal with this.

Technically, the call transmission could be completed by calling sendmsg()
again - but as Sashiko points out, the fact that I return the full amount
copied will give the caller the impression that we've done everything.

I also can't just return -ENOMEM, because the caller will then resend
everything.

I could perhaps make it work by reverting msg->msg_iter by 1 and deducting 1
from copied (provided copied > 0; this could be called with zero-length data,
but in that case I can just return -ENOMEM directly).

David

