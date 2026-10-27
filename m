Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.87
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793099218;
	b=BUL85ikudxKbY+apE2c9iPYbgCq3z2GsiQNnD88xrSiT+cH07bDe3x+cYffsV00KBYiA
	 oiQ2X3XuM6AhaXQj4OSncONiYmX9hO54e1Isv0IoWImAMrZnSJpLYDgu0LXyAMn9Cy9+k
	 F5pft8r8AhaTHPqjIGppWqTigy+UIxk+j5ibtZfrUmtkklto2iU0TA2IIjEwkTXDIKIEu
	 1mwGdvOphGNomkwbjW0WZtASLIXsIX2lY3Ax7kN831WUTwQwvjmgFFScSOnKrlJW5qJLu
	 noG9Kb2DFc9T3x/I6AQSc0mjpVZ3rNzUXnnDIQL/aZllCWOtIKu2kE3k6WCGCqWyBzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793099218;
	h=DMARC-Filter:DKIM-Signature:X-QQ-XMRINFO:X-QQ-XMAILINFO:From:To:Cc:
	 Subject:Mime-Version:Content-Type:Content-Transfer-Encoding:Date:
	 X-Priority:Message-ID:X-QQ-MIME:X-Mailer:X-QQ-Mailer:References:
	 In-Reply-To:X-QQ-mid;
	bh=hmJvxGzuixcFNAAocvFhqKaJGcR68LALuIVt4D8IqKg=;
	b=ZqljAiVXaJLXXFTpN/CkDfDKQfNu3z/UqvFbbCb2ZtQSObSSg8RKjg6+TmBP55XdLwLp
	 4HWxVnGaRgP2OTvNwu6bY6oO5FY73iA9UfM7/Z2ZKepAit4xIv2Vv+8XePsjuQHnHvNxT
	 X1y7agAfWbS604ozU3qa1xD+ZJ7JAdSzZWbHsgr9UHheM1bmC0itYyJYBvXBzMhadjGUU
	 SHsBMNXfqdYtljSbJ8GI1L+IpHX3k51r1N83c8b7m57SlcNFqXVDdf3x+Gdfz9UvzerNq
	 iXZ+cnsIxFIZ0FLXeQvGhCVpLT1DrXsF0TAoYhfMUt7tm7yUorWLQBM35Ixbx2f+uAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=x185AFOg;
	arc=none smtp.remote-ip=162.62.57.87
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92BC606A31E;
	Tue, 27 Oct 2026 11:06:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D92BC606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=x185AFOg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1793099211; bh=hmJvxGzuixcFNAAocvFhqKaJGcR68LALuIVt4D8IqKg=;
	h=From:To:Cc:Subject:Date:References:In-Reply-To;
	b=x185AFOgLVk4JHvZFHvy8FZwv0CQUucEB882GK+C24yqkWX+w2DQcN25mq2UEdU96
	 YT3emcoro0o7Qm+7NFr0IRyyXFhvhqyRXh58kdF6KmJfmcbFFCriW7V6iVZg5AEwcu
	 BzYRnyOAtqXApW6GSKc2iQRnBYC7lrW2CNAKrwyo=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-XMAILINFO: MOQpAxjIVJukshyDFOyjGDwxM9qZ/D5/ZWdLzyeokj2TF2nZH64jReURN66KiX
	 GZdL6fzf4n2uKIIMES66/CQUCm/Vge6LG52O2pwGbWdi3oo9eoUfRRrYiNy9GkIyv/qBi5X9aPifv
	 z74SDVZfNbGdcwih0OHQjYqATMgIcnZGRMPxxYZBLMspsXxp1RIBcorKaAhpNCbZ3nGce9FY3wPtl
	 6cqBybnBDBv2WwgpVM9xClgBkZh4NIvwmKrwo08k6fKiOem5kp5HTWmmjTh5Jsv2CeX/8TaN/w4vC
	 c4rA/3DpBQ40Qm4dQ0KokZRM8KgF8Ww1n6oRfa2m88IdQH4weycRobUiuDDrwqCELLZ4N52rNM5jS
	 l0NxInpaHBFppvxWSxmIrzi9vr5gXWjRQIJsevhf82JTNy3H7zUwYJcG3/t/BlkflT84+N8Bi0Cop
	 YL7DkdKomHl0wfRnbkGryLWNz5T2YvctKW6lcvirgFBIKKgASyR7uRlFvV3yQhSn33v0QL2T9KuXU
	 FOXxQoB9fSxFUl7EdAmrXX3U3ZSF4H+RosD7p4mX4VrP/MUe+PZZh//OiLd494xt/rwYAV+hB2Lt0
	 K8byXUdj8RmluG3nCBhuXHWgYNbdA7PI8nWjZrlZA2Xnxezdy7rNLF1jWY8rniW/SOhcEO2LZ0oIZ
	 SlC2bha4NHHYUj4yMK7ofvx9V0UVGQi3hQS3vLM83y+EXFjtcflPa3qCTWn/V8498Olmoi8n8typ6
	 H+q7pyyglpnFTerh40LY2P84BocW0VZXaTF6BSxtrUn3b5LtICHxs3NWJgkSMrqxDX/kZoldTSsP3
	 0z0TReq+vr7ssmrpKAbOElw2sAi+zMVzCq5DYp1Kxzuvxm4KHFp+jt/tr+SVAE4oQQtgr0Ol8X8gO
	 wqaw4jbIy6/TuWQenoT7XVqB5dN9ZwrpenUDrWReCpWhdexGrfLW0mzIy5Ope8Qhf8QOg83bvxRpz
	 o4SY4dyalbGKXZjugU+n8nnU+Xho7XiHBwxVtLxRWh+qQ/NjWHOp2VqdzKnpjQCK0rqItVxdJISIO
	 pzn2FcWTqPmz+tVybVZO0NELUQHhTW8iG8ZK7YSJMkhvyHwkX2vBgXup1jwP+iPgwZ+Db
