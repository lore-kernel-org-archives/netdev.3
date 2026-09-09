Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2122BB13
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 04:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788927235; cv=pass; b=djqph/0beiuIZYv1LXFN5dNd2zLOb5vfQpYq6C3uUHotMxoM6kuGsMqh8tEJeDsdAC/9saVJe1FfmRvfnhAd9BssVp3qrrZidCvqn2B0ToNxXdjCR0OD6WRsgexifBKEfND8Hv0KgjabbwTPHVQIy1C+1VMrgKd8xwU8K0E/q2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788927235; c=relaxed/simple;
	bh=9v7dLvyOJNBAsde7TO81Ja7O7elFrUcQkQNj8CnuAe4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LiD/YI7rhaJwckvqi8rxTxbmAWJ4pUq13C3F2JZL9fmTtl542hNB/4gt1g5ERIX3+uGbahg09Iz+WVTAvOyjJ4mjesZkqi8EI4H4BUUO4k7Gwl2h+bv5LbrRHq6n4yKMYjbxjf14SewKbIkqcV7U/uK+TJFO1lLRrRDR0YjZ/HY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MB5+Cura; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MB5+Cura"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d9db539a54so47716005ad.0
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 21:13:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788927234; cv=none;
        d=google.com; s=arc-20260327;
        b=eUVSMqd7I4iPqNfwAVAwVyQfUhuIMwCW1937kSEvLTotYj1OCdKDwvhA/XGfO0b0yv
         mhXsZwnGpb8iwPg1RHI7kco53O0ukPRs0F81o/4o//lGfVMwnAA/CKqcXlf4G0xjamM+
         q42tdLZfY5/rtk5pHs4KeOzbv9nJ/tXpbQHOmLls7Wd57rzb3rvJ4uIWpxtl+gW2swsR
         GieJ7koOqiqv4GrqKYacrvQXsVRS/mQ//K0qX2cBKlpD8knMeTJYrZjaHfp69/loadap
         yzr2NOZo6tNOGbB+fIsI6izjPZnqt3NvP1LvqGER1sozV/a/yZQOaJBTgBhdYpCrufb2
         t3mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Bl91wg/yGgEZh0K4fEYbtb7VRvcFObBtiBN/Kbq4nbA=;
        fh=+b9sRF3ztW92RvXoc9p+GALGO4WyXWsd8ALXSKTYFT8=;
        b=q54eN4o10N8rJpGNpp/Z86DHkZXm0eR4+vTD2+yQ7chg3QINfMAvSPe7BtOXB3n38Z
         FveR/pU04ECQOW7YWR55sW5tq72jNma9+bXr1xDeJFwwxBMVQD5Cwzj98RnoxmE1H29P
         Z4bVk+oWHvlP0IK4tXlhK2VLM4NytQEW5YkKSrDdZ32SxyRvkPDa+4X7seIxgsgAEuOv
         TFBddtsv97p0RlTp1pEy5XSPc436GcXDBcuMHza1vyX+64JM5i1062FGmYppyL0r/Jv3
         vPjIzx9KxniXHEu4v5KDayVZAYYuVIaNFQu/WUEyhOG6Ucq/0GcGY3kTkK5cAbSQZKbC
         n7/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788927234; x=1789532034; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Bl91wg/yGgEZh0K4fEYbtb7VRvcFObBtiBN/Kbq4nbA=;
        b=MB5+CuraMjtDj6cTw8UoPAT4Oaq+gCUMsmlyKsdCHQEBxQIaoxGGfxOKwury65lLHK
         dSuVOQmC8+/shH6aMkcdSpEhx3AG5yZYaTxt535YwoLH+R/Iwt07vYbblrNxmHjas0rA
         plsWoVqIlyHufawRy7QsFD4ijq2zfkJk1Impx1xvHk4aDSC/BUbyXtA5Ldv2LjV3En03
         MhNHVcfZlZ46b/WT/C1bpvRxSSsu2u+J7i4RfWxTyeV9GdANmwaZNEXdhaKoLRx1pX1A
         gW2rMEFjXVRqbivJcJr2ZbmQxnw0TvarECN3GQ0eRTVYaUxOI1CVIw0CyO7DJMr6hGID
         ewFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788927234; x=1789532034;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bl91wg/yGgEZh0K4fEYbtb7VRvcFObBtiBN/Kbq4nbA=;
        b=VkroIwVQ9Twl0X4RR0pPFsCTGrTAJYmYl/6T9v6EVgunw/hPEGibbO0weQp/2FvYnp
         drsXBQZFGQu9aOhOHQr1qo45EIb61rQl2Z+BTp8/zpD7sHn7Qrcu5HT4oj8/tIPA8/1i
         bi5hOolzVgrlCoEgxMBSqsBB/gYWzmBncm/hyBkUmHpIQJPtrJleh26sGDaNOeXmgZE6
         4g9y6ZYBY2TbHG/J791XbCjm4deRKJowyn1qpFd/tAHE32ztMKbN9KFVoRNARaV1RomP
         xO1jsHewtVGHGz5p+7JAq6iO17lyWPm1qSQfCa6TS2oTeBzaviVrJ6PXvJsbH4wFNWXq
         pqrA==
