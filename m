Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793154407;
	b=1bRznpN1rtNkKw467CvUX0BP3cUYgyH5lOUOoieNUHJazA9Wd+s1/0F5EL9oMbOjketI
	 etCaVd85qnxbyynNrkNc6Pr4XdEwA4lyGkIFZAlfTDNaa9lIi+yHuXxnqvAJnoor4r3bc
	 MmKfw5WsCVtND87D7YrxCocAio5rGksUDxrz/ECbXGhuoohxCxsxhpQxMUOWBWiFxNK9R
	 UpXte4v4nXgOhJTZWv2YigbEhKXxYKKo0FRABs0ubzOpRHx+LPRfs8aSqe506CSR1acOJ
	 NJ4593IMt5WxZTrQ2ssGXVVxTCo8VGhC8AG9uJ2/sX9czsedRkPUsF71wS0cVDuqCyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793154407;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=nPtXLhmYKu2MN1HqVNGXKzPAg4qEhpU7r/v/4I5Gcsw=;
	b=ili6r6DySaLHWzAIgh2k3r2lG2H375RtfU3vhyG3w/LNas3R0I7nqiZCeN/uyeGzkgDx
	 gPox0YOHl4ERQpoLgd/lPn78/jz7k6s+GG1cF6qoiyOiXa3Hqh8U3IXBprWfHBhKbJXBQ
	 RRz8vv+STAs2JZrBahlZfm3FeBI+7U0N5zQEqrTJXocAV8sypE9pFJ/CnlgXUYFa75uiu
	 SuKghskSrZEJT9iIZGGw79f/QxW0wA/R/vmZr+kNMUvydt/w7Pg0qaySx9OirmUwmvLZ6
	 yzAwYCz/a4qQB2v8GyqJuwx7+ioPv4YRH9czSUwHUXwzTuR6FOhMz2mlz07LKjBnarA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=VEDWLivC;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28753606A31E;
	Wed, 28 Oct 2026 02:26:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28753606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=VEDWLivC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=nPtXLhmYKu2MN1HqVNGXKzPAg4qEhpU7r/v/4I5Gcsw=; b=VEDWLivCoqhxBjJLnnm14TEPWp
	COR2QNe350SBN7ngS9ca47m5qquhREyv6mzRKL+WbB4zC67Pm96/qcSlpdnIfWZ4se8X7lrJLdAIp
	JLyOynqzySu/jv5BmF15h8rEn14Yxs2ASxRzT1T0t8F7demXZgLsXVhnrMbQbLpVCinM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xLtMz-00D2sQ-Fk; Wed, 28 Oct 2026 03:26:29 +0100
Date: Wed, 28 Oct 2026 03:26:29 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Caleb James DeLisle <cjd@cjdns.fr>
Cc: netdev@vger.kernel.org, olteanv@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	chester.a.unal@arinc9.com, daniel@makrotopia.org,
	linux@armlinux.org.uk, arinc.unal@arinc9.com,
	Landen.Chao@mediatek.com, dqfext@gmail.com, sean.wang@mediatek.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, naseefkm@gmail.com,
	b.larsson@gmx.com
Subject: Re: [PATCH v3 6/7] dt-bindings: net: dsa: mediatek,mt7530: add
 econet,en751221
Message-ID: <f9249c6d-ef72-4723-a3b5-8d5375e53744@lunn.ch>
References: <20261028011317.1557238-1-cjd@cjdns.fr>
 <20261028011317.1557238-7-cjd@cjdns.fr>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028011317.1557238-7-cjd@cjdns.fr>

On Wed, Oct 28, 2026 at 01:13:16AM +0000, Caleb James DeLisle wrote:
> The EcoNet EN751221 MIPS SoC integrates an MT7530 switch memory-mapped
> in the SoC register space. It is similar to the econet,en7528-switch
> except that ports 0..3 are 10/100 only, port 4 has a gigabit PHY, and
> port 5 has no PHY, but is in some implementations connected to a
> downstream MT7530 multi-chip module via a TRGMII link.
> 
> The downstream MT7530 is similar to the MT7621 multi-chip module and
> has all gigabit ports.
> 
> Add the econet,en751221-switch compatible with the same constraints as
> the other built-in switches and also add the econet,en751221-gswitch
> multi-chip-module switch whose port 6 is configured as a DSA link port.

Is there a use case of the econet,en751221-switch not in pass through
mode? This is where you could have a different dsa_switch_ops
structure, which probably makes the changes less invasive.

Even if there is a use case for not pass through, you can still look
for the property in probe, and decide which of two different
dsa_switch_ops to pass to dsa_register_switch.

	   Andrew
