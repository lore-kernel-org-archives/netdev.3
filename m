Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38DC19CCF7
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 12:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790859200; cv=pass; b=S0IoS/6+ve16PIgZVD/u1ilOt7f/itvL6PSC40NWym/yjmReP7cwOyU/9SJp2rbkOclEWss6OVdqX6Qj1aRLNPrfQNqskebttYyxp0+uzjadktCbLKZ40bVX0WTRZI89L7v06KB7SxH6MK5FXqRKWtB4xakB/tAvIRgDEjAYm5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790859200; c=relaxed/simple;
	bh=otOvJx+v4mCctU0P8KqwJwZBPi8bcxSLIa4r0CqtLHE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HNDn4ybwhlMtlip1qxHJrNeiKICnqktTmwhaz4Z5BYRdMhCPYdq8i1H8/e7aPj1pePnbZGX+wkOsVe1i3NrwbhecfatTSdEeoeU6ayO0X4L5PXuLL85wEZqEuLX/pdkAcEVech1r1+NwCNPn64bIj9NmTOPmmG2WSrsTJAiwosg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rr7Q4DwC; arc=pass smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rr7Q4DwC"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6351831so3806818f8f.1
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 05:53:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790859197; cv=none;
        d=google.com; s=arc-20260327;
        b=XXSYzBvCBi3nevbCWvqne5oluDwP9gwJ3mnKgRYrB+RNZFQaPW56DW6p4LrVlLZi0g
         Y12F6LxcMfBYAwBawOdyNEL4e3+MCEOheP7WnLO2Eme2U9qMKdukHFUZarfhteWyTy4v
         ZGkRyXV7cEwQxfwJkTVi9faSL1ixFGNI3gvTrof9gclRzWl8AyFhMHB/Uc9vtzFF7bcE
         3ma6/z9N8kykCLhwkqqiTXGs32Mj9qK+o1KZQzsRa52m7pUdGRcfi1KHOih2X8/1spWO
         lFx26UvERY/P8cW2JR9jJ4d3c08zSIVDdKuEdzTR0SkFlGaYfHwGyik7JyN8TevBBe6t
         Q1xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EgB5pRH87iQRk7r1D5YO0SmXMstv2+ESj47+eIJsfuc=;
        fh=9emtqt5bnNmmVwtCghCrF6xG0KikvDX+6z/Tv/ZVjAA=;
        b=f/N2W5XXiD7e9xCzeThjxgqSRKwTDpXZlLi0wJJFmRL/AdejsLWnzPVj+hAvxvjWS+
         8lAoOdtKuQ7JyUtQD5YrgUW2deekwRMsusRpbDjuMJgq1GTdaXqUZYqJaIUgd8u8uXuP
         MdED94BoGzJFTWVNPvfm0HUaIXrq2/ThAWMV5GZQGt6wsw3ZCeDgoHin7kAJGkg30wst
         132q0cHxaSJVajF8x38ookZdkxoFkZdMn/536mecx4ate42j6qNbxujocGqDYkc6WrUb
         VhENl81tZ7Zetz5BydR6D70vCDATJj9MTDiupnsdRwVqHbEbKY8iO4WFdsfH1XX0Clq6
         yMIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790859197; x=1791463997; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EgB5pRH87iQRk7r1D5YO0SmXMstv2+ESj47+eIJsfuc=;
        b=Rr7Q4DwCEb8j+P1UKHezNeSTxbX/ttJkufvsftz5P9M7ssFGMTLGjNnUEKfS5HjsVN
         bLh6weqFn+j8ROckepwj5yl791oyJh25gl2XrCJ5fkeHiWlMDpunWxrNIaaVbH36ZZ4D
         S97uSm8hJM/Y34GCV09cxEfVJ6AYoYwZ1yRtJg+sXJUUOAMV4mM7CS8tWO+cXIaWtHFp
         U5m2FKWNoVvVxoJWGFfLf2xUKu7UvNnu6amg1S8yEGzpHMV/bysZLowgmHbV6gj1Xn7v
         QBsWYHOPeHHM3orpwBZt9HApIThg59Cfqz5ExedmvhDG6EEsKlCLCiL5bG/Yk/L/Rg1q
         KF4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790859197; x=1791463997;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EgB5pRH87iQRk7r1D5YO0SmXMstv2+ESj47+eIJsfuc=;
        b=nJQSibsl+KYAXALynCaPrtOZz2rzhl69X0P0mCo8aQI0eKUAZSyqxvH6kLBXMtut0c
         ML+kb9gc8bHoT7rTV2dCXOENMT5/wFxT/l+wkxQKFu8Vlt2eOdR4AHFpkb/hQepmTnUJ
         BwxGXDt5ZxNq2tLesx2OMAntY/A1PzD2amCjhEQ6+Ja2r+vInXDjzGYAEbj7K+/CkHnE
         29xK3z1zBdja8F/JHnTeBwEh7GaO3hd2QvQLDy+wY/oSp4Chd0RazQ5RdzL/NvJVkXRT
         woL6htfGNrmRrJNosLRMJUrlYXUSqpGGipe/HEOlCDXAK2kUWbZJPj1nt2AI/W7hrg7A
         /i6Q==
X-Forwarded-Encrypted: i=1; AKwUvByLaqFjr9pBE43aulfE/w2qGbfkRlI0kUJF3u5vdBL6SqsMuv5Jl4lv99MpHvQFnQAdGB0fhYw=@vger.kernel.org
X-Gm-Message-State: AFq9FYIAxz4DPLshuWbPc+VZGGP7dGe0POdBEn7rrnhtFc06WKwBr7Yv
	GbxCd5OYrol44GFDZWdIrbDJHtuZVkdKpmjEhU8kd4QRTNJ46gxYCAE0Ev6laVGiGdpzxcfIE/o
	Fq9B8iJO3H3KSTU40t6Xoui80Zv3HY3Q=
