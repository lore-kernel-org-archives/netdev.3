Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50C543BDAC
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 09:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785835635; cv=none; b=ZBT8mAJIgYI8EwG1qiSykoJ0DZgRWIVUd+LLdV2PFQUa3jPNnMIy4mNagqZl/A79uHovr1jbYiB2XYlvywU/n8JToC/ycMwhZRmmOUGpYa+BQmAMScrrUF+gWG8c4kBnkfFjs9ryFFTvr26VPtWIzlIYSrztGAfRjQBi7vOcdvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785835635; c=relaxed/simple;
	bh=skB/VTMTVWUWweeYibtmz/vwh56rk9b9WsCTp4BOFYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QyoD8fhr8/Pukc8h6zZs8oyyIZZWCqf7ta/aJS1K7pMhRBr56mV8Fgqr7lvGkB+Cgnpqk0b8098++1G9Jyhk8vw6RBjXrkggpHFz6QH2EedHACQowBbYtmn8Hc7cjmfK7LX6flkvz9bXmU2RBAtSTMz1eY1ivGDngxAXT86I/p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Go52nQ7X; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yb6JF4gi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Go52nQ7X";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yb6JF4gi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785835628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PNJ/sXRmHkTmqxpE76MJtCuijUeyDT/yfL/oohXB45Y=;
	b=Go52nQ7XTbCNrceaPL9IQOBOp8TnSFBMlN0VkLt+FjGEO9WWfrLENDPOfmTtuF7YAsmCZX
	bJUWUwI291m6xVlNzH3kavK1/8K23UKR7SRAJ7DGAE3lKn08fiNAWIjP4kIZQHHI8jKnp5
	5x9l0gf5gvVcwN7WPriEmzSxwBmVXhI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-kdcy8n0pPS6MChY3ratoGw-1; Tue, 04 Aug 2026 05:27:02 -0400
X-MC-Unique: kdcy8n0pPS6MChY3ratoGw-1
X-Mimecast-MFC-AGG-ID: kdcy8n0pPS6MChY3ratoGw_1785835621
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49561facb1dso20116345e9.3
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 02:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785835621; x=1786440421; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PNJ/sXRmHkTmqxpE76MJtCuijUeyDT/yfL/oohXB45Y=;
        b=Yb6JF4giNJ5nuF2X+uHuBqhlymBhBSOanPAQwviLafHEO1dHhPCcPlqoaOzdXgrwnK
         B+ubcHJlSQ03C+4+bI03+OQ7bqIGGm/xGCcyYeclvZoUXHk0LHnt+ahAPJ/M8R7OBlQG
         NZoPvLv/MsIbqAcjWE9mPVCBJatC55KpoRPKriRyLIOhSv3M59tl80uwBv6+yc0TZYdR
         zNsusKApAdDd0deiucNbcDXpLfbAdoRXKW4c5nuSgMregtnUn0pOITvn/jm2ImXwFIRm
         rC5PlU8SfiHxmuSne5Aj2o/mtf44bSoNOGgQbTzpJ/S3CqNKcBoRIlldRWrMEOmMmRm8
         cfcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785835621; x=1786440421;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PNJ/sXRmHkTmqxpE76MJtCuijUeyDT/yfL/oohXB45Y=;
        b=a38btu/Dg3HGIhOisa0HFjbV5M27OzJ6FKwhjc90HMdTJO63bV8dPREdX6QsRlmcg9
         JUsAtesUx5qwoeVAn/AoCSncNn+bbXwXdb0xSOlmEqkMJGREE5j87dqdDshrFnPfFVEj
         mg/+jb1ZX4FzPxAsNirffI8pLl+pPkf39MDf+UC1GliuoKprfsdEelSGho5c485xoHr7
         5KG6XXgTDPHdaG6nJgcShnyROu8nNuJjb34Ce4Nrfv1u8Nr7i7t6NviqW6BJvzV1wW4f
         mbi2uEhAWmUIEODUalDzSWqag7F7YsMEhu03aXBwvS3t0oaaSq2aLxMi+GoIZdwoi02I
         h4/w==
X-Forwarded-Encrypted: i=1; AHgh+Rp49BMpGA1xSRFhbtdjx6MAQXozogmCfn9UlAYvp6iRVKE6qF+os4Ii5Hj63gj4bblTp3VwvtY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsJmWRwKXTMhtppKBawmGcX5yDaA17HD1dPW9eJkVhfsPD/WFJ
	C0O3HFwu2HmS5PBTxHfHtNRwZEmOP9cmCGYag2w4BcAwB2NYeCtN6JYwoX9vVSQI1kx1A7xkyXJ
	rxQrOuCl3UTreQNpXx3XxvOmGgbmWrk6geQSSj9RERiAbc9R8bsbqoRtW1w==
