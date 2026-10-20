Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792479919;
	b=PcNmpsi3ab5wgSKboY42D03pMGpmqVL7zBIWQLIrnKN7niFPNwxwUXeUEr5Fw0D/pZwJ
	 d1zI2g/bV7PkKNLNZjm5xpqa0HqEkspz0DWiTTQGm9NehxNn40aYOdCLlbuq79rLlG39T
	 F2ZpQ2nG7xEOO0PkOM69ZAA6wPr0pNXSZ6BbDx2gu7Xf0W89I8TUi0uE8p7j2/4rz5uTL
	 K6AT216Kuq+xWhmQMVNRId2Tt4dSIWvHQGBNFFZ7ivFrKPSwlGBxNw0T8lpjRcu5mhvgh
	 OuU2iTZm/K2NyDr3xa4IozwzsQ+3V1Uiqk5OduOAS0E80spVUeaLbqeXkxSNjLX7YRw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792479919;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=Cv2JqhQRLc+jCz83YkiL31u7vtPW6A1fRdUTLPUppjE=;
	b=u4UCn03+VafOJoaiJ+R1tWCSVpcMpz3I+laQq8qTC2syNTs75W1Q2YWXwl+v25c4Ch9/
	 A8B2KR5rVH0ooTBAmmC0RE8VSBIr/w5sBb0yBChCvaU5NKY4A24wH7wiQ97WUbxLs+uxV
	 OsPywr5j+EX54RJdEPwtWYovJFnF+Yg3gxUrVIYYAZMQ2sTKHum99H3803YFoJr/1wSl7
	 dp7zKWkySEtJnWs/nO32z7oQqSnmiCWus9o/S+Xv3IptmdhQUpYQc9QtTOp6I+W+gz7r8
	 SwAj8q9/fMJ1RjbVbLsFxj334eHmSbr6VGmehqhC15Vm2BNvw4mlbY7BcwcF0CitbIw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ci7vn84H;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA35606A31B
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 07:05:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FA35606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ci7vn84H
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c263415982eso354402566b.0
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 00:05:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792479917; cv=none;
        d=google.com; s=arc-20260327;
        b=geckKpRqz89tGnHHUYym176Ejn2H5DWIB83dz/CObIv3ePEOSTw8WeMb43b6HAyVtK
         GuyADACt75LEMAsxujYwbrWPPJ2w1Aj0Xom6PBiLUqvgqOt4W8CWJGzB+e1ucdVaeDGg
         406rTjB/B4QAplT/0PapNdKBXgSo5wOy+PQlU8sNtFT+rcd4O9EDqZePADHmfzUlnGXZ
         ghjK9eoV7ZDQ77v6xVAzLf2oD1ck2mm0feuPUTJg6/Zr6DPVP6onYDUZC4tKDgfckDMC
         w8b6fe+DZiy+s0iZRkQE7uN1BtZzZuUxkIIGalap2MrwnkNxV0fEz64snShbqQ4X+/FV
         MQXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Cv2JqhQRLc+jCz83YkiL31u7vtPW6A1fRdUTLPUppjE=;
        fh=7aqWJ1TQ0ObDvp2RRIDDy2/rt6KS4rltsLxyU720f1U=;
        b=f6JAzHFODmY92XBllFYhCeVELnQv1lWTyB9rK215fMHxTxNUp/0rO62Gjok1C7D1s1
         h3qD4sDzGtfFZIqaKaoBw0MH3PQv12PdBHl/EhmXy0ANJ4VI8b5zeJqlmKz6zfagmI+o
         7pPABkZyKB+W0vZiOvLhW2zdqNpqEQPtZFjRQHnbZfiExgliKvev5e+Ox0y/v/XHqRJL
         3OsKaKmwplSHa+52RSphKuMOLaHZvfCQXpQxibkOktDfyOiu/9x83d2qSXjae4001FI6
         VxGiJeQieomggAJSt3bxuMIdeep8/Z0Py27wR9D052F9U5KuS6bNUT6er06OFDTVqNXd
         jMSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792479917; x=1793084717; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Cv2JqhQRLc+jCz83YkiL31u7vtPW6A1fRdUTLPUppjE=;
        b=Ci7vn84Hm3XDopKmFIkGRWeYa/rtCTr2roBS3xPoMSFZjbIisbzNmyEcM/ndv212wh
         DMJ1HWpq4I225TuzoGZ2f/dsLIAvpZJ/gBPOV3CjDBBNdRGi7UWcpJIKQotGnbx7o7mo
         r3oqNk7Q7d/tadttRra1TS+hMZ8obuLx0uh1biFsaiuL+sn6zzROA3cniMuryeEwxA2M
         /PxQCnsT9A8sgeMHZ+IABdW2S09M4hopMKt1STugedoUGQQ4e0q/c5rlJYsN2uliTj9t
         HVVizhLHnNFGEBvtVexw80TxFhZLmtMrw7dBWTjXH6iCO+UfO+g6IIN44Y1rFh7HLwZb
         f9fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792479917; x=1793084717;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cv2JqhQRLc+jCz83YkiL31u7vtPW6A1fRdUTLPUppjE=;
        b=cIys4+9y6h9BLqqQ2BPnEZl7emxjyQ93tYfEWWRETDJWGpamYCD4AQpJK2emKUhoct
         d17KXbLuFiVjo76XJ9jyyzHU1j6b0lQSDqGlrH2Y0b86J03o84W3tEwmfhbuwlj+PKjD
         igFG2pEo+AeFGR65m9tsxlocLBzsK5CXPMLRwNALKxJYp8aE//2vVfTqtSTBbwy66jQe
         PnsULYdflJ3eLOjbKpJdVSTILRfEjoLShR5Aadw7ApvWTNxuihkfE7PLVeR+izmWeuN8
         iAg6yPDqRr4hvvd1jqMQoqVRriCwbf/C/Y+xkARbVXWnbI5WB7DSsW1BLrSgqx8VLuqQ
         VdcQ==
