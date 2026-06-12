Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE21931280C
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 08:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781254788; cv=none; b=L2Ql3EzGI2rl7xffFmxxvSmxdMcz+z0sRGD9X9QuZRtvx9fBAJ76x3/EmOpoycMpVE+shhanaYQascnKHsb58Q/UuL9Gybg5EIkz5G7tIFcIsq475LCSpW37Jh30NrB+1vACUpr/ybEwys6HNuDJ5SdHOIk396LiO5103rk9a08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781254788; c=relaxed/simple;
	bh=V9K27Z1kCTaIw8JicL5nH448Qqv6eCiY4PFrU2QptTA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QEHK8lAItM4rU+4g7N847UAgcRDN2zThiFLLDztpboCXNIYot6igZO03XD0O6X5TqNX8gymtVeNDppmFruEhLuiJfSrKRMYgiABNxxGUy1aCdewlOX/Ayw3vypbUHQdJ0AIn3zNXTHS3TWSvRPedplftv1d2oHBgT+bALdUpvdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kUd4WPyZ; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUd4WPyZ"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-84236f9b638so442928b3a.2
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 01:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781254787; x=1781859587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JT58991Fc/kvJc/k1XrxFwWPuGlglWdrNDxsq4ctiO4=;
        b=kUd4WPyZg8mRDSmjDki8oiCqhOyd4qOhFOt1p8oKzzw26s9v7rCBRi2hsJUB6RqAPo
         uWPMJo6qcf8Mfn4c7x/HD3dOfcZdshwO6yDFa+cKxFgThsgsiU+tei39zAY1yFNrRrG6
         5OaRudDeWvMpOg61bZjooq3uvG/0Zoh0TB/1YeRhnbt9859AuQdf6Wy8CV2CKyfyism3
         7HwUaJQv7Rs8T7Uq8j4GKfTwyjloY1xptmBJ8LM5gMwsWQVGAD9WyFeXx02T/bHOforC
         FWMJT88/G4n8zo0T8B078VeOyvq5nsZOfip7wlY9JHkLLhYrKzUsC9jAlkAH43VFNXxQ
         do5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781254787; x=1781859587;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JT58991Fc/kvJc/k1XrxFwWPuGlglWdrNDxsq4ctiO4=;
        b=mB/yvPOeoIHdasNkE9C241FdN/9b4HE8x0nOqBJ/zwVs4IVhOX4G5oi8g0yBRNaNUZ
         LHMbnTnBJ7fXTVWgdcL3e+xqPf3C74NgKRwsN5AbSskTAgjF8HzLslgqmGm9W2P8tgrw
         cUcG1ZxkPR/H31XI2En3AMTqNhme6xBqrhd2MQRa1U7YWE5kZhyRpevhMqZVjiKZKQiO
         5i/Uk4QACMauaWs9LEtknFAVdt1ZeY6f1rvwqR/5hm6JKHAuDD0BQqz7o1OIImwg2qCo
         Jl5mLJ9uoTQu3CkVbQptjSrlxemaXWw0wvMkuNsnh0jmVvBkPUgNwoF0aLuZG8k1l3Sn
         2Myg==
X-Forwarded-Encrypted: i=1; AFNElJ8v+BgbEi+49VHugy7mGY8KVjTgKb3uPQ29pMHe64Hnr+4QMzNZocvXvIHJueZBVpvQw00zzvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0e5Ku1Pn7YVnd3O6Lfw6DHDcifH+R2h0/tdzE0SWr940Y5xqB
	INssjDKRnFIuH+80ur7Txw8T0NFgaYco3loocvP8UByYLmJ6iGXNsMf/
X-Gm-Gg: Acq92OFjg8rf/IEGbMSGsBGdHRp0CyE4i/+1V5QqRwMmDhi5352RTsptVpEfdTyPMeI
	nrP6q3QvvRhNdiUpSHtg+nSBd2rjoy6cdi0gO1FPWKLayVuz5rDw4rboQZf0MZVW5JI6np+iSwB
	SLiQh0alG0w12h5SRFpOYqj1CQVxbHTC+X3kvrvWVsDou1WJVxZI7TR4Zj2xEY5taOA6FVlt57n
	d0v+b8sLySoX47xdKDiPOheng43k+14+Lq2vinhF6LT4Nu/2qdgFht9jowJyw46DjXP8us+y4Ld
	TXxSxrrgZlAxWmBn8lrydp4dcTABkSIi0k0G9IhuxLIQM3fApj+NdH3ChsucX5B4JDqFmcCoIBk
	JnGI4gxEOz8YysfXyVwaRt1AmjYoUOan0Ri6ZFakOTDaa5owLnIOVinb1VHLItLqhLYcPBXSaNs
	mkmI27/3bT5OIZ7c191zcE7W5HO/pKnlt2/mAGQMb1cJkWjp0r
