Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793154227;
	b=Ur72BUJn1ENflX1HLXmW1WuDCzBC2jzAsScXX4T+GUiiFLUrmgtnBbtlgv3XlVl1jrkY
	 CpgPVI5sQpTrDyUKOqyvWuGPlhlzgSS+TyqLyb1L5469t6g+ZWiyjQuborqS8Dn+aVoMr
	 veIQDsq61aS0R9/6KySFLTANEnPSuql7x2L3WPqUhJvU8u/KR5Ctq5mEESCI6lCMtsqpB
	 BN1arb3zp5v8hWr7/AngKQrd3n4ojQ1OCbHcnhooULCXbO+4Ekv8Xc+e/Zr22YHhS/qJ8
	 j1P9zIfzBbJ4TxG7ULahG3JOuMWwLwsJd1GG1HX53UJXNhPSTW5iIimOaqqltlqSh1w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793154227;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=f8qJrQHtshIgxX3OGUAaV2ID69tgVW0h7OtHT26+hAs=;
	b=09rAaK/ATpkQCYJXQvhhWZh9F6HSwM7DbO/RqJJinwIRGJVnxafvcCBAtUqNwDfet2vO
	 Yg8eDe521sICK2cxBlInaKfPanA/KgwggEMEFsIM/e321U4QqEyT5bjbIaH2zwx60JTV8
	 1m1IgQjMtiFiatfL6aElEzNHGgdw3IWW49ck7BgIJycQqKfCE0k8QDWAovCyBZTtLR/ye
	 vHqxHrNiUgnjpvbxYyl+/vNiXqzPvIco+vjj31fxsleyCIn3Y6Uq7prH73Zf3drVg/ZOE
	 656TT7iFGBJicxJFNhC/Yi5IH00XR/pl/qZJRrD5Hu8ZYWPS2gxV1/by0KdAbsbDUuA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H1VvilEl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.46
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5985F606A31A
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 02:23:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5985F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H1VvilEl
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6b47c1a3c74so683522a12.3
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 19:23:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793154226; cv=none;
        d=google.com; s=arc-20260327;
        b=QrUO2ql15cAqippK9nuutIX/KWRn6JII0x/nzuyxV9qiYK52XTnbY23dnX86htEbR7
         EM9RjzrS3Zqz9UEjzTzEtO6Mv01Oz+KxLMq48wtekHdbeTxqVchN8FMSIGbFr4naDGYg
         n2LxEsAI+IEyIo3pjNcvKjnwwZs7M2Fc0OuHGmGlbERJPyTaf/sQy9SPdElPFbeN6TtT
         h//CRerfclGzrQKjKa8gxrBU0jk4se54eE+7DoSjAXpmvtbs0+HqPimLEVrNVIlijtpU
         aiiBD2xr0nylOBd5WmVrQHY4TmV10vGvrGEvLYzNFixzSEJ9ThPDssVxhSES9o4aeJgt
         YQFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f8qJrQHtshIgxX3OGUAaV2ID69tgVW0h7OtHT26+hAs=;
        fh=LWkAZdsNKDenTNw91kEm/QeWVSvmg3moSY8sfQASArs=;
        b=rLVwLuT50FpIOWFDR1uAGdB4piFiMJH1rI90kjErs9SfJOVmjK3tqwpDCAmSIGwIui
         PEMwgJuI7vWvMZQK+ioc2rxOnUOwh1HfhNvNjzWwmvxQSBwXMqrPZMdovTGhGpLzN9WT
         /RS0XvyPeq5hcgDbR0nQdMrinNt3Z/GNfvWw2OxYRlySA+h2kDYef1AVL2/P1Xr44ux2
         XNlwFa0HN3XHk4nSGpW9loUHCMNM9vX8icpiPcwCvIiGxDOwmcNarW5Fd8mXsg+G2LYl
         Izl698XvU4gEWc1rPqjk0auI0RTgaWO18k7UMG4Dux0D/ATWHqFbPUDKi7ULNIi+TUty
         29nA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793154226; x=1793759026; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f8qJrQHtshIgxX3OGUAaV2ID69tgVW0h7OtHT26+hAs=;
        b=H1VvilElQADmJrCePHxT0S8IzePFoPHfVOqSxv8PIZGYRAmWiwWxg/Dgl0cR/BfyeK
         aHTEHtZPBeo+1+zwqgetnr6dlwRi3IFT3Cq6LrxlW2YSSBh+c2vRSoGEiMJKkcNuEg1J
         rfyJWuI2fhdRndTPjcscL2Zf1P7EWCaIm1cnrtEALhKyHn6PHDhYWJx4FR5AvpwLvZy7
         fhzfXcOR7n/0AAUbEi/GON9m70TkVD4/m7LshuLBt6AnWjwAtQU4JyBs0P4BybXfogD3
         mSoO84Rpkhmo6TubHWmU5NVUSEPgS+NSblAtw2IG0LVr63y+PIbYroByIO0/c06d4TFa
         zSFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793154226; x=1793759026;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f8qJrQHtshIgxX3OGUAaV2ID69tgVW0h7OtHT26+hAs=;
        b=WBgQAKrJBCWoerrZrIHrfcAqR726UI5NonIJnNreH70OQXz71JZ19U3IFvU77hZ1XR
         2VFskIFmvCFjumf6c4J2VBlEZBDCl56uL1NVUhP72J+zLCrva8FEBUzvwz/09FmeoDSm
         wbAfz8CTS7zTyf6uNie3KDBSJQL/LgVutETAtKNlvaq2aRRRxOyWQUgG9wSaBc/9ioUs
         +RiZ/LNL0EFM7GEbMnQJYqoZiEa4yaGSoznCuVdjCLlN6fni8Q57kZz9yCaZ55eeJAVs
         NMCvd2Ay4qblBLXhaLpptzGr8X2hGFtIpr7eruJdDlND3L/mYHanZT3RdzuJYreqk4qv
         Qqmg==
