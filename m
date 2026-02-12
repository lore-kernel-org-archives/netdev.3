Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C0E72623
	for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 08:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770884113; cv=none; b=r5I/4lQp95ax/bUbLba4Cj1NLG3XcA4LUirB06YPrPQnk9h/FslfR8pV+8Lv25Gdcxm2Kw7sSh0nvWvkx9JGNMFy4/xUGgwYcI4qgZ/s2J0DnzjRDu/FTh+o4hrhEcOFvTv5hm2mnnIiIyWJb3d2r//n7lcE0hcbuZTbDUYA4w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770884113; c=relaxed/simple;
	bh=FN4A2yY0+xoW17KhwSyoMZPJzAXwEZFTcnFUvKsLxMQ=;
	h=Mime-Version:Subject:From:To:CC:In-Reply-To:Message-ID:Date:
	 Content-Type:References; b=C0WiKwy45R+uPN0e52jvsJj4IZwUHC6yPjc39Z64ShX5nGhpS5jABhL8JxnwDwLglH7cyCb37uluYD3B+QuyH4Xk4MhRksYQbw3sYZqlkrXTw8ap3JmmTDtBhSktiPIvGTNErvUQ6hVqy+HT856t50DmRuircAFK0NWNvkyN9Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=cbygj7hN; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="cbygj7hN"
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20260212081502epoutp0316e712f07eb20b48a7942b9b359ad81b~TcbVsVl3N0542305423epoutp03K
	for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 08:15:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20260212081502epoutp0316e712f07eb20b48a7942b9b359ad81b~TcbVsVl3N0542305423epoutp03K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1770884102;
	bh=FN4A2yY0+xoW17KhwSyoMZPJzAXwEZFTcnFUvKsLxMQ=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=cbygj7hNvj+KSp1QZ2wnh3PQYby3QKY8UVbK47MEeM1npd3MSWbJb9fJby1urCwz1
	 xdXRJW8Y+bqkdOyCIgnAO28asL9lHnDEH4Qii6KCmPi+PC5gELxGZJMtBVnwKDdTNU
	 uxTv6h/H1lmPi8T2HnSP4uydRDTZ/CnXTltA6fGE=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTPS id
	20260212081501epcas1p2db76ea9c7dbd41e7d757278f8f46718b~TcbU9cdIe0524405244epcas1p2d;
	Thu, 12 Feb 2026 08:15:01 +0000 (GMT)
Received: from epcas1p2.samsung.com (unknown [182.195.38.194]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4fBSlT4VHmz3hhTB; Thu, 12 Feb
	2026 08:15:01 +0000 (GMT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: RE:(4) [net-next,v3] ipv6: shorten reassembly timeout under
 fragment memory pressure
Reply-To: soukjin.bae@samsung.com
Sender: =?UTF-8?B?67Cw7ISd7KeE?= <soukjin.bae@samsung.com>
From: =?UTF-8?B?67Cw7ISd7KeE?= <soukjin.bae@samsung.com>
To: Eric Dumazet <edumazet@google.com>
CC: Fernando Fernandez Mancera <fmancera@suse.de>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "netfilter-devel@vger.kernel.org"
	<netfilter-devel@vger.kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"dsahern@kernel.org" <dsahern@kernel.org>, "kuba@kernel.org"
	<kuba@kernel.org>, "horms@kernel.org" <horms@kernel.org>, "phil@nwl.cc"
	<phil@nwl.cc>, "coreteam@netfilter.org" <coreteam@netfilter.org>,
	"fw@strlen.de" <fw@strlen.de>, "pablo@netfilter.org" <pablo@netfilter.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <CANn89iJ6MJxh7BFjVdBMBLYeopgJ52Sbg7jEfQbQeQ-n0MUOTw@mail.gmail.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20260212081501epcms1p199584f85bafe3711791c419be09cb8d6@epcms1p1>
Date: Thu, 12 Feb 2026 17:15:01 +0900
X-CMS-MailID: 20260212081501epcms1p199584f85bafe3711791c419be09cb8d6
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
cpgsPolicy: CPGSC10-711,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260211030048epcms1p54c6ed78458f57def8e3163032498ca00
References: <CANn89iJ6MJxh7BFjVdBMBLYeopgJ52Sbg7jEfQbQeQ-n0MUOTw@mail.gmail.com>
	<20260211103243epcms1p2dd304fd11b28df04f4e680e8c90a7fc5@epcms1p2>
	<207b2879-e022-4b50-837b-d536f8fcabcd@suse.de>
	<CANn89i+mNojd9mUL_dt_=D+7nZ9xcV96CYJG_LYFmBZDOYUMFQ@mail.gmail.com>
	<20260212002207epcms1p7a1c19ed12038cf74f8632e5a305bd7ec@epcms1p7>
	<CGME20260211030048epcms1p54c6ed78458f57def8e3163032498ca00@epcms1p1>

Hello,

Thank you for the detailed explanation and I understand your concerns.
Given your feedback, we will reconsider this approach and rely on
the existing sysctl tunables instead.

Thank you for the guidance.
