Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B0D32860F;
	Sun, 22 Mar 2026 13:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774186054; cv=none; b=JF1mF4psOjYUxz4VezGZf0YUnch2e1u3jfPgXbt/wNC2OwkndHvN5f1J40T6clRXBGje239x6bcO2vmKpnJT/hFf4AP7dP4HDGH/B5IiqPeTqhKb4NxYFZPv3eu9QhHvioGZUDWJwlXEr1nBet4R+j1w6XS1SffjD76Qa0EAnVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774186054; c=relaxed/simple;
	bh=nt//FjBXwg0cKPku85CuxvPCjBJ6K1Jp4yFVs2d2qK4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qrTEEtFSpMMyeT0B9rtIytd6pb9A1BBvcUz7wtCHRSTjNEc9aDBR6pVO3PwG5AHRv0AayupjmpORVtikRek7hqBbOWTHQ6CRVxkrNL8s+8pgoZFqQ+85yR53YNT48HXdLF+WLYiejCFfma40LY1BKGr5MZRdcaMwLwJNYO8abw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1w4Ipn-0000000031S-3SgA;
	Sun, 22 Mar 2026 13:27:15 +0000
Date: Sun, 22 Mar 2026 13:27:12 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Frank Wunderlich <frankwu@gmx.de>, Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Liang Xu <lxu@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	Jose Maria Verdu Munoz <jverdu@maxlinear.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: [PATCH net-next v2 0/2] net: dsa: mxl862xx: MDIO bus integrity and
 optimization
Message-ID: <cover.1774185953.git.daniel@makrotopia.org>
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

Changes since initial submittions:
 * trigger worker which takes down all ports in case of a CRC error

Daniel Golle (2):
  net: dsa: mxl862xx: add CRC for MDIO communication
  net: dsa: mxl862xx: use RST_DATA to skip writing zero words

 drivers/net/dsa/mxl862xx/Kconfig         |   1 +
 drivers/net/dsa/mxl862xx/mxl862xx-host.c | 377 +++++++++++++++++++----
 drivers/net/dsa/mxl862xx/mxl862xx-host.h |   2 +
 drivers/net/dsa/mxl862xx/mxl862xx.c      |  11 +
 drivers/net/dsa/mxl862xx/mxl862xx.h      |   2 +
 5 files changed, 331 insertions(+), 62 deletions(-)

-- 
2.53.0
