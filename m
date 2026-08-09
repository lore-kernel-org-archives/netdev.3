Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4133D564B
	for <netdev@vger.kernel.org>; Sun,  9 Aug 2026 20:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786307359; cv=pass; b=J2yV9wAY/AWt42lfI+G73XGjMoYn50BsmaKHp+j8yobgdeCBUWlrb4tnYe7yCieQqjG1Kjpqyw+Iaaz/FY67BGvKSTfYbYEjyJWTeZFdB9tYUSr/TfNpiG2USGEHqq8Np0iXSiRO+nk3hUnyaEyY/eQM9Hd15wUCG6BkxU8XD30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786307359; c=relaxed/simple;
	bh=BgtaVTkKYB9i7M+jdhZZfelgFvXF+mEulzCdgRhnacw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HVDxwJQMaQHQQNWbb8wnaLKTl4uGCD5k7Z+A68GDBjCv9TMqcCDac6PYYroLC2H7K2E9LetJptRaJlZS9z+gZIelYRQGEpydeOKwCEDHFTYqY3GNDYWsB3wTyP+VhX5I1EyRBP6vaeeE4Ki0mh2X4js/waKaKjnvGyzWn+CZnkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P8pR8M2G; arc=pass smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8pR8M2G"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-977ba4d3b49so1003725241.1
        for <netdev@vger.kernel.org>; Sun, 09 Aug 2026 13:29:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786307356; cv=none;
        d=google.com; s=arc-20260327;
        b=mdpUkroC4iDXlcAfBPjKxeuaVsHVqWLt1fLKt5CX4yI1jbC4B7jr33cEvUGAHnW77c
         DcV/yRhX/e7iOniZ3aP1i7IEmp9iKLPffTosH8x/xk5hLWnm25opr8N7yBYUJfRLrFLu
         C83RmNd84OfrR14w1rskpXibs2dHysAXA5GcuYA6prR36nZopmjfLA8waS1GrcMNIG2x
         PYpJDSw7b1RjFk1g9YIJlz2UCbB/BlBU4cz74EDusAPX6pxCQNbPWcT+XWOpwcsnBJRg
         l2vCwFf7lL1gh03LiDoN8RTtQfyOxs60sb+oautYy0r53XRmE1FbVwdcc0ZD55+Ap937
         6Llg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lqI6t42BdKQforakdSoj5zqucwIqAbx3+vYL6ZUGAQM=;
        fh=WF7fbm18thZZdciHyBMzB+qzg7nSlQ8sW35uPy4wY2c=;
        b=CjfOYEUPlqdkIuFoOZ+P+6PZKngLLsJPf3uZo8SBaymf3o3LNZnLu5nTeaW8v50Qep
         sdSuSqyxnh9GGcLkGRre98iZOt8arjixuCwYKev3j7uYZi//3G0pcKXGwBvV12qilxMD
         W0h0FeI2qo3gzVwKU6VfG1+1uY68l7cGFVIbISbJ0rHep/EdUGzjWdXGokFs9Gd4zytj
         JomEIVG3VMbxbdyXOv0XncRq21K27N+UtkCKAnN2rIgBngqC4kswnN1v76grhWJ+QPoE
         RF5di/u+XhVm4I2Q+I27twq4Zybi5m0DK7si4SVMEZOOjEH8NrzUDcqtKR9cP5xEfbek
         LRCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786307356; x=1786912156; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lqI6t42BdKQforakdSoj5zqucwIqAbx3+vYL6ZUGAQM=;
        b=P8pR8M2GzkfqiNcOrnUOpyo+yUDKKv+PcJucB/WPnHKJtvq4ctBed5uxHBu/Mk2yEb
         D4aLCurw7h/AtBCp2RoTyaM9p8xuPGEjS3bPkH6pp6Oc3VWQWxEqEcn6yYb1xVvtRz2o
         bdiD+yC/e72WKb6u4ByIeQDmoj8zrYDULCGZY4cTDhZuM5v5xnb9q4A+UgMM9W/7gAy5
         CeKe+uWdoKe+clslVugUHlugMiNqXK3KVGPiYyKMmoZuhCPlf1ARSgjvGAAGycJTKV/h
         5PVSMMRWSNRSXSrjX8IiHiNsaArnMG5/DMyemtNaPJGtEkr/2P9a4/Pxg1ZzgeLiO62f
         C4GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786307356; x=1786912156;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lqI6t42BdKQforakdSoj5zqucwIqAbx3+vYL6ZUGAQM=;
        b=QIur8uCUPgyKQfERWcC20NsSrVF5xBsih2rGtcRWiP00VsLMpOQFyBPJaQHQKuTKBu
         LVcWaVI5tD6/+LdhqX3pFL9jtOC3iHX2ys++M7pYXu+0mpg/SiXDhGJId3LtVOHNM7Vd
         h82LOpjkMMIX3UYCUpQ8ze+OlkM/Hh55gm/E6tU66vZiPv+YnqM8GQxx/vFQ+P7FswhE
         kTl8rO7/RRYcuYNtFgRPTDA3fTLXQYTrAP5eO0Y/Uk5zOgek6AxLjQxwkv8iiEWzDDZ+
         DbfeJAj7Yd15nA6QX7y82V+r9Yfv8poRIFBMUIMZHllTAw34oPG3X++p3yeG4j7yGGzE
         PffA==
