Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F8749EC53;
	Thu, 24 Sep 2026 15:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790264037; cv=none; b=cPn5vEoQX9VeO1M2DUq2w0NYXunPPbffIhsHKnFU0moKJRZRNmO3zTDfmbUssiBJkHOWTaNRzP5jK3fQJXfbCpHEFYvkAApXYkgKkN5l49QjZy0eLt+yEZX2QLgcyJO4Ans8RP+RaEFg/Vo9HeLgNKjnpIkE3cjS5WrGeXygO0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790264037; c=relaxed/simple;
	bh=Aarko+3CQIaswT5E/GL4c0rHkWp+5MRf2/LxY93nxiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gjddR/ZJjvduzzTyZqLK7/7NQzSGArid4COoyuK4BDpEHjtqq68uSXHQSZtmtBqmTfwQDHumj7nSpVQbfFp1dtCiLchDnUrfxap32vapEsWQ9+37cVvZrrSPNi3OXpy4zJQKBaYk0KsAGvmMS67xsEV3pDXMds9vrDjxDSg10c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UCx1bn3V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UCx1bn3V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93FE71F000FF;
	Thu, 24 Sep 2026 15:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790264035;
	bh=0y3bhQ+E5gqrg/HPQpK6Xwg1YQ6uGBxrc+WKYjyPp74=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UCx1bn3VFUyyQieRuHSGXQms4dxjx7wLhVh2n8k7kaS4Nk8CNw0fsTvjolhfDr4pP
	 GMYg+hjnNfd4ViQPFk20H3NKNq9Bdy/Fo+m4bSRbiexSCBboseCfkK3ho3qN2IUHKq
	 AsIvQujQpXWknitxQORoSnsscBIXsej/2nlYFZxMOXLw15PiOWGT8evUHSPhyse3eA
	 iZkmqMf95Ox1WMbxXnVwSx+NUdnYx4oDZgjtYNXZPGTtaXJ9L7+dYjAekgPOT92rAe
	 ekPqcWng4nEAnnhHpxwLjASo8OOowR1ETtRfE8sVJH7tM+JmbCvFZqH52WhCmXJumS
	 p8MQJ+J6k8UcA==
Date: Thu, 24 Sep 2026 08:33:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
Cc: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net-next v3 0/4] net: microchip_t1s: fix collision
 detection on PLCA status change
Message-ID: <20260924083355.5e839290@kernel.org>
In-Reply-To: <20260918143302.76909-1-parthiban.veerasooran@microchip.com>
References: <20260918143302.76909-1-parthiban.veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Sep 2026 20:02:58 +0530 Parthiban Veerasooran wrote:
> In a 10BASE-T1S multidrop network, the PHY autonomously transitions
> between PLCA mode and CSMA/CD mode based on BEACON availability. The
> existing collision detection logic only adjusted on explicit ethtool
> PLCA changes, leaving it in the wrong state across these autonomous
> transitions.

I'm going to assume at least one of the High or Medium severity
findings is correct, please respond to the AI feedback in timely
fashion, even if it's just to agree / tell us that v4 is coming.
-- 
pw-bot: cr
