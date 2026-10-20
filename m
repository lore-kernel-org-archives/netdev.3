Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792488225;
	b=PtjL3kUuvZItVz4g3aLAXnbo6JONvbpYbcBUP/nHujDX3ccZZW/PwnPiwReKBhSdhExS
	 M5KBw7IQjWmpBOrtulKU6rVG/50ZfZI0vDVRqxqGV9WlDdcD6CXpB7tl9nB1vDXRa6uUX
	 LUaOY06Jp0rrDD5rVnI+HleMQfwHvkOYjk8njcbhlfFsibQgEDCm/h2QOMyVDSgFVKGTs
	 v7rc8x18J1P0RUqW6pl8iiwTE8MHBijAvfhICeY53G3D3dGgvPTyOPKvf+OqOKYd6iprZ
	 FWK80bw0daZ/uV75Y4iTJlfAis8cjYmAk5D1sqJj8GHjWGmzmnR8t6qQeQSefw1/Mlw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792488225;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=SHMt9246WTDFLEZePkrRxUyIIpSwpuVsNNwsVJXluYs=;
	b=wU0w4qqspaCXtqXxkyBC8ecizT6q6mGO8yiNgcl2TIxpGLv2HyVinGSngG3PqB6HcI9q
	 GuWHGGDXdV9w8cXJXQUdemajZsoBcYa2FCQXhx2WuWH9eEHvw3mMENYqiPbitRF0lkoyK
	 IEFYxD2OwDCqVAVjALCmpAifwCgLPBXP49N2K9IlUqGaG/50VqrtYnWd6FGc9ABEBfWZl
	 IIIOy2DVzIpAwZKZpOVDRCLEtp2E5c28ZheDHDNkzSDGJAapy5YskbCQe+RLaE/jvSZLq
	 5eu+BZKbihdyjZpG92Zc6kUb62WUr9Xi9/gzrckCulwgbrmvflTfinPnJXCZeBMGeYw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fKxi19eB;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=hby2gAxc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EEE606A31A
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 09:23:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8EEE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fKxi19eB;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=hby2gAxc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792488224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SHMt9246WTDFLEZePkrRxUyIIpSwpuVsNNwsVJXluYs=;
	b=fKxi19eBDqL3yKqglxo6ismH6CQTrzt40UMc71f0SDqBrSoYuZAZzBvW3JcRky7KJmIAYN
	smsgcnrlza2t8WLWTxveuKEX226CHhS2nh1OAixWOT5yGPMD6r6lFM02fcyW4EBqrEG2M3
	do9HvoCJ6Vzjc2zggAPcGoYplWhXVvM=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-7JVGulHJOMmMWOi6KaNPvw-1; Tue, 20 Oct 2026 09:23:36 +0000
