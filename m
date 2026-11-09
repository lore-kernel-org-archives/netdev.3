Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794241816;
	b=lR24z1RctScsHVDdyYJJNXCze/czsg2r20LUzySEldrutHsEiDeyKSLyPX1T6zR9Alve
	 DeYSs5WwdKJXfUgSWTL1AbrWf5K6OXYbOpa4dW9u4DFU5I0tMpJ5TL3+9ADK3UKVN4za5
	 zj2Gh3KiEMjRUEs5xAX56qPHizbX0lYhlmtp5+pTuACUoGKDy0gEF/M8eb/WyBmHa2Hfz
	 jj7IQRvBP8SwGdxFsAdrl/WIpesm9nPTm8BI3afyh4VlMp27qKv/gclBD7NsqdxG8I66M
	 LThR7k4K5kg72sDrvg8aKb84bMiKyTu7fobOBTFyOLI9dcsmQeYs9DCkGaZCknSk9xg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794241816;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=u6VYdfpwk02ticFoJF2TXqRpW+yzUumcdZDS/l2GBHU=;
	b=c8WJZS2Gz9EvsuHSwZi0s0t3bl5qpJwZO9KYWCaW1h12SRTuRpQSpi+1aDcBVjeqey7Y
	 X+a69D74yOJZaKxwxygQTNt5In47xAw1P61vG/r+/FcfWTZhbRHSTPOfRWEY6BJYL2D51
	 tayJM6VqVQLzrweaO0z4gjMiNhJmW9+CpMFaTyifWqiC/Qfa2lcU2VL4Wd3X87lLxulX0
	 mGTu81yLUHJ+IBTuz74SNSAAYeVlsr7pSoJLtpTw1dtkvIm6Yu8dB093Rv0DP8vNMg8Z7
	 n70G4WQ64MYV7RHYxGUbVoX8PjNVAk0yJGgVybtkDJmljFIsm7X8JRNQ+lk+d1aUpDQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wpFI+fQY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3BD606EE84
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 16:30:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A3BD606EE84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wpFI+fQY
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-492f6b7f70dso710502f8f.0
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 08:30:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794241814; cv=none;
        d=google.com; s=arc-20260327;
        b=L1Kb1PWCvebuav09HzIpiiIEqSyJp3Y5Qs4CFIl+lFuhCaMse9JVyytw3PKMLgq4Fl
         kW2nU/dXf2nPIvqy92ZqVIfvSYRjBerKVsV61svK5jveZWnNm5BBKIADcfIWwdG+vPx1
         ZYTZuAJCGdJ48He5OYe27UMcNCg3SFzHsIbwjgfXkj0v6Ip76+ahopTtzmDRjtR3n7bj
         x+0Ehq20iTpBccC/3i8oYGpV3f09kT0Nf9NvOJm4cwUeKy5wUsc/ngul65OzIhO7CeR4
         JPHKQqcdpHOOsTPebOSorGmKYyvtj1t339hd/2oNc736HpDcxj/mxYgVz3Q8Vqd40E5+
         J9Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u6VYdfpwk02ticFoJF2TXqRpW+yzUumcdZDS/l2GBHU=;
        fh=sgMlnpPIkoatpKB1xJDHQICPZqesERPploa6LoXqXLk=;
        b=lq34gAdcsmdLcRO3Jd2cX65OKZghFsng0qCVQR4+NGBiLuNKFP7fhka0l7i4aabKeS
         TvXRYZLBZw7r+6fnHnicD+iArjse++3WoUEESl1qjjHCN3yLwGrhZhNVa3wOqQO1BIyp
         IUuk/WiPyIwkpVL4X2zsdNrlCQ+OZWj+sAAY0hOUDmlwpB8m950GPkfPpDohr/rlinC0
         BpwFcaAXbHfzGtSnl0phY/Xp3ga0tnIWFMaK0/4EyFygIhLCWUsFAxf69DnPne+t7ld9
         Izi9TXn8lClrIZM8ljYCELt+xjYqzThFeD/0sTD9xYVevr1KRwIV1t09Wy9BUeqxeLo+
         20fQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794241814; x=1794846614; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=u6VYdfpwk02ticFoJF2TXqRpW+yzUumcdZDS/l2GBHU=;
        b=wpFI+fQYX5XLg6M1iTaccA7S0edIczBb454ostHPIlx2eTZz0gY2FhNloOdCBkKQT/
         a0YgJldnxAGK8jVX6lpSTNPNAkcNLLc1TB35DaWs0bFXJU3zHHJFKdfeWSgP5kpAvj77
         t0Y5TwISYPWhAX4UmoEWBZgWxdL3MBR4fJEvMMcboFFzuy4QBjjMMeNOVz//EaaS6HHH
         UVZaulDQCfQGx7Uh4g2P0yp78iqCsKoCJ1dt9rTtSLAC3ZiQOlDCE+4q8hTP7KKhXP5r
         A5G4PF+7s9jd8OsHage9GL0UJRNOEclN4ZpqXylERUodl6F4ynM1xjwPPAjv2pF32WCP
         fY9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794241814; x=1794846614;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u6VYdfpwk02ticFoJF2TXqRpW+yzUumcdZDS/l2GBHU=;
        b=2cqjs9UZlC4/sc+1h5L6vjZnRSx87k3JkOMNrcIx4ho55tNmO4QRiLTyKtBJ5Vt9kz
         T0gIrrTO/s7XOQdY0nk+14FoV/645c9PZb45VWfRWhum6LuApCQDTVtb/AJxw9fyrjx1
         QFyLivrp80Ro5tBDrA6pdcuswX5qtTAG+5ATiPfJAWJTAvscOx4jThU5tZzaIbjky46H
         8Cf9W+k9X9g+v+TnXhOX4f/fJvtz/Ox2dnIAdGkdmekOEjUflkbMgjJ4OHY+goKFA6uL
         B4C6bZ7hREbFDRCFLV38wVSafmelE1T3t4WJJgkoIvE6Yf6pLHISFfgGRFr0qmtiGmVq
         aNjg==
