Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877E83644DE
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 07:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790579320; cv=none; b=rmxL5qNa0geeNhdlf/DvX+pL54j/3LyJjYUcfySWtY1AMK6FANe/V1zn4PKAc7hOHl4IgyaUbzQwdkzctD6cvISekWerbnKOCB/dJYQeNoQNQojsxQVbkv1wNnwHeUMUbNnxL27eIsdyJYY2UT1NO896/VN21h28n8XL+khNOH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790579320; c=relaxed/simple;
	bh=0xDlVduU4hrgBdUxeYlZyqUTEfvXnn3AobBD9qGWMCA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N8K5nZLoe6DH27Y1Of65eWBgFrGvBygZN3zlTpicYLQLGLOZJeEc8ksgo527ZZ+uMWFlPFWrehpW5yyGLlQLUiZHSITYnsuTbIigA0dyMNh/SB4z81O+CJ5kCt8JIx/R+1SyqZuDFUvuymur7KtGXfulQgiThXGC64GvbpmPoDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JBxG0FWB; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JBxG0FWB"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 8F644C5CD4A;
	Mon, 28 Sep 2026 07:09:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 70197601BD;
	Mon, 28 Sep 2026 07:08:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 88D19102F1E71;
	Mon, 28 Sep 2026 09:08:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790579315; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=vrQRdPS/JvmvyyxNJDkzkMrivGAml0IYdINFKAT2zRo=;
	b=JBxG0FWBPGPOqjjeTJWY8LWaHlyTCmDMv0Pc26bn9+iRnDwwCBcXqYLHAE2J5/yacjiFyN
	KklGujyW0t8II/QtyJiZAMiNhjYcBVRohFx5HsmG97FLV8uAtWahg3o2DlcPIE9JIh183+
	StVrwHyCuevj0vJ4Vywg+5sisurNEEx88M9769kA+mXVaxJpn860pMR7rerzWtRkp/StL+
	aBmESiaEppEcB/5MeEsucBP6vvuj+pm9S37tXq6ojsu/5EGd1e7d35C7zB8FBwpXJ/QXQm
	DEX6XcqyF5RRD+qAiSnYgVjdTdmwWY83TPZrlNCz/1UFk9td3hhgfX9ctDi2Cw==
Message-ID: <189e048f-d04a-4440-bf65-166c747ed6cf@bootlin.com>
Date: Mon, 28 Sep 2026 09:08:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: keep the NAPI_DISABLE flag while napi is
 disabled
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Kuniyuki Iwashima <kuniyu@google.com>,
 Stanislav Fomichev <sdf.kernel@gmail.com>, thomas.petazzoni@bootlin.com,
 =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260926194714.648819-1-maxime.chevallier@bootlin.com>
 <20260927154142.656700c6@kernel.org>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260927154142.656700c6@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 9/28/26 00:41, Jakub Kicinski wrote:
> On Sat, 26 Sep 2026 21:47:13 +0200 Maxime Chevallier wrote:
>> This seems to be more general than stmmac though, there are lots of
>> drivers that create the napi instances in .probe(), so they still live
>> outside of .open()/.close(). It was verified by running the following on
>> an mvneta board :
> 
> Not sure this works, you assume ownership if DISABLE is set but we set
> it to start the shutdown, not once we stopped the poller.
> 
> We've been tempted to "fix" this multiple times. I'd prefer to fix
> drivers.

There's 2 classes of problems then

- drivers that create a napi instance but don't use it even when
admin up (stmmac, I think it used to be the case for i40e looking
at the history). Fixing the driver makes sense then

- drivers that add napi instances at .probe() time, in which
case setting threaded to 1 -> 0 when the interface is admin down
is always going to hang. There's quite a few of them :

git grep -p netif_napi_add | grep probe | wc -l
75

So at least 75 drivers call netif_napi_add from their probe
functions.

Maxime
