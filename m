Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272CB40F720
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 10:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790244410; cv=none; b=hjZpQiAQKHB+s3LMjq+/YFgQntc6KlC8Zu0F8W/7R1N9OyJrigo/jLeosPJRx2Lds0U7F4R9EMXB2j781TIL5sWPf4Rn3Ty3IpqURWvDc0R6qDfCXBLLm73mdtCAHX3QnIbyYUoBITQP+eFbVeUbongVpYhw/3jGM5khC8Mde3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790244410; c=relaxed/simple;
	bh=GFNtRpwPhMu+eKoRMyqSl+twdGE03Nm5JynpYuuyiKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rEusWPadYDfPDpl+71pOJWCSfbSMrT4MOxLQDLkmaM7FNUHLtUrKqvWXPYsO8wcKs459Dd2A9qccT3k4kyxCdPrONYy2dR8yjDhTl/f2DXxXwG2WeIvWfxQF0ef210pSWGqJq6EKCB3fVEvwiEnEB11gRK5M/vSudpgFJZqu960=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AKCPZLio; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YKkmMapT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AKCPZLio";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YKkmMapT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790244396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z1Visdhzs5DmNU4T37TUFkaK4VZvm9Ag2DOzaMeHKOM=;
	b=AKCPZLio0VAbKFGn/PtoUcJMvn5SUSmZYfJ+/msZmjzA6Lo+1qth1pUtCwk8l2z2tHzgIV
	CtSyWlpEqUkw/0mpeVSW1R1Wke90SUEHn2hVEgu2/dMENKp34CPUuE43Dxaq8zhdK2nFNl
	jLNvkCl4hFfCCoAHV0F6NSPPew4fEjU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-UesGkETUNG6-_8d9_hZSIw-1; Thu, 24 Sep 2026 06:06:35 -0400
X-MC-Unique: UesGkETUNG6-_8d9_hZSIw-1
X-Mimecast-MFC-AGG-ID: UesGkETUNG6-_8d9_hZSIw_1790244395
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49b0e6638e3so15026715e9.2
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 03:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790244394; x=1790849194; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Z1Visdhzs5DmNU4T37TUFkaK4VZvm9Ag2DOzaMeHKOM=;
        b=YKkmMapTB+dkt6KqQT8YZ4bBiNOnHyRvrI8xjmar5ZHoqdt7fvs+ur4ZOOtvkOGcQY
         uU3sHE9ev71+3oqUqeBsZlGzxnfd8o5QH3V2cAs1X5C1quXkRHlsq+XYich7Io1Aqwov
         f3XxQS+5Gh3h22QFJAgoq/PQWiakaNTRDJCQgz6+WkuzUztFmZFRN2tn7fT3X1Ge2160
         178dBL+/PDeyQMrKXsXF2XuJBDl0P0f+cpyAi/AjhMRw9lLDQt2qjDEJdb0xAJLGUUrw
         FkvFtuVKSTp/3pohRufOJd5vHVIdiRqZF5d1cikKXncb7/QyHO4a6hH/eKbJmr25sGWv
         +GNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790244394; x=1790849194;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z1Visdhzs5DmNU4T37TUFkaK4VZvm9Ag2DOzaMeHKOM=;
        b=SxoKdslgaPEoRXUMja5AF5iMcP8n5/SPlT5z6gF8TsoYb9ZIFOKvOYcqOt8tnngOGe
         llzmBlwthA64kyBdl7X5vhb/teZbnQqWTfejMntRoskrejbMr4mLDmMU60EcbuDLHDUN
         QCkyRgI/YGmUQeiHrSSxh4JmFSsQ4vuLZUpx2p5Wn8RmUFsFiY0ql2OyHNV4ZO4JKQnn
         8diRIM1nE9YSgoJ0HsIeX6/vefkcNEQhfXVi8WtqMVivIrJBENmXrMl4Lwvxn8l45tzm
         e7/uk8QLNYSSdafiKEPhMKX1u3moXRAAy41qX1PP7z+jxTE2xqLFWmLYdNw6oLX6qSPh
         1APw==
