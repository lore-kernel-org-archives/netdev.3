Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93913322749
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 13:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791899169; cv=none; b=M9dFT9x8Syqq54D/Vw4hR690yjDQz5RjoPxQpts8Q1EiTNjPnkRMxbyn9PtC7vwgGpwR4cyBKhJpHiT0oy/0mhE5g083EmA5VBWDlpHq8vInvxy+0g0SZY4CD3eqiXXk9OtM4ipabslwNMZCZBXHxp0xSjpzHud2RfYOU6bANeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791899169; c=relaxed/simple;
	bh=c4JfTret0XN6YtnbfrHwRCA2mT2SkuVR2EL/smmE9vo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tIyZbyZYmeo7H2cjBqIRMGL0gDoQZvCSgk4w1K7grHG+Of/HDjw2scD26Qe77EW34FdYb49E2YecCaOMyAEPysA6zd4k0DrnrPVRs8hZ8rQKVRv23P+UAO16RLZPvGgb4dultNvFiT9d+d/wr1Iz9KNwFU+YHhsKRTzX/Klk9EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ORxcUQvG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORxcUQvG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDB101F000FF;
	Tue, 13 Oct 2026 13:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791899168;
	bh=orLzR8+l8zVuwsg5ArMOncGw9xSXLxUtPnq05PDF2KU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ORxcUQvGgGPJmtvScchvbAvGti5oeAHifTavr4QS7Ka0IoOdJITNAfufjKYmwt4B1
	 IWgq7pNpUvuZWMRegot3UO09lRB3tTvO7zwWERKxXdJMq1AFqirBRnA7uM8fXdmMX7
	 KtkU17zRgzRkAoiR4SBlqTpGZGtUfXsduGxTu2nrZ7E/MdxBDL7Ht4gWqq2Dp2Ui8/
	 hVpgnIueflCdPLoBDEq6qwsIlUvCE5DRkexHLYId9Ej6luwTPjPRZJLyL4iD0RD/fJ
	 2VPhsGQ7OGXD5nvlsETOtctvaV7ZbI+E4HKPVxbKioJDBlN1f7t8J+nVu/mHDM0XJV
	 Yu8aJDewWsLDQ==
Subject: Re: [PATCH net] selftests: net: fix race condition in icmp.sh causing
 CKI sporadic failures
From: netdev-bot+sashiko@kernel.org
To: pmukherj@redhat.com
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, dsahern@kernel.org,
 toke@redhat.com, netdev@vger.kernel.org, dcaratti@redhat.com
Date: Tue, 13 Oct 2026 13:46:07 +0000
Message-ID: <179189916742.434549.3086628054499882669@kernel.org>
In-Reply-To:
 <b15ee681a330f9b05a9076a3852c186017f59d83.1791804421.git.pmukherj@redhat.com>
References:
 <b15ee681a330f9b05a9076a3852c186017f59d83.1791804421.git.pmukherj@redhat.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In tools/testing/selftests/net/icmp.sh, the pass/fail result
  now depends on `jq` and on `tc` with clsact, flower and gact support,…

--

selftests: net: fix race condition in icmp.sh causing CKI sporadic failures

The patch replaces the background ping and tcpdump capture in icmp.sh
with a tc flower filter on veth0 ingress in ns1. The filter matches ICMP
Destination Unreachable packets from 192.0.0.8. The test then reads the
act_gact packet counter with tc -j and jq to decide the verdict.

Closes: https://datawarehouse.cki-project.org/issue/3658

> diff --git a/tools/testing/selftests/net/icmp.sh b/tools/testing/selftests/net/icmp.sh
> index 824cb0e35eff6..0714e8b34d120 100755
> --- a/tools/testing/selftests/net/icmp.sh
> +++ b/tools/testing/selftests/net/icmp.sh

[ ... ]

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

[Severity: Medium]
With this change the verdict depends on jq. Should the test skip rather
than fail when jq is not installed?

If jq is missing, COUNT is empty. The script then prints:

  FAIL - expected 1 ICMP unreachable from 192.0.0.8, got

and exits 1 instead of exiting with ksft_skip.

icmp.sh already sources lib.sh, which provides this helper:

tools/testing/selftests/net/lib.sh:require_command() {
	local cmd=$1; shift

	if ! check_command "$cmd"; then
		exit $EXIT_STATUS
	fi
}

Several other net selftests already call require_command jq. Would it make
sense to add require_command jq (and possibly require_command tc) near the
top of icmp.sh?

Before this patch the test needed only iproute2, ping and tcpdump. On CI
hosts without jq, this could turn the sporadic failure into a failure on
every run.

The return codes of the tc qdisc add ... clsact and tc filter add ... flower
commands above are also ignored, and the script does not use set -e. If
either command fails, the test still runs the ping and then reports a test
FAIL instead of a setup error or a skip. Should those commands be checked?

The commit message also does not mention the new jq dependency.

>      echo "OK"
>      exit 0
> +else
> +    echo "FAIL - expected 1 ICMP unreachable from 192.0.0.8, got $COUNT"
> +    exit 1
>  fi

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/b15ee681a330f9b05a9076a3852c186017f59d83.1791804421.git.pmukherj%40redhat.com
