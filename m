Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34843AE6F5;
	Thu, 24 Sep 2026 06:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790231828; cv=none; b=HZkb8Ylh2wpCFCjOUKZolYtFa0DqQyLK3R/52CqQVAVA0lQQ0XOCMmfCy7Q6j3xBCMSecw7TsFMWZBZ3WrEe79xTaGa59xgHBAbunCdyvlWvTQIqnWTjbuCpZH1/fL8o5mbf7f3fFlDrp7KG/eOu6WJHPFrcBshqov60UT/fGow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790231828; c=relaxed/simple;
	bh=Ix2tdQGfP0CbwPZUkjPiWsLjqfFnrXTm6zJRNCw+IeM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=Xzmic95AYM+3DD/WsGi79mNo2GtUbPIY0f9TKQM4hwU9l31xCmI+mFdEITrnNtQ7V7p8PwaKGj1ONjXMVbkeAD+fIEeTcmlPGHtpXhjEIKmyjKqvMfUMzqP7vUVbEowHg60IDqapitGmybIMoxXD1AG7gNeJErT0UlZ4ZylhvbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=BAJNLeWY; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="BAJNLeWY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=Ix2tdQGfP0CbwPZUkjPiWsLjqfFnrXTm6zJRNCw+IeM=; b=B
	AJNLeWY7GPKdofFQv0u60zUmjciMxamk6bnckVCe0QnIqKGkYH2tEXt0VsmkreLz
	9SBWFn4hLJQPneuwcY3SV+3BvXl5QQZqxPo4P07SgpUF2de3Nh0JWCNua4dTx8sv
	f3W/+1gTMNoinjR2H05oxAZC7sV0jdK3p0UuspU/ZM=
Date: Thu, 24 Sep 2026 14:36:19 +0800 (CST)
From: taozj888  <taozj888@163.com>
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: linux-kernel@vger.kernel.org, theo.lebrun@bootlin.com,
	conor.dooley@microchip.com, andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Subject: Re:Re: [PATCH] net: macb: rate limit netdev error info print in the
 data path
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <20260923181733.1af289cf@kernel.org>
References: <20260920100920.65773-1-taozj888@163.com>
 <20260923181733.1af289cf@kernel.org>
