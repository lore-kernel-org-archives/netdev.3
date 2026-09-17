Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983E94E9C24;
	Thu, 17 Sep 2026 20:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789677054; cv=none; b=Y1XSKoi8tBPbbcu/ZVtwxd2BM5WlbNjC6Aj4pbTpEcNT2Cm0Q3ikYYwkFPgHsIJ+cU010hKxn92av42HZQGVEfoL/pds9UqHsykKSPBR504yjcHTt4VVWx0zsiLETAWAhLbzWJo7Nd6FUqgGu8o9MXdwsPsbdrt1hT8Nf87T2M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789677054; c=relaxed/simple;
	bh=qelcaST8Tkos00jpvGeJ3BcBVENjhyvUIOgwPGd2rfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EXdJgvHYD1WuSowPE6Y5mydckrfc3MLgoo6HBsgGMKvkd6rRasxVzkt4K3EWhnZjr7uaJS2TbtJjZh0WMsN8Af3YFJc9rwRUzhFzb7U4gbjUehjXw+3lGM3hqDrGWfWxlm1X2vChyohylEF9JZ+XlMJRRnz0e0E34Gi83+TwCIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=J2R/sIpp; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="J2R/sIpp"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id AF61F1A093E;
	Thu, 17 Sep 2026 20:30:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 76C7D5FF03;
	Thu, 17 Sep 2026 20:30:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2C72011C7B078;
	Thu, 17 Sep 2026 22:30:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789677047; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=7y6mSAFwBW+yGS75IelSE+K+pLmoiMZHEY9lXNLdO58=;
	b=J2R/sIppRxvsfwzwlXqBtbmCj2+YopQCzgtdwbrcIe2w+iyJOJMJlw2Y1DofPriWrWOJmx
	ALmlZo1uPRy9PT1tRfmJNkdVKQ1o2TNSxEPRUdBFh1nDSbwGuDxf///6kjg7TD8oMqVu09
	nB5VNoIYoopvJ8SkOxEa5SY0qvd1NhgUKGtFSQFmepz/T6VgpivG1kF8dC1QWBQkEOdRjC
	459hTJ5bY2xBLyVjKQ7yCUtf5MgYTff4S8QHiHv0fj+euWXsTG6a5FtMz5+ZXS0PiF5LKs
	k9XYLw1NXostLonKG6Gz55F/YKw4jqIvES8aIcjWovmqbFwBGJNBBgSY+8by4w==
Message-ID: <65b2eff4-6818-4cfa-a0e7-d48729e0cd9e@bootlin.com>
Date: Thu, 17 Sep 2026 22:30:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: phy: reject attach while the PHY driver is in
 transition
To: Aleksei Sviridkin <f@lex.la>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260914204200.2743251-1-f@lex.la>
 <6e82dc04-a68d-4c54-a6f0-a13c04fa2eef@bootlin.com>
 <20260917183345.37604-1-f@lex.la>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260917183345.37604-1-f@lex.la>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 9/17/26 20:33, Aleksei Sviridkin wrote:
> Fine, v2 will target net-next.
> 
> Out of curiosity, since I will run into this again: is the line
> "needs instrumentation to reproduce -> net-next" about the window
> being unreachable in practice, or about nobody having reported it?

Well there are lots of patches recently that fix bugs that are never
seen, and only show-up if some oddball error path is taken, under
conditions almost impossible to encounter in real life or even
reproduce without instrumenting the code to force these conditions.

> The crash itself came from a real board; the msleep() only made the
> race deterministic instead of occasional.

This is something you should say in the commit log then, it's important
to know this was seen in real life. If that's the case, then yes it's
'net' material instead of 'net-next'.

Maxime