X-Received: by 2002:a05:6a00:301f:b0:842:7296:dba with SMTP id d2e1a72fcca58-8434cd49168mr2176839b3a.7.1781254786995;
        Fri, 12 Jun 2026 01:59:46 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434a934a97sm1646892b3a.0.2026.06.12.01.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 01:59:46 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Xiao Liang <shaw.leon@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Maoyi Xie <maoyixie.tju@gmail.com>
Subject: [PATCH net v6 0/7] net: require CAP_NET_ADMIN in the device netns for tunnel changelink
Date: Fri, 12 Jun 2026 16:59:34 +0800
Message-Id: <20260612085941.3158249-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A tunnel changelink() operates on at most two netns, dev_net(dev) and
the tunnel link netns t->net. They differ once the device is created in
or moved to a netns other than the one the request runs in. The rtnl
changelink path checks CAP_NET_ADMIN only against dev_net(dev), so a
caller privileged there but not in the link netns can rewrite a tunnel
that lives in the link netns. Commit 8b484efd5cb4 ("ip6: vti: Use
ip6_tnl.net in vti6_siocdevprivate().") added the same check on the
ioctl path. This series adds it on the RTM_NEWLINK path.

Each changelink is gated at the top of the op, before any attribute is
parsed, because the per-type parsers can update live tunnel fields first
(for example ipgre_netlink_parms() sets t->collect_md). The check is
skipped when the link netns is dev_net(dev), where the rtnl path already
checked the cap.

The check goes through a new helper, rtnl_dev_link_net_capable(), added
in patch 1 next to rtnl_get_net_ns_capable() in net/core/rtnetlink.c.

Tested on net/main. For every tunnel type in the series a migrated
fake-root changelink is rejected with EPERM. For vti6 SIOCGETTUNNEL
confirms the link netns hash is left unchanged. Legit non-migrated
changelinks still succeed.

v5 -> v6, addressing Kuniyuki Iwashima's review:
 - Correct the Fixes: tags to the commits that first added x-netns
   support / namespace changing for each tunnel type, where the cap gap
   has existed, instead of the later "fix namespaces move" commits.
 - Add Kuniyuki Iwashima's Reviewed-by to all patches.

v5: https://lore.kernel.org/netdev/20260611062814.2528793-1-maoyixie.tju@gmail.com/
v4: https://lore.kernel.org/netdev/20260609163110.1717419-1-maoyixie.tju@gmail.com/
v3: https://lore.kernel.org/netdev/20260604125055.3254652-1-maoyixie.tju@gmail.com/
v2: https://lore.kernel.org/netdev/20260601034148.1272080-1-maoyixie.tju@gmail.com/
v1: https://lore.kernel.org/netdev/20260527070824.2677331-1-maoyixie.tju@gmail.com/

Maoyi Xie (7):
  net: ip_gre: require CAP_NET_ADMIN in the device netns for changelink
  net: ipip: require CAP_NET_ADMIN in the device netns for changelink
  net: ip_vti: require CAP_NET_ADMIN in the device netns for changelink
  net: ip6_tunnel: require CAP_NET_ADMIN in the device netns for
    changelink
  net: ip6_gre: require CAP_NET_ADMIN in the device netns for changelink
  net: ip6_vti: require CAP_NET_ADMIN in the device netns for changelink
  xfrm: xfrm_interface: require CAP_NET_ADMIN in the device netns for
    changelink

 include/net/rtnetlink.h        | 2 ++
 net/core/rtnetlink.c           | 8 ++++++++
 net/ipv4/ip_gre.c              | 6 ++++++
 net/ipv4/ip_vti.c              | 3 +++
 net/ipv4/ipip.c                | 3 +++
 net/ipv6/ip6_gre.c             | 6 ++++++
 net/ipv6/ip6_tunnel.c          | 3 +++
 net/ipv6/ip6_vti.c             | 3 +++
 net/xfrm/xfrm_interface_core.c | 3 +++
 9 files changed, 37 insertions(+)


base-commit: 512db8267b73a220a64180d95ab5eebe7c4964a8
-- 
2.34.1

