Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792500555;
	b=qKbu1zFVaze2aKkNcBlvBntIoZUaBB7SGSReWbUhorvh+eB5W5IgJe7DTov3gsnSdQp6
	 1aM7jgxMs3fjpEsHA8CZVw6ug7AgRdT/CM8VTdZmGKTU58K1tDe+AS+JuGrT6CHpTqVTX
	 eyVwYgH6aNllOZoS0m3H6mcUgcTXkOPXPgrhFNWL3Bay1S3sLFP5+zogB9u2ECJwpTjCG
	 ArPdNq8gfphv0z0Ai54VKwkIaD18PqLm9WL7lm9Kg7jy3jDYQspB+vpU/JMPQAHn//pRn
	 /crhkhSbprwXtiipOYgrZXNiYz/TfVXXyms0KYZo6sTaxx32tNZT+bKD1vgsUkXho+w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792500555;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=CqnJR5Wud1DAN6Fg9Q8koGamno6KsLilMYisqlHxAoA=;
	b=CmvCPLgN8Px9hG0C9re5Yc8GGnaoRc0cFTKBiOkwEwcYeWiPz9W/wnkqU5I5mCNzLmMa
	 Y5AyEzYGtBBmKCTsX+yHxcBoNPtNj668vQ9lCRmS0g/zMQyzeQWiSgU22dSrWM0d/Pg2V
	 EAMZw0GQH5BKAf7R6W+N3OBWvTkRGdD9T3NVJgiJ6zewsNJc9bO+W7ppRxzJagz0FwE+M
	 +1z/r2Hrso7A8STx0GLudz2zWN/nyRiTN3mPiE2M1cYFu39Rx9+cyWwR2UshT47N86L+r
	 0VHD4M2x0WyjIsi+hRr9ghgHMqdNXJfYKZcm6j9ptOTYY+7qYgeo5GrwvFcfkroBGtg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sartura.hr;
	spf=pass smtp.mailfrom=sartura.hr;
	dkim=pass header.d=sartura.hr header.i=@sartura.hr header.a=rsa-sha256 header.s=sartura header.b=rL6WWZyG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5162C606A31B
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 12:49:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5162C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sartura.hr header.i=@sartura.hr header.a=rsa-sha256 header.s=sartura header.b=rL6WWZyG
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3acd21ba21aso2334399a91.1
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 05:49:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792500555; cv=none;
        d=google.com; s=arc-20260327;
        b=a2xMo16In80LfhfTuST+9beo8bJh+CU0Niq7mtNWKbMoK9kDILBXAp6m52G5AAVCE5
         AJ5SRdx0E0Na7WwzFsC5R8lHf97lE1pPjAekT/fyMYXmiLwIdTiJV/1EcZK7d+LrC2FD
         eHdnVDDEuLU/Ut22tONP00pSu08chtoAjkyIDdTzqNysrgZxYbIXDCAhfnSZaeeeekMf
         bZ2C8FHWuwcK1ZinclzLKPX37wDlDRc2/AiUohxeMSBjnH6g/FM9m0d2FzrVfkZx7rHp
         J9xq2CTgK+FyCn1I5Sfr9QWeuDRrfm53IiQAXMR/KTUacbUncVKuaVzUff8d2+YYhQy2
         Ig1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CqnJR5Wud1DAN6Fg9Q8koGamno6KsLilMYisqlHxAoA=;
        fh=Zl/FnWyMYTzOu2onzN03+9cwzb6UbAQzHJNn8mfkjTo=;
        b=QJGnqrJ4wb/tlj/niY4eEEkFW4lqEJHGw6vjJUOelJ3n5/rGlx+41huo7FNgWtDDqL
         q6M9nYoVYaIZYl+/ywPFeAOEgVa3z4ocsPEEHnT118YMJv+ronDV4G1/rqhoEQVwC2Fg
         2FN95FIy5EYtihGSdinxvzScug9nYviLO2h4LB3/nBcwHqdSByjK0faVo6Q8bcFoKWB4
         p2S+fpu9+9kTFcPLeYcz1RkMY/5saW9D+vDVjKngx+9afv5CH21n4yX/Ko4ryw+w9laa
         9afzPp+Sio2Xb8bta7gW/3ria798mrZ8NKHEfaJBPlG07twx1S0xnDE2PlzwD9BhvyQ1
         DLTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1792500555; x=1793105355; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CqnJR5Wud1DAN6Fg9Q8koGamno6KsLilMYisqlHxAoA=;
        b=rL6WWZyGJ3W3e3+Utht2+BdLbdxPTSSy235V9hfVvYaxXKj2VNXGzb69QZgg5R/sb3
         matF7cmJ8hr5KQLCxG2RkpmAqlEN8qZaGTXWmaSSfpzYDwhPKRH2hEJGRMdEs/ZHLhb1
         NsRkA39Pt3BIcMUoffHh9+yOXjdq3u4FySWTrbri9CUkYapRRVJxCBfmx2ghlDQxKE+q
         BOX9wYPxsuHVCkx5CS1v1Ny0VFCqK2DVbmKCA7mUnfuLHxEBLTNuoqOsLHV6J494MdXC
         P5CKjjX5opd2nCfEcB2ARvPw2nq77l5EuO1ybDEbW9nzdbyW5wu5EOx5wfVwxNVuB+FS
         vjww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792500555; x=1793105355;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CqnJR5Wud1DAN6Fg9Q8koGamno6KsLilMYisqlHxAoA=;
        b=lswNe/FAbSz4aQUOhN9aSYzy1PT5txfFNXOuVpIdaGJUvP7IN6PNxOFkkUvT0T5Y+C
         gvWlHNFNBfD7j536cyvP9f8nX9TzCpwbHcsZl05JhjUkNN87NAloYZT0DdmaIGW/pLHc
         wKjhzn//+DVwnfZsHPj7q3ofoCT5c/UqjH4a/AQ0ra0IotfNNCxfFuyF3x8YeK4DD5ec
         ESib22FWV0xrdS82Zjf6IT0bweetZJPRWvhQyaBCm7IKcYuLhV1YaXeAyZco9aV1L/je
         xfSfBDBA0/rstuK93CXwNWemFLeoO+n5jPk3EwcGpeNw+Q83ScaHphZQ0bSdf3DmFxUG
         eC5Q==
