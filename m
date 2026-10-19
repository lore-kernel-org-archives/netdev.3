Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792452208;
	b=AoZCH0bAABSAlKkz0qYT8lm9HpktmlBd0P09f5Bo9UkrewUSY0K+2SyP6i/k/0zp12f4
	 gPf55H1MAo4gB1w6l5Qg4v9E4TZC2cQTNgcDa98Wop1s/kdE5lWIzGj5AW8FDXLgI9n19
	 goCWo82AAm1C8W/xDEu2dz+6LOxWpPePj9+ENoWn6q1lU/JoPDX5a5HdAYPX8+ObboZN3
	 ebqf94dNYql30zq3VqR54RlQyRkm+stOsZBSV8aSRsEQTHJeImLGB5DH4iZyzn5YdbckV
	 49Ucs/ECi+FxCrR2TxEaUetP+azcyFQFNT9zcw8TuZjAhzzf/a+d9AgfCTWj5PWmXdg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792452208;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=3liClcNQdcRAqalV+YXuv84MaDYDw0sfM0/SbIZNVcI=;
	b=CiO4lLg+WpiyWECO0pK3GdWwXJZhwQl7AkWt7FwqpzJzoWPJMe9YdsEHIps6V3m6eaAm
	 R1xRniifcKB8ffvz3/eNxx+krhSArCyp0DLlXDxkI2K70j3Ef7eaSlyedfgs8iKUjqcwt
	 z1bwbvWsMu6HnmEHkltUfzleqZccBhLbYjedb3/lL5RQHppZjk7+qZnGl3LE+r+dceDtn
	 cIoWk8a/qeep1+XpJKBI/u1djdY4lVAYZ8X4bvYos+QFHtZY3tQMjOTOzoKnmZaJw8pqn
	 4XJ3XUPBZI/Hbx1Pi6ZusOee3WSBRlmM1iOgJE6UbvU3raakNBA78t2MbtRyJ8xr1Qg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KqM6SFn9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.44
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216FC606A31A
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 23:23:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 216FC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KqM6SFn9
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c414e5d282eso305653366b.1
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 16:23:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792452205; cv=none;
        d=google.com; s=arc-20260327;
        b=DgrbJR+pDmxnDvvIX3moB8h+i3JloUe2bC7FGfcuCFe62JAjvIkoChKZpeZMrCko2m
         z193FrprmT3+Hi5i1yu+ar/uqTO2bYGqb8U4+nc6dLZ9+owE+IGrPtgzsuxDiqIeUZtR
         B+FNcoWVcPh0a/4c3IGYEs83z1tdUTHGsQU20JM4OpBsh8ALvG9iVUiWX0fWLYv5Vvxh
         AV6cGqx7rhQ67CzV4k2wkef3ETC1jGjFPFi6sAsdAZ9MSkVP7qPiYjEwRsivOdKqrjZP
         AuwixT+J2sArKiopaF835BFv2GEt/x55vI2ESWTQgjDnMBKkFuK2ZaSLUJ8SSfksjE4V
         Ro6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3liClcNQdcRAqalV+YXuv84MaDYDw0sfM0/SbIZNVcI=;
        fh=xm/smRLiuwzPpqBgl+IOdYkcAniIeUoollKzImWYIHA=;
        b=nnkGCxrJliVdwLDhQOEVUmzWoDWsZnkBd2D2JB9udjvvNRNgvlpne38aclHtyovM/E
         NsxLPESEaAqpka9yH9YMvlDLM4JlFn4r3Cb9233MCp9lH5qGlNqOrXNcABb2dF2YTdNc
         7baT3tXd/Ab1vybX78t5KkghsHtqWrLgah1+9a/xssCZMh/1oNi3l4eGg4D5OMTanahe
         pURXQaB+igSN/g4nqCuTDw4EmH4jtSUEjMbA67aN57K2KM4ZhXg5yogQBMElw8ZOFWP8
         qHfRFQRO/acYs5+yhv8+6PmhuHCQkEZvKzZ4sCFp6o5Dt6kU0G15FS4D9dMuQeYZDnzH
         dscA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792452205; x=1793057005; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3liClcNQdcRAqalV+YXuv84MaDYDw0sfM0/SbIZNVcI=;
        b=KqM6SFn9jVt07EtldgCpMwXpUpYVJ14RI+Z8AhyEgCOTLRJBOy/HUq4YUCuEDtmvsw
         5AO1NC4X+ZicKCiH7S3r7MYceNc+0AEL3CBmcCUdhOEWF5mByX3bcP8wjk6GXSj3KGXw
         5kJS/dcPNlyZKjFTdKOwjnIl7SdMIY4pC/rfWF0ZpDwRKaCj9Z0dQZ+IOfgtC5KyD7KU
         cxQPcHl+foarXWukMGJ0dNRExoxtVIvHYiU/UlsgM4xfxeLTq/Znli9/PYp7sHzOFMRd
         lPnU9hkdT12wLffkbzZdhAKYbJ1t2r9XPNoF7XROcp4ryeq/F+Q2w1i06auYwIDPUQ2w
         +cEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792452205; x=1793057005;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3liClcNQdcRAqalV+YXuv84MaDYDw0sfM0/SbIZNVcI=;
        b=HOPw3AZHvEOOD+VVX98qlhjhsBMwteMRKne++orZyBn1+Y25r7Eg6D5X5eVJhy6Ap7
         +hWa/2GrteenIh+h7Pe+v+PfUXrZi43u0o3krsgXjfbXa/biYpU04BrN7W4JnzDjBYzc
         7mSlaB3Nmn8y7mGRuc91nhoNoZJc7CIa+aeFBIbMKXm7YmOTGfVGNPrebxn0K8H6vOaE
         ffRLj+sNPxi19GeurACkFPX8RXw2v7pi8PLHblmbW7Qg9DBMKAwCwMGeeF2iDHaAr7R/
         OY1B3pUowUSFlbgeOSotFKjrAYrc481sPfib0qtsAy9+gPurV2Wgp8zjg4qI75QhaWtm
         AksA==
