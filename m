Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2724A5EC7
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 13:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791466325; cv=none; b=rl+QaM46IMn59Y0EGVZNXJl6I4Xy7sHpYhytIUkj0MVsk92P8oSfN0llu5az7TKSdDzSKngBudVdXWHZeUbvfTGo/Nw+GFMGNW0zzjEWAT5fdWKU/bsnxn8nq7AP2oE9DvJfTfI07E5Jc/2lep9W66bN2wx73FHssfkoncyo2Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791466325; c=relaxed/simple;
	bh=aMGBOYnLziJBnBXFla1AxQz2fx68e3Q/L8iR+wQbwzE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uAbhaAKJ/NK94JrVYMTIsKaFeVR8kZwx8f7lpM2bmm/8vzMtRqoaZnvpj1Lz5Y4fM14pR2LXHEIVCukVtQDRR/luFsuO0cU6sueUK8Hrq06tMtvn2DlTa0w9wXNza04IhP6Y7KWSpTONZuyXm8VBVcXY0HzouquFL+2u2d/ljxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CYbcDZWC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYbcDZWC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EEFC1F00898;
	Thu,  8 Oct 2026 13:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791466323;
	bh=VzzuPkgG0JMnQXdM43Na441ljBk5hLmBaUoGNX+eXWk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CYbcDZWCKIMmiPhAw8UwmCJTIadq0hzUENGbbDc8Lo3WOfc9XjvIIN8dhHmXYeVNJ
	 aWdzS2FVC3o5qi6UWvtfFRw7yT0CEd0yMeY+iiMIVpyMZQAbLVGt0ShCCZhfuc9I+J
	 vJmoAgXsYSQJ4IGKC4pPUF4gHH4vPhiK9W/GSeRVfVAUusbMWy/q3P+h2S0g5nbZCi
	 HDMJbeo/7Tp0cGI+7DI+0GvrfRIuqolMmOCROE/MJ6NnjbnAWqckNZMRx+J6sf1+Ox
	 dXEiuzWGfoeHE5XO+9VtR8NPEIz+L7IHxX1aKYm056amY0ZxQfYOdnVzdZ/nczEe7u
	 8bwsb8BzCvDjw==
Subject:
 Re: [PATCH net-next 6/7] ovpn: send peer object along with PEER_DEL_NTF
From: netdev-bot+sashiko@kernel.org
To: antonio@openvpn.net
Cc: netdev@vger.kernel.org, ralf@mandelbit.com, sd@queasysnail.net,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com
Date: Thu, 08 Oct 2026 13:32:02 +0000
Message-ID: <179146632270.434549.899167774520008786@kernel.org>
In-Reply-To: <20261007133018.1451958-7-antonio@openvpn.net>
References: <20261007133018.1451958-7-antonio@openvpn.net>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] This patch makes ovpn_nl_peer_del_notify()
  (drivers/net/ovpn/netlink.c:1289) call ovpn_nl_fill_peer(msg, NULL,…
- [Low] The updated ovpn selftest only checks that the new PEER_DEL_NTF
  counters exist, not their values.

--

ovpn: send peer object along with PEER_DEL_NTF

This commit moves the PEER_GET attribute filling into a new helper,
ovpn_nl_fill_peer(), and calls it from ovpn_nl_peer_del_notify(). As a
result, PEER_DEL_NTF now carries the full peer object, including the
final traffic counters. The selftest fixtures are updated, and the jq
filter normalizes counters and endpoint attributes before comparing.

> diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
> index 5432bc2eb8e80..15b6d99474b99 100644
> --- a/drivers/net/ovpn/netlink.c
> +++ b/drivers/net/ovpn/netlink.c

[ ... ]

> @@ -1273,7 +1286,8 @@ int ovpn_nl_peer_del_notify(struct ovpn_peer *peer)
>  	if (nla_put_u32(msg, OVPN_A_PEER_DEL_REASON, peer->delete_reason))
>  		goto err_cancel_msg;
>  
> -	if (nla_put_u32(msg, OVPN_A_PEER_ID, peer->id))
> +	ret = ovpn_nl_fill_peer(msg, NULL, peer);
> +	if (ret < 0)
>  		goto err_cancel_msg;

[Severity: High]
Does this expose PEER_GET data to unprivileged listeners?

The notification is sent with genlmsg_multicast_netns() to
OVPN_NLGRP_PEERS. That group has no capability flag:

drivers/net/ovpn/netlink-gen.c:
static const struct genl_multicast_group ovpn_nl_mcgrps[] = {
	[OVPN_NLGRP_PEERS] = { "peers", },
};

The generic netlink socket is created with NL_CFG_F_NONROOT_RECV. The
only permission check on join is in genl_bind():

net/netlink/genetlink.c:genl_bind() {
    ...
		if ((grp->flags & GENL_MCAST_CAP_NET_ADMIN) &&
		    !ns_capable(net->user_ns, CAP_NET_ADMIN))
			ret = -EPERM;
    ...
}

So any process in the socket's netns can join "peers". OVPN_CMD_PEER_GET
(do and dump) is marked GENL_ADMIN_PERM, but the same data now reaches
that group on every peer deletion. The data includes tx-id, VPN
IPv4/IPv6, remote and local address/port, keepalive settings and all
eight vpn/link rx/tx counters.

Before this change, PEER_DEL_NTF carried only ifindex, peer id and
del-reason.

Should the "peers" group be marked cap-net-admin in
Documentation/netlink/specs/ovpn.yaml, with netlink-gen.c regenerated so
it gets GENL_MCAST_CAP_NET_ADMIN? Another option would be to send the
extended payload on a separate privileged group.

>  
>  	nla_nest_end(msg, attr);
> diff --git a/tools/testing/selftests/net/ovpn/common.sh b/tools/testing/selftests/net/ovpn/common.sh
> index e33b1fe265221..08bb36ba3c806 100644
> --- a/tools/testing/selftests/net/ovpn/common.sh
> +++ b/tools/testing/selftests/net/ovpn/common.sh

[ ... ]

> +OVPN_JQ_FILTER='
> +	def zero_attr(key):
> +		if has(key) then .[key] = 0 else . end;
> +
> +	def zero_peer_stats:
> +		zero_attr("vpn-rx-bytes") |
> +		zero_attr("vpn-rx-packets") |
> +		zero_attr("vpn-tx-bytes") |
> +		zero_attr("vpn-tx-packets") |
> +		zero_attr("link-rx-bytes") |
> +		zero_attr("link-rx-packets") |
> +		zero_attr("link-tx-bytes") |
> +		zero_attr("link-tx-packets");

[Severity: Low]
This isn't a bug, but this filter only checks that the counters are
present, not their values.

ovpn_compare_ntfs() runs both the expected fixtures and the received
output through this filter before the diff. The fixtures hard-code
every counter to 0, so the test would still pass if the kernel sent
zero, stale or swapped counters.

ovpn_run_basic_traffic() in test.sh sends traffic to every peer before
deletion:

    ping -qfc 100 -w 3 5.5.5.$((p + 1))

So the counters should always be non-zero at that point. Would a check
such as .[key] |= (. > 0) work here, with true in the fixtures? That
would catch counters that are reset or not filled in.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261007133018.1451958-2-antonio%40openvpn.net