X-NTES-SC: AL_Qu2SAv6Yvk8s7yCcZukfk0cUj+c7WcCwvPkm3YRec8gEiQ3SxgknZl5DHlLm096lEQ+VqhiwWTlPyuJ5V6hxgQnTw3gZjW62rzTAFxFVpw==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <5f38e818.561f.1a0d22116ec.Coremail.taozj888@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:eygvCgD3ty7jxLRqc9lNAA--.62767W
X-CM-SenderInfo: hwdr6yqyyyqiywtou0bp/xtbC+QMx+Gq0xOMQJQAA3-
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgoKCgoKCgpIaSBKYWt1YjoKClllcywgd2UgaGFkIHRoZSBhY3R1YWwgSFcgZm9yIG91ciBwcm9k
dWN0aW9uIGVudmlyb25tZW50IHdoaWNoIGlzIGJhc2VkIG9uIGEgY2hpcAp0aGF0IHVzZWQgdGhl
IENhZGVuY2UgTUFDQiBpbXBsZW1lbnRhdGlvbiwgYW5kIGl0IHJlYWxseSBib3RoZXJlZCBvdXIg
Ym9vdGluZyBwcm9jZXNzCnNpbmNlIGl0IHJlY2VpdmVkIGEgbG90IG9mIGp1bW9iIHBrdHMgd2hp
Y2ggYXJlIGp1c3Qgb3ZlciB0aGUgY3VycmVudCBNVFUgb2YgdGhlIGRyaXZlcgphbmQgaXQgaGFz
IHRvIHNob3cgdGhvc2UgZXJyb3IgbXNncy4gCgpUaGUgaXNzdWUgd2FzIHJlcG9ydGVkIGJ5IG91
ciBwcm9kdWN0aW9uIHNlY3Rpb24uIEFjdHVhbGx5IHRoZSBlcnIgbXNnIGhlcmUgc2hvdWxkIGlu
Y2x1ZGUgYSB0aW1lc3RhbXAKYXQgdGhlIGJlZ2lubmluZywgbG9va3MgbGlrZToKWyAzMTguNTk0
OTUwXVsgQzBdIG1hY2IgUEhZVDAwMzY6MDAgZXRoMDogbm90IHdob2xlIGZyYW1lIHBvaW50ZWQg
YnkgZGVzY3JpcHRvcgpbIDMxOC42MDIzNjZdWyBDMF0gbWFjYiBQSFlUMDAzNjowMCBldGgwOiBu
b3Qgd2hvbGUgZnJhbWUgcG9pbnRlZCBieSBkZXNjcmlwdG9yCi4uLgoKYnV0IGZvciBzaW1wbGlj
aXR5LCBJIGp1c3QgcmVtb3ZlZCB0aGF0IHBhcnQuCgpJIHdpbGwgcHV0IHNvbWUgb2YgdGhlIEhX
IGluZm8gaW50byB0aGUgY29tbWl0IG1zZyBhcyB3aGF0IHlvdSBpbmRpY2F0ZWQuCgpUaGFua3Ms
CgpaaWppbiBUYW8KCgoKCgoKQXQgMjAyNi0wOS0yNCAwOToxNzo0NiwgIkpha3ViIEtpY2luc2tp
IiA8a3ViYUBrZXJuZWwub3JnPiB3cm90ZToKPk9uIFN1biwgMjAgU2VwIDIwMjYgMTg6MDk6MjAg
KzA4MDAgWmlqaW4gVGFvIHdyb3RlOgo+PiBOb3cgdGhlIE1BQ0IgZXRoZXJuZXQgZHJpdmVyIHBy
aW50IHRoZSBuZXRkZXYgZXJyb3IgaW5mb3JtYXRpb24KPj4gZGlyZWN0bHkgYnkgbmV0ZGV2X2Vy
cigpLCB3aGljaCB3b3VsZCBsZWFkIHRvIGEgbGFyZ2UgbnVtYmVyIG9mCj4+IGVycm9yIGluZm9y
bWF0aW9uIHByaW50IGlmIHRoZXJlIHdhcyBhIHNpZ25pZmljYW50IG51bWJlciBvZgo+PiBlcnJv
ciBvciBqdXN0IGp1bWJvIHBhY2tldHMgZXhjZWVkaW5nIHRoZSBNVFUgcmVjZWl2ZWQgd2hlbiBi
b290aW5nLgo+PiBGb3IgZXhhbXBsZSwgaXQgd291bGQgcHJpbnQgYSBsYXJnZSBudW1iZXIgb2Y6
Cj4+IAo+PiBtYWNiIFBIWVQwMDM2OjAwIGV0aDA6IG5vdCB3aG9sZSBmcmFtZSBwb2ludGVkIGJ5
IGRlc2NyaXB0b3IKPj4gbWFjYiBQSFlUMDAzNjowMCBldGgwOiBub3Qgd2hvbGUgZnJhbWUgcG9p
bnRlZCBieSBkZXNjcmlwdG9yCj4+IC4uLgo+Cj5EbyB5b3UgaGF2ZSB0aGUgSFcgb3IgeW91J3Jl
IGFjdGluZyBiYXNlZCBvbiBMTE0gb3V0cHV0Pwo+SWYgdGhlIGxhdHRlciwgYW5kIHNpbmNlIHlv
dSBjYW4ndCBmb2xsb3cgdGhlIHByb2Nlc3MgcGxlYXNlCj5kb24ndCBwb3N0IGFueSBtb3JlIHN1
Y2ggcGF0Y2hlcy4KPgo+SWYgeW91IGRvIGhhdmUgdGhlIEhXIHRvIHRlc3QgdGhpcyAtIHB1dCBp
bnRvIHRoZSBjb21taXQgbWVzc2FnZQo+d2hhdCBIVyB5b3UgaGF2ZSwgYW5kIGNvdmVyaW5nIGFs
bCB0aGUgY2FzZXMuCj4tLSAKPnB3LWJvdDogY3IK
