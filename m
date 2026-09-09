Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360BA2D2394
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 04:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788927169; cv=pass; b=uTwSE3V7vu5hxxF+BJEUK6kQ7BoHXnrG7hgpm7fsGlgTUsrckNa3sd4LfiyDfLkPI1QQeAGJjck2myHGBXLaHf0mJoDJ5/5QtMKWjbiwGRbdQHy51faEmUwCEncHVNt9ZHL8ta0pmwsLxQ94XcObvzSo14MfLi3oi/DYf09P39Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788927169; c=relaxed/simple;
	bh=62fQLDpFWuLBnxx2oFAOvQha4xLN5/L9fB9c9ZF1+p0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d7mXzfR1nI4UjjsD34xOJjuAkn2e9CtMsV3f3GfF5GNCYTDPbg5ZokWabVlNLTaxR2BgUZ51ICaWj4BYb8mkOnRHsrnOU+ZpkNYPLbYZh0p3pkQkb9Wh9jLunRNrb62TdMpyCORwxiexNuNZpA76JoTvd1sNpmvFTkovaAUtGFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RDMsudvY; arc=pass smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RDMsudvY"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7f48c750afcso4584947a34.0
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 21:12:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788927167; cv=none;
        d=google.com; s=arc-20260327;
        b=lo6B5Da/jQDJpgYxgTX9VzFDi/Rp6j9wy9gZZkHei9w98nDHSIcsZfvdY57WrioZaL
         Sy35pqMOVD7UXXnzR7RFBX3lTLmQ1lKt75UtehvqijsJtm0iVjfxCYFnYFWW8M1G+IDK
         Vt5jA07IyhNgG1vvyD6y2GpECJcNePFMTai4JgICrdDOHER6jppoh7S12agcCV2Bd+hB
         UwaOAo+CNxCdpbRIOo1648XG78rfovJfkl6nd8YrO2e6U+IrMYh8yH6XMFV5Xt1Emj2i
         YA1Y/HkHzIaZc6Go2uLjJJEnmbaQ6LLOUYun+95YYycy/ioB6QgR6WG23IyxrZlDSS3B
         1+3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nerhATOGIIVSAUpKaZiynm48wnmbtVvOZozN7F/qa0I=;
        fh=1zYs0idIbCfzJB5XQTGxdDwU6Uh1PF/XF5acOM4TrZo=;
        b=HS/i65fAq3E7CWotk5VboopYY5I/UE6uLb+AACtogbbGfxKnjcCevZAVXLX+WTHNV+
         oYyfVVfEZ2ZazzvBcaFM0KOPAFdUlgHmCGQg7a2HHKYqEepkQXk2SbXZnmtMwSNNRV09
         /cRKoUYvSS4Si2lpAHQcLdoq+6wf7bSc/Ly3fEOkGqk9sh8BeLLH3FvGHlclnGTtsji9
         kik6x2yZMVT2XNuLw3LKKYWpUw522k1Bt8IoNCYMfQHGmfkfGTOgkvs/4tx9++zyunHV
         YQM0ZsSIt3e459jce2j7XiIBHbsgVxb8QUr3tv0Mj7XhxbiXWeAQaG717zOvyVcIt+dy
         R26Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788927167; x=1789531967; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nerhATOGIIVSAUpKaZiynm48wnmbtVvOZozN7F/qa0I=;
        b=RDMsudvY/A1iYsg9bXuUrJV08ocrJ/rJ81blr7FpCdxJEnSG7oZx2PWMQcz7t8rMLi
         D+++BrZdli/5q9XKdK/o7GtANufwXjbasCXSVdfjUpwRJAsTId9HgsPJsQkMHpeeVYXT
         Rinh1pYtlUM4ah7JEjmmjQ0ajeBYozvoBrEvMBreECt/MY3jHOTni/VBk06xWQrIMOsB
         uHkDkxwBvJjTYxKoPhaxSqp0DPg3D13lXS1liw05rljiXOEzfw2bBJvAs8naiml2vIYT
         IGidtQO+vJi9qyIivko/BtbQQbGk85WZjc7tO/opBVVkqT9mcJ7w/jIRrkoyeLLC4bOB
         Z7MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788927167; x=1789531967;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nerhATOGIIVSAUpKaZiynm48wnmbtVvOZozN7F/qa0I=;
        b=hfqW/vz16Sc2TQRcHNzSW4rScbPk7fc/wUtlmbQLE6XTZ9FBbGHJyjw4nbDPzVJ+eV
         GFHIB6ZLNlAziFbgtP/iCJGhzhsCgcsWQpZduzduUKPDNeSYMGoz1AjPQuxWYyetlHR+
         D0vj0cbJNMp6kp6gfhnlCD8lyEvC29H+SPaS5LZ+xqlzHIP9BYGDaLmzWNK5euHk6zMs
         UuE+hv48T+6wihaR4jhOGfNV9XkW6PnGF8QGCmzQZYDW43RXluRoatNtadh9L2uRnfq8
         YhRnGA3XtQdygihjLDbcJs7o01ux0kXrD0OuSY0JlfxFQRKOE9ZXBxJ1WlAerwdSxEMz
         un9w==
