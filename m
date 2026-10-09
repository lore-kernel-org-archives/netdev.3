Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567B851C051;
	Fri,  9 Oct 2026 18:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.129.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791570730; cv=fail; b=Luck4zPstPOB+tg7sHSMmHTmK/qE27qmILFAlOzM0u/pYewmC8jjH2IWe/xBrz68e2crPk31nziD7GcM1uModoTjfzkbSPXImz1SeHWwIy0cd/VF4sUGuoFt2swPp0z3T7pHdFjc/t0LkatygYhrLvLQg9YTQo3OGNsKpn+dOVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791570730; c=relaxed/simple;
	bh=nBVoOChA8xT9cR7J6WrMmv0xbWHXiabYYD3PFPskIUo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rs7qHLJXu66jBZo4Cmgpm8YMJvIHiU5/FRnGxq8DV7ret1VlFp5AAXvFnVcq5mq7R16NbkCwNMljkPZ6AUH6OvmWmKImRSc5CYK7SdZ4haz6OoXERCdHnZJn2w/Z/uZNTR9ml4rE85ZSw3QvmN5+mRf59A13eLETtRtv0Blz4Y4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=MbnRlE1G; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=HVDvCGbi; arc=fail smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="MbnRlE1G";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="HVDvCGbi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=DJ+Zgcyp6/FYbV4NpvvYxnaEal5YVZJ24UWB0puVeqA=;
 b=MbnRlE1GiwCEuZ4HG7vPGRfg9S7h7aaFPQahV6wcSrZ2WsUgCcgUArfO3rrmG/SKzIo0xn7efk/Jck1lgD4aVnmYBlFc4JCIYFtkk5OL0m49DIO0WdxFHKpm1AthC1C46aaeb5P3L+nOtGzCbL7sS9ED9262Q9ndxNWF/uHiAkUB+CL4JycmCC83u2/Vh0QY9McKSZRN5vdp1IuMIDoN+F8VD9Pre16N5gdqLmIiF62pJ+XE8+gaGXTuCEuu0/5m7qxP7MdmkWWbF09ae0R5xKkD7FtmGOsBxVsLJdSbhZxEtMWbjRY+7S1N6iCRTnzQsZAjooOEdhs8PyKjdelESg==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023142.outbound.protection.outlook.com [40.93.201.142])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 30D6EA80076;
	Fri,  9 Oct 2026 18:32:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EDTqUDmFDsJeDYKSbf0jbCiGURDnmWMwe0yOGLIwTRJZMF3a3nuej6QBqloWMOQpGa86wHZar1Ih2jMuKfgtuFibcUqnZQp0fj/d4WmISKE3xFHB8870CKlx02lWjIzDbggUD+4IE95nG9izaWzDZjPxJRIIqEKY79CXDfyKLKx7cpl6kfeoFYvu34PGai2Fn/ndtHXhRSiCyhYWEMME/WbfexgLnF158uSU7TTerc/waoAdlZ7EfI2kYtcIvYE508DydS+LCgRnFmHheTWzAui7EJtfluxLMcidFVXhWQ93Yrjgc+RILuogBm/gcgtNJtNyG6NReZfgPpS8/XoVAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJ+Zgcyp6/FYbV4NpvvYxnaEal5YVZJ24UWB0puVeqA=;
 b=doOFHoSHXT4nvx50FaPS2g+C/f1TbxafHuBip/absVejUyOdftBvT7YRa6f23Atk3qT1IRxNAGed9XzwtH9wJn8BZ1J56HLaUp/Jia++w6HcKvvEPk3MB0mGcV0xLyCoa/1oDN1sbFAGZGtFvMwdbJ3Il2FzKoX+fNhDH6ovqqbYET9k8B9AXENyb30Qxrf+ugdQLZJcepsR4AtQUQNpGIVskOwhdfODBWnXIUNvC4nLc9HUj+kNmtagMv+X9l76frdZQuqbYa0v9Mt6gFDX823aNr3z4OhKFa38v8G6P8Ea6UjUzqMncrtg28neFeXsExsfwH7Yc6sJJwgpccWQgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJ+Zgcyp6/FYbV4NpvvYxnaEal5YVZJ24UWB0puVeqA=;
 b=HVDvCGbivQ3rSzlVTDSvVB6ckitmdvU8W/UNTdtKOIGLrO+/1XgChdOpgzpUxfVR4QtIfa4bDV1n57y9FOCr8QJ7IUtMveauk1JIlA1ZMb+liKIC3Zv8Dr6TahFxuKHuHTBZOXX7xq0I4MSkGMZaamQNT+gQBmnurYWEJUNiSQpTQX2ggIvFMdS/QSi8sasw/d0H1PfVK0GJP7GJ3xkTPW6u96p2NrIdS+sMPjdvnJRe9pzGo2mVr98VkSSS7QP6FFQrO71dNsG1xp8j0uWTq2eSd5Zl1Cjyy47PTCs3IqyKiD/btEyZQkUC4uInrBs3A8o4n7JV/SqFovkmL1zTKQ==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by CH8PR20MB995515.namprd20.prod.outlook.com
 (2603:10b6:610:2eb::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 18:31:59 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 18:31:59 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Arkadiusz Kubalewski
	<arkadiusz.kubalewski@intel.com>, Ivan Vecera <ivecera@redhat.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Carolina Jubran <cjubran@nvidia.com>, Oleg Zadorozhnyi
	<Oleg.Zadorozhnyi@devoxsoftware.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v12 09/12] dpll: sit9531x: implement output pin state
 on a DPLL
