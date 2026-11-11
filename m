Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794439265;
	b=tCt0nhCNGaycr+95KKQtb2j8Q7n1h+tGc/IXui1D20EPSUjM/nYbN6o86IAye3oFwuEJ
	 +my3rSyCi0OOg2IVrtMukDngbKlXpT5/P/2XhSAIJdfdQudKty3D/2SR3IgJ5+rjoMgIC
	 RRTPYhBKCGxmtd5HeI6lzYKnfYk10Tt7qwOW12Z9Wcisa0ZlPRUeqmVhqq9p2peu3XAWI
	 Y/Vsh/dbywx1t8vlTkMwu0zcD76apUjG1Cw1oKTdlPhOSSeIbQOEHyBVjFEaHNeGUBMyS
	 tV1c+JKz9hAO0y8vPo4oVp/GUSFFEriPYEXLfzEgr+57ddHc78u8vazZRVBnM4NrUhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794439265;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=KNu4FBFo+NiXU4uk2EB8iN37f7AOkMfz2eB0q/Nmt5s=;
	b=HwhDIZjk2jP2Rq0jkWdAGhP+iVNH7b1q8/rTbW9MgLbtz3rxOD5WjERqgadJek8sx4Xf
	 AGYcUfCJ7vGlHUnXQvz/Kf6aKakq5OT8nOeHy9zlAvGT5U7wb9XpwL2JKEeMtl+5nIcCV
	 UErd8rduhC98+K1FmOEAm8DRXqHIukNzTCna6jOkm8JXXnNcUtGh+qoT39eT5BJPCWtiu
	 +IqySiX4OM9W0i+ZG0BMrdAuRbN+0qMs7X1jG7LsIn3aYExsPGahQhHGYkF2z+ACMDxa5
	 rB6r957sEBQqCbuLNDYTWhaCYJcM+xwQ+gQ7Y/DuaAts1vKWJdI7tA+CRVqZF6EFQ5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PG06NK+8;
	arc=none smtp.remote-ip=74.125.229.5
Received: from mail-dy2-f5.google.com (mail-dy2-f5.google.com [74.125.229.5])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637B760A2614
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 23:21:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 637B760A2614
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PG06NK+8
Received: by mail-dy2-f5.google.com with SMTP id 5a478bee46e88-36caa19b0ffso2244921eec.0
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 15:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794439264; x=1795044064; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KNu4FBFo+NiXU4uk2EB8iN37f7AOkMfz2eB0q/Nmt5s=;
        b=PG06NK+8sjeCnFGsPkv7biN/XWVPp8cx4Zvam/TsDYmOaiYK6pe/9gJPX+5xFQMDwG
         FI7ZSXarOy2ZHCcYR5HKV+yYkrekblBvCUk1vUXz8MBnle4pAyi/GaiRzj0Y8Nfhmwvr
         OtfaG8jT6g6qhd4JuBpdh076rXDErLVCFrVlN+o2mFB/qS+lMM/hs33G70qIsK6M4TEJ
         J9VDq8+u00RPZUP2ARQzoVo6UUoByewIDiHYnMAJTB80Wztg6WOV49S5nQpMmODo77Cm
         n18RFe/aTJZ38OOYzqUaC6AVSKP3D41+hpBAIqwtbHebYSyUXCxDDrF162O6k1hWddDh
         Thdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794439264; x=1795044064;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KNu4FBFo+NiXU4uk2EB8iN37f7AOkMfz2eB0q/Nmt5s=;
        b=PNB1E1hXOP3kPGXJC3Obp8sVJ4B+UsORmQJe/bNYxyqlAbo9hj1+o6qTAETjzOIhVM
         74Ss1rnYyR/YjyFCyMlyCQ4FcK7Xsk4aET353jdifBie741WjlKRUuqRxdmF2ExokXmy
         mTASz9AQJBa2rZGKC6mK8D2y6yIhqQRbcJgPT2n4qrFNCVo9iUB9X92SRtJugpYfaa5d
         a0kXGkMjEaRVLPtd0c8H/zLVvE/JaAhjRSRSyCrEUAcUIfImy+oHBSxFOLhUy0te3XZc
         B6J9K6AZ8vzLfSvsT7INMhsKNwnePgXN6neZEv9o11aZQTbMgcvr2UKcRqdNSJtPWdhX
         boVQ==
X-Forwarded-Encrypted: i=1; AL+hErFQRp6XSoleXcv+XHN95NR1zfJjafnQbaxup8V4SghIxkGmTw0KM+q5V1p3hRm5XknMkBKVJ3g=@vger.kernel.org
X-Gm-Message-State: APuU4Z9FKyh3wbHyfvrFqiIct2IzuuKRqag+ocTgiPQDO4qwKmeVDkJH
	hHYPxbhi5LzShguDG+y3mrilo75PWWW1BA5GlRAieb8rGfb1kEoTNqfb
