Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D628A3DD50C;
	Wed, 30 Sep 2026 11:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790768469; cv=none; b=deTFO1KFj3AWZEYntM51zHeXEfd/nVG25z8mOkVmEIBzPeQ4eri9dKFoo/8X8HKe3uBAfgHOoxWzyEpxuMkMR7iIfOZwTJvwD9Gzk+wR5e7xiHJdQMZWccMgVKvxe3UWcah3wlS9nlGtAilzeUyoq7naDc/iOXH/qIAwYNyma0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790768469; c=relaxed/simple;
	bh=/mILoQ9z+hZzeVCIc73lgz8nWmElnX3oMVwGPPFCqI4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=tjC/+2PQ7kFTaUwpHNjBk3Es/dmGS2noFs/Sdevgc/coEugo5J4k0n9iKN0wMGeE17S0GM+1ko3T8U6pB6ipccxzzhF8Hsfjj6J/L6PYduOL2TCB40DQ/AC55lukaTs+EF4rLrjxa2IITT3pvsXbWVNFNNTRu6U581eT6igyZO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=b9Lx5OBv; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="b9Lx5OBv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=/mILoQ9z+hZzeVCIc73lgz8nWmElnX3oMVwGPPFCqI4=; b=b
	9Lx5OBveXW55kbWpjYIoU0k4eDV+4pYwM06HFcv7BKwbBblS80Auv7chaiPE0PJJ
	9Bsg5okIePDk/2GBx7KLAlBs2G+d48SacLu+A7Kg7sR2QmQrjnHYikSXfq++AE2G
	0QW5dCTmYmHgOmpBhkoYlFE97h7nXizzNgxXxA9lHY=
Received: from taozj888$163.com ( [2409:8a20:22c4:8eb0:4c8a:acdb:bd14:bd14]
 ) by ajax-webmail-wmsvr-40-110 (Coremail) ; Wed, 30 Sep 2026 19:40:40 +0800
 (CST)
Date: Wed, 30 Sep 2026 19:40:40 +0800 (CST)
From: taozj888  <taozj888@163.com>
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Cc: maintainer@kernel.org, linux-kernel@vger.kernel.org,
	conor.dooley@microchip.com, andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Subject: Re:Re: [PATCH] net: macb: rate limit netdev error info print in the
 data path
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <DLRMT6RJRL7T.3TV4K49YWR7DL@bootlin.com>
References: <20260920100920.65773-1-taozj888@163.com>
 <DLNFAUX8MFA1.3UMOGNLDKDRJM@bootlin.com>
 <45a98260.3bff.1a0eb4e2f51.Coremail.taozj888@163.com>
 <DLRMT6RJRL7T.3TV4K49YWR7DL@bootlin.com>
