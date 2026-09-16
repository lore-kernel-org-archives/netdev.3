Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAD548FF7B
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 19:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789586144; cv=none; b=QRrb7J5my3y8nn9XUNDEK6eXzPnjKTeRhLe0jRlG2WMKZGz0wkc3PYM4tPoFf92xPs9kB3z/kfUl/ymq1H1hF+RhSpr5x0hpOZbFBru7VecvENWs1iDCDqa6r2IY5nBCyCUPAmZP3eJnlL3rDst2JsuzyDEbYAdnerUO6NUYpPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789586144; c=relaxed/simple;
	bh=O0/fpMwxCSXgsWrnvAINqBsAFWVzeRSNobmmuyzCVlY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ftwRfe/Ya3S5g0Rr78yAgQDLVMJw9IqPBb9cRkLR7oDRfVIGqcvuVFZzsQTeIjiDd3FlW0k9AcCWPHnpTPAS/QIde9BbNkTr/1GWi7AQRuQk+te49Y8eYuFMT1zjSjmKYSbta0b6w3mxYOCGURCOFJAciAkfPqHtsw5vPIsjZJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FTv0bZLy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FTv0bZLy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 522251F0089B;
	Wed, 16 Sep 2026 19:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789586125;
	bh=nJmZiTq2xB9e9o17x7eE4Wzydx4DpMBiSsOwzZQH4LA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FTv0bZLyaoEkCo878L3Tip0KVldapvapJ6sVhnmu2MuH3myEA4n3i9vhRAzh0+3d6
	 x/0DJidrcu2pdsF88Ba0e3h8HmtD3AxIZx/ZsN9uS5FDsZxEH4uyN76e5eJJ2DRk7i
	 mtWwJq71n8yyggqETxwr+wZYDvrzpVbhUEZ1vWr0GJUsRznnmRK041QvI/KTR6iUqQ
	 7SdkDRNBoeUjnPUfHjhZDrFmX855vs2Wbg/mjZq6SH60q9Aw+GEDKjeTqdj975LzTH
	 bCS4oRZ+C48Jrzmo/V+SJZp5EVEcFBg4WspzVqnTqziDF2m3XuyGleV07SvWeUq3tp
	 zeBTctJe5cb/w==
Subject: Re: [PATCH net-next v2 8/9] netlink: specs: devlink: add pad to the
 subsets carrying padded u64s
From: netdev-bot+sashiko@kernel.org
To: kuba@kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, jiri@resnulli.us,
 tariqt@nvidia.com, moshe@nvidia.com, donald.hunter@gmail.com
Date: Wed, 16 Sep 2026 19:15:24 +0000
Message-ID: <178958612491.22033.18242284084477216177@kernel.org>
In-Reply-To: <20260915161341.1053476-9-kuba@kernel.org>
References: <20260915161341.1053476-9-kuba@kernel.org>
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

- [Low] Missing Fixes: tag on a spec change that repairs a real, user-
  visible parsing failure.

--

netlink: specs: devlink: add pad to the subsets carrying padded u64s

This adds the missing pad attribute to several devlink attribute subsets
that carry padded u64 values, and defines pad explicitly in the separate
dl-attr-stats space with value 61.

> diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
> index 5535247faf14f..4fb64e71063dc 100644
> --- a/Documentation/netlink/specs/devlink.yaml
> +++ b/Documentation/netlink/specs/devlink.yaml
> @@ -1065,6 +1065,8 @@ attribute-sets:
>          name: dpipe-table-resource-id
>        -
>          name: dpipe-table-resource-units
> +      -
> +        name: pad

[ ... ]

> @@ -1343,6 +1353,10 @@ attribute-sets:
>        -
>          name: stats-rx-dropped
>          type: u64
> +      -
> +        name: pad
> +        type: pad
> +        value: 61

[Severity: Low]
Should this carry a Fixes: tag?

The commit message describes a real user-visible failure rather than a
cosmetic spec cleanup:

    This would break parsing stats on
    an arch without CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS.

The kernel does emit that attribute type inside these nests:

net/devlink/devl_internal.h:
    static inline int devlink_nl_put_u64(struct sk_buff *msg, int attrtype, u64 val)
    {
            return nla_put_u64_64bit(msg, attrtype, val, DEVLINK_ATTR_PAD);
    }

and this helper feeds the u64s in every nest touched here, e.g.
DEVLINK_ATTR_DPIPE_TABLE_SIZE / _RESOURCE_ID / _RESOURCE_UNITS in
net/devlink/dpipe.c, the resource attributes in net/devlink/resource.c,
DEVLINK_ATTR_REGION_CHUNK_ADDR in net/devlink/region.c, the health reporter
attributes in net/devlink/health.c, and STATS_RX_PACKETS / _BYTES / _DROPPED
inside the DEVLINK_ATTR_STATS nest in net/devlink/trap.c.

On an arch where nla_need_padding_for_64bit() is true, ynl aborts rather
than skipping the unknown attribute, in YnlFamily._decode() of
tools/net/ynl/pyynl/lib/ynl.py:

            try:
                attr_spec = attr_space.attrs_by_val[attr.type]
            except (KeyError, UnboundLocalError) as err:
                if not self.process_unknown:
                    raise YnlException(f"Space '{space}' has no attribute "

Since the defective spec text came in via several different historical
commits (the individual subsets, and separately the dl-attr-stats space),
would it help backporters to name at least the commit that introduced
dl-attr-stats in a Fixes: trailer? Other patches in this series reference
culprit commits only in prose, for example the port function nest patch
mentions 5af3e3876d56 in the body, and nothing here states that leaving out
the trailer is intentional.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260915161341.1053476-1-kuba%40kernel.org
