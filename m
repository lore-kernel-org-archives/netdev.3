Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A77513556
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 14:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792419135; cv=none; b=anG5F7vkBSFyijDHgzeg6xq2EFqFFYRIOGktlHoD+jh5+akrb3fO1UxcivRn7UgQs6UDRk92YT0tWXgsioXS4MhH3RoLneYKig22dag5sgdYaJIbhDJCAp9jRk7szJTsUNCb1bhOpYePRKlSOX0lZdFNAE7920UKj2d2P4uGaOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792419135; c=relaxed/simple;
	bh=38h+2Yebx/4frhJrkasMSHfDfWCWtifqCUTxn5bBarU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qPHMElFEa5/tMiTk4Xj5NNa7epocjbcRvF1CDex8fY2W/9//b9yo3VAUoUt78coguywIa6DFuBj4KMS34Z3omx/eZDAe018hr5Nr2V+MRdCf+zjZYk4Rut8pNwG6gOWu/W601J7O4bp3LjPu99BW9N/gaeFFbFLkuQS51tcafw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cAnfCk/W; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AUEfQbJL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cAnfCk/W";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="AUEfQbJL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792419133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2M95tyOOQgifHQf5+1v9W4pLBHiwR5Qq/5/JuiYMWjk=;
	b=cAnfCk/WG7qZbHvHfnKc/bjRj/fc/RgCyXb3lfxVtJRR2Ra1crRmpgyzikifkG6AeVriX8
	O+0jEp2BhtdV0Fr7hbCho2Ua3FwLF6sjRWmKJUqCh4kLRymLusIrVUJ252woZnwgLRkWZV
	P8FfJJoA+MRc33LQbQxYnShxB1FqTLg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-43GM6EH-MYS8fgA8Hb1d_Q-1; Mon, 19 Oct 2026 14:12:06 +0000
X-MC-Unique: 43GM6EH-MYS8fgA8Hb1d_Q-1
X-Mimecast-MFC-AGG-ID: 43GM6EH-MYS8fgA8Hb1d_Q_1792419125
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48b027578a4so1986995f8f.3
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 07:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792419125; x=1793023925; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2M95tyOOQgifHQf5+1v9W4pLBHiwR5Qq/5/JuiYMWjk=;
        b=AUEfQbJLtk2cx5MAZMdh5bk0WAekC52HsJA5cxj9sHprTtfI4aPvyT+bUsidTG8Mnn
         k4bpTHV8xdYUigWdLoRF5aB7WR4o0IrUV7Qjc1A4xQs+owr9i682l9ZI7ukHskqAcSsH
         MEVlrUriTwIyoHccJjG6uhXqrU/1JMnfaNZchrVtcvdngq7J4huU7xK0g0zOKJgtbD0F
         RKuiPo1u75wIAdX1I2IplolRNyP41dsfEIWN/2lx/8RJKEphkByc90PHpmzXpZe9tYsS
         u+JwvDH6XlxO6sDSgldljuLkyMNITcjWWYTIIbhCDbJm84N6ApPypPaQ+pwjL1+jSkMl
         jABQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792419125; x=1793023925;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2M95tyOOQgifHQf5+1v9W4pLBHiwR5Qq/5/JuiYMWjk=;
        b=bA07ITYGravnIu+vykxCFr6OKxyLQNkwIhaTsPOxQ6DyzYTzDivC0ljVFJHqonGa0y
         hUOGWE/pOv6zyt8GQk6dZwoFVEKodIxQzsxzkRcUOE2TFbUxUzEwOsM+ToDLTL+a73fX
         H5ErH+Lh0LYJLGxPqyCMg7srxpytUcDK3URiYdgyGYBarRq7sCTDHFD1kAkEVpRi91VZ
         fsc475w568aogeAxfbFWzi4AsOP1zKF3ghFHT2eSknYm29DOxSR/Hoa+SOA420Efz3fl
         fwgvv0li5EpwNr6xUiFMS/ccZRg/K9Kcl3dda84/sTVlyH+UZt2OxJM0T7hZjSwr4Fdk
         +mZg==
