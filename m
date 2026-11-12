Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794506906;
	b=fHFXYkl3eMmDvlaLtfMWRdo/e7PrS4sNu9Tzaa9KYZcF4XsVe/UL5VVH2rLjwMIUxiy1
	 oiMIvsdnkkrskk5GcqFvicf9SINRLmcQLx2dzEWpdPx3HER45be2f21YdY8EiHb7ydryA
	 gg/FuxoZBtyT6VAWUpuoSibXX6eeiLJP/W3ooz01sC9hQzzpLermbYqAr9Z+PCXDS5dQa
	 WygDBPuzWgWUJjp+ob5vAxg9NxPKVXL4lA1dgZrJ1/dKWoHTbgzjh3ebLv8gm3JammTKu
	 TQsyfWur9SmM9zWtoPJcOm4qp2GCG1ojcgEQO03ID93J72ng8mewImvkQh+272v//pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794506906;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=IuyY4VkDEyFSQSAJ/QGlhbXVklK5sj2QLVDu+lvSUaA=;
	b=MgRv4mDVX1pMcv+CdhUNCDXXFIz0TZNy8bWjCD812V4gsbfLY2Y40v/B1h5sQTffredi
	 eYj6X3MAkRE0u0XzKedCHAIQ2uofPYpfAX9VL5TNFw9wWOUu0ARacWlJVrjjFxXkBSr80
	 2d8upj90hrDWrGmTET2lgmAg0/wAFM7MmI0gluMc9R6YbU+WLiZxV4CC9hcWbZKpUjUZJ
	 dYTVYBooi67sIegR2zDWpVN2T/AngA3IBJhdr7aO5q+RZ7DK4NlT26dbNFdNNAPiIRlJs
	 fib9AzRD8BP0Gy16imaZA2dtiGlKXB0pLUpZP8X+p3+RK940FtaCCvo5yZi53d1muLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unc.edu;
	spf=pass smtp.mailfrom=cs.unc.edu;
	dkim=pass header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=KkbandDT;
	arc=none smtp.remote-ip=209.85.128.182
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03760606A323
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 18:08:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03760606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=KkbandDT
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-8b0d126f631so2068557b3.2
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 10:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1794506905; x=1795111705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IuyY4VkDEyFSQSAJ/QGlhbXVklK5sj2QLVDu+lvSUaA=;
        b=KkbandDTebPbtmvtFRJySdi9uHWjGVY+xCBEXoeqFT3otRqLqghjLLhESS2VmNbsZG
         JW8/NU4Ji7lPnObb0Jpl8uVYwV85AQIN0rtovgkhk0Vm3brSPvgKjZIiwl/DcXianqnI
         rm5Cn/ZGv1MQxLXrr0TYT6JOmjigo37X94D4tjnDu+6m6VAOu1yrgvSIOjZovdD2wKcn
         LE1/nAxkIodnZMyyTcpWjSAOf28hhLFatREyMqb4SJH2+6oemej2YHpEtTmbc1M5LNXB
         DY8LPlMWHs0PFfvZpR0riH+0FIox/j/k/5f8tLpHJlODXEacfuw7h4h37oG6pEq1W6JT
         eErQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794506905; x=1795111705;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IuyY4VkDEyFSQSAJ/QGlhbXVklK5sj2QLVDu+lvSUaA=;
        b=2fBekvd0K/uD3nVFGB63yKMPTbZVxSkyJTJ1xdhUA0PxZ+PfkaEJKtlBC4Csx55lBA
         8dSSGMfbXP+bi0/LSyfXE5pp5kELLnJnNFpkALNzZdSzEqIv1J45xUErNrZB++0Bo+ET
         QtvQtNunajK1xc+b9NwchtJGg9JPSEsWJKCKG8N/7zzR8HyvnvkCq1Qd6PYrPCFFNy/G
         QxJaNwTrhVSqyVaDsP/rrX3tVadWOw7lUUmcaNaVymV8+vW/iOQMAh9e9JvbO4S+LooB
         TbxUyfxExQMPn+/nkc5SFAzPUgv+4nppIRJNZQR3YDa5xTjr2yy+IA25D9lFQkjAdw3D
         8J+g==
X-Forwarded-Encrypted: i=1; AL+hErFCJkC3tFwi5VLk2Q69S89g9yE6YSKRUPyyp2jxLX+fMjuAo6GJwjhz8VeBCiucTLCBKirJzu8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+CbMBVH2g9zZYLiI9nqnPD+3PxBi3dwAuI5ApWpXsHOAYllQiS
	91VnzwQyM6CjMwPhDGFXRVh1S2wi56Q7sOMfjI5sl46axLvHWxJ5dYiGT8KtZKnXxg==
X-Gm-Gg: AYBFou3ST0CtzRyJa9e5HnkwDJ0FSipoWQzZAbgMrt6Ie7Wd4Q3K66pgkniJKb6pjaK
	5ywHVNVkGwGT3l1y6k66o14pTDVWtIQMWXMO27Zew3vSqqucwKNMHtgIsYrDXX2c02Ds/JDbZYc
	C1jq0XuAbtLs2jtmQgvZMM31LYgUhDH3uC5rzWQRfOiRvCYuSQ4fhyfS1oEhgm4QFC0jLScWPPl
	gybPlu/NeMXbhzr3UYescttvFklkvs7+k/MiPcYzjPIC85LsXUhvJ8UQ4xt5kiltgifuxs8vjJe
	xSzRoz0/zG+IwNwfAt0GyYYmjumixUCdiYeUPp4/B8tWPniu0LpVMePwZwKLUiGUm8orEQmgSyt
	hLF8lU8u2zf+Vdg+Tew3dEli6/pbIRU+9aIaQ1jyLHdEMbRdgM+qzzX3kAhTwlYH8PKOs+9QU2b
	NiaobjAJhsWPf0yXIM9itBFAEByTbI9yOXCAj7cWW23Q7KsfqtU9TBavxX5PRW0MYnEx/Sb5u6t
	XVGLdRXc2nP43PcPKLFMCr3pIB2ApKaKKbslQWRWvNzVGpZvn0CkVNPwSuLM8Hk+2duCkGFYisF
	hwjkYESSHqmbPzC1Mn8nrnBYYNHf5SF83Cdf1dFXzunK5nyuYC/3
