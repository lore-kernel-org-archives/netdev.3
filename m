Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8515630AD1A
	for <netdev@vger.kernel.org>; Sat, 25 Jul 2026 23:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785022903; cv=pass; b=RragYIJtCO+LXdn5VYSM5qWy8ZZ1IHhECdOE8mV7AIgWB+dtkk+eMsMOF6ggIvhMGuJxg/ISEWyh5LO8POTeVjJxzMMKPKe6lLmiCdgeCElKbHzAnxVY5OG/lMHci15WyoS4/6OE5qcrADoRnHJWOrGlfPOHiqV+gbe0UjE2pGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785022903; c=relaxed/simple;
	bh=gS5i7U/zq1diMITl3QpprFQoqO36+GM3kv6ZsgZzV68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e9Qo3XbPGVWkn23TyCX/5mxJBQ0t196+SauWnOGNO+KfmZsV3MMDIEeG+rfeU5uuXEWPcKFbacCn57a/ccZ9PqhygQMmtKlbzRVT7LjMZ6SBb2G/hcxkD6NF52EtLZEMILuPJ/Nc76FtpRCK3xC0qyD9nCOiz1V4VkAdlVH3ow0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=pbeZV3va; arc=pass smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="pbeZV3va"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8487088510aso1346034b3a.0
        for <netdev@vger.kernel.org>; Sat, 25 Jul 2026 16:41:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785022901; cv=none;
        d=google.com; s=arc-20260327;
        b=YcYZPHSoBaup8fCScjTRQ83+1cquuRiAcXSDa1lnupBgJqCiQT7YMy7UCje0CXUenS
         UafeOhS89V26u3WySAnJ98643Qs9UGl/U7dArik3+0D0npG4iTiDz8thlCp1KrGHPRS1
         5cYMwpcHQPcPFAlKcT3wt/vmBkxQ6zZHF8gTeJVVG+pa91TLaZtbogaK4r8RzdansbIb
         +Jq/Uz+fWcwCq4A4YSZf4aj5ojMIzoSMwwckCznhnxRZ/cO9vEJGI6OmKuWqAXmvuPhB
         zJ1eOiVYA8RIFGwZwmY4cmwv/nrjpNXfd+VeQv0etESm+g2Z3+syHVag939cpMcoS1UV
         bavA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SKU69/Q8Mz4r7iWPxiIu86XOpmNLwZLF9ocXBoyOZ68=;
        fh=vVaihWUqMIoMFnAE7WhdqA9GFOUqQsgjuZsfkiiZrdQ=;
        b=pdFF8++zOPIRdKmeEBwNwgidhdnoDlyPiEe8P2wiRAvcjh5fKUaycwx4xHHax6+eWa
         bQRqVcRtwtqepHPV4uKyezjKuVVhc6EQpWbAYCgMsXRlL2Sm+vMwjaXYkEKXhagWDV6Q
         hvlQLQWUA1kXkAOH39mllLnlWaiFcCPjEEVWb657M/lkdawlNcbuQxhW+17X8NDqe6YR
         sBj7xu45SEg977p6mmscLKlnuY6i8bVb2i7SkcXk8qUB0vZw+HjkLMSvzQjQXhyQ3ojb
         yLcRXql46xCiK3bPMHe8lsIQL1KI8n1HQiHvrLlOqhGclZu9u8krMBaUkye3PpgUYlMg
         c0mA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1785022901; x=1785627701; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SKU69/Q8Mz4r7iWPxiIu86XOpmNLwZLF9ocXBoyOZ68=;
        b=pbeZV3va8nuwPFAjsiSefApu78bShbJ9qigKa5eRaCVfb6/UoAQ9St1LP2fl0Xqmc8
         obByRcYCjzdC4y/r3qMt2vx4y2OVLWZbKUM/ebGWqm+a3kxC6EeHGqrPDFJUdV7ES5nr
         Rp6KQ7bWFb5n6RFcO/Gs7oTsRfXXCq/g93fI1lNz4zaiEG9qXXdtl9K4pMnLLtg54zRl
         gj3PF8I9wHkVOTbRjNbQZPQhe5sE7ArBekAqlO2LmJaYIu8dbrNLSSn0xhVRGWnlPGT/
         qjdVrb0gd0wcF5M8yz0kNw++D5kn1oFSM7cQLJ9R+Q4NkYTANnNXqZzpaK9Jy7g6azjX
         t6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785022901; x=1785627701;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SKU69/Q8Mz4r7iWPxiIu86XOpmNLwZLF9ocXBoyOZ68=;
        b=T5gYwFKHSPSe4DrAbeFLsNJWEAv4HPJK5kcpY8iQMmA8ZiqveSqY4nc/UmNi4yZ0Ls
         TQu0WZ4tM1YBwHHEYybV2axT2XXRRNxfRTU2qXcCTBskOyb4l4Gtqfdnpys3p2XPI1j8
         dtFSSFySe+3MFO0vz5eI0yaBiAnZpvHnYjSGxvz00Ehj3mhd7Jo16bGHr5uKe+RNgZ3Y
         hxI3GqL6BdluIq27sXWtfWqYTQSV6uCzJnBEj+tSHarcGvx/VVbc66/9ToTFJ6DjEybI
         YGusrppgIbP3k/CYcfeptR3vpIoxQWY/gqoYHRMFPs1hYs6gCUM+ICy0dBb5lsyxBMeD
         hYoA==
