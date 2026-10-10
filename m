Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8DD4BFE63;
	Sat, 10 Oct 2026 19:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791661235; cv=none; b=kM8nR/YE0ZWYLQuyA12QlXDFxT8ph6M9USpntDabIEa/qdgrxV+IPlyJCpNBdgtRAjLfGvbyPMad3rojK99npkyqvW1rsIw8LLgFkKCa7HhClvLY8aZCKMhRtOT6Q3TomUOuuAN8caLVd87Lo+FvV97ajbiyyeOX4b75QqFgKYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791661235; c=relaxed/simple;
	bh=+w3WLIVqoiLeDXovxJvLrvGEnjhUhU3ITsjJwTesybs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M/vun4a9XGGVp5mS0hvxzfNxJLPWS5eY0fSaFN1vde5QCZiZy15KzuEy599yAB74riEPjRHIsXtMsbsXWBXJAjEoxIhiOZaYCfgeXfFmy3dlI0hZSL3BqW1HiDI1i7lCLP7NQNYQ2AdWbMqaaVF1X1qnGJyXtRaR+Jkz/Xd8VQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKS9LJvR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKS9LJvR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 474361F00898;
	Sat, 10 Oct 2026 19:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791661226;
	bh=+rot+4o23CEfAlRjdbxvoZ3rlIU9tvfol4bVsyDW5PQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YKS9LJvRS2IYRdymi8+XA95SORhq/IA6tADcIqjB2LqTKFAyXH0IEKe2vomEq5jez
	 FgLqH5s3/Ahn3qhk4EJXruNbG4IfxqitDoO+Yc+Pt/JEGoV4cTjO66JT0jqYFboGRt
	 gJi/fzMq+HinSvPYH+FsWgOqcuUyjKs/LepRK5XIkIwyQy88NCDsBlefGDPy0wMR6K
	 cn/if0dr34leBClE+rA7IjHk5c3q+iWlsPKwXHiDPLKgvN7UcZq78oVsLaRBl3zKSc
	 1GqQXPlu2PrmmCK0cZQ33lUAIjXLQP2F90M8beZzU3iIckHIbTkQw/+Ql5uRb+iLIb
	 3KckrCYuLeJuQ==
Subject: Re: [PATCH net-next v9 09/11] onsemi: s2500: Added selftest support
 to onsemi's S2500 driver
From: netdev-bot+sashiko@kernel.org
To: Selvamani.Rajagopal@onsemi.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 parthiban.veerasooran@microchip.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, richardcochran@gmail.com,
 andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 edumazet@kernel.org, piergiorgio.beruto@gmail.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, jerry.ray@microchip.com, ciprian.regus@analog.com
Date: Sat, 10 Oct 2026 19:40:24 +0000
Message-ID: <179166122477.434549.499211157337170569@kernel.org>
In-Reply-To: <20261009-s2500-mac-phy-support-v9-9-dcefe1d0bf0d@onsemi.com>
References: <20261009-s2500-mac-phy-support-v9-9-dcefe1d0bf0d@onsemi.com>
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

- [Medium] When CONFIG_NET_SELFTESTS=n, s2500_get_sset_count() returns 0
  for ETH_SS_TEST, because the include/net/selftests.h stub…

--

onsemi: s2500: Added selftest support to onsemi's S2500 driver

This patch adds ethtool selftest support to the onsemi S2500 MAC-PHY
driver. For ETH_SS_TEST it reports the generic net_selftest count and
strings. It also sets net_selftest() as the self_test callback in
s2500_ethtool_ops.

> diff --git a/drivers/net/ethernet/onsemi/s2500/s2500_ethtool.c b/drivers/net/ethernet/onsemi/s2500/s2500_ethtool.c
> index 062cab9460dcf..12e59e8d44a62 100644
> --- a/drivers/net/ethernet/onsemi/s2500/s2500_ethtool.c
> +++ b/drivers/net/ethernet/onsemi/s2500/s2500_ethtool.c

[ ... ]

> @@ -201,6 +202,8 @@ static int s2500_get_sset_count(struct net_device *ndev, int sset)
>  	switch (sset) {
>  	case ETH_SS_STATS:
>  		return S2500_MAC_STATS_LEN;
> +	case ETH_SS_TEST:
> +		return net_selftest_get_count();

[Severity: Medium]
What happens here when CONFIG_NET_SELFTESTS is not enabled?

In that case include/net/selftests.h provides stubs:

static inline int net_selftest_get_count(void)
{
	return 0;
}

So s2500_get_sset_count() returns 0 for ETH_SS_TEST. At the same time,
s2500_ethtool_ops still sets ".self_test = net_selftest", which is the
empty stub.

The ethtool core expects a non-zero count whenever self_test is set. In
net/ethtool/ioctl.c:

ethtool_self_test() {
    ...
	test_len = ops->get_sset_count(dev, ETH_SS_TEST);
	if (test_len < 0)
		return test_len;
	WARN_ON(test_len == 0);
    ...
}

After the warning, the no-op stub runs and "ethtool -t" reports success
without running any tests.

ETHTOOL_GSTRINGS does not require CAP_NET_ADMIN. With
string_set == ETH_SS_TEST, that path also hits a warning:

ethtool_get_strings() {
    ...
	ret = __ethtool_get_sset_count(dev, gstrings.string_set);
	if (ret < 0)
		return ret;
	...
	WARN_ON_ONCE(!ret);
    ...
}

Can this configuration actually be built? NET_SELFTESTS depends on
PHYLIB && INET. S2500_MACPHY only uses imply for it and has no INET
dependency:

config S2500_MACPHY
	tristate "S2500 support"
	depends on SPI
	depends on PTP_1588_CLOCK_OPTIONAL
	imply NET_SELFTESTS

With CONFIG_INET=n, the driver can be built while NET_SELFTESTS=n.

A few existing drivers (fec, ag71xx, asix, lan78xx, smsc95xx) follow
the same pattern.

Would any of these fixes work here?

  - return -EOPNOTSUPP for ETH_SS_TEST when net_selftest_get_count()
    is 0
  - set .self_test only under IS_ENABLED(CONFIG_NET_SELFTESTS)
  - add a dependency on NET_SELFTESTS, and therefore on INET

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009-s2500-mac-phy-support-v9-0-dcefe1d0bf0d%40onsemi.com