X-Gm-Message-State: AFq9FYJpfPouxISser2RzlSQMrQGYMQlgUH+fcIh2WJFHFERUqxotrRQ
	C457tsSAAiEvr5ujNGjA1Py5pzJ/T6uFz8a52SJBxYsJKznNtY340HbPBzgjw4O5bsgofB745XK
	xbe4TzwS719qJNQRszYfsO68oBIzoD0k=
X-Gm-Gg: AYBFou0lI5dz2hCQJdcn6UY+sjopGmOEx48ALbygvDSGjAtshBJboCg/0ICIhoALDFt
	FMmuotG0iUZbimY6cdqfhof+WbyC86X5ypeWBSFUl0NjG1O8Wzrjn5p0+XH9gOs6riTOIOpBcfh
	NMA2wNEi7hRLW2xc/kLdA94d7ZK7YRIJsIttj6z4DxznfDeZMXvVBBy82xLf3geZDx6kYfqQlNY
	CAudqxgfB8S8+KvDm1s4rsU4fsfK3HRhsGx3gQjd3IwGF1mewLbnk7tn9kAT0oagl2Zeauq+bRX
	E80XW0e1/QEcZL0oOUOtH8tdX1STRBzzFFSPff7op1FshGb2znJewLV41mnwnAngXPCmU/TUJg0
	2njUXk4ZcrHBSOSoDDWnQdhl6vnz6jBvqHiQa3Fwx1HgrRFuXiyKpuJHui7/b4G7Bcawq0Zq81z
	s/txlcUDJdJU8s36hT8f9uT9lu7S9ozRUqgJfowW3vG8E2z71wzKlrIcKhYGXd3Ypzz74D5SF+G
	j1LhtC4mZAdCKp+7AHbA2J/sNXrgKZ3Uf7A8pIJiaQYboWX0g==
X-Received: by 2002:a05:6402:2b91:b0:6b4:16fb:b9be with SMTP id
 4fb4d7f45d1cf-6b49cb8e213mr407621a12.37.1793154225577; Tue, 27 Oct 2026
 19:23:45 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028011035.49201-1-rosenp@gmail.com> <20261028022128.GA201431@pc>
In-Reply-To: <20261028022128.GA201431@pc>
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 27 Oct 2026 19:23:34 -0700
X-Gm-Features: AclHuK8E0CJD84w3EWQeIORDl1rABxmtpXg02aZ07bx5Y8fsTOc1Rm5pajA-gwo
Message-ID: <CAKxU2N9q52vrg9USU=N5_e_Yx34KsULY3j0nV1zExFbNa5-PLQ@mail.gmail.com>
Subject: Re: [PATCH net v2] net: bgmac: fix oversized RX frame check
To: Chenguang Zhao <chenguang.zhao@linux.dev>
Cc: netdev@vger.kernel.org, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Felix Fietkau <nbd@openwrt.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 7:21=E2=80=AFPM Chenguang Zhao <chenguang.zhao@linu=
x.dev> wrote:
>
> On Tue, Oct 27, 2026 at 06:10:35PM -0700, Rosen Penev wrote:
> > While reviewing commit 77dac783f11
> > ("net: bgmac: rate limit RX error messages") , Florian spotted that the=
 RX
> > length sanity check compares the length reported in the RX header again=
st
> > BGMAC_RX_ALLOC_SIZE. That is the size of the whole fragment, including =
the
> > space reserved for struct skb_shared_info. The data area handed to the
> > hardware is only BGMAC_RX_BUF_SIZE bytes, and the frame starts
> > BGMAC_RX_FRAME_OFFSET bytes into it, so a valid frame is at most
> > BGMAC_RX_MAX_FRAME_SIZE bytes long.
> >
> > A corrupted length between those two limits passes the check, and the
> > following skb_put() runs past the skb tailroom and calls
> > skb_over_panic() instead of dropping the frame.
> >
> > Compare against BGMAC_RX_MAX_FRAME_SIZE instead.
> >
> > Only compile tested. Not tested on hardware.
> >
> > Fixes: 6a6c708469c9 ("bgmac: add check for oversized packets")
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  v2: replace Suggested-by with description.
> >  drivers/net/ethernet/broadcom/bgmac.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/broadcom/bgmac.c b/drivers/net/ethern=
et/broadcom/bgmac.c
> > index b3a92ae95de3..6873c7bb7a14 100644
> > --- a/drivers/net/ethernet/broadcom/bgmac.c
> > +++ b/drivers/net/ethernet/broadcom/bgmac.c
> > @@ -455,7 +455,7 @@ static int bgmac_dma_rx_read(struct bgmac *bgmac, s=
truct bgmac_dma_ring *ring,
> >                               break;
> >                       }
> >
> > -                     if (len > BGMAC_RX_ALLOC_SIZE) {
> > +                     if (len > BGMAC_RX_MAX_FRAME_SIZE) {
> >                               if (net_ratelimit())
> >                                       netdev_err(bgmac->net_dev, "Found=
 oversized packet at slot %d, DMA issue!\n",
> >                                                  ring->start);
> > --
> > 2.56.0
> >
>
> Hi Rosen
>
> FWIW, it=E2=80=99s helpful for reviewers to have a link to the
> prior patch with the new revision for easy reference. :)
https://lore.kernel.org/netdev/20261023005313.3946390-1-rosenp@gmail.com/
>
> Thanks
> Chenguang
