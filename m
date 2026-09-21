Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CAF45C6EA;
	Mon, 21 Sep 2026 09:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789983332; cv=none; b=U37GbiUxHEA6ZtZCcNDjJN+TnBV1VH8unG790OVr8QT4d1xRNacnGw/+0C3NnVo0E9DQIj7V6j3FwjNUOz1mo49gJ44XAW3DM1Rc4qeeWduNJN059c2PU0P1n8tvYAtoqPis/J2ECcks449+fYzEQIw1DHfaANbcTv2O5Aj/jJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789983332; c=relaxed/simple;
	bh=27OyOfRiVzCT/5KrICe3uk9p3tyjRsj4FOJCxNI1D+k=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RUyWGKWujHZyhET54Opnto9ndN4moch7tnhK6MSXTGku/h2i0PsYmAsPouPXVQ4zlUaeT9mKCdxGs5DTQn/OC77hU459ghuSq/lbMzvDVfxgtC50G6lGAy/2Jh8vS/spAKyxRHmQuAKjksXyot6hdT+jbbnqICpS+zW1itUefwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LcuDV+BE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LcuDV+BE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B06EC1F00893;
	Mon, 21 Sep 2026 09:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789983330;
	bh=Z5LVq+tHONURqS34gYbM33Mx3LEDN6lVcKjOUP7Do0o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=LcuDV+BEkNFfd+sktedE/dFtJFNzeeq3Ylyic9SdFKkSv0VLCyImxumAExoUKZiKV
	 rWgNZN3+9/uz5xNeRWP6YMZP75edaJLfZWXo6VUMhRm+Rae1mU4TzmAZCQ3S3JiM1M
	 umN3sQwynmaLHvDBe1JZnG62icw0+1uN2gVWaAhS+WXJVz1PPLgAjumZ68Ew1aekXT
	 xppwYa4p8uoOBHzwsIrH53M/2v+5WRcAK0wTubdPXtQLqAf0hkWHfO4RzKiZ7sGLKw
	 3KEYDPUiYy2obqv/YrZwNygzN6uahtkj6NLinLe6fq3OT6bvzNl4qNP2S8JNKWOebz
	 vDbV+dmrhPfHg==
Subject: Re: [PATCH net-next v8 4/6] net: dsa: motorcomm: move mib stop from
 remove() to teardown()
From: netdev-bot+sashiko@kernel.org
To: kyle.switch@motor-comm.com
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mmyangfl@gmail.com,
 horms@kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
 xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com, wei.zhang@gl-inet.com,
 sijia.huang@gl-inet.com
Date: Mon, 21 Sep 2026 09:35:29 +0000
Message-ID: <178998332930.2160803.10512360025617121984@kernel.org>
In-Reply-To: <20260917082236.3427168-5-kyle.switch@motor-comm.com>
References: <20260917082236.3427168-5-kyle.switch@motor-comm.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] Commit message inaccuracy plus fragile use of a counting-disable
  API.

--

net: dsa: motorcomm: move mib stop from remove() to teardown()

The per-port MIB polling work is now disabled in yt921x_dsa_teardown()
instead of yt921x_mdio_remove(). The loop calling
disable_delayed_work_sync() on priv->ports[i].mib_read is moved verbatim
from the mdio remove path into the DSA teardown op.

> diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
> index 167b208357710..2412fe2f696f8 100644
> --- a/drivers/net/dsa/motorcomm/chip.c
> +++ b/drivers/net/dsa/motorcomm/chip.c
> @@ -4233,6 +4233,11 @@ static void yt921x_dsa_teardown(struct dsa_switch *ds)
>  #if IS_ENABLED(CONFIG_NET_DSA_YT921X_LEDS)
>  	yt921x_leds_remove(priv);
>  #endif
> +	for (size_t i = ARRAY_SIZE(priv->ports); i-- > 0; ) {
> +		struct yt921x_port *pp = &priv->ports[i];
> +
> +		disable_delayed_work_sync(&pp->mib_read);
> +	}
>  }

[Severity: Low]
The changelog says this change "ensures symmetry with the MIB start
operation, which is already invoked in the setup()".  Is that accurate?
The only MIB work operation in yt921x_dsa_setup() is the initialization:

	INIT_DELAYED_WORK(&pp->mib_read, yt921x_poll_mib);

The polling is actually started from yt921x_phylink_mac_link_up():

	schedule_delayed_work(&priv->ports[port].mib_read, 0);

and re-armed by yt921x_poll_mib() itself:

	schedule_delayed_work(&pp->mib_read, delay);

So what the new teardown call pairs with looks like the work
initialization rather than a start.  Would it be worth rewording that
sentence?

A second question about the API choice here.  disable_delayed_work_sync()
is a counting disable:

kernel/workqueue.c:disable_delayed_work_sync() {
	return __cancel_work_sync(&dwork->work,
				  WORK_CANCEL_DELAYED | WORK_CANCEL_DISABLE);
}

The disable depth it leaves in work->data is only cleared by
enable_delayed_work(), and there is no enable_delayed_work() call anywhere
under drivers/net/dsa/motorcomm/.  ds->ops->teardown is repeatable —
dsa_switch_teardown() runs it on unregister and the dsa_switch_setup()
error path runs it too — and a later ->setup() can run on the same priv.

Today this still works only because yt921x_dsa_setup() re-runs
INIT_DELAYED_WORK() for every port, which resets work->data and silently
drops the accumulated disable count.  If that one-shot init is ever moved
back to probe(), which is the more usual DSA pattern, would the
schedule_delayed_work() in yt921x_phylink_mac_link_up() become a no-op
after the first teardown/setup cycle, freezing the per-port MIB counters?

Would cancel_delayed_work_sync() in teardown (or an explicit
enable_delayed_work() in setup) make the pairing symmetric without
depending on the re-init side effect?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917082236.3427168-1-kyle.switch%40motor-comm.com
