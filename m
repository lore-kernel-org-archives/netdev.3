Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793871542;
	b=drgCN0/npVMX+ciJBikROfmWL+37UdMSJkkL+TJg7ZB3yAFm998glTCMXR/b+eeFWO4L
	 4MuRWtOAR5bRYCFGExQPYPsYOzdycodYYLbOtE2KBiCqF1rgB+7v5s1aMFgdKKoe3MXvJ
	 ymrbYZMIga3hJ5lsasjaS7DGGTBl4asMWcmoeoNBEmIOKGbT2+1yGue2+9/H31/qSAjZ1
	 mtUuygMyxd4dtQIvYkJ5qG/el+tzzyJ2LSpjktVcHzdzdF4cIv9PNf1jiGBErrsT6e157
	 bqvnXFxB0Urh6Gq1OjKyFue217Bnq+j5XHM82JpNrJxyERr3wysytd7H4f3RkfKH7Hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793871542;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=6sn1f1jWORyKv3besFYbn1oXeFyI4WIIT1pdKGKky2g=;
	b=ezLduWu3sSadNbJlcU//VAe9QXR3F+xDYExRgELcEctSfmboF5O/AO1vitMMbhtzr5hE
	 mDK41LwIBrGgggPSd1XOc5nvlVhkADo7IBXui4a31cb4L3qxblxwhkiaV2/cdXZABkZYk
	 wOqu9AYfX1lTN66bynqdgqWxSr4gOh21BSzbxUabW3BTDPrt659IUtl8TV/Dk/nhfiHeU
	 mtp6CyIU4+cqm4+/PGQRW8aI66nfQYyraIo7uiNnKSxUlxQFT8KHIWm8edgfGQf/EYK/m
	 WxeqfRB2intYUn9pqvQwkb/uCRfcBYbmzcRVRM4S9GdFgBmSN8qoa1bvJd1JBDRq8LQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MXffKtf9;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=gdP7Ftpk;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D211606A32C
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 09:39:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D211606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MXffKtf9;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=gdP7Ftpk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793871540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6sn1f1jWORyKv3besFYbn1oXeFyI4WIIT1pdKGKky2g=;
	b=MXffKtf9cJoRSCUSmhLavm9aXn7pKVxTtmDbW4efVNGZAxWf+TuFZHnIUOWas60CnVKBK/
	3yO+sO8zyf2bkidCtlsG4Ygju9r/8f1QIHzvjdxLVCOZgG0bViGimwD0sNMzEtXPiJHaAy
	d5L+XEC/PL94mdf5lGs4BQ1vooBN9cU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-GnIvpdVFOkSa_N_nryyvmQ-1; Thu, 05 Nov 2026 04:38:59 -0500
X-MC-Unique: GnIvpdVFOkSa_N_nryyvmQ-1
X-Mimecast-MFC-AGG-ID: GnIvpdVFOkSa_N_nryyvmQ_1793871538
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a9d51dc486so3013815e9.1
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 01:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793871538; x=1794476338; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6sn1f1jWORyKv3besFYbn1oXeFyI4WIIT1pdKGKky2g=;
        b=gdP7Ftpkfdd25RqpgPauAyyQay/b6EAcllvZ8cRvrNOSdPHUqBMMMEYF6CvHWakYWy
         AaCqfStc/JQXqjeQAs5zXxIRPAJyTpj1F+8L8Gt4O1rjM+nS8FbfajYLYJL+WSnhlHMT
         KnmMbPCPNdhYQz//Tweh83XDmDAxcnKnzL7TgE6ImR1544RJwH9/F25yEyUDe5F/1NIE
         Fv1FDyra97C5kI6N5wKoTBo7DFeKts4JEtUlT3uecW7ItfQRvUsfy8pEjGkSn30/SQU4
         9tbSPnp8Zg8ccNoFP66NCAJ3C2nUNfCwfZxpZVWKrDGSopnMRcb7Ca0cC28W9JlmIVtA
         4p4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793871538; x=1794476338;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6sn1f1jWORyKv3besFYbn1oXeFyI4WIIT1pdKGKky2g=;
        b=RfbdKCHjn/IfopgqNSs+BxtCFxS114l67xftR1Irfm2/ead13tlK7wGNsV9aaaNajh
         Q6B8Dfelp/Gn3aNvymN4qS1xsG0noy03s1S+hpMXmzcv4vF34wrhTMKX4didP30yTE3H
         up1XQFYlJ4P1mjDFPNc6MHgrrkC5aq6wLtZ2NzqczrMRQN8hUbeT8+saSJWXtI0n6Awm
         zgC0aARhSI+kzd+cC596MloO52X+cUjAzSnc/q84WFzhNnS0t7nhTeFJaPKev/FpGLS5
         M0zbJpFg/V/eZJxI44Tgm8K5GxKsicT1sX3vNS8O73eIUiiaeoWnXYq7oyw4YzuQOrcf
         Y0gQ==
