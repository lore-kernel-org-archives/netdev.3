Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793183470;
	b=y5Yp38iZvtst2lqwHLbKlvnKzkC8RcOF0TCKfE2fvpKHkO1bb4zrCTur5xh1nFaSrcOd
	 ZFXp3x0K1+lL1Ibnkmpd/yv5XzlHpGqLV8DEgAgW/xjUML5pJ2K6kZrD99PQ/xCwYVJ2f
	 V1zivkKIvfSYIYt44QBVhP65RryjWXLCmP/nYZpMFuPRrsNV4chq4o8fw9CyMmqEeRIrH
	 RO0clKLw3ntFwV3N6BT+1WKnxsdv3zzErCJ2OXUXHyZyjuQvlkGCSQWHa3NPZxU2fY8eN
	 dtYZuBWMCIgnmDLU7uJKhE2JLNe32Q5p9/XBt8Et07kLErt346Pl8yT32n0ss8W5eKg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793183470;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=imedKiikY/nJ9ieNEErDb82QaTr2XE4LPwGTpWh9iBQ=;
	b=kCn5TUMZ9nzMAjAkzHnZCoDTD3phhYt17ncRLUDOzsoZJAY3vYRNgoG2ggLON5AO13fQ
	 t/kFsHx4JmUEo59QuDjZ4jfnAqa0umpag7TjDMpMs/CsIjznX6GD3CcNk9fFy4vtr5tOK
	 pTmpxLFcLWvz+4pxfZgKnby7ks6nUatVdb14n+p/MaJmI2TU3KkJoSeUPLzhQ9U7p+86S
	 VUg8ksRN2hBu7CAKmSq17ATI0CLuXYseqQZ3uJpPfTvmxlMhsGiK7hIVq8hgKyMIv9qXl
	 JgqdQML0UAB4vqBMa/dQg4RUzDVh2JMi4pxDQQBrGeUPSc50BgV7EJlS/QF8QL+kkTQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="acd/2w7M";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.170
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD6D606A31E
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 10:31:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFD6D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=acd/2w7M
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-8ae8607e8afso5456517b3.3
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 03:31:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793183469; cv=none;
        d=google.com; s=arc-20260327;
        b=GOolkpk2KdMfnz0GoYYFYr7BZf7fdBKwg4/npkHvJG+xmxXu5rQHOmml7Zgt6TwbcY
         7HBxBWq4nrTgGF2UaYJRYCuljQjXprgDoyuXojJoEtfaClpOZJlBwCPp1iAGNZv6uFkN
         ZdMbchHxIokpElDzgb5a0wCY1mAjsEm77w5M6mU237JKF0D7X0bMRoKxUAQs8DEf5A8L
         Bp85vuRCMTsCFhcB/R/CqMARGl7pYnZCU7rfwOgPx/9bnX1u5G0a98/lThSF/6wpbou1
         tfB3YmOsjPkPrgm9rotBpd/o7IiQnQLu2EcBC/PHQfm5I74M6cPbdh+Cjrk9uEW+qYXw
         bIKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=imedKiikY/nJ9ieNEErDb82QaTr2XE4LPwGTpWh9iBQ=;
        fh=7JXwbiQQJthWkTyuE7R4n+AMSNL2MA1PMzOsoj4FE7Y=;
        b=RXUJPHM3zHfkT03l6CMTxDH2yaONidvT2wB1oOfg5il+5gzJFXOq48DeBqkaRl9h9n
         N7Hs3kEyOwMtWp+hChqt0f70EgXVneOcW1LM/nZXMBvPUO906c3UI92kisskApMbWO2l
         Yg3vAEvzUpDNWdYE0Bk49q2G88lkcvhTPXOmEGMcNosF5om1J9NO5Hxf93pUQo5pmnvA
         MIxh1gcbmocIJzpzBS6FnoOzRppqt0ncm2gcY8PeT3bDf7R6kVreVQ0GyeE2kRJmW3kt
         VL4bNT+e6aY2SNJSKXAXnMr7A0EeKWB5Rvd3A36RMA6RzDksFyfxNYXCCrimi+Aet5hx
         D53A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793183469; x=1793788269; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=imedKiikY/nJ9ieNEErDb82QaTr2XE4LPwGTpWh9iBQ=;
        b=acd/2w7MTsRZz2fFWnc39WSDc2rQa1UN77+0V71vGBIvU1BtdTJxa4P/P7EZr2AcY7
         Nwv7xwu0bGsj7QtSi5UsT8dbx5Wue8cf4bxRWlypcKhjIYbFwp46OBkIOBbwE9TWOaJO
         WYnQJ0snsSlcoyioYnXSIK+CdCtLMbq6jHCzWYUuLO9TzTkTDEHIFZ7lVeW6RfyJEaH1
         bPTI01p8rtEzyTmI81cFhoA7TM6Yppegg99Lsod3LSXmBgaItToTEJTZB8Ov35iECfKA
         eaTQXWObo9yF2TtcrzLzhMh4JFdL22+KcUWsK8amtIcyVf8B8fR6wUfsvGq1yj/w43/b
         JJTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793183469; x=1793788269;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=imedKiikY/nJ9ieNEErDb82QaTr2XE4LPwGTpWh9iBQ=;
        b=KpZtvXVFFwouC+YJKQ+2yPjDgXPuPQBUcfdX8jRRPRhKT2hsbTXlr7QvDI+Jk473lC
         IRAdPyBzYZL8EXYr9u2Y2TWZTp+P4m6gEkyBteShruC7vMtTASAs+h77vnoy6qW6fGgW
         UH+vawdgiu6d8tky8yzMWxK85n0bD869mOWRs/m9j6fw3AuWd3ZTHkH81f2I4axAlg30
         qnEMijoNc43fwPHdCuF4vtEhDgsAvpaOJqdjt4XfRXoAWm527NKcfre71Yj28/jmFyEx
         UtN27+pITXiDf2/sepl1WtlWk9e7/3dOg4w0iyCggT9fuKNVtTCBNMuEYa/6pPkzMrLD
         nx8Q==
