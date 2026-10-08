Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8D63E8351
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 10:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791454596; cv=none; b=qPsgEr5COlPsUNOhBnv97Hnrjv/+UitV3h9HP90mmSWmf1vy4DFtHXNRJbeza7QzTWyjXvEUa2BsrbI3IbGgcDWRUWfRaHCVRB4+RJvNLsJEgs4HV6Z4eykfPwr/FfJnDCnb8u4E87RlfmrrYPp6nfcyw1PGw2seS26wpMOPr88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791454596; c=relaxed/simple;
	bh=U28lcf97/CjhFUZfOOidZjKnIealHaMgfzCpUp3Xteo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ayXQ0DKKpT76gvNTJvcdyS7qd1Q87BbGmRxB8/OOzaK+RFNCU5mGiScE6aU3mrKEHxYYorVHSQfLB6gh3hAsHlql9M0/KrTwsgYIqLHmUMER4fEAv608NtxC51f2raXGlvahxiggRFXLbYCV2bMjhywPfc9lGhCtrNEoE1fM1EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h10LyY86; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CNYSTWqR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h10LyY86";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CNYSTWqR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791454593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SP1f9UNmtX0LiVyYf6TXLIff3crRsFq13nTHi/mc7ek=;
	b=h10LyY86fDG5Nbyl6UjwuVY08cz7sbCv160hdZtHQvABXdM4gQKKvrE7jUp9/JUP+v07K9
	gCjF7t4cIIcIsXRAeDGWmazGRGbLyew/25RhdEt4Wwf0CL5kTMeLuQeumPP3xPNw9jihg7
	jASGcRTKEpShSKjEamYZ48aU1gvPWFA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-SjAJMbGsPSS2E4VBPLuLAg-1; Thu, 08 Oct 2026 06:16:30 -0400
X-MC-Unique: SjAJMbGsPSS2E4VBPLuLAg-1
X-Mimecast-MFC-AGG-ID: SjAJMbGsPSS2E4VBPLuLAg_1791454589
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a1721559b4so39499385e9.1
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 03:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791454589; x=1792059389; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SP1f9UNmtX0LiVyYf6TXLIff3crRsFq13nTHi/mc7ek=;
        b=CNYSTWqRtI89N19CDwGDuwrlHmyMNd9dhnGNRpd2bx073GHh7YBifA83CRJExn4GQR
         wsK/TPuitMXQY6I4VvpTNFmdzQ2IVkADQSelzdN2gpBzsdejzirzSa7h+JdhGb2STbNk
         jr3wSlwv4HWxEbXoq24kL16/Exumtj0D9eEMoZd61eQYjNNwaHl4U3DQzXR+CQ2JCEbm
         g7LHB/9TaL2eg6elZh1/CUDrJiLCHjMvJ6c+cEjzOhRjuXgjuuICNyMfOzj4cVFGrfEH
         fREHFzFovSo7y0tdLgi+ONnOw7jCN1s7jWnN6KMz7JVGtB4Q6T6bCpf2N6l+5Gpfk/ED
         dtSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791454589; x=1792059389;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SP1f9UNmtX0LiVyYf6TXLIff3crRsFq13nTHi/mc7ek=;
        b=RUuWw77Jos8v+97gAPYwbIwKISLl3zTLig720rCEisYBpvY8Y16fkPDyVfhtCz26ys
         xU9CUqhHxm3AegbM23wM3NN22kkr37MNWdtTspQbweCWxrJ06f9MsM9LVojFzlJnQpHn
         Iy/0BbfZediKYa4B8VCR7vu/nKU1Wa7KjUwj/PWFSlkjED78zvWrDshghH5B5D2AVi8l
         Eb2r/GN2xQKsbfg2x7NO5Jd+1p5F1NBFJHjar7VhJAD+8676DBl5SbzMJPO3aW1pv5lF
         tgxeOsTKRDpvA/3u390Nnri/pTNHTWxvsi8ChBxspEgAvPLI4xDku/fFvydK66SK7wb+
         5YCA==
X-Forwarded-Encrypted: i=1; AKwUvBy23WyFfe1IF3UbYW+eY7zjxYX+G52L91liqHAkKKL4wZXZVmxXdpVWzPpwDHCN6Qp9X4S04l8=@vger.kernel.org
X-Gm-Message-State: AFuF++mFxkT6vRRZv9qCCTvxZHZKZ+l9DRozmbMxxaJoLTy4GymN7c1Y
	kaMGFf2YpZAauU4S23fbQJM+FFUlYH3MkPmv3Ncf0tt5ACVB4LPR1wlC9rvllpmSIpCH7FYLISS
	FnXScxq89CIyHuUnWj9CbC4vcHtjKHnBUMIB23m6aW+tWp2UBSGdkMUW4lQ==
X-Gm-Gg: AYBFou3xZAtKyF77tQrbirO79sWnDdfWGDzNf5QprAmoqltQHlQfhfr1P2/mhWFPIkk
	5E/jYvL+U198YK8dI6ipHYHiVyhsI192nqQjiB/OiZOfT4W9X0ct65eI446Z8ZUYf239n7o3gRZ
	2+M9LeXcHYxVPDI0H9FMeynUFjhuCX2I/UrnLjDUwbq0CVgrGn/lt64K8mfUEvek2ZgCIGEDAYr
	IeD45nMNqq4MGkvI/W69OU4pgaieLrRp+PhMCRW9kxAphk5ZH3yqaROpKoN2Sk2mvBuTD6ER34o
	taR+pgY5sCYmYcEoz2munW95JlCpmWCvK1T6Clk6bpXQ4VtTL5Wegao3weu/KMpaBm9k+vJ7QIe
	OQ2C6cuFcJDNi7vSUwfcx0om/BdEs
