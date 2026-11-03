Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.228.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793717699;
	b=oTY7TpuWn/04AN0Ww2bhmPIMz3KBrG33cvhcJJxHYtfxVlChiNgM5uNI+n1qsZTrBDnW
	 Z570WIdUYlMOcbTcFFhP89hzJrXnvEtU8nz7ZbUWUi0wndgf4S6wYSY+Tmbn4vI1SK4hC
	 kj9lsEl912MMs/cbcWtvDPM1Wdh+SN2gd1yOhkbHUlEDWpCpy1PRkciHGLjwE9+HoXlGr
	 TpTVgm5JGUIs+NDpJT4XqeOEFzbAyOH94AU0vHgk5eb+uycA/msMa82PpSy1Vx3m4IJ8W
	 LbyrPdRBgkGI5isWmVDib6a7kqFO8N5vjq/zyvZT2sLbTnhwwYzJCXEE1DwaQS7VVgg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793717699;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=IgQ05NbEx4CjJRtb6GmYnk00OGmK1qIWhCn9DM7D2rM=;
	b=2Flhhkge+b4Sp4ihfUU6qbZJqyi0gp2W8gf3HxhO5UTCjQUiPIcoJUyfjp55cFzbPzRL
	 1gtdYCaTvstp84qrt4gXE/tqbVLfwLZ7mjd+rmyG8W0xFyMIMGQTq2mjxG8R/vPbccrdB
	 p/mf8aamOBwli+sHD7iiBsC7/Zii0ZTecnq/6PcuZtjTX8dmX5E7PSlXZ6/q+e0xO+5Az
	 N0YPMpCwrr3Gm6I4QDl2JK7ztntz+lYwXdtAjq0+cmdO+5yAhy1DgZQOBudwGDxCwUwgf
	 Cf5szaDXG+7WkvLp/+cWifzK0AkQaH0nJhkz+7n5TppGs5Xrm82yWoGottJnIgf/QsA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lJTHeByh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.228.131
Received: from mail-ej2-f3.google.com (mail-ej2-f3.google.com [74.125.228.131])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D1C606D838
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 14:54:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2D1C606D838
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lJTHeByh
Received: by mail-ej2-f3.google.com with SMTP id a640c23a62f3a-c3e0e38c8c2so181505366b.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 06:54:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793717696; cv=none;
        d=google.com; s=arc-20260327;
        b=AWcb2WwX6cimeR248CxG2zwaE/kOWTSHQqdBoGKNhP+/iIGxELAEdSii7U+FN1NpQa
         4eKVoBBJtd8xY3LBGVuTmRyN4i/LIN6E4WEfpMaXqcK7Xa4k1Hqmhu6xfEHOwbGATKTh
         aA+T9jqvXV8T+D0yHEGTMGX8LP0rIYU+6yZ3zoiA/iwwoMWF5Xfwks9mD8kq/JpMj6kO
         ERBSHeocz8o8V+hKXi+sZnVWQwuZcZb/27K8jH7l8/hPT8gCzZnrV8T6nyFUDbS1Fgpz
         PNB0sUkP9hyp+Sk51a08TfS7siFrUrnliozpNSd2VKNvdsRvflta6yf8RCEqlFkFtKxk
         h60w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IgQ05NbEx4CjJRtb6GmYnk00OGmK1qIWhCn9DM7D2rM=;
        fh=cO3BWqgfB4p2rkGMdhQLydQG/+wDdmyf2n/VlZjx+pA=;
        b=djlcyxcHBvpLMrA2smX65KKHk9qDgfkjNhjPtdLeaqS+66PZ9GONbcpOhTeyPV3TPR
         ox3D8tUznZIz5Jh5Y8kDW/0f3et08xszlfT6vO1LO1Eq7Nmh0VcWuxJZ2D/JRSz2OnQE
         14vtF31H4l7sY6uWpbqrUbZM3Um1mQE3oV90jjhhcQwr2zl8NGeF17TknooYvXALyy4P
         HKmLliI8HTezloCdAdn4RkfeDSy+z+S0s2Fo6yfmmu9FLimZjxFbgsi1QT4egtfGaFly
         5agNBxBt+3YNc/hhjOw2t0O6rSvzSaXeDzDChPuvdryvFmM2lfY4GrPpaHK3VeMk2fui
         HPCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793717696; x=1794322496; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IgQ05NbEx4CjJRtb6GmYnk00OGmK1qIWhCn9DM7D2rM=;
        b=lJTHeByhvUsqmNthJzka8HI//cTRrFzmipR5IMxMyAxoF6ts3LUAFWrILsyTik1UmD
         2MeTsZQSE/GF5OCnYjiEhQQY96ukTa2Zfdm9XJj8qncVyf9L+q0OAkg3L8FfHcbo6l/A
         GLJdxlI7SPbxK+62d2NCDYfz7/v5tTD3HJuB8hKbfhVuKXQaLRdszKY8SSp/v7fahQyl
         MokP4a8V3Cw2R5dRVS4PpBM2nkGqTtUQdZXXz5Qd2Jpr4+Qh4K/z/Qs5EtBZDZ+YCHjs
         u30BwD1FvpNrWpljxKFTQQG7S6hFxbddzd8zz4HEpyteF92F5sAIqcu8sF3iXmvOar7n
         xHWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793717696; x=1794322496;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IgQ05NbEx4CjJRtb6GmYnk00OGmK1qIWhCn9DM7D2rM=;
        b=aYqVV1YaNhYtgPT6mvk1gGK2nO2qO1FA5qoQUTE4G5kCJxQiKxywQLobbHwpjbVMYk
         GHWYJOjNkfy3AqfNPuKyG302yEnU+WeV/VDRfiyJjs/Mz7KdEpFJ4O09mBTxCuBph3iR
         MTs6oWGJG84i3nEzRfIC+JbN1crdPpuIzxra4rs+tQdItc3sd9+pRlTWPTGgdFpzWB1d
         KrisgCtS0kpuR8JhLPSiZX+B3bipHwh8OJFvQ1NrKPUSfRAGhUFE5L7LWvBvPXXY0MrT
         M39Vhpra8H0eOvHwcnUzq54QhqNemailVq8fxAt4IMJdOVJhjPQa+Js/AzylEMpoBJ8N
         bIwA==