X-Gm-Message-State: APuU4Z/6PZ0++RnRATOMnVktPQ04nV7sQuDWVqPWH72S025hq9DUE9cR
	GI1GyyB0f0KPsOr6uByLQa82YXZoAfoCRy1ok/8axHg+96yHiH7ELfqw2qKq+x9BghE89HMkqeg
	EumuFdWU1onS7KG+5zj96mSl70oqoQxFxIZyJgJ1fVhNdw6wkXiPrgJav3w==
X-Gm-Gg: AYBFou0LTdgKvhQuLWH2DNHoQBL32N87kZ5BkrJ3v2vviMY2atoMZbp3GQxfhET9VQl
	DK2d2Dh61Dp0Rqx0nYxCXVOFfBZHB3C35Z7NAuaHiNH2WhyXRliC3y6L+llUE7wMC38VUKLlze+
	S0nW0Tx1/kJsjJu5Q9scG1dcG5w0ngW63SaA+eHEUERoowjXuN4T77wHT6kdZGCkZ3cI4SB8XRg
	plAd3a4AgQhqrJm/SP7PkKLgSdWn/tQGH6mEC1c9XAAoc7X6Slhc6Dt8yki1HKX15duDGXxGJqm
	X+xA7oRmFssJbh7pMsnah7tZQkGzDPgf7TPZDlUEbvsGywniOV2ehiS4ZsPLJYvLRFvU5Z8C4R6
	rhYPjDsznqlrj/eT/1SFasyCF1Cv/q2rE5cFdOdv04LmA37+Cy6pZ
X-Received: by 2002:a05:600c:1907:b0:4b4:a551:681a with SMTP id 5b1f17b1804b1-4b55c8743d8mr34861695e9.3.1793871537782;
        Thu, 05 Nov 2026 01:38:57 -0800 (PST)
X-Received: by 2002:a05:600c:1907:b0:4b4:a551:681a with SMTP id 5b1f17b1804b1-4b55c8743d8mr34861255e9.3.1793871537199;
        Thu, 05 Nov 2026 01:38:57 -0800 (PST)
