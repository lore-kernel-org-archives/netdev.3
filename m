Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD8A3603F6
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 18:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791655202; cv=pass; b=g0jpu1FgYr7dg0rgkkt1E2AOdUOrO7i71ZSQDQZaRbxritsCG7TEZnYDQd/I55HLEeDqDTM8Pu8NSGTv4M84WZKvYGpIY0Ys6xqCi9+i551XhK+AVRF56wE6BExpoGA9r55LnoqwhJlwRHCU/RlC5x0WsthgcLiEps7zGPeCQic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791655202; c=relaxed/simple;
	bh=RRaKBHfesnMj/MQ56/1YpZoTCrxeT4WyUztjdaRJ/BY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LnwEKRYgRRfSJZg41982P7u3oMCezLrpex6K9PraauyFFzJoBq1OE+xmab2N0BfxdU4DT1x/j6clGt/unseiYj0+j8HNk2VzwtPdxRbVSwuzKDSmUiN+TxftJSiyjagKU2g52UFsXbNgBC5KYFuICfxUGqlzKIHESXmvMPzWRl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OOoz/Xg+; arc=pass smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOoz/Xg+"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-833e671ee9fso367757a34.0
        for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 11:00:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791655199; cv=none;
        d=google.com; s=arc-20260327;
        b=SNrAZjsOtck9wENTiL6nhq5O4ParHV23Yr/XubmyECOvL6bjzk2Q85jn06Hz60xPDf
         OCuUBZ9o5ofxC0rL1t8g2En1/ROGsLyWL4h4YLOR0tWK80OJVMkDja/YIpqp5LdMJU/u
         9f0MM+0OltuGI0x7hxxzgAUvplpSXqXhuDKWDIV9k5W8SVr8ssvkVms5Vl/78th5GJj1
         QIKtC8LFax2D2FPRCzVvsxQLZ8Z7u7gYEycgQWBdqznGvNhFw+OxtWNkncHaN7FMHBzh
         69Zf9/cyBAtSxCBb8yIJBzP7o1bOygowAghv8IA7HzZSY87S8d2oHnzxfqmo5mLs7mCd
         pltg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U8Kusf1hH/TH2DSJRRPTz+9MUvUE8UuukGJs1Nu4sUY=;
        fh=yY1zpqLqNn55J4w6Oht7yqBMKbVkF6Fd3hYF+7qfxPo=;
        b=hL3iHuJ4/OgqL7xgbNZjTcXb0GJuvGK3d7Pqu3NgMDB6hG2c7Np3NOzxDllhuuewtR
         Y1gyUkqlmAlsu0HJ24l1TgVHazOWE3MtVO39GNPSn1ka8Y8Kezg7wmnyxtVdHImlS6ID
         /ZNXrPYbm194Kc/H6zTV45/SKtEtijusKL9CpGA+lHa9NuzDdyPdwV8NE8SwsxltdtqA
         1AoPSgj0OPYsWcHt1d20fm8W4MT8/vpikgYmKWzhekwZUJWisbBSDkezxwX3jfrcGyi2
         qkc8k2Zb9xiWNE2y5Yme1tPx6VrgSiVa58nRQXifgc0ZNNplTn7DvJtruzS7EGkpBWIC
         hqsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791655199; x=1792259999; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U8Kusf1hH/TH2DSJRRPTz+9MUvUE8UuukGJs1Nu4sUY=;
        b=OOoz/Xg+V32Qj9en3Gmc9HwFDs1v270dJtyHowCL/ZeufT9GnuLpFPWVx70F5UJ79s
         Jsms1PgrqRikZLN/41qbvBIzauVoXuk+UG9jAf7vqNW0DGEieKCzM+P3+MT7NPmPBQjw
         KCajBxI8Jk6bjFURdARnSRQ+nw3N3i9NgL4P8uNqzCWzyLM+lDuwKOO6Y1bj3npZv94u
         owRUxmAJpW0XID7zIDR1jfcJvTO56D0Abwlyc71DacVFal4fJh9tWhrfTvzBJYHx2S0s
         woJAydVepydVH/zCfAj7NeediIhspVPG/D2UPLSyX/5HxbpM1FHX7fzzEjjZQuiht8H/
         AXeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791655199; x=1792259999;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U8Kusf1hH/TH2DSJRRPTz+9MUvUE8UuukGJs1Nu4sUY=;
        b=yLCab75Y+Zap7JhXZkrwiUUp0R5iAsKLo66993akx8I9efXx0wtUjLAtpjNocozdad
         4viifA/BqzBAfpbDk26fnrjsm6kxY4lNU/8gkge8kasSOIM1RjjIEnYkxmB8JWS0OmMz
         JOMr178qr73tO5zRt45sKuenIM+RbVfr0Y8P68Mm6zZaart8ujhC+g3a9G3oe0UkFF89
         N6dKR0A5qKuv95jhlcWMY8IWakzOnrMLOWQZxynXWuo/Hd4ioMEmwWmK9TN6LhFNbTfs
         tHMa7B6z+G6YpIOGf5Y202QYMqq9q7IKsmdrj8lRqxoLMQ4A4CjGC8fg0zgmEpzyBPiY
         lZgg==
