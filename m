Received: from smtp.fortinet.com (smtp.fortinet.com [208.91.113.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9093C3C10A6
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 19:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.91.113.81
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787684901; cv=fail; b=RGQqpqzN8B3+jAxJbrlsCnVl1eyl90G7wIQIW9/DKhksrlol/wbcb+mg8u3RCi9Lr40QZR625rGwGE/hUkYo3eGUSxncZpGfPpTFdsZ6be8iGLQEUiBMDsSV4b6qR5d17T7nWh/4GYA+UQcw8L5gW4/c0nSccRLuqI0VoPtiB2k=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787684901; c=relaxed/simple;
	bh=BjG1mIkS1TlqEnwbOnPmfTGMnrt7Cs8YFkEtgkLMGpk=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m/1+uf/pOJ8Imv1p3+sTdOkNhz6bpyohTbxLjrDFR5OFNp7EcWGQAmhGeaNzrhtSvj1lGaJnY9pczMKxwZT5J8Dsmjv78UqdvmUl3myY8huGB8dalUkznImOKBg13m2vRFB3DUJrdix2qHXDVqRcqka84eDHW58QdjSQnYk+fh0=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fortinet.com; spf=pass smtp.mailfrom=fortinet.com; dkim=pass (2048-bit key) header.d=fortinet.com header.i=@fortinet.com header.b=G7yttlJh; dkim=fail (1024-bit key) header.d=fortinet.com header.i=@fortinet.com header.b=irWsYcJb reason="signature verification failed"; arc=fail smtp.client-ip=208.91.113.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fortinet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fortinet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fortinet.com header.i=@fortinet.com header.b="G7yttlJh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fortinet.com header.i=@fortinet.com header.b="irWsYcJb"
ARC-Seal: i=2; a=rsa-sha256; t=1787684896; cv=pass; d=fortinet.com; s=dkim;
 b=iGg6s6cULGKgcTLoKT8sTsV/nR+E1cxySOJkFQnGGAimqSavhiViLGNC9Pwh448n11wWNyZL90bM
	Olrc6FUwVpjV0eQUClweyVuesNk+zP8FdPSemS7CZhRIMAvHAgND4HLl01zMWZdJq/Gmr8c9949m
	YObMMResjzs+pNPx+4pjR8NGUK9h3TjS0st5wA0vFs9Z2eNoOhaomYV2L9eXEVAu4cE2athik3zL
	7uIxmnAMfjZTkF8cbDep9XZbO5BsUxnbEzQmLfcJ2sO2GtFHv1h9z8qxL5Pe0eRwaRzX/ma2pXh3
	WHl09BCp23ahH27FR0+SFIAR7w+3kwi0rnr+3A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=fortinet.com; s=dkim; c=relaxed/relaxed;
 h=from:to:subject:date:message-id:references:content-type:mime-version:dkim-signature;
 bh=nwn3cwhrDd8yms6ibI84f0rMsS875LHUe2Dtq24LzFI=;
 b=jSPbUKYyd/7S0LUM4ILQvkfRN40bUtCXo5ieN6Mq1FslMhiD6JDPZfKLylAdxTG3Ok7rNPIL+LdL
	jv2D7Q8Z+oA/gtJv6gO5cNHAVlcb7wVFdYuqNXwhgearASpUuHIbb3Ic7l+ZTMCbgvtNdGmZMHrp
	SvcqzlLsn0HDdZr5Bz8lVo9V4S1mnHG0k6K4j3ISo/wtagHAmnXbBJODQfcRa4HYdGjClifPwAYy
	jQG4WcqzpEAfA7P79hs3oJubToEDY8ey3CS3SbrrSfWJ/ZlabA41rljq0gh46gaI86l4O10cFQZ+
	1QiAaYIy2GGckWiuiKcTS191xh3P5d2zTpD3jw==
ARC-Authentication-Results: i=2; smtp.fortinet.com;
	dkim=pass header.i=@fortinet.com;
	arc=pass (i=1)
Authentication-Results: smtp.fortinet.com;
	dkim=pass header.i=@fortinet.com;
	arc=pass (i=1)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hcuUKS8FqSkmeiKHlG//kk+PhecM4KUXD5LUkvcDopX70qn8zSEIALpiHe+YTLrwYmjhYXGWFP+J5W1UDuCbiy7U1xvESapEqy7g2w70+8yHGaeYJFFJrlIFRB79N6tSzECVAmvxDGanRxxUpZovnlpXYyLCgL6SG9WL6zTcESu7bltgUnUTUGBV1I86al7kn5tuYH4wurmI18fHK8C9DM7hYnaAzqXK0whUu9wlUYnoJHbDkEAfZfbVpQzZAQ7Z1qUNKfn0WUt6zKbx0VpB3uTwiV3WPtVQrH8AD3Pq0zsdEzgd8+s7Sx4COFFXendM3SUT3h924XPv1eQPjpj4qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J1stG2WZtRXHht9PZtFsjcw8PLDdwYZPvUcE3fzJHns=;
 b=QriUhKpJLz2IdQjeUUg9Rk4nLML7xUgizXeeTyLc2X2I7Cuh+ipAFqubzfcnMNxuE1JT2X6Dq170B0TTYsugwmw1pFbzne4vftOJQs2wxflzCaDWLbUyeAYDIGWBUWX92CdAYrdnLQK1OFfpCRHziLUEP1unqbBp326tAU2n+b10O12SyQjbI3pMvSNClQrlYXoLmHu1EhExiXrpz3wke0zl40OCZEMzbyI9eklmIp/SanSOq7Uk2+GPykdO9VXw0J2eQ4nrLPqCkceisbMIMpCoDykd8EaCA6WJ/1F4kQHJrT7EyIjlySE677mw4NXhDlhExJo18FXbvtg6yfPiAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fortinet.com; dmarc=pass action=none header.from=fortinet.com;
 dkim=pass header.d=fortinet.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=fortinet.com; s=dkim; c=relaxed/relaxed;
 h=from:to:subject:date:message-id:references:content-type:mime-version;
 bh=nwn3cwhrDd8yms6ibI84f0rMsS875LHUe2Dtq24LzFI=;
 b=G7yttlJhreIT4zljVzBn6adnQZpJgei51tC2X34qrwbq2300Mbka1CMCanlvRfuVTC9CqfLcnFQl
	DsprAK3cEX61s/S/Zt5oSVgfn65IJvdNO6JdFqzyt6RZbQFqDpeGB1xpkvOvV1yKBZoBL89fxwNU
	2OkJqt6Gsb8N5roqfpbNDKIPVUKLsbLLASXtSRXSL4K4Yex1yWv4i64bWMThUqso1yy5nild0AmN
	VjrVAtNS6oXraZUkd+M64XsltBhHqcnU8oBjpC1ruBGCYd4jd+qJFH2z0n3K08iz6DTTkhwsp/SV
	o8I+MnHFwEPunUm9HRw4KXkpUZb54Fw9Ju6YIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fortinet.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J1stG2WZtRXHht9PZtFsjcw8PLDdwYZPvUcE3fzJHns=;
 b=irWsYcJbujZlwhO7s+LcHkXRGXUwxpBIEasHlEsV8Ym4RvWrl1/gYx7HUJPS5N6PfVIYtOXQwWp6GWVEjI9qVYZ5PoR3POa8pPJO8cT+oDqWZDXrFuEkF8AAwrBjGZoCDetx+w9PSo1M+CR1vd0T4ipakmnErVO5bZwHP5voaPU=
From: Srilatha Addanki <saddanki@fortinet.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "jmaloy@redhat.com"
	<jmaloy@redhat.com>, "ying.xue@windriver.com" <ying.xue@windriver.com>
Subject: [TIPC] Enabling an already-enabled bearer triggers brief link flap
 (~243ms down) despite 1000ms tolerance
Thread-Topic: [TIPC] Enabling an already-enabled bearer triggers brief link
 flap (~243ms down) despite 1000ms tolerance
Thread-Index: AQHdNL/5gg/ZiuzKC0+waAp0eE4DvravIHDw
Date: Tue, 25 Aug 2026 19:08:12 +0000
Message-ID:
 <BN3SPRMB00020EA67E11CAB28D9EBE6AB3AF2@BN3SPRMB0002.namprd18.prod.outlook.com>
References:
 <BN3SPRMB0002D8DE46CAA989F8F3961CB3AF2@BN3SPRMB0002.namprd18.prod.outlook.com>
In-Reply-To:
 <BN3SPRMB0002D8DE46CAA989F8F3961CB3AF2@BN3SPRMB0002.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fortinet.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN3SPRMB0002:EE_|DSVPR18MB988386:EE_
x-ms-office365-filtering-correlation-id: d89f4cd3-99a7-4470-5ff7-08df02dc357f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|38070700021|6133799003|10067099003|5023799004|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info:
 Iux/qgQIdvVDE38ZjFxhrvT4BrS3Uuoq2VI7zo5yJerwtv9PZriM4q1/Y52znW+R+Jbr4Z99WFdiRcUBo4xw2nPJcy5d98t7jIxtO4Ch90ntyZndQHyq/71YcQnSY1sezMODJZt1OfRsObZ42AvuVH8sX1ohmR1oLZlLpzIMnJlF+EqOfaR7SnOJmw2bs6zLdEQOk7cp8kBSKPYrNFCxtxGT1dfZae3/SMF1nb+hj0NlfwlNDe27ch/d7d1t1syr7DSBN5xjMprW1H/0TOJIMYm0dHOe592LO4kqRXSZuFh8P65wHyPBdup1eC4cmMRJSIRRFRJHhbWtxbHbKy6C+4KZDB97tWoYKNr8eCX3RiDquw6x9hzqwpDjn+uBVEPcHJbgwlBeHUVE2iumNFUzeZEBMn2xSXjMhJNNs2TXhTUFTl4lmoO427hAToourOdxTPo9fVwLXpTm5BWy0fGt8Lnjir0XlSn4vcLRLlxZhc1slzqVj8Wsb1NqzYqIqVqTXR4MPF1mN602QziqLC0Pk0kH5T/gqKAcEUAiNuGNl5NVVV3p2tmIc52rz9szKSC/p95JHSo9X5eJu5O7loFXnOpY+uV9y8881zhLTejC/meQUp6gd2tOOK2h/Mh406FRpke3vtlFYcHU2/wWvRn9+JWBT7jIGLkwZVbjiuw6QkIF8oBrgSyZV3p8wZeGKaBQhowJqgQCRHj8BU6I0y0cixswaqSI4ahCyFzuT/PJSlM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3SPRMB0002.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(38070700021)(6133799003)(10067099003)(5023799004)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?JnNRMgIjnWtxntu7lKgmXGPcXpFMztJokHAy8XFj7xd66imfJ3m8yq8J5g?=
 =?iso-8859-1?Q?L5utkIBv2+oIspFzkUM8dlgqVZrMz38bh4lGp0z8Pg0CTOWfOFCIJgXI+T?=
 =?iso-8859-1?Q?anyYxfAgl2QSGg5p0lZINXiiF8zjY64QIjwtbKItp3dtos0kWvDG4jKS+B?=
 =?iso-8859-1?Q?5V+iIbXKOnwG89wH5tJtoWqBIW5NaaoqXrl0sxYMdz8+wI+8RC0tph9xU9?=
 =?iso-8859-1?Q?6Lc8BA3ErfBAJjP1egZsIeHajkWB9N837OmhNs5soPOUKAkkLV9oKXHpQ8?=
 =?iso-8859-1?Q?pgHKpHCDO5TaRtHIpOOmBQZ0YE/NcanQG2PGaypTT12uN6X3HXNWYTgxG4?=
 =?iso-8859-1?Q?08mgx1HdSWd2/OjIqiDelnlsKwmKaCay5NEVfLIUh3VwzdjrgQA9lj4heQ?=
 =?iso-8859-1?Q?g96coNnbLYX1gZUCzfsMaTxPq3QeeZWqF95FFttm6U0e7xazNjFaTl5MUp?=
 =?iso-8859-1?Q?hOntJ02lIMamlu1IdC8vAuZh6uQQXjXcDpAOuXqzn0UkVswhDz7dawU+QG?=
 =?iso-8859-1?Q?ukdq4BoxmaFiKy8xXzh1pcUVamUoVlU4WWo4KCzSdZHKhraPbDxfVlHkh+?=
 =?iso-8859-1?Q?nAAVj7Vr/Ok0F5PI6KlJiJk4XmQegCNXR5XkItidotFF/UJD5VIckd3Lk+?=
 =?iso-8859-1?Q?hk9v7PcfbzzIzFHriXuJtRw5+DAjhF2KBay2zixhDfoaXSFzGcYgquvTwd?=
 =?iso-8859-1?Q?lrCWU7wJs48x0geElFcvDfr7ddEJexIQGaYFpLYXk8F5JHPBLQtLF8rvdU?=
 =?iso-8859-1?Q?GYmqcVP6v9ZCjhg6UPxj1EClL6AtdCPiBnEsPnEwnbS61ywv4gKplBD3by?=
 =?iso-8859-1?Q?9uJs/sYgO/ivP6/3V2SYol6J7nesioUR6nUveDUy1cyO/XNXx/fNZgtrnB?=
 =?iso-8859-1?Q?Nbq2D6GgEGAeVh6nGBqUOC27EfNK+cQrdblA/dgBhYC/ErGEISEQc+CK7M?=
 =?iso-8859-1?Q?ghzvbIcCxvDiOGlbI5frllW7D0RNzhhVwgiKxO7gaSAPcXd8sLgTObIudK?=
 =?iso-8859-1?Q?yt0NVHTBHYG4gQPt0+iVMbBDQnoNTdXCTgAjA/yW4NgEsXnN8oVCHBf0XY?=
 =?iso-8859-1?Q?XCqY92ty5tfdLwUNfHM7Sklg9eKrozBHuaW4LEeCkoJbd97hiEIzGqxlQ0?=
 =?iso-8859-1?Q?n8amAMNZvefAQVfqK0+s8p+fhXIhskOa9L1mCshVCuD2qUCheKXkwu+ImZ?=
 =?iso-8859-1?Q?aQkOo0QkZwaVRuh9B25633kzXjy+aWPJtZGn92cHq7+IFHCwOmPmSQoYp8?=
 =?iso-8859-1?Q?axMLzHN3MSFhwdbPNKPZQ8td7oaTWn3/MYTO4ETSbfXzuGRXvhs+cHVIfa?=
 =?iso-8859-1?Q?6YXRbQLaydnLLI+YI/X/ANdf8nKfN8TPj5FOfWIXPrmgw8C9/5brxcn82E?=
 =?iso-8859-1?Q?0emuk7BTdxwlP5Y2HAs50cn1siHglKi/7IWabQ4pxpWxveliZtN85IwJke?=
 =?iso-8859-1?Q?58HVjOIpV+CZ7xpLt6EnClQhAMW2z1Zh83bOrnO1dbCAzlhdWyu4XO1Z8N?=
 =?iso-8859-1?Q?QsFLDfjmiqZpDE/zgWaheDTizTx2hEaQhmxy009WcIHkQIqu+nGyjkQUNh?=
 =?iso-8859-1?Q?0iuNEZt2FtC4vPypn6h//CsmgPe4yVb/QO5hfs5IyUukqDWjYnm1KOI/uq?=
 =?iso-8859-1?Q?l2tfoXOuPKEYTP0LjZFNIFop/b0w1Q1gtGbzviO6E8Xpe8jHWqxpH5kUYE?=
 =?iso-8859-1?Q?9n8mlrWaxFQN8tPdO2gM4d+AVRmaOaTen2LoEr6wbHr9W3lWU0f+EaH2KQ?=
 =?iso-8859-1?Q?p/fn334mByVoI+qe6GLU1se8BgtqTGuq09mohAHuziYudzqq836hSyRbel?=
 =?iso-8859-1?Q?d5vKNqYo3A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	fyghaym0rl8quif/ej1w3d07e0rOgVu+cRmpU46M/ihJt4FfaFFfSuPNCLCNwy9TATgpsNY29k/Kz4iBY6w8i3CvNS0iTvRFrK4s+oot9BYNKrZgHXWzUrZdxrxkZaCaWGdA9g3PhNDlnPLj4e3DYUpVhDILJOFzR+I4FSP2XLxvnZOm+xnPuxWyKtTU2hK5/Ccy7UDJ8TH0+VOwrriko0v9KMC5rqWtuFPDrSnPZ0GKkC6TSXxFn0z+FuPVr8oRdPmv9iLBLa7xYixOVh7T0TuaUeYamArf+7+9ftwkQL6am2rMOi+OUZ/Ros30dA73uqzXvtUX9eV+g8alKPcRbw==
X-OriginatorOrg: fortinet.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN3SPRMB0002.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d89f4cd3-99a7-4470-5ff7-08df02dc357f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2026 19:08:12.3288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2c36c478-3d00-452f-8535-48396f5f01f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zytya39tCtVnh8DCcR2L4qSe9SCqtaIkRbmq2Z2NhKAjdXMGzaTsKyKK+GXoFlpbYiEIIazy+/D6TFVijYUdrJ1vJOgN0chV+IxYG8mUBIM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR18MB988386
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWUhZXkguLVFYWC88UVpdWFhYWFpbSFpZSBsJDAwJBgMBKA4HGhwBBg0cRgsHBUhZSFpaSAYNHAwNHigeDw0a
 RgMNGgYNBEYHGg9IWEhaSFlYSFxYRlFbRlxGWVpIUEhYSFhIW0hYSFhIWEhZX0gCBQkEBxEoGg0MAAkcRgsHBUhYSFpaSAYNHAwNHigeDw0aRgMNGgYNBEYHGg9IWEha
 WkgRAQYPRhAdDSgfAQYMGgEeDRpGCwcFSFg=
X-FEAS-DKIM-smtp.fortinet.com: Valid
X-FEAS-ARC-smtp.fortinet.com: Pass (Highest instance tag i=1)
X-FEAS-Client-IP-smtp.fortinet.com: 40.93.4.12
X-FE-Last-Public-Client-IP: 40.93.4.12
X-FE-Policy-ID-smtp.fortinet.com: 13:5:6:SYSTEM

Hi, 

We are observing brief TIPC link flaps when re-issuing a tipc bearer enab=
le command on a bearer interface that is already enabled and active.
When tipc bearer enable is invoked on an active bearer, the link drops al=
most immediately (~168ms later) and remains down for 200-250ms before rec=
overing, even though the configured TIPC tolerance is set to 1000ms.

Log:
16:28:50.067 =A0system("tipc bearer enable ...") invoked on eth dev
16:28:50.280 =A0system("tipc bearer enable ...") re-invoked
16:28:50.448 =A0TIPC mgmt link DOWN (168ms after re-enable)
16:28:50.547 =A0system("tipc bearer enable ...") re-invoked
16:28:50.691 =A0TIPC mgmt link UP =A0 (link down duration: 243ms)

Questions:
=A0 1. Behavior: Is re-enabling an already-enabled bearer expected to res=
et the link?
=A0 2. Tolerance: Why does the link go down for 200ms when tolerance is 1=
000ms?
=A0 3. API Design: Is there an idempotency option for bearer enable?
=A0=A0
Thanks,
Srilatha


***  Please note that this message and any attachments may contain confid=
ential and proprietary material and information and are intended only for=
 the use of the intended recipient(s). If you are not the intended recipi=
ent, you are hereby notified that any review, use, disclosure, disseminat=
ion, distribution or copying of this message and any attachments is stric=
tly prohibited. If you have received this email in error, please immediat=
ely notify the sender and destroy this e-mail and any attachments and all=
 copies, whether electronic or printed. Please also note that any views, =
opinions, conclusions or commitments expressed in this message are those =
of the individual sender and do not necessarily reflect the views of Fort=
inet, Inc., its affiliates, and emails are not binding on Fortinet and on=
ly a writing manually signed by Fortinet's General Counsel can be a bindi=
ng commitment of Fortinet to Fortinet's customers or partners. Thank you.=
 *** 


