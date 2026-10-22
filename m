Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=43.163.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792649354;
	b=CKRH1mtyRh1kFsKjHgkoc3ZFh2VhJJ/BVcqI8Dg1ESerEHUnri9zD3CVGFu+Dd8pMVtg
	 /CrdBmhVOiXQXN8pL7qfdWkeTtR+H4V5qPQQkofgckKUMKVVdD9abJm8r4yHOXUcrj9nf
	 gGYw9P6q/i+n7xTw5M25wVg+tpprBBdp2a7J7NFus/1PvRLYgc2ZIeoAgD8bnu6Sebdut
	 cA8ZeolgFoqRFFVoQHRV+JzXOp8nAOmWpGSgsE2iGKQcJhz+jpDA15SP0fpqPhTG2xybR
	 YPv/eFK/v4RsD1lyfIgzSah0rCXXahSl6ymiPut5S1k4sxGFQCHMaAuje5RyBpLAqSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792649354;
	h=DMARC-Filter:DKIM-Signature:X-QQ-XMRINFO:X-QQ-XMAILINFO:From:To:Cc:
	 Subject:Mime-Version:Content-Type:Content-Transfer-Encoding:Date:
	 X-Priority:Message-ID:X-QQ-MIME:X-Mailer:X-QQ-Mailer:References:
	 In-Reply-To:X-QQ-mid;
	bh=XQEbex78dJiZ6flYdEKHWa7WKCcFJQn3S3ebxGv69bQ=;
	b=ysSxe7IaNEIZbjmlkPw+LhhOGEl/ji7uhjIDupfp3LOCT3uFuX7wsHtqsQrlIqMnXPyr
	 hNJ4v7xMLr5MvW3SZ4daYUjd68epynGlPnId3ayWEH/p00iw+P5Tr87koIZhCbaFr0bsz
	 hbzivNdjnPJImGeKCL8Xz8/Isczk9g0pZcTjk1OXjbIdmTjsphjqL69xPmZwsaudXWJNI
	 Ol/wxajZb7XPktNGuq8jffvuSN0dmebHjWOidIILWbygGJQTvhyds5FLmXU0FFp1xwUjh
	 o2qR8G2IWYfkG1fTkbHSJxJf8/z394yckfOTKVACciDXbCHnPAqqhUckwh0SIXpiQJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=dke68V5f;
	arc=none smtp.remote-ip=43.163.128.54
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.54])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C49606A326;
	Thu, 22 Oct 2026 06:09:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72C49606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=dke68V5f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1792649345; bh=XQEbex78dJiZ6flYdEKHWa7WKCcFJQn3S3ebxGv69bQ=;
	h=From:To:Cc:Subject:Date:References:In-Reply-To;
	b=dke68V5fdaWoVr56UMQspozjY/X3+ezmVl9ttznTmfn1AOAaIZtld/5UOUeXPwKGP
	 rJt/Nf5ihUDjUO7ePMWGVYS1Sse1xwkoHQZ2dSfbm5bY0+CYj9kDLcdz2sPZJ+Gmto
	 coC7tKnQ3YX4cjCo5PjrmVoHWXIP/PaX0dWMTs0A=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-XMAILINFO: NsCqLbOOOuIqLRqC+FSlwScu91X/dvsM21w86Qepldmed9erOtty5JZbfypXor
	 Z+W8O+qRKguP1gOe5jgtjB1OBSp3Z0CUpphBH8b1J3YTd1v2QGH/3+iQiID2HdSTyWc6Hqht2BGKE
	 uotxFC3g6/P3V8I4Xjj708z2fqSIOzUFwSwzhTEHLSoCOhlApTu+7M943+yxFb7CTRz1FxldR6Wi9
	 yiw/mmS6mw/xzXtrfQc24ZhI/enBE36ygOVydHWsjH9LyfbhDh9ByrFNJ/fsR04ZFRTRNM8w5I3g2
	 WqJszElvpwOYJFzxLGvJ2ReXzajNsYHRNhSfUbXRX8bfAglK8yJmYWjcuhBBEavz7lPOKqqVBENXZ
	 FW52p9cZ3pQVGaFF3UcMdDGFOBviVeBZCkLRINLo5IlUAZW1Wg1eW/urrzEjYt8xmjHk7rvHZGasP
	 p9v0cgyp3Ir4WP+FEfQy+lUEGHXJigjMkD992wxlnskkUIFvMld7nHb0iCRaj9OBOfXD7pJ/gIpLQ
	 scxS3EUml5N4kEXvuu3LXxufgq8JVlEJiUMu5ijnuLWHHi/cBD35fASiOHNDlHih9+HG3Imm6GBrU
	 FbkwGjeB5qmvC6HEfc5EgNbByn7s3Xik+hVBijPxygwxu98unyy4JD5XXdYm9tRN+rHZndULE/nlt
	 t5IuP3Sf8B/zENLz9PzmLTyXZhvEO/bACsik15vyKkGRl8YljJ3rR8vR0+4bGiZfOtrQ5jW4Vh8t7
	 jlJl5bjOkANIQd/mnjopt4onu8RKx+dlAlTldKvvxEmSwW0ifKb8+3kp7xdCGhBi0GM7Umo52jzrq
	 XKs7NtCCiBxXNFr1v6ZRJTu+tmnCVuwotxcoWE00rimlqOT/LEcaHHhxnGMkwPyBDt2eqMrmPKExV
	 O6p4EPDtLdnh721MWleAnB2y117F+YwzjHHI95nkvcLVMxx38ce7WP2M+EyP76+iIoMOhWik1Yb62
	 Cq1woms1pd0MEObSkwVrtYCqjjDBMF3RTB/+F0et9qm78nflM+aey5IpuGWz7KRw56l1j/EaukSqq
	 sJ4u37ZbLyRuwChBhAw7pVxjoh5NQ8JmorbawI6TgldryQ4M=
