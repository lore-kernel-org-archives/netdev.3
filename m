Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AD31C5D5E
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 00:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786061962; cv=none; b=CZLPcb4wQhW42UUPAzn9UPgci0wKkM/zCLwScEo0Xj91UdWuwQK0Z74mj/aMb+Qq4UIeS0P34gcEg0cj1o7O4q6WmuRdYJqPOgnYr9DcIJ/X3HrOLkmiLs2xrPASuzaLhLZZR3/JW1TS8Df/O5T5dv95uWc1cC0Weq66mmg0CB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786061962; c=relaxed/simple;
	bh=dnKRBmMDlljZQJOyMogO6swQTrfJEVgegxfb+Smwxvc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PglgN5UKWUwbtjweiT93YtjvtQFqojtDmTq3dIW9hpwuJA6+81deIs5YQFO3iA/JV5MtN0WoyVXcYfqTxHiDzg2fEudT69+SxeCssnV6Crq0hYfSI8JGnSHuX9Z4dYSWi8Qegfo3BXi1qnPqP8sca4//ch1OgSy3STFIFdk7rZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZsdL32d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZsdL32d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE151F000E9;
	Fri,  7 Aug 2026 00:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786061961;
	bh=SLPQ5kyiVxwf4LANvQkHhMIsTdrmvjkjv5pkR8ZyApM=;
	h=From:To:Cc:Subject:Date;
	b=UZsdL32dEu5JmVNE8o+wEGmzy7jELExWF+8Gd1B+Bo7lrbWbj3yfY3Qakuy/Ab76J
	 srv5kioLwvD/h4Ze7M9UU4UJnaeirALU1/gnOTMQBDWPxMYT8bJZ2OPOZB9k2hHsrT
	 5P6h+fSIGDnQVatX9gjn4z1eY+3qIwdy3qLrjc/xnxh1T+ynHukZ1GOqggh2wp4Ljg
	 V8TCOPy3IKv+PWfWzcN/Jrz1UVLfFlji2ZMCP2NpwwyS053FPSSXvUFufcX6GrHrhH
	 0lrAC5gtqac8r3XWW394jsDy0buWtIJKIw7QAOIPzRZqDXxhzU9w5Ne/R5k+ffItbG
	 cY9URtyQcTXlA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	donald.hunter@gmail.com,
	sdf.kernel@gmail.com,
	houminxi@gmail.com
Subject: [PATCH net] tools/ynl: add ovs_packet uapi header in Makefile.deps
Date: Thu,  6 Aug 2026 17:19:18 -0700
Message-ID: <20260807001918.61957-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ovs_packet spec needs to fetch the right uAPI header,
like other ovs specs already do. Otherwise build breaks
on very old distros (Ubuntu 22.04).

Spec was added by commit b82bfddc46e2 ("netlink: specs: add OVS packet
family specification").

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: donald.hunter@gmail.com
CC: sdf.kernel@gmail.com
CC: houminxi@gmail.com
---
 tools/net/ynl/Makefile.deps | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/net/ynl/Makefile.deps b/tools/net/ynl/Makefile.deps
index 43d06ecbae93..2771375339d9 100644
--- a/tools/net/ynl/Makefile.deps
+++ b/tools/net/ynl/Makefile.deps
@@ -35,6 +35,7 @@ CFLAGS_nfsd:=$(call get_hdr_inc,_LINUX_NFSD_NETLINK_H,nfsd_netlink.h)
 CFLAGS_ovpn:=$(call get_hdr_inc,_LINUX_OVPN_H,ovpn.h)
 CFLAGS_ovs_datapath:=$(call get_hdr_inc,__LINUX_OPENVSWITCH_H,openvswitch.h)
 CFLAGS_ovs_flow:=$(call get_hdr_inc,__LINUX_OPENVSWITCH_H,openvswitch.h)
+CFLAGS_ovs_packet:=$(call get_hdr_inc,__LINUX_OPENVSWITCH_H,openvswitch.h)
 CFLAGS_ovs_vport:=$(call get_hdr_inc,__LINUX_OPENVSWITCH_H,openvswitch.h)
 CFLAGS_psp:=$(call get_hdr_inc,_LINUX_PSP_H,psp.h)
 CFLAGS_rt-addr:=$(call get_hdr_inc,__LINUX_RTNETLINK_H,rtnetlink.h) \
-- 
2.55.0

