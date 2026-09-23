Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FBA3E49DB
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 06:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790146161; cv=none; b=Vkg65Rm9aO4AXHaF6FM8r2GYIsQOJPbgVPfNsWYJdguKS9piBih2SQ2iit8BadDQdxQrpuX7qyn5whY4vNwsb7Z16gVm3N3ZVk3DRiisGO7ZnanFeIG8+bZkQlvgCZyjhrB60Lw8O3dN6GK2Z3xq+2CbBVDRDvjDWhNCVC7EPrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790146161; c=relaxed/simple;
	bh=0VuAMbtAZFlIn1jisUzbWb2Vf+Foa1hHt5b3FRyGrqg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mPZeVlbRDx7uYyswXRvZIBvEIfvk9+fOMR/y9nPKTajPiHFqSTf08j7e6rKWUDYFfcvM7JZKsW5uuJYMyJ3C94333JzJFbvB7VJXEIXdyi7yNALyLg9LOVlKRY/X8xxx7KoMhgiR106+YCWUFkvPt9t0bk4DTlETmWbzQRoRS3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fbuwO+k0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fbuwO+k0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72CFB1F000FF;
	Wed, 23 Sep 2026 06:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790146156;
	bh=udn7zR30EAiH6vlYQmqSZeYv5PvfwJEbQ64SKouxnF0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fbuwO+k0KV1Yfu61le4R43g3IraCklZ396CI8zwZdqryKNOqkD3Rcw51niDERFKCV
	 tPU0GL5ss4LCIXBYlw0O3mrd7ye3nd7vK2uezI0emV7GmHo/FUZDLZvi9wNvvEY+fe
	 r0fFVe/fGBKAh2ENIHAmp09cl/r3FdhzoMdqTwOZhVvYLbvQNxtbwkyEPE5C+V4J0P
	 EzWBpU1jB3P/SMfK9KCcz7/ogBbTxJXIIT+qAjCKXaIEO6uVa8fXcMEhPhpiuYKoOU
	 NS7O/YCThKxqTQeWV8JRCWfEJiH2Scv8lAPipETQUedlPdl9JVJrnejz2rKLldk8wq
	 M8V7onm9Bgf4w==
Subject:
 Re: [PATCH net-next 4/5] selftests: ovpn: enable TCP_NODELAY on TCP sockets
From: netdev-bot+sashiko@kernel.org
To: antonio@openvpn.net
Cc: netdev@vger.kernel.org, ralf@mandelbit.com, sd@queasysnail.net,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com
Date: Wed, 23 Sep 2026 06:49:16 +0000
Message-ID: <179014615600.2160803.7961385447309763075@kernel.org>
In-Reply-To: <20260922060852.2266148-5-antonio@openvpn.net>
References: <20260922060852.2266148-5-antonio@openvpn.net>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] New helper ovpn_tcp_nodelay() in
  tools/testing/selftests/net/ovpn/ovpn-cli.c references the TCP_NODELAY…
- [Medium] In TCP mode the server-side data keys are installed by a
  backgrounded subshell in ovpn_add_peer() ('(… ovpn-cli listen tun0 1…

--

selftests: ovpn: enable TCP_NODELAY on TCP sockets

This enables TCP_NODELAY on ovpn-cli's TCP sockets (both the accepted
server side and the connected client side) and restricts the
tcpdump-based peer ID capture check in the test script to UDP, since TCP
does not preserve record boundaries.

Two questions below.

[ ... ]

> diff --git a/tools/testing/selftests/net/ovpn/ovpn-cli.c b/tools/testing/selftests/net/ovpn/ovpn-cli.c
> index f4effa7580c0f..6b458a654a337 100644
> --- a/tools/testing/selftests/net/ovpn/ovpn-cli.c
> +++ b/tools/testing/selftests/net/ovpn/ovpn-cli.c
> @@ -470,6 +470,18 @@ static int ovpn_parse_key_direction(const char *dir, struct ovpn_ctx *ctx)
>  	return 0;
>  }
>  
> +static int ovpn_tcp_nodelay(int socket)
> +{
> +	int opt = 1;
> +	int ret;
> +
> +	ret = setsockopt(socket, IPPROTO_TCP, TCP_NODELAY, &opt, sizeof(opt));

[Severity: Medium]
Does ovpn-cli still compile with this?  TCP_NODELAY is used here for the
first time in this file, but the include block at the top of ovpn-cli.c is:

	#include <stdint.h>
	#include <stdio.h>
	#include <inttypes.h>
	#include <stdbool.h>
	#include <string.h>
	#include <errno.h>
	#include <unistd.h>
	#include <arpa/inet.h>
	#include <net/if.h>
	#include <netinet/in.h>
	#include <time.h>
	...
	#include <sys/socket.h>

netinet/in.h provides IPPROTO_TCP but not TCP_NODELAY, so unless one of the
libnl or mbedtls headers happens to pull in netinet/tcp.h on the build host,
this fails with "'TCP_NODELAY' undeclared (first use in this function)".

Other net selftests using the same setsockopt() call include both headers
explicitly, for example fin_ack_lat.c:

	#include <netinet/in.h>
	#include <netinet/tcp.h>

and txtimestamp.c does the same.

Since ovpn-cli is listed in TEST_GEN_FILES in
tools/testing/selftests/net/ovpn/Makefile and every ovpn TEST_PROGS script
invokes it, would a failure here take out the whole ovpn suite?  Would
adding #include <netinet/tcp.h> be the fix?  It is still missing at the end
of the series (bc56ca6a91b2).

> +	if (ret < 0)
> +		perror("setsockopt for TCP_NODELAY");
> +
> +	return ret;
> +}
> +

