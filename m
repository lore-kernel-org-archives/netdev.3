Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37751FE44A
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 13:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784638823; cv=none; b=cnQSJqz+w/huX0/adEApJmi1f1aT4s+nfTqYKRX7lo6AbItOiqep4mJM75bqBRGjNlIA0hUwaLZAxOx/w/zCHQf5r4rGvw1REi0dpTFm7XGVX0GGI2+LIoa47yJLV4GvOgnG0nl1Ewxmv9wh2lRICYKm200Y/K1z7X3nne6eW2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784638823; c=relaxed/simple;
	bh=TXS1Nuyf0R5ao7opZxqQCbEVhYdk1QslD+QClEhqigM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KBw9uH82kdy4K/kxLj4dOiZEIMerWKxwHdvZL/OAZJ6+/sWYQIcylISh0eSeKio4G1R4dc/Rw7/4qISGHoWj8zbf3+t6zgsTYgo+Flyhq9Y3HNpet97acbKzdT1mIGKtr38EUwLUUS8lPpWYL24+dDQctg8NZ0bpPOGnckS6xgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R4rbgfUk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R4rbgfUk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784638820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TXS1Nuyf0R5ao7opZxqQCbEVhYdk1QslD+QClEhqigM=;
	b=R4rbgfUkhgQN2m1CKiMVX7WjpkR9o+iZuAZx6ctqRvi8G+BSmwd6VfaCvQdUrqEBW9Y4Ax
	P/8MBrxqoGWA3EcG1V+o39dDVNcpWO3qqi92V+bZXjutZEofNCWFS1ol1K736VhYOE80hB
	Wu+RbSaLHiOO1skrUx+t3ES1VAeQoTY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-IVfW9yTDMqGDjQrmpJnllg-1; Tue,
 21 Jul 2026 09:00:17 -0400
X-MC-Unique: IVfW9yTDMqGDjQrmpJnllg-1
X-Mimecast-MFC-AGG-ID: IVfW9yTDMqGDjQrmpJnllg_1784638814
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9AFCC1808895;
	Tue, 21 Jul 2026 13:00:14 +0000 (UTC)
Received: from thinkpad (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0D4583004190;
	Tue, 21 Jul 2026 13:00:11 +0000 (UTC)
Date: Tue, 21 Jul 2026 15:00:08 +0200
From: Felix Maurer <fmaurer@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com,
	syzbot+456957213f32970c0762@syzkaller.appspotmail.com,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: Re: [PATCH v2 net] net: hsr: fix memory leak on slave unregistration
 by removing synced VLANs
Message-ID: <al9tWJf9a7U-fdpf@thinkpad>
References: <20260721101240.995597-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721101240.995597-1-edumazet@google.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, Jul 21, 2026 at 10:12:40AM +0000, Eric Dumazet wrote:
> When an HSR master device is brought UP, it auto-adds VLAN 0 via
> vlan_vid0_add(), which propagates VID 0 to its slave devices (slave A and B).
>
> If a slave device is later unregistered while HSR is active (e.g., during
> netns cleanup or interface destruction), hsr_del_port() is called to
> detach the slave port from the HSR master. However, hsr_del_port() currently
> does not delete the VLAN IDs that were synced to the slave device by HSR.
>
> As a result, the slave device retains a refcount on VID 0 (and any other
> synced VLANs). When the slave device is destroyed, its vlan_info /
> vlan_vid_info structure remains allocated, leading to a memory leak.
>
> Fix this by calling vlan_vids_del_by_dev(port->dev, master->dev) in
> hsr_del_port() before unlinking slave A or slave B ports, matching the
> propagation logic in hsr_ndo_vlan_rx_add_vid() / hsr_ndo_vlan_rx_kill_vid()
> and the cleanup behavior in bonding and team drivers.
>
> Fixes: 1a8a63a5305e ("net: hsr: Add VLAN CTAG filter support")
> Reported-by: syzbot+456957213f32970c0762@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/6a4cb6ca.57639fcc.86d58.000b.GAE@google.com/T/#u
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Felix Maurer <fmaurer@redhat.com>
> Cc: Fernando Fernandez Mancera <fmancera@suse.de>

Looks good to me, thank you!

Reviewed-by: Felix Maurer <fmaurer@redhat.com>

