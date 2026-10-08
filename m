Received: from cvsmtppost13.nm.naver.com (cvsmtppost13.nm.naver.com [114.111.35.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A70D3E4117
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 08:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.111.35.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791448770; cv=none; b=NSIi/F+C+zf9TmEYL4SrsrnM3KrabYaDdIpeYEH1yFdjYGrmBBIXP1uhK5zcoQ9KEfiEd5TjOa0D9kz9QoW3aFaN767zPgwVJluYtpRU8aso5W6uLNjjcu9miPm/5YrfGSKs4yJmCc7AfL4TM55w5xh8AwoebHChr6nH1dhg/Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791448770; c=relaxed/simple;
	bh=qkvvguZaff1UunGEWREo0VaUMF5voItHE33YJFUyQzA=;
	h=MIME-Version:Message-ID:Date:From:In-Reply-To:References:To:Cc:
	 Subject:Content-Type; b=dj4gt3nVLCf/Ox1s5QUBpEDpBpezaFAhEqd2Cyd5/+z4WvaoLoBaiE5LSV80sSvqTsBWJJ+ZhYVA2rBSzE2adH4ALwdTS+y7uZwrN0uzsM+1zeYog5IMnH3c09D9eUZu/pRqMTsuOO06f6wmJRultfNSo+G8Bk8wQYxstEx3ZXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com; spf=pass smtp.mailfrom=naver.com; dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b=xJEHv8yz; arc=none smtp.client-ip=114.111.35.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=naver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b="xJEHv8yz"
X-Works-Smtp-Source: X9YwFAulFqJCpNmwFoKrWHF0
Received: from nv1m-hmac-real-18 ([10.174.201.121])
  by cvsmtppost13.nm.naver.com with ESMTP id ThBFrLJVSWmKHv8UxOcwIw
  for <multiple recipients>;
  Thu, 08 Oct 2026 08:39:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=naver.com; s=s20171208;
	t=1791448760; bh=qkvvguZaff1UunGEWREo0VaUMF5voItHE33YJFUyQzA=;
	h=Message-ID:Date:From:To:Subject:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=xJEHv8yzl5KGjUoNMP4m00V1cVflBU/hYZcPgzX+hhaATevzEb5q1jMLcKXOdXF2q
	 aPiHyKoTrYMI5zVNYVup96yVRA57Y/ZFGDbdGB5aQCQWpJc2KOCZvw0hv78XIShkhM
	 nM1vzx4Eq6riNhiTMZIvWzsnFm9IRMCKR5eDBh33bHEjsrPoahtmvQT82fT+RFD+6m
	 p9S1JoSzRCsVcYXfIKRYjvHtBsgOIu5ZKmql5fSiQ1Fa4LtDjWIC/xLheEwlpU67/3
	 HhvGp3oVY05/l0/TTeAzlTiu09G3RY+rKXGCZatFCdsx50v7JXZsQ7iGqrBCLQHTk+
	 bUTrOz2EwHmIw==
X-Session-ID: b7432bd91b14b3c9c4039f452bee83ad8de4871cae8f5268da4c18ff4565dde3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <71b4df326a3a2df681a58ac37f5bb49f@cweb016.nm>
Date: Thu, 08 Oct 2026 17:39:20 +0900
From: =?utf-8?B?7ISx67OR7LCs?= <tjdqudcks0424@naver.com>
In-Reply-To: <179144821519.2527009.9630064777060740854@kernel.org>
References: <20261008082550.349487-1-tjdqudcks0424@naver.com>
	<179144821519.2527009.9630064777060740854@kernel.org>
Importance: normal
To: <netdev-bot+sinfo@kernel.org>
Cc: =?utf-8?B?U2FicmluYSBEdWJyb2Nh?= <sd@queasysnail.net>,
	<netdev@vger.kernel.org>
Subject: =?utf-8?B?UmU6IFtQQVRDSCBuZXRdIG1hY3NlYzogcmVqZWN0IHJlcGxheXMgYWZ0ZXIgbm9uLVhQTg==?=
	=?utf-8?B?IHJlY2VpdmUgUE4gZXhoYXVzdGlvbg==?=
X-Works-Send-Opt: OlewpzGdjHmdKHFOMr39Ko3YKHmqjAudFqM9KqMqFxIYkEljxBmwjAg=
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64

SGksCgpUaGlzIGlzc3VlIHdhcyBpZGVudGlmaWVkIGR1cmluZyBtYW51YWwgc3RhdGljIHNvdXJj
ZSByZXZpZXcgb2YgdGhlCm5vbi1YUE4gcmVjZWl2ZSBQTiBleGhhdXN0aW9uIGFuZCByZXBsYXkt
Y2hlY2tpbmcgcGF0aHMsIHdpdGggYXNzaXN0YW5jZQpmcm9tIE9wZW5BSSBDb2RleC4KCkkgc3Vi
c2VxdWVudGx5IHJlcHJvZHVjZWQgYW5kIHZhbGlkYXRlZCBpdCB1c2luZyBhIGxvY2FsIHZldGgg
cGFpciBhbmQKdGhlIHByb2R1Y3Rpb24gc29mdHdhcmUgTUFDc2VjIHJlY2VpdmUgcGF0aC4gVGhl
IGlkZW50aWNhbCBhdXRoZW50aWNhdGVkClBOIFUzMl9NQVggZnJhbWUgd2FzIGRlbGl2ZXJlZCB0
d2ljZSBpbiBhbGwgdGhyZWUgYmFzZWxpbmUgcnVucy4gV2l0aCB0aGUKcGF0Y2ggYXBwbGllZCwg
dGhlIHJlcGxheSB3YXMgcmVqZWN0ZWQgaW4gYWxsIHRocmVlIHJ1bnMsIHdoaWxlIHRoZQpQTiBt
YXgtMSwgZnJlc2ggdGVybWluYWwtZnJhbWUsIGFuZCBiYWQtSUNWIGNvbnRyb2xzIHJldGFpbmVk
IHRoZWlyCmV4cGVjdGVkIGJlaGF2aW9yLgoKVGhhbmtzLApTdW5nIEJ5ZW9uZ2NoYW4K
