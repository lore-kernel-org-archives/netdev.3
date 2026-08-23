Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE72339372
	for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 11:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787486301; cv=none; b=XTWd/c/9RuhakOwnOeVZIjbd+QQuLnzLg4FtmHpe+/bMaSSRZL9JzSUTFCB0OBFLD4beG0DmRjBvFmDkWkkj0xVLLMfwR7KLEr153BBVcKOz5aJ0EyRXipf9tpiTlkLzcdXJSqtwcpWcZV905Kh+gV1GkYjauU57PbkDAbnovTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787486301; c=relaxed/simple;
	bh=Sga20T/P8MWq7f+aP48sgyMUgOEeXsNmwdBnKjmMyOY=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=Ve5mBAcXlq+8mbO3tlI7rQRvhFVKedAI4ceOajCNY1Ab/H/Zz/U5eP6Z4EzhaKJuBYsnASIYKPOhv5iraVpX1gt/YU/KGOW1sRycF2PZwu0KztdAqkArgGpxzHKGoFF79ivyP3E253RhyIipPMwVmK42YK4ZpiH5gFttEdJ/MuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com; spf=pass smtp.mailfrom=doyensec.com; dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b=LHweCiSd; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=doyensec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b="LHweCiSd"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c1600d040e4so383101266b.1
        for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 04:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=doyensec.com; s=google; t=1787486297; x=1788091097; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:content-type:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9VCdZ1UGkHSoNerNHN6y4WQf9dSCo072rCjQ4W0h48s=;
        b=LHweCiSdWbpEhMSMjNp5345PIVQ8k26Bhug1g4Qkr03Hljym0DYU8xo+KPrccA49Sm
         dnxVj9HIqHTEugU4Tlr50pxz3N8em6ZLOxIzpuZjEGblB0DqeMigYqLl2nT7eU96rMdM
         RlgQdKkFjUXfy9EOU794y/PE5BTPdklVsCVFBzy7VN+QxxnbimodvQX49C2XM5QoBxLP
         px8SkHU+bbjD8Q+8wULTnYLvKAapyc+CBmETDIM1W5M1SJ++kFj7wZct/9eHKZ65CUru
         BL3tygxrMCGIY/Be/C33LRczzUb1YW2nCVwUottkGClQhf6zUgCo3wRbuXl1rJQNdYBf
         Eu/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787486297; x=1788091097;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:content-type:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9VCdZ1UGkHSoNerNHN6y4WQf9dSCo072rCjQ4W0h48s=;
        b=eZD3K/7zrb5wJgilLvkcMLWNAKRVY8CxxH4C5aEv7AxGzeWonkXbwaNdUDIN6S1btq
         Uk9NjI7mEbAA1Jmh4bMv6jdh4ArzTVvyHmUcK7El+KYBLhWtYqDF2spb9SPbGyQbOm0E
         SC+K9RaFCqThELkrFCwW7kOWzDYMbbWPsu/9cJtCV0HN1mI/Z7mDk/YpkeFiWW73pq2z
         yYwq0P5pAEId0yk2CGS7FNIJ4rdJx7zzMAb3eQUf/LiQWlY5YHHHuvQ9SHUuRxhJ+oGc
         rkY739FWu9QhuPO5VZOFxsSkVf90alSv6WXaz3KFtp6dSgfyh8vFfbvxfAtcukuXFJEB
         d3hw==
X-Gm-Message-State: AFuF++kjfae83+1n3ivAErValXXdsB7/2W+HZGuKM208GokM6oi9HJ9z
	vstN45mW+ue7mWvfNmTCjcDsY+3e+IgyUCFsgqsvreYGHtsnbeHW/kXcMQP58jaOl/VpT+kYInk
	udGoIv342iaNi
X-Gm-Gg: AR+sD11FvMoyrbWY978NzVySY+Nu7PEqqN5nkOJmc0UQA9lTF0fTjnuMn+ZFfUY3f9F
	/07HqH68Tyg806fCZM8xszDy6AUh8HOmnnauLBfDTIq7whkFVU7FC1OiXdYR0n2Dm+pDCT27NZr
	j2G/nfGca2QauQNCUSlxv39NvOvUnbQ/v0a+xK7+f0AUeIxxBTn3BmvSB/tDDCK+YSrYdXvTwVy
	tIDpdRN6PMgrvjoiPRsbuQYyjKjFXRMof6bkaxEbHkylSKXgn3xaAcVqGAY03eIaK92NheyefW0
	8vQw5MovOi7wpo4zz184dR35lTrS5izihagMIgc5jDS6U6kXOp9kZOO9Mmc7mpy3+V8RMPJaJhe
	+W+u1sLm+RclCM90Bvcu+nVh6mTDG3X5p2I2EwpxiFx5wIHsVfwimz6hzH7qvUMK3cP+OFHUnC9
	x53y+uPlLspfr7nXMYz8sZuGiYxpf4xRaDeYx4s8Uy4FlFipEyTJ6uu9e0Q/VsM1dEz2W66PynB
	mFiDYw+SEAV9flckNz9oaHHV0tSoEZpg9Jg31R0mBTon5yiN+yHqXAN0DmpCd9lIzjmfTi75mie
	kcz1sdBVE2wlP9SHk5bG6F1JX26NloqhgRna3A==
