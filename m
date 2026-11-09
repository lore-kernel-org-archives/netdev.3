Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794259214;
	b=QTluEFYzI+7XWuj8dtYB/ZJdHBjAVEy2tfpV8MiRJHN/pjXNJZPGTcIi7NRHsli6INv+
	 sOBv9GptcxNl6oF34KcXk9nIKpPJzivfV4BvraPRbO+u0IdY9s35LctCmvtywmw+Z+vE/
	 w3yVt5MdJuQ50tNwlY4dFgIp7fJQ4S1KtFnwkgbi/4LCbQHQg233nbzHblCQND7tOPdkk
	 x6fMChBZYUV0Q+dFg62HRqTVrD3t49gaZeLCg8DwJ5wGVPd82BTsIilvz/cO8frhGLldE
	 ODEeHhwyWiYwRbvlrxPJsr7fpBiQ2ZT4fXXjdKCNVqZdd+hMs3bULJMy1GuxXA0mOIA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794259214;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=xIRUMFb7W2iDxt8DmgrBzYpVZ/AXxC5b6re+MsIq60k=;
	b=jlXmIylXyPPyFiZI7d3oWPgZt+aPEbcJBpNtMCncMnc4P/9XSbTZFApEdX0kaNJm7TKM
	 W3Q9tzlyxwRYtluE2Gjj2AJfTegrXCPIElWlYDdypoT77/QIsz2yosZkka0hgx0iRfxwH
	 EOm+6bJitpn04dizVPAN06Ei/OMbBfE7qAJTUG55P/iwKfmDFfphjw0rmoCy4qLhBoifq
	 ++ynnSOgQB3wou8UxvWQ3bzmc6tuMfGtLHqXM4Q4ka/u7N+mek98zG3wKKM6pehTkZUqw
	 Ezs485xh6/dBzz7CDpoLyose+2GMp5v7CVNKwfFoHgSzGR0YWq0mB/f3YJhusT0BN/A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t0YQJ0ag;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9771E606A321
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 21:20:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9771E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t0YQJ0ag
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c4c9abc1824so200854966b.1
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 13:20:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794259212; cv=none;
        d=google.com; s=arc-20260327;
        b=nF2hjl9lms2j4ikCP8SSTOrv8YE4XF1TXA1TaJO+HgYiYqWsUBlVHHdf2+DtWfMXhp
         BQfc0cBPmT3TqALpzBIFMsx7x1MPqheBEluUV3bT3v9GGkSsRzZUls6wjB3UGHe+ZV0h
         EoAIRb7ySwbVy5x/NUHTK6k4+2qby+AGXzOysCcTU0mLCJIskzBIeq86gp1yZFdKZUsa
         tF49oCUntG+2gaV8CkE2l08VvHMWnRB6n5ZhkUnEC+l2upMwvaGb4ZEjsCV8DmmyczB/
         7wV8rt3IvI0KC8blI5I8FknzazJa7sYVkURQPc2df8lrCjKt62knxPLLRaVsvFl8tMbw
         mAnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=xIRUMFb7W2iDxt8DmgrBzYpVZ/AXxC5b6re+MsIq60k=;
        fh=+IKDVH5yJFkPYJ8nvwzJusHTkcC1onFgqYRGdiJp5i4=;
        b=HGe37y0goSvTjHVJxXaulEHOk+f2XJgmC4sq/YYure5Vrzgik5jOXutKRNN/MaQKY5
         Pzl8iY8du68hcbjmW3NYVBkQIFks7KNXwU40mL7SIj6ujwFfKj7diQoUR6r1KLS9urfo
         0D5SxZdE08zuJaH+GXlZJw5KNljRTquZGXrT835F2FVUxiWyMEHx39PW01Xe/CXbWZl+
         GsHljNSRL1lPF4sWsuXqZDr9bjCp94jy9foZp6k5Evd4LZcCoMKEnw36N56oJJfqIjRC
         QcsAFh0Vt8jWi8K6Vz0cNiDTEnd7IaPNWvTE233n8sc8hoVvYYzs39XZwBNmnWvNXsAg
         PKxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794259212; x=1794864012; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xIRUMFb7W2iDxt8DmgrBzYpVZ/AXxC5b6re+MsIq60k=;
        b=t0YQJ0agbWnUbyo1uAvhtKtU2A703YAJUlA+iUfn2qc3b5YJkwfdgoy8+nYvimMg/q
         hiFEzOHOCpGRo9Tz9JJ+/HdlkcruA0m7Hs3iDVfvhREvRy9QVLI4jQHPzwKINABCNe9V
         pUYrsOoCgwNQIx02ghsJmdvS6xngZECtEsASzE4Knq8C5sRtIwReXQvkcQYIskGQsssu
         HcMe9wKZert8wtSmIt5FJ3iGwp0qqXkznTz1255vw5T03U6KLXvzUi9LV50u6W+pqZms
         t8ReFj36nvp76WYxRuAIQosTpNjvqa2jVKGmyO3OWC3Bem8iMyBv1ck/0NQIkmQu72cc
         OoAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794259212; x=1794864012;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xIRUMFb7W2iDxt8DmgrBzYpVZ/AXxC5b6re+MsIq60k=;
        b=Rx+5onKp7f66EZTH8/mZMVZhfsayVFxAuSKFma5Q/QafE4OyIcDnocFlFc0sEiZ3H+
         4feHhiFJ5zTl8DiTkBCNqDbmVTZA1ISIn/KeED4ytQBa3soj83RQhg4EdOiRTd4UEE3M
         VwF0nrK2yzDRyFw/CbiMEr9dxbYa7M5aVbDsEauWeTPjeOAMSVE2b/QXTztBsI7S8m3R
         iFECh96ul4hk8ybqTN4sQOurIk0AxYQ7YnLNirM0xdtwQ3ZZUs4V34sknqQ8/5udMmiP
         oVD7Yq1yQrPBSzmaFOFSRX3B0FVzSVF4UUyJ7tuzjzKQiBxPzgOFyaKyEdKbXiQ009E/
         FnTQ==
