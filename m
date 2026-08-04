Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944E43F3285
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 09:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785836274; cv=none; b=Qd5DlFJY7oOJTJYj12YNf6CMlGNVwdfJsSaitM5s0pwBdXzhMp2M+METtTO1KgqEs9wvJ1i/FSWHDynE0+LYeET728V3VFiaXifzXDRzRNM7RqXdBjdCN/dQpcwzo6IpFRrHcF0VlnBt/U6jPpEB+1PNidBnfPiby7JtQRHbqQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785836274; c=relaxed/simple;
	bh=YHCzNxOR8vzG0iWXONmBMTdnogbrhp36qxhg1+Egca0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JBwXh7+8S0W34UVk/9wZSnfgu2olJnjQ6t0V44PF8X8EOZ/CpBiIlG+I/BuwE9Zv+RcLx2/coyzFIXacAwhN/W+d1fy8rTBna0tOh+tiQARoxmqq808cpQS1xfQ+RtXwe16W1w16nDr8ZE8jH4UZRjCGyBtfQUIdVEZo0FOKvnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YvXaRT0E; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DHAij9fo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YvXaRT0E";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DHAij9fo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785836270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EM7xpqXAUJNazCozbweIvpU+TjAspQcIOmydlbjLiPo=;
	b=YvXaRT0ElD6vdd61DR715l7mnfjazG65mS9Du4Uk9emLWoOGzweb5wOLs3YYWwtQIlRiBF
	3LIdZ90sFZVCdrFLjdmMDKnEO8Ix5V5UGo/1tqmeynmg4UpAREYYGJ8WpcgMrRLmp3eQ82
	YAkiHhyK0SyFU9PxsOGcrUfAPk5vC1U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-zDBW_W9wPeGpsOHyTiGdkQ-1; Tue, 04 Aug 2026 05:37:48 -0400
X-MC-Unique: zDBW_W9wPeGpsOHyTiGdkQ-1
X-Mimecast-MFC-AGG-ID: zDBW_W9wPeGpsOHyTiGdkQ_1785836267
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49808ea1b64so10470725e9.1
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 02:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785836267; x=1786441067; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EM7xpqXAUJNazCozbweIvpU+TjAspQcIOmydlbjLiPo=;
        b=DHAij9foOmWtR7wbCNRrWWFGwdRE3O6SFA9FoguTPzoZ0obRnrmhYhdrQit3Sev549
         CytQD/xL2PhwGG5U5/QZ1N1LV92F6i316QPAqbEa5oTNX/LHJQArImryJiJLITykGA88
         oAGcFjOcmbgG51m3WwkdJbppcrkNJpwDCHEmUH60P0r/0SMbmS/suzEMs12qiTwy1bp6
         BOsDAP2hGEelvPqe9P//Z29Ef+YwdzkktSTRZrWh2ybnrHOD7L8ZHKqoWij2q0A1oico
         VoBfNvWj/goYuSpbbWXkQdZjFIIrDGQ1fMeY7fYw5Cz8fiPLAKRoG/MXMuJdXV5S+PUy
         myTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785836267; x=1786441067;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EM7xpqXAUJNazCozbweIvpU+TjAspQcIOmydlbjLiPo=;
        b=UVdflGR6No6KqAnDty5zE+SWhMpaealoYbTNICTmhcUone2A0HRfIG8tek2CfLN6k+
         WQbMSurwKI2MN4xb9UThhZbkEZmrT2QHjO5kW+qZS61lFBrRd3BJ4Wt/oCDWTPGC+YU3
         D29/tiQP/e6jQK2AZWPHfVuXXFAXtEdl2s4/qTI/+Jcny32LSwk207/0YmSFV6U1QO2M
         Kp5i7VNVRDYUsGRdqywkQEaDYrnfdHgGIiQijCREYbKvEA49sGstfjMAzmowqIuybj94
         eCqHAcNPbuDNwVzVbbjVN18H9DJ7HspviaEA2kTX1uzfx6TMOPb6x+V69sAAAdHi2PYs
         dauA==
X-Forwarded-Encrypted: i=1; AHgh+RoX33GUQB5rpjdffxKvesC8b/7ncxMj4eoVhuEvaXr9cSAhYDd59QXNtMFlpEP1j7eHgzt7TGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzABBdewSCjGSeElTDwqzFfSvdzmSAZbcnpOQ4ZcwzD55+jt83S
	I9p/NfNqxPdW0o0gtpY8PuZaUYOgz1Dwvrr+vkSpNMrtJJrk3cWVAYgoJfmmTUmZCmAbZbm+TfC
	EXMKfLaowVvNL2llVExni8iJwUqpu2vXE2EyZPE9dA4WJhYgZ3al7hqFMmg==