X-Forwarded-Encrypted: i=1; AKwUvBxscrvrYSigV8FvPap9Nxl4fpva7kDamuqQO1wm3InCe1YRN0RNADnGCexAg1dIK9M7GqhJRpA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/9asJiKATwinTFhTnhNaDUecmsPYpQkJAlKnesIVKWBOZc7orR
	hrhCVkYwK/undsUuwy4WEQaLEZ5gcVPL4kByGeZlwpxTGV94jsvRo3STY2xtqVsRRzDCAiNEhah
	+gw1GZe+i9lAwrFfxYtpCotp0t8s9SqRYOe6KWln5yg==
X-Gm-Gg: AYBFou2u+bgjCaqb9X3a0Myd5hK99BGU5lvwqVADeaIpYyu52lftBb3Mc1HtAmZjDmy
	5H509EkMfK3uhbBdmM1wo3NsuWrIWugf49LQIxTOyjd5KxXmrhtSb6eFpGePrwzzZ5jV6dbeRZs
	nA8TeTj2XruzSEKd0EyYAjagUsU1etbHRM/dDTAQ90mtaC/eUaeoX3oq8xnQwcEilhDpFvt4wGM
	WJQUZLLJC7uoKXEpRjpUghJPMMh9pUghsF1FzD/ZkBUhQKLXUFQBb28XUjq3wNXQN2KrsYbCD9z
	QqgwaQfMLVrakUEPGAXqokP+Qj5jEhvdOUWiucDmQIyUSHxFJSCu9j6vLl9fL14i8NxHtmU7IX5
	xxpyu95+ZqzV0Zdkv6++B2rbCUyBGU65w4njL7oo=
X-Received: by 2002:a17:906:8346:b0:c4c:d6a3:f4bb with SMTP id
 a640c23a62f3a-c4cd6a3f756mr402146766b.10.1793717696122; Tue, 03 Nov 2026
 06:54:56 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029094916.3127193-2-coiaprant@gmail.com> <c5fc86f9-3c43-4aee-8d88-92e8f88c6d5d@bootlin.com>
 <1B8D463D-1295-4BF0-972D-859C342E49F5@gmail.com> <48cb8a9d-622f-497c-a13e-bc679c764ce0@lunn.ch>
 <27E466B0-72FD-47BA-B952-68BF4A817A04@gmail.com> <f554dcc0-14ea-4721-9517-dc0337c47426@lunn.ch>
In-Reply-To: <f554dcc0-14ea-4721-9517-dc0337c47426@lunn.ch>
From: Coia Prant <coiaprant@gmail.com>
Date: Tue, 3 Nov 2026 22:54:43 +0800
X-Gm-Features: AclHuK95KHd0dj6_gNrX9gHZCv0l52s-Y_iZ0--uZvsX8IoRCF8VNkN1cmNSy9Q
Message-ID: <CALj3r0hfBj_-ZGsAAvGC5FYeFDtxiWcYDsmZA5fEeq_chhvfeA@mail.gmail.com>
Subject: Re: [PATCH net] net: pcs: xpcs-rk: limit advertised interfaces
To: Andrew Lunn <andrew@lunn.ch>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, Jakub Kicinski <kuba@kernel.org>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Andrew Lunn <andrew@lunn.ch> =E4=BA=8E2026=E5=B9=B411=E6=9C=883=E6=97=A5=E5=
=91=A8=E4=BA=8C 21:09=E5=86=99=E9=81=93=EF=BC=9A
>
> > >Are there any registers which describe how the PCS was configured at
> > >syntheses time?
> > >
> > >     Andrew
> >
> > Hi Andrew,
> >
> > Yes, looking at the `xpcs_identity` code, the core does probe different
> > MMDs to get the rough type: PMA/PMD MMD for C73 and VEND2 MMD for C37.
> >
> > However, even if we determine it's a C37 or C73 block, that only gives
> > us the rough family, not the exact feature set.
>
> You might want to try reaching out to Synopsys. There are sometimes
> feature bits in VEND1/2 which list the exact configuration
> synthesised.  And since it is a core part of the licensed IP, it
> should be safe to trust it, independent of the platform it has been
> integrated into.
>
>       Andrew

Hi Andrew,

Thanks for the suggestion. I looked into reaching out to Synopsys, but
it seems the original maintainer is no longer active in mainline.

I also tried registering on the Synopsys website to look for the
databook, but the registration was rejected with:

  "We couldn't find your email domain in our records. Please verify
   your email address and try again."

It seems they only accept corporate emails or existing NDA holders.
Without the databook, guessing the VEND1/VEND2 feature bit layout is
risky, as it could lead to silent misdetection of capabilities.

Since Wangxun (Jiawen Wu) and NXP (Clark Wang) already have their own
XPCS PMA configurations and quirks in the tree, they must have access
to the vendor integration manuals that document the VEND1/VEND2 layout.

Do you think it would be appropriate if I post a query to the netdev
list (CCing them) asking if they can share the feature bit definitions?
Or is there a better channel for this kind of vendor coordination?

For this v3 patch, the glue-level intersection remains the safe
interim solution.

Coia