Thread-Topic: [PATCH net-next v12 09/12] dpll: sit9531x: implement output pin
 state on a DPLL
Thread-Index: AQHdWBx3LaY7UiR/AUSliu6UQfWoWA==
Date: Fri, 9 Oct 2026 18:31:58 +0000
Message-ID: <20261009183151.78497-10-arouhi@sitime.com>
References: <20261009183151.78497-1-arouhi@sitime.com>
In-Reply-To: <20261009183151.78497-1-arouhi@sitime.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|CH8PR20MB995515:EE_
x-ms-office365-filtering-correlation-id: b980d1e9-6f3b-4af2-57a2-08df26339b06
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|38070700021|56012099006|5023799004|10067099003|22082099003|18002099003|3023799007|6133799003;
x-microsoft-antispam-message-info:
 kDJm33in8akBLym1ImPna7Y4JNp2T7XqMntamc7tA0156eQS8GNai32tQ6gumIp3010AoDw1b4ORjK/FmyhV1IHAyBhmv6ar05CtMn9trQH3iK/+QSqW+VTz8J/ejmoeay4VN9XEsB3vKXGIBU+dIBLNXYqCia3FgecMv4H8ejPlgJqf5Vpspwm4D6mXdS+z/2KrlHlqsXlqVrpRwm8JIA9gl0L5FnxjF92aPOJ1RuK9DGiAqYp7sK7oHg9ZEkyOclPLOccowM28iEZ+0MhGfw8A9vc/ppYZGzM1hKbudU1WuhKJACB7oi6QtYuo5T1szxUBgICM0l/V1tB3ctReJV12AoVGliGXeR3bED4IsjKaefzQLmEuxXy6y0/X5EBJ+MwlWldslJ6WPia+5DZMKYmH/u36eXDP0BvrrAnV2Eo9RliHSn33z76W/OIl+cdZ+8bbikuAVfUeCilb2KS06iyqHsrYlNWVkpXufazizl3R5VDXPbXkmK1cAuCRHxO/Rk2xojl53tW2lWt70W0n5dXEEOJQwqjB/BpVRBPX6oHISgxwiBbgVj/pb8/fRdPiBEh5CgjehGWca8oPlqCgeAdPhF6229ZBrRM35qKEelxshhmCAra2rpwXSmHtwa0R7FZzsmLe39fmZj9y712SZoGJt5Y8BuhBHOFXZNnsHFu4sHkKNmNAXlDMIDEDmINUgSiFyNI0uXEZVjRju185lhaLc5si97h4T6MEI1xIoqM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(56012099006)(5023799004)(10067099003)(22082099003)(18002099003)(3023799007)(6133799003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?q09aFNT4QTs7UHGVfADSnLo5vACzZ1oTBiAIGuNVVDgC7+j9k9nqWYVkPG?=
 =?iso-8859-1?Q?lTNFWZ3Rzl2n3QstfYG3jhmtf6qqpM4UvULGm+N3gMjmlGzjHEylaEQSrX?=
 =?iso-8859-1?Q?bSGJvWOWf7XiBeJYpPnvEfpxAxTnROfFR6i18ggmKH8ClHdidwmt8MXq9J?=
 =?iso-8859-1?Q?xxtlsFn2U+fn8wuR10oRKMura96zIAJL2hE68LqOz+4NRRj3kznrOAy1tN?=
 =?iso-8859-1?Q?jj10bq8ITjPndG92NIqonJTxcVnd+TjQfrAuO5yCsMqZ4D9AExWlW+LTNy?=
 =?iso-8859-1?Q?GeqWgNEogJ75dWR5zdZmlX7ZvMCbG7OI0cY6PvYgmBpqUJl4BcvedDDlPN?=
 =?iso-8859-1?Q?eWs46G2iJpLnvb1zl9h5o0Qo+Y+N2qlbnugZwfAirdJDx9FVCIMPDam4sr?=
 =?iso-8859-1?Q?PFOgc9CR89VjSBecNxpm3DELAdf7FcHw7foZnUmmngZiQCgb11UaGNUkBo?=
 =?iso-8859-1?Q?1yXnPeESUFQIgaFZMX1dsIipQdPxIzQAweavjPrG6Ws9xZm+IQ+HmGFwKC?=
 =?iso-8859-1?Q?qfZMjOAfHS03elVAJclEAVTmrcVOQVOZo2mKVlYMxZw9QgvNmpXxX+jrFq?=
 =?iso-8859-1?Q?TKB4xud2eF9VG2rvB1chaIps4tdelN+pxladM87iBrgiEZXRR8HDDkFSNO?=
 =?iso-8859-1?Q?ZrOcWJjH5BIeIeO8SUjlSoDP8ijBAez8Eujf7KbmW+qxrc9BPIs+FvKr0O?=
 =?iso-8859-1?Q?IEjuR6bJr7jm2FpcGwJZdoiK9Jm2xy9ODSYJ0p8omy43H4ZhgEKLdE8O4r?=
 =?iso-8859-1?Q?s2dSI57HZhtOyEaJlG13rSp4iBJVj5vDh/2lNGrELzS3KeKYGvCCGay6En?=
 =?iso-8859-1?Q?zxeuZJBr2fAUNcYnAE0HhShiH6S+0LQyhRamZ5ui3YcZcSB0QnQStX/Qcy?=
 =?iso-8859-1?Q?sslY4bRB4mFPQudCVvy7Ib83DQDQanVgsgQ5KMLivNpMxsFKlQtmTqvlle?=
 =?iso-8859-1?Q?Ox6n+1BvBqGsiG/fq6tow1pcVNWi0nK9OGChdgdRZm8BEsLY3ZEBIt7hnb?=
 =?iso-8859-1?Q?aZ48jYEof8JZEfo/EWyx2Hf19xt0dC7hgQMOdvL+HddQFuiiGBGZN68K61?=
 =?iso-8859-1?Q?RdiQm1ynmPLCeT9LV10v++C86yIOK5ypzHsrumORMtBiUKCOMoeA+prHA7?=
 =?iso-8859-1?Q?xGaizW4eY2JIRx4xjxWJmBNdWL1Z2TgPVVVh/MsdgtQUFqmdFrWOtS7eZr?=
 =?iso-8859-1?Q?QGUJQ37MZ6OKd42e15pHaB3b3fGyWL7I95Ag5Jptv39rPLWBGHsGV2shXw?=
 =?iso-8859-1?Q?5rm4UldzG9ibiuudsIExdmuFF0RRmfzcFQz5VM/Qtq92BiGVfcmdr6miAA?=
 =?iso-8859-1?Q?m/lnYRJ9CDKvP5HtpEyLWKGQtqceF11cp4sq+CVzrNknC1YieTRosVT0Lx?=
 =?iso-8859-1?Q?WVj9JMk1DgD13k5RD0ZBwrepBKTdEiclB3DVFPQsUT6cP8AX4iSlALdzbX?=
 =?iso-8859-1?Q?6QFBMOmPAR1+CXlvjdoAnfwXuTrVs8FQOsKjWCeq6oDa/bex67PT/PVksb?=
 =?iso-8859-1?Q?Jc08MWtGP+BeK6Frgh7YrDOrvzZnR08tQnNk5GiaRFcZAZOcmLQU0mWopH?=
 =?iso-8859-1?Q?vY4ogIKvmlCAiSUgKhXK4P7JGdBa4gyuvN5eob9pV0JmDNYPrf1B1WXLDT?=
 =?iso-8859-1?Q?lVDmW91/H4yt7pkyn7Jev9tk2tDT4nSnDqMhagLFKqpM3p6SZsTuukOVJD?=
 =?iso-8859-1?Q?hQBlJh82N3qJNnM8obtAY2+JFletcR7vXiUE4zrORRZzmjSbaNt/Coyl+9?=
 =?iso-8859-1?Q?H3wmmIIQzfZp2II2Y6yjoIGCjI4MayswuwXSGsPLsM0U/C?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	U/tIHWJfARUOj3rgnP7KOQTO4VdzSpY4hkePiSXicK0gSfI8uDJD8hlLiBjpKN7HBk2G9Xbu4iU5QUpnUJQBUxXfJfDDWK9GI3OKbavRXOpZzg1NGu9TtQ3NOkF9StI2vtRN3z4vh+frRtUplzslCEtLw+pza2aAqHBwdfb8j+RVpeR2ftIOf2lCr3IoF3MIffL7z1lwHkdwNn6G1AOLRJg51hqFNrIGiwzFyP2KY9LgYLkCayg2VvRbgaJxxI4mQvzP1buc1je8z1boesd8flC+Z6uz+nuU3Z9wzE/SzlArxC7mpJ1/C9W5+EUJXcnkZFONcn+85RcaU9wYkDHPQw==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b980d1e9-6f3b-4af2-57a2-08df26339b06
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 18:31:58.4195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0e3LZhwIpN1MVfCjiC+MA/eSeSaK2igU95TbtlhntPSdAgXSOnhGTG84Isat+qotIdKdPEsKMmkym0/Mek0VSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR20MB995515
X-MDID: 1791570721-KI2KPtjr2S2h
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;ut7;1791570721;KI2KPtjr2S2h;<arouhi@sitime.com>;ba04557de9d2da8490f5f1e6de07b967
X-PPE-TRUSTED: V=1;DIR=OUT;

From: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
=0A=
An output is driven by its PLL rather than selected by it, so its state=0A=
says whether it carries a signal: connected while it drives, disconnected=
=0A=
while it is muted.  Setting the state mutes or un-mutes it by forcing the=
=0A=
pad to Hi-Z, the only per-output control the device offers that leaves the=
=0A=
divider alone.=0A=
=0A=
The force bit and the state bit are separate, and a pad follows the loaded=
=0A=
configuration while the force bit is clear, so both are read to decide=0A=
whether an output is muted and both are written to change it.  Which of=0A=
the four register banks applies depends on the slot and on whether the pad=
=0A=
is single-ended or differential.=0A=
=0A=
A mute or un-mute is a per-output control, but each one that changes=0A=
something runs the device-wide programming sequence of the previous=0A=
patch, so a request for the state the output already has is answered=0A=
from the registers without entering it.  A request that fails after some=0A=
of its writes landed still announces the change, so a subscriber is not=0A=
left with the old state; the pin handle is read once, so a teardown=0A=
racing the request cannot hand the notification a cleared one.  A failed=0A=
entry into the programming state is left the way a commit leaves it:=0A=
loops re-locked and the settling time waited for.=0A=
=0A=
This is also where output pins start being registered at all: until now=0A=
the registration filter took inputs only, so the output operations the=0A=
earlier patches added -- direction and frequency -- had nothing to=0A=
dispatch on.=0A=
=0A=
Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
Assisted-by: LLM=0A=
Signed-off-by: Ali Rouhi <arouhi@sitime.com>=0A=
---=0A=
 drivers/dpll/sit9531x/core.c | 344 +++++++++++++++++++++++++++++------=0A=
 drivers/dpll/sit9531x/core.h |   7 +=0A=
 drivers/dpll/sit9531x/dpll.c | 130 +++++++++++++=0A=
 3 files changed, 427 insertions(+), 54 deletions(-)=0A=
=0A=
diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c=0A=
index ea15830b0efa..19aeabd3cd4f 100644=0A=
--- a/drivers/dpll/sit9531x/core.c=0A=
+++ b/drivers/dpll/sit9531x/core.c=0A=
@@ -488,71 +488,50 @@ static int sit9531x_output_forced_hiz(struct sit9531x=
_dev *sitdev,=0A=
 					muted);=0A=
 }=0A=
 =0A=
