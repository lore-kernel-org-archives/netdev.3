Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3FC501F5F
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 14:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791902392; cv=none; b=u5X7enZzXTNeewsKNswxQOjm+6Zy5Zaj+ggq7hlWsN0JuhU+eZV1VdmkivhHRcGqyXdH6lEdzf84Gv6pBniVKjT9ymaqjGgfgD+2KeZtUT1Oi6f5bwQv6Td67UGu5PgOMKDPQ5XOcyzuuapZLDyIZB9x+ERZ7k286VoZaMAuxnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791902392; c=relaxed/simple;
	bh=CldsFQ+st2kt9P1OA5Jp0hoDoosAjRLuXzqgI9NX5Cg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YQ76YkWH4+yAk5Q25z2BgwOoD0WdtLKTSKlp5S6uWjHwLW+EIOLGTTtkGBWQsyf53Ns6d50TMx4BzByTm0QAEZrKNYSFq5pYF6kO49hadCE+G51iK6GMX0Ufwc1/7JZsVYgy0ofo/e3J2tX4VaTeNABNSXs/13bwXPzjDKLZkHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aXvNIsOx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXvNIsOx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1997B1F00899;
	Tue, 13 Oct 2026 14:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791902390;
	bh=oIsH+XufLhVd+p65ClCVL80FofoGGNi5D9mOqceGMnc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=aXvNIsOxjUkVpje48f/EOqcfzM8LzqcDzr3F2zagTIQBxG/m3d+BHt6T/SFMapGyR
	 z/4Fn9a6YdkgUp2WWnZOkApcSU/wFBPWggtvCLiFExYe1U3ra3WDn0eID7o2sriYs4
	 v35luAiCHpVEVXLrwWKppWqbK8FM++3K9koGjuO4lGJ+grBwlazkDMI2G0Q5I/aX81
	 1SvKiHvnrjR0Xzltafg6wJT5AQusgjsFxrMTn/4UYlVJQrN6840/urfww0+l2XcxlN
	 IzdGtw+tDdJQd2hnXATolZLSczQs3BUTk4oqZ3xLiyg9rBafrJRx0n1YWaToq36mL2
	 Y+bm+2PHlEwFw==
Subject: Re: [PATCH net-next 5/6] selftests: ovpn: wait for the TCP server key
 setup before traffic
From: netdev-bot+sashiko@kernel.org
To: antonio@openvpn.net
Cc: netdev@vger.kernel.org, sd@queasysnail.net, ralf@mandelbit.com,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com
Date: Tue, 13 Oct 2026 14:39:49 +0000
Message-ID: <179190238965.434549.14700774313324207816@kernel.org>
In-Reply-To: <20261012133809.2477063-6-antonio@openvpn.net>
References: <20261012133809.2477063-6-antonio@openvpn.net>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit fixes a real ordering race but has no Fixes: tag.
- [Low] In TCP mode, ovpn_add_peer() creates a temporary file with
  `OVPN_TCP_KEYS_LOG=$(mktemp)` and redirects the background subshell…
- [Low] ovpn_wait_tcp_keys() decides whether the background subshell is
  still running with `while kill -0 "${OVPN_TCP_KEYS_PID}"`.

--

selftests: ovpn: wait for the TCP server key setup before traffic

This patch saves the PID of the background TCP server subshell that
ovpn_add_peer() starts. That subshell runs listen and then new_key for
every peer, and its output now goes to a temporary log file. A new
ovpn_wait_tcp_keys() polls the subshell with a 30s bound, dumps the log
on failure, and is called from test.sh and test-close-socket.sh once all
peers are registered.

> The sleep 5 that follows does not cover it: it elapses while "listen" is
> still waiting for connections, and the peers only connect in the
> subsequent ovpn_add_peer() iterations, so the key loop starts well after
> that sleep has expired. Until now the test happened to work because of
> the unrelated delays that ran in between.

[ ... ]

> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>

[Severity: Low]
This fixes a race in the test, but there is no Fixes: tag. Should one be
added?

The background listen/new_key subshell followed by sleep 5 in
ovpn_add_peer() comes from:

959bc330a439 ("testing/selftests: add test tool and scripts for ovpn module")

Commit 7c29665a3a3c later rewrote the listen and new_key lines but kept
the same structure.

Documentation/process/maintainer-netdev.rst says "for fixes the Fixes:
tag is required, regardless of the tree". The exception there for tests
only covers tests that come with a code fix.

