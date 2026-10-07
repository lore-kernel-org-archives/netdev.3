Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E054756B3
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 13:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791379062; cv=none; b=tbKh+S/E76CMk6LB+P+WROK4PUA20Q9Q4CtCU++WS30JNDpm0NJ5hUpromSNpe66/PmsLVYQ6VeS6+A38vvq+GJwDOt9fk56+E/Q4rwm9lIuvN57HBW6qA+jamK+A7PFqcoaQ0yBsjynO46DxvtK2yxYJI3h9wojJ1935avQ9Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791379062; c=relaxed/simple;
	bh=GBieW81vtvpmXqSVtcDYAZ5IaVeL8YPqrEmju8wJE9g=;
	h=Message-ID:Date:From:To:Subject; b=b9kUbnH9ItuWa3Uf0QP1SBRB3SqSZmosytffWJcaarxSsM/Ea+ZsRZhwuzO5YfZjWwQg1PrdmGhz2NvnsTIA52e30UhDfACEfeyvTpTLLxP80v0v5/uBJueZzx3ziAIuht3Tu67ivVx1iS522Bwy3sjeAyWrMF57MZVXQ+f/bxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hraRwd4J; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hraRwd4J"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-141395927feso2708851c88.0
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 06:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791379053; x=1791983853; darn=vger.kernel.org;
        h=subject:to:from:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GBieW81vtvpmXqSVtcDYAZ5IaVeL8YPqrEmju8wJE9g=;
        b=hraRwd4JUkS18ep1pdmG8lEBXSBj/CqlPDf7l3Y2sHHc7DmoxhSkcqriXUeJyNmXab
         jpy60xMCFTCVMgfT3B7dMVrKzMCPn9MHtXcUxBtlTGxZfY7gKL3kxFLmj1rYcvdS6Kc1
         ybeNF8IceE6kZGM1HwRls/kRjPKJgwo6ArTRkcOfmBSbwVkNZKdJvJm7MfAJb1oClKvt
         IBYDoVjLzZ+sPFThdeBK4k6d28zo+88M/hx+ACGtIZwt9FTvW6wcuVoVDJayHwVxOFXv
         g5MyHJvJAUJGYSfxekCjKO68DtAVi/i/Mt9S6KrYF52OfPvUxlloMjRoc0CWG9p9SfOS
         DGPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791379053; x=1791983853;
        h=subject:to:from:date:message-id:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=GBieW81vtvpmXqSVtcDYAZ5IaVeL8YPqrEmju8wJE9g=;
        b=P1/+t4vel/49sBG77JUdYfh8Tey//YqmkLRFYqn/ioqSrz939JVBiGg7ira17CdrWg
         SD6qDi9C5XgDr4k42+hyFbAil/fDRZfWHxj7iVARh53UqrhDes9LV6/n9O5qqgk2a8Pn
         55prbxIhyvpsmsukOHt+gy0ieaOjEi9JmQaDl+YGaBWLBdNLRi/fpjenrAQetqHNpACe
         NyXNit8lucq+UXHa6iO0m99GjlKfQkjTtA9lDUVfvstWqEOUrsucpm+3ATVkwbkjUctb
         YifboVZv2KgEsDr8PDi9XVoWhHA4DvP4FUmlTSDCj9abtghnfShPwSZslHrHuSxvaZKD
         6EHA==
X-Gm-Message-State: AFuF++lzqq8DfOLChqhAVV5nt1IPAL0eBgwUxTCVVN4g5KSjzrh9OACE
	oTACjlU+zU6PEdCtPmEpx42u+qBa/OHmeqgHsgCnPIJp/0PAqgfcil37HXr0HWxV
X-Gm-Gg: AYBFou2mjv71wk+ZnHUmHjriChgMkCk00LPEunulDon1Yi8PPP3udMZ3yqg4Yr5LFvd
	gxWMilZ+n2P+ZCztWI3YPE0zJAil+vqUeau1m/H6UKyrcQjkVsyFL7GdPgn0VOB4Qn1X/biC1RQ
	31i7Sm3zPVGqn7Y9/gr1rwDLs94cID7JoByBnNUjCRuQnXacVgAUHJnuc+eSnpUAnxUVJx1V6pU
	yrfiSI3ijENsID60geXsnzPA0bVlIgg/kyZNHL51D2n3RrsRdgSV1YMISPZWq94NCy7nAXS7Qfh
	eeZ+UH5Rsn5iW4UEreYtcjNCSGH0/nsE5qFSl4cgjDRiVxKJTBL5RKny2gv/9JB+0ago2uEaJJB
	kZQCLtNqqI17q9YNyzRGfILqinxMs46sKCjoDuVVpd61A8BJXCTo0k1pxN1M2bGoCqg9CUpVhpS
	PwDgq3grEw3MTLZKJzhk+jss6hXurbJQq4GIAL7Ooq5aB2N+SXVG5x3CleotYwSrSliAdhlYYIo
	4fnt7OLFvN7GCDq8xs=
X-Received: by 2002:a05:7022:c86:b0:14d:3c0c:79ea with SMTP id a92af1059eb24-162044c055bmr1960592c88.8.1791379052503;
        Wed, 07 Oct 2026 06:17:32 -0700 (PDT)
Received: from localhost ([43.157.147.134])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-1616980c3b7sm6556621c88.16.2026.10.07.06.17.31
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Oct 2026 06:17:32 -0700 (PDT)
Message-ID: <6ac6466c.a0fc269c.182c2d.fc12@mx.google.com>
Date: Wed, 07 Oct 2026 06:17:32 -0700 (PDT)
From: PayPal Service <j39920017@gmail.com>
X-Google-Original-From: PayPal Service
To: netdev@vger.kernel.org
Subject: Renewal Completed | $394.21 | Ref: I-JJMHDU8TBVPUXO
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Dear netdev,

Your PayPal Service subscription is scheduled for renewal, and a payment of 394.21 USD will be processed within the next 24 hours for another year of service.

Renewal Details:

Service: Bitcoin

Account: netdevHello netdev,

Thank you for your recent purchase with PayPal Service.
We’re confirming that your payment has been successfully received via PayPal.

Transaction Details
Date: 2026-10-07
Transaction ID: I-M73FEV6B5KH2RW4G4
Payment Method: Pay.Pal
Amount Charged: $394.21 USD
Item: Bitcoin
Quantity: 0.05 BTC
Total: $394.21 USD

A confirmation receipt has been sent to your registered email address: netdev@vger.kernel.org.

If you have any questions or need assistance, feel free to contact our support team at +1-845-682-9283.
You may also view your order or manage preferences by logging into your account.

Merchant: netdev
Shipping/Billing Address: 44 Amerson St Anniston Al 36201 United States

Thank you for choosing PayPal Service.

Best regards,
The PayPal Service Team
