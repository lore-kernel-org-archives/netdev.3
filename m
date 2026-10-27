Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793097699;
	b=wZ1rifxTe2mc36uF/cFbGWxbbMSvDiqNdL+/4/N3rfcjILFMmum5p/d6dN8eYmT2r9hS
	 oTceSN22M56Smf3X4+6L9lFbLsOJlYKrU91Uq+Kt+6jrfPpnsMyejZBEStrHJb/1QgKEv
	 3PBB76681r9//47Pdp3NHmvQUGhFQZsz+Cx6gLNKDhcrH3AB6GOlHvEs4fwKKeI86TRGJ
	 HE2on6Kt99lHpDCMcjJoS3EmbqV3FKV4P/nmC3bdxMDzRRCcOGgQz2cy8MNqx5vXcAhE4
	 1qBYbml0Ti0veej2Fbj2BYqiktLkk6MAaO9kP13ypWB6x0xbaqls4j9owh6r8PMCFVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793097699;
	h=DMARC-Filter:DKIM-Signature:X-QQ-XMRINFO:X-QQ-XMAILINFO:From:To:Cc:
	 Subject:Mime-Version:Content-Type:Content-Transfer-Encoding:Date:
	 X-Priority:Message-ID:X-QQ-MIME:X-Mailer:X-QQ-Mailer:References:
	 In-Reply-To:X-QQ-mid;
	bh=ODqdDll0GzeBcm5id2YOWtXPK8sRGU89nkrBsWu4rGg=;
	b=IvlufPqsS7l6Jef2gPURh238yEGdhDKJOV1BPUf6PQ/mbaYnUD/uzSLPH728Na4wBlrP
	 Qok7EtpgLPcvSN0cw77Z0mFzS7vr9A66yvuPzjsxAfR9u9C+xuvlKm89mitpXx4kHnIL7
	 wtuOW6ZmGOAT96qzq2/DUQ178Iv68sbcWw324Z/n0QaiscamYYToKRuk/GqBSwR/xVzCr
	 TnHreTG/1fLR0oGvJNRg05z/I+AAGCzVxKZ1u9fMRohY5dnJqHlP3P/DY7btbsTmJ1y0S
	 6V6Lm7c3L/8jcptSHoHUYE/DOWmr9W5sQP7CUZFmpfyVIn5G7CvOwH0jrenuYfHNLNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=Bp8TzZwa;
	arc=none smtp.remote-ip=162.62.57.64
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D75606A31A;
	Tue, 27 Oct 2026 10:41:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9D75606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=Bp8TzZwa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1793097688; bh=ODqdDll0GzeBcm5id2YOWtXPK8sRGU89nkrBsWu4rGg=;
	h=From:To:Cc:Subject:Date:References:In-Reply-To;
	b=Bp8TzZwahKLRL/SddY2Sg0Z4EgXZhFRQLTen7N4HzWrkmRHPComRS++ga8FooxmU7
	 1LC7SrAb6PmnKry6S1aQWCifa17/ZE0OKqj9XUDSzlUgOvj9SXDwvUj0NGmDURJGFl
	 f2QZM1+wE6nVmwtcj+MnabNzHNCO5Viis1uiB1sY=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-XMAILINFO: M8rNKBZ4ITTu/T3HBktjzCSSpmd1v49tTIKVoHY4f8yo6KAyxeR/z8PauSRxY9
	 OdcEgVFE5C6gG8fOIhtokmXv2YwzhxMs55TK8NTw6dJih0xDXHMmwoxERaCYOdz9Vzw47IjxXZMh2
	 dOrvV4n5wLxxc5MXL3XcegqP/t0LfZ+LgW59i0fmyjDa4Yb2RX+7Pa7kO3h4GQBoQLvvnJFCjGYB0
	 wMhqhpedsNpEoVTB6XjrpHAwig+k6vh00HtpQe8FoxfLgqMEhx7ECLOyEHZ/je7cvaP8FzLGSCrGo
	 3JK2h5c3Fk/xf0riijVv/v7sG4SoXzHfLsSRdQunYLgUdiPVzLwN09HvoHS1sR8tvnD+fPrn1ql0T
	 xZ79A6xIXH6muirtZah6s0NLu/1dXFzC0q2H/sliiCqeaX/Qj3xKrnndLvWrDshBfFz23Dksm1uqb
	 UoEe0pYJSoSMpA70gV8Pvz7/PFSVpf5282wtBHXS8lR2t57XUylinUCa9bFIY6ZU5VPoOudeGZQc7
	 wnmPhKE78tVPF+4GeQ8CkswPdfdXM6+dqQz8+7BLoZ7Vyf3aWIIySSbkvTBkiGcSyL2ae/RoHI2S8
	 grDRhZQklHs/Ni+HLQFItuB36xHyVNDPaanqVKhNIuFkxNuzYBCPhdSsvYxAXTOSx725ETm/fTspt
	 4pkvfJqLQgprVQMPNWOCMgQO356hvXIOJxEsBwMLaxGjifu+Ri0Vp1PQzvBk5r8mLO9eAiAdJowV/
	 7yGSyBp/Tg6bG5CVnOA4vIBGQSYPpcoaZE8B61Z3wV2swOApepU1GWOdZPpRa23/8wF3uZyBhZ38c
	 oO1SWTT1kdNMP8x1ECfqK0qxFI3rm45L55PUzFEUtl6GWO5SZOV7ujbd/hrkek3ze63PTFZuBF2OV
	 JxUru6O5R33HUCrDYBwF5RqU+PSCyrpKbXOCXl0towbPCgPmlByb1V8gCnOUCr2mZZ5WInPYj1QFX
	 rd9rqO8Pai4DufxU4w/hJub20OUgW3On7WrGGOg2AvAmcM6T7ElJ7vuElf0GL3TGRxG26HnYI/ZY+
	 zwuS/0pcmQlnFtLy0uL3tK0vAG2EEZSI41+QmyWBXVc73WHlLBpr2wZEfuo1Xb09ZDaMvnJRG80Vx
	 +Q4jOtACtzfNwPcY81qg8sQmOMKFogaCKAgGMiY5MpRm5w0rt7w+U6/9wYbj7CvBQmhmBwDZvDZHp
	 USNbgmXMoQd