From: "=?utf-8?B?Q3VuaGFvIEx1?=" <1579567540@qq.com>
To: "=?utf-8?B?SGVpa28gU3TDvGJuZXI=?=" <heiko@sntech.de>, "=?utf-8?B?RWxhaW5lIFpoYW5n?=" <zhangqing@rock-chips.com>
Cc: "=?utf-8?B?bGludXgtY2xr?=" <linux-clk@vger.kernel.org>, "=?utf-8?B?ZGV2aWNldHJlZQ==?=" <devicetree@vger.kernel.org>, "=?utf-8?B?bGludXgtYXJtLWtlcm5lbA==?=" <linux-arm-kernel@lists.infradead.org>, "=?utf-8?B?bGludXgtcm9ja2NoaXA=?=" <linux-rockchip@lists.infradead.org>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>, "=?utf-8?B?bWZk?=" <mfd@lists.linux.dev>, "=?utf-8?B?bGludXgtZ3Bpbw==?=" <linux-gpio@vger.kernel.org>, "=?utf-8?B?bmV0ZGV2?=" <netdev@vger.kernel.org>, "=?utf-8?B?bGludXgtcG0=?=" <linux-pm@vger.kernel.org>, "=?utf-8?B?bGludXgtaTJj?=" <linux-i2c@vger.kernel.org>, "=?utf-8?B?bGludXgtc2VyaWFs?=" <linux-serial@vger.kernel.org>, "=?utf-8?B?bGludXgtbW1j?=" <linux-mmc@vger.kernel.org>, "=?utf-8?B?bGludXgtc3RtMzI=?=" <linux-stm32@st-md-mailman.stormreply.com>, 
	"=?utf-8?B?bGludXgtcGh5?=" <linux-phy@lists.infradead.org>, "=?utf-8?B?bGludXgtdXNi?=" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 07/27] clk: rockchip: Add RK3572 clock and reset support
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
Date: Thu, 22 Oct 2026 14:09:02 +0800
X-Priority: 3
Message-ID: <tencent_791C8CE4050020CEF9E536C9D3B4CA9C250A@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20261022-add-board-ok3572-c-v1-0-0b0fd85a31ee@qq.com>
 <20261022-add-board-ok3572-c-v1-7-0b0fd85a31ee@qq.com>
	<2339330.72vocr9iq0@diego>
