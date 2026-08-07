Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A5F3B38B1
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 02:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786068899; cv=pass; b=IeuQ55JdvBgfuHcLHLfF4T79hLKVN/Ro2eVYiArGycuPc7DznRccTj7mlLy8S3o0xKR45YJqW18i9rTDW4kHaoNKVOmxHE1G2Y5ADW7z7YxnjFt3IkqZ19T2xto+k7TnrUUBWfHDTDxvJw7LJkRz8iW6O12JbWMZhlDCY39W1mg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786068899; c=relaxed/simple;
	bh=s+xKiFHJBBy/E7iKJRql1oR+GWR7kgeVVxD2wlIPY08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=avxdxeO9gj6/ansYL9JSmAOZxSx5EgMZcrTR15jwUTM2Dh/d1nO7+g3sP+dgO9LdVAC5NgCPkgxp9KJRtfa6F3orlIdUSDj01MSnQQWf1WzkgNYXbXNqJM3kUNlxINRR7lqE9uQUwcx/Yo+wNo1YzS3Dz1ccSoKSAd85HIhkhqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K3LTefH5; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K3LTefH5"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cab97c86bdso35805ad.1
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 19:14:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786068897; cv=none;
        d=google.com; s=arc-20260327;
        b=koO8QUqTYqFCExLAvrN+dLpigtM5u0spRUpkPSE55CJ7TzZhXqtaBRpPNVqRzXeARz
         Y6/zlQFzLHw6646DdcbJzdxKDXhm1Dc8CEP5l10lzGWvVJRyhAPlInUQldelUHPyVFXF
         Gt/R/3FogRgp4JUfa2wE9ko+8wUM1WycXjX9b0mly5TMSa/W3FBUuUneqg0/EZtgkKIt
         5bErm17MLtIhL8KSH3IQpyFfMo9QUu2IL3AlIQ0J4oXwcGSuwcSS0mn5WKQTy6HttBHN
         ZLhLWE/rvPOp/wNg5XT3HeyKazDfL5z6aKzyZz0czI76urjXXx8QPysBNMJx8vh9u/Ul
         EgPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2P5MhNiHPzKjEEF/TkYbXp0YfkRl5rdJJLPIXj8lWFI=;
        fh=fOg9WQE1C3/9wS3sMSfE5Llamkf/7WhE532m7HYlG6w=;
        b=GbkUf2Hggd9WEsMeiuqylJ5hFCTQCSwSC/3RgoAhu34NXwtOPfPYGbfBOUN8/xprw6
         NYXfB8QWKkbUZk/WIIfrTiqMw56wX5MtTTHaOydtnDKVAhmK9P8DSAxhiEcO6ThnWged
         vwBMn+BjI3qZl71E0ncf0DGgxxUHdizXLMPE1c93D6FeollfPQc0lBPNtj26nvI4QV0e
         +QFENKDjAwASVh+IE9YVjQGDw+VWcR/3VhrCCTaZAe4Wtv0pyJgFEsc6mMravNgZ0deh
         BkzMIgvucc87kfRD/kLp8bB5re/If09wo+qyaY2keDOerSrvtAx/bP1pFLKZbZiUMF9v
         TP9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786068897; x=1786673697; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2P5MhNiHPzKjEEF/TkYbXp0YfkRl5rdJJLPIXj8lWFI=;
        b=K3LTefH5BHEqZAn/f9tXFDCsqIsuXO0JPfre/2jnhnU2SE3l4yqKOuogNsDYjFs0Pk
         Yaqm3rd91Nd86xr2yYMOxHzLM+riyI6JjxwuQM0AS7GOCUymCBZIuf5yWt18i3qJDKrt
         I7EO0oAGVvmhPusCgCCcgdQtcwjbFsTrsN5siwsOErRQe1yXYfN1RUkg3IVXXPI/BN7R
         ByB1Eh4rS4encG3jkJFClrxu5coMV9uROdVyOwNwDDKxZfRtzMFfG1c5doaJU6Cy0Li3
         van9d6e6G7RSC0U/ZceXTFz7kfpRIorgoN/rtxM21PpQleKWv9Il9On5wYq6Ihju4fj3
         0zeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786068897; x=1786673697;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2P5MhNiHPzKjEEF/TkYbXp0YfkRl5rdJJLPIXj8lWFI=;
        b=IDECUr8itAg3b5pJLGtYz0hno8DZQvYzbtMLeJWUx9XXrROo+PRvCW2FTrua1uSVGZ
         +F1T62eIIVk6V7nmlVSCHuDdTVgG4GpJp8Z1YchG6yqppIEhyuOeZFrNbXAFwOaaVdOI
         7BmLa7zP8rzbYYJFk15lMfrDMwu+eO6RL2TcFHbupJ77Y7mgvp7u6UR1GzygJ0ew9bQj
         H2JZVHFZIAvPJiaX2zrpG/saoSjDDPkF6QpgzfRzPfbT+BpNZBzma0gSmS/XMo1Ud4G2
         ODTncL45DBcxJVpoIr1/r5ZEuQDdn4AGa2q1DlRDdsog0qQYFoLcraUUacszYQO4lk+f
         mqbA==
