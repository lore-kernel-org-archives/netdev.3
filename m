Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB362E36F8
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 11:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780398466; cv=none; b=eHJks7CMHuq9WZJbPSCs8OUaQFrSJbW258b36JoJmoKtexprnOWQ5NAhaPfeBYTAnGaUJVs32n811yuXrUZ/Nmu1+MbLVS+r7D7+7+JByjI3q/Ty8L1TXcg3MV6tfEQXPcLFKac6JyPx37JRkGg2Xcau6wmHATLHPPRpyBvSMpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780398466; c=relaxed/simple;
	bh=KVsE3Z1Q/B3SzqYoRtOOQ1nbbIwAyNRfV1Fy0rzMrKw=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=kzT9sT7vtEpvqwbmbFdSQHS4YNuBb/8quYWSDofi6ivjhkUZ4ZwVCILRFGD9nkAH8rrBUGXCfHG6cuP8HQ0qkiK3mfkX0o6iBNr9KLc/ZvUgryyhL9YiH6nPxj66AXoTCNhQOpOpTSPGqo/XYdfoUqrI4o+62anGAOnLDD3fXo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=FYXGsNSs; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="FYXGsNSs"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D44AEA08DA;
	Tue,  2 Jun 2026 13:07:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1780398461; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=3EdBEkt2RH+mQOypNt6uU3wuLfoEOt8ZwFsb/iYJQXI=;
	b=FYXGsNSsjnBiEK3u2107RF5456i5zfu1wknwCW4lmHJbh/JAmsulvdmRGE4i1NOz9rrpiA
	6B0s7BR0zXNOz7LJX55lCStgZs64cCXB5CfrO7/jAva36kKIMNCMaYW+fd8V0B5y1cT5ZD
	/BX+F/ajmxrhYxdjeXHG+FFCEi6koMu0LjeldP1do7T+7FEdBrJYPnE0yLLtooCiTiyrpe
	A7mHMBHwW0T/S1L/vqO5Np9164+prLpN+WRVogKkcKYT2eL00glhGYcT0xA7/9G1HSbIi2
	9QnNXBHxbT1zA/GEwbFBiFXub9uIXZxfIlxFQY/ZKjOWZpUfkMJ/OSQvunkL+A==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 02 Jun 2026 13:07:40 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, Jakub Kicinski
 <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 michael.chan@broadcom.com, joshwash@google.com, tariqt@nvidia.com,
 haiyangz@microsoft.com, linux@armlinux.org.uk, willemb@google.com,
 ernis@linux.microsoft.com, sdf.kernel@gmail.com, kory.maincent@bootlin.com,
 danieller@nvidia.com, idosch@nvidia.com
Subject: Re: [PATCH net-next 04/14] net: ethtool: relax ethnl_req_get_phydev()
 locking assertion
In-Reply-To: <70c0a3dc-a522-4141-b98c-2ebc231b20ae@bootlin.com>
References: <20260528231637.251822-1-kuba@kernel.org>
 <20260528231637.251822-5-kuba@kernel.org>
 <70c0a3dc-a522-4141-b98c-2ebc231b20ae@bootlin.com>
Message-ID: <1ae5082196f2114c76e734b16ef115c6@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Maxime & Jakub

On 29.5.2026 10:43, Maxime Chevallier wrote:
> Hi,
> 
> On 5/29/26 01:16, Jakub Kicinski wrote:
>> phydev <> netdev linking and lifecycle depends on rtnl_lock.
>> We want to switch to instance locks for most ethtool ops.
>> Let's add an assert that ops locked devices don't use phydev
>> today. If one does we can either opt the phy ops out of
>> being purely ops locked, or do deeper surgery to make phy
>> locking ops-compatible. I don't think there's any fundamental
>> challenge to make that work.
> 
> Yeah untangling phylink/SFP/phylib from rtnl will be needed soon
> indeed, quite the can of worms...
> 
> But for the topo part, this change should do the trick.
> 
> At some point we'll need to convert a more embeded-oriented MAC
> driver to being ops-locked, to get a good idea of the amount of
> work in front of us.
> 
> Most of the constraints come from the different lifetimes of
> phy_device, sfp-bus and net_device, RTNL is the easy way to
> guarantee that the netdev doesn't dissapear under our feet.
> 
> Andrew and Russell were careful to get people to annotate
> the RTNL dependencies with assertions, this should make it easier
> to tackle the conversion :)

If you're looking for a concrete candidate, macb seems like a
reasonable one. It IMHO has a broad user base with zynq and rp1,
uses phylink (with the phylink rtnl_lock dependency you flagged),
and gets pretty active review attention from Théo and others.

stmmac would be also a sane choice, but others know that code base
better than me :) Happy to look at it for macb once the
prerequisites land.

> [...]

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks Nicolai
