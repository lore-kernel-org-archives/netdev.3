Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343972AE78;
	Thu, 10 Sep 2026 09:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789031045; cv=none; b=GAKd1PBXdeIUB+nPrkVlN0uqBBePCS+VV1rJIfu6VGtkEkqvYkG42HWjJluQe5WDDBZpUQ41NhoJGMidoK+lZduu3/hFeS7MGxzwV2c3q2p4j8uJMLCMERhK13vwTz+i/PePZz6fB9fh8fqR/dFqq6JKtoJWpxmZi8cC9hxcCfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789031045; c=relaxed/simple;
	bh=dTFDxdfNVHzX5ll4ow+62nY5L2LVtLUyxLqlUqDgwH4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kH0IXWWJZC4g9kTLtnO1+ONHUDQaP1gAL9Cje/4t7IjPaKt0r1uxsmyNyUppaoxOcjjfUfZx+xVjigm5vBggArIILNfyJxuHi/WAe4DP1/XixrbWQcvWseJpWPqaek2Q6L3RJV97pKnFuVCoTncDnL7fV+Namq+KvQ9iEIpIC4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=YTJ14IFp; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="YTJ14IFp"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68A8pW87654210;
	Thu, 10 Sep 2026 02:03:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=x
	edCww0cRyP5pC6TEBEHK15XlMCRRo5Jq3Sh+1cAtSI=; b=YTJ14IFpx4/M7zbNg
	xqA6rbUPZ7GpnF0PHCcLcaQNbh+DtlcH7xDwZtL6TSILSQiWugC3+PfwrFLSP1a9
	xxbco3PK0zPeor6XlQhZY3TwdgQtsv2YP00Do2JTvq4uC18hbRKJKGAYSekGNKZ+
	utL/cr54yE9TepDQNT9LzxWP7ID2M7T1UMDpRKnP+Vz256sKiGowg8PZdhDrBYOJ
	2Ol/7VSz3ByZo9pi5fg3zIw8LnVwxthsANTmPxb9GYlYNyY2Ng7uWhxdn+xGby9k
	t2xwAmGWNKPqQVLrfeULhy6HHjvnjtuOiG+nETB045VNbszU3tI5it2lyItn4glJ
	N9hfw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gkcxntrcu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Sep 2026 02:03:54 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Sep 2026 02:03:53 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 10 Sep 2026 02:03:53 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id DF4653F704E;
	Thu, 10 Sep 2026 02:03:49 -0700 (PDT)
Date: Thu, 10 Sep 2026 14:33:44 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev-bot+sashiko@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        <hkelam@marvell.com>
Subject: Re: [PATCH v3 net-next] octeontx2-pf: report port connector type in
 ethtool link ksettings
Message-ID: <aqJycF8VS6268u7o@rkannoth-OptiPlex-7090>
References: <20260909040621.397255-1-rkannoth@marvell.com>
 <178901476356.219967.4043623609208931989@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <178901476356.219967.4043623609208931989@kernel.org>
X-Authority-Analysis: v=2.4 cv=K923jCWI c=1 sm=1 tr=0 ts=6aa2727b cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=9R54UkLUAAAA:8
 a=M5GUcnROAAAA:8 a=VwQbUJbxAAAA:8 a=xn5eHuDypWZXWY9MClUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=YTcpBFlVQWkNscrzJ_Dz:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: OqRg_7O-GWcSOwKiSf5iTq_iHVjxI-vx
X-Proofpoint-GUID: OqRg_7O-GWcSOwKiSf5iTq_iHVjxI-vx
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDEwMSBTYWx0ZWRfX/bW+pMWbw3AG
 eW1NUwl7w9bppAMKlSV37BaY2eN3a0lcr4Jsy223d5S227C7zq4OwBEubjV5vtks7uezr4KYctG
 YwrzfBqiGamxp49X4JFYBlRhHdkT5GE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDEwMSBTYWx0ZWRfX6WFFeSTMb3rd
 GhZ8Bm4PZLaUpNYOjSrHrui2i8t8zs6rh4885LsrPQa2GGgayUVF8I8tyWuKp6DkQksW311/lBB
 AMJt5gKdoZjMR52OquDWK14QYKAIHkwgQQujv4gvBNHSB/Jno5xAAz7jeqGb1W8D84hUqq8cIQi
 a1rPUsdzpv8SPxs2X5fawHoa0EvsKXPQOV4p3JhS5x2PDUsVRq6AUIyE4jNnue043J8CDU6GeV7
 fhFk0W+6zKUQes7HAFutr/L8brjaQcFGxrSQfBKj6usqI6GaTFxXqX+ZSESSzvHNEljzwFXbKFR
 2P2o0GQkOo9UgFkCuLgN7+oeaGSRrfjh+i2zX6qpL04Q4GL8o0HrmiZivaORmsHcTgne6BhE1MP
 YxRg6CIkAbJQqGFXVrmNd2cYstTFckL5FyfSPaXsDjoVqb9QY8HzHppSnJWZ85TzaRQkCwhIcqB
 qc8lF687Dz+gS4YJFVA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_03,2026-09-09_02,2025-10-01_01

