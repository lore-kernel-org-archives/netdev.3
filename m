Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B5F4A4F0A;
	Tue,  6 Oct 2026 18:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791312252; cv=none; b=FD02cTsHM1WZi6y1E8jdr8DpNVxq4YlOTLFHwm+Jtk5VKv2fTGjdFRDEGnnooWNQDNXvPk4juXlyWitz+oVdt1KV+OVn+bbLXExnaHbGeXa22Rc21zDPm3pV2gMnN5t5BztDN2tqD7GhUdORRQlxuKivEFd7ivKdbmBT22zqVeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791312252; c=relaxed/simple;
	bh=Ls86CNSIdHb8LRJs1RPMUqK+8asdym0W6mQdjYEVFSM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JIcjArgiBAGjbBNAHttSE4+c5sbpLTqoZRfDSLDLBaJdLAhI63Fs3xKrw/sjNV/E2p4g5rLsgIU8hEWoAa12CDSj1NS1eyY3+nz6CK8uNRc1r8EFi/fRD8OxtEQ3mwsk7ri3JFWdNgkKaBOKVNNWV/dvftOpSbToE0ucJufcRcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CkaljbBB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CkaljbBB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F1CD1F0089D;
	Tue,  6 Oct 2026 18:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791312250;
	bh=V0Ges8adtddwVMK0zuqalkUXSmD9ZO2ynCbe/PnmEes=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CkaljbBBBJagNYBAg7Q3SOM4FBxzBY06HujMRWDhUF2lBiISvJAnV5vZHNwBOTW3B
	 CJ2uDKch1d9qUyNnTFOEXlvh+E0pJeRJvH+MyFIGZR3I0pi0H0c+bMcnJJGFoy1uUV
	 9+of0GnJWn0DDL7YrWgMysfWpLqg5SlI/XDvC595beZDD6dkQgm0ItkyczflBsqgrB
	 vH0RykNFmajOtMMfvVfChH8CRQcewnFHVYWthnZCMBazxsmXsJudZWOl7/sj+W4N8q
	 LnGXVlvJXQJbM085isHMlZTDtitR4GKvvndjgHDvYZt1xCcKT8GAkGBo9V6X89rVZ6
	 D1dNYSY1YyfgQ==
Subject: Re: [PATCH net-next v11 5/7] net: dsa: motorcomm: move mib stop from
 remove() to teardown()
From: netdev-bot+sashiko@kernel.org
To: kyle.switch@motor-comm.com
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mmyangfl@gmail.com,
 horms@kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
 xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com, wei.zhang@gl-inet.com,
 sijia.huang@gl-inet.com
Date: Tue, 06 Oct 2026 18:44:08 +0000
Message-ID: <179131224893.434549.4529642748317347161@kernel.org>
In-Reply-To: <20261002173706.1225502-6-kyle.switch@motor-comm.com>
References: <20261002173706.1225502-6-kyle.switch@motor-comm.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Build failure when CONFIG_NET_DSA_YT921X_LEDS=n.

--

net: dsa: motorcomm: move mib stop from remove() to teardown()

This commit moves the loop that calls disable_delayed_work_sync() on each
port's mib_read work out of yt921x_mdio_remove() and into
yt921x_dsa_teardown(). The goal is to match the MIB start, which already
happens in setup().

> diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
> index c7cfaf2442749..9380d74d79ba2 100644
> --- a/drivers/net/dsa/motorcomm/chip.c
> +++ b/drivers/net/dsa/motorcomm/chip.c
> @@ -3924,6 +3924,12 @@ static void yt921x_dsa_teardown(struct dsa_switch *ds)
>  
>  	yt921x_leds_remove(priv);
>  #endif
> +
> +	for (size_t i = ARRAY_SIZE(priv->ports); i-- > 0; ) {
> +		struct yt921x_port *pp = &priv->ports[i];
> +
> +		disable_delayed_work_sync(&pp->mib_read);
> +	}
>  }

[Severity: Medium]
Will this build with CONFIG_NET_DSA_YT921X_LEDS=n? In yt921x_dsa_teardown(),
priv is only declared inside the #if block:

static void yt921x_dsa_teardown(struct dsa_switch *ds)
{
#if IS_ENABLED(CONFIG_NET_DSA_YT921X_LEDS)
	struct yt921x_priv *priv = to_yt921x_priv(ds);

	yt921x_leds_remove(priv);
#endif

	for (size_t i = ARRAY_SIZE(priv->ports); i-- > 0; ) {
	...

The new loop sits after the #endif and uses priv->ports. With LED support
disabled, priv is undeclared and chip.c fails to compile.

That configuration looks reachable. NET_DSA_YT921X_LEDS is a user-visible
bool that depends on "LEDS_CLASS=y || LEDS_CLASS=NET_DSA_YT921X". So it is
off when the user turns it off, when LEDS_CLASS=n, or when LEDS_CLASS=m with
NET_DSA_YT921X=y.

The old loop in yt921x_mdio_remove() used a priv that is declared
unconditionally, so the failure starts with this commit. The code is still
the same in the last patch of the series ("net: dsa: motorcomm: Add support
for Motorcomm YT922x"), so the series as a whole does not build in this
configuration either.

Could priv be declared unconditionally, with only the yt921x_leds_remove()
call left under the #if? The #if could also be dropped entirely, because
leds.h already provides a no-op inline stub for yt921x_leds_remove() when
LED support is disabled.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261002173706.1225502-1-kyle.switch%40motor-comm.com
