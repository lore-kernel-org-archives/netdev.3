Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CBA39FCCA
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 11:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788174586; cv=pass; b=n68pKFjDQLWTnimf22vVhUu+J9SHnLK/SmjdzsyK0n7YBXuPPRl8nRa96T7ktVXJajsgz0c4ZDVNBvIdZoeVuoA1fkaLKtaMi9tNYatEGDD0YLysRF3wk0OrVfact3vxwflLcnqmHwRr/BRAhkoy9U8eBjzccW/fjWI529x2uyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788174586; c=relaxed/simple;
	bh=eNEEQlIjrSAO0DH2OmgK6lfFH24wmDnCRfFdxuXXBJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HPTcdxVUJry6lgry59oPegNbrb12fWVkYo9MA00XGwZp15brO1FTUqjng1rPGSKQzT1spmg0afPgEpO9HvMFBNQttcUmcgLnGDXKJe2KO49vYdhLHEjan0SaCjtJ+sQVBCEUrkY9gd+qPF40uJrK0XqmKy0/8hpgi15fC/CS6KQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T8cVrp4b; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rJUtAZsX; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T8cVrp4b";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rJUtAZsX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788174584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gGVDSMHx5ugj+9ChPGD41hmHDHU/4Z3alFYnki4dZYo=;
	b=T8cVrp4b/g4WlrVtGeBgt4olXjvF4Sw0Bqxk1BYFekOWIj2IeSfNQem7r2GLD0Ei7ZXANB
	wfZMzTykuL0q8HMbWVP2b3FYAcfddu/4e098db3xMpPv8hcxQGMspTLikfgpVMu6mtx02n
	T5fjMl5/Dt233kbUm8CJUEmw9W6PqCU=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-JoC1m-AYMAGhY1WVXPUcxw-1; Mon, 31 Aug 2026 07:09:42 -0400
X-MC-Unique: JoC1m-AYMAGhY1WVXPUcxw-1
X-Mimecast-MFC-AGG-ID: JoC1m-AYMAGhY1WVXPUcxw_1788174582
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-836c2b00bbaso45897367b3.0
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 04:09:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788174582; cv=none;
        d=google.com; s=arc-20260327;
        b=WNFoTSdv8gndBDmWkEVtVBvYsCY5sHwwPCrI1KhrBDBHChYIGW4dsMPBmGkcHSXTEg
         kO7D058EyT3fgbEUuFQ7GuG4MGKmtPLZ3ahwKB76irKpujuoo0BprH1gSV21bnZNy8Xb
         259sLhnWAIOdBJqI2oKwI6LaswH5atmGQlganB3u2Zqobz4vcvi86ceCBn4QoAn4o1O5
         q734oocrsWrFfN1LXYuKiQKPuOTAy3XdWTL4oZaV8Jyb++H9Q2atQBqg9nKo+DWb03Zx
         hqkdhLI5VRqVmeH2I5Oyo3DynWM8C93Mh0AS1/WB6vw/JGPVsD+q/icFpIrSuFglenVh
         jCmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gGVDSMHx5ugj+9ChPGD41hmHDHU/4Z3alFYnki4dZYo=;
        fh=n0cVQoaTCZ0udzfrFt60FUp84gWDmhq5Hoz1cChBR9k=;
        b=oQ++4iINAOdM0remeR9JOB7Wf5jelmjhAbrVGE6cdlD2PtMS4eydjMsUYqeeZgdd7o
         kcXxhr0qtuOVxzMnRvN9aEqTBk+2bRWooHzaUsZ04k6NyzOwu7sKgHgjqf4XJnu5K5rm
         snjOhMiVJQVT5Q6wV9kTSanWbCdn5pxC6nDcA4w8/z9JQ++G/lPMOJC/osM9X0ajX/gN
         B83nLiLvBrBWTvABX0gpN0CXHVM5/jcKeTnosdY2yyFrXl274Ci7xMSIHutO09Mg0k9N
         PDa7xAr69eq/wAcvFEjaM8jRo+97t5yb2v7UKXHKKBK1i3r+HtgTag1l/ss5qaNFczTi
         GIWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788174582; x=1788779382; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gGVDSMHx5ugj+9ChPGD41hmHDHU/4Z3alFYnki4dZYo=;
        b=rJUtAZsXdtGTgU1G5jIWVW6DLV4vW+VKK0Q7Z7MBVGbXnabO5lLFHSOFdXItHfmSzt
         3fTiXEymJ4I+WYGLTIBx/dvA9Jqw5YBHahhcbf4n3gDDlbpF6PwYWNyS9vUoZlk9Ye+Y
         fP708RmOULS++4rsSsyDNVZL+6fqWMNAcLwijnPr5HivmuzMfnJaC1qIru9yD3hXajeH
         08Pp6/aCrJiknhGldgoev/Ss9Y6XomHk5+T6b/hSOGvaNhDTrSAdLecSSwb1MhjYk6Ei
         1hqM6kqTxxIgc7t25tT4PQVN5QIRUnR+C35DGm7ClqhCZEVI5Xlfm5nGGFqJUqLJKgwx
         fH0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788174582; x=1788779382;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gGVDSMHx5ugj+9ChPGD41hmHDHU/4Z3alFYnki4dZYo=;
        b=oDRrj98IYKWIna+kGc/ZWuARL5EN51tJztJJWcnhX2j7ceua/zBjZBOiZab+526C1c
         INpmiqq4mg2K9slGP9csvYdryBtILQaL1FqbCbK3e9LhexLf7hSTkIOktyWlPsJK2NqF
         yo0IpTjDGYyfqB0h4RBpdiZnYQuJtuqkFBt0lbkksxG/63Srvj+IY1/adNMvXmR0UifJ
         9pmsBzjV6WmrOT9kWtZAWgTlgEFDH58HRamsyC79dVVDhyJDgvN1B44JWZlVUSPgaA18
         x/woSfmn++9H8qGM+sCYbeJuAgpwbHps1J+DXgVBgoFOly6121YAlUrbQqDVSuGurARH
         REbQ==