X-MC-Unique: 7JVGulHJOMmMWOi6KaNPvw-1
X-Mimecast-MFC-AGG-ID: 7JVGulHJOMmMWOi6KaNPvw_1792488216
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-8afde3fe132so34758017b3.0
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 02:23:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792488216; cv=none;
        d=google.com; s=arc-20260327;
        b=KYQB7PKD8D+b93e3mLvyVgM7SnAuT1vewcddD/+K218PlDpO+KdoE0dAos7KW1EUvM
         H07xxLL9/jii5t2x12LqxDyFP134BBKEOlkT0x5W3Ux2bbZlcZNPPIFvgGQc/KHpvyW6
         9BvmvjkNdi2fhTXPZreD7Yo0X52/M6z4cv6Er6ztYS0g6sgCKmqB7Br50aC5LMV9ZjiA
         tmvl6L/Jnx2VWb8FnE3fok8EznYmEqiUptp3wUZtHbhB2lgZ3TUxqSzop/zCg6M0KJms
         D3JBtbpfnDg4x6PdhTtnc64Wlvi0crYwlWlMbg6wQ0Tw1TLbiR5PJ7uoU3ie8InCddLg
         KofA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SHMt9246WTDFLEZePkrRxUyIIpSwpuVsNNwsVJXluYs=;
        fh=alaC+mryaxo5TfZBUXiW5y7xSc9i5Al83F1ZbIpvTpk=;
        b=pa6uWN8XqRZtNEjIyCKYpK7JV1oZstU+EHmyNWaJD7SDt2aWNgKWc5/S8Pc/UGM//P
         bUNZ/Vn2uMHlIcsj/UyYCx2rb5WsGSxbw+jiXzZoYum9tBv7QVPoDu/RIKfXMsyKYoaU
         nEneJbfU4+lBvMr8g11Kw+wTknOMPxV7r2KglX0vFQFc8NVoOajsThJlTwLu8LZqStCy
         Fok1Trhm/5njAx8hewP9al4jEl5GpRtzTBZm5R83BL0dAUyCelQTorw4uxFJPbTd1waj
         EBOF8+pRGaZToDjckKZKzf/ZK25qksUyK6xZVmUl7nFqIX46JlO1QH6azQnvzkYM1Eld
         QUmA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792488216; x=1793093016; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SHMt9246WTDFLEZePkrRxUyIIpSwpuVsNNwsVJXluYs=;
        b=hby2gAxcNdTWzdUqTNHbKoqPgYs9+RwdQYZCAT9uIZ+Jo8Pewur+omvwYgPXhn2utT
         oscV5hKctbK4ABDf64JM5NYQfaXRPDJSN+nCTqB/mrxnKl1MnTFr9HNDrpImWuALa8au
         XWQfHOnVVmlsRgTH3QjEGiTLCgIpR549YwUf0cFw/mQn9WMPAvlCepje6YYVbTzwfgOC
         fc06S+RXOtTUBlRnzP2NuZjz9JioD+1SMKDLJFdfNeIQTQzmACsanVk8CdnCjj7va7kC
         3nrrR32DwI5LAFZxc6XPbqN7foR1w0H8qfbRZqXwqTZ9zUDqqsL2wv/zoKZnXrgIcGzn
         sFWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792488216; x=1793093016;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SHMt9246WTDFLEZePkrRxUyIIpSwpuVsNNwsVJXluYs=;
        b=Gw5cpl6iG9pAdWkkfe9BwBFd5j2DrMAZQbBdD6MbkGRgHQbZQ/yDCNBsVJcvAsq32H
         1S0zaUGqA6gKrJlPXJ9HuV5WoAfRqfX5H2KKKvLa71uaZ29wmraoXlK22/Xf7mQ2Cear
         6T+RwvuiSSBc3OrVdnKWysbdXzHmKOMswiWBzKNslMqmHrZh6vXI1ZhImf+30JE1jnhN
         bPFLAhv6b2rRaYpOqZVbFG9BlGHLbVyPxmqMUsU2Dpv+m8nemjK4dUb+F2rgoO+OeJyN
         1Z7qLXbk3+ILsgz8Dkg+6gzGMz0WXH5GYjOsuTZpNPz0hH7JzKmF0YHJdCmT2zH0YpgE
         i/vg==
X-Forwarded-Encrypted: i=1; AKwUvByVsKWmwYvbc/bJ+TbdfJ2rjcMwpd1Ucdvox2qHa12RMBniWQhFhdq3UugbL95pTpsecDbouVQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYI3t4wZZbULpp92w0qKeW0ivbkdA8U5/ESQ/jP4N6D+QlJamd9t
	Z+l34bU9hWS0Woti3QFUH4Fe0O7i6Lj+cPakAL/eanTPZKvd8TgNHfJBWb69PoPJOOv6dU4IPzA
	RqkzpRxk+uCE4JyxWr4pxJGH2SYQPTRJuk8r3Xjtu430H6fW5rDw59E8dJFntRH1DmzxzktrYLc
	oZx2bVWnI0e7xPtM3S8DBAoyMwqBhUQNgG
X-Gm-Gg: AYBFou2IRngyR5UJ+67yaUbZbPwpeavFysXUMM1rWRz86VApChiJS60ukbXeo06NMUf
	SADxYcptMZbPlRED4r9NbLE53BWjeBoVai+pCP3/Mqoc3OMHcq0k3fEPblN/lZ06Weu1A00dmLI
	GylzaoJwejrDGwyTEsYUPilkKA/tTLkFhqNUcac3Wa5H3qCudo5PKk4FpJJ/d7jfNNMdhYUEquC
	0YMwSlL6EAqUv1mhCZ2i05aLYEAJcVzpcOX+eyRZhAmPWDnImAWoJt+NII=
X-Received: by 2002:a05:690c:7107:b0:8ab:41ed:c08a with SMTP id 00721157ae682-8b0f1f1a888mr37599697b3.0.1792488216204;
        Tue, 20 Oct 2026 02:23:36 -0700 (PDT)
X-Received: by 2002:a05:690c:7107:b0:8ab:41ed:c08a with SMTP id
 00721157ae682-8b0f1f1a888mr37599617b3.0.1792488215700; Tue, 20 Oct 2026
 02:23:35 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <6ad07f8a.a0c71a5e.2d2efd.977a@mx.google.com> <20261018152358-mutt-send-email-mst@kernel.org>
 <CAHk-=wiUn9EbV4TJ4J7OPY0fVc3UC+xb-pp=+rg3hRc4jQqihg@mail.gmail.com>
 <20261018174250-mutt-send-email-mst@kernel.org> <376ef9d0-b03f-4f85-aee5-46cf20eb00ae@gmail.com>
 <20261020021924-mutt-send-email-mst@kernel.org>
