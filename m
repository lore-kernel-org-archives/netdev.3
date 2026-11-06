Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793968174;
	b=FJ+1TAsQRrNvp8M6k6/rDPG42fhhl5Hf6gwdHuYeUApA7U+3myCBtUM7uOsEkc9U8XBx
	 i+y1XTtfXVSTGcVxaq9KGt/yO3q/6k0elgTvo4df/K0Vs/wpdfuVXak1xmjSNBMm7cq53
	 yNtoZdffKLB88mMv3kQGK9zJHJwcdSUyLZM1WEp2nUKlmViE35BwVHRFPXBhmUBvL/iYz
	 OJ3NFIdxlDBMbrJmPhTQlMORtEm/cZDb3gwOMW91wDa7vCPdsUj5QdvGQ7/TzDd8p2sxk
	 r5E9JVFH2VbPxfbh40y8fW+vElPj0JfykdryHkzs/o3PIPXDz9Agj7auKe/a/WPlTpw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793968174;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=gH1mJSj/kyZPh+4tLVnw5BdMCKvmnBAyYQhJaAhQgzo=;
	b=JsrdjFTgVqnOO+bkz+iSJnvEpBxyxGKhAyHPlyjfLmnSRUvfQMM6VLUijJh7Vg1EYhvp
	 Y0J7CgvDLjxwD/zYFfg3jFdM2j2k53O0DirBFEAlUbBSLUX8+kh94MZN/AQg1zboa8Hnb
	 LxyfQ1MQRpSbvJeKjn+8TJuRRmTca/jr/AwYFC/F4opeDbLQ4Hw7sMlhEz7oHILVubXuk
	 id6FgNeJeQ/h/9cjCEwUG4HMcbKARCVZsP7aHhqTNSyKzmxO0PJm2C7fZvEIaigVf/YaE
	 FMLYBWgVD7iOnlEq+YVcHv92TfmuwwaZcCo1k6TfyLsJ1kck5j3gVh9iAjTgq0m7ZOA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="CmPnMt/+";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.178
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA193606A32D
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 12:29:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA193606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CmPnMt/+
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-93f3c89594cso48418685a.2
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 04:29:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793968173; cv=none;
        d=google.com; s=arc-20260327;
        b=n3dfjPdbHIBkmJDyn4PVdK25oovT0WqC/YVkLxA8iR0HbPvJWkY98hikOJ08Qbf1qP
         EM2chQ8fjZaJ/mirpz8ZT0unI1w7r8FhaRlRXRvPoePK15ZRM5/zPNwZBQdBEQZZou2B
         b7xYMwxTpE4qQGSj5mSWP1dwkz+aW/ppPGSD3I6tpROGWyDlfEIK6VR+SWRU4tGJyQDv
         wRf9ODLC7DjyrpYrE0ugnEiG1FiLjw1re7+q953Fadk+cqIZeCWnlF0M9irg5yDbQDVL
         PE+vEs1sUzs+flvt0ZdEngdcvlr/6u2Xz9eNOToGRbSra9I3hPXLRKD9ECGiY1PbVc5X
         425w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gH1mJSj/kyZPh+4tLVnw5BdMCKvmnBAyYQhJaAhQgzo=;
        fh=XY+sD7fp4fw3esEsbX9seo8tgAGOI4Kx7T5wgXgY8NU=;
        b=VShSWKvV06xRwAjMvCuY43iUldpZx0we0Gyk2ryhhrKt3lW+U4YYdafUiwzaO5fj0h
         8VKeyc7qElJZa/3O5Q92NoXYFxhpM480fIdW8wlHcfwdAZeXlw6lJws/c/KOb882yIJe
         tz2luFUxBKeu9/iRbCCd5KkmJxJ/iM5eRSeizpQOnRLTSonFjsOF+z69/5LVd8DR0+bX
         SEx4+4kBgEw5YahT6JqzzWECAZQNMHUZ2xVxJsTqYFz7nhHYdknsNxlBYWlbyOf2iRG9
         B7XJztKfg8YSsN8YHmNk/kAmpQQl7D4ysyOHHmembc0ZpEInp0LhMTbMfyGYio+P2BW/
         pwSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793968173; x=1794572973; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gH1mJSj/kyZPh+4tLVnw5BdMCKvmnBAyYQhJaAhQgzo=;
        b=CmPnMt/+L+pcGEx8o8xV4PJnt+gAVP8+SO9XVfHNPDIU+jEa0+KSEbY/rbEYIk/cZe
         8LFT/xraPsCHng2diNi8SAQlnIKziq4K/t83l+1XhI4ryTqfau9iGgEDpkAacevs5Kyt
         JANBZDjyqPaRCYZVCf1nENMjltlVE73FT5fiTFqZ+iVJOwWBCns2AOmpa0a41ssSnNWa
         hYWe+TBpi7oputXl9AqwchOWtqMheb1lyOSrLxebE7d66+Ad568H6MfM5tKWWsJWwmsR
         ixeYLc0MbyP/0IvMwD3y0yHHULVOmVwMGd6bD/q6RP88BlgX84USg4mvQrwxQCJy/FZM
         EvKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793968173; x=1794572973;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gH1mJSj/kyZPh+4tLVnw5BdMCKvmnBAyYQhJaAhQgzo=;
        b=r69eOoPasy14vFxzE86CYeIDQDvaf26Hd88cUKm9BN+WwNtH1PSoa1Jt2QOb/WvFV9
         mAThoRafVMJ2ZF1eBzX+D0lgbxPI0lnwRI3U3W8AFK+roVn4mZZsgdEMYJDt/pYkNRTY
         bRdQc12ZrsJ//toW1gZjmshy+ekDPznz9LxXAhOSXAbhyl4CXnmU2PAfTu45NLcGwHwR
         wMI2kARN/PIMbrhCcg4ozKfYv9E0TJFHBN4my09XEtcb4Hm6QMfhAqQOkfMkUrUtFSSJ
         4H/GZAzn+9eN9jHQJ2OKVeu5h+IZd3Ulfm7HVju+4KXzTBa3s/lg/+irHaA8EzCOYfrp
         aU4Q==
