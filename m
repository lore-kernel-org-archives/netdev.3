Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.79.60.68
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794229566;
	b=V8rdVb+l0gAlG3QUbXPPHoYzf1yUT/zH6797Q9fbT8VlhHgILWu/L0oOb9XpIvPhoUvi
	 cF7Mzjw0+Y0ewt7l7ImgMvDEGNwh6clXWYj1N7mHFMbkAzDdvIPwUb+q82kMgUGsJXlTz
	 /Zz+Sx6wSCSfJv2cCM8zxO3Uqdhi90mmJQxjy3MUiV/Ksn33E6ILw/EcBj0nTRgjQmjOY
	 YGqPusiGrOWQW4wSRNKMMumY5sx92WnFk0qyUAL0TQcsX1Of+4Zft7+V+8DgYCV3aya7/
	 lV0OtYBLVwvWhpBcyu2fZJVQPeuUQrjXlXqZgGhsgiVt0DC2e+w57veM1TXj1grA54A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794229566;
	h=DMARC-Filter:Content-Type:Content-Transfer-Encoding:Message-ID:To:Cc:
	 Subject:X-Priority:X-Mailer:X-Originating-IP:In-Reply-To:References:
	 MIME-Version:Received:From:Date:X-HM-Tid:X-HM-MType:X-HM-NTES-SC:
	 X-HM-Spam-Status:DKIM-Signature;
	bh=Uwx411kQ+pLsLGYRN6fUT/Mj26SB4GKvUWvjQbIK0qs=;
	b=Ekq/vg9jo0fQzQr6zh+xHHDxaSdp7hVDi64IXeqOmEZHK+hjhGjVGgZHrwyaRfURVaAq
	 46diTUOLY7WVHPc5KlXVLN3x82K248puzgHieMKHy7ZVCybOz7gXQJNogL7Sd0dInea5i
	 zWnt/N2VySS4ZY8XQnDptDeTFfK1LghGef6VBQSDsh4g0rbW8kSBU7qJ3FzDsfqhKE9PI
	 yRUy8gL2Oaj17TkOHs4KBiFmTu4k9+cJwWTD3O2g00KsFlLXGHUO1NUVj2BTy6XNBB/CE
	 qqfzjmWS7f7fF1gfG1Sou/HMiZmtWstGgdnAM8nsgQS+l79lfkTQK0I6KkE2B0psROQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sdu.edu.cn;
	spf=pass smtp.mailfrom=mail.sdu.edu.cn;
	dkim=pass header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=c24RGP0w;
	arc=none smtp.remote-ip=210.79.60.68