On 2026-09-10 at 10:02:43, netdev-bot+sashiko@kernel.org (netdev-bot+sashiko@kernel.org) wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
>
> Critical: 0 · High: 0 · Medium: 1 · Low: 0
>
> - [Medium] otx2_get_link_ksettings()
>   (drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c:1236)…
FW is setting it properly.

>
> --
>
> octeontx2-pf: report port connector type in ethtool link ksettings
>
> otx2_get_link_ksettings() now reads the connector type out of the CGX
> firmware shared data (struct cgx_lmac_fwdata_s.port), masks the low eight
> bits, checks the result against a list of ethtool PORT_* values and stores
> it into cmd->base.port.  Unrecognized values become PORT_OTHER.
>
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
> > index 9bee1b91eeaa..a05dee0085a3 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
>
> [ ... ]
>
> > @@ -1231,6 +1232,23 @@ static int otx2_get_link_ksettings(struct net_device *netdev,
> >  				OTX2_MODE_SUPPORTED, cmd);
> >  	otx2_get_fec_info(rsp->fwdata.supported_fec,
> >  			  OTX2_MODE_SUPPORTED, cmd);
> > +
> > +	port = FIELD_GET(GENMASK(7, 0), rsp->fwdata.port);
> > +	switch (port) {
> > +	case PORT_TP:
> > +	case PORT_AUI:
> > +	case PORT_MII:
> > +	case PORT_FIBRE:
> > +	case PORT_BNC:
> > +	case PORT_DA:
> > +	case PORT_NONE:
> > +		cmd->base.port = port;
> > +		break;
> > +	default:
> > +		cmd->base.port = PORT_OTHER;
> > +		break;
> > +	}
>
> [Severity: Medium]
> Can this report a wrong connector type when firmware never populated the
> field?
>
> PORT_TP is 0x00 in include/uapi/linux/ethtool.h, and the ethtool core
> zero-fills the settings before calling into the driver:
>
> net/ethtool/ioctl.c:netif_get_link_ksettings() {
> 	memset(link_ksettings, 0, sizeof(*link_ksettings));
> 	return dev->ethtool_ops->get_link_ksettings(dev, link_ksettings);
> }
>
> So a zero firmware word takes the "case PORT_TP:" arm rather than the
> default PORT_OTHER arm, and ethtool prints "Port: Twisted Pair" on a
> fibre, DAC or backplane board.
>
> Is a zero word possible here?  The member was carved out of the previously
> reserved (zero-filled) tail of struct cgx_lmac_fwdata_s by commit
> 49f02e6877d1b, which shrank LMAC_FWDATA_RESERVED_MEM from 1021 to 1018:
>
> drivers/net/ethernet/marvell/octeontx2/af/mbox.h:
> 	u64 mgmt_port:1;
> 	u64 advertised_an:1;
> 	u64 port;
> #define LMAC_FWDATA_RESERVED_MEM 1018
> 	u64 reserved[LMAC_FWDATA_RESERVED_MEM];
>
> RVU_FWDATA_VERSION was not bumped at the same time, and
> is_rvu_fwdata_valid() in af/rvu.h only compares header_magic and version,
> so firmware images that predate the field still pass the ABI gate and hand
> back zeros for this word.
>
> Would it make sense to also consult rw_valid from the same struct?  It is
> the per-LMAC validity flag, and grep shows it is currently only referenced
> in mbox.h and rvu_debugfs.c, never by this new consumer.  Note also that
> the debugfs dumper added alongside the field prints rw_valid, lmac_type,
> portm_idx and mgmt_port, but not port.
>
> Separately, does the masking defeat part of the validation?  FIELD_GET()
> with GENMASK(7, 0) drops bits 63:8 before the switch runs, so firmware
> values such as 0x100 or 0x103 are published as PORT_TP and PORT_FIBRE
> respectively.  mbox.h documents no bitfield layout, mask or reserved-bit
> contract for this bare u64, so it isn't clear the upper bits can be
> discarded rather than treated as "not a valid connector code".
>
> Related to that, the commit message says:
>
>   "Extract only the low 8 bits of the firmware field and validate the
>    value against the standard ethtool PORT_* definitions before
>    publishing it to userspace."
>
> Given that neither the unpopulated (zero) case nor invalid values living in
> bits 63:8 can be rejected by this check, could the description be made
> more precise about what is actually validated?
>
> One more question on the encoding itself: is there an in-tree statement
> that fwdata.port uses ethtool PORT_* numbering?  The only other firmware
> description of a "port" value is struct cgx_lnk_sts.port:8 with
> RESP_LINKSTAT_PORT in af/cgx_fw_if.h, and that macro is defined but never
> decoded by cgx.c, so the mapping to PORT_TP/PORT_FIBRE/... appears
> undocumented here.
>
> --
> Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260909040621.397255-1-rkannoth%40marvell.com
