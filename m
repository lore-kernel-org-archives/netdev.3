Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792892852;
	b=fpiYn7mcwI27N7kreKakonm0HbnvWKnwLvziTgGhPGt/wwjIywLQzYO+Rbb2iKgVQ5AI
	 DjA4XIRo72aQejQPeT2ujGeXjLWv6N3kJl+LT2Sv3nUoXn9Ahtdide14Nelx5b5nDh68G
	 NqNsr5dHPAkSEZbqkA2XQPwsbS4CrDjKQdvuaw+SIUpz3mkMlHx5riVX4B+LEK2MD/LyY
	 M3dCyxjiEKsY4Jl+Qe/iLsdRwYIGgykvVx3EmsNpZ1LHXT0qMCg4rg1/BwQ2O7xRASUlT
	 46pJV3m9O8SFzrj9yAj4HCoJqPdNINHIWGTO0f5nLgSAQsPd1ftOBHikmIaKiTwfIbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792892852;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=LKl9wz07od1KtnGqk5r36fEXu2WKt0H3YytCVeKpeLc=;
	b=hWb7/shXShyMq7c0rFbnHQG+1Z57Vg6dyy1uTTNPZRcx/nS5cGJSKOqaD0qnyRc4sxxX
	 EmGJ5A1yC0xBkMyrQQdEuBthjErxjp1/fwrlBCUj50TFzfsDDQblrOPg8bzOVgIZK1tk0
	 4+IbDGUzwr1V/yTQGjyeATI4rIITZzfqils8VwYzF5VfyGDD83+ebCjPNwOgKGF1+F1Ol
	 d2vsr1K3NxluVgPil48U6p5pzou/jTHAV9ZAmktZJ6D1cMDaarXPwbdK40cqZDgYJ58uK
	 ljEgJGM/+iaqbiHdqIcajukmkGPe+gJhlTINCODbDUhBzhD8CE8Mvatym2kpHXTpnHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HyVygiV3;
	arc=none smtp.remote-ip=209.85.222.53
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D73606A322
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 01:47:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1D73606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HyVygiV3
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-98fea7e52b7so1278282241.0
        for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 18:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792892851; x=1793497651; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LKl9wz07od1KtnGqk5r36fEXu2WKt0H3YytCVeKpeLc=;
        b=HyVygiV3dVJOSmEqo+6npbk5JJr0kWBwET4OBfC+fWzK60JaYMRV0qoe1jnAuch9j4
         CZgOpMD0yClGjlJiDGCDVGwXi9DusFLOd6LaXL2GDNXhY7nTPxalYk9BlHrX64vHzp5w
         ADAsMkxSaN5g9eXDUiMDpIkaqV4iLRoWE74tSq52FIyhaiIu4YZW4fSft0k1R3r7XDvl
         CQ36x/0jdm2EemUegmNLiXTj8TwFGNJsxDzdFSZ1IDG6xjM6ZAvfjHc7cbtduSOSWDH8
         CLi1TIA9d+cS40XgccixL91VzpOMQzmLfdZ4xj4+QEbdCazq/XWUOr0VoCKaGVV6OCMa
         yyOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792892851; x=1793497651;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LKl9wz07od1KtnGqk5r36fEXu2WKt0H3YytCVeKpeLc=;
        b=GpxvzRfkO3+ZZH13XZ6WXlALtkqvldWbTLbQBTWB7WyQx19POfEZHP98WDIWyt6cxI
         A33GkvxzaKJFfFOLnnFq3F2TMKDn5AbZOQxie09mCpLk1kbjNmb1n7e8xrARMeihlfVk
         EroFs9lFTB69N/8Y6Z2N/H2ZOQn8xr4c0e9VoAWKCpu7Wf2bzOxvXc00T4Ui2qAo2YWD
         4C6wZWr5dvlLO1rypieZTVCauptrMOoKJ4JKG6dRzd3Z2QAROeD4EG5Hf+AK40rmWZUi
         ufi+JUrGJwxkGSBQm/JeBA7M2eeubgq9almdpT3TcTXh+MaGu/dRqHIa13wXm5PzFqps
         s1FA==
X-Forwarded-Encrypted: i=1; AKwUvBwBJOkR9jcfQrJ06DXOeBhCQXA++OIC4fqJ7NXZWqT9a4IapJRAjoLBxoeqeIva0bBpLRCTDUw=@vger.kernel.org
X-Gm-Message-State: AFq9FYK8/g/hoovM95CwmNPiQdYk/SRUlH/zQnsM5kz7iBNIA1RrsJXz
	ym4bBN6dTQv4+aK2/7xRN/avMtcWS7MuVRi42TClW65EUogI00WmUcBb
