Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B0F3C09E5
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 18:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790879031; cv=none; b=YSA7a79uk+XdEA7l4SITspF9B8cjlYB/3JxCLrZn+e7LIid8CVrLox/kjZiBF0KoWOvy2SS/b9JmeNuxclwNPAm4rj5xxQWzAOROSYKNp/dCk2ghqf02he7uajs3tgQVPEhjO1B2QyslV6lbiR0I3w0MNmty6wgA4mHE9RRgk24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790879031; c=relaxed/simple;
	bh=ApPsSddcz34krnPCoImgDAAUnXelxvxjJ/VafXgbhUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=slvhH5sjKY8F+cmMvjKhGFPfTsmozl5Fp/CPZWVwQyDhSe6doPivhd3h/PQpsANux679n4d88rh1uSuv50kXO74WWQrHYkL9Bi45ifgNdgqhICb03nx1vGNkDgjv2afyxTxMmaETCJ9CiiEyCoc2V9G4Gd5vS3tdcDK/PfzNWIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oR4nYzGe; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oR4nYzGe"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-3411e0ace58so8634423eec.0
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 11:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790879023; x=1791483823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dNFa4jlYFw2EffEHYX+/aDUCOKTNBmwQOlvs+e8ofc8=;
        b=oR4nYzGeEMBrRreVr/WDdjuzM80CdQf/jbOJiKZ/2R2qeqzHMkCbHxtSsgVunzwRxg
         zCmUvglH8A1yYe35tkVy2qdc+gp+UeixqgnmK+sxgBaDxV09/WEnwseV+8o2yASxT3gX
         0Jn0t+J9o84y45Ratk9RpwquvWkDDZq30IvdY1Rhpl8GMdL1HSP0X0iXrUR6wODRHHkO
         aFr8kFYAyFQD3vE97LMTabS6BhMdYCv1teGZFysMPIBQuSM1iz2AL39F0Dgfo3zDNVC3
         oQ2beHX0H7SoR5sPZ2qNCUYNk0pwPITrVYFL7qRgbxa3n1zabatzl7HrsgJk1h1uXAam
         +ERg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790879023; x=1791483823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dNFa4jlYFw2EffEHYX+/aDUCOKTNBmwQOlvs+e8ofc8=;
        b=boFeZw8urstFGvP5t0xnYGmJ2wivrBnDCSsB1y7Q9Y9WOoVfbStxAgNo+wgquMsg+1
         9JoLpSbtBZgL8Y6JaKQjwDCDRqF3j+EpcLyoIBe0JH+jjnWuF/Nkt8ao4IwWu82fnG3G
         tH++7FB3BYJzkzYk1lJmLqomkhu5tE38tLtGtDwDCrTbFOSQYcbZju2DtUyenoERm9Wj
         fWoWkGzJJU5CiNqWJAdgahtcrmPoyCr88ndgidINWLcQfGTtBjEMskOkIfGZ1aAnG3vD
         8nhHzWvbXnPMcNJpuZF8XM7IISxvM1q7qFz2WXD5D3mztsFQE5sGX4QYfdJmsofdvGzL
         qzKQ==
X-Gm-Message-State: AFq9FYLeODwSHyIzGok6H/ANnpDAj2dXM3tRVxZ9b3Qi1R7W/g73bkOo
	0KuIPiUoBt0I3hldvp0mjuz2zUlS+uhYqz+p7zXRqIhcjmjxQ1jQgC2o
X-Gm-Gg: AYBFou1D2OC3w8ZNnG1mr8j8eHE/Y2+H8W9Io8D9x7q3e1o+eVZUvAX09XNRzDCaOod
	1nVstqrKj+A8l/PwqhgGE2J/pSDEJIpegBomfhR52akcMjglVnfoOh7UnmtJhG6gaSP4xiWTypo
	30w3lxfv3bQzbp6gJOfAOpsU60a5SL/efVb6NYBZk1x615DRfEIAa7NOaqH/WCODspfDCCe1Mq5
	OwalfblSg1cC0HIfh0z9018UXP1lflLwPosQxZoiTw0+lAIHIwSvVw0aUP75JPuzVWQ+vzmq6Py
	rwkUTCyGJA+3PhrbmwPsFVm3JbBTvJP0sq9VOHP9im/9PwoYC0/PBnXAGmEgAlBQMbrvZ/FeXYs
	inh2MVWIOz9ZEBXYtju57L8cSMxZ49cAjXqq8y3o962aYLq4UbrDyEDyLuvC4jVF1PGpnVNfhcU
	19giLY2SwtW7JoydtfhKwcwYjIE7ZXB5w1HNFW8FJOWmHvacTTy5Lx/2u3k9nw9aDwp8R4fay8o
	CBsu3LdPpNTxqgVO0QXcPWLhhDnHwyJAw==
X-Received: by 2002:a05:693c:3881:b0:34c:1f07:2d5 with SMTP id 5a478bee46e88-34f1508567fmr105771eec.6.1790879022862;
        Thu, 01 Oct 2026 11:23:42 -0700 (PDT)
Received: from 192.168.50.3 ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34f14f303e3sm189671eec.5.2026.10.01.11.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 11:23:42 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Jiri Pirko <jiri@resnulli.us>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	co+2cf741c3005abc20@bugs.sh,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2 2/2] net: team: free skb when broadcast has no txable port
Date: Fri,  2 Oct 2026 02:23:26 +0800
Message-ID: <20261001182326.572045-3-bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261001182326.572045-1-bestswngs@gmail.com>
References: <20260926090039.1714460-1-bestswngs@gmail.com>
 <20261001182326.572045-1-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bc_transmit() sends the original skb through the last txable port.
When no port is txable, it returns false without consuming the skb, but
team_xmit() still returns NETDEV_TX_OK. AF_PACKET sends then retain the
skb and its socket write-memory charge.

A TX-enabled, link-down port keeps the broadcast transmit op installed.
Carrier can stay up through a second link-up, TX-disabled port or be
forced on by userspace. Free the original skb on the no-port path while
leaving the existing drop accounting intact.

Cc: stable@vger.kernel.org
Fixes: 5fc889911a99 ("team: add broadcast mode")
Assisted-by: LLM
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 drivers/net/team/team_mode_broadcast.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/team/team_mode_broadcast.c b/drivers/net/team/team_mode_broadcast.c
index 61d7d79f0c363..69dc25a5847a1 100644
--- a/drivers/net/team/team_mode_broadcast.c
+++ b/drivers/net/team/team_mode_broadcast.c
@@ -37,6 +37,8 @@ static bool bc_transmit(struct team *team, struct sk_buff *skb)
 		ret = !team_dev_queue_xmit(team, last, skb);
 		if (!sum_ret)
 			sum_ret = ret;
+	} else {
+		dev_kfree_skb_any(skb);
 	}
 	return sum_ret;
 }
-- 
2.55.0

