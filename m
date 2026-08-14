Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95535242D62;
	Fri, 14 Aug 2026 13:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786715149; cv=none; b=eYBXZQ20sMPTCT+gcdtCxHhHQIKODwvLZySj3b7DsU/iJKHCdkdUAi6ULRQ2pKXPbjunv37cHtEZc8xAJilxSlYUXTaWyfTz18nmMuDkCx2ysNmsQXiERmgv3d2hLvTtLtV/EY+DXoWnXNKImq1IoquuvOHgfvm8oUUmTKFhVaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786715149; c=relaxed/simple;
	bh=NQ40vk31HZXb/98m9MAP4Ffzf9NlD8uXfuOhcNHzve0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=QOBxkl0N6sMYOjF/4KUOdzUs6iUIndwOO0wA672cjyZWJzhtk9Saigd47y9ias8mwCipp1M83O2H3hs9MXkIS28g9UjYjR8+lrtcTCJqNtd09aS5vq540pQw53HMSUSO/kbkuuh6NXU/JioPWprEysjUeYbXwuoqsIdYSYCvLSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=HriMadzv; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="HriMadzv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=NQ40vk31HZXb/98m9MAP4Ffzf9NlD8uXfuOhcNHzve0=; b=H
	riMadzv4JMAfvAr01raL357QG7MCaXC/NcZm61EYRZYv1dAFXaWys/MEMMJeOMk5
	TBWEgE2GwDs3jFM2Nbev4qtxepswNe9xgYqmqVAhrHjg7rEHDmNtsVdHe9lAZL6C
	LLBV5CZtlmtnB5g+XzcJ9b1anDktEh584qB9kPZxsc=
Received: from 19888972804$163.com ( [117.133.52.106] ) by
 ajax-webmail-wmsvr-40-101 (Coremail) ; Fri, 14 Aug 2026 21:44:08 +0800
 (CST)
Date: Fri, 14 Aug 2026 21:44:08 +0800 (CST)
From: "jiale yao" <19888972804@163.com>
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Jakub Kicinski" <kuba@kernel.org>, "Jiri Pirko" <jiri@resnulli.us>,
	"Andrew Lunn" <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	"Eric Dumazet" <edumazet@google.com>,
	"Paolo Abeni" <pabeni@redhat.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH] team: reject ARPHRD_CAN devices in team_port_add
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <7cd9991f-57d8-47e4-83bc-2dfeb8a844ff@hartkopp.net>
References: <20260723040032.2094322-1-yaojiale02@163.com>
 <20260727182447.114f9fc5@kernel.org>
 <6be0ce2c.3d2b.19fa728cd87.Coremail.19888972804@163.com>
 <7cd9991f-57d8-47e4-83bc-2dfeb8a844ff@hartkopp.net>
X-NTES-SC: AL_Qu2TBPuaukgv7imabekdmE8Uges8WcC0svki1YJUc+oEpSv15TogVF5GE0T27s2fDgmUoQe5SShI9dxnc7F1crwG6VBmUqEwnMtZE0e0vw==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <44ba0007.8987.1a000840beb.Coremail.19888972804@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:ZSgvCgD31wCpG39qUEAyAA--.1262W
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzQlrpWp-G6kfqwAA3Z
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

SGksClNvcnJ5IGZvciBJIGNoYW5nZSB0aGUgc3ViamVjdCBuYW1lLCB0aGUgbmV3IHBhdGNoIGlz
Cmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI2MDgwNTIzNDQuWkhTVXhLYlMtbGtwQGlu
dGVsLmNvbS8KCgoKCgoKCgoKCgoKCgoKCkF0IDIwMjYtMDgtMTMgMjA6MDE6MzYsICJPbGl2ZXIg
SGFydGtvcHAiIDxzb2NrZXRjYW5AaGFydGtvcHAubmV0PiB3cm90ZToKPkhpLAo+Cj5PbiAyOC4w
Ny4yNiAwNzoxOCwgamlhbGUgeWFvIHdyb3RlOgo+PiBIaQo+PiAKPj4gU3VyZSwgSSB3aWxsIGNo
ZWNrLCBhbmQgc2VuZCB2MiBwYXRjaCBpZiB0aGVyZSBhcmUgYW55IG90aGVycy4KPgo+SSd2ZSBz
ZWVuIG5vIGZvbGxvdy11cHMgb24gdGhpcy4KPgo+RGlkIHlvdSBjaGVjayBvbiBvdGhlciBzaW1p
bGFyaXRpZXMgYmV0d2VlbiB0ZWFtIGFuZCBib25kaW5nIGRyaXZlcnMgCj5hY2NvcmRpbmcgdG8g
cmVqZWN0IEFSUEhSRF9JRUVFODAyMTU0LCBBUlBIUkRfQ0FOIGFuZCBvdGhlcnM/Cj4KPkJlc3Qg
cmVnYXJkcywKPk9saXZlcgo+Cj4+IAo+PiBKaWFsZSBZYW8KPj4gCj4+IEF0IDIwMjYtMDctMjgg
MDk6MjQ6NDcsICJKYWt1YiBLaWNpbnNraSIgPGt1YmFAa2VybmVsLm9yZz4gd3JvdGU6Cj4+PiBP
biBUaHUsIDIzIEp1bCAyMDI2IDEyOjAwOjMyICswODAwIEppYWxlIFlhbyB3cm90ZToKPj4+PiBF
bnNsYXZpbmcgYSBDQU4gZGV2aWNlIChlLmcuIHZ4Y2FuKSB0byBhIHRlYW0gbWFzdGVyIHRyaWdn
ZXJzIGEKPj4+PiBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UgaW4gY2FuX3J4X3VucmVnaXN0ZXIo
KSBpbnNpZGUKPj4+PiBuZXQvY2FuL2FmX2Nhbi5jLgo+Pj4KPj4+IEdlbWluaSByZXZpZXcgc2F5
cyB0aGF0IHNpbWlsYXIgaXNzdWUgaXMgcG9zc2libGUgd2l0aAo+Pj4gQVJQSFJEX0lFRUU4MDIx
NTQgZGV2aWNlcywgY291bGQgeW91IGRvdWJsZSBjaGVjayB0aGF0LAo+Pj4gc2VlIGlmIHRoZXJl
IGFyZSBhbnkgb3RoZXJzLCBhbmQgYWxsIHRoZXNlIGluIGEgc2luZ2xlCj4+PiBwYXRjaD8KPj4+
IC0tIAo+Pj4gcHctYm90OiBjcgo=