X-Forwarded-Encrypted: i=1; AKwUvBx6cZa1aADpfxPfR7dvsqWOjtJEnyJH8QuAMWvl1ZuoPI3TZ6gS5MVDZencUsydGb1dZnBL9/0=@vger.kernel.org
X-Gm-Message-State: AFq9FYL1iFpcvqbmjR4IcGDPwMbufwdfV/WiD4MbqPJ7kYZbJ3RT0CzF
	PBmjrY2ud9nlOIYWAj8z0m+XS2OUn0ysUs0Pcz+E322z5qD69rK7nVwJ0+5uP81c8WHE/ek6erE
	RRdHPI5FkJMFr743TcoQ3u394SgRHrw==
X-Gm-Gg: AYBFou1SkfGIYEPJEfI6GBmC0vgI3YI973yOYyOIB5xfagRt+Z93UgmFkpzQP9vc5+Z
	/iuiQDgndXcTOOlTlqpvnRBkaHCG4EF2f1VMtYTARnI0xb4aFNm0nmKu7Q5dgoaZnoLCrveB7s4
	lfuI/wkhNl/pfHsFm1dxbcJvjzS39Vy5rTN/TSMrEOLN81qHIrTqPj94RQ41AbegAbKE0AXbRMx
	cDvBOvm2b7ONbYQX0zpx+tle28b0fZXsOB4omMEh+RFQ2IWNq7Dib0JvnuNL+QzEeyfrFO9niPR
	icPUxD4BsfaMZiWtcY0enL/8b2h8xB4/FAlvouJP3hCLk/QySNduSLsJmeWKqWr9FHLnTblLcVV
	StozhJ4bbLU5/eZQUrQvHpYyJDdj0GVK0aSQerz9A9fAKcZfk5IlqUmtQeW6W8tqmSblj
