Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792440850;
	b=UqwGqC21aD45xqK1f4NRd+3XHntK0iLL/YwuYx1k3XHX6PkISpPiWQKFob46l0W7Q21o
	 9edWF6yTvCztzqF+u2QBbn86GLYXuJ5ig7LY+7r8sJ3wUAsHB9FIAfQ/T3dbqG2PsvhNX
	 wX0Ttcgouiwpz2WdJNyPXacyUY3VP4MzaWEcf4zExMoXU6GP2FUEr7xbjorWQ4wDwHgDa
	 zG8XHFwUpkasUEQUsgWwXk6b5wpbbDDud5SrV2Q4DCq+I8cVwu7b2FCkgozt5SZUoVwC5
	 DY+bcnwApwqjV788eslELPvnPOmTdft9HX8up3wudOq3LcOnAeu80jyAUtD6wqZO90g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792440850;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=mWwT6wcsjVYqsbDB3myZXUGIrP+ManxlK9KNx+Ru8xc=;
	b=QdAV9BdStJ3Di5r8EXOgiVavECqPzHdR1LuPbuADAs9fLbbl5NehdME0craSBSoGFf4l
	 OrInrkcyMdL+rLKoHkGf84NARtwD5XRDXqiwHxJzZiJar0P8pzTG6Kvyn2zB0wAz7vWtP
	 hMpz2/Tg5XIBn7NlBL2VgnUZg34y9Tmhwx522ouDfJJk7Yb1tZXIDZgY9vDwDKo+6wtII
	 wUMOcnAYf3nTjTUHJ4fpxhwVV+b7EzJiESqLuOzmAZWmL+jgTP6f3bCVOdCuKh8Q/D74M
	 pAgxoiQa9QzEtr9E5ZJVKXIsgqFDYwngQg8hohYAu3bswC3jfQM+ADfv08IMCgJheXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XavQRr3K;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85587606A31E
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 20:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XavQRr3K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FE9C1F000C4;
	Mon, 19 Oct 2026 20:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792440850;
	bh=mWwT6wcsjVYqsbDB3myZXUGIrP+ManxlK9KNx+Ru8xc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XavQRr3KAaQzKV5HyjEHQxK64l+zV+YCyrIGMnR/SHVjG00WsV5sBlSH1BGk6eSMo
	 crQj5u8XPcOYSwSQM5wVh6ya7zpsQ8+JUKr4RcneiLS1YfA7SQO1lNtZUU0qGLm0lT
	 ZRKvH9RaNLkflYj+6Hp4h3L5QCDdgYidinZUfMkMPo14ujHDM/ihxupfAFpe4xCaz7
	 ExjP7gM7ECu56Es7hQpDcqtpLEMvCs30zrbNIfXyqI8r70nimou1ZN7kbUKNERXWbK
	 Ypq63/5lrOSZ1pRqZHdQ58tRDI5zpMmk/AMuaSi6X51zTsi+zaiO2/E1UmFzYje+O0
	 1NmZVOJQTAF6A==
Subject: Re: [PATCH net v3 07/14] ice: E822: cancel offset verification work
 during reset preparation
From: netdev-bot+sashiko@kernel.org
To: anthony.l.nguyen@intel.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 poros@redhat.com, jacob.e.keller@intel.com, maciej.machnikowski@intel.com,
 przemyslaw.korba@intel.com, grzegorz.nitka@intel.com,
 sergey.temerkhanov@intel.com, arkadiusz.kubalewski@intel.com,
 richardcochran@gmail.com, horms@kernel.org
Date: Mon, 19 Oct 2026 20:14:08 +0000
Message-ID: <179244084873.3135.13916049377075971690@kernel.org>
In-Reply-To: <20261015191102.1174111-8-anthony.l.nguyen@intel.com>
References: <20261015191102.1174111-8-anthony.l.nguyen@intel.com>
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

- [Low] Possible requeue of ov_work after the new cancel (judged harmless
  and by design).

--

ice: E822: cancel offset verification work during reset preparation

This patch cancels the E822 offset verification work (ov_work) in
ice_ptp_prepare_for_reset(). Without the cancel, the work can keep running
or rescheduling itself while a reset is in progress. The PHY gets
reconfigured after the reset anyway, either by the clock owner or by
ice_ptp_link_change() at the end of the rebuild.

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index 828d46a73f292..6297773806949 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -3006,6 +3006,9 @@ void ice_ptp_prepare_for_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
>
>  	kthread_cancel_delayed_work_sync(&ptp->port.work);
>
> +	if (hw->mac_type == ICE_MAC_GENERIC)
> +		kthread_cancel_delayed_work_sync(&ptp->port.ov_work);
> +

[Severity: Low]
This is a minor observation and it may well be intended. This cancel runs
without adapter->ps_lock held, and nothing stops ov_work from being queued
again afterwards. Can another PF queue a peer's ov_work again while that
peer is still resetting?

On a multi-PF E822 adapter, the clock owner can reach this producer for
every port that has link_up set:

ice_ptp_rebuild_owner() / ice_ptp_settime64()
  ice_ptp_restart_all_phy()
    ice_ptp_port_phy_restart(port)
      kthread_queue_delayed_work(pf->ptp.kworker, &ptp_port->ov_work, 0);

ice_ptp_restart_all_phy() checks only this before restarting the peer's PHY:

	if (READ_ONCE(port->link_up))
		ice_ptp_port_phy_restart(port);

It does not look at the peer's ptp.state or its reset state.

The impact looks small. A requeued ice_ptp_wait_for_offsets() sees
ice_is_reset_in_progress() and only reschedules, with no hardware access:

	if (ice_is_reset_in_progress(pf->state)) {
		/* wait for device driver to complete reset */
		kthread_queue_delayed_work(pf->ptp.kworker,
					   &port->ov_work,
					   msecs_to_jiffies(100));
		return;
	}

Each PF's ice_rebuild() also calls ice_ptp_link_change(). That path goes
through ice_ptp_port_phy_restart(), which cancels and requeues the work.

The commit message also says the PHY is reconfigured "as part of the clock
owner resetting", so the requeue may be the intended recalibration path. If
so, the only effect left is a few no-op 100 ms reschedules during a reset.

Is that the expected behaviour, or should the restart path skip ports whose
PF is in reset?

>  	if (reset_type == ICE_RESET_PFR)
>  		return;
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015191102.1174111-1-anthony.l.nguyen%40intel.com