X-Gm-Message-State: AFq9FYIFshGP080Y8vUx+hMXHyzfJB9VOSAD1OwnhAAUnUdRrncTCWay
	2bEVfiC5+xRzGvaoQtlZxnbDx+bU1zYCZUW8mBPFRiJQigf38ZOa8d3TefX+/1X+1i2aff++3q1
	BBu5/1E08OC+QzyimdPnrRIg+FWJpePU=
X-Gm-Gg: AYBFou1dgzGHdB32e3mCD2Dyb4ofwj2Q1l8vslRYr9kTk3p9hTEqKcRvjiX6zrHJmbt
	8FljmyuRMehsTjajuviD4uek2h/ecR0KlVdPD+gkdIUzFHNQ6dKqgAl5DGqVDzOKhn2Szv5Na1X
	CAJVY9WiMDi/5lMUkfRfYap4VIyFPJhYdvPRoyXgaBAZjO9rsFPSOn3AW/x+NCcgDZAnt1GE2gr
	qYi74+Z/uCye0xl6j75fF0vpCsI2dlr7ionH6kHakvcSyH+1vteA7vV+mpnVJ8mFbPZks4FpZY1
	8tx1XkEGKmd5QL3etAbgFETXNfV2bzIKYqEtODqE19oDA3aBv2BDTlprklEbVZPbgotgMyfna6Z
	vCJw0mQ2SycyNYIPqGRSzXKotYhO3YTcSU0hUySLM0dWivSxP8tFKx4+3LMUycBlY9Bs4YuItzr
	mZBMqpzwu6ZsAHY7kJHK2V/cBkTUgz3wINSXC6eAKbTUau0/ATNGA4i9wzw51swGymG3+Kbc9x8
	o3w
X-Received: by 2002:a05:690c:6605:b0:8b0:c5bc:e87c with SMTP id
 00721157ae682-8b1b5a56bf7mr12401287b3.6.1793183468970; Wed, 28 Oct 2026
 03:31:08 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028000912.2081659-1-florian.fainelli@broadcom.com>
