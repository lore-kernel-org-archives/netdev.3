Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACD83E5ECE
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 12:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776170427; cv=none; b=KEs+QZp+ZGd+BalPBQWbrR5usDJD2CwOJDRTY9iLKIoUM2VqCvZPQzRXIwzNBR18RJGAN2WKj78edt89tb7XDE54zGxcHJEhsaosGQHdTwKE1gw/Z5CL850iJTDVXt3Xw1eo0qGTCzsBrA9WV6iIHCBq0F/gSCSEVTJWnPBoT84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776170427; c=relaxed/simple;
	bh=IPBwqh9d3tDbxmlKfehIU4Pa/JiRA+IdViszBuMtYAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bBvWKHYFpr8tp50vjBSj1CXh+bTWtuVA/AUIda9ALySUur0KTaBCNH8cwLyS4EBJ8Y/yegqKK9KdnoTmrRUcxicHBI50Pp/0SNcYu2jDvwm0wfpR+0gwlPcCraWQgf0j7detlqWQsmMzFBWvV7GcZK64awPWAyj4FIwPnkiTJuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+o6JimJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+o6JimJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A47EC19425;
	Tue, 14 Apr 2026 12:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776170426;
	bh=IPBwqh9d3tDbxmlKfehIU4Pa/JiRA+IdViszBuMtYAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l+o6JimJSyx0n76jesd6mCHnnhRw0R97PxIu1yNKcBHkqXebFznuJ4wQvjRE2Jf0r
	 H5pS6nhw8wsbwz6zcAlqNG0+5JM0yUpBW64Q0KUIC/saKUWa8CXBo8CLl0BM2tYwJe
	 /yC+jTNFhqchoZlVTqiV/NH+mGZ5zCTUFKmUfQ5amTHKmZan/hGLqkgcDOh6kqa5Un
	 PP3SGIGAMjuuVAOoIcpq4PAc+qTuDhjECcYVCgazCVL7I4txSLrm4WqhtAywLG8ZT5
	 8OAv6dyZbOFWMoLsr/jQnii/m3pNJqKNIaQz8rsCTasnzS6znKczm1Xh/+bt/nOdN9
	 Y5Du/+H/533tQ==
From: Simon Horman <horms@kernel.org>
To: lorenzo@kernel.org
Cc: 'Simon Horman' <horms@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net] net: airoha: Fix max TX packet length configuration
Date: Tue, 14 Apr 2026 13:40:11 +0100
Message-ID: <20260414124011.751922-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260412-airoha-fix-max-mtu-v1-1-333030d0a564@kernel.org>
References: <20260412-airoha-fix-max-mtu-v1-1-333030d0a564@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
net: airoha: Fix max TX packet length configuration

This commit fixes the MTU configuration for the Airoha driver by removing
ETH_FCS_LEN from the maximum TX packet length, matching the hardware
documentation which states the register does not include the FCS length.

> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
> index c14cdce588a7c..a81ffda72b39f 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -1629,9 +1629,9 @@ static void airoha_update_hw_stats(struct airoha_gdm_port *port)
>  
>  static int airoha_dev_open(struct net_device *dev)
>  {
> -	int err, len = ETH_HLEN + dev->mtu + ETH_FCS_LEN;
>  	struct airoha_gdm_port *port = netdev_priv(dev);
>  	struct airoha_qdma *qdma = port->qdma;
> +	int err, len = ETH_HLEN + dev->mtu;

Does this regression cause MTU-sized VLAN-tagged frames to be dropped by the
hardware?

By limiting the frame size to ETH_HLEN + dev->mtu, the maximum allowed length
becomes 1514 bytes for a standard 1500 MTU. An Ethernet frame containing a
standard 802.1Q VLAN tag and a maximum-sized 1500-byte IP payload requires an
18-byte L2 header, making the total frame size 1518 bytes (excluding FCS).

Previously, the inclusion of ETH_FCS_LEN inadvertently provided the 4-byte
headroom needed to accommodate a single VLAN tag. 

Could the configuration explicitly account for VLAN headers using VLAN_ETH_HLEN
instead?

[ ... ]
