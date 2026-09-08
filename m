Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7199448E0D3;
	Tue,  8 Sep 2026 19:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788895778; cv=none; b=Ntyf3P/42TztJrcexEgMMIucKIQcXjf8mNL5kmWPzhgwmoxoGOuFgN+3ZmTXOGaMImvQzqhaq0wc87mHcULpCpZ/fkG5MAAGdoCKzNoWA+HwvzJd0qLZ2SodxcGbP1VcGuosXYLu0YU+2OqknQGHiAOERGsbYZmpK38f7vrOttI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788895778; c=relaxed/simple;
	bh=oOJgm+IK+JUlbgFNrKyQc+Ij/+q/u9DoGjWSQCdW5GI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mxvgBY4OAJWanIBkja7LBbvpeZGfFd4YnbEHaZMILkRduuzg/TFfm/YWFQNLlYvtsxj+NdifSAukFHql6PgOlRe/QSMEVTr8U5s3CJgms5a98SBq8UeDKG8jSMLDG960/SB+5YcxZPauWJ6/wtw4ZSnZvDsH90GCtUO8SG4UqhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F6tlJYMd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6tlJYMd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 822DB1F00A3E;
	Tue,  8 Sep 2026 19:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788895777;
	bh=ZE+hJuyhWs8uHEl+8ow4Uaq+hUfANfNqyQoV4fQXzlw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=F6tlJYMde4LbLzrGLPAfoDc7DKyCBofyfZxG1z7Fx0YRapoOHjwCAPIz3flolutCU
	 Q/HvP+3sI5MfZvPBDOIWRdYXwhBixiZDSnnSdrcjx7dtnZik2fpRmPUh0vuufz0ko6
	 vGlmdAXafnM5Iq5ctJF0V5kakbB7Ke1bQLP43qzFV6QzgZJctCeoVACWw44UMJmz4a
	 rqPlMVIJ0hYYgus+C5wOuwag2bXf1Z/t+SMB+hk+2S30zwmBAysFaAyYVg5LPZKrjX
	 icGcR9ETjp+oblibpqbOOJZxBnE9Nggh0Hc8I7J10DhYudLJGtEgoJsk24uHRZL3pS
	 lmZDNI3Yr3Pnw==
Subject: Re: [PATCH net-next v4 4/7] netconsole: reject a target mixing IPv4
 and IPv6 addresses
From: netdev-bot+sashiko@kernel.org
To: gustavold@gmail.com
Cc: leitao@debian.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 corbet@lwn.net, skhan@linuxfoundation.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Date: Tue, 08 Sep 2026 19:29:36 +0000
Message-ID: <178889577610.219967.4235436069044930159@kernel.org>
In-Reply-To: <20260903-netcons_ipv6-v4-4-bdd183c844d3@gmail.com>
References: <20260903-netcons_ipv6-v4-4-bdd183c844d3@gmail.com>
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
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 0

- [Medium] The new family-equality check in netcons_netpoll_setup()
  (drivers/net/netconsole.c:491-495) cannot distinguish a user-…

--

netconsole: reject a target mixing IPv4 and IPv6 addresses

This adds a check in netcons_netpoll_setup() that refuses to enable a
dynamic target whose local_ip and remote_ip belong to different address
families, matching what the command-line parser already does.

> diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> index 4af4f3039d4cd..abcc8515ddd2b 100644
> --- a/drivers/net/netconsole.c
> +++ b/drivers/net/netconsole.c
> @@ -488,6 +488,12 @@ static int netcons_netpoll_setup(struct netconsole_target *nt)
>  		return -EDESTADDRREQ;
>  	}
>  
> +	if (nt->local_ip.family != AF_UNSPEC &&
> +	    nt->local_ip.family != nt->remote_ip.family) {
> +		np_err(np, "local and remote IP address families differ, aborting\n");
> +		return -EINVAL;
> +	}
> +

[Severity: Medium]
Can this check tell apart a local_ip the user configured from one that
netconsole itself stamped into the target?

Later in the same function, when no local address was configured,
netcons_netpoll_setup() fills one in from the device and records the
family:

	if (nt->local_ip.family == AF_UNSPEC) {
		if (nt->remote_ip.family == AF_INET6)
			err = netcons_take_ipv6(nt, ndev);
		else
			err = netcons_take_ipv4(nt, ndev);
		if (err)
			goto put;
		ip_overwritten = true;
	}

netcons_take_ipv4() sets nt->local_ip.family = AF_INET and
netcons_take_ipv6() sets nt->local_ip.family = AF_INET6.

The derived value is only rolled back on the failure path:

put:
	DEBUG_NET_WARN_ON_ONCE(np->dev);
	if (ip_overwritten)
		memset(&nt->local_ip, 0, sizeof(nt->local_ip));

so after a successful enable the auto-taken family stays in the target.
The disable branch of enabled_store() only touches nt->state and moves
the target to target_cleanup_list, and local_ip_store() cannot write
AF_UNSPEC back because netpoll_parse_ip_addr() rejects an empty write
(if (!len) return -1;) and always sets AF_INET or AF_INET6 on success.

Does that make the documented reconfiguration flow in
Documentation/networking/netconsole.rst fail after a family switch?

 echo 0 > enabled			# disable the target (if required)
 echo 10.0.0.4 > remote_ip		# update some parameter
 echo 1 > enabled			# enable target again

Concretely:

  1. create a target with remote_ip=10.0.0.4 and no local_ip, enable it
     -> netcons_take_ipv4() sets local_ip.family = AF_INET
  2. echo 0 > enabled
  3. echo fd00::1 > remote_ip     (accepted, remote_ip_store() only
     refuses writes while nt->state == STATE_ENABLED)
  4. echo 1 > enabled             -> the new check returns -EINVAL and
     prints "local and remote IP address families differ", although no
     local address was ever configured by the user

The only way back to auto-selection appears to be writing an explicit
local address of the new family, or removing and recreating the target
directory.

Is the deactivated-target case affected too?  remote_ip_store() also
accepts a family change while nt->state == STATE_DEACTIVATED, and when
the interface comes back resume_target() treats the new -EINVAL as a
one-shot setup failure:

	if (netcons_netpoll_setup(nt)) {
		/* netpoll fails setup once, do not try again. */
		netconsole_skb_pool_flush(nt);
		nt->state = STATE_DISABLED;
		return;
	}

which stops logging on that target with no retry.

Would it make sense to also clear the derived local_ip when the target
is disabled, or to remember that it was auto-taken, so the equality test
only applies to a local address the user actually wrote?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260903-netcons_ipv6-v4-0-bdd183c844d3%40gmail.com