-/* Attempts to re-lock the output loops before reporting them open. */=0A=
-#define SIT9531X_LOOP_LOCK_TRIES	3=0A=
-=0A=
 /*=0A=
- * sit9531x_prg_abort - leave the programming state without committing=0A=
+ * sit9531x_output_state_refresh - read an output's mute state back=0A=
  *=0A=
- * Entering the state is two writes, and the second can fail with the debu=
g=0A=
- * block already unlocked and the part possibly already in PRG_CMD.  There=
=0A=
- * is nothing to commit in that case, but the loops still have to be close=
d=0A=
- * and the debug key put back, which is otherwise only done by=0A=
- * sit9531x_prg_commit().=0A=
+ * Used when a mute could not be confirmed at the time it was written.  Th=
e=0A=
+ * driver does not poll output state, so without this the cached value wou=
ld=0A=
+ * stand until something else happened to write it.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
  */=0A=
-static void sit9531x_prg_abort(struct sit9531x_dev *sitdev)=0A=
+int sit9531x_output_state_refresh(struct sit9531x_dev *sitdev, u8 out_idx)=
=0A=
 {=0A=
-	u8 attempt;=0A=
-	int rc =3D -EIO;=0A=
+	bool muted;=0A=
+	int rc;=0A=
 =0A=
-	for (attempt =3D 0; attempt < SIT9531X_LOOP_LOCK_TRIES; attempt++) {=0A=
-		rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_PRG_DIR_GEN,=0A=
-				       SIT9531X_LOOP_LOCK);=0A=
-		if (!rc)=0A=
-			break;=0A=
-		usleep_range(1000, 2000);=0A=
-	}=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	rc =3D sit9531x_output_forced_hiz(sitdev, out_idx, &muted);=0A=
 	if (rc)=0A=
