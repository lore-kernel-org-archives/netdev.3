Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A02368941
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 06:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790318769; cv=pass; b=ptQ4G9xe1ru3Twb/4SjUlXBe5y7I0nROnFDjel7hQHG1W/m1k93ev9YRUxV5dmxC+GYGb8K6jKsgqYdTs2aatWFJilSIbKUGBtHbxxslRrBvTA7zr0JO9OEe93J+q9N7v6dQBquHuswec/iJyZ+d0PwcsF8/9G+1Kpb+j+iS9Yc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790318769; c=relaxed/simple;
	bh=FEst1Fihh4zLZdsP7t7AJnUhd+Lgtr3Hn8aaYvJzXAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZoFDGXHVLYaaxazPpcCuGmf18oMOAezKs9NuYSwyhEQXLj+jHLVqsUvR2dZdDvpWI/fUccEFtBFnk9VXqVz0rtMafHoGnMOGgQXpNTKV2he4n7EK++WO5SqV5Nmn5eAIKUTpbDf3SclqfvxrWKl6WZPZNQZnzoFU2tws3afXWkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a3h98gOT; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AFk9gD3s; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a3h98gOT";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="AFk9gD3s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790318766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+LmCbqDZvjwS/KxFRtn0hfL/FdPZYfZBnFRt+2hBYWE=;
	b=a3h98gOT2nkpuPuBaysqqEOsLbaIb2L80oidndbtgjcjEl2QaL4s3F/GREG9q/GkPKJOI1
	/6w4J0XRH+AyXW1fm7GuzXzFx3DpfLl+lox1KmKtKACMuC/ItHHnisdKSMZiRrBwHcG5Ew
	cQHNtC4+Ty7Xc5wSu2feUl+L0akQH0c=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-K8xw73dAPUCS3Ws9Q_7dKg-1; Fri, 25 Sep 2026 02:46:02 -0400
