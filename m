Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DCD23394C;
	Mon, 27 Jul 2026 12:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785154881; cv=none; b=rB9jvul/4DOtVpoJQyVh30mzshg6pKRoqMSzrjb15XxRGRSmIf2JiKGoH5VsSERp0HNeBdL0fOertBI3CQN1SZ9zG8QCZnzg3cX3E1OQvQhnx9QQEsDIBFsAgjy+f+ZGWADSZrrB4pVYl37J/255PElzvwHDQh1ewTkp8vXMF5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785154881; c=relaxed/simple;
	bh=/qgAaYQWaAbeyAP3PJcBiiWFMkeJAumbwCm16UYsfl8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZHaT/bymZtmUVq/KpuRARfr24Twp0rm/KsXWIloBtqQ5aLHHn3qQRm5wWWyensi5+JdNT5baKpWEEre6k5+kU6VTsFWSPKZhZAMY5bpV8349grsq1LAebM+RTN/xps6MSxaHUe/RGgtZfQMgomyeJFsjHv28VBUGh7OwbhTdL0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 485123E9B9;
	Mon, 27 Jul 2026 12:21:08 +0000 (UTC)
Message-ID: <03ff73c4dd251ed115b4f2149f9c0e9a1a2569a6.camel@hadess.net>
Subject: Re: [PATCH 0/4] usb: enable sysfs module symlink for more built-in
 drivers
From: Bastien Nocera <hadess@hadess.net>
To: Shashank Balaji <shashank.mahadasyam@sony.com>, Andrew Lunn	
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet	 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni	 <pabeni@redhat.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  Matthias Kaehlcke	 <mka@chromium.org>,
 Valentina Manea <valentina.manea.m@gmail.com>, Shuah Khan	
 <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>, Heikki Krogerus	
 <heikki.krogerus@linux.intel.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Daniel Palmer <daniel.palmer@sony.com>, Rahul
 Bukte <rahul.bukte@sony.com>, Tim Bird <tim.bird@sony.com>,
 linux-embedded@vger.kernel.org
Date: Mon, 27 Jul 2026 14:21:07 +0200
In-Reply-To: <20260722-mod_name_usb-v1-0-96d781530f3f@sony.com>
References: <20260722-mod_name_usb-v1-0-96d781530f3f@sony.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTF1VpgYiuSWtj1F0o3toIdSnVbZh0YOqLUcmkqOXRKcLnbr3AM3SOD1nKNCwgpzxEAUJ7CVLeQFTzX/etcWn4kpSv+4+aACvfElJJbyO7X0aQ5zaXsrLe/idtOjSeF41WVwhnDT89qARREA3zII5z2pyKfX9gsQ6Nusj9EetT9d63MikP3Q97QWxF8JJ1BJeZcOhM0eKF+h/dtQoaQCrpt0JPKT3Jl2NkC2Wjtxac7lKb5iovBvkmf0SzpY7ZCIJcO5eKSjig0r07x2897SF2p1AW+vxH5wZNUaO79o4OsibrDJrEQOi3xV7r1VnWQa+XWT/t43wU/VI0Ol72t8KtLOIBS14rMNBWnkrKLfKzGzq3ZrNNpOAx31GlAnUEt3z63DH3rQ+EqX27v8aZhmgmhHJViP4GN5uj0j6f5yK7EBaSULtjoQz7in+PAPXADUYo7rvS4TLAHXMfyGZuy4/KFmzVvFx+YYTW9CJTNa7uqbykPhN4XPvOJv7mXfDIGCy8MZ2uYGu4EBUqQu8ok/uMO1lUzcTqby3FLXY+B99KlXL79iYBsA/i50DtWBqadvvne6FQdKGBinHzzPO69x4xBjFZGtpCa9WuDK5QZKsPamcxvuLWtVqnph3FmhVzzmg8xO3XNNJBa4BVLy2nmWMPJyO5ZK+7oDVxOCMTtj17QSjA

