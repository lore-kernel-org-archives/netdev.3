Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794416303;
	b=qEtfJZZxD0f71hLRZH+hkd1NHBV7+rx7sr3+da/Jz/VLtd+YrY9BfKe6JarW9FPcvLkq
	 2eU7tDmQSdisXHp10NvttoNxb+KHPbKoJz8bSgdXOorn3N/IEfFCuEjO6nVGfZgz+mWUl
	 V3v1ASINqEiDl7nX8W+tV2XOSzUPV5fuoHUi4rQdsoTC3aLbeqQIuoYcJujmTgCcE1pp5
	 x7q0kmqAH2IhJiIw+tiZXgtjCquLdc3/9jeSlYLAVAZUKZJrV/mofmbj9WABM525tqsxw
	 j2erAai2evb2Z4ibRjSRkVVEu/CSYiLZhuHL59A34ZxOuIn5Su4IGLSl3Rs1IeMW89A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794416303;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=15hIaeM6HY+XXzI68kpVg2E+Jve2er7s8+5re1NHej0=;
	b=YjeyfgvdlOWRXnVXtjGYK6sjcULN/zGAosz5VVOavCfpNwDcFUmP0K5T5a2HcDvO1Omt
	 VUyhwWaZOefiqaZfAM3VKWqQW/vIbCqZe+YtEzynrABZZ2c1GUD4BxHvCYeEYw3I0fb/P
	 +5mkF/h3aCbnjzwkbkVStDzzrxKinHr4NKrNJV5NFxon+1jpfZRWbG3n78H+4I13eSo+C
	 nRtO0nxSAoHvg8RLn6hN2tjZl1Buweumi3svomwpknMwgf/0jRdUI2Et/J49u94chxufD
	 yNMt1WSXvww+XuA4jinqw46ZMeWmYaZNuW+mGgsqMWYzne7fb0SqFnGbbfOnD7UjD8A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oavwDbJ0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.47
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A6F606A32E
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 16:58:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85A6F606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oavwDbJ0
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-4adf4431ca0so915467fac.2
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 08:58:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794416301; cv=none;
        d=google.com; s=arc-20260327;
        b=fN0rqNd5XQIyQ3SvV8haCDx96SW72i7bdxBDnD3GnpPf0nJHdqSS4T1DwE4iuED2pf
         WKYrlV9GdY1hWVh5PShNUIKC4fjPsBWGjsJtWULXcJ+OoJeMUOQ+ZQqbSj/Fw2/H1Pld
         ZZkYo8oiogFVcmAc0j6VEwwcY96WbzeWLwT0Uvg8gNJ1Ao88O0IL3iuCWCfXja5kuamh
         ayH1AttRwsvcfxWi3AaqO7GTLXih3+KEiNp+1GkijthwjQOK4KLkjyc83WHvDFOi1G6Y
         sDFIIj2yGAUGZryVAWk0Rql+0U/dL7348yExpG9UKtsotCqCfudnNl1qYIguHRTmA+CF
         DJlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=15hIaeM6HY+XXzI68kpVg2E+Jve2er7s8+5re1NHej0=;
        fh=I7HAWFdblpiBblF4kMAwvzW1q08k4F9IvWmdtUO0RZg=;
        b=VDMxnf+UrQ66wEnw7LFvJDlDAsJCQYjDACxs65QVpbNT2kDxjfNKIcRGS3SQNj+X11
         +alEvEamZ7wJCcFHqeBxKSpvP+NPFbuEACR/ojtPFB8rz8e8sD55JaeHhR2XvOmo9RAK
         FUvAE46Bz07dsZmcq+k56JkfLMxSVTXS+NAPl8lgwcNl4O/c9Yc49SKHzQeW8KYieJK6
         7iqw/qTyKAQgOuFyjTo2wWx/cZxsanjdmg/JGbioBasC8/YmDcUNkUv9ldVvmHCj7RFy
         9SDhJj5o4C4YUV2p9Vbu+ewkFVCkv48FZE8ATdW/PE58O7aq6kdvXoIm2J1ybgEuEZOV
         cH+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794416301; x=1795021101; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=15hIaeM6HY+XXzI68kpVg2E+Jve2er7s8+5re1NHej0=;
        b=oavwDbJ08/HmX6wVgtCUXPpgOGRzoNrnr23jS47qt+4qWoVD5xLkFh+nGRYw9Kxd8n
         Ryd3a0NTZL6MowswMVIsfIS9LHmX1n4wDGBpAvUKH1nSnkBc3Kvj/BqP6Heie1ITe3zs
         Uf7qOmb0oQyeO1DbC6nxT7UTgGFMTSPzLxjUmc9ftR3jJrj3a5EOR0DzhqxrtTKfS8ey
         gSpSMqF4G9dHcuayBA2ODgVLG491ephmMmEUJlvTdno6bDjP/a/NTU5/GJmuWP2yjuHe
         rlRgs8jcEdX+cyFPspyYAT++yKv0t+fPvStyRlsi10SJqQlG69cbucrWBJpHy48AphJO
         KZXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794416301; x=1795021101;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=15hIaeM6HY+XXzI68kpVg2E+Jve2er7s8+5re1NHej0=;
        b=g8XChz+LOoL2i6AdkSQb6iEyQQy2WK9fFQnnmtC8gz0Jcddd+qq1/Iyz8rFnsTLSml
         6yFH5pIldlpf25+AOFHOWWe+N2DdJGqFEsaTnHn4X2n6dBRKxBG0wLFjibqYjUIQ3/Ff
         DhwqJrxY8Nnc0C+10Bbb/HktTrooTdd9f1s0LypmbMX0cuCFqCnd+0c4+c4Z42MsMxRi
         hkRXNxxVfBTkivMSfwZi+35zEca2jpjxmX/uW0I2EDxzZyAsd6AcLWiIwxq4cqpNAPeh
         Eebimxj9NcSyM1v+zkVOf1L7dt/nfoCkejK94PDX6aDivrebRE3D/c8y2iM3hco5O/0l
         rG/w==