Received: from mail-m6068.netease.com (mail-m6068.netease.com [210.79.60.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E46E606A321;
	Mon,  9 Nov 2026 13:06:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E46E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=c24RGP0w
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AHAASAAGLPGJfVjn9skPJKoS.3.1794229559658.Hmail.202321181@mail.sdu.edu.cn>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: =?UTF-8?B?UmU6UmU6IFtQQVRDSCBuZXRdIG5ldDogcGh5OiBtaWNyZWw6IEZpeCBwb3RlbnRpYWwgc2hhcmVkIFBIQyB1c2UtYWZ0ZXItZnJlZQ==?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com web
In-Reply-To: <71089325-dfab-45f7-9ebd-1feb65013863@lunn.ch>
References: <20261107-0d0c29e10a-net-micrel-lan8814-1@mail.sdu.edu.cn> <71089325-dfab-45f7-9ebd-1feb65013863@lunn.ch>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Received: from 202321181@mail.sdu.edu.cn( [101.76.249.61] ) by ajax-webmail ( [127.0.0.1] ) ; Mon, 9 Nov 2026 21:05:59 +0800 (GMT+08:00)
From: =?UTF-8?B?5p2O5bm/56GV?= <liguangshuo@mail.sdu.edu.cn>
Date: Mon, 9 Nov 2026 21:05:59 +0800 (GMT+08:00)
X-HM-Tid: 0aa1c068f344d0cdkusy32cfb2e0ea97
X-HM-MType: 1
X-HM-NTES-SC: AL0_4z5B86Wr4Tz9jdMF+bhXMVHpP02bZAKsMEiErRSAekjx+ys+KNZNl0PLwl
	f2MeqR5lbiqKsoq8sm3hZVy9q3VY0Ca69y1LOfMeXKdLfI1E5i1eQoqSDNKmzdVlKZstM3zMatiP
	6f2nKh8VfvidlmoN6FW855umPHcnkTFehqKqk=
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDHhhKVktIHhhDShpLSksdH1YVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWU9LSFVCQk
	lOS1VKS0tVSkJLQlkG
DKIM-Signature: a=rsa-sha256;
	b=c24RGP0w8GS1kFlMgpeIV4goy0/fiBcfsRhdX8M7EE6Rx0KfYRRZ0miTjZgw3bZBWhWbZRq/IKlF2x0yBeDImPT+PORQF6vs8CHzhLW/PzXtyHrYIM1JUHoyqZg16/KlzZM53qp8XgFAYIsc6e43m2TE8cRRQK8wwM2sqRquBfo=; s=default; c=relaxed/relaxed; d=mail.sdu.edu.cn; v=1;
	bh=Uwx411kQ+pLsLGYRN6fUT/Mj26SB4GKvUWvjQbIK0qs=;
	h=date:mime-version:subject:message-id:from;

CkhpIEFuZHJldywKCkZyb206IEFuZHJldyBMdW5uIDxhbmRyZXdAbHVubi5jaD4KRGF0ZTogMjAy
Ni0xMS0wNyAyMjo0MDo0NQpUbzogIEd1YW5nc2h1byBMaSA8bGlndWFuZ3NodW9AbWFpbC5zZHUu
ZWR1LmNuPgpDYzogIEhlaW5lciBLYWxsd2VpdCA8aGthbGx3ZWl0MUBnbWFpbC5jb20+LFJ1c3Nl
bGwgS2luZyA8bGludXhAYXJtbGludXgub3JnLnVrPiwiRGF2aWQgUy4gTWlsbGVyIiA8ZGF2ZW1A
ZGF2ZW1sb2Z0Lm5ldD4sRXJpYyBEdW1hemV0IDxlZHVtYXpldEBrZXJuZWwub3JnPixKYWt1YiBL
aWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPixQYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+
LG5ldGRldkB2Z2VyLmtlcm5lbC5vcmcsbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZwpTdWJq
ZWN0OiBSZTogW1BBVENIIG5ldF0gbmV0OiBwaHk6IG1pY3JlbDogRml4IHBvdGVudGlhbCBzaGFy
ZWQgUEhDIHVzZS1hZnRlci1mcmVlPk9uIFNhdCwgTm92IDA3LCAyMDI2IGF0IDAyOjU0OjM3UE0g
KzA4MDAsIEd1YW5nc2h1byBMaSB3cm90ZToKPj4gVGhlIHNoYXJlZCBQSEMgb3V0bGl2ZXMgdGhl
IGZpcnN0IFBIWSdzIG1hbmFnZWQgcGluIGFycmF5IGFuZCBpcyBub3QKPj4gdW5yZWdpc3RlcmVk
IGJlZm9yZSB0aGUgcGFja2FnZSBkYXRhIGlzIGZyZWVkLiBTdWJzZXF1ZW50IFBIQyBvcGVyYXRp
b25zCj4+IGNhbiB0aGVyZWZvcmUgYWNjZXNzIHJlbGVhc2VkIHN0b3JhZ2UuCj4+IAo+PiBLZWVw
IHRoZSBwaW5zIGF0IHBhY2thZ2Ugc2NvcGUgYW5kIHNlbGVjdCBhIHJlbWFpbmluZyBQSFkgZm9y
IHJlZ2lzdGVyCj4+IGFjY2VzcyB3aGVuIGEgbWVtYmVyIGxlYXZlcy4gVW5yZWdpc3RlciB0aGUg
Y2xvY2sgYmVmb3JlIHJlbGVhc2luZyBpdHMKPj4gc3RvcmFnZSBvbiB0aGUgbGFzdCBtZW1iZXIn
cyBleGl0LiBQYWlyIGVhY2ggbWVtYmVyJ3MgcmVnaXN0cmF0aW9uIHdpdGgKPj4gY2xlYW51cCB0
aGF0IGFsc28gcnVucyBvbiBwcm9iZSBmYWlsdXJlLCBhbmQgc2VyaWFsaXplIGNsb2NrIGFjY2Vz
cyB3aXRoCj4+IG1lbWJlciByZW1vdmFsLgo+Cj5Zb3UgZml4IGxvb2tzIG92ZXJseSBjb21wbGlj
YXRlZC4gVWdseS4KPgo+VHJ5IGxvb2tpbmcgYXQgaXQgZnJvbSBhIGRpZmZlcmVudCBkaXJlY3Rp
b24uCj4KPi5wcm9iZSgpIGFuZCAucmVtb3ZlKCkgc2hvdWxkIGJlIG9wcG9zaXRlcyBvZiBlYWNo
IG90aGVyLiBXaGF0IGhhcHBlbnMKPmlmIHlvdSBkbyB0aGF0Pwo+Cj4gICAgQW5kcmV3Cj4KPi0t
LQo+cHctYm90OiBjcgo+CgpPbiBMQU44ODE0LCBvbmUgUEhZIHJlZ2lzdGVycyB0aGUgc2hhcmVk
IFBIQyBhbmQgb3ducyBpdHMgcGluIGFycmF5LgpJZiB0aGF0IFBIWSB1bnJlZ2lzdGVycyB0aGUg
Y2xvY2sgaW4gLnJlbW92ZSgpLCB0aGUgY2xvY2sgZ29lcyBhd2F5CmJlZm9yZSB0aGUgcGlucyBh
cmUgZnJlZWQuIElmIGFub3RoZXIgcG9ydCBpcyBzdGlsbCBib3VuZCwgaXQgbG9zZXMKYWNjZXNz
IHRvIHRoZSBQSEMuIEkgYWRkZWQgdGhlIGhhbmRvZmYgaW4gdjEgdG8ga2VlcCB0aGUgY2xvY2sK
YXZhaWxhYmxlIGluIHRoYXQgY2FzZS4KCkknbGwgcmV3b3JrIHRoaXMgYXJvdW5kIHRoZSBQSFkg
dGhhdCByZWdpc3RlcmVkIHRoZSBjbG9jay4gSSdsbCBjaGVjawpob3cgdGhlIHJlbWFpbmluZyBw
b3J0cyByZXBvcnQgdGhlIFBIQyBhZnRlciB0aGF0IFBIWSB1bmJpbmRzLCBhbmQKd2hhdCBoYXBw
ZW5zIGlmIGl0IGJpbmRzIGFnYWluIHdoaWxlIGFub3RoZXIgcG9ydCBpcyBzdGlsbCB1cC4KClRo
YW5rcywKR3VhbmdzaHVvCgoKCg==
