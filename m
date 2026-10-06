Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8272522A4E1
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 01:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791248954; cv=pass; b=Q4+jkcI4Z2RK9tTR2tUuy4hzBg7c716cF0yGNGVcFE3q0rx8K2RnfIih9Vt/oiIM0Mu8jsYrJRnGW/n2XXehrf6w3+p2ymMpYFQYOwodq3NEr4WLTBr5HalllifKoIPRCtQThBJuH2DiJ2r8CMlv4tk1h4+rzrgKt71Fqw1PNO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791248954; c=relaxed/simple;
	bh=FQPZMOJ4kPISPNG5soX6XJknF05kL4vWkbTpQ6PZ6YE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qp3tpysTtXTEelrAUPQeyRzsnkrLW8xviLYdupZKppA2QTNjQm96auS3vG04VHchHZU2dn0F1OF19ZmrubRsPF78LlT/fewCey8e4uEKGZE+T3RWv76U+wtdlRNk04ED3ETroFJk2uMV+068c8RnCXQh+LbYZrwttqN2g3F52fE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gD1zBwY6; arc=pass smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gD1zBwY6"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5bcc6500a7dso879045e87.0
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 18:09:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791248950; cv=none;
        d=google.com; s=arc-20260327;
        b=YevT5egpd90sXyUdzV+7RU/cXwLnfCY9DloipMPWl1acFH4mQTuFYY7/K+belik6Fo
         +s693TwaOf8gyuATIZ3Bl6/V9LKXPUhIji1C1HJQiFQhJWgaC+lihbwpBAyh+n0UyfIh
         ouowQbJdQUHTwxA0wEWOf9UORD0UPL+PLBtxXWy3CQcUYlD3EV1qviNXQUyzxbFCYEfW
         RqWWzmTJ6RcLCRo0Qtf9TQQFABvhF22KJcPuSi4GNVV61/GRkCx25ZmOfShmG5ws20Bh
         4RKXEhp67E/6o93wAeIs1izF5UDYp81tKv2uY4Tw4WN/zAi4SmS7Epy1kVNNoYzUDvMt
         bcFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=kkoJa2a5Pb+V2YqC92sylMEECtxCIMpFTVrO4IIataM=;
        fh=Gz9lrOSFZ3IAcL5BkMb+JhJhhrvad50qFcmUD88/mMA=;
        b=Yz1/Spb0W8rRHypjXtzZ8FIrvWbplZTAmt1vyQB6z7T+xyhPos9m1sQ78BN1SzN0h3
         ojzWQJb72wNFnuEK6ENMZhp774dDoJksAW+CN9d8qeEXFMpybQM9LiiTbYdEXKFEV+lB
         TEz4nlwHWISjRbOf9xxWxLp5ySyfvvTZ5dstmrHFgdsN1gPOQqD9VbBHpVTaviEI2vb0
         Z5KloJPTViNZzwGiPKQ2zst39nawaD2zYvOB56D1BQekFaaYCKWYyU0RrN/+GXhZ/M3e
         /gl4pJvxzaOkdm/uH+9zE4L2FfyNCtcCWr4eblecVcCdR00t4vywmion7NpdcdrL4fnF
         hkyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791248950; x=1791853750; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kkoJa2a5Pb+V2YqC92sylMEECtxCIMpFTVrO4IIataM=;
        b=gD1zBwY63aneQEdRWI9O2+XhnWcnhenMpHkzDzfmr+2Q0LFpCQWs1J5ADzGW0KIPCt
         TOVS/UekxLDmL8+mKDkGKcZoayDRSgPcaYe3huif6OIc4UFMTbeo/s7sE6I0e5mM7VJP
         MLbb856XtAlNuVJ37tpT385z3EfGY9bqI7JBkRjVo2EQYN2brSintBa7xGik1bXmKiMV
         Hj4jG50TAT6qRMV/bAcLy5cDg15aUa8iM0fI3YSrYZKXwKa/2D5HUZuiACWPFyS+n20W
         QrSiwLGMTbXOqMLQ8na9nYcMRMPtLKzWDcZg15qjiZLozv4DR73uHJZy62lPzFmgxDja
         3w2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791248950; x=1791853750;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kkoJa2a5Pb+V2YqC92sylMEECtxCIMpFTVrO4IIataM=;
        b=zAXfrlN5mXD6a/VPcvKub7mlQtPNhjBdca3XYibbV9pGqxO9t2TGCJUsGp1rSev62Z
         DiAYuJW6fw515bmHOog5lpvE5muRoX6RICqbAXXgUJu3sci0Lkj9/vNDilrh6kIk3/o/
         Ac2gq/lEy1EYTr7TRlhQal4+tAE9EAg1g4E+Up6DecW8kQGFVtiuCmnpYtTq1xrTgE16
         neFpFL7HldjdWRPjXMvGKS7bSgkmOINPBmWUHkJV1rccskGI4OA1eTghqgjoN0uvRs71
         p3py1RiZhuf4fdwGji8KKpCe1zw4exC8u1UdkzUkc+epqd1pK4dPj/d0XY2Pj45Xwkt6
         NWhQ==
