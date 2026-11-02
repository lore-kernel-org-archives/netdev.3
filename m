Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793652052;
	b=bNImhJvPD7t3pfjDhrsq926weecdy5AkDW7PLDAsBOyeHqIAn7OsuHEzhJdS0X43o+E4
	 MMu2tePtNrTnemPTfwdgYJ3VV1q8r9npZJhxBiUXaOTGfuHU69sqXL/MEeVUUm+2TpiPm
	 9JtnHNpA05v214lYcmEi3BVO6Ou0uJdghmNdgjSFYfALMwDjt3IGALIX7W5+C36NH8DZk
	 DzBGT33IEX/9XZKBJ66dhYjyyB065M8ebUcKuY16AT1YXpxX+xf3efGqv4Dn1pmbNQteU
	 X7yDN2Av8PcE2KUFfQ9DmlJfk2/A2vc8M7MHBdv2RzBYSdtVTw27tftqCuYk0SLWyJg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793652052;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=rii+FZ54nJeZhKcJyKsTY7JZApppPOKhEtvxZ28gkHM=;
	b=CUyxirx3uwKYZ306zK16E8eamfHorBLDbl5pqbr2+i5tGzUY+RQnllyKd14fBEMgZ6j+
	 t4CAQVwIQPV/xnclA0y0kgD+hw3UxhlKkICVaUO20glJdvKqZUxCe0bxkMwK0mBk7x2ag
	 U7+iHHNDWwBwkHqNsEfnJEt+cKtwObLtPX0fc3FwszsXxj2A8cEMEEQV4pqG5Ttp6wP4Z
	 NQYfCCC7pqLksTCNboEkRblyCKylUa0a2lQlEP2OUJ5TBAPLhTJYhibpX3SyRqYVBwKhj
	 KMRDxDuUSG5vNk2XkLpy2XHbGaVUh3TWvDOsE9IoMWS18GC+FJS7tjjaq8nTtRqedYw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=eHNNvP4g;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.46
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D85606A32C
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 20:40:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36D85606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=eHNNvP4g
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6ae14cdc63aso2224a12.1
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 12:40:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793652049; cv=none;
        d=google.com; s=arc-20260327;
        b=rE7aP2IoHtM+G942MikX0sKZM7a0X/1nhH6hgh/AWRf7AStbMnDPozXfUcDVSUPbvW
         LtXw6yJ9bTkN7/L1G3BwXkYkzh9hHvhdGPCLhovKUZ6TuZO+Wfgq4h4s4kM785kRvmMy
         dLpB9N+zsD7Vgrq6ej8vBhpH9cC4TplgXeNWjnOQop2/0WJ9SD+Nn93KOsdBsWDeSQ/5
         1eAqEHdrLEEWl7uFt8Jsp5Pfm7dVw6fe3a9c0hazBzyUC0LgFRUpZbdvOG6pOOa6S4AH
         gHwLK/1mEtQPNIJ8mcmVLA0jhFx0oJqPtDDpTWEMdHj4jy+1kX8sbG7zeUFTZABd61St
         vlHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rii+FZ54nJeZhKcJyKsTY7JZApppPOKhEtvxZ28gkHM=;
        fh=rHhMJW1n6ei3x1OHTNkC63ikr42QCKERzDHZXYfMy74=;
        b=qS1fmZL70St6qpV0rh4q4Q733vgj0c1pa8YjCdY4HLvySZW7qrdG0TBq31JxT1VcW6
         e1MjlEULHUwf0TNtitbkGNwDtdfsVWjiWcuGUzCg6GevXvq2CbLvf/wufFWwGgA+xO/n
         o2fby7Qqotu1Fv8nxWSatoQin53J79Aj7XmnPBrEkkt/ZEHsFZrecmZXn6X5c7LI4BCt
         ci9AyvABYhb6u6pbPWIZRiKxIVK5CySMs7BjmTRBkztyJSW9BRq1PN0FYdPs75fbvT1P
         THk04P7YMVAm/OFx1mWDXdkwqcrJMTR3pMZ4ECHsQs3XoALsr9lVzu3XlIyr/pf7JoHu
         uDGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793652049; x=1794256849; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rii+FZ54nJeZhKcJyKsTY7JZApppPOKhEtvxZ28gkHM=;
        b=eHNNvP4gkD3jFrnE5uUMmnf91GgojEokCRr1Bj8d750eNexMgmZ8rGFlp4Hy8j4QU2
         xzu+6K68aQBmEtnDWqzd2xBxnjfoqOQ8PH0wixFaMipd+67kkunJQyI6z3wo0lQZU2dF
         vEBKFm1epjhZioAbdqRyYFTxMrL2WVzTSB+oUws9P3VLC66DjXIVql5kKhWMRhk0VQ7i
         V35M8A8pUeQhtTRXE+rpgK0B2hzGSr305ImakHHS7UF7KMWlRVgXzGQhqJnXZBzKrPC5
         8JhoSOur9ZOawQyQJJieWAXSotbOjJ39U4r9M+6lnW/94pEbAlntuJC12wSYGCi4e0vp
         hAhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793652049; x=1794256849;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rii+FZ54nJeZhKcJyKsTY7JZApppPOKhEtvxZ28gkHM=;
        b=YVDLmpDhApwlrkfYm9LFaBdYL3uvykez4BX0UpRcXPq8vzLYQO9SnoioUEThfjQAjn
         LZoce7eGkD5PxByS03LxabwCWfpuopjRhRlvR4AZQdmo4JuZCWZpa6zndJcSqUrdco5X
         MQne/IO2YrLFYaOaR6iCTzdCeSBHtcSd0o1Tq8wZgg3j2+uCqoS4skvhtTpD7cIM6DcB
         VyUZAdkIg9y2UqhgFP38/fTKLObHfVadpH+UIuCc2gXPJ0gc4546gh7PKlH6SNK72kOG
         +kzg2lkGtpB8tidsk7eCf0qLjN5Yg7m8gfbxJ+Hojg7JxPUnk8FMD0FMk1oeoV891Ztm
         lyaA==
