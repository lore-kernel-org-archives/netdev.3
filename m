Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EAF283CB5
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 19:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780428979; cv=none; b=gzfMmNinDSCfX8cOYl8L+1wUkqDhaalxd66vam7gW5jFOtnmTMGcleeQSxgTi91Z/R3qPoPdyyDWX4Jo9Wt9SkWHkaOEW/Ok/I3ViNYA4U2irMTT5tEkzU2KHg0w04IJmq5E7rTRyqJ9rzAtqtynA7od/rjDM+RR9mGZE3TwIlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780428979; c=relaxed/simple;
	bh=Q5wuIyfXbUGWIb6e4RhRGfC9p9g7xxfVKEBjzyHTPJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W/nX3Bj6zUWOZADg39dpUiI0MmmN9MdGzzE5TtvrUy2Sr/eTKLKtYNmT/bB7HzSFLZUX6CTpD5u8UExdUEjaYbBQt2HyArpZOZ/m+JiK1QM6PWHuO/ZAE7E3brenZbHduoyNyYp13EQa/stxjnvVnyUa+s0vC55QM/1jGvNUSJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h+3tZqgt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+3tZqgt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B15031F00893;
	Tue,  2 Jun 2026 19:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780428978;
	bh=DSC1ySN4bnfEV2cYnPyHPvXBXJA0rr8bb1k3UPRfk4Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=h+3tZqgtF9NzO1JdQ4D5VUGtYe3gD32UnuRoKTSxUAq12LShaHtlpJTyskq2SHhlZ
	 whuw/8AGMyRo16hqPXnhrdtpnRZbdPEt1QL1NL6Cz1n3OthfrlhwOqVk8m5LuU5zdh
	 W0edsvJpbHou4TPiBlwBi520nYmv4s3S7nlnE82h8sDd4HP9k3qOZhiNQxS89Wlleo
	 CycUIcU03pwah9UH/U5PBkgEdougl3mp9VAqXoGSYIXhAZKRBCNwAJK2uZysbPs2M+
	 +28uJD5NXbk37NAn2molXE41fDJah9Kd3R0BW8x/QESy6e4RKcuDefZHVxOu9nzFAh
	 dzFtc5r312ROA==
Message-ID: <f97592a2-6690-4511-a98c-dacdeedf6516@kernel.org>
Date: Tue, 2 Jun 2026 13:36:17 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next] iplink: add support for setting IPv4
 devconf parameters
Content-Language: en-US
To: Fernando Fernandez Mancera <fmancera@suse.de>, netdev@vger.kernel.org
Cc: stephen@networkplumber.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, Nicolas Dichtel <nicolas.dichtel@6wind.com>
References: <20260601143242.6729-1-fmancera@suse.de>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260601143242.6729-1-fmancera@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/1/26 8:32 AM, Fernando Fernandez Mancera wrote:
> Currently, modifying IPv4 interface configuration parameters requires
> interacting with sysctl (/proc/sys/net/ipv4/conf/*). While
> ip-netconf exists for monitoring these values, there has been no native
> way to set them directly through iproute2.
> 
> This patch introduces the support for that via 'inet' at the 'ip link
> set'. It uses IFLA_INET_CONF netlink attribute to set the parameter.
> 
> Example to enable forwarding on an interface:
> 
> ip link set dev enp8s0 inet forwarding on

If an attribute can be set this way, then ip link show needs to show the
values. What's the plan on that front?

> 
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
> ---
>  ip/iplink.c           | 354 ++++++++++++++++++++++++++++++++++++++++++
>  man/man8/ip-link.8.in |  81 ++++++++++
>  2 files changed, 435 insertions(+)
> 

...

>  		"		[ gso_max_size BYTES ] [ gso_ipv4_max_size BYTES ] [ gso_max_segs PACKETS ]\n"
> @@ -551,6 +569,339 @@ static int iplink_parse_vf(int vf, int *argcp, char ***argvp,
>  	return 0;
>  }
>  
> +static int iplink_parse_inet(int *argcp, char ***argvp, struct iplink_req *req)
> +{
> +	struct rtattr *afs, *afinet, *inet_devconf;
> +	char **argv = *argvp;
> +	int argc = *argcp;
> +	int ret;
> +
> +	afs = addattr_nest(&req->n, sizeof(*req), IFLA_AF_SPEC);
> +	afinet = addattr_nest(&req->n, sizeof(*req), AF_INET);
> +	inet_devconf = addattr_nest(&req->n, sizeof(*req), IFLA_INET_CONF);
> +
> +	while (NEXT_ARG_OK()) {
> +		NEXT_ARG();
> +		if (matches(*argv, "forwarding") == 0) {

new uses of matches are not allowed. If s/matches/strcmp/ is the only
comment, I can fix up before applying.