X-Gm-Message-State: APuU4Z+TCdkAJzFi/W0RXUb76RUX3VOaRst/3rwph0G1nZsO+YAU16xl
	VeYWTgJbNm73a/wsAhv80TEweXf+/YBGADwRooX2D2ZKwjMDn4j7PXzF1/dOrKqv5yo3I5nzBRT
	+Y3S63r0v6Z8CXgdMEhmGGRzfojujf68=
X-Gm-Gg: AYBFou3JOTtBgzk0YGp5PkzOoYwqL2KSgy4jRZf+khfcomsRJpUu1ljY3tp3kd+GXDL
	myR5bVS1qiHMEJDKPBflJpSiFqRTVX2TG4OJpbKndKSCIhc7tpDjOTNLhb2XK9tyRQnhVI9V+OT
	dIXdlPHR4AmKvoiwaOW6mGKX9FmOo1ziq9/Z1UPAN77nT1dMTkgv+YbAIXok2LPFjlYuZxji0UN
	Onlbas6qsSyyFLQdGXRKWXU6BpfMlXiTQ5L2rRIGOs8nrjA1pzKnxDKlec/FFX952iRPqdO+GcY
	/537QUG8AqLvwoCZoerxL83L9hmP31tn3Nm5xGyshvmMqVcfLtswCpaduAXcLbeWVArcRqW5UBs
	s39vluKpnubW2b1KqfJs4JFKq9YqzB8+N3t0ITnVhOsaJXFdXmXO7ZDk+cD/v2jvqFBFGlaI+C2
	wpVjaG3ib/ZJGg6MXROuar5BKTvMdP+pxgRCrZxmbzVrHkmbgyz2vgZw==
X-Received: by 2002:a05:6000:29ce:b0:497:9e2a:b1e with SMTP id
 ffacd0b85a97d-4979e2a0d6bmr2119308f8f.9.1794241813991; Mon, 09 Nov 2026
 08:30:13 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <179381515284.9644.1846335740085170889.stgit@ahduyck-xeon-server.home.arpa>
 <179416277142.994134.5623223181953033290@kernel.org>
