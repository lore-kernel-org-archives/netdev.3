Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BA538B7B4
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 01:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783560279; cv=none; b=IwOdQrMDfYXLF+tyyCTefKyRJioAc6uUYWYXjB2UPavcrwFes5MYfI5rzpI+y8aaDww/P4URbdMAPef0rU6V28OxnMeEHO8gGQrD5pCszLEn1TXTmQHJ2oVGxoy6XJwcgvQEmzv9xYINTKcVAA5lOObINU5L0ltlUiqfWy7cK20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783560279; c=relaxed/simple;
	bh=l7eHw/raYhzCKyoQvZO5b5gtYbr1anwl7xluE4HEstQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=d3k5eLCuHTrzv+zx0uW7XBn0Q22CInEkL0FdQqwx/+G1YCQLG8YlRS7Yu7Mbq+rUkIqAgbU3vsQQQh8n/XSphyzqHYc7gcq2nQ8PmnNWkGb0SRwva8C9p5+rirs7ezRbvB62A7XaJjH/tY1tj3X9CbQUBs1pLsZohbrfHzhs2iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QggIFKPx; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QggIFKPx"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7dbcb505578so16030107b3.3
        for <netdev@vger.kernel.org>; Wed, 08 Jul 2026 18:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783560277; x=1784165077; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=l7eHw/raYhzCKyoQvZO5b5gtYbr1anwl7xluE4HEstQ=;
        b=QggIFKPxJXqU+hgCDM8CbHi6qty1kxvO+hDKATtwDl0ALTj0vuyF3wyaS2piKuxSz3
         KpkBHSIPtmpA8MGK7+G/wu+KjXcey9BeSNJ+zixcDTNeoK9CKNFZFCCtkw010krVemtP
         ZzLjyUeqBTbOIQPQlmE7e8/rxp54IPeEi1dFJro9oyoARm2QoMAezUrNeacurygnd0nw
         KDP21kf/GEW+w0WCS+XDi8mwqAGNNAbTIqNzGhMEC8lr53bFwwaLGWYGCAHfaZx6SBng
         O25F6CjKlI+y/V5Deic0wMCn1/l7AvaROyw5aCa9uXZTPLRk/ZH/TE4c/Wauz35vRcHQ
         j7jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783560277; x=1784165077;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l7eHw/raYhzCKyoQvZO5b5gtYbr1anwl7xluE4HEstQ=;
        b=QGa2tBnHs4Wle/IqRuiRE4SoPIbdIheP3QLQ9dE6ESAslWCNuUQ+DnplMc7JyCYNcZ
         acEobfgLvAprixeftbBGajFasmYMFj/1uHen0rss1DXOU6j8y41KHB738dncvyELgx3z
         8gSZ4BMKujJA4x0lISQ1dzq8F5zCt1eFPunQbNBMVrP52BN0Ik64ifS5a+uLGLU0kSQZ
         FBxq7MMJmE+u/+V6N81+lrnYlT/ECROkTePYl8hHfFGZ+SsZrhWFoBxtjczE9CYUy7Px
         /bnTJoDkLvQxo5hUdoEEyN3ID1ZZmj3VnLvfsQIZiSf3aaV0VuyK0FSJpuSCgHpNkK2B
         mqzQ==
X-Forwarded-Encrypted: i=1; AHgh+RrTH+9Y/JEilastQ6F1aNV/0dGzRUteqjxBD1y3T3+rWo+DWYwClB7CsomogLPO/IZ7THwJ19c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRknKsMagRSP35LriEQ9UroStQPbdL6iQZIIIiBrQ+F7u/lDnX
	ZhgnvX+khn+dJdtGVIB7SLW3Wxe7+ixZ5UiSJE9VIIzIL4oogByOZQWL