X-Gm-Message-State: APuU4Z/r2XwRk7klv1LpvMvojrkqyvjrKwAGufaqTTfrCDTkp/to4MUY
	UqIAWrm9vWTucZUOGFrcnubriEQ+jdMTWG3Oz99VK3fCOE/g8bq+7r0Nnt30D6dVfrCqtxh9qG9
	7UXKPy94sYv94XlylTKjZ/qWnawAi378=
X-Gm-Gg: AYBFou3c4otNXgX0HkFJMsZy/O6aN7MEs3H3TiMqmhSAAJ6k+LBTGa1CX82nMg4xAD1
	TpjAEHNPIAcJ1F+SMb1LPaSn4kJkql3553aPhYLp3nbJ+J5IbBmGT3/xX19PHut3jK1dvCci0fN
	jnI+FhKjXupx3LWLoGnV1mWYjG1cv68lCa8+I+rzqlztfVeYVJCpI4da5qJM42VVobeAkMboH2b
	GC6wqWivRFJa7x8o/sNr7HH1j3573Dfb8Ga6Aaa2daAR7ydFz5eUeziXTkFQG6Sa1K7WnXr6pMM
	5L+tkDjEXUDMa9Wh0BmR+eOPxFIiSe5idE7eajEXoXJxtVXMdh9ihcR4u7PECYI1qp8O1GDBhUh
	CQUULcYoLAtvKwW29KJmGz280JfI8Uq+TxFuYsisc6gA+yn2AatY7YYAwPCOzRUufCHF+GZ8=
