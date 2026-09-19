Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F67E2F691D;
	Sat, 19 Sep 2026 22:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789855517; cv=none; b=EDEhVI4noaA8TSi0qrIoaV/r92+a5LtrEcDMuJanmwE8W/CDA4TwFoQ9QE6B501aRYnw6swfOXQ1qZes9EaO9LOHHi8YvZZWjPKgqIvU7zcBqCp6mgYZrIsCRJWHPfsAi62oIyTMwwEKD864cqO19MkVhfd0I0bITn/aNdJTYQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789855517; c=relaxed/simple;
	bh=WWERxkPAUPiKK76k58YZ32OHdAtflExTvYNQ0IXSQOI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rP1nMcmwL/1jtf2KENDM7jB8NMtumcRlQPRqo3Brs0DBQgcw9dA0x1+WlUCitEbQ6wO+1DZkKzNJSdMgd2YTNaGMizjN+GuHblemNBOZ46wAkyQR7dvEvGv4gY7zGdpLYv2n9Aw8cqCRkMWpD+xlUd0pjO83FX2zbz4nIkiAReU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzoHyoSq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzoHyoSq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADD071F000FF;
	Sat, 19 Sep 2026 22:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789855516;
	bh=WWERxkPAUPiKK76k58YZ32OHdAtflExTvYNQ0IXSQOI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dzoHyoSqSG47Za8CvS+VgjhTB2CLDcfXxuFp7YmURxNA5ZO8fdo+Qd8C214+g7XrP
	 RR6JEazad/NKQlZ5UI5swA4e1U6G2MOJvQBUGkO+ckhMqjObFz0RalXaCBurwR+yFD
	 0wuG8UdFonYopBC524IE7eNdIsA0XMLyB2op4xQo2a+XwyTqoXHFFOyLj+KuhU1urH
	 1q+WABX5jZ5TuVqB5OI8dv9erWsCGb3cSRhbIW17pn6wUhZ+VcnMZCiGSAuKYqPmVL
	 FiRvs4Hf+2r0QDvKyO7vDdbmKp01xjF43K5ZN0KNWWahDIWg0JbYhZGIBeoJlPoeBb
	 mfkCwpx5FNoBw==
Date: Sat, 19 Sep 2026 15:05:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jianhui Xu <neuromoments@gmail.com>
Subject: Re: [PATCH net-next v12 05/15] ax88179_178a: Add netdev2data()
 convenience function
Message-ID: <20260919150515.400c4de4@kernel.org>
In-Reply-To: <20260916-ax88179a-v12-5-60c04c9924a2@birger-koblitz.de>
References: <20260916-ax88179a-v12-0-60c04c9924a2@birger-koblitz.de>
	<20260916-ax88179a-v12-5-60c04c9924a2@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Sep 2026 05:24:04 +0200 Birger Koblitz wrote:
> Add a convenience function for the ethtool ops that use
> phylink and need to retrieve the ax88179_data structure from
> net_device.

8 loc? just squash it into the patch that needs it..
