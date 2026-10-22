Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792635085;
	b=wgyFOf43cx8GZTJFxNsdWv/s4ddUVMt/mC7l34BbrdoHdApxxaBi2qwNBykJr/9l2e+6
	 kT96BNNxJeMf9vTOgHGruTHs19YCm87zNIZOjINUvLtHomdA8/l2OlvA90N+ze7OXxLn1
	 rd6vzvXAhaNc5219aEv9emWKsCCCsethouIm9sK2PqkWcC9YAh5NhcYL0JJ4lsztXiot5
	 NomepRqZ6ltOC8hZJf0AGIEC46sSriY/YMSMPcJd4PIeSSJYdhwGB5TiMgqi/BhwjsGpS
	 NlJeDBVnCnZXx6hoVONYQjzNjfSSavkg/kE1mhIBKWEatrMRe/65t4gmuShoYzNAObQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792635085;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=auptAOYLlT7TARSAwJhMjYGyHIhmiPBoj76ZVpTPfkA=;
	b=EC5SrUywT9HDMXSL4a58TY5LzmYLlPe2YBqt2luTMCn/bwRykVrCiNbdZE8wbJIkPLLW
	 3KEknbTDn0Lm0j4HxVKvP3S9vnf9XwoIjDTenX3y05SYIkFweeb5RGM6UIeEY4/3CccAo
	 Vscad9RRW446YYmGQjB32T2FfHfkesTbn8k0/t5cy/mMZkvOlt+Wo4z6VD2YqWQvLiD3a
	 Bd4Jd4N5Etg+lXQ65xLbAcpa8fB+eg8NwooFZdX4iMzzQb0EcPMX4wzckmi6xU/N9cGyS
	 IyJw5WEV2+DbvJ+q7YlETUCSkrkhhMEbWBAjbbHEC5lLEvnuPuNDYuRJs28N/1rxyeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jbBvCW29;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D86606A31E;
	Thu, 22 Oct 2026 02:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jbBvCW29
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BC1F1F000C2;
	Thu, 22 Oct 2026 02:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792635085;
	bh=auptAOYLlT7TARSAwJhMjYGyHIhmiPBoj76ZVpTPfkA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jbBvCW29Ars2ITitkCDMi9Wi3YvKH504taXn3iFjh4y8wjlBh8qfNQvC7j8xYR+JM
	 fC1G/Wawa3al9+64HYfN5mxZh191BHVbwYSMbuCYD1D43ur3nrX6ssal7CCZ83f8Fp
	 75GojiHxjocnpSx9Xpbe/fbYY1uqwWwcKqahZSkJinIFYU9laDB0ESSTgKFkEYUphy
	 H3+H0gY8HNGdt21zWcxspzQD7WFerGDC3Nn1Q8KEvfHufST64LO1zhPxQn/mrCJjdx
	 PK4004yyTw7lp8MOIrTmRUP53W+a+iJCz0+oACvDs2fjkXPofy8WPWnOrmEu/8m17p
	 0tpMiebWnc0/w==
Subject: Re: [PATCH net-next v16 3/5] net: dsa: motorcomm: use fixed-width
 GENMASK_U*() helpers
From: netdev-bot+sashiko@kernel.org
To: kyle.switch@motor-comm.com
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mmyangfl@gmail.com,
 horms@kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
 xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com, wei.zhang@gl-inet.com,
 sijia.huang@gl-inet.com
Date: Thu, 22 Oct 2026 02:11:24 +0000
Message-ID: <179263508406.3135.842025919352184457@kernel.org>
In-Reply-To: <20261020111115.3072180-4-kyle.switch@motor-comm.com>
References: <20261020111115.3072180-4-kyle.switch@motor-comm.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message for "net: dsa: motorcomm: use fixed-width
  GENMASK_U*() helpers" does not match the diff, in three ways.

--

net: dsa: motorcomm: use fixed-width GENMASK_U*() helpers

This commit changes two GENMASK() uses in the YT921x DSA driver to
GENMASK_U32(): the FILTER_UNK value in yt921x_chip_setup_dsa(), and the
mii_bus phy_mask in yt921x_mbus_int_init(). The commit message describes
it as a type-only cleanup with no functional change.

> Some masks assigned to u16 and u32 fields are defined with
> GENMASK(),which is an unsigned long constant and wider than
> the field type on 64-bit builds. Convert the YT921X_MBUS_CTRL_*
> masks used by mdio_bus.c to fixed-width helpers.
>
> This is a type cleanup only, with no functional change. Other
> GENMASK() uses in the driver are intentionally left untouched.

[Severity: Medium]
Does this description match the diff?

The patch doesn't modify drivers/net/dsa/motorcomm/mdio_bus.h, and the
YT921X_MBUS_CTRL_* masks there still use plain GENMASK():

#define  YT921X_MBUS_CTRL_PORT_M		GENMASK(25, 21)
#define  YT921X_MBUS_CTRL_REG_M			GENMASK(20, 16)
#define  YT921X_MBUS_CTRL_TYPE_M		GENMASK(11, 8)  /* wild guess */
#define  YT921X_MBUS_CTRL_OP_M			GENMASK(3, 2)  /* wild guess */

They are still combined into u32 locals in yt921x_intif_read(),
yt921x_intif_write(), yt921x_extif_read() and yt921x_extif_write(). For
example:

	mask = YT921X_MBUS_CTRL_PORT_M | YT921X_MBUS_CTRL_REG_M |
	       YT921X_MBUS_CTRL_OP_M;

The only change in mdio_bus.c is the phy_mask expression in
yt921x_mbus_int_init(), and that is not a YT921X_MBUS_CTRL_* mask:

	mbus->phy_mask = ~GENMASK_U32(max_ports - 1, 0);

Later patches in the series don't seem to convert these masks either.

The message also says other GENMASK() uses are left untouched, but the
patch changes the open-coded value in yt921x_chip_setup_dsa() in chip.c:

	ctrl = GENMASK_U32(10, 0);
	res = yt921x_reg_write(priv, YT921X_FILTER_UNK_UCAST, ctrl);

The message doesn't mention this change. The named mask for the same
field, YT921X_FILTER_PORTS_M in chip.h, is still GENMASK(10, 0).

Both changed sites are u32, so the reference to "u16 and u32 fields"
doesn't match the diff either.

The message may describe a different version of this patch. Could it be
rewritten to describe the two conversions that are actually made? The
other option would be to convert the mdio_bus.h masks as described, and
then drop or explain the chip.c hunk.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261020111115.3072180-1-kyle.switch%40motor-comm.com
