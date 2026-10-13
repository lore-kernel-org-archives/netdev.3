Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40201FE451;
	Tue, 13 Oct 2026 14:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791900112; cv=none; b=eL0zPtMhIhTAgDKl2av/QkR6sXselM5KAlF3gVLgmspNlRmG9iswI8PgF8Cyjjqy0av3bwpCGh5awtC2B9qUoHbfnSbhDXxbNSV3j67WfvnZK8JxFwYfdDahCIOczWhniCw0va+Ny4j1faKac2susBzTYefSgne8zPr8HwgHab8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791900112; c=relaxed/simple;
	bh=zUZkpmHlmh0ad7SUvk/kogDP+6YwsetRXMcVwsxHzzM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NqChx8sJIYzQqA7awP+DVKDmDJ92ZCm+J1RcXbsWIEXiGTMl5iFol9vE4BxYSmSYV5vSmDZdfNPGwRTwufxdkdsyWngl4N6WPRLTgO+F8037l2JBE9k4AA1fN+XKon7NJ+LylTp5dV37gth+ZtVph8rmsKlX+VKseFWQBh5o+F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ApXUbKJD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ApXUbKJD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D08DE1F000FF;
	Tue, 13 Oct 2026 14:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791900111;
	bh=NlIs8wQ2DkvvZY0LZaGREWKJWI40Kot9OFnmqBhOUUM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ApXUbKJDlLYQdMarJgXTnjVKLe8bIBe35RGX78rtbJHfaVZncaaMfkFbasE84b0yz
	 B+P6hGoe28iEtpvrY3mYNeYHwKfcfGzohhkFMGk0Oq1Pi7vtbY4XybR5MhBOpRv2Pr
	 xOdl0DCPAV6hQHOgvUQKpwW5P6ARztzDbP52U5kVqSBbrkTFewBONsk6cwKCYFh09Q
	 sZCuGSCeT93cdloz7JcZWvyegmC55anWVSYy9la3+ryqAxp1m1NqZokAHqos/Yq2xt
	 x2mXPsMXRroxF9gjjnEeCayD4hqb56Eyx0E7RIxwbPLvqHVaBhKBQAz/ndJpsueWmc
	 koGvOHQOart7Q==
Subject: Re: [PATCH net v3 3/6] amt: reject an IPv6 address passed in an IPv4
 address attribute
From: netdev-bot+sashiko@kernel.org
To: omar@blockcast.net
Cc: ap420073@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org
Date: Tue, 13 Oct 2026 14:01:50 +0000
Message-ID: <179190011040.434549.12527298754520861685@kernel.org>
In-Reply-To: <20261012125943.558629-4-omar@blockcast.net>
References: <20261012125943.558629-4-omar@blockcast.net>
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
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix does not close the bug class its commit message
  describes.

--

amt: reject an IPv6 address passed in an IPv4 address attribute

This patch adds amt_ip6_in_ip4_attr() and calls it from amt_validate().
amt_validate() then rejects an IFLA_AMT_LOCAL_IP or IFLA_AMT_DISCOVERY_IP
attribute whose payload is exactly 16 bytes. The aim is to stop
nla_get_in_addr() from silently truncating an IPv6 literal to an IPv4
address.

> diff --git a/drivers/net/amt.c b/drivers/net/amt.c
> index c3716bad251f6..550b0a5e73766 100644
> --- a/drivers/net/amt.c
> +++ b/drivers/net/amt.c
> @@ -3194,6 +3194,15 @@ static const struct nla_policy amt_policy[IFLA_AMT_MAX + 1] = {
>  	[IFLA_AMT_MAX_TUNNELS]	= { .type = NLA_U32 },
>  };
>  
> +static bool amt_ip6_in_ip4_attr(const struct nlattr *attr,
> +				struct netlink_ext_ack *extack)
> +{
> +	if (!attr || nla_len(attr) != sizeof(struct in6_addr))
> +		return false;

[Severity: High]
Can other oversized lengths still get through and be truncated?

The commit message names these policy entries as the root cause, but the
patch does not change them:

drivers/net/amt.c:amt_policy[] {
    ...
	[IFLA_AMT_LOCAL_IP]	= { .len = sizeof_field(struct iphdr, daddr) },
	...
	[IFLA_AMT_DISCOVERY_IP]	= { .len = sizeof_field(struct iphdr, daddr) },
    ...
}

These entries are NLA_UNSPEC, so validate_nla() in lib/nlattr.c treats .len
only as a minimum length:

	if (attrlen < minlen)
		goto out_err;

Some lengths still pass the policy: 5 to 15 bytes, and 17 bytes or more.
amt_ip6_in_ip4_attr() returns false for these because the length is not
exactly 16.

amt_newlink() then truncates the value in the same way:

	amt->local_ip = nla_get_in_addr(data[IFLA_AMT_LOCAL_IP]);
	...
	amt->discovery_ip = nla_get_in_addr(data[IFLA_AMT_DISCOVERY_IP]);

The device is then created with an address that was never requested.

Would it be better to change these two policy entries to
NLA_POLICY_EXACT_LEN(sizeof(__be32)) or NLA_BE32? That would reject every
wrong length with a standard bad-attribute extack, and the open-coded
helper would no longer be needed. amt_get_size() and amt_fill_info()
already emit exactly sizeof(__be32) for these attributes.

The problem is still there at the end of the series. The last patch, "amt:
do not create tunnel state for unauthenticated Requests", leaves both
amt_policy and amt_ip6_in_ip4_attr() unchanged.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261012125943.558629-1-omar%40blockcast.net
