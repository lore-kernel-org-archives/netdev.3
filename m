Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0B835E956
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 22:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790893673; cv=none; b=YnT1IKe/C07vbidck+jouFAxx6Qf4VGe7eqVjy3bOLL4IfYvEcf2dOl7BTtZa7dldRQ+ISmZjN34QBIV1Hu5AyJwldRO1BWpPInZMIrD5c/EBQaoDIGABvAsxw+APOKmPyKrmo3vH1B20nS9rkEqnqG8GKCXPv3sLQT7DPDk84M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790893673; c=relaxed/simple;
	bh=fA81x/tknEodkESk5deyQ7EtllPeBDtdXhI+i+uLBWQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TEW64hoDFYzs4pM62EbuOzrgR4JXNEp/tP5niM2zdWs4HAuXVG2DhWW4jTU7/2FQhWwl2qqRoaFbLd0RnhS0hNkfyKUE6cKSiUyjbZH+ibtqR91kBg6ZJTlWz90NJt6YlYbLPLcEU30QhYELBi//eBvDJrhapFhnnIGZbsFlb3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gqPm+at3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gqPm+at3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 819D61F000FF;
	Thu,  1 Oct 2026 22:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790893672;
	bh=UaQ0AyPHGXNRQK7Nlm6qeoI3KL3U1CQ+Uag9BgHgWvE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=gqPm+at3NYHGpxBDr9bXsYQk921Q065ta3iRhT8gdKvIkHaBzsmZkVWBmC2H1MJox
	 nO0HCQdGU6of6cuw38WAavaMbB7rCWaQ1Txb8GAKTHmE8A4o4qqcvVx/qZCOEdJKk3
	 9e9fORqa+GesO2TmVnO+0BndAycXwq28lrGdoWW9DqWSoDHztWJAKqVdeWDUJAJ6if
	 bUiK2uminPbq6YfFhu9r6E5NEGL4mwp+uRmqVGvoH41C6wMAha+G7WL3QLAjqKSMlQ
	 2PHOFme/jFZ6ncvgHbGAt8deO4e0B61JUFtUpZqmj5n+TT4BlWp1iR8M/9rZ9JH9rV
	 pcrSXCyvYiiYw==
Subject: Re: [PATCH net-next 5/7] selftests: ovpn: wait for the TCP server key
 setup before traffic
From: netdev-bot+sashiko@kernel.org
To: antonio@openvpn.net
Cc: netdev@vger.kernel.org, ralf@mandelbit.com, sd@queasysnail.net,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com
Date: Thu, 01 Oct 2026 22:27:51 +0000
Message-ID: <179089367106.434549.3098615866508622379@kernel.org>
In-Reply-To: <20260930222542.3839327-6-antonio@openvpn.net>
References: <20260930222542.3839327-6-antonio@openvpn.net>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] ovpn_wait_tcp_keys() (common.sh) runs a bare `wait
  "${OVPN_TCP_KEYS_PID}"` with no timeout.
- [Low] The new 'wait for server-side key setup' check passes even when
  the server key install fails for any peer except the last one.

--

selftests: ovpn: wait for the TCP server key setup before traffic

In TCP mode, this patch saves the PID of the background subshell that
runs "ovpn-cli listen" and installs the server-side data keys. It also
adds ovpn_wait_tcp_keys(), which waits on that PID. test.sh and
test-close-socket.sh call it after all peers are registered and before
any traffic is sent.

> diff --git a/tools/testing/selftests/net/ovpn/common.sh b/tools/testing/selftests/net/ovpn/common.sh
> index 2f7851b823436..96b40742eddfe 100644
> --- a/tools/testing/selftests/net/ovpn/common.sh
> +++ b/tools/testing/selftests/net/ovpn/common.sh
> @@ -264,6 +264,7 @@ ovpn_add_peer() {
>  						1 0 ${OVPN_ALG} 0 data64.key
>  				done
>  			}) &
> +			OVPN_TCP_KEYS_PID=$!

