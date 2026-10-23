Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792738684;
	b=mwLANRdXv3lt6E+U3+COXRW3k/EY8yPaQN/HppDMgDGj896ZomXbHh7JH27FDhsmzhrQ
	 J0CICkcm2n5Loo+ZPQ/Uz6/l6p4G1OwJKkZu8zgyOPA7Me7gA5slFIlfu4cwy0Zne6JTu
	 ICAcZ3Uz4X08tX13GNiv7UEts0ibprp/7XqYRbG3g34VyuVhkSrkYhfOqMJQHVtlQvDT9
	 cUfDKIhsz63dDNU0Uu7m2Z9/4vnC65Upeefky6drNlpX7reri+pvpqUML+2koLZgnYm9j
	 EpkG2cjqPPDlXEj28GUiyujNCiRdzZBXkieMi+eNyAwC8HzZDuGKIR1mB/G02UQD73Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792738684;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=GvGhgvgqdiZI8S/8r1XTBktylfHDeaibo3EwQVJVMIs=;
	b=oNc79wtLPU8TZTElk/Xc//J6qZACy7M6oNXMEN5tbjcqH5v2z/gK0Xsx39Jyfg33dfRB
	 BS6Mtg97EWdYVig0/oRo3dgE0J/A5GmuLZexXWs+7nYhQOSB0OpZOj390jqkR3eV/Uawr
	 7OUy03mkJnURR8EJbiVPXWr8doMh9wyI6KvTvWcJnAquHHogqRFDNMd/9GBEGeEG55iFW
	 ueK9EBuseyJrCLXBuqqW/9ODJgfAYCSOyPkRDEF83aJkVxXUmXeFQlYgGraYlvVO3Co8b
	 07IyCboferNuzKGxeZ71CQ3x/UAHeEg5bAvmz9MWUh8u6F0CbsaoOF8hDrrEm8HaxGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Je3loqsd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6084606A31A;
	Fri, 23 Oct 2026 06:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Je3loqsd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 898821F01825;
	Fri, 23 Oct 2026 06:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792738683;
	bh=GvGhgvgqdiZI8S/8r1XTBktylfHDeaibo3EwQVJVMIs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Je3loqsd+wWZ95t9BFYyms+wrOvTkMKoAXYab1VhqKMNxKAV9la6aRmHJmOvDwkwf
	 hFcy2gturait/kJ0xheKkpiSl5xs/ihaXL06qk6k/s2lNKNt618HW3FRhg5igVKyvF
	 ruCiklQO4Aw7Gi3Ki5zJKYqbzC4zd/FOIUEEBixTpJx7ykspPmA3qCNNWrKDrmpL5c
	 keaHqm/HMuKt83LzwEyW2gxTJhjxY66+eTuWLVrXQIb/OOY3wYi9VRvVZOrY9GKcxn
	 C9VE5LhMHPzHeZyQaKhCmaFevhmHwdg3dNMvzcZt96436OWJp++ygHS99rD/o2edpN
	 zwbFhiBkAHdtA==
Subject: Re: [PATCH net] gtp: Require 'CAP_NET_ADMIN' when joining the gtp
 multicast group
From: netdev-bot+sashiko@kernel.org
To: anilkaushikwireless@gmail.com
Cc: pablo@netfilter.org, laforge@gnumonks.org, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, nicolas.dichtel@6wind.com,
 osmocom-net-gprs@lists.osmocom.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 23 Oct 2026 06:58:02 +0000
Message-ID: <179273868210.3134.12145105670992560597@kernel.org>
In-Reply-To: <20261021065750.2069795-1-anilkaushikwireless@gmail.com>
References: <20261021065750.2069795-1-anilkaushikwireless@gmail.com>
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

- [Medium] After this patch, the multicast group and GETPDP carry the
  same PDP-context data but are guarded by different checks.

--

gtp: Require 'CAP_NET_ADMIN' when joining the gtp multicast group

This commit marks the gtp generic netlink "gtp" multicast group with
GENL_MCAST_CAP_NET_ADMIN, so joining it requires CAP_NET_ADMIN in the user
namespace owning the network namespace. The goal is to stop unprivileged
users from reading PDP context notifications that GETPDP restricts to
CAP_NET_ADMIN holders.

> diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
> index 69fe5717846b5..e5ff1621ed620 100644
> --- a/drivers/net/gtp.c
> +++ b/drivers/net/gtp.c
> @@ -118,7 +118,8 @@ enum gtp_multicast_groups {
>  };
>  
>  static const struct genl_multicast_group gtp_genl_mcgrps[] = {
> -	[GTP_GENL_MCGRP] = { .name = GTP_GENL_MCGRP_NAME },
> +	[GTP_GENL_MCGRP] = { .name = GTP_GENL_MCGRP_NAME,
> +			     .flags = GENL_MCAST_CAP_NET_ADMIN, },

[Severity: Medium]
Does this make the multicast group check the same as the one on GETPDP?
The commit message says:

  GETPDP requires CAP_NET_ADMIN, but generic netlink lets any user join a
  multicast group by default

All of gtp_genl_ops (NEWPDP, DELPDP, GETPDP doit/dumpit, ECHOREQ) use
GENL_ADMIN_PERM. genl_family_rcv_msg() checks it like this:

net/netlink/genetlink.c:
	if ((op.flags & GENL_ADMIN_PERM) &&
	    !netlink_capable(skb, CAP_NET_ADMIN))
		return -EPERM;

netlink_capable() ends up in netlink_ns_capable(skb, &init_user_ns, cap),
so it needs CAP_NET_ADMIN in the initial user namespace.

genl_bind() checks the new flag against the netns owner instead:

net/netlink/genetlink.c:genl_bind() {
    ...
		if ((grp->flags & GENL_MCAST_CAP_NET_ADMIN) &&
		    !ns_capable(net->user_ns, CAP_NET_ADMIN))
			ret = -EPERM;
    ...
}

Take a gtp device in a netns owned by a non-init user namespace, where an
init-ns daemon installs PDP contexts through GTPA_NET_NS_FD (gtp_find_dev()
calls get_net_ns_by_fd()). gtp_tunnel_notify() multicasts to
dev_net(pctx->dev):

	ret = genlmsg_multicast_netns(&gtp_genl_family, dev_net(pctx->dev), msg,
				      0, GTP_GENL_MCGRP, GFP_ATOMIC);

Root inside that container would get -EPERM from GETPDP and the dump. It
could still join the "gtp" group and receive every NEWPDP, DELPDP and echo
response notification. These carry the MS and peer addresses, the TEIDs,
and the TID and flow label.

When the UDP socket lives in the host netns, container root has no other
way to see the TEIDs and peer addresses.

Genetlink has no init_user_ns scoped GENL_MCAST_* flag. Making the two
checks match would need a core change, or moving the ops to
GENL_UNS_ADMIN_PERM if userns scope is the intended policy.
net/ipv6/ioam6.c already pairs GENL_ADMIN_PERM ops with a
GENL_MCAST_CAP_NET_ADMIN group in the same way.

This patch does block fully unprivileged users. The commit message also
says "in the user namespace owning the network namespace".

Could the commit message say that the multicast check is still weaker than
the GETPDP check?

>  };
>  
>  static void pdp_context_delete(struct pdp_ctx *pctx);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261021065750.2069795-1-anilkaushikwireless%40gmail.com
