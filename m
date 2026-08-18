Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99A1484226;
	Tue, 18 Aug 2026 17:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787073063; cv=none; b=kocVgK7tnSH2vhWFcebTUopMz1PIVIXJEfu3pEm0UPXoo+u4ACf5xae3dACyE2HqDfWHVFjpvIlDvlHd43sbaxZlwM07BbNZfOZL9GbEG197yFeIw1UibBF6h7E01CWZo2PHR2m9tnIvjqE7SpQrE6XZih5RTSWSgt6qis7S50Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787073063; c=relaxed/simple;
	bh=Za34WiY0SPf3M+izEKMwk4RrDTjPwH0ZtpaRhAPg7JA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AnG0HrlrvHK6ComPsHm/3WYySUwLZz74jCCn216GXouGaN8rauiMYVq0YOVT4DyaVtFnHn2k9GakHuJ3RXar6ONBXUvbQ89wXl1VlJg25DgpLv2WzmsaJPP0zmKEzAMHcI1hJZKpyN/0AKOoOGL/+puVj2B1+yjeui5+wFkC5u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UjOQTjTI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UjOQTjTI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A00051F000E9;
	Tue, 18 Aug 2026 17:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787073061;
	bh=jUzwTATzXhLTxk9V9YNW4mpVF0T9eKMmLmv9P0wrhU8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UjOQTjTIXq9Ku4sh39gHgAPEZG5XF+EoRi+lBSBDXCMrXdidkf1zmmNIzvw4K/wYM
	 GE1Tc03b5dZnHg+PeSMnJoBhk5E5PFYUe6YDKAFz4W8vEgGdJdOOMWkvfvHv1jQmUe
	 ONeeIaNo6dn/EgqVOc9axAXPNYw6hJ9CmuxCOO/F+BCTXua0giDjVeOTlpHFCbhvXj
	 1zsP9WNxbbc7BE1H1Mr6bekHHJkkNrESE+p5yn3HmcDgqiV19PlZQ2qd9MsBmy7/sr
	 IH35p7fltEwgD0XVhSLoc4wo9SvQOFPAWW0uFc19jpojQNzaEsFh0DKpgCo59ouPuN
	 RMj923g3O+2Qw==
Date: Tue, 18 Aug 2026 10:10:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bhargav Joshi <j.bhargav.u@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Tony Lindgren
 <tony@atomide.com>, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, goledhruva@gmail.com, m-chawdhry@ti.com,
 daniel.baluta@gmail.com, simona.toaca@nxp.com
Subject: Re: [PATCH] dt-bindings: net: ti,davinci-emac: Convert to DT schema
Message-ID: <20260818101059.130087b7@kernel.org>
In-Reply-To: <20260817-ti-davinci-emac-v1-1-022678d966e9@gmail.com>
References: <20260817-ti-davinci-emac-v1-1-022678d966e9@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Aug 2026 04:27:03 +0530 Bhargav Joshi wrote:
> Convert Texas Instruments DaVinci EMAC binding from text to DT schema.

## Form letter - net-next-closed

The merge window for v7.3 has started, and therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We will only consider applying net-next patches which were posted
before the announcement:

https://lore.kernel.org/20260816155953.072d73da@kernel.org

Fixes are obviously welcome at any time. net-next patches may be sent
for review and discussion only with an RFC tag.

Please repost when net-next reopens.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer
pv-bot: closed
