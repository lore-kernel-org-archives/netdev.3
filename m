Received: from mail.avm.de (mail.avm.de [212.42.244.120])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA633F20F4;
	Thu,  9 Jul 2026 10:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783591559; cv=none; b=okZf6Ef4YXlXjPHeS1bIE79uFAZPS5rg6bdKgpTc9mpwMNpem8LsIcNbnFfXT7kkMxWNKpIzbMaNhRR+ZsbvNBSXqzmNOFvsQXDOQ7BaAPtG4h7N1ReO4k5Sx5xzI631bP7m4ii1oaqBQP2T1MJvrtwm9T9IYmOmD6pPJlpTuF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783591559; c=relaxed/simple;
	bh=JBpBYDM9N+b1sEVvONgcjDT5IAD4DhOvZ0rfYcrdIAI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mflmZpPqrAexlDJ8cRcvVwQvPY1HXJ56QUVWczIEzDYVww3zQRKxQeWXW4xH/lVRSPLge0QVGEa+M25Q0VlMSDs06UwpAmleFLm5rRaMN37GJKFTqcXLAHTxAEdmHx+c4XkmHd8eEpq1po6l/cjpoV4Ch561IIyc+shfkNNy8Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fritz.com; spf=pass smtp.mailfrom=fritz.com; arc=none smtp.client-ip=212.42.244.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fritz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fritz.com
Received: from [2001:bf0:244:244::71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.57.1)
	(envelope-from <t.martitz@fritz.com>)
	id 6a4f7281-7cb1-7f0000032729-7f000001ec3a-1
	for <multiple-recipients>; Thu, 09 Jul 2026 12:05:53 +0200
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [IPv6:2001:bf0:244:244::71])
	by mail.avm.de (Postfix) with ESMTPS;
	Thu,  9 Jul 2026 12:05:53 +0200 (CEST)
From: Thomas Martitz <t.martitz@fritz.com>
To: Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Thomas Martitz <t.martitz@fritz.com>,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 0/1] macvlan: allow source mode devices along with passthru
Date: Thu,  9 Jul 2026 12:05:10 +0200
Message-ID: <20260709100512.1383421-1-t.martitz@fritz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-purgate-ID: 149429::1783591553-DE6AD1B0-19EA7216/0/0
X-purgate-type: clean
X-purgate-size: 1406
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean

Hello,

we're trying to solve a use case on our devices where two SoC are
connected on the same board, using the only available high-speed interface.

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

Thanks in advance!

Thomas Martitz (1):
  macvlan: allow source mode devices along with passthru

 drivers/net/macvlan.c | 107 ++++++++++++++++++++++++++++--------------
 1 file changed, 73 insertions(+), 34 deletions(-)

-- 
2.54.0

