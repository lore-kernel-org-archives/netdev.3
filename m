Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97A532B125;
	Wed,  1 Jul 2026 03:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782875601; cv=none; b=HSEoqybLOJbAi6x7arHuuH45QtFag98z3q2Qj1dzXNoNaCAKMElhkIBk985IhkjepzqYrKcnmIPJ5nEKdqHSskfGzFSzJj2cX8nZK5iAez8cbiE/Yeni5Rhq/A9LPnUkwqXDlt4vmdp8WDbPxAZdgft03xJdU4ozuy4H1UitOQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782875601; c=relaxed/simple;
	bh=rpglH1oizB0rFm2XbCvG1y+5AiUDyAx0mzYekgGs0KA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=gowxO6FGS5gQNfvDMHE6j84sdxN8OTBE6TXvN+MN6rc7iunWvJzei95Pe8EjRzPVCgC8fbORP13R8cBbNmCVhYkigjvLAGgobA8iAj37KLy3IZqhJTyU/VQe9q7fRDKmV2fRkvp7QHGXzyHOtvYWHofI3YsU9JZUNETLHk53sRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jNAGwJcS; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jNAGwJcS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=rpglH1oizB0rFm2XbCvG1y+5AiUDyAx0mzYekgGs0KA=; b=j
	NAGwJcSwZbie6Jty8cyKDTgMgwS4QVq5PuPiBcYwvvya7lFyPOJw34judqbiTswM
	uax5gLWBIz8xmqWfAhxCBM9RMhwdlZoWTHoz+q0ql2JP9C83TRHtQEztqlR8li40
	Wu98jF8Wtv+b3N4prmP2dPSrJp6R8ptzB1tv4o+bx4=
Received: from huanglei814$163.com ( [116.128.244.169] ) by
 ajax-webmail-wmsvr-40-135 (Coremail) ; Wed, 1 Jul 2026 11:12:31 +0800 (CST)
Date: Wed, 1 Jul 2026 11:12:31 +0800 (CST)
From: huanglei  <huanglei814@163.com>
To: "Eric Dumazet" <edumazet@google.com>
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Lei Huang" <huanglei@kylinos.cn>
Subject: Re:Re: [PATCH] net: ipv4: fix TOCTOU race in __ip_do_redirect
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <CANn89iLuPPWYKCV02e_35n6Wkh7E=jQfo9aoz=0A6jq14wm6Mw@mail.gmail.com>
References: <20260630122333.935406-1-huanglei814@163.com>
 <CANn89iLuPPWYKCV02e_35n6Wkh7E=jQfo9aoz=0A6jq14wm6Mw@mail.gmail.com>
X-NTES-SC: AL_Qu2TAPScuk0u5yScYekckkobj+c7X8a5ufgl24dQc98Fmx3W2yAAeGZsPWP2ze2JJS2ouRynbhRw9sJ7bax7d2F+DRNoe+3erddjKeuK3g==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <7776d34a.30af.19f1ba9f6dc.Coremail.huanglei814@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:hygvCgCnL6GghURqp3oUAA--.911W
X-CM-SenderInfo: xkxd0wxohlmiqu6rljoofrz/xtbC0gA1LGpEhaCzogAA3R
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

