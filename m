Received: from mail-m3288.qiye.163.com (mail-m3288.qiye.163.com [220.197.32.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B55D2F7F1C
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 03:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783048968; cv=none; b=WVN7ycws8Vbt8MjKEKfYJybe4bQsID+l1Qc+LFEoCxvuwhW/xIlQ0SMAbIXR9AAF1VN3rCe8sJ4Umh3litymbwzSrGsGJeudkzpL8yiJaOVr8LopqOCna0a5FN259rEbFuClobEE3hEVdZyucXnejhdAP8VxnA9uTxyHLbibknc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783048968; c=relaxed/simple;
	bh=IaLWZHJSWr7x6ofT8f/ukg8ugiR+wODDsKMWKABs44I=;
	h=Content-Type:Message-ID:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:From:Date; b=LU/OuX1PtnMkCh74wpW3pXQNWVpnhl1dX3HNoqs5BZYbYLAw7G2I/+xYQy44UHnnTjNUJxus6rTgTl3dIwV/e6Lc1d6jqLxwcbhYX1UQvBMV8+eEIryDmo2yhizi3oPaFID/p5Coc7PcQhoMjCwTTvHqvT/CzjvLjrzV5V0Rnyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=WKEHJ1Na; arc=none smtp.client-ip=220.197.32.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="WKEHJ1Na"
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AL*AMQBXKrBQu-oL24*L4apF.3.1783048649409.Hmail.220255722@seu.edu.cn>
To: Jakub Kicinski  <kuba@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, davem <davem@davemloft.net>, 
	edumazet <edumazet@google.com>, pabeni <pabeni@redhat.com>, 
	horms <horms@kernel.org>, sashal <sashal@kernel.org>, 
	bigeasy <bigeasy@linutronix.de>, netdev <netdev@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	"jianhao.xu" <jianhao.xu@seu.edu.cn>
Subject: =?UTF-8?B?UmU6IFtSRkMgUEFUQ0ggbmV0LW5leHRdIG5ldHBvbGw6IGhvbGQgUkNVIHdoaWxlIHdhbGtpbmcgbmFwaV9saXN0?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com Sirius_WEB_WIN_1.64.1
In-Reply-To: <20260629155833.1b1c2c26@kernel.org>
References: <20260627101228.1191586-1-runyu.xiao@seu.edu.cn>	<20260627142105.29f1322c@kernel.org>	<AFEAtADoKs22QyipHhKwe4op.3.1782623057057.Hmail.220255722@seu.edu.cn>	<akJSi1g0F2k9a3cs@gmail.com> <20260629155833.1b1c2c26@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: from 220255722@seu.edu.cn( [49.76.25.93] ) by ajax-webmail ( [127.0.0.1] ) ; Fri, 3 Jul 2026 11:17:29 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
Date: Fri, 3 Jul 2026 11:17:29 +0800 (GMT+08:00)
X-HM-Tid: 0a9f25fa2a2e02f2kunmac93f42c1985
X-HM-MType: 1
X-HM-NTES-SC: AL0_4z5B86Wr4Tz9jdMF+bhXMR3tWPmxBik09n1c1SEFUj2le1z3lyvjBYCCEg
	u3Pqm2XyVOnWNrtddGkF2jLxJpG2fwDKSuSBURfnb9ivkHaJlqs+U0JofCOKUgY2GKZJpINrsERV
	gWJjaDNh8br1sDPmbzzYpzW4Oz+VMBBucUjSE=
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaTEIeVkIaS08ZSENMHk1DT1YVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlPQlVMTVVJTlVCSFlXWRYaDxIVHRRZQVlPS0hVSktISk
	5PTFVKS0tVSkJLS1kG
DKIM-Signature: a=rsa-sha256;
	b=WKEHJ1NaXoBzO/zP+08w1kHh5+1aFsC+rQDjo88PS//y6+g1Egm84MhR2NsTmHkSZ4WHiS0so+r1pIwdfF3pqo3a6BOaLgbvSJXg9akIaxbCJqHCUObzwVSDfDTi8MaJiM5kaYBU0rvDp/SH9AJ3jfNKnEQTHRgl+qtECT8LL1k=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=IaLWZHJSWr7x6ofT8f/ukg8ugiR+wODDsKMWKABs44I=;
	h=date:mime-version:subject:message-id:from;

SGkgSmFrdWIsIEJyZW5vLAoKT24gTW9uLCAyOSBKdW4gMjAyNiAxNTo1ODozMyAtMDcwMCBKYWt1
YiBLaWNpbnNraSB3cm90ZToKJmd0OyBZZXMsIGxpa2UgQnJlbm8gc2F5cywgd2UgbmVlZCBhbiBp
bi1rZXJuZWwgcGF0aCB0aGF0IGNhbiB0cmlnZ2VyIHRoZQomZ3Q7IGlzc3VlLiBPdXQtb2YtdHJl
ZSByZXByb2R1Y2VycyBjYW4gYmUgdXNlZnVsIHRvIHZhbGlkYXRlIHRoZSBmaXgsIGJ1dAomZ3Q7
IHRoZXkgYXJlIG5vdCB1c2VmdWwgdG8gcHJvdmUgdGhhdCBhIHByb2JsZW0gYWN0dWFsbHkgZXhp
c3RzLgomZ3Q7CiZndDsgV2UgdHJ5IHRvIGF2b2lkIGRlZmVuc2l2ZSBwcm9ncmFtbWluZyBpbiB0
aGUga2VybmVsLgoKVW5kZXJzdG9vZCwgdGhhbmtzIGZvciB0aGUgY2xhcmlmaWNhdGlvbi4KClRo
ZSBvdXQtb2YtdHJlZSByZXByb2R1Y2VyIHdhcyBvbmx5IG1lYW50IGZvciBvdXIgaW50ZXJuYWwK
Q09ORklHX1BST1ZFX1JDVV9MSVNUIHRyaWFnZSwgbm90IGFzIHByb29mIHRoYXQgdGhlIHVwc3Ry
ZWFtIG5ldHBvbGwKcGF0aCBpcyBidWdneS4KCkFmdGVyIHlvdXIgZmVlZGJhY2ssIEkgcmV0ZXN0
ZWQgdGhpcyBvbiBsYXRlc3QgbmV0LW5leHQgd2l0aCBhIHJlYWwKaW4ta2VybmVsIG5ldGNvbnNv
bGUgcGF0aC4gSW4gdGhhdCBzZXR1cCBJIGNvdWxkIGhpdApuZXRwb2xsX3NlbmRfdWRwKCksIG5l
dHBvbGxfc2VuZF9za2IoKSwgYW5kIG5ldHBvbGxfcG9sbF9kZXYoKSwgYnV0IEkKY291bGQgbm90
IHJlcHJvZHVjZSB0aGUgUFJPVkVfUkNVX0xJU1Qgd2FybmluZyBvbiB0aGUgcmVhbCBwYXRoLgoK
R2l2ZW4gdGhhdCByZXN1bHQsIEkgYW0gbm90IGdvaW5nIHRvIGNvbnRpbnVlIHRoaXMgUkZDIGlu
IGl0cyBjdXJyZW50CmZvcm0uCgpUaGFua3MsClJ1bnl1
