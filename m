Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.166.238
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793985493;
	b=SFRkqBR2f/xsK/BKMfhZ7slceIQiccduEbjTTxsLBdDmwqBNH3snjHymLoks15nMJcr/
	 2mZ1s96MzTyB0C8KZRbSsQWnw12YYyUFfEtXrbQXE/thiEUhtZOdWFMEjlNyJRV/Ff6gz
	 8J/Kxr/9q1fdXG/MSlXz/5MmDrAYPtlC+4WblcarI4NHndOnoB3R4Quriqfrncqafiiwh
	 0ryo5Q/Rg7+1jhQKo0wo7XB5DuEjJiOYkaXV9JpZu3eFuaGGoj2vXzhjjDqQ5SnLl90s/
	 S4bzSaZno8v8/pERBaMh6sDeQJTJUx3x81cBYUJaGtwsQHTwXzEDUE3ZFARTWaYH0Kw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793985493;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=Bi9ZE5309OJnPbbXWSNSV6UCV2z62qA6XmkD4gkB0X8=;
	b=D6BHapMh/33ZHUZKikwwBVOBhHx5SVxYdSJJlsBUHfc+3II6lTX4QTlMCOUHxVKMbhpj
	 aLI5DAR+Yq07g3VOcyY7usrE6Kk1RwSxbidXekgepo0+qj08/3gLaIJe635uEPeF6xxq7
	 NRhjiWASHXAcYSBHqKTNu25SegsDv7u9kG5Kdc5MFY/8xazvar/9j0rfRHJxWAvjHQ8GN
	 Fmz12gXchbVYhX4Nw0pBwkXPp3DiSmFgE9zYLS0fKE8PU31Mq9IiJxfHjiSdArM1lmomV
	 r+9z3am9S529xQ0++Ft/bpt5udgKzmXhQEvVp0u/Wkr5F8CTYFq83PfmsSeStDOsVSA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=windriver.com;
	spf=pass smtp.mailfrom=windriver.com;
	dkim=pass header.d=windriver.com header.i=@windriver.com header.a=rsa-sha256 header.s=PPS06212021 header.b=dCeCOJtI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.166.238
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA04606A331;
	Fri,  6 Nov 2026 17:18:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CA04606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=windriver.com header.i=@windriver.com header.a=rsa-sha256 header.s=PPS06212021 header.b=dCeCOJtI
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6F1RFx3287148;
	Fri, 6 Nov 2026 09:17:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=Bi9ZE5309
	OJnPbbXWSNSV6UCV2z62qA6XmkD4gkB0X8=; b=dCeCOJtI63WY9wnOCYZFhDD8O
	bkl36tMSHdsXgUJv7JbmXIeojmNmsIdkvRKJH70B6J67xNMDPrfPdroC3qLrlkxe
	7Wmovj9qZS0x2PvTvcA218l+jW0IoBkrFErBI6sChHuft7WxJdwltgcFiH5nc/1U
	0MgrGKOZo8uRTTanR57/UDTp0AexdDF6FuvGZk1l7Mo5hcYwwdHqkZymrCoFL37f
	YUVk4DG8+mrQB+2jtCqPArnBIM9zjFmLOevq5QZbPp/9UVwVKl2BfcmAtxOg+1Ji
	N1e6vCXtMQ8WQxQ51UEQYfUunLOfdr+X0A4zGV/5IFX+duCf401G/nya/APvw==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11020119.outbound.protection.outlook.com [52.101.56.119])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4hs3pr9dr8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 09:17:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NTRNJ3UMrEoJr8lFNJ+ATjZhvgrAS5PKaItVpBY8hHzMREYoIZCeY7JbEQ59EndbUIGbPQkawLqYoGcR5DBzVBMLN9eMkWYU5Dqikc+Akjzl7CZfoDs8PsRh1Pl+xZk13CR21dL7KlncQMeR2ldW6ftsHNR49uJ1wSp/m52/S/JiWy8UXJAeft6siGterQoC6ylCD6ADfFNM5A4BhQh+BJIMX8Z5EvrnT76DuLV8t3i9Y8M4QpD9SB9jBZ1Gc/+0jwivEY12mdEf3iut7XjfN9Ze/7v+Hx1BjlQ4TRFMzFQWMpistGkoar2gi079RsIAwQWQDLGkkVLBmElQQXGApg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bi9ZE5309OJnPbbXWSNSV6UCV2z62qA6XmkD4gkB0X8=;
 b=KZIFbaxidOO+HuN1nuGnfM5moUjRRJhADy30U2Lg2YlkABiWqpCICpvgpWYJfbttudun2yyhcrhGSKA2hZvztPGGaieYk+3D6wkY0J5N1N+7YBtk/D1sk72e3eRt2Rr0tjAHJ356BybRlNOIYghqcFNFPzS59dQUK1/joIFRjzZz4z0+6wYYZaS7MvuCI+bSecz18j984yLFcIe0C3kc7jcSoTI1l+zGNj7MJVNS9gVC/9FxYw1arPAge1yKRUyvpd3pwSNqtut2cpBg2ILzl3/hhsNEC3prrNlPb/yq64s8G1LCqazeb+bp4/r39npgHalGiA2USW0QYGw1gPMcLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=windriver.com;
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by CH3PR11MB741580.namprd11.prod.outlook.com (2603:10b6:610:34d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 17:17:30 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%4]) with mapi id 15.21.0592.010; Fri, 6 Nov 2026
 17:17:29 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: intel-wired-lan@lists.osuosl.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Wojciech Drewek <wojciech.drewek@intel.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH iwl-net] ice: release IRQs and rings in ice_dis_vsi() when the VSI is already down
