Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794416101;
	b=NVJE7ZV5l0yk0u0gl9b7Haetk3yYvdaKQ4q1KpitAyCGdTSL0CvweJRaj6lQ0x65dAhN
	 IraGPGz7r1WWNU2g3yrEMdfu47YukmLZY6sD9NyDZNpli7IkOvjNlJl8sCbxKuQdRPZBZ
	 KSLEsZK8oZQjNUXumQisPqN9RyT8u2j2hMDg6jv2F2Bj7Vgezafl+lYN3ca9N9pPev47g
	 ZBY864/G8nWM754Y1neJvryubzU8MX/7pm/OjPVl5jw4Cf7tlACtfLe1TqyFaXp9JcjJ+
	 1JLjmPPKVK4YeW/6LDViThaLz1TSbwh16nA1B1i5NGAfdqzl2N186CBCG2pI/CKD19w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794416101;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=/QxBjYodSWQbPceJSRF8tQfkfunks+Jqd+U78AusPnM=;
	b=nfzUBMRQ1ApzxMgj0Eus0nGGYqQOpM0t521mUW5oTJ+EyojKoS3ZM8UaLakwBFPEbbok
	 zGDydToJMOXVkhW1+Q2GTkp4dm9p1v3mEWqxViQ6trC9ih2eTjTIP/RtBLCh7LBybp3OH
	 ey40FeQNQTvmz5WvK663l1ds9Brh0csURh3+inA/PyfiyJeTTdShVP92nagJGtwhj7PM2
	 sKv4K5Dj1Q/ytwnDYmlJAPI8iLChnp9Gp0IuQGpl2lFL8ibb6BLAIMkTsnuhuBryKIWV9
	 LJ7HE1Lmb2YJ5lY4OWHki6QzeC1cRG9CUtnX3NdIZZ0vLiidMREW2HSjIcGMBdIcD0w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RA+sU1bI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.177
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EDC606A889
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 16:55:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70EDC606A889
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RA+sU1bI
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-4c5d8c7f326so1325187b6e.1
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 08:55:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794416100; cv=none;
        d=google.com; s=arc-20260327;
        b=GXn3G4i3s/wbS+TjtsaOwKsARIIvlngrZqZbfsNPywiS/5IwkPP3yPNuRbmiJkw502
         StdesQJYTHc/G+Nuf5oAUSubkwCKAMa4gEn9DIWkuEeED1byOzF9GFE2mSg3tkMOrDRm
         7lSpuhbL5vGPwbSfI2IWgz29U/eGMWxogMYDcKGZrEe1xK6wJYK+Bb6xOjNvOT2B5pBp
         zs13kFFIzmAM+bioYMAU+Y1V+9BLIPLPm0trejxbXrJYkVMidf1jhzDYtxTXQRlugRJe
         +nr48jjotQWcfPOe5p/PNCKmEfZ08WfApdJXIvrEWn3sddZJ/hdB4QN6OUCkos0cPHNd
         H3AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/QxBjYodSWQbPceJSRF8tQfkfunks+Jqd+U78AusPnM=;
        fh=zQiFyuIGztdeIe+Rx8Vtvd/xNXyLo/70MCZV/qtD91k=;
        b=rG3R1+iyfZwVn2MI09jz23eEqGvpibntkotzPclxpgvztMTEtznCzqBx4u3LYcDRxN
         VuvMVUE2UNlrFJdaib+mTgQqiVgvpmK1KDL0AaXFChjPqGiGeEktwk4FgMsX3LT1iogc
         I2ULaZYbFw62URMqm+ll02XYyKKUl+hd17AQYenGSc4JaPbhhiJvr+2MyIbVvuQ0KgAZ
         4wj74VMIZaITStXqD30XFrZONkmqSr1aBhdEIxP5jJ/wP7O+dAVcs28FAQWnOvGoxvew
         nK05O/qJkXDDFCPPlTeEM8p5A1iuMnvKW51tr9Z6F91HGJXJTHdEKCdSn5zj6QRZx148
         GnXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794416100; x=1795020900; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/QxBjYodSWQbPceJSRF8tQfkfunks+Jqd+U78AusPnM=;
        b=RA+sU1bIUDvshTpRKODFdeFRJL0qZJmbAe0uTQncFme/lg4+zVg7OYvEtId2VPYApe
         SX/RCISn/U8/RN+iqlaOr8C1l/66ofh/EHsZgpt7EeIeMsfagnrpB1dDEjnSK03YWtvT
         3aDiJS1o5vR5swCyI0SV5Kc871XyejlbjOgI0DFKEv3uKmROWnRulHfvnbhHDnAExUnm
         aTVlf4wUGYPZqbB7MCJij3w7mERaNCY8L+voE1uetX13GQtu+rfos0vRXuBZAwcWkOns
         qJs7Axj/nwrF++BAYIZ+zubKqRLRXgzTkfR+RAjdikkzNXq73R4JIb4K3vxd3wuHL1Q/
         Cntg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794416100; x=1795020900;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/QxBjYodSWQbPceJSRF8tQfkfunks+Jqd+U78AusPnM=;
        b=eEm4E7WU7gmcAmZP9i9o6dfqm2vT2yTmyG8cDabp0SJ5xSwtOQ9rGCsRW/uylEWREz
         oSZ7oAYzmTscYYKSWelj7cg6dVdx18llSBweXw9+2xecrxwEOsQeEvJTkO4qKllLkgLL
         wZZEX35T3UgZ99nW4mAAVC/V4EUp1Cln01jwJ+FBlx8X4aaI9e41Hsy2Z5v/KPdqlrtm
         0hX1ubXhghUvLGhVaeP7o38rCUzkJzY4RGTHndKrlENzuT31fxk+FB14JfAPkUt2jRnt
         MblmyiqiDu1pdqh4PTTJ4PapJqvAkUxwCX4ANSuE0BsRsf5BlSkrZLA0S5G5t2hf9gy1
         xL3w==
