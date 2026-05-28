Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DD337B007;
	Thu, 28 May 2026 12:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779972249; cv=none; b=Yu1g20jHG48EDA+5CVUbx10hfDWx7/iMNBDoykxPjqxqh6eECGztmYjDQx5XdyDJfeirCk7OIbAVcY8ufg2d9tHrSuL3NRkEI1z2ZgWY8AeCyKjbJmADYu1hyQTEyQdHD+DsM/SHKUdrw/dqZIrhsIn9ctrujhF75o9ftCD18cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779972249; c=relaxed/simple;
	bh=ktdHJTteuENZjygmIKdnyIPbq0G53A7TQmehHpc8RQE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=khgSuOvpE/LWm/2ed+7ZYHHNw/BhWyxgkhFRHvmbyl7TSv7Jmsl4lgjYPPhPe+aQ/LlUHre1F0jrV2qVGpZ6DkzPufPNd57v+U1kb5JxxAbghLxw/FD6bY8iBzvKXy5CVVtZIazM10L+auJ8m+4jORCEjGhdbRWIRfsodnfetyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=FWlKmQPN; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="FWlKmQPN"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64S8lf0K400653;
	Thu, 28 May 2026 08:43:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=yPs0+
	Ut+Mmj//US/eKG2HDyCXseT9Sv3IAvitcOiSrM=; b=FWlKmQPNlqE94ymYzCxVL
	2SCR5eP73++NKJu4yN7j+qWlkCTN14Lr8vRJU4XvPCDexREgEvql+PhC1X5pmW2H
	GhvDXofyfMucaVTnqpU9lPdAoAkd8sG3cLJDFENkP3S/jfc6EnhvhNaDT40VJQ26
	a5YgQEuqnLqHjLTWuWqs4Ty/Ksm6lQequ1TV4Artbd1LkBexPMJbCZZVqKa9r5Rt
	eKMOtjTTslHDTAOo8jd+x/hbt7hiK6FxqNLwMycRvpRgaUgfXmK5FVTlFOTLqNgJ
	DLDrtI4nZOSck33gCrzAXkVc1RMlmaGFiaNe1NIETeDMlbSmnpjzxFyEZk0t8p/y
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4ee7x1tsut-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 08:43:53 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 64SChpI2059440
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 28 May 2026 08:43:51 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 28 May
 2026 08:43:51 -0400
Received: from ASHBMBX9.ad.analog.com ([fe80::a11:40fc:1a6f:d912]) by
 ASHBMBX9.ad.analog.com ([fe80::a11:40fc:1a6f:d912%20]) with mapi id
 15.02.1748.037; Thu, 28 May 2026 08:43:51 -0400
From: "Regus, Ciprian" <Ciprian.Regus@analog.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
        Andrew Lunn
	<andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric
 Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Heiner Kallweit
	<hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH net-next v2 10/10] net: ethernet: adi: Add a driver for
 the ADIN1140 MACPHY
Thread-Topic: [PATCH net-next v2 10/10] net: ethernet: adi: Add a driver for
 the ADIN1140 MACPHY
Thread-Index: AQHc7Vnx3WPSKydSxEKkqCDJmkm377YjB1eAgABVdZA=
Date: Thu, 28 May 2026 12:43:51 +0000
Message-ID: <72c3a9a8040e4b8990f217d4072872de@analog.com>
References: <20260527-adin1140-driver-v2-0-37e5c8d4e0a0@analog.com>
 <20260527-adin1140-driver-v2-10-37e5c8d4e0a0@analog.com>
 <0aaa9a58-fac1-4de7-90f0-443db37228c8@lunn.ch>
