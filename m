Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793569619;
	b=4COJnXopxQZZw2m3SnUnI/NPyenViXHV1JzFM5rsHn4sSC6iT4IpNNN3RW8kXQho+Lux
	 VhK6UYazPJN/ZBcwqpWD+jix6PPGysebd+0HmKX37L3jh4MjepP0N+IsKY92iF8ZR/yEp
	 8ycMrbBVvlBAME4YzbM+v6hJNW+Kw9NvG693DnjHoNXOEBenaoDcgDpuJpQ1urG6nOLsW
	 Rs7jc7YCSoP/NuE7aC/e36CdLvMN/HOZ4KevEm3vuhtc3oL8xI9dLQths0SS7sLkc2AT0
	 IcAP57Xig+UvfVOY4mZGGlgA2HA1s2Jod8osKtRPghquduup7mVYWg5q+la18CFY/BA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793569619;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=HHNSKT8SiXWz70ors39uBUGFQtreIPGuQljyrwy05Bw=;
	b=vRqMuxOXRa1ayfQDO0TyfzL+niUKM+OyZmml8KfhFBVKmmeeWcgTTjKJ81uxGpnsCg0O
	 LR/sxo4a18b/SLYAV/2jYEWAMs0Be6+l/j7elQSs1Iy0Awpvh86300ud/hs64zP3SQtIy
	 6JEExZSKYeTwlj3wOgv0WAF7vTHfXbI90YoCvJ4tu1NvBgDPPEDk3HfupayRtkVmp+rz4
	 ywJ/IvEZ/QhkfjJ6J8i4Iz3yHPT+MGwCjJnD+oPyXPsE9tXdx+6e1jOvnil7QCxUXup6M
	 Z1DhENs9VADletatAG1dNeRrqSC6RWTpsjeIAUMSg3HWpDouwj7KyC5OgVU7/pOJ2mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EEXFL+K7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E1D606A324;
	Sun,  1 Nov 2026 21:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EEXFL+K7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9E451F000C1;
	Sun,  1 Nov 2026 21:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793569618;
	bh=HHNSKT8SiXWz70ors39uBUGFQtreIPGuQljyrwy05Bw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=EEXFL+K7EjhxWxcm506v37hbdH3npV09OKDxBP4TGzf42EIM4SOsIAOtFf+/4mq+U
	 Xy4yU3bVERLS12Fe52vrQbCZGWmxJ/NJ4/QLLRyEyvpVbp1HC321Mk0FYiKHjbUu9D
	 Tuvf3IthneoNzcWXFIz1of9DXJ6sEqmcjDlzywVKYhiYSq0J7CvQNJC4GMMD7pQ6Hg
	 whGLSLSSDdLbTU4+SRzD6P85UqctuWmE4ntHLkXBd7CRFtjz63QTdT7jR0IOQQuPyR
	 g5I79JwgQyqCMrrHynr/X6vuberIeLj0FGVe/+r5KgjJprepxEV2nI7kUrNYyCmRX/
	 85LxxZ9Iak1Kw==
Subject:
 Re: [PATCH net v2 2/5] net: dsa: b53: fix the SRAB grant timeout check
From: netdev-bot+sashiko@kernel.org
To: florian.fainelli@broadcom.com
Cc: netdev@vger.kernel.org, jonas.gorski@gmail.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, linux@armlinux.org.uk, rmk+kernel@armlinux.org.uk,
 linux-kernel@vger.kernel.org
Date: Sun, 01 Nov 2026 21:46:57 +0000
Message-ID: <179356961718.3131.9184132538995521305@kernel.org>
In-Reply-To: <20261028212310.3847553-3-florian.fainelli@broadcom.com>
References: <20261028212310.3847553-3-florian.fainelli@broadcom.com>
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

- [Low] The grant poll loop in b53_srab_request_grant()
  (drivers/net/dsa/b53/b53_srab.c, lines 102-109) wastes its final sleep.

