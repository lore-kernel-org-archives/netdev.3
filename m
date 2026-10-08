Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D153624B3
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 19:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791489354; cv=pass; b=CKIbfXeEGW7hm/lWDQXYcTZRrlpv7mQSw20cytxOC2259uxiW9uwUeOctMWwppFIXe3O+BTrmLNa/fmzP8M7gSQIbVk/5yuV1yDAKRu6wWiWy6iory5BnZpdjqAndp83dc0L1gJTGR4g3wmY3Rk1oAO9AuZFeNOSUXyVPCYmapY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791489354; c=relaxed/simple;
	bh=ziHAPQRoMkwgfKKfZIoohuKulG35BvtusPrpDG8odo0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tFI59Sw6aUlPfyb78ZiUKcfVON10tX6OSQB2+kcfbKPWJlndajQV5HcBdKiG6P6bObJTlzU2a87O5FPv5YVnHnI4WtRSut0pogVfkY4tvXHmzU9Sh/UMWtZLW9ABtL9qeHpzL8A+CYJqmBmGD/mJXFG8NjG0kq1X+s9YQicZ93Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=slItrefq; arc=pass smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="slItrefq"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-823036fae5dso243567a34.1
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 12:55:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791489352; cv=none;
        d=google.com; s=arc-20260327;
        b=VJWxiinJo8W54JQl4lIc0ma6DCckQUBwJwelxULczzEEle5zx8w1Q9FrE0Vo9hAHpj
         NHwkZ1jmF/st6QFpVKbLL7jozsTtK/3SljGwtTHdb2URmNjWIT6rbbLMtmmk56qZRWPi
         Pel0aA1UwoynpIUDm0j79CkKZvRwFYmO7Zfojkc/p1+Ky+KQzFWxHpqcuBKsJc+ny01M
         ZkJAdP2fc7P2X07bfly0f/Ph1F0YmmGpk+KGIgeBCSThjzrLu3bifZTk23di4pxUcyL0
         QB621LagoqcJrZQcABs1vyE7qCIQ8ZRNQjHNXXNeMFJry6+A3UQ2uPKA6BXhqsYOSYBF
         FM/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zgcV5jlz2rBvJZUAbH1QsAzR+KCXqGBXEWNrdPfT0UQ=;
        fh=SU3Mpk837KJJQ8tukfw8m15oNbMcHm4UWdmRMns44vQ=;
        b=Rawbumh5iMZswnhqtR/Q3SpCpXTBelCOUCu+mNwPxPxseJAwh8cEUMnmYgIOO9m6rs
         77IPiwjlqmGtENbxZ/dWVL7kJMx3W+kn4FQCokcvseLY3tTeTrr32Dlp3bqubi8qOnuY
         rtdyZ/QpHCbLomBUZmbc4/rb6/dhVJ02gNwUxUR3XbaK3hyTE16P0TtKJT+2yzpLDncs
         t1dTsps2ORirYf4+8BqAbC9BtrG6ODTSIr68vNc1AlJbu3hRWnh6BM6BbSw2mt99rEXX
         qQOxL06tdmm2+M25R5HCtrJSis5dwgwSSWyh5PQQX3qD1qGOaHOeCnyvGodbxizv9e64
         Ub+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791489352; x=1792094152; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zgcV5jlz2rBvJZUAbH1QsAzR+KCXqGBXEWNrdPfT0UQ=;
        b=slItrefqsZEZ62X5Mpm4xNTkRfqFqnU/ZkKtuVIakpXiSTQR/yVhVcsy6vFwX0Veqg
         oPQYLETZpy8jNxUfldNasUAAd2v06+uvC5Ev1xZYXvfTiBBkgxjRlVSZtB9brOMv/0I5
         CmbbIGl4nHqq7ZZN6RbTgnmCif14B8RRz2ivv5sBFrhTGrwGwrLr8XtXj/KdOd+sP8Sf
         kTSTc/kK8pua+ImWs1FyqgVrTNUnmBoilw7r2nBsIa1fuok3bL5xo+DvP/POiVkhrcjz
         ywyiGS46vNYDHL15imaS+fsjrDE2BrQB160ndbMsRZcdbOuvRnIzrrfZrsrNQeXvsIvm
         ZvLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791489352; x=1792094152;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zgcV5jlz2rBvJZUAbH1QsAzR+KCXqGBXEWNrdPfT0UQ=;
        b=xT50ZBWWgXK9Ky4FBHuSOw3PrsOTSN9WT3n/XUJhZpMCj2XnyxDL0QdkZfDSEq/pD1
         dhVtvAu25HDqLSGfROWgaLFyfNFbGnbaN9xUWxNfSZRuSdkGywbLGJY3YW/+qrt8JcwL
         TxdYeK8BksJS7XheHM3grrtizCCNQeh8MihRN2Ajhm01+UovydwIa1oWuKDQBI1xeQ98
         qbHhinK7N9wJZo+Y11iOkBfYcRsGAuyANnt6QDWk9/fyEUy5eg9vou7103oEHbj4kkNX
         1UvA19TcdxjG0owSe3FVoab1SggT4cbExaBuBCnfM9dJU1AhlKlkxWa17AFspsw0pFA6
         0a/Q==