X-Received: by 2002:a05:6938:a08b:10b0:beb:d461:7b09 with SMTP id a640c23a62f3a-c246dcc72afmr1228120866b.11.1787486297276;
        Sun, 23 Aug 2026 04:58:17 -0700 (PDT)
Received: from smtpclient.apple (host-79-57-139-67.business.telecomitalia.it. [79.57.139.67])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249685ab3csm762988166b.49.2026.08.23.04.58.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Aug 2026 04:58:16 -0700 (PDT)
From: Norbert Szetei <norbert@doyensec.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: [PATCH net] net: bridge: mcast: fix use-after-free of a master VLAN's
 multicast context
Message-Id: <B41EB55B-E5FC-431D-956C-503CA7B95C30@doyensec.com>
Date: Sun, 23 Aug 2026 13:58:04 +0200
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
 Ido Schimmel <idosch@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 bridge@lists.linux.dev,
 linux-kernel@vger.kernel.org
To: netdev@vger.kernel.org
X-Mailer: Apple Mail (2.3826.700.81.1.4)

br_multicast_toggle_one_vlan() clears BR_VLFLAG_MCAST_ENABLED under
br->multicast_lock before stopping a VLAN's multicast context.  That is
the teardown handshake: lockless readers gate on the flag through
br_multicast_ctx_should_use() -> br_multicast_ctx_vlan_disabled(), so
once it is cleared under the lock no reader can arm the context again.

For a master VLAN the handshake never runs.  __vlan_del() clears
BRIDGE_VLAN_INFO_BRENTRY before calling br_vlan_put_master(), so
br_multicast_toggle_one_vlan(masterv, false) returns early on
!br_vlan_is_brentry(vlan): the flag stays set and br->multicast_lock is
never taken.  br_vlan_put_master() then drains the context in
br_multicast_ctx_deinit() and frees the VLAN through call_rcu(), while a
reader still inside rcu_read_lock() sees the context as enabled and
re-arms it.  The port and port-VLAN branch of the function has no
br_vlan_is_brentry() test and flips the flag under br->multicast_lock,
so it is not affected.

The reader is the bridge transmit path.  For a master VLAN
br_multicast_rcv() selects brmctx =3D &vlan->br_mcast_ctx with
pmctx =3D NULL, so IGMP sent to the bridge device re-arms the context's
timers after br_multicast_ctx_deinit() has already stopped them.

Any user able to create a bridge can trigger this, which includes an
unprivileged user in a user namespace, by deleting and re-adding the
master VLAN while sending IGMP to the bridge device:

  BUG: KASAN: slab-use-after-free in detach_if_pending+0x412/0x4a0
  Write of size 8 at addr ffff88810ac39918 by task brmc/601
   __mod_timer+0x51a/0xc50
   br_multicast_host_join+0x25b/0x390
   __br_multicast_add_group+0x468/0x530
   br_ip4_multicast_add_group+0x1a0/0x260
   br_multicast_rcv+0x2cda/0x61e0
   br_dev_xmit+0x6c4/0x1540
  Allocated by task 610:
   br_vlan_add+0x111/0xb40
   br_vlan_info+0x370/0x3e0
  Freed by task 0:
   kfree+0x1a7/0x4f0
   rcu_core+0x7dc/0x10a0

Only test br_vlan_is_brentry() when enabling, like the
br_multicast_ctx_vlan_global_disabled() test next to it.  Disabling then
always clears BR_VLFLAG_MCAST_ENABLED under br->multicast_lock before
br_multicast_ctx_deinit() drains the context.

Fixes: 7b54aaaf53cb ("net: bridge: multicast: add vlan state =
initialization and control")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: Norbert Szetei <norbert@doyensec.com>
---
 net/bridge/br_multicast.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 75e1e2a8fc83..3ef5d8bbf552 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -4377,8 +4377,8 @@ void br_multicast_toggle_one_vlan(struct =
net_bridge_vlan *vlan, bool on)
 	if (br_vlan_is_master(vlan)) {
 		br =3D vlan->br;
=20
-		if (!br_vlan_is_brentry(vlan) ||
-		    (on &&
+		if (on &&
+		    (!br_vlan_is_brentry(vlan) ||
 		     =
br_multicast_ctx_vlan_global_disabled(&vlan->br_mcast_ctx)))
 			return;
=20
--=20
2.55.0

