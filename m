Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793705355;
	b=cR9wvZNMoZR1BMSjmac6XGtQaMErXnEh+sm0GKRDDxnyibbzErrJquvk7uQpfhcHCvsj
	 23KiCslt4RGTUe/wXzndZbn9tOkgsWBG7Xb4Vae9bmolEXnKK+GgJuoMycNDh+s+Kbtz7
	 ib+wrH7l4Hi1Q4n23CP+ouUqqnm8b0hBwm5MlxxBCyg7kg2Vz0F1YalzVJpyaRXClbuwC
	 d7qqycFB9qWuY5JeiWxtQOwNKGeD0z5pmDYxMmcF55eLi8sAhU8Wtl9w+be9ZDf7MPm8l
	 GGG0IZ0pKbDuZxU/FlxEba0CI1HVt1rdoWvCgbNfG+3KcRWbxhzc/5lVF2a4ysCnU9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793705355;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=pVkpz5nFPTNysaK+OObBoCi45oeQOOEdraJNg5dmE9w=;
	b=ykYf0JGBO1x00TgX3LQddhnuxdLZjdvplM/PvUB8NWBtUgrrRz5RrTSJm5MFKoDWIMrS
	 jhzEzZVA44kdVyDB8USEd3ClQKbXRaK4hYOFTKRMUJ+V2nw2I0RundBySoRImz40uPN+r
	 lPHd63v0TCM518jhVl6JSrmtPavHBa/WlTomvh1hM4cP5NhH00jvm8NHw3QX5sns8XVDI
	 R0ToYjfdOs/JsmwS2my5dwHgCWlhjXpenZDzfpR1HFQfZAYYVM3orlJfA/IG0KkgAjsBz
	 C2sFDnLX7VHx8Mc9TYyANGABI4gxjycfKxxVseS6ikBgePZE3DxBW69lKy/MUz1zYQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nkYq6iNK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFC7606A838;
	Tue,  3 Nov 2026 11:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nkYq6iNK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75ADB1F000C1;
	Tue,  3 Nov 2026 11:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793705355;
	bh=pVkpz5nFPTNysaK+OObBoCi45oeQOOEdraJNg5dmE9w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=nkYq6iNKr1G4WekUK019gDyH9o2iMu/MeYMCX6v+YzxO96ScEHf78kh12oT2JMkbj
	 KUoJ/gNIxjD9vuP9if5lMhMOKh44B8SkvW/uU7e8Bnl8B80ZDBwVP8bwj5jDYf6Jte
	 Sd1wBfdbP2WWqek89H+W/iDIdjYh+mSUgMP9Qfm/Jt8ydSMQiXT/IIJ88MOADPNmhC
	 Bc2TsK7kWz6tT+XChBKSMT8SQMYju+o5KKtkytmh2KiNZHzI1c6CZ05yup1/57wcsn
	 6J9xbx/de8c5hLpTpF/pXoQdhpGXTIedT2FnqMAGHeF7DeVw2BhPii8PX12bT+tDDu
	 i6Ham2VT2c/fA==
Subject:
 Re: [PATCH net 2/3] net: mvneta: fix the removal of the mqprio offload
From: netdev-bot+sashiko@kernel.org
To: pepe.schlehofer@gmail.com
Cc: netdev@vger.kernel.org, marcin.s.wojtas@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 maxime.chevallier@bootlin.com, w@1wt.eu, linux-kernel@vger.kernel.org
Date: Tue, 03 Nov 2026 11:29:14 +0000
Message-ID: <179370535406.488856.16925865823756698618@kernel.org>
In-Reply-To: <20261102112816.12322-3-pepe.schlehofer@gmail.com>
References: <20261102112816.12322-3-pepe.schlehofer@gmail.com>
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

- [Medium] After this patch, an mqprio teardown request (all-zero qopt,
  num_tc == 0) always reaches the device-wide reset in…

--

net: mvneta: fix the removal of the mqprio offload

When an offloaded mqprio qdisc is deleted, mqprio_disable_offload()
passes an all-zero qopt with hw set to 0. As a result,
mvneta_setup_mqprio() used to return before reaching its teardown code.
This patch checks qopt.hw only when num_tc is non-zero, so the teardown
path is reached on removal.

> diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
> index 9b9efac2846ef..79711a117c39c 100644
> --- a/drivers/net/ethernet/marvell/mvneta.c
> +++ b/drivers/net/ethernet/marvell/mvneta.c
> @@ -5251,11 +5251,12 @@ static int mvneta_setup_mqprio(struct net_device *dev,
>  	int rxq, txq, tc, ret;
>  	u8 num_tc;
>  
> -	if (mqprio->qopt.hw != TC_MQPRIO_HW_OFFLOAD_TCS)
> -		return 0;
> -
>  	num_tc = mqprio->qopt.num_tc;
>  
> +	/* On removal the qdisc passes an all-zero qopt, with hw 0 */
> +	if (num_tc && mqprio->qopt.hw != TC_MQPRIO_HW_OFFLOAD_TCS)
> +		return 0;
> +

[Severity: Medium]
Can a root qdisc replace now wipe out the configuration that the new
mqprio qdisc has just offloaded?

With this change, every all-zero teardown request reaches the reset that
covers the whole device, further down in mvneta_setup_mqprio():

	mvneta_clear_rx_prio_map(pp);

	if (!num_tc) {
		mvneta_disable_per_queue_rate_limit(pp);
		netdev_reset_tc(dev);
		return 0;
	}

Take the case where offloaded mqprio 1: is installed and the admin runs
something like "tc qdisc replace dev X root handle 2: mqprio ... hw 1".
__tc_modify_qdisc() does not find handle 2:, so it goes to create_n_graft.
The new qdisc is then initialised before the old one is destroyed:

__tc_modify_qdisc()
  qdisc_create()
    mqprio_init()
      mqprio_enable_offload()
        mvneta_setup_mqprio(num_tc = N, hw = 1)
          programs TC map, VLAN prio to RXQ map, per-queue rate limits
  qdisc_graft()
    notify_and_destroy(old)
      qdisc_put(old)
        mqprio_destroy(old)
          mqprio_disable_offload()
            mvneta_setup_mqprio(num_tc = 0)
              clears RX prio map, rate limits, netdev TC state
    new->ops->attach(new)
      mqprio_attach()

mqprio_destroy() takes this path because the old qdisc has hw_offload
set:

	if (priv->hw_offload && dev->netdev_ops->ndo_setup_tc)
		mqprio_disable_offload(sch);

mqprio_attach() only grafts the child qdiscs and does not reapply the
configuration. The replace returns success and the new qdisc still
reports hw_offload, but its rate limits, RX steering and netdev TC
mapping are gone.

Before this patch, the hw != TC_MQPRIO_HW_OFFLOAD_TCS check turned the old
qdisc's teardown into a no-op, so the new qdisc's configuration was kept.

The same init-before-destroy ordering already resets state in software
mode, since mqprio_destroy() calls netdev_set_num_tc(dev, 0). It also
affects other drivers that reset on num_tc == 0, and mvneta behaved this
way before e7ca75fe6662. On mvneta, though, this patch is what makes the
case reachable again.

>  	if (num_tc > rxq_number)
>  		return -EINVAL;
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261102112816.12322-1-pepe.schlehofer%40gmail.com
