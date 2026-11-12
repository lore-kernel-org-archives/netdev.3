Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794493335;
	b=k/KGShj/T/jSbOKwASa7hoIOL81BtYYTzqT19YVvw3Q3mB5tUZ/3C1VTRrCiBJWgBlzy
	 DWgAf7pL0j0fD1XA8vHMVPEl306VLqM87diE8uJAoqCurYzt7Nsho8iK2CXvnEgnUTi2Z
	 jTD2a8aAJ8YR5tC6XBHPLn93tULWBQrfLKVU6db3vWyQ38ErwnfgYzdfqd3kfeyqd0y31
	 cKhYBHAi0/mHSwyZhdVlU79CNxPx/JTjgq6BK4xAZlfYJv3E/LR8Bn5xxal6BCCh1D6RM
	 ALiPKMzpy+IC/Q2k+zc0q+aFlsxQD1jpRynnfY/5bNpCwZ45dZAx/wD4KtJuGGSGtSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493335;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=q5ycgM6KpIgl8GosUfIZQ6wJ8AxoFNABYsI2jhCC9jo=;
	b=F5+2hztMmN8//XY7FP5ygin0EITHDh3TTq3ELLzSkzqjfKL1DsCaMjvzE8u7AGZwnVUj
	 xjvdRi8C9TkmQIRH6WH9s/Lfc+gO3D/VFcJ2oTPNOMlYCfNQlhXJcH2CxSKut9+e9k4Pa
	 8AXXlcuTyG8BMdOjIvS5JTqi1nSgObVXZFTAnnSTTm3/FwvQGAGYeVXDrYAvE0diQ5PcF
	 N6qU0Si80A6DwKqLTCqN1dHTC+SVJVQ7GgLq/NYJppweybF06+PRMwLgXXv6dafMiLj06
	 geVWVLerdzLO22G7C2qjlUblB6P2ujVfSt/4fz5U0kJdp7MXXZJNLIVQlGxJ7TqcfSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XPQ5ehng;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=PqIaq6tp;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EA8606D561
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 14:22:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97EA8606D561
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XPQ5ehng;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=PqIaq6tp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794493333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q5ycgM6KpIgl8GosUfIZQ6wJ8AxoFNABYsI2jhCC9jo=;
	b=XPQ5ehngwUs98qcMvC29CzVPYCf57n6bPjE+GYYGQHNG2EBN0+utuP8cVMhAzN4roc6LYW
	Ha2jvFlyfeASW+LCHEEYTZzwDbsZEX/oLBNjhwJY9KqaBSyGVDYa6K1ZlK83ck6j+jDM73
	pmcVF3e52m3bLNPgrU3e224N627hY2g=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-SfmQyF5CO_axdYpEU04GDg-1; Thu, 12 Nov 2026 09:22:12 -0500
X-MC-Unique: SfmQyF5CO_axdYpEU04GDg-1
X-Mimecast-MFC-AGG-ID: SfmQyF5CO_axdYpEU04GDg_1794493331
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4b2d1eb484aso5399453b6e.2
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 06:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794493331; x=1795098131; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q5ycgM6KpIgl8GosUfIZQ6wJ8AxoFNABYsI2jhCC9jo=;
        b=PqIaq6tpC3qulR4Jy7cYgsLAsKcRKjTfd+W1Zx/p92JVotlZkNLwJOjvEXnB2U/9hh
         aEM4/hvy4HCjf6aatFLi0NjUjD+R9TaMzZlqjQ1pqv8x375HgB/q1ttcZAPJgjPxQAOo
         hLl8KuBqTu/Bm7P/POJMrXnu9OsA1i0ukxm6EuPox763QDa3wzazZOvJV5FJah0tsvOg
         c4DtdIxFVsSeMrHUlrqLjAjVoEshb/woPzb14frNfnJx872mITsv3cqXRRXvyTBImpxh
         IDOVklDCjjyB1NeGDr5os4/s2mwdAQi5BJ+/C5C5IwL4NjDjYF/ZS+dg5ByCiBQjbd+W
         FRDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794493331; x=1795098131;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q5ycgM6KpIgl8GosUfIZQ6wJ8AxoFNABYsI2jhCC9jo=;
        b=Fr/Sqp587uQp6e0O5DEVZSrWK7nozqHDdy316q9kf8LCSOrINoKT6JAd9KnFuG466K
         Z7r1kjQlNfM66Fc3DI2GrkguLT/LFeZnCUPfpWaPzXwNHn7w5G2YcccH6aMIIZDGhXEm
         fs0UWKMoGxYM0uPhWkxEGCgFxYkdKT1e5Ds9IluuL12iStAdhFJnMpoAYTzI0FLF14a0
         cIBaJeEP5nWW8kV9Tc5+T2GfF1K8TbxyC17Cr3wbVlYE0n4Ml3AUhUR1SurzopSSDUZn
         Ra5Q024BfYKZmciJM48PB8g4cOI85vAO9WRzZLMtkkl8sfop956V5B53XlM1r3SObXju
         fkSQ==
