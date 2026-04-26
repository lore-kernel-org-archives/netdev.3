Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD4B4315F;
	Sun, 26 Apr 2026 21:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.127.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777239138; cv=none; b=Htqq/LsGoqfcumiUhU1iWRYGehYrNweAVRrwftrj6GScEfr8AjezHstLbhhVaEyKZ+3nLrt77b9SyKEuXi7fnnISKcoD30QsUpFY4OR6+EHxDYpYVwotWU6S9mIH3JvfhbcPTqZi2lW4Pbhl8MdCDhqxqND2fDwhMrloaJ50nik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777239138; c=relaxed/simple;
	bh=Mozgl58LaPmVfSW1ylUeuy7I9/xU3PrplU1x0AXjZUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rVUxWDJjfJnuFQ/8LfbdqjLSWHhQdnpltKZS0ik28zSxLoziVc2qjwEVNhRLfBwluWKgJZ9a0SBNdZnOPZoNlvc31et8alm1cUIoGNB8pfoDvhF0QUjFQAhyiat0MdieEtJ8occir23p02feT97+RwRZIKW+rMVE2awBlyCnzOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=hWZkWXCO; arc=none smtp.client-ip=85.214.127.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b="hWZkWXCO"
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id D9355E83745;
	Sun, 26 Apr 2026 23:25:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1777238739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mozgl58LaPmVfSW1ylUeuy7I9/xU3PrplU1x0AXjZUY=;
	b=hWZkWXCO/agU0cuajkhYAhexstqt4pFk2Pj/YUDvOJhVQBFJo7to2CfHXcBnGfYPqjHpuZ
	cxXMrxxeOZpXLAYijqlTNdbWtfA3isbiTZxYh85M7Dqoxf/QdRqhiUKB/V1n99Xsj7zzE0
	7Nwwbx13uQpj9FfLnM9OOfpV37ZYqIWlEkflUMD226jgBPgah+w4jQfrW0dxZIpz1/ONSn
	aMjDviPiJfQfVFFSQzdaFLsGbhmZJNYD4kr0eWJeXorNN3AIpsPpRy762c7+Q1Gmb4H+UB
	poHt0ZoZ2Fj92sFhHR4R6olLmIGtEqYbOSzRPVwk8ji0iEO1X7ojMtPMy9Azag==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id A66AFrzWQ4TB; Sun, 26 Apr 2026 23:25:39 +0200 (CEST)
Received: from p14sgen5.fritz.box (dslb-002-205-089-102.002.205.pools.vodafone-ip.de [2.205.89.102])
	by szelinsky.de (Postfix) with ESMTPSA;
	Sun, 26 Apr 2026 23:25:39 +0200 (CEST)
From: Carlo Szelinsky <github@szelinsky.de>
To: kory.maincent@bootlin.com
Cc: andrew+netdev@lunn.ch,
	andrew@lunn.ch,
	corey@leavitt.info,
	davem@davemloft.net,
	edumazet@google.com,
	github@szelinsky.de,
	hkallweit1@gmail.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	o.rempel@pengutronix.de,
	pabeni@redhat.com
Subject: Re: [PATCH RFC net-next 0/4] net: pse-pd: decouple controller lookup from MDIO probe
Date: Sun, 26 Apr 2026 23:25:08 +0200
Message-ID: <20260426212508.110300-1-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260424144124.131837c7@kmaincent-XPS-13-7390>
References: <20260424144124.131837c7@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hey,
Thanks for all the help from multiple guys :-) I am currently busy with work, but I will take some time soon!
cheers Carlo