In-Reply-To: <179416277142.994134.5623223181953033290@kernel.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 9 Nov 2026 08:29:37 -0800
X-Gm-Features: AclHuK_xRb666DcBMeq7nMUJdxvBmF1ebBd9nIFEpYS4gnIiZ6jTsKhOnXkwP7k
Message-ID: <CAKgT0UeLnt0mngmL_rULfaROjrFj8hHPK-=4pRLBRuZSBMhALA@mail.gmail.com>
Subject: Re: [net PATCH 2/5] fbnic: Fix service task races with ndo_stop and
 PM suspend
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, horms@kernel.org, kernel-team@meta.com, kuba@kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 8, 2026 at 10:32=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 (1) =C2=B7 Medium: 2 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] Regression in __fbnic_pm_attach()
>   (drivers/net/ethernet/meta/fbnic/fbnic_pci.c): the patch moves=E2=80=A6
> - [Medium] The Fixes tags are incomplete.
>
> Pre-existing issues:
> - [High] This problem wasn't introduced by this patch, but there is an
>   unbounded hang across the RTNL drop between the two PCI error-recovery=
=E2=80=A6
>
> --
>
> fbnic: Fix service task races with ndo_stop and PM suspend
>
> This commit runs the service task's health check, BMC check and re-arm
> only while the interface is running and the device is present. It also
> makes fbnic_pm_suspend() cancel the service task synchronously after
> dropping RTNL. On resume, __fbnic_pm_attach() now holds RTNL and the
> instance lock across the stats reset, fbnic_up() and the device attach.
>
> > Fixes: 04a230b27d8f ("fbnic: Add logic to repopulate RPC TCAM if BMC en=
ables channel")
> > Fixes: 6ae7da8e9e06 ("eth: fbnic: reprogram TCAMs after FW crash")
>
> [Severity: Medium]
> Are these Fixes tags complete? The commit message calls the suspend
> problem "a worse one":

It may have been a fix that was picked up along the way. The general
"Fixes" tags are correct. Having the service task itself run isn't an
issue until those two bits of logic were added that introduced the
races.

> > diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/=
ethernet/meta/fbnic/fbnic_pci.c
> > index 09eeb4b4ded8f..09ae797b1f0dc 100644
> > --- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
> > +++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
>
> [ ... ]
>
> > @@ -558,19 +571,26 @@ static void __fbnic_pm_attach(struct device *dev)
> >       struct net_device *netdev =3D fbd->netdev;
> >       struct fbnic_net *fbn;
> >
> > -     rtnl_lock();
> > -     fbnic_reset_hw_stats(fbd);
> > -     rtnl_unlock();
> > -
> >       if (fbnic_init_failure(fbd))
> >               return;
>
> [Severity: Medium]
> fbnic_reset_hw_stats() now sits below the init failure check, so it no
> longer runs when fbd->netdev is NULL. Was that intended?

It was intended. I had actually recommended the change. However that
said I had overlooked the PCIe stats referenced below.

> Commit b1161b1863c5 ("eth: fbnic: Reset hw stats upon PCI error") put the
> reset ahead of this check on purpose. fbnic_reset_hw_stats() also handles
> a NULL netdev:
>
>         if (fbd->netdev)
>                 ASSERT_RTNL();
>
> A device in init failure mode stays bound so devlink still works. It also
> keeps the debugfs pcie_stats file created by fbnic_dbg_fbd_init(), and
> reading that file calls fbnic_get_hw_stats().

Now that you mentioned it there also appears to be a bug there in the
driver as the stats are initialized *after* the PCIe stats debugfs is
created, not before so there is a brief period where things can get
collected and then lost.

> Resume or AER/DPC recovery (fbnic_err_resume()->__fbnic_pm_attach()) can
> reset the hardware counters. The next read then goes through
> fbnic_hw_stat_rd64():
>
>         new_reg_value =3D fbnic_stat_rd64(fbd, reg, offset);
>         stat->value +=3D new_reg_value - stat->u.old_reg_value_64;
>
> Won't this subtraction against the stale old_reg_value_64 wrap? That woul=
d
> permanently add a huge value to ob_rd_tlp, ob_wr_tlp, ob_cpl_tlp and the
> other PCIe counters. The 32-bit counters would get wrong deltas the same
> way.
>
> The new RTNL and attach ordering doesn't seem to need the reset skipped
> here, and the commit message doesn't mention this change.

This will probably need to be addressed. I will look at updating the
patch or creating a new one to address.

That said the issue itself should be very minor. It would present
itself as a set of corrupted stats on an already disabled device.

> > +     /* Hold RTNL until the device is attached, so the service task pa=
ss
> > +      * fbnic_up() schedules cannot run until it will see it present.
> > +      */
> > +     rtnl_lock();
> > +     netdev_lock(netdev);
> > +
> > +     fbnic_reset_hw_stats(fbd);
> > +
> >       if (netif_running(netdev))
> >               fbnic_up(fbn);
> >
> >       netif_device_attach(netdev);
> > +
> > +     netdev_unlock(netdev);
> > +     rtnl_unlock();
> >  }
>
> [Severity: High]
> This is a pre-existing issue, not one introduced by this patch. Error
> recovery adds the NAPI vectors under one RTNL hold and enables them under
> a later one. Can a close between the two hang?
>
> fbnic_err_slot_reset()->__fbnic_pm_resume() calls __fbnic_open() under
> rtnl_lock() and netdev_lock(). That reaches netif_napi_add_config_locked(=
),
> which leaves NAPI_STATE_SCHED and NAPI_STATE_NPSVC set. Then both locks
> are dropped:
>
>         if (netif_running(netdev)) {
>                 err =3D __fbnic_open(fbn);
>         ...
>         netdev_unlock(netdev);
>         rtnl_unlock();
>
> The NAPIs are only enabled later, in
> fbnic_err_resume()->__fbnic_pm_attach()->fbnic_up()->fbnic_napi_enable().
>
> In between, __LINK_STATE_START is still set, and __dev_close_many() calls
> ndo_stop even on a detached device. So "ip link set dev X down" in that
> window would run:
>
> fbnic_stop()
>   fbnic_down()
>     fbnic_down_noidle()
>       fbnic_napi_disable()
>         napi_disable_locked()
>
> napi_disable_locked() then waits for bits that only napi_enable_locked()
> clears:
>
>         while (val & (NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC)) {
>                 usleep_range(20, 200);
>                 val =3D READ_ONCE(n->state);
>         }
>
> Wouldn't that loop spin forever while holding RTNL and the instance lock?
> fbnic_err_resume()->__fbnic_pm_attach() would then block on rtnl_lock().
>
> This patch now holds RTNL across fbnic_up() and the attach. The gap
> between __fbnic_open() and fbnic_up() is still open, though.

I will have to look into this. It will likely require some significant
changes to address. I am not sure if this is the correct patch to
address it in.
