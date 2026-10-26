Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793026584;
	b=bVtHXNlZuXKp35NzzyMNAU+FjmKC6rhxFmlZEhG/OGjfDruxJEd0Pqdw3b1XGL1lpIjf
	 vSKKSh7c/T+cujrALZE/eF2e/1BtTWlqDGsgCuqN6nznS/BVECzvEAU2gdWWNd5K0/t8b
	 FSzpkjj9iJi4b6uPNtnK9zcy/pq4WOaFOiQPNZgEzu5Veqqf1bhIZPZ0U/E8GCWZmvsRB
	 RWTU4N6uqFyS4MNzFov/sZb+MAUm3KXoQ7A79dmGDg6z+1MwJGHrFjio/jQG9mb7iOEHY
	 0CxDMZ5yAt+ckw8LehkHG7xj0O55OunCdqyQ3M2HjtVLKvNXUUyNQYT0tjPMq3UET6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793026584;
	h=DMARC-Filter:DKIM-Signature:X-QQ-XMRINFO:X-QQ-XMAILINFO:From:To:Cc:
	 Subject:Mime-Version:Content-Type:Content-Transfer-Encoding:Date:
	 X-Priority:Message-ID:X-QQ-MIME:X-Mailer:X-QQ-Mailer:References:
	 In-Reply-To:X-QQ-mid;
	bh=RuotPnZdxuGHvCO6ci2amZgNLLfOtFoXm03Qr+Is18Y=;
	b=lQMl6zVEBb6JRplM190N558xzKNlwRxm3eMyZRcsZr/yrCH/KQrXPD/3RTKswDtkJ7ku
	 Re7jH0l464kCJMqSVU0cot2X2DaNsWwE6jzd95w6XXVwiDXSx1+SYdZ5JkSd1Gk7TGmmV
	 tnTFMxHMuHNxjav/diHFoWQant+Kxnq3yQ3j41cd1XKRglzj5voOuAQxDhJ24Ak9Tw06X
	 eHB8OeVmHE6mY9/CHc91ml+Kl47Pvu70PzAGBCdCOsHaXyKR04K6Nwggf2Gg2ilcbZMSG
	 Q0cvboysxCDQenjkK+sjfKzvg9NStkstOC/CLy1wW9P+gCKqFhZm0YtoJQ2CS/Su1IA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=PppD0vWl;
	arc=none smtp.remote-ip=203.205.221.153
Received: from out203-205-221-153.mail.qq.com (out203-205-221-153.mail.qq.com [203.205.221.153])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CB4606A32F;
	Mon, 26 Oct 2026 14:56:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68CB4606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=PppD0vWl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1793026569; bh=RuotPnZdxuGHvCO6ci2amZgNLLfOtFoXm03Qr+Is18Y=;
	h=From:To:Cc:Subject:Date:References:In-Reply-To;
	b=PppD0vWlUeA4ARw8FHIXRROgGVyDk5jCbe+w12ek6wXZWsdNzRGR3EAxpda+W98hy
	 9Sa2oXOWHY//uQSKLkmJO1f/kf2zPPskiDuMWQ9rIVqYgn+Tol+BobSe+ysFCJkxHe
	 ejGgrUhmrZJuWqYdoa80ADnSknXjpsD3aUquEZKw=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-XMAILINFO: MQ+RLpP3ca9B9zFQFr8c37Afr8ztaUfPPDNMfVcY5KPNfYldBzuLMvpZy15GU2
	 9Iq4E+qjujD5hoa+Oye155otpR5xOhdP5dkBUq/ruyNgvOOxSRsFNeYP5cICdldqrCgfd98yDhU9Z
	 eb4ZmgwE6vDV53KUoKUx5Q+8FnzPNdJhPvV/50oIuMOK+2I5YtdN4gYiuVH8U9CaZXIUI7eC617B+
	 YtaIgFG2oT8rru28r6dnZLw6/HBXG/5V4VSbA45f4EHIiA8OwjeS/NcapKdaK8LP8PYhjD0KIoTdO
	 JMcgF2oFHrVjF13XFtSilGIGJOKsRW3F2lFDi5RZQf8nfZ5xmD+2Nnbcwn6YTRueswSYJn8F39Xjp
	 pv8qCIhfSfTeQbd8G3oLX9hXQoFbsbinJq3gUUap83xyU0nNrHjIfvIAmQ99fLMSfuS+F4gUZHs3e
	 BFMf0LkxW5YPi6ZDBNFJKBtVBDrfeL+XKqQ2T4aREK+KWS8YYS6CWxTttg+iqo3VNk36yxQSP3S71
	 ojlUhEuo9Knf7aU7LbpkHuXzXRTDozl8LQDSn1do3r9zB/XBuVIsMNVCuufCahskxns6bj1SPwAUG
	 KupriVTNprhqaPo646OyPIutu5X8PDePEh6W8n351qbL9KhTNGz9M5zAAkA3hg4I9InmlLcMldM2p
	 IoZtoHR3wOMhRVqlIKNYsAsAlZK04tyFQCTm+/AQtgWD6iBa/513WbqwejeGOdhQ2WgmWzKbztnCD
	 TzdYkKSyzMw/6/jrW1U6MkpF2mU5FLxVeeCab+OWV7ibLYYGHjRitZaGOaf3ihppsFwFzlodbO+DW
	 PuNSz2/mIRsBCN0ILzuSOg/jk8T/IC1KO4HPRv3umIPzdTdckDdK3YRxkalaXSXx2Ct1elM4o0x1n
	 4dT6R25EcqP+tdxbFYXcufJxNC9ZayTv81l7T8f0i5zLYPGn+YhHFKoHRlDBW/KjEn0vlhbFBU3YW
	 1UzpfmkhPFqISBmTzNdhj+LABVGB3VbChpsrc4vOkUpdpFdNZVEsoaa+ERi/WBet2OLL5ys2Fpru2
	 +yk86PC2wSO9+jMfYPrY8t+ysB472iILL3XDrSRN2vPUbCYpGDcAL1ICyCmleWvy2Da7n