X-Gm-Gg: AR+sD110Lzhrfc8ezVrsaxTazUNJDkIYabpwp6UbRjZ3/xgI60Aen0vVENg+8IRVyGb
	SaYxG2cBVLW3qhQP1ZlIDxBill3i/tBWceNi6xZkqjS9X9yspUN3Rz980WF6sDd0+GI93bvDPhR
	5OyzalKEY+iZx8EGnY+1+2kMg8nqA+O7/CH9vTx/L5KJgVWkvtosMUIfm96WJ4xpyHgaCN4AXny
	kFTzfoLpZ9PtMo0UHpyD5Y9htFXy4DCxsSfq0+rri4r8LvGQMSohBDXYCcMtAj0Txa1n7bNfHNp
	evDcbAu8lkyLF3WvoEGP1Pd7Xm72ziYNvrWhClLhqMUBZRUNn4lEdXjEyaCsXcp2wCR/HefCrr8
	VlVFAjVvrEr1IgNYxIuPXzgbUxo33Ow4Ug8B6M8bTu1+H+2yWnK1KlIQtqrO0CajhMcbkTmN/+E
	M=
X-Received: by 2002:a05:600c:811b:b0:495:6934:414c with SMTP id 5b1f17b1804b1-4980c696c7emr309462225e9.19.1785835620730;
        Tue, 04 Aug 2026 02:27:00 -0700 (PDT)
X-Received: by 2002:a05:600c:811b:b0:495:6934:414c with SMTP id 5b1f17b1804b1-4980c696c7emr309461645e9.19.1785835620292;
        Tue, 04 Aug 2026 02:27:00 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994a0f7bf4sm69568615e9.11.2026.08.04.02.26.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2026 02:26:59 -0700 (PDT)
Message-ID: <6a2958d9-5d16-404a-ac02-21940e90162d@redhat.com>
Date: Tue, 4 Aug 2026 11:26:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] vsock: use sock_error() to consume sk_err after a
 failed connect
To: phind.uet@gmail.com, Stefano Garzarella <sgarzare@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Andy King <acking@vmware.com>, George Zhang <georgezhang@vmware.com>,
 Dmitry Torokhov <dtor@vmware.com>
Cc: syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com,
 Wupeng Ma <mawupeng1@huawei.com>, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260730081843.287563-1-phind.uet@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260730081843.287563-1-phind.uet@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/30/26 10:18 AM, phind.uet@gmail.com wrote:
> From: Nguyen Dinh Phi <phind.uet@gmail.com>
> 
> Syzbot report an issue which can be reproduced with these steps:
> 
>    r0 = socket(AF_VSOCK, SOCK_STREAM, 0)
>    bind(r0, {VMADDR_CID_ANY, PORT})
>    connect(r0, {VMADDR_CID_LOCAL, PORT})   -> -1, EPROTO  (self-connect)
>    listen(r0, backlog)                     -> 0
>    r1 = socket(AF_VSOCK, SOCK_STREAM, 0)
>    connect(r1, {VMADDR_CID_LOCAL, PORT})   -> 0
>    accept(r0)                              -> -1, EPROTO  (stale sk_err)
> 
> Basically, it creates a socket (r0) and triggers a self-connect after
> binding it. This self-connect fails with EPROTO because it loops back to
> r0 while the socket is still in the TCP_SYN_SENT state, causing it to be
> incorrectly dispatched to the connecting-client path. The unexpected
> packet type encountered there sets sk_err to EPROTO.
> 
> After that, it invokes a listen() call on the same socket. This listen()
> call succeeds because the kernel's listening path never inspects or
> clears sk_err. Then, a new socket (r1) is created as a normal client and
> connects to r0. However, vsock_accept() rejects this incoming connection
> because the listener's sk_err still holds the EPROTO error from the
> earlier failed self-connect.
> 
> This rejection causes the child socket created for r1's connection to
> never be freed on virtio or hyperv transports; only the VMCI transport
> implements pending_work to revisit and clean up a rejected socket
> 
> Fix the issue by using sock_error() to read the sk_err to prevent the
> rejection branch from occurring  in this scenario.
> 
> sock_error() atomically reads and clears sk_err, ensuring the error is
> consumed when vsock_connect() returns and cannot affect subsequent
> operations on the same socket. This matches the established pattern
> used by other protocol connect() implementations in the network
> stack like __inet_stream_connect(), tipc_wait_for_connect()...
> 
> Reported-by: syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=1b2c9c4a0f8708082678
> Fixes: d021c344051af ("VSOCK: Introduce VM Sockets")
> Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
> Tested-by: Wupeng Ma <mawupeng1@huawei.com>
Sashiko nipa points out that the race still exits:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260730081843.287563-1-phind.uet%40gmail.com

/P

