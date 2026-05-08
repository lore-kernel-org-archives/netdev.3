Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A34280A5A
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 12:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778244647; cv=none; b=r23t7Fn9TiTh/DFQkfQy0UO8rC/Eg1ixDoE1CDee5jVJ9nCx9Dd58i/DxTHWcpOrVHuJW7p/PifPQ4xh8XV9Eq/go0FM2cLDsEwq3eVi5xVB0OjS9fBNT5o/F8EbuDd4wTxe5K5pZuLdDIIMe29TmszLvgd1U95xNXkzUv0O2w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778244647; c=relaxed/simple;
	bh=HHMEf8DWNIJ2igzl7oSuvE+lxVSKVIP8abm7DBvgqEs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OUwkKVhyRLb3uZ9+pkMQT7taddEKnrxh5LydIdqHIYwRQk5iWWzA8EcxElNoRkIfF9Wprv41ygQpGPXEIa9KV3CZkGeMxkYn/0k16I69gltDj91dGhca++d6mKhqNd5dXISpsdFBWE58kQ2LXTSv5+UoGP+kJu09tsg/gSVVeNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VLkhtd8W; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VLkhtd8W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778244644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5nscIJDj62jaV3hdNmP/ANYN3y+AdM2VSE+HH2VLj/M=;
	b=VLkhtd8WlhHGANLXGzxjjNHTzefZpcVZMV02yQZCsKIDczfFUyPYUGxJHCttj610yXFEbc
	R/u9M76PQqHAwaxWqpOY1AiIHOIT/ixw+r+mZ0/24HAzSE2JCXP5tB9+TiNaqfRh/fMDDg
	p62/2lH7fFGhIISn8F5o04qFwZE/mIY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-300-SPHISxg7N0aP7ecQl9bfow-1; Fri,
 08 May 2026 08:50:41 -0400
X-MC-Unique: SPHISxg7N0aP7ecQl9bfow-1
X-Mimecast-MFC-AGG-ID: SPHISxg7N0aP7ecQl9bfow_1778244639
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 84B681800283;
	Fri,  8 May 2026 12:50:39 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.65.142])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D1AF7300019F;
	Fri,  8 May 2026 12:50:36 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org,  Eelco Chaudron <echaudro@redhat.com>,  "David
 S. Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,
  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
  Simon Horman <horms@kernel.org>,  Jiri Benc <jbenc@redhat.com>,  Yi Yang
 <yi.y.yang@intel.com>,  dev@openvswitch.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: nsh: fix incorrect header length macros
In-Reply-To: <20260507120434.2962505-1-i.maximets@ovn.org> (Ilya Maximets's
	message of "Thu, 7 May 2026 14:04:26 +0200")
References: <20260507120434.2962505-1-i.maximets@ovn.org>
Date: Fri, 08 May 2026 08:50:35 -0400
Message-ID: <f7ta4uarrok.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Ilya Maximets <i.maximets@ovn.org> writes:

> NSH header length is a 6-bit field that encodes the total length of
> the header in 4-byte words.  So the maximum length is 0b111111 * 4,
> which is 252 and not 256.  The maximum context length is the same
> number minus the length of the base header (8), so 244.
>
> These macros are used to validate push_nsh() action in openvswitch.
> Miscalculation here doesn't cause any real issues.  In the worst case
> the oversized context is truncated while building the header, so we'll
> construct and send a broken packet, which is not a big problem, as any
> receiver should validate the fields.  No invalid memory accesses will
> happen during the header push.  But we should fix the macros to reject
> the incorrect actions in the first place.
>
> Using previously defined values and calculating the length instead
> of defining numbers directly, so it's easier to understand where they
> come from and harder to make a mistake.
>
> Fixes: 1f0b7744c505 ("net: add NSH header structures and helpers")
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
> ---

Thanks Ilya!

Reviewed-by: Aaron Conole <aconole@redhat.com>

