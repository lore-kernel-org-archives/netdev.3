Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794561576;
	b=sZGaNq7c0owJBGUwhe2SjgubCvXsoqoxPcwnDxxR90RBIIIt1ecZyh361rmhYET6bi1b
	 qcG85/LaJhcjROt3DJaJHVurMq3DqKAZkCfAqZ2M1MWj3NMRrH4pNmDpMU+owkOJrpVgk
	 a/vfFiFjGxZLU5UHR92MNnfCCUlWi4JFIs3ixoPNSyo9lbIIPsa3vxFwuY2F1cfisSiO6
	 8mvu3/LAE3dk1tdPqRKNQpXkQB2ESgv0NA279NKhqWmeNWZF7CUXtRAEdALq6zeYwXm/B
	 0v/IQ1UXK8MBvRsYlBjjJpRJEOaJV1a6v9dReqhrBCsqzpiv/0i9EyKjXONFSqMKZQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794561576;
	h=DMARC-Filter:DKIM-Signature:X-QQ-XMRINFO:X-QQ-XMAILINFO:From:To:Cc:
	 Subject:Mime-Version:Content-Type:Content-Transfer-Encoding:Date:
	 X-Priority:Message-ID:X-QQ-MIME:X-Mailer:X-QQ-Mailer:References:
	 In-Reply-To:X-QQ-mid;
	bh=FLTgX6LXmfZbFelzTi0LMWJd4LIKhoEfobITuQk3Lys=;
	b=bXqUvHbgl6DH/DZeBget5uyTc5AYTxGGwmQ+qFhVA6PdD8jIh4w+bXyxUW8SdjyhdEiz
	 /tTom+pKYDyvRV/ptW5bj5C/kBQg1frLyN1tMGOdoz+wh+uXmK9srJnxy+WojItLTaW4f
	 zY+afOq4+/Q054tvUObSW+rOirWMtN0XEiK69pwyQpxiztLqEzYfFkj1l3DPhurLWw+QT
	 WFKazq3JcVUidZfNKfBViV6FrEVFrXsL0UOSVHQrpUZPYnadBZ1JTHejWOKqU7dLgOOuu
	 A87tFuKl8VfCvSA9g59gBcD7xsLmBzSRsw6FyQMPaSs/1Jwrg0ABRQdyCGtddigwUTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=UWnIVu4l;
	arc=none smtp.remote-ip=203.205.221.153
