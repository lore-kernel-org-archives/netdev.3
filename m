Received: from mail.avm.de (mail.avm.de [212.42.244.119])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E059338E121;
	Thu,  2 Jul 2026 06:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782975442; cv=none; b=XSEmLTaPbYmaAALL5RlR4Nu9GOF8fDJlLYk2jypTJCuB4E+RhmvNr4vXto3Rch/pcTPSSQuTQh8qZGhgFDR+z5McdBSrhwVLm6pAiMss0qjO6Wend+/Z1A/CyS7kte9rdauMJNkBUR+G3C8k0eCZmLyc2B+I5gK3CFfZgt2m/iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782975442; c=relaxed/simple;
	bh=IrFLQF1aDx2NJKTYXCLYtxDdYa/7wJ+NTe+JltQynXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eMEIDqJ83zk6DXt5kWWpwHijlQ6QhxRbJhNvVL+yYTQrAcNXDqGQZffzx3cTRcqgRk9dPh/chq2aknPoVrMv0LHkBUqL+8nEPHgQ8Lnx9/yl+2UUBbUEMKk6bh9bS8oONPJ/RVU/qjl7TORkhsUW7bWWj6EUnGxvja1/lpcGadU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fritz.com; spf=pass smtp.mailfrom=fritz.com; arc=none smtp.client-ip=212.42.244.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fritz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fritz.com
Received: from [212.42.244.71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.56.1)
	(envelope-from <t.martitz@fritz.com>)
	id 6a460bbd-a25b-7f0000032729-7f000001aea6-1
	for <multiple-recipients>; Thu, 02 Jul 2026 08:57:01 +0200
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
	by mail.avm.de (Postfix) with ESMTPS;
	Thu,  2 Jul 2026 08:57:01 +0200 (CEST)
From: Thomas Martitz <t.martitz@fritz.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Thomas Martitz <t.martitz@fritz.com>,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH RESEND RFC 0/1] macvlan: allow source mode devices along with passthru 
Date: Thu,  2 Jul 2026 08:56:38 +0200
Message-ID: <20260702065642.1783764-1-t.martitz@fritz.com>
In-Reply-To: <20260612092345.2352255-1-t.martitz@fritz.com>
References: <20260612092345.2352255-1-t.martitz@fritz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-purgate-ID: 149429::1782975421-BAF71F7F-BAC1EEF6/0/0
X-purgate-type: clean
X-purgate-size: 1636
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean

Hello,

we're trying to solve a use case on our devices where two SoC
are connected on the same board, using the only available high-speed.

One SoC runs the main Linux system including the full routing stack
(FRITZ!OS) and the other SoC implements most of the GPON ONT side.

The high-speed interface is of course also used for the user traffic.
Therefore we must tell the inter-SoC traffic apart from the user traffic.

We achieve this by matching the well-known MAC address of the ONT SoC.
The user traffic passes through the ONT SoC without modifying MAC headers.
Now we would like to use macvlan (with source mode devices) on the main
SoC side for this but our routing stack requires the rx_handler to be
available. Therefore macvlan is currently not an option.

With this patch macvlan becomes an option because the current limitation
of either "one passthru device" or "any other configuration" is relaxed
for the combination of passthru and any number of source mode devices.

This allows us to configure a source mode device for the other SoC and
register an rx_handler for further processing on the passthru device.

The patch is still in an RFC state. I am not 100% confident that all the
cases where the code checks "macvlan_passthru(port)" are handled
appropriately. I hope you can guide me a little bit and provide feedback
on the general approach.

Thanks in advance!

Thomas Martitz (1):
  macvlan: allow source mode devices along with passthru

 drivers/net/macvlan.c | 41 ++++++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 13 deletions(-)

-- 
2.54.0

