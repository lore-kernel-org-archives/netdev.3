Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB1B35AC0C;
	Fri, 12 Jun 2026 10:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781261819; cv=none; b=b+UTUHAriNkub3Es6Q3Y1SFXf/k+jyUgMzTq2QxnL/Wf+MVuVw5kKiV+ChK1gWf6zrd1VPm6iL65MhSaf6jldfzgsYbyB4mnAYZssOowEkYw7V++mRATLs35h8fhu3MXl5J5I67EWR0/V0bUWUKm1xI6kRl66tl1TxcCT2zkhhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781261819; c=relaxed/simple;
	bh=lgRpJT7S8WmTDGq1fZnq37M3DL7O5UxnbIGZNBDEkU4=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=WHHgS6CWl8BjTl1pgQtHodiIjD7ppoVzE5LPLwZZTIpz2Q5LvX52LcSdJcEUmMqulUSFfLAQs0O65TcAhv/LdcFNwcOjXqkDMxjQMPKnQLoUgFgEylvz58sBfWf0LUbrjJhb1GpEkNvhU3XNGbhAUhVBkbgbHL1p7FbsRl0jj1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=O+KXPeqp; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="O+KXPeqp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1781261775;
	bh=lgRpJT7S8WmTDGq1fZnq37M3DL7O5UxnbIGZNBDEkU4=;
	h=From:To:Subject:Mime-Version:Date:Message-ID;
	b=O+KXPeqpc8B4jWMQwuQDFofWd7MN57Oq3IAJSm5eNXF2XCb2WgDWWeeXnhK89NH2l
	 30R7E7MCoega4WInKNuId91kzFxzGZVYleLYqKsfRAmOCfZ5P+2wtUAX2Gx93F7pnJ
	 0VGGhpow7LdUIUs7Bg/zS1IejhSDam7u6rv+ucJQ=
EX-QQ-RecipientCnt: 8
X-QQ-GoodBg: 1
X-QQ-SSF: 00400000000000F0
X-QQ-FEAT: D4aqtcRDiqSYScHvcdjMLM1Y+xZqzQ9cC+I23XEKuwU=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: xB3OrlVPi3vnBQV+X5q7KXRPtbwe7uii3qUetF8LePw=
X-QQ-STYLE: 
X-QQ-mid: lv3gz7b-6t1781261745ta704af38
From: "=?utf-8?B?V2VudGFvIEd1YW4=?=" <guanwentao@uniontech.com>
To: "=?utf-8?B?SmFnaWVsc2tpLCBKZWRyemVq?=" <jedrzej.jagielski@intel.com>, "=?utf-8?B?bG9yZW56b0BrZXJuZWwub3Jn?=" <lorenzo@kernel.org>
Cc: "=?utf-8?B?bmJkQG5iZC5uYW1l?=" <nbd@nbd.name>, "=?utf-8?B?c3VqdWFuLmNoZW5AbWVkaWF0ZWsuY29t?=" <sujuan.chen@mediatek.com>, "=?utf-8?B?bmV0ZGV2?=" <netdev@vger.kernel.org>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>, "=?utf-8?B?6IGC6K+a?=" <niecheng1@uniontech.com>, "=?utf-8?B?5Y2g5L+K?=" <zhanjun@uniontech.com>
Subject: Re:RE: [PATCH net] net: ethernet: mtk_wed: debugfs: correct index in wed_amsdu_show()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Fri, 12 Jun 2026 18:55:45 +0800
X-Priority: 3
Message-ID: <tencent_22AD5BAB1653961B4FF88203@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20260612064501.203058-1-guanwentao@uniontech.com>
	<PH0PR11MB5902816638ABEF8EAC1C1D48F0182@PH0PR11MB5902.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB5902816638ABEF8EAC1C1D48F0182@PH0PR11MB5902.namprd11.prod.outlook.com>
