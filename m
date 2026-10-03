Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4440D1A9FA0;
	Sat,  3 Oct 2026 09:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791020739; cv=none; b=bdxw/gk5zmxisisXrwx51WgHLe8FJOsYUrf2MZMPvSjoofJ8kFJKx8LMo3Mey/Tn1vvUzH/2/0DwlrkArQUy/CWB6Q60PS1hb6FOUug5+IxbkDlXBtSDYSYU/3Blbt1OpLatsM3ongZtBplu6E3GjBy8vVbFkBVJNlw9UhK1puY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791020739; c=relaxed/simple;
	bh=KBX+8dwqjjJeqTwvAQH1qKq6zd9qAHSj3a97B1IHKh8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=GAcKCavphxaIuISHLnY9d8mp54FW3Z3d9sKzQwTtRp0LSRvZ6pUIS+mkdt7X9Dn3PlZkNNpYpI1mrbdUW2AHNWQxXRcPcetdOd5khEPs9ih68g1xnjs1mOdksI4l5l7o2WdrWRsKoWJo2jFOKvY/V18a6rWaCFfY5R7cV95SOiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=b4axHCB5; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="b4axHCB5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=KBX+8dwqjjJeqTwvAQH1qKq6zd9qAHSj3a97B1IHKh8=; b=b
	4axHCB53HTHcRn+XsfJv9wDPxKQ/+PUu3fXWM6Q2X6thyOnTmpyaDF/uQIRZJjOU
	gf5PTWovp7viU6gpje9Pg9oGvUtw905oHulGKo6rtUTjFTCFyh6BRc+x1zKVlmIN
	qMrZIyK+uwv/SocJL853j53GhHs8wL8XfrZdIOEaYM=
Date: Sat, 3 Oct 2026 17:45:04 +0800 (CST)
From: "jiale yao" <19888972804@163.com>
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: "Willem de Bruijn" <willemdebruijn.kernel@gmail.com>,
	"Jason Wang" <jasowangio@gmail.com>,
	"Andrew Lunn" <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	"Eric Dumazet" <edumazet@google.com>,
	"Paolo Abeni" <pabeni@redhat.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH 2/3] tun: Drain eBPF RCU callbacks on module exit
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <20261001161209.135f0aef@kernel.org>
References: <20260926162554.163197-1-yaojiale02@163.com>
 <20260926162554.163197-3-yaojiale02@163.com>
 <20261001161209.135f0aef@kernel.org>
X-NTES-SC: AL_Qu2SA/yZv08r4iWdYOkdmE8Uges8WcC0svki1YJUc+4GhzHBwiABbHpeBEnt4NmlFwSNnAm9ShFy8/5qb6BZFZLhWms8IHbL+IWRqQIsJw==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <3283db82.138f.1a101272332.Coremail.19888972804@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:jygvCgD3JyOgzsBqjkYHAA--.60013W
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC8ACm4GrAzqBgFgAA3E
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

SGkgSmFrdWIsCkF0IDIwMjYtMTAtMDIgMDc6MTI6MDksICJKYWt1YiBLaWNpbnNraSIgPGt1YmFA
a2VybmVsLm9yZz4gd3JvdGU6Cj5PbiBTdW4sIDI3IFNlcCAyMDI2IDAwOjI1OjUxICswODAwIEpp
YWxlIFlhbyB3cm90ZToKPj4gU3ViamVjdDogW1BBVENIIDIvM10gdHVuOiBEcmFpbiBlQlBGIFJD
VSBjYWxsYmFja3Mgb24gbW9kdWxlIGV4aXQKPgo+cGxlYXNlIHJlcG9zdCB0aGlzIGlmIHlvdSBl
eHBlY3QgbmV0d29ya2luZyB0byB0YWtlIHRoZSBwYXRjaAo+cGF0Y2h3b3JrIHdpbGwgd2FpdCBm
b3IgdGhlIG90aGVyIGVtYWlscyB0aGF0IHlvdSBkaWQgbm90IGNjIHVzIG9uCj55b3Ugc2hvdWxk
bid0IHBvaW50bGVzc2x5IG1ha2UgcGF0Y2hlcyBmb3IgZGlmZmVyZW50IHN1YnN5c3RlbXMgaW50
byAKPmEgc2VyaWVzCgpUaGFua3MgZm9yIHBvaW50aW5nIHRoaXMgb3V0LiBJIGhhdmUgc3BsaXQg
b3V0IHRoZSBUVU4gY2hhbmdlIGFuZApyZXBvc3RlZCBpdCBhcyBhIHN0YW5kYWxvbmUgcGF0Y2gs
CmluIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI2MTAwMzA5MzgyMi41NDQ5NjQtMS15
YW9qaWFsZTAyQDE2My5jb20vIAoKSmlhbGU=
