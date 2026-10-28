Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=129.70.137.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793197788;
	b=H6fIjTOhnJjwW+ImtVIKN2hAbdwU3xqb95jTuW6cPmNPWWRw01HKgK9GM1SI8CyF0GwD
	 p0eL3VG6h4upUszqAZsuG++WkQHk7X/0/r08T+wEnWAq6PVTsPu4GyJhaqQzqvlmZz/fg
	 kHTmO7atTHEeiX9NkISo1ogoZRfEyoqfSU7m4bjq6Ti3kJS0cW92YEO1Dbp7Fd6skzWEZ
	 UopHGwLKmxP/LBqg7Yk8Q8MebpHh8Ad6jqOdbkeO/Gl/tceqCAs1ktCOEUyGEOL/g1ZQa
	 A21QFpLY3kP13navQFHdd1S+HzMmDt1wrbK9Qec7xKiNFgTDpJ3YKFaIgb0zN2fJdvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793197788;
	h=DMARC-Filter:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
	 Content-Type:Content-Disposition;
	bh=zsOlgHBs9Mth5zl+FODhlUHS2OrDrKvCGaKDR/F8sWE=;
	b=u7kjvTVhEIGDwN6z6jhrPbeN/54EWu00M8faoBH9Kd89La9dSGNnSNYe9HUiBcCGFtjQ
	 bTgdjRNYFv2If5YOiMyRbcTnpwCidQQKaaATGJJxQbvJ0fwWVIYMoYNpLXc99HL9c1NLV
	 9GDf+M9DeX10QA34PiQb2jdCUadqyaQaDiDODvck3soTxkEGThw7kN7Whzm+X8EgPaWKE
	 ol8g1tikuqyEmP9QdqNFYsIe18ZdojZW3bR+rZiGgdesuWuuYQ3glWKNcopmM0CxO9XRU
	 KzVDxD8n2oTsOytZ0tKOeZ7wMZYz9eAEYrq7Fhyt8Rsrnye6n5ehfxQ4PCpQXUdO/4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=techfak.net;
	spf=pass smtp.mailfrom=techfak.net;
	arc=none smtp.remote-ip=129.70.137.15
Received: from smtp.techfak.de (mailout3.TechFak.NET [129.70.137.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75240606A31A
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 14:29:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75240606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techfak.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=techfak.net
Date: Wed, 28 Oct 2026 15:29:28 +0100
From: Sascha Frey <sf@techfak.net>
To: netdev@vger.kernel.org
Cc: qotmddnjs@ajou.ac.kr, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, idosch@nvidia.com
Subject: [REGRESSION] vxlan: duplicate ICMP replies with nexthop FDB entries
 after 3fa64d86fc64
Message-ID: <20261028142928.GA8406@techfak.de>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I am seeing a VXLAN forwarding regression with Linux 7.2.7 and later,
apparently related to commit 3fa64d86fc64 ("vxlan: reject dynamic fdb
entries that reference a nexthop id").


Environment

Linux kernel: 7.2.7, tested from the upstream source tree
Also affected: Debian backports 7.2.9 and 7.2.11
Known good: Linux 7.1.8 and 7.2.6

The affected systems are Debian-based KVM virtualization hosts. Each
host uses Linux bridges with VxLAN devices attached as bridge ports,
acting as VTEPs.

The overall network uses EVPN. Some VTEPs run on the Debian 
virtualization hosts, while other VTEPs are implemented on Mellanox
switches running Cumulus Linux 5.18 with EVPN multihoming (EVPN-MH).

FRR/Zebra installs nexthop groups and VxLAN FDB entries on the Linux
hosts.


Symptoms

ICMP replies are duplicated. A packet capture on the source host's
physical interface carrying the outer VXLAN UDP traffic shows the same
ICMP reply encapsulated towards all remote VTEP addresses.

On a remote VTEP, a capture on the vxlan interface shows only one
request and one reply per sequence number.

Disabling GRO did not help, and the problem is independent of the ICMP
packet size.


Relevant FDB state

With the unmodified 7.2.7 kernel, the following entry was missing:

90:e2:ba:33:3b:04 nhid 536870949 self extern_learn

The corresponding nexthop group existed:

id 536870949 group 268435494/268435495 scope global proto zebra fdb
id 268435494 via 10.224.90.1 scope link proto zebra fdb
id 268435495 via 10.224.90.2 scope link proto zebra fdb


Revert test

I reverted commit 3fa64d86fc64 on top of Linux 7.2.7, without other
source changes.

With this kernel:

The missing VXLAN FDB entry reappears.
The duplicate ICMP replies disappear.

The revert removes the checks in vxlan_fdb_add() and
vxlan_fdb_update_existing() that reject dynamic FDB entries referencing
a nexthop ID.

This strongly suggests that the commit is involved, although I have not
yet established the exact mechanism by which the FDB entry goes missing.

Could someone help investigate whether the new checks can interfere with
EVPN/FRR-installed nexthop FDB entries, or whether this exposes another
issue in the VXLAN FDB handling?


Best regards,
Sascha