X-Forwarded-Encrypted: i=1; AKwUvBzRBs/2ahuzBTEARypqlzpbYaRzE/ymdy4fl9/mzpWSr139eaPvwEdiv+OE4ccKvpAq7oZ9gRc=@vger.kernel.org
X-Gm-Message-State: AFuF++n5WbRls044ayyCl1V5J3HTA/Omgr0yFcOUi+MB8nrhWAwOlfH2
	zEBZiJT9rCGujN5dYJEIDIOj+V3GPu5g9bYrL9N32+RwQ2j4JnHBDPaGml6kpBfRmNbuOYyGJhI
	6jKfXwgRr8QwU1GBaoiLhJSqP7pK227A=
X-Gm-Gg: AYBFou1umXM7LhQWyXhyCzHtqcfethvIGYGc8Rx1v1yfPeamZH4WczDVDyA/FFQHNlx
	TR348OHEQAULMkhNCCX2tMomlvfrsSNFwSHFdl2PU4IXk6ISkrkNf8ZGr9wNQPtZOQ6Yb8qI/T6
	Qwdo9T3OuPUPERfim0ireQLK1tzPQEFdqaij8U/RRzFqLfkjjMzpFxWTHMF6WQjkt5MGn92v7al
	HCYgdvQjcIyeL9c4dsaj7/XvuitXNoJJSYDn9U+KtsATUNE6ytxIN63fCoFy4U6kQIU0oHLZiEF
	6NLkSdq199O3lIVN382f5Kw6Lt70dqB2WkfGEHdeQYxooSYPcaFUJiqF6GFGihAP3fNmHgw=
X-Received: by 2002:a05:6808:1925:b0:497:d23f:e621 with SMTP id
 5614622812f47-503efe694c5mr5822680b6e.2.1791489351869; Thu, 08 Oct 2026
 12:55:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261006-netcons-fixes-next-v1-0-231cd26f8c51@gmail.com>
 <20261006-netcons-fixes-next-v1-1-231cd26f8c51@gmail.com> <afc14b81-32b3-4f91-8b0c-0152889f80f6@kernel.org>
In-Reply-To: <afc14b81-32b3-4f91-8b0c-0152889f80f6@kernel.org>
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Thu, 8 Oct 2026 20:55:40 +0100
X-Gm-Features: AclHuK-BFm-kWbsOrrSZkaU1W93cEM2S6Thw1jvB5mRVOK1OnYY5Oo50P8TSVug
Message-ID: <CAGSyskUE2CM_i_+o2Dtf+_OriRyad+UzG4S-rzOeTL18LnZheQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] netconsole: avoid printing partially updated
 target attributes
