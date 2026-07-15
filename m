Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A30B3B14D1
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 18:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784138908; cv=pass; b=VgQILvuJdIN8y+XWnIjf9uprIo3UvHjaxDExlC1rJfS8VfDj5G9s+5Cw973soHH6ZNYGIMjkV2sR7Q8g01clkOohoe/5hkoj+p5k3T1OIAT64VUGil0NOqSb/iTl8XJUASKskO+TodjQoyMEyj2haE1JsW+nv2tjOKI4tjsqONg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784138908; c=relaxed/simple;
	bh=gmWkK5GBY2LMEWE6ufMsEeT5/UFyj/875yClB5NG2hM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l/MlP/Rq6eXdjeZnAPBTUnz6V4tzE/sKD1XU06U3XEjxn/nrasWoLc6wevcxHdw+mSEoQpYbcNkizT17EZzkBRFrIOM3R9fi28dkLG1mzZhJWy7V13EeAtfgEHXX6DrVpJDMpRlJ2StKKhDzofin5+MjKO/LoXmmYbd91SVEKTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=E6xfUung; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="E6xfUung"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cc7e86e7aeso25446875ad.2
        for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 11:08:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784138904; cv=none;
        d=google.com; s=arc-20260327;
        b=izOQZgS/doY04PbBe1IIDALmA26xRROCW4FSkXOfS+mTAMDVIRqOudxavGvdft5ud2
         rwNbefNxLotwjmfwUL0kkgZWJvNVRDBvFH9BIETTl4tXV7BKppxnPPa+9Y38sBdepmCg
         vycL3NhMlxP8otyvq/DJ87/Wftm61la42UYT2DJSOPzJRCAJFKdkJZvSYxOIFL7OL+Wa
         tYbaNjYFSmtmtakqjVbdnxfKClBU9ByTr2WUNw+YWiqVZJ9Q9Qt8CgTxZDaPFXuaj+Ax
         yf6trqd3eE79HROdWVAQP+qaShgXAPfBB5Fo6fQ7CmGudp19uWstCQmXNDAvVJvgBsVX
         fxAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bTExRgnSTH/zGIn3ftYaOW1KZnYtj39qMY/sUCg+ou8=;
        fh=iVfQvShXx4Yl9AKxOw2GLH/AnesA30sYp4RjCLdbTNs=;
        b=IUQNi0MZnHkiOswEd0w/BtY5seF7DorsysSGkwBWoP2RpZfqVKnZTuu/LHTooh6lEw
         2k87bQuBNu6r2VS12C2LhAWzDrvG4nX6gnYqAVb9x8fdl23aB+sJLQ/8NZtri+PZyJAX
         Qr2xaYNpKBRdBN0ocrFZWDAgQ1vjwoMX40C3prHJ3u3b/X51teIZnGrgC9JR85mMmxDd
         npCPWHuT+6y+bdvWUvKD6sJCEH74OncAU4jX7GqSg9jTZftERe49sbVsb/YzdDRX9yCP
         z1NyEzIz0/LH0+8qoeqJNpbMfJpjqQ3Nq4I7tg6nFifxjWT12DVgLqfrNaQ7fpfCKIsW
         14Ug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1784138904; x=1784743704; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bTExRgnSTH/zGIn3ftYaOW1KZnYtj39qMY/sUCg+ou8=;
        b=E6xfUungElGUkhJ+Hik4RR1k5vKtgjx7vK3uMtZyvWxMlqW3FeMXMWmQgiCNk1PQCg
         qrF56pnQzfjp+kwK7Nn87hD7uSceDB3eqQDgnoO3tPoDFZ48kWtWgeXf82aaVjVXCypH
         faKSYBW7iMpeJIhTW7SbMttzBlkU6SGdYiRGVhaZ3O34CCwXTHdsPVFB4+pB/y9FsrsT
         Kt/+OxupuvAn1tZEL3CIzB6WdvxwXkfQD+eSnFNvshHSkY+oGhNwBiTGclSZ68IuHkxQ
         0rLvq3WOPF20ivlVNoVoB/QXwL2Mwe4RGEEJG/MATXbqBkbYrqpaWI88Tnmp3S6ejNCx
         R0Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784138904; x=1784743704;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bTExRgnSTH/zGIn3ftYaOW1KZnYtj39qMY/sUCg+ou8=;
        b=j9BOFwcEvTWYuqAsQReqInnrRgnfur3c9ze7pz1lJwAfCePcAFGxJ7rR3lt8k+4nrS
         iTnEwIyO7ZAH7bHbzPXb1jGKkIwSDiX7Zq+Obgp0/L8FDDXRdZiWv3GeF58iTCVytmrY
         ShNjiNqfU4ml6ChDJNXe43W3KXNDImDnkHMlY4VHGL/zIvJq+CkF+zgyu+yK3GfsTYCL
         z/jxtg5tcn3/xmQJcP6xPtj0J59VMg2dWz/W8eFdPsE5K9j3yWj+04bIzhSZRIe/nfJs
         c0kQUZkFlosID4qt7ArgfoWJdvIps/kjkR49SHiQuTXAsydDGRjGFnz6cG2gK6JPA2FW
         pG2w==
