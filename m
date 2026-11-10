Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794324629;
	b=uiddoXYgD2/RRAjLIciybqzRBkAx8k8cneBlu8pWIas0T142QYfGj2GwGkXEAsPb/1Y2
	 j9TOq5l2PKnYD8D7fLYjatqg1JQVX3oO+riNsxHHm8F6ZiLLtUiIeDGDynj+JGsh3+uOl
	 MzWMs7+7emS+FAvb/QqHoU7QJZyC+ZGqiK0dbMDdZSFFpyCeVIziO780a7aNOZwgUdWqp
	 5Q7aE9jn4smPdkSDaUkstr6jbSWCAsjaB3ZTePVtyYhuDxOAZ8oUhEr7ziAISXvnboRJc
	 tIj3bahez1Pg+J3p+elw+y52eY73dVfji8wFqZQgygQ/+0g5sndpA8GUDPqdl7b4/OA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794324629;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ptI5TWXLUlJ/nEd1Y9XUGbt6UYgT2k24kx/bLOwYN3k=;
	b=KBmLHamEB5HO6ZNoKn8ouHoHKj8yAqwZzQZTTVnzYPQ4tv47JYdmTl78i8kFo+TvtwZy
	 RbPdjVKUAE1AzeT4/JFU4KzAcep/Fom/Tlr+JMkjISXePF3FGmdrCI/BnCoP1eOuvnr/6
	 GJQkRA8H2uP6UgdoFJlxyUlAWZg2uGGITeiGd+wbg1ndHkO60OPuaRFa7P/nxeHOKPw8q
	 ++/EoHgCZCIlzybfbyWcUNe2TkgsP64N5axYeP8JM9RYIIvgNRleEe/npPG4dWgRYQBKz
	 0R4rtNBLT135GqS4W5Y+UR5ZR7YX801WOAh5oJ3WLQ5B9msGD0X5xZjYydW2ZrpGbsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="cb+ac/gv";
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BF8606A320
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 15:30:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71BF8606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cb+ac/gv
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-36eb1cb7aabso3337648eec.0
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 07:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794324628; x=1794929428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ptI5TWXLUlJ/nEd1Y9XUGbt6UYgT2k24kx/bLOwYN3k=;
        b=cb+ac/gvsg4CPZoDILmlj5uWqnXKk7TA+9F5PXoZj9wLF+PaIBavoGJnw285jIo4/j
         iWRqa6jXCJq+RDlaLnTBzhGai+FNThCx6bQ/S4xdQpVA3z+xYBEKDCXTEsCJ8RtnInBz
         2BVhz/NEHGYVMUWHFL36BW1chRTCKpbGdadR7oAFowP5jAbR2NJnS1brvGzmBxKc63os
         ayXcvAWOouCAaK9SqXqSGUxBeZzapD9vHX4xzJj3gQlLjjGtYR68AUJfCxiyFVfbGwpG
         IsNhpNbNhi8gmiZNXGPsHRDw0bohJI49uoHmxJ0iCX/t8VUnYrRZGcDXknbob1nqjYEM
         xUig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794324628; x=1794929428;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ptI5TWXLUlJ/nEd1Y9XUGbt6UYgT2k24kx/bLOwYN3k=;
        b=PDb25SH5Wmkeav3tr3P5C/0Tq2GcW4Z4VJAK/O8YeNVOAPxWypmQl3q6npolRqq+1y
         p/mf4+r52upXyn/AEayglvmyyIdXP1twcPEyn6DQ2l8oU1P+Uv9XREOUWV7Tc8oGpwXd
         XsNlaeddDQhB1LJsbvrPRbft6M39rgOSIzjAyMLn1JPFt35l7oDSUWZwL0qpGufG5u1G
         bdO+xbsn6WcCcJSVIWn4CGMX7ZFWHxFwRfJOa+b86Fw2+cBi/ehL9pxhBv8p4cqf49i7
         WlGkj5DZoLNSZeqXxZ1yqwxgeO3f6BgGLA6mLEziSzAQ//yGl8lXRl8aowrhSQH4kgnC
         2XLA==
X-Gm-Message-State: APuU4Z92OP4Xedg126crHgXs50K2EGwP0RvS5qAwZinbpHytAeMguoBx
	j/gJi9ufYAjMmWPjLLYnrFsinv/7Zu1EHEz5mXADZtRkCkO9haRY4RjSwNJI6Ii6
