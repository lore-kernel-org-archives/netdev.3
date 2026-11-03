Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793698995;
	b=h6ySzNxUPAduYuXv11zdLOs8XMGPKyGCHaTzldp2z1kv2hAQxY6D7ybWyHwzW7F8D6P3
	 0VrILd67E/o47ClIADQ/A9bDknBSewroqnS4ULGqIt2Toq0dMYY4gqrCorIaYZjtHW+Wb
	 GFqLDiAC8vv1/alNraIYxTx0MzL7BL5YOZBQl/DNb5Xp4DXfyLrEk84DLlXws/dMGPgj1
	 uo5AR7fs74Vgl7PxYjwKDarSEGkevDlLS6/xq1Sb7VHauGGW6HHQbyZJXMluwCOLTL6u9
	 P3m+AOKxi7g1Kp+OlUoebPraLGUGokSpp5CA5VB7SufdGRDHoV02S/Dp3YcuR/yXxOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793698995;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Ax+Y1NYJ7G+p3oM+b1SjSykoPY3EvHvOyGpyknFiIuU=;
	b=i2bslBY8ww+ifl9apyhLDmnOWtFXOkU6DPneqzT34rIXCDuECmkTJKcifAIa62Gj3aXJ
	 RHSqxJQMDlhE5BygqS6YFzLOXFe6+4vX41pGdqM6u9uauOpGnsCdRMm7CbdfQvL4+ClAs
	 1n1dkPxj73y1GCDUtW07KzX3UMTbn0JATzUTC7YZMuTQnHOQwqgAneLUqUGAhG+Ta6YYV
	 citKLWixpalW+GDsHqHvsibiVNFj6sdRjLsqQNMZ0aRNiUuII8zmTQ5urvH9SgzInx6oU
	 uHCi881tshZAYxc1jXSlFmZvg5l3sg0mNRaj+m75ueAGa8IzpomLhhxxEIWERpoXJfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VB2YJGf6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A519606A327;
	Tue,  3 Nov 2026 09:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VB2YJGf6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A7E71F000C1;
	Tue,  3 Nov 2026 09:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793698995;
	bh=Ax+Y1NYJ7G+p3oM+b1SjSykoPY3EvHvOyGpyknFiIuU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VB2YJGf6qTqPTT2o1HMhTrsJ1ggNEmsUspWeULkwX39iyMgek3DLLLcNMIdCtakZN
	 XP/S56xZo0yC3yRCBTTQWRb4QzGrR7c7Hbpy5ygVo65+UA7Z6pAcPnxIObdaxTar2+
	 c+k61U8oa/6OBp10g812TMh6x2JQFtQxvBk9+iBeBVwt7/xo9XenP2fNnWU3uvDkFh
	 6PYvH8ImiFTiMscwKX4YJgVQwAjWrK+2NSRv8uvUhfkYvptnsn+Bjw48Cdv+bpAdUW
	 JWdFfmlJ398b3HrqKsQGvcSMV7yGSi0cSUzWoC317d851Kc4nbO4m5SaMfL5MVm4Tl
	 YpZyeh04NGDlw==
Subject: Re: [PATCH] net: ti: icssg-prueth-sr1: Fix device_node refcount leak
 in prueth_probe()
From: netdev-bot+sashiko@kernel.org
To: laixiangwu@cmss.chinamobile.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, danishanwar@ti.com, rogerq@kernel.org,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 03 Nov 2026 09:43:14 +0000
Message-ID: <179369899417.488856.4974450054291603730@kernel.org>
In-Reply-To: <20261030085851.2019-1-laixiangwu@cmss.chinamobile.com>
References: <20261030085851.2019-1-laixiangwu@cmss.chinamobile.com>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The same leak is still present in the sister ICSSG driver.

--

net: ti: icssg-prueth-sr1: Fix device_node refcount leak in prueth_probe()

In the SR1.0 driver, prueth_probe() returned -ENODEV directly when the
"ti,mii-g-rt" or "ti,mii-rt" syscon regmap lookup failed. That return
leaked the eth0_node/eth1_node references taken with of_node_get(). The
patch sends both error paths to the existing put_cores label instead.

> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c b/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
> index b8115ca47082f..ef1dc32ff8b46 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
> @@ -963,13 +963,15 @@ static int prueth_probe(struct platform_device *pdev)
>  	prueth->miig_rt = syscon_regmap_lookup_by_phandle(np, "ti,mii-g-rt");
>  	if (IS_ERR(prueth->miig_rt)) {
>  		dev_err(dev, "couldn't get ti,mii-g-rt syscon regmap\n");
> -		return -ENODEV;
> +		ret = -ENODEV;
> +		goto put_cores;
>  	}
>
>  	prueth->mii_rt = syscon_regmap_lookup_by_phandle(np, "ti,mii-rt");
>  	if (IS_ERR(prueth->mii_rt)) {
>  		dev_err(dev, "couldn't get ti,mii-rt syscon regmap\n");
> -		return -ENODEV;
> +		ret = -ENODEV;
> +		goto put_cores;
>  	}

[Severity: Medium]
The SR1 change looks correct. Does the sister driver still leak the
port@0/port@1 device_node references the same way?

prueth_probe() in drivers/net/ethernet/ti/icssg/icssg_prueth.c parses the
ports the same way. It calls of_node_get(eth_node) for each port and stores
the results in prueth->eth_node[]. It still returns directly on both syscon
lookup failures:

drivers/net/ethernet/ti/icssg/icssg_prueth.c:prueth_probe() {
    ...
	prueth->miig_rt = syscon_regmap_lookup_by_phandle(np, "ti,mii-g-rt");
	if (IS_ERR(prueth->miig_rt)) {
		dev_err(dev, "couldn't get ti,mii-g-rt syscon regmap\n");
		return -ENODEV;
	}

	prueth->mii_rt = syscon_regmap_lookup_by_phandle(np, "ti,mii-rt");
	if (IS_ERR(prueth->mii_rt)) {
		dev_err(dev, "couldn't get ti,mii-rt syscon regmap\n");
		return -ENODEV;
	}
    ...
put_cores:
	if (eth0_node || eth1_node) {
		prueth_put_cores(prueth, ICSS_SLICE0);
		of_node_put(eth0_node);
    ...
}

Both returns skip put_cores, which is the only place eth0_node and
eth1_node get released.

The same ret = -ENODEV; goto put_cores; change should work there without
modification:

  - prueth is allocated with devm_kzalloc().
  - prueth_put_cores() NULL-checks the core handles.
  - of_node_put(NULL) is a no-op.

Valid DTs can reach this path. The ti,icssg-prueth.yaml binding does not
list "ti,mii-rt" under required, so an AM64x/AM65x SR2.0 DT without that
phandle would leak these references on every probe attempt.

The SR2 driver would need a different Fixes: tag, so could this be sent as
a separate companion patch rather than folded into this one?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261030085851.2019-1-laixiangwu%40cmss.chinamobile.com