In-Reply-To: <0aaa9a58-fac1-4de7-90f0-443db37228c8@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-adiruleop-newscl: Rule Triggered
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDEyOCBTYWx0ZWRfX3jaCi4H+1LRQ
 xa9q0vDugr/WMheo4sR4yiG+cj5Nz4MtFFiEjlAFgXZAEWWZIW0+70jpp1uu+y3MNdyAfQXAMYb
 TW0RIiWa+XUEWR6AncIRaVrkl2zA2GiVmjE9vM/sERpoqaCI0jy1g5lZtzqOMWjYlskOu3jNZaK
 P6nGTs5l8VxUTUv9Bbj7Ky6aRF5MBOwF3auqvaERkz9Z1hfD9/spL4kgoSCkgtmGHhOTm93gtcP
 eH+x/rtDGEEGj4XSmvfYiQhSNIWsFSaLlAhbcnR6Y80ayBMHu2uJ3kDghBt2cXfi/Act3OX7u/n
 SXEVZ5UzRansTzC5utlYJsG1R27/5kQu+p6gLudEbBpXwO+sJgKI39W/WtL7tqQfxCpY+pQDkk1
 nOyO1v67hIbojXpYFytgInnjez7BtvmsvJYhsALGCxJ7dLkeBsX+oZeUThjRtG6lXL2z4fMo9er
 bYrqp9f0fyn/AgDPqsw==
X-Authority-Analysis: v=2.4 cv=HMbz0Itv c=1 sm=1 tr=0 ts=6a183889 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=xqWC_Br6kY4A:10 a=SuJlEMG_fVsA:10 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22
 a=JMH861CndGJDf_HG_EAA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: UdXCBUC07EaeEhCwrxRNCeeWA5SM8oEx
X-Proofpoint-ORIG-GUID: UdXCBUC07EaeEhCwrxRNCeeWA5SM8oEx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_03,2026-05-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 bulkscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280128

> > +static netdev_tx_t adin1140_start_xmit(struct sk_buff *skb,
> > +				       struct net_device *netdev)
> > +{
> > +	struct adin1140_priv *priv =3D netdev_priv(netdev);
> > +
> > +	/* Pad frames to minimum Ethernet frame size (60 bytes without
> FCS).
> > +	 * The MAC will append the FCS, but we need to ensure the frame is
> > +	 * at least ETH_ZLEN bytes.
> > +	 */
> > +	if (skb_put_padto(skb, ETH_ZLEN))
> > +		return NETDEV_TX_OK;
>=20
> Does the standard say anything about this? It seems like something
> which could be moved into the core.

The comment is a mistake on my part, as it doesn't clearly describe why we
have to pad the skb. It's a case of a MAC device which doesn't pad a frame =
to
a minimum size when the host wants to transmit less than 64 bytes. I'll upd=
ate
it in v3 to say:

/* The MAC doesn't automatically pad the frame to a 64 byte minimum size in
 * case the host sent a shorter skb, so we have to do it in the driver. The=
 FCS
 * will be added by the MAC.
 */

As for what the OA TC6 standard says, this is the relevant section
(7.3 - Data Transaction Protocol for Ethernet Frames)

"Ethernet frames are typically transferred from the SPI host to the MAC-PHY=
 without
any padding or frame check sequence (FCS). The MAC will automatically pad t=
he Ethernet
frame to the minimum frame size of 64 bytes and append a computed FCS. Howe=
ver, the
Ethernet specification allows for the SPI host to optionally perform the fr=
ame padding and
FCS computation prior to transfer to the MAC-PHY. Similarly, the MAC-PHY wi=
ll typically
strip the FCS from received Ethernet frames prior to transfer to the SPI ho=
st. However,
the Ethernet specification allows the option for the Ethernet frame to be t=
ransferred to the
MAC client with the FCS.

The IEEE Ethernet standard [2] defines the behavior of the MAC and therefor=
e is beyond
the scope of this specification. As a result, support for allowing the SPI =
host to perform frame
padding and FCS computation, or passing the FCS to the SPI host is optional=
. When supported,
the method for configuring the MAC-PHY to enable these modes of frame trans=
fer is
implementation specific."

As I understand, from the TC6 standard point of view, the padding and FCS o=
ffload is optional.
So, I think this shouldn't go into the core.=20

>=20
> 	Andrew
