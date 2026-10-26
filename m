Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793010050;
	b=lJ8xMdeeeJHtzH4+rZqj/r5ll2WiKtHWU2m+mJvBLCigXWmpt+Ku6oRgn3ZwpmrPOZJO
	 7tFckgKM33flflkip/pE4iW+7D+b14sBTgYzkdOZJCOvsEF1FTu+gbHh6a2XqZbtoW+sF
	 v/LhqsJscidngIdhAkJR1rDxyAa2tlxtrWsTtpsnWrgUNC/Rn/x0L4uVEgCfz9ZMxIGs7
	 1Xct5wCuWtQkNLTy9QBZi47ldPzyx5sPNc1ObifIc3oDA1lSMXqXAIJWKv83DBJqxHC8N
	 Qb3t3BFRD0J3iN1HKZCJFTcJOdxA1MtpCwfLl1tWyKfU5wVsc+qubQlmmtmdSeFe0fg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793010050;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=YMoH16GByyq7NDx7iz3VxCzQ2SdQTyZJ1IB1eadbd3Y=;
	b=FWTVhOX/L1rFrpf1zY9jzApdAp/s0gspzLcqD++1+DqKePaerqquvUI6Cp1UjpJwR98X
	 bAAkSmYRCjFEi6+LnQVtdgSxUwShkI2ggcHIJNyJWuWYYWLZugIwAB5ZOoEXKrdBXEpsS
	 qjuV6E5dDZL1jiLSj59T0T6KVht3DOD+EY0lXCUjTkxPX1RGjY+5pk026UctrIz6Elquw
	 u/a8xjBGgNCpdX67wqG69poehejrGDqRbM9zkfLiAiKG6xXBoN6gZX5vNoWMGuDo4/qvV
	 WeDNeqr7fUOf5cpZXaKR3zfbcZVqMQU/8VKJae+qHgDHaOCDEjB+sulLPl1hQgBAoIA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=L0LJqMHR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317E7606A31B
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 10:20:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 317E7606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=L0LJqMHR
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1517bda04a0so2896722c88.0
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 03:20:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793010049; cv=none;
        d=google.com; s=arc-20260327;
        b=V2s/fL2Gj53HBvUO6jOWsuzJKltJxnOwjfln3j0VBs2lj0UJ4KpaY9RpPTvpHWaBEf
         ZoMmToS4/PYG8j+ULhcxX2Nw2x+nLrfGPAZmk77jQgxA3iXt1dJMUNYQ5WQCkXLwVGbE
         BMFIj9WfHJmKS/18BZBDqH4daGBhGgiJW2inCGFaS24Oywjhk+AQU7NksWjjXC+xLMKv
         1ODnFHN5p6qYEN4T3RMjCUxfYk56LqKFpM8Mn4pQBLL/uLUg6FyUUvYPFCVQK3ZjUKYB
         Z82eHHfSIZnl1zAuEigccey38v1iEU6DHqbT25cIe+eaRsL52zopq/UQh/7wNhQgI3xJ
         4ttQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=YMoH16GByyq7NDx7iz3VxCzQ2SdQTyZJ1IB1eadbd3Y=;
        fh=j50sCChoxrhIqTLzWFDVW8DRO0BMRAA5qhIR7RKc2DM=;
        b=lJ9fq4u/dx+v+m9JMvuG9MjdNOBnRDhs3s8QuEXLVW31q4lnWynpzHNdDbd7nDQ+dj
         p7PW2pFXDooKTB1gEdHcskzmpi5LTQ8fZrPxGF1pgZJGyBQDqETAP+H4NFNrBZbwFr/K
         oHRq2RrZEFtmLuQQXRyTNWZj/aYd2CTEe3mm3vfP2pZZCvm1fk97LmZv7LkQbh7lYJWj
         o3hOAjOBpY+a+pZzPCYRjYvN9dVJhBG98WK+e8du/M/o+GX3uEScAHLf5TbBJi1YsaCR
         mFi4flx6YudG8WPtEtFBRO1lHuwbNWOy/9nmaWUinucBpLmWVL1m/QvoJNP8ZYaJwcRm
         HeLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793010049; x=1793614849; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YMoH16GByyq7NDx7iz3VxCzQ2SdQTyZJ1IB1eadbd3Y=;
        b=L0LJqMHRrDdRR+uolPuI/shEbdMcRl2jUTyD56QSTcxpjGfE1ewpBiR2YSZ/cYflZY
         I0U/0nT6O5qXh4X9N2/xi1l2blnB1rSl9cKCM3/ol7HCw47exR5o2nQQCzBul9Qsn4F2
         CaFLWyoI+yarQ2Dl8gxWPynUCqFYz9giuaaG8Jq/zihW1wpan3gJ2TLll3VKW5rUzw6L
         2+b4tRTc3pGEGzw0wEB75qQMYIvCNc8qTFMkU4/Z1OwmZCXyHBXbgh4oP31Dxqwa9Ojn
         2Jf5kw0SFngklP7JdhmVNB8vDUZaUb+nTbf5flsP3AFu5E+U2OUowrw65XuS9xde8GU8
         Dmvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793010049; x=1793614849;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YMoH16GByyq7NDx7iz3VxCzQ2SdQTyZJ1IB1eadbd3Y=;
        b=IAB96f/7KzHryUR5uVreTsIOqgzqXDtqLZjoZx4l5vYaCaUXkuNy4BJEI/sc1OroNd
         sMgMEVOrxXR7y18tLFX2KnmYClbk58AAs26P2gQHILKwn588X0qYqklbEjZoFnrGX+bg
         JFyt8VC189DaGi95LnOFDEUcCS4GKL7HAARHnnFaEGIC7bjG0EZWUFQmxXhc5iVk/8/x
         kWe1F813AyPzq/Qsr8BNktk3w1bVaiPqeUV2OYsZG4wSTnsl5fqJ1Q/XikRbtJAQgzOo
         F386dcKsWbINHR9S6eSCNvNPfaaH3bkKUhTt7DcFQOK3xbyzic9vxUp7gX3hPCXVU/U/
         nKaw==
