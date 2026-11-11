Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794411512;
	b=zs0k1HhjRE5tWmGpgr4idO8eVWUye5kB70caXmfBrJL+fAo2MyEu96KrpMh1DZgKtc+s
	 IBy9dyl9rvPILjzOQI7kxheul6rilD+6PaPMGJ6/O9fjALMSomcaBhMANo1ANqH9eoH3U
	 OjF8FiF1Gso22Lr49fzQOmZYxe7V+SGmjf2/4HhNnegUkO/Quskp/3ut92CqwSTHP/rzO
	 U+sOKd1E3f5SRRkIqN4jEcuIKO5LEJ6KoA7mkk1wG7VTFMGIw5NnSdxfpn0NLFjA5B1wH
	 tZYC70CKh1gsEW5wUpHKB1DQzZIZX42H9zqGXtygeMgYzfeYCgk8GK6EUQmgz0Qtunw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794411512;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=TEvRSsKR5xs8YQSy5o2nBc/tYG6RojwW1Cuv81ErJuA=;
	b=MQ7Hi9ah8+BYpTbKVS92frXpzJpvs3T4lqoLpEt0MSVsHQYPbgdpJRX+iaG2hwclrnmI
	 ZMlKF8IGu33OTshoZP0vDaQN+mMQq5UMmcI+ocbVVys7K8nZmz2ZLeKlQoPMvXwTJiveg
	 1vYj5imVL+WYxHuhlGuFoN9Yy40G2bKyo9CoWVSxqxJdMv9mMefsXe8BRcJrZbViEo7ny
	 HPFBGWqVmg/XVXrUTh7iH2KT14Ur2UIlEiDJyWxNul7qFKQ0NfU7BvL3lnymPIgYa2Szx
	 OIFWVbRSa47WcbFRlOyEyy0qynr6C7m4JY6ydE6YijWH6brReZPBjCQmjmZ/1gMu3Qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="jInUJ/jo";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7834606A324;
	Wed, 11 Nov 2026 15:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jInUJ/jo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BD1A1F00A05;
	Wed, 11 Nov 2026 15:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794411511;
	bh=TEvRSsKR5xs8YQSy5o2nBc/tYG6RojwW1Cuv81ErJuA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jInUJ/joXmAvAjXofXhzBoowYvUBv/zZ4aYtnkoTJm0oLycIf/MhWZ2jd6/ZpjDpE
	 niuk9wZxf6alTP0USL/m1pS9rU0BCnIv5KoH1BsCgia+2UqcxYrgBPb9kwZvhdLwAe
	 sRzNdXWq9un6pd3vO3FNPAEDbJYqeMXz1A6r6+5Q3Yt7VPQ5rK7wog6yK9xNBz67ya
	 o1ovH8K5GI4bACJ4BIlR1WwzvSFgps53jkfP1weif4iSY1aRJ6VK60bmeXAdqXNDKq
	 CRIXpWgZSmNAOpMiSeUrvhMH7qCjoTKyfKwpwwLGgmiMTSrhfLrvFklFVBEKPHsxGA
	 2yhWNkwyQI+YA==
Subject: Re: [PATCH net] net: dsa: motorcomm: Do not inherit ports from
 dynamic FDB entries
From: netdev-bot+sashiko@kernel.org
To: mmyangfl@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Date: Wed, 11 Nov 2026 15:38:30 +0000
Message-ID: <179441151084.2199510.11035302452325241587@kernel.org>
In-Reply-To: <20261109153407.1761032-1-mmyangfl@gmail.com>
References: <20261109153407.1761032-1-mmyangfl@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] This patch replaces the egress port mask in yt921x_fdb_join()
  (drivers/net/dsa/motorcomm/chip.c) only when the existing hardware…

--

net: dsa: motorcomm: Do not inherit ports from dynamic FDB entries

This patch changes yt921x_fdb_join() so that when the existing hardware
FDB entry is not static, its egress port mask is replaced instead of
merged. The goal is to avoid converting hardware-learned ports into a
static entry that DSA does not track and can never delete.

> diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
> index 33e5fc127244d..150c51f1aa358 100644
> --- a/drivers/net/dsa/motorcomm/chip.c
> +++ b/drivers/net/dsa/motorcomm/chip.c
> @@ -799,7 +799,10 @@ yt921x_fdb_join(struct yt921x_priv *priv, const unsigned char *addr, u16 vid,
>  
>  	ctrl1 = val1 & ~YT921X_FDB_IO1_STATUS_M;
>  	ctrl1 |= YT921X_FDB_IO1_STATUS_STATIC;
> -	ctrl2 = val2 | YT921X_FDB_IO2_EGR_PORTS(ports_mask);
> +	ctrl2 = val2;
> +	if (ctrl1 != val1)
> +		ctrl2 &= ~YT921X_FDB_IO2_EGR_PORTS_M;
> +	ctrl2 |= YT921X_FDB_IO2_EGR_PORTS(ports_mask);

[Severity: High]
If the existing entry is already static, this path still ORs the new port
into the mask, and it does so for unicast addresses too. Can a static
unicast entry still be "silently expanded and can never be deleted"
when it moves between ports?

One sequence that seems to reach this:

  bridge fdb add <mac> dev swp0 master static
  bridge fdb replace <mac> dev swp1 master static

In net/bridge/br_fdb.c:fdb_add_entry(), fdb_update_dst() sees that the
port changed and returns true. The bridge then calls only
fdb_notify(br, fdb, RTM_NEWNEIGH, true). As a result,
br_switchdev_fdb_notify() sends SWITCHDEV_FDB_ADD_TO_DEVICE for swp1
and sends no delete for swp0.

For user ports, dsa_port_do_fdb_add() in net/dsa/switch.c calls
ds->ops->port_fdb_add() directly. That ends up in
yt921x_fdb_join(priv, mac, vid, BIT(swp1)).

The hardware entry is already STATIC there, so ctrl1 == val1. The new
clear of YT921X_FDB_IO2_EGR_PORTS_M is skipped, and EGR_PORTS becomes
swp0 | swp1. Unicast frames to <mac> would then go out both ports, while
the bridge thinks the address is only on swp1.

A later delete on swp1 goes through yt921x_fdb_leave(), which clears only
the departing port's bit:

	ctrl2 = val2 & ~YT921X_FDB_IO2_EGR_PORTS(ports_mask);
	if (ctrl2 == val2)
		return 0;
	if (!(ctrl2 & YT921X_FDB_IO2_EGR_PORTS_M)) {

That leaves a static entry pointing at swp0 in hardware. The driver only
flushes with flush_static=false, so nothing would remove that entry
later.

A host FDB entry on the CPU port, installed with
assisted_learning_on_cpu_port, looks like it can reach the same path
when a replace moves the address to a user port.

For comparison, mv88e6xxx_port_db_load_purge() replaces the port vector
for static unicast and merges only otherwise:

	if (state == MV88E6XXX_G1_ATU_DATA_STATE_UC_STATIC)
		entry.portvec = BIT(port);
	else
		entry.portvec |= BIT(port);

Hardware-learned entries can only be unicast, because source MACs are
never multicast. Would it work to decide based on the address instead,
for example by replacing the mask when !is_multicast_ether_addr(addr)
and merging only for MDB entries? That would cover both the dynamic
case this patch targets and the static port-move case above.

>  	if (ctrl1 == val1 && ctrl2 == val2)
>  		return 0;
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261109153407.1761032-1-mmyangfl%40gmail.com