[ ... ]

> diff --git a/tools/testing/selftests/net/ovpn/test.sh b/tools/testing/selftests/net/ovpn/test.sh
> index 9b5610837032f..d744c1a97d5fc 100755
> --- a/tools/testing/selftests/net/ovpn/test.sh
> +++ b/tools/testing/selftests/net/ovpn/test.sh
> @@ -67,35 +67,33 @@ ovpn_run_basic_traffic() {
>  	local tcpdump_timeout="1.5s"
>  
>  	for p in $(seq 1 ${OVPN_NUM_PEERS}); do
> -		# The first part of the data packet header consists of:
> -		# - TCP only: 2 bytes for the packet length
> -		# - 5 bits for opcode ("9" for DATA_V2)
> -		# - 3 bits for key-id ("0" at this point)
> -		# - 12 bytes for peer-id:
> -		#     - with asymmetric ID: "${p}" one way and "${p} + 9" the
> -		#	other way
> -		#     - with symmetric ID: "${p}" both ways
> -		header1=$(printf "0x4800000%x" ${p})
> -		header2=$(printf "0x4800000%x" $((p + OVPN_ID_OFFSET)))
> -		raddr=""
>  		if [ "${OVPN_PROTO}" == "UDP" ]; then
> +			# The first part of the data packet header consists of:
> +			# - 5 bits for opcode ("9" for DATA_V2)
> +			# - 3 bits for key-id ("0" at this point)
> +			# - 3 bytes for peer-id:
> +			#     - with asymmetric ID: "${p}" one way and "${p} + 9" the
> +			#	other way
> +			#     - with symmetric ID: "${p}" both ways
> +			header1=$(printf "0x4800000%x" ${p})
> +			header2=$(printf "0x4800000%x" $((p + OVPN_ID_OFFSET)))
>  			raddr=$(awk "NR == ${p} {print \$3}" \
>  				"${OVPN_UDP_PEERS_FILE}")
> +			peer_ns="ovpn_peer${p}"
> +
> +			timeout ${tcpdump_timeout} ip netns exec "${peer_ns}" \
> +				tcpdump --immediate-mode -p -ni veth${p} -c 1 \
> +				"$(ovpn_build_capture_filter "${header1}" "${raddr}")" \
> +				>/dev/null 2>&1 &
> +			tcpdump_pid1=$!
> +			timeout ${tcpdump_timeout} ip netns exec "${peer_ns}" \
> +				tcpdump --immediate-mode -p -ni veth${p} -c 1 \
> +				"$(ovpn_build_capture_filter "${header2}" "${raddr}")" \
> +				>/dev/null 2>&1 &
> +			tcpdump_pid2=$!
> +
> +			sleep 0.3
>  		fi
> +		ovpn_cmd_ok "send baseline traffic to peer ${p}" \
> +			ip netns exec ovpn_peer0 \
> +			ping -qfc 100 -w 3 5.5.5.$((p + 1))

[Severity: Medium]
Can moving "sleep 0.3" inside the UDP-only branch make the TCP variants
flaky?  It was the only delay between peer setup and the first ping, and in
TCP mode the server-side data keys are installed by a backgrounded subshell
in ovpn_add_peer() whose PID is discarded:

tools/testing/selftests/net/ovpn/common.sh:ovpn_add_peer() {
	...
		(ip netns exec "${server_ns}" ${OVPN_CLI} listen tun0 \
			1 ${M_ID} ${OVPN_TCP_PEERS_FILE} && {
			for p in $(seq 1 ${OVPN_NUM_PEERS}); do
				ip netns exec "${server_ns}" \
					${OVPN_CLI} new_key tun0 ${p} \
					1 0 ${OVPN_ALG} 0 data64.key
			done
		}) &
	...
}

The "listen" command returns as soon as all peers are accepted, because
CMD_LISTEN ends in ovpn_waitbg() -> daemon(1, 1), so the new_key loop runs
concurrently with the foreground script.  With the sleep now gone for TCP,
ovpn_run_basic_traffic() starts "ping -qfc 100 -w 3 5.5.5.2" with no
synchronization against that loop.

If "new_key tun0 1" has not landed yet, server to client packets for peer 1
are dropped for lack of a key, and with -c 100 plus the -w 3 deadline ping
exits non-zero, so ovpn_cmd_ok reports "run baseline data traffic" as
failed.

Would recording the background setup PID and waiting for it (or polling
get_key) before generating traffic be more robust than relying on the
incidental sleep?

>  @@ -103,8 +101,10 @@ ovpn_run_basic_traffic() {
>  			ip netns exec ovpn_peer0 \
>  			ping -qfc 100 -s 3000 -w 3 5.5.5.$((p + 1))
>  
> -		wait "${tcpdump_pid1}" || return 1
> -		wait "${tcpdump_pid2}" || return 1
> +		if [ "${OVPN_PROTO}" == "UDP" ]; then
> +			wait "${tcpdump_pid1}" || return 1
> +			wait "${tcpdump_pid2}" || return 1
> +		fi
>  	done
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922060852.2266148-2-antonio%40openvpn.net
