Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453FD13D8B1
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 12:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784723477; cv=pass; b=KSjmH5FUEoLaQpDI1Gt7xmW0DxDtuCpbZPSdwO4HChz8MXTBZJfqnPmPTYD13yBDXt98xN6z9dVeP8bNxx17u5NVDravVU7Lnjg4V0Nh5zI3PKmPFZGRILV+12gYh/ZY7cdtXXNEWU/IPuiGULMdUmVF3K8qu/QUel4XqZ2PSsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784723477; c=relaxed/simple;
	bh=qpndS44Z7Gf5WR6rJ+1AO7EPE9gBubrkn3zK/WXE13c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ntC23XRnwAXKGxnCbuSf7J9bsSo9nAArKmMHeegAv7nZBWPEi6D5zXhItULGVg+h5lykISsQ4ihhhJS9m03MufhrnLT6L3GsAgEUU+70IzqvS3QZjjKFAR24KrwVIUK7ISZdfDUUlDKecXbg+T3f3KxoHzF9oQGZSYtKoyWclNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O403Zwp9; arc=pass smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O403Zwp9"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-92e5c9211d2so1117221185a.1
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 05:31:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784723475; cv=none;
        d=google.com; s=arc-20260327;
        b=UH7520ZwAMr/FoC8It1nwsxrrKn4IIn4Jy07Vy4sb3Xmc5RJaYMB7/CN9ELuXkp6oa
         3baoMJr6jkmFisUE77PtQbQlik0OguQGDfVxeYQ8e/MDQGYbq+ZbbDmDiJ1s5aJTbAIf
         j+7ya19wPs4m6NCtMjuOCJOWBx8Vg1fT1utyl06GHWepVx+cH/M1MAz13+DJq+5e4Hsu
         C+oI0pv0mHB5nUH7re/KAh9094tCyWCE1LE90EMAnExoNTBPBBYv59JcR71to6QxqZHi
         bq4wVEZc7CyiediQpDdzqG+SMmJTbN4IBEz5lEpgmvjDkZ14zz9PMcGi37tryaT415Va
         u1GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XoG5hK/dl4CNBf3V5DTbn4dS/rgXXrwb/uktghZnvAo=;
        fh=8qJylrniEkEBYtcOSgJ5YybrsjuoFktsv8PEXC7lh5g=;
        b=lc95qJRo3pItoq5ccdThPpg0w4mtfSNBQSIMCbUcgxTUs4ivWCXyMTs3YGiuhFNhjt
         arNb7jyKoOR6XfkuhN1VOB24RFT4NZ6P7501pEZ77jiZ3qRmOwbUlacYad8BzofNRNyZ
         X7j1ifUtb0ebwFT5Y0Oqo9WXOeoDWAhFJFyEcg/gTZHoGutg+8RZDcXWjU3A5/w43Tca
         tcES5J75UCRoabH8AX/isVGbq6x95Wpva0F8OpJiG8Dwq9F29SyMiv3dWJ526oZygu8q
         bUbSoVsRpwYXrm+HSiVzVPbhgcta0IPhNsu6DJujieFwdJltSDp9uB9jsooJPbyqvJpD
         Hm8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784723475; x=1785328275; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XoG5hK/dl4CNBf3V5DTbn4dS/rgXXrwb/uktghZnvAo=;
        b=O403Zwp9g5g1GqKKl3XhyLevBFjWk6uqSo9FsO909hOG5tTO28wQF/apkoIOb1yNY4
         Fmz8+SckkFO0DAWWnhQuge0mQZV/SBeGdt+qtUyNB49aCd7d3WN1nwxV/WswZ/ncFNB7
         5ee5tCSDoXkI+8bnwewhm7nTBAmB79BgeWWyb6Heomr3Gsx/cGbU29UyU2AqWHYPBJMa
         YjJ9iXNKeiuKmIomzwABLox3Ar77DANR36gh4nLo3ErxpaJPOLU2FXCvxgsfA35+wYCw
         T5biHf/AVoEuWN+FiXoDNx/RJcpnfkupZqd/VxLfZ+gcaM1Mu+vbIYg85mktqZpPUOFk
         Sfbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784723475; x=1785328275;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XoG5hK/dl4CNBf3V5DTbn4dS/rgXXrwb/uktghZnvAo=;
        b=EKbYWdmUPYnXdm3GLyuchHHfboKKqv7gpcTRNbUt+wyaZKGHOc+NujlO0HhtPq88W0
         EX1qryX/I8anizxkbNBM2rxUS2G3ePaEcCREw3I4IJP1FnnOX/KECBbXMapu3jTTdi7f
         oQlu68A7LabgzTb9L16jZk3FJKkUmGAhR+kT3UzmYXve6s0mDBlToMqWwiQUJ1wdSwez
         qLgG2rG8gDmzO0v9g0TTp+Ab7ghPbFuBmuw7MJagbp+t9cHiWcl9knH62k6N4JK0v5K3
         12m7iNF7rR+u1hsZir/jxzicCF0N+oKrt0BNfyV1TuClAkXbV5L38FIe425qqjhjyBhd
         4Dkg==