T24gV2VkLCAyMDI2LTA3LTIyIGF0IDEyOjMxICswOTAwLCBTaGFzaGFuayBCYWxhamkgd3JvdGU6
Cj4gVGhpcyBpcyBpbiBjb250aW51YXRpb24gdG8gWzFdLgo+IAo+IHN0cnVjdCBkZXZpY2VfZHJp
dmVyJ3MgbW9kX25hbWUgaXMgbm90IHNldCBieSBhIG51bWJlciBvZiBidXMnIGRyaXZlcgo+IHJl
Z2lzdHJhdGlvbgo+IGZ1bmN0aW9ucy4gV2l0aG91dCB0aGF0LCBidWlsdC1pbiBkcml2ZXJzIGRv
bid0IGhhdmUgdGhlIG1vZHVsZQo+IHN5bWxpbmsgaW4gc3lzZnMuCj4gV2Ugd2FudCB0aGlzIHRv
IGdvIGZyb20gdW5ib3VuZCBkcml2ZXIgbmFtZSAtPiBtb2R1bGUgbmFtZSAtPiBrZXJuZWwKPiBj
b25maWcgbmFtZS4KPiBUaGlzIGlzIHVzZWZ1bCBvbiBlbWJlZGRlZCBwbGF0Zm9ybXMgdG8gbWlu
aW1pemUga2VybmVsIGNvbmZpZywKPiByZWR1Y2Uga2VybmVsIHNpemUsCj4gYW5kIHJlZHVjZSBi
b290IHRpbWUuCj4gCj4gVGhpcyBwYXRjaHNldCBhZGRzIG1vZF9uYW1lIHRvIHVzYi1yZWxhdGVk
IGRyaXZlcnMuCj4gCj4gWzFdCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjYwNTE4
LWFjcGlfbW9kX25hbWUtdjUtMC03MDVjY2M0MzA4ODVAc29ueS5jb20vCj4gCj4gU2lnbmVkLW9m
Zi1ieTogU2hhc2hhbmsgQmFsYWppIDxzaGFzaGFuay5tYWhhZGFzeWFtQHNvbnkuY29tPgoKUmV2
aWV3ZWQtYnk6IEJhc3RpZW4gTm9jZXJhIDxoYWRlc3NAaGFkZXNzLm5ldD4KCj4gLS0tCj4gU2hh
c2hhbmsgQmFsYWppICg0KToKPiDCoMKgwqDCoMKgIHVzYjogY29yZTogcGFzcyBUSElTX01PRFVM
RSBpbXBsaWNpdGx5IHRocm91Z2ggYSBtYWNybwo+IMKgwqDCoMKgwqAgdXNiOiBjb3JlOiBzZXQg
bW9kX25hbWUgaW4gZHJpdmVyIHJlZ2lzdHJhdGlvbgo+IMKgwqDCoMKgwqAgdXNiOiB0eXBlYzog
c2V0IG1vZF9uYW1lIGluIGRyaXZlciByZWdpc3RyYXRpb24KPiDCoMKgwqDCoMKgIHVzYjogdWxw
aTogc2V0IG1vZF9uYW1lIGluIGRyaXZlciByZWdpc3RyYXRpb24KPiAKPiDCoGluY2x1ZGUvbGlu
dXgvdWxwaS9kcml2ZXIuaMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgNCArKy0tCj4gwqBp
bmNsdWRlL2xpbnV4L3VzYi5owqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB8wqAgNiArKysrLS0KPiDCoGluY2x1ZGUvbGludXgvdXNiL3R5cGVjX2FsdG1vZGUuaMKgwqDC
oMKgwqDCoCB8wqAgNCArKy0tCj4gwqBkcml2ZXJzL25ldC91c2IvcjgxNTIuY8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAyICstCj4gwqBkcml2ZXJzL3VzYi9jb21tb24vdWxw
aS5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgNCArKystCj4gwqBkcml2ZXJzL3Vz
Yi9jb3JlL2RyaXZlci5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDEwICsrKysrKy0t
LS0KPiDCoGRyaXZlcnMvdXNiL2NvcmUvdXNiLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHzCoCAyICstCj4gwqBkcml2ZXJzL3VzYi9taXNjL2FwcGxlLW1maS1mYXN0Y2hhcmdl
LmMgfMKgIDIgKy0KPiDCoGRyaXZlcnMvdXNiL21pc2Mvb25ib2FyZF91c2JfZGV2LmPCoMKgwqDC
oMKgIHzCoCAyICstCj4gwqBkcml2ZXJzL3VzYi90eXBlYy9idXMuY8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHzCoCA0ICsrKy0KPiDCoGRyaXZlcnMvdXNiL3VzYmlwL3N0dWJfbWFp
bi5jwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDIgKy0KPiDCoDExIGZpbGVzIGNoYW5nZWQsIDI1
IGluc2VydGlvbnMoKyksIDE3IGRlbGV0aW9ucygtKQo+IC0tLQo+IGJhc2UtY29tbWl0OiAyNDg5
NTFkZGMxNGRlODRkZTM5MTBmOWIxM2Y1MTQ5MWE4Y2Q5MWRmCj4gY2hhbmdlLWlkOiAyMDI2MDcy
Mi1tb2RfbmFtZV91c2ItZTNiYWY1OGUxZTFlCj4gCj4gQmVzdCByZWdhcmRzLAo+IC0twqAgCj4g
U2hhc2hhbmsgQmFsYWppIDxzaGFzaGFuay5tYWhhZGFzeWFtQHNvbnkuY29tPgo=