X-Forwarded-Encrypted: i=1; AKwUvByh7UvQLi+DMbrN39B6InNJJN5VmZahVgsrbQsxTJMTpxqX9LEynKBCaPSE6YlBVVQJ9VYTpXA=@vger.kernel.org
X-Gm-Message-State: AFuF++mQZdyWbHTSHEKZ0zpb9mbFqPxEu3aAFFMPUdWgEVehpVVPrUi2
	130HryeZk9lstRQ3UsfiufTfd7aNp3BQuflkwWbx32LUGJeyY25PfebjKd4Xae8Ddj6alNq00vZ
	BOB+oeFnLcsx7Tch/rzEbhyDy7JONTaKZDWdXicBx
X-Gm-Gg: AYBFou28qPZrZScpSUmjBtmCUW3x77Fr44LDk91Z7MEn/NoQmO73dYC2nohPKM2nNgR
	NUjIkxKqi/xwHwX3YkHV7w3n3trv8POUyU9GZS/k/36ep/2GphntfgZlyQu7uVbFZI3bJ8maRQ3
	yaSzE2FVzxGbGskCGMZ43ypfl0N76fVLGry69yIo2zYv2WzCMg+D5WtxmFBZAvu4AXNB5a7FLia
	HVHDnuWjORsxs878lhBHp42Sa5iw9qFRPPX5Scd3ZvpaG8gdxO9Sqv9OfoNXcqArUB/LlXCg2vG
	GtF5dNhtQa6aFxk3BxE7cO1TkdAOvEmQzipzN5PeTAG31EkWrRFr8C3/PV/vBtt5lJL9Y/oE3zn
	jaKDVIp76EGgpFs1eXr4RZI9zfvryYUKNTDNn90LRZ7xtL+ciyCSlpxAQuGqTs6eGXMs=
X-Received: by 2002:a17:90a:149:b0:39b:2b10:d05c with SMTP id
 98e67ed59e1d1-39b2b115ba1mr34345615a91.5.1788927232913; Tue, 08 Sep 2026
 21:13:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907225846.3787676-2-kuniyu@google.com> <178891911928.219967.7580029616723211694@kernel.org>
In-Reply-To: <178891911928.219967.7580029616723211694@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 8 Sep 2026 21:13:40 -0700
X-Gm-Features: AcwNN1Wx9NiFzLv4O-MvEfmRZLjm_TaF-8bvIr6n03tgItHgaD-evtLsKAE7aYQ
Message-ID: <CAAVpQUDUg2rbw161gF8XmBPLCE7S10UxMoT+m5dmjU==ZDx6uA@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 1/7] ipmr: Call ->dellink() to remove DVMRP
 tunnel device.
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
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 0 =C2=B7 Low: 1
>
> - [Low] The commit message of "ipmr: Call ->dellink() to remove DVMRP
>   tunnel device." states the rationale inverted: "This is fine because=E2=
=80=A6
>
> --
>
> ipmr: Call ->dellink() to remove DVMRP tunnel device.
>
> The patch converts the two places in net/ipv4/ipmr.c that removed DVMRP
> tunnel devices with unregister_netdevice()/unregister_netdevice_queue()
> into calls to the device's ->dellink() followed by unregistration, in
> preparation for moving ip_tunnel_del() from ip_tunnel_uninit() to
> ip_tunnel_dellink().
>
> > ipmr.c uses unregister_netdevice() to remove DVMRP tunnel devices
> > created in ipmr_new_tunnel().
> >
> > This is fine because currently ipip_link_ops.dellink() is no-op
> > for non-fallback tunnel devices.
>
> [Severity: Low]
> Is this sentence inverted?

Oh right, will update the commit mesasge.


>  ipip_link_ops sets .dellink =3D ip_tunnel_dellink,
> and that function looks like this:
>
> net/ipv4/ip_tunnel.c:ip_tunnel_dellink() {
>         itn =3D net_generic(tunnel->net, tunnel->ip_tnl_net_id);
>
>         if (itn->fb_tunnel_dev !=3D dev) {
>                 ip_tunnel_del(itn, netdev_priv(dev));
>                 unregister_netdevice_queue(dev, head);
>         }
> }
>
> So it does real work (unhash plus queue unregister) for non-fallback
> devices, and is a no-op only for the fallback device (itn->fb_tunnel_dev)=
.
>
> The dvmrp%d devices ipmr creates go through tunl0's
> ndo_tunnel_ctl(SIOCADDTUNNEL) -> ip_tunnel_create -> ip_tunnel_add, so
> they are non-fallback and hashed in itn->tunnels[].
>
> Isn't the reason the current unregister_netdevice() calls in ipmr.c are
> harmless instead that ip_tunnel_uninit(), which runs as ndo_uninit from
> the unregister path, also calls ip_tunnel_del()?
>
> net/ipv4/ip_tunnel.c:ip_tunnel_uninit() {
>         itn =3D net_generic(net, tunnel->ip_tnl_net_id);
>         ip_tunnel_del(itn, netdev_priv(dev));
>         ...
> }
>
> ip_tunnel_del() uses hlist_del_init_rcu(), so calling it from both
> ->dellink() and ndo_uninit is idempotent and this conversion is
> behaviour-preserving today.
>
> Could the message be reworded to cite ip_tunnel_uninit() rather than
> describing ->dellink() as a no-op for non-fallback devices?  As written i=
t
> suggests this preparatory patch has no interaction with ipmr, which is th=
e
> opposite of what the follow-up "ip_tunnel: Centralise ip_tunnel_del() to
> ip_tunnel_dellink()." depends on.  The code change itself looks fine, and
> dev->rtnl_link_ops is always set for ioctl-created tunnels by
> __ip_tunnel_create(), so the new ->dellink() dereferences in
> ipmr_new_tunnel() and vif_delete() cannot be NULL.
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20260907225846.3787676-1-kuniyu%40google.com
