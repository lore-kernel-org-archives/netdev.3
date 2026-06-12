Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F518344DB5
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 14:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781273013; cv=none; b=XK27ZwKEbgyBeyT/nt5j/FzZ/jom11WLDfeo+hEyV6LcijpLnk/2Lo39jkfk+WY36ueJcN/G4i3pjCNhgh3BEsxoASVH1GM3g977McG22GxCS3D5YZtIRqr0vKiuc8z9c2iWYPYcM9HtD/bnw4GWBceoNrovtkwinC4XeBpcKfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781273013; c=relaxed/simple;
	bh=g+1P+p2AdfAp3LSSZplLbeIotJAVM57xXLrTdV3Oqdc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=asdO+UmXNDibH3t2aYsWG46w/ZXPRk7S4C9ONnIHqw9Jhzu4exEwCsOcOXh6xgOkkz240Obac0Em4RHBCCEQVyy98bx6m9FO3yxyzUOW7Zld+yBEP883j8KdHIjTgukqSoIy9dM5QAZb8KC1FIwxic4ppsbZMEbEmDi59lq3vYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=AvmBGWUB; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="AvmBGWUB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=g+1P+p2AdfAp3LSSZplLbeIotJAVM57xXLrTdV3Oqdc=; b=A
	vmBGWUBijhFHQmksb9soG9bvwwBYiLC8Rj9rFj486+GUrePzFVTosEil3DUal72A
	y2D432rGSlUjPkGheByfQU1+sRaS6pHpA5MOuGbkC/ztAfhgAJgHSJguXP8fgyKU
	PLViMAtU1WWjlZNnYEHv6PkLY9/ThG6et/E8nFzVO4=
Received: from zhulei_szu$163.com ( [240e:380:116c:64ae:2146:5436:950f:957]
 ) by ajax-webmail-wmsvr-40-149 (Coremail) ; Fri, 12 Jun 2026 22:02:47 +0800
 (CST)
Date: Fri, 12 Jun 2026 22:02:47 +0800 (CST)
From: zhulei  <zhulei_szu@163.com>
To: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
Cc: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re:RE: [PATCH net-next] ixgbevf: use vmalloc_array() replace
 vmalloc()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260403(27802f6d) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <PH0PR11MB5902A4F00E337C8A643B49C7F0182@PH0PR11MB5902.namprd11.prod.outlook.com>
References: <20260612065809.164623-1-zhulei_szu@163.com>
 <PH0PR11MB5902A4F00E337C8A643B49C7F0182@PH0PR11MB5902.namprd11.prod.outlook.com>
X-NTES-SC: AL_Qu2TA/6cvUEt4SecbekcnEYXgeY+Xcu0s/8u3YRWc+MGoTr8/x0GQHpBF0ra9f62KjuGviSKQgVV1MtlWIxlUjmW3+qyF8/8x2IcSDuocw==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <62176eef.a013.19ebc247a4c.Coremail.zhulei_szu@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:lSgvCgD3v_aIESxqT4QIAA--.10524W
X-CM-SenderInfo: x2kxzvxlbv63i6rwjhhfrp/xtbC8AgMWWosEYgjAQAA3Q
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

