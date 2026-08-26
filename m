Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786A03BB10C
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 09:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787735564; cv=none; b=PPjD9sdskoJjZFC7TPqlY7XumE+sfwcdx0TkZdtO6EmBR3AbFdrZkRxp0RSOJlBwhxSPfKLDd7q7O84pCUDSvwWUN5tOBc05I8rUgHfRfmuMAFHXu40cdiARu03EZ88gS72YVqqv19jVjM6w/cllrTJE4kfZuq4GGuhXIj9D5dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787735564; c=relaxed/simple;
	bh=aJcop90w13DJ8VL98pNvskWWLzcXM7bekHcMKkoIZbo=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=nuChsphFkvfkvPBZ0Q1yG4kD03jyuHdh/Cun/pDSJjC4IpOURmPeOkY1XLKsvo82wX0uDYhr5tW4+vjkVX6otrgjuirTvd5Oj59OHIHitpXGhbPujCysW0UEAN3SFd1iLznqy1SbV2ZloAslGwfPrpbMiBCXkJHoYQEcG6lbMnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com; spf=pass smtp.mailfrom=doyensec.com; dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b=UUlvCU66; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=doyensec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b="UUlvCU66"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-69f7fa1c548so1329615a12.2
        for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 02:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=doyensec.com; s=google; t=1787735561; x=1788340361; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:content-type:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yzTkADWqxMGZG5YtmI2G+L98ZjXC8gtF2MPGuaf+Q6A=;
        b=UUlvCU66Rqi9RTpWluFM2BTykumV2iF5dD4bIzRjmAjzZ2yazIf2WaqSDZsRmGYNK0
         0GG73cbppF3uJFTM4DkmTNOvGMOud6CfpYf+8w8Gnc9l6MRpAo9CqeJ07jTLMV93/lak
         Fqw3V/o7Z9zAOWvulMubqRtDlcrMOLNttTcQn7i2NNyP244gYhhGwvJIIzsIK/EmRjI2
         Qay/wmtcZAf5b8UvPS8GNdCTTUtMl6p+3z2nXbB/m9CGbRnbkzMbpGw2q8iK4jqRnjKl
         5hsFD1nrvksrgqiIT6mEKFeCXtY8geEiQ8GRmOEamRvTmEvlOo8Wbcvs5cp/u6Cv1ij5
         cN1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787735561; x=1788340361;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:content-type:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yzTkADWqxMGZG5YtmI2G+L98ZjXC8gtF2MPGuaf+Q6A=;
        b=nFsmPDK53Gpw+NBr0fAsKVZeA9l4KmmhUs3EEYZ18WX6bVl0T34jDhvOO9jMCfRck0
         igi5YNLmoAd/ZjO8FGrcMuzW1IuFBC6MhA3Jz084pK4QwPK4jEC5XywbkvgUdspTHnII
         tuzPM9sfRHzcgWtsjtCe1bfGEX9CbMAM7pMN0MM1kzposFxUAdXXjRiHHS650UJ9lIX7
         ZknZINY+AwuO/06ogYcuiuILXdqcqR133CGkI/DjHDJNvRtKWMSM2H1RP7C0U4EFya/m
         VmyNkVCVUXLaqQ10ZhY0PBZBkLi7fXqzwpwIKXA/c59HI39NX7Bg9JJ5YUwR6CIJ8ymB
         9Qbw==
X-Gm-Message-State: AFuF++nw7NhqbAE24WKVJ6LAWOd4vAHhJQuxmcLN2gvoIAXI2zSRL40W
	4QdzTeogEuPpy9JL0Cf4n8Nmbf1oreeq+fiBsYUp6mDUOz7CqU3PCsXiSklDJsdUUdV0Cl7jVFw
	Ox9lXIteSbg==
X-Gm-Gg: AR+sD127VQe/1DEqqL7zFZOoOxojDw+St0DboOB6nP1r2PMSIuHrxYtMKu9i7FC5Lol
	8PgTqncp8nzYdVDpilg7es9BJSMW4yOEMfHiuy8NS9YyGrvnjc6+I3bFJ7sQi1R3V1uLnrrXugJ
	OzQpjsK9WK/6y89B5+QqyFGqA1q5v/WkPOXjWD2rEWAYH5kwCYUdoRqnr16roIlll6XoM4HV/dI
	FffR8wDzyA3j8N2cNSGb0JQNQq61kySq2RSrlFU1SZvVTKZpdP7puLRHQus3ujJR6XrG2+hypve
	NaMoJah4r2m5oMNjJxrOu7pDyLaGIJdfaw6UjYbb0cFSc8ZpNNOM17Z/1NsRcxO1qRLgm4w+8x5
	KCaB3xcGIg27aHhYTPFCaJHtX8Ll3bpgONhYuL63ZctldtpjNjKZhk0a373JmeG5yr43mQNvIQY
	goFBVy8zNtAN+clkeRzcCeX3uSrJCfhoRkcNZI1iJZ9UcLSwoB0BvLBVte/DNwRzZt2T/r48tD8
	R8llbLyQMDCgMvWVkRKBlWVWy1EX6z/P7byi3Qu+jqlsr46/npO9LjOTyxESsup6u7oIvovUF9R
	ltPS2Dy/mG90MWi78sssYWC2BY/+exkPe1MBvtmWcf/3CQ10
X-Received: by 2002:a05:6402:5d0:b0:6a3:87b7:b516 with SMTP id 4fb4d7f45d1cf-6a5df6292e0mr7506777a12.6.1787735560457;
        Wed, 26 Aug 2026 02:12:40 -0700 (PDT)
Received: from smtpclient.apple (host-79-57-139-67.business.telecomitalia.it. [79.57.139.67])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a5dea8388fsm3466565a12.19.2026.08.26.02.12.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Aug 2026 02:12:39 -0700 (PDT)
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
Subject: [PATCH net v2] net: bridge: mcast: fix use-after-free of a master
 VLAN's multicast context
Message-Id: <D400F6C7-543A-4B79-9E5B-D1D8974DE5C9@doyensec.com>
Date: Wed, 26 Aug 2026 11:12:27 +0200
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
Changes in v2:
- drop the paragraph above the splat, per review
- no functional change

Reproducer available on request.

v1: =
https://lore.kernel.org/netdev/B41EB55B-E5FC-431D-956C-503CA7B95C30@doyens=
ec.com/
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
2.55.0=
