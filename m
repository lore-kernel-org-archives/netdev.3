Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.245
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793100684;
	b=5Vjwzbl/TtX1l5ZG+DbEWAc/dvb3XjBfjx6GLBn0UlvcdOdD4AtF5VkPpJgv/3sNnkqI
	 DqEisrjTLg76TxfHeTO7IWYIpfkYZb3P57QqBJn+kXJjgznQdNXA1cWrHm2I8N762j/c0
	 KH9E1W/hXEoL+/5lWk900OmXG7wy5f6QAtrlom6OMAsIPEHwAWvNHl5GAUPbwdKgp/XcE
	 LAEgY12Q1x6gbjrcxX6M4O9rSPdgORCPN8FR9BL+wsiy5sCL68YqAvunBTK25MF4f8PAE
	 mC1uvW1ET/3YnrxzTp0eoNL9TPLWXSHucQV/e67RHrkRgORJAlvxKrfoZkXrnPHdIdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793100684;
	h=DMARC-Filter:DKIM-Signature:X-QQ-XMRINFO:X-QQ-XMAILINFO:From:To:Cc:
	 Subject:Mime-Version:Content-Type:Content-Transfer-Encoding:Date:
	 X-Priority:Message-ID:X-QQ-MIME:X-Mailer:X-QQ-Mailer:References:
	 In-Reply-To:X-QQ-mid;
	bh=TE7fyLyp5nwgFIebrTzV81TEIbWOb6SkTODvFbXRBrY=;
	b=YpeDHOIp5WBC3zmiM/Py5RVikx+5J8lbrFVPL+MJ/6u+xk0JBiJ+nkAXA9w3/x7QIy+r
	 ni1rGdt77+bCNkW/NbZvlQVOd5UrZAx9tHGI3RWjEvvt7o1IOq+z0XxYZ7DEIl5baK9bS
	 lbcIhZyYivBUcYPE5oqcrh4AoqwcXp7CmGvQppJIrM6vgOX/fifL7DuUNuIVYVZqFVcwj
	 NHNGDzH0M3VUIDnBpxw57w59GJRFBH4aSK1TUiFeC7Vx37uqKxiT6uRDNh+MK9k9fvsDQ
	 LvYM6tXRsUBtkzqnyqz3SucC0V2ARwGjdhCVANAF5959dMkjIqQPLJU/PV8l72B0FDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=qI0gnQQt;
	arc=none smtp.remote-ip=203.205.221.245
