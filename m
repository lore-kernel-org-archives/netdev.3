Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792725753;
	b=XImMlWNNb6wXY3stcIzs0FC2xyC2fAb1WdrLiXXmWZh2sgxOUm631YWTTzP3KLdViCDS
	 B8SZkUfINem/0UrgnujpO/xGVZkWgXKCOOqJVqjnefdiSElVJD893fQ+feek9n+BW8RNG
	 FypkPDn3ZNg0w26TY9uYvLbTM2DNlq3OnOoQNW3L/QTJbxksIMOuOk+/8HNspx7MZZN91
	 QRA22Aibr7AGWZLkr199fK/xYvFuOVSmsygLKDaDCU2lz8cBJxmEouKYp1PYkd0FLjxRt
	 Fe03ANwls+oeCYv3ZYYFNxQ55MXu2jYxa5s7I5zEUPTikdrLJjYjdjQwfPXWZy8NocQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792725753;
	h=DMARC-Filter:DKIM-Signature:Date:From:To:Cc:Subject:X-Priority:
	 X-Mailer:In-Reply-To:References:X-NTES-SC:Content-Transfer-Encoding:
	 Content-Type:MIME-Version:Message-ID:X-Coremail-Locale:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=NKw6Awa/XyRaLtap3xFrz6SKY4+OYkIh300uWwcDCIQ=;
	b=c8RphHqGsuKQFNsJcNim0ACOhOz+XQ6n2iDjHufF6qj3SBZks9iKpgIAxbb3kwJN8+qs
	 8NOq+gG/IijYE9DlYGgtAQJaNTcSuA1n2sxCzCwtqb6yOiq+o8MdclneWVLIWFlw+Xc4w
	 wu6nIlFBf1OGYFegM8aznJQSNYd2P2jIO98gSFHsnaIwWH0VGfudE5w1n8cQGjwQEaLSA
	 zXyk1K6KPMJHCxarF9aymDMKsY0K/3jrdDRuAyK8if+4XtjW8G1rXNQfmkILxtSdHn5Hy
	 I+kwpH21XgcSt6kAhSoPl5APJkcCwPKrnzH0v7Xj2XWC5isqlzflR2zavpboEeNBudg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=A4316bx0;
	arc=none smtp.remote-ip=220.197.31.3
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AADB606A31A;
	Fri, 23 Oct 2026 03:22:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3AADB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=A4316bx0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=NKw6Awa/XyRaLtap3xFrz6SKY4+OYkIh300uWwcDCIQ=; b=A
	4316bx018ooGp73dbny+znnyS4NS71EEObUhEcymHQWtraQfzVE5AIMK/tnJlL3P
	V8dYErrCiItEMqVjY+Nv/Sf5oPSoYonuAcHuYvn1NJyH/iQ1QDL5QsWMZM2XAuEp
	MYY6ux4zb4AjhIHMLKyrD5bCS9GKA6XnNytkpKImuY=
Date: Fri, 23 Oct 2026 11:21:53 +0800 (CST)
From: sicong  <congei42@163.com>
To: "Edward Cree" <ecree.xilinx@gmail.com>
Cc: netdev@vger.kernel.org, "Andrew Lunn" <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	"Eric Dumazet" <edumazet@kernel.org>,
	"Jakub Kicinski" <kuba@kernel.org>,
	"Paolo Abeni" <pabeni@redhat.com>, "Kees Cook" <kees@kernel.org>,
	linux-net-drivers@amd.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] sfc: fix use-after-free of filter_work in
 efx_realloc_channels()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <46fdec20-c37b-4d7a-afa1-3caadcfc4640@gmail.com>
References: <20261022133927.3860186-1-congei42@163.com>
 <46fdec20-c37b-4d7a-afa1-3caadcfc4640@gmail.com>
X-NTES-SC: AL_Qu2SAPuZuk8q5SOaY+kfm0YUj+44Wsa4uvgk2YJeOpt4jD3p5jwdY11FGGPR9MC+Ow+dlwmpeTprx/x8eI5CQak03Rl+jHrlvDRZAXm07Qr/8g==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <5a7bfee.32ee.1a166c781b9.Coremail.congei42@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:dCgvCgDn1__R0tpqu5BeAA--.1187W
X-CM-SenderInfo: 5frqwvrlusqiywtou0bp/xtbC9RE6LWra0tHXcwAA3k
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

