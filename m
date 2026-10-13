Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com [209.85.215.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494655540A1
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 20:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791924339; cv=none; b=SUPHSOijpD6X97aILhP5E+mz6xzZnbWaZ1HImw8N3Jq0Q7aiR9aDLRVfEHxxMfz8XIHBQMNxhEDYHTc04+1ZLOo50Xz/Ac11f1idnB7iH2iCEhoQVW+igLiNN0IVCATY9/N6VEJQ5Z2pDFUsgOCzN+VyuK8Cax2YHZ1k/TmV2Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791924339; c=relaxed/simple;
	bh=FmD6FNbWp9/w6PoDkjvhKUx+Pyh3k1MJEzE3JeITIz8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t7Oqr3nhcn+aeJqq9Kal1V6z14ajwmF5U9kGMJtqzm8PvzwX8UMuOi3gxs0XqW0tJf06q4FmPQsR278KUMxy4YGuyTcnTnzH1JGa0/d2ZClbqUSTqP7fxcCLzEceZoOVLF4pOpta6xPlEwnX8XtKa0QOiK3gyLiBmUBuHHp8X3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Pz2wW5W0; arc=none smtp.client-ip=209.85.215.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Pz2wW5W0"
Received: by mail-pg1-f226.google.com with SMTP id 41be03b00d2f7-cd6028ff33fso1211232a12.0
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 13:45:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791924336; x=1792529136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LQY9v+3ERouGCwmAz/IXWdzwQGXdtnY8j3MIGUYv9ls=;
        b=RYhEiIDMQg4yMsNMrBerwu/9fy+6tTjJgz+IToDSR3ZmOdP6r/xQq/JXDQTbKHoHYW
         3kqd/f3RLd6Wrc7T3bd/13bXt47J86zArSwOBdg6EVMVut6ey4H5KHHlBMAqNIlXXiDc
         6R9oEyBfPMcBg89+h0+dzxraMSSGlHZbv6rQPYU39D3wVBIshCuDOxQTSdzPKCPnN4wJ
         oZ+HbOigzcznrgzIX0ZEU9WTnvpSLzGYP3NQGaytu2UXtLV0Z/zvquCD4i/mj64Jsl6O
         fBZW+fUz31DA02Iua95mS7oDO0bbfXxKgePnDyfrWZNzV5Qkc9wwjmMeKCt/dHLCXHz2
         t7cQ==
X-Gm-Message-State: AFq9FYJHosJ7TGs9iBJ8s8KwpLG7XQGLmFmdWQs8l/R3uetjXpmZXgSS
	CRLIq1/DVANow9ch9W8og3RjBtkxezMvZN8f1V9URhXBIpuN0FDyxFb2DVPAtX0yW132FeCzRaw
	+dXI5b80TvpxmCpZkca1j1dG0uRvl041jEKSfhDfBbFskEbM5qqlbmwFtUbquP4cygwZRX8SQkO
	qUMi8WrZCsX1sGW6svAY2f/RY2OP8h3VFUBZtBxfeOCMNl36Q3orXmzo6ZaaITBNSqA7qlSdjbJ
	taviwH3DPUvmgXE
X-Gm-Gg: AYBFou3t/LCjangJm7odUSkTjW1kiBK5cTQ1Hmep2zxbNlsensh84xyooRPRcSQoTMV
	HOgKG2TVZKRBPm4wMba/CD6awVp9JuYspuqGjV1x4NrGa480Re/ocoEFmj6ontdacZvsi0M07fD
	WzyeBdKgv+4DJ0s1WP1r2UrTCNauPkBSjLdE6Z+Y6UlYi9UM6NftB2zEfx7Btu4iUrAdSmY+wah
	tQoFv53H3maSl7Nj5T03tSNK0v37MP2udq5ujdeLk2L1g9mdJ27RWxUSjkYGR2TubwS2UOkfR2p
	6OScnq4U4r9LHqiIMneCm8tg8S0YYuWbwUvvUEtnJSCD90lNWaaFOXd6AjtcmHjH/dzeqB15RNL
	5CIQARrVyF40ZVQpKuw8DPjXQCZl8L1EUJxwGEfZbQ+Lv4Njk5iR/JrL39U1ypyq5fqLyajQ4gb
	UepMWuc/BOsjldgi4wXWBi3ukv8su9svEq3VLfWjVhStI=
X-Received: by 2002:a17:90b:2e8c:b0:3ab:1e1c:837b with SMTP id 98e67ed59e1d1-3ab3a9183b3mr11896979a91.63.1791924335317;
        Tue, 13 Oct 2026 13:45:35 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ac67a627d8sm40648a91.4.2026.10.13.13.45.34
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Oct 2026 13:45:35 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-535851217d9so75959931cf.2
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 13:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791924334; x=1792529134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LQY9v+3ERouGCwmAz/IXWdzwQGXdtnY8j3MIGUYv9ls=;
        b=Pz2wW5W0gkrcJgTSW2cuKJsfJazPuhpRP/80BRi6Z07p6CqEnYjVqpn777E1PREnR9
         HDotZmN1CkSyADfa0cSr7Qd/ebqSs+KnTEh/c9DidgIm+BAiUnI5dmvrGajS6DfGyrAC
         R7ZrMwL+w9YVzarc7bi3/1qQOxBn50LzSEPPs=
X-Received: by 2002:a05:622a:1350:b0:533:8900:4eb2 with SMTP id d75a77b69052e-5359fe119e6mr228861671cf.58.1791924333629;
        Tue, 13 Oct 2026 13:45:33 -0700 (PDT)
X-Received: by 2002:a05:622a:1350:b0:533:8900:4eb2 with SMTP id d75a77b69052e-5359fe119e6mr228860941cf.58.1791924332878;
        Tue, 13 Oct 2026 13:45:32 -0700 (PDT)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-535f4eee7bcsm15879231cf.30.2026.10.13.13.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 13:45:32 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Justin Chen <justin.chen@broadcom.com>,
	Doug Berger <opendmb@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Zak Kemble <zakkemble@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Ryo Takakura <ryotkkr98@gmail.com>,
	linux-kernel@vger.kernel.org (open list),
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net v3 RESEND 3/6] net: bcmasp: validate minimum RX packet size in bcmasp_rx_poll()
Date: Tue, 13 Oct 2026 13:44:36 -0700
Message-Id: <20261013204439.3494046-4-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261013204439.3494046-1-florian.fainelli@broadcom.com>
References: <20261013204439.3494046-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

