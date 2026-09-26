Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D2042AFAA;
	Sat, 26 Sep 2026 13:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.12.53.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790429273; cv=none; b=pwjwLl6sfMlmgF042TtcrNgKFTwz3BmjX9SzOj0Cl84tC79C/P2rgsScv6eSTQzMMKO9tfG6j6Fd5Ca8D+qTQu4p8BCUf9goTgp9tyK18vkRJQlnhJLLdyAbJdBXL7TNHRzgCSvA00gguuoBwW934n5r0gXLk/E5IJnC/hab+2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790429273; c=relaxed/simple;
	bh=vmejTPXQt6DL4ZbDgCsyxXP5w6h8Lap4Omwhbt8m3lA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=McFm+Q9lqJ6+BsBpNGn1cHqkg7bTF2B52VKHWMgblir3tiyc56OTgGQo05X5Y5cyV5ZhlrNUn4iXbEkkQfDXSlIqWKHRHGC9624cM5orJ7j2XaevKqYN6E33/elXcd5Yola37WHdUBxb9FyKvrZe6AB0nt2I4V/y6oP8E+0DTcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=rKBwFQyb; arc=none smtp.client-ip=52.12.53.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="rKBwFQyb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1790429271; x=1821965271;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SvyQxUuoQfRvxhBnOj0Xsuc8gwJZCfMFGw0CG6ch8bo=;
  b=rKBwFQybLFJWxdc015bAJiYzJDBIWStpiURyV8nQouQ6wFCRff0BmEQa
   C5kgTXOdPaokwzTd4jQkxHOy1ypcxj0tXU8DBP3sShl2B76KCfJ1pB2rk
   iZCG3uXpcDKeaKMG/HNpHt96UVEOFWyX9dCZECEUJv007HOW8+vhBau99
   e+jUSwpgJmo7v1dhX1qOV6Zz6qbctr33oie4UO8smCY2nko7Xu3z00wUM
   vQOFv+uszjk+lwLckjTCs+782oqLDHoAGVAG9jkxVOI/DscoVWl5oILPL
   Svpwg4POWWVqppbwStPeRz9iDsZ7EZZTwgEQP1SyWkfaFMRuJM/pg9ZvA
   g==;
X-CSE-ConnectionGUID: i/P1bY0nRx+RXw8Mg/RmVA==
X-CSE-MsgGUID: me5NK4IVSQGoCmyAqv5xmw==
X-IronPort-AV: E=Sophos;i="6.27,124,1787011200"; 
   d="scan'208";a="29576764"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2026 13:27:51 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:8094]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.33.144:2525] with esmtp (Farcaster)
 id 9d715496-4bc2-4d89-bcee-5a783de8659d; Sat, 26 Sep 2026 13:27:51 +0000 (UTC)
X-Farcaster-Flow-ID: 9d715496-4bc2-4d89-bcee-5a783de8659d
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Sat, 26 Sep 2026 13:27:50 +0000
Received: from dev-dsk-hagan-1f-c6b5e25f.us-east-1.amazon.com (172.19.159.5)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Sat, 26 Sep 2026 13:27:49 +0000
From: "Craig I. Hagan" <hagan@amazon.com>
To: <tactii@gmail.com>
CC: <andrew+netdev@lunn.ch>, <anthony.l.nguyen@intel.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <hagan@amazon.com>,
	<intel-wired-lan@lists.osuosl.org>, <kuba@kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-net] e1000e: fix flow control stuck off after link partner reset
Date: Sat, 26 Sep 2026 13:27:44 +0000
Message-ID: <20260926132744.24777-1-hagan@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <42cccecf-ff14-41e1-811d-e5a44f3d1aab@gmail.com>
References: <42cccecf-ff14-41e1-811d-e5a44f3d1aab@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA004.ant.amazon.com (10.13.139.19) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On 2026-09-24, Matt Vollrath wrote:
> I didn't try your patch, but there's a four line fix. Where the watchdog
> resets just the PHY when the MAC exits DMoff state, set FLAG_RESTART_NOW
> instead of resetting the PHY, then goto link_up. This works for me at
> both 1500 and 9000 MTU.

Thanks Matt,
I've tested this approach on two I219-LM boxes, each attached to a different switch:
one a TP-Link TL-SG108PE V3, and the other a Cisco Catalyst 9200.

On the Cisco with jumbo frames, I'm seeing, via a diagnostic message, that
the fix appears to fire and work. I have also noticed that I no longer see
it on every boot, but this may be correct as I've not seen traffic stalls.

With 1500 mtu, I'm seeing it engage fairly regularly with the TP-Link but
not the Cisco. I'm guessing it is related to how the Cisco negotiates. In both cases
traffic doesn't seem to stall.

I think you are correct about flow control being a red herring since
both switches advertise no pause (Flow Control: None) before and after
recovery.

I'd like to drop my patch in favour of your fix.

How should I proceed, should I propose a patch with suggested-by you, or with your authorship and
tested by me?

For completeness, here is the diff I tested (I added an e_info so I could see it fire on the
test rig; happy to drop that line - it isn't needed for the fix):



--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -5254,9 +5254,16 @@
 					usleep_range(10000, 20000);
 					pcim_state = er32(STATUS);
 
-					/* Checking if MAC exited DMoff state */
-					if (!(pcim_state & E1000_STATUS_PCIM_STATE))
-						e1000_phy_hw_reset(&adapter->hw);
+					/* Checking if MAC exited DMoff state.  A bare
+					 * PHY reset here does not re-run the jumbo
+					 * workaround (e1000_lv_jumbo_workaround_ich8lan),
+					 * so request a full reset instead, which does.
+					 */
+					if (!(pcim_state & E1000_STATUS_PCIM_STATE)) {
+						e_info("full reset on DMoff exit to restore jumbo-frame configuration\n");
+						adapter->flags |= FLAG_RESTART_NOW;
+						goto link_up;
+					}
 				}
 			}
 