X-Gm-Message-State: AOJu0YwUYDEKMnQ4OvvDdp5E00Ayud1Iit5IibVbLsVkupHfMhxB6Zmv
	oesn+VUUZ+ySxlj9F+Zlur9jj6QAmGRvc1jx81h2aAL3mQyPT5a3ZZi03VHOnhEq0l/s0RxUC8Q
	ZSFSeCH/+xN9JganEpcMsYPTS2bOQFTyb7zq8twoi
X-Gm-Gg: AR+sD12svR6x9/cmkz0xzHIZAH0aIDp04LI3Th2xQg2PsFSO+0YKgx5jBqWkXao/gCb
	atx6kQ8VhaWEOMgouh/ep6ApPlcYpHs1ORkMw+TvPwblBj7iRJy0M2EK1+zDigx4ld3MTKEjECN
	GbAreBuBV4Oo9S9GGjUTulWba1qW+JVhJg5BWc4gpNZgD9V8cJopccRVKANGve8Xn3rpLMxMt8Q
	NqwGO+7UrbqCrra2Iqwf3FPSlOoUx0OQEnIlWF4O2g+P5s37SskX5sD4Nl9lcUibXqtBkoJ1K5a
	b+aXr78t+lpNNSU+T+m+1Vv2QKR5vS7oEExpZBDlx33RZquq0ho1PXp1D9dPsZ3L9LjXkGK3dRZ
	Mt/MJ9/9VyI2eXxPzOIb/teWjbfvEWAL2aEZIw5S5hdUPXA==
X-Received: by 2002:a17:903:3113:b0:2c6:99be:9dd with SMTP id
 d9443c01a7336-2d120453f39mr3897575ad.12.1786068896136; Thu, 06 Aug 2026
 19:14:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803184630.3813311-1-hramamurthy@google.com>
 <20260803184630.3813311-5-hramamurthy@google.com> <6bb3205d-e9b9-4f18-8d8a-5bde4d014084@intel.com>
In-Reply-To: <6bb3205d-e9b9-4f18-8d8a-5bde4d014084@intel.com>
From: Harshitha Ramamurthy <hramamurthy@google.com>
Date: Thu, 6 Aug 2026 19:14:45 -0700
X-Gm-Features: AUfX_myuze9JU7w6bPUkVxEX0R5VeDbSrPzG_JXTCAzhpHfrqxcV_HlAKdjaei0
Message-ID: <CAEAWyHewnJ3DpbeaMiYcHnbpFz09weW6FBfvmX1FcFX2g1AFAg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 04/15] gve: add struct gve_device_info to hold
 device properties
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org, joshwash@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, jordanrhee@google.com, 
	willemb@google.com, nktgrg@google.com, maolson@google.com, thostet@google.com, 
	jacob.e.keller@intel.com, debarghyak@google.com, kees@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 12:19=E2=80=AFAM Przemek Kitszel
