Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794593929;
	b=TAQnGYOqGXJiFM3fR4pse65uMo7D/Wej/ZCySOVH5d+aYf5OvUhKGvcWUB8q7O1bcwpK
	 xqMCO9EYiVGq8Cb4B6xRHSMisHGeejB+vrqrmqMKnBax/ap744IUZEP/7dj0kuAncJRE2
	 wYtT5OQft/XVBgfLGYZNTEyiwfrUJIvN3sZj/GW0hStgoIxQQNzwmKzf4wlGv3W5u5a9r
	 VnI9cp59MrmSJ1Hpw3wcPLCBIjdf+EM+0Rn5xQSACDnJynVnG+5mJk8R6A8obGEsOzTk3
	 CDEshnxbqsLxLeVSaa2Q1hNIMACoSf9iqGoyc5wNhKez0mh4phYijE8qyxdugKhntxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794593929;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Subject:Cc:To:
	 From:X-Mailer:References:In-Reply-To:X-Last-TLS-Session-Version;
	bh=YMmgQJzMtgBLpA0dIqJ/1stJoQj5sUUq2ttQetzsqvg=;
	b=pFUVE9kYeIFgViM0zXyj6SGj25MPIVaxvTew77x1/NUbjo3e9e6N9eFKSALOlcPvTXSo
	 /nuz0VSwdY1tR5vgR4lLf9DESF484qN8CxWGTOI6YevHa7xBnkH4V94bU4oNy4p/zqJuu
	 o6DttB6rgKg1nvdT4+n17MpVCt3vdY8NIuDhDjD7swqyvREdE5Ai5GkHXNWgdTjWMFKWd
	 jDWMYblnrDgvau2zxzZFMOVOdgE+mBZb2t3Lp8gbk5GagXrhXUXc/XTtMvKyLExsLgBDW
	 HfBpTWVkJeh7Lt9SZx+p5keo46KStlJb8ex76dBTJrycAitBpzT1EObbwuaA1yk7qWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=g0BsCETI;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E15606A893
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 18:18:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82E15606A893
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=g0BsCETI
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 711F8C4F755;
	Fri, 13 Nov 2026 18:18:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8D04A60015;
	Fri, 13 Nov 2026 18:18:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 079F711BC17F0;
	Fri, 13 Nov 2026 19:18:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794593921; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=YMmgQJzMtgBLpA0dIqJ/1stJoQj5sUUq2ttQetzsqvg=;
	b=g0BsCETI93Z/vfFeXyPOJ+wzeIFI6lkh5ApLVBfCqngmB8VuE3lgNx75ASl9xFGzHvNAdg
	krnVf3mAFlgbjTFnYU0f9dpTgSjMOe72qiAe0g1vpjRYz6eJVqyClQDdCRdekbA3FjCL4q
	DBNU/2YFYRhaaZ7t7HcHnuzAkJ1bUw7cq8reOM0XCoGUq8fUgW+6xap8gO4HDWfi3MtEfq
	1ayZ91VLFHUfLD1vH+ZriMiLXZk/fDrQchCULwXig+YrX8fvt+IuWlV9VX4DjD62/nh5Yk
	UABhQ5nIjbbNUbuTZWTBJqRzRMOHwiTVqTh5X5ewzQSoREPEJ+jISsu9igODXw==
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 13 Nov 2026 19:18:32 +0100
Message-Id: <DMUAG5X9SJS5.3IJRLV67X9SXH@bootlin.com>
Subject: Re: [PATCH net-next v6 2/2] net: macb: distribute evenly Tx SRAM
 segments
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Nicolai
 Buchwitz" <nb@tipi-net.de>, "Paolo Valerio" <pvalerio@redhat.com>,
 "Vladimir Kondratiev" <vladimir.kondratiev@mobileye.com>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>, =?utf-8?q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>, "Tawfik Bayouk" <tawfik.bayouk@mobileye.com>,
 "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>,
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
To: "Conor Dooley" <conor.dooley@microchip.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@kernel.org>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Russell King" <linux@armlinux.org.uk>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261113-macb-set-channels-v6-0-5de59d9e7f02@bootlin.com>
 <20261113-macb-set-channels-v6-2-5de59d9e7f02@bootlin.com>
