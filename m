Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793886055;
	b=zQyu+zs8Ar0U0vfvVO4A7HTgPBhepdTs45yRH7waqQSISMBdYHtzodPMjkpBzkqhxR7s
	 oPYlzHACEjvemgGCYtptxAJfLAcmvegiiXlevmgq/Olbf6R/zAiaaDD/67MeFidSsAKVt
	 Y79JQWKLKWRTLGvIxlik9qlp3WtbGt3N7lh2H8o8Vh/E1gMzAJGb8FXYBCl6mcKIcGl4I
	 jso3xX6RlyVhjmWt0kvxtFJLI9Gn6338nqug6T4FQMb6nIHWX+Z6UE20HO0repw+vT3Fm
	 elY8v4glmGDzzE06WPB+AfbtD56hB4KvAOChf3px+XfeqmgqWN7I7elrn7/hSB3H5EQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793886055;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Debian-User;
	bh=cayOl+ah2VntGuMKSFZe0/sOYOLHGMSfHTljLp1hqos=;
	b=rSp03ynUxv7cbh+2J9GjOxnOxJwWO/UwqgBkXiMXVUq2OO8X9ZWJ/zjvDaMdzma7s+Rc
	 0aj2tRRB7j7mOrEqat0+RgquBNdHgPlhW7JOUv9Lbg/IZrqz5G19Xqd3FOx5mQpzs1lpq
	 zh1rNRTLDsxJrVl5Ol5iAmXPw6Wc1jCj/OHkLzL9BljEEpkDD0Rn4IzVMvRaO+2L0FGbB
	 5cSQ/4GsHTjLElukQ3wrUkrnQ+TTwzP+iBF+16ZTQqhrTIJoXShtvgvlSZtCtZlWgxNxS
	 iVcmpL77qq25lqAVM4zAohniYJ0U4WjPrpOQxeccGTbnKHa+SG2/JlJpl3zA6see0fQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=BcsHNlT1;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40915606A335;
	Thu,  5 Nov 2026 13:40:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40915606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=BcsHNlT1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cayOl+ah2VntGuMKSFZe0/sOYOLHGMSfHTljLp1hqos=; b=BcsHNlT12nA+YrSs/yRQfTMO5p
	C1AEYURjocvZzLl7GjwphDEfRVdYqCD9RQ4WSY1RRadoooX7PEBQd2njIbSf0/8jAi5D8GScOyO0Z
	nQzofL3rkkHavZNegA2NJpWPSzvkTW65cBDV5gGUBpYYF1At8PsL5E957J0wG74iUl78HgOMgRWVd
	8krpw4mt0iFi6G3+l0/amB2R9RxV3H1IsBL4A7HUApVc9x8AdTicgmu3Kzm8VOt3JFnGSCilpsRyr
	TBApv+jFdlfxpHhRB+A8nXol+C281WEVBnrOR1udOBkiuXEDHDjppxGjcjT8697ze2O3nyo2UcxNm
	RKs+KCLQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xOxhk-008XWA-2g;
	Thu, 05 Nov 2026 13:40:37 +0000
Date: Thu, 5 Nov 2026 05:40:31 -0800
From: Breno Leitao <leitao@debian.org>
To: Ali Tariq <alitariq45892@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Yixun Lan <dlan@kernel.org>, 
	Troy Mitchell <troy.mitchell@linux.spacemit.com>, Vivian Wang <wangruikang@iscas.ac.cn>, 
	Chukun Pan <amadeus@jmu.edu.cn>, Siddharth Vadapalli <s-vadapalli@ti.com>, 
	Tomas Hlavacek <tmshlvck@gmail.com>, Muhammad Bilal <meatuni001@gmail.com>, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	"open list:RISC-V SPACEMIT SoC Support" <linux-riscv@lists.infradead.org>, 
	"open list:RISC-V SPACEMIT SoC Support" <spacemit@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: spacemit: Hold RTNL lock in emac_resume() and
 emac_suspend()
Message-ID: <auyG7hGJtMzV0Gbi@gmail.com>
References: <20261105123441.2524171-1-alitariq45892@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105123441.2524171-1-alitariq45892@gmail.com>
X-Debian-User: leitao

On Thu, Nov 05, 2026 at 05:34:37PM +0500, Ali Tariq wrote:
> The emac_resume() calls the emac_open() and emac_suspend() calls
> emac_stop() functions directly without holding the lock through
> rtnl_lock(). These functions rely on phy_disconnect() which reads pointer
> with rtnl_dereference(). But since no lock is being held,
> rtnl_dereference throws a suspicious RCU usage on
> Orange Pi RV2 (SpacemiT K1) warning when lockdep is enabled.
> 
> WARNING: suspicious RCU usage
> drivers/net/phy/phy_device.c:1831 suspicious rcu_dereference_protected() usage!
> Call Trace:
> phy_detach_internal+0x490/0x5f2
> phy_disconnect+0x90/0xc0
> emac_stop+0x114/0x626
> emac_suspend+0xac/0x126
> platform_pm_suspend+0x72/0xe4
> 
> Hold RTNL lock before emac_open() and emac_stop() with rtnl_lock() and
> release the lock when functions return with rtnl_unlock().

This would work, but I am wondering if it would be possible to call rtnl
inside the _open function, when dealing with the PHY? in other words,
shrink the time rtnl is held.