-		dev_err(sitdev->dev,=0A=
-			"output loops left unlocked after a failed entry: %d\n",=0A=
-			rc);=0A=
+		return rc;=0A=
+=0A=
+	sitdev->out[out_idx].enabled =3D !muted;=0A=
+	sitdev->out[out_idx].state_stale =3D false;=0A=
 =0A=
-	sit9531x_write_u8(sitdev, SIT9531X_REG_OUTSYS_DEBUG,=0A=
-			  SIT9531X_DEBUG_LOCK_VAL);=0A=
+	return 0;=0A=
 }=0A=
 =0A=
-/*=0A=
- * Enter the output-system programming state: unlock the debug=0A=
- * registers on Page 3 and issue the PRG_CMD state command.  Register=0A=
- * writes that reconfigure the output system only take effect when=0A=
- * they are made inside this state.=0A=
- */=0A=
-static int sit9531x_prg_enter(struct sit9531x_dev *sitdev)=0A=
+static int sit9531x_hiz_set_bit(struct sit9531x_dev *sitdev,=0A=
+				unsigned int reg, u8 bit, bool set)=0A=
 {=0A=
+	u8 cur, new_val;=0A=
 	int rc;=0A=
 =0A=
-	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_OUTSYS_DEBUG,=0A=
-			       SIT9531X_DEBUG_UNLOCK_VAL);=0A=
+	rc =3D sit9531x_read_u8(sitdev, reg, &cur);=0A=
 	if (rc)=0A=
 		return rc;=0A=
 =0A=
-	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_PRG_DIR_GEN,=0A=
-			       SIT9531X_PRG_CMD_STATE);=0A=
-	if (rc) {=0A=
-		/*=0A=
-		 * The debug block is unlocked at this point, and a transfer=0A=
-		 * that reported an error may still have reached the part --=0A=
-		 * which would leave the device in PRG_CMD with its output=0A=
-		 * loops open.  Callers skip the commit when the entry=0A=
-		 * fails, so close both here.=0A=
-		 */=0A=
-		sit9531x_prg_abort(sitdev);=0A=
-		return rc;=0A=
-	}=0A=
+	new_val =3D set ? (cur | BIT(bit)) : (cur & ~BIT(bit));=0A=
 =0A=
-	return 0;=0A=
+	return sit9531x_write_u8(sitdev, reg, new_val);=0A=
 }=0A=
 =0A=
