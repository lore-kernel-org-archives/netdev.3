Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9F2346774;
	Wed, 12 Aug 2026 13:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.127.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786543194; cv=none; b=Sjqe29dwwiXuysvomiShqZIeTGTsHGRmSdaDHpzFGGV6sQyT5lkjGb1nmLBN9nqrx3COie2ife1Lyk2mB8aJF6r69oaKuZm3aNS9flTtZxK012v1fdymuB6uC+OnjS9bV/wWn8qqHw0gAsCgeI2eHdFEu7msW5R5vInCdGQoCBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786543194; c=relaxed/simple;
	bh=Jokbltb+zA1d6fucMN6E3Co3pWL6vfKPXBDjXPWTPzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WdEx/bS5fdfQZiKObJTK8F/ggO/OX1CgojufOJLxdfhc189tPgEo7ENBLQ/FwIoJPUSuWwPM7U151FscDWtpuO4L6c1rqE6+ni+U0G/IUbjHbbV0JivhPsNDL1GKwGnpaYkS49eRg/6xxwB4pIJGsv6HQA61ebA2dCygfvRp/LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=ln8OB5sN; arc=none smtp.client-ip=85.214.127.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b="ln8OB5sN"
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id C2642E8322B;
	Wed, 12 Aug 2026 15:59:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1786543189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jokbltb+zA1d6fucMN6E3Co3pWL6vfKPXBDjXPWTPzM=;
	b=ln8OB5sN+K2EwgNKD68euK4sniTzTIs0kBq7Dc67GmkhSJ7wpm57ouRFLo66DF6Vt1HV1k
	Ir1YoBvjXtsjTvFc61fm7ucZQ8HauwmA3aAdzaDMGGsWk2f8Pnc/n70rI2z24yDCcsM8ef
	+UCaDFoh19yrOomPQi32L3gfL08bOjlVMQ8VZjcI8+c007NSuNgXz+yZiSXIhgaAJDoU3h
	RQhdzXBBpc5CWjz7asWCmxBzYkbMXzmKd69LqhfkIOj2iySuXd2jvkFzbeVLivtsU9PUZM
	Caj0a7K28RusxkY9+mveNH4vL5dd06woAXWgJasJHdmE5XyA7sXChKtEggpD+Q==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id gKh4YMMfSl2l; Wed, 12 Aug 2026 15:59:49 +0200 (CEST)
Received: from p14sgen5.. (tmo-120-142.customers.d1-online.com [80.187.120.142])
	by szelinsky.de (Postfix) with ESMTPSA;
	Wed, 12 Aug 2026 15:59:48 +0200 (CEST)
From: Carlo Szelinsky <github@szelinsky.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
	Simon Horman <horms@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlo Szelinsky <github@szelinsky.de>
Subject: Re: [PATCH net v2 2/2] net: pse-pd: guard regulator ops against freed PI data during unregister
Date: Wed, 12 Aug 2026 16:59:36 +0300
Message-ID: <20260812135936.889119-1-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260810135233.4be3dc5d@kernel.org>
References: <20260810135233.4be3dc5d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 10 Aug 2026 13:52:33 -0700 Jakub Kicinski wrote:
> It'd be great if we can figure out the safe lifetime rules for pse-pd
> from all entry points. Specifically the sysfs complaint on patch 1
> (assuming it's real) makes the series seem like a bit of of a see-saw.
>
> Let's get it reposted and take it from there?

Thanks for the reviews, Kory.

Makes sense. Let me go through everything that still touches pcdev->pi
once pse_controller_unregister() has started freeing it, so it's clear
what the series covers and what it doesn't.

The regulator ops (pse_pi_enable/disable/is_enabled) are the sysfs case.
It's real: the PI regulators get registered before the controller, so on
unbind the controller goes down first and pse_release_pis() frees
pcdev->pi while the regulators are still live. is_enabled() is
reachable over sysfs. Patch 2 is what handles this - it checks !pcdev->pi
in those three ops and frees under the same lock. Patch 1 just does the
reorder, so the two really need to be read together.

The other one is of_pse_match_pi() from of_pse_control_get(). A consumer
probing at the same time walks pse_controller_list and reads
pcdev->pi[i].np. Problem is we free pi before list_del(), so the
controller is still on the list with pi already gone. The series doesn't
touch this yet. It's a one-liner really - move list_del() before the
free. Then a lookup either sees a valid pi or doesn't find the controller
at all, no NULL checks anywhere. I'd add that as a patch 3.

Last two are pse_ethtool_get_status() and __pse_control_release(), from a
consumer still holding a pse_control. They read pcdev->pi[psec->id] too,
but here the real issue isn't pi, it's that the consumer can outlive the
whole controller - of_pse_control_get() only takes a module ref, no
device link - so a NULL check buys you nothing. That's pre-existing and
not really something to fix in net. The notifier series I have for
net-next [1] is what deals with it: the phy layer drops phydev->psec on
unregister before pi is freed, and phy is the only pse_control user we
have in tree.

So for v3: patches 1 and 2 as they are with Kory's Reviewed-by, plus the
small patch 3 for the list_del reorder, and I'll write all this up in the
cover letter so the ethtool side is clearly left to [1].

Sound ok before I send it out?

[1] https://lore.kernel.org/netdev/20260630091125.3162481-1-github@szelinsky.de/

Thanks,
Carlo
