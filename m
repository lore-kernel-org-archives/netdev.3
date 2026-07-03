Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD32E1F94F;
	Fri,  3 Jul 2026 07:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783063836; cv=none; b=Z0mzIAleaITU0Q1qhSlwg9B+c7AV998J9Kcv2L4PhJyBMMnsOZ88U8gqrTjLkAssKZo9jmLGnmC7T4QypWQS/NveekpQUoZgjR2wf+A3EbRcfuB7Q9yiT6qPT3Rb6R8yutV6ZakRMwMwvb5wsD2Gn7yHdjpq/ZaCDzgOEogy2qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783063836; c=relaxed/simple;
	bh=Sg57Y3RsGSQ9VeT2zdNx29l3HPEg8/4X6UrXDda1gwg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fH3ONmTu4a2OzQZ0oyId9DYKJB1BhM27GbYyhF6mNmg2ZoKWx5KqQagsz7q0zCTRu0LonYPqmhmfczfntm9JloDh6pREcD8j4eCBjmGGFDncecJZK0hCAEUXokK8d/5mW5nY7CPjwhp7TjGOmeAijAKECMUnfoaAKYMcmC86qKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=krvueJcw; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="krvueJcw"
Received: from [127.0.1.1] (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id 7234B60C04;
	Fri,  3 Jul 2026 03:30:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1783063833; bh=AXWe9CQxKe73JQ1zA5cOJDEo/PIXtcg7nVYL/NokWrk=;
	h=From:Subject:Date:To:Cc:From;
	b=krvueJcwP0OhMbMHq41/IoM30lrxH9497qlK546HGhgtbrL1zy8BWCypsNc0NJnch
	 QtugAULTHW910wSO7qa5gf1BaFVVJ/EZYvBKJ5gl6+h3BJnNeJVanyIxg/Ah3JwuLf
	 IPKmQIxQOKrK8hEqCCuGb+Z7L/+otrB6Yyv7xw8JFMSigc8uXqKNIF8Utuk7MTSJ1f
	 gs9i8Zy+uzEfLTLxlmCS6owqImjvybxljz2UIOvBR+92rTkF0rYGQyqDG5JH7lISt4
	 839i5+EBFSrgsHWa2zXca8jHzMbBeUMGzFpXVj4jjiqDw/0gg5TjRTUtVSMt0AoqWp
	 UatpC+DGffY6g==
From: Luke Howard <lukeh@padl.com>
Subject: [PATCH net-next 00/12] net: dsa: support for inband management of
 switches
Date: Fri, 03 Jul 2026 17:30:19 +1000
Message-Id: <20260703-net-next-dsa-rmu-v1-0-a03febf20bb4@padl.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAtlR2oC/zWMwQrCMBBEf6XM2YUkYCn+injIplu7glGyqRRK/
 92oeJjDY2beBpOiYjh1G4q81PSRG/hDhzTHfBXSsTGCC73rfaAstWWtNFqkcl/omJjd5F3kgdF
 uzyKTrl/lGf81Lr/GFr5Jqh8j9v0NCTOh1H4AAAA=
X-Change-ID: 20260612-net-next-dsa-rmu-5cbb0f10ab8b
To: Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Vivien Didelot <vivien.didelot@gmail.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, Andrew Lunn <andrew@lunn.ch>, 
 Simon Horman <horms@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, 
 Tobias Waldekranz <tobias@waldekranz.com>
Cc: Cedric Jehasse <cedric.jehasse@gmail.com>, 
 Kieran Tyrrell <kieran@sienda.com>, Max Holtmann <mh@rme-audio.de>, 
 Max Hunter <max@huntershome.org>, 
 Christoph Mellauner <christoph.mellauner@joyned.at>, 
 Simon Gapp <simon.gapp@gapp-audio.com>, 
 Ryan Wilkins <Ryan.Wilkins@telosalliance.com>, 
 Mattias Forsblad <mattias.forsblad@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luke Howard <lukeh@padl.com>, 
 Christian Marangi <ansuelsmth@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783063828; l=2254;
 i=lukeh@padl.com; s=20260701; h=from:subject:message-id;
 bh=Sg57Y3RsGSQ9VeT2zdNx29l3HPEg8/4X6UrXDda1gwg=;
 b=5nFQiZQwnuVo4N/MPAz0QxTsKOqNqzmB2nU2oNkBtMuj3FQU1KZ0hvzx/Jy48boY8ba3PHrWR
 L5lTURu2G6tDCkqA7WKTscrY07fu1isztP+fiYpXCF+TK7vOKchUX/M
X-Developer-Key: i=lukeh@padl.com; a=ed25519;
 pk=D6YgUnH9/OzSZsduYm9XDbvXn1IHDwKwI1hLTsKNRLw=

This patch set shephards a series of commits made by Andrew Lunn
and others to support inband management of DSA switches. [1]

Specifically, it allows the switch itself to be managed using
DSA tagged frames instead of MDIO. MDIO is typically required
to enable inband management. An implementation is included for
the qca8k driver.

This is patch set one of four: the remaining sets add support
for the Remote Management Unit (RMU) in the mv88e6xxx, and then
general and mv88e6xxx support for "inband-only" mode where MDIO
is unavailable on the hardware.

Note: the patch to validate the source trunk against lags_len
was previously submitted and rejected, but I am including it as
the issue has been triggered when running in inband mode.

[1] https://github.com/lunn/linux/tree/v6.15-rc2-next-next-inband

Signed-off-by: Luke Howard <lukeh@padl.com>
---
Andrew Lunn (10):
      net: dsa: qca8k: Move register access completion into DSA core
      net: dsa: qca8K: Move queuing for request frame into the core
      net: dsa: qca8k: dsa_inband_request: More normal return values
      net: dsa: qca8k: Drop replies with wrong sequence numbers
      net: dsa: qca8k: Move request sequence number handling into core
      net: dsa: qca8k: Refactor sequence number mismatch to use error code
      net: dsa: qca8k: Pass error code from reply decoder to requester
      net: dsa: qca8k: Update error handling
      net: dsa: qca8k: Move inband mutex into DSA core
      net: dsa: Add helper to find ds_switch by index

Christian Marangi (1):
      net: dsa: qca8k: drop redundant mgmt_eth_data

Luke Howard (1):
      net: dsa: validate source trunk against lags_len

 drivers/net/dsa/qca/qca8k-8xxx.c   | 238 +++++++++----------------------------
 drivers/net/dsa/qca/qca8k-common.c |   2 +-
 drivers/net/dsa/qca/qca8k.h        |  12 +-
 include/net/dsa.h                  |  36 ++++++
 net/dsa/dsa.c                      | 109 +++++++++++++++++
 net/dsa/tag.h                      |  14 +++
 6 files changed, 220 insertions(+), 191 deletions(-)
---
base-commit: 2bb62a85aff6d4c14a62a476dfabaada3c1cc014
change-id: 20260612-net-next-dsa-rmu-5cbb0f10ab8b

Best regards,
--  
Luke Howard <lukeh@padl.com>

