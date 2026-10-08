Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955F643499E
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 13:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791466323; cv=none; b=Zen6LzS9JMTDXpGnKM+lnzmqjsZgr4dXHXD1ymF/vbTNa/SS9EJbDrW6x1SKMkFnr3PU72eBUMDu5vTNal3nEkdwUDANXzrMKu1mBYQbIJPrlZpztECIoPeA5lDjwdWCgxKaFuW+HY/HUJzceGRrq2xS+0s/xfaLN4OGxHy4R8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791466323; c=relaxed/simple;
	bh=GCc6hdXuoEpXFUh1ETpECGfr3WoWLdt7TinGxOYbLJw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=arL/9W2CTyVpPUT9/8MDH+CUqmDy/6aMWCbzvI5o/nKOfJyi20c/wg9ISElQMzvA8FJwfPE/cJE8OjEa1h+HemdllR/5dw3DSfW8GLlMyNr6vbIyf6Qb66ZqnV34IeSIbBYSDVlhIcp6Lbbhz0xmjUbPRNy2Fcd70FqMr9SlMeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iWggV4PD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iWggV4PD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E22A61F000FF;
	Thu,  8 Oct 2026 13:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791466321;
	bh=DHqQSxpu25SFfdNmAKtIxYNB4MjQhli30SVHwjK6v4E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=iWggV4PD1yPsr5Chleh6G9XxUaWizk0/iqoEX8muAIoybF0sgSTsRFI3LQvf9xsl7
	 1sRH587aJa/n/wKIV12yGNauLzYlOpv72J7PWKCevXw/JtumtgPNbTh05MuYAJizBA
	 5hMnPQaasrTHbqTKU6lUHmj1TjO+6OJelu+/9EmN4kHELte1JcN3K0UJDnvZirp9pW
	 wuoOoXSuerCS+NqwxO8aqqGopaRDrGHYE0JD24VtzTQs/f6fY88a9hUhlf/YdzazJb
	 GlpBsU2/3z78zuHR+wSUouEcjZPWoRAAbiNpY/qM/AehrYC43zSdzzK9pz06RCPMSp
	 mMj716D1aKCwg==
Subject:
 Re: [PATCH net-next 4/7] selftests: ovpn: enable TCP_NODELAY on TCP sockets
From: netdev-bot+sashiko@kernel.org
To: antonio@openvpn.net
Cc: netdev@vger.kernel.org, ralf@mandelbit.com, sd@queasysnail.net,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com
Date: Thu, 08 Oct 2026 13:32:00 +0000
Message-ID: <179146632050.434549.11769906419879477924@kernel.org>
In-Reply-To: <20261007133018.1451958-5-antonio@openvpn.net>
References: <20261007133018.1451958-5-antonio@openvpn.net>
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

- [Low] The patch reduces TCP selftest coverage.

--

selftests: ovpn: enable TCP_NODELAY on TCP sockets

This commit makes ovpn-cli set TCP_NODELAY on both the connecting and the
accepted TCP sockets, which matches the current userspace default. TCP does
not preserve record boundaries, so the tcpdump based DATA_V2 peer ID check
in ovpn_run_basic_traffic() now runs only for UDP. The TCP branch of
ovpn_build_capture_filter() is removed.

> diff --git a/tools/testing/selftests/net/ovpn/test.sh b/tools/testing/selftests/net/ovpn/test.sh
> index 392109d5e14e2..e2e6ffdd29bb0 100755
> --- a/tools/testing/selftests/net/ovpn/test.sh
> +++ b/tools/testing/selftests/net/ovpn/test.sh
> @@ -137,35 +137,33 @@ ovpn_run_basic_traffic() {
>  	local tcpdump_timeout="1.5s"
>  
>  	for p in $(seq 1 ${OVPN_NUM_PEERS}); do

[ ... ]

>  		if [ "${OVPN_PROTO}" == "UDP" ]; then

[ ... ]

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

[Severity: Low]
This isn't a bug, but now that the capture runs only for UDP,
test-tcp.sh and test-symmetric-id-tcp.sh no longer check the DATA_V2 peer
ID on the wire. Is there another way to keep some wire-level peer ID
coverage for the TCP variants?

On receive, ovpn_tcp_rcv() gets the peer from the stream, not from the
on-wire peer ID:

drivers/net/ovpn/tcp.c:ovpn_tcp_rcv() {
	struct ovpn_peer *peer = container_of(strp, struct ovpn_peer, tcp.strp);
    ...
}

So a successful ping over TCP does not by itself show that the correct
tx_id was sent.

tx_id is set in common code and written to the packet in
ovpn_aead_encrypt():

	op = ovpn_opcode_compose(OVPN_DATA_V2, ks->key_id, peer->tx_id);

The UDP variants, including test-symmetric-id.sh, still exercise that
path.

Separately, ovpn_connect() and ovpn_accept() in ovpn-cli.c now set
TCP_NODELAY unconditionally, so every TCP selftest runs with Nagle
disabled. Would it be worth adding an option that leaves Nagle enabled, so
that setup still gets tested?

> -		peer_ns="ovpn_peer${p}"
> -
> -		timeout ${tcpdump_timeout} ip netns exec "${peer_ns}" \
> -			tcpdump --immediate-mode -p -ni veth${p} -c 1 \
> -			"$(ovpn_build_capture_filter "${header1}" "${raddr}")" \
> -			>/dev/null 2>&1 &
> -		tcpdump_pid1=$!
> -		timeout ${tcpdump_timeout} ip netns exec "${peer_ns}" \
> -			tcpdump --immediate-mode -p -ni veth${p} -c 1 \
> -			"$(ovpn_build_capture_filter "${header2}" "${raddr}")" \
> -			>/dev/null 2>&1 &
> -		tcpdump_pid2=$!
> -
> -		sleep 0.3

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261007133018.1451958-2-antonio%40openvpn.net
