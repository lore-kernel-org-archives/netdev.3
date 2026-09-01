Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7A240860A
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 02:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788229670; cv=pass; b=OAtzj6LY0XVcR8NLHaAEdM7ndSCE4Wgu8yp1pqDMwYbRHpJ2lbFMUSk0pycVKNycVIrB5AwEfWFAIx068W9+kKKTzdVcw+YwAOGgFne+A0YTye1V4LOqH6fwO31UbNaozWNP1p/66eya325ub/nLVS6W/wEkEpbjnp3Db/cSFTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788229670; c=relaxed/simple;
	bh=PN/UjImC7bgd865J9BP2KD4atjXNWpj+MALMnuPZKh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RqafYhHNTRzvy2CDFG1NFyIMAXB7r7RcA/IeXWwFn3HiJmF7Elktq3rGJSSnaS60a5V5dX1oB6+lq6yWRTCFLeZcO+UIWf30UaUT4rXigJrk9fFqg+f5TX9CW+YBgR7B4++vyS+xNbQOoD1Xdexq5fPHG+s+WGoDG9N5Yn5nnLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aVGtqx6U; arc=pass smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aVGtqx6U"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-92f0b5ed131so509252785a.3
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 19:27:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788229667; cv=none;
        d=google.com; s=arc-20260327;
        b=qIHnpP4G45HVzdshYglThVtcW8FazTpMpAa5XUjcEszNBr2rHnU11Is5Bkw+Lq+BPk
         a4TU+QvxRDkYWEKgkwkrn10U2lW0Mgwq9ASGJ3UhVLBRoJi5ZzBXKU58j5jU2/tl17Jv
         /t3KJLXxkWSVnUdvUU5ssdqfxZ/Kn8+f3ZRO3eBn6BeJVsvO0hPlNHpnchP4+G478ZFr
         0b4Xvxun44tupneBGjpryc1wIYBh3/B4fT1avLCCPXbIpg535RSqRXahcWnpIoW89/yQ
         g5TIc28j79MlSz8kZi/Knwn915pUFjtjzzlK4KI0UqPQ25M7Nhtvgw6hzApeAnV20YoB
         xZ6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DIwG3h1DWr4hnTm8Um8YYeq8VR9qYUjCZHlufcU+1bY=;
        fh=sREmDdJG8c/mfEOqKkiK39McnrCkQMiLzS1adSU9tBo=;
        b=nmcW33qByXh8h6Db3u9yUSuiltvo7I7ihkpRrnXD9nuBl5lqn6S56mPOn1QoG2w6Y0
         Drss98UZlvKMjHrWpFOaAXM1J62+miCiX8eiCc+qGLBxzX5ibv5pPDTA2Tl8R9I9+e49
         xQh42GCPEz/y8NlyMp6dYZqiDyAj7DPXu/2qauiwVUnr7BxW72QvimgOPQbC7sZpoL8I
         zK0tHQ/YzoYnga5SUPXdz3nLkj+UiyDnWt35l6z/PX8gDeyQYD1u9Ye8EkZoAVAlSOnr
         mBrxphA0sMoAJ8WTMIyCERf1brckfzve0D/9c1gAsQANzqxWqM6jwROEjwdDE5/x7WA5
         3Nwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788229667; x=1788834467; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DIwG3h1DWr4hnTm8Um8YYeq8VR9qYUjCZHlufcU+1bY=;
        b=aVGtqx6Uh8m9TPjCcQt7kVMDw6uqg4T0QVuPd6jOfSZQ6Zc84z01Yq8soTAZEvCXdz
         9LLyHYXAlH85VL0t0nM/AinM4plP5VgD680Swx7x1qNWdE5hibAFnfhDlPkHHZUFcM4r
         c2TJCXohAm7KhUWI2kIo4BexlQR4xtcjQMBkwuuObg0Ms5PEMpF0WRHPOzoj6BwDE+iR
         Rm/YMZhTtO2lHEkhuOyLabtaGBlXteTq19jLxFAxDZbQ/Y8Ft1unvka0Let9vxbNGB1l
         H5QP/HwZB+ms2GEBrGKIiSLmKGMCR4jHmu/BkYk7i6ggExW9nve8pIyHhUouR0SEWfxL
         TYcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788229667; x=1788834467;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DIwG3h1DWr4hnTm8Um8YYeq8VR9qYUjCZHlufcU+1bY=;
        b=CCcYK2mxL2nzVP25R5cClhgUbswfvZ50PfFoTJwEmh3bviVHugQKAQkOP0OV3UouUW
         3X+Ql2Rst1DVr6KflLhf7p8LC7UD8O0osSrf2wgHMbT9h4F6QkmSuiSqLMqKCRSZcR8m
         KQpRaPx4alujGlb2gjJy0zssxy44/dq2rbh1vSXs4MmVmPFEexcaP9WB3ykAZdwsb9xq
         EOnUBhkzlh+5GI8PTrf/ImdFOq3gbofWQ7N/DKSQdrMDbsUqdbTSrAyzoN58qn6HMT24
         7Z7Zd6mIepqNq8/cZxyNlJx9HpDSBtkZN6EIcLe46xxo/XwPd1iafSXStszoRU4Azy+r
         JZBw==
