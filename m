Received: from mta0.migadu.com (out-224.mta0.migadu.com [91.218.175.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A06A391E52
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 06:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791873192; cv=none; b=M6o7Sx9xbt49cV6+afV7jL5M3attllGnZTPKKHqyC68Iz41MV+7fsQR3fJhUUUjTqK9x651IRPOMDaG0L+297ixn02QhYXSHZMkEkkGupemLqPkEFpiOp2YNH9HFEMlko/nGVwYOxWOe/QhIdQM+I4oCz/QxfV8WFwdImfqTioY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791873192; c=relaxed/simple;
	bh=XVxuLMoX0zIlKVesEWn7dtGmWeyxZzUJ3pLhkZjDcOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ND9G4Q7jP4TGiBVAY207yO3jxH3XxVH0Vd1q/Zk36If8igYf25FnKAP6gStTQi0FlKglIeAWYLVwuI78HbZuyAXFwNEtnmPUhbaS3iHafJNJvRqrL1ff3/7IiEtcWYnTXZMaW5JJp8sLsy4eNTiMZjcZKJtB02cFLZF1g5YVUK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GoxhJyIc; arc=none smtp.client-ip=91.218.175.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GoxhJyIc"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=XVxuLMoX0zIlKVesEWn7dtGmWeyxZzUJ3pLhkZjDcOE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791873188; v=1; x=1792477988;
 b=GoxhJyIcotEKQ9RWaPmSdbB3lqGpXJbwL0+v+BwbB7wgwUVPH3VLU38xl7HdUY/gIyq9UJ7h
 UlB6waZw/U0cuZY040LSROktRUgbA+xhj0KJzkYBTWXSu8jvElV2jHCy8A2FsLg5PHEL837N5+l
 kIB8EkuiXINfmO5F+5IGb4fs=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id f9062f3d95f0ed0b;
	Tue, 13 Oct 2026 06:33:08 +0000
X-Mizu-Trace-ID: f9062f3d95f0ed0b
X-Migadu-Flow: FLOW_OUT
Date: Tue, 13 Oct 2026 14:32:50 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Prasenjit Mukherjee <pmukherj@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
	netdev@vger.kernel.org, Davide Caratti <dcaratti@redhat.com>
Subject: Re: [PATCH net] selftests: net: fix race condition in icmp.sh
 causing CKI sporadic failures
Message-ID: <as3Qko-Sl60tJZ4S@fedora>
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

Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
