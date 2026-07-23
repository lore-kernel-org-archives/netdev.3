Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF9F24E4C3
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 23:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784849882; cv=none; b=Ru1dRR/rUkwMKWzWBLRiHGCmQMHXiHO3Sz75Mm0LimsDpfPxnvjVCUYRSlDa6Pqgo9+CzRk6ZPHgWg5/5s3f1x5BPmo/1i59B7I5eNo04NvKjlQ6HDeZEn+GnWexD5tsjIIeBBdGinJJ/x1u16ZQ/c/w4ZHU+Luv/kct5GWnLCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784849882; c=relaxed/simple;
	bh=UfQtJ/kp0gNRViuTO9YqrowKPyphLa7XBVMfCt6J8rc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n5hYaDzCli1hDByA1H3I9A8c0JMbpSo9yUuZRowjWfu0AvvU3mbjZ4o0HU81iPmuL/TSTqzC8OW14iVPEMiaHc/c0bX0nRUs0EDtI7GmD3v6PGzYW74//SyOwCuGHF+tPTzdhq//Jj9OMVEKWTUTb84zbDPsPhbKVyxkyP0Beqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jv6JNC2X; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jv6JNC2X"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-6689f36ae56so1470924d50.3
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 16:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784849880; x=1785454680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zFto45DI7j1DhybQGaSarDjXXaVDfX4JCACCXpmrTbI=;
        b=Jv6JNC2X6cmVph5TZo60kwbAxveKbr/t97SiomYNsrR2aG69nN8qSYoNiSuwcjhUGf
         uPay5jGEIlPkA4+hrZMFhUxg5X5kHiBnF2XfaD1JxfzevSJNgr8MxaBb2JOQhhbGfExY
         igNte8gfHkGC0ueUuyImdE2STXWS33OqdnBYhsGEJBMj2DkzIOlopb4972GHSLkDxtU5
         emX05drdqq7YxU3rdb82OR2qjIfk6o8DsbwgutbnZShuz4ILU1FXqf34ZvEP3wxnoPo3
         G8NwWHpR5ozomhJ6d3zkoG06RSY3tQQfIpiot1eBNegV7yFnWgWAxVrdo7LULAGo3YuK
         00wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784849880; x=1785454680;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zFto45DI7j1DhybQGaSarDjXXaVDfX4JCACCXpmrTbI=;
        b=ABMngRkBTuW+mGaTKh3NNWhzABgjaotq0/eTl2gLwBPbzU2DiFpiqRUd3w+8gykrc4
         VhOhXnwy714LiDIXL4wIlSBy7awfTzKHd0nkEu6kacUd75TdPSf7GVMThj4QDsgAlEwN
         gIQp/De2Lb+qrAAvxzTOu5FOISIAWZUEm2UBuNbUrYtWgEauiOdKaSxmZJJI+996ajJ1
         IltYWJkkBdZrj/RHWTMuXelynsZKDt9Du6fujN73CnRv6uNzgCkMtTZv4qBK83Ldju/X
         Nfj7CYI9k9Jotq5f1GFnqOqTV2+2edBuljAsM9BBQ7D/ZZz1yFAEXna0j4fgwuvlez+s
         IPIA==
X-Gm-Message-State: AOJu0YzGnJQ6MAp97Ba70axcd6ZZaMr6zd75g5/9n7vB5CUw4nTNeklI
	tnwaN4Q0G7SvniPURf2c+4e2tR38MUsFreAsQzs3RMyJel0zt8Bm2y/a