<przemyslaw.kitszel@intel.com> wrote:
>
> On 8/3/26 20:46, Harshitha Ramamurthy wrote:
> > In the current AdminQ mode, device properties are written into
> > struct gve_device_descriptor that is allocated in shared memory
> > between the driver and device. In the upcoming MailboxQ mode,
> > these properties will be returned in the response of a mailbox
> > message. Hence, add struct gve_device_info as the structure that
> > holds all the properties that are negotiated with the device in
> > either mode.
> >
> > Change the AdminQ mode method gve_adminq_describe_device()
> > and its children to fill up device information into this newly
> > introduced struct gve_device_info. Move a few helper functions
> > and code that set device properties in the priv structure into
> > gve_init_priv(). So now gve_init_priv() calls/does the following:
> >
> > - gve_set_mtu()
> > - gve_set_mac()
> > - gve_set_queue_properties()
> > - gve_set_buf_sizes()
> > - set flow steering and RSS properties
> > - set other priv properties
> >
> > When MailboxQ support is added, device information will be filled
> > into the same structure and the same gve_init_priv() path would be
> > used to set device properties to ensure common code reusage.
> >
> > These changes are refactors only, no functional change.
> >
> > Reviewed-by: Willem de Bruijn <willemb@google.com>
> > Reviewed-by: Jordan Rhee <jordanrhee@google.com>
> > Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> > ---
> > Changes in v3:
> > - Read default_min_ring_size from device info instead of priv
> >
> >   drivers/net/ethernet/google/gve/gve.h        |  29 +++++
> >   drivers/net/ethernet/google/gve/gve_adminq.c | 115 +++++++++++-------=
-
> >   drivers/net/ethernet/google/gve/gve_adminq.h |   6 -
> >   drivers/net/ethernet/google/gve/gve_main.c   | 101 +++++++++++-----
> >   4 files changed, 170 insertions(+), 81 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethern=
et/google/gve/gve.h
> > index c280ff35ee77..021adb9108df 100644
> > --- a/drivers/net/ethernet/google/gve/gve.h
> > +++ b/drivers/net/ethernet/google/gve/gve.h
> > @@ -797,6 +797,34 @@ struct gve_ptp {
> >       struct gve_priv *priv;
> >   };
> >
> > +struct gve_device_info {
> > +     enum gve_queue_format queue_format;
> > +     u16 default_tx_queues;
> > +     u16 default_rx_queues;
> > +     u16 max_tx_queues;
> > +     u16 max_rx_queues;
> > +     u16 default_tx_ring_size;
> > +     u16 default_rx_ring_size;
> > +     u16 max_tx_ring_size;
> > +     u16 max_rx_ring_size;
> > +     u16 min_tx_ring_size;
> > +     u16 min_rx_ring_size;
> > +     u16 max_mtu;
> > +     u8 mac[ETH_ALEN];
> > +     u16 max_rx_buffer_size;
> > +     u16 header_buf_size;
> > +     u32 max_flow_rules;
> > +     u16 rss_key_size;
> > +     u16 rss_lut_size;
> > +     u16 tx_pages_per_qpl;
> > +     u16 num_event_counters;
> > +     u64 max_registered_pages;
> > +     bool default_min_ring_size;
> > +     bool nic_timestamp_supported;
> > +     bool modify_ring_size_enabled;
> > +     bool cache_rss_config;
> > +};
>
> you could save some bytes of the struct size by reordering fields

I did run pahole on this struct previously:

