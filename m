Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBA632C94A
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 15:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792165448; cv=none; b=XzLG+RHwURQWznAIpDJicPn2t8/trVh22FUlim14Ezi2Jj16wBiL0IbxemG6vYe5Flh+leEacHmq/bJ7H5Ed8SOZO/3Ka6VrqhYoGNxuGHktrp9EFt0hYqcgh95y9KeLqzgU643hYl0og0zQ859gUBZFBe6ct1pokvDl5V6e8Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792165448; c=relaxed/simple;
	bh=Zz8i0lUTzRkuZgBP2+V7pWig14l8N8fd7W2Q0Mi/UCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dmbShe2isrTmWCvntzGp7Gc8+yZFFE1fLc5Rz5UShd+dLpZw1GUMXKdhIaf/IknK21C4mMs28Dsob8QipTqZnJOfrkzacLkiwvScDTuCKZYV/YugqeqVw+6pgdFJZslpwYw4F51pcNxrwqpgO7VcmsqQYNLXQvB4HanZCavgj8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NWl7COJF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NWl7COJF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EE641F000C4
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 15:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792165446;
	bh=x4BlVnBkdABSzxNkd7xtQc1KrHevTV+nHJUmN1WOF50=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=NWl7COJFN7Hf2rYjR08s5lUnWdyU60zFI9qWzWql2nZLxLwFDrOUuWaPtlZlEJCXf
	 k8HQ2guCGgRB450IeMTOxyhWfFQhO05ODS6uVNvGrehUbFykMXgPbVAwTDeiX6Xvf1
	 +sXx/gEJeltqf0VDI3BwB08CXxKGzx2LHRPe4qPXP+NoRKR0j0Cgj4YpApDJ9AdrLc
	 o+p29XbXvdplq512JPyDc7qGFzWLTorWk3hXmOdCW1MKV2cElO27KeSH5l39+z++5n
	 Zv50sIRji7pMPoHHTsw6CJkqOZ1/FXpBL26ojt3RPb0YMo9zvKdTqcTLzwfS4AXcgf
	 l7JQpzxGgEt1g==
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-833e671ee9fso4742138a34.0
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 08:44:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzklj2dZy9hJmECzUhobKQ1pIRP+S9eb0hQK0MRvGlO3OQBDA9b9jwhWvs0dzgJ9a8DMfn5bjI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKSXiDqY/3gMvdMU9EBAuxh7msmYuQvHRZBuyGtPuLcFxGmz7na
	WtXUuM3F8jbCiQv1AqNXqOAXFFIeAwY3gQkSTGPpOehmgUYLGKvZ5X6yIEkClW2Oe5Px3yHe88i
	4G7lJphQSbk09IXWPchaogf49rDfUybg=
X-Received: by 2002:a05:6808:6f8f:b0:4ea:686e:fe86 with SMTP id
 5614622812f47-50c5b464a7emr20203589b6e.63.1792165446007; Fri, 16 Oct 2026
 08:44:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261016-bug-veth-init-queues-before-register-v1-1-f48eb2bb25a0@gmail.com>
In-Reply-To: <20261016-bug-veth-init-queues-before-register-v1-1-f48eb2bb25a0@gmail.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Fri, 16 Oct 2026 17:43:54 +0200
X-Gmail-Original-Message-ID: <CAL4WiipGJT316aRQSMtyHo9s0qGoWGeZLxqnksyQTO9mioidQA@mail.gmail.com>
X-Gm-Features: AclHuK-vfqoap1s0w_q-N6yPL7qX4SBSAmBMtMa8Gsw7Q-KmBm3I-033Cj2xIhU
Message-ID: <CAL4WiipGJT316aRQSMtyHo9s0qGoWGeZLxqnksyQTO9mioidQA@mail.gmail.com>
Subject: Re: [PATCH net-next] veth: set the real number of queues before
 registering the devices
