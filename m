Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33E73F44D0
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 08:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785226924; cv=none; b=GPWvk/mySE92fyuy6q8+YUfpXpat/rzpxCN4DmFk4Ozwr9t6ccyxeDIcNsLZuzAQ1ujrZGnjPK0Uo7AfFJVsig70N8fU8jXEi5vcXZbLBkGw+32C0zJcdN1wgQRL5E2ZlVdyB1TLS32rxhcoLF4m135Fw4wtVs8k3cnWkvVcNOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785226924; c=relaxed/simple;
	bh=743zbxPSWY9LXSLECHD52e5NJjTvQZ1kd9uEZiehS3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R3adYFHFffmzf6jNRScXxAUxjVwpFmnOJrqiaixbSysSQGKTSLgv9PVlfEztUzn0yJlw3Np5dvpDxsxSkmbqPvOXgHozeyxb9RZfRAB14g1YAxSx+6wp8ESw4HQXjA1lV5gsx8lKZfUv0uRHLYdXj4QH37U6P4Tkb8tH/TsrG/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dpWMnOcN; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LsrU8N9g; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dpWMnOcN";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LsrU8N9g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785226922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7L3Oa6yWKDj9Irs9koCNMMfNBAhfRI7uo2QmecVaVL8=;
	b=dpWMnOcNkTK9k0NLHWMLR5n+7Zi0DcFDTzLDUkrB7oI32TZzI4wjF9DZHZfdOasiXNppzd
	sKIa6FwUXfMffOTXAjMU8VqpDLgaJZBOzfmofGRWb7yUmgXERwCQz4H0YtGVxnxGmTyqmC
	+9btkJlH+RCmgzVQrpRd3h3LdB0i5F0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-m-_j8NubPSq0mtXjhUJcng-1; Tue, 28 Jul 2026 04:22:00 -0400
X-MC-Unique: m-_j8NubPSq0mtXjhUJcng-1
X-Mimecast-MFC-AGG-ID: m-_j8NubPSq0mtXjhUJcng_1785226919
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47f2de3ba47so2052474f8f.1
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 01:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785226919; x=1785831719; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7L3Oa6yWKDj9Irs9koCNMMfNBAhfRI7uo2QmecVaVL8=;
        b=LsrU8N9gqCZk+zHIOtFGKoH6NNNeOr1AQ8EvayQm6s6A6nwdTkmdQsLzSwOsWIAhmS
         uJoxLG+0WqVFFngZ3Kc17A7RYX/XVpWzf+iDNxjW/PQfJPRTQoLbcawcBkEdq8eucIY/
         5afp5KSwTdr/ee3AAHkPKYr3YH6L2yF2gwtk81EnL8h4piB3viJL0j8tZaaQ8LnykND8
         cBwIKVGeMk3f4DmNPMDllDZ7sjqzXXgY9N48XzlEHQ8EN39ndB3iLhViPu4/uBmmMyWv
         yCk+ZHN3NAwd3HlVGGM0JkoJ5pM3LB7PlkeuTK+6XNE5vuSyTxZ2Dxon2MoCb4/quR6M
         68wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785226919; x=1785831719;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7L3Oa6yWKDj9Irs9koCNMMfNBAhfRI7uo2QmecVaVL8=;
        b=sF9fscP3L/rnx4Zfch0dWKqKZ9RSkgU+udzVe6031TDITizZ4qXHXjwAD1tpItDpEL
         KGDEp6LpO07Estd55dS+GpCrK4mLHRVHSi7SMcqYfTFhkQ8dJpJ6fmwj8Wnt1BbTvalX
         WKvs5I00aAXS7/h3VTbuQGDpYNi0bgA8A3qdFcHx6wvSr6Cx2PvMWazcQaWvT0CEsG7s
         h/0fHhMp1I3M2hqhpzUhEZc4ynUNBNnDl4Ta4RVuLzvmPJY2+3W4TpnM9ezzNHpT7+jh
         oe64KgnL9ShCHR872Crqn9ySXiK+Qul+U4Eamd7hFyVUrlwisY3sk3aCXrR3ysr95ywn
         1aDw==
X-Forwarded-Encrypted: i=1; AHgh+Rq9ShDS+zoQvlFNxvyqlpnZBgZIErEN+D9rFKO0/bDqDMMUzfMqqSLbCaY3AsTgSg63B5PRr7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBklmrfw8+SPVN2Snf/AGFw7c149PuUGL0mfF1ygJNxTTcvVkV
	1obLbgUL2Mp80NFQBKBo94uTMkEumT97mbCqEzDsXcxRHfFVUOO+U4ndwBcqr0n4+2sqIJAwNNN
	1LdaXP/lIOXDSJYfkw2vCuJa2q2I2zA16XfdXtUeCi6euPrix1ngqiusicQ==