X-Received: by 2002:a05:600c:3e0a:b0:4a1:6c0c:ab93 with SMTP id 5b1f17b1804b1-4a18045995fmr80697505e9.28.1791454588764;
        Thu, 08 Oct 2026 03:16:28 -0700 (PDT)
X-Received: by 2002:a05:600c:3e0a:b0:4a1:6c0c:ab93 with SMTP id 5b1f17b1804b1-4a18045995fmr80696665e9.28.1791454588042;
        Thu, 08 Oct 2026 03:16:28 -0700 (PDT)
Received: from sgarzare-redhat (90-181-163-241.rco.o2.cz. [90.181.163.241])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1843d1ea0sm60309235e9.8.2026.10.08.03.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 03:16:27 -0700 (PDT)
Date: Thu, 8 Oct 2026 12:16:25 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Ilia Gavrilov <Ilia.Gavrilov@infotecs.ru>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	George Zhang <georgezhang@vmware.com>, Dmitry Torokhov <dtor@vmware.com>, Andy King <acking@vmware.com>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: Re: [PATCH net] vsock: Fix memory leak in
 vmci_transport_recv_dgram_cb()
Message-ID: <asds3RsjgMTh8OFj@sgarzare-redhat>
References: <20261007143716.1984702-1-Ilia.Gavrilov@infotecs.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261007143716.1984702-1-Ilia.Gavrilov@infotecs.ru>

On Wed, Oct 07, 2026 at 02:37:47PM +0000, Ilia Gavrilov wrote:
>During the closure of a datagram socket, the vmci_transport_recv_dgram_cb()
>function may be called, which will add the packets
>to the socket's backlog; then, after the receive queue is cleared,
>the __release_sock() function will move the packet back from the socket's
>backlog to the receive queue, which will lead to a memory leak.
>
>sock_close
>  __sock_release
>    __vsock_release
>      // take ownership by user-space
>      lock_sock_nested
>      sock_set_flag(sk, SOCK_DEAD)
>      vmci_transport_release
>                                      vmci_dispatch_dgs
>                                        vmci_datagram_invoke_guest_handler
>                                          vmci_transport_recv_dgram_cb
>                                            sk_receive_skb
>                                              if (!sock_owned_by_user(sk))
>                                                  [...]
>                                         (!)  else if sk_add_backlog()
>                                                  [...]
>  (!) skb_queue_purge(&sk->sk_receive_queue)
>
>      release_sock
>        __release_sock
>          // move all packets from the backlog
>          // to the receive queue
>   (!)    sk_backlog_rcv
>            vsock_queue_rcv_skb
>            [...]
>              __sock_queue_rcv_skb
>                if (!sock_flag(sk, SOCK_DEAD))
>                  // Since the socket is "dead", the function will not
>                  // be called
>                  sk->sk_data_ready(sk)
>        sock_release_ownership(sk);
>        sock_put
>
>Add a receive queue cleanup in the socket destructor to fix this.
>
>syzkaller report:
>
>unreferenced object 0xffff8880117bfb80 (size 240):
>  comm "irq/56-vmw_vmci", pid 205, jiffies 4295064448 (age 73.992s)
>  hex dump (first 32 bytes):
>    78 dc 26 1e 80 88 ff ff 78 dc 26 1e 80 88 ff ff  x.&.....x.&.....
>    00 00 00 00 00 00 00 00 c0 da 26 1e 80 88 ff ff  ..........&.....
>  backtrace:
>    [<ffffffff82be8d97>] __alloc_skb+0x287/0x330 net/core/skbuff.c:505
>    [<ffffffffa114bcbd>] vmci_transport_recv_dgram_cb+0xbd/0x210 [vmw_vsock_vmci_transport]
>    [<ffffffffa05072c6>] vmci_datagram_invoke_guest_handler+0x366/0x450 [vmw_vmci]
>    [<ffffffffa050ad75>] vmci_dispatch_dgs+0x235/0x490 [vmw_vmci]
>    [<ffffffffa050b025>] vmci_interrupt+0x55/0x290 [vmw_vmci]
>    [<ffffffff8137ad2b>] irq_thread_fn+0x8b/0x1a0 kernel/irq/manage.c:1205
>    [<ffffffff8137c7ae>] irq_thread+0x28e/0x530 kernel/irq/manage.c:1314
>    [<ffffffff81253dd6>] kthread+0x2e6/0x3a0 kernel/kthread.c:376
>    [<ffffffff81004392>] ret_from_fork+0x22/0x30 arch/x86/entry/entry_64.S:295
>
>Found by InfoTeCS on behalf of Linux Verification Center
>(linuxtesting.org) with Syzkaller.
>
>Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
>Signed-off-by: Ilia Gavrilov <Ilia.Gavrilov@infotecs.ru>
>---
> net/vmw_vsock/af_vsock.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 9b71479a2b29..fbafd882a12c 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1048,6 +1048,7 @@ static void vsock_sk_destruct(struct sock *sk)
> {
> 	struct vsock_sock *vsk = vsock_sk(sk);
>

nit: maybe a comment here referring to vmci datagram could be nice to 
have if you send a v2. In any case, also this version is fine to me:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>+	__skb_queue_purge(&sk->sk_receive_queue);
> 	/* Flush MSG_ZEROCOPY leftovers. */
> 	__skb_queue_purge(&sk->sk_error_queue);
>
>-- 
>2.47.3
>