Received: from out203-205-221-245.mail.qq.com (out203-205-221-245.mail.qq.com [203.205.221.245])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6C4606A32D;
	Tue, 27 Oct 2026 11:31:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C6C4606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=qI0gnQQt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1793100674; bh=TE7fyLyp5nwgFIebrTzV81TEIbWOb6SkTODvFbXRBrY=;
	h=From:To:Cc:Subject:Date:References:In-Reply-To;
	b=qI0gnQQtN8qNK6+VaPty62V/kgunfQdGPhAjeFZPmu2e04szr5at8+OjdnzbOfVl8
	 Biv/zIe8CBjAp+MWGE/LmlnAy9ZUzQwi3hqIbSd0Wx9z+FPUyVdIVlwQKKSdn70Irx
	 Xrj/e9keqLO9MVp99+2N1ULS05JAn4om29n3QxM8=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-XMAILINFO: M070hzG9bpixdNYnLOYGQw/kRcHFlCK+icSEE8DKqa2kjogW5Vk/VQv6XckSlb
	 e2RZdJiW6XiIRME8iqrro55sHekX7IIDgqzjy40owqLanriVM7wJJ79WQ74HJ/+wpSI2h2MhtRMYv
	 WCUQknXTXsOsjborpTvw6xypbbDNhWR05QOJi3wOkE5mM5gXMNKagPaRK+N/LowN66Ez/IFQHIHmZ
	 XFvG65C+Qde13cPB9AChkFv5KEKsAvRZHEKWzKhNcJUF77Y7XM9Zu+6vtfP6VEwRnKkv3PtejdIHS
	 GVWP065NPXmdaLqmduajsd1EBSiVVox0R36tESQvTpTCA1dmD+KBQsvIJxk14a+W/PIofX3o/w/L5
	 ahkZhBgQV8qaboQCS9HyWCiEJMwIE8gjGOr/IVD92hqZiCxhMVXrLSk6ln+XcoC3LQVU9Lh524ZS1
	 R8pPay3RUJy/ACmSxZSdoHNIlTeTfdhntIqm/QjBh0JBOjQRHcwyCzC8hWMdgEbDR0IpwLI8YITjw
	 OVPcEaFQcU0VxRJ4Rwqwn+bve7t59qp6OzmsMS4AqmZf4LUp89taQVfm/K8/WHWB+m94UtGcPqT83
	 OCOVkXau6xL7jCWjKTMgecLQb9yzbcwhLDiHy+1YR2vWlMkW/Ygamrq/aekLEK6c+1qCDLW1ewlAj
	 Q/f8KMfR8rssUg4NrBG4e3R0zjsj+zBr8NU7290h3S+QGcBGV1RNDnKQIf+pF8cP30vIge8W02C8Y
	 fTUob0h6LSMFdew2kPhQqF7z7/pNHI/UtshggG6tsKan7m/zvuhjHV+Z2M1qtiE/sObP8mnCxpyCy
	 0h+e7DnNeLFkH8ICQTQOf2h/0EJFf/SmxmTWSipCTIeE9vaIhYBaea+mnzrENOvbCqHhHroUP2+wo
	 yLdEFxvMpeYAEip05g4ANuthGipK2qx7DRx//6UgODkvGfD12sSpOp4cPAUnTI5y/6wbcj2FRlQ02
	 mUlKbIaajK3Y8EnD+G8ilL4/JvZQ8g3ftGGWXuc2lnk2hyP4r8EClMPflwj+IEshiIjo/+xpsXFlj
	 eIW/BkXyXHjQO/y3q+2b9DxXtduLe+/FkugjDdmxKZdTyS4iywmkJrsGBISonIM5l/aaM29/nl+XE
	 1HXNURw2i5hTe+Vg21ZxtGgvD7r0cZw7Dw9NhHvjK2WZmK/DmS6eUnV5DmdSoxHsKMM=
From: "=?utf-8?B?Q3VuaGFvIEx1?=" <1579567540@qq.com>
To: "=?utf-8?B?SGVpa28gU3TDvGJuZXI=?=" <heiko@sntech.de>, "=?utf-8?B?U2hhd24gTGlu?=" <shawn.lin@rock-chips.com>, "=?utf-8?B?U3RlcGhlbiBCb3lk?=" <sboyd@kernel.org>, "=?utf-8?B?QnJpYW4gTWFzbmV5?=" <bmasney+clk@redhat.com>, "=?utf-8?B?SmVyb21lIEJydW5ldA==?=" <jbrunet+clk@baylibre.com>, "=?utf-8?B?Um9iIEhlcnJpbmc=?=" <robh@kernel.org>, "=?utf-8?B?S3J6eXN6dG9mIEtvemxvd3NraQ==?=" <krzk+dt@kernel.org>, "=?utf-8?B?Q29ub3IgRG9vbGV5?=" <conor+dt@kernel.org>, "=?utf-8?B?UGhpbGlwcCBaYWJlbA==?=" <p.zabel@pengutronix.de>, "=?utf-8?B?RWxhaW5lIFpoYW5n?=" <zhangqing@rock-chips.com>, "=?utf-8?B?UmljaGFyZCBDb2NocmFu?=" <richardcochran@gmail.com>
Cc: "=?utf-8?B?c2hhd24ubGlu?=" <shawn.lin@rock-chips.com>, "=?utf-8?B?bGludXgtY2xr?=" <linux-clk@vger.kernel.org>, "=?utf-8?B?ZGV2aWNldHJlZQ==?=" <devicetree@vger.kernel.org>, "=?utf-8?B?bGludXgtYXJtLWtlcm5lbA==?=" <linux-arm-kernel@lists.infradead.org>, "=?utf-8?B?bGludXgtcm9ja2NoaXA=?=" <linux-rockchip@lists.infradead.org>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>, "=?utf-8?B?bmV0ZGV2?=" <netdev@vger.kernel.org>
Subject: Re: [PATCH v4 2/4] clk: rockchip: Add internal support for 24-bit fractional dividers
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Tue, 27 Oct 2026 19:31:11 +0800
X-Priority: 3
Message-ID: <tencent_3EE2905F5ED310CDBC0C74C2D0C842800B06@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20261027-add-board-ok3572-c-clk-v4-0-d4152b4fedaa@qq.com>
 <f9068153-0d6c-471f-a08b-41cff51ff748@rock-chips.com>
 <tencent_AE0E51DA2FACC999E65D6631016044234005@qq.com>
	<6321950.31tnzDBltd@diego>