X-Gm-Message-State: AFq9FYIQIrfPvcR4NIjXKqrSjaZbHDnUxUUrrD49ReTmynWSdtwjSz7f
	uVAdRp7/e4dEyCxUB5zQ+vuJ6kKhkVJvlINBQUHTu0A8QOu+uFkYnJYO1jkJaVIQRXBgeawiNB6
	+LxWAfNkqGbq3samWsFtmYdeHlsrZZOY=
X-Gm-Gg: AYBFou2GhPgFsCvXfLaiKjUITp3GqDLogA8lx85W1zelh7w56B2fmbttkqFoVdiYlyE
	jNqUfuzt2Sl5zSFNSIQe+xZodkcbGQbiC7b06tb8Sva+k7WNo/EKThI/GhSDfPhs53k9rGOHjZ1
	swX7sJOTf/oYdqA/UIy9AC1bSTZKdU9Cap8TlG5VXglSwl9dEaH9KHpp4iozArlZTFBp39EgEpI
	ZqEe3c1mE94Xnh4/f6PhpmcgBVARgMu2gdAAIDfFxvEV6fEdFNMQH2+Ncty4IxVUR8zVygf4F9P
	C/nSK7eSOTMF3ACQe5OPAePJC3eLiNwr4lIAuLHbO/7Ff/3iB9KP52I9sNTEcVHGlkzt4wDVzt8
	HuP9vbyTSjOU=
X-Received: by 2002:a17:907:2d10:b0:c40:5de7:33d3 with SMTP id
 a640c23a62f3a-c419f416e87mr706642266b.35.1792479917230; Tue, 20 Oct 2026
 00:05:17 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019193148.1381545-1-prashantsengar25031@gmail.com> <d9177176-75c2-4273-b5ba-d0c6afdad6c5@lunn.ch>
In-Reply-To: <d9177176-75c2-4273-b5ba-d0c6afdad6c5@lunn.ch>
From: Prashant Sengar <prashantsengar25031@gmail.com>
Date: Tue, 20 Oct 2026 12:35:04 +0530
X-Gm-Features: AclHuK_7y3QBi-8T55S8hZraTXagD4MrO2PiPkvzXTg04An0LfQcykZBh015bfk
Message-ID: <CABW1sBkKtBt0gipBNsNRWbwYy3GSDbe2d0TMBX8=whwu4WQmJg@mail.gmail.com>
Subject: Re: [PATCH net v2] net: usb: lan78xx: avoid NULL PHY dereference in
 WoL setup
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Thangaraj.S@microchip.com, 
	UNGLinuxDriver@microchip.com, andrew+netdev@lunn.ch, 
	linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

While testing the unconditional phylink_ethtool_set_wol() call, I
noticed that it returns -EOPNOTSUPP for the PHY-less LAN7801
fixed-link configuration in my QEMU USB Raw Gadget setup.

The NULL dereference is avoided, but lan78xx_set_wol() updates
pdata->wol and the USB wakeup policy before calling phylink. I
observed the following when disabling WoL:

Before SET: WoL =3D 0x20, USB wakeup enabled
SET WoL=3D0:  -EOPNOTSUPP
After SET:  WoL =3D 0x00, USB wakeup disabled

LAN78xx currently doesn't register a mac_wol_set callback with
phylink, although it has its own controller-side WoL handling during
suspend.

I wanted to share this observation while investigating the WoL path.
Is this behavior expected for the fixed-link configuration, or am I
overlooking some existing handling?

Thanks,
Prashant


On Tue, Oct 20, 2026 at 2:54=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > @@ -1805,7 +1805,9 @@ static int lan78xx_set_wol(struct net_device *net=
dev,
> >       if (ret < 0)
> >               goto exit_pm_put;
> >
> > -     ret =3D phy_ethtool_set_wol(netdev->phydev, wol);
> > +     if (phylink_expects_phy(dev->phylink))
>
> Is phylink_expects_phy() actually needed?
>
> > +             ret =3D phylink_ethtool_set_wol(dev->phylink, wol);
>
> We try to keep the phylink API simple, and put all the complexity
> within phylink. Hence it would be better if you could just call
> phylink_ethtool_set_wol() and at the MAC level not have to care about
> fixed link. phylink knows if there is a PHY, it should decide what to
> do.
>
>         Andrew