X-Forwarded-Encrypted: i=1; AKwUvBxIzzRRLrFVzzxld2G6IuBuPCNkOF+0KKgJF6oDvyEZjlPuDiq8kycwlNRfsB2/03WctJJpP2A=@vger.kernel.org
X-Gm-Message-State: AFuF++knHnMxE3Gp5/AFk5wrXGJaov5Ta7gslSpAQQkio4LVxlbu0WC9
	NDa5SiLM8Iq4SqppGLCtEZgzLPUqVsHRU5350rB4Qjx2UjVF797qbi+GEo1uJ93D4KVR2IoXxMP
	eNYFwwwLVunMTv1+1kMP2mMtbw8u4+KqmBcPWTgKKVCwmCLbUtJG2o3DP/5DLWYD2FqAR5szMtD
	EpCXLL6V6bPpvqx+1THFLFkbmoxLXNvPop
X-Gm-Gg: AYBFou0sRO4kAz/6DuohjH6W1L+l1PSWSA0QsvdpdLHnUBFEtorZpDk73iAoTcavfJb
	ToWL6EcJw3n2P+crWP2uxIKSqZxmoYwzo3k8H9QEXppI/nnYS/1EmFO+uWx36Ffk27cnnFr5t6s
	8UFmmR6MOwejPgcXvjusXH2036z2st6IifIvH3peSBZgQAMtOXIZth5pBnpnmva7l6WJpf9gbAu
	/nJIxbFtFwhb15/1nqajHPTDiYCuS6Zl+GB6wjGSjrfRHFwJjlkVSSbKwY=
X-Received: by 2002:a05:690c:c4f1:b0:81e:7d90:5673 with SMTP id 00721157ae682-85d6b84749cmr86908407b3.26.1788174581622;
        Mon, 31 Aug 2026 04:09:41 -0700 (PDT)
X-Received: by 2002:a05:690c:c4f1:b0:81e:7d90:5673 with SMTP id
 00721157ae682-85d6b84749cmr86908167b3.26.1788174580953; Mon, 31 Aug 2026
 04:09:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827055850.26951-1-physicalmtea@gmail.com>
