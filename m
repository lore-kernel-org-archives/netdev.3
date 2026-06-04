Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94363342C88
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 15:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780587387; cv=none; b=dMSFd4olB2Igb4g4sCo8OJFcvHco3psdgZ3WqY4IM/CVwC0Ikg4nAGBTHC3yLznTxfuHZ2cqnteqLoAsOG8Xv3+jzOnA2ASCedOQrIXDpgbggEbx9IUMhZBrhqhT7Wi0ewGVfQwKFE88lz4iHIpJ1xXW/htDb6ef5DFcqH8yX2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780587387; c=relaxed/simple;
	bh=qkVKFYCe5VPkcUo7OKFJOM8zmsofehNViaFbdXZx0uE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UJ6fGM+zdpVMsaxLg1xhbDcuPnGK7r2/AiWvB+P0/zHCniQHw2FG2jEjUOZPw1N340ircVoHUoBHIPKk4fER8mADLITApzCJGcAnXyXqT8aAF6aFknG/HWymJ6MshHVJQI7hiEnh0GVwPw1d200CsaLImO/SsHPa9DVlx3jwdNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=glPRWIeE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="glPRWIeE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780587385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lKEGFEOyGjd+radcR4C1q84cAHVu0//u+OiuLG8lrUA=;
	b=glPRWIeEopzMRynOsXtjFPtA60rjcG4AEcWp/UgehPp2V3VAI72TgbyGhCxRN17bWOYHhm
	5WtIH8ekyPVBe/Sq1ga9VVQo/XbhWWuuyTJB68RQGHXwvUfx/rhGiCpw59gfMFuGzoaU4d
	uHwrDZT4oGnZQ7y0WXCuMXQyRhvsG8M=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-pNO9Zv0wPZqe0TPXmkWp5A-1; Thu,
 04 Jun 2026 11:36:22 -0400
X-MC-Unique: pNO9Zv0wPZqe0TPXmkWp5A-1
X-Mimecast-MFC-AGG-ID: pNO9Zv0wPZqe0TPXmkWp5A_1780587379
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8B4B81956094;
	Thu,  4 Jun 2026 15:36:19 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.88.184])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4E0B230001A1;
	Thu,  4 Jun 2026 15:36:17 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Adrian Moreno via dev <ovs-dev@openvswitch.org>
Cc: netdev@vger.kernel.org,  Adrian Moreno <amorenoz@redhat.com>,  "open
 list:OPENVSWITCH" <dev@openvswitch.org>,  Paolo Abeni <pabeni@redhat.com>,
  Pravin B Shelar <pshelar@nicira.com>,  Ilya Maximets
 <i.maximets@ovn.org>,  open list <linux-kernel@vger.kernel.org>,  Eric
 Dumazet <edumazet@google.com>,  Simon Horman <horms@kernel.org>,  Jarno
 Rajahalme <jrajahalme@nicira.com>,  Jakub Kicinski <kuba@kernel.org>,
  "David S. Miller" <davem@davemloft.net>, Minxi Hou <houminxi@gmail.com>
Subject: Re: [ovs-dev] [PATCH net] net: openvswitch: fix possible kfree_skb
 of ERR_PTR
In-Reply-To: <20260604121946.942164-1-amorenoz@redhat.com> (Adrian Moreno via
	dev's message of "Thu, 4 Jun 2026 14:19:46 +0200")
References: <20260604121946.942164-1-amorenoz@redhat.com>
Date: Thu, 04 Jun 2026 11:36:16 -0400
Message-ID: <f7tzf1agvwv.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi Adrian,

Adrian Moreno via dev <ovs-dev@openvswitch.org> writes:

> After the patch in the "Fixes" tag, the allocation of the "reply" skb
> can happen either before or after locking the ovs_mutex.
>
> However, error cleanups still follow the classical reversed order,
> assuming "reply" is allocated before locking: it is freed after unlocking.
>
> If "reply" allocation happens after locking the mutex and it fails,
> "reply" is left with an ERR_PTR, and execution jumps to the correspondent
> cleanup stage which will try to free an invalid pointer.
>
> Fix this by setting the pointer to NULL after having saved its error
> value.
>
> Fixes: 893f139b9a6c ("openvswitch: Minimize ovs_flow_cmd_new|set
> critical sections.")
>
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> ---

Good catch - I guess this should only happen when modifying an existing
flow without putting any actions (and that would be only from an
implicit drop case since the actions list would be empty).  CC'ing
Minxi, since he's recently had interest in the selftests area and may be
able to help with writing a test case for the scenario.

Reviewed-by: Aaron Conole <aconole@redhat.com>