QXQgMjAyNi0wNi0xMiAxNzoxMToxNSwgIkphZ2llbHNraSwgSmVkcnplaiIgPGplZHJ6ZWouamFn
aWVsc2tpQGludGVsLmNvbT4gd3JvdGU6Cj5Gcm9tOiBMZWkgWmh1IDx6aHVsZWlfc3p1QDE2My5j
b20+IAo+U2VudDogRnJpZGF5LCBKdW5lIDEyLCAyMDI2IDg6NTggQU0KPgo+PkZyb206IExlaSBa
aHUgPHpodWxlaUBreWxpbm9zLmNuPgo+Pgo+PlJlcGxhY2Ugdm1hbGxvYygpIHdpdGggdGhlIGVx
dWl2YWxlbnQgYW5kIG1vcmUgcmVhZGFibGUKPj52bWFsbGNfYXJyYXkoKS4gVGhpcyBjaGFuZ2Ug
aGFzIG5vIGZ1bmN0aW9uYWwgaW1wYWN0Lgo+Cj5IaSwKPgo+SWYgdGhlcmUncyBubyBmdW5jdGlv
bmFsIGltcGFjdCB3aGF0IHdlIHdhbnQgdG8gYWNoaWV2ZQo+dGhyb3VnaCB0aGlzIHBhdGNoPyBX
aGF0J3MgdGhlIHBvaW50IG9mIHRvdWNoaW5nCj50aGUgY29kZSB3aGljaCB3b3JrcyBmb3IgYWdl
cyBpbiB0aGF0IGNhc2U/Cj4KCldoaWxlIHJlYWRpbmcgdGhlIGl4Z2JldmZfc2V0X3JpbmdwYXJh
bSBmdW5jdGlvbiwgSSBub3RpY2VkIHRoYXQKdHhfcmluZyBpcyBhbGxvY2F0ZWQgdXNpbmcgdm1h
bGxvY19hcnJheSgpLCBidXQgcnhfcmluZyBzdGlsbCB1c2Ugdm1hbGxvYygpLgoKSSBmb3VuZCB0
aGF0IGNvbW1pdCA0NDkwZDA3NWMyZDkgKCJldGg6IGludGVsOiB1c2Ugdm1hbGxvY19hcnJheSgp
IHRvCnNpbXBsaWZ5IGNvZGUiKSBkaWRuJ3QgY29tcGxldGVseSBtYWtlIHRoZSBjaGFuZ2UuIEkg
c2F3IGEgc2ltaWxhciBmaXggdXBzdHJlYW0KaW4gY29tbWl0IDE3NzJiN2Y4MDQ1YiAoIm1lZGlh
OiBwdDE6IHVzZSB2bWFsbG9jX2FycmF5IHRvIHNpbXBsaWZ5IGNvZGUiKSwKc28gSSdtIHRyeWlu
ZyB0byBtYWtlIHRoaXMgY29uc2lzdGVudCBoZXJlLgoKPj4KPj5TaWduZWQtb2ZmLWJ5OiBMZWkg
Wmh1IDx6aHVsZWlAa3lsaW5vcy5jbj4KPj4tLS0KPj4gZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50
ZWwvaXhnYmV2Zi9ldGh0b29sLmMgfCA1ICsrKy0tCj4+IDEgZmlsZSBjaGFuZ2VkLCAzIGluc2Vy
dGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4+Cj4+ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0
aGVybmV0L2ludGVsL2l4Z2JldmYvZXRodG9vbC5jIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50
ZWwvaXhnYmV2Zi9ldGh0b29sLmMKPj5pbmRleCA1MzdhNjBkNTI3NmYuLjcyYmRhYzhjMDA3NSAx
MDA2NDQKPj4tLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9peGdiZXZmL2V0aHRvb2wu
Ywo+PisrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2l4Z2JldmYvZXRodG9vbC5jCj4+
QEAgLTMyMiw4ICszMjIsOSBAQCBzdGF0aWMgaW50IGl4Z2JldmZfc2V0X3JpbmdwYXJhbShzdHJ1
Y3QgbmV0X2RldmljZSAqbmV0ZGV2LAo+PiAJfQo+PiAKPj4gCWlmIChuZXdfcnhfY291bnQgIT0g
YWRhcHRlci0+cnhfcmluZ19jb3VudCkgewo+Pi0JCXJ4X3JpbmcgPSB2bWFsbG9jKGFycmF5X3Np
emUoc2l6ZW9mKCpyeF9yaW5nKSwKPj4tCQkJCQkgICAgIGFkYXB0ZXItPm51bV9yeF9xdWV1ZXMp
KTsKPj4rCQlyeF9yaW5nID0gdm1hbGxvY19hcnJheShhZGFwdGVyLT5udW1fcnhfcXVldWVzLAo+
PisJCQkJCXNpemVvZigqcnhfcmluZykpOwo+PisKPj4gCQlpZiAoIXJ4X3JpbmcpIHsKPj4gCQkJ
ZXJyID0gLUVOT01FTTsKPj4gCQkJZ290byBjbGVhcl9yZXNldDsKPj4tLSAKPj4yLjI1LjEKPgo=