X-Forwarded-Encrypted: i=1; AHgh+Rr+XDQhOV7HNzf0FtrdnAUS59sDPeP6TRvjoxlGHeQ4yCK2rykzjYnWa0MlX34z5ZyfUkCUCWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiNOif7WPAgggzidQ4hHmVW/tclOct4fHwwFC+lzFWa/iLSBTb
	gUu0yqNxkZmGMCbQue7UAMc69Om/5e6N2ruvGrlGi+SmOoKj5p0j0hvQZNnK92V+yrsepYxVdl8
	4vpMuenkNNvUtTll9NWVSEQ4eqnP97pM=
X-Gm-Gg: AR+sD12pgGcjJwOXEksNOSt0UbcpterzbmUKayO1qacDu8fCcMr9KX39E5pNT3BVnT8
	X0KZVoNBzFwcH7QcQuuqJf9iXeY5uuSRkHSSDpXTiy9JZOMMCbRsOZK0DKwwVRhphqIc81sCioe
	BmJvasYLGtg0lc+5X2gxYHGu0JvpqDWBlgdqvWezDDDKisttyPOxpjysJYktCaBtsCVX7LY3ozG
	qYQgQ2AZnVNiicGsvQGbn9/MrJN7dR4Msq1xqklcUJv4J436kHbt09hLc8OunHNALNKX+reWbRu
	doj/cDmnOqbVsj2oabZ1I6/rWmZmHPxKiopfc5A4DmtehDdf25QVtKwye0hbO1uMAdUeFfn0sIl
	tsxIiJEOJzGxxPdHBMy6424Ue9kmdsbuaYxhOzwz2/eLueSErzlzkePRqESW3v72CunSv7XFnmk
	+kmmrk9oa8APfGiB+P4mlx2westWUuTK+XPxv/qg==
X-Received: by 2002:a05:6102:1510:b0:738:89ca:65a0 with SMTP id
 ada2fe7eead31-765213c1716mr1391331137.9.1786307356117; Sun, 09 Aug 2026
 13:29:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806-submit-acx00-of-dynamic-v1-v4-0-9bf2f7441632@gmail.com>
 <20260806-submit-acx00-of-dynamic-v1-v4-4-9bf2f7441632@gmail.com> <c78c2c35-52e7-4393-9714-06039d8a3f28@lunn.ch>
In-Reply-To: <c78c2c35-52e7-4393-9714-06039d8a3f28@lunn.ch>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 9 Aug 2026 14:29:04 -0600
X-Gm-Features: AUfX_myH4wks2-Q5Fk66AAdiXlKqq3NVL2fkKURJiEoPFq00IVVGviYpLv4QDTk
Message-ID: <CADvTj4q0=aBf=V=rXyKeVcR1ZZtBsTkkDZ58qLLbhkunsCzpKw@mail.gmail.com>
Subject: Re: [PATCH net-next v4 4/4] net: phy: add X-Powers AC200/AC300 EPHY driver
To: Andrew Lunn <andrew@lunn.ch>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, mfd@lists.linux.dev, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 9, 2026 at 9:51=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Thu, Aug 06, 2026 at 10:51:29PM -0600, James Hilliard wrote:
> > The AC200 and AC300 contain compatible Fast Ethernet link PHYs, but the
> > link endpoint is inaccessible until package-specific control registers
> > have powered and configured it.
> >
> > Add one PHY driver which binds the link child and joins its parent
> > Ethernet PHY package. Fixed package compatibles select the correspondin=
g
> > backend. The generic ACx00 compatible reads one packed configuration fi=
eld
> > and selects the backend before touching backend-specific resources. The
> > AC300 path therefore does not resolve or enable the candidate AC200 I2C
> > device.
> >
> > AC200 obtains the regmap of the referenced I2C MFD and keeps it bound
> > with a device link. If CONFIG_OF_DYNAMIC is available
>
> Please drop all the CONFIG_OF_DYNAMIC code.

