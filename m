Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2159253A8A4
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 12:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788871742; cv=pass; b=X0YWt485y2214BdI9vz5mErjVmmTzPY2Fy5jQqDRYRe3NmvehLT1fM+7wfa0n8IjyP2JtduS4VL3/HESya0AskTz0wkB22R9f7dGJz4+L0Rvigz/BOEaUGmIRBV/NFB/JlPqd5SElDGk3RVUBPIQdcEZSLF+Pq0J3T5fWX7XbSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788871742; c=relaxed/simple;
	bh=78Hqg4JS69EObpzSUByjTj00CCKytaf1mVYb9pI6H0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GRO5CP2bm3+ivR2PDuuVxfPBIp3n5nRbvFkzELhTOfH3hyjqzOgbDNzvrbrCHsSQVDM8NiIdRcGHnKPaj1g4/+eDZAB8Bo+t2fSnrmo1SYbX5gSUYDi+5CP3//RogLfKYl6+cfkPuKJGrNRy8IpELyMnB5aFtHG9+CXkLORBHD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sRBFzKHr; arc=pass smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sRBFzKHr"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-90cbff85fa9so53686176d6.2
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 05:49:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788871740; cv=none;
        d=google.com; s=arc-20260327;
        b=mQU6xA0373eimPCPnYUjCCGgfHUppd+Z+txJUp9yzi8P0Hk3pXriqIbOMYFvbdOCg2
         01r7dX5lxAC4iIiM3K0P42x/cWuBrVrR4spmmiulGESKGOpNt/saeVsv3vHLiT3/61d6
         f3HqdVf7J1aNkKQtsXZpCgobYZ1e3V9NUQamZcp7AFnqmapIv416965McE72zZudMaAn
         qwmiEPnq0ob5ZK+WuBDig7mKqqNiLV1fOx3UPsXXVFq1BpYExB1MEDgDtRiKu4Su2lVh
         jnrtbnVdciXN/dEz6Ulik/ODJd66DNjCCJ9LybCUsOrfbYsUnr5xdU6bgAXkGysVKrr5
         QS7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BUiVqNsH2BqPxyyfl13B8I2hyyPsofxH5VCL45yPH5g=;
        fh=bXHfNaq5/BVjLdTJfjshujBLDLsFo9vx8gXbx77BkdM=;
        b=No1LT67fTYcGUyzN35IJsP99gd8wPISK8r5MtH6OV5d0ULoxq3pCrge+WuVToenZkD
         NlcyS2VSPAsPQn/kwxeo6nenLwFHGDRjauvBSRcHwSjMTSl1/LLQ529bm6LQyacaWnOA
         iHrcqSr/iWLgEcf4RJDcBQRZAJVeNBaHy5TfZjVr43UVfdAohi8qHvyR5X1zZR1f0uuZ
         hzZ/o7ZCY0Rk694VVTUojcy12oWgJzIwFjxodPhayCdVAI+Fm1KOPVNTRFVCqBSTQPv2
         NXyF3ZJh9S5V+ntkXQ3ectvJbC8kf8VTh7V2xT5kv5HmEhoTE4EkTxHn4h/ZmIzrq/f+
         YD+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788871740; x=1789476540; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BUiVqNsH2BqPxyyfl13B8I2hyyPsofxH5VCL45yPH5g=;
        b=sRBFzKHrUQwC0us9AUEOo8Z9s0U1zlmdX+HHaNyNC0OxEU9D2kiP2Yd72zuD6DLklI
         unINQf+V/+Kxgkg0Rs6DY3VWiemUisbpKGMS8Mwg2W/TUo2UZvLTY1YIAA+vm62vJLuc
         fUpJZGVQue6ZhQfEYYSPvFyPS09tzJSff19lSPJpmfkRoLyIxap+mkGMbSUvXKeRwpvF
         ew9N94huxmOQ55kHRl7qEqITUjjXO8GbPrZt2FTZCwBGabEYkiszROKSx/c2BCJZs5IY
         RiujL4HFA676rs8cB0LFwNqgxX/jCS8X7Hb90wqhdrbvOSwWtri4UWeV70r+uzmw/YOE
         MxqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788871740; x=1789476540;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BUiVqNsH2BqPxyyfl13B8I2hyyPsofxH5VCL45yPH5g=;
        b=JvSAq9K1nNSmlWzoZ9OHvDDazWRBZcpf4addvFOXe4KRb3KIHqFfN3nf08jrajoBSV
         XZDirzkHfBM/VLZfBfCmYlumYm38VYAVaR0j/NP1rSbzQI/IAe/MbqCrOC5a522mZAPb
         uZUrVTAnil7mh7vUaw8Jxhtcx3f2XR0p2SyAe57Clr0ky3N27/W7XUMBf97lOSBEKfCy
         vEwjl9yO3mhPIKBgTM1lhqzOYSiHS5pFvLwbCfhSewPN+01pUHauy9/GdIn3e7SpFW+e
         EX+I6BK3npaKbDDgK4mYXIzXzJKK+UwdM1SsPlNWu23f6GOyKezJQ0j9ZRZTGw3bP3BY
         rl2w==