X-Forwarded-Encrypted: i=1; AKwUvByHflQ1Z79KJJC9vzPnrlG01N//thRCXGFHOPXSTUb+gRdbNh9vNFmVKw0YCEHs5FBHPbdMuo0=@vger.kernel.org
X-Gm-Message-State: AFuF++m70PZ4OAF8W715i+v22PmAhkLna7j3AAmbqYYi1S8ekJZuArYT
	SC66B9WC9eTzyxix0wrB72Y9cirLG819IVRySJDcBV7q6fS1LgGbSjq0N0O8Bi1yITZNInFs/x1
	8NDDzeFCnhXdc38rR9QtvvQTODGviewXpWUtCSkSH
X-Gm-Gg: AYBFou17Yq4p07wS4QDhdaRje2QaXxC464uwLp9iO6XX8zYA4bsV3s4q1/7GKyy5XFC
	TcR8HQExgPyVbmZkH2xYpQp833t2sZrvy4o6Ux8swUM6gRattdK4ojYIc/le9wTYaQQfr3196ji
	hx85492HiECyzylEAVI259PTkgwG44fqqsPf6QnZkOYI7n+g6ZChrk5ofHJjJy/SCVKMCqQGdbN
	YVJHRNrjTQY+0HSmM2rxe0N/csSwKuj2HEQ9oIekGDTJIPX2ep5S8du24k4eDBJeZ2VApHELKxv
	vkBi0awdbeQeHXCp/aHF2kPoSEyodhjO8M6WQgUVZOKUW4Cfcw9neGb2nM4LLmrQDXScOT/xb+b
	mhsHE6mgB7w9vF9kl6ar47PzGciyVpGxixo0lNSFbp7njjh3N9BSQpXj7tBRVV4ipJKQ=
X-Received: by 2002:a05:6820:a06:b0:6bd:a88f:c8cb with SMTP id
 006d021491bc7-6bda88fcd26mr2797865eaf.6.1788927166196; Tue, 08 Sep 2026
 21:12:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907225846.3787676-8-kuniyu@google.com> <178891912177.219967.15134714866444953265@kernel.org>
In-Reply-To: <178891912177.219967.15134714866444953265@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 8 Sep 2026 21:12:34 -0700
X-Gm-Features: AcwNN1X4HvvzCzRMa7mYdIeTvVeV0My0QiaS6VwcrHDGFy6h2JuCFvcSGO4i7hY
Message-ID: <CAAVpQUAPFgGpzwKYhjFcuQ-hTGFw6aK2WFoG_9yF0WR0jFHGVA@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 7/7] ip_tunnel: Support per-netns device unregistration.
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, idosch@nvidia.com, horms@kernel.org, 
	steffen.klassert@secunet.com, herbert@gondor.apana.org.au, kuni1840@gmail.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 6:58=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wrot=
e:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 =C2=B7 Low: 0
>
> - [High] ip_tunnel_ctl()'s SIOCADDTUNNEL arm can register a brand-new
>   netdevice into, and re-hash a tunnel in, an ip_tunnel_net that=E2=80=A6
>
> --
>
> ip_tunnel: Support per-netns device unregistration.
>
> This switches __ip_tunnel_dellink() to unregister_netdevice_queue_net() s=
o
> ip_tunnel devices living in a different netns than the dying link_net are
> queued per-netns, and adds an ip_tunnel_unregistering() guard to the
> SIOCCHGTUNNEL and SIOCDELTUNNEL arms of ip_tunnel_ctl(), to
> ip_tunnel_dellink() and to ip_tunnel_changelink().
>
> > diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
> > index 9ad63f1af37a6..051d7fd689029 100644
> > --- a/net/ipv4/ip_tunnel.c
> > +++ b/net/ipv4/ip_tunnel.c
>
> [ ... ]
>
> > @@ -895,20 +900,22 @@ static void ip_tunnel_update(struct ip_tunnel_net=
 *itn,
> >       netdev_state_change(dev);
> >  }
> >
> > -static void __ip_tunnel_dellink(struct net_device *dev, struct list_he=
ad *head)
> > +static void __ip_tunnel_dellink(struct net *net, struct net_device *de=
v,
> > +                             struct list_head *head)
> >  {
> >       struct ip_tunnel *tunnel =3D netdev_priv(dev);
> >       struct ip_tunnel_net *itn;
> >
> >       itn =3D net_generic(tunnel->net, tunnel->ip_tnl_net_id);
> >       ip_tunnel_del(itn, tunnel);
> > -     unregister_netdevice_queue(dev, head);
> > +     unregister_netdevice_queue_net(net, dev, head);
> >  }
> >
> >  int ip_tunnel_ctl(struct net_device *dev, struct ip_tunnel_parm_kern *=
p,
> >                 int cmd)
> >  {
> >       struct ip_tunnel *t =3D netdev_priv(dev);
> > +     struct net *orig_net =3D dev_net(dev);
> >       struct ip_tunnel_net *itn;
> >       LIST_HEAD(dev_kill_list);
> >       struct net *net =3D t->net;
> > @@ -979,7 +986,7 @@ int ip_tunnel_ctl(struct net_device *dev, struct ip=
_tunnel_parm_kern *p,
> >                       }
> >               }
> >
> > -             if (t) {
> > +             if (t && !ip_tunnel_unregistering(t)) {
> >                       err =3D 0;
> >                       ip_tunnel_update(itn, t, dev, p, true, 0);
> >               } else {
>
> [Severity: High]
> The SIOCCHGTUNNEL arm now consults ip_tunnel_unregistering(), and so do
> SIOCDELTUNNEL, ip_tunnel_dellink() and ip_tunnel_changelink().  Should th=
e
> creation arm just above in ip_tunnel_ctl() get an equivalent check?

No, ip_tunnel_find() is called under the mutex, so
"t && ip_tunnel_unregistering(t)" never happens.


> It is
> the only path that mutates itn and registers a device with no liveness te=
st:
>
> net/ipv4/ip_tunnel.c:ip_tunnel_ctl() {
>         ...
>         itn =3D net_generic(net, t->ip_tnl_net_id);   /* net =3D=3D t->ne=
t */
>         ...
>                 t =3D ip_tunnel_find(itn, p, itn->type);
>
>                 if (cmd =3D=3D SIOCADDTUNNEL) {
>                         if (!t) {
>                                 t =3D ip_tunnel_create(net, itn, p);
>         ...
> }
>
> ip_tunnel_create() -> __ip_tunnel_create() does dev_net_set(dev, net) plu=
s
> register_netdevice(), then ip_tunnel_add(itn, nt) re-populates the hash.
>
> Can that happen after ip_tunnel_delete_net() has already made its final
> pass over the same itn?

Good point, ip_tunnel_ctl() needs to check !itn->fb_tunnel_dev
or maybe_get_net().

---
pw-bot: cr


> With CONFIG_DEBUG_NET_SMALL_RTNL=3Dy, this is the
> sequence the commit message itself demonstrates with gre1:
>
> cleanup_net()
>   ops_undo_list() -> ipgre_exit_rtnl(ns2)
>     ip_tunnel_delete_net(ns2)
>       WRITE_ONCE(itn->fb_tunnel_dev, NULL);
>       __ip_tunnel_dellink(ns2, gre1, head)
>         unregister_netdevice_queue_net(ns2, gre1, head)
>
> Since dev_net(gre1) is ns1 and not ns2, unregister_netdevice_queue_net()
> only queues the device:
>
> net/core/dev.c:unregister_netdevice_queue_net() {
>         ...
>         list_add_tail(&dev->unreg_list_net, &net->dev_unreg_head);
>         rtnl_net_queue_work(net);
>         ...
> }
>
> so gre1 stays registered after ops_exit_rtnl_list() drops RTNL, exactly a=
s
> the bpftrace output shows (gre1 is torn down later from
> rtnl_net_work_func).  While it is still registered, an ioctl in ns1 can
> reach ip_tunnel_ctl(gre1, p, SIOCADDTUNNEL) holding only
> rtnl_net_lock(ns1):
>
> dev_ioctl() -> dev_ifsioc() -> dev_siocdevprivate()
>   -> ip_tunnel_siocdevprivate() -> ndo_tunnel_ctl -> ip_tunnel_ctl()
>
> ip_tunnel_ctl() then uses net =3D t->net =3D ns2 and itn =3D net_generic(=
ns2, id),
> the itn that was just drained.  ip_tunnel_find() returns NULL on the empt=
y
> hash, so a new device is registered into ns2 and hashed into that itn.
>
> Does anything reclaim that device afterwards?  The last sweep of ns2's
> device list is in default_device_exit_batch():
>
> net/core/dev.c:default_device_exit_batch() {
>         ...
>         unregister_netdevice_many(&dev_kill_list);
>         rtnl_unlock();
>
>         rtnl_net_flush_workqueue();
>         ...
> }
>
> The scan and rtnl_unlock() precede rtnl_net_flush_workqueue(), and gre1's
> unregistration is still pending at that point, so an ioctl winning RTNL i=
n
> that gap can create a device in ns2 after the final sweep.  ops_free_list=
()
> would then kfree() ns2's ip_tunnel_net while the new tunnel is hashed in
> it, and cleanup_net() would free ns2's net->gen and struct net while a
> registered netdevice still points at them through dev_net()/dev_list, sin=
ce
> netdevices hold no netns reference.
>
> The per-tunnel guard added here, hlist_unhashed(&t->hash_node), cannot
> cover a tunnel that does not exist yet.  Would a separate "this itn is
> dying" test work here, for instance keying off the marker
> ip_tunnel_delete_net() already publishes with
> WRITE_ONCE(itn->fb_tunnel_dev, NULL)?
>
> [ ... ]
>
> > @@ -1194,7 +1204,7 @@ void ip_tunnel_delete_net(struct net *net, unsign=
ed int id,
> >               struct ip_tunnel *t;
> >
> >               hlist_for_each_entry_safe(t, n, thead, hash_node)
> > -                     __ip_tunnel_dellink(t->dev, head);
> > +                     __ip_tunnel_dellink(net, t->dev, head);
> >       }
> >
> >       mutex_unlock(&itn->tunnels_lock);
>
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20260907225846.3787676-1-kuniyu%40google.com