To: Eric Dumazet <edumazet@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sashiko <netdev-bot+sashiko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Eric, thanks for the review!

On Tue, Oct 6, 2026 at 9:35=E2=80=AFPM Eric Dumazet <edumazet@kernel.org> w=
rote:
>
>
>
> On 10/6/26 20:58, Gustavo Luiz Duarte wrote:
> > The configfs store callbacks all serialize on dynamic_netconsole_mutex
> > but not on the read side, so reading an attribute while it is being
> > written returns a partially updated value.
> >
> > Hold dynamic_netconsole_mutex on *_show() callbacks to avoid racing wit=
h
> > writers.
> >
> > The dev_name_show() callback can also race with
> > netconsole_netdev_event() writing to np.dev_name due to
> > NETDEV_CHANGENAME. So it needs to hold RTNL in addition to
> > dynamic_netconsole_mutex.
> >
> > Reported-by: Sashiko <netdev-bot+sashiko@kernel.org>
> > Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260814-ne=
tcons_ipv6-v3-7-bc0915e8c75f@gmail.com
> > Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928-ne=
tcons-fixes-v1-0-bb5ffe5e698a%40gmail.com
> > Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
> > ---
> >   drivers/net/netconsole.c | 62 +++++++++++++++++++++++++++++++++++++++=
---------
> >   1 file changed, 51 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> > index 267254f046de..188beacb308d 100644
> > --- a/drivers/net/netconsole.c
> > +++ b/drivers/net/netconsole.c
> > @@ -859,7 +859,19 @@ static ssize_t release_show(struct config_item *it=
em, char *buf)
> >
> >   static ssize_t dev_name_show(struct config_item *item, char *buf)
> >   {
> > -     return sysfs_emit(buf, "%s\n", to_target(item)->np.dev_name);
> > +     struct netconsole_target *nt =3D to_target(item);
> > +     int ret;
> > +
> > +     dynamic_netconsole_mutex_lock();
> > +     /* Hold RTNL to prevent racing against netconsole_netdev_event()
> > +      * changing np.dev_name.
> > +      */
> > +     rtnl_lock();
> > +     ret =3D sysfs_emit(buf, "%s\n", nt->np.dev_name);
> > +     rtnl_unlock();
> > +     dynamic_netconsole_mutex_unlock();
> > +
> > +     return ret;
> >   }
>
> Please do not add rtnl_lock() in a _show() sysfs handler unless there is
> no other way?
>
> Something like:
>
>      dynamic_netconsole_mutex_lock();
>      strscpy(name, nt->np.dev_name, sizeof(name));
>      if (nt->state =3D=3D STATE_ENABLED) {
>          struct net_device *dev =3D nt->np.dev;
>
>          if (dev)
>              netdev_copy_name(dev, name);

This could lead to a use-after-free if we race with NETDEV_UNREGISTER
and 'dev' gets freed. It is the same issue I'm trying to fix in [1].
Claude suggested adding an rcu_read_lock(). Since
unregister_netdevice_many_notify() calls synchronize_rcu(), it is
guaranteed that the net_device won't be freed until the grace period
finishes.
Something like:

  dynamic_netconsole_mutex_lock();
  strscpy(name, nt->np.dev_name, sizeof(name));
  rcu_read_lock();
  dev =3D READ_ONCE(nt->np.dev);
  if (nt->state =3D=3D STATE_ENABLED && dev)
        netdev_copy_name(dev, name);
  rcu_read_unlock();
  dynamic_netconsole_mutex_unlock();
  return sysfs_emit(buf, "%s\n", name);

Also, netdev_copy_name is not an exported symbol, I would have to
EXPORT_SYMBOL(netdev_copy_name).

Would something like this be acceptable?

I can try and apply the same RCU approach to [1]. We don't have a
similar seqlock for dev_addr though, does it make sense to create one?

[1] https://lore.kernel.org/all/20261006-netcons-fixes-v2-2-ca652d55fd4a@gm=
ail.com