X-Received: by 2002:a05:620a:2794:b0:945:f28f:ce92 with SMTP id
 af79cd13be357-945f34b9241mr264204285a.40.1793968171614; Fri, 06 Nov 2026
 04:29:31 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103041134.33310-1-physicalmtea@gmail.com>
 <20261103041134.33310-3-physicalmtea@gmail.com> <auxFXGVwY5IxlP5L@sgarzare-redhat>
In-Reply-To: <auxFXGVwY5IxlP5L@sgarzare-redhat>
From: Jia Jia <physicalmtea@gmail.com>
Date: Fri, 6 Nov 2026 20:28:55 +0800
X-Gm-Features: AclHuK8WSWZqF0YhOcKmUqT_DW8bT4U1CLlE79rQgfWA3WujjgxC2J69k28qsgw
Message-ID: <CAJwVaMLa2kNAtQvJkE-2aVX7M=pA4eNOTTHeixdZ919DbKu5Nw@mail.gmail.com>
Subject: Re: [PATCH net-next v5 2/5] vsock/virtio: factor RX skb metadata
 budget check
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, stefanha@redhat.com, bobbyeshleman@gmail.com, 
	mst@redhat.com, jasowangio@gmail.com, eperezma@redhat.com, 
	xuanzhuo@linux.alibaba.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> On Tue, Nov 03, 2026 at 12:11:31PM +0800, Jia Jia wrote:
> >Extract the skb metadata budget check from virtio_transport_inc_rx_pkt()
> >into virtio_transport_rx_buf_full().
> >
> >The helper retains the existing condition and will be reused by a
> >following RX batching change.
> >
> >Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> >---
> > net/vmw_vsock/virtio_transport_common.c | 12 +++++++++---
> > 1 file changed, 9 insertions(+), 3 deletions(-)
> >
> >diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> >index 43325d7aebbb1..2a9cfed085515 100644
> >--- a/net/vmw_vsock/virtio_transport_common.c
> >+++ b/net/vmw_vsock/virtio_transport_common.c
> >@@ -576,11 +576,17 @@ virtio_transport_collapse_rx_queue(struct virtio_vsock_sock *vvs,
> >       skb_queue_splice(&new_queue, &vvs->rx_queue);
> > }
> >
> >-static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
> >-                                      u32 len)
> >+static bool
> >+virtio_transport_rx_buf_full(struct virtio_vsock_sock *vvs)
> > {
> >       u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
> >
> >+      return skb_overhead > vvs->buf_alloc;
> >+}
>
> As I pointed out in patch 3, I'm not sure we need this.
> After we introduced the collapse, SOCK_STREAM should collapse rx_queue
> before hitting this, so not sure we really need this function.
>
> Thanks,
> Stefano
>

This patch only factors out the existing metadata check from
virtio_transport_inc_rx_pkt() into virtio_transport_rx_buf_full() so
can_continue() in patch 3 can reuse it.

virtio_transport_recv_enqueue() attempts collapse when the queue is
already at this limit, and then inc_rx_pkt() runs the check again.
Collapse may not free enough slots: some skbs cannot be merged, and
allocation of a replacement skb can fail. As explained in the patch 3
reply, when virtio_transport_rx_buf_full() is true before the packet is
handled, the caller releases the socket lock. A waiting reader then has
a chance to drain before that packet reaches
virtio_transport_recv_enqueue().

> >+
> >+static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
> >+                                      u32 len)
> >+{
> >       /* Allow at most buf_alloc * 2 total budget (payload + overhead),
> >        * similar to how SO_RCVBUF is doubled to reserve space for sk_buff
> >        * metadata. Check payload against buf_alloc to be sure the other
> >@@ -588,7 +594,7 @@ static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
> >        * queue growth.
> >        */
> >       if ((u64)vvs->buf_used + len > vvs->buf_alloc ||
> >-          skb_overhead > vvs->buf_alloc)
> >+          virtio_transport_rx_buf_full(vvs))
> >               return false;
> >
> >       vvs->rx_bytes += len;
> >--
> >2.53.0
> >
>
