Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.220
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792570881;
	b=pZ7p8FYH7z0xv05WG1srhzhyZvpkQrfCQ+H/PmYMWAEaREbuca9zBE2i3dkL+oID5Km6
	 u0c8UQFhM9T0PW4FuOL7eDm9Hk47F+QFKG0PyEkHYYEsHW3GQgB8Vz8qliAIa9l0iY2i5
	 ICM6bT8KEKr9jXc4wQ/b5NISzAlDFGQnAaXurImsBZnlwq2XGPJaFoEwjbVcCsijQYrQY
	 Esr5dg86JqUPu0LWapF96Ib+Xyqmyk/DfzJ94ksXio5iUlzV9smhai/kG0kb47gRHofU5
	 WVsn2mBmWqFG5H2PBrBy1WRv5Kxwp1DpCCsgggQlV/AkP2BaHTy6W7erseEBZwIA+Aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792570881;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=Crmd2bM2PbFygsXayYi4dObxKuPU+CEb2DoYjzmN3no=;
	b=szuFW/0+02GvbSNLSpHaVwSiSqpQqTrohkPa++2qw3uw+5xihXyMDraJzFmKEikwtpTu
	 Q10MIvj9u1+XUbLALVpZSR4Pkax19eN+iIc/USeTSPmIIemaTSWdlwQtz8m5GP4wluvTZ
	 6ShVx9oV4bYWv4PCahjjLb5P+E3tdvr0P8QMwcOooMrsW4kxx3zIYXfV39cTgUMjuFNC3
	 5X7MC84KqCokUNPAk8oWv8Nwg/oDeWRYSpwJz0pndDHsZ7Rq88dKnsav1AiyDuJKEaCZn
	 N+m0aNwjskC0Jizttt0MwBERCieTgEY3yQR1bCY1S061qlQ/I5zIz+GA3j9XiiDf14Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Tzo74RtU;
	arc=none smtp.remote-ip=113.46.200.220
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAB8606A319;
	Wed, 21 Oct 2026 08:21:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BAB8606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Tzo74RtU
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Crmd2bM2PbFygsXayYi4dObxKuPU+CEb2DoYjzmN3no=;
	b=Tzo74RtUq/fkCOoiQ+lxSXI+yqO/EK7W7SQLlgoSbAyX1NB1WGPbfKjFqUz3KVU1eMaYQSgrI
	eSBdi9W/Evz5axLSRqwEhV9KhDoV2e4EXRjxANGwHpS111LnzwaNdpt7iqa02s4QWlkJgfdHfRA
	fESZEm+/aRyNDe5tblY8uQs=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4j8j0l0HpSz12LcX;
	Wed, 21 Oct 2026 16:21:11 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id DB7644056E;
	Wed, 21 Oct 2026 16:21:09 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.38) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 21 Oct 2026 16:21:08 +0800
From: Fan Gong <gongfan1@huawei.com>
To: <kuba@kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<dimitri.daskalakis1@gmail.com>, <edumazet@google.com>,
	<gongfan1@huawei.com>, <horms@kernel.org>, <hramamurthy@google.com>,
	<ioana.ciornei@nxp.com>, <larysa.zaremba@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<maxime.chevallier@bootlin.com>, <mohsin.bashr@gmail.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <tengpeisen@huawei.com>,
	<vadim.fedorenko@linux.dev>, <wudi234@huawei.com>, <wulike1@huawei.com>,
	<zhoushuai28@huawei.com>
Subject: Re: [PATCH net-next v17 1/2] hinic3: Add ethtool statistic ops part1
Date: Wed, 21 Oct 2026 16:21:04 +0800
Message-ID: <20261021082104.14495-1-gongfan1@huawei.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20261020175113.182b3b92@kernel.org>
References: <20261020175113.182b3b92@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemf100013.china.huawei.com (7.202.181.12)

> On Thu, 15 Oct 2026 17:55:43 +0800 Fan Gong wrote:=0D
> > +	HINIC3_RXQ_STAT(alloc_skb_err),=0D
> > +	HINIC3_RXQ_STAT(alloc_rx_buf_err),=0D
>=0D
> Why bother separating these two? Rx packet was lost due to memory=0D
> pressure, doesn't matter which part failed to alloc.=0D
=0D
The `alloc_skb_err` counter signifies a failure in allocating a skb,=0D
whereas `alloc_rx_buf_err` indicates a failure in allocating the data=0D
buffer referenced by the skb. Given that these two resources are allocated=
=0D
and managed independently, distinct counters have been implemented for each=
.=0D
=0D
> On Thu, 15 Oct 2026 17:55:43 +0800 Fan Gong wrote:=0D
> > +	HINIC3_PORT_STAT(mac_rx_1519_max_bad_pkt_num),=0D
> > +	HINIC3_PORT_STAT(mac_rx_1519_max_good_pkt_num),=0D
>=0D
> Isn't the 1519_max_good just the last RMON histogram bucket?=0D
=0D
The `mac_rx_1519_max_bad_pkt_num` metric functions as a specialized counter=
;=0D
strictly speaking, it is not the last RMON histogram bucket. It quantifies=
=0D
the aggregate number of packets exceeding 1,518 bytes while simultaneously=
=0D
providing granular statistics for such oversized frames. Consequently,=0D
this metric is classified as a private, non-standard counter within=0D
the `ethtool -S` output.=0D
=0D
> > +static struct hinic3_stats hinic3_tx_queue_stats[] =3D {=0D
> > +	HINIC3_TXQ_STAT(gso_packets),=0D
>=0D
> Isn't this the standard lso/tso counter from queue stats?=0D
=0D
Yes, it is.=
