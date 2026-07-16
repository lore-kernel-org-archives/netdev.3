Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F01130F95F;
	Thu, 16 Jul 2026 12:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784204412; cv=none; b=lx63tpJe4zA+REUuvmJ40Osn9XEGq/VRfe1jTHo+/P4B0Ga8O8XtVDbfy4CbAbIoWppYOym8/Kftz+pFFR2PQvIqatnh/WOePDRCj3CT9xvyK5SbSTX72U2a/bKl+Iio4/wwtySOfT3Uryyn8sThQ5yM5EdV9IXdzrmYYkXeq7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784204412; c=relaxed/simple;
	bh=9TX3CitbWUKGHrB8D51zYwiiD5iRycUXS2KAi9+WQTM=;
	h=Message-ID:Date:MIME-Version:To:CC:From:Subject:Content-Type; b=X1SMJsmFz3vSGD8OngTiPvrWdOBkxuAQ9Lfqky4CrltQReGqZynZ2gS/QbLbh8wRpjeuP2vFZwIVAEtD2+YRgmiDoGqwsGXLK0YOWP9WS1DzS4NJhFMNVwPneLP/CwqVFPyun1nGHHbCMUTdQJ2JxSQ4rDyw6DxERLrnjv/K+pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=h-partners.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=P7seXuic; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=h-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="P7seXuic"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Bu1LLfuzd2nAEZgn5mU4YfWHv1CL5j3qcL1aHodI5Tw=;
	b=P7seXuicazuGkr41KgyDkJwaadkPzblzXkJyY2jIeesGrbbLmcBPngZNuLpjw92kkU8Gpm62Y
	/UjhpJPzu4BbNGVewYpRLjDBBEONeOuUsubNvfvFhJN//lMl6y1XVaPd9UGechlL9WdC3SbkUws
	XhuFqVXsf6KnRJc92ltKKfc=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4h1BhT4PZhz1T4JN;
	Thu, 16 Jul 2026 20:10:49 +0800 (CST)
Received: from kwepemr100001.china.huawei.com (unknown [7.202.195.168])
	by mail.maildlp.com (Postfix) with ESMTPS id CEAEA2012A;
	Thu, 16 Jul 2026 20:20:01 +0800 (CST)
Received: from [10.136.112.147] (10.136.112.147) by
 kwepemr100001.china.huawei.com (7.202.195.168) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 16 Jul 2026 20:20:00 +0800
Message-ID: <99d678ae-c7b2-4b44-b534-b8320679deb3@h-partners.com>
Date: Thu, 16 Jul 2026 20:20:00 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, John Fastabend <john.r.fastabend@intel.com>,
	Jesse Gross <jesse@nicira.com>, <gaoxingwang1@huawei.com>, huyizhen
	<huyizhen2@huawei.com>
From: xietangxin <xietangxin@h-partners.com>
Subject: [BUG] vlan: skb_under_panic when toggling NETIF_F_HW_VLAN_CTAG_TX on
 lower device
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemr100001.china.huawei.com (7.202.195.168)

[BUG] vlan: skb_under_panic when toggling NETIF_F_HW_VLAN_CTAG_TX on lower device

Hi all,

We encountered a skb_under_panic triggered by toggling
NETIF_F_HW_VLAN_CTAG_TX on the lower device while a VLAN device is
up and sending traffic.

Call trace
==========

 skbuff: skb_under_panic: text:ffffc0d2900283d8 len:74 put:14
  head:ffff334820249c00 data:ffff334820249bfe tail:0x48 end:0xc0 dev:vlan4
 ------------[ cut here ]------------
 kernel BUG at net/core/skbuff.c:116!
 Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
 Call trace:
  skb_panic+0xcc/0xd0
  __skb_checksum+0x0/0x480
  eth_header+0x48/0x1a0
  vlan_dev_hard_header+0xd0/0x284
  neigh_connected_output+0x16c/0x20c
  ip6_finish_output2+0x4b4/0xd74
  __ip6_finish_output.part.0+0x1ac/0x3b0
  ip6_finish_output+0x160/0x200
  ip6_output+0x13c/0x294
  ndisc_send_skb+0x41c/0x6f0
  ndisc_send_rs+0xac/0x3b0
  addrconf_rs_timer+0x42c/0x660
  call_timer_fn+0x54/0x290
  expire_timers+0x26c/0x420

Reproducer
==========

 # Create veth pair (NETIF_F_HW_VLAN_CTAG_TX is ON by default)
 ip link add veth0 type veth peer name veth1
 ip link set veth0 up
 ip link set veth1 up

 # Turn off HW VLAN TX offload on lower device
 ethtool -K veth0 tx-vlan-hw-insert off

 # Create VLAN device on veth0
 # At this point: header_ops = &vlan_header_ops, hard_header_len = 18
 ip link add link veth0 name veth0.10 type vlan id 10 reorder_hdr off
 ip addr add 192.168.10.1/24 dev veth0.10
 ip link set veth0.10 up

 # Turn HW VLAN TX offload back ON on lower device
 # This triggers NETDEV_FEAT_CHANGE -> vlan_transfer_features()
 # hard_header_len changes from 18 to 14, but header_ops is NOT updated
 ethtool -K veth0 tx-vlan-hw-insert on

 # When a packet is sent through veth0.10
 # - skb is allocated based on hard_header_len=14 -> ~16 bytes
 # - vlan_dev_hard_header() pushes VLAN_HLEN(4) + ETH_HLEN(14) = 18 bytes
 # - skb_under_panic!


Any feedback or guidance would be greatly appreciated.

-- 
Best regards,
Tangxin Xie

