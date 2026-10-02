Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E56747F79C
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 10:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790937556; cv=none; b=WUKFDmXkZ9h4W2gFH9GrxAgMNc+O/l/HQ0wJ/4XJlBYCM8oTPjTmP+RQiIzrUysWqjLcNFfYK3CUA7ptMsB669DA7BT7iPxyKWzZUcEeSKjeOQ9weJavK5jb8342zfjQTacbfy5LYTWQWDMY7D/NQMQVGPE1t7je1TsBqldwAGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790937556; c=relaxed/simple;
	bh=KtkrCiH2Hb/NMXldy9WUxOKupOTiAB7hAqMQ2sR7Kok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c05YXSwT4GFUNoA3jMD9ccsHTd95cCToSQjnvqIhg/0DxPtKxQGV5Y/py28HktsClioRdZmXd4sFqzxg1s7honDl5SNssQNnY6mlypQ4XO/Pu68Tpx4yFHO31+G5PkdF1fzdopjRlW1o68NeqWdqxg2bFCoF7PJK6L8AiimKb64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iARhaPGj; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=K+LWPdAN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iARhaPGj";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="K+LWPdAN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790937554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MJkvDY/VxTHA+7Il1t54O0cGx3YczFz/IeL9Lev4wYw=;
	b=iARhaPGjM9cdy8qCwKaU0RAsKfteZ+zeX+fAIb/bveHrOe8cLIanfV2FNpBKD8zJsyDHfR
	3/O4UxegkYdDtAfqZG3/K16qw59Gj6LrkXdhkzD4TD6S7j5c1++/iHhSk4nLoAl8JP0pzM
	f24vjs9V5r/uX0lA+qUJc8+qmakTgRA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-cWjjDqFcOrmkyCjAXDzllQ-1; Fri, 02 Oct 2026 06:39:10 -0400
X-MC-Unique: cWjjDqFcOrmkyCjAXDzllQ-1
X-Mimecast-MFC-AGG-ID: cWjjDqFcOrmkyCjAXDzllQ_1790937550
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48aef5cfe43so2780686f8f.1
        for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 03:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790937549; x=1791542349; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MJkvDY/VxTHA+7Il1t54O0cGx3YczFz/IeL9Lev4wYw=;
        b=K+LWPdAN7Tj6AQXAbTatlIMwPax9t1pynifbe8Ia/8cQhTlzSO4l+sqkctaapBfB90
         6ZOYQ5s5V0wop+NRhx3QvInWt98XufgzDBCRy4r1HuO282EybgdqqovHAjpuSByT7eVa
         aJtHTlBVpsSrjfrjXWVHCYEQJH7NuBB/npzdBbquaRl+7w3i51EZD7UmlCmhMdMtawo0
         gx4ntOZUb4F/KKieFNJ4D/ylPvrnDnu4KTOdaBUsDdHLyNCEJKJKHudiRMaGyo6gTBAJ
         9zOS/X4QSKnPIEUauFbMV/IfVornAGzuizp5inj93VLBIEmkJa+FQFuHSHLwR43qHu9A
         FPzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790937549; x=1791542349;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MJkvDY/VxTHA+7Il1t54O0cGx3YczFz/IeL9Lev4wYw=;
        b=Vdv7uGJETbYcB5QVZRRh1KrSm5R6xFd6FJRjZgUNScdTX8yYEYPl9DNYO9Rkfm0sCn
         +NYsueYV3Y9aGdIBJO07TMyak+dpwdxBaBkquFoxURwkaOaeWk9ycRygBZrxhC1gt01w
         75yAvyALjwYKhY3nQY2heq4oDHwf1Lsmkjzy7AB0/bfAY3UxDZs8OfdP5HwVD7l4fyN+
         luheV+Zxru1uJH8At5r/13UBexMgonvseG0eKcVM5Gyro+ldoSAc42bbZ7kf6tsxsU15
         LXBjDxgjbV60m0/8t86U5y3VvKvxPsuDRupyezN5BXF+5kHorH9792fvtMzMbutqlvWL
         YuLA==
