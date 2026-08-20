Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096BE3DCD80;
	Thu, 20 Aug 2026 21:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787260261; cv=none; b=sUxXGa2jDRPplpa/YlKfDN88aBoULJAKY3kH2EYOFk9i1vd8/1wNHx4N89jA3ZeQPJlboPJhVr/HQmZb7+m1Br5yNHJwKe2Ua2yXpKkfgfhjJ/bw2cQ+FdXWhwYLqti1peldiQZZisQweFHDBZliAYFqVZ2b+IGDopq/gdnSKYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787260261; c=relaxed/simple;
	bh=haz3cX+jgtRxUtYhx1PNu2kmlr1O+I/z9J1THqvKWns=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JWJBE3nm5nIW6P0MJbZwY48Q3i2djY174ttmsTifA/yKiCQILpKClmp3SPVzuqzQLCbMCfKKXL7Ce7KePvJtRi3gbxu8J1AbEO/kwlR8D2hQ4vx0xItlnaoTppiZqLWlm4X0q32XkNdHWh/OuIZMHJizbTfgBpdwhGzwcLlwoow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sw3ZLQhM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sw3ZLQhM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 096761F000E9;
	Thu, 20 Aug 2026 21:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787260259;
	bh=H85X30IWrJ95sAQc0ZuX4pj9XKiyPTX6Mj+tx29AriQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Sw3ZLQhM1zRkynV4fddikXPADtXcUSUBtUa7Nhlz1u4/UDqIG8uXkHTimHJf2+Wwi
	 t4BxfvCjxs7hr2cdrB0ZANUP0qNZvFCPNk4H6cj3daLIJ/3es6ZjAP8ByL82DyxqIN
	 Uxq+21T/0KhUA4oiZLd7ZjvLIZac8Njlo/EK5KpeMftgFaCmiVXj5dtHvtU0c5EjsW
	 wBcl69VDVp+qE2wYRstlcH1Mp6UrFSKIm3+hp4O+uGW4amniZGkbGVY/lUbcdvvUgM
	 HqZ2la4ptIrHmSvoeeXcHSALvQBXS+xQxmlXkQ5qtf5bvnXOEmJH6SgY2NAdLRAv/6
	 M+2T/tGUoA/Ag==
Date: Thu, 20 Aug 2026 14:10:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bhargav Joshi <j.bhargav.u@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Tony Lindgren
 <tony@atomide.com>, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, goledhruva@gmail.com, m-chawdhry@ti.com,
 daniel.baluta@gmail.com, simona.toaca@nxp.com
Subject: Re: [PATCH v2] dt-bindings: net: ti,davinci-emac: Convert to DT
 schema
Message-ID: <20260820141058.69ad2edf@kernel.org>
In-Reply-To: <20260818-ti-davinci-emac-v2-1-805736d99e65@gmail.com>
References: <20260818-ti-davinci-emac-v2-1-805736d99e65@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Aug 2026 05:00:59 +0530 Bhargav Joshi wrote:
> Convert Texas Instruments DaVinci EMAC binding from text to DT schema.

## Form letter - net-next-closed

We have already submitted our pull request with net-next material for v7.3,
and therefore net-next is closed for new drivers, features, code refactoring
and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after Aug 31st.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer
pv-bot: closed

