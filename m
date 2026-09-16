Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5071349B45A
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 19:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789586147; cv=none; b=i4nbEjR3w7IhoYZ+h+E9qRPjThhOh7/vJSKOKNiAgWOszfuoPCPVJIru5qTLf+UaEavfoPsurEN3Z1+A00E56ofVDFcLdQMxx8G9wt1rL1sRmCIV9vgxkOBn5w7kQ5o22yHMVLVilpiy9izM8ojYK8Gi+AjU8z3fxeXSLTu/h9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789586147; c=relaxed/simple;
	bh=ZQQFsbvs0yaXxdVqs5IDscbjWD/YcjaOc7M1S+LRrxY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Log5OLB4RRJDTGuUJsCay1m/pR9ovnYIoCsnHsABoHjzQCKQxLTqmvErCKuTxGbmTyJT0WjD1mJkPDGVKNWIK7rTk4e4/RbOJ+XIQv748+REE3MR+DWqSdn3sWB413zOj+FqKNGO+LkpWmWyp4qIKbiJTNwNRDF7FklrwRJlCR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XrlZh5Ys; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XrlZh5Ys"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DC3A1F0089C;
	Wed, 16 Sep 2026 19:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789586127;
	bh=eVw50cNO1ZApEwe5Tw+plkDCPSqe3C0wmrW3iX+3yyA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XrlZh5YsXcwLT9EKi56TJnVUQayxKF7jKQyR6oDtS11Q03pAOI5PEsY1Vo76YQYqI
	 8Q3yUPKf/FcXuEyiEPbq1tAZvnMxhuyanmPScqpEdy3jew4quGtNnfaBGbyvHHt/dy
	 BwszSBTQbDZ4fZTQ8hG26cbU1XlKfkmhBzMS9SP1Nshg/TS5xCGPuVrFr1ghoWvKE/
	 x+WiMOJEuAIV0yCXXE/bks/Mjgml3UlKbRmlMRc+8t4SB+aEpcoH73fLgPhLzRXqRw
	 pkOyCvnM4eY5Tcam/9/oQWCrWRf5wD5+ZZlv5eCV+sh2WHfmN5gegY3+l9IaxIPiwM
	 VsDOA2S7y0Z0g==
Subject: Re: [PATCH net-next v2 9/9] devlink: validate the port index in the
 rate set request
From: netdev-bot+sashiko@kernel.org
To: kuba@kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, jiri@resnulli.us,
 tariqt@nvidia.com, moshe@nvidia.com, donald.hunter@gmail.com
Date: Wed, 16 Sep 2026 19:15:26 +0000
Message-ID: <178958612602.22033.8655238125047770212@kernel.org>
In-Reply-To: <20260915161341.1053476-10-kuba@kernel.org>
References: <20260915161341.1053476-10-kuba@kernel.org>
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

Critical: 0 · High: 0 · Medium: 0 · Low: 1

- [Low] Commit-message characterization / missing `Fixes:` tag.

--

devlink: validate the port index in the rate set request

This adds port-index to the rate-set request attribute list in the devlink
YAML spec and adds the matching NLA_U32 entry to the generated
devlink_rate_set_nl_policy. rate-new is deliberately left unchanged since
it resolves rate nodes by name.

> diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
> index 43ef6864d462f..9e1b4c081a7b3 100644
> --- a/net/devlink/netlink_gen.c
> +++ b/net/devlink/netlink_gen.c
> @@ -618,6 +618,7 @@ static const struct nla_policy devlink_rate_set_nl_policy[DEVLINK_ATTR_PARENT_DE
>  	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
>  	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
>  	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
> +	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },

[Severity: Low]
This isn't a bug in the change itself, but should this carry a Fixes tag?

The missing policy slot looks bisectable to f2f9dd164db0 ("netlink: specs:
devlink: add the remaining command to generate complete split_ops"), which
moved DEVLINK_CMD_RATE_SET out of small_ops into split_ops. The old
small_ops path used the global devlink_nl_policy in net/devlink/netlink.c,
which does declare:

	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32 },

so before that conversion a short port-index was rejected, and afterwards
it is not.

The commit message says:

	Since we're reading a linear skb the OOB read is still
	within the same memory allocation, it's just garbage. We also do not
	echo the garbage back to the user so it's not an info leak either.
	Hence not treating this is a real bug fix.

That reasoning checks out, and the op is GENL_ADMIN_PERM so only a caller
that can already reconfigure any port reaches it. The one remaining effect
is behavioural rather than memory-safety related: with the zeroed policy
slot plus GENL_DONT_VALIDATE_STRICT, a zero-length port-index passes
validation, devlink_rate_get_from_info() picks the leaf path purely on
attribute presence:

net/devlink/rate.c:devlink_rate_get_from_info() {
	if (attrs[DEVLINK_ATTR_PORT_INDEX])
		return devlink_rate_leaf_get_from_info(devlink, info);
	...
}

and devlink_port_get_from_attrs() then reads past the payload:

net/devlink/port.c:devlink_port_get_from_attrs() {
	u32 port_index = nla_get_u32(attrs[DEVLINK_ATTR_PORT_INDEX]);
	...
}

If those four bytes happen to name a registered port,
devlink_nl_rate_set_doit() goes on to change that leaf's rate settings
instead of returning -EINVAL. Would a Fixes tag help stable/backport
tooling identify the trees (v6.7 onward) where a malformed rate-set request
is acted upon rather than rejected?

>  	[DEVLINK_ATTR_RATE_NODE_NAME] = { .type = NLA_NUL_STRING, },
>  	[DEVLINK_ATTR_RATE_TX_SHARE] = { .type = NLA_U64, },
>  	[DEVLINK_ATTR_RATE_TX_MAX] = { .type = NLA_U64, },

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260915161341.1053476-1-kuba%40kernel.org
