Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F65A434981;
	Tue,  8 Sep 2026 19:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788895777; cv=none; b=U7CnsmE9hSDLnoGc5DTITub/1MR4BsqircX6GrMkqaDIKEMnFYENPyNf/ksrMLd0MvWYOLkrB9nvhRLr/58TqnjwNjMd0P09kpNMtmLWbkat8S8CSQLQg7Xe4txRYuJk5V82PmRPGOOzC8x2FKVaWqSy6DmBwgHNA5nXxghdlYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788895777; c=relaxed/simple;
	bh=+n3arIzFG+duTAIVXZSmdKp/FiRO8H8WYdqq7qJd0hc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Tx6KKEwaZJnq9g1pDZJv2f4o6DFHojxdi0Zb5bam3ZvvpgGsUbln3ArqLrSTpbphYiClIS5cQxH745yzCXjLEfUq4OCC5kNcpXrwAbSqcmPCT4du91Fjv1dZCqU2gKnNFb1qRPHs/JAcc8pyjEf82ZjaBlmQeWeYOFfYS29Ykzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eYI/yB3p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYI/yB3p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BCE91F00A3A;
	Tue,  8 Sep 2026 19:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788895775;
	bh=CUwkv7XGtr3w28PK0YkN6gepUb4ETAxtEQ/DY/ARY5Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=eYI/yB3prlMhvUKZg1Y3178CYs9nFS0D4cD+49om9f8Nm45r8DGIGuPW15NTgpoHe
	 RBJKfEgh1SLoiBUv8sM5LVij8UxO37Uo3qH+xEmiWLD1Fck+MpI5k+HxebPB3pqcfl
	 aAUUdII6K0T3sjgA0PP2bJqXClTWw3zQ8qxVGIPjPwZRn6/yAG3JvblX0fhNPz4ykG
	 xEFi6T3TLYZRQsaiJQUsbKYJn88wmzcLiKmFX99ZhdNAtqoXEMYy7Zr36e6b7rioGi
	 A8iu3+pcqvHYCyB2HSImA4gsD77GUAuHs1TW9UCUX37pry+FWKVsV4mFyskYnqU52D
	 B2DCiHFcX8FDQ==
Subject: Re: [PATCH net-next v4 3/7] netconsole: reject enabling a target with
 no remote IP address
From: netdev-bot+sashiko@kernel.org
To: gustavold@gmail.com
Cc: leitao@debian.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 corbet@lwn.net, skhan@linuxfoundation.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Date: Tue, 08 Sep 2026 19:29:34 +0000
Message-ID: <178889577479.219967.13637564005930534526@kernel.org>
In-Reply-To: <20260903-netcons_ipv6-v4-3-bdd183c844d3@gmail.com>
References: <20260903-netcons_ipv6-v4-3-bdd183c844d3@gmail.com>
X-sashiko-severity: Low
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

Critical: 0 · High: 0 · Medium: 0 · Low: 1 (1)

- [Low] Documentation gap: after this patch `echo 1 > enabled` on a
  freshly created dynamic configfs target hard-fails with -EDESTADDRREQ…

Pre-existing issues:
- [Low] Concern (validated as NOT a defect after series verification,
  retained only per the validation-policy retention rule): claim that…

--

netconsole: reject enabling a target with no remote IP address

This adds an early check in netcons_netpoll_setup() so that enabling a
target whose remote address was never set fails with -EDESTADDRREQ instead
of sending netconsole traffic to 0.0.0.0. Only the configfs (dynamic
target) path is affected, since the command-line path already requires a
remote address.

No Link: tags present in the commit header.

> diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> index 351754d53cf97..4af4f3039d4cd 100644
> --- a/drivers/net/netconsole.c
> +++ b/drivers/net/netconsole.c
> @@ -483,6 +483,11 @@ static int netcons_netpoll_setup(struct netconsole_target *nt)
>  	bool ip_overwritten = false;
>  	int err;
>  
> +	if (nt->remote_ip.family == AF_UNSPEC) {
> +		np_err(np, "remote IP address not configured, aborting\n");
> +		return -EDESTADDRREQ;
> +	}
> +

[Severity: Low]
Should Documentation/networking/netconsole.rst be updated along with this?

The "Dynamic reconfiguration" section still says:

  Note that newly created targets have default parameter values (as mentioned
  above) and are disabled by default -- they must first be enabled by writing
  "1" to the "enabled" attribute (usually after setting parameters accordingly)
  as described below.

and the attribute table still lists remote_ip as an ordinary read-write
parameter:

	remote_ip	Remote agent's IP address		(read-write)

After this change the following sequence fails with -EDESTADDRREQ:

  mkdir /sys/kernel/config/netconsole/t1
  echo 1 > t1/enabled

Reading the rest of the series, the last patch ("docs: netconsole: document
local_ip auto-selection") only adds a paragraph stating that local_ip is
optional; nothing marks remote_ip as required before enabling, and the new
errno is not mentioned anywhere. Would a sentence in that section saying
remote_ip must be set before enabling be worth adding?

[Severity: Low]
This isn't a bug introduced by this patch, but a note on how the new gate
interacts with an explicitly written 0.0.0.0.

The check keys on nt->remote_ip.family == AF_UNSPEC, while
netpoll_parse_ip_addr() sets AF_INET for an explicit value:

  if (in4_pton(str, len, (void *)&addr->ip, -1, &end) > 0 &&
      (!end || *end == 0 || *end == '\n')) {
	  addr->family = AF_INET;
	  return 0;
  }

So this still succeeds and sends to 0.0.0.0:

  echo 0.0.0.0 > t1/remote_ip
  echo 1 > t1/enabled

That looks intentional: the later patch "docs: netconsole: document local_ip
auto-selection" documents "Writing any value to it, including 0.0.0.0, uses
that value verbatim and disables the automatic selection", and it matches
the command-line path which also accepts an explicit tgt-ip of 0.0.0.0. The
related read-back ambiguity, where remote_ip_show() rendered AF_UNSPEC as
"0.0.0.0", is also addressed later in the series by "netconsole: show empty
string for an unset IP address". Mentioning it only so the distinction
between "unset" and "explicitly 0.0.0.0" is on record for this hunk.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260903-netcons_ipv6-v4-0-bdd183c844d3%40gmail.com