[Severity: Low]
Does this subshell's exit status report a new_key failure for any peer
other than the last one? The subshell in ovpn_add_peer() is:

	(ip netns exec "${server_ns}" ${OVPN_CLI} listen tun0 \
		1 ${M_ID} ${OVPN_TCP_PEERS_FILE} && {
		for p in $(seq 1 ${OVPN_NUM_PEERS}); do
			ip netns exec "${server_ns}" \
				${OVPN_CLI} new_key tun0 ${p} \
				1 0 ${OVPN_ALG} 0 data64.key
		done
	}) &

ovpn_cmd_run() calls ovpn_add_peer 0 as an if condition:

	if "$@" >"${output_file}" 2>&1; then

That ignores errexit for the whole function body, including this forked
subshell. So the loop keeps going after a failed new_key, and the
subshell exits with the status of the last new_key only.

If new_key fails for any of peers 1..N-1, wait "${OVPN_TCP_KEYS_PID}"
in ovpn_wait_tcp_keys() still returns 0. The "wait for server-side key
setup" step then reports success.

The error output also seems to be lost. The subshell's stdout and
stderr still point at the mktemp file from the "register peer0 in
overlay" call. ovpn_cmd_run() deletes that file with rm -f as soon as
ovpn_add_peer 0 returns. If the wait does fail, ovpn_cmd_run() prints
the wait step's own output file, which is empty.

In both cases the missing key only shows up later, as a ping failure
for that peer.

Could the subshell record a failure from any new_key and exit non-zero,
and write its output somewhere that still exists when
ovpn_wait_tcp_keys() runs?

>  			sleep 5
>  		else
>  			peer_ns="ovpn_peer${1}"
> @@ -281,6 +282,18 @@ ovpn_add_peer() {
>  	fi
>  }
>  
> +# In TCP mode the server accepts the peers and installs their data keys from a
> +# background subshell. "listen" only returns once every peer has connected, so
> +# the key installation necessarily runs after ovpn_add_peer() has been called
> +# for the last peer. Wait for that subshell to finish before generating any
> +# traffic, otherwise the first packets may race the key installation and get
> +# dropped for lack of a key.
> +ovpn_wait_tcp_keys() {
> +	[ -n "${OVPN_TCP_KEYS_PID:-}" ] || return 0
> +
> +	wait "${OVPN_TCP_KEYS_PID}"

[Severity: Medium]
Can this wait block forever?

The subshell exits only after ovpn-cli listen returns. In the
CMD_LISTEN case of ovpn_run_cmd() in ovpn-cli.c, listen does three
things in order:

  - a blocking ovpn_accept() for every line of the peers file
  - a blocking ovpn_recv_tcp_data() on each accepted socket
  - ovpn_waitbg(), which lets the parent exit

The two blocking calls have no timeout.

Before this patch nothing waited on that PID, so a stuck listen made
the test fail at the ping stage. With this patch the network setup
stage hangs instead. Under the kselftest runner it would be killed by
the timeout and reported as TIMEOUT.

I can see two ways to reach this.

First, the new comment says that "listen" only returns once every peer
has connected. But listen counts lines in the peers file, not
OVPN_NUM_PEERS, and OVPN_NUM_PEERS can be set from the environment:

	OVPN_NUM_PEERS=${OVPN_NUM_PEERS:-$(wc -l ${OVPN_TCP_PEERS_FILE} | \
		awk '{print $1}')}

For example, OVPN_NUM_PEERS=3 ./test-tcp.sh creates only 3 clients.
listen then blocks in accept() waiting for the 4th entry in
tcp_peers.txt.

Second, CMD_CONNECT ignores the result of ovpn_send_tcp_data():

		ret = ovpn_send_tcp_data(ovpn->socket);
		ovpn_waitbg();

The client's parent still exits 0 through daemon(), so "register peerN
in overlay" passes. The daemonized client keeps the socket open in
pause(), so the server's recv() on that socket can block forever. A
kernel regression in the ovpn TCP path that stops the payload from
reaching recv() would cause the same hang.

Would it make sense to bound this wait, for example with timeout on
listen or a polling loop around kill -0, so these cases fail with an
error message instead of hanging?

> +}
> +

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930222542.3839327-2-antonio%40openvpn.net
