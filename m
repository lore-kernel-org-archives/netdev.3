Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E674F4735;
	Tue,  8 Sep 2026 09:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788858900; cv=none; b=krxTuxmlOVYKwYeL70bnviSN8PEJqkY9kJWd9WnlWTcuBwg9sSeFmrS1FiFsNlLhq1UBbI/9zNBxkn2j21Knw8YHHpG40O6rFPKNt5khQNGcm5vnDZEcPP/JcGnQ3GYrDNF5mCJWoza/NA6M8oLxaZA5vPxhCkmQ7qR0gURoEmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788858900; c=relaxed/simple;
	bh=9KBBol5b8wDOKMLuX/X6+UvraLLUK6NlDmjF1r5yQhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N/8fVP3OhVierDvq6iyQ01seU0V1nolrpM0Hmq9OuoPIelTDHEq/EcdnxkFlmJquTrsbdMTnwlqmhLmTvEBW2uR7K7LaczkeO+fPXzrRogpmIOST2UZhE4QelQ63IgyfzRisV+GL+QngfVMLqk7Kp1CR+MvZ9HHXBiuV64JK09A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cLL+2wJU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cLL+2wJU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 647911F00A3A;
	Tue,  8 Sep 2026 09:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788858899;
	bh=qr/xd13Ka2hSZsY6poiNywH4/8XWWAtoxAsgencf/4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cLL+2wJUUSEGYl3GSaTXVVKuBFXbX4QbrkhX2q3FHJ9BRE8XvGvH49h8S16zJtO/a
	 hskMemYv+2eUrZcOk+zd++J1jHa3bC+EI/1gE8yoqNaVb5f642TTqZFSOck/7zSzzM
	 K2G6SIYQVqAoaQvKRBUU6sPIhAv1+Anu7hxGxvjG0cHNiNgsjXDgwF3pHBGMjnVOgl
	 FWqDhPZhiihd5m2g6Tua2BLPIvXQojFi8/vLUE+dAanNae9AzTNPsk/gALg0Lq7b4U
	 Jf7ldfkUIa065i711MG0IIRNBG7TXuenmM8dlU0724tOpECj0N3cWPMYS7jHm/Q1bC
	 9QdYQvKHyqU3Q==
Date: Tue, 8 Sep 2026 11:14:55 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vasilij Strassheim <v.strassheim@linutronix.de>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, Martin Kaistra <martin.kaistra@linutronix.de>, 
	Benedikt Spranger <b.spranger@linutronix.de>
Subject: Re: [PATCH net-next v2 2/4] dt-bindings: net: dsa: Add SoC-e SWIP
 switch
Message-ID: <20260908-psychedelic-jolly-kestrel-a743af@quoll>
References: <20260903-devel-vstrassheim-soce-dsa-ml-v2-0-fb0587cb466b@linutronix.de>
 <20260903-devel-vstrassheim-soce-dsa-ml-v2-2-fb0587cb466b@linutronix.de>
 <20260907-petite-pillbug-from-atlantis-dd3ea4@quoll>
 <9751fadc03ab555327f5baf1d2adc10821f13b1e.camel@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9751fadc03ab555327f5baf1d2adc10821f13b1e.camel@linutronix.de>

On Mon, Sep 07, 2026 at 04:01:26PM +0200, Vasilij Strassheim wrote:
> > > +patternProperties:
> > > +  '^(ethernet-)?ports$':
> > 
> > ethernet-ports
> > 
> > > +    patternProperties:
> > > +      '^(ethernet-)?port@[0-9a-f]+$':
> > 
> > ethernet-port
> > 
> 
> Is there a reason for such a restriction?
> The pattern intentionally follows the generic DSA binding in dsa.yaml,

dsa.yaml lists ethernet-ports and port.

> which permits both ports/port@N and ethernet-ports/ethernet-port@N. The
> device-specific pattern is needed here to apply the SoC-e port
> constraints to both accepted node naming variants.

ports is legacy (because it conflicts with graph ports), for existing
users, so why insisting on this pattern? If legacy is being added to new
schemas, when are we going to be able to remove that legacy? Never.

Best regards,
Krzysztof

