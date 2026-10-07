Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C1322157B;
	Wed,  7 Oct 2026 05:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791352591; cv=none; b=aVfiWuobps/UVE08BBhKVdas6aYmkBa/WpAArlNE0l7rIKRjkTeQIFNAxmRp5PCjXAhrtVhU2cfoVdfKxWjXgVe/zhOECnKX1Dr00B8IXTdEUR7iGNoQe3w/oyuqnRUGAYu3OSoH3io3F0nkZgMWCLYOBYYcYfOvLSrDEA2NKbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791352591; c=relaxed/simple;
	bh=mJktbMKqkWI+drqysq4fvT3ON0LQDXK0FthOfNETKSQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=eGyF2JimdpeqbP6CU6r9F41VKj1ELLOtPQ2GXxI86Om44pG0X0uj310DpHPtWjiW6AIf09sxn8Z5a920B+Hm6PFAMq25LG1+Nykpu01c91r05y1bh1GW5uSQadcSe/5IS+itL6Vf/IV5vd5TDgb9rcR+ZMC8M8UB9qcDkvxrkI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JTA6umid; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JTA6umid"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=mJktbMKqkWI+drqysq4fvT3ON0LQDXK0FthOfNETKSQ=; b=J
	TA6umidfbnDe6XzwB2s8epAmcjjHPTuUeMfOHmJVXhkWZw9eXbYmHWNIjV1brUZy
	L9QpCmzLOUB6zZaBiLWw1JIyouGJXkSXfvu98LoLK8dUvX2/Pb+6I62govDCRfZC
	KPjfFt3X0HaaEKpQ6jXiLGhHZ4Ma3BjjGSuAe8bqs4=
Received: from taozj888$163.com ( [2409:8a20:22c4:8eb0:343f:2daa:6f8d:39d4]
 ) by ajax-webmail-wmsvr-40-135 (Coremail) ; Wed, 7 Oct 2026 13:55:13 +0800
 (CST)
Date: Wed, 7 Oct 2026 13:55:13 +0800 (CST)
From: taozj888  <taozj888@163.com>
To: "Jacob Keller" <jacob.e.keller@intel.com>
Cc: theo.lebrun@bootlin.com, "Conor Dooley" <conor.dooley@microchip.com>,
	"Andrew Lunn" <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	"Eric Dumazet" <edumazet@google.com>,
	"Jakub Kicinski" <kuba@kernel.org>,
	"Paolo Abeni" <pabeni@redhat.com>,
	"Haavard Skinnemoen" <hskinnemoen@atmel.com>,
	"Jeff Garzik" <jeff@garzik.org>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	"open list" <linux-kernel@vger.kernel.org>
Subject: Re:Re: [PATCH net v3 0/1] brief description about the patch and its
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <d69249a8-210f-405d-9cd5-715245fecb8c@intel.com>
References: <20261004133916.559956-1-taozj888@163.com>
 <d69249a8-210f-405d-9cd5-715245fecb8c@intel.com>
