Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3731628C009;
	Fri, 21 Aug 2026 20:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787344172; cv=none; b=lEJUOYpV3jUX5+nGW7w2DW10LQj2BmxcmCSbANPhclBn2l8QcvcZqqqCchYGBJrn+Vp7ImeGJPFG9Rcb5a0elDTtd+oMBvK9sR8ZVmGxvZKk2o/5QoPFIRM1g6xqmk5iMEzncwxnlvCt+YoKF94nvYgXvAG/aC/2qR/Fsx5E1NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787344172; c=relaxed/simple;
	bh=5Z7zTShx/tz8zQU68ki8h3ljCOiWq2XceVd8PCQm8sk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pk73+lwosu859llJKmq3sgKB36ddc1n+QzFFd9Sk1eUG4H7p5mhQsey0qMbiMa9+U3bCQQGEkk3mVTSBJGzxvGahWrCrmE6LZZjCfoVVbcuFKVKzl0nDgrSzy+clVhIJDdW4q8Ms3jgvG8Y0m3TWBskGtrDvYtyMyuJHDhNTVK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=ZJZuKDWr; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="ZJZuKDWr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GJVYThdLX6flGpGPc+xAe8iCpnn+ESplzc1fhpKsD7M=; b=ZJZuKDWrb2je8EOYNJ+W2Dh5wL
	nRMwlo2YPo2Q1FuJy1w+0v2XSUsvDplBEFh+KzCjf4MpFVJVNZxuMfdwaaoq1tmB85JYORxGFCOrB
	3Bt8si65z9wRWzvXNS8BlkmEaCpKL/TbVg6JjO7IIdGzyCGKF8YMOOY/TFjj8jDa29WKkQeI40D2I
	KRplknwA7fAuKQ/lDaSjC+KcckXZxfhiZk54+ZnxgcivpuKxB/2+Tdx1DMtyLV8xw7oQzbPkuc6K7
	dO1BTDFMN/tuLaX0BYHdddbnCaxn0Fe4VaNXis+dZCYwOEy2HhxxAUL9ur9W5i6ZjTo5OQ2gUUm2O
	HmwLDM3g==;
Received: from [151.115.150.205] (port=58992 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1wxVrk-0000000EXYi-367R;
	Fri, 21 Aug 2026 22:29:28 +0200
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>,
	Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
Subject: [PATCH] net: qualcomm: rmnet: require real-netns admin for bridging
Date: Fri, 21 Aug 2026 20:28:46 +0000
Message-ID: <20260821202845.4053530-2-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

An rmnet device remains linked to its real device after it is moved to a
different network namespace. When it is used as a master, rmnet_add_bridge()
follows that pointer and switches the real device's port to bridge mode.

The rtnetlink master operation only requires CAP_NET_ADMIN in the namespace
holding the visible rmnet and slave devices. A caller privileged only there
can therefore bridge an attacker-controlled interface to the real device
in another namespace, receiving and transmitting raw traffic across the
namespace boundary.

Require CAP_NET_ADMIN in the network namespace of the real device before
configuring the bridge.

Fixes: 60d58f971c10 ("net: qualcomm: rmnet: Implement bridge mode")
Assisted-by: Codex:gpt-5
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---
 drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
index bed6f63facf2..45e6c16a5a70 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
@@ -441,6 +441,14 @@ int rmnet_add_bridge(struct net_device *rmnet_dev,
 	struct rmnet_port *port, *slave_port;
 	int err;
 
+	/*
+	 * The rtnl path only checks CAP_NET_ADMIN against dev_net(rmnet_dev),
+	 * but bridge mode below controls real_dev, which may live in another
+	 * netns.
+	 */
+	if (!rtnl_dev_link_net_capable(rmnet_dev, dev_net(real_dev)))
+		return -EPERM;
+
 	port = rmnet_get_port_rtnl(real_dev);
 
 	/* If there is more than one rmnet dev attached, its probably being
