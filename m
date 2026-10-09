Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE81F4582C8
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 06:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791528875; cv=none; b=KGxPztkanp5vnu1qC1h+Q90g9PkLemLlhfJ/9SlCrVBtf/+F6Mg+3+DoUTTpsfX6AlZDbX1HoQM81PU2l5vewpKBKWLf3BYLgSZIULpQ3PsZJ3Qz+aU8sWNZXkQqqQZb1onjuAg9bG7iQjp4XRNJyC2eQ6EQYTIYayw6W9mWRzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791528875; c=relaxed/simple;
	bh=T6CW6eIIjDRuMCeNkO+47KQJAuDB8lChFB7dh7ew3tc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nT5Dl/pQWgF1Yt7cQL2d7xcArzGbxnaIEMoxkvDWtJ3uoQ9R63ChHZ68ED08cgfmPACC+3zaSJvAUEf5QAwqRoCkeq/gDbXTICISirdnBSfRcTHy6lU2SimwGcauLt4FiVhwkZaevdSoufMjZSkTNW+ZBne1qwICEAZ7Eb69qZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YiE6B6Je; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YiE6B6Je"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 848F61F0089C
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 06:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791528874;
	bh=06QBzCXNVWA52XqK4TOlg6a6r68c0bAK18RCVlbai3E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=YiE6B6Je3umtVXzq3Mr+gELqjv3GxQE7GXN7wwK0TExP/3MbmJsoDIRnju8Nz8+ps
	 e0edxCcemk8F7VGCZ5lyC5nc1jtcwu+vZjO9+pWzWJUW+xYRztYGmu7mFOd9umi+bH
	 cTaQ0P0cAqp+0dNQXtUe83kWmV8Os5YN9BmbScbQ2dJ2Oph+3F9Shzim5sMRS383Tv
	 0kzs6j4BoH+YKOvnzd7Z/0zHdC2zCSiNMBIGFQOmKtV3UiRWEfyRpUSa4BQN0bJcJ+
	 3yH/ZIuFI1S5V+Ebr4ZnTs4PkRXNN7zAwyttTCYSrlhI0bJ8LCSvUXlI5RC2sUPA6U
	 NkvF4Lf+i5Cyg==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6c8f6a53fabso1327434eaf.1
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 23:54:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBx0arCft2usQFDkFuGjSwATgoLnM9hYnZQwW/u0V82sGIUADHFYqFFXtwW7jyCsqAkazdJvTs4=@vger.kernel.org
X-Gm-Message-State: AFuF++mYS2XT9yc935ZZRjInfAVU4BLnglUztE7DwZEB4iE+tUs8Hxbw
	fCGIyib3T8SROmBOu6iRRirz6fCT1lpKyaKGDR8g8k+dPjl0Az1M26Rwou9VJE9hetPXTZpOVoc
	kB0p9YGRvkbRYe9I36WqoGf9/yN7esYs=
X-Received: by 2002:a05:6820:c98:b0:6d7:294:ef93 with SMTP id
 006d021491bc7-6eee58f58cbmr865984eaf.68.1791528873851; Thu, 08 Oct 2026
 23:54:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pm-ip-core-objects-candidate-0002-v9-1404514d79dd4560c571@gmail.com>
In-Reply-To: <pm-ip-core-objects-candidate-0002-v9-1404514d79dd4560c571@gmail.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Fri, 9 Oct 2026 08:54:21 +0200
X-Gmail-Original-Message-ID: <CAL4WiirhPWmWCnPLHJVp8vXUvPGo6CQ6HC0ZmaEzYXmP8uZtzA@mail.gmail.com>
X-Gm-Features: AclHuK_4rc-K38AyJ0dtzz7KoSpe9qNAcpD0zjCYRCssCVISK54w2IqH9Ba6080
Message-ID: <CAL4WiirhPWmWCnPLHJVp8vXUvPGo6CQ6HC0ZmaEzYXmP8uZtzA@mail.gmail.com>
Subject: Re: [PATCH net v2] ipv4: prevent in_dev_get() from returning a dead in_device
To: Cen Zhang <zzzccc427@gmail.com>
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, baul.lee@xbow.com, 
	baijiaju1990@gmail.com, jjzuming@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le ven. 9 oct. 2026 =C3=A0 08:21, Cen Zhang <zzzccc427@gmail.com> a =C3=A9c=
rit :
>
> in_dev_get() samples dev->ip_ptr under RCU and unconditionally
> increments the in_device reference count. Device teardown can clear
> the pointer and drop the last reference after the sample but before
> the increment. RCU keeps the allocation accessible during the lookup,
> but does not guarantee that a reference can still be acquired.
>
> Commit 9d40c84cf5bc ("net: devinet: Reduce refcount before grace period")
> moved the final put before the grace period. A zero-count increment now
> warns and saturates the count, but cannot cancel the RCU free that has
> already been queued. Returning that pointer lets callers access the
> allocation after leaving RCU, when it can have been freed.
>
> Use refcount_inc_not_zero() and return NULL if the reference cannot be
> acquired, following the in6_dev_get() fix in commit 0e243671bc7b ("ipv6:
> prevent in6_dev_get() from resurrecting inet6_dev"). A successful
> increment retains the object for the caller. Under RTNL, a published
> in_device still has a live reference, so reference acquisition is
> unchanged. Callers already account for a NULL dev->ip_ptr result.
>
> The RTM_GETNETCONF handler already checks for NULL and can keep
> RTNL_FLAG_DOIT_UNLOCKED. This fixes reference acquisition in the helper
> rather than serializing that one reader with teardown.
>
> KASAN report as below:
>
>   BUG: KASAN: slab-use-after-free in inet_netconf_fill_devconf+0x748/0x79=
0
>   Read of size 4 at addr ffff88811d70b958 by task ip_core_fixture/498
>
>   Call Trace:
>     [...]
>     inet_netconf_fill_devconf+0x748/0x790
>     inet_netconf_get_devconf+0x41c/0xe40
>     rtnetlink_rcv_msg+0x7b9/0xce0
>     netlink_rcv_skb+0x133/0x390
>     [...]
>
>   Allocated by task 496:
>     [...]
>     inetdev_init+0x60/0x550
>     inetdev_event+0x71e/0x1780
>     [...]
>
>   Freed by task 0:
>     [...]
>     kfree+0x12b/0x530
>     in_dev_free_rcu+0x51/0x90
>     rcu_core+0x661/0x1d10
>     [...]
>
>   Last potentially related work creation:
>     [...]
>     __call_rcu_common.constprop.0+0x76/0xbd0
>     in_dev_finish_destroy+0x12e/0x190
>     inetdev_event+0xa37/0x1780
>     [...]

This is very confusing.
The changelog shows only the KASAN splat, which is really not that
interesting here.
The refcount_t: addition on 0 warning that must precede it would be
stronger evidence, as in the IPv6 commit.

So this looks like a modified kernel or something like AI hallucination ?
Please elaborate

pw-bot: cr