X-MC-Unique: K8xw73dAPUCS3Ws9Q_7dKg-1
X-Mimecast-MFC-AGG-ID: K8xw73dAPUCS3Ws9Q_7dKg_1790318762
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc4922b7c31so417704a12.1
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 23:46:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790318762; cv=none;
        d=google.com; s=arc-20260327;
        b=pdeJCnQjDtXMLiUAY4bFxdFTz5u55bIH3RFH0DT62dP7QVB9MdSWNSwIxLree88PHh
         hAZnkwYuTPvjHrmBSWxN2omzgCaFSqUjAZQVm+QPQ5/vgKSl+Zi0Q7fU5M2R+vYxYajB
         69K72rM5r844wWRhjjIlDFzvGS89mRVF8A+HGXRqm9tb/qA+OwofQBNy0/ZAPWg//azC
         yIhdhl9rdk3cilItOA9va/4iiVhziu6B6dJxEu0e+/7qjwIkS07wWKeCnCqoaKR2aMWa
         9gdFNtZEPH1s1SO9EqZyLyBReSDNFVr7TPhYkmT0W5aXXsmlzEe7YOh6O64V+acYP+JT
         vwMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+LmCbqDZvjwS/KxFRtn0hfL/FdPZYfZBnFRt+2hBYWE=;
        fh=aSb1CwwSjq4BxyHgrEV32qRWbEIRnIIL1Htkab7XZpY=;
        b=eVY5+s/6L6C3Gzc/R0XYHWYA4aotPkFgdfHnovc7b/8tddWb+TPlz20VbtNi7QfBzv
         GcHq4MStFSYhthINH1EeQwUiG87ujqHH6kHFvDIkfgZcx3HneJxfGSYoabYe6XM7Zlbe
         OlSmGSBs5fLhi5q2CnpWPyUVvlvgDQPJprFXWgiiFlcNJHnxHOMpCACSSjI3w+2Pp0hw
         oTA7Hnkg88XcOIpc/UGbM8ALVDEyfSKPz2U0ImqY2nrh6dQRFqef0VnP+1PKedKuR6Le
         wPbPK9mHQjfv123X8xMUTLTMgOU+3RJokW0F5jT0hjAoWykGpjQQtQOH/cHhnOwVYqVe
         juIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790318762; x=1790923562; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+LmCbqDZvjwS/KxFRtn0hfL/FdPZYfZBnFRt+2hBYWE=;
        b=AFk9gD3s8CqGlk4LP6ZzeNKOgNLUqyOxwpfDT7Z2XFHJv+TsvuLuMKSvjef0CNe1YX
         1AdXuggKgaZHjXrkC+bVB1/NLtjUHZR5PuENoDXWa79B0BezWX61b435zom3Ty10uhK8
         v+Bdriyvoq6i4T/nkst1P9EVPpx9Af4MQjXOiswZptisLmnZTVYDTcCFrXXrCz9HRWOZ
         mxGXqwOfP/GuO1P33lrwgy83TTVrX9wlplhzWcK9R2h+MutlZxJO/xpytaH0JpPkodsF
         mEklXwcK5xOzIuBGKlGKP76faXahVEoW/B9RSmWTm7NevfzoGKe5YH4fftjz0ea0uXgN
         4tRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790318762; x=1790923562;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+LmCbqDZvjwS/KxFRtn0hfL/FdPZYfZBnFRt+2hBYWE=;
        b=RMYYYfoGwExMmSxNyOwr+tKTZ6SepOVk86yPZbZxDLaYfbH4XMnTA37B/A5rP5XTyk
         9toomudvZQH/72UZcDzThZeZXYfykwqy+TXsLs4q9eF24uFii3bbVfz36TSQt7esXg/o
         HjNRnSeDvnrS+2IKoqRwYyUHTO4oFE0tyYlwhhkapSITjPyxf6TKUr3C7n9BZbId37QL
         Mi+RR5f/hKKKm9JtLp6wNnj0CygDfUS0J6ysftg0ArNNH+LN55FajA0gdS1XFpdbT0b6
         bU+AVLjSKlp/7s8LRuv5d0WAZTfAB1+Y8O7ED89GZpqKMbA6dr961oNna1Zdatt9ODX2
         aCMA==
X-Gm-Message-State: AFuF++kelsqyKAyhqd7nvJ6/vfV6gilxcQ9Df4iSjQqyHYvxNC82Utn/
	X8Eoant1Jh8LF6U4xjbEoOQVGPlk2y9goKfg6z3M8iYn3c00u5eh256xyqhrUzut/0eDNHNfjCI
	ZzaMrNFk0Yshgxl9kS0nVpBn9UcclNMIPnmG+d3FQCfv1E4f1MJVrImQoaZMHDMlR7tc63jgW2q
	0komGt+8Z6GGFrVhpKWam843zkabMluOM/
X-Gm-Gg: AYBFou0hoLodrl3inNRBANrWnJj3NmShdKoI2mU81aFLyXy/EBh1UlGpJ67NOwviLJ6
	rxEyNtE5wcTR1r5uO9MSBsgDqPcow9BEHlwASf9XX58tjxLX6/Nm819J7np0YYXzOoCLxha9/1G
	+3stVia0AgbISz3aBxIvSscPwKlJmTdqMdCKthdvGuzbd85H0xI+Fqa6izPn3lCi5tClnPghK9I
	HKLBfHJE9oIxpHr
X-Received: by 2002:a05:6a20:2d21:b0:3dd:a196:30a6 with SMTP id adf61e73a8af0-3de0e9b22f2mr4534991637.86.1790318761682;
        Thu, 24 Sep 2026 23:46:01 -0700 (PDT)
X-Received: by 2002:a05:6a20:2d21:b0:3dd:a196:30a6 with SMTP id
 adf61e73a8af0-3de0e9b22f2mr4534959637.86.1790318760818; Thu, 24 Sep 2026
 23:46:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922135123.46205-1-avirdi@redhat.com> <179025806955.2160803.14946061126391357248@kernel.org>
 <CAJHXLyHH-RG_y04yT-SV+r3+_scac15iKrMtVfNG9Ti3wQFmrw@mail.gmail.com>
