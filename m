Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98675221D3
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 19:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788808466; cv=none; b=iP4jMGKy5DhJvM0d4BOIXe33J05Lhb9MVh+igNhM7fCmKwrEXvMYrwS4NFwNA3e4nAvVGxThSw1yizae3dAKLgcii7j9I1pRRBHt+5BiuwW1ugoOfcXWXFt68bdHNDPf1yUkYiEV22s4llJPhFP0YFvZNAv2R72zTit6Uq8NLMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788808466; c=relaxed/simple;
	bh=KgB3AF9yP7ZkIohUT6yVWOcVsZh9lP/uWOOrdfGoaqU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mtdtfrXhFQbRNDZHbRBFjub3hgllPmwWSf0hxlRrSuPigIC9nuI4S1aHuIPEzpagshHKV5QLcj5rWJb5iclzrqgz0hE/0lXWW/U7l1T6prx+HFk/XKxK1cLXLcae8fTJBqb0veKh4J0nAjxxp0QDfr4hOd0WdpOeBvxMLUoI4kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EviBxDPK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EviBxDPK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FED31F00A3A;
	Mon,  7 Sep 2026 19:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788808464;
	bh=va1wYI6pqPh78NO9C+PN0iIrhS56asabITjl8HbhpMo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=EviBxDPKnDvMcRfpr4iEW49yT2bExqBePZzviOzmMxuwRPXfxeBZCLnvA+LPp9U1P
	 AArMR2GoRE4e4Rw15aKUpoomO1GEQ7LvF+9zMD4SsfkPUpZiY47tsOtcWWh9oIIZIQ
	 Z0js2g3qRu9Lhg4JeQq+I+s5cu55TT/e41HDxVok3dR3Lpy23ut5I85TARyTPkrVjq
	 bFYcoWcfOIadjRBl5EEj7BcvloCafvi4cE2mlvQHO22Ru7h9gmQnA0tIwrnOLypu+C
	 sTGPi3Sv+L/M135y//GW9WVAggwL0E/h2nV4WxaMevIx/6XIWq/2j8C61jr7aJp3tu
	 apaiO+nIkYDqw==
Subject: Re: [PATCH net-next 1/3] netlink: specs: fou: add af to the shared
 attribute list
From: netdev-bot+sashiko@kernel.org
To: kuba@kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, kuniyu@google.com
Date: Mon, 07 Sep 2026 19:14:23 +0000
Message-ID: <178880846361.219967.3864810868984050900@kernel.org>
In-Reply-To: <20260904191412.3872344-2-kuba@kernel.org>
References: <20260904191412.3872344-2-kuba@kernel.org>
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

- [Low] Missing `Fixes:` tag on a user-visible ynl/uAPI-codegen fix.

--

netlink: specs: fou: add af to the shared attribute list

The fou spec's &all_attrs anchor, used by the add do request and the get
do/dump reply, did not list the af attribute.  This patch adds it, so ynl
generated clients gain a setter for it and the get reply struct gains a
member.  Only user space codegen and the rendered docs change.

> diff --git a/Documentation/netlink/specs/fou.yaml b/Documentation/netlink/specs/fou.yaml
> index 331f1b342b3ad..32d34be1dc63a 100644
> --- a/Documentation/netlink/specs/fou.yaml
> +++ b/Documentation/netlink/specs/fou.yaml
> @@ -90,6 +90,7 @@ operations:
>          request: &all_attrs
>            attributes:
>              - port
> +            - af

[Severity: Low]
Would a Fixes: tag be appropriate here?

git blame shows the &all_attrs anchor lines, including the local-v6 /
peer-v6 entries, come from 4eb77b4ecd3c ("netlink: add a proto
specification for FOU"); the only later touch, 791a9ed0a40d ("netlink:
specs: fou: replace underscores with dashes in names"), just renamed
names.

The effect described in the commit message is user visible: since
parse_nl_config() in net/ipv4/fou_core.c is the only place the family is
chosen and only switches away from AF_INET when FOU_ATTR_AF is present, a
generated client had no way to create an IPv6 FOU port, and fou_fill_info()
puts FOU_ATTR_AF unconditionally so the reply struct was missing a member
for an attribute present in every reply.

The same file has precedent for tagging a spec-only change:
791a9ed0a40d carried Fixes: 4eb77b4ecd3c ("netlink: add a proto
specification for FOU").

Without the tag, would a stable backporter have to bisect the spec history
to find where the omission came from?

>              - ipproto
>              - type
>              - remcsum-nopartial

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260904191412.3872344-1-kuba%40kernel.org
