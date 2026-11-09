Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794262952;
	b=e+l3BD862i9eLaOu3vfg/jicGigmeERAmQAISWPWd64Jb6sSkEULWxKmYb/1fF4Zi5BT
	 M19E8Lv+jnzN7Wq/EbPFHLsdExegAU6Fr4oFMQKE1NYbiLXsVOzJAbJThy5foDIZ5tjIh
	 Kn1PdseYXBIkGMJKeR4QyGvQYe5zP+U5ilVT2zj4JBl2WJx2lG65m6ClMITtDF0bOsXDg
	 +akp/sBKzKf9KrOMdYUTsMsum12rLPcMCjs+CAFxnFgas36mBd4OAf4lZ5Il7IrzGm8Az
	 63Epgd/Hixy6YAXgNg9tBzXKmXTqyoXaBm8WSqOO4AcYl9ot4BjqkVj59nXxs43Kulg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794262952;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=OiCpC5XsB3JYKakoqgJAGxb3FzHd2zCmjhOwtLqCcWc=;
	b=PrxrPzUuXPmEuSUgw/EMl0b+LfkLsv23rKLi7gzqrQ+QSq4WBud2SqYh2kSjG+Flwgnn
	 7QX6YgmNgb8Vw7DL2jIC4WhNtq4ubo4Kad6Y6DS35cN8jpua1RW5Q7dqb1ZQjrSXPdh+Q
	 lv/ck186R0dsosbFR/Axu3FnbUnKgmlX3Hxt5Ze1KhzvERpBcXE04LhQutL4pUfIdPAdU
	 WCeUolyU7u9iBAJYD4e8l7JZ+mSQ5QidK7sy5+g2SgZEviRyQ+gOX9AQNRAaCT5wIPnhL
	 uFwhivJSAfbW+xismlY7WdLAlBumg/K27GfYRNJv4ef+BSJGcMK2TKoE7/TCX2vJdgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pc14mFzS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B16A60A261A;
	Mon,  9 Nov 2026 22:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pc14mFzS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 313761F008A3;
	Mon,  9 Nov 2026 22:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794262951;
	bh=OiCpC5XsB3JYKakoqgJAGxb3FzHd2zCmjhOwtLqCcWc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Pc14mFzS08ChMou+vLHy/VLWuEut/MmhM/CcqDlpyb4cC33r6yBXzcopmsDJvDx7Q
	 da3giONMgPOV4LK+b2fGDRnQRfY4pwLUiL7ODCHH8rARYHAmfX119IvabQSMtC7co/
	 6S6J5YLtL59C1HRJ3k1NozoiV6lOL+NXJ32K4Pbhv7t7X/4eIWxa73ytlpsNLtdDSO
	 y5djTQ+DKBv1ceyYlcwGFLCptf0ccsVN7cIn9UUHVQmuC2CaznszxcyGO/tuJS7ppr
	 kmAHdY93dRYxZ5QFTLeJEi/N5OgsHGAuVu2CqkbD/fkzWmuGyry0Fpc6UnMDnrkpBA
	 uchrsM5WgkYZw==
Subject: Re: [PATCH net-next v5 6/7] net: dsa: motorcomm: Report inconsistency
 on bridge join failure
From: netdev-bot+sashiko@kernel.org
To: mmyangfl@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Date: Mon, 09 Nov 2026 22:22:30 +0000
Message-ID: <179426295075.994134.15437406189348834005@kernel.org>
In-Reply-To: <20261108214450.1662362-7-mmyangfl@gmail.com>
References: <20261108214450.1662362-7-mmyangfl@gmail.com>
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] When yt921x_bridge_join() fails partway, the patch knowingly
  leaves the switch half-programmed and only sets an extack message.
- [Medium] In yt921x_dsa_port_bridge_join()
  (drivers/net/dsa/motorcomm/chip.c:1436-1439), a failed join is…
- [Low] The new extack text "Fatal IO error; hardware no longer
  consistent" is set for every non-zero return from…

--

net: dsa: motorcomm: Report inconsistency on bridge join failure

This commit sets an extack error message in yt921x_dsa_port_bridge_join()
when yt921x_bridge_join() fails, because DSA does not call port_bridge_leave
after a failed join. The commit message says that rolling back from the
driver would only issue more register accesses that could fail the same way.

> diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
> index 46534127d070e..3d4aa79ac0268 100644
> --- a/drivers/net/dsa/motorcomm/chip.c
> +++ b/drivers/net/dsa/motorcomm/chip.c
> @@ -1433,6 +1433,11 @@ yt921x_dsa_port_bridge_join(struct dsa_switch *ds, int port,
>  	res = yt921x_bridge_join(priv, port, ports_mask);
>  	mutex_unlock(&priv->reg_lock);
>  
> +	/* DSA does not send bridge_leave when join fails */
> +	if (res)

[Severity: High]
What state is the switch left in when yt921x_bridge_join() fails partway?
In net/dsa/port.c, dsa_port_bridge_join() does only this:

	err = dsa_broadcast(DSA_NOTIFIER_BRIDGE_JOIN, &info);
	if (err)
		goto out_rollback;
    ...
out_rollback:
	dsa_port_bridge_destroy(dp, br);

So software treats the port as standalone, but the hardware may still have
the following.

YT921X_PORT_LEARN_DIS may be cleared in YT921X_PORTn_LEARN(port) by
yt921x_userport_bridge(). The driver does not set fdb_isolation, so the
standalone port would learn into the shared FDB. yt921x_userport_standalone()
normally prevents that.

Some YT921X_PORTn_ISOLATION() registers may already have been rewritten by
the loop in yt921x_bridge():

		res = yt921x_reg_write(priv, YT921X_PORTn_ISOLATION(port),
				       ctrl);
		if (res)
			return res;

ports_mask includes the joining port. So the lower-indexed members would no
longer block the joining port, and the joining port's own register may
already allow forwarding to the bridge.

Can the switch then forward and flood traffic between a port the kernel
thinks is standalone and the bridge members, until another join/leave
cycle?

The commit message says:

  "Rolling back from the driver would just issue more register accesses
  that can fail the same way."

yt921x_reg_mdio_read() and yt921x_reg_mdio_write() each send the full SMI
address/data sequence by themselves. So an MDIO failure looks
per-transaction and may be transient. The driver also keeps doing register
I/O after this failure.

Would a best-effort call to yt921x_bridge_leave() on this error path work,
reporting the inconsistency only if that call also fails?
yt921x_bridge_leave() already exists. It runs yt921x_userport_standalone()
and then yt921x_isolate() to restore the standalone configuration.

Later in the series, "net: dsa: motorcomm: Support BR_FLOOD and
BR_MCAST_FLOOD offloading" adds yt921x_bridge_flood_set() as a third join
step. It writes the global YT921X_FILTER_UNK_UCAST/MCAST registers, and the
error path is still not rolled back there.

> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Fatal IO error; hardware no longer consistent");

[Severity: Medium]
Will this message reach anyone when extack is NULL? NL_SET_ERR_MSG_MOD()
does nothing in that case, and the legacy bridge ioctl passes NULL:

net/bridge/br_ioctl.c:add_del_if() {
    ...
		ret = br_add_if(br, dev, NULL);
    ...
}

That NULL is passed down this chain:

netdev_upper_dev_link()->dsa_user_changeupper()->dsa_port_bridge_join()
    ->DSA_NOTIFIER_BRIDGE_JOIN->ds->ops->port_bridge_join()

So brctl addif (SIOCBRADDIF) on a yt921x port would still report nothing
beyond the errno.

On the netlink path, the message goes only to the requesting socket. The
hardware state it describes stays after the reply.

The matching leave path in this driver already logs failures in
yt921x_dsa_port_bridge_leave():

	if (res)
		dev_err(dev, "Failed to %s port %d: %i\n", "unbridge",
			port, res);

Should the join path also log with dev_err(), in addition to setting the
extack message?

[Severity: Low]
Is this message accurate for every non-zero return from
yt921x_bridge_join()?

The first hardware access is this chain:

yt921x_userport_bridge()->yt921x_reg_clear_bits()->yt921x_reg_update_bits()

yt921x_reg_update_bits() does this before any write:

	res = yt921x_reg_read(priv, reg, &v);
	if (res)
		return res;

If that read fails, no register has been changed. After
dsa_port_bridge_destroy(), hardware and software still agree, yet the user
is told the hardware is "no longer consistent".

"Fatal" also seems inaccurate. The driver records no dead state, and each
SMI access is self-contained.

A more speculative case: if a register op returned -EOPNOTSUPP,
dsa_user_changeupper() would turn the join into a success:

			if (err == -EOPNOTSUPP) {
				NL_SET_ERR_MSG_WEAK_MOD(extack,
							"Offloading not supported");
				err = 0;
			}

A weak message does not replace the driver's text. The successful join
would then carry the "Fatal IO error" message.

Could the message be set only when a write has actually happened, or be
softened to something like "may be inconsistent"?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261108214450.1662362-1-mmyangfl%40gmail.com
