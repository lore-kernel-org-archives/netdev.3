Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F2F43CE78;
	Wed, 22 Jul 2026 17:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784740658; cv=none; b=koXj45ZMIjEdVMngDn8aBeWdPe5BJymXa0VBmaoXfaHJzGcPSI+AsAVaD3EqaQ2r+UcsSWCaf3MsDHfSCmWIH3aQVa1W6LAON5bdWAcODcx4xnu9Iz+Jh7DsToJ1InEWRyunFwIEklS+WMAZe5hBv3LWVqwDanzX7s0azXr62Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784740658; c=relaxed/simple;
	bh=DgIm8f+ShoKBfGNPiCNyaToghLUd0zMKHcFc5O3JQtY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UBT6SnpolO58Ne70Ru/A+6VQbgdC5eTfrMCh6Wefec6+VEq7A/s4F7WA9NpvIDMOW1dAGsNNegn87lXZSKbX15It3G8qYIw74O961TqFVnLlJ0B1/UlM9MQwPxb9onvu0ffGP5kjWM6SX4FdmdTENy1GNyPu4VFcsNc1+IQDgW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R2eA40qx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R2eA40qx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E73821F000E9;
	Wed, 22 Jul 2026 17:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784740657;
	bh=3+uXKKSG/xRqQ+1D6vmFgc2VuTqzOoBsFajRDmbAdCA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=R2eA40qxnbNrdmxkucnNDcVY5yna4ZygLc4MqYXqAMZ0+9n5uUNK+8mxbY5N+eBaj
	 7vQCBieBM5JAnEyySmP4SPCaWu66FX7t1wyf8LCyH6AgD1xw9KBMAR999ecW3p67o6
	 j3ThOTIm12XsnRn7AgwMhmyS2308Uekob0Jp0/t+iE395FNpo9EuCcX1Ze5uOid0kA
	 7YGG9o7tbcYYKkaUmj+1W3M5B9IJMP0IimtAn7eZWZicQ0CfJkbPKxjQTHC8vu7zVy
	 1kVMWAxVQLQiiDc9BujlNcGsvIss0HGVBMpx1XzoPeT6jOnSYGngRQxw6UH0UnQDsH
	 Fz0l2ZS4F+FRA==
Date: Wed, 22 Jul 2026 10:17:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4 0/4] net: dsa: mxl862xx: support firmware
 update
Message-ID: <20260722101736.6f41371e@kernel.org>
In-Reply-To: <cover.1784665017.git.daniel@makrotopia.org>
References: <cover.1784665017.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Jul 2026 00:58:15 +0100 Daniel Golle wrote:
> The firmware of MxL862xx managed Ethernet switches can be updated
> in-system via the same MDIO bus which is also used to manage the
> switch. Wire up the devlink flash_update operation for DSA drivers
> and implement firmware update and version reporting in the mxl862xx
> driver.

You have to create a documentation file under
Documentation/networking/devlink/ for the driver.
Commit messages must contain example outputs for info.
-- 
pw-bot: cr
