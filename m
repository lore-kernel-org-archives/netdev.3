Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EAB46DFFC;
	Tue, 21 Jul 2026 16:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784651008; cv=none; b=Ai1NNN5BuI+IamIPMLWLFO2AUCO4Zd5N75VRtOWwWH27zOGHLIa4aJlw9qSfoGqO8vVzPNGNgP50y1LQvTYZDmk6oLruntRYXUkvH8wQ9FA/Z/t0d4h1jJ5CxKGPQoLn+AWxbXNbv4dWs6NFuA1zr9ohaMHUV0Ih7B6DYgt18Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784651008; c=relaxed/simple;
	bh=Wsz8ilwWzdYrUhL+4ksROHyGwpcyo7lgbJeBIMxyyVM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oR6w11E0T9NIiAQWRYfrq61RBK7O2YUvmVwT2h/8PfDrR0UeyprGhVHiXDZRJF/hqJXxWOoujtj1oyXuVud5q/dkHhW6E+AXVfzNtN10FZcGPdFcWRmHAqIKVZ8QL4L9wwc6BW5/lO4oA6+H8fukOVzGFurjXplBgfbBOPmfmWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZReO5y9J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZReO5y9J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36FB61F000E9;
	Tue, 21 Jul 2026 16:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784651007;
	bh=Wsz8ilwWzdYrUhL+4ksROHyGwpcyo7lgbJeBIMxyyVM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZReO5y9JY/EcFNHqGu9F89tg8D67ik1UeFRgk2xllPoxJKDA10BH1+yJ9AzNx6SXv
	 srvwrIxMC7xiZPeRJE1LsrX0AukcY0LC39+dGq7zp7HcWmkcaivFasdvIG15HeHbxR
	 V9NudI+qj+F50rVmo1QGtfi+RagUPhr4DqBWvk71BIEg9AO5v1neKwmLXFaLuERgbD
	 1SidNEkNh7xXCJjGDXqw5LyLX1Eq0R3IZ7oWWF3u7WR8DHOAC0JjMN9bLmYd3ekuDP
	 cBoqYkdUUVIKkAvBMe9uhHLWuMCZBA7ldRHNpbrLaisYqPxLRuMuiBkdjhrvN7WSZ7
	 fd53zsvpNjtRA==
Date: Tue, 21 Jul 2026 09:23:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Oliver Neukum <oneukum@suse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, manuelebner@mailbox.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 net-next 1/9] net: usb: move updating filter and
 status from cdc drivers to usbnet
Message-ID: <20260721092326.4ffa30dc@kernel.org>
In-Reply-To: <20260714114429.1073434-1-oneukum@suse.com>
References: <20260714114429.1073434-1-oneukum@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Jul 2026 13:44:21 +0200 Oliver Neukum wrote:
> These helpers are used by multiple drivers and do not depend
> on the rest. For example rndis_host will also need cdc_ether.
> Leaving them in a cdc driver means that additional drivers are loaded
> just as a library, not to support hardware by themselves.

checkpatch

ERROR: trailing whitespace
#169: FILE: drivers/net/usb/usbnet.c:2316:
+^I^I/* we cannot assume the device is in sync with us*/ $
