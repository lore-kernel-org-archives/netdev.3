Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87B7399375
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 08:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786610610; cv=none; b=TO4JPsiZjT+LRsP+buHRJCF+Ur8Jn8RKcTQ47kmOhjnRbNdcTCTTmA07HUPwbX/zHsflkBMWzALDz2g5wVjpmMAa1e3RoOxecGRSES3s4KQBeBAs9eUjuDCguMgCx9Pe97HKxFybaDMXmGRaakgNebb+dIwKVuwL+Bs/wdQy6HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786610610; c=relaxed/simple;
	bh=7eh/tEEaVVT82VWXjTL8vLLDWxnKGlVuFG9YrOF+sW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uWJgCQdIak7yt4P+KUU4EsfkD7TtJF3njvGrRfqUf82MUDiAAPdndoirOKyO3TzU54kHb0i34c0uN3Dv05b/eT7r6SNhWv9+1Py2CJiCpRO0gzzdjPH9VO1CLyVOpIWXrikjcz2c+kLspi76KI7TvkYALE0CjbH0IguikhV9uf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S2JCR5C+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ik2qCxHc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S2JCR5C+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ik2qCxHc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786610603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w06Zz5eZ4ZoMZ6QYcdF6VhN9WY/dFLXdTr47WLmeFiU=;
	b=S2JCR5C+Bibtdb1Igyt77x6m6an1pIPccIGliwOzbcuCm6wHwQ7zJnmw1CeG3hifzmbiZB
	8dAsPWgTzbYSAj9OELkjmx4qSTeULP2zNIEM8cS5TkkiTycmW2hN5WgXun1tAw/7eeRHAl
	R00gXP0jC+ONpobNPhu3enyyOAjHCXA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-WUytBZqaMh2Y3ITIYU2n-Q-1; Thu, 13 Aug 2026 04:43:22 -0400
X-MC-Unique: WUytBZqaMh2Y3ITIYU2n-Q-1
X-Mimecast-MFC-AGG-ID: WUytBZqaMh2Y3ITIYU2n-Q_1786610601
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4954fd771baso3138925e9.0
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 01:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786610601; x=1787215401; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=w06Zz5eZ4ZoMZ6QYcdF6VhN9WY/dFLXdTr47WLmeFiU=;
        b=Ik2qCxHcfDQXW/ptSsJw9EdL07B7t9DTVSJl+ervMaNTFogPPLvaEji1diWYFd33/b
         LgJeRMeD7kUlWa0lsuQfD0J2VnEl4jjvY43+bt0aPWhSmlHcO8rhr8r1EoNyn9Wa5WjI
         7LNwUU2i6/oQ1TO9LPAoGXd2SLxHqhuE0ERcPjFTC7OPNfHh46YCon+sn1EfpSUzHMOE
         YLl8jTlctq0giCporKOfR3NTOGF2ANzvvcOtWYPHB7YhYa8l8rybeN/RZaVqdTWcD/b5
         LJ4D7IeoJHtEIvzYWgaCnsfbmbh818M5GdHNFzg33UzSI6WKtv7NNW22wIOGnf1C9lch
         JwpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786610601; x=1787215401;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w06Zz5eZ4ZoMZ6QYcdF6VhN9WY/dFLXdTr47WLmeFiU=;
        b=U4jUEb1K4osHdhDb/3b/3MNF7MiYvd1YpNrMLSPtPdI9xQPU0BHb2SV927/R2ynnHJ
         SE6z61HBGwsiorq+DD2NNIy8fnD2tS6ieoGqeG1fYxscj4p9jUwzxASawNX/Cne+aAxn
         twjX21JNAhjIKNlfWjgy9sOxDEiGSeSlHITVQyII6xTqAWPHDppadZt4gHkhG3er1YzR
         R6V1z0tCKsA9gPmP/CiJpMRekWP6xBdSQ6x8PcLattdXqfhEcOC1ogynQ5bE4imOgTK1
         0TAF5IqmYLD0HLkisIL71mb5r2Ypb338MGJpGWJ96aWUKyPVROUnM2uNzykRRcKLMivB
         qeNQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr0M50VNyG1NsRbtRBT8UUdjtb8PY+eascH4ISm/llViyw9ywLUwB+EkqNTAQy6u+2Z227kTRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVytbG4mn5qZbCcfNfKqgiAWQhoAmhezfej+a6MHiEYEnj4RlU
	LMKpRR1HqH3ePO/YVjT9kOE6g8vp++3ZyYRf/+6T4P3tlXnjBbxS3ihgQFj7yRY2GwFTdIwfrBg
	KOYEhpMc657IWVlBsSOMxwaZom8yBgS4OTF3LYrboCTl6hALvfiA5jdznEQ==
