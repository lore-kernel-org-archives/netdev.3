Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E31D3B3C14;
	Tue, 18 Aug 2026 17:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787072969; cv=none; b=VB45aq3yQxziztf2fAUITSrqf1/fhO6VnLGq8p0TeAeLuxmrN6EVZGv3k3/1R3gUBMs+8mlVvdKGJat6MnRJYy8m4bEBs+oEjmCy4IcJKupm6E7B3aFznMVL2jS4vkgQZwhXpzrX7GNQqMqZUeRBohkEcaG6A2GvcqjrDdEsoiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787072969; c=relaxed/simple;
	bh=0M4sfICO74xi4cIKm4eS/rGTtT8/HkaYeLryq+XdBXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q7bT7EuUacKn0R0aBaFxgjnMcjc3xw3Yd/MmBE621Osx19S7lE+jeKMfxGjEhendlYwKNUwi85NG33GYJotIOuYEcTM6GzpO675VkbhHGlkAnYESjriD9cUhSEz4MZ0TVYpDEetI2CiCAnzWMFKdBdcepKFziHj4292lgSKFOEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IWuG8WX3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IWuG8WX3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D4D01F000E9;
	Tue, 18 Aug 2026 17:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787072967;
	bh=9byILTCgvGkX+4b/fusPq4En9ZqkB5ST8chwNivfZ1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IWuG8WX3bPbIPs5uBfTetEhOZjgCv9r1K45vn3LRAPGruNIJDYh7DNaL7FjaXoIiH
	 WeJmaT4AHlBC4gToRUveJRJSr31EV8DvumTcUOgdJAxKD3TdWu6eG5AA3pKmc9palF
	 +A5OM2f37t1zU2tKvmhe/15jySVR3Wa3DtmQjM1LFfqWqFpZFn+PLNlSuYFngpfT86
	 NWMnTrw2QDl5fWpTMDp1fHlKTFmohoCjSKeUH9ZzDoXbSom4ZduGeiXjL0NMI89lS4
	 W0X6f0R8ZZ52fTmW2hsSnRzTwdc9OW6+lUU8ayMkFYxGcwuIIZFD+Uw2ugnr/mXtP4
	 3+miN7ZAVE4wQ==
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
Subject: Re: [PATCH net-next v4 1/3] net: wwan: core: propagate modem control signals to port drivers
Date: Tue, 18 Aug 2026 10:09:26 -0700
Message-ID: <20260818170926.4019431-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260816121705.858013-2-peter.hunt@opengear.com>
References: <20260816121705.858013-2-peter.hunt@opengear.com>
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
net: wwan: core: propagate modem control signals to port drivers

Adds an optional ->dtr_rts(port, on) callback to struct wwan_port_ops so
port drivers learn when the host asserts or drops DTR/RTS.  The wwan core
keeps tracking the TIOCM bitmask in port->at_data.mdmbits and now calls the
new op from the TIOCMSET/TIOCMBIC/TIOCMBIS ioctls as well as on first open
and last close of an AT port.

A few questions below.

> diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
> index ffbcf11e4e681..90ca85a63b5a3 100644
> --- a/drivers/net/wwan/wwan_core.c
> +++ b/drivers/net/wwan/wwan_core.c
> @@ -759,8 +759,17 @@ static int wwan_port_op_start(struct wwan_port *port)
>  	if (!port->start_count)
>  		ret = port->ops->start(port);
>  
> -	if (!ret)
> +	if (!ret) {
>  		port->start_count++;
> +		/* Mirror TTY semantics: raise DTR/RTS on first open of an AT port */
> +		if (port->start_count == 1 && port->type == WWAN_PORT_AT &&
> +		    port->ops->dtr_rts) {
> +			mutex_lock(&port->data_lock);
> +			port->at_data.mdmbits |= TIOCM_DTR | TIOCM_RTS;
> +			mutex_unlock(&port->data_lock);
> +			port->ops->dtr_rts(port, true);
> +		}
> +	}
>  
>  out_unlock:
>  	mutex_unlock(&port->ops_lock);
> @@ -773,6 +782,13 @@ static void wwan_port_op_stop(struct wwan_port *port)
>  	mutex_lock(&port->ops_lock);
>  	port->start_count--;
>  	if (!port->start_count) {
> +		/* Mirror TTY semantics: drop DTR/RTS on last close of an AT port */
> +		if (port->ops && port->type == WWAN_PORT_AT && port->ops->dtr_rts) {
> +			mutex_lock(&port->data_lock);
> +			port->at_data.mdmbits &= ~(TIOCM_DTR | TIOCM_RTS);
> +			mutex_unlock(&port->data_lock);
> +			port->ops->dtr_rts(port, false);
> +		}

[Severity: Low]
Can the dtr_rts(true) issued by wwan_port_op_start() go unmatched when the
port is removed while an fd is still open?  wwan_remove_port() does not go
through wwan_port_op_stop():

drivers/net/wwan/wwan_core.c:wwan_remove_port() {
	mutex_lock(&port->ops_lock);
	if (port->start_count) {
		port->ops->stop(port);
		port->start_count = 0;
	}
	port->ops = NULL; /* Prevent any new port operations (e.g. from fops) */
	mutex_unlock(&port->ops_lock);
	...
}

So ->dtr_rts(port, false) is never called and at_data.mdmbits keeps
TIOCM_DTR|TIOCM_RTS visible to TIOCMGET on the still-open fd.

The later close() cannot repair it either, since the unconditional
port->start_count-- in wwan_port_op_stop() underflows the already-zeroed
unsigned counter to UINT_MAX and the new de-assert block sits inside
if (!port->start_count).  The underflow itself isn't introduced by this
patch, but the new assert/de-assert pair inherits it.

Would it make sense to call ->dtr_rts(port, false) (and clear mdmbits) in
the same branch of wwan_remove_port() that calls ->stop(), or to document
that ->stop() implies de-assert?

>  		if (port->ops)
>  			port->ops->stop(port);
>  		skb_queue_purge(&port->rxq);
> @@ -980,6 +996,8 @@ static long wwan_port_fops_at_ioctl(struct wwan_port *port, unsigned int cmd,
>  				    unsigned long arg)
>  {
>  	int ret = 0;
> +	bool call_dtr_rts = false;
> +	bool dtr_on = false;
>  
>  	mutex_lock(&port->data_lock);
>  
> @@ -1036,6 +1054,10 @@ static long wwan_port_fops_at_ioctl(struct wwan_port *port, unsigned int cmd,
>  			port->at_data.mdmbits |= mdmbits;
>  		else
>  			port->at_data.mdmbits = mdmbits;
> +		if (port->type == WWAN_PORT_AT) {
> +			dtr_on = !!(port->at_data.mdmbits & TIOCM_DTR);
> +			call_dtr_rts = true;
> +		}

[Severity: Medium]
Does this drive RTS in the opposite direction of what userspace asked for?

The kernel-doc added to struct wwan_port_ops says the boolean asserts or
de-asserts "the DTR and RTS modem control lines", and the two call sites in
wwan_port_op_start()/wwan_port_op_stop() do treat the pair together
(TIOCM_DTR | TIOCM_RTS).  Here the boolean is derived from the DTR bit
alone, and the TIOCM_RTS bit the caller just changed is dropped.

The first in-tree implementer added later in this series expands the boolean
back to both lines:

drivers/net/wwan/mhi_wwan_ctrl.c:mhi_wwan_ctrl_dtr_rts() {
	mhi_wwan_ctrl_send_dtr(wwan_port_get_drvdata(port),
			       on ? TIOCM_DTR | TIOCM_RTS : 0);
}

so on an AT port:

  TIOCMBIS(TIOCM_RTS) with DTR clear   -> mdmbits shows RTS set,
                                          dtr_rts(false) clears RTS on the wire
  TIOCMBIC(TIOCM_RTS) with DTR set     -> mdmbits clears RTS,
                                          dtr_rts(true) re-asserts RTS
  TIOCMBIC(TIOCM_DTR) with RTS set     -> both lines dropped while TIOCMGET
                                          still reports TIOCM_RTS

TIOCMGET then reports a state that contradicts what the driver was last told
to drive, and nothing re-synchronises the two until some later ioctl happens
to change DTR.  The commit message does say "The boolean passed reflects DTR
only", but should the kernel-doc say the same thing, or should the op carry
the bitmask so RTS can be driven independently?

>  		break;
>  	}
>  
> @@ -1061,6 +1083,13 @@ static long wwan_port_fops_at_ioctl(struct wwan_port *port, unsigned int cmd,
>  
>  	mutex_unlock(&port->data_lock);
>  
> +	if (call_dtr_rts) {
> +		mutex_lock(&port->ops_lock);
> +		if (port->ops && port->ops->dtr_rts)
> +			port->ops->dtr_rts(port, dtr_on);
> +		mutex_unlock(&port->ops_lock);
> +	}
> +

[Severity: Medium]
Can two concurrent TIOCM ioctls leave mdmbits and the line state
permanently inconsistent here?

port->at_data.mdmbits is updated and dtr_on is sampled under data_lock, but
the callback is issued after data_lock is dropped and ops_lock is taken, so
the two updates happen in disjoint critical sections under different
mutexes.  The handler is registered as .unlocked_ioctl in wwan_port_fops, so
two threads (or two fds) can be inside wwan_port_fops_at_ioctl() at once:

CPU0: TIOCMBIC(TIOCM_DTR)
	port->at_data.mdmbits &= ~TIOCM_DTR;
	dtr_on = false;
	mutex_unlock(&port->data_lock);
	/* preempted before taking ops_lock */

CPU1: TIOCMBIS(TIOCM_DTR)
	port->at_data.mdmbits |= TIOCM_DTR;
	dtr_on = true;
	mutex_unlock(&port->data_lock);
	port->ops->dtr_rts(port, true);

CPU0 resumes:
	port->ops->dtr_rts(port, false);

Final state: TIOCMGET reports TIOCM_DTR asserted while the driver was last
told to de-assert DTR, which is the exact condition the patch is meant to
fix (modem withholds URCs while userspace believes DTR is raised).

The commit message's justification, "the ->dtr_rts call is made after
releasing data_lock and re-acquiring ops_lock so that it is serialised
against port removal", covers port->ops becoming NULL but not the ordering
of the bitmask and the line.  Would re-reading mdmbits under data_lock while
holding ops_lock work, i.e. nesting data_lock inside ops_lock as
wwan_port_op_start()/wwan_port_op_stop() already do in this same patch?

>  	return ret;
>  }
>  
> diff --git a/include/linux/wwan.h b/include/linux/wwan.h
> index 1e0e2cb535799..a7684950d73b0 100644
> --- a/include/linux/wwan.h
> +++ b/include/linux/wwan.h
> @@ -57,6 +57,8 @@ struct wwan_port;
>   * @tx_blocking: Optional blocking routine that sends WWAN port protocol data
>   *               to the device.
>   * @tx_poll: Optional routine that sets additional TX poll flags.
> + * @dtr_rts: Optional routine that asserts (on=true) or de-asserts (on=false)
> + *           the DTR and RTS modem control lines.

[Severity: Low]
Should this note that the op is only ever invoked for WWAN_PORT_AT?

All three new call sites in wwan_core.c are gated on
port->type == WWAN_PORT_AT, but the TIOCM emulation they hook into is shared
with QCDM ports:

drivers/net/wwan/wwan_core.c:wwan_port_fops_ioctl() {
	if (port->type == WWAN_PORT_AT || port->type == WWAN_PORT_QCDM) {
		/* AT and QCDM port specific IOCTLs */
		res = wwan_port_fops_at_ioctl(port, cmd, arg);
	...
}

For a QCDM port the core still mutates port->at_data.mdmbits on
TIOCMSET/TIOCMBIC/TIOCMBIS but never calls ->dtr_rts, so a QCDM driver that
implements the documented callback gets a hook that never fires while the
TIOCMGET-visible state drifts from the hardware.

Cross-instance finding from sashiko-gemini (1f1883cdaae2b1f372b000af391d04e91947cf2c647012be2e4aa3916c3a8822):
[Severity: Medium]
TTY emulation behavior for `TIOCMGET` incorrectly depends on the hardware driver's implementation of `dtr_rts`
-- 
pw-bot: cr