In-Reply-To: <CAJHXLyHH-RG_y04yT-SV+r3+_scac15iKrMtVfNG9Ti3wQFmrw@mail.gmail.com>
From: Anirudh Virdi <avirdi@redhat.com>
Date: Fri, 25 Sep 2026 12:15:48 +0530
X-Gm-Features: AclHuK8sXxjzZGnFiyrwFUNGm5czlW8cbMfwRi3V4i4mMNUe7qHDXLQs9PnHxA8
Message-ID: <CAJHXLyGhZFtaX_AzfqNJW3f4_EVM=W6834uB5srYycvfgGHgnQ@mail.gmail.com>
Subject: Re: [PATCH net] net/mlx5: Fix slab-out-of-bounds when handling team
 device events
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, saeedm@nvidia.com, leon@kernel.org, 
	tariqt@nvidia.com, mbloch@nvidia.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	shayd@nvidia.com, ohartoov@nvidia.com, maorg@nvidia.com, 
	linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for the detailed analysis, Sashiko!

The concerns you've raised have been addressed in v2 of this patch:

1. Over-broad guard: v2 now keeps netif_is_lag_master() at the top of
   mlx5_handle_changeupper_event() and only wraps the bond-specific API cal=
ls
   (bond_slave_get_rcu/bond_is_slave_inactive) with netif_is_bond_master().
   This allows team LAG tracking to continue working while preventing the
   out-of-bounds read.

2. Commit message inaccuracy: v2 correctly narrows the scope to only
   mlx5_handle_changeupper_event(), acknowledging that
   mlx5_handle_changeinfodata_event() is only reached from bonding code pat=
hs.

3. TC mirred issue: Noted as pre-existing. This can be addressed in a
   separate patch series after this fix merges.

v2 is available at:
https://lore.kernel.org/netdev/20260924064244.94045-1-avirdi@redhat.com/

Feedback appreciated!