Received: from out203-205-221-153.mail.qq.com (out203-205-221-153.mail.qq.com [203.205.221.153])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE02606A31C;
	Fri, 13 Nov 2026 09:19:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CE02606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=UWnIVu4l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794561570; bh=FLTgX6LXmfZbFelzTi0LMWJd4LIKhoEfobITuQk3Lys=;
	h=From:To:Cc:Subject:Date:References:In-Reply-To;
	b=UWnIVu4lhrn12D3GDRA1T/IpcrZATfsAZKhHh1RBcmU32Zq41Z/C31Srj3Ou4Uf/k
	 OI4h9p8Dwg9Uc2z69vGurDAWcnX0hcdRbqDXduvSb4cIkHxJbhKPQCAsI32Cagub2E
	 PmIYoeKahTWwzJGjWxisKNlYBuh+ZerWGjR4W8iM=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-XMAILINFO: Nc4sSaQs5LhjhuwfxraDTfC6XJ/Rq8jVRZP+R02RkzswqGKmXwU+qN/L8r8TM0
	 ww6H5yShFksTHfz6DZtO/O4eW58x8upCQL3BaNjMQ2MMIK93ee9tbGTT4cu5UvBop/m/SQZcEFbvy
	 s5KQDYRHQqxrpitZIqhfWE+2edJnrhVyf/3xKXDSGu6Ilvoz9yUgX+UrbaI6i4Z0KOOa7jGFK8m0h
	 hcXUkDgdlETV7YgTdI4PCKNwS0glh3eAouEq9foflNg0BxVPSRY6fqoH863nEDLs2Nt22DtsevRZn
	 nSVa7F8qFQzkXPCzNmaFivG6qlECtvkPDLG6+q7gElMzz3RIkqu1QINE/BLMt9N2cxJaTULz+O/o4
	 unZ2pTu2f7Ocz/sphtnjd+///icmb+/Ve+GUhBQ62OlBKzh0lEOS7EBEYV2wtFgewLmT0rzaK0SDD
	 2VpisKVUmOwi9HMsLWmBOeZqP0Tc1QHA1S6erwXfazW0lTFQnpNh+fQXGTunlSsOPYsaVQo12mtwK
	 lPieW/Mm8rPIIqoov/MNBd+7T4UFGW4ixL6sXQm2nCmYEYhjq+LpkHQCI1LGg/zwaHDtbRT52R+vp
	 bRG1w19lQStBXkNOEjAnYcDcpkVKu5pHzXwUs54Yhb6zRdRZOrKq7DODU+t5Di4qUgYLfKwiegaa5
	 Q/b7I9DAQyb6oPmhtbRzVyZwsmESwjIXMKdCWQ00c9MenbK3HG3E22/kSB3Zzdf64REnXz9+CY6Rn
	 RBAKCHxux0VZybjWAVBCYgowHGKGwbIq2nwy8kSnfsDEt55K9N64rVryLMZy8mI3gnfaeTwpef04w
	 DLtoG8XgS5dfPYfx5kX/m5zfw95aKe+Th8/33pA/qrEoX9wG7gUlTWypkiaSBR9mfn37sgwE1eW9T
	 tMXBzbotnsecZp5cqfOIg8uQd+2ZF0FYbnoHUiCoAqcq+cBAiUasy3RsJgycwOTJjnyzMykMyhKki
	 IcAtNdWglbcy0TT3ZP6HUq8PSZ2orbedL9sl/ZFCJnv4MjUx5twYWTxA5r8NzpTPeTirXQMmaT7j/
	 WPBGvl4jiQeTL9H4b7fphUfA11dsTqP3HDSGEp7RAgjek8JY=
From: "=?utf-8?B?Q3VuaGFvIEx1?=" <1579567540@qq.com>
To: "=?utf-8?B?TWF4aW1lIENoZXZhbGxpZXI=?=" <maxime.chevallier@bootlin.com>, "=?utf-8?B?QW5kcmV3IEx1bm4=?=" <andrew+netdev@lunn.ch>, "=?utf-8?B?RGF2aWQgUy4gTWlsbGVy?=" <davem@davemloft.net>, "=?utf-8?B?RXJpYyBEdW1hemV0?=" <edumazet@kernel.org>, "=?utf-8?B?SmFrdWIgS2ljaW5za2k=?=" <kuba@kernel.org>, "=?utf-8?B?UGFvbG8gQWJlbmk=?=" <pabeni@redhat.com>, "=?utf-8?B?Um9iIEhlcnJpbmc=?=" <robh@kernel.org>, "=?utf-8?B?S3J6eXN6dG9mIEtvemxvd3NraQ==?=" <krzk+dt@kernel.org>, "=?utf-8?B?Q29ub3IgRG9vbGV5?=" <conor+dt@kernel.org>, "=?utf-8?B?SGVpa28gU3R1ZWJuZXI=?=" <heiko@sntech.de>, "=?utf-8?B?RGF2aWQgV3U=?=" <david.wu@rock-chips.com>, "=?utf-8?B?QWxleGFuZHJlIFRvcmd1ZQ==?=" <alexandre.torgue@foss.st.com>, "=?utf-8?B?R2l1c2VwcGUgQ2F2YWxsYXJv?=" <peppe.cavallaro@st.com>, 
	"=?utf-8?B?Sm9zZSBBYnJldQ==?=" <joabreu@synopsys.com>, "=?utf-8?B?TWF4aW1lIENvcXVlbGlu?=" <mcoquelin.stm32@gmail.com>