X-Forwarded-Encrypted: i=1; AKwUvBwv6K+jSPcL39tdW48W9XK8lQFx57iXqORNXJbmrhrakXrIeWsRayXDEMcW5dvtQPsy8BtgH6E=@vger.kernel.org
X-Gm-Message-State: AFuF++mtV5vQWbdG9VbRXe/UPaeelJZeR4KJdj6s6U/QCD36Y2gEdgZt
	jojuWjcwaWe5uyrlP9fK43BATTL5ltLXzRHE0TS5/up+xKwi/EO5sUAL7LXM+xbFU4x/lQdEkYg
	u+5tI4+ogwdRvuHU5tryIPbzG8nyhy80=
X-Gm-Gg: AYBFou1RBxk7MSQTnK4VqUhZBLeNQlhqo5XWhVY1xFpUHbuoYbRJY/4CHgT5i48bUFa
	2wAJKDKOBOvHFQp1K5qwjI/qu2Q/xeulNQfkzPFISUqvqEKtYahbrbcmsTK1aNssJLwIkKNf1Pb
	1sLWkcMfSc5NsUZheRDHKUahJzqBzN+IThRXAX0wy4MAtE+yBOxDNXn6Rj8+wEKlCll87OrsAuU
	BkKGqhFYMBFZj2j+mag0f+sy1jUY34P6fkBrWB1CjqS84nzc09NwSN0UotrhlNF9fqwcocQdi38
	c0QPCWEtY7YWQD2RvntOKjGADScnFe4mekdFE8izsXpweg==
X-Received: by 2002:a05:6214:2f8c:b0:910:3451:341 with SMTP id
 6a1803df08f44-9103efb48afmr389824056d6.32.1788871739943; Tue, 08 Sep 2026
 05:48:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907-ncsi-over-usb-v1-0-6b74d2f1196c@gmail.com>
 <20260907-ncsi-over-usb-v1-1-6b74d2f1196c@gmail.com> <08083379-6eb9-441e-a656-0066c9006dd7@lunn.ch>
In-Reply-To: <08083379-6eb9-441e-a656-0066c9006dd7@lunn.ch>
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Tue, 8 Sep 2026 20:45:36 +0800
X-Gm-Features: AcwNN1VVwv-AZVG7aa6d6kuiXNW-vhHZ-9WmoGIa_ElFwS3ifzk9WoGv7iR7QI4
Message-ID: <CAGfYmwUTsqgDQCP1q=XxCyW=R+a61urg_Jnnw_3-oJfw_BU38Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] net: usb: cdc_ether: add NCSI passthrough support
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Oliver Neukum <oliver@neukum.org>, Samuel Mendoza-Jonas <sam@mendozajonas.com>, 
	Paul Fertser <fercerpav@gmail.com>, Simon Horman <horms@kernel.org>, linux-usb@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Cosmo Chou <cosmo.chou@quantatw.com>, Mike Hsieh <Mike_Hsieh@quantatw.com>, 
	Mik Lin <Mik.Lin@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
	Adrian Ambrozewicz <aambrozewicz@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 2:17=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > +/* NCSI operates at 100 Mbps */
> > +#define NCSI_SPEED_BPS               (100 * 1000000)
>
> Why 100Mbps? RGMII is often used, running at 1G.
>

Since the original NC-SI specification was designed based on the
RMII protocol, simply set the speed to 100 Mbps as the default
for this virtual USB link.

> > +struct cdc_ncsi_priv {
> > +     struct ncsi_dev *ndev;
> > +     struct net_device_ops netdev_ops;
> > +     const struct net_device_ops *orig_netdev_ops;
> > +};
> > +
> > +static int cdc_ncsi_open(struct net_device *net);
> > +static int cdc_ncsi_stop(struct net_device *net);
>
> No forward declarations. Move the code around so they are not needed.

Thanks for the suggestion, I will move the code to remove forward declarati=
ons.

>
>    Andrew

Best regards,
Potin
