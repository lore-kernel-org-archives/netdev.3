Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003AE49B5B5
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 13:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791466324; cv=none; b=cvcWuh//8kxWMJPq6qr37nucON5uU9E7A8BIdELS1OOfBrngbJh966XNcCzYX/+TFTjcvTHHY+DSOeivmttYt3rYnnq9xpLwC+DEGYTsC1VGnhPtjHn1sNW3uFQFOMQAk6qV75kAhbYpJZveFsfaLNE7KC2qK/z2XbMxpmRuAvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791466324; c=relaxed/simple;
	bh=5BdrxS2NUFskphH3SEPgBTZUqGTY1jv2z8ZNt2gK00s=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cpHxZRfyb13dMVW1Spl2mpGz45M4mQjZoKIOnyfOZmKmtj8SRB3DdI9FOR3zdqzpBEfsfy/oeCDMKmWZ4Mi9Y7nCYNzKb9tyd22u+TiiAVtt4mnOg06+UOrMmLnWhmnzhqxtZWuAmZemucS6or1znIIBqCB4ND5M0xi1G406+NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ikXhzKfv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ikXhzKfv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09AB41F00893;
	Thu,  8 Oct 2026 13:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791466322;
	bh=+IpHwHkHX9m4DL9ItwWczMMtQuSR2uOWxvTdUifQfAs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ikXhzKfvmuu3LKPCfoZmL8CHsIhxjt/Rxp4505ScaXsRKENzxh4/VZGDz1/k5mW1F
	 rcHAKxttoNEAFIFCIpUS56aKztHmHF+waGOz1TqVSyaQCvJrkBYuwdCoRDdBuTbCTT
	 IYsv5y8uLPnwt4y9OrQ6V+bN1HU/xYQto6O4sitHbyhVgGKAfE341ioq5ucEtMqO5W
	 82gSemugBGdfX6N4c17kco6GGHIJzdZTonK6hil/7cTttXjMeTXW4yi6myWfB/RwYP
	 XhFOXCNGiVDj+YMqFYKgzWB4VT7ZpLHuA7JfvmCTcrWR2Bxlti3cb+qGJP059QGvpY
	 IJ2UHdo+lhLRA==
Subject: Re: [PATCH net-next 5/7] selftests: ovpn: wait for the TCP server key
 setup before traffic
From: netdev-bot+sashiko@kernel.org
To: antonio@openvpn.net
Cc: netdev@vger.kernel.org, ralf@mandelbit.com, sd@queasysnail.net,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com
Date: Thu, 08 Oct 2026 13:32:01 +0000
Message-ID: <179146632153.434549.6066824763324113429@kernel.org>
In-Reply-To: <20261007133018.1451958-6-antonio@openvpn.net>
References: <20261007133018.1451958-6-antonio@openvpn.net>
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

- [Low] The new failure path for server-side key setup gives no hint of
  its cause.
- [Low] Claim: the patch fixes a race in the ovpn TCP selftest, in the
  backgrounded `listen && { new_key loop }` subshell plus `sleep 5` in…
- [Low] Claim: in ovpn_wait_tcp_keys() (common.sh lines 301-319),
  OVPN_TCP_KEYS_PID is a bare number that is never initialised or…

--

selftests: ovpn: wait for the TCP server key setup before traffic

In TCP mode, ovpn_add_peer() spawns a background subshell that accepts the
peers and installs their data keys. This commit records that subshell's PID.
A new helper, ovpn_wait_tcp_keys(), polls the PID with a bounded timeout. It
is called from test.sh and test-close-socket.sh once all peers are
registered.

> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>

[Severity: Low]
This might not matter, but should this patch have a Fixes: tag?

The backgrounded "listen && { new_key loop }" construct comes from commit
959bc330a439 ("testing/selftests: add test tool and scripts for ovpn
module"). It was later reworked in 7c29665a3a3c.

However, the commit message says the race was latent:

> Until now the test happened to work because of
> the unrelated delays that ran in between.

The delay that hid it seems to be the tcpdump setup plus the sleep 0.3 in
ovpn_run_basic_traffic(). The previous patch in this series ("selftests:
ovpn: enable TCP_NODELAY on TCP sockets") moved that delay under the
UDP-only branch.

If the race only shows up within this series, leaving out the tag is
probably fine.

> diff --git a/tools/testing/selftests/net/ovpn/common.sh b/tools/testing/selftests/net/ovpn/common.sh
> index 2f7851b823436..e33b1fe265221 100644
> --- a/tools/testing/selftests/net/ovpn/common.sh
> +++ b/tools/testing/selftests/net/ovpn/common.sh
> @@ -258,12 +258,16 @@ ovpn_add_peer() {
>  		if [ ${1} -eq 0 ]; then
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
> +				exit ${rc}
>  			}) &
> +			OVPN_TCP_KEYS_PID=$!

[Severity: Low]
If this subshell fails, where does the output of listen and new_key go?

ovpn_add_peer 0 runs under ovpn_cmd_ok "register peer0 in overlay". At
that point ovpn_cmd_run() has already sent stdout/stderr to a temporary
file:

ovpn_cmd_run() {
    ...
	output_file=$(mktemp)
	if "$@" >"${output_file}" 2>&1; then
    ...
	rm -f "${output_file}"
	return "${ret}"
}

The backgrounded subshell inherits those descriptors. The file is deleted as
soon as ovpn_add_peer 0 returns, so anything ovpn-cli writes after that goes
to an unlinked inode.

With this patch, a listen or new_key failure is now a hard error reported
through ovpn_wait_tcp_keys(). The log would only show:

  wait for server-side key setup: command failed with rc=1: ovpn_wait_tcp_keys

It would contain no ovpn-cli error text and no failing peer id. Setting
OVPN_VERBOSE=1 doesn't help either, because the verbose dump in
ovpn_cmd_run() runs before the subshell has written anything.

Could the subshell output go to a dedicated log file, printed when
ovpn_wait_tcp_keys() fails?

>  			sleep 5
>  		else
>  			peer_ns="ovpn_peer${1}"

[ ... ]

> @@ -281,6 +285,39 @@ ovpn_add_peer() {

[ ... ]

> +OVPN_TCP_KEYS_TIMEOUT=${OVPN_TCP_KEYS_TIMEOUT:-30}
> +
> +ovpn_wait_tcp_keys() {
> +	local deadline
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
This is likely minor. OVPN_TCP_KEYS_PID is never initialized at file scope
and never cleared after the wait. It is only set in ovpn_add_peer(), for
peer 0 in TCP mode.

Could a value inherited from the environment make a UDP run poll an
unrelated process here and then send it SIGTERM on timeout? It could also
make the final wait fail with 127.

There is a related question about PID reuse. Once bash reaps the subshell
during the sleep 0.2, kill -0 and kill are working on a bare number.

In practice:

- each test runs as its own process
- the variable isn't exported
- ovpn_wait_tcp_keys() is called once per process
- cyclic PID allocation makes reuse within 0.2s unlikely at normal pid_max
  values

So if anything is needed, initializing OVPN_TCP_KEYS_PID= at the top of
common.sh and clearing it after the wait might be enough.

> +			wait "${OVPN_TCP_KEYS_PID}" 2>/dev/null
> +			return 1
> +		fi
> +		sleep 0.2
> +	done
> +
> +	wait "${OVPN_TCP_KEYS_PID}"
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261007133018.1451958-2-antonio%40openvpn.net