X-Gm-Message-State: AFq9FYKp+7YUgwsBIMOh/IQSCAcG3L+Ls66sRojjJxHX1F7UeQ0Rn/69
	r+7Ro2V8S4FOLDBIneOEqWT+wyZcdUSWiiwGxQM6lHRGylAvferYa0ihu6uxZvaNHzPkueV3pe9
	ppgx7ap3ylwtwFsG+WEiA3dMVSsPiv5s=
X-Gm-Gg: AYBFou2xs07yzTuIx840xzFtn6cqjjohBz+kYbeJkgWVReFtBCALBACX33yP7V/0o8H
	UQVlcMDkrQr6V77Eqa0iu9ni1gyCovVGujYzeq/ayHTMcj/nV5mDZjfEr2ePTvWSPVadV4xtV4V
	C0gD6s3K9Pgm6ig+VZz+zYu1Bh9T/MFU7CtzPsbHdmcAV49sVji+82UrBSOVw81bpdBqZFmlTsw
	0xogwXXMsRPhqe/BdtggEM+bqUZ/xhg0VeUJi2kVpToF+svD1YIg1J5uZpgyN6MnZDc1B6sERa3
	UqNuyE+yBigXb5rX7nvnak84y68ehZYKSHii5PgVwbME8CNW/0LJQmwRmQxGeizvTgy3H55UVhM
	up5RjsVr//TMaIjPcSFYFAZ4xwAnXUeOjWZzN
X-Received: by 2002:a05:701b:204a:20b0:14d:c7ae:85df with SMTP id
 a92af1059eb24-1993505df63mr8729350c88.12.1793010048874; Mon, 26 Oct 2026
 03:20:48 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022103821.89552-1-timur.stukan.linux@gmail.com>
 <atsRW-aYHeB-cEgi@fedora> <CAF+_u5Byu9BccKQpZ9VcXAb-fMEhpKAD9A65LktLDJ77ng+KfQ@mail.gmail.com>
 <at6lTNHwA1V9Xja9@fedora>
