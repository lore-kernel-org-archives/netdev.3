Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793871522;
	b=otj7aXk5muLR23d0q2/Lj5f/hMa8v2gQtvi3loZvpqsdPXgbAwsGsZ0bKI6HpbgKFpXK
	 /UbmyRa8VcqtA2wX9fa88zgGJVykiHPQyw8SOddlbVoX3EzNhuo0GQYuwNEi8tLky+GZv
	 YMbau/HaY87bMQxCLrvZzjn+WeP1RQngJec6dECSRVUf9Mn+LGHiyLCD/7VYCH7hcI3zI
	 uXM+5nUXVG0Jmzc90anOfz2VK60npwIH+HGZXFX2k3I8e5mjBLF69Afk+kLYNEqbXEI1t
	 EgWMNv1yLvUV741dXTg0jSeVBoNsbJvXnho8rui7Sxx79H6vR2wce7HwHWrIqsOlrAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793871522;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=NJOowqkaokprRQgrBwv7q6k2B3V31/vfYBmvVAJiIuQ=;
	b=M2H7kVRvWbQX0XsTKXN2hLp961806YL+QPxB8Lbl813HOs0RzDutzEyRBrq9iU5lMxgk
	 REFvfUqThp18T1Ik0gx/6yw+vtdV3r+/b4qnM2bYxexuGEhh2Fs9h37fkIxKKHF6yQ5db
	 zQcvGSZAqabrFHBUEPRipcWonvrFG1F4Maq8b8W3cpLM6QYIS2RdnYrXSajvBpBwwoeQI
	 VWJEZLid8M2tgt23mHKnhfM5gWQYzLVFR0b2IBFt5eS/RqvA08uORXEK7iPlmpn014W9H
	 g8G7Zyfn2YV8s5HT/sfIdIZ5rGTYXTyBhFWwiDIBnRk5xB53qz2/dvLA5FZCkNBdoRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AGiIuSRZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AC1606A328;
	Thu,  5 Nov 2026 09:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AGiIuSRZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BD9B1F000C1;
	Thu,  5 Nov 2026 09:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793871522;
	bh=NJOowqkaokprRQgrBwv7q6k2B3V31/vfYBmvVAJiIuQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=AGiIuSRZjtkgDkzwYrd+MlIl56rdYiiahaJWJ40fFXgqbnst4AsVLaRJPucmdhc7m
	 Go3i3s1L2eOQxd9O1ybBzKHxsky2wNDSDeie31win1yg+n2RZgcCf/bPm1XEF55FFk
	 rBcUYUK7pIZDWBxvHX+youFmzhveP0zwNvSitqouLvAtEgMZ3ptcTFtftxtDrM8s+3
	 vDrz7UTdrOBC/KU1MSjxEJVFeWE1cCOs56XG86woADfZcCCclkC+f/5adDti31Spsd
	 QFmyB/Mfiwt5eIVrVrB3jrAaADJQNFJxc7bbIu5qT+QM+yfDrcCndj8sFTqbOqN5u6
	 kvcXmbXEygs6w==
Subject: Re: [PATCH net v5 1/2] genetlink: Reject joining multicast groups no
 family owns
From: netdev-bot+sashiko@kernel.org
To: anilkaushikwireless@gmail.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, idosch@nvidia.com,
 nicolas.dichtel@6wind.com, jacob.e.keller@intel.com, jiri@resnulli.us,
 fw@strlen.de, martineau@kernel.org, v3rdant.xiang@gmail.com,
 aliceryhl@google.com, linux-kernel@vger.kernel.org
Date: Thu, 05 Nov 2026 09:38:40 +0000
Message-ID: <179387152067.488856.5027284112549941042@kernel.org>
In-Reply-To: <20261104092125.211537-2-anilkaushikwireless@gmail.com>
References: <20261104092125.211537-2-anilkaushikwireless@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message says "Nothing is ever sent to such a group,
  so joining it has no use." That is not true for the fixed legacy group…
- [Low] The patch gives a reserved meaning to -ENOENT from the generic
  `struct netlink_kernel_cfg::bind` callback…

--

genetlink: Reject joining multicast groups no family owns

This makes genl_bind() return -ENOENT for a multicast group ID that no
family owns. Without this, the GENL_MCAST_CAP_* checks can be bypassed by
joining a group before its family registers. netlink_bind() treats -ENOENT
from the bind callback as "skip this group" and joins the rest of the mask,
while setsockopt(NETLINK_ADD_MEMBERSHIP) returns the error.

