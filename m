Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688E047F2C4
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 14:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790088073; cv=pass; b=PKhxUHIrpTFm50FVBz5an6cFDO35JEofMQ3RmoD4AHcw7zPrsqMA6GwG50S84Rosnb4feOiLHib5llvlJW0zk/j9to/bBu77SJl/hH83Q9gkpVX7fuphCcVu6KnQDUo2rDC3bZ9evwebCJ6OF2zOnxkNNfe0Qc9hicxvIUJDqkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790088073; c=relaxed/simple;
	bh=iYkoLLjFuLaOLIFnl2IacK4JF+N4rG+CagfraarYei4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vs7iEdyK05rPhJPeZdat2dqEZmsRtymQNgITAPGNoNkTusOjiSzCk+NfZRTBKD3BB0jGp1Us2VKQcG+muz9cL1nfQwYjV2zMCnkMqdX58+CFYZW9oJdtFVQo6YPs/qxXoiYyE1/X+UbhEMA0JzH/KNjxFQdWP2B63x7brkdeQhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pPVxjpNy; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pPVxjpNy"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f9f7db0so513962566b.3
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 07:41:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790088069; cv=none;
        d=google.com; s=arc-20260327;
        b=SDO7V0gT8QfxXXy3BwerBZLI8Ljt5rfNZrvrCPgA0e9wcQHZZIUQC3+FsKmK22kFXR
         Z0AD7GByt9H17paptHcD2xISbNRMJ8mPtoEjFl86aVTQUqwtm6RW4fTOClyviP1MrQuZ
         DDJdqrIJXKgc4GCgnvrd5zcU9To7NzxxWG7kp+GoWkcBs7qELxOTs1SIze0iQdpw2Hh9
         C3G8gGQnHT/QP7IVJYUU1ESRJOykT7haSgYyY4RrqNaMBXeljGfZD4wzjGUFEo/bq56Z
         fQe3Al32n8KgqKg1GjfblqgRoWgWcUY1U2hr6og87uiCSl1JXZrpERD/Dg48hHItfn1g
         Gg6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=aobqVTftx2RUrnHTqiqb5TNxJi/O+H0hYNwZcfYit+Y=;
        fh=oscuMgTh7wHBzrUDKOarO0aBSXBA85T1i+BN/enA+6U=;
        b=nXLE5WEwdzrHWIz/za3o27x67XdW/6ZTXUQcgYj8UaTooNhiBO54zE/T/4gQ0EDw/a
         rwDJa8H5LLACqYIk/M2/4+sKJBAlN0lTKj/kjgoR8g5N5YOsobEmrskHxECDrSAEa6Uq
         64Z8H/eZO4Aj4X3sP7x+aXXewWaI+ZtThB+rwb6VyXRAQUuQ+V+tUH7uA5ueyzBeN/+u
         1Dlj7i0d6B9jTjX9d33NUE+ceYEmB+Gm90W7bV1Tp/chnIYFKCMY8q/IBcn0/tBjJMCU
         2hngsK9X7pc93wFAXSm7dBb254xEtqjGxxQHOPMrFrAedbbIZxw8oZsGSHGkFbPgUQLV
         ZCzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790088069; x=1790692869; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aobqVTftx2RUrnHTqiqb5TNxJi/O+H0hYNwZcfYit+Y=;
        b=pPVxjpNyTrNK+5ZOq0PM2wCKcDZs7hZyct3huk+9SPzuvcVEW/QIcGiGOrqOaydR/5
         Zq63oCKR7m97TtIrvMEmWJUzQm4k3CDT8LPJZgbTG36I3hZ7OrUZonzr6Y/RbyFf2LsH
         LbCxa/SdUf8gJ/0mAZJ7ivod1C0S+6tGCkTLH3SbbEfEv0XaIXyukmGAjTNDQOYL4urZ
         2QyPbk4QhmyQkGIJ6t9Ib16Erp+tu0l9mpxN2nzih2QhgRmVOA3pzGGt2pTp8ugegUeC
         7NKABHf6QzukcTJtc1JR07/x+H7IW44H0PmCc6EA+HhcQ+FslOzCKb9xu4TMmMTG0poe
         BXpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790088069; x=1790692869;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aobqVTftx2RUrnHTqiqb5TNxJi/O+H0hYNwZcfYit+Y=;
        b=qrv6IpQNpTfPB9DleLfMY1b15c89wbzx0KenDVHsx+1Pnt+0f+T1jA+Dwr1QiGpDhR
         fWxzSwTqmGP2/62mRa8oXhQuQ674/g/0wM2xM9epdeYvOdJjBTQYHmytSDBSXY6i6UH8
         ib6IKzvVfe5xgX5Hrdl6j1TdSpaisZWVpjJd7M4CZEhLjjQeC/yG2nHTwI3GU8txhGNg
         i/RAsaSHLE4sS7Isz/csT8JzN8aeMoZAZ65MDUXbTAdvX+roZ4XL4maoULnqmjoXXdBv
         bCqZapXl8/h2cEj2k/DpIFc6KMlma5U+xlGM59JH5UYSqO3Sq1N+7LVsYa50jgWIkYAw
         lpzQ==