To: Qiliang Yuan <odys.yuan@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le ven. 16 oct. 2026 =C3=A0 08:51, Qiliang Yuan <odys.yuan@gmail.com> a =C3=
=A9crit :
>
> Since commit 9d3684c24a52 ("veth: create by default nr_possible_cpus
> queues"), each veth device is allocated with one rx and one tx queue
> per possible CPU, and veth_newlink() reduces the real number of queues
> to one unless the user asked for a number.
>
> Both devices are already registered at that point, so
> netif_set_real_num_tx_queues() and netif_set_real_num_rx_queues()
> remove the sysfs objects of every extra queue that register_netdevice()
> has just created, each one emitting an add and a remove uevent, and the
> tx side also waits for an expedited RCU grace period. This happens with
> RTNL held, twice per pair, and grows with the number of possible CPUs:
> with 240 of them a veth pair emits about 1900 uevents, and udev
> processing them slows down later sysfs work such as deleting devices.
>
> Set the number of queues before registering each device. For a device
> that is not registered yet this only updates the counters, so the extra
> queues never appear in sysfs, and the error paths that undid a
> registration are no longer needed.
>
> Creating and then deleting 500 veth pairs, one ip -batch each, in a 16
> vCPU guest, median of 3 runs, per pair:
>
>                                    before      after
>   16 possible CPUs    create      1644 us     520 us
>                       delete     11822 us    9750 us
>   240 possible CPUs   create     17253 us    1339 us
>                       delete     17082 us    9941 us
>                       uevents        1918          6
>
> Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
> ---
>  drivers/net/veth.c | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index 38f263d4f06b4..92ad064567327 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c
> @@ -1875,6 +1875,10 @@ static int veth_newlink(struct net_device *dev,
>
>         netif_inherit_tso_max(peer, dev);
>
> +       err =3D veth_init_queues(peer, tb);
> +       if (err)
> +               goto err_register_peer;
> +
>         err =3D register_netdevice(peer);
>         if (err < 0)
>                 goto err_register_peer;
> @@ -1904,6 +1908,10 @@ static int veth_newlink(struct net_device *dev,
>         else
>                 snprintf(dev->name, IFNAMSIZ, DRV_NAME "%%d");
>
> +       err =3D veth_init_queues(dev, tb);
> +       if (err)
> +               goto err_register_dev;
> +
>         err =3D register_netdevice(dev);
>         if (err < 0)
>                 goto err_register_dev;
> @@ -1917,16 +1925,10 @@ static int veth_newlink(struct net_device *dev,
>         priv =3D netdev_priv(dev);
>         rcu_assign_pointer(priv->peer, peer);
>         netdev_hold(peer, &priv->peer_tracker, GFP_KERNEL);
> -       err =3D veth_init_queues(dev, tb);
> -       if (err)
> -               goto err_queues;
>
>         priv =3D netdev_priv(peer);
>         rcu_assign_pointer(priv->peer, dev);
>         netdev_hold(dev, &priv->peer_tracker, GFP_KERNEL);
> -       err =3D veth_init_queues(peer, tb);

Orthogonal to your patch, but here we should have used @tbp instead of @tb.

# ip link add va type veth peer vb numtxqueues 4

-> vb has 4 tx queues, but only 1 real tx queue, which is quite unexpected.

# ip -d link sh vb
13: vb@va: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noop state DOWN
mode DEFAULT group default qlen 1000
    link/ether e2:53:93:f3:f4:f8 brd ff:ff:ff:ff:ff:ff promiscuity 0
allmulti 0 minmtu 68 maxmtu 65535
    veth addrgenmode eui64 numtxqueues 4 numrxqueues 8 gso_max_size
65536 gso_max_segs 65535 tso_max_size 524280 tso_max_segs 65535
gro_max_size 65536 gso_ipv4_max_size 65536 gro_ipv4_max_size 65536

# ls /sys/class/net/vb/queues/
rx-0  tx-0