X-Forwarded-Encrypted: i=1; AHgh+Rqmqr8boPpiNrqBujQIVtBCrRS5YSOvDLKkqjP0T9BvMGs/tljDw+evvFmA75CsckLUnatjST0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfLdVr3uY2gozMBKOSo/+8ve5CyGSDv6XTdkU+pCGZ+v6D+YuX
	UI91ZWFjunXZskUUpmugp5Iu7bM2tEnB841KJz3obnCgAlA/1D+BdV9RWg6M+sTKjmbnbEFdpzN
	24DSZp1rx1+fOca9NqD0rgTc5vkabgligB2f0wzm7
X-Gm-Gg: AR+sD13svGG7Y7ff/4xIIR+uKK8u0ols7iIxU3P7iYtTzDBoqbUN6Dyv2v63iJH4ehs
	XXMR8lHVWtQMiHqrS6Hr9BCpig6u/addfQUpnpU7M461yTIkMa+j86vPKSK8wlPqmgMhBKeJDtF
	frdod7q466d1yP363VMy/Wdvmz1Wx325R+YzcsucYpSgVskHHY9Xk1c+1Nmy3VNImmg/JPMPIdZ
	cGc0/Ma3CSa2x62b66XM2UC7peTaEJ+KpOld8Z7IVqlEyG9eGaGJ7Qh2q3taWvnmWHqqtny0o+v
	Z964qu0heH+/sX6//A==
X-Received: by 2002:a05:6a00:12db:b0:848:727f:2c90 with SMTP id
 d2e1a72fcca58-84e5958a446mr2692694b3a.64.1785022900786; Sat, 25 Jul 2026
 16:41:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720223400.1939998-1-xmei5@asu.edu> <55429a5a-c9c9-4cbe-850a-ae983674df02@blackwall.org>
In-Reply-To: <55429a5a-c9c9-4cbe-850a-ae983674df02@blackwall.org>
From: Xiang Mei <xmei5@asu.edu>
Date: Sat, 25 Jul 2026 16:41:29 -0700
X-Gm-Features: AUfX_mx_pXX9lnSBX6n3Xb8HInve9KceepEqzhbBDkfnA77pZke4HvNwzrgqWLY
Message-ID: <CAPpSM+RJ7gK8MGyA=VKpsd0uSVHypXL7a3B01LUWkNz3vvduHQ@mail.gmail.com>
Subject: Re: [PATCH net] bonding: alb: re-check primary_is_promisc under RTNL
 in bond_alb_monitor
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, AutonomousCodeSecurity@microsoft.com, 
	tgopinath@linux.microsoft.com, kys@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 1:22=E2=80=AFAM Nikolay Aleksandrov <razor@blackwal=
