Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AC541A914
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 20:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791577186; cv=pass; b=BxL17DFAH5EqtnNOTS2x0KFviesgBZdQ/+7aGunwNiqdARQaeHcdqePWGp8OmgPXrilaw0L/SoZNzStWnKYHGwM9NjLAr3hjxSaU6TbWJsZvqSh7oQ8spcbLEbyTgqK8T/qLaB5jKznj1QCAHEa5YKpJsGY7D3wk0EvN3Y4S5Oo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791577186; c=relaxed/simple;
	bh=LHuM++ypPRN/csYCm9wgjToWu2NKVwtNFtTg8nsZAHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DiuLSN+aVntlNSCAwW5tCCHJzSXr2eS1kd/kDrfyqcDzAo04nJGWVZp0Lhu6LGnzZLvuiAlvaQy0KNKkSn1GQrjT/93lvd58J6YiqHAZ2fX9zmerDjP/wg3W7mAqVSZ/mI6WnQrgvU4Y9sFpiVTh0LFdjUc+rxiauoQMFv++xg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kiYR0zZ+; arc=pass smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kiYR0zZ+"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-823ad2ea407so25969a34.2
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 13:19:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791577184; cv=none;
        d=google.com; s=arc-20260327;
        b=LLr7SzORveLqlm88/uG8O3XIw1XV8CsatIshloMk9BbOkxJBdsk00KuoCnTGYpKgkQ
         IiwzDrjBn3U/FnbAmKAi+UoQwntfrW15AndY14m7U5D6FF6yJIk40+Hihn0X/5fbOpiM
         vKjSXHWCJ0nWxBB3SUa92KusCdpsixkhRlmI2KWxuO7WGJJx9Cu43wHxuly/Kykw1lVr
         bZB0+ZvQYj7uCpMNWqQqiTfWOChJRop78oWG9y/bKSYBCsc/ELy1ITu6qvdbo/CIWCqb
         k098TR9Ynzvt/jLQuRnZBS1ZG944JMoYNvsN5z7IP5dZZ2msZ6ZA2bl3boZ5Jw8QYX1n
         QYHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DZTn6/Lz8nRVlXVjhpKVoP1fGQxBATGcsrbeLxvH18U=;
        fh=Zz6epJ2MZIX1mit6lKs9z9/qJxw72dxEvBVakE2PWsg=;
        b=W+dDsGHLZWNWfmIjdRQ/bjPN5ePEDA6cb7cLQoGDIBFORA2/ZRQERftzJ3eY2B6RuB
         wnw49olXb/HxuX4D+o4MPZIDciQi5Q6kFe3Eggu/4pJ8JAvOt0xCztQoaASfIPePMlGD
         VwrmNQb/HLHf58GuGbmDeKG19V9+nfAxJaZmBW6o0zA3DHOoTOKDrYYlPdA+WqwwskWq
         Q1MMKYW7gCi7/NM4yBcZK2Qx1M1wxRkPnX3ibwCVHWUTohLkkWdRcR+UqCfin+H7oEG6
         JBdrBH2pshzam46UMbcc2Q67Fp+4248Xcg/6m33TjPU7eYVxljGLmFOZUily+3Eumfd+
         4P0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791577184; x=1792181984; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DZTn6/Lz8nRVlXVjhpKVoP1fGQxBATGcsrbeLxvH18U=;
        b=kiYR0zZ+PTk+IzW0qMwg6RwQzbSXSqpPY+c5oD+mGrn2Ea6eEqIPB3zTafK5tJo0Cz
         a/y9bK6uoZY1t0trc/sV4e1E7bC3Ymk7t/ibPK2MoyrnS6CqF9DwXPEjs0lIZu/1dtn8
         dPHfz8rkuvt1SAw9FvORGfhM/6DmztEAmfdKdx7RuDsGArUqivC9DvOcXOazIR/m4xJw
         ykSXpIuRlDlgTmmVSeywNYSw0OhCVHPlDw/lMLh0B0L3wxrXZ4HymXY3zduAo8StcEtM
         yE8/6ga0n0JM9BoEak+EPrvK+v6+bQkpX+XpVN8dOkM+bBzmI/z7WRhP65KlsXM/63PO
         Tw9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791577184; x=1792181984;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DZTn6/Lz8nRVlXVjhpKVoP1fGQxBATGcsrbeLxvH18U=;
        b=cKx16KEXhQvtbOfLRlOPxcOZrSYYJKNIq7Fp1Un5SG6ZZXBtBb9BwvUc1cGLk4gFBW
         78ow10UtRuKtzUPCSKrUxNbFpJVhYvcB4qDgpw7vhQIUx/38gnM81u7bIVJi9LlQmSxu
         aGmh+nNke+gmuAQ776F2JIeKNe7QmD456q4EnbX9ya//T+lsa401xKYfyV7gU7qNNy/j
         VPpTtsiL/u/AlWfkyU2oqS5wLp+IQj3ExNI7jHFlPuxS5goQpFsMU6qw5RPYslstbIvj
         mouV9hZu7m3ERJTrpLlAEJc8Bgv3Tb07nWD061NaOUjVpje3P7Q21v2K6vQcOfeu3fYE
         mp+w==
