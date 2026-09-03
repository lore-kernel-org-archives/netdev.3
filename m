Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE51426D0A
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 09:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788426127; cv=none; b=cYDnKP7Yh7exY0M1fPFHR1MnSPRWKEUpxM7I24p4ZE5n0qSs9QIk1+UScWsJOWyjq7FnH3KXHiBteZAwmyIEEEb1pbBjRybHfpXCPiqyaAspFbcNdiTcY4dc9kyq8j9sBE1rqdhXC26dM6FgAB2+oerhTmFFdHBuHySi3aiLlTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788426127; c=relaxed/simple;
	bh=7gQd6GfKxv8QmrquOpH3JSu4vx9nFTsdaUMNVH/5710=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=X8y3I3dSJiebyFvftD/FSE56+WIUzkr8HPFGW4m1KCJ36t6q8IS2VDxLqWYIYRoK65cEdTQ0fSkPGwHRkw91jl1/zCkwJvdgT3+aPbaBHbxmc5HEo3exCJUBDoL0zLVUuewIb8mADJ9Ptl6LLFUELij1w+ocvfLV9FB7sbXQ0d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=atTsFKwG; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="atTsFKwG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=7gQd6GfKxv8QmrquOpH3JSu4vx9nFTsdaUMNVH/5710=; b=a
	tTsFKwGbs6Qz0B52qUkixc1RdcR365TnOVZRPM8HfJRHovl/FeS3K5wuVPw/teXW
	94DWjjQw4DHJDZOCYlujvGtQ7wcfqVw8Zy8yn+P+A2TOEJR/r1SiR2gAqci5VAVJ
	HE7sCsKE/XeQ7srdGksFwtUzdhhK3mh6J9oaJriSNM=
Date: Thu, 3 Sep 2026 17:01:29 +0800 (CST)
From: huhai  <15815827059@163.com>
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: "Xuanqiang Luo" <xuanqiang.luo@linux.dev>, netdev@vger.kernel.org,
	huhai <huhai@kylinos.cn>, andrew@lunn.ch,
	divya.koppera@microchip.com
Subject: Re:Re: [PATCH] net: phy: microchip_t1: fix NULL pointer dereference
 in lan887x_phy_init()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <20260902155825.63974224@kernel.org>
References: <20260902083342.221050-1-15815827059@163.com>
 <a59a2f22-dca0-443b-a0de-f580ed2c4438@linux.dev>
 <20260902155825.63974224@kernel.org>
X-NTES-SC: AL_Qu2TCviZuUgj7yGRZOkcmkgajuc/XMK3ufsv24FSc/EEiBv02AIGcVVFFFbt7dKjGz6Kmz2YbDhj9uFeZYt/9EXYuuR/Q0tkZQfXmQWIlQ==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <2a9bd784.78bc.1a0668072f0.Coremail.15815827059@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:digvCgD3txRpN5lqAeQ+AA--.2522W
X-CM-SenderInfo: rprvmiivyslimvzbiqqrwthudrp/xtbC8AnobmqZN2lGQAAA3U
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