X-Gm-Gg: AYBFou120w+ZOPf8qMDxoHSNrDLzLg8q5Tp5U8FW6aiGsxsxIC0GXrO5KpxL9nEDmUl
	minGHhwyqP/0uncy6nZPbFtsjF/JzR9iyz9dfhrrUSTwvWm4N1MSXsalYneyzi2iU4X/Cj7uRt1
	l4QJsLwUoa55e35jJlNGml9IRt4KY9Mvs0YKuRxZ4+BDKFLtVRJioAssouWOwGRo7jU2LyERusd
	+uSqRP1Cutqk5RFl5FEjZVeNuO5ZB9M3BwFQErrXabPRXAf+uGLDClvMBU0ucr1Onw3aZ8Oa0lj
	+9KKBIvdiGoNdYowHd4r4Lym1NZaFGDijMys9wHyZBpjAB9AivhnvQB7j9o6J1jI3gPYkHu1mg0
	jboUblYDj7FQyOV5e12QEgi9WPUXDKZjeURTiyx4ivDo3TQG/nulweG+FP73aeKUGfMxpDfAzym
	rPHHvm1AQUmgjzYOy2L5+oQ6A378uVKa6bg5j+uxt3u7cP4dhnB021mBjPv6LdKiVodtvM4TO4N
	FA3LVIpO5iGyI+PEQrUDjPNwVwKZ+qGoTCescOsRusCOeH0gjRxs6MdDR7ON19M81QVTUhNLytz
	ZRfT9YfJ5/6shuy2FToBl2k=
X-Received: by 2002:a05:7300:fc13:b0:375:87f5:ccee with SMTP id 5a478bee46e88-37686a456b0mr3993699eec.29.1794439264317;
        Wed, 11 Nov 2026 15:21:04 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:67::])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520bf3e18sm39819238eec.16.2026.11.11.15.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 15:21:03 -0800 (PST)
Date: Wed, 11 Nov 2026 15:09:21 -0800
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	io-uring@vger.kernel.org, Mina Almasry <almasrymina@google.com>, 
	"Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>, Weiming Shi <bestswngs@gmail.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, David Wei <dw@davidwei.uk>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stuart Clark <stuclar@meta.com>
Subject: Re: [PATCH net-next v1 04/11] xsk: Allocate UMEM chunks through
 page_pool
Message-ID: <avT1lx9mdbzz8OGo@devvm16445.scu0.facebook.com>
References: <20261110102039.1002605-1-bjorn@kernel.org>
 <20261110102039.1002605-5-bjorn@kernel.org>
 <avOia/ZPWiFdfW7y@devvm16445.scu0.facebook.com>
 <87o6bv8o5e.fsf@all.your.base.are.belong.to.us>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87o6bv8o5e.fsf@all.your.base.are.belong.to.us>

On 11/11, Björn Töpel wrote:
> Stanislav Fomichev <sdf.kernel@gmail.com> writes:
> 
> > On 11/10, Björn Töpel wrote:
> 
> >> diff --git a/net/xdp/xsk_pp.c b/net/xdp/xsk_pp.c
> >> new file mode 100644
> >> index 000000000000..fdd55265a6cd
> >> --- /dev/null
> >> +++ b/net/xdp/xsk_pp.c
> >> @@ -0,0 +1,246 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/* AF_XDP UMEM as a page pool memory provider
> >> + *
> >> + * Each aligned UMEM chunk is a readable net_iov with one owner at a time:
> >> + *
> >> + *   userspace --FILL--> page pool --release--> reuse --alloc--> page pool
> >> + *       ^                   |
> >> + *       +-----RX ring-------+
> >> + */
> >> +
> >> +#include <net/page_pool/helpers.h>
> >> +#include <net/page_pool/memory_provider.h>
> >> +#include <net/xdp_sock_drv.h>
> >> +
> >> +#include "xsk.h"
> >> +#include "xsk_queue.h"
> >> +
> >> +enum xsk_pp_chunk {
> >> +	XSK_PP_USER,	/* owned by userspace */
> >> +	XSK_PP_POOL,	/* owned by a page pool */
> >> +	XSK_PP_REUSE,	/* on the reuse stack */
> >
> > Can you explain more about that reuse/reuse_cnt? When is the chunk reused?
> > How is it different from FILL->RX path?
> 
> 
>             FILL             RX ring
>   USER ----------> POOL ---------------> USER
>                    |  ^
>    release_netmem  |  |  next refill,
>                    v  |  before FILL
>                   REUSE
> 
> POOL is a chunk in the page pool or on a driver ring. XDP_DROP, copied
> XDP_PASS and XDP_TX recycle it inside the page pool, so it stays POOL.
> FILL->RX is the only way back to userspace: an XSK redirect puts the
> chunk on the RX ring, and the flush (patch 7) marks it USER. Userspace
> posts it to FILL again.
> 
> REUSE is a chunk the page pool lets go of without a packet: when the
> pool is destroyed (queue restart, unbind), or its ring is full on a
> recycle. Userspace already gave it up, and the kernel can't post to
> FILL, so the next refill takes it before FILL. Same job as free_list in
> xsk_buff_pool. A FILL entry for a chunk the kernel holds is dropped.
> 
> I'll put that in the comment at the top of xsk_pp.c.

Yes, that helps a lot, thanks!
