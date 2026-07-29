Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B04247A0BE;
	Wed, 29 Jul 2026 12:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785327168; cv=none; b=cCzZ8E/I1XFk4FnkOhMgAH4Oz9KKKBu9epVyD2zv44d0yKdle48ZT5RFK4zEV9Qjiu3g4fpEN1mD1hj/JBN/MsesLslaXdEf9INAoWF2mKL1hMJm57qD9UYC+3zvDiDppve904oBC077Xe7pg7W+G4iO3yG2o7qVuKcHF3R5cZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785327168; c=relaxed/simple;
	bh=Q9NEvUPIlGEUbUf/np0VoJCi/NWhh6U47Omu/wHP1Zk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=ai/S3yvxjrogBo+oa3txICapQpy2cZFQDmWlMvLJqmxoDbu8zAxQIoaGME0h/l26ECJFt0CpDuQx2HdedgpuS4xY/S6FkaEPnoKrMIrOqX56s2bvnjCBNG7zMG9MGBZNd7ZRJfK4WeFETzFt/YhSmoKCgtEeeo6bHtzW9HRYWJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=b1pQrtr3; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="b1pQrtr3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=Q9NEvUPIlGEUbUf/np0VoJCi/NWhh6U47Omu/wHP1Zk=; b=b
	1pQrtr3JKqIKUGkHA+TGmmeUTkiHaVUoGnw78noiMKb/78TFQjEAz07WNpC1hw/T
	Ay+WCExnpNImSolykp8Kntq9fNHBvl647GrlwYZzGB7k3BDxHS9mrASi7NZ/JclZ
	/eOhSnm03h+qXP1V3NUNzRddlah2aYBdJo9tYay1bs=
Received: from 19888972804$163.com ( [111.19.71.39] ) by
 ajax-webmail-wmsvr-40-139 (Coremail) ; Wed, 29 Jul 2026 20:11:55 +0800
 (CST)
Date: Wed, 29 Jul 2026 20:11:55 +0800 (CST)
From: "jiale yao" <19888972804@163.com>
To: "Jiri Pirko" <jiri@resnulli.us>
Cc: "Andrew Lunn" <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	"Eric Dumazet" <edumazet@google.com>,
	"Jakub Kicinski" <kuba@kernel.org>,
	"Paolo Abeni" <pabeni@redhat.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH v2] team: reject CAN and IEEE 802.15.4 devices in
 team_port_add
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <amnESUrOtl0dXaXk@FV6GYCPJ69>
References: <20260728151240.89434-1-yaojiale02@163.com>
 <amnESUrOtl0dXaXk@FV6GYCPJ69>
X-NTES-SC: AL_Qu2TB/+ZuEkq4ymcY+kdmkcah+Y8XMu2vfQl24RWc9AFiSvg3zIeclVdMlHR7uKLLT6xtji2SAZ36MBKeKdGGKKFhNdGyXHK/tBYL7s3Aw==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <4d056e9f.8019.19fadc9deb5.Coremail.19888972804@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:iygvCgD31_YN7mlqg64nAA--.8092W
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzgyz7Wpp7gx2ZgAA3t
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