X-Received: by 2002:a17:907:9614:b0:c2e:8eb7:53e8 with SMTP id
 a640c23a62f3a-c419ed3674emr829871166b.30.1792452205119; Mon, 19 Oct 2026
 16:23:25 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261016020035.3621768-1-mhun512@gmail.com> <e17bcdcf-3ae6-4444-ae18-aed0f98d5a6b@huawei.com>
In-Reply-To: <e17bcdcf-3ae6-4444-ae18-aed0f98d5a6b@huawei.com>
From: Myeonghun Pak <mhun512@gmail.com>
Date: Mon, 19 Oct 2026 19:23:13 -0400
X-Gm-Features: AclHuK_vsw1ZU2Q3bVlL6cGmC1_FQPWEDHodzuisv_SXyRG2bdJWcoh1e31ahh8
Message-ID: <CAGEsz8F6Xiwx5RQ88spip4a6Xmcmb1A3yp7WDLw9_LfJT1-eXg@mail.gmail.com>
Subject: Re: [PATCH net] net: hns: retire service work before releasing device resources
To: Jijie Shao <shaojijie@huawei.com>
Cc: Jian Shen <shenjian15@huawei.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jijie,

Thanks for the review. In v2, I will keep the dump outside RTNL and
remove the extra link-update locking. The original RTNL scope around
reinit will remain to serialize with ndo_stop(), with a state recheck
after acquiring the lock. I will clarify that draining work before
unregister makes additional serialization against unregister
unnecessary.

Best regards,
Myeonghun

2026=EB=85=84 10=EC=9B=94 19=EC=9D=BC (=EC=9B=94) =EC=98=A4=EC=A0=84 3:00, =
Jijie Shao <shaojijie@huawei.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
>
> on 2026/10/16 10:00, Myeonghun Pak wrote:
> > The remove path releases ring, PHY and accelerator resources before
> > canceling service work, allowing use-after-free. A pending worker can
> > also reinitialize the device or publish linkwatch events after
> > unregister.
> >
> > Set REMOVING, synchronize an in-flight TX timeout, then shut down the
> > service timer and drain work before unregister invokes ndo_stop.
> > Serialize reset and link-update state checks and operations with
> > unregister under RTNL.
> >
> > Compile-tested with Clang 22.1.2 (W=3D1); not tested on hardware.
> >
> > This issue was identified as part of our ongoing research while
> > reviewing kernel code.
> >
> > Fixes: b5996f11ea54 ("net: add Hisilicon Network Subsystem basic ethern=
et support")
> > Assisted-by: LLM
> > Co-developed-by: Ijae Kim <ae878000@gmail.com>
> > Signed-off-by: Ijae Kim <ae878000@gmail.com>
> > Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> > ---
> >   drivers/net/ethernet/hisilicon/hns/hns_enet.c | 37 ++++++++++++++----=
-
> >   1 file changed, 27 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/hisilicon/hns/hns_enet.c b/drivers/ne=
t/ethernet/hisilicon/hns/hns_enet.c
> > index e905f10b894e..977f054b00c3 100644
> > --- a/drivers/net/ethernet/hisilicon/hns/hns_enet.c
> > +++ b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
> > @@ -2024,21 +2024,22 @@ static void hns_nic_reset_subtask(struct hns_ni=
c_priv *priv)
> >               return;
> >       clear_bit(NIC_STATE2_RESET_REQUESTED, &priv->state);
> >
> > -     /* If we're already down, removing or resetting, just bail */
> > +     rtnl_lock();
> > +     /* Serialize the reset decision with ndo_stop and unregister. */
> >       if (test_bit(NIC_STATE_DOWN, &priv->state) ||
> >           test_bit(NIC_STATE_REMOVING, &priv->state) ||
> >           test_bit(NIC_STATE_RESETTING, &priv->state))
> > -             return;
> > +             goto out;
> >
> >       hns_nic_dump(priv);
>
> Since hns_nic_dump() can be highly time-consuming, is it really appropria=
te
> to execute it inside the rtnl_lock critical section? Holding the global
> RTNL lock for a long period might block the entire network control path
> and impact system responsiveness.
>
>
> >       netdev_info(priv->netdev, "try to reset %s port!\n",
> >                   (type =3D=3D HNAE_PORT_DEBUG ? "debug" : "service"));
> >
> > -     rtnl_lock();
> >       /* put off any impending NetWatchDogTimeout */
> >       netif_trans_update(priv->netdev);
> >       hns_nic_net_reinit(priv->netdev);
> >
> > +out:
> >       rtnl_unlock();
> >   }
> >
> > @@ -2058,7 +2059,14 @@ static void hns_nic_service_task(struct work_str=
uct *work)
> >       struct hnae_handle *h =3D priv->ae_handle;
> >
> >       hns_nic_reset_subtask(priv);
> > -     hns_nic_update_link_status(priv->netdev);
> > +
> > +     rtnl_lock();
> > +     /* Keep linkwatch events within the netdev's registered lifetime.=
 */
