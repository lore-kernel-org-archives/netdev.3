Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3430D38B7D5
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 06:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778827689; cv=none; b=C5L/JGY19YZ4FcrNujf3Xb5PqOQ8PcHPurkdKEG6GI8OObLifzDLmvTsHyQvfYTkXfwIM37vBDMAjjeC6+rgcJ7fA3ew95lSJyvfTIbXlbDK7W1mmmZv77swtZ3fscL/gjcDkljXrKxu6ObNhgA0zQhT9eRw2I47Kk3+lzYvF4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778827689; c=relaxed/simple;
	bh=dmpEW/UwSPa34BgWfh9ZKZucjW4J/htpHe7WemhHnR0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=abk4/RXsmIoAL/vdPvIOVlBZHNroDTMXtW4kpiX3gEhOgPFHyplfWI3PHEefOmKH5IOeYWj4bsP83gd9a8iT4gMEQf5IRQ03PoA/ugM9AahGZjZdQTsGgPygwh96QWAEr3cV/7teQn0BBgyBsTfieYnfvhkINv+CDpoMwTrStjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ei+Vs6Ic; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ei+Vs6Ic"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778827687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HH6/RJeSawU/SRCBWk+T5RMIlAZ2X3lFypP3SdEmxro=;
	b=ei+Vs6Ic32mEOv+nswsUkosS/RunuXcumgwhgI2wNjwNMIv6MWw0Q5zxxtzbi9H1i/PulS
	9NpKuyU+2SxNwFdFh4nqu0d/45fRLRM9LgvDqTLmcqeKvky4ErHuRya8NVnso0ivXpB/tY
	6dRyCudrLk6RmxYaAHz4dk5QW+28hKs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-223-zhh2F2WAPKWfzyLe3FNMUQ-1; Fri,
 15 May 2026 02:48:03 -0400
X-MC-Unique: zhh2F2WAPKWfzyLe3FNMUQ-1
X-Mimecast-MFC-AGG-ID: zhh2F2WAPKWfzyLe3FNMUQ_1778827681
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 75465195608B;
	Fri, 15 May 2026 06:48:01 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.81.221])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1B44F1956053;
	Fri, 15 May 2026 06:47:57 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org,  Eelco Chaudron <echaudro@redhat.com>,  "David
 S. Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,
  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
  Simon Horman <horms@kernel.org>,  dev@openvswitch.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] openvswitch: vport: fix race between linking and
 the device notifier
In-Reply-To: <20260514184702.2461435-1-i.maximets@ovn.org> (Ilya Maximets's
	message of "Thu, 14 May 2026 20:46:31 +0200")
References: <20260514184702.2461435-1-i.maximets@ovn.org>
Date: Fri, 15 May 2026 02:47:54 -0400
Message-ID: <f7t8q9lp3s5.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Ilya Maximets <i.maximets@ovn.org> writes:

> Sashiko reports that it is technically possible that we got the device
> reference, but by the time we're linking it to the OVS datapath, it
> may be already in the process of being deleted.  In this case if the
> notifier wins the race for RTNL, it will see that the device is not
> yet in the OVS datapath (ovs_netdev_get_vport() will fail in the
> dp_device_event()) and will do nothing.  Then the ovs_netdev_link()
> will take the RTNL and link the unregistering device to OVS datapath.
>
> Eventually, netdev_wait_allrefs_any() will re-broadcast the event and
> the device will be properly detached, but it will take at least a
> second before that happens, so it's not something we should rely on.
>
> Let's avoid linking the non-registered device in the first place.
>
> Note: As per documentation, RTNL doesn't protect the reg_state, but
> it actually does for all the state transitions we care about here,
> so it should not be necessary to use READ_ONCE or taking the instance
> lock.  We can still do that, but we have a few more places even in
> this file where the reg_state is accessed without those while under
> RTNL, and many more places like this across the kernel code, so it
> might make more sense to change all of them in a more centralized
> fashion in the future, if necessary.
>
> Fixes: ccb1352e76cf ("net: Add Open vSwitch kernel components.")
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
> ---

Reviewed-by: Aaron Conole <aconole@redhat.com>