In-Reply-To: <20261028000912.2081659-1-florian.fainelli@broadcom.com>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Wed, 28 Oct 2026 11:30:57 +0100
X-Gm-Features: AclHuK_B_4dhiY1uBiy_8fsXbNuV7k79HWgTMcm0LExCnPUWVLwnCuYV7EcZt78
Message-ID: <CAOiHx=kKX0YWEkyp-HBahae_krDCXLAjO6kLPi1gJzpf7EOfMw@mail.gmail.com>
Subject: Re: [PATCH net v2] net: dsa: b53: Enable IGMP and MLD control packet
 CPU copies
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Vivien Didelot <vivien.didelot@gmail.com>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 1:10=E2=80=AFAM Florian Fainelli
<florian.fainelli@broadcom.com> wrote:
>
> IGMPv2 reports and MLDv1 reports are addressed to the multicast group
> itself. Once the first listener is installed in the ARL table, subsequent
> reports can follow that entry without reaching the CPU. The bridge then
> fails to learn additional listeners, although static MDB forwarding works=
.
>
> Enable the high-level protocol classifiers so that IGMP and MLD control
> packets are copied to the CPU independently of the multicast ARL lookup.
> Retain normal L2 forwarding by clearing the CPU-only forwarding modes,
> and preserve unrelated protocol-control fields.
>
> Handle the BCM5395's 16-bit register and different classifier fields
> separately from the 32-bit layout on the BCM531xx, BCM5301x and newer
> integrated RoboSwitch families, including BCM7445, BCM7278 and BCM4908.
> Export the helper and call it from bcm_sf2_sw_setup() as well, since SF2
> uses its own setup operation instead of b53_setup(). This also restores
> the classifiers after the switch reset on resume. Leave older devices
> with different IGMP controls untouched, and propagate register access
> failures during setup.
>
> The SF2 setup integration and BCM4908 chip gate were updated with
> assistance from OpenAI Codex in response to review feedback.
>
> Fixes: 5d65b64a3d97 ("net: dsa: b53: Add support for MDB")
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
> Changes in v2:
>
> - export the helper and call it from bcm_sf2.c as well as spotted by
>   Sashiko
>
>  drivers/net/dsa/b53/b53_common.c | 52 ++++++++++++++++++++++++++++++++
>  drivers/net/dsa/b53/b53_priv.h   |  1 +
>  drivers/net/dsa/b53/b53_regs.h   | 17 +++++++++++
>  drivers/net/dsa/bcm_sf2.c        |  5 +++
>  4 files changed, 75 insertions(+)
>
> diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_c=
ommon.c
> index 0880310c9ce3..51784432d266 100644
> --- a/drivers/net/dsa/b53/b53_common.c
> +++ b/drivers/net/dsa/b53/b53_common.c
> @@ -836,6 +836,54 @@ void b53_brcm_hdr_setup(struct dsa_switch *ds, int p=
ort)
>  }
>  EXPORT_SYMBOL(b53_brcm_hdr_setup);
>
> +int b53_enable_mcast_snooping(struct b53_device *dev)
> +{
> +       u32 val;
> +       u16 val16;
> +       int ret;

I'm surprised to be the first to say that, but ... reverse christmas
tree? Or is this not a thing anymore?

> +
> +       /* BCM5395 has a narrower register and a single IGMP classifier.
> +        * Its ICMPv6 classifier also covers MLD.
> +        */
> +       if (dev->chip_id =3D=3D BCM5395_DEVICE_ID) {
> +               ret =3D b53_read16(dev, B53_MGMT_PAGE, B53_HL_PRTC_CTRL, =
&val16);
> +               if (ret)
> +                       return ret;
> +
> +               val16 |=3D HL_PRTC_IGMP_IP_EN_5395 | HL_PRTC_ICMPV6_EN;
> +               val16 &=3D ~(HL_PRTC_IGMP_FWD_MODE_5395 |
> +                          HL_PRTC_ICMPV6_FWD_MODE);
> +
> +               return b53_write16(dev, B53_MGMT_PAGE, B53_HL_PRTC_CTRL,
> +                                  val16);
> +       }
> +
> +       /* Older switches use different IGMP controls, not HL_PRTC_CTRL. =
*/
> +       if (!is531x5(dev) && !is5301x(dev) && !is58xx(dev) &&
> +           dev->chip_id !=3D BCM4908_DEVICE_ID)
> +               return 0;

I would move this to top, and probably check for those that don't have
it. Basically go from oldest to newest generation code wise.

> +
> +       ret =3D b53_read32(dev, B53_MGMT_PAGE, B53_HL_PRTC_CTRL, &val);
> +       if (ret)
> +               return ret;
> +
> +       /* IGMPv2 and MLDv1 reports use the group's destination MAC. Once
> +        * the first listener is offloaded, ordinary multicast forwarding
> +        * can keep subsequent reports from reaching the bridge CPU.
> +        * Copy control traffic to the CPU independently of the ARL looku=
p,
> +        * retaining L2 forwarding rather than selecting CPU-only traps.
> +        */

Should this comment be also in the 5395 case? Feels like it would apply to =
both.

> +       val |=3D HL_PRTC_IGMP_RPTLVE_EN | HL_PRTC_IGMP_QRY_EN |
> +              HL_PRTC_IGMP_UKN_EN | HL_PRTC_MLD_RPTDONE_EN |
> +              HL_PRTC_MLD_QRY_EN;

I would also break out the "Copy control" part and move it here, to
make it more obvious that these bits control this, and clearer that 0
means copy to CPU instead of trap to CPU.

> +       val &=3D ~(HL_PRTC_IGMP_RPTLVE_FWD_MODE | HL_PRTC_IGMP_QRY_FWD_MO=
DE |
> +                HL_PRTC_IGMP_UKN_FWD_MODE | HL_PRTC_MLD_RPTDONE_FWD_MODE=
 |
> +                HL_PRTC_MLD_QRY_FWD_MODE);
> +
> +       return b53_write32(dev, B53_MGMT_PAGE, B53_HL_PRTC_CTRL, val);
> +}
> +EXPORT_SYMBOL(b53_enable_mcast_snooping);
> +
>  static void b53_enable_cpu_port(struct b53_device *dev, int port)
>  {
>         u8 port_ctrl;
> @@ -1334,6 +1382,10 @@ static int b53_setup(struct dsa_switch *ds)
>                         b53_disable_port(ds, port);
>         }
>
> +       ret =3D b53_enable_mcast_snooping(dev);
> +       if (ret)
> +               return ret;
> +
>         return b53_setup_devlink_resources(ds);
>  }

(snip)

Best regards,
Jonas
