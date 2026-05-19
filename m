Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB87A1ABEDE;
	Tue, 19 May 2026 00:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779149752; cv=none; b=P9K8V1Youihl4LBlOjCH4+/bfXhVeWcaoXhE3IsuDFs49h8ZWzOMX/W/2DYJNULWoGftnwDlzco8kUDgcnEn3KVY4XJN5hQWDk0ibezFhvGlLq4RIhykPaLjQdIpkrJduk8AYgSFa8FfWd3ps3ddizKHVlBLpQFHOgrPbaqHntQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779149752; c=relaxed/simple;
	bh=XHVsuByL/XktUso1vX3AnXp0EPgic3oUXah4axgYY4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JjE4uhh2TDTy8yYDDFpOzbdCVxVp/QkaH+YRDbj4Up0v1C2V0/XOyGCTXR0Yu5pDmFyS8+w3xuvg3S0b9lyIA7/1j4JX8iois+DMFKHllTA7Z2jUADd7UIaxu6S4JQjvMleMbVVTE2FTZJOTvCLeDeI1Nm/FXB0ZGzByURydF7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J9ife/fX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J9ife/fX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10CA8C2BCB7;
	Tue, 19 May 2026 00:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779149752;
	bh=XHVsuByL/XktUso1vX3AnXp0EPgic3oUXah4axgYY4Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=J9ife/fXOK+EBsZdyTT4wL4hQFIy6eXeSywWFoiykKGUSyR20S5aoYzrIj2UhIbox
	 Y5an5MPmYjBHSmgghmtDMhn45ZtnjkWXBRDTAurw45ukSUovGAya4Y23Q09ml4sAFy
	 G7+WiGO6XA3YpYEwI9oMBKwP7uDPOGikQ6kyW/0QJZIlFenEkZPfOaKtwcJoGwuKJJ
	 lzb8YjohOn/Onhe4FpCe1sKXggQAnVS+a3du9m45g7iPtCb/dexkshDrRi7VhHRSgs
	 j7s6mDTTk73a0qHNIsEvAyKUyZeggZYW0qhK0tQBBkRYWZoRIYPNy4XakCTh69ux6O
	 jpqs6gkvAnjAQ==
Date: Mon, 18 May 2026 17:15:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 0/3] net: phy: micrel: Code clean-up
Message-ID: <20260518171551.1eb8b09c@kernel.org>
In-Reply-To: <cover.1778856199.git.christophe.jaillet@wanadoo.fr>
References: <cover.1778856199.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 May 2026 16:50:23 +0200 Christophe JAILLET wrote:
> This serie is only some clean-up related to
> drivers/net/mdio/mdio-mscc-miim.c
> 
> It depends on a patch called "[PATCH net-next] net: phy: micrel: use dev_err_probe()"
> that has been sent recently.
> 
> Note that in the 2nd patch, the order of the calls in the remove
> function is changed. I don't think that it matters, but I'm always
> relunctent to change such things.
> 
> The patches are compile tested only.

... against the wrong base tree I suspect? :S

Applying: net: mdio: mscc-miim: Remove some redundant code
Applying: net: mdio: mscc-miim: Use devm_clk_get_optional_enabled()
error: patch failed: drivers/net/mdio/mdio-mscc-miim.c:318
error: drivers/net/mdio/mdio-mscc-miim.c: patch does not apply
Patch failed at 0002 net: mdio: mscc-miim: Use devm_clk_get_optional_enabled()
hint: Use 'git am --show-current-patch=diff' to see the failed patch
-- 
pw-bot: cr