In-Reply-To: <20260827055850.26951-1-physicalmtea@gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 31 Aug 2026 13:09:04 +0200
X-Gm-Features: AcwNN1VgorMGLHjUu2yMfvgBMefLlEZdtOPgiCl06CVBpYpTFVo6Jeh18PCESXs
Message-ID: <CAJaqyWfjjSe19z4TrPbJfBBQZJXuAzqE4H8bik6UAiSgogzfmQ@mail.gmail.com>
Subject: Re: [PATCH] vhost/vsock: batch RX used-ring updates
To: Jia Jia <physicalmtea@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	"Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 7:59=E2=80=AFAM Jia Jia <physicalmtea@gmail.com> wr=
ote:
>
> vhost_transport_do_send_pkt() calls vhost_add_used() for every Guest RX
> buffer even though it delays the Guest signal until the worker finishes.
> Each call publishes one used entry and updates the used index separately.
>
> Collect the completed buffer heads in the arrays already allocated for th=
e
> virtqueue and publish them with vhost_add_used_n().  Bound the batch by t=
he
> ring size, array capacity, and worker packet budget.  Flush before
> re-enabling notifications or leaving the worker.
>
> Each used entry describes one completed RX buffer and keeps its actual us=
ed
> length, so set nheads to 1 for every entry.  This patch does not change
> negotiated features or compress multiple buffers into one used entry.
>
> This patch is limited to the current skb-based vhost-vsock RX path.
>
> Performance:
>
> Tested with a QEMU/KVM guest on a host with 4 online CPUs, using 2 vCPUs
> pinned to host CPUs 2 and 3, QEMU 10.2.1, q35, 1536 MiB, and Linux
> 7.2.0-rc3-next-20260713-next-debug-kasan.  The vhost-vsock source is base=
d
> on linux-next master at 49362394dad7df66c274c867a271394c10ca2bb8.
>
> Current vhost-vsock does not implement VIRTIO_F_IN_ORDER or
> VIRTIO_F_RING_PACKED, so both configurations used packed=3Doff and
> in_order=3Doff:
>
>   baseline:                 RX batching=3Doff
>   vhost-vsock RX batching:  RX batching=3Don
>
> The test used vsock_perf.  The Guest receiver was started with:
>
>   vsock_perf --port PORT --buf-size 64M --vsk-size 64M --rcvlowat 1
>
> The Host sender was started with:
>
>   vsock_perf --sender 3 --port PORT --bytes BYTES \
>       --buf-size SEND_BUF --vsk-size 64M
>
> Each workload transferred BYTES=3D1 GiB.  The SEND_BUF values were 256 B
> (SEND_BUF=3D256), 512 B (SEND_BUF=3D512), 4 KiB (SEND_BUF=3D4K), and 64 K=
iB
> (SEND_BUF=3D64K).
> Each state used a fresh Guest.  Each workload uses 20 paired runs, with 1=
0
> runs in each order.  The reported values are
> Guest RX throughput in Gbits/s.  The baseline and batching columns are th=
e
> geometric means over the 20 runs; change is batching / baseline - 1,
> computed from the unrounded values:
>
>   workload   baseline RX    batching RX   change   faster
>   256 B      0.0795724      0.0831509      +4.497%  20/20
>   512 B      0.1194885      0.1210297      +1.290%  14/20
>   4 KiB      0.7208273      0.7242053      +0.469%  11/20
>   64 KiB     2.1712797      2.1951941      +1.101%  13/20
>
> For reference, the table below gives the 95% normal-approximation interva=
ls
> obtained from the 20 paired log(batching / baseline) values:
>
>   workload   paired 95% interval
>   256 B      +3.985% to +5.011%
>   512 B      +0.206% to +2.385%
>   4 KiB      -1.442% to +2.416%
>   64 KiB     -1.474% to +3.745%
>
> All transfers passed byte-count checks, and no kernel errors were observe=
d
> in the logs.  The 256-byte workload improved in every pair.  The 512 B
> workload was faster in 14 of 20 pairs, with a small gain.  The 4 KiB and
> 64 KiB workloads showed no material throughput change; the difference
> between their results may be due to scheduling and execution variation.
>
> Link: https://lore.kernel.org/r/20181214082146-mutt-send-email-mst@kernel=
.org
> Link: https://lore.kernel.org/r/20220901055434.824-4-qtxuning1999@sjtu.ed=
u.cn
> Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> ---
>  drivers/vhost/vsock.c | 41 +++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 39 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index 9aaab6bb8..d8050cca2 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -103,12 +103,37 @@ static bool vhost_transport_has_remote_cid(struct v=
sock_sock *vsk, u32 cid)
>         return found;
>  }
>
> +static bool vhost_vsock_flush_used(struct vhost_virtqueue *vq,
> +                                  unsigned int *used_count)
> +{
> +       if (!*used_count)
> +               return false;
> +
> +       vhost_add_used_n(vq, vq->heads, vq->nheads, *used_count);
> +       *used_count =3D 0;
> +       return true;
> +}
> +

