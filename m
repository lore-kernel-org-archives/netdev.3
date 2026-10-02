Received: from mx.prosyst.ru (m2.prosoftsystems.ru [46.48.77.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16AB499F2E;
	Fri,  2 Oct 2026 14:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.48.77.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790950819; cv=none; b=HaXY3UIOrPwbStkKQcsCE04qAmpfgTWLEYLexQ6uYnzMCBgUO1/ie+6E2dZokDnkjFWOZI4fecrpThL511Pt72CSq8FCsosJguokKwwok79i8TEBDBwYZ6y3IEppK4Q4qgj+VHnVEd2OK/JCcS1skTquP3OifQ5ec+Ugh5FUvwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790950819; c=relaxed/simple;
	bh=6/u7dHvVpuy9dLkFtTOwJyTFLmWAbKnWIHrGFm82i4Q=;
	h=Content-Type:From:To:CC:Subject:Date:Message-ID:References:
	 In-Reply-To:MIME-Version; b=gqUawTGfOi1pUYGlwMClqAYGQWsk/n4+rosrWeY4bE+CTrSCwwzZRHS6O2Eh2E6OpO+IlF8fzdYxu9pVgDArnuEBC32icoMjBIm24K+DJMTifkINlCeRw5itkZhLFMaTBdgQiOi7ZQbp3pSXir22ydwt2uDZ9njU6vQZR6c7NUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prosoftsystems.ru; spf=pass smtp.mailfrom=prosoftsystems.ru; dkim=pass (2048-bit key) header.d=prosoftsystems.ru header.i=@prosoftsystems.ru header.b=kyGB4KDE; arc=none smtp.client-ip=46.48.77.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prosoftsystems.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prosoftsystems.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=prosoftsystems.ru header.i=@prosoftsystems.ru header.b="kyGB4KDE"
Content-Language: ru-RU
Content-Type: text/plain; charset="utf-8"
Content-ID: <AE876FFC8C285C4098958881CFAFE742@prosoftsystems.ru>
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; d=prosoftsystems.ru; s=ps;
	c=relaxed/relaxed; t=1790950808; h=from:to:date:message-id:subject;
	bh=6/u7dHvVpuy9dLkFtTOwJyTFLmWAbKnWIHrGFm82i4Q=;
	b=kyGB4KDEO/E3bt68t/EZn+7anfjAFp1Tpm955tHIG1hAn13x0asX/QzY9Bw8q1b30UCbR6dNwa+
	r8e40m1kCVOxkpL/NefmQ2sZStqxhltlY/ZMT/Spw7Lg4VZcPFLrUGvBR98Yt+/sMxJFLxUPbNnf5
	txsFCYUnjDQpqv8w5fP03txom74B/HgxUbbkg4qHMXFucE7H5UapvDHf0uboJY+ixqz1SOhsY/m3q
	oX9LrCKaC1F5FsshmFOgBLtbv3rYjp8HjamzROc5AtgmQrPYR4Je8ugK+4i7CnQhnV1lFDCsDcpED
	wTRtPRy4v/0PuXPANiS1VmxC9lNpH+DzObeg==
Received: from echo-2.prosoft.ural.ru (172.21.245.22) by mx.prosoftsystems.ru
 (172.21.240.33) with Microsoft SMTP Server (TLS) id 15.1.396.30; Fri, 2 Oct
 2026 19:20:08 +0500
Received: from echo-2.prosoft.ural.ru (172.21.245.22) by
 echo-2.prosoft.ural.ru (172.21.245.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Fri, 2 Oct 2026 19:20:03 +0500
Received: from echo-2.prosoft.ural.ru ([::1]) by echo-2.prosoft.ural.ru
 ([fe80::c1a2:90f7:8820:c669%17]) with mapi id 15.02.1748.039; Fri, 2 Oct 2026
 19:20:03 +0500
From: =?utf-8?B?0JbQsNC80LHQsNC60LjQtdCyINCg0LDQtNC40Lkg0KDQuNC60LDRgNC00Lg=?=
 =?utf-8?B?0L3QvtCy0LjRhw==?= <r.zhambakiev@prosoftsystems.ru>
To: "netdev-bot+sinfo@kernel.org" <netdev-bot+sinfo@kernel.org>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "mgr@kernel.org"
	<mgr@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
	"benato.denis96@gmail.com" <benato.denis96@gmail.com>,
	"aleksandr.loktionov@intel.com" <aleksandr.loktionov@intel.com>,
	"u.kleine-koenig@baylibre.com" <u.kleine-koenig@baylibre.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "shaojijie@huawei.com"
	<shaojijie@huawei.com>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: Re: [PATCH net v2 0/3] net: fealnx: fix card-index overflow and PCI
 device teardown
Thread-Topic: [PATCH net v2 0/3] net: fealnx: fix card-index overflow and PCI
 device teardown
Thread-Index: AQHdUne62MTefemLtkmJUzgYZc/gMLbp98eAgAABsoA=
Date: Fri, 2 Oct 2026 14:20:03 +0000
Message-ID: <e95524a48ea6666a1d0c78d3dbd9a570e0f875a7.camel@prosoftsystems.ru>
References: <20261002140954.261779-1-r.zhambakiev@prosoftsystems.ru>
	 <179095043961.1402591.2720135629640976917@kernel.org>
In-Reply-To: <179095043961.1402591.2720135629640976917@kernel.org>
Accept-Language: ru-RU, en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gRnJpLCAyMDI2LTEwLTAyIGF0IDE0OjEzICswMDAwLCBuZXRkZXYtYm90K3NpbmZvQGtlcm5l
bC5vcmcgd3JvdGU6Cj4g0JLQndCY0JzQkNCd0JjQlSEg0J/QuNGB0YzQvNC+INC/0L7Qu9GD0YfQ
tdC90L4g0L7RgiDQstC90LXRiNC90LXQs9C+INC+0YLQv9GA0LDQstC40YLQtdC70Y8uINCd0LUg
0L/QtdGA0LXRhdC+0LTQuNGC0LUg0L/Qvgo+INGB0YHRi9C70LrQsNC8INC4INC90LUg0L7RgtC6
0YDRi9Cy0LDQudGC0LUg0LLQu9C+0LbQtdC90LjRjywg0L/QvtC60LAg0L3QtSDRg9Cx0LXQtNC4
0YLQtdGB0YwsINGH0YLQviDQvtC90LgKPiDQsdC10LfQvtC/0LDRgdC90YsuCj4gCj4gCj4gSGkh
Cj4gCj4gVGhpcyBpcyBhbiBhdXRvbWF0ZWQgbWVzc2FnZS4gVGhpcyBzZXJpZXMgbG9va3MgbGlr
ZSBhIGZpeCwgYnV0IGl0cwo+IGNvbW1pdCBtZXNzYWdlcyBzZWVtIHRvIGJlIG1pc3Npbmcgc29t
ZSBpbmZvcm1hdGlvbjoKPiAKPiDCoC0gV2hhdCBoYXJkd2FyZSB0aGUgY2hhbmdlIHdhcyB0ZXN0
ZWQgb24uIEZvciBkcml2ZXIgZml4ZXMgcGxlYXNlCj4gwqDCoCBtZW50aW9uIHRoZSBkZXZpY2Ug
KGFuZCBpZiByZWxldmFudCBmaXJtd2FyZSB2ZXJzaW9uKSB1c2VkIGZvcgo+IMKgwqAgdGVzdGlu
Zywgb3Igc2F5IHRoYXQgdGhlIGNoYW5nZSB3YXMgbm90IHRlc3RlZCBvbiByZWFsIGhhcmR3YXJl
Lgo+IApUaGUgY2hhbmdlIHdhcyBub3QgdGVzdGVkIG9uIHJlYWwgaGFyZHdhcmUuCg==