Removed in v5.

>
> >  drivers/net/phy/Kconfig               |  11 +
> >  drivers/net/phy/Makefile              |   3 +
> >  drivers/net/phy/xpowers-acx00-ac200.c | 388 ++++++++++++++++++++++++
> >  drivers/net/phy/xpowers-acx00-ac300.c | 404 +++++++++++++++++++++++++
> >  drivers/net/phy/xpowers-acx00-main.c  | 536 ++++++++++++++++++++++++++=
++++++++
> >  drivers/net/phy/xpowers-acx00.h       |  28 ++
>
> Since there are 4 files, i would suggest a subdirectory.

Moved to xpowers subdirectory in v5.

>
> > +struct ac200_ephy_ctl {
> > +     struct acx00_ephy_control control;
> > +     struct regmap *regmap;
> > +     struct device *dev;
> > +     struct mutex lock; /* Serializes power sequencing and state. */
> > +     u16 ephy_ctl;
>
> What is this locking against?

In v2, the AC200 backend was a separate control device. The PHY driver
obtained its callback table from the supplier and invoked power,
interface, and LED operations from probe, reset, PM, and LED paths. The
control driver could independently invoke power_off() from its remove
and shutdown callbacks.

The mutex therefore serialized calls crossing those two driver
lifecycles. It prevented, for example, supplier shutdown from running
power_off() halfway through a PHY power_on() sequence, and protected
cached state such as powered, phy_addr, interface, and LED
configuration. The device link protected lifetime and removal ordering,
but did not serialize every callback.

When v3 removed the standalone control devices and made each backend
private to its PHY instance, that second entry domain disappeared. The
mutex then became an unnecessary carryover through v3/v4 and has been
removed in v5.

>
> > +     client =3D of_find_i2c_device_by_node(ac200_node);
> > +     of_node_put(ac200_node);
> > +     if (!client) {
> > +             ret =3D IS_ENABLED(CONFIG_I2C) ? -EPROBE_DEFER : -ENODEV;
> > +             return ERR_PTR(dev_err_probe(dev, ret,
> > +                                          "AC200 device is not registe=
red\n"));
> > +     }
> > +
> > +     if (!device_link_add(dev, &client->dev,
> > +                          DL_FLAG_AUTOREMOVE_CONSUMER)) {
> > +             ret =3D dev_err_probe(dev, -EINVAL,
> > +                                 "failed to link AC200 device\n");
> > +             goto out_put_client;
> > +     }
> > +
> > +     if (!device_trylock(&client->dev)) {
> > +             ret =3D dev_err_probe(dev, -EPROBE_DEFER,
> > +                                 "AC200 driver is not ready\n");
> > +             goto out_put_client;
> > +     }
> > +
> > +     if (device_is_bound(&client->dev))
> > +             priv->regmap =3D dev_get_regmap(&client->dev, NULL);
> > +     device_unlock(&client->dev);
> > +     if (!priv->regmap) {
> > +             ret =3D dev_err_probe(dev, -EPROBE_DEFER,
> > +                                 "AC200 driver is not ready\n");
> > +             goto out_error;
> > +     }
>
> Please take a look at syscon, and syscon_regmap_lookup_by_phandle().
> I think it will make this code a lot simpler.

That does simplify the consumer. I have converted the AC200 path to use
syscon in v5. The AC200 I2C driver creates its paged regmap as before and
publishes it for the AC200 OF node. The PHY resolves x-powers,ac200
with syscon_regmap_lookup_by_phandle(), so the device_trylock(),
device_is_bound() and dev_get_regmap() sequence is gone. The lookup
returns -EPROBE_DEFER until the provider has published its regmap.

Since this is an I2C-backed regmap rather than a generic MMIO syscon, and
the AC200 driver can be unbound, I added managed registration for
externally created syscon regmaps. It removes the syscon entry before
devres releases the regmap, avoiding a stale global entry after provider
removal.

The PHY still resolves the I2C device to establish a device link and
obtain the chip-wide input clock. The device link provides supplier
lifetime and teardown ordering; syscon is now used for the regmap lookup.

>
>     Andrew
>
> ---
> pw-bot: cr