From: "=?utf-8?B?Q3VuaGFvIEx1?=" <1579567540@qq.com>
To: "=?utf-8?B?5byg5pm0?=" <zhangqing@rock-chips.com>, "=?utf-8?B?U3RlcGhlbiBCb3lk?=" <sboyd@kernel.org>, "=?utf-8?B?QnJpYW4gTWFzbmV5?=" <bmasney+clk@redhat.com>, "=?utf-8?B?SmVyb21lIEJydW5ldA==?=" <jbrunet+clk@baylibre.com>, "=?utf-8?B?Um9iIEhlcnJpbmc=?=" <robh@kernel.org>, "=?utf-8?B?S3J6eXN6dG9mIEtvemxvd3NraQ==?=" <krzk+dt@kernel.org>, "=?utf-8?B?Q29ub3IgRG9vbGV5?=" <conor+dt@kernel.org>, "=?utf-8?B?SGVpa28gU3R1ZWJuZXI=?=" <heiko@sntech.de>, "=?utf-8?B?UGhpbGlwcCBaYWJlbA==?=" <p.zabel@pengutronix.de>, "=?utf-8?B?UmljaGFyZCBDb2NocmFu?=" <richardcochran@gmail.com>
Cc: "=?utf-8?B?bGludXgtY2xr?=" <linux-clk@vger.kernel.org>, "=?utf-8?B?ZGV2aWNldHJlZQ==?=" <devicetree@vger.kernel.org>, "=?utf-8?B?bGludXgtYXJtLWtlcm5lbA==?=" <linux-arm-kernel@lists.infradead.org>, "=?utf-8?B?bGludXgtcm9ja2NoaXA=?=" <linux-rockchip@lists.infradead.org>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>, "=?utf-8?B?bmV0ZGV2?=" <netdev@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] clk: rockchip: Add RK3572 clock and reset support
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Mon, 26 Oct 2026 22:56:06 +0800
X-Priority: 3
Message-ID: <tencent_6876096D2306016F88487E0E4D78345B3208@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20261026-add-board-ok3572-c-clk-v3-0-dbabfa39d692@qq.com>
 <20261026-add-board-ok3572-c-clk-v3-3-dbabfa39d692@qq.com>
	<0d5de6fd-3150-4898-a652-7f5b64dcaf07@rock-chips.com>
In-Reply-To: <0d5de6fd-3150-4898-a652-7f5b64dcaf07@rock-chips.com>
X-QQ-mid: xmsezb41-0t1793026566tx8hx42zl