X-QQ-ReplyHash: 3852605563
X-BIZMAIL-ID: 13455078298466844166
X-Address-Ticket:version=;type=;ticket_id=;id_list=;display_name=;session_id=;
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Fri, 12 Jun 2026 18:55:46 +0800 (CST)
Feedback-ID: lv:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: NFXvChbjhpWZ6QUOdYbhGePKZpx//jZ8AdgDUdxvSF+DgXgTmxJVfdbQ
	XVIg3n68O4TyOQsSeND8WFpyVC1eoE+JavIPDlMZLbkzu+AqwPmMM0xWMwpSnYXokLK60ln
	patdgpsrg1CpWvb4TpJc8mcrZ0Pn18b5ReiJ07VzUvQoymn7Vn5jsF1VeElvtKFSryuqDsG
	5cYrYfVkFEWk3uSCE3TEPLhfZOKq/aJS8LsDQ/9OQKhrk/+EEK3naikglQo7wQRBMDX9qEN
	sPrtRkl/umwgbHMKz/yVhDIyjtpmbj0CXjSucchqz01XDMOpSeA95bzFsojbaeQAZbtNHEv
	Ik6PqFckcL3pcgGqF91ERJRuoa5fFMAfVIHYhZHPSonWzHZnJO+Aju4DZj7+nJC8ajYNa9y
	NforkUeDISx8d3fWU7Z5YZLCckZu+L5c39L/EBz/GHr319a2ZSHhfWl0bI2kxDb9d1FQC6o
	mAUrUfSSlq9aqN3ZI7Zk/uv8qdtDtktpkTnEU3rxIwSf+23xP5OKR+o+qkkNVTwe7cMRBH0
	eBTKMKxwvH/vgOCYE+U5kiOKjccFVjJo1RKwuZ/dSEdS4r/66K074+AxR22F79x+oUbme1B
	RnPSNQxZXA6E22KuBw7UPHeGQdSFoFuVxmnfEyyPX2ZWr22zOW7Xhf/1ogTH6spQ8JyjbnR
	Or325JWPn3YcgGihjUXWIv/KzqDiknSJtEj+hBoEyp06njGUTvgQfinGnYBLm7zaahbcizJ
	hsaJtPforvPE0CQbvHdl9greerBwCC6BCMZONTBeQkn4A4fN9nPn661kLT9rVwA5uWqcYpR
	onUP6BrEaZ2+EHN6TnghrLVYwNbpO/9Ra8bjp9uvqCjHpf+A/GAzpShqT9X5fwHNSkDDF62
	eZr/hJhiByPTYRVbLZkz0isSayCuhepfqjPGyY0u4y6Oo4nbuytsULJJB6bXaq4HSZsLzy/
	E0lUdz9UEYPG7bipSH/dWUYc0KhmzQM4miY1g7XZZsEvD9aliFOMDNrdLC5QGTPoMjOKFOx
	ik169+ild1j0wX3FQPRX0N947JStE8uplqT4WuYxZY2gRp7atJL9cJJ2h+38Ob2EYvmPjvo
	6TjFcETog/iZwERr4mwuUpFbcMDqqwEng==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

SGVsbG8sDQoNClRoYW5rcyBmb3IgeW91ciByZXZpZXcuDQo+IEZyb206IFdlbnRhbyBHdWFu
IDxndWFud2VudGFvQHVuaW9udGVjaC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgSnVuZSAxMiwg
MjAyNiA4OjQ1IEFNDQo+IA0KPiA+V0VEX01PTl9BTVNEVV9FTkdfQ05UIHBvaW50IHRvIGRp
ZmZlcmVudCBlbnRyeSBieSAnYmFzZStuKm9mZmVjdCcgbW9kZSwNCj4gPmNvcnJlY3QgdGhl
IHdlZCBhbXNkdSBlbnRyeSBudW1iZXIgaW4gd2VkX2Ftc2R1X3Nob3coKS4NCj4gDQo+IG9m
ZnNldD8NClllcywgbXkgZmF1bHQsIGl0IGlzIGEgdHlwby4NCg0KQlJzDQpXZW50YW8gR3Vh
bg==