X-Forwarded-Encrypted: i=1; AHgh+RqaXgEviATuDRemkrOTkuFZzKygsglq6WMB5JwDbO79KP5WOY50jjXS3YFTOibZJOhtuaDr0i4=@vger.kernel.org
X-Gm-Message-State: AFuF++nluhanAXWmyijQjmHawWfNuE8NFBGZNJ4PXLhtfROBoS73UyQQ
	34/mMmPRbtM8SdD079OD9Ol2RiYE7R3ImTMxLtTjARdPdABjYTYCWtbzYD67XLYHWLp8t0ocNaL
	SLIsekoS/wY2u+SaouMWaZq8BG7oSJKY=
X-Gm-Gg: AR+sD139NmJD3RyWAT127Q8Bs4UCJkjRcY6h+i4+r4b81cVjBNHAiXXb4gCdxjJwrXY
	N2evE6AEzDdO0E+NmW/cqAx8Wh9eo8+q8ZaCUOK9OkNmZ4x2ipdYpanNzhosoKhuevtak7u5qsv
	Iyl6/0LvK24K1RHCHCgYWetWjT/QY2LB31/eVnE2ODfhqAfmEWn6Mu+GacSrKWd2oeWoSxP6HYd
	qZWEmb/XrFxmoA8eDXEESoF5P0fiBh9GiXDAUVCAOdtPdiKLk3V7588waJ1tfEtbjrBvMAb0CLl
	TwrnoMP9nzm0sK08c7806G9OQis+Hl67DkZPAOjm7XGQ
X-Received: by 2002:a05:620a:172b:b0:939:32ea:9f0c with SMTP id
 af79cd13be357-93932eaa334mr1720744085a.8.1788229666903; Mon, 31 Aug 2026
 19:27:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827055850.26951-1-physicalmtea@gmail.com> <CAJaqyWfjjSe19z4TrPbJfBBQZJXuAzqE4H8bik6UAiSgogzfmQ@mail.gmail.com>
In-Reply-To: <CAJaqyWfjjSe19z4TrPbJfBBQZJXuAzqE4H8bik6UAiSgogzfmQ@mail.gmail.com>
From: Jia Jia <physicalmtea@gmail.com>
Date: Tue, 1 Sep 2026 10:27:11 +0800
X-Gm-Features: AcwNN1X8xFc3zj4Mx5oZW-ZuOM04e_bQ28qEh0Tx7DrEEEAOGAyocsDW-QjEdZI
Message-ID: <CAJwVaMJ5Lc0J1M-+QAHH9w_tcrjNYDqOTbkAWUucCK4_50ay-g@mail.gmail.com>
Subject: Re: [PATCH] vhost/vsock: batch RX used-ring updates
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	"Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
> On Thu, Aug 27, 2026 at 7:59=E2=80=AFAM Jia Jia <physicalmtea@gmail.com> =
wrote:
> >
> > vhost_transport_do_send_pkt() calls vhost_add_used() for every Guest RX
> > buffer even though it delays the Guest signal until the worker finishes=
.
> > Each call publishes one used entry and updates the used index separatel=
y.
> >
> > Collect the completed buffer heads in the arrays already allocated for =
the
> > virtqueue and publish them with vhost_add_used_n().  Bound the batch by=
 the
