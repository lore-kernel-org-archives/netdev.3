Received: from flow-a8-smtp.messagingengine.com (flow-a8-smtp.messagingengine.com [103.168.172.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AC03D411D
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 07:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785138099; cv=none; b=h0CCHgolMcnGqV9cy5xDmlpoPN+IP9NZDvTPqz5B8VDRsvxXKdZEJvHqvgaCwSY3njoOso6EId/LRELfYvs4DEK80ahrjFWghC43PtdDkwBLBx6ZZEGzV/PNYD8VS2nNasjGGRW/4ld5hUHVX/4U4aMoCrS1tdMsc/Jzkk5vYsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785138099; c=relaxed/simple;
	bh=tWWlxv2Y5cIn6iqt+xC+l+NinaF3IkPEODOPxiD5cEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RpCDv5VTQEOxCAIrvdX1wTAgzPvDjthNUWW0TCWfQADEbhij2sAis5LHGqMSwoBtT4dI5YXNZUbCRahgKytviIrGt/BesHkTB6MSPpUKO06i4byvZuV6CV6S42xQbfyHYKSHGhRHPyNoY278JLmKZHjYVi68b9ymdrcHphA62EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=mG6V3dFj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BtaeCgnr; arc=none smtp.client-ip=103.168.172.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="mG6V3dFj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BtaeCgnr"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailflow.phl.internal (Postfix) with ESMTP id F11F31380120;
	Mon, 27 Jul 2026 03:41:35 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 27 Jul 2026 03:41:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1785138095; x=
	1785141695; bh=4yYZBYsaeI09Mklf1n+JFWv/gLtDzuwSHmx88gUwGTs=; b=m
	G6V3dFjpih5xm42WBW4M/Yf0bVYxJEOJYcOmEFUqm5meIrtCTo3uMHQZHCuxy870
	xDqXlByrqO1HC8S4brtL64QoubUS55mFgXXE78Sa1HPzPiTzeZeSarGVMWidfOin
	G9zSNpv3kpaYXV3zXtO79jpr7j7k/bTi0GM7PAzH0emZrAvh80VkgSQIZQuKPOSI
	TSjPGwbfVVCqs8/Kdc6KDcIA7nF9hJ3i/CSXfTRNg/fkYSWTc8s23OIgYOBwEXnk
	qAzkj+o+Rtibxj2P0Vp+5NIPULc6mVDrStcwcAW7v595Y4FqmvhiqukibM8MtZ2G
	TXBXgJyGIG5/7qATAp1lg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1785138095; x=1785141695; bh=4
	yYZBYsaeI09Mklf1n+JFWv/gLtDzuwSHmx88gUwGTs=; b=BtaeCgnrVL1tUrIZ5
	p9gu01ukfCeSZsqU4dAtluNbh4kH2MOx3u3k3dN1T9N2tehvXPGF3v1WHwbASS34
	xiQl0DZNMOKfXGAi2huEdn5W2D6vmKOQAX6TTWYeP6NX3ot1+88//DUwNiuBo/NK
	5cyXdKuMiBgENzYsIoLucr4v90STKQfDh4Jz/Xn7W9a85R+nKLTc9xHfRExav8rZ
	nuxmAkjKitbnqM+bGZZrdMbodx+h3VWcBy5Ltc1lIv4bBNHkvinZqJ8dgtZfSbAa
	B/rXgRHh/W+J0oD+lDccmilZiXu2szs/NAdbd59j20kcnS9QCP04XOYmYVPTvZ9Y
	LYLPg==
X-ME-Sender: <xms:rgtnag5INyqMthfeqvGDPHF_xb1ybxqMrItIK876wy3pnxccM_eC-g>
    <xme:rgtnanHQbF0uwDr8MS8rrC1Ppq_BqBrh3Vif6fwU3_hwd91EwfIDL-WG5UpDg3D-P
    lGCgNGS-kxCIENMvJbTNVvkRVQtpQSXGWUcJdnZhAmanmpIVT1KpSVA>
X-ME-Received: <xmr:rgtnagVEfpG018Mm5PsziRQ5lcbdKuK7aVFVFFErat2hejK7cuKMJ_cZ6SQzZb4nGyjld6JQyw>
X-ME-Proxy-Cause: dmFkZTENxRucv7q9/zhucnfiKu+rVGcJe5BBaR1s3eWMOmRBLzeLO62kt/k+2iSbGEBGvf
    NagAeXotYwMwN+EnOsOoRmqR+/AMRL5ino7Zd/D7h1F70w53T/KNb1vtncSX9ErP3d4Xow
    0mPDpoyw2zybZHtSAfXtHejlv8sx0LpOcH/Sqx+PhV5w+Z6j5O1Brww6m0wDDRCAJ1isC5
    tCxKpZy579kdXHDqMqZYyhN36Fs2L5XVTDKO3YfJ3zZCY8vlZAaUIpd8fXEzVD+pSXSGhT
    j9GkkGRPnalOTp2qJdl3SWW4MlzkCGGB7YWycU/xYrQs2lKPF/je/wi/9+crhTuLmZzkYw
    f2zpY8oQoWqCLFyOwhSsZkxoxf1zRrePTrpibQ7liuU7GpOpqYXxzX/68RwdbDUcw0M/fo
    5l0Nk+rNswsiVM51MZlywzAutr2WPjsQ26HKhZOk3v53pMhAx6aSrcWRPJmNcBEENDRl6Z
    DJau1naXyT/L5LPi39pzvM6/Iolw7aUaidgshU7m6AJqz/54QGJ0pt0HM867YNzitshkBo
    hTWn3VT6mTrNZV3ZYmQsdiH2+kU15dT5We9Yl80cyPfrrSU7IwogBVKoW/Pxsil032LwT8
    8XIcBPVxR9di1jZJh1dmBSHb4GTiYI5m0CCz0f6RbkPYHUC87ZC7vpPLDPvA
X-ME-Proxy: <xmx:rgtnarXEPvHYUCF59pQbV9SbBNXotfb3qXgAzk-ShuKNIztMBSPOtQ>
    <xmx:rgtnamI_BJyxt9VTDpgIltrDUGVjfMr_GQ0PLbPOq_FCEFsyljUvag>
    <xmx:rgtnarDdNjDPv2aez7jAtNnH6B6GvyoBMFF7sqdnXqlperKsysqvgA>
    <xmx:rgtnamc5Vd5KQT9i2qA9glg36GU5LqCYGa8ItNFqM40Qq5oK1CBuSA>
    <xmx:rwtnarMuaThPIooInBuseP0OISAMIAdx8to-w8A9QYdYsHlNrAW3dTyY>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jul 2026 03:41:32 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: attinagaoxu@gmail.com
Cc: alchark@gmail.com,
	maxime.chevallier@bootlin.com,
	chaoyi.chen@rock-chips.com,
	andrew@lunn.ch,
	netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH net-next 0/3] net: stmmac: dwmac-rk: add RK3576 GMAC 25M refout support
Date: Mon, 27 Jul 2026 19:41:30 +1200
Message-ID: <20260727074130.1138409-1-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260727021048.3375444-1-attinagaoxu@gmail.com>
References: <20260727021048.3375444-1-attinagaoxu@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Gavin,

We ran into the same thing on the ArmSoM CM5-IO. As Alexey and Maxime
say, the 25 MHz output is a CRU clock muxed to a pin, so the PHY should
enable it, not the GMAC. I sent that for the YT8531:

  https://lore.kernel.org/all/20260719034555.3623003-1-gahing@gahingwoo.com/

It has Andrew's Reviewed-by and is waiting for net-next. On the CM5-IO
the YT8531 comes up at 1000 Mbit/s with no dwmac-rk change and no dwmac
binding change.

Your board has a YT8521, which uses yt8521_probe(), so it needs the same
devm_clk_get_optional_enabled() there rather than in yt8531_probe(). I am
happy to fold YT8521 into my patch, or you can send a small follow-up
once mine lands, whichever the maintainers prefer. The board DTS then
just needs a clocks phandle to the CRU on the PHY node.

Thanks,
Jiaxing
