Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793545023;
	b=gliLfId4kBy1EvQYkN0sFzJCNFqVR2Oj1NwKAQ1E+pT+qwKym/ZayaaqPcd4F1bhTq9q
	 gRSUafjQwXW96XxBJHLId/kFOjzFjDqvaA4pWnTkUv2BuCN6eutOJYMu50AK3fb4JfrXh
	 X1xoOmKuFuqioalHLqH1lUhXqcIJRxKUK4iQgSKJyuxmNJfY5ljQekdJmjBpIFqpYTXxY
	 HOU7WfJ3mPUpfKnNzrtJn3apWQWUuHCptJHJQveEQLzsToQHknA0uv3rWMrtaWQDofdox
	 UTYtmvYqzdrWPwfHEHz2fwPS0xGyxHBrJCOh2nr+tl3WUPFBpqCEcp+CT61QOEehr7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793545023;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=L5lhL2beYV7BhyhbK9ACbFrNrJXtxDi/4b3LA9oMRFA=;
	b=Zqc+XltOH48ECRyMRDr0q0Y99B2P16DtXdBBOOxSNCwO5EkkkiJ1chktk2ft8ErEaCEO
	 bmQcxv1jSTNrXFo2+eUr5hKlMAOVvba3gPqyeHz9HOyeHE+vDZFACQJt5OPC0Y2nCKXa7
	 0OdCWQMdAX+3u0NeYnweR6SLpXwy844NH11M5PCvyHMz76qfUFgtrYMKbgxoc/x5GfRBQ
	 XmEF/cAkz0i1VhBnh08rBEIeufANojHy+I6xJXDN8PLjt6PcvNg1Xgm5cP3LJEgEyWFuh
	 J5DPE0/tg43B6U4JYZIfxr8dcEuW2mN/n5Euxk2rmu20G6zZ4XRdkeHcBeRMZn8TEKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QILQC8FE;
	arc=none smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB90606A325
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 14:57:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BB90606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QILQC8FE
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6acb57c2b88so2784744a12.2
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 06:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793545021; x=1794149821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=L5lhL2beYV7BhyhbK9ACbFrNrJXtxDi/4b3LA9oMRFA=;
        b=QILQC8FE1WP2+aAvEV5glCxGnqssHHiRDH4Bu+bW8/rLzjezvWaIscoeNvwWY0XwtV
         sWHqhXZPQ7neMkYKtck2VSHZNgGryHhvszLlcaHpX0eKJG6x3qHlVq9spSPe2Eil1bUU
         ypGY9bWkGdrR8srF791MX7a7V0FS9IIiPee37U+7B6IWG4XhsP9cp10JcNJ/9+wFWwU7
         M8jGKwrD9Lpywn53jH4enEhA23ZsaSkSfLkffVHQyYINkGxF+Ur6zXpiBpUN/DV2Fd6s
         F0lDxNiSGF3vi/jU/N0VwGR+acvhKAnc6eL9NLSuuBxEyCrXlfBU7OUqVeW8AYRX5yRO
         9P+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793545021; x=1794149821;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L5lhL2beYV7BhyhbK9ACbFrNrJXtxDi/4b3LA9oMRFA=;
        b=VaeFctq2XE5JJKncDw7wtJYuUQq8KHpd+AYpelNtGijPH0ROOjo6JkAPHkWbSJuoHx
         OYkTEBYaq2BrDMipZLi4RJX0+IdKMsdGKQf+zvrVLPpyEn/vrduCnTjW7xgFxW/+ZbCF
         DX4QlpDbAip1gxfPDolV6XqIQz/qfHCZGKqeaMDEVcBSiicvsYDLzsUqzNxyDHEzruNA
         plQR/aanaT6hFpB1Gv7Y3tch6XkmTFF/E3JoIusIUXmD07RZpu1mHEBZADyUQaNPb2zN
         JGqMxxMgZ8JPIm13YejNRscU8Nf9bhyWcM0+HiDbyQRZ5VEiiyf/3hF6QOxQ8pP2sDea
         f5xA==
X-Gm-Message-State: APuU4Z/GPE8kB02t6iSRW4MqPGjvYgjKpnEL28AziupbBvE2u07vk3+R
	quMwB2HTpC8BI0MT4dvH1vCFxq5ApCWbdwvujBcL8vjqsNLtWTevMh5CWG8gSg==