> > ring size, array capacity, and worker packet budget.  Flush before
> > re-enabling notifications or leaving the worker.
> >
> > Each used entry describes one completed RX buffer and keeps its actual =
used
> > length, so set nheads to 1 for every entry.  This patch does not change
> > negotiated features or compress multiple buffers into one used entry.
> >
> > This patch is limited to the current skb-based vhost-vsock RX path.
> >
> > Performance:
> >
> > Tested with a QEMU/KVM guest on a host with 4 online CPUs, using 2 vCPU=
s
> > pinned to host CPUs 2 and 3, QEMU 10.2.1, q35, 1536 MiB, and Linux
> > 7.2.0-rc3-next-20260713-next-debug-kasan.  The vhost-vsock source is ba=
sed
> > on linux-next master at 49362394dad7df66c274c867a271394c10ca2bb8.
> >
> > Current vhost-vsock does not implement VIRTIO_F_IN_ORDER or
> > VIRTIO_F_RING_PACKED, so both configurations used packed=3Doff and
> > in_order=3Doff:
> >
> >   baseline:                 RX batching=3Doff
> >   vhost-vsock RX batching:  RX batching=3Don
> >
> > The test used vsock_perf.  The Guest receiver was started with:
> >
> >   vsock_perf --port PORT --buf-size 64M --vsk-size 64M --rcvlowat 1
> >
> > The Host sender was started with:
> >
> >   vsock_perf --sender 3 --port PORT --bytes BYTES \
> >       --buf-size SEND_BUF --vsk-size 64M
> >
> > Each workload transferred BYTES=3D1 GiB.  The SEND_BUF values were 256 =
B
> > (SEND_BUF=3D256), 512 B (SEND_BUF=3D512), 4 KiB (SEND_BUF=3D4K), and 64=
 KiB
> > (SEND_BUF=3D64K).
> > Each state used a fresh Guest.  Each workload uses 20 paired runs, with=
 10
> > runs in each order.  The reported values are
> > Guest RX throughput in Gbits/s.  The baseline and batching columns are =
the
> > geometric means over the 20 runs; change is batching / baseline - 1,
> > computed from the unrounded values:
> >
> >   workload   baseline RX    batching RX   change   faster
> >   256 B      0.0795724      0.0831509      +4.497%  20/20
> >   512 B      0.1194885      0.1210297      +1.290%  14/20
> >   4 KiB      0.7208273      0.7242053      +0.469%  11/20
> >   64 KiB     2.1712797      2.1951941      +1.101%  13/20
> >
> > For reference, the table below gives the 95% normal-approximation inter=
vals
> > obtained from the 20 paired log(batching / baseline) values:
> >
> >   workload   paired 95% interval
> >   256 B      +3.985% to +5.011%
> >   512 B      +0.206% to +2.385%
> >   4 KiB      -1.442% to +2.416%
> >   64 KiB     -1.474% to +3.745%
> >
> > All transfers passed byte-count checks, and no kernel errors were obser=
ved
> > in the logs.  The 256-byte workload improved in every pair.  The 512 B
> > workload was faster in 14 of 20 pairs, with a small gain.  The 4 KiB an=
d
> > 64 KiB workloads showed no material throughput change; the difference
> > between their results may be due to scheduling and execution variation.
> >
> > Link: https://lore.kernel.org/r/20181214082146-mutt-send-email-mst@kern=
el.org
> > Link: https://lore.kernel.org/r/20220901055434.824-4-qtxuning1999@sjtu.=
edu.cn
> > Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> > ---
> >  drivers/vhost/vsock.c | 41 +++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 39 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> > index 9aaab6bb8..d8050cca2 100644
> > --- a/drivers/vhost/vsock.c
> > +++ b/drivers/vhost/vsock.c
> > @@ -103,12 +103,37 @@ static bool vhost_transport_has_remote_cid(struct=
 vsock_sock *vsk, u32 cid)