In-Reply-To: <2339330.72vocr9iq0@diego>
X-QQ-mid: xmsezb41-0t1792649342t4uw2xziw

SGkgSGVpa28sCgo+IEFzIHlvdSBkaWRuJ3Qgd3JpdGUgdGhpcyBkcml2ZXIgb24geW91ciBv
d24gYW5kIGV2ZW4ga2VwdCB0aGUgb3JpZ2luYWwKPiBhdXRob3IsIHBsZWFzZSBhbHNvIGNy
ZWRpdCB0aGUgb3JpZ2luYWwgYXV0aG9yIGluIHRoZSBjb21taXQgaXRzZWxmLgo+Cj4gVGhp
cyBjYW4gYmUgZG9uZSBmb3IgZXhhbXBsZSB3aXRoIHNvbWV0aGluZyBsaWtlCj4gZ2l0IGNv
bW1pdCAtLWFtZW5kIC0tYXV0aG9yPSJFbGFpbmUgWmhhbmcgPHpoYW5ncWluZ0Byb2NrLWNo
aXBzLmNvbT4iCj4gYW5kIGluIHRoZSBjb21taXQgYWxzbyBoYXZlIGJvdGggc2lnbmVkLW9m
ZnMtYnksIGFrYSBFbGFpbmUgZmlyc3QKPiB0aGVuIHlvdXJzIGJlbG93IGFzIHRoZSBzdWJt
aXR0ZXIsIGkuZS4gbGlrZQo+Cj4gKysrKysrKysrKysKPiBTaWduZWQtb2ZmLWJ5OiBFbGFp
bmUgWmhhbmcgPHpoYW5ncWluZ0Byb2NrLWNoaXBzLmNvbT4KPiBbZG9jdW1lbnQgd2hhdCBj
aGFuZ2VzIHlvdSBkaWQgaW5zaWRlIHRoZSBicmFja2V0c10KPiBTaWduZWQtb2ZmLWJ5OiBD
dW5oYW8gTHUgPDE1Nzk1Njc1NDBAcXEuY29tPgo+ICsrKysrKysrKysrCj4KPiBUaGUgc2Ft
ZSBhcHBsaWVzIHRvIGFsbCBjb21taXRzIGNvbWluZyBmcm9tIHRoZSBSb2NrY2hpcCB2ZW5k
b3Iga2VybmVsLgoKVGhhbmtzIGZvciBwb2ludGluZyB0aGlzIG91dCwgYW5kIHNvcnJ5IGZv
ciBtaXNzaW5nIHRoZSBjb21taXQgYXV0aG9yc2hpcC4KCkknbGwgcmV2aWV3IGFsbCBwYXRj
aGVzIGFuZCBhZGQgdGhlIG9yaWdpbmFsIGF1dGhvcnMnIG5hbWVzIHdoZXJlIG5lY2Vzc2Fy
eS4KSG93ZXZlciwgYmVjYXVzZSB0aGUgQlNQIEkgcmVjZWl2ZWQgZG9lcyBub3QgaW5jbHVk
ZSBHaXQgY29tbWl0IGhpc3RvcnksIEkgY2FuCm9ubHkgaWRlbnRpZnkgdGhlbSBmcm9tIHRo
ZSBuYW1lcyBub3RlZCBpbiB0aGUgZmlsZSBoZWFkZXJzLgoKQmVzdCByZWdhcmRzLApDdW5o
YW8=

