Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B12246EC88
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 10:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790245044; cv=none; b=b2GqfCTRZbaKgKioWdtICyhZugQB2oRrydIL4bi0YA3aL46OQ2EbJINcPXADP1n6t/YPYK/GfAVp58q0O8dw1pdzdLnyiJNdPTY0bZj6SS5FrN8vt9mCyVi91f8t+Biv2ZeXPvbgbqcFRVHaJ32j2wJPI4Et0IfOUs+qMftGkxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790245044; c=relaxed/simple;
	bh=OLQtN8/9/Nf4flz3Kt2BUy4OlOf9PndZym7N2lg6lbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KlO0WPGas9kdMDbRSrGmqPPn/IdEKjDAAnTTWXP8U2qQUOOViz3QwE7W2IXCA/AGoxCP8uSYDSTruP+3GcrNcbZyGzRZHb8TafKTvzjiQ8LSwPu8w1cGzuFOiimZKjIIr/bruiKhRf+RCJ24XI3x1iDN+umVMitWr14Mqli2xis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J6qG73mj; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SLC4QTgF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J6qG73mj";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SLC4QTgF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790245035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H6EUUW1m1zoaB7DVxqcfClkBe+yQHGLp6gBbcFMHwFk=;
	b=J6qG73mj372AxtaJwfCfQ4AKU/wuW9462hUK78fQHbn7Kw9kr66Elu9mUM7eShfglO3u5g
	49BGehw8+BBWHe1IopZ6mOpSHNomkWjPzjICFPM3tN6v1MloAWkCNvlvvYUHXryp60FnWd
	2rSqx9XZObVM6dGPaQNVNkJHRmHpTa0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-lFFnXt8pM-G4xLn7BS6_ng-1; Thu, 24 Sep 2026 06:17:12 -0400
X-MC-Unique: lFFnXt8pM-G4xLn7BS6_ng-1
X-Mimecast-MFC-AGG-ID: lFFnXt8pM-G4xLn7BS6_ng_1790245032
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48701401090so1634614f8f.3
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 03:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790245031; x=1790849831; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=H6EUUW1m1zoaB7DVxqcfClkBe+yQHGLp6gBbcFMHwFk=;
        b=SLC4QTgFAAmhmFB0lfmX2GhPXUY3bABWcBSfVj+xcAe18+GN19WX5pbtqMUPDVKuOd
         b5EOf+bxKaW+wnvqX0YMlANb0wCPN4K7JS+1xJks1Kc2rbctUkYGOpT6sdevnenxfMJe
         DnhkShpfo94T4Ie/gNC1s9yBQUlOBuqDe4r3zuvvDplxCz4nqa4iQMX+dgCnkWoNXRTQ
         njDHVkAgJOpFzZ29AMlOvMFAOVdzqLavI59ltEFrDcV14ryLvSU93A6mvcYUiv4VXOXb
         hLYxdUFD1R4p1CxxhHWRbTIdTv1fjL22IglA5Wo0GXSAWUSbVqhikZaqk7IOGUiB5iW7
         A4SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790245031; x=1790849831;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H6EUUW1m1zoaB7DVxqcfClkBe+yQHGLp6gBbcFMHwFk=;
        b=jC9W5mYKh/hmmCOM7TPx5X29/AE3ObGnEXHM55CTdlqPKmlkAAb7N4Ri4mKlCEYYLZ
         ErXL2QkKFxXMy7/i6SfgJrsUiurLwU3eGmp6kSKHqQTVHh+0MkfQhj51gWmifyg1iTG9
         6irJoIu5CZG5xyhC+wlOQr1wopSfPHnM5fpXgwCrcrVeN+1NFPNCKOPm9f1CvKOyjYtu
         CTmncWK/AGcxYmoDSb7carXM94yV6xEWJgHAS/e3Fm7LbUE27cIIxqyB+gYdWZiUTMND
         BKD+QMjZigZQ0DFVOVm5PSmMfxOwwtPT7CZkTSTn5hfABavm7I9ed/H/bK8t8Nq3gAT8
         CRNA==
X-Forwarded-Encrypted: i=1; AKwUvBzb4b/qXHRJd9x81djF9Q1k3duSAbmCyAhfXWtzn1caWKuPTBWampG5Zz+guZmwVuIkMIPK++o=@vger.kernel.org
X-Gm-Message-State: AFuF++ls75Jf2dSx9SnERr9+XHO5iJt//pBjIZZuLTlAF/PUaAKMzJw/
	qQqx0dC9Plt17MtvIDgD8l8jhi1XQjDMiWgNqbDSWDlNO/Unh8wJKagJO41SuDoF2W8UnqWpPmf
	AUWfnvnTzhkLlQuFU3lDQv3Sgp3vbKdVy0mwFE4OY/RHrWI/s4EHO0FbmqA==
