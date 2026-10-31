Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.240
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793436173;
	b=z9mTQvSZVYVh8u+0vRkAP2PF/4XNKAs0AaINp9lhH9HschDYbDeO1yQt4QfPlL+3cDyu
	 QFTt9bEGIajDQiumcT1OtXMaVGbtdvlueY6B6ITkRvZzZQoQdjsUykTWbCopz+Qv65yFG
	 lBRG0EoFFX52I82kS3doHOsABD+1kES0APnVbIcd3ZeM/qda5vn2+O1z5gGi+swWZ0vBP
	 xsI0EzZenj5b4EJ65kxd5/p9hAyT+YIvhN36tg8A1DkTJ7X+7u64HnW5F5pL8obXI2yHx
	 M1ypdf9Ehsmo2fPxnGixnUrNW8q6My0lazBbZ+q1GoO95zwsd5ZntATuISTxDqul15w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793436173;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Subject:Date:X-OQ-MSGID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=XT3BBUo66jNQ+uBk2ktPgEN/xFQ4QZOVHHhm10OBNvE=;
	b=W8JskycPYuqYYsjDLxhnS7iiImJQ9GZh+t6DuFXE92bwn3tT4+/CLr4rxtGajtvYjIAE
	 Qa1CJBvZQki1HeAKS6Q0YxNWt1PkfTtM/Iocarwa6NUz5tJjHLZmYnYWpadJQ1zcicIhg
	 hCZUVjYtaL1gAwDCRmrEWvDB5wFhcrNWimdG8sff6y9imsPXZV+rgjMXZBTHsSmR4uv3u
	 8IixL6vdZX180owUHe7fqkinvN46Z6aqq2N+mTD9mu71LqYfMzZv4KnkAVY6W3Ked0HeM
	 BO0epD7N+ycaFEluw+BpG5mBXo4o56feqbhCJnx4v9JqG5MT2UCzlr43+ARJXGVHPeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foxmail.com;
	spf=pass smtp.mailfrom=foxmail.com;
	dkim=pass header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b="lojhR/M8";
	arc=none smtp.remote-ip=203.205.221.240
Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com [203.205.221.240])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE7F606A31C
	for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 08:42:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CE7F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=lojhR/M8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1793436163;
	bh=XT3BBUo66jNQ+uBk2ktPgEN/xFQ4QZOVHHhm10OBNvE=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=lojhR/M8UbLZr7x6+BYQ0vBbu461Gpwh9gmKB9i3+UO0tBK5kRPVli4LtO4Uvk9qb
	 LZZaz7L3BzNzM6k6kmPsaQnAs3hLJotj/WG/jkVBnC7qte0V14/yUX8oc1zz2tMKLz
	 kgDw4sO2oVwSBxGuzeowfpnoNJI4m+yXZqHNZ1b8=