X-Gm-Message-State: APuU4Z9YWCTDYJH8quMt7qaPg1yuGKLGbTBGjxB1LHBxOKScGC3pHDb6
	Kr3c49JF7MkKwSZvk3wjlfZNkDpw4A6ICme1GUlYQ3j2hGeCif5jSo8gHrP1l8mSys5yf6i/97l
	aV601YaqtDLvzfUgEX6XR0yIxvrwmJi4nFvvkCLyL
X-Gm-Gg: AYBFou26bp5sKwYKVfxiKzS0rVJTNBy2erm9JNIpvHm4RUIcntc5tKTsYC6n8T9DhDD
	gKETRdA2dZK54Aivm0uyLcSfZzumphusyPCEulqzq1iUc5uPa5VgXX+x7zdEwZKXHVw7QvONIGd
	HmqumHcy7++Kh3kCwAWGjv/8qG7RLjktL2mx6le/tJ3tE0HddFjzsyj2plN5wAtZfxpmaH7accm
	KPNXlFvq6v8gXeonFWcd1Wzc62hdUwlTGRY/4lxvfAjIsf8+qd1gcT5oitiZMCx7maB8VGRiLPV
	YV+uQ9Un8ZPtqHEyG8r+8OEcRhdBjBU/M4C1ihl4FwLE7o4F3YbW2qO64jcYzUvkvrCvZ2Yh1D0
	ZGQKFPRvjpNPUn2egzfyHgwGiAgTZ4JXJX2t1gNxIVWagN2aaB4A1bt+SvmvT+lgnefo=
X-Received: by 2002:aa7:d794:0:b0:6b4:2188:97d0 with SMTP id
 4fb4d7f45d1cf-6b539d22220mr5870a12.6.1793652049063; Mon, 02 Nov 2026 12:40:49
 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102191438.1059771-1-sdf@fomichev.me> <20261102191438.1059771-7-sdf@fomichev.me>