In-Reply-To: <20261020021924-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 20 Oct 2026 11:22:59 +0200
X-Gm-Features: AclHuK9FUCG_bUrdJCcSR0YUoQOz7ayN0KKtj2bVgQH1ECGQzQu04PmOJxsZwI8
Message-ID: <CAJaqyWfcg_K33c5hzSh83vgTvujn_M_8odcxFSTVzkcv6jQu9g@mail.gmail.com>
Subject: Re: [BUG] vhost/vringh: __get_user without access_ok leaks kernel
 memory via vDPA passthrough
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Wang Haoran <haoranwangsec@gmail.com>, torvalds@linuxfoundation.org, 
	jasowangio@gmail.com, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 8:31=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Mon, Oct 19, 2026 at 03:14:46PM +0800, Wang Haoran wrote:
> > Eugenio previously offered some additional suggestions in reply to
> > my patch email. Should these also be addressed?
>
> The following seems to work for me. Testing would be appreciated.
>
> From: Michael S. Tsirkin <mst@redhat.com>
> Subject: [PATCH v2] vringh: use get_user/put_user in the use_va path
>
> getu16_iotlb()/putu16_iotlb() pass the address produced by
> iotlb_translate() straight to __get_user()/__put_user(),
> without access_ok checked anywhere. Not good.
>
> Switch to get_user()/put_user(), which are always
> correct, and safer.
>
> But the fact is that accessing user memory like this
> will sometimes (rarely) race with page being swapped
> out, trigger EFAULT, and it should be retried
> from a worker, and vdpa_sim currently does not do this.
>
> Fixes: 42823a871fd4 ("vringh: support VA with iotlb")
> Cc: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
> ---
>
> Notes (changelog):
> v1->v2:
>     Use get_user()/put_user() wrapped in pagefault_disable() instead of
>     access_ok() followed by __get_user()/__put_user(); the helpers are
>     reached from BH-disabled sections, and __get_user() is not a valid
>     way around that (David Laight, Linus Torvalds)
>
>  drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 2 ++
>  drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 2 ++
>  drivers/vhost/vringh.c               | 4 ++--
>  3 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim=
/vdpa_sim_blk.c
> index 76dd5b0828d7..325ec8f0ab85 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> @@ -347,8 +347,10 @@ static void vdpasim_blk_work(struct vdpasim *vdpasim=
)
>                         smp_wmb();
>
>                         local_bh_disable();
> +                       pagefault_disable();
>                         if (vringh_need_notify_iotlb(&vq->vring) > 0)
>                                 vringh_notify(&vq->vring);
> +                       pagefault_enable();
>                         local_bh_enable();
>
>                         if (++reqs > 4) {
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim=
/vdpa_sim_net.c
> index a6514b5ccd86..964cdf422467 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> @@ -77,8 +77,10 @@ static void vdpasim_net_complete(struct vdpasim_virtqu=
eue *vq, size_t len)
>         smp_wmb();
>
>         local_bh_disable();
> +       pagefault_disable();
>         if (vringh_need_notify_iotlb(&vq->vring) > 0)
>                 vringh_notify(&vq->vring);
> +       pagefault_enable();
>         local_bh_enable();
>  }
>

Why not move the pagefault disable_enable to wrap just the accesses?
Future vdpa drivers could use va and we might miss the call. Also, the
reverse is also true, vdpa_sim could be configured to not use it, even
if it is not a big waste.

> diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> index 9066f9f12ba1..74836eb60c7a 100644
> --- a/drivers/vhost/vringh.c
> +++ b/drivers/vhost/vringh.c
> @@ -1213,7 +1213,7 @@ static inline int getu16_iotlb(const struct vringh =
*vrh,
>                 return ret;
>
>         if (vrh->use_va) {
> -               ret =3D __get_user(tmp, (__virtio16 __user *)ivec.iov.iov=
ec[0].iov_base);
> +               ret =3D get_user(tmp, (__virtio16 __user *)ivec.iov.iovec=
[0].iov_base);
>                 if (ret)
>                         return ret;
>         } else {
> @@ -1251,7 +1251,7 @@ static inline int putu16_iotlb(const struct vringh =
*vrh,
>         tmp =3D cpu_to_vringh16(vrh, val);
>
>         if (vrh->use_va) {
> -               ret =3D __put_user(tmp, (__virtio16 __user *)ivec.iov.iov=
ec[0].iov_base);
> +               ret =3D put_user(tmp, (__virtio16 __user *)ivec.iov.iovec=
[0].iov_base);
>                 if (ret)
>                         return ret;
>         } else {
>