X-Forwarded-Encrypted: i=1; AL+hErGmaY/nv64GD267VZyg3oKU6JjV3pAswgfQjUYfBLp/j+9+6x1dkf4jDLMY8amMWDGKfe85Uh4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8/ZlFcL1HAP3YIAhBOgbRq7BTY/89AU6O9mCrlZZC2zMZ6Y7y/
	JrqhwqbitfYjW6r6i4yT8/43Q4d+rq/fb9B2U6Cz8+UItEE84bT1obTj0qSOhma6xNhtXHxC4M3
	rrNyZyGzmTetBG7zC/0CSgYv3r10kld0=
X-Gm-Gg: AYBFou3Ib4OwYWwBypgnZROAbmEGvK3ydfM8r//wq9Dii2SbzXlDyA441cPRTlqrVIN
	l4bFVa0XoTxNO2cxr5M+fQn0nTDJaVUxli8yhgdOr8VcPdAeDBKbCCzKFynxP7sHu30K3S0cxi7
	yUVYJ2iOMgBB2b+2qZUxX9BOR5rbiyOQgmktLVAkP0Oe9eTvNXJIbB1UF+AId+jHXd/5Rl9+ou4
	iQr12T4+IAZxihFcD/Ia8Rm8qEkhHuKgFBlx/7wibdmRdr74ZSxU0I5NlEtA5EE75jAuvajqhZr
	+6JbT/HlhD6D6hC5s4hDr7feA2qmbXfWsbJqJ+SxGgVnaOWSxCDZRbiaLnJoH1sCzAeHzQ23ZsL
	pOXX6WT2Gd3zLvhbAdxw6H5iIZ0bUGYPMOcCeHqtZeIcjI9O/fzGY9Z9oU6NxgrsvZfqasIQ=
X-Received: by 2002:a05:6808:30a4:b0:53a:3533:10d7 with SMTP id
 5614622812f47-56b96298e4bmr2580318b6e.14.1794416100173; Wed, 11 Nov 2026
 08:55:00 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105031442.4164960-1-kyle.switch@motor-comm.com> <20261105031442.4164960-4-kyle.switch@motor-comm.com>
In-Reply-To: <20261105031442.4164960-4-kyle.switch@motor-comm.com>
From: David Yang <mmyangfl@gmail.com>
Date: Thu, 12 Nov 2026 00:54:23 +0800
X-Gm-Features: AclHuK-U4mMKhwssiW9rHnMWYquQbzYY1D7gCMxyTnRq5E0ycN8owzUXZceUdYg
Message-ID: <CAAXyoMOTWjCHNQ6tV-KF2=DaOpXVAbX795hWA7Q5dUQxwH=i7Q@mail.gmail.com>
Subject: Re: [PATCH net-next v17 3/5] net: dsa: motorcomm: use fixed-width
 GENMASK_U*() helpers
To: Kyle Switch <kyle.switch@motor-comm.com>
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux@armlinux.org.uk, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com, 
	jianmin.wang@motor-comm.com, wei.zhang@gl-inet.com, sijia.huang@gl-inet.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 11:14=E2=80=AFAM Kyle Switch <kyle.switch@motor-comm=
.com> wrote:
> --- a/drivers/net/dsa/motorcomm/chip.c
> +++ b/drivers/net/dsa/motorcomm/chip.c
> @@ -2285,7 +2285,7 @@ static int yt921x_chip_setup_dsa(struct yt921x_priv=
 *priv)
>         if (res)
>                 return res;
>
> -       ctrl =3D GENMASK(10, 0);
> +       ctrl =3D GENMASK_U32(10, 0);
>         res =3D yt921x_reg_write(priv, YT921X_FILTER_UNK_UCAST, ctrl);
>         if (res)
>                 return res;

Just removing this line of change will work.
