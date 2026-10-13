Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBFB40F73A
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 14:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791902391; cv=none; b=nVguPmi/KbJh+hHlar+7M0bTmIkuUHsZwcYTvpivEunHTNQ3bi0nnjQgdrfu3C9DM/qQ4lxSX1pJO+KdcJRjK18m0Ttim6uttLb+MDMPfQoxzOk5VAVvpgdw3ZbvOlROCflg0EqscS7bsocHnhnJ27qjv8/cjoIwqEp7BqrTNjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791902391; c=relaxed/simple;
	bh=x4JXlDlGmqWY5EW+2edkOtzPjV1b+03YQOwDIz+jHdo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ATesPAa4VG0KbgP/uZ0XCnKo+yrBzolOFiwuoex0BBYBoJgulgjZ7En+otWc9/QdfqvPHj68ADNac0A2eS+TbXa/VRC1QZLW1fcsCsOYZyUAIWyPvIr44xOX0jAcUXdz5zBBokLp//npZE7QzdH70UHxJNJVF0t5H0/nijOn/KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bkG4PJbN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bkG4PJbN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 006FB1F000FF;
	Tue, 13 Oct 2026 14:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791902389;
	bh=jdOmbyKW1BXVliYEEyAVtWpOSyYPCb1tNiqls9Wke5M=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bkG4PJbNHB1fX6XQ8GE7WIqmgK3R3d9abb3nMS/pYz2iev3QCpkTQQz11ROGPGIy1
	 eLMgaeb6S4Hufub/HwtpeFLngpsHqrh6oVvfjuZ/Pe/PKBBo6NAktC+VIJFHsnSYRD
	 1vWauesjES7DJ3Mt+95mf3f08uv/ScBnHzuAvsXXmhFs2kUVvAB2gCLEKVIpqTbFFT
	 5N2baHIhxweaRB7nBetbOucB5ZYydEx+IdPkgHydntYa3Ns+6/E6EX1K2+xD+nGGtl
	 uacBqjW/3nAdOgUv2UAR2s/IdwNGxAWsMqgwo9B0usK4AiOj48/Jfjxvuu9FTVFUgF
	 zKoOAiN2ixaBw==
Subject:
 Re: [PATCH net-next 4/6] selftests: ovpn: enable TCP_NODELAY on TCP sockets
From: netdev-bot+sashiko@kernel.org
To: antonio@openvpn.net
Cc: netdev@vger.kernel.org, sd@queasysnail.net, ralf@mandelbit.com,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com
Date: Tue, 13 Oct 2026 14:39:48 +0000
Message-ID: <179190238850.434549.6180086091448145830@kernel.org>
In-Reply-To: <20261012133809.2477063-5-antonio@openvpn.net>
References: <20261012133809.2477063-5-antonio@openvpn.net>
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

- [Medium] After this patch, no TCP selftest checks the TX peer-ID that
  goes out on the wire.

--

selftests: ovpn: enable TCP_NODELAY on TCP sockets

This commit makes ovpn-cli set TCP_NODELAY on its TCP sockets by default.
Setting OVPN_TCP_NODELAY=0 turns it off, and the new test-tcp-nagle.sh
uses that to keep running the TCP suite with Nagle enabled. It also limits
the tcpdump-based peer ID check in ovpn_run_basic_traffic() to UDP.

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

> @@ -173,8 +171,10 @@ ovpn_run_basic_traffic() {
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

[Severity: Medium]
This patch removes the TCP branch of ovpn_build_capture_filter() and makes
these waits UDP-only. After that, does any TCP selftest still check the
peer-id that goes out on the wire?

The capture was added by commit 367f4b163a8c ("selftests: ovpn: check
asymmetric peer-id"). Its purpose was to check the peer-id in the data
packet headers for every connection, TCP included.

On the kernel side, the TCP receive path never reads the peer-id from the
packet. It takes the peer that is bound to the socket:

drivers/net/ovpn/tcp.c:ovpn_tcp_rcv() {
    ...
	ovpn_recv(peer, skb);
    ...
}

So if a TCP peer had the wrong tx_id here, traffic would still flow:

drivers/net/ovpn/crypto_aead.c:ovpn_aead_encrypt() {
    ...
	op = ovpn_opcode_compose(OVPN_DATA_V2, ks->key_id, peer->tx_id);
    ...
}

The JSON expectations in the selftest directory don't compare tx-id
either. With this change, test-tcp.sh, test-symmetric-id-tcp.sh and the new
test-tcp-nagle.sh would all pass with an incorrect TCP tx_id.

The later patch in the series ("selftests: ovpn: wait for the TCP server
key setup before traffic") does not bring the TCP check back.

Could these TCP variants keep some form of peer-id check that does not
depend on TCP segment boundaries?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261012133809.2477063-1-antonio%40openvpn.net