X-Forwarded-Encrypted: i=1; AL+hErHPJkigUZuvYc9uEUHywKdW9u+rx561tHBvuGOALmpLC6YYx2dexm7VtPxhmgVlrF8cd5ASmdg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/9GloRkUxW6RhfiP5enfUaaHEtxRkn9mbXzn+8lh2RwO25/w18
	Nw3dBL5WwjVtoGxkLaWRvryG69ulAfI27u2ex2gI1l8fiQB5p4IcNTcY4w8Wp5B0E0KwohWyAZR
	GKuLDp+FRDNtdEW92idkUSKv0UtGaqc3ZTS/DptZNaGi3xHMkLV14vA+ZM3WhYRZAXGfC
X-Gm-Gg: AYBFou0wZKNebuXVtplIiIxvRZebPWcODVehTHGbhrWVJVQCxM/h7U3QOGJKA/SEX+E
	oBQJ8vt34xDD29POmBO3V5DBHlGIPQS7CYzs6yzoypP13pZ/GO/vjz8Be6lyVw5MpUCZPfYGH+o
	8cnWoaexiJNeSLV76nqe8efyl5xoJDrIfkbYU8d4DZQB8dO+f2ID24BocKqwRG9usxdtg53mAvK
	QDHMUU99qAYcpmKMOUs4uKCvX3BuEuPGkC350twnwk+7z31obQpHywpXEHlRHHVp1/QTekpKNrf
	K/ok6T0eGiK+Z0CoXsbY35j6Hu6iFm+tMrTqOWFBH1OtYe4uc8dNRptsMSnx7kkKWXuxzkQui0L
	f1zkk2luILER0YQ0VswavtgHxJY0Ku/euMi5faRv/Qb1ZSTL22kA4
X-Received: by 2002:a05:6808:5198:b0:4f4:9314:af39 with SMTP id 5614622812f47-56b96bd3b81mr4468296b6e.28.1794493330971;
        Thu, 12 Nov 2026 06:22:10 -0800 (PST)
X-Received: by 2002:a05:6808:5198:b0:4f4:9314:af39 with SMTP id 5614622812f47-56b96bd3b81mr4468260b6e.28.1794493329942;
        Thu, 12 Nov 2026 06:22:09 -0800 (PST)
Received: from sgarzare-redhat ([209.52.143.85])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4ae22fbc9c5sm5819481fac.9.2026.11.12.06.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 06:22:09 -0800 (PST)
Date: Thu, 12 Nov 2026 15:21:53 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Oleg Drokin <green@linuxhacker.ru>
Cc: stefanha@redhat.com, mst@redhat.com, jasowangio@gmail.com, 
	eperezma@redhat.com, xuanzhuo@linux.alibaba.com, bobbyeshleman@meta.com, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 1/3] vhost/vsock: release the accounting of
 packets dropped on rx errors
Message-ID: <avXG51ibBiap9tG9@sgarzare-redhat>
References: <20261106050244.602625-1-green@linuxhacker.ru>
 <20261106050244.602625-2-green@linuxhacker.ru>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261106050244.602625-2-green@linuxhacker.ru>