Received: from sgarzare-redhat ([80.116.143.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b56fca22e1sm61976075e9.14.2026.11.05.01.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 01:38:56 -0800 (PST)
Date: Thu, 5 Nov 2026 10:38:51 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: netdev@vger.kernel.org, stefanha@redhat.com, bobbyeshleman@gmail.com, 
	mst@redhat.com, jasowangio@gmail.com, eperezma@redhat.com, 
	xuanzhuo@linux.alibaba.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 5/5] vsock/virtio: defer native RX readiness
 notifications until batch unlock
Message-ID: <auxK5K_n2hYw0ahW@sgarzare-redhat>
References: <20261103041134.33310-1-physicalmtea@gmail.com>
 <20261103041134.33310-6-physicalmtea@gmail.com>
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
In-Reply-To: <20261103041134.33310-6-physicalmtea@gmail.com>

On Tue, Nov 03, 2026 at 12:11:34PM +0800, Jia Jia wrote:
>An RX batch can make a socket readable while the RX worker retains its
>socket lock. Waking a blocked reader before release_sock() merely makes it
>wait for the same lock.
>
>P4 coalesces native sk_write_space notifications while retaining their
>under-lock callback context. This patch also coalesces native sk_data_ready
>notifications and moves both callbacks after release_sock(), so awakened
>tasks do not immediately block on the RX worker's socket lock.
>
>Save the native data-ready callback before the AF_VSOCK socket is
>published. Batch only while the native protocol and both native readiness
>callbacks are present and no psock is observed under sk_callback_lock. A
>socket with a replacement callback continues down the existing per-packet
>path.
>
>At batch finish, deliver write-space before data-ready and hold the
>connected lookup reference until both callbacks return. Packets admitted on
>the native path continue to use their saved native callbacks. Loading a
>current sockmap callback at finish would not serialize its invocation
>against sockmap teardown and could lose the native wakeup or invoke a stale
>data-ready wrapper.
>
>Extract the data-ready predicate from vsock_data_ready() so the deferred
>and regular paths share the low-watermark test.
>
>Performance:
>
>P4-P5 contribution (P1-P3 vs P1-P5):

I'm still confused on the reason why P4-P5 are not squashed.
This patch is essentially changing 90% of the previous patch...

>
>End-to-end RX throughput (64K Guest recv() size, SO_RCVLOWAT=1; Gbit/s):
>
>  payload  P1-P3 RX  P1-P5 RX  throughput change (95% CI)
>           (Gbit/s)      (Gbit/s)
>  64B        0.2449       0.2463    +0.55% [-3.86%, +5.17%]
>  256B       0.9649       0.9931    +2.93% [+0.83%, +5.07%]
>  512B       1.8205       1.8260    +0.30% [-4.27%, +5.10%]
>  1K         3.3431       3.3420    -0.03% [-2.15%, +2.12%]
>  4K         5.6541       5.8428    +3.34% [+1.10%, +5.63%]
>  8K         5.4280       5.3364    -1.69% [-15.55%, +14.46%]
>  16K        5.5935       5.6701    +1.37% [-1.41%, +4.23%]
>  64K        5.6917       5.8351    +2.52% [-0.20%, +5.31%]
>
>Fixed-syscall stress test (receiver recv() size = sender write size;
>Gbit/s):
>
>  payload P1-P3 RX P1-P5 RX throughput change (95% CI)
>  recv() calls are listed as P1-P3/P1-P5.
>  64B      0.2553   0.2575   +0.87% [-3.68%, +5.63%]
>           1048577/1048577
>  256B     0.9069   0.9183   +1.26% [-3.96%, +6.76%]
>           1048577/1048577
>  512B     1.6048   1.6459   +2.56% [+0.98%, +4.18%]
>           1048577/1048577
>  1K       2.6939   2.7357   +1.55% [-1.35%, +4.54%]
>           1048577/1048577
>  4K       4.9168   4.9678   +1.04% [-1.84%, +4.00%]
>           524965/525283
>  8K       5.1476   5.2005   +1.03% [-4.02%, +6.34%]
>           262926/263156
>  16K      5.5964   5.6609   +1.15% [-2.86%, +5.33%]
>           131311/131475
>  64K      5.9439   5.9073   -0.62% [-3.00%, +1.83%]
>           32875/32937
>
>Guest CPU1 aggregate cycles per received byte
>(fixed 64K receiver, with perf):
>
>  payload     P1-P3     P1-P5  change (95% CI)
>  64B        60.281    58.258  -3.36% [-8.74%, +2.35%]
>  256B       14.242    13.648  -4.17% [-9.81%, +1.82%]
>  512B        7.547     7.211  -4.45% [-9.73%, +1.13%]
>  1K          3.987     3.853  -3.35% [-8.52%, +2.12%]
>  4K          1.983     1.880  -5.17% [-7.97%, -2.27%]
>  8K          1.665     1.620  -2.75% [-9.03%, +3.96%]
>  16K         1.409     1.346  -4.52% [-10.94%, +2.37%]
>  64K         1.322     1.281  -3.11% [-6.49%, +0.38%]
>
>Full-series cycles/B (baseline vs P1-P5):
>
>Guest CPU1 aggregate cycles per received byte
>(fixed 64K receiver, with perf):
>
>  payload  baseline     P1-P5  change (95% CI)
>  64B        65.282    57.843  -11.40% [-13.77%, -8.95%]
>  256B       14.710    13.813   -6.10% [ -7.89%, -4.28%]
>  512B        7.709     7.188   -6.75% [ -8.79%, -4.66%]
>  1K          4.075     3.862   -5.23% [ -6.80%, -3.63%]
>  4K          2.034     1.887   -7.21% [ -8.67%, -5.72%]
>  8K          1.664     1.568   -5.78% [ -7.83%, -3.69%]
>  16K         1.450     1.385   -4.48% [ -6.08%, -2.86%]
>  64K         1.338     1.317   -1.51% [ -3.21%, +0.22%]
>
>Signed-off-by: Jia Jia <physicalmtea@gmail.com>
>---
> include/linux/virtio_vsock.h            |  5 ++-
> include/net/af_vsock.h                  |  9 +++--
> net/vmw_vsock/af_vsock.c                | 27 ++++++++++---
> net/vmw_vsock/virtio_transport_common.c | 52 +++++++++++++++----------
> 4 files changed, 62 insertions(+), 31 deletions(-)
>
>Tested:
>  Concurrent map-entry attach/detach during sequenced RX and duplex traffic
>  passed on baseline, P1-P3, P1-P4, and P1-P5. The active SK_PASS case also
>  passed on each state, with 200,000 verdict invocations. The concurrent
>  SK_PASS attach/detach case completed 1,000 insert/remove pairs per state;
>  its 10,000-record suffix after the final detach was verified. No kernel
>  diagnostic markers were found in successful runs.
>
>  Sockmap may replace sk_data_ready and sk_write_space. With non-native
>  callbacks, native RX batching must be declined and the ordinary per-packet
>  receive path used. The active SK_PASS case covers the condition expected to
>  trigger this fallback. The test does not trace each packet's internal
>  branch, so it verifies the fallback scenario without asserting that every
>  packet took that branch.
>
>  The duplex cases exercised write-space backpressure: the guest's nonblocking
>  send reached EAGAIN while the host was not reading. After the host began
>  draining data, the guest observed POLLOUT and resumed sending. Counts below
>  are observed EAGAIN/POLLOUT recoveries.
>
>    Test / result                              baseline   P1-P3   P1-P4   P1-P5
>    No-verdict RX churn: attach/detach pairs     433493  455507  430985  380351
>    No-verdict duplex: attach/detach pairs       229793  212410  214198  148755
>    No-verdict duplex: EAGAIN/POLLOUT            365/365  266/266  264/264  443/443
>    Active SK_PASS: EAGAIN/POLLOUT              2548/2548 3013/3013 3093/3093 4208/4208
>    SK_PASS attach/detach: intervals with verdict progress 705 616 631 692
>    SK_PASS attach/detach: verdict invocations  99747   99894   97475   82409
>    Post-detach SK_PASS suffix                 10,000/10,000 records per run
>
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index bf28e8e32e280..2aa0e81e655d5 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -287,14 +287,15 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
>  * Initialize a batch to zero before use. A non-empty batch owns @sk's socket
>  * lock and the reference returned by vsock_find_connected_socket_net(). The
>  * caller retains both until it calls virtio_transport_rx_batch_finish(). An
>- * empty batch owns neither. A pending native write-space notification belongs
>- * to the lock holder and is delivered by virtio_transport_rx_batch_finish().
>+ * empty batch owns neither. Pending native readiness notifications belong to
>+ * the lock holder and are delivered by virtio_transport_rx_batch_finish().
>  */
> struct virtio_transport_rx_batch {
> 	struct sock *sk;
> 	unsigned int pkts;
> 	size_t bytes;
> 	bool write_space_pending;
>+	bool data_ready_pending;
> };
>
> static inline bool
>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>index b76ab565ea58b..57ee545fdb496 100644
>--- a/include/net/af_vsock.h
>+++ b/include/net/af_vsock.h
>@@ -64,9 +64,10 @@ struct vsock_sock {
> 	bool sent_request;
> 	bool ignore_connecting_rst;
> 	/*
>-	 * Captured before the socket is published. This identifies AF_VSOCK's
>-	 * native write-space callback after a consumer has replaced it.
>+	 * Captured before the socket is published. These identify AF_VSOCK's
>+	 * native readiness callbacks after a consumer has replaced them.
> 	 */
>+	void (*native_data_ready)(struct sock *sk);
> 	void (*native_write_space)(struct sock *sk);
>
> 	/* Protected by lock_sock(sk) */
>@@ -83,7 +84,9 @@ s64 vsock_stream_has_data(struct vsock_sock *vsk);
> s64 vsock_stream_has_space(struct vsock_sock *vsk);
> struct sock *vsock_create_connected(struct sock *parent);
> void vsock_data_ready(struct sock *sk);
>-bool vsock_write_space_is_native(const struct sock *sk);
>+bool vsock_data_ready_pending(struct sock *sk);
>+bool vsock_callbacks_are_native(const struct sock *sk);
>+void vsock_call_native_data_ready(struct sock *sk);
> void vsock_call_native_write_space(struct sock *sk);
>
> /**** TRANSPORT ****/
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index e39567990539f..0617073e99ed8 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -958,6 +958,7 @@ static struct sock *__vsock_create(struct net *net,
> 		sk->sk_type = type;
>
> 	vsk = vsock_sk(sk);
>+	vsk->native_data_ready = sk->sk_data_ready;
> 	vsk->native_write_space = sk->sk_write_space;
> 	vsock_addr_init(&vsk->local_addr, VMADDR_CID_ANY, VMADDR_PORT_ANY);
> 	vsock_addr_init(&vsk->remote_addr, VMADDR_CID_ANY, VMADDR_PORT_ANY);
>@@ -1113,24 +1114,38 @@ s64 vsock_stream_has_space(struct vsock_sock *vsk)
> }
> EXPORT_SYMBOL_GPL(vsock_stream_has_space);
>
>-void vsock_data_ready(struct sock *sk)
>+bool vsock_data_ready_pending(struct sock *sk)
> {
> 	struct vsock_sock *vsk = vsock_sk(sk);
>
>-	if (vsock_stream_has_data(vsk) >= sk->sk_rcvlowat ||
>-	    sock_flag(sk, SOCK_DONE))
>+	return vsock_stream_has_data(vsk) >= sk->sk_rcvlowat ||
>+	       sock_flag(sk, SOCK_DONE);
>+}
>+EXPORT_SYMBOL_GPL(vsock_data_ready_pending);
>+
>+void vsock_data_ready(struct sock *sk)
>+{
>+	if (vsock_data_ready_pending(sk))
> 		sk->sk_data_ready(sk);
> }
> EXPORT_SYMBOL_GPL(vsock_data_ready);
>
>-bool vsock_write_space_is_native(const struct sock *sk)
>+bool vsock_callbacks_are_native(const struct sock *sk)
> {
> 	const struct vsock_sock *vsk = vsock_sk(sk);
>
>-	return READ_ONCE(sk->sk_write_space) ==
>+	return READ_ONCE(sk->sk_data_ready) ==
>+	       READ_ONCE(vsk->native_data_ready) &&
>+	       READ_ONCE(sk->sk_write_space) ==
> 	       READ_ONCE(vsk->native_write_space);
> }
>-EXPORT_SYMBOL_GPL(vsock_write_space_is_native);
>+EXPORT_SYMBOL_GPL(vsock_callbacks_are_native);
>+
>+void vsock_call_native_data_ready(struct sock *sk)
>+{
>+	vsock_sk(sk)->native_data_ready(sk);
>+}
>+EXPORT_SYMBOL_GPL(vsock_call_native_data_ready);
>
> void vsock_call_native_write_space(struct sock *sk)
> {
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index af26344678e41..9d02e81042c21 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1598,7 +1598,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
>
> static int
> virtio_transport_recv_connected(struct sock *sk,
>-				struct sk_buff *skb)
>+				struct sk_buff *skb,
>+				bool *data_ready_pending)
> {
> 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
> 	struct vsock_sock *vsk = vsock_sk(sk);
>@@ -1617,7 +1618,12 @@ virtio_transport_recv_connected(struct sock *sk,
> 			vsock_remove_sock(vsk);
> 			break;
> 		}
>-		vsock_data_ready(sk);
>+		if (data_ready_pending) {
>+			if (!*data_ready_pending && 
>vsock_data_ready_pending(sk))
>+				*data_ready_pending = true;
>+		} else {
>+			vsock_data_ready(sk);
>+		}
> 		return err;
> 	case VIRTIO_VSOCK_OP_CREDIT_REQUEST:
> 		virtio_transport_send_credit_update(vsk);
>@@ -1874,20 +1880,19 @@ __virtio_transport_rx_batch_can_receive(struct virtio_transport *t,
> 		return false;
>
> 	/*
>-	 * Sockmap can replace sk_prot or sk_write_space, and publish a psock,
>-	 * without the socket lock. Coalescing is safe only for the native
>-	 * write-space callback, so a boundary that sees a replacement returns to
>-	 * the existing per-packet path.
>+	 * Sockmap can replace sk_prot or either readiness callback, and publish a
>+	 * psock, without the socket lock. Coalescing is safe only for native
>+	 * callbacks, so a boundary that sees a replacement returns to the existing
>+	 * per-packet path.
> 	 */
> 	return READ_ONCE(sk->sk_prot) == sk->sk_prot_creator &&
>-	       vsock_write_space_is_native(sk) &&
>+	       vsock_callbacks_are_native(sk) &&
> 	       !virtio_transport_sock_has_psock(sk);
> }
>
> /*
>- * Sockmap teardown restores the native protocol and write-space callback
>- * under sk_callback_lock. Serialize each packet admission check with those
>- * updates.
>+ * Sockmap teardown restores the native protocol and callbacks under
>+ * sk_callback_lock. Serialize each packet admission check with those updates.
>  */
> static bool
> virtio_transport_rx_batch_can_receive(struct virtio_transport *t,
>@@ -1905,9 +1910,8 @@ virtio_transport_rx_batch_can_receive(struct virtio_transport *t,
> /*
>  * The caller holds sk's socket lock. If @batchable is non-NULL, update it
>  * after processing @skb to say whether a native STREAM/RW batch can continue.
>- * When @batch is non-NULL, record a native write-space notification for batch
>- * finish. A writer cannot consume the updated credit until this lock is
>- * released.
>+ * When @batch is non-NULL, record native readiness notifications for batch
>+ * finish. A reader or writer cannot make progress until this lock is released.
>  */
> static void
> virtio_transport_recv_pkt_locked(struct virtio_transport *t,
>@@ -1917,6 +1921,7 @@ virtio_transport_recv_pkt_locked(struct virtio_transport *t,
> {
> 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
> 	struct vsock_sock *vsk = vsock_sk(sk);
>+	bool *data_ready_pending;
> 	struct sockaddr_vm src;
> 	bool space_available;
>
>@@ -1926,6 +1931,8 @@ virtio_transport_recv_pkt_locked(struct virtio_transport *t,
> 	if (batchable)
> 		*batchable = false;
>
>+	data_ready_pending = batch ? &batch->data_ready_pending : NULL;

Can we just pass `batch` to virtio_transport_recv_connected and avoid 
all of this complexity?

>+
> 	/*
> 	 * The socket may have been closed or reassigned after lookup but before
> 	 * its socket lock was acquired. Listener sockets have no assigned
>@@ -1962,7 +1969,7 @@ virtio_transport_recv_pkt_locked(struct virtio_transport *t,
> 		kfree_skb(skb);
> 		break;
> 	case TCP_ESTABLISHED:
>-		virtio_transport_recv_connected(sk, skb);
>+		virtio_transport_recv_connected(sk, skb, data_ready_pending);
> 		break;
> 	case TCP_CLOSING:
> 		virtio_transport_recv_disconnecting(sk, skb);
>@@ -2036,32 +2043,37 @@ EXPORT_SYMBOL_GPL(virtio_transport_recv_pkt);
>
> /*
>  * Release an active RX batch. A non-empty batch holds the socket lock and the
>- * reference returned by vsock_find_connected_socket_net(). Deliver any
>- * deferred native write-space notification while holding the lock, preserving
>- * the callback context of the regular receive path. An empty batch holds
>- * neither.
>+ * reference returned by vsock_find_connected_socket_net(). Release the lock,
>+ * deliver deferred native write-space and data-ready notifications in that
>+ * order, then drop the reference. An empty batch holds neither.
>  */

Really, avoid comments that just describe what a function is doing. They 
really don't add much value and we need to update them every time, like 
this...

Comments should explain reasons, hidden behaviours, etc.
Something unclear just looking at the code.

> void virtio_transport_rx_batch_finish(struct virtio_transport_rx_batch *batch)
> {
> 	bool write_space_pending = batch->write_space_pending;
>+	bool data_ready_pending = batch->data_ready_pending;
> 	struct sock *sk = batch->sk;
>
> 	batch->sk = NULL;
> 	batch->pkts = 0;
> 	batch->bytes = 0;
> 	batch->write_space_pending = false;
>+	batch->data_ready_pending = false;
>
> 	if (!sk)
> 		return;
>

Here should be nice to have a comment to explain WHY it's safe to 
release in this new position...

>+	release_sock(sk);
>+
> 	/*
>-	 * The packet was admitted with the native callback. Do not reload a current
>+	 * Packets were admitted with native callbacks. Do not reload a current

Why this change?

Sorry, this series is really hard to review :-(

> 	 * callback here: sockmap can replace or remove its wrapper independently.
> 	 */
> 	if (write_space_pending)
> 		vsock_call_native_write_space(sk);
>
>-	release_sock(sk);
>+	if (data_ready_pending)
>+		vsock_call_native_data_ready(sk);
>+
> 	sock_put(sk);
> }
> EXPORT_SYMBOL_GPL(virtio_transport_rx_batch_finish);
>-- 
>2.53.0
>