> > +     if (!test_bit(NIC_STATE_DOWN, &priv->state) &&
> > +         !test_bit(NIC_STATE_REMOVING, &priv->state))
> > +             hns_nic_update_link_status(priv->netdev);
> > +     rtnl_unlock();
> > +
> >       h->dev->ops->update_led_status(h);
> >       hns_nic_update_stats(priv->netdev);
> >
> > @@ -2398,6 +2406,21 @@ static void hns_nic_dev_remove(struct platform_d=
evice *pdev)
> >       struct net_device *ndev =3D platform_get_drvdata(pdev);
> >       struct hns_nic_priv *priv =3D netdev_priv(ndev);
> >
> > +     set_bit(NIC_STATE_REMOVING, &priv->state);
> > +     if (priv->notifier_block.notifier_call)
> > +             hnae_unregister_notifier(&priv->notifier_block);
> > +     priv->notifier_block.notifier_call =3D NULL;
> > +
> > +     /* Join a TX timeout that passed the REMOVING check before work d=
rain. */
> > +     if (ndev->reg_state !=3D NETREG_UNINITIALIZED) {
> > +             netif_tx_lock_bh(ndev);
> > +             netif_tx_unlock_bh(ndev);
> > +     }
> > +
> > +     /* Stop the timer and drain work before ndo_stop touches the hard=
ware. */
> > +     timer_shutdown_sync(&priv->service_timer);
> > +     cancel_work_sync(&priv->service_task);
>
> The commit message states "Serialize ... with unregister under RTNL",
> but cancel_work_sync() has now been moved before unregister_netdev(),
> which already drains the service_task.
> Is the RTNL serialization in hns_nic_reset_subtask() still necessary?
>
> > +
> >       if (ndev->reg_state !=3D NETREG_UNINITIALIZED)
> >               unregister_netdev(ndev);
> >
> > @@ -2411,12 +2434,6 @@ static void hns_nic_dev_remove(struct platform_d=
evice *pdev)
> >       if (!IS_ERR_OR_NULL(priv->ae_handle))
> >               hnae_put_handle(priv->ae_handle);
> >       priv->ae_handle =3D NULL;
> > -     if (priv->notifier_block.notifier_call)
> > -             hnae_unregister_notifier(&priv->notifier_block);
> > -     priv->notifier_block.notifier_call =3D NULL;
> > -
> > -     set_bit(NIC_STATE_REMOVING, &priv->state);
> > -     (void)cancel_work_sync(&priv->service_task);
> >
> >       /* safe for ACPI FW */
> >       of_node_put(to_of_node(priv->fwnode));