X-Gm-Gg: AYBFou0yQ2dqqkTitLFzMHscF/r10l6oEJQ/Y0wWLQ4D7R6O0bhRMTvxd6kCdIkQS6L
	xvMKXp1ls2fmXjv48YTzuux5QI+YXJWqIbyL8QEiO1+NiDZfSwc9gXvpWC/i7S9WHJw20TnKda/
	RGaR8JvQHQWMn74JY9PatvDcvXD4xdcV0LuNoompdkQMhw4epfEl0asDSaOo5lgU4HiXkJctCyB
	zUzAT1WkNLvGfX6xBZBjCZjz2aBSCT2kgNh+z2kZzL93vfHZ+NuxX0UcOcmSizr3kIqVOqguyyg
	jM7W9fGG+OJ0k9f08PBRIbStH3P6AAeUK4ZfwaSuBlmo13IH06cP7hML57Br7mx9uvvf02lkCZt
	FtgwnDgQ8SdqFzmLezKmzE1Pyw84EMsXTUnLP2i1LwxmdkUNeC0YOf/t/D/+DOYLc9tnSRMWfaV
	Wiv5A2DiH7eQbwL8JwB7r4/n4nRh+lxqrkM8CbYRvCeeeZXb8XLfobeiudoPdLNcElVBKUFvddi
	bmE4oIU51RypRrjIHvFQKAZaA3Eb1C7nyJ1S2XEACX3/Q/bt1E+RQhThyC7UmKVd7tjHWldCBWj
	DoeuY2Am5AU45iI+AG0yCLQAPp0Ya7I7CztBJBxUSyIMew90Rv0=
X-Received: by 2002:a05:6102:4b1b:b0:7c3:ac79:9b09 with SMTP id ada2fe7eead31-7ce5ce62789mr982785137.30.1792892850663;
        Sat, 24 Oct 2026 18:47:30 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([2804:7f0:b101:277b:8118:1af6:d493:fe05])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec233f4bfbsm3877257e0c.4.2026.10.24.18.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 18:47:29 -0700 (PDT)
From: Joas Antonio dos Santos <joasantonio108@gmail.com>
To: David S. Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH net] net: dcb: initialize PFC value before calling getpfccfg
Date: Sat, 24 Oct 2026 22:47:24 -0300
Message-ID: <179289284460.50470.572724041164324949@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

dcbnl_getpfccfg() and dcbnl_cee_fill() pass the address of an
uninitialized stack u8 to the driver's getpfccfg() op and then put it
into the netlink reply unconditionally.  The op returns void, so the
core cannot tell whether the driver wrote the value.

i40e_dcbnl_get_pfc_cfg() and ice_dcbnl_get_pfc_cfg() return without
writing *setting unless the DCBX agent is host managed and in CEE mode.
Both drivers normally run with firmware managed DCBX
(DCB_CAP_DCBX_LLD_MANAGED), and i40e with FW LLDP disabled runs host
managed in IEEE mode, so on a DCB capable i40e/ice port the PFC values
in DCB_CMD_PFC_GCFG and DCB_CMD_CEE_GET replies, and in the CEE part of
RTNLGRP_DCB notifications, come from uninitialized stack.  The same u8
is reused for all eight priorities, so this is one byte per reply.

dcb_doit() only requires CAP_NET_ADMIN for RTM_SETDCB, so the GET
commands are available to unprivileged users.

Set the value to 0 before each call, like the PG config path already
presets its outputs to DCB_ATTR_VALUE_UNDEFINED.  0 is also what the
reply contains today on kernels built with CONFIG_INIT_STACK_ALL_ZERO,
so nothing changes for those.

Fixes: b94b013eb626 ("ice: Implement DCBNL support")
Fixes: 5effa78e7c94 ("i40e: Add netlink callbacks support for software based DCB")
Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
Assisted-by: Yaga Agent HackerSec Claude:claude-opus-5-5
---
Found by code inspection, compile-tested only (W=1).  I don't have
i40e/ice hardware to check the reply.  On kernels built with
CONFIG_INIT_STACK_ALL_ZERO the byte is already zero, so in practice
it only leaks on builds without stack auto-initialization.

 net/dcb/dcbnl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/dcb/dcbnl.c b/net/dcb/dcbnl.c
index ab71f53128..ad0aebe0ad 100644
--- a/net/dcb/dcbnl.c
+++ b/net/dcb/dcbnl.c
@@ -281,6 +281,7 @@ static int dcbnl_getpfccfg(struct net_device *netdev, struct nlmsghdr *nlh,
 		if (!getall && !data[i])
 			continue;
 
+		value = 0;
 		netdev->dcbnl_ops->getpfccfg(netdev, i - DCB_PFC_UP_ATTR_0,
 		                             &value);
 		ret = nla_put_u8(skb, i, value);
@@ -1395,6 +1396,7 @@ static int dcbnl_cee_fill(struct sk_buff *skb, struct net_device *netdev)
 			goto nla_put_failure;
 
 		for (i = DCB_PFC_UP_ATTR_0; i <= DCB_PFC_UP_ATTR_7; i++) {
+			value = 0;
 			ops->getpfccfg(netdev, i - DCB_PFC_UP_ATTR_0, &value);
 			if (nla_put_u8(skb, i, value))
 				goto nla_put_failure;