Link: https://lore.kernel.org/netdev/179324692107.3134.14443689892607921337@kernel.org/

> diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
> index 1281c42a3456a..136055764a006 100644
> --- a/net/netlink/af_netlink.c
> +++ b/net/netlink/af_netlink.c
> @@ -1033,6 +1033,12 @@ static int netlink_bind(struct socket *sock, struct sockaddr_unsized *addr,
>  			err = nlk->netlink_bind(net, group + 1);
>  			if (!err)
>  				continue;
> +			/* no one owns this group, still join the others */
> +			if (err == -ENOENT) {
> +				__clear_bit(group, &groups);
> +				err = 0;
> +				continue;
> +			}

[Severity: Low]
This is generic af_netlink code. For bind(2), -ENOENT from any protocol's
bind callback now means "skip this group and report success". The other
caller of the same callback, netlink_setsockopt(), still returns it as an
error:

net/netlink/af_netlink.c:netlink_setsockopt() {
    ...
		if (optname == NETLINK_ADD_MEMBERSHIP && nlk->netlink_bind) {
			err = nlk->netlink_bind(sock_net(sk), val);
			if (err)
				return err;
		}
    ...
}

The commit message says this difference is intended. Today only
genl_bind() returns -ENOENT. rtnetlink_bind(), nfnetlink_bind(),
sock_diag_bind(), audit_multicast_bind() and cn_bind() return only 0 or
-EPERM.

Could the reserved meaning of -ENOENT be documented on the bind member of
struct netlink_kernel_cfg in include/linux/netlink.h? Otherwise a later
bind implementation that returns -ENOENT to mean "subsystem not present"
would have its group silently dropped from bind(2) masks, while
setsockopt(2) fails.

>  			netlink_undo_bind(group, groups, sk);
>  			return err;
>  		}
> diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
> index 5cc1037d4917e..f038f04ef4ead 100644
> --- a/net/netlink/genetlink.c
> +++ b/net/netlink/genetlink.c
> @@ -1825,7 +1825,7 @@ static int genl_bind(struct net *net, int group)
>  {
>  	const struct genl_family *family;
>  	unsigned int id;
> -	int ret = 0;
> +	int ret = -ENOENT;

[Severity: Medium]
The commit message says:

    Nothing is ever sent to such a group, so joining it has no use.

Does this hold for the group IDs that genetlink assigns as fixed values?

genl_validate_assign_mc_groups() always gives NET_DM group ID 1, and that
ID is exported as uAPI:

net/netlink/genetlink.c:genl_validate_assign_mc_groups() {
    ...
	} else if (strcmp(family->name, "NET_DM") == 0) {
		first_id = 1;
		BUG_ON(n_groups != 1);
    ...
}

include/uapi/linux/net_dropmon.h:
#define NET_DM_GRP_ALERT 1

VFS_DQUOT and PMCRAID also have fixed IDs. Registering a family only
assigns the ID and resizes the bitmaps, so existing members stay members.
The "NET_DM/events (ID 1): member" line in the Before output shows that an
early join gets the group's messages once the family registers.

ret now starts as -ENOENT and is set to 0 only when a family owns the
group. That means privileged callers get -ENOENT too. Take a CAP_SYS_ADMIN
process that does this:

  bind(nl_groups = 1 << (NET_DM_GRP_ALERT - 1))
    netlink_bind()
      genl_bind(net, 1)          -> -ENOENT, drop_monitor not loaded
      __clear_bit(0, &groups); err = 0;
  CTRL_CMD_GETFAMILY "NET_DM"   -> request_module() loads drop_monitor
  NET_DM_CMD_START

Before this patch the socket was a member of group 1 and got the alerts.
Now bind() returns 0, the socket is never a member, and the alerts are
lost without any error.

Is this regression intended for privileged callers? I couldn't find
existing userspace that does this; dropwatch appears to resolve the
family first.

The commit message mentions the getsockname() change and the setsockopt()
-ENOENT. Could it also say that early subscription to fixed IDs stops
working for privileged callers, and that NETLINK_LIST_MEMBERSHIPS output
changes as well?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261104092125.211537-1-anilkaushikwireless%40gmail.com