In-Reply-To: <20261102191438.1059771-7-sdf@fomichev.me>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 2 Nov 2026 12:40:37 -0800
X-Gm-Features: AclHuK-QHSUFwb7InxS-A8g0MGgfg1Hp3eU1afIQI3kknV9M7EMlKPAHYQ2ow5c
Message-ID: <CAHS8izMRtaL=kZaM29XQBodT8e+srppnK_DjNSTJnxFfNgG9aw@mail.gmail.com>
Subject: Re: [PATCH net-next 6/7] net: devmem: size TX net_iovs from the
 dmabuf sg table
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch, 
	edumazet@kernel.org, horms@kernel.org, corbet@lwn.net, 
	skhan@linuxfoundation.org, rdunlap@infradead.org, michael.chan@broadcom.com, 
	pavan.chebbi@broadcom.com, sdf@fomichev.me, bobbyeshleman@meta.com, 
	asml.silence@gmail.com, daniel@iogearbox.net, razor@blackwall.org, 
	leitao@debian.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 11:14=E2=80=AFAM Stanislav Fomichev <sdf.kernel@gmai=
l.com> wrote:
>
> PAGE_SIZE TX net_iovs cap devmem skbs at MAX_SKB_FRAGS pages (~68KB),
> which makes BIG TCP ineffective.
>
> TX net_iovs only need to be DMA contiguous. Use the largest power of 2,
> up to 2MB, which aligns every DMA segment of the dmabuf:
> - 2MB hugepage-backed udmabufs get 2MB net_iovs
> - no UAPI change, TX addresses are dmabuf offsets
> - skbs are still bounded by TCP's size_goal, only frags get larger
>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  net/core/devmem.c      | 28 ++++++++++++++++++++++++++--
>  net/core/netdev-genl.c |  2 +-
>  2 files changed, 27 insertions(+), 3 deletions(-)
>
> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index 19c039ed2cb2..98c9594dbf99 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c
> @@ -181,6 +181,20 @@ int net_devmem_bind_dmabuf_to_queue(struct net_devic=
e *dev, u32 rxq_idx,
>         return err;
>  }
>
> +static bool net_devmem_sgt_aligned(struct sg_table *sgt, size_t size)
> +{
> +       struct scatterlist *sg;
> +       unsigned int i;
> +
> +       for_each_sgtable_dma_sg(sgt, sg, i) {
> +               if (!IS_ALIGNED(sg_dma_address(sg), size) ||
> +                   !IS_ALIGNED(sg_dma_len(sg), size))
> +                       return false;
> +       }
> +       return true;
> +}
> +
> +/* niov_shift =3D=3D 0 picks the net_iov size from the dmabuf, TX only *=
/
>  struct net_devmem_dmabuf_binding *
>  net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
>                        struct device *dma_dev,
> @@ -191,11 +205,11 @@ net_devmem_bind_dmabuf(struct net_device *dev, void=
 *vdev,
>                        struct netlink_ext_ack *extack)
>  {
>         struct net_devmem_dmabuf_binding *binding;
> -       size_t niov_size =3D 1UL << niov_shift;
>         static u32 id_alloc_next;
>         struct scatterlist *sg;
>         struct dma_buf *dmabuf;
>         unsigned int sg_idx;
> +       size_t niov_size;
>         size_t niov_idx;
>         size_t i;
>         long err;
> @@ -221,7 +235,6 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *=
vdev,
>         binding->tx_max_frag_size =3D dev->netmem_tx_max_frag_size;
>         write_pnet(&binding->net, sock_net(nl_sk));
>         binding->uid =3D sk_uid(nl_sk);
> -       binding->niov_shift =3D niov_shift;
>         xa_init_flags(&binding->bound_rxqs, XA_FLAGS_ALLOC);
>
>         err =3D percpu_ref_init(&binding->ref,
> @@ -266,6 +279,17 @@ net_devmem_bind_dmabuf(struct net_device *dev, void =
*vdev,
>                 goto err_unmap;
>         }
>
> +       if (!niov_shift) {
> +               niov_size =3D SZ_2M;
> +               while (niov_size > PAGE_SIZE &&
> +                      (!IS_ALIGNED(dmabuf->size, niov_size) ||
> +                       !net_devmem_sgt_aligned(binding->sgt, niov_size))=
)
> +                       niov_size /=3D 2;
> +               niov_shift =3D ilog2(niov_size);
> +       }
> +       binding->niov_shift =3D niov_shift;
> +       niov_size =3D 1UL << niov_shift;
> +

How come we're not checknig the largest supported size of the netdev here?

Also, maybe should clarify in the cl with the largest supported size,
is it actually only powers of 2 up to that power of 2? Or all sizes up
to that (not-necassirly) power of 2 size?

--=20
Thanks,
Mina