l.org> wrote:
>
> On 21/07/2026 01:34, Xiang Mei (Microsoft) wrote:
> > bond_alb_monitor() reads primary_is_promisc under RCU, then drops RCU a=
nd
> > takes RTNL via rtnl_trylock() before undoing the promiscuity it set on =
the
> > active slave. In that window the active slave can change under RTNL
> > (RTM_DELLINK -> __bond_release_one() -> bond_alb_handle_active_change()=
),
> > which already drops the promiscuity and clears primary_is_promisc. The
> > monitor still acts on the stale decision: if the slave was removed with=
 no
> > failover, curr_active_slave is now NULL and the deref faults; if it fai=
led
> > over, the stale dev_set_promiscuity(-1) underflows the new slave's
> > promiscuity counter and pins it in IFF_PROMISC.
> >
> >    Oops: general protection fault, probably for non-canonical address .=
..
> >    KASAN: null-ptr-deref in range [0x0000000000000000-0x000000000000000=
7]
> >    Workqueue: b42 bond_alb_monitor
> >    RIP: 0010:bond_alb_monitor (drivers/net/bonding/bond_alb.c:1600)
> >     process_one_work (kernel/workqueue.c:3322)
> >     worker_thread (kernel/workqueue.c:3486)
> >     kthread (kernel/kthread.c:436)
> >     ret_from_fork (arch/x86/kernel/process.c:158)
> >    Kernel panic - not syncing: Fatal exception
> >
> > Re-check primary_is_promisc (and curr_active_slave) after taking RTNL s=
o
> > the monitor only undoes an increment it still owns. The other bonding
> > monitors already re-read state under RTNL in their commit phase
> > (bond_miimon_commit/bond_ab_arp_commit); bond_alb_monitor() was the onl=
y
> > one acting on the pre-trylock decision.
> >
> > Fixes: d0e81b7e2246 ("bonding: Acquire correct locks in alb for promisc=
 change")
> > Reported-by: AutonomousCodeSecurity@microsoft.com
> > Signed-off-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
> > ---
> >   drivers/net/bonding/bond_alb.c | 10 ++++++----
> >   1 file changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_=
alb.c
> > index 2d37b07c8215..70458c5b23cc 100644
> > --- a/drivers/net/bonding/bond_alb.c
> > +++ b/drivers/net/bonding/bond_alb.c
> > @@ -1535,7 +1535,7 @@ void bond_alb_monitor(struct work_struct *work)
> >                                           alb_work.work);
> >       struct alb_bond_info *bond_info =3D &(BOND_ALB_INFO(bond));
> >       struct list_head *iter;
> > -     struct slave *slave;
> > +     struct slave *slave, *curr;
>
> please move this up to keep the reverse xmas tree ordering
>
Thanks for your review and reminder. I fixed the ordering issue and sent v2=
:

https://lore.kernel.org/all/20260725233930.2957317-1-xmei5%40asu.edu/

Best,
Xiang

> >
> >       if (!bond_has_slaves(bond)) {
> >               atomic_set(&bond_info->tx_rebalance_counter, 0);
> > @@ -1597,9 +1597,11 @@ void bond_alb_monitor(struct work_struct *work)
> >                        * because a slave was disabled then
> >                        * it can now leave promiscuous mode.
> >                        */
> > -                     dev_set_promiscuity(rtnl_dereference(bond->curr_a=
ctive_slave)->dev,
> > -                                         -1);
> > -                     bond_info->primary_is_promisc =3D 0;
> > +                     curr =3D rtnl_dereference(bond->curr_active_slave=
);
> > +                     if (bond_info->primary_is_promisc && curr) {
> > +                             dev_set_promiscuity(curr->dev, -1);
> > +                             bond_info->primary_is_promisc =3D 0;
> > +                     }
> >
> >                       rtnl_unlock();
> >                       rcu_read_lock();
>
