Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130E0331200
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 07:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791877734; cv=none; b=LtscDl1JPEIFkv1vYc2yo0IygpiGH9heUwjAeP+iklpo7HNq3J2txVf/1AvDHhn4SBUFJVTxc5HAijBJz/FXsD8KJBcvmBSf/Rpbpl6fzL79S2uMlOrHEGddBaL64FQbyIV+DXH1+jgVrYqVB77JlKj1sDAwhgZarebgB4vCn+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791877734; c=relaxed/simple;
	bh=xEkqoGMJ1M71vGumt/SaVUYSGY/3+WxtSEEgWA2GSmI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q1LMq7UcO2j5c7NjIP1cgRu3WY31l5IGKBdHBp48PNPFk109NXPi9CsYs/UcLv3Z+lRBrf6E1WFnInbCFeNAGjb7O2nO0jzs0cRu27qr/3aTCrF/gv0jOE+HrUGnAAJa+1XM68gErH28R6aN1vEQoPufZVGxmuRuFqZTkPQ0Z+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=zz/0A9+o; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="zz/0A9+o"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 415A94E4120A;
	Tue, 13 Oct 2026 07:48:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 132F160362;
	Tue, 13 Oct 2026 07:48:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AD44811D7012D;
	Tue, 13 Oct 2026 09:48:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791877727; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=J9Kb+jCZDseePdcQUKuFbPGPzmxEj/uofpen6TU2Bfo=;
	b=zz/0A9+ooNtaYDsE/E19+ovTaPyxHH8N5p0a+PkmLplMS0NO11kPhh7Qb2bRRS9cPtmIlb
	/KzAOLJO6SqoXRN81aSjDC2EKZ0+faYZzjj761TJjfTjisbQrcLki/LuETQ9gqrU8yzAdw
	XkizO5I68sAvYkIabp4WNzTT7L55WUy0HEwiS8grcIL5A/S3s6rJ1ke2CbDWHyzEuexHQM
	GjfxLo36yt9IX2xouXE9tD+OajTz31nv7ejgEZSuXr3Dgo9J4AbmVpMQwiKXPk4cQ9zg1h
	gzlgePej/bzGGfaEjsF5a4PXxNd0sBbPz1fAk7TLsEQHeFBK8W1xfXO2rNrUqw==
Message-ID: <670f3506-efe4-4d73-a71d-7140547f1cfe@bootlin.com>
Date: Tue, 13 Oct 2026 09:48:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: Don't allow disabling napi kthread mode while
 napi instances are disabled
To: Paolo Abeni <pabeni@redhat.com>, netdev-bot+sashiko@kernel.org
Cc: andrew+netdev@lunn.ch, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, linux@armlinux.org.uk,
 kuniyu@google.com, sdf.kernel@gmail.com, thomas.petazzoni@bootlin.com,
 alexis.lothore@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261006141119.85562-1-maxime.chevallier@bootlin.com>
 <179142548474.434549.4875313383372623036@kernel.org>
 <35a238ae-0e06-49a9-8539-9139aeca1a30@bootlin.com>
 <24dbe3af-8706-4369-8308-d3ad558fea71@redhat.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <24dbe3af-8706-4369-8308-d3ad558fea71@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Paolo,

On 10/12/26 18:31, Paolo Abeni wrote:
> On 10/8/26 12:19, Maxime Chevallier wrote:
>> On 10/8/26 04:11, netdev-bot+sashiko@kernel.org wrote:
>>> Would it be better to handle disabled NAPIs in the stop path itself,
>>> napi_stop_kthread() or napi_set_threaded(), rather than only guarding the
>>> explicit disable branch?
>>
>> Hmmm maybe yes
> My personal take is that the complexity of addressing the issue for good at
> the core level sounds like a good argument to fix this at the device level,
> one device at the time, as needed.

Fixing that in drivers isn't enough however. The visible problem of hanging while
disabling threaded mode if the interface is down would be addressed, but not the
corner cases such as "disabling threaded mode while changing the MTU" for example.

And this is a lot harder to test :(

> 
> Otherwise I'll probably got for the suggested path above.

My brain is becoming a bit more operational now that the conference flu I caught
last week is healing, I'll spin another round see if I can get that addressed.

Maxime


