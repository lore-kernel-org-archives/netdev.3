Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793433902;
	b=dgystKp8uXniuBn3v+kY74AvbgTJgnswoQsanYTWBPlRHSaySp7t/Az5F/mSkxXjy9Kt
	 h1um7vYS/fcvGhCaQ0Vb7zYSHOCByQ001EFt5Ca/79NY68UmxgDiL6df5n6QgSXHxC/UH
	 hbTADok+f7/8b1vIX5FkUWesPGjqKDCd23wy2lO0p0Yf8sFGXo5uqo2D9WGC59cpINsdp
	 VFdHbUkGdLyMt52cMUtp5I49FWpJgSc3i23OZUXwXpq2171+R0/4T9xtmuuSDWa6PWzB3
	 8icF+NHTUlkSijmTBKzVNqYoB6wtgIWWZ9NQprD3gJ7GdfuCotkL22r39G4pI/objPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793433902;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	b=AcwAZyQ+GzvIZyHPjZG9RpsPsE3B1znzdJ6Z3L7xFBqnO49bjHSBvKHEFPLMTX/M4ZJk
	 iISmDQUcyeLhT+lLwnlstEYHw2deYY2L+VH7Nc4uL9xdT4Ab4MIyY/icliyzPpXdVi0Dx
	 kwrsKcXxNgawOqemVS4c4Vq5Uoj7kfEPVqfSQN2J4vu2H27CIq9iXRu9/LyIFfiMdOssC
	 7vKhl4UTUwY9hTbZp92IYwm1a+4qattfiZ4Fg7OZAvkqe0BztaYynjpjI/lvegrKTjeKf
	 m2R/kUTn+gpjftImvJZDUCyNZe7JQnFdJpNlkz8IBN/mH2boDhgzTppx3d2KPJX+UBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k0ecfEyD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA5E606A31A;
	Sat, 31 Oct 2026 08:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k0ecfEyD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 617E71F000C1;
	Sat, 31 Oct 2026 08:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793433901;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k0ecfEyDslk3OPxAdAna6unlZefnr/LSIYKvo4kar7IqKLLsf3yvlR0IuZ97gCV79
	 t/fv2IGxGjaz6mfSd0xNgpGBONXUtlnisUH41brdoXR1yGN/Z8WD5Wv3zffFJ2t2G9
	 OoERCMFJ1TwI2NqVa/C/nj0BYzxew+9cHHQfwyksbLzA0vkdquWShg1/RK5YprOUN5
	 gC/wP+3E2bEWPi76yjhOitPIvGSWsYGWXG4yrGn68l7u0ecbKua29ubmmUISq69FcU
	 Ym71YAmNkC1qunfsbohxe8Fm2HygfBNcjATBQAeMX6pVi22rnjQPK/+Y91eBqclG1Z
	 yd9Chh25ADtBQ==
From: netdev-bot+sinfo@kernel.org
To: Igor Velkov <iav@iav.lv>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Lukas Wunner <lukas@wunner.de>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Wei Fang <wei.fang@nxp.com>,
 Niklas =?utf-8?q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
 Paul Barker <paul@pbarker.dev>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Doug Berger <opendmb@gmail.com>,
 Thangaraj Samynathan <Thangaraj.S@microchip.com>,
 Shenwei Wang <shenwei.wang@nxp.com>, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4 0/5] net: phy: postpone PHY interrupts during sleep
 with MAC-managed PM
Date: Sat, 31 Oct 2026 08:04:59 +0000
Message-ID: <179343389984.3286.809839136574794731@kernel.org>
In-Reply-To: <20261031-b4-phylib-mac-pm-irq-v3-v4-0-5ba23b3ff9a4@iav.lv>
References: <20261031-b4-phylib-mac-pm-irq-v3-v4-0-5ba23b3ff9a4@iav.lv>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