In-Reply-To: <at6lTNHwA1V9Xja9@fedora>
From: Timur Stukan <timur.stukan.linux@gmail.com>
Date: Mon, 26 Oct 2026 12:20:37 +0200
X-Gm-Features: AclHuK8aVN00Mh9suAw-8_VhUq9Nba3PvRGqPy0j7Ezrj-pFXdmwKx2AZvyeAfA
Message-ID: <CAF+_u5Bo7_GySpNLv00omfAtKD++5DJYgriSO_=rwzNT7vrfyg@mail.gmail.com>
Subject: Re: [PATCH net] bonding: fix missing down path on speed/duplex
 failure after FAIL->UP
To: Hangbin Liu <hangbin.liu@linux.dev>
Cc: netdev@vger.kernel.org, Hangbin Liu <liuhangbin@gmail.com>, 
	Fernando Fernandez Mancera <fmancera@suse.de>, Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 26 Oct 2026 at 02:56, Hangbin Liu <hangbin.liu@linux.dev> wrote:
>
> On Fri, Oct 23, 2026 at 03:35:57PM +0300, Timur Stukan wrote:
> > On Fri, 23 Oct 2026 at 10:48, Hangbin Liu <hangbin.liu@linux.dev> wrote:
> >
> > > >  static void bond_miimon_commit(struct bonding *bond)
> > > >  {
> > > >       struct slave *slave, *primary, *active;
> > > > @@ -2807,10 +2828,21 @@ static void bond_miimon_commit(struct bonding *bond)
> > > >                       err = bond_update_speed_duplex(slave);
> > > >                       netdev_unlock_ops(slave->dev);
> > > >                       if (err && bond_needs_speed_duplex(bond)) {
> > > > -                             slave->link = BOND_LINK_DOWN;
> > >
> > > Hmm, this issue only happens when link_state is on
> > >
> > >         netif_running(slave->dev) && netif_carrier_ok(slave->dev);
> > >
> > > while !netif_device_present. Should we set the link up when device detached?
> >
> >
> > Hi Hangbin,
> >
> > Thanks for the review and the suggestion.
> >
> > A detached device is one way to get there, but it does not cover all
> > the ways to hit this bug. In particular, it does not cover the case i
> > reproduced: during inspect both link_state and netif_device_present()
> > are true, but the carrier is lost after inspect and before commit, so
> > reading speed/duplex fails in commit.
>
> Hi Timur,
>
> Thanks for the explain, but the same question to this patch. How do you
> make sure the carrier is not lost during bond_miimon_inspect() and
> this slave->link_prev_state setting?
>
> Thanks
> Hangbin

Hi Hangbin,

Thanks for the question. To answer directly: there is no way to make
sure the carrier is not lost between bond_miimon_inspect() and setting
link_prev_state, but the fix does not need that.

Let's split the miimon logic with this patch into 3 steps, executed in
this order:
- bond_miimon_inspect() - carrier is checked here and new state is proposed.
- setting slave->link_prev_state - just a copy of slave->link, it is
not read from the carrier.
- bond_miimon_commit(), case UP - speed/duplex check.

And there is the case where downdelay is set and active slave flaps,
so it is currently in FAIL. Possible scenarios:
a) The carrier is present during inspect, so bond_miimon_inspect()
proposes link_new_state as UP for active slave. Then the carrier is
lost somewhere between bond_miimon_inspect() and bond_miimon_commit().
It does not matter whether this happens before (your question) or
after setting link_prev_state, it is set to FAIL anyway. Then in
bond_miimon_commit() in case UP, speed/duplex check fails because
carrier is lost and because link_prev_state is FAIL, the active slave
goes through a regular down path with failover.
b) The carrier is lost before bond_miimon_inspect(), so UP is not
proposed at all, and after downdelay the slave goes DOWN through the
same regular down path.
c) The carrier is lost after bond_miimon_commit(), so the slave is
already UP. On the next miimon tick bond_miimon_inspect() proposes
FAIL and then it follows the same path as in b).

So slave->link_prev_state is not affected by carrier changes between
inspect and commit, that is just a copy of slave->link, needed to do
the right thing in bond_miimon_commit() if the speed/duplex check
fails (e.g. because the carrier is lost).

The same applies to the approach without link_prev_state I proposed to
Jay, since there slave->link itself still holds the previous state in
bond_miimon_commit().

Thanks,
Timur.