X-Forwarded-Encrypted: i=1; AKwUvBzPRRqi3pz+7Ij26B4bV6p3ThO6BFLpmV17faDExVRmrHPKHipcn2BC/IGvQLNEp/Rp14hwlnk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKcEcPOhVj0V91XzWvXLZaC7EtV2Etls1YcF4kJyY7YY+iYmqlP
	upqoqhBu9upg6Jx3sB/hcgsTumnNfMGPFgIVxh61Nb6r6kdxJsOG7t8KFbSqDXOxdPK0KBL8uWP
	nJLRmUREh+Z602gPaUrqTb2PkV3IASTV4o4LGMORSMfVESvrKUp7W6xyaDA==
X-Gm-Gg: AYBFou109lXqfAXQKJkCMoqqwN+Yxq41AOq+FaVkKCqjz8GUYl17/fEORGnf0lyBVaz
	QvpUAxa+leF81dGh9yu+EoDN/lrrSNW7T/G4y2fJn1WWrjelCJT2ulqKBHa/HzAONhhN5+cUupo
	Q8/hnsODOtPnxZpQ7bzhBSf7xluzYIIeBz45Xf3SRqRiUlv3vW1gmduj8YO1THuUHYh3X2vsTgS
	qLMudHpImYEPL2y5HlpdajAPgazbwcLXtP8d+XHNzHxocVdkJwAeTR2ksJ/FhSfJGfGigQIVOiW
	rJaAswx3EnhStS4+ScoKKA8gM1vRl+oapQab6U41CJCLHfcV0Gts74v4Q61x81gqRdb7yXdkYHx
	/Edl/
X-Received: by 2002:a5d:534f:0:b0:486:e707:42eb with SMTP id ffacd0b85a97d-48e07f9a00emr12076080f8f.33.1792419124945;
        Mon, 19 Oct 2026 07:12:04 -0700 (PDT)
X-Received: by 2002:a5d:534f:0:b0:486:e707:42eb with SMTP id ffacd0b85a97d-48e07f9a00emr12076004f8f.33.1792419124225;
        Mon, 19 Oct 2026 07:12:04 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.74.151])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd471a72sm25288394f8f.4.2026.10.19.07.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 07:12:03 -0700 (PDT)
Date: Mon, 19 Oct 2026 16:11:57 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: stefanha@redhat.com, mst@redhat.com, jasowangio@gmail.com, 
	eperezma@redhat.com, xuanzhuo@linux.alibaba.com, davem@davemloft.net, 
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bobbyeshleman@gmail.com
Subject: Re: [PATCH net-next v4 4/4] vsock/virtio: defer RX notifications
 until batch unlock
Message-ID: <atYlFHcjGMFxHCuM@sgarzare-redhat>
References: <20261014115640.184286-1-physicalmtea@gmail.com>
 <20261014115640.184286-5-physicalmtea@gmail.com>
 <atI3neoHXhgiEpYJ@sgarzare-redhat>
 <CAJwVaMLmMf1iyWmoZMAJuS2551DsSWSkcRsUVz3M5xi9AXWsWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAJwVaMLmMf1iyWmoZMAJuS2551DsSWSkcRsUVz3M5xi9AXWsWg@mail.gmail.com>