In bcmasp_rx_poll(), the driver removes a 2-byte alignment pad and
optionally strips the ETH_FCS_LEN CRC from received packets before
passing them to eth_type_trans().

If the hardware reports a descriptor size smaller than the sum of the
2-byte pad, the Ethernet header (ETH_HLEN), and optional CRC
(ETH_FCS_LEN), subtracting the pad and CRC lengths underflows u32 len.
This adds ~4 GiB to rx_bytes statistics, while the undersized frame
reaches eth_type_trans(), which reads past skb->len into stale buffer
data.

Check that desc->size is at least (2 + ETH_HLEN + (crc_fwd ? ETH_FCS_LEN
: 0)) before proceeding to process the descriptor.

Fixes: 490cb412007d ("net: bcmasp: Add support for ASP2.0 Ethernet controller")
Assisted-by: LLM
Reviewed-by: Justin Chen <justin.chen@broadcom.com>
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
index 9ad5a982542f..d679c796c8c2 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
@@ -523,6 +523,12 @@ static int bcmasp_rx_poll(struct napi_struct *napi, int budget)
 					DMA_FROM_DEVICE);
 
 		len = desc->size;
+		if (unlikely(len < 2 + ETH_HLEN + (intf->crc_fwd ? ETH_FCS_LEN : 0))) {
+			u64_stats_update_begin(&stats->syncp);
+			u64_stats_inc(&stats->rx_dropped);
+			u64_stats_update_end(&stats->syncp);
+			goto next;
+		}
 
 		/* Allocate a page pool page as the SKB data area so the
 		 * kernel can recycle it efficiently after the packet is
-- 
2.34.1

