Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B252F7EF3;
	Thu, 23 Jul 2026 23:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784850060; cv=fail; b=QKMpZD75EkSzZ8IO1CeES00C81MADEyI7brJxtVQmWj1/Ixud0hHKj4xXm5kWTqUVX0tP/iYMGIZD3PbA921g2LUzDl/yz3oAtpzDiVYMY5yPs8dq7njX9Md84wT6AFlYMbmyCMLiix+CV5pLb6tOoKgoSH68Oyueo6C/PRTWb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784850060; c=relaxed/simple;
	bh=NB2B2PeAa08Wu4jOcy5LbLfaFj07I9ISvtzRJm2VTpk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UmKohoUZS12yq8RqK1mJC/d7v4iOvJdv8v1cGuU8l/U25SlVUVTKgkgaPJ70bYPF3iWpcFwH9zU21qFYAht084pZqm/X17jzjdB9Q+kM8c+3QG4KL202o+FdYApPi6vh3zhgqC1hIncatCmIVHWzebTYgP1o3WsiGwAcbpZPIhk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=K3Mc8eFf; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="K3Mc8eFf"
Received: from pps.filterd (m0209326.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NN6Bd53602220;
	Thu, 23 Jul 2026 23:07:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=p1; bh=NB2B2Pe
	Aa08Wu4jOcy5LbLfaFj07I9ISvtzRJm2VTpk=; b=K3Mc8eFfhDY/VlIhUwshe3U
	C3gClY+HGPz3Wu3gF5VkCtnJdLtulW/h4NA8fC5qzV7z5/53PBIRFX1GcOHDYJYI
	zkz2hC5WpCxemWSqOYciYxrPQHv3ftNCMQDftbAvsk9f7duR68k/5yvUQ4mtdbCc
	ikWgYJ7n+5wfdBJ0d3HKAmz/VjUv8GrmRuftUF05hRjh4CVl9e6WRvRP5unLc9Og
	aQTQDb3/wdq5jd/3CWRe6Gw82nDagNr7XWU7cAjfSy1a2/XcxP0DROK3EMSemu/6
	QTj2cgJhRYB2sJwilinTSb62mXrEtwvgfDoaLiG/Io8Kx+0FxbeiKWIAh6v8PRA=
	=
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013045.outbound.protection.outlook.com [40.93.201.45])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 4fg1jueea3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 23:07:13 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xDdAd3jSw0OamMA1z09kMdzSNsADQU8Xmm3xAd8N8x6vjkfMMhSKRuYWMv5M6bIhuHHltFUHJibF5bofoECFu0Q6YRb8JW7D7w8iY0SyWPU+e6dsxUjrx2lt+34NhT1/z01iZ6CaMdtC/LqgWs/6fnAi0WUzaN4QvZCF3td0D/qUo26Qs5e8w/zch8T5Qjm6czN/0uL/sgwZi8DLhIMGDah2VIyH5rSb6nZWpHbwD2mJGpGOmHSdgc2e+DcgSgfusCLrmf3bB9hI6fZBGYf12VNSS/pshv/hFHkOd5xHFfk9Go3LbSjdTznKtMX11hQDHOlWhcpan6ln35V7uoRlsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NB2B2PeAa08Wu4jOcy5LbLfaFj07I9ISvtzRJm2VTpk=;
 b=HYOMG4QS0zr9YiSOHNU91jU8oqHWWd/psAZiI3wte3BJ9sHjtUH0RDdIvbJPVpsHpvVOtdEHD1IzpzUDV6yqGOFYYo/XFD4Mb0IsfnRahmw2ctYtz4sLsCEtAnm6D892EWKAvXyXDpFDvxPji/LNFOrB+qql9LFEq/DmYHZe/SYcYWeprCuXSF1QuQ/x1J++IZ84Gj6SwvsDQk82YADPnT25AmvstgdFDz0MxhPYtkOKCQyuIr4QPw9xkUshZ20f2FRTJJGn+nxpeJmQPpiNzHlBWm9+gQ8i8fcNySezsmTaM4nlU9tr9tWErGQ1/QzC/9Q1cv6hZf807tb7loNa5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from BY5PR13MB3651.namprd13.prod.outlook.com (2603:10b6:a03:22e::19)
 by IA3PR13MB7003.namprd13.prod.outlook.com (2603:10b6:208:538::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 23:07:09 +0000
Received: from BY5PR13MB3651.namprd13.prod.outlook.com
 ([fe80::a413:78a3:24c7:39bf]) by BY5PR13MB3651.namprd13.prod.outlook.com
 ([fe80::a413:78a3:24c7:39bf%4]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 23:07:09 +0000
From: "Bird, Tim" <Tim.Bird@sony.com>
To: "Shashank.Mahadasyam@sony.com" <Shashank.Mahadasyam@sony.com>,
        Andrew Lunn
	<andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bastien
 Nocera <hadess@hadess.net>,
        Matthias Kaehlcke <mka@chromium.org>,
        Valentina
 Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>, Hongren
 Zheng <i@zenithal.me>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Daniel.Palmer@sony.com" <Daniel.Palmer@sony.com>,
        "Rahul.Bukte@sony.com"
	<Rahul.Bukte@sony.com>,
        "linux-embedded@vger.kernel.org"
	<linux-embedded@vger.kernel.org>
Subject: RE: [PATCH 0/4] usb: enable sysfs module symlink for more built-in
 drivers
Thread-Topic: [PATCH 0/4] usb: enable sysfs module symlink for more built-in
 drivers
Thread-Index: AQHdGYqezbiiyqxZX0aoeW//aB3bo7Z7u6Lw
Date: Thu, 23 Jul 2026 23:07:08 +0000
Message-ID:
 <BY5PR13MB365100E0FB52AEB0F37B3C9EFDC02@BY5PR13MB3651.namprd13.prod.outlook.com>
References: <20260722-mod_name_usb-v1-0-96d781530f3f@sony.com>
In-Reply-To: <20260722-mod_name_usb-v1-0-96d781530f3f@sony.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR13MB3651:EE_|IA3PR13MB7003:EE_
x-ms-office365-filtering-correlation-id: 826f1386-ed01-40e8-fcd3-08dee90f1f29
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|23010399003|376014|7416014|10067099003|11063799006|6133799003|56012099006|22082099003|18002099003|38070700021|921020;
x-microsoft-antispam-message-info:
 vJAJ8R8ELcTsMQHCjXTx7wtZL5U6te1u5mM7hVLgLEcuMXapVByBwET/ETRvo/mCddkAmsmtueYwrQ9OT9Ug8q7S3mjv7RBLvqD/TQ3/2hD0dcs5xWrzqEdXEDKtghJGddbJWdekXN763bh+icM8ptrzwWUVHD3kP3uFDeGVaxpYUGYb4wRZFTvy0ByPr3AGB1cFQw04OptyVH5kFZP+IQJSQv+Rw9jIv4SxiyYUH4poMNlbrdTbvrDQlHkp+ZSX5cQNjHWI4KcHrBSFZ0jtLVgiaVJHO+0T48o6X/ZaVg595lba5RaoMXKFSIA2+tS+o9+wWCbgeYL9k2A78n4zv4LC+c7q1f0F60JJnoROGPhVatPyzT/pXklISMJF6W66bRxCT1INGIDw+MfqN1zw4pUSLeHUQy7BTOGJbfJgXb2+zRCRbls7zBnw0L/DdJ4YqviEcQxwu+vng4zxFgHaZbs0EuArh/iuW1cIAEtuxVCDxFTbZ7BGnoUk9mT/302ycqJ/wYV/fscbNkXCu4ZiPF5w/318Z2hAoaUjTCu5pCMCq0L/qSnfVswxDaW6UqQa0VRBLtLLL3iaNV9UIQhXiDDDax4LgcpL8fNct863NkM1ZI3fxS4GisPBSqRuSO+h0HIDNo+vOTorowdrJ7anDy9uh0Rk7gf0jQE6TiCNAcloM/Drtk8o/wMS6GQaOYigIhq9D3A5O9nQYB04DFlBZ0TPH/6hyY2lDbdli7UTMWbTLdq4TwKX+plI+UzylztH
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR13MB3651.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(23010399003)(376014)(7416014)(10067099003)(11063799006)(6133799003)(56012099006)(22082099003)(18002099003)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M0ZYWlNxcnpCdHZ3SHdBUWVkd2liaUpTaXRBVHBlbExPYWI5Mk5tb1hwYUM0?=
 =?utf-8?B?aHJhNnhuZmZwU2xwamtRbFJydlU5c0NGaGkrcFNCL2VMRUlvWlRUSFIrWnRR?=
 =?utf-8?B?ckx3Q0hwNmtBS3ZtSVloYVg0b1hKRmZnTStKWFBuU0VlNVdocHZYbFJMbmx1?=
 =?utf-8?B?REYxd1R3Y0ZCWFRNQ2pjT3o1UXRBditkcDhpSk9jM0ZRNHpPYnBnekRrNjRP?=
 =?utf-8?B?MkVJc2pQZnhEOHllOXZWZ3lxNTE5bGZ2WkVHUnU2YmZWKytCK093eloyL2lN?=
 =?utf-8?B?ZjFwdlFTcGptVnlRMERNejZZbUd4ZFBSbFhtc0V3OURTL2I3emFyZmF3L0dL?=
 =?utf-8?B?OU5kdmhveG9ldVdZSzBOK1R4UzFCZ3lEa3E5SWJaclpXOHQ4b0JncGFvL083?=
 =?utf-8?B?aUszdkkzRTlxUjBsNEhFK1JEL09adGZzNVJQd2oxcW95Uk9zOTB1Nk9ycHQz?=
 =?utf-8?B?QktVRW42WG9vamlldUVDVG4vV3V3TmoxLzcwWG9ydHU5WXB6eXRLNkVvanF2?=
 =?utf-8?B?YlJYdFVlazIxbDFZSTdITWhkQzF5WWVteHJSdjFTMW41em9zZHhSdDg5LzQy?=
 =?utf-8?B?UTBnRlhIelcraWdNeXlFSFNxWU9WV0JDcG9HNGc4eks0TVFYUmoxMkFrTDRz?=
 =?utf-8?B?ZUJVVzV3NDhMWndkTStrRlM3YjRqOXhzR0FITnNRRmczMk1hZXMvRGJIdXg2?=
 =?utf-8?B?OEhZRmpwMTBCd2FHTXpiNkRWamNrWVl3WFRFZWpFTlU5Z0dvVktQeFZGNU1T?=
 =?utf-8?B?K251aWwyN0dMamNpZXRoWWF5UUlSeUxocmlENmVwNi8rUlNaSHlFYjc2STNE?=
 =?utf-8?B?Ym5aQyt3R21OMURDVFV4cU5lOXFUUExJZHJBUE1rbTNaVGhsVFpMLzFYUHEy?=
 =?utf-8?B?UjBzZlU2Mi9nN2phYUtZd3VLQjg2Y1ZyazF0dXAzdThwZzlGc3Uvd04rMkt0?=
 =?utf-8?B?KzRvbHVXU1lMcWhxTUpZUmNNM3lvMHJZbTZURkt0Zk5xTGdIMFVsK09LTWhy?=
 =?utf-8?B?cFd0UmpIdTF0em0zenUxTktma1RZY3E4Zk82MHJUVS9BTHMyM1p2dlUrajhO?=
 =?utf-8?B?ZWwrbzRpRTlwQzZrdzNtaHZyT1BuVWdYMmF4T3l3TEV4eGMxeWw0WHV3YzBU?=
 =?utf-8?B?RHMwbDZpa05naWQ5RFNJY3BQbW0xMmY3bDZUVFIydDI1ZitCamlCVnMzcFAy?=
 =?utf-8?B?aTJhRjFWYmpNd3lZcUJLZFIxa2RhbzMydnk4U0c0dXJ1aFNtUG56MXBGQ1Q3?=
 =?utf-8?B?ZnI5MTJ3cEZXTEpxdm8zaXBtQ09aVDl0elp2cjNYVlZ5VFlFYTVvcWNFQkFJ?=
 =?utf-8?B?YlVjZ29LUWJzV1FYUDNma3MzRzBCVVdRQk5UamlkbW9MUENENzRYVE5NMmQ1?=
 =?utf-8?B?Tmg0clh6UGJ4MHl1LzFsSFJ4Vm1nZXJTVXNsaHR3VzliOGtpRlVkajROSFh2?=
 =?utf-8?B?eVQyUWxBdGdNMTNMKy9UYTRoL285SFlSN1BpdExCc2t5am9mTlIvZnV1NmE4?=
 =?utf-8?B?bnA5SVI0L3R1anVIenc0LzE3enhkM3pITnRib1owM1JTcUpYRVo5RWZ2SW1Q?=
 =?utf-8?B?eDNFWUt2Wkl1R0lRK3NUcnNJaEk2TjIrQXVIYVBYaWZqbis2eEZGejIxVks1?=
 =?utf-8?B?ZWJQNEV5K0Z4RDZnUEhNVUNPYnprWld3WEg0aGRIb2VmbWhpSlBWU2hQRFd6?=
 =?utf-8?B?YWlNcFRLRU8xTFVXUHBRU1krSVlNRmtIMDh3YW53NDNoa2YyeElGVllZN1lS?=
 =?utf-8?B?ZEFwZW02TWNZZFREQUtJYXZvUVI3RkdkVjllNkpsd0FwVFV3ZGU3MEZjTmdM?=
 =?utf-8?B?RkhnZHJ0UVNWRGVyandjeW1KMkdMRzEwc0dsSDJsY2VZUEViZTFOdG9mL2VF?=
 =?utf-8?B?TFVoa214MGNyN205c2lpYWh2b1ExU0lYS0NQMzgxN1NCTDM5WDJPbGh4bXBW?=
 =?utf-8?B?b09oODcwRCtuMFJYV29UMEdIRThUVXkxQVF4akdsaitLVW1tZXZ4M2wzbSti?=
 =?utf-8?B?aTZxbjE4VmJHU0k2VVJpTjdXYjVicDZnNjB5K0tNbEFnaWxiV0NkeFFCUW5Q?=
 =?utf-8?B?STVLdzVOZTZtRDJwN1FVdEZ3OE9FcU9OMUZId0Z2QVBNaUc0bW5yRlRVSjQ2?=
 =?utf-8?B?b3NjcFFWbFpiNE1YNDhlaWdGR0l3SU1nWFl5akFnYTZvVTNHN3Y0cHNUcE44?=
 =?utf-8?B?eHR5eXBzRTdxMC9tZW1uMFlzY0JXUCtWc2Y3S2d5MWVRS2tINVNFU1pWdUs4?=
 =?utf-8?B?bC96VnlWU1dJdWZZYi9XT1J0YmE3dGJIYndObXZ0WDRLVU51SHhKTytDdElq?=
 =?utf-8?B?ZU16aFliK0YvRE5lU1E4VUttMFQxWTc2RkVwUnRzMGhiUHFDWXR2VGFrOVU4?=
 =?utf-8?Q?NYZ48M7YjGUHE+RHhwNyxUo1TizKSl/8YcQdr?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	T0S2qTUBU477r7HT/fqbO9uDTj7Zc1OtT0C7vYx2P87itCIsl9o1mZovGU+/bT7ATGMEnyNA9PzNQ9HIW8PCc5Bx8RrwmAWyS8n9L4ec3WGIHxv8Y//Z1ynOF5Sn4ia2w9nL1CqQwamiM8JEOxAOh9qJN/vsLur8bbajuTm/D6z5lkdCbWGCSOEv+zQgK8nn96bXvN1ljXQuy0DdALuZE7mLsRdFQY8gPi//+4M0Orc6uq6aYR6IgOmpXKPP+rRR7OZvmk7BciK8aNfg7yp5MUbjofbZjjrxYYvmNhE8Uld0/PUqTNxQ4K+jV+jYMy817z0pufpV50p43uL1xhkLCQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TO8wJX+Um9rae/+ZnmgRmmAf4Ttk1l+JF1+VHeIWID75qBinVUcLXPp3w+DSJCoN8W1gwH2onYeO/JknQbFPauWuLShQHIxhF8SyOQilFHF2oHQyluFsr9T8xLgWH8aHu77MJRyffRqCv9ly3SEQcDVPrfKGYFYEMrO9hARHBOEv6VL5A/alSkMwqMcPrWlniZpxnurxKDyBoqbkIqXRnsi0iP9gW+W4VUMSbYfhvjM3vwiKbuGZWX992wQG3ftBHjxg8+Rq+CYgOkpe7HdxqkKwiTrm4Y6AIZKabUiCvbTLW11ULuMMOG1SasZHMaJfK9jnzh+y9WjZgm3jKsLaB2OZOmHqf13/4mdgCiWZbd21zKRbWStiRzYF/gq68O85ugPbCybayB5Ue2UyOkRkjKsfS/lgf+9mb3lJJBYHsUg06B02oVnAisSfc0o3TfUDj+neWuy8jnQNZrfV4Y89kmzuRZvanS+gS0GgXYL8GTGeLeRv0kT+sfrOy4DHh8DQDZoKcvrO16iYMX8ECp4mhc92YkMILa0baV3dYEnZ6VMbYwPCaWCdx7lqxSJadw2gcFSxgrU4HEg72a4wAW0gMq1G/qT+EuVOsBwrXEOxZRi8wseNKq7CdNkLwD0Tjl6M
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR13MB3651.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 826f1386-ed01-40e8-fcd3-08dee90f1f29
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2026 23:07:08.8782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xwmMZ7gbCxJVmQ+BX4D1+th0hsIs1C4asrqgA9OGFk88zbbhcMUk2vv6lXcoxZ/+8emjD8dE5/jqOc+Bopuk0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR13MB7003
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDIyMyBTYWx0ZWRfXzxsbYyGf//SQ
 zMILRIyoA711QId3T46R4zQPY0bG5Qgdz5ZbRzAgpRDR7QIy8KB57ebd3U6ZXpmlYIpwNdT0NhK
 AncVV32gvKSEEdQ5VWSURt25fcVxiBW2/et4WbZ1Eu+/GY2GYdG7
X-Proofpoint-ORIG-GUID: 4XyqOqgfODpUdUcuy0XMCy3dzdw5Q5gQ
X-Authority-Analysis: v=2.4 cv=cZbiaHDM c=1 sm=1 tr=0 ts=6a629ea1 cx=c_pps
 a=vt7ZpyDplQGd1SQmd2LaWQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=xR56lInIT_wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KAb5x4SsHD3PzxGk7EmX:22 a=lmptg-Pxpg44AF-n8Qp9:22 a=VwQbUJbxAAAA:8
 a=z6gsHLkEAAAA:8 a=wRM2bpcKo_aYF1OLT60A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 4XyqOqgfODpUdUcuy0XMCy3dzdw5Q5gQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDIyMyBTYWx0ZWRfXy2Xdes/oOmH2
 fNSY4qq3gE4V7D1VQ7/riE3Nio4nYVQEV4ePT+QOol3XaCu0TfFiSpzG7oiOva46gcWxfWtBl9K
 qBwxo5fyeIWixpOOr/kTZvvv5uiug1DUNBr0AOHy10j0c788ShfGiSZVS4jE7i0V1NAtYlSw7PJ
 8Nm3xlrBSW5kh/nS8R79zXtQegxxB4HoQJEmbwWUps8CA9vRYjcAlllcccmVo0cy6k2gKcBUDT+
 DnHTZkKGpvGYVD5BRt3/vJEDjh54Z60cp77/YB51ApHbfRjdfx1/IRrB+2VJwmEJy/uNTUERWpi
 decVF2cO8GYSlDqsodEPPvxIT2HjQhALjvuUUb6gPRNcJCE/NGgSk9DxCdp6YXXewoS2PM4V/o1
 ESFtLU2ZcdcHq3bDIchf6dTPTHquqAXp8Io+Phir5ykM2qrlGfRWgiMqFvcQvEw7u4MgFjVgKIy
 UIL5QMruhBLmgw/8s7w==
X-Sony-Outbound-GUID: 4XyqOqgfODpUdUcuy0XMCy3dzdw5Q5gQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_07,2026-07-22_02,2025-10-01_01

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYWhhZGFzeWFtLCBTaGFzaGFu
ayAoU0dDKSA8U2hhc2hhbmsuTWFoYWRhc3lhbUBzb255LmNvbT4NCj4gU3ViamVjdDogW1BBVENI
IDAvNF0gdXNiOiBlbmFibGUgc3lzZnMgbW9kdWxlIHN5bWxpbmsgZm9yIG1vcmUgYnVpbHQtaW4g
ZHJpdmVycw0KPiANCj4gVGhpcyBpcyBpbiBjb250aW51YXRpb24gdG8gWzFdLg0KPiANCj4gc3Ry
dWN0IGRldmljZV9kcml2ZXIncyBtb2RfbmFtZSBpcyBub3Qgc2V0IGJ5IGEgbnVtYmVyIG9mIGJ1
cycgZHJpdmVyIHJlZ2lzdHJhdGlvbg0KPiBmdW5jdGlvbnMuIFdpdGhvdXQgdGhhdCwgYnVpbHQt
aW4gZHJpdmVycyBkb24ndCBoYXZlIHRoZSBtb2R1bGUgc3ltbGluayBpbiBzeXNmcy4NCj4gV2Ug
d2FudCB0aGlzIHRvIGdvIGZyb20gdW5ib3VuZCBkcml2ZXIgbmFtZSAtPiBtb2R1bGUgbmFtZSAt
PiBrZXJuZWwgY29uZmlnIG5hbWUuDQo+IFRoaXMgaXMgdXNlZnVsIG9uIGVtYmVkZGVkIHBsYXRm
b3JtcyB0byBtaW5pbWl6ZSBrZXJuZWwgY29uZmlnLCByZWR1Y2Uga2VybmVsIHNpemUsDQo+IGFu
ZCByZWR1Y2UgYm9vdCB0aW1lLg0KPiANCj4gVGhpcyBwYXRjaHNldCBhZGRzIG1vZF9uYW1lIHRv
IHVzYi1yZWxhdGVkIGRyaXZlcnMuDQo+IA0KPiBbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
YWxsLzIwMjYwNTE4LWFjcGlfbW9kX25hbWUtdjUtMC03MDVjY2M0MzA4ODVAc29ueS5jb20vDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBTaGFzaGFuayBCYWxhamkgPHNoYXNoYW5rLm1haGFkYXN5YW1A
c29ueS5jb20+DQo+IC0tLQ0KPiBTaGFzaGFuayBCYWxhamkgKDQpOg0KPiAgICAgICB1c2I6IGNv
cmU6IHBhc3MgVEhJU19NT0RVTEUgaW1wbGljaXRseSB0aHJvdWdoIGEgbWFjcm8NCj4gICAgICAg
dXNiOiBjb3JlOiBzZXQgbW9kX25hbWUgaW4gZHJpdmVyIHJlZ2lzdHJhdGlvbg0KPiAgICAgICB1
c2I6IHR5cGVjOiBzZXQgbW9kX25hbWUgaW4gZHJpdmVyIHJlZ2lzdHJhdGlvbg0KPiAgICAgICB1
c2I6IHVscGk6IHNldCBtb2RfbmFtZSBpbiBkcml2ZXIgcmVnaXN0cmF0aW9uDQo+IA0KPiAgaW5j
bHVkZS9saW51eC91bHBpL2RyaXZlci5oICAgICAgICAgICAgIHwgIDQgKystLQ0KPiAgaW5jbHVk
ZS9saW51eC91c2IuaCAgICAgICAgICAgICAgICAgICAgIHwgIDYgKysrKy0tDQo+ICBpbmNsdWRl
L2xpbnV4L3VzYi90eXBlY19hbHRtb2RlLmggICAgICAgfCAgNCArKy0tDQo+ICBkcml2ZXJzL25l
dC91c2IvcjgxNTIuYyAgICAgICAgICAgICAgICAgfCAgMiArLQ0KPiAgZHJpdmVycy91c2IvY29t
bW9uL3VscGkuYyAgICAgICAgICAgICAgIHwgIDQgKysrLQ0KPiAgZHJpdmVycy91c2IvY29yZS9k
cml2ZXIuYyAgICAgICAgICAgICAgIHwgMTAgKysrKysrLS0tLQ0KPiAgZHJpdmVycy91c2IvY29y
ZS91c2IuYyAgICAgICAgICAgICAgICAgIHwgIDIgKy0NCj4gIGRyaXZlcnMvdXNiL21pc2MvYXBw
bGUtbWZpLWZhc3RjaGFyZ2UuYyB8ICAyICstDQo+ICBkcml2ZXJzL3VzYi9taXNjL29uYm9hcmRf
dXNiX2Rldi5jICAgICAgfCAgMiArLQ0KPiAgZHJpdmVycy91c2IvdHlwZWMvYnVzLmMgICAgICAg
ICAgICAgICAgIHwgIDQgKysrLQ0KPiAgZHJpdmVycy91c2IvdXNiaXAvc3R1Yl9tYWluLmMgICAg
ICAgICAgIHwgIDIgKy0NCj4gIDExIGZpbGVzIGNoYW5nZWQsIDI1IGluc2VydGlvbnMoKyksIDE3
IGRlbGV0aW9ucygtKQ0KPiAtLS0NCj4gYmFzZS1jb21taXQ6IDI0ODk1MWRkYzE0ZGU4NGRlMzkx
MGY5YjEzZjUxNDkxYThjZDkxZGYNCj4gY2hhbmdlLWlkOiAyMDI2MDcyMi1tb2RfbmFtZV91c2It
ZTNiYWY1OGUxZTFlDQoNCkZXSVcsIEkgbG9va2VkIHRocm91Z2ggdGhlc2UgYW5kIHRoZXkgbG9v
ayBPSyB0byBtZS4gIEkgZGlkbid0IHNlZQ0KYW55IG9idmlvdXMgZXJyb3JzIChidXQgSSdtIG5v
dCBhIFVTQiBvciBkcml2ZXIgb3Igc3lzZnMgZGV2ZWxvcGVyKS4NCkdpdmVuIHRoYXQsIGEgIlJl
dmlld2VkLWJ5IiBtaWdodCBiZSB0b28gc3Ryb25nLCBidXQgeW91IGNhbiBhZGQNCmFuICJBY2tl
ZC1ieSIgZm9yIG1lIGlmIHlvdSdkIGxpa2UuDQoNCldlIHNob3VsZCB0YWxrIHNvbWUgdGltZSBh
Ym91dCBteSAoaGFsZi1iYWtlZCkgdG9vbCB0byBmaW5kIHRoZQ0KY29uZmlnIG9wdGlvbnMgYXNz
b2NpYXRlZCB3aXRoIGZpbGVzIGFuZCBzb3VyY2UgY29kZSBsaW5lIG51bWJlcnMuDQpJdCBzb3Vu
ZHMgbGlrZSBpdCBoYXMgc2ltaWxhciBnb2FscyB0byB3aGF0IHRoZXNlIHBhdGNoZXMgYXJlIHRy
eWluZyB0bw0KZW5hYmxlLg0KIC0tIFRpbQ0KDQo=