Received: from localhost.localdomain ([240e:3bb:302c:4eb1:751b:856d:f57c:9109])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id A5FB5E1A; Sat, 31 Oct 2026 16:41:31 +0800
X-QQ-mid: xmsmtpt1793436091t6h2lbxy5
Message-ID: <tencent_5CB6A296D9183428F481E6A6EB9490D77B09@qq.com>
X-QQ-XMAILINFO: OPDQNGCUQ3qLeRqP5RvBmgn4oMPodAzTrTFiwBmIR97iOuQpinBfkwIdP5oVhP
	 lcI0Oj8SNfs7cvuMO85JAiAywcaCdWL8CP0tCMi13N/WDLG/9o/eG7D0LWV+iCY8f6kG60vB/Akm
	 AvTWvE2KD55b27aEsMqpPVHcNhYVhpLYx9HqQjDx8WpoXVBrDqOHHIsZZzkE7wFIdbhlHSDBwbvJ
	 iFqFGI7pQM2qaxCjqaPfxyzc5/N6Fr1yayr5fYLrB0mjiFDgjpVgzBxkW2cy2UPDsx0WpGBy8tSw
	 Qbllw49uzq+Ax9JNdAYHIN7GXQVce13oI/n8/wfkM3RDcL9sW17Q97c22/tSi0W+xfjF+avgfB1j
	 AcH5/D2TlJe5a6xdj9wmWjg5XXT5VZhOav8XX85HYYWFfPm+N45+gVkAWFx0C//a9nG3fNEoi0Jf
	 RBxafX5WKUmsBuSoFtuFRnuUZhxYCLtHCDsHO+9tMLaV2/WpanffIu4UFIP7YxwBvGPdmUveRZ2/
	 BkD9+4BJvt305foyDhH8vY86cyGpKosrApxWuGBA5qlzjg0xcmQvFASRqJf/MTcKd5iGp5m72O2r
	 /saWwaw+omkFixsimSmeoWgkofAxuYUQZKbtdXlna27p5oKc8WiMv6HUAC3TgxddqQSAJ+Dy6Hzb
	 sjLo8Dqw7I+uFQIJrq+qCr9MZRnH8Go8AcVicTZnHmogR283gy7wVeLAp/OqPQqcCcGbAlshNWPt
	 jdebriosr5dNDhJ7M6F/74EThL328f3HgnIZ5P71rMA/KfNC5EiJR9TisV4SJIZBbYM4WnSucAWT
	 RrzOEm/z4kGH4EiVX6xdHdzZuUtXk8KCQsmk5QhFfIG1reTvqL7u1PBxp1cT9pQrGPNuBBFO3dPK
	 RE76Az8P1e3fMlpfz+W8z42bMzP7vOYXmixlPDuYwj8pOJCmLI0sjGDuev+wPxvSVeMjHMxd3wgF
	 dUjVUEMna76Iu8cS4I1ES6A3dnIP7pGxSZYnF8SWAshUhb4y+LgLwOo5WSVeQS7kZDCa/wmMrBlv
	 p1pdDJHgEOcq4k8UFzWapTOSQg7hL6MFgZnBSJ+Q==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: memoriaru@foxmail.com
To: netdev@vger.kernel.org
Subject: Re: [PATCH net v4 0/3] net: dsa: mxl862xx: bound FDB dump walk and validate BRIDGE_ALLOC ids
Date: Sat, 31 Oct 2026 16:41:31 +0800
X-OQ-MSGID: <20261031084131.66503-1-memoriaru@foxmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <179343510012.3286.11131587555804022012@kernel.org>
References: <tencent_920A69A08AE91025A2F5D4ADC3E555862E07@qq.com> <tencent_6030CC520C02054D1B2925AEEF6FA92DC30A@qq.com> <tencent_BF2386050A18A0AF692525F075A8ADED6507@qq.com> <tencent_3DB6652906268A3AA099E978258675B1AD07@qq.com> <179343510012.3286.11131587555804022012@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Zhang Hewei <memoriaru@foxmail.com>

Hi,

Adding the requested information:

How discovered: manual code inspection. We were auditing the
mxl862xx driver's handling of device-controlled API responses
(firmware as a misbehaving party rather than an adversarial one):
the MAC table walk's only exit is the device-set "last" flag, the
returned bridge id is never checked against the values the API
documents as reserved, and the ALLOC-style API_READ call sites
conflate the firmware result value with an errno. Patch 2's
transport/payload split and patch 3 were refined after the sashiko
review of v3 flagged the positive-result path (an LLM review finding,
verified against the driver source).

Triggered: no, theoretical. We have no MxL862xx hardware in hand,
so none of the three issues was exercised on a real device. The FDB
dump loop, the bridge_id gaps, and the firmware-result conflation
were verified by code inspection against the GSW API documentation
(id 0 reserved, INVALID_HANDLE documented but undefined -- 0xffff in
the MaxLinear GSW API). No symptoms to report.

Best,
Zhang Hewei

