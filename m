Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B54823EAA6;
	Thu,  1 Oct 2026 06:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790837483; cv=none; b=pGo7EzD3aqgx6TI1Nil2T8XiBpOBXRUU2iS5J9SNzMnJdJwkjlGZ6gLGljEWfDugPM9tuVHRZO2HBB+GLj0G4yIHXlweb9BoVF0b3joPBSckDflmaJfd4Zh0w1X4gvag8xi5CkFB2ZGFgdZkUh5pOgAbOAJfSMCa8JMZDqAEEP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790837483; c=relaxed/simple;
	bh=9y0LJ6Gb3mkDcBQ6rHidl0242MuXefQbLJzCSz5Y4/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iKmcEHXnxLZPb4jnHagfCprJRpTy3Gq+ci5gQhPzo3pUklo82DR84TIxxwM08UyCR1Xa9H/cN4NRqR/4vKXuL24VaNx4lBJoYWLU8ysfC68PqUMgomt46QhWoHi1AYVj7zJYt3pPaWbA4xZqIETziBJt852eCb6WzFFRePe6Yjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=1lh4buLj; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="1lh4buLj"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E2D0D1A1099;
	Thu,  1 Oct 2026 06:51:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AA55D60341;
	Thu,  1 Oct 2026 06:51:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 31E5F10328334;
	Thu,  1 Oct 2026 08:51:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790837478; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=XdSazJlkUOjn1tB6G2mz0rNLggZYEJjIMTZxBezObaQ=;
	b=1lh4buLjXbitsWh83sgdjBQ9sTEEvvTWlM+ocRMWSlab/oBckNLk2Bk9O9KKoGG03SWJfw
	Sh+43E7zA6Jj9QLd015C0RVbLVLKdqAUeBzAIDC2i6/lx0zMhLD2wXril9Eo7h+hwqZSgK
	SYUmRa2vf36WBCDh+miu+sIbVFNVA4sJQt9upuCJEftbbPD7j0n0yK7BBS1v6pWjzpmuUO
	0/mQ+lmYfig1HcfVSh3bmkAFr92GA4ze1fUseRqwn/hU7bnnWTyFDQQFeK2cEbZjfan4lJ
	AtCyMi0QBRCJfWdsIqNYqzE/aja8r9nPJpu0p5x+9LlofT6+ROlhXf6Tr+kd3g==
Message-ID: <04e248e4-073a-4a98-bb46-d747169cde8f@bootlin.com>
Date: Thu, 1 Oct 2026 08:51:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v18 09/10] net: ethtool: Introduce ethtool
 command to list ports
To: Jakub Kicinski <kuba@kernel.org>, netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, andrew@lunn.ch, edumazet@google.com,
 pabeni@redhat.com, linux@armlinux.org.uk, hkallweit1@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, christophe.leroy@csgroup.eu,
 herve.codina@bootlin.com, f.fainelli@gmail.com, vladimir.oltean@nxp.com,
 kory.maincent@bootlin.com, kabel@kernel.org, o.rempel@pengutronix.de,
 nicveronese@gmail.com, horms@kernel.org, mwojtas@chromium.org,
 romain.gantois@bootlin.com, daniel@makrotopia.org,
 dimitri.fedrau@liebherr.com, frank.wunderlich@linux.dev, p.ameruoso@live.it,
 f@lex.la
References: <20260927133619.955236-10-maxime.chevallier@bootlin.com>
 <179064232552.3145.9027939570900472817@kernel.org>
 <20260930154019.63726960@kernel.org>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260930154019.63726960@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Jakub,

On 10/1/26 00:40, Jakub Kicinski wrote:
> On Tue, 29 Sep 2026 00:38:45 +0000 netdev-bot+sashiko@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 4 potential
>> issue(s) to consider.
>>
>> Critical: 0 · High: 0 · Medium: 3 · Low: 1
>>
>> If you believe none of the issues are legitimate, please reply to each
>> issue of Medium severity or higher and explain why the AI is wrong.
>> If any of them are legitimate and you plan to respin, please let patchwork
>> know by including "pw-bot: cr" as a separate line at the end of your reply
>> (one such reply per series is enough).
>>
>> - [Medium] ETHTOOL_A_PORT_SUPPORTED_INTERFACES is sent as an ethtool
>>   bitset.
> 
> sounds legit, why not expose it?
> 
>> - [Medium] In the unfiltered PORT_GET dump, ctx->pos_portid is carried
>>   from one dumpit() call to the next without recording which device it…
> 
> Also right, we fixed it in other places. Off the top of my head fix
> like this:
> 
> 	int start_ifindex = ctx->pos_ifindex;
> 
> 	...
> 
> 	for..dump(&ctx->pos_ifindex) {
> 		...
> 		if (start_ifindex != ctx->pos_ifindex)
> 			ctx->the_other_pos = 0;
> 		...
> 	}
> 
>> - [Medium] port_dump_one_dev() reads dev->link_topo twice (the NULL
>>   check, then &dev->link_topo->ports) and walks the ports xarray with no…
> 
> didn't look into this one but sounds legit-ish
> 
>> - [Low] The ETHTOOL_MSG_PORT_GET genl_ops entry in net/ethtool/netlink.c
>>   uses ethnl_port_get_policy for both doit and dumpit.
> 
> That's right, please fix, IDK why AI thinks its low.
> You can reject it in the code (start callback)
> or have a separate policy.

Ok I'll fix the above :)

Thanks for looking at this,

Maxime
