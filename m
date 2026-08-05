Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C45349CD6;
	Wed,  5 Aug 2026 13:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785935710; cv=none; b=f1aK3A4bPxms7IlMTpXdfLuomorfJnAK3Q6MOlZ8dxIYznpN4lggMJXWlf7nHMnMRqxlP0oQd4ylgHFR7jFFC2yiVKJzxm81gZPvpU1ZLEItoAqr9O2CmIMh8UgCQR0qp2kBI2fbYfTSSCnqaK9bgBAy8wQza+nL0I/Lb+X/lp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785935710; c=relaxed/simple;
	bh=Yrg1ErwQQvfeFOROWOyJx0XM0IbSa9BL6q1B5tpim1s=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=CSF8BLM7WILPE/9f/u9seYghcj0G4sOfhj2wQjoHICmEDc7ZoWZbC9U6QuyKv5v33K55hC2B+qZA+TpAVkNNrq4NNRFCiVMugu4rlbrV8I3WaY0Q5pVoYRyPJ+cnJ/j5HySIRYkpkpSC9icRusdFWlIjpwWCX3SPzZrALrADEFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=zoOkX+uT; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="zoOkX+uT"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id D8A244E4104F;
	Wed,  5 Aug 2026 13:15:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id ABBC4602AB;
	Wed,  5 Aug 2026 13:15:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 00D2211C349E7;
	Wed,  5 Aug 2026 15:14:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785935699; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=uIHxcjJyQ0y8FabWacsLPaMO/+nPUzK4AJsBNIDdFIs=;
	b=zoOkX+uTzInOyjkRfqVDeQ6qflmBLZWzl2vRGga0nrlumtL6UmnC3+oD0cw5B8IntY1yTp
	hRTbKyDqbEfk406eFifx1gJtHdhNBylBOl9ED0nlZI0hXFAckCzV/WpgBIYe9Fv5jMgyT+
	sDhdW3lyblEZTYKU+B4ehpnAGuM43n22hx0aKyK7ye5U+txWn9Pq4LskIznCgJpqJrmbw4
	F/l2BiDNxbH/TDsDyecsF7tsC5fsghV+yC5W4rn6IZ1PnOlEMVjQ2baKbo/zlyVo1kq4nj
	QV4BWc+enE0NbnqaYJnNT9TmROLjqG+ZclkrDUYAsP9oxiP64PiGNuKjeLLY+w==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 05 Aug 2026 15:14:55 +0200
Message-Id: <DKH1D7X1YSQY.3UOH4SJMIQ5QW@bootlin.com>
Subject: Re: [PATCH net v2] net: macb: configure ENST registers for all
 queues
Cc: <git@amd.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Vineeth Karumanchi" <vineeth.karumanchi@amd.com>,
 <conor.dooley@microchip.com>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
 <pabeni@redhat.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260805044204.272989-1-vineeth.karumanchi@amd.com>
In-Reply-To: <20260805044204.272989-1-vineeth.karumanchi@amd.com>
X-Last-TLS-Session-Version: TLSv1.3

Hello Vineeth,

On Wed Aug 5, 2026 at 6:42 AM CEST, Vineeth Karumanchi wrote:
> When a taprio config only covered a subset of queues, the driver
> programmed the ENST registers only for the queues named in the config
> and left the remaining queues holding stale register values. This
> produced an inconsistent hardware setup that affected the scheduling
> of the configured queues.
>
> This was observed on a GEM instance with four hardware queues, all
> enabled:
>
> Initial configuration:
> - All four queues are enabled.
> - enst_on_time_qX registers are left at their reset value (0x0001FFFF).
> - Only q0 and q1 are configured with valid, non-overlapping ENST
>   schedules (T0 and T1 respectively).
> - Traffic streams p0 and p1 are bound to q0 and q1.
> - ENST is enabled only on q0 and q1.
>
> Observed behavior:
> - During T0 on-time, both p0 and p1 packets are transmitted.
> - During T1 on-time, both p0 and p1 packets are transmitted.
>
> With the unused queues (q2 and q3) explicitly programmed with
> enst_on_time =3D 0x0:
> - During T0 on-time, only p0 packets are transmitted.
> - During T1 on-time, only p1 packets are transmitted.

Thanks for the expanded commit message.

> Leaving the ENST on-time registers of unused queues at their reset
> value (0x0001FFFF) disrupts the scheduling of the configured queues,
> whereas programming them with 0x0 yields the expected ENST operation.
>
> Program the ENST registers for every queue unconditionally. The
> per-queue configuration array is now allocated for bp->num_queues and
> indexed directly by queue_id; unconfigured queues are left
> zero-initialized by kcalloc(), so their registers are cleared.
> Indexing the array by queue_id also makes the queue_id field in
> struct macb_queue_enst_config redundant, so drop it.
>
> Fixes: 89934dbf169e ("net: macb: Add TAPRIO traffic scheduling support")
> Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
> ---
> Changes in v2:
> - Split the patches for net and net-next.
> - Updated commit message
> - Link to v1 : https://lore.kernel.org/netdev/20260724043257.2221030-1-vi=
neeth.karumanchi@amd.com/
> ---
>
> [...]
>
> @@ -4357,7 +4357,7 @@ static int macb_taprio_setup_replace(struct net_dev=
ice *ndev,
>  		return -EINVAL;
>  	}
> =20
> -	enst_queue =3D kcalloc(conf->num_entries, sizeof(*enst_queue), GFP_KERN=
EL);
> +	enst_queue =3D kcalloc(bp->num_queues, sizeof(*enst_queue), GFP_KERNEL)=
;
>  	if (unlikely(!enst_queue))
>  		return -ENOMEM;

My first reaction to this was that we should be using the new
kzalloc_objs() API. But actually those 96 bytes are not worth the
trouble of a kmalloc, it could be stack allocated.

   struct macb_queue_enst_config enst_config[MACB_MAX_QUEUES] =3D {};

Anyway this is a bit orthogonal to your change.
Whether you change it or not:

Reviewed-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

