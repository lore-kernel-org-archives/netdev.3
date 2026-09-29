Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7BA51EE12
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 12:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790684560; cv=none; b=Iy3WlmM/3JGII0Ul5ebRCSQImPNQnPfCDsVba+B0YWbQL/nnx/mkEF8MdOXH+xX3qjrxxx5pfJ0aG0DfMODAbJxQl333SG8FkAKZwMVKHcxFafipEM9hOuLm5ShZ5S/M34hpSXgTi8hRbRv1B87WS/ms/eW85FuYeyINqXvv83Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790684560; c=relaxed/simple;
	bh=jyxZUwag4Snx6w7CS1Ff8QzWTwsdLnKCeNSRrAD6Qj4=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Cc:Content-Type; b=ky3YmEXhRwue4GDnQx6vWEmVl90oEQkGyAuuspmdofkGMoEL1LmnPFZSCPjmdTuvvJ5CU+45n7SVCLGG1EMNI8nUNPEHnZB2Dev7eqp9go0Y1FKBNO/2jBYHa7GHd/vuX+SbkNul+d3R/huAUfFe9QO200btos6Spb4HPDC00ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Emxv21Pk; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Emxv21Pk"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc797656e44so1308760a12.2
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 05:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790684556; x=1791289356; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:subject:to:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RJYJHIvticSjWb8jFlLhFo4kaOC5D+azks8bAAbUZag=;
        b=Emxv21PkrZa3lhpD6lRfz9nHujhfKlWlhdqXh/MypGXQCYcG+iRkiMAahQFb8eZAH/
         Fu632SpUAP8sprE/pP3Vp9VRAqdjn5+aNFopGgHpE24esBTkDx86UBn2ZdYU48fWwbPe
         ME4CEru5T6KN+tYN4REuTq9AIN+xPREJ45ojfbkx+wYf2AyxxdB+4Gwn37MKC5PccMw0
         Y1mWe1E38iQfxCnTRcynLsAZKnWNjHT+FrOShRnlnrChvlh331sYGJOdnUl7XypWQcBC
         Agcf12btt0RB3EGD9ACf2ETutxuvWXQxt5DD7cOtqHHk4Di7rjFQUqqtjHEk4nUh7puE
         a8Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790684556; x=1791289356;
        h=content-transfer-encoding:content-type:cc:subject:to:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RJYJHIvticSjWb8jFlLhFo4kaOC5D+azks8bAAbUZag=;
        b=diGT2GMPh6qj66furemHIeEvTe1qZuZP31g1amTbiCuGgGKaQpwaB4JrusKIAyR07J
         NpSui6367hb1hZ/Upj8RZgLN8KRIlJpb+G7kVrhrcLm71Qb8Z1B5GB9xuDzyrI5lWNZH
         jGS2h0CJCBPsg3zdZjpNzn+jmjL9E8hfAEn85QV0ZcRToU6ePlg0ZTtkHwGH/do+pqlZ
         qf2SgthZ0hyeJk8ZghurSnvhl95ll9wik58jgHIlsH/Or/3/Un1f74QgnQd9ax3LfSIn
         bE6DK/oqgfQJ9ytndA98+2rjHmVKyJfqcuozy5pGsYAH+NTLrVuXt/16Qv/hHia6Fpul
         7kDw==
X-Gm-Message-State: AFq9FYIT2Y524n3cMz+mzdamGIsLkNYynl8hApy3zL2UuhAK8O69rwTd
	HmkMxE/7X9TDExL6SLH+GJMa7Dgps1iUdU/guG2uCJ044qCDkDi5hGkQb8zFdxQl6jJTCg==
X-Gm-Gg: AYBFou1hh0nrL3WrBA3WJSU7PRK/YTrcT9+iDguswKVtk0blJDEBNfdbjlUsuM+5U+h
	XEJvXwJxgiZhLn5DNXUjezkceeSvsSLFM/EAR9vl0iT2G+NxPjBiO1F/DWTBz5z+852mOKwtoE3
	qh37Wc1br501OT7td/fLr+Mt+EY8dZWpa5j82490ZdkxjxF8NLVTFAuVZmbjWIYwLTY2HzPbu/6
	V3hZ01JErGIli7DRriSfh1tF80nr19HS1gM/76OhZkPDTATnVMIM+As4gmFZ8YAhgGvHWhVld+/
	THwDyFZFTAAzwpW8zyr4LEQK6qC4PVlfzQGTrL53baQWqFCcz+BiqUaCo6tWpAOa17eu4lHCDUY
	uM8CzWAXDboJrgEhKYfrZzy8rdYHoQCEaBAYPsPpq/ZEYuW/kHTxMjwM/bVNvjkh/Gcg+tynj5K
	eD6QlwWwtWQwEDEDU7TczggBvzOB1xUdKSyH+AEVMWOEnsW1g3Tw==
X-Received: by 2002:a17:90b:4aca:b0:3a1:8b70:d46b with SMTP id 98e67ed59e1d1-3a18b70e64dmr6457041a91.42.1790684555551;
        Tue, 29 Sep 2026 05:22:35 -0700 (PDT)