SG93IGFib3V0IGFkZGluZyBhIGhlbHBlciBpbiBpbmNsdWRlL2xpbnV4L2lmX2FycC5oLCBzaW1p
bGFyIHRvIGRldl9pc19tYWNfaGVhZGVyX3htaXQoKT8gUGVyaGFwcwpzb21ldGhpbmcgbGlrZSBk
ZXZfaXNfY2FuX29yX2llZWU4MDIxNTQoKT8KCgpBdCAyMDI2LTA3LTI5IDE3OjE1OjA2LCAiSmly
aSBQaXJrbyIgPGppcmlAcmVzbnVsbGkudXM+IHdyb3RlOgo+VHVlLCBKdWwgMjgsIDIwMjYgYXQg
MDU6MTI6NDBQTSArMDIwMCwgeWFvamlhbGUwMkAxNjMuY29tIHdyb3RlOgo+PkVuc2xhdmluZyBh
IENBTiBvciBJRUVFIDgwMi4xNS40IGRldmljZSAoZS5nLiB2eGNhbiwgd3BhbjApIHRvIGEKPj50
ZWFtIG1hc3RlciB0cmlnZ2VycyBhIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSBiZWNhdXNlIHRo
ZXNlCj4+ZGV2aWNlIHR5cGVzIHVzZSBkaWZmZXJlbnQgTGF5ZXIgMiBhcmNoaXRlY3R1cmVzIGZy
b20gRXRoZXJuZXQgYW5kCj4+dGhlIHRlYW0gZHJpdmVyIG5ldmVyIGluaXRpYWxpemVzIHRoZWly
IHByaXZhdGUgbWlkLWxheWVyIGRhdGEKPj5zdHJ1Y3R1cmVzLgo+Pgo+PlJlamVjdCBBUlBIUkRf
Q0FOLCBBUlBIUkRfSUVFRTgwMjE1NCwgYW5kIEFSUEhSRF9JRUVFODAyMTU0X01PTklUT1IKPj5k
ZXZpY2VzIGluIHRlYW1fcG9ydF9hZGQoKSwgbWlycm9yaW5nIHRoZSBleGlzdGluZyBDQU4gY2hl
Y2sgYWxyZWFkeQo+PnByZXNlbnQgaW4gdGhlIGJvbmRpbmcgZHJpdmVyIHNpbmNlIGNvbW1pdCA4
YmE2ODQ2NGU0NzggKCJib25kaW5nOgo+PnJlZnVzZSB0byBlbnNsYXZlIENBTiBkZXZpY2VzIiku
Cj4KPkNhbiB3ZSBwZXJoYXBzIGhhdmUgYSB1bmlmaWVkIGhlbHBlciBmb3IgdGhlIGNoZWNrPwo+
Cj4KPj4KPj5MaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvYjU4ZDk4ZTAtOGZlMy00
ZTRlLWI4YTUtYzFjN2U2NDdjY2NhQGhhcnRrb3BwLm5ldC8KPj5GaXhlczogMWQ3NmVmZTE1Nzdi
ICgidGVhbTogYWRkIHN1cHBvcnQgZm9yIG5vbi1ldGhlcm5ldCBkZXZpY2VzIikKPj5Bc3Npc3Rl
ZC1ieTogQ2xhdWRlOmRlZXBzZWVrLXY0LXBybwo+Cj5Mb29rcyB5b3VyIGFpIGdvbmUgYSBiaXQg
d2lsZCBoZXJlLi4uCj4KPgo+PlNpZ25lZC1vZmYtYnk6IEppYWxlIFlhbyA8eWFvamlhbGUwMkAx
NjMuY29tPgo+Pi0tLQo+PlYxIC0+IFYyOiBFeHRlbmRlZCBjaGVjayB0byBhbHNvIHJlamVjdCBB
UlBIUkRfSUVFRTgwMjE1NCBhbmQKPj4gIEFSUEhSRF9JRUVFODAyMTU0X01PTklUT1IgZGV2aWNl
cyBwZXIgcmV2aWV3IGZlZWRiYWNrCj4+LS0tCj4+IGRyaXZlcnMvbmV0L3RlYW0vdGVhbV9jb3Jl
LmMgfCAxMSArKysrKysrKysrKwo+PiAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKQo+
Pgo+PmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC90ZWFtL3RlYW1fY29yZS5jIGIvZHJpdmVycy9u
ZXQvdGVhbS90ZWFtX2NvcmUuYwo+PmluZGV4IGZlYWE3NWZiZjhmYy4uZDhjNDYxMDVmYzhiIDEw
MDY0NAo+Pi0tLSBhL2RyaXZlcnMvbmV0L3RlYW0vdGVhbV9jb3JlLmMKPj4rKysgYi9kcml2ZXJz
L25ldC90ZWFtL3RlYW1fY29yZS5jCj4+QEAgLTEyMjQsNiArMTIyNCwxNyBAQCBzdGF0aWMgaW50
IHRlYW1fcG9ydF9hZGQoc3RydWN0IHRlYW0gKnRlYW0sIHN0cnVjdCBuZXRfZGV2aWNlICpwb3J0
X2RldiwKPj4gCQlyZXR1cm4gLUVJTlZBTDsKPj4gCX0KPj4gCj4+KwkJaWYgKHBvcnRfZGV2LT50
eXBlID09IEFSUEhSRF9DQU4gfHwKPj4rCQkgICAgcG9ydF9kZXYtPnR5cGUgPT0gQVJQSFJEX0lF
RUU4MDIxNTQgfHwKPj4rCQkgICAgcG9ydF9kZXYtPnR5cGUgPT0gQVJQSFJEX0lFRUU4MDIxNTRf
TU9OSVRPUikgewo+PisJCQlOTF9TRVRfRVJSX01TRyhleHRhY2ssCj4+KwkJCQkgICAgICAgIkNB
TiBhbmQgSUVFRSA4MDIuMTUuNCBkZXZpY2VzIGNhbid0IGJlIGFkZGVkIGFzIGEgdGVhbSBwb3J0
Iik7Cj4+KwkJCW5ldGRldl9lcnIoZGV2LCAiRGV2aWNlICVzIGlzIENBTiBvciBJRUVFIDgwMi4x
NS40LiBUaGVzZSBkZXZpY2UgdHlwZXMgY2FuJ3QgYmUgYWRkZWQgYXMgYSB0ZWFtIHBvcnRcbiIs
Cj4+KwkJCQkgICBwb3J0bmFtZSk7Cj4+KwkJCXJldHVybiAtRUlOVkFMOwo+PisJCX0KPj4rCX0K
Pj4rCj4+IAlpZiAobmV0aWZfaXNfdGVhbV9wb3J0KHBvcnRfZGV2KSkgewo+PiAJCU5MX1NFVF9F
UlJfTVNHKGV4dGFjaywgIkRldmljZSBpcyBhbHJlYWR5IGEgcG9ydCBvZiBhIHRlYW0gZGV2aWNl
Iik7Cj4+IAkJbmV0ZGV2X2VycihkZXYsICJEZXZpY2UgJXMgaXMgYWxyZWFkeSBhIHBvcnQgIgo+
Pi0tIAo+PjIuMzQuMQo+Pgo=
