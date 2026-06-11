Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6EA37700A
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 08:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781167560; cv=none; b=DM98p/or9f8czIwyX7P6q8LTwErtBE7krNL4fgGLWtMPTwmlSGllNmpeh+Lz8Mq3jvfYyMmSdmU4GmG1CTuOqvabgzqnSAClWphA5E21+H16293JrB1aFKLRPutQfVWTT/btDPUDXd5DECh7o5nlRAuO5rvNJalRicLgxauO22E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781167560; c=relaxed/simple;
	bh=yDJBfs20l2Xs17nIeHGIm4cX8CniXBdnKTlO4JjiAuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XIl5gn+HbbCFxl6tOsJ1t/V9tr2M4t0i/hcEF9nIedkVF74HTRugAOU2l6+8Bx8ZpkryVUEESWTjxX6v7pRKCywtQVVHhhDRZzklERUnNG0QSw5buIsaYAcasDVch5qtqPUgjyWBNR8/2s3Vp2Dr2JSF9rO8itEBvjI0Goo6rKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U5bI9G/R; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U5bI9G/R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781167558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yDJBfs20l2Xs17nIeHGIm4cX8CniXBdnKTlO4JjiAuQ=;
	b=U5bI9G/RBSeMU28ErWDq0u100XIGhZZWVGeoQHhK3a/y8k7RlaEjP5MaVkxk+2pAXri6uu
	3QWAZeErgxirePbhzZeaXjeNStGM82lRLnMourpCvYjnrVbp64O4mcRqAkvtkPAMKsjgD0
	lILpkOsrajcMeaOeGC2tRQYKbVMUo9I=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-245-Ut5TMn77O7q3Czir8k-9Yw-1; Thu,
 11 Jun 2026 04:45:52 -0400
X-MC-Unique: Ut5TMn77O7q3Czir8k-9Yw-1
X-Mimecast-MFC-AGG-ID: Ut5TMn77O7q3Czir8k-9Yw_1781167550
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 03A331944A96;
	Thu, 11 Jun 2026 08:45:50 +0000 (UTC)
Received: from thinkpad (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0214E3000223;
	Thu, 11 Jun 2026 08:45:45 +0000 (UTC)
Date: Thu, 11 Jun 2026 10:45:42 +0200
From: Felix Maurer <fmaurer@redhat.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Kexin Sun <kexinsun@smail.nju.edu.cn>,
	Yury Norov <ynorov@nvidia.com>,
	Quan Sun <2022090917019@std.uestc.edu.cn>,
	Luka Gejak <luka.gejak@linux.dev>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: hsr: simplify fill_last_seq_nrs()
Message-ID: <aip1tjdLIUXre9e1@thinkpad>
References: <20260609171545.1051322-1-ynorov@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609171545.1051322-1-ynorov@nvidia.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, Jun 09, 2026 at 01:15:44PM -0400, Yury Norov wrote:
> The function checks the HSR_PT_SLAVE_A and HSR_PT_SLAVE_B bitmaps
> for emptiness right before calling find_last_bit().
>
> This pass may be avoided, because if the bitmap is empty, the
> find_last_bit() returns >= HSR_SEQ_BLOCK_SIZE
>
> Signed-off-by: Yury Norov <ynorov@nvidia.com>

Reviewed-by: Felix Maurer <fmaurer@redhat.com>

Looks good to me, thank you!