X-Forwarded-Encrypted: i=1; AKwUvBx1PkvAP8oWXm+oZFjQUBoSAUQH5YYNKm3oZy69UI0smaapkSKC1+uTmVGDjOGj2axtkwHY7gk=@vger.kernel.org
X-Gm-Message-State: AFuF++nSJairJv5ph8Wx+fULXqTcKfqNid8hfUVxVE1DxWDMrl39HA69
	af3GsMKNGKLAuv3Vnn8m4CvkAa08ZH3pT6q2TYkrSiA4xWrTMJFFCgXCQPdwy4ECJnRJgThsMJf
	nC0CW45hr9UZYDz5QAw0sBFlQrTF5Hk2MEJ/ajYXU/LjQS0shtzx+q+KBrA==
X-Gm-Gg: AYBFou0pBYWdhGrcriCB+ir92hItbSt8lXo8hQzbSkaA59PitLzsMuQkMj+Nkvd+Avn
	qC4MNdI3EwDlkpsldode9k5EK048323uUrRbzrggP/Xyw2zQ84Q2NuD2lKDxsR05mesLxggmOfY
	jl8LJVqfYyTo+cY6vYRlmdwwFzAwp55NbQJo97bxxY6Q+GKVmIUTdEz2A9AQzyMoJIFR14HDdP2
	3406TTJ9IWse6Q9gZPv1Oh9jwUd3EEkn/hdy/zNlBs+ywJZ6AVvihYGldoT1maohC8aVgxBwYnO
	l+wGQOQ7sOoZIwYMxtaOZWOy9/aC82RrYVELUcsVy7aiJnQ8AADQrvheuD0izJzqw73h4+2qnjm
	Yx7BqFDRUNUYTR/cYt+rpaS8FXGapT1h7FVfOd/xsxP+XbCVi94g=
X-Received: by 2002:a05:600c:4689:b0:49f:bc8a:b103 with SMTP id 5b1f17b1804b1-49fe66841f8mr32855255e9.0.1790244394457;
        Thu, 24 Sep 2026 03:06:34 -0700 (PDT)
X-Received: by 2002:a05:600c:4689:b0:49f:bc8a:b103 with SMTP id 5b1f17b1804b1-49fe66841f8mr32854435e9.0.1790244393834;
        Thu, 24 Sep 2026 03:06:33 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-131.retail.telecomitalia.it. [82.53.134.131])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48867b49661sm13003456f8f.0.2026.09.24.03.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 03:06:33 -0700 (PDT)
Date: Thu, 24 Sep 2026 12:06:27 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Asias He <asias@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 2/5] vsock/virtio: Streamline socket reset on
 transport/PM event
Message-ID: <arTwyyLVU3jM5fTA@sgarzare-redhat>
References: <20260915-vsock-connect-reset-closing-v2-0-a1d9abb472f7@rbox.co>
 <20260915-vsock-connect-reset-closing-v2-2-a1d9abb472f7@rbox.co>
 <aqp3Po7OcubJboM_@sgarzare-redhat>
 <3cbeb82a-60ff-4129-b630-5404df1f689e@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <3cbeb82a-60ff-4129-b630-5404df1f689e@rbox.co>

On Tue, Sep 22, 2026 at 03:17:30PM +0200, Michal Luczaj wrote:
>On 9/16/26 14:30, Stefano Garzarella wrote:
>> On Tue, Sep 15, 2026 at 03:15:13PM +0200, Michal Luczaj wrote:
>>> Follow vhost's vhost_vsock_reset_orphans() and VMCI's
>>> vmci_transport_handle_detach(): set SHUTDOWN_MASK, which will come handy
>>> later in the series.
>>
>> IMO it would be better to include the reason here as well. Every commit
>> should explain why doing a change.
>
>Sure, will do.
>
>>> static void virtio_vsock_reset_sock(struct sock *sk)
>>> {
>>> +	struct vsock_sock *vsk = vsock_sk(sk);
>>> +
>>> 	/* vmci_transport.c doesn't take sk_lock here either.  At least we're
>>> 	 * under vsock_table_lock so the sock cannot disappear while we're
>>> 	 * executing.
>>> 	 */
>>>
>>> +	vsk->peer_shutdown = SHUTDOWN_MASK;
>>
>> In all other places we use WRITE_ONCE/READ_ONCE on vsk->peer_shutdown,
>> should we do the same here?
>
>Right, we should. Isn't this also the case for sk_state and sk_err?

Are those read without the sk_lock?

Thanks,
Stefano