X-Forwarded-Encrypted: i=1; AHgh+Rr2gFGO3YrlvOFUvXLt0Ihj/VaON2YBpL4Pmj+mDIESggAhB78kaZqcz6cIa0I8+/RSNuR/jug=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7tj9nygT5Xe/ZXu29KCygarxRo4Bg+OiWmH4FLbYs0ulo45JX
	6fBmwiTR6Xr0BLrezRrEdGCOiO2eBQm8E/NuywJ4sKmo7jJgJG8oPirf+DR2JVXsXh0Te1tS6Oc
	QJh9GX79Cxh5c6o0B878/RpgEJ0MINmsjwldGs940
X-Gm-Gg: AR+sD12A8mupAZRdWWBWijVFl1HWMXpLJtCBdomLuLPqVdz9p4uADf5NapSO7UxUGQe
	ub+hHx8DoXYfdXvrls4gKNOC+brL1Pg85PS6TyJ09AxJ+otaPHCpyxGmWoiapGClZR2CL25qGcD
	dRgP9rs2GGmLxM6djQH2XurSnkTn7CCaOPp+31UUrYpwJ70wPm+2u/GOr97B916y+wae5F/vJMK
	/SlWMY7THFOEqr1zrosMcB6d0BY8hs2Xk2+SICTfphTJbbsNQIvMyvwU2WlCSM2Dkrpmbd3YH64
	2VBPFZmZvUcJ33Ie6gO6gDyp9xG/NgYE0eZ495oSE/2rl83aAI9mB5np4+W9/6Xkl3ocnBJX
X-Received: by 2002:a05:620a:1a23:b0:926:e8e6:3c34 with SMTP id
 af79cd13be357-930b3f34726mr2371527085a.21.1784723474278; Wed, 22 Jul 2026
 05:31:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722093814.3017176-1-manizada@pm.me> <2c8655e9-208a-440e-bbeb-d72019e0131e@linux.dev>
In-Reply-To: <2c8655e9-208a-440e-bbeb-d72019e0131e@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 22 Jul 2026 14:31:01 +0200
X-Gm-Features: AUfX_mzYvzkh2jbjL8h6sGaGzQRHuRpZcC97t4pcN2uRu9aGpjEa84lSQzUokmk
Message-ID: <CANn89iJ_ifdRt-+VFu+_P2VJw+F27DvSQs1unk9xbSNkXcy_=A@mail.gmail.com>
Subject: Re: [PATCH net] pppoe: reload header pointer after dev_hard_header()
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Asim Viladi Oglu Manizada <manizada@pm.me>, netdev@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 1:17=E2=80=AFPM Vadim Fedorenko
<vadim.fedorenko@linux.dev> wrote:
>
> On 22/07/2026 10:38, Asim Viladi Oglu Manizada wrote:
> > pppoe_sendmsg() saves a pointer to the PPPoE header before calling
> > dev_hard_header(). Device header callbacks are allowed to reallocate th=
e
> > skb head, invalidating pointers into it.
> >
> > This can happen when a send is blocked in copy_from_user() while the fi=
rst
> > non-Ethernet port is added to an empty team device. The team's delegate=
d
> > GRE header callback then expands the skb head. PPPoE subsequently write=
s
> > six bytes through the stale pointer into the freed head.
> >
> > Reload the PPPoE header through the skb's network-header offset after
> > device header creation. pskb_expand_head() updates that offset when it
> > relocates the head.
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Cc: stable@vger.kernel.org
> > Assisted-by: avom-custom-harness:gpt-5.5-qwen3.6-mod-mix
> > Signed-off-by: Asim Viladi Oglu Manizada <manizada@pm.me>
> > ---
> >   drivers/net/ppp/pppoe.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
> > index 4a018acb5..6874a1a8e 100644
> > --- a/drivers/net/ppp/pppoe.c
> > +++ b/drivers/net/ppp/pppoe.c
> > @@ -825,6 +825,7 @@ static int pppoe_sendmsg(struct socket *sock, struc=
t msghdr *m,
> >       dev_hard_header(skb, dev, ETH_P_PPP_SES,
> >                       po->pppoe_pa.remote, NULL, total_len);
> >
> > +     ph =3D pppoe_hdr(skb);
> >       memcpy(ph, &hdr, sizeof(struct pppoe_hdr));
> >
> >       ph->length =3D htons(total_len);
> Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

Reviewed-by: Eric Dumazet <edumazet@google.com>
