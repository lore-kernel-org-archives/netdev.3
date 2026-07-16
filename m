Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04D03F8717;
	Thu, 16 Jul 2026 09:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784195368; cv=none; b=uFIKqVpf7CrX2p6vHD+1kP9JfQ+ylwU9rhsH3/GhfbeUS88hFTy26iQxE1JtB3+jBfoWpcBqy8u3ucgpc2OcPKdqjwnsPMY68cQ1lWWQFZg70PfyE5TNAq2caRaYQ3ESEP2WXh+L99MLL3tj5lDhePX0V6jwJxbyEGGPl8yFWgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784195368; c=relaxed/simple;
	bh=Q1V5Vj1Oogubs1b8NG9a8SvG7xcIQg7Y+7yACB2ctUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EgoDuS/JhUdDI1ja7qpF6sg0SCRoC75F0qYwN0ZM0mzpZFgw61/DYHH7km5rdkxk9KUTNkKrwdwznxsa2gxhBg3VO/VUIixLMM8nDILN1WbzzreuzGaGE0jjwn3/48zunFQwD2Dio1QapKh6q7BQvE1cD3grO23YUx8tFXjOVtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=b1tWKVm6; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="b1tWKVm6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1784195337; x=1784800137; i=markus.elfring@web.de;
	bh=kMsSJHLWZos0cYf46zDcVMKzc5ytQtmQIa3duNy3+ps=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=b1tWKVm6Fn+PshrC1etze3TfMxX/ZRC5aS3g+qLehXmc158Yx8FOvHw59C9nzGyS
	 z1yXDDMLwOi2YaAvAmx1fZ7pzXemZ/2CZA9A3RF4hG4Mg7tSmL4yUOxtVexUeQbe3
	 FzEb11gcohQA7PQAUywaBcQRxQnj59k5f34FdO3uNThonvHQhwSRS841ZixaYN+XR
	 1o+XGHSFcGH2c5GfvusuZ8DaxOSy/w4hjZtTKWAVE56hmEn9xcZjm5j/UFRra907o
	 zz+7BUBRkFkCadT1+3fnhy/PhwGRz/meg8dZWpS3qRt1dRaryUK0wK/c38cIUvDLC
	 ouLlh30Jd5vlukL5Sw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MbCI8-1xH9YP1uqO-00oRco; Thu, 16
 Jul 2026 11:48:57 +0200
Message-ID: <95abcefe-2211-4abb-9af2-7e8d7f4a9b76@web.de>
Date: Thu, 16 Jul 2026 11:48:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: net: rnpgbe: Pass an expression directly in rnpgbe_rm_adapter()
To: Dan Carpenter <error27@gmail.com>, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, MD Danish Anwar <danishanwar@ti.com>,
 Michael Grzeschik <mgr@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, Yibo Dong <dong100@mucse.com>,
 LKML <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>
References: <7958e26e-a4f9-48ee-8d79-3797016944c5@web.de>
 <alScHkiC3EmGzOlI@stanley.mountain>
 <8110bb3f-70d9-4f0f-82f2-ffe1262b2962@web.de> <aleFN4Z2XT3NP3od@monoceros>
 <85ad473e-b2f5-4458-8973-a643f90eda5e@web.de>
 <alikx3W3NX7r9o99@stanley.mountain>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alikx3W3NX7r9o99@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:qHSjYmu16+XmUqBiRYtqAw55luzkWuHAOXlbqz2hP6Hvsb1YGQT
 As1NC6tbIdX9AdjGbK9/jJegGCka2IIu1JJWVLof3XFezCYn9DyyYHZ51aer+09wHgv5YPo
 Ql4+Jo7xnAeFn+qrxchqs1PKdhttq/tn3El81Qt4u0tsio+7L17xKwriWT5hCaL/Sp/V+hR
 JhcUROcDrZTo2oeap+BMw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zYcDXn3wd4Y=;pFwdN+RxHHMxJHLrHHwcXU5+VO6
 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

> In C writing if (!p) and if (p == NULL) are always equivalent but weirdly
> the NULL doesn't have to zero.  It's part of the C FAQ.
> https://c-faq.com/null/machexamp.html It's just a bit of fun trivia that
> doesn't really matter unless you have a time machine.  Even if you invented
> a time machine, the code here would still be fine because we have a NULL
> test before dereferencing the results of our pointer math.
Which expression evaluations would you interpret as pointer dereferences finally?
https://c-faq.com/sx1/

Regards,
Markus