X-Forwarded-Encrypted: i=1; AL+hErHab1Dvq0ZrwDl1lG3HmZAPJDRC1lM7HZBts6/tvBEbb8KpQ0pvtyiEOkpJo2yUd8vF++J05dA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8XXbcHp8cKubQ0X2RLr3xmA18rfHYYQNqmu5rFHgJyqnTAScUT
	7uS6gUP8mKyoP0XL0qob4LyXXxDV11gUY454Y+8oNrsHFrLakLs9G+EQxm2GGbkrgktC0VYRK2v
	VvvjYEAwGZMRE1M611Y43TWhYOekt0Bs=
X-Gm-Gg: AYBFou1HjJ0Yfd+grl3X7doMqyn+gvRtX1OGfTP9ePmAh4SJIDRFH0797PauUWVBjrq
	Qi4KJcvdjkzS8XmmQONf2BWPJ33ATjsaNzGdfFmsJK/x1tZGGfCGLzdE4HoGo3nWjENiv6FZBVv
	EuECoYLOmOJHS10xCeeQ01KYaT+rF03Q8p+4njSRPksjtvzT0sezl8Oy2inPS1c5pEhwnP5RaNz
	LIIRQdu1GXe4jEnaRLP5CpL8hwYJTp4jis9mjnC9O9wJGBKB37eMWZNmy8Z7w5jcO7ORtLGkG1g
	u1hOs5Uhgrnyo9FR2E+l5sUpkHDpILE+genF6wcUb7gIJ3gRZwb74uUB8H+44LlCpcjFA8rC7Ih
	LXYOa2h0vkfgJlRZMlnUgNpiQd0EQEnIycDihNg==
X-Received: by 2002:a17:906:f5a4:b0:c34:e9fe:82ed with SMTP id
 a640c23a62f3a-c50496a40a9mr43078166b.28.1794259211749; Mon, 09 Nov 2026
 13:20:11 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <autLlP81HFeMyICc@analog.com> <20261106150124.3630781-1-stijncleynhens@gmail.com>
In-Reply-To: <20261106150124.3630781-1-stijncleynhens@gmail.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Mon, 9 Nov 2026 18:20:00 -0300
X-Gm-Features: AclHuK_ru7Vsb58s_yEKb9uIA5rl9_ZxNkKKy0_jnJiTtgUn0tS4mNE0wjCb1to
Message-ID: <CAJq09z4gGczRVzhrV_WwhRE_jpu8UCA+PKca6MuQR9AgmQBsbg@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net: dsa: realtek: rtl8365mb: use IVL in VLAN 0
To: Stijn Cleynhens <stijncleynhens@gmail.com>
Cc: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin.sipraga@analog.com>, 
	netdev@vger.kernel.org, Linus Walleij <linusw@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Mieczyslaw Nalewaj <namiltd@yahoo.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > Yes, all this makes sense. I actually remember doing basically the same
> > thing back when I was working on this, but it seems not to have survived
> > the final work by Luiz. It would be good to get his input on why.
>
> Luiz, do you remember a reason the IVL setup of VID 0 was dropped? I
> could not find one, and the switch only matches the driver's VID 0
> entries with it.

Yes, it was there:

        /* Add all ports to VLAN0. Not sure if needed. But at least for
         * learning, we need to set the ivl_en bit to 1 so that the switch
         * learns with {VID, MAC, EFID} rather than {FID, MAC, EFID}.
         */
        // TODO find right place for this
        {
                struct rtl8365mb_vlan4k vlan4k = { 0 };
                ret = rtl8365mb_vlan_get_vlan4k(priv, 0, &vlan4k);
                if (ret)
                        return ret;
                vlan4k.member |= RTL8365MB_PORTMASK;
                vlan4k.ivl_en = true;
                ret = rtl8365mb_vlan_set_vlan4k(priv, &vlan4k);
                if (ret)
                        return ret;
        }

I missed that one. I might have focused too much on filtered VLAN and
missed the vlan unaware bridges.

On any vlan4k write, IVL is always enabled. It is just vlan ID 0 was
never written by the driver. We would just need to write it once.

Another way (untested) to get the same result would be to call
rtl8365mb_vlan_4k_port_del() on any port for VID=0 during setup.

Reviewed-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>

Best regards,

Luiz


> > So I'm not sure I like this function being added to the vlan.c
> > library. Semantically it makes more sense to me for the main.c driver to
> > actually call rtl8365mb_vlan4k_port_add() for each port, so as to
> > explicitly say: "all ports are, one way or another, members of this
> > neutral VLAN". Then you would get IVL automatically.
>
> I kept it out of rtl8365mb_vlan_4k_port_add() on purpose: making every
> port a member of VID 0 also sets the member mask, which the ingress
> filter of a VLAN-aware port then checks. I only wanted to change the
> learning mode, not which frames a filtering port accepts.
