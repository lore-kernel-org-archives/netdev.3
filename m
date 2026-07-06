Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C6B2D7BF;
	Mon,  6 Jul 2026 09:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783330967; cv=none; b=Imkg+1bGp3qwODI0rR/1eghG/trzpX/ev3nKdIEL8Qj94kbQypmsXKtaMtN4dwRiSjDIkKGzeqZAKjM+p51GBgVQOUW5UL88c237ckbQP3d0vIPtKSVyju/yEFQJPfaWw851PUod3iH8V47Weu8bRryIpWdj5F3kS2EQ0Hjd6Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783330967; c=relaxed/simple;
	bh=oxYM7OmTLYW2tUoB3STKInz4oHSc9nPtr4q1z8//Ua4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=aaCy0IlFoNVGawzS8q4OHxu2NmCdcyqWZvtEKlApBrC6RefSrasiXJcap3XI7DbsGCMsoDwNzZc+ZEZ5SIuNgLs/QgynUNpRy4Uk7NugdgVDdB6sIh0gGM+oQcV1eS7rJQm06FKySevakE3TGhFLEL8Kao+UiLE1E4FwXmy8edY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=OizCMT3B; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="OizCMT3B"
Received: from smtpclient.apple (119-18-22-158.771216.mel.static.aussiebb.net [119.18.22.158])
	by us.padl.com (Postfix) with ESMTPSA id 7F57D60DA2;
	Mon,  6 Jul 2026 05:42:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1783330954; bh=oxYM7OmTLYW2tUoB3STKInz4oHSc9nPtr4q1z8//Ua4=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=OizCMT3BZgIgQrNEu+/kMtt2CS/Rt7t2eh4H2931fBloU8T6RrYTOoGNoFRx3XPMp
	 zNE/sNxkXOcH7dlLriaXNsTF0QqBoIUfjraokSwqlKVVsBak9XPM27aYV4dWJ7t1Br
	 FztLRYTVD3FewtMvy8K2xzbVdAmxQgZPSHwuiHSAMEGKET2RRuagb+4yxRrwDXULLZ
	 i5NccT/9uZRoQU+MKfV6Ewn03W67VcGAdDbhImlfdQLx4gPd3md/Gy01lWhsz8297y
	 8gYMuYStXKzfdburN1dSuvOevZ92F1fFEJWnyIlDrEi2sd8ixjPgJ87V0mlgZ+JLO8
	 XvnkAmCu6MeoQ==
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH net-next 11/17] net: dsa: mv88e6xxx: Move available stats
 into info structure
From: Luke Howard <lukeh@padl.com>
In-Reply-To: <PH0PR11MB5902B0E9FF059E56C5D6D32BF0F12@PH0PR11MB5902.namprd11.prod.outlook.com>
Date: Mon, 6 Jul 2026 19:42:17 +1000
Cc: Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 Richard Cochran <richardcochran@gmail.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Cedric Jehasse <cedric.jehasse@gmail.com>,
 Max Holtmann <mh@rme-audio.de>,
 Max Hunter <max@huntershome.org>,
 "Tyrrell, Kieran" <kieran@sienda.com>,
 Ryan Wilkins <Ryan.Wilkins@telosalliance.com>,
 Mattias Forsblad <mattias.forsblad@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <19E97EC3-683F-4FEC-89AB-F8CC579F651E@padl.com>
References: <20260703-net-next-mv88e6xxx-rmu-v1-0-991a27d78bca@padl.com>
 <20260703-net-next-mv88e6xxx-rmu-v1-11-991a27d78bca@padl.com>
 <PH0PR11MB5902B0E9FF059E56C5D6D32BF0F12@PH0PR11MB5902.namprd11.prod.outlook.com>
To: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
X-Mailer: Apple Mail (2.3864.600.51.1.1)


> Is everything fine with this patch?
> There's nothing beside adding checks to some of the functions
> (which is reverted in the upcoming patch) what does not
> seem to be corresponding to the commit msg

This (Marvell RMU) patch series has been deferred, I=E2=80=99ll note =
your comments and return to them once the other patch series I have =
submitted have been processed.

Cheers,
Luke=