Received: from [198.18.0.1] ([2407:cdc0:8003::1027])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a492da42a3sm2643075a91.2.2026.09.29.05.22.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2026 05:22:34 -0700 (PDT)
Message-ID: <b397156b-c184-4061-a9d5-52cce5c4f07e@gmail.com>
Date: Tue, 29 Sep 2026 20:22:28 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Wentao Luo <luowentao077@gmail.com>
To: netdev@vger.kernel.org
Subject: [PATCH net] vxlan: fix NULL deref when joining a group without a
 socket
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Edward Cree <ecree.xilinx@gmail.com>,
 Fernando Fernandez Mancera <fmancera@suse.de>,
 Antonio Quartulli <antonio@openvpn.net>, Jiri Benc <jbenc@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

vxlan_sock_add() ignores -EAFNOSUPPORT when creating the IPv6 socket
of a metadata device, so the device can come up with vn6_sock NULL
after ipv6.disable=1. A later IPv6 multicast join still uses that
socket. vxlan_igmp_join() dereferences it and oopses.

This was observed on an external vnifilter device by adding an IPv6
group while the device was up:

   BUG: KASAN: null-ptr-deref in vxlan_igmp_join+0xb8/0x18c
   Read of size 8 at addr 0000000000000010 by task bridge/729
   Call trace:
    show_stack+0x18/0x24 (C)
    dump_stack_lvl+0x78/0x90
    print_report+0x468/0x5cc
    kasan_report+0xa4/0xf0
    __asan_load8+0x7c/0xd0
    vxlan_igmp_join+0xb8/0x18c
    vxlan_vni_update_group+0x2b4/0x390
    vxlan_process_vni_filter+0xfe0/0x1750
    vxlan_vnifilter_process+0x218/0x270
    rtnetlink_rcv_msg+0x1ec/0x514
    netlink_rcv_skb+0xc0/0x1f0
    rtnetlink_rcv+0x18/0x24
    netlink_unicast+0x4b8/0x558
    netlink_sendmsg+0x2b8/0x584
    ...

Return -EAFNOSUPPORT from vxlan_igmp_join() and vxlan_igmp_leave()
when the address family has no socket. The same leave path runs while
rolling back a failed join.

Fixes: d074bf960044 ("vxlan: correctly handle ipv6.disable module 
parameter")
Signed-off-by: Wentao Luo <luowentao077@gmail.com>
---
Simplest reproducer. Build with CONFIG_IPV6=y and boot with
ipv6.disable=1:

   ip link add vxlan0 type vxlan external group ff05::1 dev lo dstport 4789
   ip link set vxlan0 up

The NULL pointer dereference is then reproduced.

  drivers/net/vxlan/vxlan_multicast.c | 12 ++++++++++++
  1 file changed, 12 insertions(+)

diff --git a/drivers/net/vxlan/vxlan_multicast.c 
b/drivers/net/vxlan/vxlan_multicast.c
index 3b75b48dc726d..33ec1fd59ca82 100644
--- a/drivers/net/vxlan/vxlan_multicast.c
+++ b/drivers/net/vxlan/vxlan_multicast.c
@@ -29,6 +29,9 @@ int vxlan_igmp_join(struct vxlan_dev *vxlan, union 
vxlan_addr *rip,
  			.imr_ifindex		= ifindex,
  		};

+		if (!sock4)
+			return -EAFNOSUPPORT;
+
  		sk = sock4->sk;
  		lock_sock(sk);
  		ret = ip_mc_join_group(sk, &mreq);
@@ -37,6 +40,9 @@ int vxlan_igmp_join(struct vxlan_dev *vxlan, union 
vxlan_addr *rip,
  	} else {
  		struct vxlan_sock *sock6 = rtnl_dereference(vxlan->vn6_sock);

+		if (!sock6)
+			return -EAFNOSUPPORT;
+
  		sk = sock6->sk;
  		lock_sock(sk);
  		ret = ipv6_sock_mc_join(sk, ifindex, &ip->sin6.sin6_addr);
@@ -62,6 +68,9 @@ int vxlan_igmp_leave(struct vxlan_dev *vxlan, union 
vxlan_addr *rip,
  			.imr_ifindex		= ifindex,
  		};

+		if (!sock4)
+			return -EAFNOSUPPORT;
+
  		sk = sock4->sk;
  		lock_sock(sk);
  		ret = ip_mc_leave_group(sk, &mreq);
@@ -70,6 +79,9 @@ int vxlan_igmp_leave(struct vxlan_dev *vxlan, union 
vxlan_addr *rip,
  	} else {
  		struct vxlan_sock *sock6 = rtnl_dereference(vxlan->vn6_sock);

+		if (!sock6)
+			return -EAFNOSUPPORT;
+
  		sk = sock6->sk;
  		lock_sock(sk);
  		ret = ipv6_sock_mc_drop(sk, ifindex, &ip->sin6.sin6_addr);
-- 
2.43.0
