Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792575469;
	b=tRo3wfO35HR/2MOJR+RALKsXTVuGYGyioitS0nmOrSD80YRNi1Kj3+Pb/Hg19LqYWZNV
	 DWFCi+c7cb+VIsn2udVrxEVUpmb2TUG4pVFWkVN0xq+D+T9Q+rffr5rM9c0Kv3rh4tzQZ
	 jMtKUylXnsjFLXhDveDFwS9qZOac4g4ClFE9Eik/YE7Uq+hD4l4w0Fsr3sCyOjoofMMFK
	 rtcZlZhNFxfl780FButGZ8jEw4mS0p5QjDNlDF1rh9FW46+acaM5g5VFrlAA6xpu88+3+
	 OJ5TKp4efIObGSUPRg8KWlsKCvKvbMmYRH8aYXBuGDuriPFQnzLTr3NwczGD1ONUCrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792575469;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Scanned-By;
	bh=zYYaJ3Cx83d1i6W0tWGXSMXeldqRUTYijFYdQSWTCqk=;
	b=CdlKR4UI1j8YypNgcKa8veefcrQ8XeIDyQ9v+X2IEWgb5XP8iCpkHOgmEDH2lnUr3B/G
	 ddAB4PXPWRL3dzycwP0cVZAPNhwwG38eX8uuP1iNhTGM99vKKAZMmb407GmCtNWeDojDT
	 S0DvwghtLg3nZHN1Iol5r9ufSRldT0FH6nmvwIe08/SDnoeB0olh+XTL3hkEF+LIR6AGa
	 r8zzccTeiNJH7zpKUdu1+klV3yCjkFt7vRhYXUCu9twhC5+h7OHLmNZfxJMj/19DWMIqy
	 AvfuT1AhBVaikKZsHZ15ubWAOQ9hL3oQHvKO9HbpfNqqSZ0o/7aSwNhgX3W6lvhbYgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MWELxC+w;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD5D606A320
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 09:37:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFD5D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MWELxC+w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792575468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zYYaJ3Cx83d1i6W0tWGXSMXeldqRUTYijFYdQSWTCqk=;
	b=MWELxC+wygAqLfGDTPAxE0k7TvWM+pdLEYREhlp3/jVEm5aB5u6e9jgU2dh9lWBZ3nehLu
	KcoFCUKL4rNbTADztHG2s3AouBZf4CcAx+WIWUFDuaqVyhCaulbWmv70BD4lghcqDAvlQP
	3hC6vgMHHRvmgwNBZqPe3poy1JGbRZU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613-_u7xX48KOf-yVVlOyNLt4A-1; Wed,
 21 Oct 2026 09:37:41 +0000
X-MC-Unique: _u7xX48KOf-yVVlOyNLt4A-1
X-Mimecast-MFC-AGG-ID: _u7xX48KOf-yVVlOyNLt4A_1792575460
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 826651800847;
	Wed, 21 Oct 2026 09:37:39 +0000 (UTC)
Received: from onestero-thinkpadp1gen7.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id D87471956087;
	Wed, 21 Oct 2026 09:37:35 +0000 (UTC)
Received: by onestero-thinkpadp1gen7.tpbc.csb (nbSMTP-1.00) for uid 13628
	oleg@redhat.com; Wed, 21 Oct 2026 11:37:39 +0200 (CEST)
Date: Wed, 21 Oct 2026 11:37:34 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Allison Henderson <achender@kernel.org>
Cc: Joel Granados <joel.granados@kernel.org>,
	kernel test robot <yi1.lai@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, linux-s390@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
	wireguard@lists.zx2c4.com, rds-devel@oss.oracle.com
Subject: Re: rds_wq UAF
Message-ID: <atiH3sYO8XvnP-Vn@redhat.com>
References: <202610190310.9737b2e3-lkp@intel.com>
 <atYB0bm9eEXp8A2g@redhat.com>
 <atYW0K3t57puHeLW@hobbes>
 <atYuE1xnVYe0BDG4@redhat.com>
 <atY42k00k0Waj6o4@redhat.com>
 <42964fa071bd8dcafd418c89be6d66856def4dc5.camel@kernel.org>
 <atdoGiW_sHlWgOwt@redhat.com>
 <e7888169bdc76ea40fcfe782c2bc9b70e037dfc6.camel@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7888169bdc76ea40fcfe782c2bc9b70e037dfc6.camel@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 10/21, Allison Henderson wrote:
>
> On Tue, 2026-10-20 at 15:09 +0200, Oleg Nesterov wrote:
> >
> > Let me try to summarize.
> >
> > If rds_init() fails after rds_threads_init() for any reason,
> > rds_threads_exit() will destroy/free rds_wq.
> >
> > If rds_rdma_init() is called after that, and rds_ib_init() fails
> > after rds_ib_mr_init(), rds_ib_unregister_client() will try to
> > flush the already freed rds_wq.
> >
> > But we have
> >
> > 	module_init(rds_init);		// net/rds/af_rds.c
> > 	module_init(rds_rdma_init);	// net/rds/rdma_transport.c
> >
> > and IIUC the order of these initcalls is not defined. So if
> > rds_rdma_init() -> rds_ib_init() is called before rds_init(), it
> > can do flush_workqueue(rds_wq) when rds_wq == NULL on failure.
>
> It is sort of defined.  When built as modules the order is enforced by
> symbol dependencies. rds_rdma and rds_tcp need symbols exported by rds
> (rds_wq itself is one of them), so they can't be loaded unless rds_init()
> succeeded.

Yes, somehow I forgot that rds_rdma depends on rds ...

> So the rds_wq == NULL case can't happen.

Well, in theory rds_threads_init() -> create_singlethread_workqueue() can
fail too and leave rds_wq = NULL. Nevermind.

> So I think the fix belongs at the transport init: if the core didn't
> come up, rds_rdma_init() and rds_tcp_init() should return early,
> before they register anything.  I can send that along with the
> sysctl change tomorrow.

OK, thanks.

Oleg.

