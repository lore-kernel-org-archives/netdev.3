Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78B44248AC
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 20:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785184199; cv=none; b=RWZu+itti+F0VTjGKkcFbNIR+RtflZLE0PpJKFwXMjKubJnSmPqQ45Pxt9Q/ZD3BZJ+7wRrWT9L3f5Ua25HllqnwpIdbdbO04msEJudPlyLhgWIVNztAPkkk0/ygLI9FDXz9U6LFdAbxowEpy8O2jhvu0kKzyDmjvOHxJ3tFpPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785184199; c=relaxed/simple;
	bh=1caNyXLRKWyM25hq/Qow0s3803t1noNaWzSlXu6KhI8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=aXxO+trimxkMHqBDakGZR25ZhJarXHnTo8X0JSfB4bes3HTo4O7+JRAd1k/tviwRPhPkuUApL+7N/3hiQuifQNEb5sEimeChgs9QwkDxmNFIxvyBsv0w5Cr9MpotbEKt1B4LJwO8D+d4CuccPTVQB2eJhACO9NKMV1oh6E6MP3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pqrs.dk; spf=pass smtp.mailfrom=pqrs.dk; dkim=pass (2048-bit key) header.d=pqrs.dk header.i=@pqrs.dk header.b=RnduKmPz; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pqrs.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pqrs.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pqrs.dk header.i=@pqrs.dk header.b="RnduKmPz"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqrs.dk; s=key1;
	t=1785184190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0C3nU+PEEBhW7iHgFaaC5EqBgPQV5VuXjxoKfA8jqGI=;
	b=RnduKmPzC5mIHowdya2CpfMh+Ip8giZ/nx9GiBlMpu9r0+8g50KK0wQ4KK8h4KOq64sJFE
	arGcDuO/SPFFJewRMqb8hNTZ/EgQ2LCL4ssWQxFVJ8ysxMHYMK8PS/FAJj3LD0V93yZmVw
	HuoWrxnjsu9+N9VA61utA04lRTi3JBG5ZsDV0wmrn3nOARkk0huzTmZ0qjtHyUJ8x3aREM
	5leZIKPj/sUkTnwIyx1sv+yLlm2Y5eGlovFNK7yQk9xy2npLFpdED4bHudR2CsKYwCZUxm
	ObBTGebDIDjK79lWPOJAjmkvB+wGeEwzVc9ZAv2W++YzJhK16GTHv5op/MIpsg==
From: =?utf-8?q?Alvin_=C5=A0ipraga?= <alvin@pqrs.dk>
Date: Mon, 27 Jul 2026 22:29:29 +0200
Subject: [PATCH net] MAINTAINERS: make Luiz a maintainer and myself
 reviewer for Realtek DSA
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260727-realtek-maintainers-v1-1-ab501adc0cdb@analog.com>
X-B4-Tracking: v=1; b=H4sIAKi/Z2oC/yWMywrCMBBFf6XM2kBMi6n+iriI06uOjygzqQil/
 96oi7s4F86ZyKACo10zkeItJs9cYb1qiC8pn+FkqEzBh42PITpFuhfc3CNJLnVQc9Fzv+VuaEP
 PVM2X4iSfX3VPGYUO/9PG4xVcvj2a5wVHW1/yfAAAAA==
X-Change-ID: 20260727-realtek-maintainers-70c89c4d328c
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>, 
 Linus Walleij <linusw@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alvin.sipraga@analog.com>
X-Migadu-Flow: FLOW_OUT

From: Alvin Šipraga <alvin.sipraga@analog.com>

I have changed jobs and therefore no longer have access to hardware
using Realtek Ethernet switches. Luiz has kindly agreed to take up the
role of maintainer, while I will stick around as a reviewer.

Also update .mailmap so that mails to my old company email stop
bouncing. Use my new work email for Analog Devices Inc. instead.

Signed-off-by: Alvin Šipraga <alvin.sipraga@analog.com>
---
---
 .mailmap    | 1 +
 MAINTAINERS | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index a0f64c31abcc..b66c317e8f06 100644
--- a/.mailmap
+++ b/.mailmap
@@ -72,6 +72,7 @@ Alice Mikityanska <alice.kernel@fastmail.im> <maximmi@nvidia.com>
 Alice Mikityanska <alice.kernel@fastmail.im> <maxim@isovalent.com>
 Alice Mikityanska <alice.kernel@fastmail.im> <alice@isovalent.com>
 Aloka Dixit <quic_alokad@quicinc.com> <alokad@codeaurora.org>
+Alvin Šipraga <alvin.sipraga@analog.com> <alsi@bang-olufsen.dk>
 Al Viro <viro@ftp.linux.org.uk>
 Al Viro <viro@zenIV.linux.org.uk>
 Amit Blay <quic_ablay@quicinc.com> <ablay@codeaurora.org>
diff --git a/MAINTAINERS b/MAINTAINERS
index 61126d170e4a..2385c27f14b9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22735,7 +22735,8 @@ F:	drivers/watchdog/realtek_otto_wdt.c
 
 REALTEK RTL83xx SMI DSA ROUTER CHIPS
 M:	Linus Walleij <linusw@kernel.org>
-M:	Alvin Šipraga <alsi@bang-olufsen.dk>
+M:	Luiz Angelo Daros de Luca <luizluca@gmail.com>
+R:	Alvin Šipraga <alvin.sipraga@analog.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/dsa/realtek.yaml
 F:	drivers/net/dsa/realtek/*



