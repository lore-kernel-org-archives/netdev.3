Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6252D43B6C9
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 07:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790149995; cv=pass; b=DO5sfgZbO7I9Rkj/t1YRufWZB9+llXXcQRYk8z4DmIxvWY+CC6hhEdxQQ0StHs3swG3z3YfL3aM1tpBFeNvBzinNM7RSUy+UTAb6uubuFVPwXUzrYwrQWh5GbpgV8GgfIHqWEX6vsfNOmZuARny1qWc+WGXDkswx5M0l2sIFveU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790149995; c=relaxed/simple;
	bh=C2cOOuI7fokFnvWV4gMQQKjXRE4B0fo66EYnxXaiu20=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=hQsa2I2T4R2SmqKpRPrBZlSR4M3XyCIO9V0rqClRlKPqbGEFNz4jn0lR2ycUpZughssTQ9SlSXfOMFSy7oHK6IGtCn+jDY/baMzrYggVr6xMiQIGiUjoG+60kP7ATyQJGhcowOU0tqXM20vS6JKx/L9yZcRF6ieEVyyKg3pvgk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alkira.net; spf=pass smtp.mailfrom=alkira.net; dkim=pass (2048-bit key) header.d=alkira.net header.i=@alkira.net header.b=NxhMpI96; arc=pass smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alkira.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alkira.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alkira.net header.i=@alkira.net header.b="NxhMpI96"
Received: by mail-pz2-f40.google.com with SMTP id 41be03b00d2f7-cc750a1482fso473676a12.2
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 00:53:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790149992; cv=none;
        d=google.com; s=arc-20260327;
        b=Vqv3GC2vINwANohrzw7rl9gJ5ZegtcOnxVn9jaI8MsS3ghuBbyZiDsleMypwo40iaj
         NdWK/Dn1ICzzp03+JtINysbRFxxdxr4wXK2LXsd5AbqXQ9MTfF15cg/OQDsVxVVEElC2
         uQ5Lb2pM6FuJAsRHaY94S7RfI/ofYhuAd88jNLa38kNFvqbMJYWmYk1J0TSTEhTIC+gU
         lEXsXOqxt51B719tmHVpxZe4s1DeD2u2YkvC/VL7UF2IpKBVn7CWGI7+56hRbGxYRDA/
         P8V2d931eADXCsoXGn3Y96O7K3ZfYs1ahZUDmHpMzMncXEpu1LiGdDXHxlxFw5StKyxV
         aHGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=/4zbsOJYMMKrOgOuYFJZifKVCeo7J1nWx9sorNtlsmQ=;
        fh=8MCWDVBoyfe0JbkKmWafBb+U5YLV6ejSASgvhoDnjgo=;
        b=CMx71zUSyAD81FZVzjLvsaNfGYPk1YgSFJR0F4anbexDy5+yXMpeaCJ+pQKiOO9UE5
         Pv7qeHani+KLTeabY8FwBz0aNw9WjAgj19cSpycXLP5tYlDkMpPRiftNi8Vq/iGznrDP
         futBu0n7Q9sgmyxulSTdtuEXElcNQ81h8gNV54UPHqHK6TSQ0Bd5em9boHWuXqxnC3D9
         gA5yM/jXu0x4V6XV9zxL+1Zz2Kei5jpWUI4PJa5n7a4MuzEKuKCBeZ+QE5FSsPWHIhaA
         LQNjAXJCDGwoe650ivChf2mwukhF0UY5tGgchPsAkCi6N3eqf99a4KEUpVTNdONAzAx6
         iXZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=alkira.net; s=alkiranet; t=1790149992; x=1790754792; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/4zbsOJYMMKrOgOuYFJZifKVCeo7J1nWx9sorNtlsmQ=;
        b=NxhMpI96JLbozaWmIp8jnas6hQ0iFN08HjM4vj5pnnClGunTCSqMVLbzPDDK9WPRPh
         v/1w2aYAbMnsPMQTd1XF9VnH0HC8+Yd8NuE9J7Rnq+MPAxnt2Xqqo6VkCf7cdNwNgJi0
         YpnsE9ACUfy/ue/mBJjRpGud07MXGaCIUkE1c34JntXbKIawherRN9w9COLuu/+xgeuR
         D14a4i8IGkb0C1hVtgiYZengMgdVfmqtHpZ4pYgvEINpXGuVnsN3wEia6NTo5rNvqT7l
         XZYf6fnlECuOUaj5MBapt3+ejL2yStVVp2PdhiBpMZjAAqjxIUPON7Rjyx43QcSFyftE
         X55Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790149992; x=1790754792;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/4zbsOJYMMKrOgOuYFJZifKVCeo7J1nWx9sorNtlsmQ=;
        b=2PBTyA0h9/5JSG3OKNZIAFrZjk50S4Zhrjfy1dII9mf7fRNzG2J8v0spjxHMn02bZN
         zyA+CDmC00uYeeGXoYLELQk+0gTNP+3U08Kt25FUAbIYJS9/PRqOuKJkuvfkfJx0+Tf2
         9ZuRkJogr5+EdGEfn2jYetxjbcHJ4HiUi3oGT3fWozOnublpoq/PffIi+g/qv5fx8ZXK
         gMILWSJAV+HWGVmVk0e1PP42LNBHp/nCeBODDzU097Ap5i/G7Qaa9XhkWLwrIr+6uMXJ
         xUBfhihnpSvXllTEod5EnbOx77e0g8eDtGViJiR8PryijqN1fFN7HgEQ2ZyMLVRSGoUJ
         Rplw==