X-Forwarded-Encrypted: i=1; AKwUvBys3KnbE1pCDqbrZEfSmxUosssQ5nZeAxv/ghxJimb8ANlG2vCms027qz2x5sZe2P5/qs8E1y0=@vger.kernel.org
X-Gm-Message-State: AFuF++mZ/I9EWGiitCOlrnWhfTLSrle8gDYOg1MijXjveAUhJYOWm5uG
	DdhrrTYJX37ZBxpJumqNxclJKK7ZIsTDUYMXEWgJl2028vqt91GsIPNKVPD+dwzV3qkAU9DAMOR
	QDJ+X+gR6LkUwsXP6IeM9c64hKOooB1GHhJHb2qEio/5gMp/2ubmDxW/HNw==
X-Gm-Gg: AYBFou2jq5ovfWZhVCzBENyzLPslntlaoS9wr+dSO9Cx8JZeoFwDUKW0Ys8Pf+P9T3R
	N48S/7F5EqV1tyyKI9q/QNi/Zk/vLYg1kstrm8yVdqn3/j2Ep3fyzuTRcV3hGOzb9qNT+bA0mCs
	d3M4BCbJ93qyQU0XtvrgtczSqwv/Zyh5BsOnkES4Z4GYM9GoBL7yfDt0k4G224UdTrOvSWqo359
	3RKNqYZJNTdDeOURvWQbPjtDa82d74Qe06gUiXspKIImaW3sAmSHs6coM99IiQfJNmhgP8rZcx3
	Al/xh2yl8Tv/RLlqS/ylWBZwsRBhn7hCYJEphTf4zGLyi3dpEaZp7mA4bRNc1PQOOdU08AHtDR4
	PrdWP
X-Received: by 2002:a05:600c:4e50:b0:49f:faa3:3ca2 with SMTP id 5b1f17b1804b1-4a0275840aamr42202885e9.13.1790937549476;
        Fri, 02 Oct 2026 03:39:09 -0700 (PDT)
X-Received: by 2002:a05:600c:4e50:b0:49f:faa3:3ca2 with SMTP id 5b1f17b1804b1-4a0275840aamr42202565e9.13.1790937549019;
        Fri, 02 Oct 2026 03:39:09 -0700 (PDT)
Received: from sgarzare-redhat ([178.99.185.246])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a03fef174bsm38987125e9.2.2026.10.02.03.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 03:39:08 -0700 (PDT)
Date: Fri, 2 Oct 2026 12:39:03 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: physicalmtea@gmail.com
Cc: stefanha@redhat.com, mst@redhat.com, jasowangio@gmail.com, 
	eperezma@redhat.com, xuanzhuo@linux.alibaba.com, davem@davemloft.net, 
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] vsock: reduce RX per-packet socket overhead
Message-ID: <ar95red76pmfQwvF@sgarzare-redhat>
References: <20261002074551.318789-1-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261002074551.318789-1-physicalmtea@gmail.com>

On Fri, Oct 02, 2026 at 07:45:46AM +0000, physicalmtea@gmail.com wrote:
>From: Jia Jia <physicalmtea@gmail.com>
>
>This series reduces per-packet socket overhead in the virtio-vsock RX
>worker.

I did a quick look but IMO this is hard to review, please try to keep 
patches as small as possible, e.g. where you are introducing ctx, store 
ctx->net in a net variable, so you don't need to touch the entire 
function, etc.

Please check https://docs.kernel.org/process/coding-assistants.html
and also https://docs.kernel.org/process/submitting-patches.html
ans also https://docs.kernel.org/process/maintainer-netdev.html#git-trees-and-patch-flow
(I guess this is net-next material).

I don't think this series was sent properly, I tried
`b4 am 20261002074551.318789-1-physicalmtea@gmail.com` without success 
and also looking at 
https://lore.kernel.org/virtualization/20261002074551.318789-1-physicalmtea@gmail.com/ 
I can't see the full series, please check your workflow.

