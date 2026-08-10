Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E151049620
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 07:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786347613; cv=pass; b=Xtg++5n4PpZVtjc9T7sxIGg8sRzLNgOvpHo8skQpICjpUF55eKeyRAZCQwAJWLrpLUPGvUGgYUx10klvx9VKrnaIwm0gmD4hR8FpgoeoHVg5veji5UpH9L3Vz9yAoFejSMRHzQvkAvT6ortzW1mInCndjjghrBJKia19uCx4mzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786347613; c=relaxed/simple;
	bh=iuV34rsn6HpVxK3aaFQb95q9mvgoGsocunGrkQXo5u0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kqxq+xIIycd1GjAph/qgMhBPW/LWz7DDTolaOghzk71A9tD/YNUHLXuft4MksIm0JB86vLq78vu5JqPaYAXSon3Kbwh3g/X6AOMBAUo0wmzQ505T0m/Q5hQdgpsKadGG8jB4vhojQkcUOSH3OQZ7JMlZVqm9IV4MMq6rZqb3Obk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mkqdsatJ; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mkqdsatJ"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51c15a5b265so293731cf.0
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 00:40:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786347611; cv=none;
        d=google.com; s=arc-20260327;
        b=UvjLgKLASkeW+Pty+E9OCDiMEIgEga5ergpzU9JXEsd5UXBV+SdmO7VE63FXGbdFkl
         PC+vpjOT0XqaDLVPiNA/VLETAUn+pVAE71aEPQzQBT4dlN26Ap5Yty1Vsdn1ObDTn+6S
         FHTVxRzUo+n2JzM3QAbFl8Hbd+rCGUCgfwx6/XbiutJl5+RuGhGl8gLD5oPymGnCXNgC
         gnOudfSJi2BLHuHQt1x3l4PdEeubkIrks+WtBQgn2MoBn+8o4drDHbYAvMKj9Iab8lOX
         Qk17BuYJBpXFr57IjBKcHqhj1lkF8vzu26LqasLBz8/at88vwP7I/DSFmC62WwbnYtZX
         Qfvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xWEnc98/U16ZabgS11Z3nKVIko8ezoTwBqo/WFptwSg=;
        fh=ygR+ygqqmOFsf6DwwgFzWBkPlkERn7p8bPn79V+lfh0=;
        b=nuU5CYXUJegCjjQO0AT5lU/O2OQ7P/SY5GTSoMLS+NJxh9kx/W/S+F3iQGmWIwvI2+
         ecRUAsjPAjwHwQfuXnRYcQbPRADnkSZwp0G/v6hCAbsSeBndVEDZ+w3DNYp4Nsh8Lk3s
         IxIKi9v3BJxsdt70CCuFHxMup4P/umK95shW+16LNfN5GhQRUnrE25IMbR7yUfob1A9V
         taqTz7rYPMTgDrnu46W5iSPecaL+o+7gcTzzBZZX/TuBZN2u7xJ/OHKM97HQHoTk1kvH
         BJ81LXXqREWjwHGMCEeOhuZfPo+dvDVm2rKKkkOBPKFKpXQyq5wLk7lIOF7rP1txpWDq
         tKYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786347611; x=1786952411; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xWEnc98/U16ZabgS11Z3nKVIko8ezoTwBqo/WFptwSg=;
        b=mkqdsatJvcJUyU4ifGyXuUWbvi4Oy1NyIwmssluLiblA5cdtxDgvBqUn0DLEQjZN38
         kNOMJLqX1PEWlo8CXyY+tzW0/TqwbDhlVV7WbddyHzHX8t6bncENLQToFjaSDkbSxIGv
         oYOR0SsooYO6Z5uqVTOOT1Fl2bgd2bADlbpMqzJs80mu8o0XrhLTHQLcUY4g8XSoULrG
         +580za/bos5epHxVPZOzvk9ocqGar7MMQv/QMkdrJXkYzegkNDoJVZ/cdA0EVS6ln3gO
         ZAR0LRkcrX2IxMI/E2eT7rg/2DXbaxLr1AdlRarMBuoYVsFi3D4JlfUIro9xX45xRA17
         UxzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786347611; x=1786952411;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xWEnc98/U16ZabgS11Z3nKVIko8ezoTwBqo/WFptwSg=;
        b=Yuq7le5nB7/DnaTQ3hr3pr2gllJoSzb5oW2jUZdcbZCUnO21cX6E4lZLA/pTOhoYpw
         /eiSCYv5kcelPQN1s5JTrJVVbc//LBu11TpZKD8/kK4LHZ2LGl2Kh2aRW2vL4Wn7mkGQ
         /zkRcKoV/bJV78WKvBDxM0ElxVQuCR4ijzfg526vI+0UBRZv/B658azcE+6bazbOwZaf
         CrJYwrAb4CRljnmlPOxeMcu+/flj5NbJojhOUX1tnZOb9/lXg/VIh4k50B4N2wt768i2
         0DnOSjF1oJzMdfcb5aPDDh5NbjPqHcFL4ffQvDd/dEKL5QsIUU1ynlDks0GU30no8225
         wWUQ==
