Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F47E2F7EF3
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 14:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791729225; cv=pass; b=dulDTmar+hM7qac+CEK3R/ztqI8AjVdo4dZqA6eEjXdRcUdBaT5nTb8UIOJOTNtJ+QpEM9FpVmiBwdPq2GBqjokBgA5xORaj73t8XTQoHdCPMMFZUugNHilWa/DVy1zjPOIjTVLmOiD8gxeVjSM3vOEW6x5ey4DfmABGcEfI0hw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791729225; c=relaxed/simple;
	bh=mfpOKnIb2lPxTOneML/VhNInEmWNxWvTH6pPXHsj6Mg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xbo5ieixIlKnwlfewI9DHKvlsH8MGD0GjbDjdBTCfYOF7wmdo2DkTZZpm7ZptWyjs9kwJiZW3foU7q7HHAlJ5PVbu/NZC3I1ZGPCxmGkm6T0e7yuxLoruW/Pq+iQ0uCWOnxNwhcm7IrsCORjHMYw1PGjLxfJEpsknwP6gaSNDJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jclark.com; spf=pass smtp.mailfrom=jclark.com; dkim=pass (2048-bit key) header.d=jclark-com.20251104.gappssmtp.com header.i=@jclark-com.20251104.gappssmtp.com header.b=U3IsH7xc; arc=pass smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jclark.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jclark.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jclark-com.20251104.gappssmtp.com header.i=@jclark-com.20251104.gappssmtp.com header.b="U3IsH7xc"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-91b83459526so76466d6.2
        for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 07:33:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791729223; cv=none;
        d=google.com; s=arc-20260327;
        b=TMQKSc97Bn+21klfIwyEiink48XemuwL6+ahal3lpFmSKq7mRMW6/o5wwJ3VqP3hPz
         RCTcfXcC+XnKgceuQ+IkM5EIs/wJJIXdDSXSScCEfUhPXlkyMYgRO8vsI+6ij3I44OWH
         1ar4X4hDq/7Y6T/CvF2d5aG+Y9T36LqkY44nF08qFSt8BH9kbPBVLPXL6smm2DNmrj8u
         6kVmNN57JF/hjQCNxokwSha5ewgZF33NikmAbFU4kWYN8FUDgMGQ/7j6CAA/E01Ho2W0
         CRdFPkCsKXo33Q5miSPgBhrhYj9GBm0lBs4B+uKBp1U1Jr0XaER6RjIX9+/dIVXSw+Jx
         ttLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RimT+BJQr+BZd/nBQf4bNoeClkAHtE09xphYwHOsuq8=;
        fh=QLvHrAuliOcCAK+wcwl3r0ftqneoyE6IjOjcoWXa54I=;
        b=X+b2Mopo0FnVGOPSkT546tl8pxJAfDfFj4GzEEpGMmdJVs3LxeH430/4EATfaG7gb+
         /Tub/67YuzNdRO1oL0+Lja+I7lUxX/4OrnPuSeod4Sc8rIwQYsiQC88JJKhZZJrw8P9c
         b/rcqy3oi7mGFUJ4tgJDyMk24PJJpi2rKrH40g0Py0WUJbn4oh3zYngonIQOSEkfe15Y
         mnYHGMtsGEgHgdeAo2POZC1mB7AirpCEslV1zCaL0QIzzDSsm33c4dXdIaAz92n7WSD5
         vq0RwvHof9A7S1ag3MT3VfD4tTGm6nngTQXGvCfX2w/XqaIh/dLnmiSdQ4RzhUcE9ine
         xx7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jclark-com.20251104.gappssmtp.com; s=20251104; t=1791729223; x=1792334023; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RimT+BJQr+BZd/nBQf4bNoeClkAHtE09xphYwHOsuq8=;
        b=U3IsH7xc4UI1OMR8uEmylufAXs3JQYpiCszNIR7ghf2aMaxaTjeilvwDVJQuSiwC+M
         2Y/IFQ+gQF8qI2Vftb6CdDDk6ca9Srq1MvpFUk32y/jyYY4Bb2GHz7lPGkCIDiW2yvxY
         coRx/WrTRDVXcdInyFcSpdD9dp78yqqpI/mvNHWdqd80B5VlQJjQDmYgNfNTrRLvETGS
         Jq8t8ZiADDV5Gv6WyxByJ2LtWBHNs7HxeTYbV7cBiQIhBYDmPdM6ULf0PLBtO/Pvglm5
         Pe3d6sEx5iKm4sgaKvMTnGyTKbjzbtIU+RD80fcD+o6BgakySPV7CYfl5yanYskipydU
         M3Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791729223; x=1792334023;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RimT+BJQr+BZd/nBQf4bNoeClkAHtE09xphYwHOsuq8=;
        b=IRk4d37QpMBtsq1xiAH/PEyjiX9RvLNgMMC6oCTNFguQH71hzaT9KNbXPLy+Ab3u7+
         m39GYAkZ+rtINeSen3KPcyy+nu0QskhxyuF2NBKyAtZJFBYqw9rotUzvN9WqE5zlnx8Q
         WqAuwrkvil2V+1hdor9W08MCotONansgSMkfis8f0WRj8E8SFr9O84Em6M1Js2B7XRe0
         cVhv3X91xoa9pUJuCmL9KDLIVOar6MTGS2/zfnfiBp6ls9ArWJac1re3NtRRb+AVGg86
         paDDkpO/MOwEcT1c6mS6jQhAcC17BIXhBuUWDZe4c56dnMPvlfP67KEPGrFR8iQTJ9pP
         fNJw==
