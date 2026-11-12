Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794503068;
	b=FtJL3EVI/JNlIl0nM3OlZ3CyXtNrhqZHmMNeO/Nwl8B49/39eJINTGJrU2xXlR9GaMWc
	 W9n6PwpHNBa1m3ycp/4fzLZbZaMQ90+4YMLswhGhIW+d6R3bO/19PY4K58cQswt666XKx
	 b8o7T4tX3umNzGXdi4ZamkQV1GNS5Xyy7LXj/xRC86I00TS97yyq9ZyWH7PksJcKNfDYZ
	 brheXdnI99jcpstka922MHXs+KGuNNhtC65d3cPm0gbql/MrdSFqDChISwpb696d7Aj+F
	 7buPmsi9gcaTCKVGzMDFPY5I9ZwXUafju12geXTI89Et/I3G6RnAsZDxAhTt+S4fWjg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794503068;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:In-Reply-To:References:MIME-Version:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=snSHFcywNjYaU+V8VNJTtf/b2PyC3xXSLz2Yl9hABOc=;
	b=mw6yFStRucMQ+sut1TXJU1cq+H3q9EvRwVkoSxQv5Hj8LRRwe5Y6JrDsU4uK/ZY554nE
	 6ebEwgXw8JR+ya9AuhoM/mxpkK0gu002VT/R7g0h4jd5sR0xU7lj2CEcUJLniPbQtUc/E
	 fnfWEHAY+f+svpyvLvX17wUkUO8k/WwUbi1LXoRpPh07R8KqCF2LrKuyOtFSzpqU+72oe
	 3eCpjgcFeU2RJ3BmUk8smbORDc0hgsrvhz8iKDOX7r0hkCeuKiL/vZeVW/WTd/wIpH8K9
	 0SO2pBXbSsJxYg0uWsUxUYEB12fj3p84tIgSSZMQqCKkBPL9qTd+VntuSF3cohnjfeQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WfdvRLKh;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=SkqdLGv1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D4F606A330
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 17:04:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78D4F606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WfdvRLKh;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=SkqdLGv1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794503067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=snSHFcywNjYaU+V8VNJTtf/b2PyC3xXSLz2Yl9hABOc=;
	b=WfdvRLKhAK2Fhu0Mnnd7QkCTa6x0FSYmCb/TLHg4UV8lvtfOOAc4TN5zfhr0i2V7cZFix1
	cuQh+JvNIWgVppc9/CQO9YKn3CRly3sYjgZ2InI9Mp3ddL4KWAd7KvuTkgCASy4yEt/Qmx
	2QE6KdXghzJLjg2RdS2otDwACSrTSFo=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-8H0kUQqoP2Ov26VG1_L2IQ-1; Thu, 12 Nov 2026 12:04:26 -0500