X-Forwarded-Encrypted: i=1; AKwUvBxAsmTSyY1LEkUFvFYnBGE3AEiidbJiCcSehIhnxaXlIaZeJ+se8r/B7dsOTl5OVBbIMqpU1c4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJUW/e8aoi/OvnsfQBPc0tMmZL8v6Qka1/4/yQ+otIzQyR3cnkg
	j3xXVguKTMutlm0dL6Gtb4zy3Z1bCFA9xrbis04xS6N7eWk6rzLd0DmWkpexemBELR6hKwf2yax
	+vYDdTuHyWzDdNz56hLHrid74B85jFF8=
X-Gm-Gg: AYBFou01d5B+rDi+xUigpNzKlOfZyfoG+hx5z6gkvUkxgV/SpBo+4StqhxukDdgelLR
	Gmyz7l+rW28uOA5K6EV9gtGhL6La9OCSYxAfTJ4wxyeKYc1+jWM0vK4XfZkqMvS1tRDAvXpPfvF
	11KpVFXxtwOLw0Q7qBbOcfbf/xQcDWeW03ebIUwokGn2AopbIgTmI1l04BINjnwDWowG9N2NzSj
	3oaFiVM56Qhgtg+R2UNmVAFvLFL2tXcU76E66T/XZOKfU7NQQtfQD1PgnxgbB/nkUaKbypWYatA
	iy01woO0nk28h1WjDAMWan+M2xSgrv7S81vGcBLRyqBSO3lQp7iPJtrCSm1xU2CjPzcQvSkgoeA
	lIQ9u/hqFRnI=
X-Received: by 2002:a05:6512:2523:b0:5bc:b091:e78d with SMTP id
 2adb3069b0e04-5bcb091e7e6mr4148625e87.37.1791248950470; Mon, 05 Oct 2026
 18:09:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930112842.21323-1-sigefriedhyy@gmail.com>
 <20260930112842.21323-5-sigefriedhyy@gmail.com> <20261005164946.25da19c2@kernel.org>
In-Reply-To: <20261005164946.25da19c2@kernel.org>
From: Yuyang Huang <sigefriedhyy@gmail.com>
Date: Tue, 6 Oct 2026 10:09:00 +0900
X-Gm-Features: AclHuK-bztab4w1lM2DovGlyn5DZ8ZhMm-bLH4zjSTjG2-Wv3eC_T9ovpy0ACZk
Message-ID: <CA+7S2v+XZjnzxpucTBAaKqLp8FtF92cyHBbrQF8G5D3uT3r8Hg@mail.gmail.com>
Subject: Re: [PATCH net-next v9 4/6] net: add AF_PACKET multicast dumps
To: Jakub Kicinski <kuba@kernel.org>
Cc: Ajay Singh <ajay.kathat@microchip.com>, 
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, Ido Schimmel <idosch@nvidia.com>, 
	Jacob Keller <jacob.e.keller@intel.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Kees Cook <kees@kernel.org>, Kory Maincent <kory.maincent@bootlin.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Nicolas Dichtel <nicolas.dichtel@6wind.com>, 
	Nikolaos Gkarlis <nickgarlis@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
	Sabrina Dubroca <sd@queasysnail.net>, Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	Stanislav Fomichev <sdf.kernel@gmail.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Willem de Bruijn <willemb@google.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > + err = dev_mc_fill_addr(skb, dev, ha, NETLINK_CB(cb->skb).portid,
> > +       cb->nlh->nlmsg_seq, flags, netnsid);
> > + if (err < 0)
> > + break;
> > + nl_dump_check_consistent(cb, nlmsg_hdr(skb));
>
> Why are you checking this on every iteration?

Right, we don't need to check it on every iteration, I will fix it in v10.

> The changes still lack polish IMO.

I will go over the series again for v10. If you have something
specific in mind, a pointer would help.
