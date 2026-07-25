Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E141E1C11
	for <netdev@vger.kernel.org>; Sat, 25 Jul 2026 04:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784953893; cv=none; b=BjN2OffgtP/8jPfrsUEjllAphylxbst7N2ngIkYhVdmUjGFlPYnjb+zwQ7H5dno+jbQi4pIBWd0ikAg8jebTmd75OUJ4OGqqneWVm56pidYBg7My7VTwWe/VzyZtRmGH9Z4w1X8jWKxuQbWHcbnrvzveRG4qgIULkl9EmZJTZEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784953893; c=relaxed/simple;
	bh=J4d9yK4iyxr+ISBNHyoQlLWe+cOMaGR43TOv4AMrfnk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RddtuMtwQEgb1nu3M3fuX3ZuhrH7qo4yJwnZjJ9eow1Y0uPIWPKlnOOkZ17jJtaLSmyDwEk/yRIzFO15/e+FJhJUyEq27naVi5mP4gYnKAG7Nvg1GcdR95T2mV6Eno3+On4IBv+NfnJxZ9XMnRVu9WhtecTDDnj/jkX6gNcLYHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H+TlW/il; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+TlW/il"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-6685483aad2so1141947d50.0
        for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 21:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784953891; x=1785558691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2cajvijRlXPf8dhrTZghp6sisym8DBTflIvH0RGtGos=;
        b=H+TlW/ilo8YK/twX1ZBCKw/sv0d5hMYIsNyMKPbQ0FCWu9pC3BWtQhBCuzc1OU5X18
         v7mWT0jmD9uA31tKQZN3Smbiz/xrlh/w/ghmdgGcGN7B0yu09+u0zOWTmSM2TITZ2xlB
         fqJfuIU037uk76ty+KfmSXfIsEywCUfjIyZFvMW6HasJkGctcEs9BOOYdrRWgt2M/hX3
         qbAtDCaqKEZkNxtJCj3uc/qZczxiHPH21svdXl6AwqTPBkKXVDjpfpn9NO8/CBEZzBsI
         g9iryIWXmKO6gaCrTN3i7EBD43OWu9Dsn4qyB+XOrGIi3dsvmT1n9sFyckMC94zQTgB2
         47kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784953891; x=1785558691;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2cajvijRlXPf8dhrTZghp6sisym8DBTflIvH0RGtGos=;
        b=JVcVpByM9FBNhm6wSrTIOdY1+ExXbFIttOo/Z/RFMn8LLKpdOKXW7/1XNxqYd59q9b
         fbJnLkkEnXYZCJCJzMD/xuwLFvsXkgyh/em8+nb8bxtziGp0lfa7CMy6CwafHr9zbiWv
         TB+2tL1xOXq5Kk82CMJq7j9Fn7rgJObco+1xZKNOBKrJF/T7LDLWW+85/3NlLDLB8o/O
         4IdUwmpoRoE3XLITay3Fp/0VtBIJy5QUrco61fS3n9+CqfKSuPX3UkvpNqhOzl5L4LHD
         0iAHoX3pklro7xnio8tRMwdzhU/h5a2rzOuIZ+wyyiP3IMVWSbESe1fGNdcchQ7Z0j5l
         +M0w==
X-Gm-Message-State: AOJu0Yz6l0dkqieMt3biQ+vl0m/k4XgfIGoVt/oFA8O0CAnNgM7K9qwb
	lTTMgqRLPH4FMcQHYbmCRKfMpKy1DqEJHQf6W2REh3bRo3WQNRcxcZXA
X-Gm-Gg: AR+sD13GRyaw8ofx97uen9pMdXJz3Co/16/JTcA27215HWGju6nPR6OHuBo36zCE4tn
	3uaKM0fWHkC1m0MKReBTGXa9PWDKGReIOdWfUtAjqAiWHfkUesZxHYDDuu9YMjEZcrh8F/2P4p7
	KZCYcQnG3jmIXsprMphGijK7Ak0ALRLR/D2ocP3qL5ZRiJTC2XG1R8WQQ+MY26dc1IXyAue846Y
	ZLYPr8QveLBy5dLY1JHSgSgawQkMTBbMWm0Q5jUG43juyBDLw3657JoDPn7fNnK2n3xjNFUYC5T
	R6lpYLQVhVrWoMpnVsUEOObGyFtEZS3cNi1SgBqobcOOH2z53S5qjDDg8spf2DfcLhrn6jmvEvn
	K5Y5EblCFvWj+UWYXGkCR6P1u2kVbxXnLPjZsFEEnszd7VatP4/LZ8n0DJNRjnf/vtjk4InOwaG
	nzz91sZBKl3weBtF30qUMG6shDdJF/816lOjxYVBefh3BNb3CuLL4yvPu1/gHx45qGQ1lMPd/xi
	r9pSV/uPTQ5PQ==
X-Received: by 2002:a05:690e:4292:20b0:667:bf79:773c with SMTP id 956f58d0204a3-668c7bdab4fmr190062d50.100.1784953890490;
        Fri, 24 Jul 2026 21:31:30 -0700 (PDT)
Received: from LAPTOP-83ECOPAB.f7a5e5c3-cab1-4810-bdbb-207cdd06de9e.globalsecureaccess.local ([136.55.173.105])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-668c6d30094sm401325d50.1.2026.07.24.21.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 21:31:30 -0700 (PDT)
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
Subject: [PATCH net v4] net/openvswitch: check Ethernet header length in  key_extract()
Date: Sat, 25 Jul 2026 00:31:28 -0400
Message-ID: <20260725043128.193164-1-blbllhy@gmail.com>
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

Fixed by calling check_header() in key_extract() before accessing the
Ethernet header.

Fixes: 217ac77a3c25 ("openvswitch: allow L3 netdev ports")
Reported-by: AutonomousCodeSecurity@microsoft.com
Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
---
v4: Update documentation and move variables into the Ethernet block.
v3: Use check_header() per review, fix format issue.
v2: Moved the check into key_extract() per Ilya Maximets.
Link: https://lore.kernel.org/all/20260721143602.64677-1-blbllhy@gmail.com

 net/openvswitch/flow.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/openvswitch/flow.c b/net/openvswitch/flow.c
index 66366982f604..8ad0be37a65a 100644
--- a/net/openvswitch/flow.c
+++ b/net/openvswitch/flow.c
@@ -889,8 +889,6 @@ static int key_extract_l3l4(struct sk_buff *skb, struct sw_flow_key *key)
  * Ethernet header
  * @key: output flow key
  *
- * The caller must ensure that skb->len >= ETH_HLEN.
- *
  * Initializes @skb header fields as follows:
  *
  *    - skb->mac_header: the L2 header.
@@ -910,8 +908,6 @@ static int key_extract_l3l4(struct sk_buff *skb, struct sw_flow_key *key)
  */
 static int key_extract(struct sk_buff *skb, struct sw_flow_key *key)
 {
-	struct ethhdr *eth;
-
 	/* Flags are always used as part of stats */
 	key->tp.flags = 0;
 
@@ -926,6 +922,12 @@ static int key_extract(struct sk_buff *skb, struct sw_flow_key *key)
 		skb_reset_network_header(skb);
 		key->eth.type = skb->protocol;
 	} else {
+		struct ethhdr *eth;
+		int err = check_header(skb, ETH_HLEN);
+
+		if (unlikely(err))
+			return err;
+
 		eth = eth_hdr(skb);
 		ether_addr_copy(key->eth.src, eth->h_source);
 		ether_addr_copy(key->eth.dst, eth->h_dest);
-- 
2.53.0

