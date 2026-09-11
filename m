Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D736E598BEF
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 20:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789157480; cv=none; b=pjOLlw7vYypx6SwDp1c44BcdZFSW23Ba3gldZmEu/khMluLRhyIpbezjmi3l9RwCTDUKiSHRTevuBb3OW0ieMwcWsnk92QBwVnO777b486bkQkyhwAupglr0TPAx/KQU5fNvtDTlPHUIZ2LNTitcl0E6c6XT7NO2Pl7618EMiv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789157480; c=relaxed/simple;
	bh=BS0Za6dhK9t8gONJ6/AZ2yHnOWi2NkzHx3T0TOaWvQc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s+a2GNjap2LmZbxh4Kh0CaATCwQOP2854Yd56qObYqQTbVG5NjoUoeZdPGUm3/XKeBKXomttkdTZyqETF1BUzoIwi2IzzqcwN8sjeesr0kvzMN+UjzRMPiNxGt1iKRKVQIH3thMO0PbKmYzFAs+AXBqQnRL8NXU3DJBc9HmiP/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=alYqsp+W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="alYqsp+W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FA6C1F00893;
	Fri, 11 Sep 2026 20:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789157478;
	bh=0eLBy84tnDMTfKR+D3gCCvICKuwCQomApAcY8GjoEnc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=alYqsp+W8FukeO+RjfNL5LSNP3kGCqlf5BBL4bp2NRVIrehDRLoMX2ZpU+nfcz2QQ
	 EnRna0wgWYLuH6Qk0Ya0rfyyiA7X16bObRPOgtZpShV/szANPWylhYH219ab738T66
	 vRBiQAutkqH8/S2gneql3gIkdUd3uebCvUZB5pc9C6npSFwUvmQc9g4fgKZmHRR6lX
	 PKV8HUOugkdCoprU4AsOK62+uRx7Vp4cMdW57qPdLIWZqFY2jNsJQgH59aZSozwS7g
	 RSCF53K40HlI0UojJvcHGjqKhSgMv5S8iZMvyn6/jHCWWDGiIbPRJkST/LmcZWg4cP
	 /RhIu2G3R8CNA==
Subject: Re: [PATCH net-next 6/8] netlink: specs: devlink: populate multi-attr
 attrs for region read and line card
From: netdev-bot+sashiko@kernel.org
To: kuba@kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, jiri@resnulli.us,
 tariqt@nvidia.com, moshe@nvidia.com, donald.hunter@gmail.com
Date: Fri, 11 Sep 2026 20:11:17 +0000
Message-ID: <178915747774.219967.6070132870760204550@kernel.org>
In-Reply-To: <20260910200312.2665792-7-kuba@kernel.org>
References: <20260910200312.2665792-7-kuba@kernel.org>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 0 · Low: 0

- [High] The commit message enumerates three repeated attributes that
  need both `multi-attr: true` and an entry in the operation attribute…

--

netlink: specs: devlink: populate multi-attr attrs for region read and line card

This adds multi-attr: true to the region-snapshot, region-chunk and
linecard-type attributes, and adds region-chunks to the region-read reply
plus the linecard state/type attributes to the linecard-get reply.  The
stated goal is that all three repeated attributes get both the multi-attr
property and an entry in the attribute list used by C code generation.

> diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
> index f23466fb27f97..9d816a0b7da41 100644
> --- a/Documentation/netlink/specs/devlink.yaml
> +++ b/Documentation/netlink/specs/devlink.yaml
> @@ -1264,6 +1264,7 @@ attribute-sets:
>      attributes:
>        -
>          name: region-snapshot
> +        multi-attr: true

[Severity: High]
The commit message says that for all three attributes "the attributes
themselves are missing from the attr list used by C code gen".  For
region-chunks and the linecard attributes the patch adds them to the
respective replies, but is the region-snapshots half missing?

Grepping the spec, region-snapshots only appears in its own definition in
the devlink attribute set and as the dl-region-snapshots subset name; no
operation lists it.  The region-get reply is still:

        reply: &region-get-reply
          value: 42
          attributes: *region-id-attrs

where region-id-attrs is {bus-name, dev-name, index, port-index,
region-name}.

Since ynl-gen-c only generates parsing code for attribute sets reachable
from an operation's attribute list, does the new multi-attr: true on
region-snapshot have any effect?  The generated region-get reply struct
would still have no snapshot list.

There is also a related gap in what the spec describes: for every
REGION_GET do and dump message, devlink_nl_region_fill() in
net/devlink/region.c emits attributes the reply does not declare:

	err = devlink_nl_put_u64(msg, DEVLINK_ATTR_REGION_SIZE, region->size);
	...
	err = nla_put_u32(msg, DEVLINK_ATTR_REGION_MAX_SNAPSHOTS, region->max_snapshots);
	...
	err = devlink_nl_region_snapshots_id_put(msg, devlink, region);

and devlink_nl_region_snapshots_id_put() nests one
DEVLINK_ATTR_REGION_SNAPSHOT per entry of region->snapshot_list:

	snapshots_attr = nla_nest_start_noflag(msg, DEVLINK_ATTR_REGION_SNAPSHOTS);
	...
	list_for_each_entry(snapshot, &region->snapshot_list, list) {
		err = devlink_nl_region_snapshot_id_put(msg, devlink, snapshot);

Would it make sense to add region-snapshots (and region-size /
region-max-snapshots) to the region-get reply, or otherwise to narrow the
commit message to the two operations the patch actually completes?

Checking the tip of the series (59624e85e9fb), the region-get reply is
still attributes: *region-id-attrs, so no later patch in the series
changes this.

> @@ -2045,6 +2048,7 @@ operations:
>              - index
>              - port-index
>              - region-name
> +            - region-chunks
>  

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260910200312.2665792-1-kuba%40kernel.org