> >         return found;
> >  }
> >
> > +static bool vhost_vsock_flush_used(struct vhost_virtqueue *vq,
> > +                                  unsigned int *used_count)
> > +{
> > +       if (!*used_count)
> > +               return false;
> > +
> > +       vhost_add_used_n(vq, vq->heads, vq->nheads, *used_count);
> > +       *used_count =3D 0;
> > +       return true;
> > +}
> > +
>
> I think that the used_count should be updated by the caller based on
> the boolean returned by this function.
>

Thanks for the review. I will fix this in v2.

> > +static void vhost_vsock_add_used(struct vhost_virtqueue *vq,
> > +                                unsigned int *used_count,
> > +                                unsigned int head, unsigned int len)
> > +{
> > +       struct vring_used_elem *used =3D &vq->heads[*used_count];
> > +
> > +       used->id =3D cpu_to_vhost32(vq, head);
> > +       used->len =3D cpu_to_vhost32(vq, len);
> > +       vq->nheads[*used_count] =3D 1;
> > +       (*used_count)++;
> > +}
>
> Same here, why pass it as an argument? The caller knows way better.

I will fix this in v2.

>
> Other than that, the patch looks good to me,
>
> Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
>
> Thanks!
>

Thanks!

> > +
> >  static void
> >  vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
> >                             struct vhost_virtqueue *vq)
> >  {
> >         struct vhost_virtqueue *tx_vq =3D &vsock->vqs[VSOCK_VQ_TX];
> >         int pkts =3D 0, total_len =3D 0;
> > +       unsigned int used_count =3D 0;
> > +       unsigned int used_limit;
> >         bool added =3D false;
> >         bool restart_tx =3D false;
> >
> > @@ -120,6 +145,12 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vs=
ock,
> >         if (!vq_meta_prefetch(vq))
> >                 goto out;
> >
> > +       used_limit =3D min_t(unsigned int, vq->num,
> > +                          min_t(unsigned int, vq->dev->iov_limit,
> > +                                vq->dev->weight));
> > +       if (unlikely(!used_limit))
> > +               goto out;
> > +
> >         /* Avoid further vmexits, we're already processing the virtqueu=
e */
> >         vhost_disable_notify(&vsock->dev, vq);
> >
> > @@ -134,9 +165,13 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vs=
ock,
> >                 u32 offset;
> >                 int head;
> >
> > +               if (used_count =3D=3D used_limit)
> > +                       added |=3D vhost_vsock_flush_used(vq, &used_cou=
nt);
> > +
> >                 skb =3D virtio_vsock_skb_dequeue(&vsock->send_pkt_queue=
);
> >
> >                 if (!skb) {
> > +                       added |=3D vhost_vsock_flush_used(vq, &used_cou=
nt);
> >                         vhost_enable_notify(&vsock->dev, vq);
> >                         break;
> >                 }
> > @@ -153,6 +188,7 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vso=
ck,
> >                         /* We cannot finish yet if more buffers snuck i=
n while
> >                          * re-enabling notify.
> >                          */
> > +                       added |=3D vhost_vsock_flush_used(vq, &used_cou=
nt);
> >                         if (unlikely(vhost_enable_notify(&vsock->dev, v=
q))) {
> >                                 vhost_disable_notify(&vsock->dev, vq);
> >                                 continue;
> > @@ -230,8 +266,8 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vso=
ck,
> >                  */
> >                 virtio_transport_deliver_tap_pkt(skb);
> >
> > -               vhost_add_used(vq, head, sizeof(*hdr) + payload_len);
> > -               added =3D true;
> > +               vhost_vsock_add_used(vq, &used_count, head,
> > +                                    sizeof(*hdr) + payload_len);
> >
> >                 VIRTIO_VSOCK_SKB_CB(skb)->offset +=3D payload_len;
> >                 total_len +=3D payload_len;
> > @@ -264,6 +300,7 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vso=
ck,
> >                         virtio_transport_consume_skb_sent(skb, true);
> >                 }
> >         } while(likely(!vhost_exceeds_weight(vq, ++pkts, total_len)));
> > +       added |=3D vhost_vsock_flush_used(vq, &used_count);
> >         if (added)
> >                 vhost_signal(&vsock->dev, vq);
> >
> > --
> > 2.53.0
> >
>
