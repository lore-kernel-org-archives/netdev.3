Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F473EEAF2;
	Wed, 17 Jun 2026 11:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781696734; cv=none; b=TVozG8g7aKMHxbjk11XS1k27ADt2Hu9DLx2gklvoJXMnBtg5UBnVBeVFoWXyusH53JQuT64An8huN89k/igwViKFbaHGvSh7batD1xhJskIIQgRYvNCMcHuJglM3KIn8JlPWmAMPp3tRgpiQcLMVooP+keMz4U8VGhepGML9Jaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781696734; c=relaxed/simple;
	bh=adDV1ppAUpQ67CpkcMHuvJ795UMWAGCSHaAU4Y3DT1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lxDFQA0giji46HzunkmWUrH2/LQvmC1p3HivQMCU3Wxsz8jag1pBcKX1NzvGuCcCKEgS5FbK5WTU0UuaxlMFWbtS9xxcPw/RTWhje2eENlH+eZok31qgPGLzW4x0gVVLE8w1AgILlPXnwrsPJ8oUk0DYY9jhan972oUYpvX8y88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I8QHQ9V+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I8QHQ9V+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2019E1F000E9;
	Wed, 17 Jun 2026 11:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781696732;
	bh=AuUrWPb+daIMdbL9iHx34oo1WgA00hCuqCiSD8TIPAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I8QHQ9V+nBEhhVjcDw4P4xh5gx0UrTz/EytHqT0wl8x8Z5erqwdZ9CM3C8PPnXLnj
	 kS2I6TjOy4ShgMxxmiUOy40YYHXMp5NjaDwvVJ7Ep7h+dDYG9N148rEqMYL8uqI4OY
	 1OMDvVQvrqBFM59Tv4A9XnY2MoAiEhpuTpNamQwgwPIjdJfi/+Fay/UGyMcsCNaXqR
	 TUSHoYwGVeKjLo1yXu0iR73splVzuGYHbF/gFo7CNC+8NolmRcqbn0sTJYZs3TXpy9
	 0hnq0Vu+7OFmt+Ku8kzJJb7Vzie0YCVf+jPuTtY1tW64rhxPZs8v8M3AFl3unkSUiZ
	 BrysC4K/aA2yg==
From: Simon Horman <horms@kernel.org>
To: ioana.ciornei@nxp.com
Cc: Simon Horman <horms@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	f.fainelli@gmail.com,
	vladimir.oltean@nxp.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] dpaa2-switch: fix VLAN upper check not rejecting bridge join
Date: Wed, 17 Jun 2026 12:45:18 +0100
Message-ID: <20260617114518.857486-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616105430.3725910-1-ioana.ciornei@nxp.com>
References: <20260616105430.3725910-1-ioana.ciornei@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
dpaa2-switch: fix VLAN upper check not rejecting bridge join

The blamed commit refactored the prechangeupper event handling but
failed to actually return an error in case
dpaa2_switch_prevent_bridging_with_8021q_upper() detected a 802.1q upper
on a port which tries to join a bridge. Fix this by returning err
instead of 0.

> diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> index 52c1cb9cb7e02..46ae81c2fa013 100644
> --- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> +++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> @@ -2177,7 +2177,7 @@ dpaa2_switch_prechangeupper_sanity_checks(struct net_device *netdev,
>  	if (err) {
>  		NL_SET_ERR_MSG_MOD(extack,
>  				   "Cannot join a bridge while VLAN uppers are present");
> -		return 0;
> +		return err;

[Severity: High]
If a user adds an 802.1q VLAN upper device to a port after it has already
successfully joined a bridge, won't this check trigger when the port leaves
the bridge?

In drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c,
dpaa2_switch_prechangeupper_sanity_checks() is called for both bridge joins
and unlinks from dpaa2_switch_port_prechangeupper():

    err = dpaa2_switch_prechangeupper_sanity_checks(netdev, upper_dev, extack);
    if (err)
        return err;

    if (!info->linking)
        dpaa2_switch_port_pre_bridge_leave(netdev);

Since returning an error aborts the notifier chain, an unlink notification
would fail this check, preventing dpaa2_switch_port_pre_bridge_leave() from
running. Does this lead to state inconsistency and skipped switchdev
unoffloads?

Could this check be guarded so it only runs when info->linking is true?

>  	}
>  
>  	netdev_for_each_lower_dev(upper_dev, other_dev, iter) {