X-Forwarded-Encrypted: i=1; AKwUvByDN7hUuhyzx8K+fLAH9bB9HeD7wpFM6sfFhVoTkKNST6QEDKrYAOqqqHDbumUPpfMEx/tKhyA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKdz5/zNOuJplncDGluRKea2XYRGhHYrNaTaWIWwxlY3ataq/nF
	J7lhS//QaVsaVy1M7FzNsyNE5KwD8cM8YbO6UqRPGzBUHmjUchPB5tnHLr0aPFoFItw5eClD7c3
	wO4vQhj9MR9pF9kagZ8Ly2VyJlD7r+44SUI9f61LR
X-Gm-Gg: AYBFou31hwaqwSOCdYu/jp+xPvt/3BB96+JFNfjBQ70ge0jcoBWLHlVj0DWNimAR3NX
	BOBTI3rx6EYstKz9olKDCXSiOq3UTM3pRd3P9HQOnrvoYkPIHXL9WA0XFrz6oRQ6Vf4/50+saIu
	R+bCNj3XALctnZinGi/N3yuGimlH+ldKbDczoaysGT4futARsLKpwyO70/v6c8BMH1JaTaN4VCo
	MXW3YTbmfKdFT0xVMyiBbJrAlBBBmpjBPTaCAojXb85BnmYrUa0Q/ITxw9NeSlroEPdbmOA7Kp6
	3esi+Tk4YK/IGD5bgn7HCtw/XOhRyJerFhhtUzBFyqgL1NyN9F+aX/I=
X-Received: by 2002:a05:6214:ca4:b0:91b:5d3b:4ac0 with SMTP id
 6a1803df08f44-91b5d3b4e68mr123540436d6.53.1791729223287; Sun, 11 Oct 2026
 07:33:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009143506.2507607-1-jjc@jclark.com> <20261009143506.2507607-2-jjc@jclark.com>
 <af97fa4b-d817-4e8b-bbd7-aaefa23d4d7a@lunn.ch>
In-Reply-To: <af97fa4b-d817-4e8b-bbd7-aaefa23d4d7a@lunn.ch>
From: James Clark <jjc@jclark.com>
Date: Sun, 11 Oct 2026 21:33:32 +0700
X-Gm-Features: AclHuK9eexRlWA5M879Crhtnp6jM6vwO493yA7pfOJjE5VhMdHya6ZQFlGC7FHo
Message-ID: <CANz3_Ead154hG=5H7fmnamUDbhEv==sGMHdiY+jUhjzYLRzLaw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/5] net: mdio: add timestamped write operation
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Richard Cochran <richardcochran@gmail.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Doug Berger <opendmb@gmail.com>, 
	Nicolai Buchwitz <nb@tipi-net.de>, =?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>, 
	Russell King <linux@armlinux.org.uk>, Conor Dooley <conor.dooley@microchip.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Thomas Gleixner <tglx@kernel.org>, 
	Miroslav Lichvar <mlichvar@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 11, 2026 at 9:03=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > + * If @sts is NULL, perform an ordinary write.
> > + *
>
> Please don't do that. We don't want drivers calling this when they
> don't need to.

Agreed.

> > +             if (!ktime_before(now.monoraw, sts->post_sts.monoraw))
> > +                     return 0;
> > +
> > +             /* Cap the wait at 1 ms, which is more than any single
> > +              * write's delay. This guards against an aux clock being
> > +              * disabled and reenabled, which restarts its raw time.
> > +              */
> > +             if (!ktime_before(ktime_get_raw(), deadline))
> > +                     return -EBUSY;
>
> A bit banging MDIO bus might be slower.

The comment is misleading; I'll fix it. The 1 ms doesn't limit how
long the write takes, but how long the core waits after write_sts()
returns. It allows for a driver that returns before the transfer is
complete, at worst as soon as it has started. A bit-banging driver
returns only after the last bit, so it doesn't wait at all.

> Also, i've not thought about the mux case, where the write gets
> blocked until some other operation is performed on the shared hardware
> of the mux.

In the mux case, mdio_mux_write_sts() takes the parent bus lock and
switches the mux before calling the parent's write_sts(). So any time
spent blocked on the mux comes before the lower bound. Or did you have
another case in mind?

> > +     /**
> > +      * @write_sts: Perform a write transfer on the bus,
> > +      * with system timestamps bounding its completion. Set only
> > +      * if timestamps can always be provided. Must not return
> > +      * -EOPNOTSUPP.
> > +      */
> > +     int (*write_sts)(struct mii_bus *bus, int addr, int regnum, u16 v=
al,
> > +                      struct ptp_system_timestamp *sts);
>
> I suggest putting C22 in the comment. At some point, somebody might
> need C45. And that gets complex because of C45 over C22.

Agreed.

> Is there any need for read_sts?

Not for this series, I think. The BCM54210PE captures its time on a
write, so a timestamped read isn't needed here. I'd leave read_sts
until a driver needs one.

James
