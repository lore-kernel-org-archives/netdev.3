Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2718D3BE155
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 08:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791880877; cv=none; b=fxKjTKBzyaV7LDlx93fTT0+/HTiHvWMs1E8+NBNaeZPqmtrsTpIVfI1HGkvs13lPzdRYxrI2PkYU3AiuPko+q7ziKa5B9T+oh9q998bsBIAuB1RNFDoCqLaZDvA2JZAZHXtK9ti2uKBMWOkKh5IpJeBDk/uSCxDa4dwBYQPf6iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791880877; c=relaxed/simple;
	bh=HdV2lf1RSnZt4JJg5NsL/gxvZ4pNyy8xfT7j/N4E6uQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nQHKai6pOovjNA2nJMfUMc0+qm65i2/a1Y9RHkIbxCl6ZR2MvoItkM5gB+/0HmrsZqRRJS//6BNvXOf3B1iGNLz7FYM6i1qZRMAbgBI8kH/vjMB73RAvo2oQZLPAInOAn8v/yklvgQ67BQGOGMjA7igKqgc/pdqt2Yihx8BXNCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DRIF1qvz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DRIF1qvz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 368731F000FF;
	Tue, 13 Oct 2026 08:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791880874;
	bh=dauLebWjc4cMcvBim0l5yF31Aaj2J57N980UuMWrHyw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DRIF1qvzzLcHosNq2Sp5+M+MVe11MVnFPPNgcLKE2mc79D+GWs+9zOqU3QGCWO9Sz
	 7Gv9DOpD1QH7eY4VQPqHNDtVGDeEfBfDC6xEmNHGcS1j8YTm0ZvwwsWm4KvjtpHMzh
	 7hPg/py15cAAE9tojsEhSA3xPStZsRRdUmo4K28FtJ30TZC7dL3Nk6Pr7SxwGJ9fiq
	 CON/Qew9vRN1ndrRqmupXCtxyT4id1fM4KJRg0FX8tHoqxsdehFdMnjxe1jV0hXc8x
	 y7p01S8e0289UZfPTuav1wxk0Deo/5s9jxc3lYAzQuOsrFsUkKgxVxHZja+of9YoZk
	 mkPfnU56Jb7Cg==
Date: Tue, 13 Oct 2026 10:41:11 +0200
From: Antoine Tenart <atenart@kernel.org>
To: Prasenjit Mukherjee <pmukherj@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	David Ahern <dsahern@kernel.org>, Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, 
	netdev@vger.kernel.org, Davide Caratti <dcaratti@redhat.com>
Subject: Re: [PATCH net] selftests: net: fix race condition in icmp.sh
 causing CKI sporadic failures
Message-ID: <as3uX-HDEKesn4xT@kwain>
References: <b15ee681a330f9b05a9076a3852c186017f59d83.1791804421.git.pmukherj@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b15ee681a330f9b05a9076a3852c186017f59d83.1791804421.git.pmukherj@redhat.com>

On Mon, Oct 12, 2026 at 06:23:32PM +0530, Prasenjit Mukherjee wrote:
> CKI reports sporadic failures in icmp.sh, Davide suggests this might be
> caused by a race condition where tcpdump starts capturing after the last of
> expected ICMP unreachable packets have been sent.
> Fix this replacing tcpdump with a tc flower filter that
> matches ICMP Destination Unreachable (type 3, code 0),
> and match on act_gact counters instead.
> This will remove any race condition to appear.
> 
> Fixes: 7e9838b7915e2 ("selftests/net: Add icmp.sh for testing ICMP dummy address responses")
> CC: Toke Høiland-Jørgensen <toke@redhat.com>
> Suggested-by: Davide Caratti <dcaratti@redhat.com>
> Reviewed-by: Davide Caratti <dcaratti@redhat.com>
> Reported-by: CKI Project <cki-project@redhat.com>
> Closes: https://datawarehouse.cki-project.org/issue/3658
> Signed-off-by: Prasenjit Mukherjee <pmukherj@redhat.com>

Reviewed-by: Antoine Tenart <atenart@kernel.org>

> ---
>  tools/testing/selftests/net/icmp.sh | 32 ++++++++++++++---------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/icmp.sh b/tools/testing/selftests/net/icmp.sh
> index 824cb0e35eff..0714e8b34d12 100755
> --- a/tools/testing/selftests/net/icmp.sh
> +++ b/tools/testing/selftests/net/icmp.sh
> @@ -27,11 +27,8 @@ PINGADDR=172.16.1.1
>  RT2=172.16.0.0/24
>  H2_IP6=2001:db8:1::2
>  
> -TMPFILE=$(mktemp)
> -
>  cleanup()
>  {
> -    rm -f "$TMPFILE"
>      cleanup_ns $NS1 $NS2
>  }
>  
> @@ -52,21 +49,24 @@ ip -netns $NS2 route add $RT2 via inet6 $H1_IP6
>  
>  # Make sure ns2 will respond with ICMP unreachable
>  ip netns exec $NS2 sysctl -qw net.ipv4.icmp_ratelimit=0 net.ipv4.ip_forward=1
> +# Install tc flower filter to count ICMP unreachable from 192.0.0.8
> +ip netns exec $NS1 tc qdisc add dev veth0 clsact
> +ip netns exec $NS1 tc filter add dev veth0 ingress \
> +	protocol ip pref 1 handle 1 flower \
> +	src_ip 192.0.0.8 ip_proto icmp type 3 code 0 \
> +	action pass
>  
> -# Run the test - a ping runs in the background, and we capture ICMP responses
> -# with tcpdump; -c 1 means it should exit on the first ping, but add a timeout
> -# in case something goes wrong
> -ip netns exec $NS1 ping -w 3 -i 0.5 $PINGADDR >/dev/null &
> -ip netns exec $NS1 timeout 10 tcpdump -tpni veth0 -c 1 'icmp and icmp[icmptype] != icmp-echo' > $TMPFILE 2>/dev/null
> +# Send ping to trigger ICMP unreachable from ns2
> +ip netns exec $NS1 ping -c 1 $PINGADDR >/dev/null 2>&1
>  
> -# Parse response and check for dummy address
> -# tcpdump output looks like:
> -# IP 192.0.0.8 > 172.16.0.1: ICMP net 172.16.1.1 unreachable, length 92
> -RESP_IP=$(awk '{print $2}' < $TMPFILE)
> -if [[ "$RESP_IP" != "192.0.0.8" ]]; then
> -    echo "FAIL - got ICMP response from $RESP_IP, should be 192.0.0.8"
> -    exit 1
> -else
> +# Verify ICMP unreachable was received from dummy address 192.0.0.8 per RFC7600
> +COUNT=$(ip netns exec $NS1 tc -j -s filter show dev veth0 ingress \
> +	| jq '.[1].options.actions[].stats.packets')
> +
> +if [[ "$COUNT" -eq 1 ]]; then
>      echo "OK"
>      exit 0
> +else
> +    echo "FAIL - expected 1 ICMP unreachable from 192.0.0.8, got $COUNT"
> +    exit 1
>  fi
> -- 
> 2.55.0
> 
