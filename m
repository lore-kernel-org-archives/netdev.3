Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=180.76.5.236
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794201562;
	b=wUW6Ttunzwu2eSGMtCCyjgaV8lYexlAzltGb4uaHGvD00xPpyOMEEXgwKGSqsTzwJeyN
	 sPthzNOLsumHtn3n/hDWYmj2qXD8/LjKfQ64Ffh1FX8xBRBLOavp2lF8JxYSvPkmWu4ny
	 o84266WbPovLRuNBeLzTnlbl0f6RGKpG7SJVgqL43jraRoY3FdGg3XXTRdFQYdxUanf73
	 61u6JCV20/ZTNj79eh+Jmo9GLNwg22TFChpyfTuL5hpDPUOxVqw11HvOQA2abaXL3QLIC
	 thrvQzWiSKIweKrv+Dx3NMkt08EbFFUjeBFpf6w8UwMvafpLZBYr28f7j5qzAz8rjUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794201562;
	h=DMARC-Filter:X-MD-Sfrom:X-MD-SrcIP:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-originating-ip:Content-Type:Content-Transfer-Encoding:MIME-Version:
	 DKIM-Signature;
	bh=Ce3YwrOJXaRipfIYp3w8Z9TnqInm8hZCIQukd1m1qlk=;
	b=auEuUg7PpLRMCu33ePhFV93jq91ASMgyJWITtnV8sMxs3c6wef5RJTp7AsWY/7nEHx9T
	 xBiR/Y6i0EqEYYvTVe8Ht6ddyXxw/s5xODUa1Y3mjLgZum2zjZU9zdIbvI0Qhb+IMpSWh
	 ZvJsgrwUN3iLrBft308+m/rKNjMpFdozxZD6fQaAW/+h3zuLdSr2U8cViffxhWhZ1MjEO
	 XLBOZvY/VJraiFgw1Vr5xF3KTX1rh6CjrytdWzGhLp6O4fp+4wN5Y+kugOfuGhHG84QE9
	 A2Ek+arz0uaDSau0Q/oq9EP3Wvn7bM6yQ5bY0G5D8HArc38RAZk+cnrVkyX5fI5qnwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baidu.com;
	spf=pass smtp.mailfrom=baidu.com;
	dkim=pass header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=BnktGqNT;
	arc=none smtp.remote-ip=180.76.5.236
Received: from outbound.baidu.com (outbound.baidu.com [180.76.5.236])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 66A8B606A321;
	Mon,  9 Nov 2026 05:19:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66A8B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=BnktGqNT
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.45
From: "Li,Rongqing" <lirongqing@baidu.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
CC: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?tPC4tDogWz8/Pz9dIFJlOiBbUEFUQ0hdIGFmX3VuaXg6IEZpeCB3cm9uZyBz?=
 =?gb2312?B?b2NrZXQgdGVzdGVkIGluIHRoZSBzeW1tZXRyaWMgaGFsZiBvZiB1bml4X3N0?=
 =?gb2312?B?YXRlX2xvY2tfY21wX2ZuKCku?=
Thread-Topic: [????] Re: [PATCH] af_unix: Fix wrong socket tested in the
 symmetric half of unix_state_lock_cmp_fn().
Thread-Index: AQHdbiv8JPaqeURuJkmRgktJk6Opfbchu90AgAN7aIA=
Date: Mon, 9 Nov 2026 05:19:15 +0000
Message-ID: <06faaaea248d4cefb1f12d1221b75a8a@baidu.com>
References: <20261106201822.1734-1-lirongqing@baidu.com>
 <au7bGHqwhXXttXH_@google.com>
In-Reply-To: <au7bGHqwhXXttXH_@google.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1794201559;
	bh=Ce3YwrOJXaRipfIYp3w8Z9TnqInm8hZCIQukd1m1qlk=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=BnktGqNTdzYCtmaSKBirjfFdHdxXUvMZp//Iq6FTjlo4y3zxCE8daWyoIIvEkLnPr
	 tHmAJ0e3x6qWRJ6UrktvTlxEkLzJYZLb25MzI+HHWWdcapxnVuqlHmjC3GNQzYLeuN
	 eSrXOQB/i2/+QerzxR5Qjzfg3aJBwH6nLLv7/E21LQKE0Xv86N1Z7Ux7MmgBg9Pdlo
	 W9w5EfKIKjwOQUhTeSy3+RpY6DIEuNF98+6BnO30ZdcGX9JuMzxS3gVKMPDjTdYHbE
	 DqbdOyfPJdKxqVmNCP4GeuTrM+tStqG2CwQCc8BTzEVK3Ch7e6054OK1iUrQxO32/U
	 dozKF7/paX7AA==

