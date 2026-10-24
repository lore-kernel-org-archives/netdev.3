Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792803751;
	b=E1E9+HbHBFg+bDCGN+ld7UurgfkauunAVeJ2dCJi8FWelQ8ecX+4sf9dWUKDyeqNLRxQ
	 UzwcXaFaQmctfidInhtlNvLmHfu/DqhmJAhidGVej/bt2DwPOkkQcsqy9rHcl/fq2n3Ia
	 e9uafUL31WVA4+grExFn7vqmJ2A+RbwTKOL3wuq5Gq34OZvxqfheMuxQXBdnqd1Jn5XbF
	 AEZFH4YxBG1YIrPAMTEGL4YEy6R4Cwh3mBh+YOLPtiiCNbAN93JtJ0nAhUES8/Z1AbxJm
	 NiZeUwJTWqjiU+CH3FX7gizNmoksk67XA3Y7k01Uj7+RqrsHtrbOHycuGr8cZJsJaOg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792803751;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=oDzvj+xShohDhW41Zdjus/8bwn2Q2oAdGVZHK4gc8Ik=;
	b=q4j0Z5b0DrKXu9p/O+uZ+tW/QvOxU2J6osmZqgoJrmT1E4IGUmVSCTNIw5HRuldGR/O3
	 DgFS9usboMziSARAHk1hLMo7uqzBJUJ1M65m2F4pSwrWfH2/4hlBuO4gIOqiEzbEkJMC3
	 XCOQdGYXRoZjD7T3WuXzZiKfmuOMB8U6hKHZR/PdrJKKhhpJrXBmzzxwtYqtKAOY3BXNo
	 DSkl0F2yShQUSJUlgD9n72IT8lEJfDC+ksTFCwnwHOzrtHG95IB+rQemUxLDLxs4Vpyrn
	 8TLRFsKGnLU7zkqIe62zQsN+9c0J9WmPSSF8jivcGXwbOHOnwNpAXAzVPA9XnI28rbw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Eu1Gynx9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B455D606A31B
	for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 01:02:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B455D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Eu1Gynx9
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c40f29667e6so222153466b.0
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 18:02:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792803749; cv=none;
        d=google.com; s=arc-20260327;
        b=D1tDD7kmsStqwA1kDSCeFknRfqCvtfdt+tsHsj16qabHPU6aH6TNHGd+st28boiKHy
         otVmTzfKVR0OggMJHpyXC+YH+oWC6+QfQpVxmDtm8yXMG/yuV0IheIcD4d479TxweBUu
         wp5vrHZPWy78p0BlPniKEyf0a2a2fMMdawgVdKYkDJOr6gx5HGRkXvs4/YowhjUEHLz4
         UAvkGqXeI7P49w/XFkdEVQHtR3KczpvBYLDVzAI7NFAytrZ0RP5mgmggMTjiW0ELkPTz
         eUdFzNCTSCr16EEQ4y8Wme2PDpV3Y32UG6/puN5M+Rxr1GvFyW3RVoLPHTDWeZTLYVII
         VQqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oDzvj+xShohDhW41Zdjus/8bwn2Q2oAdGVZHK4gc8Ik=;
        fh=nd0H02/mG9CPbLejH3PYrlS4Yk8/yS7Y/1m1IdVCsOI=;
        b=pG6qITGur+SRIudbCL+wWm7ysbEBnY1ZP1yfiE4XK05tgh8bRD0V72IHsp4F5DOs0d
         HERzN/nvjvfVu+a+T/ur0Nbs+8TBL2yUejGf+qJqTSv0eQQRv6V4eGuf5Ip0TKR5KaWK
         gikSaSmL+JVLFeO5WjVsih9e9Nn9lWOOfB5vCkC1INDs2008JmybMSFY20kjkuJ2Tpsm
         opBowxXtteT4/dXq1EnFWU7E1zxPzv+55mnTn35Tgv+AgN698xQT+UTJ8OLkD2d+6ILa
         lmJA/tAswqZ9ljywM6JEH/0HhpSP98BMG/b6Rq3zoYk7Mp/itK2DmFAQwrSRIKQiKYEB
         gQEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792803749; x=1793408549; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oDzvj+xShohDhW41Zdjus/8bwn2Q2oAdGVZHK4gc8Ik=;
        b=Eu1Gynx9JHdZJHAzWpLJCRz23RJUI/tpfHb1S6OGcJpC6jME3983wgnmf2ZX1sgPDD
         vTdB0MZMSc83zja3PDPUOijtvtalFMssIM6HtntODZMvrSKvocE2NM8C3NqhbTjq46v8
         0s7eNmu6ou6IN2Ro6cU5ns3aUppu4AE+ab7KI1r2jMfrMPf6R3+T4+GDG2iF5s1mYuyo
         2V5ljrqaKrLRCIszXKU3XTvNXcaFR3zu1Zr5I75arVF6A9xFfWBLikXgv8CIQbfQoL+l
         8Yw+EDGgpueisHXXBruzAF8tFTmWwQeMxTw/Y+yx+xTO8WPL5hJKahhZ/B/ffjgxU31c
         OQVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792803749; x=1793408549;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oDzvj+xShohDhW41Zdjus/8bwn2Q2oAdGVZHK4gc8Ik=;
        b=zaAzSIoBk3AB6JQ4EpHdw8g8IElBgJ0NZQztubJ4yleaG7dL0tczZRQ9+qqmfYirO+
         EciB+TddeUsMtDkl6+IuBoe6KaosVaqqCzrSs+jFrdpPVJS79VBdNw3ZU6DNYvZs/SOZ
         SfWxz73Gu54J9M49NTPoUR1sZQrZf85MQCaHpxUupErQVGFNRvsB/s+iM5UMOVyo27WZ
         IpR0gDncgOfK/FSdRskl2lbPSSZ7dg7uSNEwL98ajBV855I82vBoTK6zA9T9Ay7go71v
         CQOx9L1+nbA4QJx/BtkRcmtyoldKacVD+G2xxY8QhmaFUQBmCbGCKcPM9PxUN6Oi6n+F
         Z6MQ==