Cc: "=?utf-8?B?bmV0ZGV2?=" <netdev@vger.kernel.org>, "=?utf-8?B?ZGV2aWNldHJlZQ==?=" <devicetree@vger.kernel.org>, "=?utf-8?B?bGludXgtYXJtLWtlcm5lbA==?=" <linux-arm-kernel@lists.infradead.org>, "=?utf-8?B?bGludXgtcm9ja2NoaXA=?=" <linux-rockchip@lists.infradead.org>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>, "=?utf-8?B?bGludXgtc3RtMzI=?=" <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH net-next v2 1/2] dt-bindings: net: rockchip-dwmac: Add RK3572
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
Date: Fri, 13 Nov 2026 17:19:28 +0800
X-Priority: 3
Message-ID: <tencent_407EF44D1A34A432300969237F012088F708@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20261111-add-board-ok3572-c-net-v2-0-304466394970@qq.com>
 <20261111-add-board-ok3572-c-net-v2-1-304466394970@qq.com>
	<85370a77-e2ef-4eae-96f0-7f591625f47d@bootlin.com>
In-Reply-To: <85370a77-e2ef-4eae-96f0-7f591625f47d@bootlin.com>
X-QQ-mid: xmsezb41-0t1794561568tn9q43j08

SGksCgo+ID7CoEFkZMKgdGhlwqByb2NrY2hpcCxyazM1NzItZ21hY8KgY29tcGF0aWJsZcKg
d2l0aMKgdGhlwqBzbnBzLGR3bWFjLTQuMjBhCj4gPsKgZmFsbGJhY2vCoGFuZMKgcmVxdWly
ZcKgcm9ja2NoaXAscGhwLWdyZi4KPiA+wqAKPiA+wqBTaWduZWQtb2ZmLWJ5OsKgQ3VuaGFv
wqBMdcKgPDE1Nzk1Njc1NDBAcXEuY29tPgo+ID7CoC0tLQo+ID7CoENoYW5nZXPCoGluwqB2
MjoKPiA+wqAtwqBBZGTCoFJLMzU3MsKgdG/CoHRoZcKgc2hhcmVkwqBTeW5vcHN5c8KgY29t
cGF0aWJsZcKgbGlzdMKgZm9ywqBjb25zaXN0ZW5jeS4KPgo+IFRoaXPCoGRvZXNuJ3TCoGFk
ZHJlc3PCoEFuZHJldydzwqByZXF1ZXN0wqB0b8KgZGVwcmVjYXRlwqB0aGXCoHR4X2RlbGF5
wqBhbmQKPiByeF9kZWxhecKgcHJvcGVydGllc8KgZm9ywqB0aGF0wqBuZXfCoFNvQy7CoEV2
ZW7CoGlmwqB0aGXCoGJvYXJkwqB5b3UncmXCoHVzaW5nCj4gZG9lc24ndMKgbmVlZMKgdGhl
bSzCoHdlwqBuZWVkwqB0b8KgbWFrZcKgc3VyZcKgbmV3wqBkZXNpZ25zwqB3aWxswqB1c2XC
oHRoZQo+IGdlbmVyaWPCoHByb3BlcnRpZXPCoGZvcsKgUkdNSUnCoGRlbGF5c8KgOikKPiAK
PiBUaGXCoG9sZGVywqByb2NrY2hpcMKgZ2x1ZXPCoGhhdmXCoG5vwqBjaG9pY2XCoGJ1dMKg
dG/CoGtlZXDCoGFjY2VwdGluZ8KgdGhlc2XCoGZvcgo+IGNvbXBhdMKgcmVhc29ucy4KClNv
cnJ5IGZvciB0aGUgbWlzdW5kZXJzdGFuZGluZy4gSSBoYWQgb25seSByZW1vdmVkIHR4X2Rl
bGF5IGFuZApyeF9kZWxheSBmcm9tIHRoZSBkZXZpY2UgdHJlZSBmb3IgdGhlIGJvYXJkIEkg
YW0gdXNpbmcuCgpJbiB2NCwgSSB3aWxsIGRpc2FsbG93IGJvdGggcHJvcGVydGllcyBmb3Ig
cm9ja2NoaXAscmszNTcyLWdtYWMgaW4KdGhlIERUIGJpbmRpbmcgYW5kIG1hcmsgdHhfZGVs
YXkgYW5kIHJ4X2RlbGF5IGFzIGRlcHJlY2F0ZWQuCgpCZXN0IHJlZ2FyZHMsCkN1bmhhbyBM
dQo=