In-Reply-To: <20261113-macb-set-channels-v6-2-5de59d9e7f02@bootlin.com>
X-Last-TLS-Session-Version: TLSv1.3

On Fri Nov 13, 2026 at 6:32 PM CET, Th=C3=A9o Lebrun wrote:
> +/*
> + * Distribute evenly available segments across queues. The computation i=
s
> + * complex because (1) segments are counted in powers of two and (2) a q=
ueue
> + * can only use up to 8 segments. There are four types of cases:
> + *  - Sharing all segments equally is doable. Take num_queues=3D4 and
> + *    num_segments=3D16. Each queue will get 2^2=3D4 segments.
> + *  - Sharing all segments is doable. Take num_queues=3D5 and num_segmen=
ts=3D16.
> + *    Three queues will get 2^2=3D4 segments and two will get 2^1=3D2 se=
gments.
> + *  - Sharing all segments is not doable because not enough queues are
> + *    available. Take num_queues=3D1 and num_segments=3D16; queue 0 can =
only have 8
> + *    segments.
> + *  - Sharing all segments is not doable because not enough segments are
> + *    available. Take num_queues=3D4 and num_segments=3D2.
> + *
> + * We start by computing the power each queue will have. For num_queues=
=3D5 and
> + * num_segments=3D16, each queue will have at least 2^1 segments. That l=
eaves us
> + * with remaining_segments=3D6. If we increase the power for a queue, we=
 get a
> + * delta of 2 (2^2-2^1). The first three queues will therefore be advant=
aged
> + * and each have 2^2 segments. The remaining 2 queues will only have 2^1
> + * segments.
> + */
> +static u32 gem_sram_distribute_segments(unsigned int num_queues,
> +					unsigned int num_segments)
> +{
> +	unsigned int pow, remaining_segments, i;
> +	unsigned int num_advantaged_queues =3D 0;
> +	u32 val =3D 0;
> +
> +	/* When growing the max # of queues, make sure to return a u64 here and
> +	 * to write into GEM_TXQSEGALLOC_UPPER.
> +	 */
> +	static_assert(MACB_MAX_QUEUES =3D=3D 8);
> +
> +	/* pow=3D0 for all queues. ilog2(0) is dangerous. */
> +	if (num_queues >=3D num_segments)
> +		return 0;
> +
> +	pow =3D min_t(unsigned int, ilog2(num_segments / num_queues), 3);
> +	remaining_segments =3D num_segments - num_queues * (1U << pow);
> +
> +	/* We can only distribute remaining segments if (1) there are remaining
> +	 * segments and (2) we did not reach the max segments per queue (2^3).
> +	 */
> +	if (remaining_segments !=3D 0 && pow !=3D 3) {
> +		unsigned int delta =3D (1U << (pow + 1)) - (1U << pow);
> +
> +		num_advantaged_queues =3D remaining_segments / delta;
> +	}
> +
> +	for (i =3D 0; i < num_advantaged_queues; i++)
> +		val |=3D field_prep(GEM_TXQSEGALLOC_MASK(i), pow + 1);
> +	for (i =3D num_advantaged_queues; i < num_queues; i++)
> +		val |=3D field_prep(GEM_TXQSEGALLOC_MASK(i), pow);
> +
> +	return val;
> +}

This implementation doesn't use all segments if
num_segments > 8*num_queues. Reported by Nicolai and discussed here [0].
I don't think any hardware lands in that case, but let's fix the bug.
I will let some time pass before iterating.

[0]: https://lore.kernel.org/all/1113dac19771ff7881b60bfdd14b0af6@tipi-net.=
de/

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