X-Forwarded-Encrypted: i=1; AKwUvBzrdbMKWCV0ZkVnTgNYKfrcrhAQs9vdTxdtaXV1yq81+Yft/WQbq7nmYgoRLEXLVYsKUSmtjd8=@vger.kernel.org
X-Gm-Message-State: AFq9FYK/yIEqQfIXYFWaRwrKvciJPMAWURKRdyhiFiIJkBHx0JZEN3BQ
	4gjd5A7+FJlO7QRe3VI/JIWnAlYNmJDTnH0NM6MJ63EgrCxKJHCfU3yehK/OMyqFFY1AgybMe9r
	I5MmVlTuK98dvJBNvQuOl292r8oO3pQiTz4nNsF3Y5rtQ1nYzpgitTeGDjQ==
X-Gm-Gg: AYBFou2JXPXrjAI5vbovbGghW3XsPX6WUtpVRq7M+8e3zb7I97VyrDAjzDY3dTis483
	meD9cS4TN8RyUSOLte9Ebgj9unF5kMloHE39mAmOnBqL3cYesgmDIZpfZWzSFAFbI8zTTz8O0iI
	R1Lx9qYulW3yFmK55Sp7VHDNiL6n+Bdt1Ma5sES2a+MlN5dL3esGBUo9sw1GgX9Bb3JNlFiqKXl
	ANiD4o9x142ph/MHq/9hXNbLjHN8ga9PXdM9ucH8fnSjbh4xfzA+VrlCoCILquTkIdVEy/+JrVj
	Da4BcNpUP3+9O2Gy9ctYNPMwkCYTJswJ5IOqPG4ZRutJmM4CAN3tAxbHAMlvtfg21QXpAl5qNCn
	7mGfq+qaYLDxmPan9eTCnT8khEO07adHlO65MmjpeiSLd
X-Received: by 2002:a17:90a:da87:b0:3ab:36c4:b502 with SMTP id
 98e67ed59e1d1-3acef19656fmr9756442a91.30.1792500554208; Tue, 20 Oct 2026
 05:49:14 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020093655.344585-1-robert.marko@sartura.hr>
 <20261020093655.344585-2-robert.marko@sartura.hr> <554ff2eb-af27-434f-be62-17246c7a302a@lunn.ch>
In-Reply-To: <554ff2eb-af27-434f-be62-17246c7a302a@lunn.ch>
From: Robert Marko <robert.marko@sartura.hr>
Date: Tue, 20 Oct 2026 14:49:01 +0200
X-Gm-Features: AclHuK_rohgS66giciekkFEQ6V1rvibGJWMBWALaApFMciIq_wE3KnKfDINfbIc
Message-ID: <CA+HBbNF7DKkwu9X2=cykc1brHLmVnbYJe2VqbOH71S3sULu57A@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/5] net: phy: mxl-gpy: add MxL86211C VDDP supply
To: Andrew Lunn <andrew@lunn.ch>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, lxu@maxlinear.com, hkallweit1@gmail.com, 
	linux@armlinux.org.uk, lgirdwood@gmail.com, broonie@kernel.org, 
	michael@walle.cc, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lrosu@maxlinear.com, luka.perkov@sartura.hr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 2:39=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > +/* Packet Manager Control */
> > +#define VSPEC1_PM_CTRL               0x0c
> > +#define VSPEC1_PM_CTRL_MDIO_VOL      BIT(14)
>
> Is this Packet or Power?

The datasheet calls it Packet Manager Control.

Regards,
Robert
>
>         Andrew



--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura d.d.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
