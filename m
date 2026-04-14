Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678AF2641C6;
	Tue, 14 Apr 2026 15:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776181168; cv=none; b=XM4ESSHNky6Ov036UxDpPh+3ioANFnDv46kHv6UqoRzNYKtHjceeGRQJbZHSQiL91eh7lDM2DX5x2aELQnw4e7IS/JwM8dsCD9mXKO2rr8r8nzgQ0Dg2ZbRTWCTgg7kIPzSd3FUWE68Tz8QfU+kObAo5su2PHENI90bv+EhYjxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776181168; c=relaxed/simple;
	bh=rvfCg0/c2jStKBs1lu0aHeajXcAaG62j7ArPVl5a5Ek=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tRThCwPqpfoiqLhAlXyxgRogp3QRpkV5n6eMTO0vvPpZeuq6QIOvA77PmZIf7dcjhBEj/JrcGu2USHEYEqlQXhr1DHy5Mdk8d0y4g4edt2oXQnkJKtGPqH2KcilDnpiob9VhyK/aQp9Thjx+TNcW5WlKXj8NSgsj+GEwOMey0R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fg60qm48; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fg60qm48"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 485B7C19425;
	Tue, 14 Apr 2026 15:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776181168;
	bh=rvfCg0/c2jStKBs1lu0aHeajXcAaG62j7ArPVl5a5Ek=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Fg60qm48jFOg5TYDgoqonpDyXxVnc4ix+NtsuXD/dIstBdZrOcY0vR2tqmI9zqcOL
	 bbMCXKX8aRlAKNvw0KRcenNRwd6w/alLkhN/NgPBP0oykQK9PyAtny3Ua8OYlas7xS
	 6rgHbBa/uTlHeceIBu1M6UPrnsN5oiqzRflA0s89tgN7cltiGWx3ryarQSRpXhU9ic
	 CYpFiOYNzTptlROx93gczU7rdog0mCnItWO+kyLskDXSEoMntwx8SYxhM7YID1cQYX
	 cCj9lYnvoR+tu8kEto7tQxoS7TVqsnGVF4eMImutjekxykS0SDA2p2+e5RcctdDevJ
	 8p2Ra1lKWC6ZA==
Date: Tue, 14 Apr 2026 08:39:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Biju <biju.das.au@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Biju Das
 <biju.das.jz@bp.renesas.com>, Russell King <linux@armlinux.org.uk>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven
 <geert+renesas@glider.be>, Prabhakar Mahadev Lad
 <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH net-next v3 0/5] net: phy: Fix phy_init_hw() placement
 and update locking
Message-ID: <20260414083926.6928260a@kernel.org>
In-Reply-To: <20260412140032.122841-1-biju.das.jz@bp.renesas.com>
References: <20260412140032.122841-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 12 Apr 2026 15:00:22 +0100 Biju wrote:
> This series fixes two related issues in the PHY subsystem: incorrect
> placement of phy_init_hw() in the resume path, and drop/update locking
> in several PHY drivers.

Hi Andrew, IIUC this should be applied for 7.1 but we're waiting 
for Russell (who is AFK/busy) to review. Did I get that right?