X-Gm-Message-State: AFq9FYKQ+hWCIIhGKSnvZB664l9CDb0SlB8REtgWeekdCmZFuaS81Cqn
	JtDVJnBcY1/3nz4Vz9NPa+kxpP8Z8H9T/8kRWzvY3WjcHoT5SqZf3JJGjqsmqjNCbBCEPmHggiW
	TTk4aT6pdtFhg+35Fkfx7oQg8mmKf2Lw=
X-Gm-Gg: AYBFou2bm0lNRhuYxBnDKWAMS6imu+PzX2/XlyIUbKJ9I3/cxQGHr6Bcdh3QV5iUNl3
	aZIgHuIb9iWump11yssaKRNYghmLaEeo63Y5TS3Ix2b2ADQbiap8+AWVsPnVRvJzUNX8s+hYTt0
	EINMlOuWdSWtf7PQBiXz+FhhjVtO5QPiumnXnXNVwjhLnW7yDN4Ux2j0mW8SE271giRIB7i44Yr
	TGHucqrsHRYDjkSYc3+nlvIa37eBn+bbSVFj8p0nj3rWc7BfMJip2DSHl4/qUXPn3bFZbQXmynC
	Fez2T/CR2TIPFBMv8U87iklVirxsXQOr5FGIK5sxA6Q980eMElIyDaCIcyRraw8dvJ2eJJuE8wu
	ijVSbnlUdUNuv8R8IHYopdeNGHP2Cwsm2J+j3rjfbm8gH
X-Received: by 2002:a05:6808:30a1:b0:4b3:7da2:f393 with SMTP id
 5614622812f47-50c52471233mr6704569b6e.15.1791655199462; Sat, 10 Oct 2026
 10:59:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009165825.359259-5-mmyangfl@gmail.com> <179165246658.434549.13789649791572206324@kernel.org>
In-Reply-To: <179165246658.434549.13789649791572206324@kernel.org>
From: David Yang <mmyangfl@gmail.com>
Date: Sun, 11 Oct 2026 01:59:23 +0800
X-Gm-Features: AclHuK83CIhkKI0SXuptnmlX9MwXNcY8gSNZtizFBXcwCcTNrzVJ_Ce_8IafsTU
Message-ID: <CAAXyoMPnoTvCiYanrYCrfY=u19+-7PQkQt-SbahuiV9RRwijMQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 4/4] net: dsa: motorcomm: Add TC prio support
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 11, 2026 at 1:14=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wro=
te:
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
> - [Medium] net: dsa: motorcomm: strict TC priority modulo check breaks
>   auto-allocation

Already explained in the comment. Also we already reject some rules
with -EOPNOTSUPP, if returning -EOPNOTSUPP when skip_sw is not set is
a problem, that should be fixed by another series.
