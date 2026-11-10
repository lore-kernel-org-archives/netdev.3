Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=211.75.126.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794304744;
	b=ZAGI53vsUTC95MGNVGwDBL75RZupYR8aWUBHUaqCK6wX2Y2wPbXvyoD2FdRDI06AO+qp
	 MUOU/vgFaug7k6KC8OW0FG9Jc7kezvk+eDHgTu0PJTC2+oWc4Xff/ZdZQ+vLgT5pW9s+J
	 XlCyub91sAYgZCLn98YLX/S8rb54hhxcVLsAW1yEo7w3oR0VJ/foSkM2gd+bVEX5qcBl3
	 pHsyQhADajcWxqn2PbOiKZ/ZGPqVsZmZ+XtC8ZY56pxUIMdWGwatZak0dmEx6Irfh4ETD
	 sS3Ol5MqdPPDLtW+H7PLkuzAZtrZChAWhOEuw2POsdcnt4YNWA4Ewj6QUv1SQGQNfFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794304744;
	h=DMARC-Filter:X-SpamFilter-By:DKIM-Signature:Received:Received:
	 Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:
	 References:In-Reply-To:Accept-Language:Content-Language:
	 x-originating-ip:Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=oS004R4Q/p4GtJUctdLJ+apSKurv7OcxpF2uLd03vYs=;
	b=klHgM+pYC+wWtUvsDyS0PJBm6vvFsPSkDwd16t+nn+BIhjCN38ufpW9UVzZRuMiiE9OJ
	 +Ql6ttfwPif4PHOWHGhfNBMsPKGiTg1vzD4fHsL9MBzcbgEQlPu22SnmoElUBX7qkUyB/
	 EV1WkadSA9fsTqR/V31zMrTNsJyOydAdiyGwxpTVSpUmMQmjzSimROVkZhOpD2KwBi4Rf
	 xQwnARruBfy2ZRWow0nmOyLOKwWr8ffvhHHgs5rBBOCvYiQkzbICsuh/AMk6BLp0Bgzre
	 9ViwM+v2iKFX2ZmAkAy7YRsDAn/zlkYGAo7dR/dbx3zYH/fpXWGy3LMJEWIwNJ4+6yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=realsil.com.cn;
	spf=pass smtp.mailfrom=realsil.com.cn;
	dkim=pass header.d=realsil.com.cn header.i=@realsil.com.cn header.a=rsa-sha256 header.s=dkim header.b=H7OYMvPt;
	arc=none smtp.remote-ip=211.75.126.72
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6244B606A325;
	Tue, 10 Nov 2026 09:59:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6244B606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=realsil.com.cn header.i=@realsil.com.cn header.a=rsa-sha256 header.s=dkim header.b=H7OYMvPt
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6AA9wLtU51227499, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1794304702;
	bh=oS004R4Q/p4GtJUctdLJ+apSKurv7OcxpF2uLd03vYs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=H7OYMvPtEQwelq4oV/ukBmax69NFK/5CVHXvZ65VWQxdnVcZau8HIcaBk7KLiWnU0
	 LM0gHWZSBdWCK3bi3Bgs1sc7/0k+YjJR0lipFXzdTo4TCC++onU4SM4P3323EaWXEs
	 A1WFd0N7HrPyRsuS9cKvZkJ/nmzHuB+MOs3j7NjHy8vNtfR6IbmUrw+nQLd0wkvud+
	 HYHsSdr2mWGy+bYgwu+V0UGwWn07aDqSFAD6HNhKOp+z5h8XjMhq4DS7KdPF7fYdbP
	 Jth5JEIPOCMkCoQxRaft7ncYGv0KACZF45REnyfnj+wTdC+lVeT5FVBsL3JuxNehpQ
	 MmTZYCRrf77Xg==
Received: from RS-EX-MBS1.realsil.com.cn ([172.29.17.101])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6AA9wLtU51227499
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 10 Nov 2026 17:58:22 +0800
Received: from RS-EX-MBS3.realsil.com.cn (172.29.17.103) by
 RS-EX-MBS1.realsil.com.cn (172.29.17.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 10 Nov 2026 17:58:22 +0800
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) by
 RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) with mapi id 15.02.2562.056; Tue,
 10 Nov 2026 17:58:22 +0800
From: Javen <javen_xu@realsil.com.cn>
To: Andrew Lunn <andrew@lunn.ch>
CC: "hkallweit1@gmail.com" <hkallweit1@gmail.com>, "nic_swsd@realtek.com"
	<nic_swsd@realtek.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
	<horms@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v1 1/3] r8169: make PHY OCP access safe in atomic
 context
Thread-Topic: [PATCH net-next v1 1/3] r8169: make PHY OCP access safe in
 atomic context
Thread-Index: AQHdb/JH1RCIF5rgLEGFx9BLgCKrZrclsS4AgAFgmNA=
Date: Tue, 10 Nov 2026 09:58:22 +0000
Message-ID: <b986c9c9f4b1407b99f62975885b73e6@realsil.com.cn>
References: <20261109023022.770-1-javen_xu@realsil.com.cn>
 <20261109023022.770-2-javen_xu@realsil.com.cn>
 <7791e7b5-fdc8-4c8c-ab5b-dcc7d7a6506a@lunn.ch>
In-Reply-To: <7791e7b5-fdc8-4c8c-ab5b-dcc7d7a6506a@lunn.ch>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

>
>On Mon, Nov 09, 2026 at 10:30:20AM +0800, javen wrote:
>> From: Javen Xu <javen_xu@realsil.com.cn>
>>
>> r8168_phy_ocp_read() and r8168_phy_ocp_write() wait for the GPHY_OCP
>> handshake with rtl_loop_wait(), which may sleep (fsleep(25)). Upcoming
>> PTP support for RTL8127A accesses the PTP block through the same PHY
>> OCP interface from atomic context (spinlock held, NAPI RX path), and
>> concurrently with phylib MDIO accesses.
>>
>> Busy-wait for the handshake with readl_poll_timeout_atomic() instead,
>> keeping the previous maximum wait time of 250us, and serialize the
>> GPHY_OCP register accesses with a new spinlock.
>
>There are many drivers which need to access PHY registers via blocking MDI=
O
>accesses. Why is this driver different?

In v1, RX timestamp was read in rtl_rx(), i.e. in NAPI context and tx is in=
 ndo_start_xmit. Since neither of those fast-paths can sleep, I had to expo=
rt the raw PHY OCP accessors and wrap them in a spinlock.

I will try to move all the code to phy driver and all accesses will use phy=
_read_mmd()/phy_write_mmd() and will be serialized by a mutex.

Thanks,
Javen

>
>        Andrew
