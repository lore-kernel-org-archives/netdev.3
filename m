Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECE2399CED;
	Thu, 30 Jul 2026 20:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785442189; cv=none; b=mCMnDC7oF0w02p0eou/67wbknPyP2N+JlPM9qQFPHlFg+J5bwzctm2Ba6qzJUgAXDsCk96F8NZtqUX4G71a23JMogRWkcwJukxaIDF090yvysp3hkY8T3oRtR9rgEsyK2k++vsN45OuTvX+98028BfJ9XHhk53fvi4zmMQWf3nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785442189; c=relaxed/simple;
	bh=YoageaeHuW+vLD+n3J3BgniEcl+294LoQ8nwrWdQTmM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hb1uZPtalSUgR1Xc3XNhn1uilMBAEdeioWunrYxy9JxyNZvoPyYsUwI/mD/iWwkvfwSKIJk9gcHGRPEPlBa4Y3SEmxgQQmWSUvXUr3hqQol8CcxOm5sIFbFEEdZ6KRjPSt5y+POnC0b0iEWC+ZJrl4oHQgDZ5SdjW3284uIcCyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m9tJgX3s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m9tJgX3s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A3511F00A3A;
	Thu, 30 Jul 2026 20:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785442166;
	bh=YoageaeHuW+vLD+n3J3BgniEcl+294LoQ8nwrWdQTmM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=m9tJgX3s2+fJtTOhhzSUFdSf87f6HjmB6S0nyzk6AawrnI2k3ZI7Ayp4PPvoIHtcB
	 x/nuxXEsuEtzHawo9hnIacD46ErBp0Ce8aOJMYeeZa07Sc6imTMJrJT4AZaarPmd3U
	 3iEVDGLGDiUtOZnb1OB6kHky6CS03EbgSp2Wv6uh0VpiXc94wEQpq3xXoEY3KAdhL/
	 +xaTi+pCBaTEB8me4zzBzMj7/WvYt/OoK1/dL2hL0JPZ8CNQCn5FFCD2Sgp83hJoRA
	 9mg7rEbTuCxYM0onWdSQSwyWXIC9Sdc+XCXq08APafCGENqjiwOMCN189/C96EUqmQ
	 FKQZbf/MUCEPg==
Date: Thu, 30 Jul 2026 13:09:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Vladimir
 Oltean <olteanv@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 "Chester A. Unal" <chester.a.unal@arinc9.com>, Daniel Golle
 <daniel@makrotopia.org>, Heiner Kallweit <hkallweit1@gmail.com>, Russell
 King <linux@armlinux.org.uk>, Simon Horman <horms@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org, mfd@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v19 00/10] net: dsa: Add Airoha AN8855 support
Message-ID: <20260730130924.1f99801a@kernel.org>
In-Reply-To: <20260728154846.1828945-1-ansuelsmth@gmail.com>
References: <20260728154846.1828945-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Jul 2026 17:48:27 +0200 Christian Marangi wrote:
> This series add the initial support for the Airoha AN8855 Switch.

This series did not apply at the time of posting.

Looks like Sashiko/Gemini applied and reviewed it against net/main
so you should check if it has anything worth addressing to say:

https://sashiko.dev/#/patchset/20260728154846.1828945-8-ansuelsmth@gmail.com