QXQgMjAyNi0xMC0yMiAyMjozNjo1MiwgIkVkd2FyZCBDcmVlIiA8ZWNyZWUueGlsaW54QGdtYWls
LmNvbT4gd3JvdGU6Cj5UaGUgYW5hbHlzaXMgbG9va3MgY29ycmVjdCwgYnV0IEkgd29uZGVyIGlm
IHJhdGhlciB0aGFuIHBsYWNpbmcgdGhlCj4gY2FuY2VsX2RlbGF5ZWRfd29ya19zeW5jKCkgaW5s
aW5lIGluIGVmeF9yZWFsbG9jX2NoYW5uZWxzKCksIGl0IHNob3VsZAo+IGJlIGRvbmUgYnkgZWZ4
X3JlbW92ZV9jaGFubmVsKCkgKG9yIHJvbGxlZCB1cCB3aXRoIHRoZSBrZnJlZSgpIGludG8gYQo+
IG5ldyBlZnhfZnJlZV9jaGFubmVsKCksIHNpbmNlIGl0J3MgdW5kb2luZyBlZnhfYWxsb2NfY2hh
bm5lbCgpIHJhdGhlcgo+IHRoYW4gZWZ4X3Byb2JlX2NoYW5uZWwoKSksIHRvIHJlZHVjZSB0aGUg
cmlzayBvZiB0aGUgc2FtZSByYWNlIHBvcHBpbmcKPiB1cCBlbHNld2hlcmUuICBDb25zdW1lcnMg
b2YgdGhlIGNoYW5uZWxzIEFQSSBzaG91bGQgbm90IG5lZWQgdG8ga25vdwo+IHRoYXQgdGhleSBo
YXZlIHRvIGRvIHRoaXMgJ21hZ2ljJyBjYW5jZWwgdG8gc2FmZWx5IGZyZWUgYSBjaGFubmVsLAo+
IHRoYXQncyBhIGxheWVyaW5nIHZpb2xhdGlvbi4KClRoYW5rcyBmb3IgdGhlIHJldmlldywgdGhh
dCBtYWtlcyBzZW5zZS4KCkkgd2VudCB3aXRoIGVmeF9mcmVlX2NoYW5uZWwoKS4gSXQgY2FuY2Vs
cyBmaWx0ZXJfd29yayBzeW5jaHJvbm91c2x5CmFuZCB0aGVuIGZyZWVzIHRoZSBjaGFubmVsLCBh
bmQgYm90aCBlZnhfcmVhbGxvY19jaGFubmVscygpIGFuZAplZnhfZmluaV9jaGFubmVscygpIG5v
dyB1c2UgaXQgaW5zdGVhZCBvZiBjYWxsaW5nIGtmcmVlKCkgZGlyZWN0bHkuClRoZSBTaWVuYSBk
cml2ZXIgZ2V0cyB0aGUgc2FtZSBjaGFuZ2UuCgo+KEFjdHVhbGx5LCBpdCdzIGEgbGF5ZXJpbmcg
dmlvbGF0aW9uIHRoYXQgZmlsdGVyX3dvcmsgZXZlbiBsaXZlcyBpbiB0aGUKPiBlZnhfY2hhbm5l
bCBhbmQgbm90IGl0cyBlZnhfcnhfcXVldWUsIGJ1dCBJIG5ldmVyIGhhZCB0aW1lIHRvIGZpeCB0
aGF0Cj4gYW5kIGFtIG5vdyBub3QgbGlrZWx5IHRvIKGqIEkgY29tbWVuZCB0aGUgaWRlYSB0byBm
dXR1cmUgbWFpbnRhaW5lcnMuKQoKVGhhdCBzZWVtcyBsaWtlIGEgYmlnZ2VyIHJlZmFjdG9yIHRo
YW4gYmVsb25ncyBpbiBhIGZpeCBmb3IgbmV0LCBzbwpJJ3ZlIGxlZnQgaXQgb3V0IG9mIHRoaXMg
cGF0Y2guCgpJJ2xsIHNlbmQgdjIgYXMgYSBzZXBhcmF0ZSB0aHJlYWQuCgpUaGFua3MsClNpY29u
ZwoKCgoK