X-Gm-Message-State: AOJu0YxwrSZ9+AbOHrdwxAXZMlnIr+S6iNFxACRSqx562QGYdwJtbFe2
	qceQfi/QcdIWJmiy/FE7u7VT8m5jhtmAtWB6VXlSKz/AsD6MK0f2ufWcY1qJdG/z0rTyEl2nsVS
	BNRlt/V+XbiMOeL6lzp5Y/a/V+RUrAzvR+jCy8Nzd
X-Gm-Gg: AR+sD10o/nHSzH7v8mhvoQWqTApvWUTF4SQaLjbbFLlbBFcKyWhTsyPdMKhTUvVn4Xl
	y1ibOe8bQYhiSknH+bpeTlJc3BiArN2ORgpk3XPY/qNTsfnvv1Oa82SYhW7UbCH7OkhSTXBZtSR
	TSHYtjCiTP2S6NXwmPhGD+i51ro5DSpxzHJ0MllzcnGQiQgc3cdyz/QsJuccyHGsU8vLBzpEcHe
	vqoNVlzUoC8nIDaMVlVfddxr7b9UL5K0FuhvP3sI43yMrWuoQFY8H3HZej9cT0zz0fA4hsjROYm
	mtSXCBdEyN0V4tg6oGJgHo5faFYnMbrm1AhR5GS7ritKuFobXG4wn0yy+tXGXMd1V/XXhZMBqqz
	8fPhjlFYU8nIxTlAteoaFyUSJ3BRL1NE=
X-Received: by 2002:a05:622a:d0d:b0:516:ccc0:ee38 with SMTP id
 d75a77b69052e-52d28158dbdmr26021461cf.9.1786347610206; Mon, 10 Aug 2026
 00:40:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810065759.3735934-1-shivajikant@google.com> <9cff59e3-247f-463f-8d43-5138eefc18e3@blackwall.org>
In-Reply-To: <9cff59e3-247f-463f-8d43-5138eefc18e3@blackwall.org>
From: Shivaji Kant <shivajikant@google.com>
Date: Mon, 10 Aug 2026 13:09:58 +0530
X-Gm-Features: AUfX_mwdnd_jJ0JYQC7JyKBFQBNBeg45T97rH6OS82I1t0bRyW6TZJ-r7QDxFW0
Message-ID: <CAMEhMpmTyQKmSSPxoBkkdepZ9mj9wFp89-3oYPjsXuG8J5361A@mail.gmail.com>
Subject: Re: [PATCH] net: convert netdev_nl_sock bindings list to xarray
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, praan@google.com, 
	Mina Almasry <almasrymina@google.com>, Simon Horman <horms@kernel.org>, 
	Bobby Eshleman <bobbyeshleman@meta.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Dragos Tatulea <dtatulea@nvidia.com>, Kees Cook <kees@kernel.org>, 
	David Carlier <devnexen@gmail.com>, Yue Haibing <yuehaibing@huawei.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, David Wei <dw@davidwei.uk>, 
	Maoyi Xie <maoyixie.tju@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 12:48=E2=80=AFPM Nikolay Aleksandrov