+/* Attempts to re-lock the output loops before reporting them open. */=0A=
+#define SIT9531X_LOOP_LOCK_TRIES	3=0A=
+=0A=
 /*=0A=
  * Commit a programming sequence started by sit9531x_prg_enter():=0A=
  * update the NVM shadow and re-lock the loops.  The sleep gives the=0A=
@@ -622,6 +601,251 @@ static int sit9531x_prg_commit(struct sit9531x_dev *s=
itdev)=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * Enter the output-system programming state: unlock the debug=0A=
+ * registers on Page 3 and issue the PRG_CMD state command.  Register=0A=
+ * writes that reconfigure the output system only take effect when=0A=
+ * they are made inside this state.=0A=
+ */=0A=
+static int sit9531x_prg_enter(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	int rc;=0A=
+=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_OUTSYS_DEBUG,=0A=
+			       SIT9531X_DEBUG_UNLOCK_VAL);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_PRG_DIR_GEN,=0A=
+			       SIT9531X_PRG_CMD_STATE);=0A=
+	if (rc) {=0A=
+		/*=0A=
+		 * The debug block is unlocked at this point, and a transfer=0A=
+		 * that reported an error may still have reached the part --=0A=
+		 * which would leave the device in PRG_CMD with its output=0A=
+		 * loops open.  Callers skip the commit when the entry fails,=0A=
+		 * so leave the state here the way every completed sequence=0A=
+		 * does: nothing was changed, so the update commits what the=0A=
+		 * part already holds, the loops are re-locked, and the=0A=
+		 * settling time is waited out before the caller drops the=0A=
+		 * lock and the next request programs the part.  The entry=0A=
+		 * failure is the error to report.=0A=
+		 */=0A=
+		sit9531x_prg_commit(sitdev);=0A=
+		return rc;=0A=
+	}=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_output_hiz_write - mute or unmute an output=0A=
+ *=0A=
+ * Muting takes control of the pin (MASK=3D1) and forces it to Hi-Z=0A=
+ * (STATE=3D0) on every Hi-Z pair of the slot -- differential, CMOS OutP=
=0A=
+ * and CMOS OutN -- because the output must go quiet whichever way it is=
=0A=
+ * wired; unmuting releases the override on all of them and hands the pin=
=0A=
+ * back to the device.  The caller must already be in the programming=0A=
+ * state.=0A=
+ */=0A=
+static int sit9531x_output_hiz_write(struct sit9531x_dev *sitdev, u8 slot,=
=0A=
+				     bool mute)=0A=
+{=0A=
+	struct sit9531x_hiz_pair p[SIT9531X_HIZ_PAIRS];=0A=
+	u8 mask[SIT9531X_HIZ_PAIRS], state[SIT9531X_HIZ_PAIRS];=0A=
+	int i, rc, undo_rc;=0A=
+=0A=
+	sit9531x_output_get_hiz_regs(slot, p);=0A=
+=0A=
+	if (!mute) {=0A=
+		for (i =3D 0; i < SIT9531X_HIZ_PAIRS; i++) {=0A=
+			rc =3D sit9531x_hiz_set_bit(sitdev, p[i].mask, p[i].bit,=0A=
+						  false);=0A=
+			if (rc)=0A=
+				return rc;=0A=
+		}=0A=
+		return 0;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * Remember every pair as it was: if the mute fails part-way, that=0A=
+	 * is what the pad goes back to -- which may already be a mute, from=0A=
+	 * an earlier request or from the loaded profile.=0A=
+	 */=0A=
+	for (i =3D 0; i < SIT9531X_HIZ_PAIRS; i++) {=0A=
+		rc =3D sit9531x_read_u8(sitdev, p[i].state, &state[i]);=0A=
+		if (rc)=0A=
+			return rc;=0A=
+		rc =3D sit9531x_read_u8(sitdev, p[i].mask, &mask[i]);=0A=
+		if (rc)=0A=
+			return rc;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * Forced value first, override enable second.  Muted is decoded as=0A=
+	 * MASK set with STATE clear, so enabling the override while STATE=0A=
+	 * still holds whatever the loaded configuration left there can pin=0A=
+	 * the pad driven for the width of an I2C transfer.=0A=
+	 */=0A=
+	for (i =3D 0; i < SIT9531X_HIZ_PAIRS; i++) {=0A=
+		rc =3D sit9531x_hiz_set_bit(sitdev, p[i].state, p[i].bit, false);=0A=
+		if (!rc)=0A=
+			rc =3D sit9531x_hiz_set_bit(sitdev, p[i].mask, p[i].bit,=0A=
+						  true);=0A=
+		if (rc)=0A=
+			break;=0A=
+	}=0A=
+	if (!rc)=0A=
+		return 0;=0A=
+=0A=
+	/*=0A=
+	 * Only part of the mute reached the device.  Put every pair it may=0A=
+	 * have touched back to the bits read above -- override first, then=0A=
+	 * value, the reverse of the order they went on -- so the pad ends=0A=
+	 * where the request started rather than on part of a mute, or=0A=
+	 * un-muted when it was muted before.=0A=
+	 */=0A=
+	for (; i >=3D 0; i--) {=0A=
+		u8 bit =3D BIT(p[i].bit);=0A=
+=0A=
+		undo_rc =3D sit9531x_hiz_set_bit(sitdev, p[i].mask, p[i].bit,=0A=
+					       mask[i] & bit);=0A=
+		if (!undo_rc)=0A=
+			undo_rc =3D sit9531x_hiz_set_bit(sitdev, p[i].state,=0A=
+						       p[i].bit,=0A=
+						       state[i] & bit);=0A=
+		if (undo_rc)=0A=
+			dev_err(sitdev->dev,=0A=
+				"slot%u: Hi-Z override left part applied (%d)\n",=0A=
+				slot, undo_rc);=0A=
+	}=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_output_disable - mute an output (force Hi-Z)=0A=
+ * @index:	logical output index (0..info->num_outputs-1)=0A=
+ *=0A=
+ * Sets MASK and clears STATE on every Hi-Z pair of the slot, differential=
=0A=
+ * and both CMOS pads, so that the output is muted regardless of its=0A=
+ * electrical configuration.  The=0A=
+ * writes are wrapped in the PRG_CMD / NVM update / loop lock sequence=0A=
+ * so the new state is applied by the hardware.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+int sit9531x_output_disable(struct sit9531x_dev *sitdev, u8 index)=0A=
+{=0A=
+	const struct sit9531x_chip_info *info =3D sitdev->info;=0A=
+	bool muted;=0A=
+	u8 slot;=0A=
+	int rc, ret, state_rc;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (index >=3D info->num_outputs)=0A=
+		return -EINVAL;=0A=
+=0A=
+	slot =3D info->clkout_map[index];=0A=
+	rc =3D sit9531x_prg_enter(sitdev);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	rc =3D sit9531x_output_hiz_write(sitdev, slot, true);=0A=
+=0A=
+	/*=0A=
+	 * Always leave the PRG_CMD programming state, even on a mid-sequence=0A=
+	 * write failure: prg_enter() unlocked the output loops, so returning=0A=
+	 * without prg_commit() would strand the chip in the programming state=0A=
+	 * with the loops unlocked.  Best effort -- keep the first error.=0A=
+	 */=0A=
+	ret =3D sit9531x_prg_commit(sitdev);=0A=
+	if (ret && !rc)=0A=
+		rc =3D ret;=0A=
+=0A=
+	/*=0A=
+	 * Keep the software state aligned to what hardware now drives even=0A=
+	 * when one write in the sequence failed. The commit above may have=0A=
+	 * applied a partial mask/state combination.=0A=
+	 */=0A=
+	state_rc =3D sit9531x_output_forced_hiz(sitdev, index, &muted);=0A=
+	if (!state_rc) {=0A=
+		sitdev->out[index].enabled =3D !muted;=0A=
+		sitdev->out[index].state_stale =3D false;=0A=
+	} else {=0A=
+		/*=0A=
+		 * The writes may well have landed; what failed is the proof.=0A=
+		 * Mark the cached state for a read-through rather than=0A=
+		 * reporting the value it had before this call.=0A=
+		 */=0A=
+		sitdev->out[index].state_stale =3D true;=0A=
+		if (!rc)=0A=
+			rc =3D state_rc;=0A=
+	}=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_output_enable - un-mute an output (active state)=0A=
+ * @index:	logical output index (0..info->num_outputs-1)=0A=
+ *=0A=
+ * Releases MASK on every Hi-Z pair so the device drives the output=0A=
+ * again as the loaded profile configures it.  The writes are wrapped=0A=
+ * in the PRG_CMD / NVM update / loop lock sequence so the new state is=0A=
+ * applied by the hardware.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+int sit9531x_output_enable(struct sit9531x_dev *sitdev, u8 index)=0A=
+{=0A=
+	const struct sit9531x_chip_info *info =3D sitdev->info;=0A=
+	bool muted;=0A=
+	u8 slot;=0A=
+	int rc, ret, state_rc;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (index >=3D info->num_outputs)=0A=
+		return -EINVAL;=0A=
+=0A=
+	slot =3D info->clkout_map[index];=0A=
+	rc =3D sit9531x_prg_enter(sitdev);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	rc =3D sit9531x_output_hiz_write(sitdev, slot, false);=0A=
+=0A=
+	/*=0A=
+	 * Always leave the PRG_CMD programming state, even on a mid-sequence=0A=
+	 * write failure: prg_enter() unlocked the output loops, so returning=0A=
+	 * without prg_commit() would strand the chip in the programming state=0A=
+	 * with the loops unlocked.  Best effort -- keep the first error.=0A=
+	 */=0A=
+	ret =3D sit9531x_prg_commit(sitdev);=0A=
+	if (ret && !rc)=0A=
+		rc =3D ret;=0A=
+=0A=
+	/* See sit9531x_output_disable(): commit can apply part of it. */=0A=
+	state_rc =3D sit9531x_output_forced_hiz(sitdev, index, &muted);=0A=
+	if (!state_rc) {=0A=
+		sitdev->out[index].enabled =3D !muted;=0A=
+		sitdev->out[index].state_stale =3D false;=0A=
+	} else {=0A=
+		/*=0A=
+		 * The writes may well have landed; what failed is the proof.=0A=
+		 * Mark the cached state for a read-through rather than=0A=
+		 * reporting the value it had before this call.=0A=
+		 */=0A=
+		sitdev->out[index].state_stale =3D true;=0A=
+		if (!rc)=0A=
+			rc =3D state_rc;=0A=
+	}=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
 /*=0A=
  * Input priority selection=0A=
  *=0A=
@@ -2512,6 +2736,8 @@ static int sit9531x_out_state_fetch(struct sit9531x_d=
ev *sitdev, u8 index)=0A=
 	if (rc)=0A=
 		return rc;=0A=
 =0A=
+	sitdev->out[index].state_stale =3D false;=0A=
+=0A=
 	/*=0A=
 	 * Each PLL page holds the PLL's output-enable mask, twelve bits:=0A=
 	 * bits 0-7 in OUT_MAP_LO and bits 8-11 in OUT_MAP_HI[3:0].  PLLA and=0A=
@@ -3313,7 +3539,7 @@ static void sit9531x_dpll_pin_unregister(struct sit95=
31x_dpll_pin *pin)=0A=
 	 * afterwards leaves a window where the field still reads as live=0A=
 	 * and the pin behind it is already gone.=0A=
 	 */=0A=
-	pin->dpll_pin =3D NULL;=0A=
+	WRITE_ONCE(pin->dpll_pin, NULL);=0A=
 =0A=
 	dpll_pin_unregister(sitdpll->dpll_dev, dpll_pin, ops, pin);=0A=
 	dpll_pin_put(dpll_pin, &pin->tracker);=0A=
@@ -3363,8 +3589,8 @@ static void sit9531x_dpll_pins_unregister(struct sit9=
531x_dpll *sitdpll)=0A=
  * @index:	pin hardware index=0A=
  *=0A=
  * For input pins: delegate to sit9531x_input_pin_is_registrable().=0A=
- * A pin class whose state callback the tree does not have yet is not=0A=
- * registrable: the core refuses a pin without one.=0A=
+ * For output pins: the pin is registrable if this DPLL is routed to it,=
=0A=
+ * whether or not it is currently driving.=0A=
  *=0A=
  * Return: true if pin should be registered, false otherwise=0A=
  */=0A=
@@ -3374,13 +3600,23 @@ static bool sit9531x_dpll_pin_is_registrable(struct=
 sit9531x_dpll *sitdpll,=0A=
 {=0A=
 	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
 =0A=
-	if (dir !=3D DPLL_PIN_DIRECTION_INPUT)=0A=
+	if (dir =3D=3D DPLL_PIN_DIRECTION_INPUT) {=0A=
+		if (index =3D=3D SIT9531X_MAX_INPUTS)=0A=
+			return true;=0A=
+		if (index =3D=3D SIT9531X_INTSYNC_PIN_ID)=0A=
+			return false;=0A=
+=0A=
+		return sit9531x_input_pin_is_registrable(sitdev, index);=0A=
+	}=0A=
+=0A=
+	if (index =3D=3D SIT9531X_INTSYNC_OUT_PIN_ID)=0A=
 		return false;=0A=
 =0A=
-	if (index =3D=3D SIT9531X_MAX_INPUTS)=0A=
-		return true;=0A=
+	if (index >=3D sitdev->info->num_outputs)=0A=
+		return false;=0A=
 =0A=
-	return sit9531x_input_pin_is_registrable(sitdev, index);=0A=
+	return sitdev->out[index].pll_idx =3D=3D sitdpll->id &&=0A=
+	       sitdev->out[index].routed;=0A=
 }=0A=
 =0A=
 /*=0A=
diff --git a/drivers/dpll/sit9531x/core.h b/drivers/dpll/sit9531x/core.h=0A=
index 006a7fee76ab..0554b9f28503 100644=0A=
--- a/drivers/dpll/sit9531x/core.h=0A=
+++ b/drivers/dpll/sit9531x/core.h=0A=
@@ -99,6 +99,8 @@ struct sit9531x_ref {=0A=
  * @cmos:		output is wired single-ended; the Hi-Z pairs that=0A=
  *			speak for it are the two CMOS pad ones, not the=0A=
  *			differential=0A=
+ * @state_stale:	the cached mute state could not be confirmed against=0A=
+ *			hardware and has to be read back before it is reported=0A=
  * @routed:		output is mapped to @pll_idx by the initial=0A=
  *			configuration; an unrouted output has no DPLL pin=0A=
  * @pll_idx:		PLL driving this output (0-3)=0A=
@@ -107,6 +109,7 @@ struct sit9531x_out {=0A=
 	u64		freq;=0A=
 	bool		enabled;=0A=
 	bool		cmos;=0A=
+	bool		state_stale;=0A=
 	bool		routed;=0A=
 	u8		pll_idx;=0A=
 };=0A=
@@ -266,6 +269,10 @@ int sit9531x_input_prio_add(struct sit9531x_dev *sitde=
v, u8 pll_idx,=0A=
 			    u8 input_idx);=0A=
 =0A=
 /* ---- Output enable/disable (Hi-Z control) ---- */=0A=
+int sit9531x_output_disable(struct sit9531x_dev *sitdev, u8 index);=0A=
+int sit9531x_output_enable(struct sit9531x_dev *sitdev, u8 index);=0A=
+int sit9531x_output_state_refresh(struct sit9531x_dev *sitdev,=0A=
+				  u8 out_idx);=0A=
 =0A=
 /* ---- Output frequency ---- */=0A=
 int sit9531x_output_freq_set(struct sit9531x_dev *sitdev, u8 out_idx,=0A=
diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c=0A=
index aa021b374c45..fa650cc3177d 100644=0A=
--- a/drivers/dpll/sit9531x/dpll.c=0A=
+++ b/drivers/dpll/sit9531x/dpll.c=0A=
@@ -831,10 +831,140 @@ sit9531x_dpll_output_pin_frequency_set(const struct =
dpll_pin *pin,=0A=
 	return rc;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * sit9531x_dpll_output_pin_state_on_dpll_get - get output pin state=0A=
+ *=0A=
+ * reports CONNECTED when the output is driven and=0A=
+ * DISCONNECTED when it has been muted via sit9531x_output_disable().=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_output_pin_state_on_dpll_get(const struct dpll_pin *pin,=0A=
+					   void *pin_priv,=0A=
+					   const struct dpll_device *dpll,=0A=
+					   void *dpll_priv,=0A=
+					   enum dpll_pin_state *state,=0A=
+					   struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll_pin *dpin =3D pin_priv;=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	const struct sit9531x_out *out;=0A=
+	int rc;=0A=
+=0A=
+	/*=0A=
+	 * A mute whose read-back failed left the cache unconfirmed; there is=0A=
+	 * no poll of output state to correct it, so read it here rather than=0A=
+	 * report a value that may predate the request.=0A=
+	 */=0A=
+	if (sitdev->out[dpin->id].state_stale) {=0A=
+		mutex_lock(&sitdev->multiop_lock);=0A=
+		rc =3D sit9531x_output_state_refresh(sitdev, dpin->id);=0A=
+		mutex_unlock(&sitdev->multiop_lock);=0A=
+		if (rc) {=0A=
+			NL_SET_ERR_MSG(extack,=0A=
+				       "Output mute state could not be read back");=0A=
+			return rc;=0A=
+		}=0A=
+	}=0A=
+=0A=
+	out =3D sit9531x_out_state_get(sitdev, dpin->id);=0A=
+	*state =3D out->enabled ? DPLL_PIN_STATE_CONNECTED=0A=
+			      : DPLL_PIN_STATE_DISCONNECTED;=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_dpll_output_pin_state_on_dpll_set - mute/un-mute an output=0A=
+ *=0A=
+ * Forces Hi-Z on the output through the Hi-Z force/state register pairs=
=0A=
+ * of its slot, the differential and the single-ended one.=0A=
+ *   CONNECTED    -> enable (release the override, the device drives it)=
=0A=
+ *   DISCONNECTED -> disable (force Hi-Z)=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_output_pin_state_on_dpll_set(const struct dpll_pin *pin,=0A=
+					   void *pin_priv,=0A=
+					   const struct dpll_device *dpll,=0A=
+					   void *dpll_priv,=0A=
+					   enum dpll_pin_state state,=0A=
+					   struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll_pin *dpin =3D pin_priv;=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	bool enable =3D state =3D=3D DPLL_PIN_STATE_CONNECTED;=0A=
+	bool was_enabled, changed;=0A=
+	int rc;=0A=
+=0A=
+	if (!enable && state !=3D DPLL_PIN_STATE_DISCONNECTED)=0A=
+		return -EINVAL;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+=0A=
+	/*=0A=
+	 * The core forwards a request for the state the output is already=0A=
+	 * in.  The Hi-Z pairs say what the pad does now, so read them and=0A=
+	 * answer such a request from them rather than run the programming=0A=
+	 * sequence, which holds the output loops unlocked for the 100 ms its=0A=
+	 * commit takes and would change nothing.  A read that fails leaves=0A=
+	 * the request to the sequence and its own read-back.=0A=
+	 */=0A=
+	if (!sit9531x_output_state_refresh(sitdev, dpin->id) &&=0A=
+	    sitdev->out[dpin->id].enabled =3D=3D enable) {=0A=
+		mutex_unlock(&sitdev->multiop_lock);=0A=
+		return 0;=0A=
+	}=0A=
+=0A=
+	was_enabled =3D sitdev->out[dpin->id].enabled;=0A=
+=0A=
+	if (enable)=0A=
+		rc =3D sit9531x_output_enable(sitdev, dpin->id);=0A=
+	else=0A=
+		rc =3D sit9531x_output_disable(sitdev, dpin->id);=0A=
+=0A=
+	/*=0A=
+	 * A read-back that failed left the cache unconfirmed, and the=0A=
+	 * writes before it most likely landed: count that as a change too,=0A=
+	 * and let the getter's read-through fill in the state when the=0A=
+	 * notification is built.=0A=
+	 */=0A=
+	changed =3D sitdev->out[dpin->id].enabled !=3D was_enabled ||=0A=
+		  sitdev->out[dpin->id].state_stale;=0A=
+=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	if (rc) {=0A=
+		struct dpll_pin *dpll_pin;=0A=
+=0A=
+		NL_SET_ERR_MSG(extack, "Failed to set output pin state");=0A=
+		/*=0A=
+		 * The core notifies only a request that succeeded, and the=0A=
+		 * poll does not watch outputs.  A failed request whose=0A=
+		 * read-back shows the output did change, or could not show=0A=
+		 * whether it did, still has to be announced, or subscribers=0A=
+		 * keep the old state for good.  The core's lock is held here,=0A=
+		 * as the helper requires.=0A=
+		 *=0A=
+		 * Teardown clears the pin's handle without that lock before=0A=
+		 * it unregisters the pin, and this callback spends the=0A=
+		 * sequence's 100 ms under it.  Read the handle once: NULL is=0A=
+		 * a pin on its way out, with nobody left to tell, and a=0A=
+		 * handle still set stays valid until this callback returns.=0A=
+		 */=0A=
+		dpll_pin =3D READ_ONCE(dpin->dpll_pin);=0A=
+		if (changed && dpll_pin)=0A=
+			__dpll_pin_change_ntf(dpll_pin);=0A=
+	}=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
 static const struct dpll_pin_ops sit9531x_dpll_output_pin_ops =3D {=0A=
 	.direction_get		=3D sit9531x_dpll_output_pin_direction_get,=0A=
 	.frequency_get		=3D sit9531x_dpll_output_pin_frequency_get,=0A=
 	.frequency_set		=3D sit9531x_dpll_output_pin_frequency_set,=0A=
+	.state_on_dpll_get	=3D sit9531x_dpll_output_pin_state_on_dpll_get,=0A=
+	.state_on_dpll_set	=3D sit9531x_dpll_output_pin_state_on_dpll_set,=0A=
 };=0A=
 =0A=
 const struct dpll_pin_ops *=0A=
-- =0A=
2.39.2 (Apple Git-143)=0A=
=0A=
