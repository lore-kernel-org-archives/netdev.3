Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E75035B653;
	Tue, 22 Sep 2026 00:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790038730; cv=none; b=jXtQnjJ0JVvjlTIRq5XWNlnq6vhTrxD45j7asGUJXpLJ8d8uxsLgQpLry5MiTNuyyF5qiuBPasPfVX8dUelYCXgTcPXW+vtTOrgz6OFYIHWuFPgmwX5+W8gW5hUQWK+qQAlLyc/sBMvFXhabYIHrZVT5x3ak3oNdrI9cGxdpzDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790038730; c=relaxed/simple;
	bh=LuucaXUYW2vNElT9BtbSKxK90c5AT/Pap3VElpTyj64=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y/tnvRi9rqtBy7/d5kj7OAd8OM2MPwO4PlBz3xtxSvw0goGfOeqWmxjsKSgjW6MHL0bxvrVpGsQp/4csebDpd28+aLs/9BjAbSMUp9wrxqiaaO5HJQMgM4jX5qx8RUMJQvnUB7KFr7gSujKUlo+ecXzF8a3lD/HUpzLD7nJ1pYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ba3B+C7n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ba3B+C7n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72AEB1F000FF;
	Tue, 22 Sep 2026 00:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790038729;
	bh=vjpopAt2M/1jQ9Wty6/L8f2eqKUUBtCNk4SC/rcfJHQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ba3B+C7nOBFazk39hpWJw/s1ZjjszpyCnV+1dU/cEl/fb4sOhW90t5k/hBNl3E1fG
	 nI8QXEwcg3AfDYrWatSjS+c1MJURWp8nYDWyCzA9Ak16ill8X0Yf8sC/54i0gL6pC5
	 kGH+noVlN2ReSUWEHbcQCFOJjVtuyv5Nv2hWytz/BnUoVeUs+5e8PLLlSGx+HAjPBe
	 23Ex6GhcZ6JkE1HEa0HNiQvSxAwlJ0wrAWIKsGHw4z3j/Vdp7oWf8korPIF6X6WvUE
	 2O4bDwwseleQ7yg8x00eEHJXz+/6Q5KtGrONSunX7iOkL4vweqUGEbhqHPYkgu9H6a
	 7wy30WtJ23vtQ==
Subject:
 Re: [PATCH net 3/8] net: bcmgenet: do not skip WoL power up on GENET V1
From: netdev-bot+sashiko@kernel.org
To: florian.fainelli@broadcom.com
Cc: netdev@vger.kernel.org, cursoragent@cursor.com, opendmb@gmail.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 zakkemble@gmail.com, horms@kernel.org, ryotkkr98@gmail.com,
 linux-kernel@vger.kernel.org, nb@tipi-net.de
Date: Tue, 22 Sep 2026 00:58:48 +0000
Message-ID: <179003872801.2160803.5049749603905996617@kernel.org>
In-Reply-To: <20260918000732.276506-4-florian.fainelli@broadcom.com>
References: <20260918000732.276506-4-florian.fainelli@broadcom.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The submitted commit "net: bcmgenet: do not skip WoL power up on
  GENET V1" (d8dc741c84b2) carries no Signed-off-by: line.

--

net: bcmgenet: do not skip WoL power up on GENET V1

The patch moves the bcmgenet_has_ext() test out of the top of
bcmgenet_power_up() and into the GENET_POWER_PASSIVE and
GENET_POWER_CABLE_SENSE cases, so that GENET_POWER_WOL_MAGIC reaches
bcmgenet_wol_power_up_cfg() on GENET V1 where the EXT block is absent.

The only comment below is about the commit message trailers, so the diff
hunks are not quoted.

>     Fixes: 1c1008c793fa ("net: bcmgenet: add main driver file")
>     Assisted-by: LLM
>     Co-authored-by: Cursor <cursoragent@cursor.com>
>     Change-Id: Id6c85b2790191786aa535d71fea357d1cd49a2ec

[Severity: Low]
This isn't a code bug, but the trailer block of this commit has no
Signed-off-by: line. Without it the Developer's Certificate of Origin is
not asserted, so can this be applied by a netdev maintainer as posted?

The block also ends with:

    Change-Id: Id6c85b2790191786aa535d71fea357d1cd49a2ec

Change-Id is a Gerrit-local artifact. Should it be stripped before posting
so it does not end up in kernel history?

Since the change carries a Fixes: tag and is therefore a stable backport
candidate, the authorship and sign-off trailers matter for the tooling that
picks it up. The same trailer pattern appears on the other commits of this
series, so would it make sense to fix them all together in a v2?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260918000732.276506-1-florian.fainelli%40broadcom.com
