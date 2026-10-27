Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.1
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793120868;
	b=iyMjsXOWr0QB80bMmeJiv1G8HadC7IBzzaMoiFy0ooY/YdSRHt2PuifSBfm0MKhH0vyI
	 ToorpLJzIUtRYnzFgI+YgZ91XWNZyz/Ph7+SbGiWgBEQvIZuHsUSZypXI6YQhSMvKkSVy
	 0NDIzaYlvUmkIg5YrRrnqjxoJD97HGdxoh+DLag8TMpUWZVvYu48hWis320c2rFWGYmTO
	 g4o6f1tkWwzNJh4ByDu+VLacOy0QHwtFchleiXwKAqWD8nPp999k7N6daAQ9Zj0eplYqZ
	 RNlQml3bV5lmny+oZoufZerwg/uNZDNtx79mPPGzMG6N9XQjD9upXOTpETkJb+dxXZg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793120868;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=VRDVRKYaMu8kzl427JrQTQLdK+5E666eczfqK+K4CcQ=;
	b=dEGaSrKnlGGrq9BZSs/e7tInKHc3voV+woG8VREBNcBUMqUyekOvY5epDd6GSDZvvTlA
	 Z3VQB/Pcap4XvXjPrcNX2kH/KWUTHjX5YCKUE+uQ/9nR/8pOxTqjYYvpeTZjfHk1LkfuX
	 2YqKDsgz6ebIRl3YU5zp1UqfFk/37i9rb2DD5u+b3JUYmUJpAqRNjMG8spftqmGOj4R6p
	 SWZEqsUfVvd8yOlFIfa7yaas7ZTlBH2EeKQOOc+a6TuVRnbVMKaVPv7Hi07UHaRcgry9P
	 ZhlNqerlosjZZph3bY0nVedaK5huX+GLqM+hQN9gGl6moTCWBYgjnNnj29H6grifOTA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=PR26Zyue;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.1
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012001.outbound.protection.outlook.com [40.107.209.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C13F606A31A;
	Tue, 27 Oct 2026 17:07:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C13F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=PR26Zyue
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oD2e0WpC4SCsKzQ96ePL8b1buQ/ux2QJCY3xoadYsB9Z4NLQ06MUrcHDmc+LVgwu3wx1X3/fMIxHfQETe1CJJnHr0rEtWm8+KwfAUhnrxKSdVcUzg2XdB2Zd0Un5OyZeh+Bp4tEvuh3KiXRAxjQA/+2RDz+5uBCjq7YR4s6DEZK83g4xJFnHIeIxL4BftlTjDCWjHSWMahC/oGypmuJGrOWfmTD0hcLXuQ1Sa51kehhjn7PFSZOhd9A3mELljOjaA8iXseX5dINyzw7tA0UOs1ymlR1+RgBh9vkf4a8fk/x2+ljD5iiROMVACQbBR6ijWt7dkN5U9seaflAvoJoRAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VRDVRKYaMu8kzl427JrQTQLdK+5E666eczfqK+K4CcQ=;
 b=y3tzEPkN8IMG2iAAJu4oJ9Bd+aYoy6uykz2CRi5TLtodu548sz/nWDpkloswOyOrN+O3aHpKi1C+6+P8eNMtaWQkFZTBHkx+24z/ezko0UwEoiYBDu80ptrFLIPD8mtKYtTdOA1s4NeByv/fkiBpPwKFpowhBJ0/d3FOowiuKgCWWW6mnb13gVb6SK4oaik68+tPTGtqQik33laqf92CjE6GtGa7PQYP1z435T8KIKLhuxDOV0Zzw3ekot9YTJea1gmvEhuhOl2Dil07K8Ew9MXVhcCCgqBqwuKz6iDqWEEy2FkdIy4bM3SxW2sE+OlaOwUbCdNbZdHXihaauB/CfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRDVRKYaMu8kzl427JrQTQLdK+5E666eczfqK+K4CcQ=;
 b=PR26Zyue3Fkd/VnCgc5Klj7xPhh6S/vZcTAma9GLCFD8H2kjIDVXAurSx365NqCyCTszOkQt9QcAG/LOMtIbsEH7fm6VoHNGw8hbYlET+nKpmlGzfxvR83kMEWy+xCfDGq9b/K3aPwzaC2vVBm+aD94rVZ16jT53tUYJfPRrUNGRBai9E62CmvHa4SmJFs57vTLsfxs9MpjK3pFWlIJKOXXhV8DZxLhMMGMdNs3PX+g2f/9Em4HaRwndIvoAijjJVTnFaqmOMaeLafQM9N2+D1oAW7NidjiB5YG9NJthaI2xFk4sb0FcSpGWAqg+DUbkQIoGqcnUFK+n80XJv9Rqxg==
Received: from DS7PR03CA0016.namprd03.prod.outlook.com (2603:10b6:5:3b8::21)
 by CH3PR12MB8880.namprd12.prod.outlook.com (2603:10b6:610:17b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 17:07:39 +0000
Received: from CH2PEPF00000144.namprd02.prod.outlook.com
 (2603:10b6:5:3b8:cafe::90) by DS7PR03CA0016.outlook.office365.com
 (2603:10b6:5:3b8::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Tue,
 27 Oct 2026 17:07:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000144.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 17:07:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 27 Oct
 2026 10:07:14 -0700
Received: from vdi.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 27 Oct
 2026 10:07:12 -0700
From: Chris Babroski <cbabroski@nvidia.com>
To: <netdev-bot+sashiko@kernel.org>
CC: <Raju.Lakkaraju@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew+netdev@lunn.ch>, <bryan.whitehead@microchip.com>,
	<cbabroski@nvidia.com>, <davem@davemloft.net>, <davthompson@nvidia.com>,
	<edumazet@kernel.org>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux@armlinux.org.uk>, <maxime.chevallier@bootlin.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <richardcochran@gmail.com>
Subject: Re: [PATCH net-next v1 2/5] net: lan743x: start phylink last and stop it first
Date: Tue, 27 Oct 2026 13:07:02 -0400
Message-ID: <20261027170702.576476-1-cbabroski@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <179242764576.3135.4479437969199107753@kernel.org>
References: <179242764576.3135.4479437969199107753@kernel.org>
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
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000144:EE_|CH3PR12MB8880:EE_
X-MS-Office365-Filtering-Correlation-Id: ce13ea3e-2ce2-49f6-316f-08df344ccd1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|82310400026|1800799024|23010399003|261022105027099003|18002099003|261026121527099003|22082099003|56012099006|11063799006|10067099003|261009223027099003|261022075727099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	eAMBgL2zVE13ClDOf7N/tJZmGtE7ZfP+upItJO+jHRgPCdFZVAAPKpPaW9nuUXDd5cdnGdK+SXRitbumxWiZ7TEWycruGUVwlLs4Kj7BZVGCEp1AlApqdUCc/k2iXdO4yzlOe7EQdAlTCYwHKwi22WWg8hSLSVvzZtb3RqI6R8flpzReJVcbKBoh6HowmI6n03smfSmS/AHxBu4BTtg9579DRaffn8Gvpr+j8F1IXUOCmwGuE6+sX84UsFuI8a9sh9PtnRpEM1S1CwTvyOkRZiH8surnE0KytRCD+bZEMBmMtrgTrBVZ3wfKUY+zxiNgIbmtXdTTKOzvu1n9EGdxyiQFA1Rc3qRo/0Cp1D7skYmNvyaje42mYyq7VewPch1iOYdG+8XOq/YHQGCia8fAliq62NGYqj+DxC+sxsuT3MWWy3ZjqM+QvYRprhrF3fGb0KGbVPDweoriA03M4XEuecieXoSaljyyK7/wDxXFUAhhpiZO2px4xXP8CNiBTs7xfuc0mftFLG+2lS3E8AYKunYyHfKlD4B7Kgfv9xoJWyFlkRBvUE2R3/CXf6aQsKTpOJASrrGiF0/N47gL+MuNxFJkfDrNFDxn/OgmB23UBgsYIk7j7a52Rz8kjUT7sH7AjrOcFZG7241Bm/ZQttVO0KCxV6pnJZnnTztQi36oCKpsOLRmHqy3ELNE1IVoCNThuO2M6s70E7ny3p+24OtDrw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(82310400026)(1800799024)(23010399003)(261022105027099003)(18002099003)(261026121527099003)(22082099003)(56012099006)(11063799006)(10067099003)(261009223027099003)(261022075727099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jgB5MxKQYRbbOVNZF5KzeX1yplQhb8LfKplFRIX2HZgsv6uUkQm4118Zd4M/ttzkxYkbK3/KGyujiz42wWEeI3IS0Dg3T+M/xEfX/EJdUniTPazy6dilPouOwIoLZyW/QFSKDRQw1fstd/tUeGxHY9wUhwuBEniQOIh7ZdtaiKEdByJMObiKMC7dEcL7kCeUblIF3s8PRBjjsmI8poeQVB84VHMpYRk784+0oSnrY8HDsYFImicqBGkMENMxmoYkWQ3QZZl2IVPNZ1Vbo7MIkBWRIlVYrUdSb3Hq71LUr7b/NxL3mglVTaCygXmIh3ToY8g22wofagM6pNtnTfvwskCGJCJHJo1u+DXDF+k5+ee8t1v+8NmlLamwkzjbEAOkWbZfexhZD/aJnWGoM3bIn/RnUegxUNclEDXXsjxP5tnLAubvmusuosrtTPIXkup5
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 17:07:37.1819
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce13ea3e-2ce2-49f6-316f-08df344ccd1f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000144.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8880

> > @@ -3334,6 +3334,8 @@ static int lan743x_netdev_close(struct net_device=
 *netdev)=0D
> >  	struct lan743x_adapter *adapter =3D netdev_priv(netdev);=0D
> >  	int index;=0D
> >  =0D
> > +	lan743x_phylink_disconnect(adapter);=0D
> > +=0D
> >  	for (index =3D 0; index < adapter->used_tx_channels; index++)=0D
> >  		lan743x_tx_close(&adapter->tx[index]);=0D
>=0D
> [Severity: High]=0D
> Can a TX queue get woken again after this point and stay awake while the=
=0D
> rings are freed?=0D
> ...=0D
> This looks to be fixed later in the series by "net: lan743x: quiesce TX=0D
> before freeing the rings". That commit adds a netif_device_present() chec=
k=0D
> before the NAPI wake, and adds synchronize_net() plus netif_tx_disable()=
=0D
> after lan743x_phylink_disconnect() in lan743x_netdev_close().=0D
=0D
As mentioned by Sashiko, this issue is resolved in patch 3/5. For v2 I=0D
will rearrange the commit order so that patch 3/5 comes before this one.=0D
=0D
> [Severity: High]=0D
> Can a transmit that is already in flight also race with the ring=0D
> teardown here?=0D
> ...=0D
> This also appears to be fixed later in the series by "net: lan743x:=0D
> quiesce TX before freeing the rings", which adds synchronize_net() and=0D
> netif_tx_disable() right after lan743x_phylink_disconnect().=0D
> netif_tx_disable() takes each txq lock, so it waits for in-flight=0D
> transmits.=0D
=0D
Same as above.=0D
=0D
> > @@ -3387,6 +3383,10 @@ static int lan743x_netdev_open(struct net_device=
 *netdev)=0D
> >  			goto close_tx;=0D
> >  	}=0D
> >  =0D
> > +	ret =3D lan743x_phylink_connect(adapter);=0D
> > +	if (ret)=0D
> > +		goto close_tx;=0D
> > +=0D
>=0D
> [Severity: High]=0D
> This is a pre-existing issue, but does every open after the first one=0D
> fail on LAN7431/PCI11x1x boards that have no DT node and no PHY on the=0D
> MDIO bus?=0D
=0D
This is a pre-existing issue and doesn't occur on the HW I have=0D
available to test with so I'm hesitant to change as part of this patch=0D
series. It feels out of scope, but if the maintainers can provide an=0D
appropriate fix and want it included in this patch series I can make the=0D
change as part of a later revision.=0D
=0D
> [Severity: High]=0D
> This isn't a bug introduced by this patch, but what happens on resume=0D
> when this goto close_tx is taken?=0D
> ...=0D
> A transmit path that bypasses the qdisc and does not check carrier, such=
=0D
> as netpoll, could also reach lan743x_tx_xmit_frame() while ring_cpu_ptr=0D
> and buffer_info are NULL.=0D
> =0D
> Together with the fixed-link -EINVAL above, every resume on fixed-link=0D
> boards without a DT node would hit this. It still seems to be present at=
=0D
> the end of the series. The lan743x_netdev_stop() wrapper added later only=
=0D
> skips close when !netif_device_present(), and resume has already=0D
> re-attached the device by then.=0D
=0D
Same as above.=0D
=0D
Thanks,=0D
Chris=0D