X-Forwarded-Encrypted: i=1; AKwUvBxwIixdDzsibcA611WBFKEvPYOvlcfGyg8UTWddk+HNP/yD4JxTV2syBr+7kl5oGZ9/FtMoteA=@vger.kernel.org
X-Gm-Message-State: AFuF++nVmaf3yqsJEvHHYITIjj342wza3BDBc67qiHXkAjauw2WUkCvq
	NXPK/1Zgi6L/yI+80SKfJhzd7sRTmcOAOAgz8EIQgwqevN+8mpA6wUft7Hb8RvvtF1eox7S+Q9K
	e4J06tBY2SHohH9n93FYJfP12au5Qi3M=
X-Gm-Gg: AYBFou1B4HstpEJfFK2fk7DXJEKpI13wcIAZ7Z5m/cpMrGX77JTOCYCgSHYYfm7GZ+D
	nq1CcCDPn3/JIzDUXLBhiJ0+7fHG3LIOcp7lsSiBO5ahIahuLp2ankpS2FUesRRIOTioVE2lPRl
	MArP/JXGdXXd4WvJY2ktwM7q71mG0HS3X9XKx3yCA3pNNT/H10fb33PfrLZIAbUJyt6QOTCOGlZ
	9IU5toho9Mtb81t8Lmnyy+uMV2WyGpO54hsLjjgOpIAeFJ4gLEuf/r4dlgze2wjIQxeQ+EITPDX
	dlAXzndmtCNPTRwb3WX6jSoA2ONrCs610ja7dZkf79EOF4p/v+SjWPIeOMSA+osWmylvdNU=
X-Received: by 2002:a05:6808:1825:b0:4c5:90f1:b9c3 with SMTP id
 5614622812f47-50c438a90cdmr3433845b6e.2.1791577183759; Fri, 09 Oct 2026
 13:19:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261006-netcons-fixes-next-v1-0-231cd26f8c51@gmail.com>
 <20261006-netcons-fixes-next-v1-1-231cd26f8c51@gmail.com> <afc14b81-32b3-4f91-8b0c-0152889f80f6@kernel.org>
 <CAGSyskUE2CM_i_+o2Dtf+_OriRyad+UzG4S-rzOeTL18LnZheQ@mail.gmail.com> <asjfY79OetvGy4an@gmail.com>
In-Reply-To: <asjfY79OetvGy4an@gmail.com>
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Fri, 9 Oct 2026 21:19:32 +0100
X-Gm-Features: AclHuK_SmouqZ8gGRicUCLxC1nVPC-Rfbwhq_vDqzm_DMop0yNSTGIcelyt7RXc
Message-ID: <CAGSyskWLdTJ-QSeys=_42wuOYbPJz-=0ySHW6hqmPdvHcmuqag@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] netconsole: avoid printing partially updated
 target attributes
