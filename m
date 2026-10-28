Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793208334;
	b=3GhQcgdLREI1cV5zbVQAxGoYH04KqB7gYJqg6rZl4RhZujkTsGba3N4Yzv34jc5PgRL1
	 Ffok/FhYOzHTYif2AnWxlHMZyLEI0FPCL/TI/I+BRMN5Ii2LGFvOpjPL8+W54NF0VS+2j
	 fUuZO/goCSrAOnaDYok2cCBcfWGZis4h+sFqXcrbD7APPJhG/9tToPBHX3unEfsUcSJl/
	 0tMLiibYWQj4jThrS7HGuH+RQxT/zPNfshoH1tpV9YsiWuEAYssiboLIN7LxCdxBTF+im
	 L0SS67RoYvCJO7IGt0FiT6cWUOfSBTgOP/7mMs7DID/Jy5RQwNHp7X2ZeOCaIDvXKQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793208334;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Subject:From:To:Cc:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=XLYiEepDtnyQ6wJ1rlYe5RaJc/i8ARvs/UjwaNMVQRE=;
	b=mgD6STMIOpRdiw+xr6YaAv7A7RYjwDGxStXUm3UIja0jB4kmSLpQpunEDHQ4KB99eseF
	 jxSTaMBcgYFkJIXfeOUcJtztjVnipurL8bZ8ekhHTDKJttcOuT8Au2xgwmq9elArZbJ+0
	 cSLNT8IXVi8jJ2gmr6xiHjwLHrOvU5dxWQt66AnF8eeIGKcBR5BXKdXWIhYiD44GeBCha
	 SATymiIec+uJIdzJaFBt+DZ3NbPhRy9+powrnABZJS8mvm8mFFgbl7rCfXzP4Uzen6wBX
	 M0ILNCeoR04JRlzKVeyCV3eti3/7Aoh6//H35m6IGP8mDbMRLSaKi5tqk7Vx6L8TOzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Af7y52Ro;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB76606A31C
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 17:25:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEB76606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Af7y52Ro
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ab60ff4273so1114654a91.0
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 10:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793208333; x=1793813133; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XLYiEepDtnyQ6wJ1rlYe5RaJc/i8ARvs/UjwaNMVQRE=;
        b=Af7y52RoNQXZRESfNzlA5nWU7zYO0dfLPezS+5rNH3Tx4+4DsnOMyhABRaQvfQPhli
         WGDEJ6zWLk88idrS1IRmCJxUBASFuuPGGngNzQZZ7LzmANcSte3aAEFKuC2VjHtOK2z7
         yjKMj+n+y7innZ39T/IQMUNxUrOFGpd7ZgkibuW592Y5ybQz3HYIMsH9Gk9Vo/7F25Aa
         q36OaknOzdG878FRgHSj5M2t3J2VawgIYj7j4isik5KORWNcsNhJEboFyrcCLGCCUvS1
         gSvujDxwZjfi6G+bKCVFt8XzBT2Fk2cA1mp2Ztj8lzO/DQBvE/UHm9uoMPtJq1mQY/nw
         HIEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793208333; x=1793813133;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XLYiEepDtnyQ6wJ1rlYe5RaJc/i8ARvs/UjwaNMVQRE=;
        b=oI5h2SjF+8C7WSKjzsgGWaNTN4i90DcSWOjS2AGUWT8jQKnzl+qVc/3u51FwlDyAHA
         n3bU7EP3mWCw+wzFSxOi+nfcBjMlQZseaPrnYeApCd9SmDcif5H1r1b3sfCFZSbPauji
         UkGIT4g/i1hnXP9t5yygXHm/KzCPkFIOFi6b28mHGrzBLyP1RPCdYPHWch0lyR/FQdf1
         siq7MpBc16LO8e0U4K34vZ9I8D/ZW5HqD+ysBTjigmAPMcKDsdlg14C0aycdVB/yZ8KS
         Wz4z8blZnUskpQQWldKmXP7mlGasQT39kYWB308VcSYLEBQMNDq2WnlGJWcvK7nG3gd3
         QdeA==
X-Forwarded-Encrypted: i=1; AKwUvBxXS26fI/LVBRR7LGzXzNe557RtkihboeUFZUchoGYCfjw7RqFLXtNk7zF9SXDHlf+WABspyKA=@vger.kernel.org
X-Gm-Message-State: AFq9FYK7jtpKHKKX2wml0f9j9kAy5HxSJzqwa0rsZfmwxqEFoPQdesRr
	Ib1fylYlbeZyVuMe1Fe46iRAK4GvyH3ZW85aZbTyY+b8zim1EXbvYEIa
