Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596A93C1083
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 10:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784628767; cv=none; b=uM6nnXandnQ/jDvcMRI32ZsnzbaVA/jYa3uvMVN4tJhJCkUwtbv1PrN+GE0obDCPJ/ryHmQcvmPyq+MdDqXecBGRMY2ElXeQUVdyMkx9/+HucXukUrshZbdZ4yy4uLntvrzVcCJNwcS+IggqXmaT8DMaEVO+d+tgLTDWE9MslNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784628767; c=relaxed/simple;
	bh=ieHMWKKxdq4PB/pG+5he4+nY383ZAvD689GYUaMMMrs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=sC4Z2Q54/BDx7puwKpRWuuHnT42eIHPKFHG1/9lXQqf6Hl1AjAn7F7e2et30LPVRT49wG2vwZ3y1dtrVBs2xwu9CTRtE/qtE0vEKEUBn6VtuY3hYB863Do53EU2GjSvFBZyKg1dRiFbGE3BSVXKEfZMINWUnyzIlDHy87dXHMMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ww3OcBJo; arc=none smtp.client-ip=209.85.128.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ww3OcBJo"
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-81ed0c52d9cso36650407b3.0
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 03:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784628765; x=1785233565; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/+GrrHVDMGXDd8ZFPqgB1P5m7HTJ2mkxYZMliI3BxgY=;
        b=Ww3OcBJohfHziJbR1ooTI7fsU9XjrKlVCUOuZB8ISDRaf0KHkVFC8pzbn9vBJaVauV
         9AxB/Y7fhUQFk/J4CK+bDRW5BZ8tH9/DNmtLvfkpPC0ZB1ZKTsZ5Kg/oVGG0vHmgoCbc
         3H+L2X+jT3LJbb3R5/pra8cBFKwXlo8euEL/VjQdIvIVY5jQKL7/tazZidLjDG0LaQQK
         ckQd7HlXCwMl2qDFGczvIrF5LU0e8Ga/7u2ZIhBGa6QPJRTlPYudpPQi3GpnpsiIlUIC
         BsPpRVU5+zj01mWLWIbU0mX+j/4s0A2Mh2JVYuxRl3XsfYUlzQxdKCXmltxBxwh/QSow
         vYtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784628765; x=1785233565;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/+GrrHVDMGXDd8ZFPqgB1P5m7HTJ2mkxYZMliI3BxgY=;
        b=DV7vN1Mjuxp6cZdGC7p4qWoW42XsXCAxyJtvDwcpBe1GRyFD5RLH8gJde22P16Q/Tl
         fymbQp7zUx8BSnOdxiIglxrbfv8WXDGi+3UmpnzvYV6XGFM71XNNJNXm1waKqYCerIgd
         dZ+m0TvrgLy3J7o4sqBlFT9HCXp/CzYfOD4yaD4RT+EMaYFdoUmLZ3lhD1OLpApihQpN
         P5iZwwKrTDOloU06QTYGKBjNPhg2Prria6+d/8eKuicvz8/1lW3wxU3jsbRn2rQT/C19
         1hzWv1cuGcqbWMLIwdivc0CJwLz2FiuQ94x7VE+dLWo6f+AUglFC3efAGmxStxEpa2IA
         0uxA==
X-Forwarded-Encrypted: i=1; AHgh+RpjetRy/b8s8d2PGTJUMBW1zQXRgl9Q9VL+15NKYoYlJs/u4z+YmJTXI6b+1NsXDFgkf6Zo+/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCO9irQrCEOYDXm8BY1LevHuvggANoDtf0DEUauYjpuuRcx87c
	rydxffMo/g5NA/wEaogr1eOMQTr2v0mo4fUFd8+kokJSsEq2iSEwhcOg2vST9DFFLLoyMDvIDOu
	r2N5PxuBBGOrstQ==
X-Received: from ywbgn2.prod.google.com ([2002:a05:690c:4382:b0:81c:9a28:74a])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:650e:b0:80b:a1c7:9f95 with SMTP id 00721157ae682-81ef22e5bc0mr57709997b3.5.1784628764871;
 Tue, 21 Jul 2026 03:12:44 -0700 (PDT)
Date: Tue, 21 Jul 2026 10:12:40 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260721101240.995597-1-edumazet@google.com>
Subject: [PATCH v2 net] net: hsr: fix memory leak on slave unregistration by
 removing synced VLANs
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+456957213f32970c0762@syzkaller.appspotmail.com, 
	Felix Maurer <fmaurer@redhat.com>, Fernando Fernandez Mancera <fmancera@suse.de>
Content-Type: text/plain; charset="UTF-8"

When an HSR master device is brought UP, it auto-adds VLAN 0 via
vlan_vid0_add(), which propagates VID 0 to its slave devices (slave A and B).

If a slave device is later unregistered while HSR is active (e.g., during
netns cleanup or interface destruction), hsr_del_port() is called to
detach the slave port from the HSR master. However, hsr_del_port() currently
does not delete the VLAN IDs that were synced to the slave device by HSR.

As a result, the slave device retains a refcount on VID 0 (and any other
synced VLANs). When the slave device is destroyed, its vlan_info /
vlan_vid_info structure remains allocated, leading to a memory leak.

Fix this by calling vlan_vids_del_by_dev(port->dev, master->dev) in
hsr_del_port() before unlinking slave A or slave B ports, matching the
propagation logic in hsr_ndo_vlan_rx_add_vid() / hsr_ndo_vlan_rx_kill_vid()
and the cleanup behavior in bonding and team drivers.

Fixes: 1a8a63a5305e ("net: hsr: Add VLAN CTAG filter support")
Reported-by: syzbot+456957213f32970c0762@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6a4cb6ca.57639fcc.86d58.000b.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Felix Maurer <fmaurer@redhat.com>
Cc: Fernando Fernandez Mancera <fmancera@suse.de>
---
v2: incorporated Sashiko's feedback
v1: https://lore.kernel.org/netdev/20260707082327.3238690-1-edumazet@google.com/

 net/hsr/hsr_slave.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
index d9af9e65f72f07b1997b80c85db16d812fbda488..01c73b4b50ddd89afa74defa37fa83d40c401cf8 100644
--- a/net/hsr/hsr_slave.c
+++ b/net/hsr/hsr_slave.c
@@ -242,6 +242,8 @@ void hsr_del_port(struct hsr_port *port)
 		netdev_rx_handler_unregister(port->dev);
 		if (!port->hsr->fwd_offloaded)
 			dev_set_promiscuity(port->dev, -1);
+		if (port->type == HSR_PT_SLAVE_A || port->type == HSR_PT_SLAVE_B)
+			vlan_vids_del_by_dev(port->dev, master->dev);
 		netdev_upper_dev_unlink(port->dev, master->dev);
 		if (hsr->prot_version == PRP_V1 &&
 		    port->type == HSR_PT_SLAVE_B) {
-- 
2.55.0.229.g6434b31f56-goog

