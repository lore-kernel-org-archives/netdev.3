Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793181517;
	b=1iWN++b8Cbdznho3GWCEhdl2YuIphxg0kMGchOAM4ZBR+3WvzzcF1P3QXM0/9Yeuq88s
	 6qLRrZ/AiwZ7IGZjgGfzQL12uZ6iYmq+FTHV6lke5LScpDNN49APlwr+orf6/2jR6ipmi
	 Wk2O5pYQj/f3bMPWdNAZ6+YQITVdJmq2h/PxtMLXWN0iRvVXMg/jWEGH0cTAlOuBEoQ0K
	 RpYzVWVyrQ8g7EuDltWhSlRS8RoDFxSEvz42mU9pr8VK2mr9yYcLasQtl7jhFGXG8jPnl
	 zz8lPlCkTp/CmQ72zDZVETGdKiTqelIhHcS1Z1jXcES3qrCSZbhVI2eJzgcwUZO0NAQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793181517;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=8iL3xBuCLUGHOr0laLgv9lVNTvVFhiaaWX6F5QYCURE=;
	b=vQ1AmvGf5nIU5Y9QQtXUDAcVl6QNba0/jIgb5VKEk56jek2AyMxr48bZQbzNmGgdhuok
	 ocMFc0teHQjJeOPeT4S5xn0Od5QQNCdZ1iQ7JUonCn2CoIizvdWktDn9oiHkV5GDG9RKm
	 0mnP4mi7aAMnTguKcdIJdF2J1r5RZF5i3DKWH6gu3yBzAw/bsKYjdrEZo2zk83RATNoQW
	 3mmIpShNCWo4Ev+Y58a7u41Q+kplsXWbpW18t4Q83gdDVRJ8B/ScZdC2TkLBlN9HPb5Uz
	 GGQo7vl29V8ykCCwXdrrJ/39BbeR52vv94Ksya1SzRPWNhMwZNudg5ncvmbmUidWS/g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MNfRGB8W;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.179
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A19D606A31C
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 09:58:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A19D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MNfRGB8W
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-8aea7b7ca0cso5645337b3.2
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 02:58:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793181516; cv=none;
        d=google.com; s=arc-20260327;
        b=EJJcsj5ZKyiwLpe/cSgNEipBH/EX67cIPDoPVz/iZwTFLOygQ9x2InRLToIj3a5CsW
         wJQMRa1KimDDP5uXpZXZNufR+56yV5QyflYG+Q9rEFW/IYyJg1ueEiYb9iqFFqmn6Ul+
         zCAN8eC1esTMVQx6f0mEUrJGaq5hsCs5Ei3KFjB+vcKXdyU/7pRDBatLDCbEOOLKM+Rc
         xisGoQmDmb2+klHVRk5n5qBbluewUNx0zkipuXJDGT/5UlYc1bYEWerkl9SufFDMqmNo
         hIMp7PO09aUnd5VWlqebbdMGCbmdmmsXQzfEWfxqMKMPgsrav3jdH3oGwB/Spj3S1eyB
         ptYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8iL3xBuCLUGHOr0laLgv9lVNTvVFhiaaWX6F5QYCURE=;
        fh=3rM+mk4x3Nd7dZrGPPzl8nXyUwXhAg6S1dYaTlDEkdw=;
        b=Z/JE0+soIJr+JnawlNuLEa81hwXNlbxkeoD2JF1ua4Z6iw0LdFVQJzXAUk5SniO3Se
         6HKW13bAPC31vu2uy6b8lcSrBLvKCxjv3MafIqhhq8bQWhmaiN9OqI2OmYLiqkLYkqS6
         rpjUVZpHK7BcpQtKk5paQ+0lgcwgcNCOcLY76Kz6PDQ/hwiJsaZFqLLDFVmm0BVuiVjy
         za5JFchXProOcCcAq7UCSRnaUDbc9zlsV42loGbjUv0BpkZ0Btp7yp6K0bxlQ5CNx3qa
         cVD8wdKhGs3iUtQd1ooKIfQ8taJp8IxeTaFlUZ2fGQXn2F4IQUSmW8arx8vl3Y9MdV9a
         s7iw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793181516; x=1793786316; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8iL3xBuCLUGHOr0laLgv9lVNTvVFhiaaWX6F5QYCURE=;
        b=MNfRGB8WjgsnbQddruBkQbQap46egl4P62hZyl083tttW4bwNcxmisX11SNMOJUKr/
         O0hdC/YN6Dm4IL5PnRihGOTuD2yUkYMuIFI0ClqJ6dz7/yzsxRlZls5yDt61KgaVn2Wb
         PFj6Dbjd2UmBdlD1H2iQwvBOgDja7mtIWexAoHMNgBOZxRNI3o6j9g9mP3yYR0aE0vZP
         i/389bDRqI2qWiLbl31Hr93VKNVWxC9HDvPre6+qxknFCwlLcogIDQBDkG87l5RQ69Qu
         c1JeDoxMN2QKrP6gfP2TepfBcTmHiNE1LYGhtc03w9GHNGoqGGLokST0TtRtRt9Cu9Kf
         /ayQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793181516; x=1793786316;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8iL3xBuCLUGHOr0laLgv9lVNTvVFhiaaWX6F5QYCURE=;
        b=G0ADzZ5eWaR9awZwsBqDcJdrYJU4t5s+6L6+lGQf1fIGhXBE/7zCk8X6A08l5qKtIC
         vGE9H+WslsKIDC/SMlZjLV+MFA52/F2TnuqWlliGO2dT70+p1AREc6lWN5eRfkYGeLYL
         nUn1GxqPuznMFTVObEfWzLZJJUXTxpn9ykZ00Pm6Eb+B0BFK4aNCzQtA8Y82YLA3DwlC
         YrkYsPANd9HU/p1RCThCwmH3JIvoW/xIRTZ1KLlT3wschBu5wVt9C00wlDUO2hnI3m3p
         6AWLEgUgnXhTEi8lzfPTDvxmJznwipeBvsiStKf/BKmzJqZbmCnsXSNENZIbT1ZOBGCm
         2ZvA==