X-Gm-Gg: AYBFou3WOeNMBm2/yVaRZh6p7t/suoNBW0rJYQPfZkUxcopKkzCQsdvveYvUxlVKSbU
	dWF3i6raYu/PTrK1s1h7nCV85UzRHmELBusgLEOchShjmusG5tfjDXlIgtZzdm1iEbuXrV7Y4DR
	lnw4NqVNSB5e3KKRU2dX33zbF2U66lqwcVA4ffRBg2zIEmon0AmeX/4HJNYvyFOH7VTxGB0+D0G
	RSP9TNPNTZniZXGYdi3NNb1CttCNLQyGkKvho5V6su+kmkCbYQ1xafmY/i4YN6kzwby5Yv4XkXH
	ewCJKDiEHspM+cznNPgjUA/1mCB3yKzjmLVQIXgtPs8xufx0fKKoYtdMxYXrgXvQRh6408ncyTO
	fao3+XrZDHfWiKG8AmJLalRDubOgWWKOaevGurt06/J4l+mdGkJhzvUJhkcvgboyLDiYKodQ2Hj
	qZes2NV8WakEJdY5/RWHLMS48+cUJxptAX9aD66XcipJ4GYTIPLP1Ko1DtBRZteeVHXEJTowYfW
	am1uNtPPG7d7bp9XCsnv/1lFm59BmH5IVkOYS1Rm0QrOqmAP9vrBTzzmJcRKaQFVLvmzaa2GDo9
	jEYqfalJ5uSphTIklr4bmryeKem+OP/RvblrJEJu3yA9sQ9ncqdUXdzhDW1Xn6PXZUZd1slU0B8
	J3u3KQ1wwd0HOLBk3Tnveqgg2D0sVgY2AJQ==
X-Received: by 2002:a17:90b:3a46:b0:3aa:fdad:7d6e with SMTP id 98e67ed59e1d1-3ae581b7b3fmr2290113a91.10.1793208333116;
        Wed, 28 Oct 2026 10:25:33 -0700 (PDT)
Received: from localhost ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e9583c1sm397200a91.10.2026.10.28.10.25.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 10:25:32 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 28 Oct 2026 17:25:31 +0000
Message-Id: <DMGNAV67LK3F.2FNLTD5NVHDEA@gmail.com>
Subject: Re: [PATCH RFC 0/8] vsock: add datagram support to virtio and vhost
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Sergio Lopez" <slp@redhat.com>, "Stefano Garzarella"
 <sgarzare@redhat.com>, "Bobby Eshleman" <bobbyeshleman@meta.com>, "David S.
 Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, "Bryan Tan" <bryan-bt.tan@broadcom.com>,
 "Vishnu Dasa" <vishnu.dasa@broadcom.com>, "Broadcom internal kernel review
 list" <bcm-kernel-feedback-list@broadcom.com>, "Stefan Hajnoczi"
 <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Jason Wang"
 <jasowangio@gmail.com>, =?utf-8?q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, "Xuan Zhuo" <xuanzhuo@linux.alibaba.com>, "Haiyang
 Zhang" <haiyangz@microsoft.com>, "Wei Liu" <wei.liu@kernel.org>, "Dexuan
 Cui" <decui@microsoft.com>
Cc: <virtualization@lists.linux.dev>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
 <bpf@vger.kernel.org>, <linux-hyperv@vger.kernel.org>
In-Reply-To: <20261028-vsock-dgram-support-v1-0-e457cf7cee78@sinrega.org>
References: <20261028-vsock-dgram-support-v1-0-e457cf7cee78@sinrega.org>
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Wed, Oct 28, 2026 at 09:04 AM Sergio Lopez <slp@redhat.com> wrote:
> This series implements SOCK_DGRAM support for virtio-vsock and
> vhost-vsock, allowing applications to exchange connectionless messages
> through the existing AF_VSOCK datagram API.

The cover doesn't say who needs it.

Bobby and Amery took the same feature to v6:
https://lore.kernel.org/all/20240710212555.1617795-1-amery.hung@bytedance.com/
Stefano said there that it can work well and that the virtio spec change
is the next step. The last mails of the thread have Amery's v7 WIP and a
short list of what is left.
The cover doesn't mention it. The spec change is still missing.

Why not finish v7 instead ?

This RFC goes the other way in these places:

  what               v6                        this RFC
  -----------------  ------------------------  ----------------------------
  (cid, port) space  own bind table for dgram  shared with stream. The 2nd
                                               bind() gets EADDRINUSE
  vsk->transport     empty until connect(),    g2h or h2g, picked in
                     lookup per packet         socket(). -ENODEV with
                                               vsock_loopback only
  routing            one helper for stream     2nd copy of the chain in
                     and dgram                 vsock_assign_transport()
  recvmsg()          in af_vsock.c,            dgram_dequeue() stays,
                     no dgram_dequeue()        dgram_payload_len() is new
  VMCI               fallback                  first. No virtio dgram when
                                               its module is loaded
  dgram > RX buffer  drop, EHOSTUNREACH in     every RX buffer is 64K
                     the error queue

> Datagrams use destination-based routing across guest-to-host,
> host-to-guest and loopback transports while retaining the socket's
> transport state. VMCI keeps priority as the dedicated datagram

A dgram socket uses two members of struct virtio_vsock_sock: tx_lock and
bytes_unsent. They serve SIOCOUTQ only.
virtio_transport_alloc_skb() does skb_set_owner_w() already.
udp_ioctl() returns sk_wmem_alloc_get() for SIOCOUTQ.

Without them a dgram socket has no transport state, like in v6.
Then no need for the owner transport, dgram_transport_match(),
fallback_transport, tx_accounted, the skb destructor, etc.

> transport.  Guest RX buffers accommodate complete messages when
> datagrams are negotiated, preserving message boundaries.

That's 64K per RX buffer instead of 4K, for stream and seqpacket too.
It undoes commit 03a92f036a04 ("vsock/virtio: Resize receive buffers so
that each SKB fits in a 4K page").

pskb_trim_unique() doesn't reduce skb->truesize. So a datagram of 1 byte
charges more than 64K to sk_rmem_alloc of the guest socket.
The default sk_rcvbuf is about 208K on x86-64. The 5th datagram in the
queue is dropped.