$pahole -C gve_device_info gve.ko
struct gve_device_info {
enum gve_queue_format      queue_format;         /*     0     4 */
u16                        default_tx_queues;    /*     4     2 */
u16                        default_rx_queues;    /*     6     2 */
u16                        max_tx_queues;        /*     8     2 */
u16                        max_rx_queues;        /*    10     2 */
u16                        default_tx_ring_size; /*    12     2 */
u16                        default_rx_ring_size; /*    14     2 */
u16                        max_tx_ring_size;     /*    16     2 */
u16                        max_rx_ring_size;     /*    18     2 */
u16                        min_tx_ring_size;     /*    20     2 */
u16                        min_rx_ring_size;     /*    22     2 */
u16                        max_mtu;              /*    24     2 */
u8                         mac[6];               /*    26     6 */
u16                        max_rx_buffer_size;   /*    32     2 */
u16                        header_buf_size;      /*    34     2 */
u32                        max_flow_rules;       /*    36     4 */
u16                        rss_key_size;         /*    40     2 */
u16                        rss_lut_size;         /*    42     2 */
u16                        tx_pages_per_qpl;     /*    44     2 */
u16                        num_event_counters;   /*    46     2 */
u64                        max_registered_pages; /*    48     8 */
bool                       default_min_ring_size; /*    56     1 */
bool                       nic_timestamp_supported; /*    57     1 */
bool                       modify_ring_size_enabled; /*    58     1 */
bool                       cache_rss_config;     /*    59     1 */

/* size: 64, cachelines: 1, members: 25 */
/* padding: 4 */
};

