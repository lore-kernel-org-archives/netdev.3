Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C2228CF5D
	for <netdev@vger.kernel.org>; Sun, 28 Jun 2026 17:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782667842; cv=none; b=LoqyMiQs2n4/GDZdCrVyuRaaG+IIazSGGmDApGtqznykQLoSZL3aQyyX3vijdJkYbCW89w38Y/SH/l6CimHHpS4K9I7mzveFZPf8hjd5SINjeb5TtLth28iywmk8x6uwXb0rYsoa+fhEE5qTntiZoNbvYZAVApgMRXQjzmXCrzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782667842; c=relaxed/simple;
	bh=UOd4PCagrSfLiLuMPu95jDgkFbBWwM/hA8HenaYlzCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C99AcQrGqT3PiNLGsDkDtc1/14DI2mmQPTR2UIiK0kLAxwM5mibXX65vq8nG2dV8ZecZg0U3004DU2860Sr8d1UAfoaMWib7Ob9IQr99c25Hl/eKg33nLt7XZitSWxgG/tS271kgE3VuyWdM5JxLmjbKruAp/yQsayXyB/1gc/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XK09RP/D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XK09RP/D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BF431F000E9;
	Sun, 28 Jun 2026 17:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782667840;
	bh=vXC5hPpLV+1Ac/7F0+Js4zR9vJrTp00r7bbjd3kswpI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=XK09RP/DrrXfmh0fXaiaXPeYViGF2ETbt+JMAsdp7yawpjRAR291VNy/uHE+kRInE
	 FvB9Wu4VSqge6oRAuMjEhG8obws78s314T/betPSVN7P6I13gLuYjfAX3shMHC9kYM
	 AbkjV7sis+VQjEnpUZWpJQaGxmv404ly8G5PlpA0VVR94yfL9kzv2MEKp/Trc9/vMF
	 yuZwUP7b75IvZ0NaqNc6oHwr9TOWTSBmAbybi1o02eLmAlI45OI+/jL060xIvDXd/2
	 f+xKA92QkWU4smu8NHqUSixWtHaoye7Ceu4BN+d5e1Ghmv7lkFLA6WCqhAe6TxDjFD
	 MJwUSaomIvJ1w==
Message-ID: <6b9df322-718e-4515-a944-48122ed8574c@kernel.org>
Date: Sun, 28 Jun 2026 11:30:39 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute-next v3] ipaddress: add support for showing IPv4
 devconf attributes
Content-Language: en-US
To: Fernando Fernandez Mancera <fmancera@suse.de>, netdev@vger.kernel.org
Cc: stephen@networkplumber.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
References: <20260614182515.8765-1-fmancera@suse.de>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260614182515.8765-1-fmancera@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/14/26 12:25 PM, Fernando Fernandez Mancera wrote:
> This patch introduces support for showing IPv4 devconf attributes on
> detailed output of an interface e.g "ip -d link show dev enp1s0".
> 
> Additionally, this refactors 'print_af_spec()' to sequentially process
> both AF_INET and AF_INET6 attributes rather than returning early if
> AF_INET6 is missing.

refactors should be a separate patch.

> 
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
> ---
> v2: changed print_string to print_bool for boolean attributes
> v3: use print_bool for JSON output only
> ---
>  ip/ipaddress.c | 313 ++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 273 insertions(+), 40 deletions(-)
> 
> diff --git a/ip/ipaddress.c b/ip/ipaddress.c
> index 6017bc83..1530b836 100644
> --- a/ip/ipaddress.c
> +++ b/ip/ipaddress.c
> @@ -23,6 +23,7 @@
>  #include <linux/netdevice.h>
>  #include <linux/if_arp.h>
>  #include <linux/if_infiniband.h>
> +#include <linux/ip.h>
>  #include <linux/sockios.h>
>  #include <linux/net_namespace.h>
>  
> @@ -294,53 +295,285 @@ static void print_linktype(FILE *fp, struct rtattr *tb)
>  	close_json_object();
>  }
>  
> +static void print_inet(FILE *fp, struct rtattr *inet_attr)
> +{
> +	struct rtattr *tb[IFLA_INET_MAX + 1];
> +
> +	parse_rtattr_nested(tb, IFLA_INET_MAX, inet_attr);
> +
> +	if (tb[IFLA_INET_CONF]) {
> +		int *conf = RTA_DATA(tb[IFLA_INET_CONF]);
> +		int max_elements = RTA_PAYLOAD(tb[IFLA_INET_CONF]) / sizeof(int);
> +
> +		if (max_elements >= IPV4_DEVCONF_FORWARDING) {
> +			print_bool(PRINT_JSON, "forwarding", NULL,
> +				   conf[IPV4_DEVCONF_FORWARDING - 1]);
> +			print_string(PRINT_FP, "forwarding", "forwarding %s ",
> +				     conf[IPV4_DEVCONF_FORWARDING - 1] ? "on" : "off");
> +		}
> +
> +		if (max_elements >= IPV4_DEVCONF_MC_FORWARDING) {
> +			print_bool(PRINT_JSON, "mc_forwarding", NULL,
> +				   conf[IPV4_DEVCONF_MC_FORWARDING - 1]);
> +			print_string(PRINT_FP, "mc_forwarding", "mc_forwarding %s ",
> +				     conf[IPV4_DEVCONF_MC_FORWARDING - 1] ? "on" : "off");
> +		}
> +
> +		if (max_elements >= IPV4_DEVCONF_PROXY_ARP) {
> +			print_bool(PRINT_JSON, "proxy_arp", NULL,
> +				   conf[IPV4_DEVCONF_PROXY_ARP - 1]);
> +			print_string(PRINT_FP, "proxy_arp", "proxy_arp %s ",
> +				     conf[IPV4_DEVCONF_PROXY_ARP - 1] ? "on" : "off");
> +		}
> +
> +		if (max_elements >= IPV4_DEVCONF_ACCEPT_REDIRECTS) {
> +			print_bool(PRINT_JSON, "accept_redirects", NULL,
> +				   conf[IPV4_DEVCONF_ACCEPT_REDIRECTS - 1]);
> +			print_string(PRINT_FP, "accept_redirects",
> +				     "accept_redirects %s ",
> +				     conf[IPV4_DEVCONF_ACCEPT_REDIRECTS - 1] ? "on" : "off");

As I stated in the last patch for devconf:

"iproute2 follows netdev with coding standards and those need to be
followed as long as humans are in the loop. Please make sure follow on
patches adhere to roughly 80 columns with a little extra if it improves
readability (and of course strings are not broken across lines)."

Use print_on_off for example for these or use a temp variable for the
attributes.