<razor@blackwall.org> wrote:
>
> On 10/08/2026 09:57, Shivaji Kant wrote:
> > netdev_nl_sock previously used a struct list_head bindings to keep
> > track of active netdev netlink bindings, protected by a per-socket
> > struct mutex lock (priv->lock).
> >
> > Since list modifications and iterations are not concurrency-safe,
> > priv->lock was introduced to serialize operations on priv->bindings.
> > However, xarray manages its own internal locking (xa_lock) for store,
> > erase, and iteration operations.
> >
> > Convert bindings in struct netdev_nl_sock from struct list_head to
> > struct xarray and remove priv->lock. This simplifies the code by
> > removing explicit mutex locking in netdev_nl_bind_rx_doit(),
> > netdev_nl_bind_tx_doit(), and socket initialization/teardown functions.
> >
> > Reviewed-by: Mina Almasry <almasrymina@google.com>
> > Signed-off-by: Shivaji Kant <shivajikant@google.com>
> > ---
> >   include/net/netdev_netlink.h |  5 ++---
> >   net/core/devmem.c            | 13 ++++++++++---
> >   net/core/devmem.h            |  4 ++--
> >   net/core/netdev-genl.c       | 25 ++++++-------------------
> >   4 files changed, 20 insertions(+), 27 deletions(-)
> >
>
> This patch should target net-next.

Ack, I will correct this in v2.