DQo+ID4gW1BBVENIXSBhZl91bml4OiBGaXggd3Jvbmcgc29ja2V0IHRlc3RlZCBpbiB0aGUgc3lt
bWV0cmljIGhhbGYNCj4gDQo+IFRoaXMgaXMgbmV0LW5leHQgbWF0ZXJpYWwsIHNvIGl0IHNob3Vs
ZCBiZQ0KPiANCj4gICBbUEFUQ0ggbmV0LW5leHQgdlhdIGFmX3VuaXg6IC4uLg0KPiANCj4gc2Vl
IERvY3VtZW50YXRpb24vcHJvY2Vzcy9tYWludGFpbmVyLW5ldGRldi5yc3QuDQo+IA0KPiANCj4g
T24gU2F0LCAwNyBOb3YgMjAyNiAwNDoxODoyMiArMDgwMCwgbGlyb25ncWluZyB3cm90ZToNCj4g
PiBGcm9tOiBMaSBSb25nUWluZyA8bGlyb25ncWluZ0BiYWlkdS5jb20+DQo+ID4NCj4gPiBUaGUg
c2Vjb25kIGhhbGYgb2YgdW5peF9zdGF0ZV9sb2NrX2NtcF9mbigpIGlzIG1lYW50IHRvIG1pcnJv
ciB0aGUNCj4gPiBmaXJzdCBvbmUgd2l0aCB0aGUgcm9sZXMgb2YgYSBhbmQgYiBzd2FwcGVkLCBi
dXQgaXQgc3dpdGNoZXMgb24gYidzDQo+ID4gc3RhdGUgYWdhaW46DQo+ID4NCj4gPiAJaWYgKGIt
PnNrLnNrX3N0YXRlID09IFRDUF9MSVNURU4pIHsNCj4gPiAJCXN3aXRjaCAoYi0+c2suc2tfc3Rh
dGUpIHsNCj4gPiAJCWNhc2UgVENQX0NMT1NFOg0KPiA+IAkJY2FzZSBUQ1BfRVNUQUJMSVNIRUQ6
DQo+ID4gCQkJcmV0dXJuIDE7DQo+ID4NCj4gPiBUaGUgZW5jbG9zaW5nIGlmIGFscmVhZHkgZXN0
YWJsaXNoZWQgdGhhdCBiIGlzIFRDUF9MSVNURU4sIHNvIHRoZQ0KPiA+IHN3aXRjaCBjYW4gb25s
eSByZWFjaCB0aGUgZGVmYXVsdCBsYWJlbCBhbmQgdGhlIGJyYW5jaCBhbHdheXMgcmV0dXJucw0K
PiA+IDAsICJubyBvcmRlciBrbm93biIsIGluc3RlYWQgb2YgdGhlIGludGVuZGVkIDEuDQo+ID4N
Cj4gPiBUZXN0IGEncyBzdGF0ZSwgYXMgdGhlIGZpcnN0IGhhbGYgZG9lcy4gIFRoZSBjb2RlIGlz
IG9ubHkgY29tcGlsZWQNCj4gPiB3aXRoIENPTkZJR19QUk9WRV9MT0NLSU5HLCBzbyB0aGVyZSBp
cyBubyBydW50aW1lIG1lbW9yeS1zYWZldHkNCj4gPiBpbXBhY3Q7IHRoZSBlZmZlY3QgaXMgdGhh
dCBsb2NrZGVwIGNhbm5vdCB2YWxpZGF0ZSB0aGlzIG5lc3Rpbmcgb3JkZXINCj4gPiBvZiB1bml4
X3N0YXRlX2xvY2soKS4NCj4gPg0KPiA+IEZpeGVzOiA5OGY3MDZkZTQ0NWIgKCJhZl91bml4OiBE
ZWZpbmUgbG9ja2luZyBvcmRlciBmb3IgVV9MT0NLX1NFQ09ORA0KPiA+IGluIHVuaXhfc3RyZWFt
X2Nvbm5lY3QoKS4iKQ0KPiANCj4gUGxlYXNlIGRyb3AgdGhlIHRhZy4NCj4gDQo+IEFzIGNvbW1l
bnRlZCwgdGhlIGJyYW5jaCBuZXZlciBoaXRzIGFuZCBubyByZWFsIGlzc3VlIGV4aXN0cywgbm90
IHdvcnRoDQo+IGJhY2twb3J0aW5nLg0KPiANCg0KT2ssIEkgd2lsbCBzZW5kIHYyDQoNCltMaSxS
b25ncWluZ10gDQoNCj4gDQo+ID4gU2lnbmVkLW9mZi1ieTogTGkgUm9uZ1FpbmcgPGxpcm9uZ3Fp
bmdAYmFpZHUuY29tPg0KPiA+IC0tLQ0KPiA+ICBuZXQvdW5peC9hZl91bml4LmMgfCAyICstDQo+
ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+
ID4gZGlmZiAtLWdpdCBhL25ldC91bml4L2FmX3VuaXguYyBiL25ldC91bml4L2FmX3VuaXguYyBp
bmRleA0KPiA+IGU3YTA1ODIuLjUwMWU2OTMgMTAwNjQ0DQo+ID4gLS0tIGEvbmV0L3VuaXgvYWZf
dW5peC5jDQo+ID4gKysrIGIvbmV0L3VuaXgvYWZfdW5peC5jDQo+ID4gQEAgLTE2Myw3ICsxNjMs
NyBAQCBzdGF0aWMgaW50IHVuaXhfc3RhdGVfbG9ja19jbXBfZm4oY29uc3Qgc3RydWN0DQo+ID4g
bG9ja2RlcF9tYXAgKl9hLA0KPiA+DQo+ID4gIAkvKiBTaG91bGQgbmV2ZXIgaGFwcGVuLiAgSnVz
dCB0byBiZSBzeW1tZXRyaWMuICovDQo+ID4gIAlpZiAoYi0+c2suc2tfc3RhdGUgPT0gVENQX0xJ
U1RFTikgew0KPiA+IC0JCXN3aXRjaCAoYi0+c2suc2tfc3RhdGUpIHsNCj4gPiArCQlzd2l0Y2gg
KGEtPnNrLnNrX3N0YXRlKSB7DQo+ID4gIAkJY2FzZSBUQ1BfQ0xPU0U6DQo+ID4gIAkJY2FzZSBU
Q1BfRVNUQUJMSVNIRUQ6DQo+ID4gIAkJCXJldHVybiAxOw0KPiA+IC0tDQo+ID4gMi45LjQNCj4g
Pg0K
