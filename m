Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930334AA1D7;
	Mon,  5 Oct 2026 14:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791210606; cv=none; b=jJfqK8O5s2dmLj5aXF1Um2U/HI1EUChVr2hpULBbYfBKDGdB3lXoCT2k/+AzCxYFsbBDF+4UMtYAUs18wRhJExJxfDiQn9TSy6/rnJ+pBp4UJMKXx39jVWJnMpDArtout3SyMgS5kIhHn4O6hM27kgdom1comI4KOmBd4Rs9q8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791210606; c=relaxed/simple;
	bh=qQYqIMKz42cxDGI4pa0a62sKzRbZ+eK+/Z78Mlr2BmU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Zlu3rQ9cP7evtizhaZMJBybq8itCD835h/n++1BXGb4pmQKHtaAfO3oPecTFo2oubbYuSltHrZWKWL6GzB3u0mLb+uSaBnHlMotubbtS0Rft7r+imXZmDxgQrB7/5ahyXl9oLFhn2C6nsrtCXbQ9QBO3v8kUUBBjobuk4eizNWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RgLf90bd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RgLf90bd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF7461F00893;
	Mon,  5 Oct 2026 14:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791210594;
	bh=ruyeKuz6DedPpkIcesJmpP9H55Ihr0QFSivp3ZU/g1k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RgLf90bdcHausTN5PPUM3X+yUceCwShIKNw6bJS84ZKTODurULCZCm5BZtsdbmiJg
	 CbR0HTYDh+d3XvQ8tkyQ1pdr5PBT5S6HV7gkMSWt1ZbXIhBmVu3/zRLrQpIh1gNLrQ
	 2c72I4u6esbQxOzN0IvbjH2Pb2pwsl4iyHd60A0GUB/j5r4zbZQYufSi7o1vIiYUip
	 D6LWo/4eFgg8LSZtoNreJD8hLwZPRMZu6GrNXAvN1cHNOsdtTmnoYb/TZK+RmLVi0w
	 pPc0DgoHQAXD+WbbyPOkAIWR0N2iT8tazFv3OutIC0oR0XNg0Y7NqoQ0N6cu74VI59
	 p9gqAf2JHfnuA==
Subject: Re: [PATCH net-next v3 3/3] net: stmmac: Don't set or get RSS
 parameters when not supported
From: netdev-bot+sashiko@kernel.org
To: maxime.chevallier@bootlin.com
Cc: andrew+netdev@lunn.ch, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 linux@armlinux.org.uk, lorenzo.bianconi@oss.qualcomm.com, nb@tipi-net.de,
 jitendra.vegiraju@broadcom.com, thomas.petazzoni@bootlin.com,
 alexis.lothore@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, pbrobinson@gmail.com, joe@dama.to
Date: Mon, 05 Oct 2026 14:29:52 +0000
Message-ID: <179121059252.434549.3845635961153166403@kernel.org>
In-Reply-To: <20261002142806.1299041-4-maxime.chevallier@bootlin.com>
References: <20261002142806.1299041-4-maxime.chevallier@bootlin.com>
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

- [Low] The commit fixes a user-visible bug that goes back to 2019 but
  has no Fixes: trailer.

--

net: stmmac: Don't set or get RSS parameters when not supported

This commit makes stmmac_get_rxfh_key_size() and
stmmac_get_rxfh_indir_size() return 0 when stmmac_rss_is_supported() is
false. The ethtool core then reports -EOPNOTSUPP instead of returning a
bogus key and indirection table for ethtool -x, or failing with -EINVAL
for ethtool -X.

> The RSS kselftests fail on stmmac, and this is partly due to the driver
> reporting bogus data for the RSS ops :
>
>  - ethtool -x reports an indirection table and a key while the hardware
>    doesn't have any of that
>  - ethtool -X fails with -EINVAL.
>
> Return a 0 indir size and key size when rss isn't supported, effectively
> meaning we don't support RSS here.
>
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

[Severity: Low]
The commit message describes a user-visible bug fix, but there is no
Fixes: tag. Should one be added?

Both callbacks were added by commit 76067459c686 ("net: stmmac: Implement
RSS and enable it in XGMAC core"). Since then they have returned
sizeof(priv->rss.key) and ARRAY_SIZE(priv->rss.table) whether or not RSS
is supported.

Because those sizes were non-zero, ethtool_get_rxfh() and
ethtool_set_rxfh() in net/ethtool/ioctl.c, and rss_prepare_data() in
net/ethtool/rss.c, never reached their -EOPNOTSUPP path:

    if (!rxfh_dev.indir_size && !rxfh_dev.key_size)
        return -EOPNOTSUPP;

Instead, ethtool -x reached stmmac_get_rxfh() and returned the defaults
set at probe time. ethtool -X went through
stmmac_set_rxfh()->stmmac_rss_configure(), and stmmac_do_callback()
returns -EINVAL there when the core has no rss_configure callback.

The previous patch, "net: stmmac: Introduce a helper to check RSS
support", notes that no platform sets rss_en yet. That means this affects
every stmmac user today.

Would something like this help stable maintainers?

    Fixes: 76067459c686 ("net: stmmac: Implement RSS and enable it in XGMAC core")

Any backport would also need the helper patch from the previous commit,
which also has no Fixes: tag.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261002142806.1299041-1-maxime.chevallier%40bootlin.com