X-Gm-Message-State: AFq9FYLqrCyNILZ2W76UIhGSTJUdKOnWYBMk6kmbgjGZdHeU5EIzvDHM
	4H+TjGT4kLF4oHwqv1fO5ZfxrHIxaGZvMCdwQNzwlmhrHud3z2EckCbgg/AqC/W92+rhM9oq1Tv
	4T/Q4sIXp/Wwrr18z5KaCOB2QX6Rg6N1kpU60
X-Gm-Gg: AYBFou0Lp44DwrDDdR05jsc1eSuvE3av7eQ5IBqYKG9VJcOkmTaPmLwMWBYITzW9Wiu
	0IbrQONd8wkcMgxHqNsBVsJAv7PLiXhl87e/4WuMpAV7DssXoU0vsuJvsf4EjH6I42VWTuPDadM
	jft2mhPAH6gA/Bk9Dz2JsTU/g3OYDkJ+EhlLTgu3IJKZ6mbaq5SD8lxWTmD95xotXGZzv6Gr9vB
	WnlNH5vUg7uZCpEpRY7J8VrdNrNqg2/5LWKS0ZwkLkgptaySmyQtJ1C+qI8ly6h9HIyj17Y27Os
	OVjtK72vF1auUxUSCrKXwZ3Sh3UBYiyJqbqIGwvKIzA6B1QRKjn80CCq1cgwqEj11sre0cbrtTB
	aXpOigiDmW1aHnw1ApUKpIBXwCzyK++w1AhaoGp/zglJMJpnTYKjfVRRtdR3ocp41M67wFmk=
X-Received: by 2002:a17:906:ef05:b0:c46:b9b0:8e8f with SMTP id
 a640c23a62f3a-c46bde21c02mr62177366b.41.1792803748727; Fri, 23 Oct 2026
 18:02:28 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020201537.2465655-1-prashantsengar25031@gmail.com>
In-Reply-To: <20261020201537.2465655-1-prashantsengar25031@gmail.com>
From: Prashant Sengar <prashantsengar25031@gmail.com>
Date: Sat, 24 Oct 2026 06:32:16 +0530
X-Gm-Features: AclHuK9Zzs_3WSZD_RLY-M2lGy8SjI382zxLf5M-4bIkPQ09NRQHeqm8GF6KJo4
Message-ID: <CABW1sBnq8nHsm_B9xffgrcfVo5ht_XHEQ9i5T-F=KJ1KtCdEnA@mail.gmail.com>
Subject: Re: [PATCH net v4] net: usb: lan78xx: avoid NULL PHY dereference in
 WoL setup
