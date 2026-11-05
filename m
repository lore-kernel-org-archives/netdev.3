Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793914045;
	b=sHdtDwB0lfNSJKio69zCO5KwlbC+Hp7TUiH9bOmAwiuJr+8hp31U4cHOZFV6xXTc48an
	 282vFEcAjUMDu+pAHWNT7BlIfbYEol8IxOEVgn1ERsTC7bz8IRdXOPPA5AfSCPgj8hOCD
	 KFOeqiukFUK5c0TyKT/KVNt2JcZIFWa/MxR5Xfgj9aLro3RRLw+0IT0ZyKZ4dr+fQMArr
	 ynSR411Q5KJsOb79Pwa5iN99OdgJhw/knCQyqc/49BdxESeJmNw5A0yFpWpHm7IEjh1qD
	 TNzTYoBQAly/fsjI0gx5IOnWAqVLuXxjgfXqGK4S1lj6jkhsnqHKra0A/x0xZGeCpEg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793914045;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=THABttIrCrQJ7hBmQ20KZf2AKE1jXHtkzAQnRjFVbLo=;
	b=kGLj/1A4fe0CX7vOMJ3+oWPjotUNe6F+qRaqgGsJl0RUXW1iE4PSsb/42sR4mkBG5dHD
	 NTA3PvJLE2tj9slCwPbHMKyGxT9kShZLOHH8ob8cmQ/nonmoGo9MH1xUYruVzRzjxkHTE
	 IkImqwaMmLYmgOx/dqu/mLDfarRTVGRQOomaL+zr8EEUmSirovEuY+GkFDhz8fM3J+sLn
	 DJidi1cCUL2VJACwpqK+G0kyCx9aBvJSJIw3WkUpgi5P3Ip0yBr5Mnvd1+ck3PCkKkk07
	 3P4mLdqEGaBbWtBgwqWjkHNxD4eZnHGMEjlkeh63taSoO3WDYBnus6ZjaH+t4PykS9g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=okpsmsZg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7200F606A326
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 21:27:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7200F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=okpsmsZg
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a206f0b95bso14785e9.0
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 13:27:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793914043; cv=none;
        d=google.com; s=arc-20260327;
        b=KXa+NCvlAVfEX9WOYWJQV99PdgcZ0y+3ONhlMiYOPa4VLHUw3ADDeXy01/sZ+MjMFI
         HV0kIr9Lx6zdAwXXO+iag4Qj1l5IxkPw8+bIpXLfPNJLj36slGYZtPos3bCZfE3fVvvO
         9xObE60hpjT83EtKbmzIMpJwn4OiB3Mb7+EO13i4H8Itk/qjzuH+LkBtIvu84BAPcy0E
         WZSV45QOKAaFUXhzw0j6UyVPjefKOer67y271qONG198ZqU1ecoYEPKVd00o192Sw2ox
         REGvB6vVV0HDsOKnoIMrUdEPJUjaLuj6B9RbJBX1gxwyh2CvI+iEedFhX8r3RIFpDBiJ
         S2Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=THABttIrCrQJ7hBmQ20KZf2AKE1jXHtkzAQnRjFVbLo=;
        fh=pgyZhmIXCR4adQV6v6MpDEFjFCRMy0+3cO6aqiF96vY=;
        b=PDSD0DTmWplWM3q7+MuW1vovOoG3Z3uNldkkJoVO1SPvsGm5971XnA4u6AKSR44D3X
         CSryJsSGH/bv58aRicr/QS5OnWG807Oam/ZHE3Efn4f1EFljDvvSIw2obSDX/psgOkPd
         dN5giQYQv2bPzOAHb+h+wGqm87pY6PYfnPEmRhyfHz1hTw78mb9Qu+qmTOI8w7OBie5e
         d8GpdfFYpnE6oBG7kZrhzBwA7URT45SiQVW59ulaX5dOCLNqmW1WS6njdcQSz3l3fSsn
         gcQGIO9/l+f77KYowTqS+LjZUgv9b5NWlL+UvyTzOoCD+E7MoIt2DUZDJnzdbE5ddTIL
         zazw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793914043; x=1794518843; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=THABttIrCrQJ7hBmQ20KZf2AKE1jXHtkzAQnRjFVbLo=;
        b=okpsmsZgVoz0nRQ0h+sRXdGBl00thWmGMFJ0aXIWgRDot6Y+w8XnNK0V3sqGL4uU38
         MCZpG5rm8mIiUfwLcM91i6aSBCxvas3ef3nXddOAKo5frX2YqMasMbnve32upjW5u7Kg
         zCImOdDpC5Rdqyz/3tbKUNzjyFNuoSl/8LLxk4UfJxjSja1YMQXibkiQg3cMtM3hISt3
         /nxTMkGwhyJS0FeKItFdHQfdl+2IVMn+Abejt+Ch8FbE/27T+eFjyebYpLGk3t5gmysp
         kqn48K7wf2Jp0/T5LsIlELHqUbwub1UdYRP0wPDv717etr2zRjKwLVqboPAc+Mhz1ajl
         wA3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793914043; x=1794518843;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=THABttIrCrQJ7hBmQ20KZf2AKE1jXHtkzAQnRjFVbLo=;
        b=G9luB/+gojnNMmHgYYHdCThWLgu36Ah8lWeOsxpKJ8R3Z/ziWL26JQPOuVFY/nl65H
         V8b7xKo5Z9L8RTto7EK9X3ogCOTtOvmlBdR6K/jgw3AnFfuLBBEaZYlCrs8I/l0mPni0
         nme068sdQaVGjuVWNro1xKrt0qXQcDzClBh47iRfcxfOWgSpEtLu+GbjB/VNHVwCE4Uh
         Csfh2Ne3X8enJ75PvffSvlg6lSVUGPe3RwTWx8hZ4YxBF8YE3jB7BVGKmkK9YmOT9dPc
         X9StlqyKYxndh2PlIseGXVuxYzSG0WBDdtZa3sSkrt/x87mM8ge8ntkOZHMGIoZQ5qwU
         Ha/Q==