From: "=?utf-8?B?Q3VuaGFvIEx1?=" <1579567540@qq.com>
To: "=?utf-8?B?SGVpa28gU3TDvGJuZXI=?=" <heiko@sntech.de>, "=?utf-8?B?S3J6eXN6dG9mIEtvemxvd3NraQ==?=" <krzk@kernel.org>
Cc: "=?utf-8?B?U3RlcGhlbiBCb3lk?=" <sboyd@kernel.org>, "=?utf-8?B?QnJpYW4gTWFzbmV5?=" <bmasney+clk@redhat.com>, "=?utf-8?B?SmVyb21lIEJydW5ldA==?=" <jbrunet+clk@baylibre.com>, "=?utf-8?B?Um9iIEhlcnJpbmc=?=" <robh@kernel.org>, "=?utf-8?B?S3J6eXN6dG9mIEtvemxvd3NraQ==?=" <krzk+dt@kernel.org>, "=?utf-8?B?Q29ub3IgRG9vbGV5?=" <conor+dt@kernel.org>, "=?utf-8?B?UGhpbGlwcCBaYWJlbA==?=" <p.zabel@pengutronix.de>, "=?utf-8?B?RWxhaW5lIFpoYW5n?=" <zhangqing@rock-chips.com>, "=?utf-8?B?UmljaGFyZCBDb2NocmFu?=" <richardcochran@gmail.com>, "=?utf-8?B?bGludXgtY2xr?=" <linux-clk@vger.kernel.org>, "=?utf-8?B?ZGV2aWNldHJlZQ==?=" <devicetree@vger.kernel.org>, "=?utf-8?B?bGludXgtYXJtLWtlcm5lbA==?=" <linux-arm-kernel@lists.infradead.org>, "=?utf-8?B?bGludXgtcm9ja2NoaXA=?=" <linux-rockchip@lists.infradead.org>, 
	"=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>, "=?utf-8?B?bmV0ZGV2?=" <netdev@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] dt-bindings: clock: rockchip: Add RK3572 CRU
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
Date: Tue, 27 Oct 2026 19:06:49 +0800
X-Priority: 3
Message-ID: <tencent_C11F61130B4D904C5A82CE0849002F22B806@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20261026-add-board-ok3572-c-clk-v3-0-dbabfa39d692@qq.com>
 <20261026-add-board-ok3572-c-clk-v3-1-dbabfa39d692@qq.com>
 <20261027-vagabond-gabby-caracara-4edabe@quoll>
	<3011736.yaVYbkx8dN@diego>
In-Reply-To: <3011736.yaVYbkx8dN@diego>
X-QQ-mid: xmsezb41-0t1793099209tc2h45k0e

SGkgSGVpa28sCgo+IFdpdGjCoGNvZGXCoG9yaWdpbmF0aW5nwqBpbsKgdGhlwqB2ZW5kb3LC
oGtlcm5lbCzCoGl0wqBpc8KgbmljZcKgdG/CoGtub3fCoHdoYXTCoGNoYW5nZWQsCj4gYnV0
wqBJwqBndWVzc8KgdGhlcmXCoGlzwqBhwqB0cmFkZW9mZsKgYmV0d2VlbsKgYnJldml0ecKg
YW5kwqBtb3JlwqBkZXRhaWxzLgo+Cj4gScKgZ3Vlc3PCoHRoaXPCoGNvdWxkwqBiZcKgc2hv
cnRlZMKgdG/CoHNvbWV0aGluZ8KgbGVzc8KgdmVyYm9zZSzCoGxpa2UKPgo+ICsrKysrKysr
KysrKysKPiBTaWduZWQtb2ZmLWJ5OsKgRWxhaW5lwqBaaGFuZ8KgPHpoYW5ncWluZ0Byb2Nr
LWNoaXBzLmNvbT4KPiBbYWRhcHRlZMKgdG/CoG1haW5saW5lwqByb2NrY2hpcMKgY2xvY2vC
oGFuZMKgcmVzZXTCoGhhbmRsaW5nwqAoeGluMjRtwqBpbnB1dCwKPiAgwqBkb24ndMKgaW50
cm9kdWNlwqBDTEtfTlJfQ0xLUyzCoGV0Y8KgXQo+IFNpZ25lZC1vZmYtYnk6wqBDdW5oYW/C
oEx1wqA8MTU3OTU2NzU0MEBxcS5jb20+Cj4gKysrKysrKysrKysrKwoKU29ycnkgYWdhaW7i
gJRJIGp1c3QgcmVyZWFkIHlvdXIgZWFybGllciBjb3JyZWN0aW9uIGFuZCByZWFsaXplZCBJ
J2QKc3RpbGwgbWlzc2VkIHRoZSBzcXVhcmUgYnJhY2tldHMgW10uCgpJJ2xsIGFkZCB0aGF0
IHRvIG15IG93biBwcm9tcHQgKGZvciBteXNlbGYpIHNvIGl0IHN0YXlzIHdpdGggbWUgYWNy
b3NzCnNlc3Npb25zIDpECgpCZXN0IHJlZ2FyZHMsCkN1bmhhbyBMdQo=