On Sun, Oct 18, 2026 at 12:55:35PM +0800, Jia Jia wrote:
>>
>> On Wed, Oct 14, 2026 at 07:56:40PM +0800, Jia Jia wrote:
>> >An RX batch can make a socket readable while the worker still holds its
>> >socket lock. Waking a blocking reader then only moves it to waiting for
>> >the same lock.
>> >
>> >Record the existing low-watermark condition and notify once after
>> >release_sock(). Move the coalesced write-space notification after the
>> >unlock as well, since both callbacks wake sk_sleep(sk). Deliver
>> >write-space before data-ready and keep the lookup reference until both
>> >callbacks complete.
>> >
>> >As with write-space, save the initial sk_data_ready callback and batch only
>> >while both saved callbacks remain installed. Sockets with replaced
>> >callbacks retain their per-packet behavior.
>> >
>> >The existing psock-marker check also covers a concurrent sockmap attach:
>> >at most the already admitted packet completes on the native path, and the
>> >next packet ends the batch.
>> >
>> >Signed-off-by: Jia Jia <physicalmtea@gmail.com>
>> >---
>> > include/linux/virtio_vsock.h            |  1 +
>> > include/net/af_vsock.h                  |  5 ++--
>> > net/vmw_vsock/af_vsock.c                |  1 +
>> > net/vmw_vsock/virtio_transport_common.c | 35 ++++++++++++++++++-------
>> > 4 files changed, 31 insertions(+), 11 deletions(-)
>> >
>> >diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>> >index bf077ee0ded88..f1396ca3ad9b5 100644
>> >--- a/include/linux/virtio_vsock.h
>> >+++ b/include/linux/virtio_vsock.h
>> >@@ -288,6 +288,7 @@ struct virtio_transport_rx_batch {
>> >       unsigned int pkts;
>> >       size_t bytes;
>> >       bool write_space_pending;
>> >+      bool data_ready_pending;
>> > };
>> >
>> > void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
>> >diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>> >index 9a40960d10cbe..78bab5820f528 100644
>> >--- a/include/net/af_vsock.h
>> >+++ b/include/net/af_vsock.h
>> >@@ -64,9 +64,10 @@ struct vsock_sock {
>> >       bool sent_request;
>> >       bool ignore_connecting_rst;
>> >       /*
>> >-       * Initial callback, used to identify replacements and deliver deferred
>> >-       * write-space notifications.
>> >+       * Initial callbacks, used to identify replacements and deliver deferred
>> >+       * notifications.
>> >        */
>> >+      void (*default_data_ready)(struct sock *sk);
>> >       void (*default_write_space)(struct sock *sk);
>> >
>> >       /* Protected by lock_sock(sk) */
>> >diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>> >index fe7f49da6c4bc..f40659ec29df0 100644
>> >--- a/net/vmw_vsock/af_vsock.c
>> >+++ b/net/vmw_vsock/af_vsock.c
>> >@@ -958,6 +958,7 @@ static struct sock *__vsock_create(struct net *net,
>> >               sk->sk_type = type;
>> >
>> >       vsk = vsock_sk(sk);
>> >+      vsk->default_data_ready = sk->sk_data_ready;
>> >       vsk->default_write_space = sk->sk_write_space;
>> >       vsock_addr_init(&vsk->local_addr, VMADDR_CID_ANY, VMADDR_PORT_ANY);
>> >       vsock_addr_init(&vsk->remote_addr, VMADDR_CID_ANY, VMADDR_PORT_ANY);
>> >diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>> >index f4b5f0230493e..8b62b789b71c5 100644
>> >--- a/net/vmw_vsock/virtio_transport_common.c
>> >+++ b/net/vmw_vsock/virtio_transport_common.c
>> >@@ -1588,7 +1588,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
>> >
>> > static int
>> > virtio_transport_recv_connected(struct sock *sk,
>> >-                              struct sk_buff *skb)
>> >+                              struct sk_buff *skb,
>> >+                              bool *data_ready_pending)
>> > {
>> >       struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
>> >       struct vsock_sock *vsk = vsock_sk(sk);
>> >@@ -1607,7 +1608,13 @@ virtio_transport_recv_connected(struct sock *sk,
>> >                       vsock_remove_sock(vsk);
>> >                       break;
>> >               }
>> >-              vsock_data_ready(sk);
>> >+              if (!data_ready_pending) {
>> >+                      vsock_data_ready(sk);
>> >+              } else if (!*data_ready_pending &&
>> >+                         (vsock_stream_has_data(vsk) >= sk->sk_rcvlowat ||
>> >+                          sock_flag(sk, SOCK_DONE))) {
>> >+                      *data_ready_pending = true;
>> >+              }
>> >               return err;
>> >       case VIRTIO_VSOCK_OP_CREDIT_REQUEST:
>> >               virtio_transport_send_credit_update(vsk);
>> >@@ -1820,6 +1827,7 @@ virtio_transport_recv_pkt_batchable(struct virtio_transport *t,
>> >       return sk->sk_state == TCP_ESTABLISHED &&
>> >              sk->sk_type == SOCK_STREAM &&
>> >              READ_ONCE(sk->sk_prot) == sk->sk_prot_creator &&
>> >+             READ_ONCE(sk->sk_data_ready) == vsk->default_data_ready &&
>> >              READ_ONCE(sk->sk_write_space) == vsk->default_write_space &&
>> >              !sock_flag(sk, SOCK_DONE) &&
>> >              vsk->transport == &t->transport &&
>> >@@ -1830,8 +1838,9 @@ virtio_transport_recv_pkt_batchable(struct virtio_transport *t,
>> > /*
>> >  * The caller holds sk's socket lock.  Set @batchable if the socket can remain
>> >  * locked for another ordinary STREAM/RW packet.  When @batch is non-NULL,
>> >- * record a default write-space notification for batch finish instead of
>> >- * delivering it immediately.  Return true if the caller must free @skb.
>> >+ * record default write-space and data-ready notifications for batch finish
>> >+ * instead of delivering them immediately.  Return true if the caller must
>> >+ * free @skb.
>> >  */
>> > static bool
>> > virtio_transport_recv_pkt_locked(struct virtio_transport *t,
>> >@@ -1883,7 +1892,9 @@ virtio_transport_recv_pkt_locked(struct virtio_transport *t,
>> >               kfree_skb(skb);
>> >               break;
>> >       case TCP_ESTABLISHED:
>> >-              virtio_transport_recv_connected(sk, skb);
>> >+              virtio_transport_recv_connected(sk, skb,
>> >+                                              batch ?
>> >+                                              &batch->data_ready_pending : NULL);
>> >               break;
>> >       case TCP_CLOSING:
>> >               virtio_transport_recv_disconnecting(sk, skb);
>> >@@ -1957,27 +1968,33 @@ EXPORT_SYMBOL_GPL(virtio_transport_recv_pkt);
>> > /*
>> >  * Finish the RX batch.
>> >  * For a non-empty batch, the caller holds the socket lock acquired with
>> >- * lock_sock(). Deliver any deferred write-space notification while the lock
>> >- * is held, then release the lock and the batch's lookup reference.
>> >- * An empty batch is a no-op.
>> >+ * lock_sock(). Release the lock, deliver any deferred write-space and
>> >+ * data-ready notifications in that order, then drop the batch's lookup
>> >+ * reference. An empty batch is a no-op.
>> >  */
>> > void virtio_transport_rx_batch_finish(struct virtio_transport_rx_batch *batch)
>> > {
>> >       bool write_space_pending = batch->write_space_pending;
>> >+      bool data_ready_pending = batch->data_ready_pending;
>> >       struct sock *sk = batch->sk;
>> >
>> >       batch->sk = NULL;
>> >       batch->pkts = 0;
>> >       batch->bytes = 0;
>> >       batch->write_space_pending = false;
>> >+      batch->data_ready_pending = false;
>> >
>> >       if (!sk)
>> >               return;
>> >
>> >+      release_sock(sk);
>> >+
>>
>> Why in the previous patch we release the socket after calling
>> default_write_space() and now we are moving before?
>>
>
>My intention was to keep the two behavioral changes separately
>testable. Patch 3 is a complete intermediate state: it coalesces
>repeated sk_write_space()
>notifications while preserving the existing under-lock callback
>context. Patch 4 then adds data-ready coalescing and moves both
>deferred notifications
>after release_sock(). Patch 4 therefore builds on Patch 3 rather than fixing it.

Okay, I see, makes sense, please make it clear in the commit 
description.

Thanks,
Stefano

>
>> >       if (write_space_pending)
>> >               vsock_sk(sk)->default_write_space(sk);
>> >
>> >-      release_sock(sk);
>> >+      if (data_ready_pending)
>> >+              vsock_sk(sk)->default_data_ready(sk);
>> >+
>> >       sock_put(sk);
>> > }
>> > EXPORT_SYMBOL_GPL(virtio_transport_rx_batch_finish);
>> >--
>> >2.53.0
>> >
>>
>

