Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3978A3A2E33
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 07:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787558311; cv=none; b=UEy1X259tYHOfsBuBqE2B9IK4MxERji6YVhhFL4STA42TdSg+5uf4AinXR/wgAmfl6QHCWHp4Vqwlnh3EIBR0UhYMIjvHPlzzjrqfltv4m2QgJbxdMqfmiuE/7Lhtqpc3CN6uEklBnQHmElA0ZBohGMEaYsxCUjpwb433q809mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787558311; c=relaxed/simple;
	bh=LtLAUSBAmo1id4ssvN6V4cwVmsbwJhID8+Oss6jKwlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hL7fzQHuJtW9tFbXjx8kZdR342OpE/eeqDIkGceDtdP3bFAHbk5WHoLCOy73UbI97dxxNqFtHKEseLKILEMdnpZfVty9eWsL+5YqIltneltNS97rDSqFagRkJRvcvw7WC1yyczvdwe8cQHS7tfQ3A/M4WhE+afs7tpuKQJR9mn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vo0+VWsR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vo0+VWsR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787558304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xMOx8wTE/aOOWbroGizvM616+4zkrfzOR4clqDhgv+Y=;
	b=Vo0+VWsRNYFhkyXz1fHVy5aua9cVU9sGKwk8mVxDGCa0DkqAEy6PnTFrNFHPBskt24KaDK
	9RaL22UZOm88vF48rqhy561WJ3SKLKMC0RSB32BrIV/ATZwYwhvgErqW47wSEGISaDRukQ
	VroyX5BO7C9bECDmGuT21YB3Lc3yUZo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-186-7BjKulc0NamgRxXNZ0zPJA-1; Mon,
 24 Aug 2026 03:58:18 -0400
X-MC-Unique: 7BjKulc0NamgRxXNZ0zPJA-1
X-Mimecast-MFC-AGG-ID: 7BjKulc0NamgRxXNZ0zPJA_1787558297
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 408C2182A12A;
	Mon, 24 Aug 2026 07:58:17 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B40411955DAA;
	Mon, 24 Aug 2026 07:58:14 +0000 (UTC)
Date: Mon, 24 Aug 2026 09:58:12 +0200
From: Miroslav Lichvar <mlichvar@redhat.com>
To: JR Lanteigne <root@dnim.dev>
Cc: Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net] net: fall back to skb_iif for the timestamping
 pktinfo if_index
Message-ID: <aov5lCT4P_3tmRqR@localhost>
References: <178746246095.3786864.2262454553798466512@dnim.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178746246095.3786864.2262454553798466512@dnim.dev>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Sun, Aug 23, 2026 at 02:21:00AM -0300, JR Lanteigne wrote:
> put_ts_pktinfo() resolves the interface index of a received packet
> from its napi id. The lookup fails on drivers whose napi instances
> are not attached to the delivering net_device (e.g. ti cpsw, which
> keeps them on an internal dummy device) and on kernels built without
> CONFIG_NET_RX_BUSY_POLL, where skb_napi_id() is always 0. In those
> cases SCM_TIMESTAMPING_PKTINFO carries if_index 0 and applications
> cannot tell which interface produced the hardware timestamp. chronyd,
> for example, then ignores valid hardware timestamps.

That's the intended behavior, from timestamping.rst:
  A valid (non-zero) interface index will be returned only if
  CONFIG_NET_RX_BUSY_POLL is enabled and the driver is using NAPI. 
 
> Fall back to skb->skb_iif, which is set for every received packet.
> On aggregated interfaces this reports the aggregating device instead
> of the physical one, but only in cases where the napi lookup already
> failed and nothing was reported at all.

That would cause applications to receive a wrong index in some cases,
right? If it's possible, it should report the index of the physical
interface, but it should not be guessing.

> A userspace fallback for existing kernels was proposed to chrony
> separately.

That makes sense to me. It's a bug that it doesn't check for
zero value.

-- 
Miroslav Lichvar

