Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792672400;
	b=U48lH1pTX7wlhXvwvn8yDYLWdBR1J8A6lPQ/X4zlewV4v+gkJA2K57xCP6yFKDxAX01d
	 LeISce6t0WwBMLvjgHCWMormeIeCx2KjxAnP2AWlnQB3zt/3U/B08l97d7SS9ay9w/X15
	 R/PeLincWdTldwrCgtyH9jTmXrmT4FyUSZXJsuSUG+4J71zy+L2ys2UodBrcCMuJmcAOb
	 uODEnj843L5oWZ4WiFHcSyPCvhvaT57/FE6+jvY6ZaWp3l472riLttzlAurVk9Ig6Aok4
	 DYEcjMZarYRsOVitrMpkAIZmDqCGOUUuppQdIfUyd25IcciTu1Ji0tgdAjRZHzMdpdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792672400;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Scanned-By;
	bh=ORzLwHM8BGYbMikpTiVo/3MerTLh128qa09MowVExQQ=;
	b=FIdEEQ6srKaxhaT4E+cLNvoB5EFl2jcKCdRJACJyAJkSABUPdkK9iEfpcKEXle7KSeZ7
	 WEHGcoucvxK9qJ7rfQjJ5ZQGmzZf0RZvBM31U4KF0ymyGfavF/5TmPJ9WafUEVLGkm9Pi
	 jVdxwnOlFzwV/aaEj642J6jXw22RItz0vbA+8vaw84xAeoF9xPZhPlNmn7x16E5Zgt+Yy
	 TEkPisohPJRvojOudFZY7Qjo5Y5787EtaCRNkvRiIT2P9wNHT2JHjk49ol6XXMs/Snf18
	 L1qkkXallFLofolpkmchCMGeWboDRgCUU4rWuNUpDcKqdB9jxdu0/FpX9dTv/xYX0Pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=N5erlkmk;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822A2606A31B
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 12:33:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 822A2606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=N5erlkmk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792672398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ORzLwHM8BGYbMikpTiVo/3MerTLh128qa09MowVExQQ=;
	b=N5erlkmk6B7WbVpSkMlDATuGaDNrp2ef8cA+n8VbdVxnaHs5aGAjg0t8v9nFw/uoANASqn
	UQmJK6sfF8YoxW5JAuiqbGyDCoHmxu6gRm+w+2f+GPgW/CkbWvdQ6oE/U6Om3r9SdrTKVR
	hS0dMX5Xfukp2dFuupZrXOyv0rsFVk4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-344-fU_oay6oNrCdi7x5QJoKOQ-1; Thu,
 22 Oct 2026 08:33:17 -0400
X-MC-Unique: fU_oay6oNrCdi7x5QJoKOQ-1
X-Mimecast-MFC-AGG-ID: fU_oay6oNrCdi7x5QJoKOQ_1792672396
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C969718011D4;
	Thu, 22 Oct 2026 12:33:15 +0000 (UTC)
Received: from onestero-thinkpadp1gen7.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 4EE071800347;
	Thu, 22 Oct 2026 12:33:13 +0000 (UTC)
Received: by onestero-thinkpadp1gen7.tpbc.csb (nbSMTP-1.00) for uid 13628
	oleg@redhat.com; Thu, 22 Oct 2026 14:33:15 +0200 (CEST)
Date: Thu, 22 Oct 2026 14:33:11 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Allison Henderson <achender@kernel.org>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org, pabeni@redhat.com,
	edumazet@google.com, kuba@kernel.org, horms@kernel.org,
	joel.granados@kernel.org
Subject: Re: [PATCH net 1/2] net/rds: do not fail init when CONFIG_SYSCTL=n
Message-ID: <atoCh3jw_1noK2Nr@redhat.com>
References: <20261021195837.142802-1-achender@kernel.org>
 <20261021195837.142802-2-achender@kernel.org>
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
In-Reply-To: <20261021195837.142802-2-achender@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 10/21, Allison Henderson wrote:
>
> Only treat the NULL return as a failure when sysctl support is actually
> compiled in.  The exit paths need no change: unregister_net_sysctl_table()
> is an empty stub with CONFIG_SYSCTL=n and already tolerates a NULL header
> otherwise.

FWIW,

Acked-by: Oleg Nesterov <oleg@redhat.com>


I'll rebase my changes which move all the sysctl related code in net/rds
under ifdef(CONFIG_SYSCTL) on top and send the patch(es) for review.

Oleg.