X-Forwarded-Encrypted: i=1; AKwUvBwSVdhECoTfTo51qC+wyyLEkJ4zcSZG0yKDtLWuq+6EWLgndPRotpFXW1DTMCbYVslsxQ0P0bo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+YuwbaJjRYDP4h8mlQtTPZzMtLR1woiPGFepraRbKj9juTaosW
	1iuNCy4t+CMb8hEAoPXuAGWGfdtVmio3rkgi8HIWtqkEVYNmU8V+4s0S+lo0bo2ssT+08uIZtAn
	FmvZ/MeLGl5JEZQEkehddk2OJygkNtA3kQrV5eBKO
X-Gm-Gg: AYBFou2GM+mDn23bH1CJGXbPAF8sz6Kr90hI6NfatAmASBHJY0gFUsiihSmpH/3NBW+
	h35yZ/HEITTNzn4Gek8GlPMTNgdtFQY4rANnMFFYV9ywTMjya75leJhIfzjQ03MxXZjzE04Wsxz
	6QJAiiIlXvAneaapSAtVYSIbNl0JYA/NcuNmkSW06WZbjwI4wR7X5KdMzUQeRxAvczVTDN26ofQ
	Tf8Ey8NBTE1MjU57oKTYR6Vc+qQS6G80ZNqLqdkDB+J7criflsUEEuYnQ+WDqVTP/7KtQhQjO4t
	+5SYIA77Cvr1QgdIlPr5vze1XOYv3BgazmyqRih/PQg4zbs0wuPrvGpDmvf7BVqdlRYZlu8P905
	OYxLQtQRFPMF5lUoM51d93OFKnNHChXWR8bCKa/juNCjqIqWh2HC9m0jyuZuCbih4Pg==
X-Received: by 2002:a05:600c:894:b0:4a1:a48c:17eb with SMTP id
 5b1f17b1804b1-4b702461a35mr16585e9.11.1793914042316; Thu, 05 Nov 2026
 13:27:22 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105144543.1624238-1-edumazet@kernel.org>
In-Reply-To: <20261105144543.1624238-1-edumazet@kernel.org>
From: Naman Gulati <namangulati@google.com>
Date: Thu, 5 Nov 2026 13:27:06 -0800
X-Gm-Features: AclHuK-XnVgSnKXLvGKaUazPzyTUbyVGLonTKfNoll_RrWfiGnkHdq8T4bN8Ykk
Message-ID: <CAMP57yWHhQEdTCut9MF1UnsqWGKR-19xzL=TO8x=9-jYyn6bjQ@mail.gmail.com>
Subject: Re: [PATCH net] net: wait for in-flight device unregistrations before
 netns dismantle
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	stable@vger.kernel.org, syzbot+1269fe6cc2016008124e@syzkaller.appspotmail.com, 
	Henry Martin <bsdhenrymartin@gmail.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the fix, much cleaner than the individual rebroadcast