>
> > +
> >   struct gve_priv {
> >       struct net_device *dev;
> >       struct gve_tx_ring *tx; /* array of tx_cfg.num_queues */
> > @@ -929,6 +957,7 @@ struct gve_priv {
> >       struct gve_nic_ts_report *nic_ts_report;
> >       dma_addr_t nic_ts_report_bus;
> >       u64 last_sync_nic_counter; /* Clock counter from last NIC TS repo=
rt */
> > +     struct gve_device_info device_info;
> >   };
>
>
> [..]
>
> > -int gve_set_mtu(struct gve_priv *priv,
> > -             struct gve_device_descriptor *descriptor)
> > +static int gve_set_mtu(struct gve_priv *priv)
> >   {
> > +     struct gve_device_info *device_info =3D &priv->device_info;
> >       u16 mtu;
> >
> > -     mtu =3D be16_to_cpu(descriptor->mtu);
> > +     mtu =3D device_info->max_mtu;
> >       if (mtu < ETH_MIN_MTU) {
> >               dev_err(&priv->pdev->dev, "MTU %d below minimum MTU\n", m=
tu);
> >               return -EINVAL;
> >       }
> >       priv->dev->max_mtu =3D mtu;
> > +     priv->dev->mtu =3D priv->dev->max_mtu;
>
> nit: I would just use `=3D mtu`
>
> >
> >       return 0;
> >   }
> >
> > -void gve_set_mac(struct gve_priv *priv,
> > -              struct gve_device_descriptor *descriptor)
> > +static void gve_set_mac(struct gve_priv *priv)
> >   {
> > -     eth_hw_addr_set(priv->dev, descriptor->mac);
> > -     dev_info(&priv->pdev->dev, "MAC addr: %pM\n", descriptor->mac);
> > +     struct gve_device_info *device_info =3D &priv->device_info;
> > +
> > +     eth_hw_addr_set(priv->dev, device_info->mac);
> > +     dev_info(&priv->pdev->dev, "MAC addr: %pM\n", device_info->mac);
> > +}
>
> whole function is rewritten (in git sense), and it was just added in
> previous commit
>
> one way to avoid that is to extract "mac" variable in the prev patch,
> and here only update the assignement and function signature

Makes sense, will be easier to review the diff. Will make this change.

>
> > +
> > +static void gve_set_buf_sizes(struct gve_priv *priv)
> > +{
> > +     struct gve_device_info *device_info =3D &priv->device_info;
> > +
> > +     if (device_info->max_rx_buffer_size > priv->max_rx_buffer_size)
> > +             priv->max_rx_buffer_size =3D device_info->max_rx_buffer_s=
ize;
> > +
> > +     if (gve_is_dqo(priv) &&
> > +         priv->max_rx_buffer_size > GVE_DEFAULT_RX_BUFFER_SIZE)
> > +             priv->rx_cfg.packet_buffer_size =3D priv->max_rx_buffer_s=
ize;
> > +
> > +     if (device_info->header_buf_size)
> > +             priv->header_buf_size =3D device_info->header_buf_size;
> >   }
> >
> >   static int gve_init_priv(struct gve_priv *priv, bool skip_describe_de=
vice)
> >   {
> > +     struct gve_device_info *device_info =3D &priv->device_info;
> >       int err;
> >
> >       /* Set up the adminq */
> > @@ -2514,7 +2533,7 @@ static int gve_init_priv(struct gve_priv *priv, b=
ool skip_describe_device)
> >       if (skip_describe_device)
> >               goto setup_device;
> >
> > -     priv->queue_format =3D GVE_QUEUE_FORMAT_UNSPECIFIED;
> > +     device_info->queue_format =3D GVE_QUEUE_FORMAT_UNSPECIFIED;
> >       /* Get the initial information we need from the device */
> >       err =3D gve_adminq_describe_device(priv);
> >       if (err) {
> > @@ -2523,6 +2542,8 @@ static int gve_init_priv(struct gve_priv *priv, b=
ool skip_describe_device)
> >               goto err;
> >       }
> >
> > +     priv->queue_format =3D priv->device_info.queue_format;
> > +
> >       err =3D gve_set_num_ntfy_blks(priv);
> >       if (err) {
> >               dev_err(&priv->pdev->dev,
> > @@ -2546,12 +2567,34 @@ static int gve_init_priv(struct gve_priv *priv,=
 bool skip_describe_device)
> >               netif_set_tso_max_size(priv->dev, GVE_DQO_TX_MAX);
> >       }
> >
> > -     priv->dev->mtu =3D priv->dev->max_mtu;
> > +     if (gve_set_mtu(priv)) {
> > +             err =3D -EINVAL;
> > +             goto err;
> > +     }
> > +
> > +     priv->num_event_counters =3D device_info->num_event_counters;
> > +
> > +     gve_set_mac(priv);
> > +
> > +     gve_set_queue_properties(priv);
> > +     priv->modify_ring_size_enabled =3D device_info->modify_ring_size_=
enabled;
> > +
> > +     gve_set_buf_sizes(priv);
> > +
> > +     priv->max_flow_rules =3D device_info->max_flow_rules;
> > +     if (priv->max_flow_rules)
> > +             priv->dev->hw_features |=3D NETIF_F_NTUPLE;
> > +
> > +     priv->rss_key_size =3D device_info->rss_key_size;
> > +     priv->rss_lut_size =3D device_info->rss_lut_size;
> > +     priv->cache_rss_config =3D device_info->cache_rss_config;
>
> I don't know, especially with your MailboxQ coming next, if following
> makes sense, but I wonder why you have to copy whole device info into
> priv (or IOW, hold two copies of most params)?

For the upcoming mailboxQ control plane path, device properties will
be negotiated with the device before the priv structure is available.
Hence this struct is introduced to hold device properties. Also the
idea is that gve_device_info contains properties negotiated
with/returned by the device while priv tracks active driver
configuration properties.

>
> Alternative will be to use variables from device info everywhere,
> you could even achieve that without any code changes via struct_group
>
> > +
> >       priv->numa_node =3D dev_to_node(&priv->pdev->dev);
> >       priv->tx_cfg.num_xdp_queues =3D 0;
> >       priv->rx_copybreak =3D GVE_DEFAULT_RX_COPYBREAK;
> >       priv->ts_config.tx_type =3D HWTSTAMP_TX_OFF;
> >       priv->ts_config.rx_filter =3D HWTSTAMP_FILTER_NONE;
> > +     priv->nic_timestamp_supported =3D device_info->nic_timestamp_supp=
orted;
> >
> >   setup_device:
> >       priv->xsk_pools =3D bitmap_zalloc(priv->rx_cfg.max_queues, GFP_KE=
RNEL);
>