To: Breno Leitao <leitao@debian.org>
Cc: Eric Dumazet <edumazet@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sashiko <netdev-bot+sashiko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 9, 2026 at 1:35=E2=80=AFPM Breno Leitao <leitao@debian.org> wro=
te:
>
> On Thu, Oct 08, 2026 at 08:55:40PM +0100, Gustavo Luiz Duarte wrote:
> > Hi Eric, thanks for the review!
> >
> > On Tue, Oct 6, 2026 at 9:35=E2=80=AFPM Eric Dumazet <edumazet@kernel.or=
g> wrote:
> > >
> > >
> > >
> > > On 10/6/26 20:58, Gustavo Luiz Duarte wrote:
> > > > The configfs store callbacks all serialize on dynamic_netconsole_mu=
tex
> > > > but not on the read side, so reading an attribute while it is being
> > > > written returns a partially updated value.
> > > >
> > > > Hold dynamic_netconsole_mutex on *_show() callbacks to avoid racing=
 with
> > > > writers.
> > > >
> > > > The dev_name_show() callback can also race with
> > > > netconsole_netdev_event() writing to np.dev_name due to
> > > > NETDEV_CHANGENAME. So it needs to hold RTNL in addition to
> > > > dynamic_netconsole_mutex.
> > > >
> > > > Reported-by: Sashiko <netdev-bot+sashiko@kernel.org>
> > > > Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/2026081=
4-netcons_ipv6-v3-7-bc0915e8c75f@gmail.com
> > > > Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/2026092=
8-netcons-fixes-v1-0-bb5ffe5e698a%40gmail.com
> > > > Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
> > > > ---
> > > >   drivers/net/netconsole.c | 62 +++++++++++++++++++++++++++++++++++=
++++---------
> > > >   1 file changed, 51 insertions(+), 11 deletions(-)
> > > >
> > > > diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> > > > index 267254f046de..188beacb308d 100644
> > > > --- a/drivers/net/netconsole.c
> > > > +++ b/drivers/net/netconsole.c
> > > > @@ -859,7 +859,19 @@ static ssize_t release_show(struct config_item=
 *item, char *buf)
> > > >
> > > >   static ssize_t dev_name_show(struct config_item *item, char *buf)
> > > >   {
> > > > -     return sysfs_emit(buf, "%s\n", to_target(item)->np.dev_name);
> > > > +     struct netconsole_target *nt =3D to_target(item);
> > > > +     int ret;
> > > > +
> > > > +     dynamic_netconsole_mutex_lock();
> > > > +     /* Hold RTNL to prevent racing against netconsole_netdev_even=
t()
> > > > +      * changing np.dev_name.
> > > > +      */
> > > > +     rtnl_lock();
> > > > +     ret =3D sysfs_emit(buf, "%s\n", nt->np.dev_name);
> > > > +     rtnl_unlock();
> > > > +     dynamic_netconsole_mutex_unlock();
> > > > +
> > > > +     return ret;
> > > >   }
> > >
> > > Please do not add rtnl_lock() in a _show() sysfs handler unless there=
 is
> > > no other way?
> > >
> > > Something like:
> > >
> > >      dynamic_netconsole_mutex_lock();
> > >      strscpy(name, nt->np.dev_name, sizeof(name));
> > >      if (nt->state =3D=3D STATE_ENABLED) {
> > >          struct net_device *dev =3D nt->np.dev;
> > >
> > >          if (dev)
> > >              netdev_copy_name(dev, name);
> >
> > This could lead to a use-after-free if we race with NETDEV_UNREGISTER
> > and 'dev' gets freed.
>
> Any chance you can get the lock (either dynamic_netconsole_mutex or
> target_list_lock) in netdev notifiers, so, it doens't conflict with this
> one?

We can sidestep the device teardown entirely if we just stick to
np->dev_name and protect it with target_list_lock which is held in
netconsole_netdev_event() while handling NETDEV_CHANGENAME:

  dynamic_netconsole_mutex_lock();
  spin_lock_irqsave(&target_list_lock, flags);
  ret =3D sysfs_emit(buf, "%s\n", nt->np.dev_name);
  spin_unlock_irqrestore(&target_list_lock, flags);
  dynamic_netconsole_mutex_unlock();

The local_mac_show() case is not as simple because we don't keep a
copy of dev_addr, but we can couple target_list_lock with nt->state =3D=3D
STATE_ENABLED, which ensures the target is not queued for cleanup so
the device won't be freed from under us.

I will send a new revision for this and for local_mac_show() using
target_list_lock.