On Fri, Sep 25, 2026 at 12:12=E2=80=AFPM Anirudh Virdi <avirdi@redhat.com> =
wrote:
>
> Thank you for the detailed analysis, Sashiko!
>
> The concerns you've raised have been addressed in v2 of this patch:
>
> 1. Over-broad guard: v2 now keeps netif_is_lag_master() at the top of
>    mlx5_handle_changeupper_event() and only wraps the bond-specific API c=
alls
>    (bond_slave_get_rcu/bond_is_slave_inactive) with netif_is_bond_master(=
).
>    This allows team LAG tracking to continue working while preventing the
>    out-of-bounds read.
>
> 2. Commit message inaccuracy: v2 correctly narrows the scope to only
>    mlx5_handle_changeupper_event(), acknowledging that
>    mlx5_handle_changeinfodata_event() is only reached from bonding code p=
aths.
>
> 3. TC mirred issue: Noted as pre-existing. This can be addressed in a
>    separate patch series after this fix merges.
>
> v2 is available at:
> https://lore.kernel.org/netdev/20260924064244.94045-1-avirdi@redhat.com/
>
> Feedback appreciated!
>
>
> On Thu, Sep 24, 2026 at 7:30=E2=80=AFPM <netdev-bot+sashiko@kernel.org> w=
rote:
>>
>> Thank you for your contribution! Sashiko AI review found 2 potential
>> issue(s) to consider.
>>
>> Critical: 0 =C2=B7 High: 1 (1) =C2=B7 Medium: 0 =C2=B7 Low: 1
>>
>> If you believe none of the issues are legitimate, please reply to each
>> issue of Medium severity or higher and explain why the AI is wrong.
>> If any of them are legitimate and you plan to respin, please let patchwo=
rk
>> know by including "pw-bot: cr" as a separate line at the end of your rep=
ly
>> (one such reply per series is enough).
>>
>> - [High] Over-broad guard: replacing netif_is_lag_master() with
>>   netif_is_bond_master() at the very top of=E2=80=A6
>> - [Low] Commit message inaccuracy: the message states that
>>   mlx5_handle_changeinfodata_event() suffers the same team_port-=E2=80=
=A6
>>
>> Pre-existing issues:
>> - [High] The identical bug class the patch claims to eliminate remains
>>   reachable in the mlx5e TC mirred offload path: get_fdb_out_dev()=E2=80=
=A6
>>
>> --
>>
>> net/mlx5: Fix slab-out-of-bounds when handling team device events
>>
>> This changes the two LAG notifier helpers in mlx5's lag.c to gate on
>> netif_is_bond_master() instead of netif_is_lag_master(), so that a team
>> master no longer reaches bond_slave_get_rcu()/bond_is_slave_inactive().
>> The reported symptom is a KASAN out-of-bounds read when a team_port is
>> interpreted as a struct slave.
>>
>> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drive=
rs/net/ethernet/mellanox/mlx5/core/lag/lag.c
>> > index dd14cdc378de0..2714d39ae7c24 100644
>> > --- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
>> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
>> > @@ -1922,7 +1922,7 @@ static int mlx5_handle_changeupper_event(struct =
mlx5_lag *ldev,
>> >       int changed =3D 0;
>> >       int i, idx =3D -1;
>> >
>> > -     if (!netif_is_lag_master(upper))
>> > +     if (!netif_is_bond_master(upper))
>> >               return 0;
>>
>> [Severity: High]
>> Does this early return do more than avoid the bonding-only calls?  The
>> only team-unsafe statements in mlx5_handle_changeupper_event() are furth=
er
>> down in the for_each_netdev_in_bond_rcu() loop:
>>
>>         slave =3D bond_slave_get_rcu(ndev_tmp);
>>         if (slave)
>>                 has_inactive |=3D bond_is_slave_inactive(slave);
>>
>> Returning 0 at the top of the function also skips the computation of
>> tracker->tx_type, tracker->hash_type and tracker->is_bonded for any team
>> master.
>>
>> Since mlx5_lag_netdev_event() only writes the tracker back and queues th=
e
>> work when a handler returns non-zero:
>>
>>         if (changed)
>>                 mlx5_lag_update_tracker_speed(&tracker, ndev);
>>
>>         ldev->tracker =3D tracker;
>>
>>         if (changed)
>>                 mlx5_queue_bond_work(ldev, 0);
>>
>> and mlx5_do_bond() gates activation on the tracker:
>>
>>         do_bond =3D tracker.is_bonded && mlx5_lag_check_prereq(ldev);
>>
>> can is_bonded ever become true again for mlx5 ports aggregated by a team
>> master?  Team does advertise the TX types mlx5 accepts =E2=80=94
>> team_upper_dev_link() sets lag_upper_info.tx_type =3D team->mode->lag_tx=
_type,
>> with NETDEV_LAG_TX_TYPE_ACTIVEBACKUP in team_mode_activebackup and
>> NETDEV_LAG_TX_TYPE_HASH in team_mode_loadbalance =E2=80=94 which are exa=
ctly the
>> two values the mode_supported test in this function allows.
>>
>> Would gating only the bond_slave_get_rcu()/bond_is_slave_inactive() bloc=
k
>> on netif_is_bond_master() remove the out-of-bounds read while keeping
>> team-based LAG tracking?
>>
>> Related to this, does the driver's notifier state machine become
>> asymmetric?  mlx5_handle_changelowerstate_event() still admits team port=
s:
>>
>>         if (!netif_is_lag_port(ndev))
>>                 return 0;
>>
>> and returns 1, so team NETDEV_CHANGELOWERSTATE events keep updating
>> tracker->netdev_state[] and queueing bond work while is_bonded can never=
 be
>> set.  mlx5_lag_update_tracker_speed() also still resolves a team master =
as
>> the bond device:
>>
>>         if (netif_is_lag_master(ndev))
>>                 bond_dev =3D ndev;
>>
>> and publishes its speed through mlx5_lag_query_bond_speed().
>>
>> One more question on the changelog: with a Fixes: tag aimed at stable,
>> should the loss of hardware LAG offload for team-aggregated ports be
>> mentioned, since there is no extack or dmesg indication when the handler
>> bails out early?
>>
>> >
>> >       if (info->linking)
>> > @@ -2029,7 +2029,7 @@ static int mlx5_handle_changeinfodata_event(stru=
ct mlx5_lag *ldev,
>> >       bool has_inactive =3D 0;
>> >       int idx;
>> >
>> > -     if (!netif_is_lag_master(ndev))
>> > +     if (!netif_is_bond_master(ndev))
>> >               return 0;
>>
>> [Severity: Low]
>> The commit message says:
>>
>>     The mlx5_handle_changeupper_event() and mlx5_handle_changeinfodata_e=
vent()
>>     functions assume the upper device is a bonding device and call bondi=
ng-
>>     specific
>>     APIs like bond_slave_get_rcu() and bond_is_slave_inactive().
>>
>> Can mlx5_handle_changeinfodata_event() actually be entered with a team
>> master?  NETDEV_CHANGEINFODATA has a single emitter in the tree, in
>> bond_option_active_slave_set():
>>
>>         call_netdevice_notifiers(NETDEV_CHANGEINFODATA, bond->dev);
>>
>> drivers/net/team/ never emits it, so this hunk looks like hardening of a=
n
>> unreachable path rather than a second fix.  Could the changelog be narro=
wed
>> to the mlx5_handle_changeupper_event() path, so stable backporters see t=
he
>> real scope?
>>
>> Also, the sentence above is wrapped mid-word ("bonding-\nspecific") in t=
he
>> changelog.
>>
>> >
>> >       rcu_read_lock();
>>
>> [Severity: High]
>> This isn't a bug introduced by this patch, but the same pattern is still
>> present in the mlx5e TC mirred offload path, and it may be worth fixing =
in
>> the same series.  get_fdb_out_dev() in
>> drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/mirred.c still uses th=
e
>> generic check before a bonding-only accessor:
>>
>>         } else if (netif_is_lag_master(out_dev)) {
>>                 fdb_out_dev =3D bond_option_active_slave_get_rcu(netdev_=
priv(out_dev));
>>
>> For a team master, netdev_priv() is a struct team, and
>> bond_option_active_slave_get_rcu() reads it as struct bonding:
>>
>> include/net/bonding.h:bond_option_active_slave_get_rcu() {
>>         const struct slave *slave =3D rcu_dereference_rtnl(bond->curr_ac=
tive_slave);
>>
>>         return bond_uses_primary(bond) && slave ? slave->dev : NULL;
>> }
>>
>> bond_uses_primary() reads BOND_MODE(bond) out of unrelated bytes of the =
team
>> private area, and bond->curr_active_slave aliases team->header_ops_cache
>> (struct team starts with pcpu_stats, it has no leading dev member).  If =
the
>> garbage mode value happens to be one of the primary modes, does this
>> dereference header_ops_cache as struct slave * and return slave->dev as =
a
>> bogus struct net_device *, which mlx5e_eswitch_rep() then dereferences?
>>
>> The reachable caller is parse_mirred():
>>
>>         out_dev =3D get_fdb_out_dev(uplink_dev, out_dev);
>>         if (!out_dev)
>>                 return -ENODEV;
>>
>> reached from tc_act_parse_mirred() when
>> netdev_port_same_parent_id(priv->netdev, out_dev) holds, which a team ma=
ster
>> over mlx5 representors satisfies.  Should this site use
>> netif_is_bond_master() too, the way mpesw.c already does?
>>
>> --
>> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patc=
hset/20260922135123.46205-1-avirdi%40redhat.com
>>
>
>
> --
>
> Anirudh Virdi



--=20

Anirudh Virdi

