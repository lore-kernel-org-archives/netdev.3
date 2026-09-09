Received: from mail.dspace.de (mail2.dspace.de [80.228.58.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096EE46C4A9;
	Wed,  9 Sep 2026 08:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.228.58.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788944313; cv=none; b=Tue7lkfU7qzUmuNev/2j6EZaqTKrNw8wggfmmYOy2audjsUL4961xiv1G3qw2onPG8jTNkOHGCEJlf8YkleccFR988ojqvKciU0Ivi4GOyLXISOjD20s8I/iUaqx4EHlnRkXiNhMmkGS6jjvlwc5imGQl9b3J88+TkOPgLA6tUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788944313; c=relaxed/simple;
	bh=VR5lz6e56CwLHQCzov/eaD5ZDxE3Nsomj2KxU1fy0aA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DYQ8Jot0m0CDs9p+H+kzIQWXohLQ664l83PwGRVWZg+4pZ4oLVhD38fC6c+jrIViy1gCNAjtRbVwgcw9KIebJHPrpgblrJgt3qmZXDIBwL2xSJmCBPmKded/M4gpx+kudFRPogq0z36iyamPQA9f4XeSUHlohSlgT593h3zHIO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dspace.de; spf=pass smtp.mailfrom=dspace.de; dkim=pass (1024-bit key) header.d=dspace.de header.i=@dspace.de header.b=ES3eO9xY; arc=none smtp.client-ip=80.228.58.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dspace.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dspace.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dspace.de header.i=@dspace.de header.b="ES3eO9xY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=dspace.de; i=@dspace.de; q=dns/txt; s=dkim1;
  t=1788944308;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W64OfXJBTXrdEHn01dbecqbXkdcTLtQbrrsQRWJQMCY=;
  b=ES3eO9xY69RiPQQ8Fep/5u2gqkeW29L/cA7LvOqYC268ILf+SkXOpuzx
   UEJOZjMYNO7RZJlcxSSZ6uPZS3ZzG2SVi68veCM3kS1bNsRvt08FB9CSl
   GZiG9ZmatiG/i5hWJSaAXp21aa6UmHtWSPjhCzpwGidpFglQfaFECpuhq
   0=;
X-CSE-ConnectionGUID: lesFjaISRZmDooY3588RlQ==
X-CSE-MsgGUID: WwlpYq3GRcO/083IRCND2A==
X-IronPort-AV: E=Sophos;i="6.25,270,1779141600"; 
   d="scan'208";a="5430986"
Received: from unknown (HELO Z1-1000) ([10.1.1.222])
  by mail.dspace.de with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2026 10:57:16 +0200
Received: from VM-Z1-1000-LIVE.dspace.de (localhost [127.0.0.1])
	by Z1-1000 (Postfix) with ESMTP id 50DDB60038;
	Wed,  9 Sep 2026 10:57:16 +0200 (CEST)
Received: from exchange.dspace.de (EX-DE-PAD-SE.dspace.de [10.100.196.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by Z1-1000 (Postfix) with ESMTPS id 41CED60036;
	Wed,  9 Sep 2026 10:57:16 +0200 (CEST)
Received: from PascalKW11-NB.dspace.de (10.71.5.241) by EX-DE-PAD-SE.dspace.de
 (10.100.196.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 9 Sep
 2026 10:57:15 +0200
From: Pascal Kneuper <PKneuper@dspace.de>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
CC: kuba@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, rmk+kernel@armlinux.org.uk,
	0x1207@gmail.com, si.yanteng@linux.dev, larysa.zaremba@intel.com,
	aleksander.lobakin@intel.com, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	DBaldin@dspace.de
Subject: Re: [PATCH net v2] net: stmmac: restore NET_IP_ALIGN in the RX DMA
 offset
Date: Wed, 9 Sep 2026 10:57:29 +0200 (CEST)
Message-ID: <20260909085731.108922-1-PKneuper@dspace.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <5aeb6fd1-f1c3-426d-a2c4-1ad45ddc8572@bootlin.com>
References: <20260813092923.284285-1-PKneuper@dspace.de>  <20260824125014.47862-1-PKneuper@dspace.de>  <09e7cd4b-b79c-47ea-95b6-1c1a96fe7657@bootlin.com>  <5aeb6fd1-f1c3-426d-a2c4-1ad45ddc8572@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: EX-DE-PAD-SE.dspace.de (10.100.196.14) To
 EX-DE-PAD-SE.dspace.de (10.100.196.14)
X-C2ProcessedOrg: 563f5800-21cf-4d8d-8aed-fddd1469e4ee
X-TBoneOriginalFrom: Pascal Kneuper <PKneuper@dspace.de>
X-TBoneOriginalTo: Maxime Chevallier <maxime.chevallier@bootlin.com>
X-TBoneOriginalCC: kuba@kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	rmk+kernel@armlinux.org.uk, 0x1207@gmail.com, si.yanteng@linux.dev,
	larysa.zaremba@intel.com, aleksander.lobakin@intel.com,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	DBaldin@dspace.de
X-TBoneDomainSigned: false

On Tue, 08 Sep 2026 22:58:05 +0200, Maxime Chevallier wrote:=0D
> Hi again,=0D
>=0D
> On 9/8/26 10:16, Maxime Chevallier wrote:=0D
> > Hi,=0D
> >=0D
> > On 8/24/26 14:50, Pascal Kneuper wrote:=0D
> >> Since the RX path was converted to zero-copy, the page pool page is ha=
nded=0D
> >> to the stack directly as the skb head, and the offset the DMA engine w=
rites=0D
> >> at is what determines the alignment of the packet headers.=0D
> >>=0D
> >> Before the conversion the payload was copied into an skb obtained from=
=0D
> >> napi_alloc_skb(), which reserves NET_SKB_PAD + NET_IP_ALIGN. The=0D
> >> conversion moved the headroom into stmmac_rx_offset() but did not carr=
y=0D
> >> over NET_IP_ALIGN, so on architectures where NET_IP_ALIGN is 2 the IP=
=0D
> >> header now lands misaligned:=0D
> >>=0D
> >>   64 (NET_SKB_PAD) + 14 (ethernet) + 20 (IP) =3D 98=0D
> >>=0D
> >> Same for the XDP branch:=0D
> >>=0D
> >>   256 (XDP_PACKET_HEADROOM) + 14 (ethernet) + 20 (IP) =3D 290=0D
> >>=0D
> >> On ARM32 this is fatal, because ldm and ldrd trap on unaligned address=
es=0D
> >> even when CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is set.=0D
>=0D
> > This patch breaks the stmmac selftests for Jumbo Frames on dwmac1000 :(=
=0D
> So looks like the problem isn't this patch, but rather both the way we se=
lect=0D
> the bufsize, and the Jumbo test itself :)=0D
>=0D
> This merely surfaces existing problems, I have some fixes that I'll send =
shortly.=0D
>=0D
> Maxime=0D
>=0D
=0D
Great! Thanks for testing and keeping us posted :)=0D
=0D
Best=0D
Pascal=0D
