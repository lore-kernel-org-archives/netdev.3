Received: from out28-123.mail.aliyun.com (out28-123.mail.aliyun.com [115.124.28.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA64B288B1;
	Sat,  9 May 2026 03:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778298378; cv=none; b=tzLa8UF8EMMMsPfvXrFdn88rec58r7qU8zItU6jkdlhdgJFjDykEQV0nhTcM2EQbOUaRiPQ80mZ7DKEaws9wNDhUYc4mt+tN3+UwXCSeeYNZFJV6oVGpntAJaZtQpwgMIZa9R62KbyEx/Yr3lNkY9ZE5Md2MBUs2U6wU+gYuKPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778298378; c=relaxed/simple;
	bh=5+tiPxPboza3dx3lU8ZkakPHY/rXSy3azDglMDTAnko=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:References:
	 In-Reply-To:Content-Type; b=rqOwlADiRtuto2AYz1H5/z6ZwjtX4Z8a3W4cTh9LfSB5qzhoy1qWClMMidNYvJKrKwqxxOe4pULGNS0ifteVoXhCaci1NKIPkmljTvWzvAUSowswv9vBXmbzJmfrmMOvmP1jActNZ4CQgkTVUlbcZNXUZkSRPGzPQb/g4HW/gPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=115.124.28.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.06689236|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.020606-0.000989613-0.978404;FP=17893326682209567367|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037021130;MF=illusion.wang@nebula-matrix.com;NM=1;PH=DW;RN=18;RT=18;SR=0;TI=W4_0.2.3_21250554_1778298367345_o7001c161e;
Received: from WS-web (Illusion.Wang@nebula-matrix.com[W4_0.2.3_21250554_1778298367345_o7001c161e] cluster:ay29) at Sat, 09 May 2026 11:46:07 +0800
Date: Sat, 09 May 2026 11:46:07 +0800
From: "Illusion Wang" <Illusion.Wang@nebula-matrix.com>
To: "Paolo Abeni" <pabeni@redhat.com>,
  "Dimon" <dimon.zhao@nebula-matrix.com>,
  "Alvin" <alvin.wang@nebula-matrix.com>,
  "Sam" <sam.chen@nebula-matrix.com>,
  "netdev" <netdev@vger.kernel.org>
Cc: "andrew+netdev" <andrew+netdev@lunn.ch>,
  "corbet" <corbet@lwn.net>,
  "kuba" <kuba@kernel.org>,
  "linux-doc" <linux-doc@vger.kernel.org>,
  "lorenzo" <lorenzo@kernel.org>,
  "horms" <horms@kernel.org>,
  "vadim.fedorenko" <vadim.fedorenko@linux.dev>,
  "lukas.bulwahn" <lukas.bulwahn@redhat.com>,
  "edumazet" <edumazet@google.com>,
  "enelsonmoore" <enelsonmoore@gmail.com>,
  "skhan" <skhan@linuxfoundation.org>,
  "hkallweit1" <hkallweit1@gmail.com>,
  "open list" <linux-kernel@vger.kernel.org>
Reply-To: "Illusion Wang" <Illusion.Wang@nebula-matrix.com>
Message-ID: <0bf67146-6167-4141-ad6c-aa6506c582e3.Illusion.Wang@nebula-matrix.com>
Subject: =?UTF-8?B?5Zue5aSN77yaW1BBVENIIHYxMyBuZXQtbmV4dCAwNS8xMV0gbmV0L25lYnVsYS1tYXRyaXg6?=
  =?UTF-8?B?IGFkZCBjaGFubmVsIGxheWVy?=
X-Mailer: [Alimail-Mailagent revision 745868][W4_0.2.3][null][Chrome]
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
x-aliyun-im-through: {"version":"v1.0"}
References: <20260428114910.2616-1-illusion.wang@nebula-matrix.com> <20260428114910.2616-6-illusion.wang@nebula-matrix.com>,<d8f24185-9987-487a-9e0c-5387bd72b629@redhat.com>
x-aliyun-mail-creator: W4_0.2.3_null_EuMTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzEzMy4wLjY5NDMuMTQyIFNhZmFyaS81MzcuMzYgZGluZ3RhbGstd2luLzEuMC4wIG53KDAuMTQuNykgRGluZ1RhbGsoOC4zLjE1LVJlbGVhc2UuMjYwNDI0MDA0KSBNb2pvLzEuMC4wIE5hdGl2ZSBBcHBUeXBlKHJlbGVhc2UpIENoYW5uZWwvMjAxMjAwIEFyY2hpdGVjdHVyZS94ODZfNjQgd2ViRHQvUEM=uL
In-Reply-To: <d8f24185-9987-487a-9e0c-5387bd72b629@redhat.com>
x-aliyun-mailtrack: {"foreign-track":"0"}
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

Pj4gK3N0YXRpYyBzdHJ1Y3QgbmJsX2NvbW1vbl93cV9tZ3QgKndxX21ndDsKPj4gKwo+PiArdm9p
ZCBuYmxfY29tbW9uX3F1ZXVlX3dvcmsoc3RydWN0IHdvcmtfc3RydWN0ICp0YXNrKQo+PiArewo+
PiArCXF1ZXVlX3dvcmsod3FfbWd0LT5jdHJsX2Rldl93cSwgdGFzayk7Cj4+ICt9Cj4+ICsKPj4g
K3ZvaWQgbmJsX2NvbW1vbl9kZXN0cm95X3dxKHZvaWQpCj4+ICt7Cj4+ICsJZGVzdHJveV93b3Jr
cXVldWUod3FfbWd0LT5jdHJsX2Rldl93cSk7Cj4+ICsJa2ZyZWUod3FfbWd0KTsKPj4gKwl3cV9t
Z3QgPSBOVUxMOwo+PiArfQo+PiArCj4+ICtpbnQgbmJsX2NvbW1vbl9jcmVhdGVfd3Eodm9pZCkK
Pj4gK3sKPj4gKwl3cV9tZ3QgPSBremFsbG9jX29iaigqd3FfbWd0KTsKPj4gKwlpZiAoIXdxX21n
dCkKPj4gKwkJcmV0dXJuIC1FTk9NRU07Cj4+ICsKPj4gKwl3cV9tZ3QtPmN0cmxfZGV2X3dxID0g
YWxsb2Nfd29ya3F1ZXVlKCIlcyIsIFdRX01FTV9SRUNMQUlNIHwgV1FfVU5CT1VORCwKPj4gKwkJ
CQkJICAgICAgMCwgIm5ibF9jdHJsZGV2X3dxIik7Cj4+ICsJaWYgKCF3cV9tZ3QtPmN0cmxfZGV2
X3dxKSB7Cj4+ICsJCXByX2VycigiRmFpbGVkIHRvIGNyZWF0ZSB3b3JrcXVldWUgbmJsX2N0cmxk
ZXZfd3FcbiIpOwo+PiArCQlnb3RvIGFsbG9jX2N0cmxfZGV2X3dxX2ZhaWxlZDsKPj4gKwl9Cj4+
ICsKPj4gKwlyZXR1cm4gMDsKPj4gK2FsbG9jX2N0cmxfZGV2X3dxX2ZhaWxlZDoKPj4gKwlrZnJl
ZSh3cV9tZ3QpOwo+PiArCXdxX21ndCA9IE5VTEw7Cj4+ICsJcmV0dXJuIC1FTk9NRU07Cj4+ICt9
Cj5Eb2VzIHRoaXMgZ2xvYmFsIHNpbmdsZXRvbiBzdXJ2aXZlIG11bHRpcGxlIGFkYXB0ZXIgcHJv
YmVzPwo+d3FfbWd0IGlzIGEgZmlsZS1zY29wZSBzdGF0aWMgcG9pbnRlci4gSWYgbmJsX2NvbW1v
bl9jcmVhdGVfd3EoKSBpcwo+Y2FsbGVkIGZyb20gYSBzZWNvbmQgcHJvYmUsIHRoZSBwcmlvciB3
cV9tZ3QgaXMgb3ZlcndyaXR0ZW4gYW5kIHRoZQo+cHJldmlvdXMgd29ya3F1ZXVlIGlzIGxlYWtl
ZC4gT24gcmVtb3ZlIG9mIHRoZSBzZWNvbmQgZGV2aWNlLAo+bmJsX2NvbW1vbl9kZXN0cm95X3dx
KCkgdW5jb25kaXRpb25hbGx5IGNhbGxzIGRlc3Ryb3lfd29ya3F1ZXVlKCkgYW5kCj5rZnJlZSgp
IGFuZCBzZXRzIHdxX21ndCB0byBOVUxMIOKAlCBzbyBhIGxhdGVyIHJlbW92ZSBvZiB0aGUgZmly
c3QKPmRldmljZSB3aWxsIGRlcmVmZXJlbmNlIE5VTEwgaW4gZGVzdHJveV93b3JrcXVldWUod3Ff
bWd0LT5jdHJsX2Rldl93cSkuCj5uYmxfY29tbW9uX3F1ZXVlX3dvcmsoKSBhbHNvIGRlcmVmZXJl
bmNlcyB3cV9tZ3Qgd2l0aCBubyBOVUxMIGNoZWNrLgo+VGhpcyBwYXRjaCBkb2VzIG5vdCB3aXJl
IHVwIHRoZSBjYWxsZXJzLCBidXQgdGhlIGxhdGVyIHNlcmllcyBwYXRjaAo+Im5ldC9uZWJ1bGEt
bWF0cml4OiBhZGQgY29tbW9uIGRldiBzdGFydC9zdG9wIG9wZXJhdGlvbiIKPigxZmYwYWQyMDZk
YTMpIGRvZXMuIFdvdWxkIHJlZmNvdW50aW5nIGNyZWF0ZS9kZXN0cm95LCBvciBzd2l0Y2hpbmcg
dG8KPnBlci1hZGFwdGVyIHdvcmtxdWV1ZXMsIGFkZHJlc3MgdGhpcz8KCkluIHRoZSBsYXN0IHBh
dGNoOgpzdGF0aWMgaW50IF9faW5pdCBuYmxfbW9kdWxlX2luaXQodm9pZCkKewoJaW50IHN0YXR1
czsKCglzdGF0dXMgPSBuYmxfY29tbW9uX2NyZWF0ZV93cSgpOwoJaWYgKHN0YXR1cykgewoJCXBy
X2VycigiRmFpbGVkIHRvIGNyZWF0ZSB3cSwgZXJyID0gJWRcbiIsIHN0YXR1cyk7CgkJZ290byB3
cV9jcmVhdGVfZmFpbGVkOwoJfQoJc3RhdHVzID0gcGNpX3JlZ2lzdGVyX2RyaXZlcigmbmJsX2Ry
aXZlcik7CglpZiAoc3RhdHVzKSB7CgkJcHJfZXJyKCJGYWlsZWQgdG8gcmVnaXN0ZXIgUENJIGRy
aXZlciwgZXJyID0gJWRcbiIsIHN0YXR1cyk7CgkJZ290byBwY2lfcmVnaXN0ZXJfZHJpdmVyX2Zh
aWxlZDsKCX0KCglyZXR1cm4gMDsKCnBjaV9yZWdpc3Rlcl9kcml2ZXJfZmFpbGVkOgoJbmJsX2Nv
bW1vbl9kZXN0cm95X3dxKCk7CndxX2NyZWF0ZV9mYWlsZWQ6CglyZXR1cm4gc3RhdHVzOwp9Cgpz
dGF0aWMgdm9pZCBfX2V4aXQgbmJsX21vZHVsZV9leGl0KHZvaWQpCnsKCXBjaV91bnJlZ2lzdGVy
X2RyaXZlcigmbmJsX2RyaXZlcik7CgluYmxfY29tbW9uX2Rlc3Ryb3lfd3EoKTsKfQoKbW9kdWxl
X2luaXQobmJsX21vZHVsZV9pbml0KTsKbW9kdWxlX2V4aXQobmJsX21vZHVsZV9leGl0KTsKClRo
ZSBmdW5jdGlvbiBuYmxfY29tbW9uX2NyZWF0ZV93cSBpcyBvbmx5IGNhbGxlZCB3aXRoaW4gbmJs
X21vZHVsZV9pbml0LCBhbmQKbmJsX2NvbW1vbl9kZXN0cm95X3dxIGlzIG9ubHkgY2FsbGVkIG9u
Y2Ugd2l0aGluIG5ibF9tb2R1bGVfZXhpdC4gU28sIGlzIHRoZQpBSSdzIHN1Z2dlc3Rpb24gYWxz
byBpbmNvcnJlY3QgaW4gdGhpcyBjYXNlPwotLS1pbGx1c2lvbg==
