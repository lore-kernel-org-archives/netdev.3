Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792971842;
	b=eRuTmdWW5+AHh08Y5wWQxXDDl0BKQG/EI6BlrraBLulmIjLfntXh7iWv1sgXUpcAXGLP
	 FjNdyX7qKokzHNC8621hMNfNXeirvi/h9iQyIWrbyQyzGuqz5ees1YMBoVRAjRW1KXodA
	 RWAJP3Mq8xGew/aQ/cLl3cYLhOw7oV9W1UK/0PNyxgPAC5P4DMslsYHW52iU9/vtWYQC1
	 pZNYqIBPNiWq0iWiZO0M8q95stU30n15CRe6eMnetEfppkx+eyXaZtWQ/UYd+ri8wUjGZ
	 vEFmByCkmdCRVmzXzHeIt87PK+miJY+rsBE7hFWJAMfgzo93oA3r/eWTSeE8hw/YL6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792971842;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=F5IcTz3zdhdhlrBs64CB/6G2Lii0ugSxWBd4UAQ8ZAk=;
	b=5HwPE2kZij9tELGErnUlfv8vd+oWcCqNNFPwBg++Pj5n1OcRmcifTvyZ2qhgvvV1da+u
	 2FbjEQqtD8yxddKerwiBKtXY3GlT6l06T3N0srzyQqsICdWLkd2tUwE5P0vh5mdwhvoLq
	 EDuJbEBT0FPTvIqjhCtqJzadB9J474fNJh8BsR9YicOlu5OXLrj6MQvwnvARIDPNRF0fV
	 QP6faTqISDaQ6X7TObEpbLkRkh8BmRFn1l0SaK8xz0JGTaZCcuWJt8UvtUTnOpKBhlJSY
	 T7PG1Ln9BEGP0y/xPLoCGtWyRmxrWFZPe2b2B5rYznZfQT1Gc2x6VQPsWN51V4wBgzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="iehOsL/t";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2617606A325
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 23:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iehOsL/t
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF0BE1F01828;
	Sun, 25 Oct 2026 23:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792971841;
	bh=F5IcTz3zdhdhlrBs64CB/6G2Lii0ugSxWBd4UAQ8ZAk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=iehOsL/te6kHBDWPlTSW9qeid8hPnXNQONupLzBMjZ2L5So/4de3qoqgiL9WblA02
	 OXzcvt+65xXJCMq7hV8lSn+PrUze+bssw7EEM65gzPHDCosmUftZYeYLDaI7yv9mNc
	 D+sSf3XFN+bMoC6ulO6awFzfeHmjw9vkUN96NL7vXGMzWfE+nwDgCqSYhVO0ctllgo
	 Ndd84VKRmmLeY0JVRQdTdDXiRW3eGozy5ntqNPcHmkkpEwvah8SXNjWdOMETXeZjK3
	 N8T6xZuOXrKrnf40/WGQEYdc8Pd3wuG5G4pEMs+0JsNc5LXKoj8+R4gcfcNiNxd5xl
	 yvegxDK5fvGbg==
Subject:
 Re: [PATCH net v5 08/13] ice: E825: stop clearing PHY_REG_TX_OFFSET_READY
From: netdev-bot+sashiko@kernel.org
To: jacob.e.keller@intel.com
Cc: przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, poros@redhat.com,
 netdev@vger.kernel.org, grzegorz.nitka@intel.com,
 aleksandr.loktionov@intel.com, alexander.nowlin@intel.com,
 anthony.l.nguyen@intel.com, maciej.machnikowski@intel.com,
 przemyslaw.korba@intel.com, sergey.temerkhanov@intel.com,
 arkadiusz.kubalewski@intel.com, richardcochran@gmail.com, horms@kernel.org
Date: Sun, 25 Oct 2026 23:44:00 +0000
Message-ID: <179297184040.3134.16872406836500329599@kernel.org>
In-Reply-To: =?utf-8?q?=3C20261021-jk-e825c-timestamp-processing-logic-fixes?=
 =?utf-8?q?-srcu-v5-8-72289a4ac8eb=40intel=2Ecom=3E?=
References: =?utf-8?q?=3C20261021-jk-e825c-timestamp-processing-logic-fixes-?=
 =?utf-8?q?srcu-v5-8-72289a4ac8eb=40intel=2Ecom=3E?=
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

- [Low] The commit message for "ice: E825: stop clearing
  PHY_REG_TX_OFFSET_READY" names a Tx tracker field that does not exist.

--

ice: E825: stop clearing PHY_REG_TX_OFFSET_READY

On E825, ice_stop_phy_timer_eth56g() no longer clears
PHY_REG_TX_OFFSET_READY. Clearing it left the hardware's outstanding Tx
timestamp counter out of sync. Instead, new Tx timestamp requests are
blocked in software while the PHY is stopped or restarting, and
ice_ptp_mark_tx_tracker_stale() now checks tx->init.

> Now that we do not clear the PHY_REG_TX_OFFSET_READY, new timestamp
> requests could happen while the PHY is calibrating. To avoid this, set the
> tx.calibrating field of the Tx timestamp tracker when stopping the timer
> and clear it when finishing the restart.

[ ... ]

> Unlike E822 devices, set the calibrating flag when "stopping" the PHY and
> clear it immediately after the start procedure.

[ ... ]

> In the event that the PHY timer start procedure fails, the device is in an
> unknown state and timestamps will not behave properly. As such, and similar
> to E822 devices, the calibrating field is not cleared on failure.

[Severity: Low]
Should these references to tx.calibrating say tx.disabled instead?

struct ice_ptp_tx in ice_ptp.h has no calibrating member. Its bitfields
are:

	u8 init : 1;
	u8 disabled : 1;
	u8 has_ready_bitmap : 1;

The new E825 code in ice_ptp_port_phy_stop() and
ice_ptp_port_phy_restart() sets and clears ptp_port->tx.disabled:

	spin_lock_irqsave(&ptp_port->tx.lock, flags);
	ptp_port->tx.disabled = true;
	spin_unlock_irqrestore(&ptp_port->tx.lock, flags);

ice_ptp_wait_for_offsets() uses the same field for E82x, and the
kernel-doc update in this patch is for @disabled.

The behaviour the commit message describes matches the code. Only the
field name is wrong.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261021-jk-e825c-timestamp-processing-logic-fixes-srcu-v5-0-72289a4ac8eb%40intel.com
