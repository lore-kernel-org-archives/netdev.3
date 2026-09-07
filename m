Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950441DDC38
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 10:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788775386; cv=none; b=BweTAkjbJNqsBCnEvX1rLKajXy2zVu2s/PQBVbK9B+Y8Uqv2bYba4vubnIpTjQmB0Xmhl6PjiE1F6KNTbJaDqklQR4hAMykRzOVBIzO/oWJNueA+olyi1Hs4xWEFqfuqVHVpypAn9H4tcbziIvVPOkQhys79XsfEkR32qmqkzC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788775386; c=relaxed/simple;
	bh=EmuKp8yPpL3kTtnu+JTxFylD/g+qvdq4iowyu3hyZYE=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=VfCnrwRZDRbkVcbr50JfkuzrwJNa0fedWxsZf17jMvKV7xhAWYR1JlnrI7u+tfqbYBh47bY1gzfylVpG14reoVmQ8bg0OX+bfSXlH8XYUUYqKkCLQtqusYhfY/iHdoU1M56cjUlJlhIisg17QzAG15Gbg/Uk29/4JaesaVb9TmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fHBYhc6V; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fHBYhc6V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788775383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EmuKp8yPpL3kTtnu+JTxFylD/g+qvdq4iowyu3hyZYE=;
	b=fHBYhc6VrZioy/Ih05hcJIZj83LmENNrQMVHr+f6dTrnSyHwEbQbwrAWITUxeE3SQHS91H
	RuWm41o9M7vbwoODD0PskURztMDJybbnsJ/RKJ/z19euVo4cIQdNIEpgoaZMD0t8DpO1se
	3WjL6CuEadumD3T89AuXDi6Ru9browY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-2zDrQAcQMS2iWInoplfkNw-1; Mon,
 07 Sep 2026 06:02:59 -0400
X-MC-Unique: 2zDrQAcQMS2iWInoplfkNw-1
X-Mimecast-MFC-AGG-ID: 2zDrQAcQMS2iWInoplfkNw_1788775378
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5012E1955D69;
	Mon,  7 Sep 2026 10:02:58 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.32.158])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9A877180034F;
	Mon,  7 Sep 2026 10:02:55 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20260901051045.58252-1-qotmddnjs@ajou.ac.kr>
References: <20260901051045.58252-1-qotmddnjs@ajou.ac.kr>
To: Seungwon Bae <qotmddnjs@ajou.ac.kr>
Cc: dhowells@redhat.com, marc.dionne@auristor.com,
    linux-afs@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] rxrpc: fix use-after-free in rxrpc_poke_conn()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1385407.1788775374.1@warthog.procyon.org.uk>
Date: Mon, 07 Sep 2026 11:02:54 +0100
Message-ID: <1385408.1788775374@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Hi Seungwon,

Do you have a stack trace available that I could look at?

Thanks,
David