X-Gm-Message-State: AFq9FYIrG8zH19DsWxskWwsPHhm9AsezvdOqHjHUuUGiAUFdNfOO/K7D
	ZZ2veo8s07+C8CC93mOkE9hnCFebMtHPCCgNbIPKL7553KiPTlV/qzvoUz1OmeRv2x/jfXiTK4/
	zMh1sAiaKRxC6a8YBCkCDM/qm/2JGde0=
X-Gm-Gg: AYBFou2oKF3AreeGuVCg3XX/uLHfPYha5PxX1/t7llZI9cnUiwyMeG522+sWCs/5OFe
	98sSJFLMK64Ls3QQzQDBIcbR1jvaBNxPpIZEJeBvNvUvc9sfXc1oOHJRt5cXs2A9SJdCzdWbpIg
	jvv50+B3rsDXsXYyTSYZimuGRMCbL3q+ZvH0c7WPaO2hSsxzYj4wI8r8D2Jz2PBmp8W1QygEhmB
	F0RtAhU4OCv1Qrynrvg51cQVNr3Xys27fiVnu4E3Xk0uBPTxcbLkUV9uAhYpLqw2C6GXCtRqJCR
	sSFesxbJQd6UemXDU4l42GB0q1txMS4HmcbaZz9Mn7x++z/9sumDV0GGdh01Twiu/QQ/12CvFT3
	hY4u4onSs3Fy7B6fdSbSMyR8PNIXQvlieUxIheQuVz3oq/PNcw1eHrZfyEYa8JCZPo/7JFTm1Dj
	hbmS+KU0wBXdPOEUgxWkPOerrCW6sc67+rfWMsu6tSKuDqyaAkBzg3QyZyBH5XBtLYmO+Ez8MGu
	4nU
X-Received: by 2002:a05:690c:fd3:b0:8b0:a7d5:8592 with SMTP id
 00721157ae682-8b1b595a363mr12233987b3.7.1793181516411; Wed, 28 Oct 2026
 02:58:36 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027202230.3539646-1-florian.fainelli@broadcom.com> <20261027202230.3539646-6-florian.fainelli@broadcom.com>
In-Reply-To: <20261027202230.3539646-6-florian.fainelli@broadcom.com>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Wed, 28 Oct 2026 10:58:25 +0100
X-Gm-Features: AclHuK9Wu3Tn39aB_LH0camjx_DlDNxaxkN0UrceaNk9WSSmvziGqPcnpvmptdg
Message-ID: <CAOiHx==nHqXwjsmjH1vqiPZ+d12W9rKFOFarqhvhD5ukJb=xVQ@mail.gmail.com>
Subject: Re: [PATCH net 5/5] net: dsa: b53: use the correct override register
 2 Gbps bit
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Russell King <linux@armlinux.org.uk>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 9:22=E2=80=AFPM Florian Fainelli
<florian.fainelli@broadcom.com> wrote:
>
> The IMP and per-port GMII override registers swap the override-enable and=
 2
> Gbps speed bits. Using the IMP speed bit on a GMII port clears its overri=
de
> enable and leaves any previous 2 Gbps selection intact. Select the speed
> bit alongside the register and enable bit so lower speeds clear the corre=
ct
> bit and 2 Gbps sets it.
>
> Fixes: b6a8a5477fe9 ("net: dsa: b53: fix resetting speed and pause on for=
ced link")
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>

Reviewed-by: Jonas Gorski <jonas.gorski@gmail.com>
