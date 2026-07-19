Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010007.outbound.protection.outlook.com [52.101.46.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E8238E8CA
	for <netdev@vger.kernel.org>; Sun, 19 Jul 2026 14:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784470084; cv=fail; b=sko5TWdlhVzjmha1ZcWsAGbjMyfvGwFYniakoRxk7uFeOtK0tbdbAouh0m6evoPSkxBzx0vgKlrvYxIOV4kRSdc4KXjmwZqcQ1T+rjZ/fj9i52z9c5L5mg1rJfncXq1IcKrE8N3Li1PkIJW1H5QO0hqSisuWXV7wlZo9q3SHjZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784470084; c=relaxed/simple;
	bh=a8bZga96sVjjDGYuU+0TSg7W+et8wVqCaISXIMzdJys=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dK/wht8KuHXTuvvPOiST+SuQlQ5Qb/D6FSkQ0O5HNf/AJLCTaSldd+VZL87fnB1p78uTUVJlWVzasBuscmMM8NHhWDQsnA3KxIS1RquItiVy8UM1FVOwpIPVCT3ACIlrrBl9H076Mj7uxncCW3f2zJX0QlkOtMxhE0ZubGxkjic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VU4A4iV9; arc=fail smtp.client-ip=52.101.46.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VU4A4iV9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qWrYyMuYa5EE3NWioy4y2DOSt4z7vjiBa82OAqhI9mfoo1pnrkqMTpcDctP9qmyVotR+1GeXC5kTjZ+StQC1rf+L/4ZkNtbl5Bg5NaHJPy1lmW7Qo/R0LJXaUYgIdgS4O2krjpVp68Z2k8zGi0GwVGaqQ5Ua6hYxYNcEXMr/7MCMddhcXqlbTVQcS6j46ddpjv/Uze8P0f3FWXFEqfTjIx1PygY1+HX6+3r2gr933GMJuCaf+hl1U8R6v50DIri3C93IVCDDl/7brDceZXKGGQBewHbLTyiwlhgSNKTwCsr3KXqIx8jSX1rpZNPMmY8rBfKLlN+Dp1c/GyLBT6zlLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a8bZga96sVjjDGYuU+0TSg7W+et8wVqCaISXIMzdJys=;
 b=S0s2yHIChqv9ezTn0HiO+FeUmzLjCEwKxXkWhzuPA5BaT7KaUVT5gIL6txhkoW3AU+EJ8SYHdmwqapSfx7s5YSOc9GBseyITiJrobTx3SI35J6lI+tfrwL6kAGYQprNuqGlMs5v3kQ0L6a3jGa8bMLLey+YgDbUMnemAvF2AjqXeOzCwgBpdHZisFUkw9nxZWP+Yisu3xAnqyaWPqQywXufbEGu4xLzVJnV6gLSR6TbS1p3OKsG+a8W/Wvi5WPuIXAat/gJAJAiURScWmpW0UgM/t3OU3DT2zEkhXQzEXLqDyEWsLgekh+pobPsOg4QwI1tXObgRb6lBJZecI9cNxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a8bZga96sVjjDGYuU+0TSg7W+et8wVqCaISXIMzdJys=;
 b=VU4A4iV9750/+YfpAr3Pvt34d6vTD/l3/zHuf9XlhtaG4okB7ELT72DUAf17sxZlOIipN+U2R6AXKmZ6dTJZyuK6nSW8B7gCo4B88J6EnrXznJqCGhWhYKk9aHkASZw+dDq6GdzR2m2inVHPTM0fimQ7ijUWDQrZUAEaYV0z4LZh/g8qo5t3e2miurDYNxKOVj7Z+vRLSOJJkBIG+tsCevBgv0hEvicuf7eL535q5oVOVlmH6K9JFjQ/9Gdvv5QBV7yrrE/F54AwepkPEx+MWUC2XidHImxEriDbe8VLoyPUupD0dKDdjvWmQ2++9Qmzx0nL7p6aHG2ZwIRfimA/oQ==
Received: from SJ2PR12MB9008.namprd12.prod.outlook.com (2603:10b6:a03:543::19)
 by CH3PR12MB8330.namprd12.prod.outlook.com (2603:10b6:610:12c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Sun, 19 Jul
 2026 14:07:59 +0000
Received: from SJ2PR12MB9008.namprd12.prod.outlook.com
 ([fe80::e25c:9cce:637a:3dfd]) by SJ2PR12MB9008.namprd12.prod.outlook.com
 ([fe80::e25c:9cce:637a:3dfd%3]) with mapi id 15.21.0223.011; Sun, 19 Jul 2026
 14:07:59 +0000
From: Danielle Ratson <danieller@nvidia.com>
To: Aleksander Jan Bajkowski <olek2@wp.pl>, "mkubecek@suse.cz"
	<mkubecek@suse.cz>, "andrew@lunn.ch" <andrew@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"jbe@pengutronix.de" <jbe@pengutronix.de>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [PATCH ethtool-next v3 2/3] sfpid: print all compliance codes
Thread-Topic: [PATCH ethtool-next v3 2/3] sfpid: print all compliance codes
Thread-Index: AQHdF128cMjnIq+r3UqBKF9uIxaoAbZ04Sow
Date: Sun, 19 Jul 2026 14:07:59 +0000
Message-ID:
 <SJ2PR12MB90088B66B0D642CA6C789C5DD8C42@SJ2PR12MB9008.namprd12.prod.outlook.com>
References: <20260719090458.659332-1-olek2@wp.pl>
 <20260719090458.659332-2-olek2@wp.pl>
In-Reply-To: <20260719090458.659332-2-olek2@wp.pl>
Accept-Language: en-US, he-IL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR12MB9008:EE_|CH3PR12MB8330:EE_
x-ms-office365-filtering-correlation-id: d94a79e8-29ea-4ade-177d-08dee59f23e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|3023799007|6133799003|11063799006|10067099003|4143699003|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 8T9bGt2rz+BZ5Iq8Zn5C7p7VcFyhg8iWeFILAe6UgdNyPSd54DcEaGbLxMROu3bNEXM5IMt/3ttg1UNJhhfiBrALQ2h51I4lv5ZiMp1EWeyK8oAD1r7zfao8Wu3y8N1394v82IVi55svbtrdqDwAvIdt5Wu+1nnGyul656PLOA/iGhpd3N9b8P3KzYUuNWa1t0bJGzUNoTKBIvQ4nJrvPFk//jYQ8HC6sKyi2gOAyeNN+xaingnA2dNGSPvyOwvjyIaGhPy9ZlDR4LHku2mZnhqW9Yi1uDtjtg52MkPk692b2tSGiCykf9mm/PaZJl70PmOoLA0pzciGuSfLe7Y3DhTaZfrxaQPb2/JPYji5oBJ6SZSGEXxiM2LANVyNyCzItiYhrxy2qwZCViNPS7u/2QK5QeSv8u2lzQBVo5M8ct/w3FdqPqshJ8Cgx6b142koJx8254KtnU5HscKX5xIARsIteehU3MQ0NhIiCGqtcN78VlBkNFZHx4a1ILeN/FSdsisNmpsxYbJH0cdb8F3mqjOJqbaWmCVIkvSa9HEgG5xFkgka37UWFTBPlFkTDAsHxzcKu132NEaseTcKrENmFqn7Z1gj/n4CvN7xBVFrJpmCQ/NfXPrz1Y1y4JWc7Huu2z+trheXOwunuYaNReTf1nwfpX0JMtPHozOVXXK5y//HrDL6kldxGbTwCHY4E2u3ilxu41GYRB8u5R1dQ6IRYUcA+9tKUegxDPBiOJt2ZIs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9008.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(3023799007)(6133799003)(11063799006)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aXY2byttTnc5Q0k3UUJZSHN3UDJQaGhrK2VXcS9sWGJTT0k0dmRiOG0zUCtN?=
 =?utf-8?B?YkhLV3hPNW1iSUl0ckFDTXpwL0N6ZndqRXNYS1c1WlVMbXFlanhHVWMyUlZW?=
 =?utf-8?B?VDJqSjRtUEx6S2lJWk0zVzdWZUEzTVE4M2dkSVJYYUhUTGQrNXpoTkVsNFp2?=
 =?utf-8?B?bHhzQ3lySS9nN09ScDcvQ09tTTlyMmRrNEtub1lRUDhpQmxJVHEyNzY0NFVm?=
 =?utf-8?B?bFlxQU5LbkxUMkNtS2prM1BCQnpvbVZnZnlEMUVnVmN4TWQyNjlhYW9ybzEy?=
 =?utf-8?B?aHR0ZkxvODNmRFRzVzJUVXlWWnVJRnNSTEp6NVpzNmM0MkwwSDZoOTY5Uk5i?=
 =?utf-8?B?QzJZV2RPTXNhcFhOQVY0djdFbjhUODc3dlh4Q2hqWGlZUHp5bkcxOFZDOHo4?=
 =?utf-8?B?VFludlNOdjNISEl5ajZDUm9qOElGazBqRU1Nc0VYV0FvTHNtZDV3d0FsZmJI?=
 =?utf-8?B?MFhsTDluZXhReWVWZ0dyeDBwNVRNTzVWYVdwK1FKNFlpQlhZVGxGajVXeGE2?=
 =?utf-8?B?aWtLZzB3VjBNdVUwc2l2MjJyWnJZYTZUd096NzVIQklGbUZUWW9zWW9vUllX?=
 =?utf-8?B?UXptTTBXSXFEY2twemNQQ0ZmYzlNa2V6OE05Y1NMUEtMeERpYm1qZ1pOTGps?=
 =?utf-8?B?S0NxSVdUUUxLaGRRM2VIR2xHSUZ6Sm5sS0lJTE1OaGhOR0s3a3dscjBBeVVD?=
 =?utf-8?B?alFmMCtYOEovVkF6S0FhT1NpOFh5MVd1Vjc2ZHV5dDhBNE1hM1FDZTdiT1Vo?=
 =?utf-8?B?d0t6L0VRNHlCeW9WalE0bXQyNENYTTFCSjZFeXJHaDFDSFpudnVJS3VvaVYy?=
 =?utf-8?B?VnJPQlNWVTVhcTN3R0pQeGx1cERJUU16RnF3Rk81cStIc3dubzVya2pveDdp?=
 =?utf-8?B?M1UyLzFCaEwyQmZkVVNBYzRjVms4SGxoNVRDVXhSQytOSmRWV1MySWhIcVQy?=
 =?utf-8?B?MjZSQzN4dlpFWldQVGNlUVFwdzVIWWF0Vkcydk56ZE5oZVZLTmR3c3VzUW05?=
 =?utf-8?B?andpeGE4UUhwNkloOFRHSXluOHNOMVZLZWo2RHhCQnFJSFM2bjQwMlEwaTlR?=
 =?utf-8?B?cHExZHJtMFRSNzlLUk9BNlBJb0JsTzVHVzlYZFkzN2dkUlNXK2FXRXlxUmk2?=
 =?utf-8?B?ODNoSFY4b3owWjUyS3pvS2V4ZFJ1T21YNjdVUTdMTHA3bWFiUlplNk9UeklJ?=
 =?utf-8?B?YTZHQ1VjbllXU1JtK1Awbzk1RlUrSDVUQ1F1UGF2RFBGdy9rQk5LcFhQL2c4?=
 =?utf-8?B?Zk5xRGcxK0JiUFlXa3dHdE82VW9wYkJBaVEyMUFRdlZVeU0zZ21mVXFyWnRH?=
 =?utf-8?B?cWwrVHVCSUF1VFF6YlhOejB4YzBkdmw5RjUvMjRMTG1ROUpGUGVPWDVwZ2J1?=
 =?utf-8?B?VjhqckgvRHdKM2lJTHlCTGoyUFZPTlowSm9HcStjYWpLZVU3aFlmbTM5Zkhs?=
 =?utf-8?B?SGo1Z3NZUEpiMmw5WkF2OGhKSDVaUkFQN3prZVN6WGJKZTdrMWx6L3lDUVZT?=
 =?utf-8?B?SGZHZDZ5eFE3bHVWcGVTSVpTbVFQRTcycERqYlVJRXRQcWZFdjl5K3hWeTdH?=
 =?utf-8?B?QlJML2dmenhxbzhpYU1RYWFPRDkxVnQ4cVZIQjZHYisraWZxMHJkcVE0Z0Ji?=
 =?utf-8?B?d2ZoeEhkcXdkNnc1QWZaeWgvUHE0UHM2T3J0aGwyYmVEK1duMFJMRXZWd0NH?=
 =?utf-8?B?QVgvRGZHTVRWR1pCb3IrbzJLdXY5N045ZWhrMHRIZitLZkV3UTZJbTBQM241?=
 =?utf-8?B?WkpNbDJLTERrWmtlQmJSVTdNRUx3UG1aZUJhSjd3Mi9qMFRKUWIyeVl4Tk85?=
 =?utf-8?B?cVNPdXd6dVBVaTZYMG5RL2lOZ3d5OEZBTkhrTnF5a3Bvb2pKTFhwWFZPazdu?=
 =?utf-8?B?SGtDcmM4TVlCeHA1UGRXejlXeWQ0eW5FZnpsOWRlblJBU0hMTGVRWmhKdTcz?=
 =?utf-8?B?aithb1JQSm14Yk5HOFNuQjdUNzNjL1k4VUpud2FTS3oyY0M1cjJ1Mnp0L2sr?=
 =?utf-8?B?ZzdBMG5ISktHYjVrazI2dmdJWUgzU2pneVNOaUhURjZlSkNvQ09xN09DNU1K?=
 =?utf-8?B?MjZ2Z1lIK0VlRVBQVUx5K3I1c0RIVzdIbllwaTgyTlg5WFFXTVZnb1ZnZUl1?=
 =?utf-8?B?UGhUb0NYbHhjeVU0ZzlHeG9yUjFFdktTbHFVcHlKbmdhUTUrWlptVytRSlRN?=
 =?utf-8?B?QWNLZlJyVzU0N3BSTkcyTldxcElRWE5GV0NQN0l1R2hJOERNZDlsMWcwcHEw?=
 =?utf-8?B?MStNSnNHdTFCa0xaK29WZWhXeFVONWFhUHM5UTYxeHExcGlLL2VkSTBrYWRo?=
 =?utf-8?Q?ep7MzYhk9JFSxTikz3?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9008.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d94a79e8-29ea-4ade-177d-08dee59f23e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2026 14:07:59.8013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IMk1OJhmaYny41IALKa3phRfi5B5HzmvXQbWmU/Gc8fCeuO8zEd/7xzHa61A5+ylvvy4yzAmZZH0VRCP03UeiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8330

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbGVrc2FuZGVyIEphbiBCYWpr
b3dza2kgPG9sZWsyQHdwLnBsPg0KPiBTZW50OiBTdW5kYXksIDE5IEp1bHkgMjAyNiAxMjowMQ0K
PiBUbzogRGFuaWVsbGUgUmF0c29uIDxkYW5pZWxsZXJAbnZpZGlhLmNvbT47IG9sZWsyQHdwLnBs
Ow0KPiBta3ViZWNla0BzdXNlLmN6OyBhbmRyZXdAbHVubi5jaDsgZGF2ZW1AZGF2ZW1sb2Z0Lm5l
dDsNCj4gZWR1bWF6ZXRAZ29vZ2xlLmNvbTsga3ViYUBrZXJuZWwub3JnOyBwYWJlbmlAcmVkaGF0
LmNvbTsNCj4gamJlQHBlbmd1dHJvbml4LmRlOyBuZXRkZXZAdmdlci5rZXJuZWwub3JnDQo+IFN1
YmplY3Q6IFtQQVRDSCBldGh0b29sLW5leHQgdjMgMi8zXSBzZnBpZDogcHJpbnQgYWxsIGNvbXBs
aWFuY2UgY29kZXMNCj4gDQo+IFNGUCBtb2R1bGVzIGltcGxlbWVudCBtdWx0aXBsZSBjb21wbGlh
bmNlIGNvZGVzLiBUaGlzIGlzIGNvbW1vbiBmb3IgZHVhbC0NCj4gcmF0ZSBtb2R1bGVzLiBCZWZv
cmUgdGhlIGBqc29uYCBvcHRpb24gd2FzIGludHJvZHVjZWQsIGFsbCBjb21wbGlhbmNlIGNvZGVz
DQo+IHdlcmUgZGlzcGxheWVkLiBDdXJyZW50bHksIG9ubHkgdGhlIGxhc3QgY29kZSBpcyBkaXNw
bGF5ZWQuIFRoaXMgY29tbWl0IGZpeGVzDQo+IHRoYXQgYnVnLiBDb21wbGlhbmNlIGNvZGVzIGFy
ZSByZXByZXNlbnRlZCBhcyBhcnJheS4NCj4gDQo+IEJlZm9yZToNCj4gJCBldGh0b29sIC1tIHNm
cC13YW4NCj4gLi4uDQo+IAlUcmFuc2NlaXZlciBjb2RlcyAgICAgICAgICAgICAgICAgICAgICAg
ICA6IDB4MDAgMHgwMCAweDAwIDB4MDEgMHgyMCAweDQwIDB4MGMNCj4gMHgxNSAweDAwDQo+IAlU
cmFuc2NlaXZlciB0eXBlICAgICAgICAgICAgICAgICAgICAgICAgICA6IEZDOiAxMDAgTUJ5dGVz
L3NlYw0KPiAuLi4NCj4gJCBldGh0b29sIC0tanNvbiAtbSBzZnAtd2FuDQo+IFsgew0KPiAuLi4N
Cj4gICAgICAgICAidHJhbnNjZWl2ZXJfY29kZXMiOiBbIDAsMCwwLDEsMzIsNjQsMTIsMjEsMCBd
LA0KPiAgICAgICAgICJ0cmFuc2NlaXZlcl90eXBlIjogIkZDOiAxMDAgTUJ5dGVzL3NlYyIsIC4u
Lg0KPiAgICAgfSBdDQo+IA0KPiBBZnRlcjoNCj4gJCBldGh0b29sIC1tIHNmcC13YW4NCj4gLi4u
DQo+IAlUcmFuc2NlaXZlciBjb2RlcyAgICAgICAgICAgICAgICAgICAgICAgICA6IDB4MDAgMHgw
MCAweDAwIDB4MDEgMHgyMCAweDQwIDB4MGMNCj4gMHgxNSAweDAwDQo+IAlUcmFuc2NlaXZlciB0
eXBlICAgICAgICAgICAgICAgICAgICAgICAgICA6IEV0aGVybmV0OiAxMDAwQkFTRS1TWA0KPiAJ
VHJhbnNjZWl2ZXIgdHlwZSAgICAgICAgICAgICAgICAgICAgICAgICAgOiBGQzogaW50ZXJtZWRp
YXRlIGRpc3RhbmNlIChJKQ0KPiAJVHJhbnNjZWl2ZXIgdHlwZSAgICAgICAgICAgICAgICAgICAg
ICAgICAgOiBGQzogU2hvcnR3YXZlIGxhc2VyIHcvbyBPRkMgKFNOKQ0KPiAJVHJhbnNjZWl2ZXIg
dHlwZSAgICAgICAgICAgICAgICAgICAgICAgICAgOiBGQzogTXVsdGltb2RlLCA2Mi41dW0gKE02
KQ0KPiAJVHJhbnNjZWl2ZXIgdHlwZSAgICAgICAgICAgICAgICAgICAgICAgICAgOiBGQzogTXVs
dGltb2RlLCA1MHVtIChNNSkNCj4gCVRyYW5zY2VpdmVyIHR5cGUgICAgICAgICAgICAgICAgICAg
ICAgICAgIDogRkM6IDQwMCBNQnl0ZXMvc2VjDQo+IAlUcmFuc2NlaXZlciB0eXBlICAgICAgICAg
ICAgICAgICAgICAgICAgICA6IEZDOiAyMDAgTUJ5dGVzL3NlYw0KPiAJVHJhbnNjZWl2ZXIgdHlw
ZSAgICAgICAgICAgICAgICAgICAgICAgICAgOiBGQzogMTAwIE1CeXRlcy9zZWMNCj4gLi4uDQo+
ICQgZXRodG9vbCAtLWpzb24gLW0gc2ZwLXdhbg0KPiBbIHsNCj4gLi4uDQo+ICAgICAgICAgInRy
YW5zY2VpdmVyX2NvZGVzIjogWyAwLDAsMCwxLDMyLDY0LDEyLDIxLDAgXSwNCj4gICAgICAgICAi
dHJhbnNjZWl2ZXJfdHlwZSI6IFsgIkV0aGVybmV0OiAxMDAwQkFTRS1TWCIsIkZDOiBpbnRlcm1l
ZGlhdGUgZGlzdGFuY2UNCj4gKEkpIiwiRkM6IFNob3J0d2F2ZSBsYXNlciB3L28gT0ZDIChTTiki
LCJGQzogTXVsdGltb2RlLCA2Mi41dW0gKE02KSIsIkZDOg0KPiBNdWx0aW1vZGUsIDUwdW0gKE01
KSIsIkZDOiA0MDAgTUJ5dGVzL3NlYyIsIkZDOiAyMDAgTUJ5dGVzL3NlYyIsIkZDOg0KPiAxMDAg
TUJ5dGVzL3NlYyIgXSwgLi4uDQo+ICAgICB9IF0NCj4gDQo+IEZpeGVzOiA0MDcxODYyZjU4ZDgg
KCJzZnBpZDogQWRkIEpTT04gb3V0cHV0IGhhbmRsaW5nIHRvIC0tbW9kdWxlLWluZm8gaW4NCj4g
U0ZGODA3OSBtb2R1bGVzIikNCj4gU2lnbmVkLW9mZi1ieTogQWxla3NhbmRlciBKYW4gQmFqa293
c2tpIDxvbGVrMkB3cC5wbD4NCj4gLS0tDQo+IENoYW5nZXMgaW4gdjM6DQo+ICAtIGZpeCBpbmRl
bnRhdGlvbiBhbmQgY2hlY2twYXRjaCB3YXJuaW5ncyBDaGFuZ2VzIGluIHYyOg0KPiAgLSBkcm9w
IDwvcHJlPiBsZWZ0b3Zlcg0KPiAgLSB1c2Ugc2luZ2xlIHNmcCBtb2R1bGUgaW4gQmVmb3JlL0Fm
dGVyDQo+ICAtIHJlbmFtZSBtb2R1bGVfcHJpbnRfYXJyYXlfc3RyaW5nKCkgLT4NCj4gbW9kdWxl
X3ByaW50X2FueV9hcnJheV9zdHJpbmdfZW50cnkoKQ0KPiAtLS0NCg0KUmV2aWV3ZWQtYnk6IERh
bmllbGxlIFJhdHNvbiA8ZGFuaWVsbGVyQG52aWRpYS5jb20+DQo=
