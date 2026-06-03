Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B499F481248
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 19:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780514554; cv=none; b=dYSbtkpVPAS8aXoK8IJ5NMYCClNjmzmhprQESyjaZKW62bwApuxILM+qcm5c5IcCmFaGl0/l1Y769Dr1WFFIfPxGUcYcAKZVr8PA/houijaPnscxuUFWhsy3ZpfmgsKlkPE6MvLIlh88Fe+JYJhrW5bjshmPF8qQHSANzFHkyx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780514554; c=relaxed/simple;
	bh=LDFA3pbOm+KSrwgSML1mRQ80y9BoK4sbHsGg8JM9Eeo=;
	h=In-Reply-To:References:To:Cc:Subject:MIME-Version:Content-Type:
	 From:Date:Message-ID; b=Uh36iFb83gwNUQkYYVZsCOm97w+gO7kxPzdIJ+fgV80kVj2W9iQljbFHUkHiLjeeao82TVevHF8e15wy04DR4F3UcY1ENUsE3+lk3cCBM+sgrz0KxzVeNJ0CSaWjx3c9JO+XPzjsZaNDY4DQprko3TjCFWqPzqwCjgYdxtwIam4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cZPC8pPr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cZPC8pPr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780514553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SzfTa5HCL1jfcKZlB3EuMMBtnPEwh0opU3X/4Q5o0kA=;
	b=cZPC8pPrBWRyjBVgrQ5TDGrvJGrDEZTljDOw9I2D2PuH5kIBobiPR4DG4JDsYGNgZiIdsv
	34JEBpEN1FWAwbLDKl26LPDUYYA8bi5GxdHVyOD/4wVVKfdmqE8R4A+G8AlFcv2YyQZX4P
	QYgnRLLxsC0CMsxNuayn9a38wvX0y6A=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-681-aQ1vVfH5Ndq95wd2x-ZPOw-1; Wed,
 03 Jun 2026 15:22:27 -0400
X-MC-Unique: aQ1vVfH5Ndq95wd2x-ZPOw-1
X-Mimecast-MFC-AGG-ID: aQ1vVfH5Ndq95wd2x-ZPOw_1780514545
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E63FE1956095;
	Wed,  3 Jun 2026 19:22:23 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.48.52])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 75C3219560AD;
	Wed,  3 Jun 2026 19:22:16 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
In-Reply-To: <CAHk-=wiEwSjfbjfO74xu=UmkkdHXkJg5QNQ8pP-3iYmunmeV9g@mail.gmail.com>
References: <CAHk-=wiEwSjfbjfO74xu=UmkkdHXkJg5QNQ8pP-3iYmunmeV9g@mail.gmail.com> <CAHk-=wiAqf0PdZ4AKj_4riUnnEb=g_ZNPkLnXrByA9BBHYiFRg@mail.gmail.com> <20260602225426.122258-1-safinaskar@gmail.com> <CAHk-=wgKy4dP0oQCNKyMQQf3-uVpaigmDyH6_T0Via76gWST9g@mail.gmail.com> <CALCETrWx8-Q5-rK1KnAPCxCbXaWCd=Yfs_Pr8qVMa8k8L6of1w@mail.gmail.com> <CAHk-=wizkDXRut5xLXRF-CVUVYMaZ5AOexxeghOAoXPb4yAvQg@mail.gmail.com> <CALCETrXzxubt4eWue3+wv7Fq9C2m7uu6bWPstqFh6Mo57bPwQQ@mail.gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: dhowells@redhat.com, Andy Lutomirski <luto@amacapital.net>,
    Askar Safin <safinaskar@gmail.com>, akpm@linux-foundation.org,
    axboe@kernel.dk, brauner@kernel.org, david@kernel.org,
    hch@infradead.org, jack@suse.cz, linux-api@vger.kernel.org,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    linux-mm@kvack.org, miklos@szeredi.hu, netdev@vger.kernel.org,
    patches@lists.linux.dev, pfalcato@suse.de, viro@zeniv.linux.org.uk,
    willy@infradead.org
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <22677.1780514496.1@warthog.procyon.org.uk>
From: David Howells <dhowells@redhat.com>
Date: Wed, 03 Jun 2026 20:22:15 +0100
Message-ID: <22766.1780514535@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> Because if people think splice is complicated, you haven't looked at
> the skb rules. They are completely arbitrary and complex and spread
> all over the tree.

Yeah - I fell foul of the net loopback driver just reflecting the outgoing
packet back, complete with all the original spliced bufferage.  I was
wondering if the loopback driver needs to look at the skbuff, see if it has
zerocopy elements of some sort and, if so, copy it (or drop it if ENOMEM).

David

