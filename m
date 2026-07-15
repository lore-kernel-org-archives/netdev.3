Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021103.outbound.protection.outlook.com [40.107.130.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B95047AF43
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 15:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784128854; cv=fail; b=eRGMV43m6WT1COHlGBryjxWlFhwD4OO41xDw9JN98akmy/ivkJL5PW7oMDSfKxGIdT1WBhyU4W5OTD/dPXwZfDuZr/ltRlT2PpRU1AoYWETohDiFqxmChI97e/QMAlfQK4AQv09rlgnXmCpUpAlDBHUv36NNF3JxByPh3gTS9JA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784128854; c=relaxed/simple;
	bh=Etc0OPGX8X2j0lf7gqjGrURJJKUPah7BxHHQKP0nCVc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XVsQ+wVX+iQ0sF1liliD32KmzDDXeIbdrehk3pe48444nyh0OsXpyCJknP7lZDfqLRrJtc1VwjYfItfCUS/byaxo/Mqyea1BOKioguz7mtKKvFR/JSjErdT5D4nta122TrPJ+O0kef/RfEdpATPc72ZLgkwkevGr/9ZYAVFScPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=technica-engineering.de; spf=pass smtp.mailfrom=technica-engineering.de; dkim=pass (1024-bit key) header.d=technica-engineering.de header.i=@technica-engineering.de header.b=cEqjlLtG; arc=fail smtp.client-ip=40.107.130.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=technica-engineering.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=technica-engineering.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=technica-engineering.de header.i=@technica-engineering.de header.b="cEqjlLtG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=goYDjmB7bGsBLZO8RNtfgdUau8GWhc8V9gtUHYCckxnfn/Sb32N2hALv5HKqV7Dgq/uWElcfyBhibd6zzs3BC4iFCsCmq6JrDaUqUgCxBCtj4m/mDK8jUrSWrgfRJ3KVz7YkWk+xTeEi7XZWFZl6hG9qxwM8qb7uK6BEebhWiHUXnaGCP9JRDjBtyps77L/5TIAGNWjjNbR84XpBsQIBTXDjsUuBko5akQZCZGgl35PAoTRngVXr1dd9LGNSeVqUJ/Wtd3q9awA6fNqalQGW8c6E+5z2Z2cJ8eygBHOWxNgx+haMOmpYVzMooHFrCybf4QlWljtMVfh/HOolQoEwPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Etc0OPGX8X2j0lf7gqjGrURJJKUPah7BxHHQKP0nCVc=;
 b=LBXCzbwI4l4jbNA/D0ufMG3S4+02hie2Q4oxSD/MBXBkpTfze4kKvW8Rf6MyIxXhg+J4SPLtFqh2Smwtvt6FblpHbycYJq0CSOax1Kwd8zDa/wlqLmfO0/wHVanonPn5dPOqcN6mKy8K85pJ/7h4k3o+p5T/mWWJS7dq2GPQqT+In4TGjSS1/y8Eyk/4JcedIYhutwBIgsSzhg4PBR0mEcoWpAKbU6kpj3HHqsqbGN11P1+U0S1YQzB/132xvOB9qpy+Imlv5eZ9i1qRPyd1/NuXz6C94QZaFdk+GUtw1gyCecr+GlA5deSn5W5puezsldDM42ds4wQPMG6mvL58vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=technica-engineering.de; dmarc=pass action=none
 header.from=technica-engineering.de; dkim=pass
 header.d=technica-engineering.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=technica-engineering.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Etc0OPGX8X2j0lf7gqjGrURJJKUPah7BxHHQKP0nCVc=;
 b=cEqjlLtG3Gmdyls65NmyTqosRjiuRlY+MfrfgjlUKIKatFDT1ij9PSJOwYTs8oyBUbN+Do45vvKmTvt1g2FkmvZRxs3VH00dxbpRk/GqZFqU/RiMBEcbw9qq7N20nEmQ+51HQqH2w24GIgwJfLbmhHAXvzMDfT1tzu14vTIKVDo=
Received: from AS4PR08MB8021.eurprd08.prod.outlook.com (2603:10a6:20b:584::15)
 by GV1PR08MB10930.eurprd08.prod.outlook.com (2603:10a6:150:1ed::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Wed, 15 Jul
 2026 15:20:47 +0000
Received: from AS4PR08MB8021.eurprd08.prod.outlook.com
 ([fe80::edd9:a452:6f60:5e9]) by AS4PR08MB8021.eurprd08.prod.outlook.com
 ([fe80::edd9:a452:6f60:5e9%4]) with mapi id 15.21.0202.018; Wed, 15 Jul 2026
 15:20:45 +0000
From: Ayoub Kaanich <ayoub.kaanich@technica-engineering.de>
To: Andrew Lunn <andrew@lunn.ch>
CC: Russell King <linux@armlinux.org.uk>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, =?iso-8859-1?Q?Dr=2E_Lars_V=F6lker?=
	<lars.voelker@technica-engineering.de>
Subject: Re: RFC: symmetric SET_MODULE_EEPROM_BY_PAGE with i2c_address for
 non-SFF pages
Thread-Topic: RFC: symmetric SET_MODULE_EEPROM_BY_PAGE with i2c_address for
 non-SFF pages
Thread-Index:
 AQHdEqUvQ2S5XVAteEurgYKiixGWIrZtcDEAgAC2GcqAAGmagIAAAGhMgAAclQCAAABHdw==
Date: Wed, 15 Jul 2026 15:20:45 +0000
Message-ID:
 <AS4PR08MB8021EAE9D0196FA87849F74DB7F82@AS4PR08MB8021.eurprd08.prod.outlook.com>
References:
 <AS4PR08MB80212ED810625BB46A8EE1B7B7FA2@AS4PR08MB8021.eurprd08.prod.outlook.com>
 <23323308-6278-47ba-834e-662b0e408705@lunn.ch>
 <AS4PR08MB8021E0A64800F977B6887141B7F82@AS4PR08MB8021.eurprd08.prod.outlook.com>
 <cd58995a-6bcf-4283-a072-84651a4f0031@lunn.ch>
 <AS4PR08MB80219505FEC2334B503C55DCB7F82@AS4PR08MB8021.eurprd08.prod.outlook.com>
 <259dbf46-5d93-4fc4-bf67-a7356a70ed26@lunn.ch>
In-Reply-To: <259dbf46-5d93-4fc4-bf67-a7356a70ed26@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f4ba6aec-3794-45cc-8203-ba2df4db1a2c_Enabled=True;MSIP_Label_f4ba6aec-3794-45cc-8203-ba2df4db1a2c_SiteId=1f04372a-6892-44e3-8f58-03845e1a70c1;MSIP_Label_f4ba6aec-3794-45cc-8203-ba2df4db1a2c_SetDate=2026-07-15T15:20:44.584Z;MSIP_Label_f4ba6aec-3794-45cc-8203-ba2df4db1a2c_Name=Internal;MSIP_Label_f4ba6aec-3794-45cc-8203-ba2df4db1a2c_ContentBits=1;MSIP_Label_f4ba6aec-3794-45cc-8203-ba2df4db1a2c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=technica-engineering.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR08MB8021:EE_|GV1PR08MB10930:EE_
x-ms-office365-filtering-correlation-id: 9b1be9f7-b809-4672-0e69-08dee284a428
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|38070700021|6133799003|22082099003|5023799004|4143699003|56012099006|10067099003|3023799007|55112099003|18002099003;
x-microsoft-antispam-message-info:
 Urb33YJiYxOJEDpeXIt7ApkbwWRKQd9tYwjbP4YkSFrSnSp12bmrhnHmbuCtotcWzIFd/QAVmDqaAP2nVK8Jlq7Y3Dqmmf4odhgjeEnxUhXoY7flCl3rJPV+QSxPfl7S34hfWkBXsfdai6F1yKqQ5Ho/nyiXSe+6VgJeFeS6GALRAOjtYLpr6rUG/hMCNweA4LUMIm20UWk1ud4mWkxXWdAYJ8942+Nf2FR67MKxxme2eAUF2bXVaEuI1c9fs9wgJYM4hI/EfxRYJQP9lpSjP9BtqdyWGsAo7Yis9xZJNnowr6VU7MB/bWfUJC936OArr5r79fbS6YDf7KHzIFYLFhaxtxfnbqnF0tJAtWD8o8laYAElzaCojtXzOEXeRWf8D5vcwixyrfY8zIv9G20IYjqfFdeSmEam8iKwiM7nIK4T+F7JAVFWMB0usyqGB23a2dkSrdK0q234Zup6bcA0F/cQb6f0Zi0gqAcnbdbW3Unk33MacXHvbpITJK58S9GwLrWx2O7oozkJq64SpenjGyaNfsbN9KBV4dUgSRT1zHjWv2hGYb+y+5VDAWN3zDaNBooZrKdFTHRSfUA7DM+2koMxIjlcf3jbyPj0oWvh3HiaovmTBQddOgJaT1a5GzfTkSXOUeF5cqRymqQjwl5LoYciWLHw58KpaOEc4Hg5lDw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR08MB8021.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(38070700021)(6133799003)(22082099003)(5023799004)(4143699003)(56012099006)(10067099003)(3023799007)(55112099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?nQuiDMkcSCxL9cJmrcFZWKHHObkBW2PKfAij8ieTQXvDo5IlGi1v2GidS+?=
 =?iso-8859-1?Q?7r53E1ppI6zgN24hLsmkAA2Q+8DujGvvErMy1CBF/51M2CVREzzaJSRejt?=
 =?iso-8859-1?Q?A1MP6Ik2uuaoKDHnvoyRwfnHhnpi9vkiBZET/B3rzBjZgVWFLnI94K+eAE?=
 =?iso-8859-1?Q?X+XKbn9+fKnI+Na1zkZau8W9bVuqmg+CZbKi+ouZZJHgzG+f8xXXlKoMsB?=
 =?iso-8859-1?Q?OZ0UdW890GYVcs4mt1T0orzHs/A6zqptl8HfbjHX3hgRPR8Xg+PfRhyUY9?=
 =?iso-8859-1?Q?9sDGRgF41R8acXslzR5zfth6GevWPxTVSI3FmYmDJ6+IV1huGdLJg9hCXT?=
 =?iso-8859-1?Q?vBalRFNGlMc5wL8td+qVg5oeH5/uOb0k3tqbr34ME3AJJzLY1Sqbxivqhh?=
 =?iso-8859-1?Q?MyVy0A6X7tk6tONnldpiROzLAuH15u19LeBfOsl0NK+M/D9agpqbPKGEev?=
 =?iso-8859-1?Q?zjdtxnsZvXdx1qj3B9JIDq+U1w30psXv5wfkT9l4hM48HKQF+Z7OFoJR4K?=
 =?iso-8859-1?Q?XrSJpOvv0RAAQNvDLn0tfp0QCgCjc2WbOsFnPD91O52zCD6VvONhBUno0s?=
 =?iso-8859-1?Q?xySgqxTjpcHoiNVUR0+MVkPPrmvSr5x+xi4w6JqmXTtJFq26WkMsrJ+GtB?=
 =?iso-8859-1?Q?goJE9RCJHL1mut82zhBfoqWqzSoT+f3Qvwt7opuQgA7rThKtTr31Gr0Q4h?=
 =?iso-8859-1?Q?rNPYPjO7VMn1PJZ5dvxih+vsM59mBfUO21MQzuPSd4XgUM7pP6xG8NSU7A?=
 =?iso-8859-1?Q?+Sd4qjbHGuoF+uKk79AhhoZ2gaXKf+eFCeErhz3VtnxXEpAx2aMik8eCRU?=
 =?iso-8859-1?Q?dtt+noWRZrFew2WMkpDi0U2D1Up2mNxGSgVC68fu8Tl3ueqLZzMeUUBSsB?=
 =?iso-8859-1?Q?8/gI27KjR1fs46eIX0Lu4OX5m1xDXuH0oHuISQ+UATgp82PTm1fzpEVpxU?=
 =?iso-8859-1?Q?v/z1Qviou8AfTMMnf/6snghD++aL7nS25+v4lMbWSnZ3oInErcNtyMi4Ar?=
 =?iso-8859-1?Q?GD1ujz4FWcr+QjykzR4xoIVJmdWYQTO1kXruPLbQJzavsfnF3sbiaTvj/G?=
 =?iso-8859-1?Q?dVcn19PyXWxab4wvJu9o3FJ3XzPamXPgaRHxqr3gLLOG/luGkOdhfjRwFt?=
 =?iso-8859-1?Q?CkaPnir0Dz/BhsKer7b8KUlf7uW6HR2uDQ4E+Sjyr0ldyT3KyeEQq7tek7?=
 =?iso-8859-1?Q?djd9layG9Un6t6cUdnaQ7OIpGyAYWR43E+wPnRe8Qles1LNh1MrC+FN2S6?=
 =?iso-8859-1?Q?Rhbnt3P0laM7TEn8ljuseZ+Vv3AuxBM/m9AK7rI02Kw8zMVWqBwn+8pLTi?=
 =?iso-8859-1?Q?WuHmKkRgnALyZBwn1tsOnUHpOOoV7vqhfbTcU6a4ZyvYTwT+mBvWVZOblO?=
 =?iso-8859-1?Q?PNVHJlw6wmo87gk4xGsVmNXTpllwTYWcvQAEv3+jD6nOR5aMxqft+Z7Oeo?=
 =?iso-8859-1?Q?6fkJN51dLCwfESVw0sXoL5KfHL3lZYpRammJmVHIHouTcFebRQwO3GkLR3?=
 =?iso-8859-1?Q?1FaVIGckWXTBvyx7ZHKNDVzSyJ6dW8zJY20gzhAy94et9+3QOULyq1PHHQ?=
 =?iso-8859-1?Q?caZaAGJJQbK1Izx8NkSKWo37OL3+LBY688Vj8E/FWSuU7ePd5ORGJGf2e6?=
 =?iso-8859-1?Q?vfqO6VfMWz9VBj47xIJcKlbpeWCz0e2LpjEkXjrzCbNoGqfJBux6qUbRgX?=
 =?iso-8859-1?Q?tZM0bcfqSfVuiSEroa1honivQtEWtApQFlU6dNj/mXunMUUbBbK5dmD2IR?=
 =?iso-8859-1?Q?g61UUpmZGAyKlXk4xnYN1Bo2nqEMnBFKvPwF/LziHeK6qUBeAUdrYC1wqb?=
 =?iso-8859-1?Q?D5JP//HxUKiFGkxt+4LMEmVeW8pgJUI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: technica-engineering.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR08MB8021.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b1be9f7-b809-4672-0e69-08dee284a428
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2026 15:20:45.0305
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1f04372a-6892-44e3-8f58-03845e1a70c1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0QeT9fQP24ZTq6fyA5pc27IfBYhrl72O5z6BkK5IT67UbvNGRtqzvdNyJGUw1uTKToh4Cxy8KNR8gB8jwX1y0aaeSM+ABPYiXBSBvpJ/mJ3cs1mc8RT8UqUcID1JyKPi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB10930

Hi,=0A=
=0A=
I suppose a bit of context is required here.=0A=
=0A=
We develop SFP modules on top of automotive PHYs, the SFP module takes care=
 of all what's needed for the PHY to function correctly (it has a mini embe=
dded processor).=0A=
=0A=
The NIC firmware does not need to know the details of the PHY and how it op=
erates, we take care of that in the SFP.=0A=
=0A=
The SFP modules we develop, are not meant to go in the car, they are meant =
to go into PC test-benches that communicate and validated the embedded devi=
ces.=0A=
This is the reason we are interested in the Intel cards in particular (and =
not embedded systems)=0A=
=0A=
=0A=
The issue is that automotive PHYs have extra functions, not available in st=
andard SFP 1000BASET/Fiber modules.=0A=
=0A=
Namely:=0A=
=0A=
* 1000BASET1 PHY needs to be assigned a role (either master or slave), a st=
andard NIC have no concept of this.=0A=
* The PHY have multiple operational speeds, for example 100BASET1 and 1000B=
ASET1=0A=
=0A=
Example of how it looks like, can be found in table 9: https://flex-product=
.com/assets/produkte/fl3x_sfp_1000base-t1/instruction_for_use_fl3x_sfp_1000=
base-t1.pdf=0A=
=0A=
In order to set those configurations, we need to send an I2C command to the=
 SFP module; to inform it in which mode the user wants it to work (the enti=
re config is just few bytes of data)=0A=
=0A=
This pattern is common in automotive SFPs, where SFP behaves as close as po=
ssible to a Fiber/RJ45 SFP so "it just works".=0A=
=0A=
We made workarounds using DIP-Switches in the SFP module body so far, but t=
hat's won't scale for the next generation of automotive features:=0A=
=0A=
* Configuring the PHY Macsec certificates=0A=
* Automotive TC10 (sleep/wakeup commands)=0A=
=0A=
To make those features work, the only interface available between the PC an=
d SFP, is the I2C bus controlled by the NIC driver.=0A=
=0A=
Since this bus is already exposed for other operations (like read EEPROM an=
d flash EEPROM), it would be nice if the kernel was able to expose the I2C =
bus to third party drivers, so that SFP manufactures can develop SFP driver=
s.=0A=
=0A=
Best Regards.=0A=
=0A=
Ayoub Kaanich=0A=
=0A=
Principal Software Engineer=0A=
Engineering Department=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
________________________________________=0A=
From: Andrew Lunn <andrew@lunn.ch>=0A=
Sent: Wednesday, July 15, 2026 04:49 PM=0A=
To: Ayoub Kaanich <ayoub.kaanich@technica-engineering.de>=0A=
Cc: Russell King <linux@armlinux.org.uk>; netdev@vger.kernel.org <netdev@vg=
er.kernel.org>; Dr. Lars V=F6lker <lars.voelker@technica-engineering.de>=0A=
Subject: Re: RFC: symmetric SET_MODULE_EEPROM_BY_PAGE with i2c_address for =
non-SFF pages=0A=
=0A=
=0A=
CAUTION: This email originated from outside of the organization. Do not cli=
ck links or open attachments unless you recognize the sender and know the c=
ontent is safe.=0A=
=0A=
=0A=
=0A=
> That does not sound reasonable, given that the only interface needed=0A=
=0A=
> to the SFP/PHY is the I2C bus which the kernel could access directly=0A=
=0A=
> (to read EEPROM for example)=0A=
=0A=
=0A=
=0A=
The MAC driver needs to know what the PHY has negotiated. Should it be=0A=
=0A=
sending packets at 10Mbps half duplex, or 1G full duplex. Has the PHY=0A=
=0A=
negotiated pause? sync or async pause? The configuration API via=0A=
=0A=
netlink is via the top of the MAC driver. So the MAC driver needs to=0A=
=0A=
ask the PHY to advertise what the user wants it to advertise. Enabling=0A=
=0A=
loopback again comes via the MAC driver. There are all sorts of APIs=0A=
=0A=
between the MAC and the PHY. The firmware needs to implement all=0A=
=0A=
these. You cannot drive the PHY independent of the MAC.=0A=
=0A=
=0A=
=0A=
And when you consider this is an SFP, ideally you need access to the=0A=
=0A=
GPIO lines. You want to know when a module is inserted. For a copper=0A=
=0A=
SFP, LOS has less meaning, so you can probably do without it. You=0A=
=0A=
could maybe use TX_ENABLE to save power when the MAC is admin down.=0A=
=0A=
=0A=
=0A=
I'm actually surprised you are interested in ice. You seem to be=0A=
=0A=
targeting automotive. I would of expected a more embedded SoC,=0A=
=0A=
probably ARM based, and those do tend to have Linux driving the=0A=
=0A=
hardware.=0A=
=0A=
=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0 Andrew=0A=
=0A=