X-Gm-Gg: AYBFou23+jGb2ksYpnf9aBfAAc52W9SozFbHOSUgBqp6Tqxh0cvEWCrS/VCYlDJFe2k
	Jnawc5lh42PFtF37W0mOgxKBxunrT0IWNknARIm8O4npebc5EIMEqa5tLip9YLJAYTJQBS1FYom
	YDsyj3Oc7Rd8IhoMw19ZEaI5TBRfb1M2nt4vWzyBC9wrvpailBBVUPMt5q4zkZrM+UxQecoGF6D
	XMS42Nsa9acWcoMyqZaQbNe9o9BFXXHohk6aDga9tB4f4oLMkc/2PZMa7Hs1+aPLMzA/KADcrnp
	MiSpMa+XpokA7mTMXzHUkvEbmM1AysVgxqa84PEU1XfZlj1XhnzHokE/LrXkGZS7PZHSc0kA97r
	2xwnqkcvvQitV93L1er4W9qBM1JR6kwVzfuLpfxWdrRQRCMhxul7AuyoTLUZZORxqQ7r4BFxI2w
	==
X-Received: by 2002:a05:6000:25e3:b0:487:81c:6de with SMTP id
 ffacd0b85a97d-48b02508325mr9021943f8f.34.1790859196761; Thu, 01 Oct 2026
 05:53:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928-miic-validate-dtb-v2-2-1ee3d33748e9@reliablecontrols.com>
 <179085726114.434549.9959783778596639760@kernel.org>
In-Reply-To: <179085726114.434549.9959783778596639760@kernel.org>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 1 Oct 2026 13:52:50 +0100
X-Gm-Features: AclHuK_zR-x6ip1N3fhdB5PHJQsBa-WlevX9rtbONnoIWhDXBj2buHYHs3VNnC0
Message-ID: <CA+V-a8uOzGjem5R0o-7i3HAcFi4oiw8+=v+PMFC+XVsaHEGDxg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/3] net: pcs: rzn1-miic: Fix miic register
 initialization loop
To: khendry@reliablecontrols.com, netdev-bot+sashiko@kernel.org
Cc: clement.leger@bootlin.com, andrew@lunn.ch, hkallweit1@gmail.com, 
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, prabhakar.mahadev-lad.rj@bp.renesas.com, 
	linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kyle,

On Thu, Oct 1, 2026 at 1:28=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wrot=
e:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] The Fixes tag and commit message of "net: pcs: rzn1-miic: Fix
>   miic register initialization loop" blame the wrong commit and describe=
=E2=80=A6
>
> --
>
> net: pcs: rzn1-miic: Fix miic register initialization loop
>
> This commit changes the loop in miic_init_hw() that writes default
> register values. The loop now runs for miic_port_max - miic_port_start + =
1
> iterations instead of miic_port_max, so the count comes from the SoC port
> range.
>
> > The function to write default values to miic registers was looping from
> > zero to miic_port_max, which might not cover all ports depending on SoC
> > numbering. Determine the port count from SoC data and loop over that.
> >
> > Fixes: c112520de041758e ("net: pcs: rzn1-miic: move port range handling=
 into SoC data")
>
> [Severity: Medium]
> Is this Fixes tag pointing at the right commit?
>
> Before this series, the loop in miic_init_hw() already covered every
> converter on both supported SoCs:
>
>     for (port =3D 0; port < miic->of_data->miic_port_max; port++) {
>
> RZ/N1 uses miic_port_start =3D 1 and miic_port_max =3D 5, so the loop wal=
ks
> ports 0..4. That is 5 converters.
>
> RZ/T2H uses miic_port_start =3D 0 and miic_port_max =3D 4 (from 08f89e421=
21d),
> so the loop walks ports 0..3. That is CONV0..CONV3.
>
> c112520de041 only added the RZ/N1 data.
>
> The loop stops covering CONV3 only after the previous patch in this
> series, "net: pcs: rzn1-miic: Fix port numbering on RZ/T2H". That patch
> changes rzt2h_miic_of_data.miic_port_max from 4 to 3. So this patch seems
> to fix a regression from earlier in the same series, not a problem from
> c112520de041.
>
> This leaves a bisect window. At the previous patch, miic_init_hw() on
> RZ/T2H runs only 3 times. The CONVRST bit for CONV3 is never cleared
> during init.
>
> The two patches also carry different Fixes tags (08f89e42121d and
> c112520de041), so stable trees could pick up one without the other. If a
> tree takes only this patch, RZ/T2H still has miic_port_max =3D 4:
>
>     num_ports =3D miic->of_data->miic_port_max -
>         miic->of_data->miic_port_start + 1;    /* 4 - 0 + 1 =3D 5 */
>
> The loop would then clear MIIC_CONVRST_PHYIF_RST(4), which is for a
> converter RZ/T2H does not have. If a tree takes only the previous patch,
> CONV3 is skipped as described above.
>
> Could the miic_port_max change and the num_ports change be squashed into
> one patch with Fixes: 08f89e42121d ("net: pcs: rzn1-miic: Add RZ/T2H MIIC
> support")? If not, could the commit message at least state the dependency
> on the previous patch and drop the c112520de041 attribution?
>
I totally agree with this feedback.

Cheers,
Prabhakar

> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20260928-miic-validate-dtb-v2-0-1ee3d33748e9%40reliablecontrols.com
>