X-Gm-Gg: AR+sD10K0iis6HPsttJiEw8ILZC1Hu8Umyp9F8IgL5t/8i0j3ciDZ4BykH/mL5SXR+M
	SOtky8145RdTIb8VJ4ij91ZqqHjjxFtH7c9X+vBqjmUo6nl0qTpkMUmSr+//6nxMxHiwSPZRMOx
	PJhmq5RKu4KSDeiG3oslKBi7CFjSnV6zeKygRYtSWBDNpvZTf6pXYHs3PO0UMBza7V137prFR+K
	seRdoVKj3oDoumBj0zgUFQKv+a/NRtVunTxHjuugvE/D+JUOnaz/XvSN6T931vuBKH10RBsQbnY
	0ArNWL4LNdlMo0+R+HCRe0S2KLb9eooMjcuulU9jTksUOg4bM/Sj/gyykEul8RovdVIKRn4FyyY
	hXSu8xXCnAhTYIIKhxanMZO+2VG+ejnT30cmgVNuq6Dg=
X-Received: by 2002:a05:6000:1889:b0:475:f0d1:eb56 with SMTP id ffacd0b85a97d-47fb1eabd10mr1428735f8f.49.1785226919024;
        Tue, 28 Jul 2026 01:21:59 -0700 (PDT)
X-Received: by 2002:a05:6000:1889:b0:475:f0d1:eb56 with SMTP id ffacd0b85a97d-47fb1eabd10mr1428707f8f.49.1785226918560;
        Tue, 28 Jul 2026 01:21:58 -0700 (PDT)
Received: from sgarzare-redhat (ip139-137-192-82.pool-bba.aruba.it. [82.192.137.139])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f939c1465sm41353599f8f.26.2026.07.28.01.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 01:21:57 -0700 (PDT)
Date: Tue, 28 Jul 2026 10:21:52 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Nguyen Dinh Phi [SG]" <phind.uet@gmail.com>
Cc: Michal Luczaj <mhal@rbox.co>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vsock: use sock_error() to consume sk_err after connect
 timeout
Message-ID: <amhmjLa9DjNFKgmb@sgarzare-redhat>
References: <20260719220103.684489-1-phind.uet@gmail.com>
 <al3UuvBhfxp82krV@sgarzare-redhat>
 <78225425-1ca7-45fb-85cb-9e04f489e68f@gmail.com>
 <amB15TdzPAEk9A9C@sgarzare-redhat>
 <b81bfea4-6b19-4cc8-95c0-dcd4ad42476e@gmail.com>
 <95cd0d4e-58c9-44ab-b94f-fcf57b88583b@rbox.co>
 <amHN9mOGj7oMak4-@sgarzare-redhat>
 <27412e44-ab4b-4dd3-9685-481875683860@gmail.com>
 <a6cb1b8f-d8cf-412a-a204-3a26e4db0bd0@rbox.co>
 <6b684c2f-1f98-43ea-84c9-9b6f162d5e9f@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <6b684c2f-1f98-43ea-84c9-9b6f162d5e9f@gmail.com>

On Fri, Jul 24, 2026 at 03:34:23PM +0800, Nguyen Dinh Phi [SG] wrote:
>On 24/7/26 05:43, Michal Luczaj wrote:
>>On 7/23/26 12:26, Nguyen Dinh Phi [SG] wrote:
>>>>>>>...
>>>>>>>Yeah, we need to handle that part better, I think it's a leftover when
>>>>>>>we generalized AF_VSOCK to support more transport than vmci.
>>>>>
>>>>>Speaking of leftovers, I have trouble understanding where does vsock set
>>>>>sk_err on listener sockets anyway. If it doesn't, why vsock_accept()
>>>>>checks for it?
>>>>
>>>>I can't also see where it can be set TBH. Should we remove it ?
>>>
>>>I couldn't find it for listener side too.
>>
>>Removing sk_err handling from vsock_accept() solves the problem, right?
>>
>>thanks,
>>Michal
>
>Yes, confirmed, removing sk_err checks from vsock_accept() does solve 
>the problem.

Okay, so maybe better on going on this direction. WDYT?

Stefano

