Received: from mail.avm.de (mail.avm.de [212.42.244.120])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1341C3E9C3C;
	Thu,  9 Jul 2026 09:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783588337; cv=none; b=RU+4a0x5U7reo8SJy3txM75RPP5ebvOgAvRoPRfOgHEdrQE/qVDaebnJcALW6a4KxSNJUdx+FTVGFwb4687xBHSu4PdZTTkqPd3/VeZIjRrTliQY67vpamrbmXD10K7nQZ6BQAQMyuS8YB2wSvNhgw4zSel3GWHbIG8jAIjmooE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783588337; c=relaxed/simple;
	bh=JBpBYDM9N+b1sEVvONgcjDT5IAD4DhOvZ0rfYcrdIAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KOwofoVMaLBmrvoC62tjBHpzGVXZgjWBgt0voXrGIeMitSBqf9eE3TTfhhVS1t1SPchWgZDZf+g6E3ytfXXWA5vwT7eiGypyJxjw5HByWF+4zG3ZvO5Jh6/c+rLd8mPWq4BO23zwlmzhZRwnmFIWWG61NzYJo7WRRaOjGGWP7K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fritz.com; spf=pass smtp.mailfrom=fritz.com; arc=none smtp.client-ip=212.42.244.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fritz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fritz.com
Received: from [212.42.244.71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.57.1)
	(envelope-from <t.martitz@fritz.com>)
	id 6a4f65ec-7cb1-7f0000032729-7f0000019a28-1
	for <multiple-recipients>; Thu, 09 Jul 2026 11:12:12 +0200
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
	by mail.avm.de (Postfix) with ESMTPS;
	Thu,  9 Jul 2026 11:12:12 +0200 (CEST)
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
Date: Thu,  9 Jul 2026 11:11:36 +0200
Message-ID: <20260709091138.170348-1-t.martitz@fritz.com>
In-Reply-To: <20260702065642.1783764-1-t.martitz@fritz.com>
References: <20260702065642.1783764-1-t.martitz@fritz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-purgate-ID: 149429::1783588332-7DEB61B0-6D5525B3/0/0
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