In-Reply-To: <6321950.31tnzDBltd@diego>
X-QQ-mid: xmsezb41-0t1793100671tc1fp95h9

SGkgaGVpa28sCgo+IGFuZMKgYXPCoEnCoHdyb3RlwqBpbsKgbXnCoHJlcGx5wqB0b8KgS3J6
eXN6dG9mwqBzbGlnaHRseSzCoGxlc3PCoHZlcmJvc2l0ecKgaXMKPiB1c3VhbGx5wqBiZXR0
ZXIuwqBJLmUuwqBhwqBzaG9ydMKgZGVzY3JpcHRpb27CoHdoYXTCoHlvdcKgZGlkLMKgbm90
wqBhwqBkZXRhaWxlZAo+IGxpc3TCoGlzwqB1c3VhbGx5wqBuaWNlcizCoGkuZS7CoHNvbWV0
aGluZ8KgbGlrZQo+Cj4gKysrKysrKysrKysrKwo+IFNpZ25lZC1vZmYtYnk6wqBFbGFpbmXC
oFpoYW5nwqA8emhhbmdxaW5nQHJvY2stY2hpcHMuY29tPgo+IFthZGFwdGVkwqB0b8KgbWFp
bmxpbmXCoHJvY2tjaGlwwqBjbG9ja8KgYW5kwqByZXNldMKgaGFuZGxpbmfCoCh4aW4yNG3C
oGlucHV0LAo+IMKgwqBkb24ndMKgaW50cm9kdWNlwqBDTEtfTlJfQ0xLUyzCoGV0YynCoF0K
PiBTaWduZWQtb2ZmLWJ5OsKgQ3VuaGFvwqBMdcKgPDE1Nzk1Njc1NDBAcXEuY29tPgo+ICsr
KysrKysrKysrKysKCkknbGwgdXNlIHRoaXMgZm9ybWF0IGluIG15IG5leHQgcGF0Y2hlcywg
bWVudGlvbmluZyBvbmx5IHNpZ25pZmljYW50CmNoYW5nZXMgYW5kIGxlYXZpbmcgb3V0IGZv
cm1hdHRpbmcgYW5kIGNvbW1lbnQgdXBkYXRlcy4KCj4gQW5kIGFzIGZvciBzcGVlZCwgbWF5
YmUgZ2l2ZSBpdCBhIGJpdCBtb3JlIHRpbWUgYmV0d2VlbiBpdGVyYXRpb25zLgo+IEEgdmVy
c2lvbiBwZXIgZGF5IGlzIGEgYml0IGZhc3QsIGFzIGl0IGRvZXNuJ3QgZ2l2ZSBwZW9wbGUg
dGltZSB0byBhY3R1YWxseQo+IHJlc3BvbmQuCgpVbmRlcnN0b29kLiBJIGNhbiBsZWF2ZSBt
b3JlIHRpbWUgYmV0d2VlbiByZXZpc2lvbnMgYW5kIGZvY3VzIG9uIGltcHJvdmluZwp0aGUg
cXVhbGl0eSBvZiBlYWNoIHN1Ym1pc3Npb24uCgpCZXN0IHJlZ2FyZHMsCkN1bmhhbyBMdQo=