Date: Fri,  6 Nov 2026 19:16:57 +0200
Message-ID: <20261106171657.583713-1-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0075.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:52::12) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|CH3PR11MB741580:EE_
X-MS-Office365-Filtering-Correlation-Id: eadde2a9-e277-4c72-a7d0-08df3c29d649
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|52116014|7416014|1800799024|18002099003|6133799003|10067099003|11063799006|261102123227099003|261026140227099003|261028144727099003|261026121527099003|261022105027099003|261021121427099003|261021123027099003|56012099006|261009223027099003|261022075727099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	NPd4a86NxbYVwqG03tMYLgdqRq/ULm3XzocNjnBcTdc/gNcXYg2Pr5/TIXjE5ZvSvEBfoJ3PWa38QJjb/aM8wfx0Zl8SIXnhZ2AcCmkkxaK5W28oMv0cfsOAf53Y++cnuP1+fdsbSsx0cctEtUSmdtMsialpzfOj4zOFUhFaSChTbsfDcnQGL0pIWiWhGyUc0Y17iNpkN8I8VGMiFHfxsffHrNZn+++lEFuQVg02IbC8y2spYtAxd9HNp5Q/smnIAouymekBNmXR9FrgmRgiiePV0gzqMnEDtw+nMJ8NBgHaj6Et0WWoPUw2MAdtN1Y7dMrLVcY51F9RrFNxGYhMS7Pg/238s2UqSHPN1YAWT9Fix9R3vesQlFwOdHNQGFWIqW6ZnZYOC5SxITq00QGjs3qyTFDdBk1IGsTtg9TO8MFgDg7zbTMKqOl846DE5HmG5r7J/aMEHYOAsm1wsUtK8rlQ7a3v9RqFI3h+EnIS4++NV2FGs7SOwW3QXxe7DKVTEsjRz25Fhs8pMQJBR6z3zVmzigN05TVWL9fKk3pTbx2ZvnpcjsStjvYa2i/HCwKje2L2OhcrtSZ7M7Ad9BPml337cIQQfXcW+pUWdNKIRh1I+0rpZdCNYIU1IIIx9YJ0q4ZW+0Z1vYQIDeh6Y4pHUxvS6Bmh1IQbcYtmtYEqeiSglc2qODlCQNFFeK2l09SLqpA8khNhvbYRJTk99DGQjYyAj4c+7QdIMhwF3jNr5a8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(52116014)(7416014)(1800799024)(18002099003)(6133799003)(10067099003)(11063799006)(261102123227099003)(261026140227099003)(261028144727099003)(261026121527099003)(261022105027099003)(261021121427099003)(261021123027099003)(56012099006)(261009223027099003)(261022075727099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7lF2Mf/8MKafN6KZJDJ6nGfWBuNa/TMvaGe4b590dcFjAyeMZUWvO5/v6AdP?=
 =?us-ascii?Q?PXFNjCfJy1v2i6mfhRqA9JbhS351/t2/IDxod1ZyH+IG1NwrrqmNFvItzP73?=
 =?us-ascii?Q?4hdBTljseTPSlvazwoP4yErnb1DW093lWh6v8A54rMMj22lMDosfk013Woql?=
 =?us-ascii?Q?xW27wLH0PVzMTwA+oiRCb38Ps4Bj3bpbB8dLysuLQbSFMgIDzhbxjwytq/Al?=
 =?us-ascii?Q?sBsmbrCwrTbKSQq5xuXDMzvosGb23h19uG1NNXgGk9oVJh8Tu5h8LARU2CRc?=
 =?us-ascii?Q?HQc/zlTVhUqjO0lSMRAsmXa7dq4iaI+/qQqhLD73uyv6scln+LYz6aZko/6j?=
 =?us-ascii?Q?zqJfYqpym0uaSAR4Ijq42fkT+8qrlCcYBAnyNGQosPjmN1H4VqAqR5mr99sp?=
 =?us-ascii?Q?6ziBSYN2XqBeeTO1b2xfDn+XzoCAZi0hndX71dbxMlUL832o8I+AUriWe4bi?=
 =?us-ascii?Q?7ymBqxX0VXaJMm+9jgKJQnnZJEoEPZoW6fKZPOmVogWdqqzckvzUQtQOJiU3?=
 =?us-ascii?Q?XqNYhSbfZro4GOqcYmaoFlj1IrRHnK2tXXDmjNgR/ABQvYh86QWfJK5jbtGy?=
 =?us-ascii?Q?6Rn5t3pnGEkmADuaix8+l0vTSqBqmHaZf26uCGxaroG+9ThgzVJlA/bJhxYB?=
 =?us-ascii?Q?JxkaqMhEZDwiP96tSRASSNXjS+3Y3DjXqdKz/QsXKIq8JyR0ppVVKAuMBFnw?=
 =?us-ascii?Q?jT3oPS+hfHlxVpQ4V3+LF8y9DwmUOrCoO0n1X2bj0WMxPWN3O8myNm8t00w0?=
 =?us-ascii?Q?MjaJgGXUcBj4BSbCUhpS20ULUMF3Vzx72v81JUzMoU8KdXj4m0iXrhvHC66f?=
 =?us-ascii?Q?8kbMRaYpyr374Hw2YACdZFvdUj4oKbwcKAHQM2lIs7+PwYgdUxRONQ+HHIpj?=
 =?us-ascii?Q?nd/8S55FEpoyKj8Gx/eZpcEobwza3qgfct6/lYCQwCosl7ioP+5tNjvi/pEY?=
 =?us-ascii?Q?qQzSn/cdjbUMShsMGmH6IiSZEQ/XP7QqD/P/p1TqIRkzXaotyL1ls3u2GJPw?=
 =?us-ascii?Q?rP4UzC1mlXNgWykIDsHfo4TvDcPknvYc6Q6sZQpBId0OqKLhetQ38rJNlckX?=
 =?us-ascii?Q?xLnCDO5NTg8buKnKHRYTG0ksCzcwvyZ2OUhWEVcHJnIZeDGGWNS2biHoBVK3?=
 =?us-ascii?Q?CnYJ/EvbPMNSIdNZZNwmGdc8hnFYEVGYYHRz03d9FwPcaIsacj8VK7pCSYqM?=
 =?us-ascii?Q?JtS9vLteBRQ8fM54NUsD2DFQ5B8qw3bMbs+bqlsCTolG7hgF3nepkHNNWnGX?=
 =?us-ascii?Q?BHXZifxKllcExsAINBY+MRdcUyMD5ZImezdLdzysEzj4dpKbGfahJJCsNNVm?=
 =?us-ascii?Q?TIdQSzHro6KWgGcA6VrxmdQ0lyx74bxftd3XKX4D6up1AwD6SyT39hDoQ/IL?=
 =?us-ascii?Q?WhK+bx7kggtGclO1RjcZOqrqmblqvJGSTdIrS7KrT3qk+36TfdlJdyteI+s5?=
 =?us-ascii?Q?jW1uErorJQ1fWevmK1gOb2zN4aCqysPkqWZAraxA0pm19nU/aGWwt7noPr0H?=
 =?us-ascii?Q?8sM8WxihRxD2zwfwHQFGyW/LrBl+8FA0xrDeCzwhwS3k0QOQ+jPDGHjP7OUM?=
 =?us-ascii?Q?nwOrymQyoTv1UkQhcZRzG/G4eUJdpY9yCVrHjd5DM6JYnzGSpZO5wo9Hjo/p?=
 =?us-ascii?Q?lH2wcdxcJS4jKq2jJy7134BI2lgi2B3V0ww7HUc5rGMqSq7gSTvPGozUhvGN?=
 =?us-ascii?Q?WiODInqqGEZ1hv1eNXFoyIZi943U+VntL+5dV6MwZeoCOGhfGg59f5KF096U?=
 =?us-ascii?Q?PjUoUzDKGvKZICbbZ2EWtCEb7onfEKY=3D?=
X-Exchange-RoutingPolicyChecked:
	FCddwRkgKDctJ+j8oR0A6aLHYD/NU3V/VfYE33JfE+bEDTQ4RGa6qFmfTbGy/Rfy4FsTYSV/Axbw0o5rs8CRTGK9gS1+Mo72XIjfG+wPPH/U0XeMR02neTlR6+KQnMF8nnowGYy19tZfBq6IKmlWRAUR5ZCfjcokYwjzOpXIE+dI6ZdkqLbvMwyYyH+ajW+7n6l3AK+NUszL5iaNerQnWK7dzkE1I+1B26iJpDYWJkhU1+Kn9AwaVNX2U3pDhaBiOSTM9ttDsIiz2+fHHE3vjCBkmqydG2uBHOK8U96Ww38BYWEDSiTn7w7ii92K0SKhaTyyzY09k8qzJ2nuTB4GpQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eadde2a9-e277-4c72-a7d0-08df3c29d649
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 17:17:29.8917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u867Pwu7lsWVr/p+fXB0JUmDy0adg3BLy11sVu8bso7qqyvcrvupixPCV1OQ86B20a76OgQTtKnCi+SnlKGohCoFt9V8RmeALp+W9ZpCKVs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB741580
X-Proofpoint-GUID: r7SI_5xID_JiWtMQri7ExvE-WHk1UJPO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2OCBTYWx0ZWRfX86+26JQcoTOY
 8qSiff8KD7cCRX2pl0t+kYLtRbAX+9F6j4/0GxTllGzkaeBlzYw8HDY+uWIRTXAya+pbIzty5cV
 paIXSRu/u9Qimx8X/9eettMyh0spXfV29exSwdBWGAVp/pvsb0MzKIiCU2Nz5YA0bJmekydmp/N
 f8VGxcB+YATP2K/nGYU/0Zy8/sWBM1sJAFkVIRrvaLeKBKbxApouChPfmkpWafSgDdQ/jqUhsPa
 //yymqGkKIfzUpt78mk853HHnXW+lHTZf9FqGJOqHZ1vU5iknt2l1GdEzjyr57o0/zlMxyf6RYX
 rd0kZ42hEgzxac8jhyzO1VpQKBM2whDn8UyP1FPeUAHB8UPHAXa0gxdwy6jVduYUm/LQ8QcCn2T
 49xPrRTlCMDRW9D/bJgRkJNkmHU9CYRDDEUqzYZgBQbwy7N+DndPYjlC1YejLzmDPyN15sABY0d
 qAM1AzNh6M73uPNN1Bg==
X-Authority-Analysis: v=2.4 cv=Iq6L47/g c=1 sm=1 tr=0 ts=6aee0bad cx=c_pps
 a=TIEeaaXQjm2sgGsZDBwmrA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22 a=t7CeM3EgAAAA:8
 a=tsWWKMcrzgDGkEzjiCsA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: r7SI_5xID_JiWtMQri7ExvE-WHk1UJPO
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2OCBTYWx0ZWRfX26OgS5/rS5jK
 itELJljS9Ml5CdQXcZ26M++8oK/kFMrpVKiTPUM96pL9vMr0ixu66Q3uXKEQwiCxxwQkzEi/alR
 htLpaKWAkOlmOEkgZ5rHVAFEwMPshYN1IJ8Krl7QmPuK+yho5MEo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 phishscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 malwarescore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060068

From: Ionut Nechita <ionut.nechita@windriver.com>

Since commit d8c40b9d3a6c ("ice: check ICE_VSI_DOWN under rtnl_lock when
preparing for reset"), ice_dis_vsi() sets ICE_VSI_NEEDS_RESTART
unconditionally, but still skips ice_vsi_close() when ICE_VSI_DOWN is
already set. For a running netdev, ice_ena_vsi() then calls
ice_open_internal() -> ice_vsi_open(), which does a full open: it sets
up the rings and requests the IRQs again.

A running netdev with ICE_VSI_DOWN set is not always a closed VSI.
ice_down() only cleans the rings. It keeps the ring memory and the IRQs
so that ice_up() can restart the VSI quickly. If the restart fails, the
VSI stays in that state while the netdev is still running, for example:

  - ice_down_up(), when ice_down() or ice_up() fails (the latter also
    via ice_change_mtu());
  - ice_xdp_setup_prog(), when ice_down() fails.

If ice_dis_vsi()/ice_ena_vsi() are called on such a VSI without an
ice_vsi_rebuild() in between, which is the case for the DCB
reconfiguration in ice_pf_dcb_cfg() and
ice_dcb_process_lldp_set_mib_change(), ice_vsi_open() runs on rings and
IRQs that were never released:

  - ice_setup_tx_ring() hits WARN_ON(tx_ring->tx_buf) and overwrites
    tx_buf and desc, leaking the previous arrays;
  - ice_setup_rx_ring() overwrites desc, leaking the previous descriptor
    memory;
  - ice_vsi_req_irq_msix() requests the PF vectors again without
    IRQF_SHARED and fails with -EBUSY, so the open fails and the
    interface stays down until it is closed and opened again.

On the reset and mqprio paths, ice_vsi_rebuild() frees the ring
structures in between, so there is no WARN, but the ring memory still
held by them is not released until the device is unbound.

Call ice_vsi_close() unconditionally for a running netdev, under
rtnl_lock. ice_vsi_close() already handles a VSI that is down: it only
calls ice_down() if ICE_VSI_DOWN was not set, ice_vsi_free_irq() returns
early when the IRQs are not requested, and ice_vsi_free_{tx,rx}_rings()
only free rings that have a descriptor ring. This is also what
ice_stop() does for a VSI in this state. The race fixed by the commit
above does not come back: ICE_VSI_DOWN is still tested, by
ice_vsi_close(), under rtnl_lock.

The non-running and ICE_VSI_CTRL branches are left as they are. In both
cases ice_ena_vsi() either does not reopen the VSI or, for the control
VSI, the only paths that set ICE_VSI_DOWN also release its rings and
IRQs.

Fixes: d8c40b9d3a6c ("ice: check ICE_VSI_DOWN under rtnl_lock when preparing for reset")
Assisted-by: Claude:claude-opus-5.5
Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
Found while chasing the same WARN_ON() in ice_setup_{rx,tx}_ring() with
the out-of-tree ice driver on an E830 port without a module installed,
where ice_vsi_cfg_lan() fails and ice_dis_vsi()/ice_ena_vsi() then
reopen a VSI that ice_down() left with its rings allocated. The
in-tree paths above were found by code reading.

Based on net (f66469d9905b, "Merge tag 'net-7.4-rc2'").
Tested: build only (W=1, no new warnings).

 drivers/net/ethernet/intel/ice/ice_lib.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 7cd2dd066ef5e..0421b0738abd1 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2852,9 +2852,14 @@ void ice_dis_vsi(struct ice_vsi *vsi, bool locked)
 		if (netif_running(vsi->netdev)) {
 			if (!locked)
 				rtnl_lock();
-			already_down = test_bit(ICE_VSI_DOWN, vsi->state);
-			if (!already_down)
-				ice_vsi_close(vsi);
+			/* ice_ena_vsi() will reopen the VSI with
+			 * ice_open_internal(), so release IRQs and rings even
+			 * if the VSI is already down: ice_down() keeps both,
+			 * and a failed restart (e.g. in ice_down_up()) leaves
+			 * the VSI in that state. ice_vsi_close() skips
+			 * ice_down() when ICE_VSI_DOWN is already set.
+			 */
+			ice_vsi_close(vsi);
 
 			if (!locked)
 				rtnl_unlock();
-- 
2.43.0