I think that the used_count should be updated by the caller based on
the boolean returned by this function.

> +static void vhost_vsock_add_used(struct vhost_virtqueue *vq,
> +                                unsigned int *used_count,
> +                                unsigned int head, unsigned int len)
> +{
> +       struct vring_used_elem *used =3D &vq->heads[*used_count];
> +
> +       used->id =3D cpu_to_vhost32(vq, head);
> +       used->len =3D cpu_to_vhost32(vq, len);
> +       vq->nheads[*used_count] =3D 1;
> +       (*used_count)++;
> +}

Same here, why pass it as an argument? The caller knows way better.

Other than that, the patch looks good to me,

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!

> +
>  static void
>  vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
>                             struct vhost_virtqueue *vq)
>  {
>         struct vhost_virtqueue *tx_vq =3D &vsock->vqs[VSOCK_VQ_TX];
>         int pkts =3D 0, total_len =3D 0;
> +       unsigned int used_count =3D 0;
> +       unsigned int used_limit;
>         bool added =3D false;
>         bool restart_tx =3D false;
>
> @@ -120,6 +145,12 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsoc=
k,
>         if (!vq_meta_prefetch(vq))
>                 goto out;
>
> +       used_limit =3D min_t(unsigned int, vq->num,
> +                          min_t(unsigned int, vq->dev->iov_limit,
> +                                vq->dev->weight));
> +       if (unlikely(!used_limit))
> +               goto out;
> +
>         /* Avoid further vmexits, we're already processing the virtqueue =
*/
>         vhost_disable_notify(&vsock->dev, vq);
>
> @@ -134,9 +165,13 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsoc=
k,
>                 u32 offset;
>                 int head;
>
> +               if (used_count =3D=3D used_limit)
> +                       added |=3D vhost_vsock_flush_used(vq, &used_count=
);
> +
>                 skb =3D virtio_vsock_skb_dequeue(&vsock->send_pkt_queue);
>
>                 if (!skb) {
> +                       added |=3D vhost_vsock_flush_used(vq, &used_count=
);
>                         vhost_enable_notify(&vsock->dev, vq);
>                         break;
>                 }
> @@ -153,6 +188,7 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock=
,
>                         /* We cannot finish yet if more buffers snuck in =
while
>                          * re-enabling notify.
>                          */
> +                       added |=3D vhost_vsock_flush_used(vq, &used_count=
);
>                         if (unlikely(vhost_enable_notify(&vsock->dev, vq)=
)) {
>                                 vhost_disable_notify(&vsock->dev, vq);
>                                 continue;
> @@ -230,8 +266,8 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock=
,
>                  */
>                 virtio_transport_deliver_tap_pkt(skb);
>
> -               vhost_add_used(vq, head, sizeof(*hdr) + payload_len);
> -               added =3D true;
> +               vhost_vsock_add_used(vq, &used_count, head,
> +                                    sizeof(*hdr) + payload_len);
>
>                 VIRTIO_VSOCK_SKB_CB(skb)->offset +=3D payload_len;
>                 total_len +=3D payload_len;
> @@ -264,6 +300,7 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock=
,
>                         virtio_transport_consume_skb_sent(skb, true);
>                 }
>         } while(likely(!vhost_exceeds_weight(vq, ++pkts, total_len)));
> +       added |=3D vhost_vsock_flush_used(vq, &used_count);
>         if (added)
>                 vhost_signal(&vsock->dev, vq);
>
> --
> 2.53.0
>

