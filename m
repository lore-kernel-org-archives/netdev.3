Received: from mailgw2.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DA233F36B
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 06:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.204.27.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773382957; cv=none; b=AbqyCykr8meLterBXRTlm8ighfBt28SLSlXF2jqQxMnoXxpv3vtYxatYZPYaX87eZcnMZrkJ1PAcQcZGARRkwx1LeakRaXMS46U0oppKJaMr0KiW434EFIc44lBuMNHgN+PbmWo779NaRstRIXmTgiYqUUmvlzLUR1XqC5F+sbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773382957; c=relaxed/simple;
	bh=F56GQyNSFLF0AdZyevYHXAOzQQafsSNM4kdqW9Ok01w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ht7IL6pFr5rkoo8kXAlU2vxgt1EjLRUvW/YpOJ4idb3gvg2NZB0+eZW66KAfGt9pCdIwa0Y8C29434rq5YvaCBWt+/6XHvHkd3ImXuyEkVq5Fl4GG3lRhuPrKTMiTBIPifqdK235Mta+/14zsGoT8a4twGSXgiCGp3KX36gEGXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn; spf=pass smtp.mailfrom=hygon.cn; arc=none smtp.client-ip=101.204.27.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp1.hygon.cn (unknown [127.0.0.1])
	by mailgw2.hygon.cn (Postfix) with ESMTP id 4fXDsz05C2z1YQpmD;
	Fri, 13 Mar 2026 14:22:15 +0800 (CST)
Received: from maildlp1.hygon.cn (unknown [172.23.18.60])
	by mailgw2.hygon.cn (Postfix) with ESMTP id 4fXDsy14hJz1YQpmD;
	Fri, 13 Mar 2026 14:22:14 +0800 (CST)
Received: from cncheex05.Hygon.cn (unknown [172.23.18.115])
	by maildlp1.hygon.cn (Postfix) with ESMTPS id 5EF7A1D6;
	Fri, 13 Mar 2026 14:22:06 +0800 (CST)
Received: from cncheex04.Hygon.cn (172.23.18.114) by cncheex05.Hygon.cn
 (172.23.18.115) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Fri, 13 Mar
 2026 14:22:14 +0800
Received: from cncheex04.Hygon.cn ([fe80::1b6f:6c58:58a4:430d]) by
 cncheex04.Hygon.cn ([fe80::1b6f:6c58:58a4:430d%10]) with mapi id
 15.02.1544.036; Fri, 13 Mar 2026 14:22:14 +0800
From: Zhud <zhud@hygon.cn>
To: Jason Wang <jasowang@redhat.com>
CC: "mst@redhat.com" <mst@redhat.com>, "xuanzhuo@linux.alibaba.com"
	<xuanzhuo@linux.alibaba.com>, "eperezma@redhat.com" <eperezma@redhat.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, Jing Li
	<lijing@hygon.cn>, Zhiwei Ying <yingzhiwei@hygon.cn>
Subject: RE: [PATCH net] virtio-net: clear NETIF_F_GRO_HW if no GRO-related
 offloads are capable
Thread-Topic: [PATCH net] virtio-net: clear NETIF_F_GRO_HW if no GRO-related
 offloads are capable
Thread-Index: AQHcsokJYSEJvH0W90iKftd05A/cWrWrdOQAgACGyrA=
Date: Fri, 13 Mar 2026 06:22:14 +0000
Message-ID: <a0aa07c8b6a2423aa1e363c09b54392d@hygon.cn>
References: <20260313013040.896924-1-zhud@hygon.cn>
 <CACGkMEvwR2WWyKvho-WU=_06OmWsYTSDSkML9JS9pSkzOQVkTA@mail.gmail.com>
In-Reply-To: <CACGkMEvwR2WWyKvho-WU=_06OmWsYTSDSkML9JS9pSkzOQVkTA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

