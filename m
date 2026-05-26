Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51922D6E58
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 13:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779801397; cv=none; b=c1vU5+67aFs+OpCPu8Imj7urXYSEiAg3a4vrS/UnSHR1TTtLofl1Uh/TdN7LYpRrOPli/Fx6jZrllDyThj4yMI542J46eiH1mXlMB6QCl2DRiWbItwAbJ5Ou4Cdp1OXtlWfsE5+sxv1et4g1at9508GEuZ0/tYnEYj9MYnGgfqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779801397; c=relaxed/simple;
	bh=8M/T1Gxh6U8czmubB12+JgK2xXxNkm47j/lnx5Lmalk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rdnTymYwUQcys3wn24JBduCvjCNAjoTORj9iTJTohX2kJ/Y8ciJLoyNuRoFLzGZ9Q5OBSPSadDufhUmbxsR/OSW6TWZcQDexFL3exIbsFDy0p2b3P49g1cQwMrAkQKNnb6uipiMCF7e1wzOaD0Ou+zp+JhWyHxPDtbI0VsftiWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hxijwjix; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hxijwjix"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779801394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6GgSUNdqXFIqT+MkUpzmU8TLtF4oHHs3+i4Z69bF14w=;
	b=HxijwjixjVenxrEa8bguESJ1m3hy9o27632y+Ddh8xaS6LOYgzn6G99wsBlD9SUHQqIz2R
	0k663LTuE13h7cqW596fzKnD4DlQXKjRKr2eCs8nsL270tFWbPma6hreiqfJMybd3TZwGo
	y0mJa/pBwWLgdljerj6ngODi9IzM1vw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-sejl_gT6N7CC7eZBMv2yJw-1; Tue,
 26 May 2026 09:16:31 -0400
X-MC-Unique: sejl_gT6N7CC7eZBMv2yJw-1
X-Mimecast-MFC-AGG-ID: sejl_gT6N7CC7eZBMv2yJw_1779801389
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8CA9F182E6A2;
	Tue, 26 May 2026 13:16:22 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.48.107])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3F309180034E;
	Tue, 26 May 2026 13:16:16 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: devnull+cedric.jehasse.luminex.be@kernel.org
Cc: andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cedric.jehasse@luminex.be
Subject: Re: [PATCH net-next 2/2] net: dsa: mv88e6xxx: add support for credit based shaper
Date: Tue, 26 May 2026 15:15:50 +0200
Message-ID: <20260526131550.185704-1-pabeni@redhat.com>
In-Reply-To: <20260522-net-next-mv88e6xxx-cbs-v1-2-c87a8e6bcc0c@luminex.be>
References: <20260522-net-next-mv88e6xxx-cbs-v1-2-c87a8e6bcc0c@luminex.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

From: AI Reviewer <ai@example.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev/
---
net: dsa: mv88e6xxx: add support for credit based shaper

This commit adds support for credit-based shaping (802.1Qav) to several 
MV88E6xxx chip families (6352, 6390, 6393). It implements the UAPI 
structures allowing configuration of the idleslope and hicredit parameters 
per queue.

> diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
> index 1bd0615ea95b1..7ab0733f49154 100644
> --- a/drivers/net/dsa/mv88e6xxx/chip.c
> +++ b/drivers/net/dsa/mv88e6xxx/chip.c
> @@ -7170,6 +7197,101 @@ static int mv88e6xxx_crosschip_lag_leave(struct dsa_switch *ds, int sw_index,
[ ... ]
> +	if (!cbs->enable) {
[ ... ]
> +		goto unlock;
> +	}
> +
> +	hi_limit = cbs->hicredit & qav->hi_limit_mask;

[Severity: High]
The tc_cbs_qopt_offload UAPI structure specifies hicredit in bytes, but this
appears to pass the value directly to the hardware register without scaling.
If standard tooling passes a correct byte value, will this result in the
hardware allocating significantly more credits than intended due to hardware
block size multipliers?

> +	err = avb_ops->port_qav_write(chip, port, hilimit_reg, hi_limit);
> +	if (err)
> +		goto unlock;
> +
> +	err = avb_ops->port_qav_write(chip, port, rate_reg, rate);
> +	if (err)
> +		goto unlock;
> +
> +	err = ops->port_set_scheduling_mode(chip, port,
> +					    chip->info->num_tx_queues - 1);
> +	if (err) {
> +		avb_ops->port_qav_write(chip, port, rate_reg, 0);
> +		goto unlock;

[Severity: Medium]
If ops->port_set_scheduling_mode() fails, the rate register is cleared, but
the queue_bit is not removed from chip->ports[port].cbs_active_queues.
Could this cause the software state to incorrectly believe the queue is
still active, preventing the port from returning to standard scheduling
mode when other queues are later disabled?

> +	}
> +	chip->ports[port].cbs_active_queues |= queue_bit;
> +
> +unlock:
> +	mv88e6xxx_reg_unlock(chip);
> +
> +	return err;
> +}
[ ... ]
> diff --git a/drivers/net/dsa/mv88e6xxx/port.c b/drivers/net/dsa/mv88e6xxx/port.c
> index ea1fab71968a0..cadbc664608ff 100644
> --- a/drivers/net/dsa/mv88e6xxx/port.c
> +++ b/drivers/net/dsa/mv88e6xxx/port.c
> @@ -1323,6 +1323,44 @@ int mv88e6097_port_egress_rate_limiting(struct mv88e6xxx_chip *chip, int port)
[ ... ]
> +int mv88e6390_port_set_scheduling_mode(struct mv88e6xxx_chip *chip, int port,
> +				       u8 mode)
> +{
> +	u16 reg;
> +
> +	if (mode > MV88E6390_PORT_QUEUE_CTL_SCHEDULE_MASK)
> +		return -EINVAL;
> +
> +	reg = MV88E6390_PORT_QUEUE_CTL_UPDATE |
> +	      (MV88E6390_PORT_QUEUE_CTL_SCHEDULE <<
> +	       MV88E6390_PORT_QUEUE_CTL_PTR_SHIFT) |
> +	      (mode & MV88E6390_PORT_QUEUE_CTL_SCHEDULE_MASK);
> +
> +	return mv88e6xxx_port_write(chip, port, MV88E6390_PORT_QUEUE_CTL,
> +				    reg);

[Severity: Medium]
This function sets the MV88E6390_PORT_QUEUE_CTL_UPDATE bit but returns
immediately. Should there be a wait or poll for the hardware to clear
this bit before returning, to prevent sequential configuration changes
from silently dropping updates while the hardware is still busy?

> +}
-- 
This is an AI-generated review.

