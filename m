Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B169A3D76;
	Mon, 21 Sep 2026 23:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790032475; cv=none; b=ekCWG5LpJxGjOiE4aEziSZRiyIU2bCu+tbhg4k+w4l1dmXbnK3n0sdHgmvCQ4fqxNv3lr5zU3td+Kx+hoWavzkp2byRb16EQVrhk+LlRNrEPZbi0kFVFzG46gG+ayndaQjTfy937LxQtAn7E3rp4DrMDO8PsNh3lwK+rZbjHJN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790032475; c=relaxed/simple;
	bh=5N398/3mDHZQ9gXLgS0HPtSZVg4D1QaLhP3tV0hav4M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s38BJlTn31fYoHJWxfMbyKPWfnV/Z89f2gFDz1lGpUbkizEdWMuYJlPPvN7FxZTB4CRRkAlfBjhjS+Vu6rRBWRDxkQRPjd54SsfivIxW+JEl5bxZDgHCoJaM78xGsBMylOopwFnt4vyHx8OC5IlSChCiiuLDOEZIfKwxa6DZe5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=q14wgn0Y; arc=none smtp.client-ip=192.19.144.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="q14wgn0Y"
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 9FB68C0000E4;
	Mon, 21 Sep 2026 16:14:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 9FB68C0000E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1790032472;
	bh=5N398/3mDHZQ9gXLgS0HPtSZVg4D1QaLhP3tV0hav4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q14wgn0YVs0WL1o0iI7qhLOjl0zHgdO/emgFShGI17UYFIHoGeHFGYtRIGw6boj4K
	 WERZq1J0jtEwS9l/QyWk/qS/Di9Mza4kRJf25o0DpGvlfXe+qHw4FRZtgWRdpa4edB
	 wNb4484g/Wic5P376wdGyQxlKFKAp/VDsAgERG3Y=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 48AB4AD9;
	Mon, 21 Sep 2026 16:14:32 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
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
Subject: [PATCH net 01/12] net: systemport: Fix buffer overflow in bcm_sysport_get_stats()
Date: Mon, 21 Sep 2026 16:12:54 -0700
Message-Id: <20260921231305.394773-2-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260921231305.394773-1-florian.fainelli@broadcom.com>
References: <20260921231305.394773-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When running on SYSTEMPORT Lite, certain statistics are unsupported and
skipped during bcm_sysport_get_stats(). The variable 'j' tracks the
compacted index into the destination data buffer, whereas 'i' iterates
over all elements in bcm_sysport_gstrings_stats.

Because the buffer allocated by ethtool is sized only according to
bcm_sysport_get_sset_count(), storing values at data[i] instead of
data[j] writes past the allocated array bounds, leading to memory
corruption.

Fix this by writing to data[j] instead of data[i].

Fixes: 10377ba7673d ("net: systemport: Support 64bit statistics")
Assisted-by: LLM
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/ethernet/broadcom/bcmsysport.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
index 4d06c6ba6641..db627cd15fb7 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -482,10 +482,10 @@ static void bcm_sysport_get_stats(struct net_device *dev,
 		    s->type == BCM_SYSPORT_STAT_NETDEV64) {
 			do {
 				start = u64_stats_fetch_begin(syncp);
-				data[i] = *(u64 *)p;
+				data[j] = *(u64 *)p;
 			} while (u64_stats_fetch_retry(syncp, start));
 		} else
-			data[i] = *(u32 *)p;
+			data[j] = *(u32 *)p;
 		j++;
 	}
 
-- 
2.34.1

