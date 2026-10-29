Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793246923;
	b=b8Jln8HM9bsfkmjcGZlAgNOWppr5hzoUXlu2/M+bUkiRFJ7PgiHXxjYdtvXA4O9CKaRo
	 Raov0obYvSPSEcifyHyLr1Ph9qREXpJv1pTBd4I26dbv7wE2Y89jx78BabI4B2VfcjWvf
	 Vz7Qi7gyX6MXG93TzSl4BkE5gvNYFHxkuJsX3FVQqvin5uGuZCCISJxCglwo/vNNwwyBC
	 zMTMLRf1wTO4twz7vgWHDi3B0CByj6gRzyxraadX30gwXYvh5FU/89Uhi+jam6FB5I3t3
	 YsaRQALU9LjMIVu9NPFcp91eSg4ObC9gD5GQOTULlExcYZmVDo9Z4BcFlNeLtf8VUiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793246923;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=rNJzeTZD4jfhviFLrLVUszsSvyifhrVAvFVCNMWMNb4=;
	b=f4qVJFv51TBoBpqHOncVk1Z8OT900+hDRydciW2+39uM2M3XaLAYOofZJ9GcXvgWNEYc
	 W4rudzR4D4YzwtlJxLwrmdohvykjorYVts2xKH0WF9j+ZTcvhmQ2qpWxZYjw7Nzbn8PmT
	 vIbqXkMVGGxEfgWG56KUu1vU6wi4tQLYkHmS68yZz6GOlhpt0Hfp0xMz5pfVALmyKQETY
	 sggss1cXS9T2R3mBzGJTJuW3sYoowQlNR+6+AQkYBPajHPH0NgOQmc8oRkJeME5QdkOJD
	 EsRcDYfLWzUVjV8uLKY1433cVTQ3n/n9pdhyHVzEUgADbT+1DLgiCJeN5OldVvyt9TQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MvwZSlRj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E949606A31A;
	Thu, 29 Oct 2026 04:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MvwZSlRj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 831C11F01825;
	Thu, 29 Oct 2026 04:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793246922;
	bh=rNJzeTZD4jfhviFLrLVUszsSvyifhrVAvFVCNMWMNb4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MvwZSlRjSEfpHD1tnJyouuGCNVVKD2OQ8BziuYkLbwaXMIvF92fmqbbShjPw/BGAy
	 s/VcSVcB3CpSSZyID1BrugVjkSLwg1Sepw1eCjKmbyLhfOyY+xHF8ZL/99JoINNJNm
	 1+Vo9A3tWUuzPQvM7Dm4HowxKJZyIYgpsCGp/cIU4Ty7ewhAYC+6UyF4p/MjsChyqk
	 AKPRTMshLZyPbAJUfo0GhsUQRkgAuARfypFTfywoiZqhXhjG8b6wRZJ6cffHzY6p05
	 UntDRvq071Ya26lPtqrVnUy7UbudRPuTxkcacw8aNxWeXNb1MV5Ow2IOTo1+Pl6SEx
	 tMQ56RZf54LCg==
Subject: Re: [PATCH net v3] gtp: Require 'CAP_NET_ADMIN' when joining the gtp
 multicast group
From: netdev-bot+sashiko@kernel.org
To: anilkaushikwireless@gmail.com
Cc: pablo@netfilter.org, laforge@gnumonks.org, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, nicolas.dichtel@6wind.com,
 osmocom-net-gprs@lists.osmocom.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Thu, 29 Oct 2026 04:08:41 +0000
Message-ID: <179324692107.3134.14443689892607921337@kernel.org>
In-Reply-To: <20261027130623.3136658-1-anilkaushikwireless@gmail.com>
References: <20261027130623.3136658-1-anilkaushikwireless@gmail.com>
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

- [High] An unprivileged local user can still receive gtp multicast
  notifications (PDP add/delete and echo responses) by joining the…

--

gtp: Require 'CAP_NET_ADMIN' when joining the gtp multicast group

This patch marks the gtp generic netlink multicast group with
GENL_MCAST_CAP_NET_ADMIN in drivers/net/gtp.c and with uns-admin-perm in
the gtp netlink spec. The goal is to stop unprivileged users from
receiving the PDP context add/delete and echo response notifications,
which carry the same data as a GETPDP reply.

[ ... ]

> diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
> index 86c8c88b702cf..1dd32e979cf59 100644
> --- a/drivers/net/gtp.c
> +++ b/drivers/net/gtp.c
> @@ -118,7 +118,8 @@ enum gtp_multicast_groups {
>  };
>  
>  static const struct genl_multicast_group gtp_genl_mcgrps[] = {
> -	[GTP_GENL_MCGRP] = { .name = GTP_GENL_MCGRP_NAME },
> +	[GTP_GENL_MCGRP] = { .name = GTP_GENL_MCGRP_NAME,
> +			     .flags = GENL_MCAST_CAP_NET_ADMIN, },
>  };

[Severity: High]
Can an unprivileged user still get these notifications by joining the
group ID before the gtp family is registered?

The flag is only checked in genl_bind(), and only when a registered
family owns the requested group. If no family owns it, the loop matches
nothing and ret stays 0:

net/netlink/genetlink.c:genl_bind() {
    ...
	int ret = 0;
    ...
	idr_for_each_entry(&genl_fam_idr, family, id) {
    ...
		i = group - family->mcgrp_offset;
		if (i < 0 || i >= family->n_mcgrps)
			continue;
    ...
	}

	up_read(&cb_lock);
	return ret;
}

The genl socket is NL_CFG_F_NONROOT_RECV. For NETLINK_ADD_MEMBERSHIP,
netlink_setsockopt() only checks the ID against nlk->ngroups. So an
unprivileged NETLINK_GENERIC socket can join any free ID that fits in
the current bitmap.

When gtp is loaded later, the call chain is
genl_register_family()->genl_validate_assign_mc_groups()->
genl_allocate_reserve_groups(), which gives gtp the first free ID. After
that, only __netlink_change_ngroups() runs to resize the table. Sockets
already subscribed to that ID are not cleared or rechecked.

do_one_broadcast() only looks at the socket's group bitmap and netns.
So the earlier subscriber would receive what gtp_tunnel_notify() and the
echo response path send through genlmsg_multicast_netns(...,
GTP_GENL_MCGRP, ...).

The same user can also trigger the module load. CTRL_CMD_GETFAMILY does
not need GENL_ADMIN_PERM. ctrl_getfamily() calls request_module() for
"net-pf-16-proto-16-family-gtp", and gtp.c declares
MODULE_ALIAS_GENL_FAMILY("gtp").

The commit message says:

    This fix blocks the unprivileged users.

That claim fails when gtp is built as a module and is not yet loaded
when the user subscribes.

Could this also be closed in the genetlink core? One option is for
genl_validate_assign_mc_groups() to clear existing members of newly
allocated IDs with __netlink_clear_multicast_users(). Another is for
genl_bind() to reject IDs that no family owns. Either change would go on
top of this patch, not replace it.

The same gap seems to affect other modular groups that use the
GENL_MCAST_CAP_* flags, such as the psample one.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261027130623.3136658-1-anilkaushikwireless%40gmail.com