On Fri, Nov 06, 2026 at 12:02:42AM -0500, Oleg Drokin wrote:
>When vhost_transport_do_send_pkt() fails to deliver a packet to the guest
>(unexpected output buffers, a buffer smaller than the header, a fault
>while copying the header or the payload) it frees the skb with
>kfree_skb() and gives up. The success path does more:
>virtio_transport_consume_skb_sent() subtracts the payload from the
>socket's bytes_unsent (SIOCOUTQ), and for a reply the queued_replies
>counter is decremented, restarting the guest's tx queue once it drops
>below the ring size.
>
>The error paths skip both. Every such drop leaves SIOCOUTQ too high for
>the life of the socket, and every dropped reply permanently takes one
>slot of the queued_replies budget, so that after a ring's worth of them
>vhost stops processing the guest's tx queue for good.
>
>Release both on the error paths, as the success path does.
>
>Found by an LLM-assisted security review of vhost-vsock, done while
>porting a project from Xen to KVM. These error paths were not
>reproduced: they need a guest that posts malformed rx buffers.
>
>Fixes: 433fc58e6bf2 ("VSOCK: Introduce vhost_vsock.ko")
>Fixes: e6ab45005772 ("vsock/virtio: add SIOCOUTQ support for all virtio based transports")

Why this Fixes tag?

>Signed-off-by: Oleg Drokin <green@linuxhacker.ru>
>---
> drivers/vhost/vsock.c | 23 +++++++++++++++++++----
> 1 file changed, 19 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 88a310390eb0..b0004cb48999 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -104,6 +104,21 @@ static bool vhost_transport_has_remote_cid(struct 
>vsock_sock *vsk, u32 cid)
> 	return found;
> }
>
>+/* Undo the send accounting of an undelivered skb; true if tx may restart. */
>+static bool vhost_vsock_drop_skb(struct vhost_vsock *vsock, struct sk_buff *skb)
>+{
>+	bool restart_tx = false;
>+
>+	if (virtio_vsock_skb_reply(skb)) {
>+		int val = atomic_dec_return(&vsock->queued_replies);
>+
>+		restart_tx = val + 1 == vsock->vqs[VSOCK_VQ_TX].num;

Can we add a comment to explain this check?

>+	}

nit: try to follow the style, e.g. leave a blank line here.

>+	virtio_transport_consume_skb_sent(skb, false);

mmm, this entire function is very similar to the code we have in 
vhost_transport_do_send_pkt() where we also call 
virtio_transport_consume_skb_sent() but with consume=true.

What about renaming this entire function to vhost_vsock_release_skb(), 
adding a new `delivered` parameter to be passed to 
virtio_transport_consume_skb_sent() (and to be used to call or not 
kfree_skb()) ?

Thanks,
Stefano

>+	kfree_skb(skb);
>+	return restart_tx;
>+}
>+
> static void
> vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
> 			    struct vhost_virtqueue *vq)
>@@ -162,14 +177,14 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
> 		}
>
> 		if (out) {
>-			kfree_skb(skb);
>+			restart_tx |= vhost_vsock_drop_skb(vsock, skb);
> 			vq_err(vq, "Expected 0 output buffers, got %u\n", out);
> 			break;
> 		}
>
> 		iov_len = iov_length(&vq->iov[out], in);
> 		if (iov_len < sizeof(*hdr)) {
>-			kfree_skb(skb);
>+			restart_tx |= vhost_vsock_drop_skb(vsock, skb);
> 			vq_err(vq, "Buffer len [%zu] too small\n", iov_len);
> 			break;
> 		}
>@@ -212,7 +227,7 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
>
> 		nbytes = copy_to_iter(hdr, sizeof(*hdr), &iov_iter);
> 		if (nbytes != sizeof(*hdr)) {
>-			kfree_skb(skb);
>+			restart_tx |= vhost_vsock_drop_skb(vsock, skb);
> 			vq_err(vq, "Faulted on copying pkt hdr\n");
> 			break;
> 		}
>@@ -221,7 +236,7 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
> 					   offset,
> 					   &iov_iter,
> 					   payload_len)) {
>-			kfree_skb(skb);
>+			restart_tx |= vhost_vsock_drop_skb(vsock, skb);
> 			vq_err(vq, "Faulted on copying pkt buf\n");
> 			break;
> 		}
>-- 
>2.56.0
>

