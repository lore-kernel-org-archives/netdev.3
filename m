Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632D552BE29;
	Thu,  1 Oct 2026 15:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790868799; cv=none; b=YdGW2PBZ/Myg4olwEzK61BmczbzR6XvpF0i/694PKEwN5ecWC5YgyDBmamaOQ9ItL1kpRrJ0A/F+zZCjEhb9WLTHn2GuOwwomh32vi43uitrpN93fs/yMYAcFZfl111dQDRionVoPSzTjL5tUAOZXrUmbP/Z6s5kybH82xo75pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790868799; c=relaxed/simple;
	bh=7Co/PBM/QewhkyF95LSYXheo/HH1O8wv967j0uQZ+ow=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qwlhoUmXaoeyGnqXKFt+VoOj+nG4PjqJqW4Ou+mM89NeomkkCd6KmEF72MC2Gt/0olEgNV4IpMOzsBT/Y3vOkwQpOZnpGXSNX9bdcTkry+bRcAAW6/X+aUl3LDGwoUm6iO0GoXRfjdShIA6kk2Atw3IR/1LAiLVeElQ8YAjjBWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U5n2S8RJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U5n2S8RJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAFB31F000FF;
	Thu,  1 Oct 2026 15:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790868798;
	bh=XzcSQutqoku+SocI7sZVUG5ang1FCLfZ6hHDRWBAfBA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=U5n2S8RJuUXRDmTV7eWcybRD3jwznhjvmjhSyT4SD5iz+1WDoneHnQXp5dWgkvhgq
	 DTNpNi1AvFIgO51/CSNy1pHyFXE1q1Fcbo6Ib7qw8ZunAHr5TnPm5bLY6ghobPTW6s
	 eaSY5juUvqEp5VUPmNKLwlaPfxwjHNHtZfgB8/Dnus4rFcyzt5xl8EeNHcNE+8gjVz
	 +1cQcAeKt0O03XreljbIrBEaOEmdWHVzvrJoq3wIpxhYyVccwqQYUpCvM6vIYJPBpC
	 3iklHd36hxrvtqNng6BbyzlHrvcf3m9cXX7u42st3hlr4ZIVZDGAV51cz7t7gXaNsi
	 Nv4RjsQW/EkKg==
Date: Thu, 1 Oct 2026 08:33:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kyle Switch <kyle.switch@motor-comm.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, Frank.Sae@motor-comm.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com,
 jianmin.wang@motor-comm.com
Subject: Re: [PATCH net-next v23 3/3] net: phy: Add driver for Motorcomm
 Quad 2.5GbE phy
Message-ID: <20261001083317.6b1aa87e@kernel.org>
In-Reply-To: <20260930194513.663575-4-kyle.switch@motor-comm.com>
References: <20260930194513.663575-1-kyle.switch@motor-comm.com>
	<20260930194513.663575-4-kyle.switch@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  1 Oct 2026 03:45:13 +0800 Kyle Switch wrote:
> +	/* 100M template amplitude */
> +	ctrl = FIELD_PREP(YT8824_DAC_IMID_CH3_ORG, 0x45);
> +	ctrl |= FIELD_PREP(YT8824_DAC_IMID_CH2_ORG, 0x45);
> +	mask = YT8824_DAC_IMID_CH3_ORG | YT8824_DAC_IMID_CH3_ORG;

cocci says:

drivers/net/phy/motorcomm.c:1372:8-31: duplicated argument to & or |

Please also wait for the AI review to be published before reposting.
-- 
pw-bot: cr