X-Gm-Gg: AfdE7cmsBN5z7JBF4aG0m6OOCCUrr2ogkHlvZPKbdnvHpkcIXl9PKVtaGXo8YdaEvFI
	6eZZPL5jXqg4R7B12NjaAyIdU2VoxYVwv3/Eiw6s1c6i3liFQpwUWDI4RiXsQ/wnD1jrAgKUZPx
	Pr8QOP69ejbQGHAbJAN540N12jBu9ChAqbAm8oKiZyPXoZIYXwI5PdDM3Q/Znknji+R79bkz+iC
	3u+sueLd1nB9cg1ix/LjuIJ8fAM04lS4ds1IJUVSycd/KYhRjvXSec7R7cYNQMPaS8Q3MkmJXLF
	xbGhfmCxvc9246YIpzJ7Rc7l411wbMBgnqN3tAC9+54Wh6XpPpvNyL1ZKO0EvfgkSiNm8dxifxY
	tZHsENHA5RQl+AyhpatMf3mZi4er8AbhVT7z4C3mhOl1neCC6vHTdyM8RAMRnfSJi4JWCYO/zl7
	Qs32+O6fMMvIncHbLukxcYIYRRgwVtylMfypIQf5J0D++W0NZJoQ8asYgyxvCnyYb1Cw==
X-Received: by 2002:a05:690c:12:b0:81d:4f4b:94be with SMTP id 00721157ae682-81dbd41c1a7mr37863157b3.32.1783560276655;
        Wed, 08 Jul 2026 18:24:36 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81e6be99124sm6315537b3.4.2026.07.08.18.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 18:24:36 -0700 (PDT)
Date: Wed, 08 Jul 2026 21:24:35 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: =?UTF-8?B?U2hpbWluZyBDaGVuZyAo5oiQ6K+X5piOKQ==?= <Shiming.Cheng@mediatek.com>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 "dsahern@kernel.org" <dsahern@kernel.org>, 
 "imv4bel@gmail.com" <imv4bel@gmail.com>, 
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, 
 "alice@isovalent.com" <alice@isovalent.com>, 
 "daniel.zahka@gmail.com" <daniel.zahka@gmail.com>, 
 "eilaimemedsnaimel@gmail.com" <eilaimemedsnaimel@gmail.com>, 
 "nbd@nbd.name" <nbd@nbd.name>, 
 "horms@kernel.org" <horms@kernel.org>, 
 "kuba@kernel.org" <kuba@kernel.org>, 
 "pabeni@redhat.com" <pabeni@redhat.com>, 
 "edumazet@google.com" <edumazet@google.com>, 
 "willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>, 
 "willemb@google.com" <willemb@google.com>, 
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, 
 "davem@davemloft.net" <davem@davemloft.net>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 "sd@queasysnail.net" <sd@queasysnail.net>
Cc: "steffen.klassert@secunet.com" <steffen.klassert@secunet.com>, 
 "stable@vger.kernel.org" <stable@vger.kernel.org>, 
 =?UTF-8?B?TGVuYSBXYW5nICjnjovlqJwp?= <Lena.Wang@mediatek.com>
Message-ID: <willemdebruijn.kernel.31a5346f5d77e@gmail.com>
In-Reply-To: <2d71af40897d73dbd9e243ce5e25bbd3f99acc5d.camel@mediatek.com>
References: <20260707021425.483-1-shiming.cheng@mediatek.com>
 <willemdebruijn.kernel.39a3b0237ed2@gmail.com>
 <2d71af40897d73dbd9e243ce5e25bbd3f99acc5d.camel@mediatek.com>
Subject: Re: [PATCH v6] net: gro: fix double aggregation of flush-marked skbs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Shiming Cheng (=E6=88=90=E8=AF=97=E6=98=8E) wrote:
> On Tue, 2026-07-07 at 11:16 -0400, Willem de Bruijn wrote:
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> > =

> > =

> > Shiming Cheng wrote:
> > > The skb_gro_receive_list() function is missing a critical safety
> > > check
> > > that exists in the skb_gro_receive() implementation. Specifically,
> > > it
> > > does not validate NAPI_GRO_CB(skb)->flush before allowing packet
> > > aggregation, as of commit 0ab03f353d36 ("net-gro: Fix GRO flush
> > > when receiving a GSO packet.").
> > =

> > It does not check .. as of commit .. ?
> > =

> > No, skb_gro_receive checkos NAP_GRO_CB(skb)->flush as of that commit.=

> > =

> =

> Is this wording okay?
> =

> Commit 0ab03f353d36 ("net-gro: Fix GRO flush when receiving a GSO
> packet.") added a flush check to skb_gro_receive(), but
> skb_gro_receive_list() lacks the same validation.
> =

> As a result, packets marked with NAPI_GRO_CB(skb)->flush may still be
> re-aggregated.

That sounds good to me, thanks. =

