Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975E9472521;
	Wed,  5 Aug 2026 13:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785936749; cv=none; b=MVzlfKokP350L/5lJiZmQ/bu5TuiwL4aHjJTujYW++HiUw9T8qx9Zy/Ksu2Xy8HkrlJz8db+w7MlRBQb0i2gnIXI4HiPrcEnnkIKQCPEWrORwBiiIdboBDYwpzUhPumr2MJGRqY3W9M/9xz+UNeFor5jDjoTTSAQzmzh1X/nLKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785936749; c=relaxed/simple;
	bh=R2apSWBXSUirB/UtMUlvuAshDxiPYml/uIQKMcnebR8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k72Z3zgY5gtVBLpRlQasK3TCCrFyNE4Z4nnE+/1+/yI0MrMpszSOi12wUsC1KavS93F8fyaFb2tha2lSC4HcFD0dNQVfdz6K1FqTHJ9rVub9kdPoXuAr1YsGxTD+DEMwRFIB7T7VgrRk1+SXOpsY6hjGVCXOCBaI1ZTZzJqSLpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aCmQdTKj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IChQUx3m; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aCmQdTKj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IChQUx3m"
Date: Wed, 5 Aug 2026 15:32:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1785936745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LSUjXyojxYUstOoU9FinVpdu7Ze0HGj9+KlBRZ5mhu0=;
	b=aCmQdTKjgZ5ZIdy/u1ZI3q75vIhLAgCQAv7pnzle55pQcJ9pznSfvwZVn9YBVO5wHOXPgc
	ltII/sfKTrtOBkZOR0nTbheo0oT3lYapRs7aXRhckMf23n86gbT4yBfNijwFST7k8zjy7P
	KIgXa1MBMqXDT0TzeKxQWqjCab/+sq0a/ofFRTqrphx10PbKeqxHum/nyqPxS/YqIqOqnp
	D66Va+dvRJxDQbVzIwro2mAumYT/dWB9Rn32w+Pw6A1HQPwJ1wjq24TszE8D/eBfmwmASw
	nh0+m4+ndkYGXNBliP9SCcTE0aE9dF8AvNQE7J7xD+rZD04FR6H7ymo+RSpxbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1785936745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LSUjXyojxYUstOoU9FinVpdu7Ze0HGj9+KlBRZ5mhu0=;
	b=IChQUx3mceLkOLFKFrXhguLxKwzQw/5yQTSO8fHoaoeM6abmERCOByyN38BuOwBdmUVJva
	ZhEs0oInuR1tkrAA==
From: Benedikt Spranger <b.spranger@linutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Vasilij Strassheim <v.strassheim@linutronix.de>, Krzysztof Kozlowski
 <krzk@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Russell King
 <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Martin Kaistra
 <martin.kaistra@linutronix.de>
Subject: Re: [PATCH 2/4] dt-bindings: net: dsa: Add SoC-e switch IP and DSA
 bindings
Message-ID: <20260805153220.3860b262@mitra>
In-Reply-To: <590a933f-85af-4eaa-b9ee-be689dc15c69@lunn.ch>
References: <20260729-devel-vstrassheim-soce-dsa-ml-v1-0-be569dae1b20@linutronix.de>
	<20260729-devel-vstrassheim-soce-dsa-ml-v1-2-be569dae1b20@linutronix.de>
	<20260730-loutish-labrador-of-joviality-6e6c79@quoll>
	<411ec84fd55e152e94ac1f4edba497eac3a5623d.camel@linutronix.de>
	<590a933f-85af-4eaa-b9ee-be689dc15c69@lunn.ch>
Organization: Linutronix GmbH
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Aug 2026 18:43:23 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> If it is not compatible, it needs a different compatible.
This is quite tricky here - namewise. 

> It gets interesting with something you synthesizer, something where
> there are a number of different synthesise options. How do you define
> compatible? You might want a very specific compatible, for your
> synthesise configuration, and a more generic compatible which might
> work for other synthesise configurations, but maybe not?

SOC-E sells quite a bunch of switch IPs (MES, MRS, NTS to name some).
As far as we know for now, these different IP cores can be determined
by reading specific registers, which seem to be on the same spot across
different IPs. You may wonder about "It seems". Since we have only a
limited access for information about different IPs, we have examined the
vendor linux DSA driver and the surrounding configuration software.

So for now the different features can be read out at specific registers
- an autoconfiguration of the DSA driver is therefor possible. Now to
the compatible string. The easiest way is to name it after the IP core
name: MES, MRS or NTS. But that's wishfull thinking:

You can use the MRS IP core an disable all management features. You
have an unmanaged switch with an MDIO interface. Terefore you can not
rely on the compatible string and have to verify the feature registers.
Also you have to switch device trees for different IP cores for no good.

The big plus for this solution is less struggle with the devicetree
police.

So in fact the compatible string should reflect a register layout
nessesary to determine the switch IP and configuration. There is no
such name in the documentation, as we can see so far.

As a suggestion from my side: soce,switch-reg-layout-v1

If this minimal set of registers changes in an incompatible way, the
version number can be increased.

Regards
    Bene