PiBPbiBGcmksIE1hciAxMywgMjAyNiBhdCA5OjM34oCvQU0gRGkgWmh1IDx6aHVkQGh5Z29uLmNu
PiB3cm90ZToNCj4gPg0KPiA+IEFsdGhvdWdoIFZJUlRJT19ORVRfRl9DVFJMX0dVRVNUX09GRkxP
QURTIGlzIG5lZ290aWF0ZWQsIHdoaWNoDQo+ID4gaW5kaWNhdGVzIHRoZSBkZXZpY2Ugc3VwcG9y
dHMgZHluYW1pYyBjb250cm9sIG9mIGd1ZXN0IG9mZmxvYWRzLCBpdA0KPiA+IGRvZXMgbm90IG5l
Y2Vzc2FyaWx5IG1lYW4gdGhlIGRldmljZSBzdXBwb3J0cyBzcGVjaWZpYyBoYXJkd2FyZSBHUk8g
ZmVhdHVyZXMuDQo+ID4NCj4gPiBJZiBub25lIG9mIHRoZSBmZWF0dXJlcyBkZWZpbmVkIGluIEdV
RVNUX09GRkxPQURfR1JPX0hXX01BU0sgKHN1Y2ggYXMNCj4gPiBUU080LCBUU082LCBvciBVRk8p
IGFyZSBwcmVzZW50IGluIHZpLT5ndWVzdF9vZmZsb2Fkc19jYXBhYmxlLCB0aGUNCj4gPiBkZXZp
Y2UgZWZmZWN0aXZlbHkgbGFja3MgdGhlIGhhcmR3YXJlIGNhcGFiaWxpdHkgdG8gcGVyZm9ybSBH
Uk8uDQo+ID4NCj4gPiBJbiB0aGlzIGNhc2UsIE5FVElGX0ZfR1JPX0hXIHNob3VsZCBiZSBjbGVh
cmVkIGZyb20gZGV2LT5od19mZWF0dXJlcw0KPiA+IHRvIHByZXZlbnQgdGhlIHN0YWNrIGZyb20g
YXR0ZW1wdGluZyB0byBlbmFibGUgYW4gdW5zdXBwb3J0ZWQgaGFyZHdhcmUNCj4gPiBvZmZsb2Fk
IGNvbmZpZ3VyYXRpb24uDQo+ID4NCj4gPiBGaXhlczogYTAyZTg5NjRlYWY5ICgidmlydGlvLW5l
dDogZXRodG9vbCBjb25maWd1cmFibGUgTFJPIikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBEaSBaaHUg
PHpodWRAaHlnb24uY24+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyB8
IDMgKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgYi9kcml2ZXJzL25ldC92aXJ0aW9f
bmV0LmMgaW5kZXgNCj4gPiA3MmQ2YTljNmE1YTIuLjQ5YTYwYWY2ODRkNSAxMDA2NDQNCj4gPiAt
LS0gYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMNCj4gPiArKysgYi9kcml2ZXJzL25ldC92aXJ0
aW9fbmV0LmMNCj4gPiBAQCAtNzA1OCw2ICs3MDU4LDkgQEAgc3RhdGljIGludCB2aXJ0bmV0X3By
b2JlKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2KQ0KPiA+ICAgICAgICAgfQ0KPiA+ICAgICAg
ICAgdmktPmd1ZXN0X29mZmxvYWRzX2NhcGFibGUgPSB2aS0+Z3Vlc3Rfb2ZmbG9hZHM7DQo+ID4N
Cj4gPiArICAgICAgIGlmICghKHZpLT5ndWVzdF9vZmZsb2Fkc19jYXBhYmxlICYgR1VFU1RfT0ZG
TE9BRF9HUk9fSFdfTUFTSykpDQo+ID4gKyAgICAgICAgICAgICAgIGRldi0+aHdfZmVhdHVyZXMg
Jj0gfk5FVElGX0ZfR1JPX0hXOw0KPiA+ICsNCj4gDQo+IEl0IGxvb2tzIHRvIG1lIHRoZSByb290
IGNhdXNlIGlzIHRoaXMgZHVyaW5nIHByb2JlPw0KPiANCj4gICAgICAgICBpZiAodmlydGlvX2hh
c19mZWF0dXJlKHZkZXYsIFZJUlRJT19ORVRfRl9DVFJMX0dVRVNUX09GRkxPQURTKSkNCj4gICAg
ICAgICAgICAgICAgIGRldi0+aHdfZmVhdHVyZXMgfD0gTkVUSUZfRl9HUk9fSFc7DQo+IA0KPiBU
aGFua3MNCg0KCUV4YWN0bHkuIEl0IHNlZW1zIHRoZSBjb2RlIGJsaW5kbHkgZW5hYmxlcyBORVRJ
Rl9GX0dST19IVyBhcyBsb25nIGFzIHRoZSANCmNvbnRyb2wgY2hhbm5lbCBpcyBwcmVzZW50LCB3
aXRob3V0IHZlcmlmeWluZyBpZiB0aGUgYmFja2VuZCBhY3R1YWxseSBzdXBwb3J0cyB0aGUNCm9m
ZmxvYWQgZmVhdHVyZXMuDQoNCj4gDQo+ID4gICAgICAgICBydG5sX3VubG9jaygpOw0KPiA+DQo+
ID4gICAgICAgICBlcnIgPSB2aXJ0bmV0X2NwdV9ub3RpZl9hZGQodmkpOw0KPiA+IC0tDQo+ID4g
Mi4zNC4xDQo+ID4NCj4gPg0KPiANCg0K

