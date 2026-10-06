Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE9D455628;
	Tue,  6 Oct 2026 13:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791293704; cv=none; b=XkmCfQNwJYpU9cMHAou29rwmP8m0HQFZLNSfnoJo872UrxOKyxbGzvAcNZrMhC4wId8ZP6RDvmRUJ5SRIKH44ig3hLwsyp3esmCUYNyfwVy/dU9IWw1LKeuPNwDntXk9O182RCNoo2DR2DARFXb+7DvtWOoLMi3q4c3KyUoL9ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791293704; c=relaxed/simple;
	bh=MXjHLJMZdTweVhX18r17oAYLlBuq3FbHiuiq03q3ZVk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fG7pv/AGuUyDVvscLUPHOLCmlwSzIFy6hZKIgXFGD7hpdOuwtlB1gxg+VPLdjFS0SmCzGUj7u9N3z/GxDOcVKrW+cYIjrYjTfcJ7vFlqShB0LRzBqFhM7rEGjldBumlQ5CYqNHpW1A6Lmb2zApI5R4GbX0DR3TOrWxBqwYqhuHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kcaxHcLW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcaxHcLW"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 954D9C4AF63;
	Tue,  6 Oct 2026 13:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791293704;
	bh=MXjHLJMZdTweVhX18r17oAYLlBuq3FbHiuiq03q3ZVk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=kcaxHcLWW/AUAAMW6Ok/D4L1rQBhXGu1GGB9iRtf6/B9iCyIi1OQVbvJrwm0gw+Ax
	 jhm4geBuaXl+Rev4oMtXxe3QxBcxBNxQzmRwmX4VJDz1WatHBB8crSu1P+0WvCujDH
	 sUbfwA/+P9C4BMRsI/aG/S5CDYxdlXx3kMgv14KDVkJ2Bp+OXOpyK0Tm2Ng9WpaHBz
	 KwlM55FgCsGW8BsZNDex/4yLoTuZE9odHOSOPSgOZMIaGc8oiW/0ZxjlzBxwfOv6a9
	 AOEQk5nbMBXxLEJeTqpBcaZl9taj694dNO/7lLQjrsGh3X/J7o0AAluUpWQjMCy44r
	 kEpt4KdaE1QgA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75836CA6002;
	Tue,  6 Oct 2026 13:35:04 +0000 (UTC)
From: Vincent Jardin via B4 Relay <devnull+vjardin.free.fr@kernel.org>
Date: Tue, 06 Oct 2026 15:34:52 +0200
Subject: [PATCH net 3/3] ptp: qoriq: fix support for PTP_EXTTS_REQUEST2
 ioctl
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-for-upstream-qoriq-ptp-extts-flags-v1-3-b4a161b92832@free.fr>
References: <20261006-for-upstream-qoriq-ptp-extts-flags-v1-0-b4a161b92832@free.fr>
In-Reply-To: <20261006-for-upstream-qoriq-ptp-extts-flags-v1-0-b4a161b92832@free.fr>
To: Yangbo Lu <yangbo.lu@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Claudiu Manoil <claudiu.manoil@nxp.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, Wei Fang <wei.fang@nxp.com>, 
 Clark Wang <xiaoning.wang@nxp.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, Ioana Ciornei <ioana.ciornei@nxp.com>, 
 Vincent Jardin <vjardin@free.fr>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791293703; l=1341;
 i=vjardin@free.fr; s=20260525; h=from:subject:message-id;
 bh=bI02Z3k7XT254gwi64zNOv+zUT6wunV7tGvU62lzDZo=;
 b=z/FaeWp4UPCP8KJOLLZEahYoJuYfBopSJnSUbYl8Q479lSWpuToWVzswUuSd3zxahwBvO8kMN
 xuhPw3+AoFKCltg4/nvgeCGCtiZAXa2l4b+g/sRf/h+BmQmLIAEyr4m
X-Developer-Key: i=vjardin@free.fr; a=ed25519;
 pk=hppgLeFpGpKOi7LNwGEZ4jOYofJCoGd4Jf1ltAabiLw=
X-Endpoint-Received: by B4 Relay for vjardin@free.fr/20260525 with
 auth_id=871
X-Original-From: Vincent Jardin <vjardin@free.fr>
Reply-To: vjardin@free.fr

From: Vincent Jardin <vjardin@free.fr>

Commit 7c571ac57d9d ("net: ptp: introduce .supported_extts_flags to
ptp_clock_info") moved the validation of the external timestamp request
flags into the PTP core. A driver that does not set
.supported_extts_flags still accepts the legacy PTP_EXTTS_REQUEST ioctl,
but every PTP_EXTTS_REQUEST2 request is rejected with -EOPNOTSUPP, since
the core always adds PTP_STRICT_FLAGS to it

ptp_qoriq_init() programs TMR_CTRL with ETEP1 and ETEP2 cleared, so the
timer timestamps the rising edge of its external trigger inputs. Declare
that, with PTP_STRICT_FLAGS, so that a falling edge request is rejected
instead of being timestamped on the rising edge.

Fixes: 7c571ac57d9d ("net: ptp: introduce .supported_extts_flags to ptp_clock_info")
Signed-off-by: Vincent Jardin <vjardin@free.fr>
---
 drivers/ptp/ptp_qoriq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ptp/ptp_qoriq.c b/drivers/ptp/ptp_qoriq.c
index 76272e5ac5b8..bcd29104effe 100644
--- a/drivers/ptp/ptp_qoriq.c
+++ b/drivers/ptp/ptp_qoriq.c
@@ -355,6 +355,7 @@ static const struct ptp_clock_info ptp_qoriq_caps = {
 	.n_per_out	= 0,
 	.n_pins		= 0,
 	.pps		= 1,
+	.supported_extts_flags = PTP_RISING_EDGE | PTP_STRICT_FLAGS,
 	.adjfine	= ptp_qoriq_adjfine,
 	.adjtime	= ptp_qoriq_adjtime,
 	.gettime64	= ptp_qoriq_gettime,

-- 
2.43.0


