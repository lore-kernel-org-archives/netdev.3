Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6083859B67F
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 20:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789157482; cv=none; b=AFxu25jEd15XvdISzyXZxDnaVuAcB0DX4Hw9z/Nmj8uUtRRqmqtZWPfgeRDO7MHOpf5YIGEo37f/Bv7lKAKtmibN7tWSz89MruW3t+0E4Oz6aODT9/S8dk5/cvCqyQS+piWyQljdWSlH3SE4bg5pHM1XLAsRGaUxCxytCCt7UwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789157482; c=relaxed/simple;
	bh=Iu2cEDkgGLet6xhL2jVaImcd9Ejccv6SLlmk5tAmp48=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OoagOX1bWbwuyOi+vlXkbzma6B5kUT87MR0hPTO7jYWMBlMhv5dZSZ40KOEIuGsQDm/GqZeXTqXz1uaQnDeU9+xHt8deqBUZ/gSWJIcuQcLeDhWmrFmbi1FGVCcblZBYd77b/WvYtgH0YMPa7/DkVVIyYBJlIXcjs2ETG9JkyBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KD/Fbe9X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KD/Fbe9X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D8BF1F00893;
	Fri, 11 Sep 2026 20:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789157481;
	bh=nLamnUcpZaRxfwbSOX4g6CwuFhpSSq+u6j9uxYHGzDk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KD/Fbe9XvQ4gL7D71HoiH3yJ3t/b7v/GtAhc3cV3xyJUkiF97vN8A0CdUqNFyDlfN
	 8jh62Dupz9MDV5jXLYlj6bAXnDq0WoLUfG5lY8Wgl4MY806CsYG3ZudQrZAbj4Jh1M
	 t/vFPnTaQJEgJ8z8SmfyJLm1bJqlkuetkMnRT24KnYDgvb5bXyJFVY1rEg72YzsPOe
	 eQkZZ2o+QJu5UZF8SG1D+k4DAuRLfpe5Ff0XHEpxkE7ABotd4nfGlhwU7L85F0CSLl
	 U6UrXtsFFnlQXgKPg3Kq1DuuxIbh+E7YCJB+86uF1aoY/S3+s/718zXvDNuihto6N2
	 p1Gkt6gMsx8xg==
Subject: Re: [PATCH net-next 8/8] netlink: specs: devlink: add pad to the
 subsets carrying padded u64s
From: netdev-bot+sashiko@kernel.org
To: kuba@kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, jiri@resnulli.us,
 tariqt@nvidia.com, moshe@nvidia.com, donald.hunter@gmail.com
Date: Fri, 11 Sep 2026 20:11:20 +0000
Message-ID: <178915748014.219967.11210143409687648210@kernel.org>
In-Reply-To: <20260910200312.2665792-9-kuba@kernel.org>
References: <20260910200312.2665792-9-kuba@kernel.org>
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

- [Low] Missing `Fixes:` tag on a patch that repairs a concrete, user-
  visible parsing failure.

--

netlink: specs: devlink: add pad to the subsets carrying padded u64s

The devlink netlink spec is missing the pad attribute in several nested
attribute subsets that carry padded u64 values, and the separate
dl-attr-stats space had no pad definition of its own. This patch adds
pad to those subsets and gives dl-attr-stats an explicit pad with value
61.

> diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
> index 54de1eeb22347..acb22856a6a85 100644
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
Should this carry a Fixes: tag?  The commit message says the missing pad
"would break parsing stats on an arch without
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS", which reads like a user-visible
bug fix rather than a spec cleanup.

The kernel really does emit the pad attribute inside these nests:

net/devlink/devl_internal.h:
	static inline int devlink_nl_put_u64(struct sk_buff *msg, int attrtype, u64 val)
	{
		return nla_put_u64_64bit(msg, attrtype, val, DEVLINK_ATTR_PAD);
	}

and all of the touched spaces use it - dpipe table size/resource-id/
resource-units and dpipe entry index/counter in net/devlink/dpipe.c, the
resource attributes in net/devlink/resource.c, region-chunk-addr in
net/devlink/region.c, the health reporter counters in net/devlink/health.c,
and the stats attributes in net/devlink/trap.c.

On the decode side an unknown attribute value in a space is fatal rather
than skipped:

tools/net/ynl/pyynl/lib/ynl.py:YnlFamily._decode() {
	...
		attr_spec = attr_space.attrs_by_val[attr.type]
	except (KeyError, UnboundLocalError) as err:
		if not self.process_unknown:
			raise YnlException(f"Space '{space}' has no attribute "
					   f"with value '{attr.type}'") from err
	...
}

So before this change devlink dpipe/resource/region/health-reporter and
trap stats replies were undecodable by ynl on those architectures.  Would
adding something like:

	Fixes: 74bf6477c18b ("netlink: specs: add partial specification for devlink")

help stable and backport tooling pick this up along with the ynl tooling?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260910200312.2665792-1-kuba%40kernel.org
