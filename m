Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB2D21771B;
	Sat, 21 Mar 2026 05:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774070338; cv=none; b=rBUWe8vVY5FH/ApIeh8xlIaSNgqFl0fc0QOn5QzLNft61gww45uqJEoqR0KxdcatNBEkbrjXuow7m1kQrHmnojb+DukTDpFEmE0/kXUiYcGe38Da08jnLPJ39iPpOjun/flUkAAbiOZGXySl72yWyrUB2yrDoTF6DrR3ghsoV4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774070338; c=relaxed/simple;
	bh=UlFuD3WWB7p8FsO2w2sAK1CKIRQVQhSq4bpJlI/ImN4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oHYlDgD831DHXHuwUQ1aCbbPJYIcpTiePK+GD+/VO8jJZuAWFCifZfCJmGmEv8BrdkgvuERzGzESb8xXmPPk8ZwIQjSLFRnnRDdR7jrt66M4Ggbz/l/C4PK5Vk0kZjmmDx/GAogqPxzjFFDxyxRPGuumxzFQ/JD8VVqluXRnjIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1w3ojZ-000000006vY-1Z9p;
	Sat, 21 Mar 2026 05:18:49 +0000
Date: Sat, 21 Mar 2026 05:18:46 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Frank Wunderlich <frankwu@gmx.de>, Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Liang Xu <lxu@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	Jose Maria Verdu Munoz <jverdu@maxlinear.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: [PATCH net-next 0/2] net: dsa: mxl862xx: MDIO bus integrity and
 optimization
Message-ID: <cover.1774070039.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The MxL862xx firmware offers opt-in CRC validation on the MDIO/MMD
command interface to guard against bit errors on the bus.
The driver has not used this until now.

This series enables CRC protection on both the command registers (CRC-6)
and data payloads (CRC-16), and reduces MDIO bus traffic by bulk-zeroing
registers instead of writing zero-valued words individually.

Daniel Golle (2):
  net: dsa: mxl862xx: add CRC for MDIO communication
  net: dsa: mxl862xx: use RST_DATA to skip writing zero words

 drivers/net/dsa/mxl862xx/Kconfig         |   1 +
 drivers/net/dsa/mxl862xx/mxl862xx-host.c | 365 ++++++++++++++++++-----
 2 files changed, 297 insertions(+), 69 deletions(-)

-- 
2.53.0
