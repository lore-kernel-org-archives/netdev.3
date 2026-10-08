Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C7938886A;
	Thu,  8 Oct 2026 08:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791446530; cv=none; b=S4Nporg8+0dKWEuCmU/Bg4LmWfocCiuPe5lEsUtcVHo79WGFPPK9f7pSXAPUHr5TotLN1ReHqS+80yqQFlMQq9HTq96GzuJCOjxK280fH4n+Ps1L4G5oJsD6uV5RnjOOjF20IWtkPkVb8ueNieWjHLHfrT10gg+JNQnUnvz3+bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791446530; c=relaxed/simple;
	bh=uaMDXbdt23ihBGmhZhBRjzcQK+yRXU2ygdB5cz/uiAQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=OZG3rXjaiLLa4KkcfOKmNXXJOFtM+7HrRex6DNAPrySut3qbffRuW1YbNICsGJZCrI5BBPkUuVv6supz2GFB9HTogJaAsEHNylu7h8YRe3/BEa33GitYH6/QgqfvhHSeydGl9/OYqoK3+78UEKOBI4u1SeDeWQPxd022QxsRzWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=Pl8UCaTT; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="Pl8UCaTT"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 93F14A1551;
	Thu,  8 Oct 2026 10:02:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1791446522; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=l4f2RYpZ9JHI9Lr44tu461ZrdYW0nDBrI6l/DQCt3zg=;
	b=Pl8UCaTTRJ54wdnAycGFkzj0mTInp4Tu9ugo0N01FUkooh4Q8sOneObCFMSIr+NlQ4AbgG
	k6h6Sn4aHrtKqHhZSzBbmDA3LIp+PP/yzOxFKfiTruDJuNJU8G9LZZe7eYsHtvCPXZPux+
	KU6zrXsH0hprArSH66p50/Bd66/NhxYFK3stqofVjjuOw2LdzS836A+54HRhGW79a4twHf
	Ltw/JuqA5/HwLP8whJe/ZAG5WdjgAReIMwZ2fF0y0kLJ0UFI2lMJPh7zioGrr2gd9aMy9i
	9IzkZ/W2VvzVJncL8MHONoHJ0bFvU2oYfTr7YrZkai80HwRd8tH7wVocvvAKcA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 08 Oct 2026 10:02:00 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev-bot+sinfo@kernel.org
Cc: Doug Berger <opendmb@gmail.com>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dave Stevenson <dave.stevenson@raspberrypi.com>, Justin Chen
 <justin.chen@broadcom.com>, Pierre-Marin Leclercq
 <pierremarinleclercq88@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH net-next v3 0/8] net: bcmgenet: support larger MTUs
In-Reply-To: <179136337262.2527009.9220130121409362777@kernel.org>
References: <20261007-nb-genet-mtu-nn-v2-v3-0-74a796c019ce@tipi-net.de>
 <179136337262.2527009.9220130121409362777@kernel.org>
Message-ID: <b669c9650a91eaded8304fb0a0d5057e@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 7.10.2026 10:56, netdev-bot+sinfo@kernel.org wrote:
> Hi!
> 
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
> 
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.

No, it's not. The one commit carrying a fixes tag shouldn't be reachable 
without the mtu series, but is kinda required for it. I added the tag 
for the sake of completeness though.

> 
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
> 
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

(response was only sent to the bot but Suie is not happy with that, so I 
resend it to everyone)