X-MC-Unique: 8H0kUQqoP2Ov26VG1_L2IQ-1
X-Mimecast-MFC-AGG-ID: 8H0kUQqoP2Ov26VG1_L2IQ_1794503066
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-91f0f4c70cdso306326d6.3
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 09:04:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794503066; cv=none;
        d=google.com; s=arc-20260327;
        b=JLu7eNqbr9s+tk4nhgf1MazSlHhdKRFHCa7rDw4jJNCwdOkAsv0d5LbV0flPL/zmfy
         47xNkDtppohVhkAr0ZITYgzb9tdSX5QGpdnYRUpuxldiLUVCOZxioquuuBbJS4gLbmtR
         PnMZSrAuLFU3FQf6p7Or/ESYsP/hWa8YoSkmsuE/rHH91wErTIEN7ZNFWbi903NK2Y4L
         l8xhutT+EBdC+Aj+36OqtTTc0JLbbe2KETyYGMu7et3xf1B+AREw6PgbvKyrz7shE+Nc
         8LnngZoKJIt4Wgjzr7A4vdXgfrEQvHaP/+uvvq+r5J4ZLX9yYAzL4sVQwUuGusU5Ofm/
         7wAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=snSHFcywNjYaU+V8VNJTtf/b2PyC3xXSLz2Yl9hABOc=;
        fh=C/SgfvVKJhyfioHxl1AATrEEoO+/gy5GYawK6Z+0f+8=;
        b=JMsmLRIdbrn8oLIosY3LDtY/x6PECKIqegZ0yjvpwIAH7vxR7Mwg07GIm7jhl9J4Rz
         urlpP1jzbf1dRzvBmGrxXFu+uBlO0kyt9zUEbCn8aCHhWV8aoDsYZNQ4i4qrxORs4812
         d3Dk/71MA8xdp1+JJiAEcpZHz4MTYKUzGCJmJTMVFCoB2QnUuwlllI3/cDB7xkcJhu5a
         0AGV3rD0qplazE7HDVJr2rsxA668fG6au6gEIrB65QvNS3MACC+iv06/EcvPs5Fy8vYI
         UhGd9PiV26AI+FAlWOcp94WiEakgAXHjDupnFZk/9f+jfEK7gQe54Q9BykISuxaoTi3e
         m4og==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794503066; x=1795107866; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=snSHFcywNjYaU+V8VNJTtf/b2PyC3xXSLz2Yl9hABOc=;
        b=SkqdLGv16/JrcSt3jjaH1o/ExnG5UxWD+NbadW5NrJISz6Vl30xrDORks1QiELAS7y
         2J7Si3Ool4fURMl92CVVwlBYul691Ik5FQRsV1sqA0LpyNXeJ2yTlpjakOKEC6D1Cc6a
         FydcrLoCbInkWXLEPP0g8oe867miegZRvDPXKlGD9F9AINBkVem5tXUOIPmZBDTRXbEL
         DA6wBSQi4zqzyBceaJgFQCn4DcWr+CDIIIHSiTooCgFBohsYHEBEffkROHcU2wpoD/SF
         8Eav0PJwJHsWCsqHp1IlygHFjNmsFp97qpFvHxsbrx4Nc98yeC/ednmldwNyvKU/3v7e
         Pyng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794503066; x=1795107866;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=snSHFcywNjYaU+V8VNJTtf/b2PyC3xXSLz2Yl9hABOc=;
        b=rRqIsW2oeR2wkhw9+/8jpoBUcQrSToq2KZl1FU1ouJTcTTUErud4jmvkBTK4mdl+Zi
         xG58WXrD7Bxn3JMSxFM/TNaGTH1+mLZh2PWwzaNPQxqcLmMJrY6+1fO7ncVjHJMUC5Z+
         YGrISYq1EBGg5WYTSaU7CcMcHeiDnDnwnNcgJwiVlSyqr6ZixYEyJPBxd4HPwDTKeM+H
         YR+rG2lrwf0PqFvN7i/dZUo9TRfWmqqUnZ0NBoVwL9ETwb5r2FsImOooUEKffUt9hku4
         xozh7mmxE7wcofE6J3Y4U6fP1f714SvPlkY076qUmt5qhABE75wFaZix1pJ9NrVQ2Aev
         N2nA==
X-Forwarded-Encrypted: i=1; AL+hErE8G9+uZvA8vBAqJkocc9TPtl7QSB3bnlpXOtcdhtn/So+APdYm/N4WYTStRpuV55kgS/kdWUU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/5Mg6oBWbGkzDKWhAKg5kv9YLoDTy+t3l3YXZoCrrUx682fSjo
	mBU6LnmPyX+qcwm4m72NhKJ3pP9OBdoHl6a9Y6fB1OMt3FSUd3qr8kvrqc1yuyXV1T48Qa6XtgK
	0efanQUeIimScq4VRxf+14P8EQUSmKUHM24TUKmXMym5cvAiAh+fwxm7DkLWQhID3EcQLP9vKO9
	8Pfw5TSYeJMOaU/uYtM3KN53RrLFIJFA0t
X-Gm-Gg: AYBFou1kLbYkNyeOZjcdeI/QhCv+IAZNoJYIMCo7QUzdDZegVa/ssHUkhK8Sk54goHr
	eySNJuX+KEruE79WCSNhg3mwNarbJleir0cTbc3kQ8qiMmts6rA6qBtgzRkE3kM8N7D/W56ccQX
	prBBdMfe57R3KJN8c+jxYzQcBHllqqx7c0qeaEPUMTfBSUnB8jE0G7H4E=
X-Received: by 2002:a05:6214:3d11:b0:91c:79eb:ea55 with SMTP id 6a1803df08f44-91f040c0da4mr105357636d6.28.1794503064159;
        Thu, 12 Nov 2026 09:04:24 -0800 (PST)
X-Received: by 2002:a05:6214:3d11:b0:91c:79eb:ea55 with SMTP id
 6a1803df08f44-91f040c0da4mr105356616d6.28.1794503063345; Thu, 12 Nov 2026
 09:04:23 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 12 Nov 2026 11:04:22 -0600
