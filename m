Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B05D331A6D;
	Thu, 28 May 2026 06:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779949711; cv=none; b=gptvW8Z9ppkraxIUsPt4DDjTM4JnaZJ9+NnFRS5sFedKS/sblfVg9ZoKMd/0+Qnq5fEPOCyeMIdOj+8dGCFbnvaJ32mVW9bdlZ0zUyorbbeJ0kzWsV8jbV8KDhERjs6J8CGgu+4c30IYMy2B+XkBM1CKnJxgmF3ev75KRnY/zD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779949711; c=relaxed/simple;
	bh=l2v49YmcllRcfHVL5TLGQFYdscegvWaOv8FZyDzTfB8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=NQvMpCgm+7bNt2T8z62d3TvqjW1ycTYtewk20IfaZ3I2FjEpEbBhVG4GCcUq3a+WT5Vd1mLCliGNTgAKKIZz4ejCSQpMoOgkstPIZ1JAx50RlfdijQWr/rxdth+iY7qA7zb27ZKfaMuO+V2PEMQQbe60V6MApPsEBsgZJS24JE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=CKyn5DlS; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="CKyn5DlS"
Received: from auth (localhost [127.0.0.1]) by us.padl.com (8.14.7/8.14.7) with ESMTP id 64S6RjX6016542
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 28 May 2026 07:27:48 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 us.padl.com 64S6RjX6016542
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1779949671; bh=ihRuRsFu6g8bViSLMgUrlEZVaOEOh72i2B5DEottp60=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=CKyn5DlSWOyAAgTpKalRo8ntP0go5goIqo2IAbnWMRQRotJSoUlxSoc2/m5cUyHpU
	 v9m4u1E2Kd7Y6UYK1qU2+Jwue/OoJS++GjgmBuYsCgEAaR5E1xyNsQ7H1wLu62nsTI
	 x9daAtTfU8dItfu8io8RBJvjkKUUi9TeAMM4GXFOSWjPnMxzmyMM6ngg+WkFAesIU3
	 ewJlMgbwJnHKbgKwX4FRmBdV+VQ56MekiFi66L3UUF3ZssBbQnEcHUM/RhMpyf9uPB
	 0m/GzcZoGbI1uMrnajahrbcZ7eiaQ0X4nPXzFHTqH6+lTL5jfJbyd5x6eSFJaNJa0j
	 TPkw4WHR9JNsA==
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH net-next v3 2/2] net: dsa: mv88e6xxx: add support for
 credit based shaper
From: Luke Howard <lukeh@padl.com>
In-Reply-To: <20260527-net-next-mv88e6xxx-cbs-v3-2-2f387eb5ff63@luminex.be>
Date: Thu, 28 May 2026 16:27:35 +1000
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
        Cedric Jehasse <cedric.jehasse@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <31F2127F-685B-4409-BF0E-21CB378B2CD6@padl.com>
References: <20260527-net-next-mv88e6xxx-cbs-v3-0-2f387eb5ff63@luminex.be>
 <20260527-net-next-mv88e6xxx-cbs-v3-2-2f387eb5ff63@luminex.be>
To: cedric.jehasse@luminex.be
X-Mailer: Apple Mail (2.3826.700.81)

Hi Cedric,

One further comment: the Marvell DSDT reference implementation (GPLv2) =
also sets an undocumented register on the 6352 family of switches to =
enable CBS. (This does not apply to the 6390 family.)

My understanding is that you should call =
mv88e6xxx_port_qav_read(MV88E6352_PORT_QAV_CFG) and then set or unset =
MV88E6352_PORT_QAV_CFG_ENABLE accordingly.

The values are given below:

#define MV88E6352_PORT_QAV_CFG                    0x08
#define MV88E6352_PORT_QAV_CFG_ENABLE             0x8000

Apologies that my previous comments were against an older version of =
your patch series; however, I believe they are still relevant.

Cheers,
Luke=