X-Gm-Gg: AR+sD11KBhzjZsfWogAIxkhSl/a86gs8MODc12sAKxIOe6Fw8qIKvB8vJ7dq4yosK0m
	jsKY5AtRCTInW976bHbsXsjDjZBfJLQf2uUhiraKHMzRVeAW9xfZ1rHGrsV175gxT2ekmD8oSGz
	zAgGneAWK1wqPbs9OHlL4JPvJjGCI6zF0DE5A1ovXgeDdmt4izd41oacuJlZvNcYMcMhs5KEcnD
	VbCDYtMCBoC+SUKpFmnLye1gWXbsEAZxQlrJWBbaecS7/qJsHLiYfJti6yKCgVvMP1JDOrthEX7
	6yOa/cwKKadHTM1BVhmc9CMtJNQa2RSOYJc87NGuOl/IrZOVk3p9Baey+n5ZGe1wCqmmYTbrdTj
	K7nY=
X-Received: by 2002:a7b:ce08:0:b0:495:5d6d:9cc1 with SMTP id 5b1f17b1804b1-49949f89850mr56638975e9.0.1785836267197;
        Tue, 04 Aug 2026 02:37:47 -0700 (PDT)
X-Received: by 2002:a7b:ce08:0:b0:495:5d6d:9cc1 with SMTP id 5b1f17b1804b1-49949f89850mr56638165e9.0.1785836266578;
        Tue, 04 Aug 2026 02:37:46 -0700 (PDT)
Received: from sgarzare-redhat ([5.11.104.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49949fec606sm86248365e9.14.2026.08.04.02.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 02:37:45 -0700 (PDT)
Date: Tue, 4 Aug 2026 11:37:37 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>, Michal Luczaj <mhal@rbox.co>
Cc: phind.uet@gmail.com, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Simon Horman <horms@kernel.org>, Andy King <acking@vmware.com>, 
	George Zhang <georgezhang@vmware.com>, Dmitry Torokhov <dtor@vmware.com>, 
	syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com, Wupeng Ma <mawupeng1@huawei.com>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] vsock: use sock_error() to consume sk_err after a
 failed connect
Message-ID: <anGyP3hBQfO0I1Pe@sgarzare-redhat>
References: <20260730081843.287563-1-phind.uet@gmail.com>
 <6a2958d9-5d16-404a-ac02-21940e90162d@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <6a2958d9-5d16-404a-ac02-21940e90162d@redhat.com>

On Tue, Aug 04, 2026 at 11:26:57AM +0200, Paolo Abeni wrote:
>
>
>On 7/30/26 10:18 AM, phind.uet@gmail.com wrote:
>> From: Nguyen Dinh Phi <phind.uet@gmail.com>
>>
>> Syzbot report an issue which can be reproduced with these steps:
>>
>>    r0 = socket(AF_VSOCK, SOCK_STREAM, 0)
>>    bind(r0, {VMADDR_CID_ANY, PORT})
>>    connect(r0, {VMADDR_CID_LOCAL, PORT})   -> -1, EPROTO  (self-connect)
>>    listen(r0, backlog)                     -> 0
>>    r1 = socket(AF_VSOCK, SOCK_STREAM, 0)
>>    connect(r1, {VMADDR_CID_LOCAL, PORT})   -> 0
>>    accept(r0)                              -> -1, EPROTO  (stale sk_err)
>>
>> Basically, it creates a socket (r0) and triggers a self-connect after
>> binding it. This self-connect fails with EPROTO because it loops back to
>> r0 while the socket is still in the TCP_SYN_SENT state, causing it to be
>> incorrectly dispatched to the connecting-client path. The unexpected
>> packet type encountered there sets sk_err to EPROTO.
>>
>> After that, it invokes a listen() call on the same socket. This listen()
>> call succeeds because the kernel's listening path never inspects or
>> clears sk_err. Then, a new socket (r1) is created as a normal client and
>> connects to r0. However, vsock_accept() rejects this incoming connection
>> because the listener's sk_err still holds the EPROTO error from the
>> earlier failed self-connect.
>>
>> This rejection causes the child socket created for r1's connection to
>> never be freed on virtio or hyperv transports; only the VMCI transport
>> implements pending_work to revisit and clean up a rejected socket
>>
>> Fix the issue by using sock_error() to read the sk_err to prevent the
>> rejection branch from occurring  in this scenario.
>>
>> sock_error() atomically reads and clears sk_err, ensuring the error is
>> consumed when vsock_connect() returns and cannot affect subsequent
>> operations on the same socket. This matches the established pattern
>> used by other protocol connect() implementations in the network
>> stack like __inet_stream_connect(), tipc_wait_for_connect()...
>>
>> Reported-by: syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=1b2c9c4a0f8708082678
>> Fixes: d021c344051af ("VSOCK: Introduce VM Sockets")
>> Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
>> Tested-by: Wupeng Ma <mawupeng1@huawei.com>
>Sashiko nipa points out that the race still exits:
>
>https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260730081843.287563-1-phind.uet%40gmail.com

Yeah, it seems the same conclusion we reached with Michal on v1 and Phi 
agreed on: https://lore.kernel.org/netdev/148e56ec-dc26-4be2-a7af-eb547b517a68@gmail.com/

Not sure why sk_err check was not removed in vsock_accept.

Phi can you check?

Thanks,
Stefano