Pre-existing issues:
- [Medium] Uninitialized stack values are used on the grant-timeout path
  that this patch makes reachable.

--

net: dsa: b53: fix the SRAB grant timeout check

This patch changes the timeout check in b53_srab_request_grant() from
i == 5 to i == 20 so that it matches the 20 iteration poll loop. A grant
that never arrives now returns -EIO, where before the register access
went ahead without ownership of the switch resources.

> diff --git a/drivers/net/dsa/b53/b53_srab.c b/drivers/net/dsa/b53/b53_srab.c
> index 83a03fca142a0..f4689078ccd51 100644
> --- a/drivers/net/dsa/b53/b53_srab.c
> +++ b/drivers/net/dsa/b53/b53_srab.c
> @@ -105,7 +105,7 @@ static int b53_srab_request_grant(struct b53_device *dev)
>  			break;
>  		usleep_range(10, 100);
>  	}
> -	if (WARN_ON(i == 5))
> +	if (WARN_ON(i == 20))
>  		return -EIO;

[Severity: Medium]
This is a pre-existing issue, but this patch makes the grant timeout
path reachable. Several callers then use uninitialized values.

When b53_srab_request_grant() returns -EIO, b53_srab_read8() (and the
read16/read32/read48/read64 variants) skip the *val assignment:

drivers/net/dsa/b53/b53_srab.c:b53_srab_read8() {
	ret = b53_srab_request_grant(dev);
	if (ret)
		goto err;
	...
	*val = readl(regs + B53_SRAB_RD_L) & 0xff;

err:
	b53_srab_release_grant(dev);
	...
}

The b53_build_op() wrappers in b53_priv.h pass the error through and do
not initialize *val. Many callers in b53_common.c ignore the return
value. One example is b53_get_ethtool_stats():

		} else {
			u32 val32;

			b53_read32(dev, B53_MIB_PAGE(port), s->offset,
				   &val32);
			val = val32;
		}
		data[i] = (u64)val;

Can this copy uninitialized kernel stack data into the ETHTOOL_GSTATS
buffer that is returned to userspace?

Other callers follow the same pattern:

  b53_eee_enable_set() writes an uninitialized u16 reg back to
  B53_EEE_EN_CTRL with b53_write16().

  b53_enable_vlan() read-modify-writes the uninitialized mgmt, vc0, vc1
  and vc5 into the switch mode and VLAN control registers.

  b53_arl_search_read_89() (and the _25/_63xx/_95 variants) decode the
  uninitialized mac_vid and fwd_entry into a b53_arl_entry.
  b53_fdb_dump() then passes that entry to b53_fdb_copy() and the FDB
  dump callback.

Before this patch, a grant timeout fell through to b53_srab_op() and
*val got written. The same uninitialized use could already happen
through the GORDYN timeout in b53_srab_op(). That path also returns
-EIO and skips the assignment.

Should the SRAB read accessors zero *val on error? The other option is
for these callers to check the b53_read*() return value.

[Severity: Low]
Can this reject a grant that arrives during the last sleep?

On the i == 19 iteration, the loop reads B53_SRAB_CTRLS and sees no
RCAGNT. It then calls usleep_range(10, 100) and exits with i == 20,
without reading CTRLS again:

	for (i = 0; i < 20; i++) {
		ctrls = readl(regs + B53_SRAB_CTRLS);
		if (ctrls & B53_SRAB_CTRLS_RCAGNT)
			break;
		usleep_range(10, 100);
	}

Suppose the arbiter asserts RCAGNT during that last sleep. The function
now WARNs and returns -EIO. The caller's err: path then calls
b53_srab_release_grant() and clears RCAREQ, even though access was
granted. In practice the wait covers 19 polls, not 20.

Before this patch the timeout check never fired, so this had no effect.

Would readl_poll_timeout() avoid this? A final read of CTRLS after the
loop would also work.

>  
>  	return 0;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261028212310.3847553-1-florian.fainelli%40broadcom.com
