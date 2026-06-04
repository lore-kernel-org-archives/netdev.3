Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC9D320CD9
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 15:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780585857; cv=none; b=K/AW/Th4XOcJbwF0xTvG4SXACulMCbb8uVFh3AhV9gSBqWqkPx/XUSa3YgotjcXCjjBkomizgJsQ+HvW1EdPXpeeRRkBuJ+ie05QRJXGLnof6n+HpOgZ84ndfwDEAc20Rz4exNHjwyoUfagJXgNCKNFWid8CPKS+GzJKgrsM6K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780585857; c=relaxed/simple;
	bh=9FA2owq/h4NsoaW0r3Zz2b5bNjxtfSxbfhbIBlb13qs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j9iUO4Z8WOus6zUCLJJ5rb2bf2NRYo1TGIzo4seS95Ar+9v9JCfrgCr007+09ndbCNRIIkS5PLwldIuENV9ILY769d+ZUsnB24d/1Gz6vkJBhOeXeTjE4UqS1g8cgyWfDRIjeSneduC66EeZopHt4EJUSps3MR+FrL62GH0SXFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M9rS+DdZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M9rS+DdZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C5DC1F00893;
	Thu,  4 Jun 2026 15:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780585856;
	bh=+d5rm5cShWLOZj0zr0blxBPlBN3G2F5ZfzUEFqBP58Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=M9rS+DdZxkf7x1uq4bM2zzQFoj81UH6sFHePHOiY+JBnv1NFt4BCH8tn5x+F1FE+t
	 yeBjCmTh74YCB68eKdZlhSAHnhP/HXrZGlOfS5SjN2pBAWS737e+abcOhD6coYEE7J
	 oYsGJZDM+3NkkjpVens7uLzF/w5xulq0BRXcTzyFyq64LyAXKo3NKJSVKPWEQHZhbd
	 dIM+1HHNYRB77IPTsg8/R3eeiEDVpC50eGOJmipJ6rI4eOJ2Q+HlVsWWWTOPRwQBv0
	 yXX9HetnOg/nZbL3xxBYSYyHUXdgkydjXupOZG8q6L3ZqcDfL9C0ooCwiTfpd8ScrZ
	 aKZh93Sbr3MDg==
Message-ID: <25d51ba2-12b3-4e24-a60c-71d215637815@kernel.org>
Date: Thu, 4 Jun 2026 09:10:55 -0600
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
 pabeni@redhat.com
References: <20260601143242.6729-1-fmancera@suse.de>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260601143242.6729-1-fmancera@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
> 
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
> ---
>  ip/iplink.c           | 354 ++++++++++++++++++++++++++++++++++++++++++
>  man/man8/ip-link.8.in |  81 ++++++++++
>  2 files changed, 435 insertions(+)
> 

applied to iproute2-next after s/matches/strcmp/ and fixed up the code
to keep lines of reasonable length. iproute2 follows netdev with coding
standards and those need to be followed as long as humans are in the
loop. Please make sure follow on patches adhere to roughly 80 columns
with a little extra if it improves readability (and of course strings
are not broken across lines).

claude had one quibble with the man page update - please send a fixup:

1. Man page indent imbalance (visible bug) — man/man8/ip-link.8.in
synopsis opens the inet block with .in +8 but closes with .in -10.
Confirmed by rendering with groff: the [ macaddr ... ] line and
everything after it is indented 2 columns to the left of the baseline.
Should be .in -8. The detailed-description section (~lines 2661/2699) is
already correctly paired.


