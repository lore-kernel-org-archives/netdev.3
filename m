Received: from out28-220.mail.aliyun.com (out28-220.mail.aliyun.com [115.124.28.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDB53C10BE;
	Wed,  5 Aug 2026 02:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785896810; cv=none; b=XQe96hK/N5AaHIWLLEOs/Ub266GgC+tOQJh48vo2FDilP44MNcOsu0y4YWAj9S7uKywPTbIu+mT/TVk5gvAfU7CcV5FmlMS7B1o2knB7zD69FFkW+GCnIOVWRsmtBnqgGpD5EFN7X18FvF+bHefSWntxtODdz7xP9wsMztph5uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785896810; c=relaxed/simple;
	bh=nrsSQ4hnB/xMHXEJQajdNQvd6O5sqbdHDRNmYQSg3yU=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:References:
	 In-Reply-To:Content-Type; b=jUo7bManUhFaCyWOoBXK2LhTUpKKVKnHrTE3iZr2bKnRaNdIqk+bPOO3A0FJrqkAZBTbApa/8AKpXJMXMcnp0dOv7ObL2wEt5DtoBIJ3bYWlt+fUHq+iVH4ARLmRRrFCyoi7KDBRjsKTQMInqmzDBa26K4CZ5NiyXLfzZT9pmpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=115.124.28.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.06669818|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0124756-0.00117969-0.986345;FP=10869237358135174870|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037022039;MF=illusion.wang@nebula-matrix.com;NM=1;PH=DW;RN=18;RT=18;SR=0;TI=W4_0.2.3_212D3FFB_1785896791226_o7001c181k;
Received: from WS-web (Illusion.Wang@nebula-matrix.com[W4_0.2.3_212D3FFB_1785896791226_o7001c181k] cluster:ay29) at Wed, 05 Aug 2026 10:26:31 +0800
Date: Wed, 05 Aug 2026 10:26:31 +0800
From: "Illusion Wang" <Illusion.Wang@nebula-matrix.com>
To: "Illusion Wang" <illusion.wang@nebula-matrix.com>,
  "Dimon" <dimon.zhao@nebula-matrix.com>,
  "Alvin" <alvin.wang@nebula-matrix.com>,
  "Sam" <sam.chen@nebula-matrix.com>,
  "netdev" <netdev@vger.kernel.org>
Cc: "andrew+netdev" <andrew+netdev@lunn.ch>,
  "corbet" <corbet@lwn.net>,
  "kuba" <kuba@kernel.org>,
  "horms" <horms@kernel.org>,
  "linux-doc" <linux-doc@vger.kernel.org>,
  "pabeni" <pabeni@redhat.com>,
  "vadim.fedorenko" <vadim.fedorenko@linux.dev>,
  "lukas.bulwahn" <lukas.bulwahn@redhat.com>,
  "edumazet" <edumazet@google.com>,
  "enelsonmoore" <enelsonmoore@gmail.com>,
  "skhan" <skhan@linuxfoundation.org>,
  "hkallweit1" <hkallweit1@gmail.com>,
  "open list" <linux-kernel@vger.kernel.org>
Reply-To: "Illusion Wang" <Illusion.Wang@nebula-matrix.com>
Message-ID: <21f3dc71-fe1e-4f9a-a2a6-0840f25bdeec.Illusion.Wang@nebula-matrix.com>
Subject: =?UTF-8?B?5Zue5aSN77yaW1BBVENIIHYyMyBuZXQtbmV4dCAwMi8xMl0gbmV0L25lYnVsYS1tYXRyaXg6?=
  =?UTF-8?B?IGFkZCBjb3JlIGRyaXZlciBhcmNoaXRlY3R1cmUgYW5kIEhXIGxheWVyIGluaXRpYWxpemF0?=
  =?UTF-8?B?aW9u?=
X-Mailer: [Alimail-Mailagent revision 6][W4_0.2.3][null][Chrome]
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
x-aliyun-im-through: {"version":"v1.0"}
References: <20260731094242.2655-1-illusion.wang@nebula-matrix.com>,<20260731094242.2655-3-illusion.wang@nebula-matrix.com>
x-aliyun-mail-creator: W4_0.2.3_null_EuMTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzEzMy4wLjY5NDMuMTQyIFNhZmFyaS81MzcuMzYgZGluZ3RhbGstd2luLzEuMC4wIG53KDAuMTQuNykgRGluZ1RhbGsoOC4zLjQ1LVJlbGVhc2UuMjYwNzIwMDA1KSBNb2pvLzEuMC4wIE5hdGl2ZSBBcHBUeXBlKHJlbGVhc2UpIENoYW5uZWwvMjAxMjAwIEFyY2hpdGVjdHVyZS94ODZfNjQgd2ViRHQvUEM=uL
In-Reply-To: <20260731094242.2655-3-illusion.wang@nebula-matrix.com>
x-aliyun-mailtrack: {"foreign-track":"0"}
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

UmV2aWV3IGNvbW1lbnRzIGZvciBWMjIKPk9uIFRodSwgMjMgSnVsIDIwMjYgMTI6MDA6NTQgKzA4
MDAgaWxsdXNpb24ud2FuZyB3cm90ZToKPj4gKyBlcnIgPSBkbWFfc2V0X21hc2tfYW5kX2NvaGVy
ZW50KGRldiwgRE1BX0JJVF9NQVNLKDY0KSk7Cj4+ICsgaWYgKGVycikgewo+PiArICBkZXZfZGJn
KGRldiwgIkNvbmZpZ3VyZSBETUEgNjQgYml0IG1hc2sgZmFpbGVkLCBlcnIgPSAlZFxuIiwKPj4g
KyAgIGVycik7Cj4+ICsgIGRtYV8zMl9lcnIgPSBkbWFfc2V0X21hc2tfYW5kX2NvaGVyZW50KGRl
diwgRE1BX0JJVF9NQVNLKDMyKSk7Cj4+ICsgIGlmIChkbWFfMzJfZXJyKSB7Cgo+UmVhZCB0aGUg
ZG9jdW1lbnRhdGlvbiBmb3IgdGhlIERNQSBBUEksIGRtYV9zZXRfbWFza19hbmRfY29oZXJlbnQo
KQo+aXMgZ3VhcmFudGVlZCB0byBzdWNjZWVkIGluIHNvbWUgY2FzZXMuLgpBcyBkb2N1bWVudGVk
OgpkbWFfc2V0X21hc2tfYW5kX2NvaGVyZW50KCkgbmV2ZXIgcmV0dXJuIGZhaWwgd2hlbiBETUFf
QklUX01BU0soNjQpLiBUeXBpY2FsCmVycm9yIGNvZGUgbGlrZTo6CgoJLyogV3JvbmcgY29kZSAq
LwoJaWYgKGRtYV9zZXRfbWFza19hbmRfY29oZXJlbnQoZGV2LCBETUFfQklUX01BU0soNjQpKSkK
CQlkbWFfc2V0X21hc2tfYW5kX2NvaGVyZW50KGRldiwgRE1BX0JJVF9NQVNLKDMyKSkKCmRtYV9z
ZXRfbWFza19hbmRfY29oZXJlbnQoKSB3aWxsIG5ldmVyIHJldHVybiBmYWlsdXJlIHdoZW4gYmln
Z2VyIHRoYW4gMzIuClNvIHR5cGljYWwgY29kZSBsaWtlOjoKCgkvKiBSZWNvbW1lbmRlZCBjb2Rl
ICovCglpZiAoc3VwcG9ydF82NGJpdCkKCQlkbWFfc2V0X21hc2tfYW5kX2NvaGVyZW50KGRldiwg
RE1BX0JJVF9NQVNLKDY0KSk7CgllbHNlCgkJZG1hX3NldF9tYXNrX2FuZF9jb2hlcmVudChkZXYs
IERNQV9CSVRfTUFTSygzMikpOwoKUmV2aWV3IGNvbW1lbnRzIGZvciBWMjMKPj4gKwllcnIgPSBk
bWFfc2V0X21hc2tfYW5kX2NvaGVyZW50KGRldiwgRE1BX0JJVF9NQVNLKDY0KSk7Cj4+ICsJaWYg
KGVycikgewo+PiArCQlkZXZfZGJnKGRldiwgIkNvbmZpZ3VyZSBETUEgNjQgYml0IG1hc2sgZmFp
bGVkLCBlcnIgPSAlZFxuIiwKPj4gKwkJCWVycik7Cj4+ICsJCWRtYV9zZXRfbWFza19hbmRfY29o
ZXJlbnQoZGV2LCBETUFfQklUX01BU0soMzIpKTsKPklmIHRoZSA2NC1iaXQgbWFzayBjb25maWd1
cmF0aW9uIGZhaWxzIGluIG5ibF9wcm9iZSgpLCBhbmQgdGhpcyAzMi1iaXQKPmZhbGxiYWNrIGFs
c28gZmFpbHMsIGRvZXMgcHJvYmUgc3VjY2VlZCBhbnl3YXkgbGVhdmluZyB0aGUgZGV2aWNlIHdp
dGggYW4KPnVuY29uZmlndXJlZCBvciBpbnZhbGlkIERNQSBtYXNrPwo+U2luY2UgdGhlIHJldHVy
biB2YWx1ZSBvZiB0aGUgZmFsbGJhY2sgZG1hX3NldF9tYXNrX2FuZF9jb2hlcmVudCgpIGlzCj5p
Z25vcmVkLCB0aGUgcHJvYmUgcGF0aCB3aWxsIGNvbnRpbnVlIHdpdGhvdXQgYSB2YWxpZCBETUEg
bWFzayBjb25maWd1cmF0aW9uLAo+d2hpY2ggY291bGQgY2F1c2Ugc3Vic2VxdWVudCBETUEgb3Bl
cmF0aW9ucyB0byBmYWlsIG9yIG1pc2JlaGF2ZSBzaWxlbnRseS4KPj4gKwl9Cj4+ICsJcGNpX3Nl
dF9tYXN0ZXIocGRldik7Cj4+ICsKPj4gKwlhZGFwdGVyID0gbmJsX2NvcmVfaW5pdChwZGV2LCAm
cGFyYW0pOwoKU28gTXkgZml4IGltcGxlbWVudGF0aW9uIGlzIE9LPwpyZXQgPSBkbWFfc2V0X21h
c2tfYW5kX2NvaGVyZW50KCZwZGV2LT5kZXYsIERNQV9CSVRfTUFTSyg2NCkpOwppZiAocmV0KSB7
CglkZXZfZXJyKCZwZGV2LT5kZXYsICJTZXQgNjRiaXQgRE1BIG1hc2sgZmFpbGVkICVkLCBkZXZp
Y2UgY2Fubm90IHdvcmtcbiIsIHJldCk7Cglnb3RvIGVycl9vdXQ7Cn0KLi4uCnBjaV9zZXRfbWFz
dGVyKHBkZXYpOwphZGFwdGVyID0gbmJsX2NvcmVfaW5pdChwZGV2LCAmcGFyYW0pOwoK