X-Forwarded-Encrypted: i=1; AHgh+Rq0aSnUAGFnRoMWgzbBLImwL5UP1I1qHmok81ngwEVMfp7efCzHSieM33TJ7sUVYkC70KErcTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUzkAqabzQBuBI3o/dtyIchM78KLpfyZJcvSCD0XSkr0e6igZM
	MgDNUQtZsv0HwLHMDqvzXYBb4wh+ACJoCxZQEbUeUfAjvaDdzrPsuLYqtUwbGPEuKHm5T9lPM9a
	Am5g5vdDcEoMbnHIjr8FZZ5a0TsWbEXsSFntXDfsb
X-Gm-Gg: AfdE7cnqI+e+CkQwdKEMXM3QrEOaBISnOJDx5rMc+/OlJyGNws+AGiHA+s6rOAn1wpJ
	DCAVwop//HDaXD05bskjjNu7ORyLaA9vdc/4w3VcGGa/Aea7CUD+AWzu8rKdzlvYLarBkz/6tMN
	yn/QZek+/3czx/h+JYyvCmgoEi0iY0dvDJeCVlB0a+9ifCrAUEYLJ4LUdQtYam+vL9gq0nx49z3
	Kv+jgrwyHv5ihdBoZiXmxDETWgapqRCzhQqUP51nEGV7I4IATsAIgm8w9zw37qB1xe2El3PgckA
	3QI3NxQlf87YO4ndjIomVqCJqpHy
X-Received: by 2002:a17:902:ecce:b0:2c9:c083:cd50 with SMTP id
 d9443c01a7336-2ce9e9ac9acmr170981245ad.17.1784138904382; Wed, 15 Jul 2026
 11:08:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260704210333.668216-1-xmei5@asu.edu> <alddIi8ArJ13ytSC@secunet.com>
In-Reply-To: <alddIi8ArJ13ytSC@secunet.com>
From: Xiang Mei <xmei5@asu.edu>
Date: Wed, 15 Jul 2026 11:08:13 -0700
X-Gm-Features: AUfX_mzFjlKmKNXWUkRNr2pzRBXPzS3cMIwj9lKmxyFNCb-B-xpM5GlG5AEUE1c
Message-ID: <CAPpSM+TxGBMPoP==W0vv8e2Hx30ceF28Pv3Y5cgSAGTBJmLU6g@mail.gmail.com>
Subject: Re: [PATCH ipsec] xfrm6: fix out-of-bounds write in
 xfrm6_input_addr() when secpath is full
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: herbert@gondor.apana.org.au, davem@davemloft.net, nakam@linux-ipv6.org, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2026 at 3:13=E2=80=AFAM Steffen Klassert
<steffen.klassert@secunet.com> wrote:
>
> On Sat, Jul 04, 2026 at 02:03:32PM -0700, Xiang Mei wrote:
> > The depth check in xfrm6_input_addr() is off by one:
> >
> >   if (1 + sp->len =3D=3D XFRM_MAX_DEPTH)
> >           goto drop;
> >   ...
> >   sp->xvec[sp->len++] =3D x;
> >
> > xfrm_input() can leave sp->len =3D=3D XFRM_MAX_DEPTH, and the transport=
-mode
> > receive path re-enters IPv6 input via xfrm_trans_reinject() with that
> > secpath preserved. If the inner packet carries a destination-options HA=
O
> > option or a type-2 routing header, xfrm6_input_addr() is called with
> > sp->len =3D=3D XFRM_MAX_DEPTH; the check (1 + 6 =3D=3D 6) is false, so
> > sp->xvec[sp->len++] writes one slot past the 6-element xvec[]. The writ=
e
> > stays within the sec_path allocation (invisible to KASAN); UBSAN_BOUNDS
> > flags it and panics under panic_on_warn.
> >
> > Use "sp->len >=3D XFRM_MAX_DEPTH", matching xfrm_input(). This also
> > restores one chain level the old check rejected at sp->len =3D=3D 5.
> >
> >   UBSAN: array-index-out-of-bounds in net/ipv6/xfrm6_input.c:309:10
> >   index 6 is out of range for type 'xfrm_state *[6]'
> >
> > Fixes: 9473e1f631de ("[XFRM] MIPv6: Fix to input RO state correctly.")
> > Reported-by: Weiming Shi <bestswngs@gmail.com>
> > Assisted-by: Claude:claude-opus-4-8
> > Signed-off-by: Xiang Mei <xmei5@asu.edu>
>
> Applied, thanks a lot!

Thank you!
