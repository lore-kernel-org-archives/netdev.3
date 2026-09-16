Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4E44AFE25
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 10:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789553602; cv=none; b=mKql1FHRRsD7ciMzPF8JPUv6o7m9gfVcoHt3MZEnpcVzLapKVY6WbQhRNQ4NwJ5XODh4Nrz0r4pZfjPqTBT+gTHksf8xPFf69B2huzq+PAhhOw/3WY1FXu6wNYrnI5bLUwIVpSlwZS7hlW5LqPlMeNPu+HnjU1zzYXcoWOkq6VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789553602; c=relaxed/simple;
	bh=C6Aos2BBAKNPtzD1p6pos02H1wbUMwW8WkxKtu0zVE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JR2jWjtXj/2aW99znGUJnSF6qQ0uZWC1Itg6OaUZtYBKrAYWb0zhdWENCezHx4oWaVfkG+TkzIUFLJj+MkqvS00EJph0WRIHg2zGfkft+i62nos9F69uVVIxkWNFnu/ribKOo18yeKjM+cdGZ5ozGa2vhev+bYaOFj1TtbYClJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LVbRnSXZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LVbRnSXZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789553588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C6Aos2BBAKNPtzD1p6pos02H1wbUMwW8WkxKtu0zVE4=;
	b=LVbRnSXZX6rMsMvRjurfntrlEBsApAEdK/j/sKkbI6S8t/VlgRvmaRh+wpcPzm6GRlE5id
	wcQ8qjQXGOHRyhLViorIQcs+0OoVUVOiV9I/5PrY1RrMDil9uXWbDTVb74vqghCvaxEPlG
	a6+YA9XNUU6Ot847fsWrlsXT3dtZiZY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-465-FJYG7LPOPjaY1p-jn2scnA-1; Wed,
 16 Sep 2026 06:13:05 -0400
X-MC-Unique: FJYG7LPOPjaY1p-jn2scnA-1
X-Mimecast-MFC-AGG-ID: FJYG7LPOPjaY1p-jn2scnA_1789553583
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 33C0D195411B;
	Wed, 16 Sep 2026 10:13:03 +0000 (UTC)
Received: from fedora.redhat.corp (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3281519560AB;
	Wed, 16 Sep 2026 10:12:58 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: kuba@kernel.org
Cc: aleksandr.loktionov@intel.com,
	andrew+netdev@lunn.ch,
	anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	jacob.e.keller@intel.com,
	jtornosm@redhat.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	przemyslaw.kitszel@intel.com,
	rafal.romanowski@intel.com,
	sdf@fomichev.me,
	stable@vger.kernel.org
Subject: Re: [PATCH net 1/4] iavf: return EBUSY if reset in progress or not ready during MAC change
Date: Wed, 16 Sep 2026 12:12:56 +0200
Message-ID: <20260916101257.17595-1-jtornosm@redhat.com>
In-Reply-To: <20260915092418.0aafd079@kernel.org>
References: <20260915092418.0aafd079@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hello Jakub,

> You're not fully fixing the issue, and sprinkle in EBUSY returns to user
> space instead of waiting. I'm afraid that below the bar.

The -EBUSY here is not replacing a useful wait — during reset,
the admin queue is down and the wait would block for 2.5s on a
non-functional queue and could still fail anyway.

This patch is preparatory for patch 3/4 which replaces the
wait_event with a synchronous virtchnl send + poll, eliminating
the wait under netdev_lock entirely.

The early -EBUSY here is needed because the synchronous path in
patch 3/4 must not attempt to send a virtchnl message when the VF
is resetting or not yet initialized — the admin queue is down or
in an undefined state, the message cannot reach the PF, and the
poll would hold netdev_lock for up to 2.5s on a non-functional
queue, blocking iavf_reset_task() which also needs netdev_lock
to proceed with recovery.

In short, it prevents the synchronous poll from blocking reset
recovery by holding netdev_lock on a dead queue, without
disrupting the existing driver reset recovery flow.

I think failing fast with -EBUSY during reset/initialization is
the correct behavior: it avoids delaying reset recovery and the
caller can retry once the reset completes (milliseconds to
seconds). The full fix is in patch 3/4 which carries the Fixes:
tag and cc: stable.

Without this guard, the synchronous path in patch 3/4 would wait
for 2.5s during reset on a non-functional queue and still could
fail with -EAGAIN, while holding netdev_lock and delaying
recovery. The -EBUSY avoids that pointless wait.

Thanks

Best regards
José Ignacio