X-NTES-SC: AL_Qu2SAvudt0wv5iKebOkfm04bju07UMu2v/4l2Y9SOp9wjCfp0Doke1lFOkfq0dusByuliwGxfD9J8Md1ZZdWbr40hWlYFNH0cGL83UFKhwK2Gg==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <ad4079f.94a9.1a0f21de3d5.Coremail.taozj888@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:bigvCgD3P0c49bxqKtRRAA--.3366W
X-CM-SenderInfo: hwdr6yqyyyqiywtou0bp/xtbC3RhVHWq89TiFIAAA3z
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgoKCgoKSGkgVGhlbzoKCgpXaXRoIGFsbCB5b3VyIGluZm9ybWF0aW9uIHByb3ZpZGVkLCBJIHNl
bnQgdGhlIHBhdGNoIGluIFtQQVRDSCBuZXQgdjJdIGFnYWluLCBob3BlIGl0IHdvdWxkIHNhdGlz
ZnkgdGhlIHJlcXVpcmVtZW50LsKgCklmIG5vdCwgSSB3b3VsZCBhbHNvIGNoYW5nZSBpdCBhcyBy
ZXF1aXJlZC4KCgpUaGFuayB5b3UsCgoKWmlqaW4gVGFvCgoKCkF0IDIwMjYtMDktMjkgMTU6NDU6
NDcsICJUaMOpbyBMZWJydW4iIDx0aGVvLmxlYnJ1bkBib290bGluLmNvbT4gd3JvdGU6Cj5IZWxs
byBaaWppbiwKPgo+UGxlYXNlIHVzZSBpbnRlcmxlYXZlZCBwb3N0aW5nIGZvciByZXBsaWVzLCBu
b3QgdG9wIHBvc3RpbmcuCj4KPmh0dHBzOi8vZG9jcy5rZXJuZWwub3JnL3Byb2Nlc3Mvc3VibWl0
dGluZy1wYXRjaGVzLmh0bWwjdXNlLXRyaW1tZWQtaW50ZXJsZWF2ZWQtcmVwbGllcy1pbi1lbWFp
bC1kaXNjdXNzaW9ucwo+Cj5PbiBUdWUgU2VwIDI5LCAyMDI2IGF0IDU6NTYgQU0gQ0VTVCwgWmlq
aW4gd3JvdGU6Cj4+IFRoYW5rIHlvdSB2ZXJ5IG11Y2ggZm9yIHlvdXIga2luZGx5IHJlcGx5Lgo+
Pgo+PiBGb3IgYWxsIHlvdXIgY29uY2VybnMgaW4gdGhpcyBtYWlsIHRocmVhZCBhbmQgWzBdWzFd
LCBJIHRyeSB0byBnaXZlCj4+IG15IGFuc3dlcnMgaGVyZSBhbmQgaG9wZSBpdCBkb2VzIG5vdCBt
aXNzIGFueXRoaW5nOgo+Pgo+PiAxLiBZZXMsIEkgbWlzc2VkIHRoZSBwcmVmaXggW1BBVENIIG5l
dF0sIEkgd2lsbCBhZGQgaXQgaW4gbXkgbmV4dAo+PiBjb21taXQ7IEkgd291bGQgbGlrZSB0byBz
ZW5kIGl0IGFnYWluIGFzIHRoZSAxc3QgdmVyc2lvbgo+PiBzaW5jZSBJIG1pc3NlZCB0aGlzIG5l
ZWRlZCBwYXJ0IFtQQVRDSCBuZXRdOwo+Cj5JZiBwYXRjaCBzdGF5cyB0aGUgc2FtZSBpdCBpcyBP
SywgaWYgaXQgY2hhbmdlcyAoZm9yIGV4YW1wbGUgYmVjYXVzZSB5b3UKPmFkZCB0cmFpbGVycykg
dGhlbiB5b3UgbXVzdCBpdGVyYXRlIG9udG8gdjIuCj4KPj4gMi4gRm9yIHRoZSBUby9DYyBsaXN0
LCBJIHdpbGwgdXNlIGBnaXQgc2VuZC1lbWFpbCAtLWNjLWNtZD1zY3JpcHRzL2dldF9tYWludGFp
bmVyLnBsYCBhcyB5b3UgaW5kaWNhdGVkOwo+Pgo+PiAzLsKgVGhpcyB3aG9sZSBwYXRjaCBpcyAg
Tk9UIExMTSBnZW5lcmF0ZWQsIGl0J3MgcmVhbGx5IGEgYnVnIGhpdCBpbiBwcmFjdGljZSwgdGhl
ICJQSFlUMDAzNjowMCIgCj4+IGRldmljZSBuYW1lIGlzIHRoZSByZWFsIG5hbWUgdGhhdCBzaG93
ZWQgaW4gb3VyIGNvbnNvbGUgb3V0cHV0LCBJIGNhbid0IGp1c3QgaW1hZ2luZSBvciBtYWRlIHRo
aXMgbmFtZSBhbmQgaXQncyByZWFsbHkgb2Ygb3V0IG9mIG15IGltYWdpbmF0aW9uLgo+PiAgSSB0
aGluayBpdCBtYXkgYmUgcmVsYXRlZCB0byBhIHZlbmRvciB3aXRoIHNvbWUgb2YgdGhlIFBDSSBh
ZGRyIGJ1dCBJIHRoaW5rIGl0IG1heSBub3QgYmUgcG9saXRlIHRvIHNheSBpdCBkaXJlY3RseS4g
Cj4+IEFjdHVhbGx5IGhhbGx1Y2luYXRpbmcgYSBrZXJuZWwgbG9nIGV2ZW4gYSBrZXJuZWwgcGF0
Y2ggaXMgb3V0IG9mIG15IGtub3dsZWRnZSwgaWYgeW91IGtub3cgdG8gaG93IGFuZCAKPj4gd2lz
aCB0byB0ZWxsIG1lLCBJIHRoaW5rIGl0IHNob3VsZCBiZSByZWFsbHkgaW50ZXJlc3RpbmchCj4K
Pk5vIEkgZG9uJ3QgZW5jb3VyYWdlIHlvdSB0byBoYWxsdWNpbmF0ZSEgSXQncyB3aGF0IExMTXMg
ZG8gc29tZXRpbWVzCj53aGVuIHlvdSBhc2sgb25lIHRvIGdlbmVyYXRlIGEgY29tbWl0IG1lc3Nh
Z2UgZm9yIGEgYnVnIGZpeC4gVGhleSBoYXZlCj5zZWVuIHRvbnMgb2YgY29tbWl0cyB3aXRoIGxv
Z3Mgc28gdGhleSByZXByb2R1Y2UuCj4KPlsuLi5dCj4KPj4gNS4gRm9yIHRoZSBzZXZlcml0eSB0
YWcgYW5kIHNob3VsZCB0aGlzIGNhcnJ5IGEgRml4ZXMgdGFnIGFuZCBuYW1lIHRoZQo+PiBpbnRl
bmRlZCB0cmVlLCAgcGxlYXNlIGdpdmUgb3V0IGEgY2xlYXIgaW5kaWNhdGlvbiBmcm9tIHlvdXIK
Pj4gZXhwZXJpZW5jZXMgZm9yIHdoYXQgSSBkZXNjcmliZWQgYWJvdmUuIEkgcmVhbGx5IGhhdmUg
bm90IHRvbyBtdWNoCj4+IGtub3dsZWRnZSBhYm91dCB0aGF0Lgo+Cj5ZZXMuIFlvdSBwdXQgdGhv
c2UgdHdvIHRyYWlsZXJzOgo+Cj4gICBGaXhlczogODllNTc4NWZjOGE2ICgiW1BBVENIXSBBdG1l
bCBNQUNCIGV0aGVybmV0IGRyaXZlciIpCj4gICBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZwo+
Cj5TZWUgZG9jdW1lbnRhdGlvbiBsaW5rIGJlbG93IChvciBrZXJuZWwgZ2l0IGxvZyBmb3IgbWFu
eSBleGFtcGxlcykuCj4KPkluIHlvdXIgY2FzZSB5b3Ugd2FudCB0aGUgb2xkZXN0IGNvbW1pdCB0
aGF0IGludHJvZHVjZWQgb25lIG9mIHRob3NlCj5sb2dzLiBUaGUgbWFjYl9zdGFydF94bWl0KCkg
b25lIGZvciBleGFtcGxlIGdvdCBpbnRyb2R1Y2VkIHdpdGggdGhlCj5maXJzdCBkcml2ZXIgY29t
bWl0LCBzbyB0aGF0J3Mgd2hhdCB5b3UgdGFyZ2V0Lgo+Cj5odHRwczovL2RvY3Mua2VybmVsLm9y
Zy9wcm9jZXNzL3N1Ym1pdHRpbmctcGF0Y2hlcy5odG1sI2Rlc2NyaWJlLXlvdXItY2hhbmdlcwo+
Cj5UaGFua3MsCj4KPi0tCj5UaMOpbyBMZWJydW4sIEJvb3RsaW4KPkVtYmVkZGVkIExpbnV4IGFu
ZCBLZXJuZWwgZW5naW5lZXJpbmcKPmh0dHBzOi8vYm9vdGxpbi5jb20K