X-Forwarded-Encrypted: i=1; AKwUvBw7O0xyU/brRJQKkICfeGyNV/aWuzbMvSdhvu+GiEkvj73rwkiqSsAcJEpEZulmDTdAEKjDTxI=@vger.kernel.org
X-Gm-Message-State: AFuF++nIH8ced2BrochTrbnyTvIBFjI4jttkZ0L5gUpxFiZML2XfohG9
	jN2dxDxw16YLcZ05Bhbfo8UxJxq/9zfqs7yHRapzCYlg8aXme0hZDGoHkzpQtwAK49KgnBGlpHf
	E83cKvvbeL+R0GXhSbYjLXdYbtzNnha0=
X-Gm-Gg: AYBFou0u2Pzj+g6/2f3lApz4IzIzIIUe61BhIQxqu1Q8NmuDAmDlmOjNG7n7xHjPh27
	hPxFjEYvRbrQxRusKj5tJT8xrG5YIBAdijXnw6+T3hXpimOCIc10xfUhPQZR7b7Gudrbc05lOLL
	TQxAjXojjyt+4vCQF1qs3WHPDLfXj8qu29OO8Wk8Lx8D3d/roN3V32idsDacfxbI/+t0eFCfkDz
	QAtDg7m1UlN8Vk6BE6RoQPWGCByRYOxDqwJ91gX6WY9yfOpLYf0iUe/nwbLVmwaKHyhrPjEhYkp
	TCskKoNO71PFl4a8iXcIUcf01q5SBbpgjVOKuQriQ4wtH9ksBxWwW7f3IgAYZ2DatFtHGAbzdkf
	EAwdLHuTglTYkAC+gQXwWwaC/buLoeI/DscPYJ2ylbXNYzSHH5u+EmNAFfvFWV7/x06K2BQFaHx
	XXu7vI+rwmLLbwjlqh9YiW68uoOBVKBh0jakauTdTW/g==
X-Received: by 2002:a17:907:7b87:b0:c29:5a49:f8ae with SMTP id
 a640c23a62f3a-c2a156d4889mr1174425166b.12.1790088068900; Tue, 22 Sep 2026
 07:41:08 -0700 (PDT)
Received: from 1057883412519 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 22 Sep 2026 07:41:07 -0700
Received: from 1057883412519 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 22 Sep 2026 07:41:07 -0700
From: Zack Gomez <zack.gomez@gmail.com>
In-Reply-To: <aqpnhJyXHYrqqohg@gmail.com>
References: <20260914041221.1028092-1-zack.gomez@gmail.com>
 <aqeyvaw06I2883Fo@gmail.com> <CAErB-w3fmW4bQqRg7895dZ4ZRqkDJmfb7FSCLPvRCkwrhQzaqQ@mail.gmail.com>
 <aqpnhJyXHYrqqohg@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 22 Sep 2026 07:41:07 -0700
X-Gm-Features: AcwNN1WJEk5oAzhiFwYCAEjZSZzcOxsgWSi9YoYm3E2lZNizP7dV3aoB5UEvxfE
Message-ID: <CAErB-w0sQ6mg9UpK9_YM-VXjQrf=shY+nwtkWMYbSF=zk+cSeQ@mail.gmail.com>
Subject: Re: [PATCH net] netpoll: bound the deferred transmit queue
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, Sep 16, 2026 at 03:01:30AM -0700, Breno Leitao wrote:
> My concern is some other netpoll users that do not check for return
> value. Is this change going to affect them?
>
> For instance, team doesn't even check the return value.

They only lose the accounting. bond, bridge, team, vlan, macvlan
and dsa reach netpoll_send_skb() only under netpoll_tx_running(),
when the upper device's xmit was itself entered from netpoll, so the
skb they hand down is always netconsole's, and it is consumed whether
sent, parked or dropped. The drop lands on the lower device's txq,
which is the queue that fills, so the bound holds for them too. What
none of them see is the drop itself, bond included: NET_XMIT_DROP
from the nested call is below NET_XMIT_MASK, so the outer
__netpoll_send_skb() reports a completed transmit and xmit_drop_count
never moves. The existing !npinfo / !netif_running() drops behave
the same way today, and netconsole never had a delivery promise to
lose (UDP, and netpoll_send_udp() already drops on pool exhaustion).

> If a WARN is too heavy and it seems it might be, would a drop with
> a reason be better than just dev_kfree_skb_irq() ?
>
>       dev_kfree_skb_irq_reason(skb, SKB_DROP_REASON_FULL_RING);

Will do in v2, though it will rarely be seen:
dev_kfree_skb_irq_reason() defers the free to the completion queue,
and the next find_skb() on that CPU zaps it with __kfree_skb(), so
the reason seldom reaches the tracepoint. v2 therefore also does
dev_core_stats_tx_dropped_inc() on the device whose queue is full,
so the loss shows in its tx_dropped in the stacked case (tun pairs
the two the same way for its ring). I'd rather not WARN: the path
runs from the console being drained, and with a flood in progress
the splat is one more thing queued behind it.

Zack