X-Gm-Gg: AYBFou08u43a1DWxLSrjXRHv0xbS6ouzuHivG2Gwb4pFjYvFgAQjaDIHe+VnDJ67n2O
	Z0gN6uSoVRsp5Y13hoGh6Gy7kgUKkFuHDBHtmZcxz2eqTDBq2DStI1SCZbRnEhoYjeTPezq1npw
	Kylh7W8Bh/aBj6ag6tEwDgMTlpSJEUs3PEjsfkpdsi+gSF8ETb+W1Iq35JwmngwxPp59MBzumkL
	SQLO2Je2KiOVDNSEYNz+DVTWUDyTDx7/SL5x8fjLGVr7eUOaFtJ8JqK5Mo+FYuMRgo+j+xEpfcn
	VagrQuoTEbR33cqkAS2sFhPxAeHqWTTeZy+DWGdihrcdO4fyDkbrdV1RIU1bn6n0H9XZlW7rs25
	gVfQG0/+PifOoXQlYjBGUxQt7Wg5kSmkRJ8GgHC4bmIpA+msorOU=
X-Received: by 2002:a5d:5e93:0:b0:487:27f9:82a with SMTP id ffacd0b85a97d-488716f74b7mr3255256f8f.31.1790245031491;
        Thu, 24 Sep 2026 03:17:11 -0700 (PDT)
X-Received: by 2002:a5d:5e93:0:b0:487:27f9:82a with SMTP id ffacd0b85a97d-488716f74b7mr3255203f8f.31.1790245030920;
        Thu, 24 Sep 2026 03:17:10 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-131.retail.telecomitalia.it. [82.53.134.131])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-488684863d9sm13714443f8f.12.2026.09.24.03.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 03:17:10 -0700 (PDT)
Date: Thu, 24 Sep 2026 12:17:04 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Asias He <asias@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 3/5] vsock: Enforce no-transport invariant for
 TCP_LISTEN sockets
Message-ID: <arT3jXoS7OaU6Tsc@sgarzare-redhat>
References: <20260915-vsock-connect-reset-closing-v2-0-a1d9abb472f7@rbox.co>
 <20260915-vsock-connect-reset-closing-v2-3-a1d9abb472f7@rbox.co>
 <aqp7CV9DnfsG1GJc@sgarzare-redhat>
 <0bc40e5c-8790-4a36-84bc-80e0bfe6b504@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <0bc40e5c-8790-4a36-84bc-80e0bfe6b504@rbox.co>

On Tue, Sep 22, 2026 at 03:18:13PM +0200, Michal Luczaj wrote:
>On 9/16/26 14:30, Stefano Garzarella wrote:
>> On Tue, Sep 15, 2026 at 03:15:14PM +0200, Michal Luczaj wrote:
>>> A non-blocking connect() running in parallel with a blocking connect(),
>>> combined with a racy listen() that hits right after a connect timeout:
>>> TCP_SYN_SENT -> TCP_CLOSE -> TCP_LISTEN, while the connect() loop is still
>>> in progress.
>>>
>>> Enforce the invariant. Prevent a socket from becoming a listener after
>>> acquiring a transport.
>>
>> We should improve this comment; it's not entirely clear to me, TBH.
>
>The race I was thinking about:
>
>sk is CLOSE UNCONNECTED
>non-blocking connect():
>  sk := SYN_SENT CONNECTING
>  enqueue vsock_connect_timeout()
>                                   blocking connect():
>                                     release_sock()
>                                     schedule_timeout()
>vsock_connect_timeout():
>  sk := CLOSE UNCONNECTED
>listen():
>  sk := LISTEN UNCONNECTED
>                                     lock_sock()
>                                     sk is TCP_LISTEN UNCONNECTED
>
>It's not really critical (blocking connect() just timeouts), but I thought
>the invariant should be enforced once and for all.

I see, would it better to do this change in net-next?

>
>>> @@ -1973,13 +1973,13 @@ static int vsock_listen(struct socket *sock, int backlog)
>>> 		goto out;
>>> 	}
>>>
>>> -	if (sock->state != SS_UNCONNECTED) {
>>> +	vsk = vsock_sk(sk);
>>> +
>>> +	if (sock->state != SS_UNCONNECTED || vsk->transport) {
>>
>> Are we changing the behavior when an error occurs?
>>
>> If we call `connect()` on a socket (with no others running in parallel),
>> it fails, and then when we call `listen()`, it now fails, whereas before
>> it didn't. Can this happen? Is that what we want?
>
>Ah, true, I didn't consider that. So yeah, we'd changing the behaviour.
>
>> If so, we should mention it at least in the commit description; if not,
>> perhaps we should unassign the transport in the `connect` call.
>
>Do you mean immediately un-assign on every transition from SYN_SENT to
>CLOSE (failure, timeout, signal)? Then we could also drop the re-assign
>logic. I think that's a nice idea.

yeah, that!

>
>---
>
>I've addressed all your other comments for v2 and went through Ashiko's
>reports (side effects of lockless peer_shutdown write, imperfect
>no-transport TCP_LISTENER enforcement). I've decided to try the
>eager-unassign approach. I think/hope this way we sidestep the lockless
>writes and enforce the invariant without breaking the API, while fixing the
>bugs.
>
>This should probably be RFC, but I'm posting as v3[1] so netdev's LLM can
>have a go (too). Hope I'm not breaking any workflow. Let me know what you
>think.

I think you can add RFC also on a v3 patch, just to make it clear you 
are not sure it's ready to be merged.

That said, thanks for that :-) I'll take a look today or next week 
because I'm off tomorrow.

I'm just worried it's becoming too big for net. Anyway, I'll comment 
there.

Thanks,
Stefano