SGkgemhhbmdxaW5nLAoKPiBUaGlzIGlzIGluIGNsay5oLCBwbGVhc2Ugc3VibWl0IGl0IHNl
cGFyYXRlbHkuCgpUaGFua3MgZm9yIHRoZSByZXZpZXcuIEkgd2lsbCBtb3ZlIENPTVBPU0lU
RV9NVVhUQkwgdG8gY2xrLmggYW5kIGFkZCBpdAppbiBhIHNlcGFyYXRlIHByZXBhcmF0b3J5
IHBhdGNoLgoKPiBUaGlzIGlzIGluY29ycmVjdCBoZXJlOyB0aGVyZSBzaG91bGQgYmUgbm8g
bmVnYXRpdmUgdmFsdWVzLiBUd28ncwo+IGNvbXBsZW1lbnQgaXMgdXNlZCBoZXJlLCBzbyBh
IGNvbnZlcnNpb24gaXMgbmVlZGVkLiBGb3IgZXhhbXBsZSwKPiAtMTI5NTUgc2hvdWxkIGJl
IDUyNTgxLgo+Cj4gSW4gY2xrLXBsbC5jLCBjdXIuayAmIEJJVCgxNSkgaXMgdXNlZCB0byBk
ZXRlcm1pbmUgdGhlIHR3bydzIGNvbXBsZW1lbnQKPiBjb252ZXJzaW9uLgoKSSBhZ3JlZSB0
aGF0IHRoZSBoYXJkd2FyZSBleHBlY3RzIGEgMTYtYml0IHR3bydzIGNvbXBsZW1lbnQgZW5j
b2Rpbmc6Ci0xMjk1NSBpcyBlbmNvZGVkIGFzIDB4Y2Q2NSwgd2hpY2ggaXMgNTI1ODEgd2hl
biByZWFkIGFzIHVuc2lnbmVkLiBUaGUKZGlmZmVyZW5jZSBoZXJlIGlzIGhvdyB0aGF0IGNv
ZWZmaWNpZW50IGlzIHJlcHJlc2VudGVkIGluIHRoZSByYXRlCnRhYmxlIG9uIHRoZSBrZXJu
ZWwgdmVyc2lvbiB0aGlzIHNlcmllcyB0YXJnZXRzLgoKSSBmb3VuZCB0aGUgY3VyLmsgJiBC
SVQoMTUpIGJyYW5jaCBpbiBSb2NrY2hpcCdzIGRvd25zdHJlYW0gZGV2ZWxvcC02LjEyCnRy
ZWUuIFRoZXJlLCBrIGlzIHVuc2lnbmVkIGludCwgc28gdGhlIGRyaXZlciBleHBsaWNpdGx5
IGNoZWNrcyBiaXQgMTUKYW5kIHN1YnRyYWN0cyB0aGUgbWFnbml0dWRlIG9mIGEgbmVnYXRp
dmUgZnJhY3Rpb25hbCBjb2VmZmljaWVudC4KClRoaXMgc2VyaWVzIHVzZXMgdGhlIHVwc3Ry
ZWFtIGltcGxlbWVudGF0aW9uLiBCb3RoIHYyIGFuZCB2MyBhcmUgYmFzZWQKb24gYTgwNGM1
NzQyYmZmLCB3aGljaCBhbHJlYWR5IGNvbnRhaW5zIGNvbW1pdAo1ODE0Nzg4ODM0NzcgKCJj
bGs6IHJvY2tjaGlwOiBGcmFjdGlvbmFsIFBMTCBjb2VmZmljaWVudCBvbiBSSzM1ODgvUksz
NTc2CmlzIHR3bydzIGNvbXBsZW1lbnQiKS4gVGhhdCBjb21taXQgY2hhbmdlZCB0aGUgayBt
ZW1iZXIgb2YKc3RydWN0IHJvY2tjaGlwX3BsbF9yYXRlX3RhYmxlIHRvOgoKICAgICAgICBz
MTYgazsgLyogZnJhY3Rpb25hbCBwYXJ0LCAxNiBiaXQgdHdvJ3MgY29tcGxlbWVudCAqLwoK
T24gdGhpcyBiYXNlLCByb2NrY2hpcF9yazM1ODhfcGxsX3JlY2FsY19yYXRlKCkgdXNlcyBz
aWduZWQgYXJpdGhtZXRpYzoKCiAgICAgICAgczY0IGZyYWNfcmF0ZTY0ID0gKHM2NClwcmF0
ZSAqIGN1ci5rOwogICAgICAgIHBvc3RkaXYgPSBjdXIucCAqIDY1NTM2OwogICAgICAgIHJh
dGU2NCArPSBkaXZfczY0KGZyYWNfcmF0ZTY0LCBwb3N0ZGl2KTsKClRoZSBzaWduZWQgdHlw
ZSByZXByZXNlbnRzIHRoZSBuZWdhdGl2ZSBjb2VmZmljaWVudCBkaXJlY3RseSwgc28gdGhp
cwppbXBsZW1lbnRhdGlvbiBkb2VzIG5vdCBuZWVkIGEgc2VwYXJhdGUgY3VyLmsgJiBCSVQo
MTUpIGJyYW5jaC4gRm9yCmV4YW1wbGUsIHRoZSBtYWlubGluZSBSSzM1NzYgcmF0ZSB0YWJs
ZSBhbHJlYWR5IGNvbnRhaW5zOgoKICAgICAgICBSSzM1ODhfUExMX1JBVEUoOTU1NTIwMDAw
LCAzLCA0NzgsIDIsIC0xNTczMCksCiAgICAgICAgUkszNTg4X1BMTF9SQVRFKDc4NTU2MDAw
MCwgMywgMzkzLCAyLCAtMTQ0MTkpLAoKVGhlc2UgYXJlIGV4YWN0bHkgdGhlIHNhbWUgZW50
cmllcyBhcyBpbiB0aGlzIFJLMzU3MiBwYXRjaCwgaW5jbHVkaW5nCnAsIG0gYW5kIHMuIE1h
aW5saW5lIFJLMzU4OCB1c2VzIHRoZSBzYW1lIGVudHJpZXMgYXMgd2VsbC4gU2luY2UgUksz
NTcyCnVzZXMgdGhpcyBzaGFyZWQgdXBzdHJlYW0gUExMIGltcGxlbWVudGF0aW9uLCBJIHdp
bGwgZm9sbG93IHRoZQptYWlubGluZSBSSzM1NzYgY29udmVudGlvbiBmb3IgaXRzIHJhdGUg
dGFibGUuCgpXcml0aW5nIDUyNTgxIGRpcmVjdGx5IGludG8gYW4gczE2IGluaXRpYWxpemVy
IHdvdWxkIHJlcXVpcmUgYW4Kb3V0LW9mLXJhbmdlIGltcGxpY2l0IGNvbnZlcnNpb247IGEg
cmVkdWNlZCBjb21waWxlciB0ZXN0IHJlcHJvZHVjZXMKQ2xhbmcncyBjb25zdGFudC1jb252
ZXJzaW9uIGRpYWdub3N0aWMuIEFuIGV4cGxpY2l0IGNhc3Qgc3VjaCBhcwooczE2KTUyNTgx
IHdvdWxkIHByb2R1Y2UgdGhlIHNhbWUgc2lnbmVkIGNvZWZmaWNpZW50LCBidXQgd291bGQg
YWRkIGEKY29udmVyc2lvbiB0aGF0IHRoZSBleGlzdGluZyBtYWlubGluZSB0YWJsZXMgYXZv
aWQuIFVzaW5nIC0xMjk1NQpkaXJlY3RseSBtYWtlcyB0aGUgdmFsdWUgdXNlZCBpbiB0aGUg
cmF0ZSBjYWxjdWxhdGlvbiBjbGVhciBhbmQgc3RheXMKY29uc2lzdGVudCB3aXRoIFJLMzU3
Ni4KClRoZSByZWdpc3RlciBlbmNvZGluZyBpcyBwcmVzZXJ2ZWQ6IHRoZSB3cml0ZSBwYXRo
IHBhc3NlcyBrIHRocm91Z2gKSElXT1JEX1VQREFURSgpIHdpdGggYSAweGZmZmYgbWFzaywg
c28gLTEyOTU1IHN0aWxsIHdyaXRlcyAweGNkNjUgaW50bwp0aGUgY29lZmZpY2llbnQgZmll
bGQuIFRoZSBmaXZlIGluaXRpYWxpemVyIGNoYW5nZXMgZnJvbSB2MiB0byB2MyBvbmx5Cm1h
a2UgdGhlIHNpZ25lZCB2YWx1ZXMgZXhwbGljaXQ7IHRoZXkgZG8gbm90IGNoYW5nZSBwLCBt
LCBzIG9yIHRoZQoxNi1iaXQgY29lZmZpY2llbnQgZW5jb2RpbmdzLiBJbiBwYXJ0aWN1bGFy
LCBubyBmdXJ0aGVyIGFkanVzdG1lbnQgb2YKbSBpcyBuZWVkZWQgZm9yIHRoZXNlIHJlcHJl
c2VudGF0aW9uIGNoYW5nZXMuCgpJIHdpbGwgdGhlcmVmb3JlIHJldGFpbiB0aGUgc2lnbmVk
IGNvZWZmaWNpZW50cywgZm9sbG93aW5nIG1haW5saW5lClJLMzU3Ni4KCkJlc3QgcmVnYXJk
cywKQ3VuaGFvCg==

