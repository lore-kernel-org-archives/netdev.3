Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4294F3876D7;
	Wed,  5 Aug 2026 14:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785940036; cv=none; b=HEHsbTVRTkltzFw+GkhGcH8q3GEc8cEPpQnEwdHc6yUkarifgJ/ohK9lP5nE2/68hDYGWK5D/Wxn/jIB3y89U+Dg2Rg0M9RKdYwEV5dy0QqLvejfw/hH8V3Ijgh519ZaFt0kN4neQfEv3L7nHFCYuzAAfWj9Z+KBnepFxBFFJlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785940036; c=relaxed/simple;
	bh=J29jxjXUMbEn4JnHzEAbOMz9nnbYBQhHrp+c55xBWAw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fo8hxi3HuUngviKNvonIT6Rngl77XAtifcs11rl4/oUSrAMQ8U6WPkgIG+j+QOE/6kbUY5nK/rM0SX6aBWjT4Qpid42wx2mbRepkPI2w7pJh548wRZILXjwU3H1N5tnBPQ5mZel3056g/JGJxT4JRETv8h4TrPVBYLCp3OzvGIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mZR1w+PB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zlYii1JP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mZR1w+PB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zlYii1JP"
Date: Wed, 5 Aug 2026 16:27:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1785940026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l5TZJvnFtqp9UjxqxUwWtdrCzh9IyhgMcA5uW7oAJSw=;
	b=mZR1w+PBO3ydU37TsUE3cpdHGErb/LDDqpX4uSv3lSAxmwXmMerl8fWn3EWdLt8p1Qjfmc
	T9ns0hlsqTVVyo1DnR0VizYRUCmQkh/sahsl06X5vckUFQdslD3dQ/HzFogGkFeL+m9tFH
	BNeeKD5S6cvTypnQSgbtDWN5CXL5v2vQEI7oc22/v+THpij6zmuDqJP2lVV6Yse20+NMfA
	3vTnSks438TdBwYh1lWEirlNanyENmKlMo/UQlNsXPdhuT58aimw10O92adT0CZZr9rRwP
	mR/baJuvLHpqrcGNfFMgVFbxo8Mkmwxivsdy7bbExNbt2nM4RNHSJhzSn48J3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1785940026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l5TZJvnFtqp9UjxqxUwWtdrCzh9IyhgMcA5uW7oAJSw=;
	b=zlYii1JPuPl97CzKIkPuS74DMv4YUd4rx9dr8FtwvGlg79gEK5THclrszrEn12JSIH0vac
	RWRvKl2CX+UoIpDg==
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
Message-ID: <20260805162705.1a3467ea@mitra>
In-Reply-To: <9f8ac30b-6579-4e48-abe3-823302a3da0e@lunn.ch>
References: <20260729-devel-vstrassheim-soce-dsa-ml-v1-0-be569dae1b20@linutronix.de>
	<20260729-devel-vstrassheim-soce-dsa-ml-v1-2-be569dae1b20@linutronix.de>
	<20260730-loutish-labrador-of-joviality-6e6c79@quoll>
	<411ec84fd55e152e94ac1f4edba497eac3a5623d.camel@linutronix.de>
	<590a933f-85af-4eaa-b9ee-be689dc15c69@lunn.ch>
	<20260805153220.3860b262@mitra>
	<9f8ac30b-6579-4e48-abe3-823302a3da0e@lunn.ch>
Organization: Linutronix GmbH
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Am Wed, 5 Aug 2026 15:53:59 +0200
schrieb Andrew Lunn <andrew@lunn.ch>:

> So i suspect you will need to support integration specific
> compatibles.

Me too. But for *now* things are, better seem to be, simple. The aim is
not to plug forseeable future development.

> One way to consider this. Look at your FPGA design. Delete the
> licensed core. What do you have left? Does it need software to drive
> it?
The minimal IP core is an unmanaged switch. No need for a DSA driver
here. The IP core profides a MDIO bus, therefor a MDIO driver would be
good. The version register in combination with some feature register
can be determined to get the needed information to configure the DSA
driver, or in the minimal case to return -ENODEV.

Thats, why I suggest to have a compatible string, which reflects the
register layout needed to determine the switch configuration:

1) Read the version register
2) Upon the version read the feature register
3) Be happy and configure the switch.

Regards
    Bene
