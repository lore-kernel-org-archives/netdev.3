Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAF827B340;
	Sat, 19 Sep 2026 22:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789857696; cv=none; b=DkC8EXKewyaZbpYInhpKdT9g+zIslW5T47Ub6a9cVUxDK9WuJ1fZwKn3wdzJd7dcK3r4l33ftPTxa8cGXfnv3I9Nfr61wB2pP4FF4q1DpkfJjVjFzxvzZCK03w6+aY4oT9gl+YviMFkDPj71do40+WKhyurigHfoPmjMt6DfHSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789857696; c=relaxed/simple;
	bh=GWuuOvf1JPHsAV53AHQ4cVkBj7+GWC4kkbhJwdwxn4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ISF/BoPJ+Lja5s0vC1pzD1Rz52MHUVBF9McP/EJafgPv+VgsMy2tg5+5lZ3hQVdUXiifAyG1jABCjhwXdA62GccFf4F8vJUVNNUfLsbws5arGLyOnjreaRKDfRc3oyHRI+7Fyxlymowj9qxUEi34DlSjNkOb5JC6Q6VM8jDjq/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c4PP+K8Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c4PP+K8Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 575D21F000FF;
	Sat, 19 Sep 2026 22:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789857694;
	bh=QxdajoRUbpisH/niCr3vIjGevbK/r5JxIfffAEufKjc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=c4PP+K8QLpz4cohUTDzXbn/czVPlWQNSwfPSzIv0YXJrmpYbiGBolkkC2btAzYM4Z
	 G98ICq0DfYd6BnMYSC8yFcXu3ZKPa0oK+2opv77fKKu1AUVbkROUPehibYwHXS/Sbw
	 w1BSsDi2zJSTok1DCp0NeE7kGR+PSPgfwg7eKeeAss6rXkocUt05kzDIGna/2osyWj
	 jyrLY9ZLG/TtwxF03u0fO52TmuqNvdnGtw7CfwXcSaH1/Fyp6nPhlXLb1o2jayUs8u
	 j2s0HE1OG7mtLn58xTbKMN8Qz4wp2Iymz6Gm90LcHXZlYdksTGQ/OkW5JIrW9V34qm
	 +2/lFOPn/Sj5A==
Date: Sat, 19 Sep 2026 15:41:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Michael Stapelberg <michael@stapelberg.de>,
 linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCHv2 net] net: phy: marvell: undo WoL setup when
 Wake-on-LAN is disabled
Message-ID: <20260919154133.3fd41455@kernel.org>
In-Reply-To: <20260914212409.74539-1-rosenp@gmail.com>
References: <20260914212409.74539-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Sep 2026 14:24:09 -0700 Rosen Penev wrote:
> Fully disabling Wake-on-LAN on the 88E1318S/88E1510 used to leave
> the WoL interrupt enable bit (CSIER.WOL_EIE) set and LED[2]
> configured as the INTn pin. A magic packet arriving after "wol d"
> would still assert INTn, and a later "wol g" re-enabled WoL from a
> dirty register state.
> 
> Fully disabling WoL clears CSIER.WOL_EIE on the copper page. The
> LED[2]/INTn pin mux is disposed of only when this driver forced it to
> the INTn function: the INTn enable and polarity bits read at arming
> time are saved, and restored once all WoL options are cleared, so PHYs
> serving the MAC interrupt, strap configs, or marvell,reg-init values
> are never touched. The FORCE_INT bit is not set while disposing of the
> pin: it holds the interrupt line asserted and turns the shared PHY
> interrupt into a "nobody cared" IRQ storm when the PHY interrupt is in
> use.

Oof, this is pretty hard to read. The paragraph is pretty much 2
run-on sentences.

Please add info about how the issue was discovered and how it was
tested. If you don't have HW back to net-next without Fixes it goes.
The AI is pretty bad at judging severity, I need to find time to tune
the Fixes suggestions further :/
-- 
pw-bot: cr