X-Forwarded-Encrypted: i=1; AL+hErH77DDIeGrKNd12MuKFPOkp9D/iyBm2k44Z/+7eVZ+km/Ro9TRG8VvWL/hEk8f9ox04ViUt41Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z+5cnJ4mpqpUz9aPIQGCQSXLgksn4F8D0nyx4PYujGhknNmFpwE
	NWqmt0oMKqVVLOsomnZvCjazgHqnIQpi+VWPO6WQ7GIFOkRW1AQo4E/KDpmcV1MkAn0Z9Nauuy7
	yaVYGFSPwbsnxxXd0Vv7NeccQB4lyNhY=
X-Gm-Gg: AYBFou1gQBB5cnDLv6m5umLpuMFG8JiSh1/JTN9w/m6XZHx4McULrOwuvYeA6aPWNYJ
	0EKDeYqz8BLXurU5cSFdqWswyhdDZjSG7c6snSkOVLZwK9j4SQLM+ZKctXp+eqKeFT7S8J9oTZw
	5k8F70VsbCCoxJvhEPG3htqGk4KQXvXvI1R9R1Ieiuuqr+2PG5260ZIQuQBa+N+cw585V1SLrDn
	FnBxHUIwsJEMElTTFwsUtAhnvLBYjRmQWgAuBW1kwD0lbroicNL7H9dTe5bgdn4l2KQc6pH9JH0
	sbY2Y460d/T6LpDR4rcD4QR1gQDsH4giZc38ZUXp5w/lP5l/E4msv7iNmIggCLunu3jQ7ZqhFeW
	QC32bDY70dCUSIkXytozp0HU5jv3La27xuZxogT+t+6EQ3bIfmzPvhKhrJkbzi/1mcdlWAg==
X-Received: by 2002:a05:6808:f13:b0:567:cac4:f1c3 with SMTP id
 5614622812f47-56b9628f6demr2322703b6e.23.1794416301286; Wed, 11 Nov 2026
 08:58:21 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105031442.4164960-1-kyle.switch@motor-comm.com> <20261105031442.4164960-6-kyle.switch@motor-comm.com>
In-Reply-To: <20261105031442.4164960-6-kyle.switch@motor-comm.com>
From: David Yang <mmyangfl@gmail.com>
Date: Thu, 12 Nov 2026 00:57:42 +0800
X-Gm-Features: AclHuK97k3WBHp2-m_5BzCVwlCnsf-cLUmeErgxp3jexwYJIXBcu7tFJPz8zkOo
Message-ID: <CAAXyoMM+HYhnZ_pV1wvjP3zEBbjNrWT6ry5bKQABiLqmHNn_iw@mail.gmail.com>
Subject: Re: [PATCH net-next v17 5/5] net: dsa: motorcomm: Add support for
 Motorcomm YT922x
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
> @@ -2608,15 +3104,13 @@ static int yt92xx_register_switch(struct dsa_swit=
ch *ds)
>         mutex_lock(&priv->reg_lock);
>         res =3D yt921x_reg_read(priv, YT921X_CHIP_ID, &chipid);
>         mutex_unlock(&priv->reg_lock);
> -       if (res) {
> -               dev_err(dev, "Unexpected chipid 0x%x\n", chipid);
> +       if (res)
>                 return res;
> -       }
>
>         major =3D FIELD_GET(YT921X_CHIP_ID_MAJOR, chipid);
>         series =3D yt92xx_series_lookup(major);
>         if (!series) {
> -               dev_err(dev, "Undefined series info for the corresponding=
 major\n");
> +               dev_err(dev, "Chip ID: 0x%x, and Unknown major.\n", chipi=
d);
>                 return -ENODEV;
>         }
>         priv->series =3D series;

You are fixing your own code in the same series. Is there any
particular reason for this?
