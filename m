Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7707280A56;
	Fri, 23 Jan 2026 03:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.150.39.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769137270; cv=none; b=R/cP/x8qeentzZfmbJD8AAYhAxe2ARcSYpk3+4UPZoLffyynhCvq88QffjdgSFhyivtQ+gQpw4rwGlHYplmwUBzKuu3sNu4m3/SY/tlmjgh25hyy3NaeWi642otAQ8Pzl6MWYyijf2ns09uqhIKTENPpM5FyKwk9yqu8B5OWBFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769137270; c=relaxed/simple;
	bh=9tWzlg4noYB1SecXcRQgDvZBvbUbx3Ptw7Th/eHLv3M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=EG3mxNaOiCRDrQgZ1BnT4sMh55P8tz9ulmnTDM35krCUoPpciz+d3s3nEizVhDBXFjpuZJSKG3LBWKhZfx80v8ZgGUbWaZzWW8EosKYj6Yrn3Uso3SmMhKk/caRkcNB+6kQgzaR0xObUMPZzRvbVeaRTSt+MYq4gYz3h8o5JOUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=129.150.39.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from lizhi2$eswincomputing.com ( [10.11.96.26] ) by
 ajax-webmail-app1 (Coremail) ; Fri, 23 Jan 2026 11:00:16 +0800 (GMT+08:00)
Date: Fri, 23 Jan 2026 11:00:16 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?5p2O5b+X?= <lizhi2@eswincomputing.com>
To: "Andrew Lunn" <andrew@lunn.ch>
Cc: devicetree@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, rmk+kernel@armlinux.org.uk,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	ningyu@eswincomputing.com, linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com, weishangjuan@eswincomputing.com
Subject: Re: Re: Re: [PATCH v1 1/2] dt-bindings: ethernet: eswin: add clock
 sampling control
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2026 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <59cec617-0189-4dc3-bc3f-6346155a62ae@lunn.ch>
References: <20260109080601.1262-1-lizhi2@eswincomputing.com>
 <20260109080859.1285-1-lizhi2@eswincomputing.com>
 <00b7b42f-2f9d-402a-82f0-21641ea894a1@lunn.ch>
 <308b676.2d03.19bb0caebed.Coremail.lizhi2@eswincomputing.com>
 <59cec617-0189-4dc3-bc3f-6346155a62ae@lunn.ch>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <4e2a55e7.3662.19be8cb9c3c.Coremail.lizhi2@eswincomputing.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:TAJkCgD3SmxA5HJpFPMEAA--.1437W
X-CM-SenderInfo: xol2xx2s6h245lqf0zpsxwx03jof0z/1tbiAgEQDGlyUYERQgABsG
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

CgoKPiAtLS0tLeWOn+Wni+mCruS7ti0tLS0tCj4g5Y+R5Lu25Lq6OiAiQW5kcmV3IEx1bm4iIDxh
bmRyZXdAbHVubi5jaD4KPiDlj5HpgIHml7bpl7Q6MjAyNi0wMS0yMiAyMTozMjozNCAo5pif5pyf
5ZubKQo+IOaUtuS7tuS6ujog5p2O5b+XIDxsaXpoaTJAZXN3aW5jb21wdXRpbmcuY29tPgo+IOaK
hOmAgTogZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmcsIGFuZHJldytuZXRkZXZAbHVubi5jaCwg
ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldCwgZWR1bWF6ZXRAZ29vZ2xlLmNvbSwga3ViYUBrZXJuZWwub3Jn
LCByb2JoQGtlcm5lbC5vcmcsIGtyemsrZHRAa2VybmVsLm9yZywgY29ub3IrZHRAa2VybmVsLm9y
ZywgbmV0ZGV2QHZnZXIua2VybmVsLm9yZywgcGFiZW5pQHJlZGhhdC5jb20sIG1jb3F1ZWxpbi5z
dG0zMkBnbWFpbC5jb20sIGFsZXhhbmRyZS50b3JndWVAZm9zcy5zdC5jb20sIHJtaytrZXJuZWxA
YXJtbGludXgub3JnLnVrLCBsaW51eC1zdG0zMkBzdC1tZC1tYWlsbWFuLnN0b3JtcmVwbHkuY29t
LCBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcsIGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmcsIG5pbmd5dUBlc3dpbmNvbXB1dGluZy5jb20sIGxpbm1pbkBlc3dpbmNvbXB1
dGluZy5jb20sIHBpbmtlc2gudmFnaGVsYUBlaW5mb2NoaXBzLmNvbSwgd2Vpc2hhbmdqdWFuQGVz
d2luY29tcHV0aW5nLmNvbQo+IOS4u+mimDogUmU6IFJlOiBbUEFUQ0ggdjEgMS8yXSBkdC1iaW5k
aW5nczogZXRoZXJuZXQ6IGVzd2luOiBhZGQgY2xvY2sgc2FtcGxpbmcgY29udHJvbAo+IAo+ID4g
T24gRUlDNzcwMCwgUlhDIGFuZCBSWEQgZXhwZXJpZW5jZSBhbiBpbnRlcm5hbCBza2V3IGJlZm9y
ZSByZWFjaGluZyB0aGUKPiA+IE1BQy4gQXQgaGlnaCBzcGVlZCwgdGhpcyBjYW4gc2hpZnQgdGhl
IGVmZmVjdGl2ZSBzYW1wbGluZyBwb2ludCBieQo+ID4gYXBwcm94aW1hdGVseSBoYWxmIGEgY3lj
bGUsIGNhdXNpbmcgdGhlIE1BQyB0byBzYW1wbGUgdGhlIHdyb25nIG5pYmJsZQo+ID4gb24gZWFj
aCBlZGdlLgo+IAo+IFlvdSBzYXkgaW50ZXJuYWwuIFNvIHRoZSBza2V3IGlzIGZpeGVkLCBpdCBp
cyBhIHByb3BlcnR5IG9mIHRoZQo+IHNpbGljb24/IElmIHNvLCB3aHkgYSBEVCBwcm9wZXJ0eT8g
V2h5IG5vdCBqdXN0IGhhcmQgY29kZSBpdCBpbiB0aGUKPiBkcml2ZXI/IFNpbmNlIGl0IGlzIGlu
dGVybmFsLCBkaWZmZXJlbnQgYm9hcmRzIHNob3VsZCBub3QgbmVlZCBpdCBzZXQKPiBkaWZmZXJl
bnRseT8KPiAKVGhhbmtzIGZvciB0aGUgcXVlc3Rpb24uCgpFSUM3NzAwIGhhcyB0d28gRXRoZXJu
ZXQgTUFDcy4gT25seSBldGgxIGhhcyB0aGlzIGludGVybmFsIFJYQy9SWEQgc2tldywKZXRoMCBk
b2VzIG5vdC4KClNvIHRoaXMgaXMgbm90IGEgY2hpcC13aWRlIGNvbnN0YW50IHRoYXQgY2FuIGJl
IGhhcmRjb2RlZCBpbiB0aGUgZHJpdmVyLgpXZSBuZWVkIGEgd2F5IHRvIGRpc3Rpbmd1aXNoIHRo
ZSB0d28gTUFDIGluc3RhbmNlcywgd2hpY2ggaXMgd2h5IHRoaXMgaXMKZGVzY3JpYmVkIHBlci1w
b3J0IGluIERUUy4KCi0tCkxpIFpoaQo=
