Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF962390C8E;
	Wed,  2 Sep 2026 22:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788387136; cv=none; b=FFNpBlmyATbyZi53ea1YB6dH87jxItpal63wQpJQYuW+y4cX5eUIozCXr0ynQY0j+rj/YZTWfWMwT1BQh4DQArQxgsRUbkF0wlInLS/bMf8nHhqKh+s5jG+vf06eFaPkBON9yQ4w5ue5rZLKpBcJ8nfJoKGNU0nd1/2U/J9GaYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788387136; c=relaxed/simple;
	bh=lBRo0dtFcGZoLsHqwG1x8Z7YpfuSx379Id0Q97B6c50=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RCoYwzWaCf5flA1BMlK081lr0o3uPFXuF7xSrOsse1kfOLOVgtk+rKVP5kjtyPCKpta605c2sAM+56WOc+eUWrL0uHxe+p8Cyr0Ij6ZLKCj5pQyN71MPH2ntKrhmuNKjrZZ8WxhXThxz3vDppgO6r1mtfS8N511klD1sz9ogYW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Alcyj74s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Alcyj74s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EC561F000E9;
	Wed,  2 Sep 2026 22:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788387128;
	bh=tg7zC0YvIqt87WX64Kb8dFLAU/T4AqeU8cWYntG0MUc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Alcyj74sTAGIUKrzpdX7RXIevv7KPHJ471XZlqZ4FKGF8kSPgvwlpYqqLqb+LiC4S
	 zUoOvaJyBU6nSYWdpnQSO84qved4hVW3Q2lfyWTBs39c6XsBi8Mr4HaEz35Ke6bTlL
	 d46qHBte0SL4yXVEO5tGSipLL4z0St9EfUYVQHiIIYdptZNeYDmhZT6wxNXPKeGIvb
	 pjp6+dlDTpvUZ73EsgTqOIRC9jMbePjqp756ffAePwxHMh79ZLchPNKwfgEaj1e48E
	 MrDu7LrhzjL+0TfAGcvGd9Ld9DTNeO8hZOX/fIhBEEDCqhkgIkE+OLYNyMTeUgKufE
	 k/bVucW3m7IdQ==
Date: Wed, 2 Sep 2026 15:12:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kyle Hendry via B4 Relay
 <devnull+khendry.reliablecontrols.com@kernel.org>
Cc: khendry@reliablecontrols.com, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?=
 <clement.leger@bootlin.com>, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Lad Prabhakar
 <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] net: pcs: rzn1-miic: Verify port number from dtb
Message-ID: <20260902151207.671c55f5@kernel.org>
In-Reply-To: <20260902-rzn1-miic-fix-array-v3-2-3f7dccffaf5a@reliablecontrols.com>
References: <20260902-rzn1-miic-fix-array-v3-0-3f7dccffaf5a@reliablecontrols.com>
	<20260902-rzn1-miic-fix-array-v3-2-3f7dccffaf5a@reliablecontrols.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 02 Sep 2026 11:37:36 -0700 Kyle Hendry via B4 Relay wrote:
> +		if (port < miic->of_data->miic_port_start || port > miic->of_data->miic_port_max) {

Please wrap this at 80 chars, some for previous patch

> +			dev_err(miic->dev, "Port number out of range: %d\n", port);
> +			kfree(dt_val);
> +			return -EINVAL;

coccicheck says:

drivers/net/pcs/pcs-rzn1-miic.c:691:1-33: WARNING: Function "for_each_available_child_of_node" should have of_node_put() before return around line 698.

> +		}
-- 
pw-bot: cr