X-NTES-SC: AL_Qu2SA/+evU0q5SCRbekfm04bju07UMu2v/4l2Y9SOp9wjB7o6gYwQ19jPl3k/tKrLyeSrye4aDhI+M53XaxnWb8MjAo8Xe02rpUtbjWyl3VrIg==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <66801d4d.16ab.1a114ee2256.Coremail.taozj888@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:hygvCgD3_6DB3sVqCRIcAA--.14498W
X-CM-SenderInfo: hwdr6yqyyyqiywtou0bp/xtbC3QHzu2rF3sGTOAAA3P
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgoKCgoKCgoKCgoKCgpIaSBKYWNvYjoKClRoYW5rcy4KWmlqaW4gVGFvCgpBdCAyMDI2LTEwLTA3
IDA1OjIzOjMzLCAiSmFjb2IgS2VsbGVyIiA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPiB3cm90
ZToKPk9uIDEwLzQvMjAyNiA2OjM5IEFNLCB0YW96ajg4OEAxNjMuY29tIHdyb3RlOgo+PiBGcm9t
OiB0YW96aWppbiA8dGFvemo4ODhAMTYzLmNvbT4KPj4gCj4+IAo+PiBUaGlzIHBhdGNoIGlzIHRp
dGxlZCBhczoKPj4gICBuZXQ6IG1hY2I6IHJhdGUgbGltaXQgbmV0ZGV2IGVycm9yIGluZm8gcHJp
bnQgaW4gdGhlIGRhdGEgcGF0aAo+PiAKPj4gQ2hhbmdlcyBzaW5jZSB2MToKPj4gCj4+IHYzOiAK
Pj4gLSBhZGQgdGhpcyBjaGFuZ2UgbG9nIHNpbmNlIHYyIG1pc3NpbmcgaXQKPj4gLSBkcm9wIHRo
ZSBibGFuayBsaW5lIGJldHdlZW4gdGhlIGFzc2lnbm1lbnQgc2VudGVuY2UgYW5kIHRoZSBjb21t
aXQKPj4gICBpbmZvCj4+IAo+PiB2MjoKPj4gCj4+IC0gdXBkYXRlIHRoZSBjb21taXQgbWVzc2Fn
ZSB3aXRoIHRoZSByZWFzb24gd2h5IHRoZSB1bmxpbWl0IHByaW50cyB3b3VsZAo+PiAgIGJvdGhl
ci9kZWxheSBib290aW5nIHByb2Nlc3MKPj4gLSB1cGRhdGUgdGhlIGNvbW1pdCBtZXNzYWdlIHdp
dGggdGhlIEZpeCBjb21taXQgaWQgcHJvdmlkZWQgd2hpY2ggaXMKPj4gICBzdWdnZXN0ZWQgYnkg
VGiopm8gTGVicnVuPHRoZW8ubGVicnVuQGJvb3RsaW4uY29tPgo+PiAtIHVwZGF0ZSB0aGUgY29t
bWl0IG1lc3NhZ2Ugd2l0aCB3aGF0IHBhY2tldCB0eXBlIHdvdWxkIHRyaWdnZXIgdGhlCj4+ICAg
ZXJyb3IgcHJpbnRpbmdzIG1vcmUgZWFzaWx5Lgo+PiAKPj4gdjE6Cj4+IAo+PiAtIGluaXRpYWwg
Y29tbWl0Cj4+IAo+Cj5Gb3Igc2luZ2xlIHBhdGNoZXMsIGl0IGlzIHR5cGljYWwgdG8gc2VuZCB0
aGlzIGFzIHBhcnQgb2YgdGhlIHNhbWUKCj5tZXNzYWdlIGJlbG93IHlvdXIgY29tbWl0IG1lc3Nh
Z2Ugd2l0aCAnLS0tJy4KCgpPSywgSSB3aWxsIGFkZCB0aGUgY2hhbmdlbG9nIGluIHRoZSBjb21t
aXQgbWVzc2FnZSBiZWxvdyAnLS0tJyBpbiB0aGUgbmV4dCBwYXRjaC4+Cj5UbyBtYWtlIHRoYXQg
ZWFzaWVyIHRvIGhhbmRsZSwgaWYgeW91IHVzZSBnaXQgZm9ybWF0LXBhdGNoIGFuZCBnaXQKPnNl
bmQtZW1haWwgeW91IGNhbiB1c2UgLS1hbm5vdGF0ZSB3aXRoIGdpdCBzZW5kLWVtYWlsIHRvIGlu
c2VydCB0aGUKPmNvbnRlbnRzIGJlZm9yZSBzZW5kaW5nIHRoZSBlbWFpbC4gSWYgeW91IHVzZSBi
NCwgaXQgd2lsbCBhdXRvbWF0aWNhbGx5Cj5nZW5lcmF0ZSB0aGUgY29ycmVjdCBmb3JtYXQgZnJv
bSBpdHMgY292ZXIgbGV0dGVyIGFuZCB0aGUgaW5kaXZpZHVhbCBwYXRjaC4KPgo+SWYgeW91IGRv
IHNlbmQgYSBzdGFuZGFsb25lIGNvdmVyIGxldHRlciwgdGhlIHN1YmplY3Qgd291bGQgYmUgYmV0
dGVyIGFzCj5qdXN0IHJlcGVhdGluZyB0aGUgc3ViamVjdCBmb3IgdGhlIGluZGl2aWR1YWwgcGF0
Y2guCj4KPkkgZG9uJ3QgcmVjYWxsIGlmIG5ldGRldiBoYXMgYW55IGVuZm9yY2VkIG9yIGVuY29k
ZWQgcG9saWN5IGhlcmUsIHNvCj50aGlzIGlzIGp1c3QgYSBjb21tZW50IHRvIGhvcGVmdWxseSBo
ZWxwIGVhc2UgZnV0dXJlIGNvbnRyaWJ1dGlvbnMuCj4KPlRoYW5rcywKPkpha2UKPgo+PiBCZXN0
IFJlZ2FyZHMsCj4+IAo+PiBaaWppbiBUYW8KPj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L2NhZGVu
Y2UvbWFjYl9tYWluLmMgfCAxNCArKysrKysrKy0tLS0tLQo+PiAgMSBmaWxlIGNoYW5nZWQsIDgg
aW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKPj4gCg==