Also, the previous patch in this series ("selftests: ovpn: enable
TCP_NODELAY on TCP sockets") removed the two tcpdump captures and the
sleep 0.3 before the first TCP ping. That may be one of the "unrelated
delays" mentioned above.

> diff --git a/tools/testing/selftests/net/ovpn/common.sh b/tools/testing/selftests/net/ovpn/common.sh
> index 2f7851b823436..da732c64ffea6 100644
> --- a/tools/testing/selftests/net/ovpn/common.sh
> +++ b/tools/testing/selftests/net/ovpn/common.sh
> @@ -256,14 +256,19 @@ ovpn_add_peer() {
>  		fi
>  	else
>  		if [ ${1} -eq 0 ]; then
> +			OVPN_TCP_KEYS_LOG=$(mktemp)
>  			(ip netns exec "${server_ns}" ${OVPN_CLI} listen tun0 \
>  				1 ${M_ID} ${OVPN_TCP_PEERS_FILE} && {
> +				rc=0
>  				for p in $(seq 1 ${OVPN_NUM_PEERS}); do
>  					ip netns exec "${server_ns}" \
>  						${OVPN_CLI} new_key tun0 ${p} \
> -						1 0 ${OVPN_ALG} 0 data64.key
> +						1 0 ${OVPN_ALG} 0 data64.key \
> +						|| rc=1
>  				done
> -			}) &
> +				exit ${rc}
> +			}) >"${OVPN_TCP_KEYS_LOG}" 2>&1 &
> +			OVPN_TCP_KEYS_PID=$!
>  			sleep 5
>  		else
>  			peer_ns="ovpn_peer${1}"

[ ... ]

> +ovpn_wait_tcp_keys() {
> +	local deadline rc
> +
> +	[ -n "${OVPN_TCP_KEYS_PID:-}" ] || return 0
> +
> +	deadline=$((SECONDS + OVPN_TCP_KEYS_TIMEOUT))
> +	while kill -0 "${OVPN_TCP_KEYS_PID}" 2>/dev/null; do
> +		if [ "${SECONDS}" -ge "${deadline}" ]; then
> +			printf '%s\n' \
> +				"server-side key setup still running after ${OVPN_TCP_KEYS_TIMEOUT}s"
> +			kill "${OVPN_TCP_KEYS_PID}" 2>/dev/null

[Severity: Low]
Can kill -0 and kill here end up hitting an unrelated process?

Both use the raw number saved by OVPN_TCP_KEYS_PID=$! in ovpn_add_peer().
Bash reaps background children itself, both from its SIGCHLD handling
and while it waits for the foreground sleep 0.2. It keeps the exit status
so the later wait still works.

Once the child is reaped, its PID is free in the kernel and can be given
to another task. If that happens before the next kill -0:

  - the loop treats the unrelated process as the key setup job and spins
    until the 30s deadline
  - kill then sends SIGTERM to that process
  - setup is reported as failed even though the keys were installed

alloc_pid() hands out PIDs cyclically, so this needs a PID wraparound
within one poll interval. That makes it very unlikely in practice, but
the check is not tied to the job's lifetime.

Could the liveness check and the kill be tied to the background job
itself rather than to the numeric PID?

> +			wait "${OVPN_TCP_KEYS_PID}" 2>/dev/null
> +			ovpn_dump_tcp_keys_log
> +			return 1

[Severity: Low]
Does this timeout path leak the OVPN_TCP_KEYS_LOG file that mktemp
creates in ovpn_add_peer()?

The only removal is the rm -f "${OVPN_TCP_KEYS_LOG}" further down. It
only runs when the subshell exits on its own, and this return 1 skips it.

The file is also left behind if a later ovpn_add_peer() call fails before
ovpn_wait_tcp_keys() is reached, for example when connect fails. Under
set -eE that path goes through the EXIT trap to ovpn_cleanup(), which
never touches OVPN_TCP_KEYS_LOG:

ovpn_cleanup() {
	local peer

	# some ovpn-cli processes sleep in background so they need manual poking
	killall "$(basename "${OVPN_CLI}")" 2>/dev/null || true

	for peer in "${!OVPN_LISTENER_PIDS[@]}"; do
		ovpn_stop_listener "${peer}" 2>/dev/null
	done
	...
}

The existing OVPN_TMP_JSONS temp files are already removed from
ovpn_cleanup() through ovpn_stop_listener(). Should OVPN_TCP_KEYS_LOG be
removed from ovpn_cleanup() too?

> +		fi
> +		sleep 0.2
> +	done

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261012133809.2477063-1-antonio%40openvpn.net
