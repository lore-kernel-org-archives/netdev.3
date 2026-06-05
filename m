Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC9D257ACF;
	Fri,  5 Jun 2026 01:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780622099; cv=none; b=I0BVNS+u/bKeiO2530Af6mBi1vs0LGNFyjKSmQdrEqifPoPhi4ZaGTpRPKj0Euln97Dv5PNbHTxGa1cLSt7wNbGA+UNOZu8Jf5xklmwFw99TvuB5FMmsR0fvBAOBW3mKPC2r85GMK4ssoOYQyrFnAOctVR7m7DH/WdDBGbvS1bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780622099; c=relaxed/simple;
	bh=IMW3mHULA84ZynJMv7Y8ZwXydunw+vSaSoGi95or450=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=GSeoVC/FmTX/agVJJVRrXxkc/F48tBJwsvzS56X6qZFkQjDvnemt9TLRSUv9RRlAGEMjIUw8XkNzEadek5cY1ZNRRlpRiTZdVV3dvSk9x4VPh6Qyjo8ji4OQZ81eC/buqUNA4tENCawznMUOyZk16NqFGDMDAqZykuVQSfXjrX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=b2bRTMMo; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="b2bRTMMo"
Received: from smtpclient.apple (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id AF1F26221C;
	Thu,  4 Jun 2026 21:14:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1780622097; bh=IMW3mHULA84ZynJMv7Y8ZwXydunw+vSaSoGi95or450=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=b2bRTMMo6X1DMnuHcO5lRpNqSqEIrDxMotKpNz67FppHjhDZO5ZAAbqCnTReP5Q7J
	 SZZIKQ8lKCUJAHJ/GlFAXnwnzJAkf6VmENZ18WzZCPNMKvwNOKvBoAFFAb1MZrCDch
	 yW15klybX4M5lkHs9ItH8vq5ehjZzD06LIEsMRCEt/Bz7yj+RpUnL19NNHQ00H22dR
	 C92TzmslW0suhUdFfM1g9Plf1zcqwOtSRffcL2giB7lQoLyfl4qYiOlnHGyMwriqc6
	 7KfOWdvQYW0E9Z0hsEdx9Y3U+zE7mrqjj/VIrKzvPLc/TTkuMMECHiPoiTAOHS05q+
	 4WJD4dTpgktlg==
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH net-next 0/2] net: dsa: mv88e6xxx: add support for dcb pcp
 app
From: Luke Howard <lukeh@padl.com>
In-Reply-To: <20260604-net-next-mv88e6xxx-pcp-prio-v1-0-f9d10fe6cdc8@luminex.be>
Date: Fri, 5 Jun 2026 11:14:44 +1000
Cc: Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Cedric Jehasse <cedric.jehasse@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D81590F2-DB4A-41CF-9884-1B6AFC752CED@padl.com>
References: <20260604-net-next-mv88e6xxx-pcp-prio-v1-0-f9d10fe6cdc8@luminex.be>
To: cedric.jehasse@luminex.be
X-Mailer: Apple Mail (2.3826.700.81)



> On 4 Jun 2026, at 6:30=E2=80=AFpm, Cedric Jehasse via B4 Relay =
<devnull+cedric.jehasse.luminex.be@kernel.org> wrote:
>=20
> This patch series adds support for dcb pcp app to the mv88e6xxx
> driver. The pcp app is there to configure pcp based queue
> classification.

Somehow these patches didn=E2=80=99t arrive in my inbox, but (looking on =
lore) they all LGTM.

The only comments I had:

- whether you might use IEEE_8021Q_MAX_PRIORITIES instead of 8 (this =
requires importing dcbnl.h though)
- the user might infer the =E2=80=98prio=E2=80=99 parameter name means =
we are remapping frame priorities rather than assigning to a queue. =
Perhaps it could have a different name?

Luke=