X-Gm-Message-State: AFuF++mIb6YRzdGuypI+Edp0BZPqn5ZlQeCJtx+AgdET/QOK1DCHBZEl
	f5Tvql9fw2urnXsEmqWmSnaGvNKVnfVx85zuzv0eN19UmDejJ3JxSJ7A2Dw701Q/h6T1DySO/rS
	/550faW/QUJZn6jmGHAfGfZzW4sxtiLv/cFbdFA71Lw==
X-Gm-Gg: AYBFou3V660RhgRFfl3rYZoubEJbG2Sk91hhGqxkp07+1YANJ6S+D1FEK2u7BQrexMq
	hBxoYv2yj0wo9wnV3AfH3wi6ocjEAAWdZbumuviWoibTxlCehMJLnmtS7F+nimv5h0EggIA/PZE
	BOm6C5J0I82RzNn5XzGnc72qY5IBf8TddTCfxoidWICIbyBkV8HUfl9N0s8iDt6T8Qfb7wQi2sD
	JnnL1E24/9E+OFzgJew9YmUo0A4W9sv9TFwruMmOjxMCKkZRCOOObO9RsOfIP0sdezSMvfrlW4+
	YO14ngWBkdJ48vE5PKQBMe2eaMUR0AG93JBa3hi4ZbtFGKfQeJ+OjZY=
X-Received: by 2002:a05:6a20:3d08:b0:3dd:7a92:77bf with SMTP id
 adf61e73a8af0-3ddf79f1a9dmr2134734637.0.1790149992414; Wed, 23 Sep 2026
 00:53:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Kusuma DS <kusuma.ds@alkira.net>
Date: Wed, 23 Sep 2026 13:23:01 +0530
X-Gm-Features: AclHuK-K1F3kafhhFFVTAFUrnrPzX0Mgbz13X2jkHtNw218CJPf0ogJhVhczpNk
Message-ID: <CAMcJb7NLooAw=6Vyzbq-7JnE9L=gfTbLL0Y=L1pTFMTg3Vf76A@mail.gmail.com>
Subject: [6.12.y] Please backport 8045c0df98d4 ("xfrm: Fix dev use-after-free
 in xfrm async resumption")
To: stable@vger.kernel.org
Cc: netdev@vger.kernel.org, Chakradhar Kar <chakradhar.kar@alkira.net>, 
	Ramakanth Gunuganti <ramakanth@alkira.net>, Sripathy Ramaswamy <sripathy@alkira.net>, steffen.klassert@secunet.com, 
	sashal@kernel.org, dongchenchen2@huawei.com
Content-Type: text/plain; charset="UTF-8"

Hi,

6.12.y picked up a bug without its fix. Details below; the request is to queue
8045c0df98d4 for linux-6.12.y.

The issue: on every packet whose ESP decrypt goes async, dev_hold() is taken on
the ingress device but dev_put() lands on the VTI, because vti_rcv_cb reassigns
skb->dev without taking a reference. The VTI refcount is driven negative during
normal traffic, and a later `ip tunnel del` then hangs forever in
netdev_wait_allrefs_any(). The process is stuck in D state, unkillable, and the
netdev is pinned for the rest of the boot.

Introduced in 6.12.y by:

    4236c30b437b ("xfrm: hold dev ref until after transport_finish NF_HOOK")
    = mainline 1c428b038400, backported 2026-06-19, first in v6.12.94,
    together with its dependency af4b8c5e9d6d

Fixed upstream by:

    8045c0df98d4 ("xfrm: Fix dev use-after-free in xfrm async resumption")
    Fixes: 1c428b038400
    mainline v7.2-rc1; in 7.1.y as 63a300151999

The fix was not queued alongside the commit it fixes, and is still absent from
6.12.y as of v6.12.111. So every 6.12.94+ kernel carries the bug.

Confirmed on 6.12.96+deb13-cloud-amd64 with a strongSwan tunnel-mode IPsec VTI
under inbound load; kernels up to 6.12.93 do not contain the code and are
unaffected.

The fix touches only net/xfrm/xfrm_input.c, net/ipv4/xfrm4_input.c and
net/ipv6/xfrm6_input.c, against code 6.12.y already has, so it should apply
cleanly. I can test a 6.12.y-rc against the reproducer if useful.


Thanks,
Kusuma DS
Alkira Networks
