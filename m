Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794353213;
	b=pauSTh+o9oE179MUl5HpWBd+h/7WxkvaI0nPL4OOl0EyGH2xK0raZ4KgIboS78Fby/0x
	 AnVa9loWetHmoQdyr28hs4aYfDc1O95BXH79q3r0dBQiEuSPDKD8rfoq2N9ey/uVzVkJC
	 uNssM7KqabBKcXSpOTQP4LIjCi0GkSNiXQWRJPhyc9WCXHp4cszuIpXpWH66yjinODDJw
	 DX4/9fkmo5sI3zCWEEFW2zr9gIRuqYfKhtGa0ogmJ3gbTZCTXwzYDJXtsUBmOinKkNNqF
	 zwCmdkv+m+fm7cMIBY843kqZei9Cs942CD6NMEow1cnCSM89VvpfKNlGEZqe3r8jYJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794353213;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=dkkjz90Suz+xU/M9ypVYo1fqYZs9S1zPBs/lFY8imtM=;
	b=hN5XRiQgLBMrkTUomaBwGziNTjXuJyNxV4MK6TOAHn5Ly4qH729mD7upItWO0wyXxxw8
	 t2i5gSkekN540WWwRmA95Agm5KCqB3+GK2yFPq2pcZr1YXWzmLIHG4IpbZERkGfndphve
	 sXpNebSmMJYQUMQr4LjaMsPJ6rQYJRb1GALqt+bzbgSAZ9eTHduXzVhSzuoOWPo/RUMKD
	 3qgVQL8fHVex6YFFD9egiJkK4oIU8YkaXZ/ehCMKSKljdntHErlt1TJiX4UECnxOcKRLw
	 Q2rI2PxtjK+ZvxHCRQWfdFPhmT+lXfSevbUlK8c3glJY8uJFwMFlCMjxdTuwSbKymvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="SMqYm/0Y";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77ED606A335;
	Tue, 10 Nov 2026 23:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SMqYm/0Y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB8E91F0093D;
	Tue, 10 Nov 2026 23:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794353213;
	bh=dkkjz90Suz+xU/M9ypVYo1fqYZs9S1zPBs/lFY8imtM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SMqYm/0YGCG6mtuFtGslnCPPOfgI/ePVXB62hFOdhcunKGY6o8IiU3knvDBUo8JF5
	 ELBVh5p+Gjh37PPtbJwU6kM7LEVRCjB9hZrJX2rAeXvRSlvR/qvjH52yr+vwqi/PAn
	 K5wn1Byww5lvNZieDSeX1fqipgRp0HqDBkVQTRBWNSvGzNLGG4aKc8La2R70+yYN1f
	 CBpnJ8wa0ibIbLJJ28JBV/uBwhSTv1H5ZH8n0tj+Qp5FLgN25Y/ci0mlIqpq1BTxEB
	 RdVZAteSl9NiF7Lc2+d6WJSvwrxqqw8Wr0gOhdlqcUN5TzMcu22hQ4rgoB5kF4znd9
	 +QGlWt4t1iLNg==
From: Jakub Kicinski <kuba@kernel.org>
To: kyle.switch@motor-comm.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	mmyangfl@gmail.com,
	horms@kernel.org,
	linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ming.xu@motor-comm.com,
	xiaolin.xu@motor-comm.com,
	jianmin.wang@motor-comm.com,
	wei.zhang@gl-inet.com,
	sijia.huang@gl-inet.com
Subject: Re: [PATCH net-next v17 3/5] net: dsa: motorcomm: use fixed-width GENMASK_U*() helpers
Date: Tue, 10 Nov 2026 15:26:52 -0800
Message-ID: <20261110232652.2437155-1-kuba@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105031442.4164960-4-kyle.switch@motor-comm.com>
References: <20261105031442.4164960-4-kyle.switch@motor-comm.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: dsa: motorcomm: use fixed-width GENMASK_U*() helpers

This patch replaces two GENMASK() uses in the motorcomm DSA driver with
GENMASK_U32(). One is in yt921x_chip_setup_dsa() in chip.c and the other
is in yt921x_mbus_int_init() in mdio_bus.c. It is described as a type
cleanup with no functional change.

> Some masks assigned to u16 and u32 fields are defined with
> GENMASK(),which is an unsigned long constant and wider than
> the field type on 64-bit builds. Convert the YT921X_MBUS_CTRL_*
> masks used by mdio_bus.c to fixed-width helpers.
>
> This is a type cleanup only, with no functional change. Other
> GENMASK() uses in the driver are intentionally left untouched.

[Severity: Medium]
Does this description match the diff? The patch doesn't seem to touch
the YT921X_MBUS_CTRL_* masks at all. After this patch they are still
plain GENMASK() in drivers/net/dsa/motorcomm/mdio_bus.h:

#define  YT921X_MBUS_CTRL_PORT_M		GENMASK(25, 21)
#define  YT921X_MBUS_CTRL_REG_M			GENMASK(20, 16)
#define  YT921X_MBUS_CTRL_TYPE_M		GENMASK(11, 8)  /* wild guess */
#define  YT921X_MBUS_CTRL_OP_M			GENMASK(3, 2)  /* wild guess */

They still feed the u32 mask variables in yt921x_intif_read(),
yt921x_intif_write(), yt921x_extif_read() and yt921x_extif_write(),
for example:

	mask = YT921X_MBUS_CTRL_PORT_M | YT921X_MBUS_CTRL_REG_M |
	       YT921X_MBUS_CTRL_OP_M;

No later patch in the series converts them either.

The two lines the patch does change are not MBUS_CTRL masks. In
yt921x_chip_setup_dsa(), the mask written to YT921X_FILTER_UNK_UCAST
and YT921X_FILTER_UNK_MCAST is changed:

	ctrl = GENMASK_U32(10, 0);

That seems to contradict "Other GENMASK() uses in the driver are
intentionally left untouched".

The other change is the phy_mask calculation in yt921x_mbus_int_init():

	mbus->phy_mask = ~GENMASK_U32(max_ports - 1, 0);

Also, the message refers to "masks assigned to u16 and u32 fields",
but none of the changed lines involve a u16 field.

Both changed lines give the same values as before, so runtime behaviour
does not change. Only the description is off.

Could the message be reworded to describe the FILTER_UNK and phy_mask
changes, with the "left untouched" sentence dropped? The other option
is to convert the YT921X_MBUS_CTRL_* masks in mdio_bus.h as the
message says.