From: Sergio Lopez Pascual <slp@redhat.com>
In-Reply-To: <DMGNAV67LK3F.2FNLTD5NVHDEA@gmail.com>
References: <20261028-vsock-dgram-support-v1-0-e457cf7cee78@sinrega.org> <DMGNAV67LK3F.2FNLTD5NVHDEA@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Thu, 12 Nov 2026 11:04:22 -0600
X-Gm-Features: AclHuK8-kXlDfbY9EpdjADOfLMjXVcZNZptS66ye_0dxL9--qQit5gRpAYjKWyc
Message-ID: <CAAiTLFVrvmrLoFxAdJ+ObY5trjgKvNJW5im7XaRQ+K1PG-_M-Q@mail.gmail.com>
Subject: Re: [PATCH RFC 0/8] vsock: add datagram support to virtio and vhost
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Bobby Eshleman <bobbyeshleman@meta.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
	Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, bpf@vger.kernel.org, 
	linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

"Alexei Starovoitov" <alexei.starovoitov@gmail.com> writes:

> On Wed, Oct 28, 2026 at 09:04 AM Sergio Lopez <slp@redhat.com> wrote:
>> This series implements SOCK_DGRAM support for virtio-vsock and
>> vhost-vsock, allowing applications to exchange connectionless messages
>> through the existing AF_VSOCK datagram API.
>
> The cover doesn't say who needs it.
>
> Bobby and Amery took the same feature to v6:
> https://lore.kernel.org/all/20240710212555.1617795-1-amery.hung@bytedance.com/
> Stefano said there that it can work well and that the virtio spec change
> is the next step. The last mails of the thread have Amery's v7 WIP and a
> short list of what is left.
> The cover doesn't mention it. The spec change is still missing.
>
> Why not finish v7 instead ?

The previous series is more that two years old, and vsock has changed
significantly since then. I thought this deserved a complete refresh.

I should have linked the old series in the cover, though. I'll do that
in v2.

As for the spec, I asked Stefano and we agreed it'd be better to have a
series that's pretty close to be merged before sending the spec change,
and I agree that's a good idea. In fact, adopting SEQPACKET's strategy
for splitting up packets in the vq would have an impact on the spec.

> This RFC goes the other way in these places:
>
>   what               v6                        this RFC
>   -----------------  ------------------------  ----------------------------
>   (cid, port) space  own bind table for dgram  shared with stream. The 2nd
>                                                bind() gets EADDRINUSE
>   vsk->transport     empty until connect(),    g2h or h2g, picked in
>                      lookup per packet         socket(). -ENODEV with
>                                                vsock_loopback only
>   routing            one helper for stream     2nd copy of the chain in
>                      and dgram                 vsock_assign_transport()
>   recvmsg()          in af_vsock.c,            dgram_dequeue() stays,
>                      no dgram_dequeue()        dgram_payload_len() is new
>   VMCI               fallback                  first. No virtio dgram when
>                                                its module is loaded
>   dgram > RX buffer  drop, EHOSTUNREACH in     every RX buffer is 64K
>                      the error queue
>
>> Datagrams use destination-based routing across guest-to-host,
>> host-to-guest and loopback transports while retaining the socket's
>> transport state. VMCI keeps priority as the dedicated datagram
>
> A dgram socket uses two members of struct virtio_vsock_sock: tx_lock and
> bytes_unsent. They serve SIOCOUTQ only.
> virtio_transport_alloc_skb() does skb_set_owner_w() already.
> udp_ioctl() returns sk_wmem_alloc_get() for SIOCOUTQ.
>
> Without them a dgram socket has no transport state, like in v6.
> Then no need for the owner transport, dgram_transport_match(),
> fallback_transport, tx_accounted, the skb destructor, etc.
>
>> transport.  Guest RX buffers accommodate complete messages when
>> datagrams are negotiated, preserving message boundaries.
>
> That's 64K per RX buffer instead of 4K, for stream and seqpacket too.
> It undoes commit 03a92f036a04 ("vsock/virtio: Resize receive buffers so
> that each SKB fits in a 4K page").
>
> pskb_trim_unique() doesn't reduce skb->truesize. So a datagram of 1 byte
> charges more than 64K to sk_rmem_alloc of the guest socket.
> The default sk_rcvbuf is about 208K on x86-64. The 5th datagram in the
> queue is dropped.

Thanks for the review, I'm putting together a v2 addressing these
concerns.

Cheers,
Sergio.