To: netdev@vger.kernel.org
Cc: Thangaraj.S@microchip.com, UNGLinuxDriver@microchip.com, 
	andrew+netdev@lunn.ch, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Regarding the two findings from the netdev Sashiko review:

1.MAC-level WoL capabilities on PHY-less devices

As discussed with Andrew in the earlier review, fixed-link WoL was not
properly supported through the existing PHY-based ethtool path.

The intention of this patch is to provide a minimal crash fix for net
without introducing additional WoL functionality.

Andrew suggested keeping the existing phylib handling for this fix and
implementing proper MAC-managed WoL support through phylink separately
in net-next.

2.WoL reported as disabled while pdata->wol remains WAKE_MAGIC

The observation is correct. With this patch, get_wol() reports no
enabled WoL modes when no PHY is attached, while pdata->wol may still
contain WAKE_MAGIC.

This can cause a request to disable WoL to be treated as a no-op by
the ethtool layer, leaving the internal configuration unchanged.

However, the default WAKE_MAGIC configuration and its use during
suspend already existed before this patch. The PHY-less ethtool WoL
configuration path was not functioning correctly before the fix.

I kept the changes limited to preventing the NULL dereference,
following the approach suggested in the earlier review, without
modifying the existing initialization or suspend handling.

Please let me know if this reporting inconsistency should also be
addressed as part of the fix.

Thanks,
Prashant


On Wed, Oct 21, 2026 at 1:45=E2=80=AFAM Prashant Sengar
<prashantsengar25031@gmail.com> wrote:
>
> LAN7801 supports fixed-link configurations without an attached PHY.
> However, lan78xx_set_wol() unconditionally passes netdev->phydev
> to phy_ethtool_set_wol(), causing a NULL pointer dereference when
> a userspace WoL request reaches this path.
>
> Report no WoL capabilities when no PHY is attached, and return
> -EOPNOTSUPP from lan78xx_set_wol() before modifying the wakeup
> configuration. Keep the existing phylib WoL handling for devices
> with an attached PHY.
>
> The issue was reproduced using USB Raw Gadget and dummy_hcd in QEMU.
> An ETHTOOL_SWOL ioctl triggered a kernel Oops with the original
> driver. With this change, the PHY-less configuration no longer
> advertises unsupported WoL operations, avoiding the crash.
>
> Fixes: e110bc825897 ("net: usb: lan78xx: Convert to PHYLINK for improved =
PHY and MAC management")
> Signed-off-by: Prashant Sengar <prashantsengar25031@gmail.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---
> v4:
>   - Remove the unrelated blank-line change noted in review.
>   - Preserve the existing spacing in lan78xx_get_wol().
>
> v3:
>   - Report WoL as unsupported when no PHY is attached.
>   - Keep the existing phylib WoL handling for attached PHYs.
>
> v2:
>   - Use the phylink API instead of calling phylib directly.
>
> v1: https://lore.kernel.org/netdev/20261018151830.643511-1-prashantsengar=
25031@gmail.com/
>  drivers/net/usb/lan78xx.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
> index 5655941f1478..4f100bec5b3a 100644
> --- a/drivers/net/usb/lan78xx.c
> +++ b/drivers/net/usb/lan78xx.c
> @@ -1764,6 +1764,12 @@ static void lan78xx_get_wol(struct net_device *net=
dev,
>         u32 buf;
>         struct lan78xx_priv *pdata =3D (struct lan78xx_priv *)(dev->data[=
0]);
>
> +       if (!netdev->phydev) {
> +               wol->supported =3D 0;
> +               wol->wolopts =3D 0;
> +               return;
> +       }
> +
>         if (usb_autopm_get_interface(dev->intf) < 0)
>                 return;
>
> @@ -1795,6 +1801,9 @@ static int lan78xx_set_wol(struct net_device *netde=
v,
>         if (wol->wolopts & ~WAKE_ALL)
>                 return -EINVAL;
>
> +       if (!netdev->phydev)
> +               return -EOPNOTSUPP;
> +
>         ret =3D usb_autopm_get_interface(dev->intf);
>         if (ret < 0)
>                 return ret;
> --
> 2.55.0
>