From: "=?utf-8?B?Q3VuaGFvIEx1?=" <1579567540@qq.com>
To: "=?utf-8?B?U2hhd24gTGlu?=" <shawn.lin@rock-chips.com>, "=?utf-8?B?U3RlcGhlbiBCb3lk?=" <sboyd@kernel.org>, "=?utf-8?B?QnJpYW4gTWFzbmV5?=" <bmasney+clk@redhat.com>, "=?utf-8?B?SmVyb21lIEJydW5ldA==?=" <jbrunet+clk@baylibre.com>, "=?utf-8?B?Um9iIEhlcnJpbmc=?=" <robh@kernel.org>, "=?utf-8?B?S3J6eXN6dG9mIEtvemxvd3NraQ==?=" <krzk+dt@kernel.org>, "=?utf-8?B?Q29ub3IgRG9vbGV5?=" <conor+dt@kernel.org>, "=?utf-8?B?SGVpa28gU3R1ZWJuZXI=?=" <heiko@sntech.de>, "=?utf-8?B?UGhpbGlwcCBaYWJlbA==?=" <p.zabel@pengutronix.de>, "=?utf-8?B?RWxhaW5lIFpoYW5n?=" <zhangqing@rock-chips.com>, "=?utf-8?B?UmljaGFyZCBDb2NocmFu?=" <richardcochran@gmail.com>
Cc: "=?utf-8?B?c2hhd24ubGlu?=" <shawn.lin@rock-chips.com>, "=?utf-8?B?bGludXgtY2xr?=" <linux-clk@vger.kernel.org>, "=?utf-8?B?ZGV2aWNldHJlZQ==?=" <devicetree@vger.kernel.org>, "=?utf-8?B?bGludXgtYXJtLWtlcm5lbA==?=" <linux-arm-kernel@lists.infradead.org>, "=?utf-8?B?bGludXgtcm9ja2NoaXA=?=" <linux-rockchip@lists.infradead.org>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>, "=?utf-8?B?bmV0ZGV2?=" <netdev@vger.kernel.org>
Subject: Re: [PATCH v4 2/4] clk: rockchip: Add internal support for 24-bit fractional dividers
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
Date: Tue, 27 Oct 2026 18:41:25 +0800
X-Priority: 3
Message-ID: <tencent_AE0E51DA2FACC999E65D6631016044234005@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20261027-add-board-ok3572-c-clk-v4-0-d4152b4fedaa@qq.com>
 <20261027-add-board-ok3572-c-clk-v4-2-d4152b4fedaa@qq.com>
	<f9068153-0d6c-471f-a08b-41cff51ff748@rock-chips.com>
In-Reply-To: <f9068153-0d6c-471f-a08b-41cff51ff748@rock-chips.com>
X-QQ-mid: xmsezb41-0t1793097685t5ro03ncb

SGkgU2hhd24sCgo+IEkgZ3Vlc3MgeW91IGFyZSBkZXNjcmliaW5nIHdoYXQgeW91IGNoYW5n
ZWQgYWdhaW5zdCB0aGUKPiBvcmlnaW5hbCBwYXRjaCBmcm9tIEVsYWluZS4gQnV0IHRoaXMg
aXMgbm90IGhvdyBpdCB3b3Jrcy4KCkknbSB2ZXJ5IHNvcnJ5IGZvciB0aGUgbWlzdGFrZS4g
QWZ0ZXIgY2FyZWZ1bGx5IHJldmlld2luZyB0aGUgZ3VpZGVsaW5lcywKSSB1bmRlcnN0YW5k
IHRoYXQgbXkgbm90ZXMgYWJvdXQgY2hhbmdlcyB0byBFbGFpbmUncyBvcmlnaW5hbCBwYXRj
aCBzaG91bGQKaGF2ZSBiZWVuIGVuY2xvc2VkIGluIHNxdWFyZSBicmFja2V0cyBbXS4gSSB3
aWxsIGtlZXAgb25seSB0aGUgc2lnbmlmaWNhbnQKY2hhbmdlcyBpbiB0aG9zZSBub3RlcyBh
bmQgcGxhY2UgdGhlbSB3aXRoaW4gc3F1YXJlIGJyYWNrZXRzLgoKVGhhbmsgeW91IGFnYWlu
IGZvciBwb2ludGluZyBvdXQgbXkgbWlzdGFrZS4gVGhpcyByZW1pbmRzIG1lIHRoYXQgSSBz
dGlsbApoYXZlIG11Y2ggdG8gbGVhcm4uCgpCZXN0IHJlZ2FyZHMsCkN1bmhhbyBMdQoKcHct
Ym90OiBjcg==