X-Gm-Gg: AR+sD11Bw9MnOv0jD9VGuFOD2IK+xl+Nxl1cEFv+OuYRYRcslqKQvn6xJR8N97yoBKF
	C2vuhyDpRr7UruPSzf+3Ep6Kks/Bh8LWVHPuCfrhPYr3HLJLYApSQrhxZtxnTrz9KK21A0GF0So
	L/JdacakLaVZQXF1FkHEsZMObO7GnCGTeQUf7js/vcxLvYJ5izEU88lAwG4Mw+IRWmpzPkJ4cNW
	lA3l+zVOirO8HC6hIX0J+kYMGYIflunOCQ9UOpJhZbm3Ay/UQqZpDZ3W4HZzcwv7cpdC3ZqEQg+
	TE222rF0Yzj2UbYttquGApUZ7CJ7/RpmzFPLMEex4kJRj5h29Naqh5axrz01Fg2QoWBERsWp2jd
	zC8D82EEu/fbbxPk8a4awDo1f6oskUtnHGuLPXOtbC/eKLbN4JGfN
X-Received: by 2002:a05:600c:4708:b0:499:596b:2e91 with SMTP id 5b1f17b1804b1-49982200a77mr35404275e9.3.1786610601124;
        Thu, 13 Aug 2026 01:43:21 -0700 (PDT)
X-Received: by 2002:a05:600c:4708:b0:499:596b:2e91 with SMTP id 5b1f17b1804b1-49982200a77mr35403785e9.3.1786610600655;
        Thu, 13 Aug 2026 01:43:20 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-154.retail.telecomitalia.it. [82.53.135.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49981b0f6b1sm48409915e9.4.2026.08.13.01.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 01:43:20 -0700 (PDT)
Date: Thu, 13 Aug 2026 10:43:05 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Nguyen Dinh Phi <phind.uet@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Dmitry Torokhov <dtor@vmware.com>, Andy King <acking@vmware.com>, 
	George Zhang <georgezhang@vmware.com>, Wupeng Ma <mawupeng1@huawei.com>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] vsock: use sock_error() to consume sk_err after a
 failed connect
Message-ID: <an17EsASX_Nn8wxi@sgarzare-redhat>
References: <20260810170935.2242314-1-phind.uet@gmail.com>
 <20260810170935.2242314-4-phind.uet@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260810170935.2242314-4-phind.uet@gmail.com>

On Tue, Aug 11, 2026 at 01:09:32AM +0800, Nguyen Dinh Phi wrote:
>vsock_connect() returns sk_err to userspace but does not clear it:
>  if (sk->sk_err) {
>            err = -sk->sk_err;
>
>For a blocking connect() the error has already been delivered as
>connect()'s return value, so leaving it set causes subsequent operations
>like poll()/epoll() to keep reporting POLLERR even though the connect
>failure was already delivered.
>
>The error should be consumed once it has been returned to userspace.
>Switch to sock_error(), which reads and clears sk_err atomically,
>matching the behavior of other protocol implementations such as
>__inet_stream_connect().
>
>Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
>Tested-by: Wupeng Ma <mawupeng1@huawei.com>
>Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
>---
> net/vmw_vsock/af_vsock.c | 6 ++----
> 1 file changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