Also, is this for vsock core or just virtio-vsock? if it's just 
virtio-vsock transports, please use "vsock/virtio" prefix.


>
>Patch 1: separate socket lookup from locked packet processing.
>
>Patch 2: keep one socket lock across a bounded run of established
>STREAM/RW packets for the same native socket.
>
>Patch 3: reuse the locked socket for later packets with the same
>address tuple.
>
>Patch 4: coalesce default write-space notifications while that
>lock is held.
>
>Patch 5: defer the default readable callback until after the batch
>unlocks. Custom callbacks retain per-packet notification behavior.
>
>Performance:
>
>Tested on single-stream AF_VSOCK (1 reader on Guest CPU0, virtio-vsock IRQ
>on Guest CPU1, fresh QEMU guest per state, 16 balanced AB/BA pairs per
>payload).

What the host is using? vhost-vsock?

>
>End-to-end RX throughput (64K receiver buffer, SO_RCVLOWAT=1):
>
>  payload  baseline RX (G/s)  PATCH RX (G/s)  throughput change (95% CI)

What G is? Gbit? Gbytes?

>  256B     0.5722             1.0286          +79.76% [+75.40%, +84.23%]
>  512B     1.1464             1.9779          +72.53% [+69.50%, +75.63%]
>  1K       2.2714             3.6368          +60.12% [+56.92%, +63.37%]
>  4K       3.9095             7.7160          +97.37% [+92.09%, +102.79%]

Why stop to 4k?

>
>Fixed-syscall stress test (receiver buffer = sender write size; RX in G/s):
>
>  payload baseline RX PATCH RX throughput change (95% CI) recv() base/patch
>  256B     0.2885       0.6737    +133.50% [+123.58%, +143.86%]  1048577/1048577
>  512B     0.5631       1.2091    +114.71% [+104.97%, +124.92%]  1048577/1048577
>  1K       1.5361       2.9678    +93.20% [+80.15%, +107.20%]     1048577/1048577
>  4K       2.8378       6.1878    +118.05% [+109.15%, +127.33%]  538802/525645
>
>Request-response latency (Ping-Pong RTT, 10,000 requests):

What tool did you used for both throughput and latency?

>
>  payload  baseline mean RTT (us)  PATCH mean RTT (us)  change (95% CI)
>  256B     126.968                124.541              -1.91% [-3.35%, -0.45%]
>  4K       130.362                126.664              -2.84% [-5.12%, -0.50%]

Whys only this payload cases? For latency we should use even try small 
payloads IMO like 64 bytes.

Thanks,
Stefano

>
>Diagnostic Guest CPU1 system-wide cycles (fixed-64K receiver, with perf):
>
>  Buffer size  baseline cycles/B  PATCH cycles/B  cycles change (95% CI)
>  256B     15.287            13.630          -10.84% [-12.51%, -9.14%]
>  512B      7.306             6.611           -9.51% [-10.92%, -8.08%]
>  1K        3.811             3.458           -9.25% [-10.96%, -7.50%]
>  4K        1.850             1.669           -9.75% [-11.78%, -7.67%]
>
>Jia Jia (5):
>  vsock: split socket lookup from locked RX processing
>  vsock: amortize RX socket locking for stream packets
>  vsock: reuse same-flow socket lookup in RX batches
>  vsock: coalesce RX write-space notifications in lock batches
>  vsock: defer RX readable notifications until batch unlock
>
> include/linux/virtio_vsock.h            |  14 ++
> include/net/af_vsock.h                  |   3 +
> net/vmw_vsock/af_vsock.c                |   2 +
> net/vmw_vsock/virtio_transport.c        |  48 ++++-
> net/vmw_vsock/virtio_transport_common.c | 341 +++++++++++++++++++++++++++-----
> 5 files changed, 357 insertions(+), 51 deletions(-)
>
>base-commit: f5f84daefcd92d7a630066635ecea1433ed5eac7
>-- 
>2.53.0
>