X-Received: by 2002:a05:690c:c6c3:b0:8b0:d9c9:3fc6 with SMTP id 00721157ae682-8b4aa2f2c28mr2160547b3.13.1794506904893;
        Thu, 12 Nov 2026 10:08:24 -0800 (PST)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b4aa933f04sm1743067b3.18.2026.11.12.10.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 10:08:24 -0800 (PST)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] ipv6: bring NLM_DONE out to a separate recv() in link and address dumps
Date: Thu, 12 Nov 2026 13:08:08 -0500
Message-ID: <20261112180808.1217483-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit ac14ad9755d4 ("ipv6: use xarray iterator to implement
inet6_dump_ifinfo()") and commit 9cc4cc329d30 ("ipv6: use xa_array
iterator to implement inet6_dump_addr()") made the IPv6 RTM_GETLINK and
RTM_GETADDR dumps put NLM_DONE into the same recv() as the last
objects.

However, some applications expect NLM_DONE in a separate recv(). As of
now, Kamailio waits for it when it looks for the IPv6 addresses of the
host. It gives up after 4 seconds and listens on localhost only.

A similar issue happened before in the route dumps and in the IPv4
address dump. It was fixed by commit 460b0d33cf10 ("inet: bring
NLM_DONE out to a separate recv() again") and commit 5b4b62a169e1
("rtnetlink: make the "split" NLM_DONE handling generic"). Perhaps
these two dumps need the same.

The issue can be reproduced with:

    python3 tools/net/ynl/pyynl/cli.py --dbg-small-recv 4096 --no-schema \
        --spec Documentation/netlink/specs/rt-addr.yaml \
        --dump getaddr --json '{"ifa-family": 10}' 2>&1 | grep Recv

Before commit 9cc4cc329d30 ("ipv6: use xa_array iterator to implement
inet6_dump_addr()"), the result is:

    Recv: read 232 bytes, 3 messages
    Recv: read 20 bytes, 1 messages

After that commit, the result is:

    Recv: read 252 bytes, 4 messages

This patch will set RTNL_FLAG_DUMP_SPLIT_NLM_DONE for both dumps.

Fixes: ac14ad9755d4 ("ipv6: use xarray iterator to implement inet6_dump_ifinfo()")
Fixes: 9cc4cc329d30 ("ipv6: use xa_array iterator to implement inet6_dump_addr()")
Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
---
Application impact (Ubuntu 26.04 user space): Kamailio 6.0.5 with
"auto_bind_ipv6=1" added to the shipped kamailio.cfg, on a host with
one IPv4 and one global IPv6 address. On v6.8, it listens on both
addresses and on localhost. On v6.9 and on net, it logs "Could not get
network interface list" and listens on 127.0.0.1 only.

Kamailio looks only at the first message of each recv() for NLM_DONE
(src/core/socket_info.c, same in its master branch).

Tested on net: with this patch, Kamailio listens on all addresses again
and starts without the 4 second wait.

 net/ipv6/addrconf.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index d9d13e78bf13..cbee883e8b01 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -7561,14 +7561,16 @@ static struct rtnl_af_ops inet6_ops __read_mostly = {
 
 static const struct rtnl_msg_handler addrconf_rtnl_msg_handlers[] __initconst_or_module = {
 	{.owner = THIS_MODULE, .protocol = PF_INET6, .msgtype = RTM_GETLINK,
-	 .dumpit = inet6_dump_ifinfo, .flags = RTNL_FLAG_DUMP_UNLOCKED},
+	 .dumpit = inet6_dump_ifinfo,
+	 .flags = RTNL_FLAG_DUMP_UNLOCKED | RTNL_FLAG_DUMP_SPLIT_NLM_DONE},
 	{.owner = THIS_MODULE, .protocol = PF_INET6, .msgtype = RTM_NEWADDR,
 	 .doit = inet6_rtm_newaddr, .flags = RTNL_FLAG_DOIT_PERNET},
 	{.owner = THIS_MODULE, .protocol = PF_INET6, .msgtype = RTM_DELADDR,
 	 .doit = inet6_rtm_deladdr, .flags = RTNL_FLAG_DOIT_PERNET},
 	{.owner = THIS_MODULE, .protocol = PF_INET6, .msgtype = RTM_GETADDR,
 	 .doit = inet6_rtm_getaddr, .dumpit = inet6_dump_ifaddr,
-	 .flags = RTNL_FLAG_DOIT_UNLOCKED | RTNL_FLAG_DUMP_UNLOCKED},
+	 .flags = RTNL_FLAG_DOIT_UNLOCKED | RTNL_FLAG_DUMP_UNLOCKED |
+		  RTNL_FLAG_DUMP_SPLIT_NLM_DONE},
 	{.owner = THIS_MODULE, .protocol = PF_INET6, .msgtype = RTM_GETMULTICAST,
 	 .dumpit = inet6_dump_ifmcaddr,
 	 .flags = RTNL_FLAG_DUMP_UNLOCKED},

base-commit: 19ec8416a76c08326fe5f814410a1b43046e63be
-- 
2.53.0

