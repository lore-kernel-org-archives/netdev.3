Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AECE3B4EBD
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 05:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785217882; cv=none; b=IOpWDHIkWA0MOmGKYtz1aEBhPzVhmxK9vSLkZKnA9ylQ9aTfE375qJC3borl5Ah1SmudEizm3pE3QvdT7vTb+aZXTVgt+YZP3OSo0KgxpagH4ag7apx0rVb/8b1Nh9VtQrBmzUCEzRchPuIM0dPvpVo7xFiQ0x7J3V4ZILr9e+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785217882; c=relaxed/simple;
	bh=swGq6OraSGtll0qK3hgE5/IpN1LeU1bZM5RBzwhlMXQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=QR71IBGzWhPYLiGNd3d4Wcx8P9qqtpirj9Jly0NQG8MT8ADB7wbQgVQ2qGhvd0e66J1LZqLTnxZyp92lS7MvJfgJE9EUAZu1q0l/n3F5vWhu/rqFqW6DTGlADc/sHI28WowiVTHa0fu8EcIaZKGAFG3FDInp5BYx2fZmgy/9H5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=QuTXSIQ3; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="QuTXSIQ3"
Received: from smtpclient.apple (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id 2C2DB60964;
	Tue, 28 Jul 2026 01:51:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1785217871; bh=swGq6OraSGtll0qK3hgE5/IpN1LeU1bZM5RBzwhlMXQ=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=QuTXSIQ3Xq/aYQGaDHlRrXeRJ1ARuVvM1IUjnXREBnzvv1oHo/B583PR+xtuZjoqf
	 gsNN2etc9CbXtqeYDBWIiEN4amRE5UUB+uNcLhViRYbv8VqNGBDFudsiwwdYzu07I+
	 FDHZkNstSWLlcC5bF1fVZ8etFMqo53knVbrIz1HpitsVlnFM/18vfs+WIppTF8yQZx
	 My6Oe50o9HmSTg3jfENtyXXuKFhLtZZK0Qdp31b/brvQaB0MYfhFCQShdOg+BtpZHf
	 dKyMT8lPKvYmhBoaac2eE7Jy7Nsi0UDXPrAp1bl5YydkIT5w1enQZW3qRiMYii+6LJ
	 ++OIoX/J64CmQ==
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH net-next v4 1/5] net: dsa: mv88e6xxx: only time stamp
 PTPv2 frames
From: Luke Howard <lukeh@padl.com>
In-Reply-To: <20260728035958.951161F00A3A@smtp.kernel.org>
Date: Tue, 28 Jul 2026 15:50:55 +1000
Cc: robh@kernel.org,
 netdev@vger.kernel.org,
 Vladimir Oltean <olteanv@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>,
 Richard Cochran <richardcochran@gmail.com>,
 Cedric Jehasse <cedric.jehasse@gmail.com>,
 Kieran Tyrrell <kieran@sienda.com>,
 Max Holtmann <mh@rme-audio.de>,
 Max Hunter <max@huntershome.org>,
 Christoph Mellauner <christoph.mellauner@joyned.at>,
 Simon Gapp <simon.gapp@gapp-audio.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FCEF80BF-B088-4348-9377-A2ECAAD6B4CC@padl.com>
References: <20260727-mv88e6xxx-ptp-fixes-v4-0-10b4020155fc@padl.com>
 <20260727-mv88e6xxx-ptp-fixes-v4-1-10b4020155fc@padl.com>
 <20260728035958.951161F00A3A@smtp.kernel.org>
To: sashiko-reviews@lists.linux.dev
X-Mailer: Apple Mail (2.3864.600.51.1.1)


> [Severity: High]
> This isn't a bug introduced by this patch, but does ptp_parse_header()
> guarantee that the returned header is in the linear region of the skb?

This is a pre-existing bug shared by every caller of ptp_parse_header().

> [Severity: High]
> This is another pre-existing issue, but does using the
> MV88E6XXX_HWTSTAMP_ENABLED bit flag provide adequate synchronization?

Worst case is a timestamp request being dropped mid-reconfiguration. I =
don=E2=80=99t think this is worth addressing.

Luke=