>
> > diff --git a/include/net/netdev_netlink.h b/include/net/netdev_netlink.=
h
> > index 075962dbe743..45a4a482d42e 100644
> > --- a/include/net/netdev_netlink.h
> > +++ b/include/net/netdev_netlink.h
> > @@ -2,11 +2,10 @@
> >   #ifndef __NET_NETDEV_NETLINK_H
> >   #define __NET_NETDEV_NETLINK_H
> >
> > -#include <linux/list.h>
> > +#include <linux/xarray.h>
> >
> >   struct netdev_nl_sock {
> > -     struct mutex lock;
> > -     struct list_head bindings;
> > +     struct xarray bindings;
> >   };
> >
> >   #endif      /* __NET_NETDEV_NETLINK_H */
> > diff --git a/net/core/devmem.c b/net/core/devmem.c
> > index 957d6b96216b..52fda18b80ef 100644
> > --- a/net/core/devmem.c
> > +++ b/net/core/devmem.c
> > @@ -134,8 +134,8 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dma=
buf_binding *binding)
> >        */
> >       synchronize_net();
> >
> > -     if (binding->list.next)
> > -             list_del(&binding->list);
> > +     if (binding->sock_priv)
> > +             xa_erase(&binding->sock_priv->bindings, binding->id);
> >
> >       xa_for_each(&binding->bound_rxqs, xa_idx, rxq) {
> >               const struct pp_memory_provider_params mp_params =3D {
> > @@ -193,6 +193,7 @@ net_devmem_bind_dmabuf(struct net_device *dev, void=
 *vdev,
> >       struct dma_buf *dmabuf;
> >       unsigned int sg_idx, i;
> >       unsigned long virtual;
> > +     void *res;
> >       int err;
> >
> >       if (!dma_dev) {
> > @@ -325,7 +326,13 @@ net_devmem_bind_dmabuf(struct net_device *dev, voi=
d *vdev,
> >       if (err < 0)
> >               goto err_free_chunks;
> >
> > -     list_add(&binding->list, &priv->bindings);
> > +     binding->sock_priv =3D priv;
> > +     res =3D xa_store(&priv->bindings, binding->id, binding, GFP_KERNE=
L);
> > +     if (xa_is_err(res)) {
> > +             err =3D xa_err(res);
> > +             xa_erase(&net_devmem_dmabuf_bindings, binding->id);
> > +             goto err_free_chunks;
>
> This error cleans up after the previous xa_alloc_cyclic call itself inste=
ad
> of following the style of the rest of the error cleanups. I'd move the xa=
_erase()
> into its own err_ label and goto there.

Ack, will follow this consistent style.

>
> > +     }
> >
> >       return binding;
> >
> > diff --git a/net/core/devmem.h b/net/core/devmem.h
> > index 3852a56036cb..bf77e5a9a8fe 100644
> > --- a/net/core/devmem.h
> > +++ b/net/core/devmem.h
> > @@ -49,10 +49,10 @@ struct net_devmem_dmabuf_binding {
> >        */
> >       struct percpu_ref ref;
> >
> > -     /* The list of bindings currently active. Used for netlink to not=
ify us
> > +     /* The socket priv this binding belongs to. Used for netlink to n=
otify us
> >        * of the user dropping the bind.
> >        */
> > -     struct list_head list;
> > +     struct netdev_nl_sock *sock_priv;
> >
> >       /* rxq's this binding is active on. */
> >       struct xarray bound_rxqs;
> > diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> > index c15d8d4ca1f8..d3f3a91a6d93 100644
> > --- a/net/core/netdev-genl.c
> > +++ b/net/core/netdev-genl.c
> > @@ -1044,13 +1044,11 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb,=
 struct genl_info *info)
> >               goto err_genlmsg_free;
> >       }
> >
> > -     mutex_lock(&priv->lock);
> > -
> >       err =3D 0;
> >       netdev =3D netdev_get_by_index_lock(genl_info_net(info), ifindex)=
;
> >       if (!netdev) {
> >               err =3D -ENODEV;
> > -             goto err_unlock_sock;
> > +             goto err_genlmsg_free;
> >       }
> >       if (!netif_device_present(netdev))
> >               err =3D -ENODEV;
> > @@ -1102,8 +1100,6 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, s=
truct genl_info *info)
> >
> >       netdev_unlock(netdev);
> >
> > -     mutex_unlock(&priv->lock);
> > -
> >       return err < 0 ? err : 0;
> >
> >   err_unbind:
> > @@ -1112,8 +1108,6 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, s=
truct genl_info *info)
> >       bitmap_free(rxq_bitmap);
> >   err_unlock:
> >       netdev_unlock(netdev);
> > -err_unlock_sock:
> > -     mutex_unlock(&priv->lock);
> >   err_genlmsg_free:
> >       nlmsg_free(rsp);
> >       return err;
> > @@ -1185,12 +1179,10 @@ int netdev_nl_bind_tx_doit(struct sk_buff *skb,=
 struct genl_info *info)
> >               goto err_genlmsg_free;
> >       }
> >
> > -     mutex_lock(&priv->lock);
> > -
> >       netdev =3D netdev_get_by_index_lock(genl_info_net(info), ifindex)=
;
> >       if (!netdev) {
> >               err =3D -ENODEV;
> > -             goto err_unlock_sock;
> > +             goto err_genlmsg_free;
> >       }
> >
> >       if (!netif_device_present(netdev)) {
> > @@ -1233,7 +1225,6 @@ int netdev_nl_bind_tx_doit(struct sk_buff *skb, s=
truct genl_info *info)
> >       if (bind_dev !=3D netdev)
> >               netdev_unlock(bind_dev);
> >       netdev_unlock(netdev);
> > -     mutex_unlock(&priv->lock);
> >
> >       return genlmsg_reply(rsp, info);
> >
> > @@ -1242,8 +1233,6 @@ int netdev_nl_bind_tx_doit(struct sk_buff *skb, s=
truct genl_info *info)
> >               netdev_unlock(bind_dev);
> >   err_unlock_netdev:
> >       netdev_unlock(netdev);
> > -err_unlock_sock:
> > -     mutex_unlock(&priv->lock);
> >   err_genlmsg_free:
> >       nlmsg_free(rsp);
> >       return err;
> > @@ -1418,19 +1407,17 @@ int netdev_nl_queue_create_doit(struct sk_buff =
*skb, struct genl_info *info)
> >
> >   void netdev_nl_sock_priv_init(struct netdev_nl_sock *priv)
> >   {
> > -     INIT_LIST_HEAD(&priv->bindings);
> > -     mutex_init(&priv->lock);
> > +     xa_init(&priv->bindings);
> >   }
> >
> >   void netdev_nl_sock_priv_destroy(struct netdev_nl_sock *priv)
> >   {
> >       struct net_devmem_dmabuf_binding *binding;
> > -     struct net_devmem_dmabuf_binding *temp;
> >       netdevice_tracker dev_tracker;
> >       struct net_device *dev;
> > +     unsigned long xa_idx;
> >
> > -     mutex_lock(&priv->lock);
> > -     list_for_each_entry_safe(binding, temp, &priv->bindings, list) {
> > +     xa_for_each(&priv->bindings, xa_idx, binding) {
> >               mutex_lock(&binding->lock);
> >               dev =3D binding->dev;
> >               if (!dev) {
> > @@ -1446,7 +1433,7 @@ void netdev_nl_sock_priv_destroy(struct netdev_nl=
_sock *priv)
> >               netdev_unlock(dev);
> >               netdev_put(dev, &dev_tracker);
> >       }
> > -     mutex_unlock(&priv->lock);
> > +     xa_destroy(&priv->bindings);
> >   }
> >
> >   static int netdev_genl_netdevice_event(struct notifier_block *nb,
>