checks! Should we separately clean up the added checks as well? At
least the netdev-genl check also protected userspace listeners from
duplicate notifications beyond the null-ptr-deref protection, so it
might be worthwhile to keep.

Reviewed-by: Naman Gulati <namangulati@google.com>


On Thu, Nov 5, 2026 at 6:45=E2=80=AFAM Eric Dumazet <edumazet@kernel.org> w=
rote:
>
> A device can be unregistered by a context other than the cleanup_net()
> of its own netns, for instance a veth whose peer in another netns is
> deleted. If references on it are still held, it stays in
> netdev_wait_allrefs_any(), which rebroadcasts NETDEV_UNREGISTER every
> second.
>
> Meanwhile its netns can be dismantled: default_device_exit_batch()
> only takes care of devices still listed in the netns, then pernet exit
> handlers free their state, and finally struct net is freed while the
> device still points to it.
>
> The rebroadcasts then run notifiers against torn down pernet state, or
> freed memory. Three instances were reported so far:
>
>  - netdev_genl_netdevice_event(): net->genl_sock is NULL [1]
>  - nh_netdev_event(): net->nexthop.devhash is NULL [2]
>  - nf_tables netdevice notifiers: use-after-free of the nftables
>    pernet storage [3]
>
> but any notifier using dev_net(dev) is affected, as is
> netdev_wait_allrefs_any() itself (__rtnl_net_lock(dev_net(dev)) with
> CONFIG_DEBUG_NET_SMALL_RTNL=3Dy).
>
> This was prevented by rtnl_lock_unregistering() until I removed it
> in commit 8a4fc54b07d7 ("net: get rid of rtnl_lock_unregistering()"),
> considering only the loopback dependency, and missing the notifiers one.
>
> Restore a per-netns counter of devices sitting in netdev_run_todo(),
> and make default_device_exit_batch() wait for it to reach zero, after
> it has unregistered all devices of the dying netns(es). At this point
> no new unregistration can be started for these netns.
>
> Unlike the old barrier, this only waits for devices of the netns being
> dismantled and runs after their own devices are gone.
>
> Tested on a KASAN kernel with a debug-only hack holding a reference
> on a veth device for 5 seconds after its unregistration: a nexthop
> on the veth in netns X, delete its peer from init_net, then delete X.
> Without this patch, the nexthop_flush_dev() null-ptr-deref from [2]
> triggers. With it, no splat; netns churn and dismantle of a netns
> whose own device is held still work.
>
> [1] https://lore.kernel.org/netdev/6adf9f64.6200f071.51519.0ed1.GAE@googl=
e.com/
> [2] https://lore.kernel.org/netdev/20261105114707.3030737-1-bsdhenrymarti=
n@gmail.com/
> [3] https://lore.kernel.org/netdev/20261105114817.3033625-1-bsdhenrymarti=
n@gmail.com/
>
> Fixes: 8a4fc54b07d7 ("net: get rid of rtnl_lock_unregistering()")
> Cc: stable@vger.kernel.org
> Reported-by: syzbot+1269fe6cc2016008124e@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/6adf9f64.6200f071.51519.0ed1.GAE@g=
oogle.com/
> Reported-by: Henry Martin <bsdhenrymartin@gmail.com>
> Closes: https://lore.kernel.org/netdev/20261105114707.3030737-1-bsdhenrym=
artin@gmail.com/
> Closes: https://lore.kernel.org/netdev/20261105114817.3033625-1-bsdhenrym=
artin@gmail.com/
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>
> Cc: Kuniyuki Iwashima <kuniyu@google.com>
> Cc: Naman Gulati <namangulati@google.com>
> Cc: Pablo Neira Ayuso <pablo@netfilter.org>
> Cc: Florian Westphal <fw@strlen.de>
> ---
>  include/net/net_namespace.h |  1 +
>  net/core/dev.c              | 35 +++++++++++++++++++++++++++++++++++
>  2 files changed, 36 insertions(+)
>
> diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
> index c29a22ca178fa678c0468247b9f85f53eec86184..4a4d72080acdc787797bffd3a=
5a1bc0e6d4b46c7 100644
> --- a/include/net/net_namespace.h
> +++ b/include/net/net_namespace.h
> @@ -72,6 +72,7 @@ struct net {
>
>         unsigned int            dev_base_seq;   /* protected by rtnl_mute=
x */
>         atomic_t                dev_mc_genid;   /* dev->mc membership cha=
nges */
> +       atomic_t                dev_unreg_pending; /* devices in netdev_r=
un_todo() */
>         u32                     ifindex;
>
>         spinlock_t              nsid_lock;
> diff --git a/net/core/dev.c b/net/core/dev.c
> index df1a840b033437a168d4290f19611e6a23507d08..5d25b65e20dc4dc012492970d=
de42210808de17a 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -11101,6 +11101,14 @@ atomic_t dev_unreg_count =3D ATOMIC_INIT(0);
>  static void net_set_todo(struct net_device *dev)
>  {
>         list_add_tail(&dev->todo_list, &net_todo_list);
> +       atomic_inc(&dev_net(dev)->dev_unreg_pending);
> +}
> +
> +/* Paired with net_set_todo(). @net must not be used after this call. */
> +static void net_unreg_done(struct net *net)
> +{
> +       if (atomic_dec_and_test(&net->dev_unreg_pending))
> +               wake_up(&netdev_unregistering_wq);
>  }
>
>  static netdev_features_t netdev_sync_upper_features(struct net_device *l=
ower,
> @@ -12000,6 +12008,7 @@ void netdev_run_todo(void)
>                 if (unlikely(dev->reg_state !=3D NETREG_UNREGISTERING)) {
>                         netdev_WARN(dev, "run_todo but not unregistering\=
n");
>                         list_del(&dev->todo_list);
> +                       net_unreg_done(dev_net(dev));
>                         continue;
>                 }
>
> @@ -12016,8 +12025,11 @@ void netdev_run_todo(void)
>
>         cnt =3D 0;
>         while (!list_empty(&list)) {
> +               struct net *net;
> +
>                 dev =3D netdev_wait_allrefs_any(&list);
>                 list_del(&dev->todo_list);
> +               net =3D dev_net(dev);
>
>                 /* paranoia */
>                 BUG_ON(netdev_refcnt_read(dev) !=3D 1);
> @@ -12038,6 +12050,8 @@ void netdev_run_todo(void)
>
>                 /* Free network device */
>                 kobject_put(&dev->dev.kobj);
> +
> +               net_unreg_done(net);
>         }
>         if (cnt && atomic_sub_and_test(cnt, &dev_unreg_count))
>                 wake_up(&netdev_unregistering_wq);
> @@ -13486,6 +13500,17 @@ static void __net_exit default_device_exit_net(s=
truct net *net)
>         }
>  }
>
> +static bool __net_exit netns_dev_unreg_pending(const struct list_head *n=
et_list)
> +{
> +       struct net *net;
> +
> +       list_for_each_entry(net, net_list, exit_list) {
> +               if (atomic_read(&net->dev_unreg_pending))
> +                       return true;
> +       }
> +       return false;
> +}
> +
>  static void __net_exit default_device_exit_batch(struct list_head *net_l=
ist)
>  {
>         /* At exit all network devices most be removed from a network
> @@ -13527,6 +13552,16 @@ static void __net_exit default_device_exit_batch=
(struct list_head *net_list)
>         unregister_netdevice_many(&dev_kill_list);
>         rtnl_unlock();
>
> +       /* Devices of these netns unregistered from another context
> +        * (e.g. a veth whose peer was deleted) can still be waiting
> +        * in netdev_run_todo() for their last references, while
> +        * NETDEV_UNREGISTER is rebroadcast for them. Wait for them
> +        * before pernet exit handlers tear down the state used by
> +        * netdevice notifiers, and before the netns is freed.
> +        * No new unregistration can start: all devices are unlisted.
> +        */
> +       wait_event(netdev_unregistering_wq, !netns_dev_unreg_pending(net_=
list));
> +
>         rtnl_net_flush_workqueue();
>  }
>
> --
> 2.53.0
>
