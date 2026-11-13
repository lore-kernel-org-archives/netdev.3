Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794549827;
	b=HubQ+uXUa8If7h6qRygBQAxcccTOycVIxZiuGBKP3LG6RrupGCTIHlA0SLtJnL9hYJyD
	 oyZksptPvWibpYXJNcMYGeHsYw7zSHyRlfi5FRaR6vHEWtkrpYdQI5B7EPHrfrCt6nXMx
	 u5Z5p47EWifRzrN33qddSj32RG45bYWP4wKmrBPuygY4VzLVgEG0c/58FQT49KV2DMn+d
	 EcGlYJJvBcirOitP8/u00f9cNracwcgPKS4doPZwVrq+W2J387Vq+ZNGHdAjagT6judGh
	 b2ViHJs78BUHY7LU5YLxKSClSCMgIrkin++0yNhOU6nVFu1d4duEINHj2meFTFMlQ2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794549827;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Zm0SXoTsslJ98OYXXtI9gqGgG6mU0h0OU9o2vwPu4zc=;
	b=vLUUjFZfo9Svyl/DeplUgRgFVBmVLknjChoDsOWiF62b/eIvous6SyYY6kxVPFDTeSyv
	 M8KvXfHj0Ve6u/WWLrxCI7pCb8fE8tbbtUyVXire0kdXAhKQxlxwaGqJkph6Izpg7B+oo
	 wM1CG87i4g6s+uFTz4wCFX2I7sVAd4EILAkFkDjSBR/WKT5/q16VghQXSrYePi7lV7c4b
	 VZqyctRKK9QMnUySrJsQNp/f9K4tv0qAnmvF5rmS2TxvzMLdZ5gCsU+oAGRz943LrCzr/
	 Erc2ltbpCI/3i5kVhy5l2Xu3/ngC69NaXalqyTbxrA/4Ged9jpeR9zWjcmuhxCu7XDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EX1a+XGG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0906606A32D
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 06:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EX1a+XGG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CC481F000C5;
	Fri, 13 Nov 2026 06:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794549827;
	bh=Zm0SXoTsslJ98OYXXtI9gqGgG6mU0h0OU9o2vwPu4zc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=EX1a+XGGwBx+6r9TJTxfkeOgnEbqr12c+0aaZhbL23F9L+oaGCMjne3M6IKrvASM2
	 +1VzL0UbolXAxiCpQ4WA1GXDiXMYdNbNaoM/PP8scZJEsZkv5osDEPpFHOTrOfcVa5
	 ljLRvlJnaiOyYTpjuVjZr1RTnSrdku0Bc2DtB3qdT1jPxCWrvIF3H59gYVHD/BOssz
	 14f/PCufumUPg+8BUw87ar/5h/ujz4dZqhsofqsHcD5vGU/YYY96DrtFqabDfzK1+w
	 lY8o8ABX31zmxxcztNeiwJxk9XIqJYY/vuwtQrKZWuAm7l6Bqi5dSQD8bvIQLkcL+3
	 KQX6clHqhs1XQ==
Subject:
 Re: [PATCH net-next v4 2/4] selftests: drv-net: add an iperf performance test
From: netdev-bot+sashiko@kernel.org
To: sdf.kernel@gmail.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, bjorn@kernel.org
Date: Fri, 13 Nov 2026 06:03:46 +0000
Message-ID: <179454982676.2199510.893997649108643676@kernel.org>
In-Reply-To: <20261111000246.962871-3-sdf@fomichev.me>
References: <20261111000246.962871-3-sdf@fomichev.me>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] In commit "selftests: drv-net: add an iperf performance test",
  the author and sign-off addresses differ.
- [Low] The patch adds a new HW-only test directory,
  tools/testing/selftests/drivers/net/perf.

--

selftests: drv-net: add an iperf performance test

This commit adds a new drivers/net/perf selftest target with its own
lib/py, similar to drivers/net/hw. It adds Iperf3Runner.measure(), which
returns an Iperf3Result, and a new iperf.py test that reports TCP
throughput as a ktap metric.

> Reviewed-by: Björn Töpel <bjorn@kernel.org>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>

[Severity: Low]
This isn't a bug, but the author and sign-off addresses don't match:

  Author: Stanislav Fomichev <sdf.kernel@gmail.com>
  Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>

There is no From: line or second Signed-off-by linking the two, and
checkpatch flags this as a From:/Signed-off-by: email address mismatch.
The other patches in the series have the same mismatch.

Could the author address be changed to match, or a Signed-off-by from
the author address be added?

> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index 07c3719f8b04b..c55d7792b27c4 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -159,7 +159,7 @@ TARGETS_HOTPLUG = cpu-hotplug
>  TARGETS_HOTPLUG += memory-hotplug
>  
>  # Networking tests want the net/lib target, include it automatically
> -ifneq ($(filter net drivers/net drivers/net/hw,$(TARGETS)),)
> +ifneq ($(filter net drivers/net drivers/net/hw drivers/net/perf,$(TARGETS)),)
>  ifeq ($(filter net/lib,$(TARGETS)),)
>  	INSTALL_DEP_TARGETS := net/lib
>  endif

[ ... ]

> diff --git a/tools/testing/selftests/drivers/net/perf/iperf.py b/tools/testing/selftests/drivers/net/perf/iperf.py
> new file mode 100755
> index 0000000000000..5b6f0bce2a03d
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/perf/iperf.py

[ ... ]

> +def main():
> +    """Run the iperf performance test."""
> +    with NetDrvEpEnv(__file__, nsim_test=False) as cfg:

[Severity: Low]
Should tools/testing/selftests/drivers/net/README.rst be updated to cover
the new drivers/net/perf directory?

With nsim_test=False this is a HW-only test. The "Both modes required"
section of the README still says:

  All tests in drivers/net must support running both against a software device
  and a real device. SW-only tests should instead be placed in net/ or
  drivers/net/netdevsim, HW-only tests in drivers/net/hw.

The build/install example also only lists the existing targets:

  # make -C tools/testing/selftests/ TARGETS="drivers/net drivers/net/hw"

No patch in the series mentions drivers/net/perf in the README. Users who
follow the example won't build or install the new perf tests, and the
placement rule for HW-only tests no longer matches the tree.

> +        ksft_run([tcp], args=(cfg,))
> +    ksft_exit()

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261111000246.962871-1-sdf%40fomichev.me