QXQgMjAyNi0wOS0wMyAwNjo1ODoyNSwgIkpha3ViIEtpY2luc2tpIiA8a3ViYUBrZXJuZWwub3Jn
PiB3cm90ZToKPk9uIFdlZCwgMiBTZXAgMjAyNiAxNzoxNjo0OCArMDgwMCBYdWFucWlhbmcgTHVv
IHdyb3RlOgo+PiA+IG1jaHBfcmRzX3B0cF9wcm9iZSgpIG1heSByZXR1cm4gTlVMTCB3aGVuIENP
TkZJR19QVFBfMTU4OF9DTE9DSyBpcyBkaXNhYmxlZC4gIAo+PiAKPj4gV2hlbiBDT05GSUdfTUlD
Uk9DSElQX1BIWV9SRFNfUFRQPW4sIHRoZSBzdHViIGZvcgo+PiBtY2hwX3Jkc19wdHBfcHJvYmUo
KSBhbHNvIHJldHVybnMgTlVMTCwgZXZlbiBpZgo+PiBDT05GSUdfUFRQXzE1ODhfQ0xPQ0s9eS4g
UGxlYXNlIG1lbnRpb24gdGhpcyBjYXNlIGluIHRoZSBjb21taXQgbWVzc2FnZS4KPgo+U3BlYWtp
bmcgb2YgaW1wcm92ZW1lbnRzIHRvIHRoZSBjb21taXRzIG1lc3NhZ2UgLSBwbGVhc2UgYWxzbyBl
eHBsYWluCj5ob3cgdGhlIGlzc3VlIHdhcyBmb3VuZCwgcmVwcm9kdWNlZCwgYW5kIGZpeCB2YWxp
ZGF0ZWQuCj4KClRoZSBpc3N1ZSB3YXMgZGlzY292ZXJlZCB2aWEgc21hdGNoOgoKbWFrZSBDSEVD
Sz0ic21hdGNoIC1wPWtlcm5lbCIgIEM9MiAgZHJpdmVycy9uZXQvcGh5L21pY3JvY2hpcF90MS5v
CiAgQ0hFQ0sgICBzY3JpcHRzL21vZC9lbXB0eS5jCiAgREVTQ0VORCBvYmp0b29sCiAgQ0hFQ0sg
ICBkcml2ZXJzL25ldC9waHkvbWljcm9jaGlwX3QxLmMKZHJpdmVycy9uZXQvcGh5L21pY3JvY2hp
cF90MS5jOjEyOTUgbGFuODg3eF9waHlfaW5pdCgpIHdhcm46ICdwcml2LT5jbG9jaycgY2FuIGFs
c28gYmUgTlVMTAoKSSB3aWxsIGFkZCB0aGUgYWJvdmUgaW5mb3JtYXRpb24gdG8gdGhlIGNvbW1p
dCBtZXNzYWdlIGluIHRoZSBuZXh0IHZlcnNpb24gb2YgdGhlIHBhdGNoLgoKVGhlbiwgZGlzYXNz
ZW1ibHkgY29uZmlybWVkIHRoYXQgYSBudWxsIHBvaW50ZXIgZGVyZWZlcmVuY2UgZG9lcyBpbmRl
ZWQgZXhpc3Q6CgpvYmpkdW1wIC1kclN3QyAtLW5vLXNob3ctcmF3LWluc24gLS1kaXNhc3NlbWJs
ZT1sYW44ODd4X3BoeV9pbml0IGRyaXZlcnMvbmV0L3BoeS9taWNyb2NoaXBfdDEubwogICAgICAg
ICAgICAgCXByaXYtPmNsb2NrID0gbWNocF9yZHNfcHRwX3Byb2JlKHBoeWRldiwgTURJT19NTURf
VkVORDEsCiAgICAxMGMyOiAgICAgICBtb3ZxICAgJDB4MCwweDMwKCVyMTMpICAgIyBwcml2LT5j
bG9jayA9IE5VTEwKICAgICAgICAgICAgICAgIC4uLiAuLi4KICAgICAgICAgICAgICAgIHByaXYt
PmNsb2NrLT5ldmVudF9waW4gPSAzOwogICAgMTBlNzogICAgICAgbW92ICAgIDB4MzAoJXIxMyks
JXJheCAgICMgcmF4ID0gcHJpdi0+Y2xvY2sgPSBOVUxMCiAgICAxMGViOiAgICAgICBtb3ZsICAg
JDB4MywweDE5MCglcmF4KSAgIyAqKHUzMiAqKShOVUxMICsgMHgxOTApID0gMwoKQWRkaXRpb25h
bGx5LCBJIGRvIG5vdCBoYXZlIGhhcmR3YXJlIGF2YWlsYWJsZSB0byB2ZXJpZnkgYW5kIHJlcHJv
ZHVjZSB0aGUgaXNzdWUsCml0IHdhcyBpZGVudGlmaWVkIHB1cmVseSB0aHJvdWdoIGFuYWx5c2lz
LiBBZnRlciBhcHBseWluZyBhIHBhdGNoLCBzbWF0Y2ggbm8gbG9uZ2VyIApwcm9kdWNlcyB0aGUg
d2FybmluZy4KCj5JdCdkIGJlIGdvb2QgdG8gaW1wcm92ZSB0aGUgc3BhbGxpbmcgb2YgeW91ciBu
YW1lIChyYXRoZXIganVzdAo+cmVwZWF0aW5nIHlvdXIgZW1haWwgbG9naW4pIGEgbGl0dGxlOyBv
ciBqdXN0IGFkZCB5b3VyIHJlYWwgbmFtZSBpbgo+dW5pY29kZSBjaGFyYWN0ZXJzIGluICgpIGJy
YWNrZXRzLCBsaWtlIGh1aGFpICgkdW5pY29kZSBjaGFycykgPGVtYWlsPi4KClJlZ2FyZGluZyB0
aGUgbmFtZSBzcGVsbGluZyBzdWdnZXN0aW9uLCBJIHdpbGwgdXBkYXRlIG15IHNpZ25lZC1vZmYt
YnkKbGluZSB0byB1c2UgbXkgZnVsbCBFbmdsaXNoIG5hbWUgaW4gdGhlIG5leHQgdmVyc2lvbiBv
ZiB0aGUgcGF0Y2guCgpUaGFua3Mu