X-Gm-Gg: AYBFou1go6jNV7NXuuT6UNiadubxhTmpaUcOg4ZG7NkmbibQC3L8tSVSXQl1b6ZRI/n
	Qfq3qohZPqW2+dQTxY0EX2OgD2QONCXFkv8xxeP2IHhK37mn3n9RHhiUpLl0n/r1jiESrSffgy7
	S+HStFscYDQadEJ3gLYDl18zvIe6s19fNp75mYtI0tkyHnkQt+MLaPFEubarOcZIG4DfCtnk7+e
	5waKeksMw9lBhqmX+sGmroim4BQJ7SpCZ9bYzzyU7xMQMZOaquOxrZQAVtS8GIr69KqvOxj5UN9
	2/5DCZUFIuN3q0JfDWI3LiWI6NhDVmO+NRs037CuCEIrtoulayAsBJzIAG6jRHEasXOFXyUyhtP
	Q5OckaH4WD6E+KjFcBAFxTtH3tcdk2TI7hVapsz1Kqg/d4Jc6hIIBTHSMp7tf9wQmZMvDfho7WH
	eUZXTy85jhRW5Pkw09w2olqUj8lwPS2Ch7/p/GxrluxpMPz2iL+km+pW7ML7f1sluaQgQXe3RAi
	3EdOS3AA7YtT5ypPhMrfxvOTOi35SVsm2wJhAMNioRYP/GGP647/+KmAbJOjgHpAlioPwQogPDg
	R8SgRu+u1CohBAvVoe2rO5pUF8YoMa4DQmkA4JEHVL6M+jp6csHfZwH31M4qjkkspZ7x92F0RXp
	n4hQ=
X-Received: by 2002:a05:7300:a498:b0:36f:5746:3364 with SMTP id 5a478bee46e88-37520bf7048mr4607740eec.28.1794324628231;
        Tue, 10 Nov 2026 07:30:28 -0800 (PST)
Received: from localhost.localdomain ([116.88.205.165])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-375218c863csm7476355eec.28.2026.11.10.07.30.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Nov 2026 07:30:25 -0800 (PST)
From: CMGS <ilskdw@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	kuniyu@google.com,
	mschiffer@universe-factory.net
Subject: [PATCH net v2] vxlan: reset the remote's dst cache when snooping moves a MAC
Date: Tue, 10 Nov 2026 23:30:20 +0800
Message-ID: <20261110153020.9635-1-ilskdw@gmail.com>
X-Mailer: git-send-email 2.54.0
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

vxlan_snoop() handles a known MAC that now arrives from another remote
by rewriting the remote's IP address in place. It leaves the remote's
dst_cache alone, so the next packet to that MAC is routed with the dst
cached for the previous remote. When the two remotes have different
next hops, the packet leaves the wrong way. For example, if the
previous remote was on-link and the new one is behind a router, the
device resolves the new remote's address on the local link, the
neighbour stays incomplete, and traffic to the MAC is blackholed until
the cached route is invalidated, such as by "ip route flush cache".

The same branch also leaves remote_ifindex unchanged, although the
early return compares it and vxlan_xmit_one() uses it as the output
interface. When a MAC moves between an IPv6 link-local and another
address, the remote keeps the previous interface, and every later
packet from that remote enters the migration branch again.

vxlan_fdb_replace(), which makes the same change through netlink,
already resets the cache, updates remote_ifindex and clears offloaded.
Do the same when snooping.

Reproduced with network namespaces: a learning VXLAN device has one
peer VTEP on-link and another behind a router, and an inner MAC moves
from the first peer to the second. Without this patch, pings to the MAC
fail after the move until the route cache is flushed: in 10 of 10 runs
with one CPU, and in 5 of 6 runs with two CPUs, where it depends on
whether the sending CPU holds the stale entry. With the patch, they
succeed in all 16 runs. In a second setup over IPv6, the MAC moves from
a peer with a global address to a peer with a link-local one. Without
this patch, the move and every later packet from the new peer each send
an RTM_NEWNEIGH notification, 33 in each run. With the patch, only the
move sends one.

This was found by our AI-driven automated live migration tests. The fix
and this changelog were written with the help of an AI coding assistant.

Fixes: 0c1d70af924b ("net: use dst_cache for vxlan device")
Fixes: 87613de95041 ("vxlan: fix snooping for link-local IPv6 addresses")
Signed-off-by: CMGS <ilskdw@gmail.com>
---
v2:
- also update remote_ifindex and clear offloaded, as vxlan_fdb_replace() does
- add the IPv6 link-local case to the changelog and a second Fixes tag

v1: https://lore.kernel.org/netdev/20261106144406.66035-1-ilskdw@gmail.com/

 drivers/net/vxlan/vxlan_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index d11028b37..6bc54642e 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1482,7 +1482,10 @@ static enum skb_drop_reason vxlan_snoop(struct net_device *dev,
 				    "%pM migrated from %pIS to %pIS\n",
 				    src_mac, &rdst->remote_ip.sa, &src_ip->sa);
 
+		dst_cache_reset(&rdst->dst_cache);
 		rdst->remote_ip = *src_ip;
+		rdst->remote_ifindex = ifindex;
+		rdst->offloaded = false;
 		vxlan_fdb_notify(vxlan, f, rdst, RTM_NEWNEIGH, true, NULL);
 	} else {
 		/* learned new entry */
-- 
2.47.3

