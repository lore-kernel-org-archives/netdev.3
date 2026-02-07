Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDE226FA60
	for <netdev@vger.kernel.org>; Sat,  7 Feb 2026 05:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770441139; cv=none; b=V7oDFf93sbIbbU8Rtc7GoI0yuCVkN1nZmbHoQOUAOBVuIjDQ8ufBROnoAflw4fEcE/xQdIwcAWb+j+tB9B0QlQW7OsCYQDGJIiIHdSJAlkmz73R5ZMkqhj5JM3evf+UmuHUhd9tqSVVfuNrfWcLPK2vfuTnZ7FQJhzxc/8kQdho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770441139; c=relaxed/simple;
	bh=SFCyVkqntMQTX1MIAGNKTM9Upbb+KSUjc3vc8aVy4HI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j+cix/X5DrjzYDpGS9XccJzEvyQj4hHbB1kFaDnmIW1vffFwPfO0WxTM+UFzQ+Rrk0QoNTK9YYg1P2fqKHgk//o2F+y0FvteXHnbeiTdVlnGO76UpEf8/nj2aAtoeFSO3lKn+nsMU0UnqldIaaDFMCyg/zW53tAGM5tYrSef144=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uh3hJ7jJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uh3hJ7jJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B3F3C116D0;
	Sat,  7 Feb 2026 05:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770441139;
	bh=SFCyVkqntMQTX1MIAGNKTM9Upbb+KSUjc3vc8aVy4HI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Uh3hJ7jJJUgWkPW8P1HkaTZqYRekZNplvAB41c7CC0XNurAIcStY+MWSSKQ3I1tqg
	 QN2is4TkdyGEf+zb8EUMTO49LtJSxYbdeZTwzby+pJSZrmya61MEziIs4TAeRESGyi
	 fDwZgqTHJMo8U+Xj9qWnkfakHLzvJ6j7M0edRYcKa8922E1UZcm1tzQk2dJbc69ulT
	 y2S0BKXhReJ85A69WQgwIjyYiXrWsQSg3L9J5LwL+Pt0k5Io0zQpzrWU+adneq8RcL
	 OjKn8DU+iSRMBkYmiCXD0XxZ3qDd6g3Av2hPX6wyTo0i4pPQa1mzaEKrFSJDZeIo7Y
	 zi/OYhFBEIIEw==
Date: Fri, 6 Feb 2026 21:12:18 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com
Subject: Re: [PATCH net v2 4/4] selftests: drv-net: rss_ctx: test RSS
 contexts persist after ifdown/up
Message-ID: <20260206211218.323d172f@kernel.org>
In-Reply-To: <20260206052930.1882740-5-michael.chan@broadcom.com>
References: <20260206052930.1882740-1-michael.chan@broadcom.com>
	<20260206052930.1882740-5-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  5 Feb 2026 21:29:30 -0800 Michael Chan wrote:
> diff --git a/tools/testing/selftests/drivers/net/hw/rss_ctx.py b/tools/testing/selftests/drivers/net/hw/rss_ctx.py

Please use:

 ruff check $file
 pylint --disable=R $file

and fix the new warnings.

This file predates my discovery of these tools so there are some
warnings already, but let's not add more.

> +@ksft_disruptive
> +def test_rss_context_persist_ifupdown(cfg, pre_down=False):
> +    """
> +    Test that RSS contexts and their associated ntuple filters persist across
> +    an interface down/up cycle.
> +
> +    """
> +
> +    require_ntuple(cfg)
> +
> +    qcnt = len(_get_rx_cnts(cfg))
> +    if qcnt < 6:
> +        try:
> +            ethtool(f"-L {cfg.ifname} combined 6")
> +            defer(ethtool, f"-L {cfg.ifname} combined {qcnt}")
> +        except:
> +            raise KsftSkipEx("Not enough queues for the test")
> +
> +    ethtool(f"-X {cfg.ifname} equal 2")
> +    defer(ethtool, f"-X {cfg.ifname} default")
> +
> +    if pre_down:
> +        ip(f"link set dev {cfg.ifname} down")
> +
> +    try:
> +        ctx1_id = ethtool_create(cfg, "-X", "context new start 2 equal 2")
> +        defer(ethtool, f"-X {cfg.ifname} context {ctx1_id} delete")
> +    except CmdExitFailure:
> +        if pre_down:
> +            ip(f"link set dev {cfg.ifname} up")

You should use defer for the ifup. You can save it and run it with
.exec():

	ifup = defer(ip, f"link set dev {cfg.ifname} up")
	if pre_down:
		ip(f"link set dev {cfg.ifname} down")

	try:
		ctx1_id = ethtool_create(cfg, "-X", "context new start 2 equal 2")
		defer(ethtool, f"-X {cfg.ifname} context {ctx1_id} delete")
	except CmdExitFailure:
		raise KsftSkipEx("Create context not supported with interface down")

	....

	if not pre_down:
		ip(f"link set dev {cfg.ifname} down")
	ifup.exec()

this ifup.exec() also removes ifup from the "defer queue".

> +            raise KsftSkipEx("Create context not supported with interface down")
> +        raise
> +
> +    ctx2_id = ethtool_create(cfg, "-X", "context new start 4 equal 2")
> +    defer(ethtool, f"-X {cfg.ifname} context {ctx2_id} delete")
> +
> +    port_ctx2 = rand_port()
> +    flow = f"flow-type tcp{cfg.addr_ipver} dst-ip {cfg.addr} dst-port {port_ctx2} context {ctx2_id}"
> +    ntuple_id = ethtool_create(cfg, "-N", flow)
> +    defer(ethtool, f"-N {cfg.ifname} delete {ntuple_id}")
> +
> +    if not pre_down:
> +        ip(f"link set dev {cfg.ifname} down")
> +
> +    ip(f"link set dev {cfg.ifname} up")

You can add here:

	wait_file(f"/sys/class/net/{cfg.ifname}/carrier",
		  lambda x: x.strip() == "1")   

to wait for carrier before running the ping loop.


