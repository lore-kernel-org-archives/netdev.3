Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BA92E739D;
	Fri, 14 Aug 2026 19:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786737064; cv=none; b=lcFo+Fp5ZophoMoCyJhbznIEoFIBlufJy2n2EJLXapf0ywAIsdI0tzRQ8LtNuMwDoWos06CZbST6vH50XgLv4WnPM6zIhJEAbnO9j2E5L5BA5WCHeojgHdhPtp422HfVSUDhMon+AGQwq6lRcj5YfftY79qhFN3dr/whup1zOY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786737064; c=relaxed/simple;
	bh=1RECcdbEQ98isxyyjrAj1pUuOSdGQgYNEgK1SlexgTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VOgliIxKL4So6S6PDdwJui5JeCX/HtIJXaWT7KTatLT4vHac6P0YKS0aBDhlom+HAv3DJXWt8UOV7c9ijMXdqMeVQY+F1i6J1j0Zlb8vhgc3XBrCj/KQ0e2n5gHxzfVviKfgV6+xGqldKqZsnhIiOOrppBBwXN8osbVvhURECXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SI+TajKu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SI+TajKu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F31E91F00A3A;
	Fri, 14 Aug 2026 19:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786737063;
	bh=vDlXcSQGACLjyzPywSGax/Quo8a3G0VxgINJqc53e2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SI+TajKuOzMnanl6OCx9zDWYMco1NavMz2rnz/bqJAPPMBtYAA4zaHFRBmIi2q1uH
	 atLSFRWijvgWW/jmqXiTxN/G0VSFbNqch0UtJGABCJx3N+L6wvw8mwTX7/pNiRey5Y
	 9oYpvDcx6EmYfhRluU0HHwCLSX93OIvqJ5/uGOoRj0RI8jh4r8z4qtPsEkcUXlEKkL
	 f0BtcATeBSchs4BEQLCtMFodnbp7B36V47MMYTA2u4lx89ZqYbwxr5lKM5fOtrT/9s
	 pOcTv48d8n4RaMPj4dtTBOdMwWLJ3WYwz1MDuCV9vGtLiuoQBdJ2PWgHSC5HFY0oWw
	 +AoVNRX946xlw==
From: Jakub Kicinski <kuba@kernel.org>
To: peter.hunt@opengear.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	loic.poulain@oss.qualcomm.com,
	ryazanov.s.a@gmail.com,
	mani@kernel.org,
	johannes@sipsolutions.net,
	netdev@vger.kernel.org,
	mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/3] bus: mhi: host: pci_generic: enumerate IP_CTRL channel for Sierra EM919x/EM929x
Date: Fri, 14 Aug 2026 12:51:02 -0700
Message-ID: <20260814195102.3204050-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260807215042.2714442-3-peter.hunt@opengear.com>
References: <20260807215042.2714442-3-peter.hunt@opengear.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
bus: mhi: host: pci_generic: enumerate IP_CTRL channel for Sierra EM919x/EM929x

This adds the standard Qualcomm MHI control channels 18/19 ("IP_CTRL") to
the Sierra em919x channel configuration, using the control event ring.
The stated purpose is to let the host drive DTR/RTS towards the modem.

> Enumerate it in the Sierra em919x channel config (shared by the EM919x
> and EM929x) using the control event ring. This is the device the change
> was tested against; other Qualcomm modem configs that expose IP_CTRL can
> enable it the same way, since the mhi_wwan_ctrl DTR support that consumes
> it is device-agnostic and binds purely by channel name.

[Severity: Low]
This isn't a bug, but the phrase "the mhi_wwan_ctrl DTR support that
consumes it is device-agnostic and binds purely by channel name" is written
in the present tense, while that consumer only appears later in the same
series.

At this commit, drivers/net/wwan/mhi_wwan_ctrl.c has no IP_CTRL entry in its
mhi_device_id match table and no ->dtr_rts implementation in wwan_pops; both
arrive with "net: wwan: mhi_wwan_ctrl: drive DTR/RTS via the IP_CTRL
channel".

Would it be clearer to phrase this as support added by a following patch in
the series?

For the record, the intermediate state looks harmless: the newly enumerated
channels only create mhi_device instances with no bound driver, and such a
channel is never started because mhi_prepare_for_transfer() is only called
by a client. pci_generic already enumerates channels with no in-tree
consumer for a given config, for example "IPCR" and "IP_SW0".

> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
> index 0d0d9c7ffa4b..ba47dd153837 100644
> --- a/drivers/bus/mhi/host/pci_generic.c
> +++ b/drivers/bus/mhi/host/pci_generic.c
> @@ -728,6 +728,8 @@ static const struct mhi_channel_config mhi_sierra_em919x_channels[] = {
>  	MHI_CHANNEL_CONFIG_DL(13, "MBIM", 128, 0),
>  	MHI_CHANNEL_CONFIG_UL(14, "QMI", 32, 0),
>  	MHI_CHANNEL_CONFIG_DL(15, "QMI", 32, 0),
> +	MHI_CHANNEL_CONFIG_UL(18, "IP_CTRL", 32, 0),
> +	MHI_CHANNEL_CONFIG_DL(19, "IP_CTRL", 32, 0),
>  	MHI_CHANNEL_CONFIG_UL(32, "DUN", 32, 0),
>  	MHI_CHANNEL_CONFIG_DL(33, "DUN", 32, 0),
>  	MHI_CHANNEL_CONFIG_HW_UL(100, "IP_HW0", 512, 1),

Cross-instance finding from sashiko-gemini (7294b6d42c500c3db0e0cd5f3fe50b00b9c09cbd890618c9d32841fb863f7603):
[Severity: High]
Unchecked dereference of `port->ops` in `wwan_port_fops_at_ioctl` can cause a kernel panic during device hot-unplug.