X-Gm-Gg: AR+sD12jsDJRaf8qWgytyy5l4+jrb/7L1MXhSEI/C3cGpJK94R3gDNSoGHiTi/L1Bnz
	ZeY9Q9pb3jotgec+riOABwvnmo+v8aOveNp1OxG/9gBm8pxOh2IV9fxuDrnvNDlH+Y2pOufpmDA
	P3NOd65sj6zhw6xXgyzIG92nNbjBAEo2ZW62UgN1Gp1l8WmCmA1oHo9/dUlURJT47raofs9QnUn
	pkYiII00b29Lc0dYCP0zrzcmX3CS+c+WNznM5DkrRwu//n39HIAZieQ8iDfBBW6X1Ye0f/0aXye
	5SelBGVV6MQPhtw/LFMyoqGD9SA1agviAI2375jZ3ZKMpcF+6ksahIbYpVtvosmt7814OMnjKgp
	aUSptTKeyTEbwIWWG8PEV9l1n/37MiN15lC6PSCwN7yGKoepR3v9stpRycw3jX776kvnNlUtiV/
	jNUB8qG8O6JsLhY62cEDUw6U8FmwZcB6dswdrHmzdaHu6dNE0PQOlMF5gPLvgSqRf+S/bCzYYdH
	qavRSwcpUyN0YO6o9dWpQdB
X-Received: by 2002:a05:690e:4894:10b0:667:8b90:2e61 with SMTP id 956f58d0204a3-668a50369cemr979969d50.109.1784849880355;
        Thu, 23 Jul 2026 16:38:00 -0700 (PDT)
Received: from LAPTOP-83ECOPAB.f7a5e5c3-cab1-4810-bdbb-207cdd06de9e.globalsecureaccess.local ([136.55.173.105])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-668906da4c8sm4007169d50.11.2026.07.23.16.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 16:37:59 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: aconole@redhat.com,
	echaudro@redhat.com,
	i.maximets@ovn.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	dev@openvswitch.org,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	blbllhy@gmail.com
Subject: [PATCH net v3] net/openvswitch: check Ethernet header length in  key_extract()
Date: Thu, 23 Jul 2026 19:37:57 -0400
Message-ID: <20260723233757.96356-1-blbllhy@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a packet arrives on an ARPHRD_NONE device (e.g. TUN),
ovs_flow_key_extract() trusts the user-provided skb->protocol field: if
it is ETH_P_TEB, the packet is classified as MAC_PROTO_ETHERNET and
key_extract() is called without ensuring the skb has ETH_HLEN (14) bytes
of linear data. key_extract() unconditionally pulls 2 * ETH_ALEN bytes
for MAC addresses and parse_ethertype() pulls 2 more, either of which
triggers a kernel BUG in __skb_pull() when the linear area is too small.

  kernel BUG at include/linux/skbuff.h:2848!
  RIP: 0010:key_extract+0xa7e/0xd90 net/openvswitch/flow.c:933
  ovs_flow_key_extract+0x419/0xa70
  ovs_vport_receive+0x222/0x390
  netdev_frame_hook+0x3e0/0x630
  tun_get_user+0x2d0c/0x38e0

Fixed by adding checks in key_extract() before pulling the Ethernet
header.

Fixes: 217ac77a3c25 ("openvswitch: allow L3 netdev ports")
Reported-by: AutonomousCodeSecurity@microsoft.com
Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
---
v3: Use check_header() per review, fix format issue.
v2: Moved the check into key_extract() per Ilya Maximets.
Link: https://lore.kernel.org/all/20260721143602.64677-1-blbllhy@gmail.com

 net/openvswitch/flow.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/openvswitch/flow.c b/net/openvswitch/flow.c
index 66366982f604..fc4002353e17 100644
--- a/net/openvswitch/flow.c
+++ b/net/openvswitch/flow.c
@@ -911,6 +911,7 @@ static int key_extract_l3l4(struct sk_buff *skb, struct sw_flow_key *key)
 static int key_extract(struct sk_buff *skb, struct sw_flow_key *key)
 {
 	struct ethhdr *eth;
+	int err;
 
 	/* Flags are always used as part of stats */
 	key->tp.flags = 0;
@@ -926,6 +927,10 @@ static int key_extract(struct sk_buff *skb, struct sw_flow_key *key)
 		skb_reset_network_header(skb);
 		key->eth.type = skb->protocol;
 	} else {
+		err = check_header(skb, ETH_HLEN);
+		if (unlikely(err))
+			return err;
+
 		eth = eth_hdr(skb);
 		ether_addr_copy(key->eth.src, eth->h_source);
 		ether_addr_copy(key->eth.dst, eth->h_dest);
-- 
2.53.0