X-Gm-Gg: AYBFou3h8Wr5YMTsvidq1rlm0sBCDKRYTjNSO/5FGlTxnHVHxN0Ilj7jXGjacNgYZX/
	5GYjqzTcTVox/7yGMVcF6Kf+YxY6OV1g6FqUPtZFINrXk5+Athly4R5zGtgqx0e9xARwVdDVdLW
	d0ohtX5jegFTPrp2Nzrdh41bQzWPLA0v5aSvCh2XxC63f2aQCbs62k+Vv56qqMx1z9hIIhaVulS
	24lXlSklDKA5TPMrHA7+N8ov4ZE2nutd7ZsmFDO4CRF/ufJ4M88OAp8K53mPIXiDlOzkfLMPT4a
	pwBb+2LDJD3xjEhmInDuGvX3ggsfyOVikKwr/daGpq54m7bPCg/RcRgTk4vfQboTT6ezGbPivyQ
	7hL44MY7jNWZ03HtD79HKoaRzmRv6BT99tEvoReXyojgyDrAprhcJuesMHktuHnsWj8rINGL5aE
	lxUyWhiyJLwISmeHwrfKOhVyWs0b692IVRavA75OwYGcVdUIEoZv7mEb6wXb4H51/A5YxcAesUF
	C1YCdO2GGUhbsYvEiejxo6T5CCjXb+Hdb9BpB4b4hLZBj7tGgG8haNqqlAtaxJt5ubQFfJw/u1n
	9GOTOjScFhA1Uj7aIyx6YRzbtBYEDaAXIkQ+N67T0zNO
X-Received: by 2002:a05:6402:a50b:10b0:6b4:27a:38f7 with SMTP id 4fb4d7f45d1cf-6b4d46841c0mr3541426a12.22.1793545021117;
        Sun, 01 Nov 2026 06:57:01 -0800 (PST)
Received: from stukan.bbrouter ([46.201.91.224])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b4ec9ee975sm2166587a12.13.2026.11.01.06.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 06:56:59 -0800 (PST)
From: Timur Stukan <timur.stukan.linux@gmail.com>
To: netdev@vger.kernel.org
Cc: Hangbin Liu <hangbin.liu@linux.dev>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Timur Stukan <timur.stukan.linux@gmail.com>,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jarod Wilson <jarod@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] bonding: 3ad: don't set BOND_LINK_FAIL on a slave that is not up
Date: Sun,  1 Nov 2026 16:56:53 +0200
Message-ID: <20261101145653.63648-1-timur.stukan.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 802.3ad mode, when bond_update_speed_duplex() fails on NETDEV_UP or
NETDEV_CHANGE, bond_slave_netdev_event() sets the slave link to FAIL if
the slave has ever been up (last_link_up != 0), and to DOWN otherwise,
so that miimon can set it right once speed/duplex are valid.

last_link_up is never cleared, so a slave that is currently DOWN but
was up before is set to FAIL as well. miimon then treats it as a slave
that is still in use and takes it through the full down path again:
the link failure count is incremented, "link status definitely down"
is logged and the 802.3ad port is disabled a second time, although the
slave has not been up since it went down.

Reproduced in 802.3ad mode with miimon=100 by setting a slave down and
up again. On NETDEV_UP the speed is still unknown, so the notifier sets
FAIL, and the next miimon pass sees no carrier and proposes DOWN:

	ip link add bond0 type bond mode 802.3ad miimon 100 lacp_rate 1
	ip link set enp0s3 down
	ip link set enp0s4 down
	ip link set enp0s3 master bond0
	ip link set enp0s4 master bond0
	ip link set enp0s3 up
	ip link set enp0s4 up
	ip link set bond0 up
	# wait for LACP to settle
	ip link set enp0s3 down
	ip link set enp0s3 up

procfs then shows "Link Failure Count: 2" in enp0s3 slave part. Also in
dmesg wrote twice: "link status definitely down, disabling slave".

Fix this by setting FAIL only for a slave that is currently UP and
leaving other states alone. An up slave that loses speed/duplex still
goes through FAIL as before, and DOWN/BACK slaves are left to miimon,
as in the other modes.

Fixes: ea53abfab960 ("bonding/802.3ad: fix link_failure_count tracking")
Signed-off-by: Timur Stukan <timur.stukan.linux@gmail.com>
---
 drivers/net/bonding/bond_main.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 7019e5d8fdc8..8212d406f3bc 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -3973,18 +3973,13 @@ static int bond_slave_netdev_event(unsigned long event,
 	case NETDEV_CHANGE:
 		/* For 802.3ad mode only:
 		 * Getting invalid Speed/Duplex values here will put slave
-		 * in weird state. Mark it as link-fail if the link was
-		 * previously up or link-down if it hasn't yet come up, and
-		 * let link-monitoring (miimon) set it right when correct
-		 * speeds/duplex are available.
+		 * in weird state. Mark an up slave as link-fail and let
+		 * miimon set it right when correct speed/duplex are available.
 		 */
 		if (bond_update_speed_duplex(slave) &&
-		    BOND_MODE(bond) == BOND_MODE_8023AD) {
-			if (slave->last_link_up)
-				slave->link = BOND_LINK_FAIL;
-			else
-				slave->link = BOND_LINK_DOWN;
-		}
+		    BOND_MODE(bond) == BOND_MODE_8023AD &&
+		    slave->link == BOND_LINK_UP)
+			slave->link = BOND_LINK_FAIL;
 
 		if (BOND_MODE(bond) == BOND_MODE_8023AD)
 			bond_3ad_adapter_speed_duplex_changed(slave);
-- 
2.43.0