VGhhbmsgeW91IGZvciB0aGUgcmV2aWV3LiBZb3UgYXJlIGFic29sdXRlbHkgcmlnaHQuCgpJIHRy
YWNlZCB0aGUgY2FsbGVycyBhbmQgY29uZmlybWVkIHRoYXQgZmliX2NvbXB1dGVfc3BlY19kc3Qo
KSBhbmQgX19pcF9kb19yZWRpcmVjdCgpIGFyZSBib3RoIGludm9rZWQgZnJvbSBwcm90b2NvbCBo
YW5kbGVycyBjYWxsZWQgdmlhIGlwX3Byb3RvY29sX2RlbGl2ZXJfcmN1KCkgaW4gaXBfbG9jYWxf
ZGVsaXZlcl9maW5pc2goKSwgd2hpY2ggaG9sZHMgcmN1X3JlYWRfbG9jaygpIGFjcm9zcyB0aGUg
ZW50aXJlIGRpc3BhdGNoLiBUaGUgZmliX2xvb2t1cCgpIGludGVybmFsIHJjdV9yZWFkX2xvY2sv
dW5sb2NrIGlzIG9ubHkgbmVzdGluZywgc28gcmVzLmZpIGFuZCByZXMubmhjIHJlbWFpbiBwcm90
ZWN0ZWQgYnkgdGhlIG91dGVyIGxvY2sgYWZ0ZXIgZmliX2xvb2t1cCgpIHJldHVybnMuCgpUaGFu
a3MgYWdhaW4gZm9yIHRoZSBjb3JyZWN0aW9uLgoKCkF0IDIwMjYtMDYtMzAgMjA6MzE6MDksICJF
cmljIER1bWF6ZXQiIDxlZHVtYXpldEBnb29nbGUuY29tPiB3cm90ZToKPk9uIFR1ZSwgSnVuIDMw
LCAyMDI2IGF0IDU6MjTigK9BTSBMZWkgSHVhbmcgPGh1YW5nbGVpODE0QDE2My5jb20+IHdyb3Rl
Ogo+Pgo+PiBGcm9tOiBMZWkgSHVhbmcgPGh1YW5nbGVpQGt5bGlub3MuY24+Cj4+Cj4+IGZpYl9s
b29rdXAoKSBpbnRlcm5hbGx5IGFjcXVpcmVzIGFuZCByZWxlYXNlcyByY3VfcmVhZF9sb2NrIGFu
ZCBhbHdheXMgdXNlcwo+PiBGSUJfTE9PS1VQX05PUkVGIChubyByZWZjb3VudCBvbiBmaWJfaW5m
bykuIEFmdGVyIGl0IHJldHVybnMsIHJlcyAoYSBsb2NhbAo+PiBzdHJ1Y3QgZmliX3Jlc3VsdCBv
biB0aGUgc3RhY2spIGhhcyBpdHMgbmhjIGZpZWxkIHBvaW50aW5nIGludG8gdGhlCj4+IGZpYl9p
bmZvIGludGVybmFsIG5leHRob3AgYXJyYXksIGJ1dCBSQ1UgcHJvdGVjdGlvbiBpcyBhbHJlYWR5
IGRyb3BwZWQuCj4+IEEgY29uY3VycmVudCByb3V0ZSBkZWxldGlvbiBjYW4gZnJlZSB0aGUgZmli
X2luZm8gdmlhIGtmcmVlX3JjdSwgbWFraW5nCj4+IHJlcy5uaGMgYSBzdGFsZSBwb2ludGVyLiBT
dWJzZXF1ZW50IEZJQl9SRVNfTkhDKHJlcykgcmVhZHMgdGhpcyBzdGFsZSB2YWx1ZQo+PiBhbmQg
dXBkYXRlX29yX2NyZWF0ZV9mbmhlKCkgZGVyZWZlcmVuY2VzIGl0LCBjYXVzaW5nIFVBRi4KPj4K
Pj4gRml4IGJ5IHdyYXAgdGhlIGVudGlyZSBmaWJfbG9va3VwICsgRklCX1JFU19OSEMgKyB1cGRh
dGVfb3JfY3JlYXRlX2ZuaGUKPj4gcmVnaW9uIGluIGFuIGV4cGxpY2l0IHJjdV9yZWFkX2xvY2sv
dW5sb2NrIHRvIGtlZXAgdGhlIGZpYl9pbmZvIGFsaXZlCj4+IHRocm91Z2hvdXQgdGhlIGNyaXRp
Y2FsIHNlY3Rpb24uCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IExlaSBIdWFuZyA8aHVhbmdsZWlAa3ls
aW5vcy5jbj4KPgo+WW91IGZvcmdvdCB0byBpbmNsdWRlIGEgRml4ZXM6IHRhZy4KPgo+UGxlYXNl
IHJlYWQgRG9jdW1lbnRhdGlvbi9wcm9jZXNzL21haW50YWluZXItbmV0ZGV2LnJzdAo+Cj5Bbnl3
YXksIHRoaXMgcGF0Y2ggaXNuJ3QgbmVlZGVkOyBhbGwgY2FsbGVycyBvZiB0aGlzIGhlbHBlciBh
bHJlYWR5Cj51c2UgcmN1X3JlYWRfbG9jaygpLgo+Cj5JIGFtIGd1ZXNzaW5nIGFsbCBvZiB0aGVt
IGFyZSBjYWxsZWQgZnJvbSBpcF9wcm90b2NvbF9kZWxpdmVyX3JjdSgpCj4KPklmIHlvdSB0aGlu
ayBhYm91dCB0aGlzLCBMT0NLREVQIHdvdWxkIGhhdmUgZmlyZWQgYSB3YXJuaW5nIHllYXJzIGFn
bwo+YXQgbGluZSA3Njk6Cj4KPmluX2RldiA9IF9faW5fZGV2X2dldF9yY3UoZGV2KTsKPgo+Cj5w
dy1ib3Q6IGNyCg==
