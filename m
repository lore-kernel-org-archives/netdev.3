Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C2612C534;
	Mon,  5 Oct 2026 21:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791234200; cv=none; b=VIvBGGblHjERTaVyDfmrcsmn5/7oBDoxCAmfyByLvQAfaksv5wRS3dP7F0wak4C/hN4xhfFnVBxBfzPUOOGi1xUp0N0lNn9O9dOakZlSDWnjvy2LrqkdBSkFw3mWzdERwr1pF8u01I+8ecZfYCSlFwc7gr8mn4IIigSW8dI3z00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791234200; c=relaxed/simple;
	bh=/bCATJHWAqNlcQ/KaREYE1iU9INbtNFH965NeT7G1Ng=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gQP3p5BuCuH1sTddtLueasygWbOvdTo30ES9LYdZLv/4XAWX5u1w4ut0Lt7Atbo/aACqeMQKajlA8qh4rzDHWcaaS41qhRywx0SPXV0sMuC/eGJKFFDOjVY6W6nniVbjW2nWEaYJ0mVkTxb76JhKzQL2pT1PHLU91KPrYUP24VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eRQr/Fsb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eRQr/Fsb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E98DF1F000FF;
	Mon,  5 Oct 2026 21:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791234198;
	bh=1tsZKeQEmPb9f2ieMeoLIoZq6tU11UgwZYXpshglJUE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=eRQr/Fsbp78PsFbHKmoRX2ShW1lkv+iFs6F8Q/S1iNITHTmBd2h97kaow5p+mOq8J
	 cbel4JyhflmowUPihA58PIZnZ3jsr5WkKJSDYYkvCprNmRo5JtjV/wHE/Wc6WFGw7z
	 sEzwONH+8GMXuun27xvF7bqS+2PDh3Ha8n/xt/i2R6Coyn547vycaNtSBYVwHsDNv3
	 KcS6AJMQ4D5oztUVGLoVQcFXD1XOqvwOx2e4YVdJFgWD6TmcC/Ba//TaQZynV0qaP6
	 wd5ENTTGEtPsiglbr2LsJUP+G5SrttpNRNjiHCkzOY3HitevnopD/DC5Atzyjkmqvp
	 MLGA8BHVsWrNA==
Subject: Re: [PATCH net-next v6 1/2] net: wwan: core: propagate modem control
 signals to port drivers
From: netdev-bot+sashiko@kernel.org
To: peter.hunt@opengear.com
Cc: loic.poulain@oss.qualcomm.com, ryazanov.s.a@gmail.com,
 johannes@sipsolutions.net, mani@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 05 Oct 2026 21:03:17 +0000
Message-ID: <179123419746.434549.9037062792939057692@kernel.org>
In-Reply-To: <20261001204614.3481089-2-peter.hunt@opengear.com>
References: <20261001204614.3481089-2-peter.hunt@opengear.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] wwan_port_op_stop() always clears TIOCM_DTR|TIOCM_RTS and
  calls ->dtr_rts() on the last close of an AT port.
- [Low] wwan: inconsistent dtr_rts() bitmask during wwan_remove_port()

--

net: wwan: core: propagate modem control signals to port drivers

This adds an optional ->dtr_rts() operation to struct wwan_port_ops. The
wwan core calls it when the TIOCM bits of an AT port change through the
ioctl path. The core also raises DTR/RTS on first open and drops them on
last close or port removal, which the commit message describes as
mirroring TTY semantics.

> diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
> index ffbcf11e4e681..d201d395a0031 100644
> --- a/drivers/net/wwan/wwan_core.c
> +++ b/drivers/net/wwan/wwan_core.c

[ ... ]

> @@ -773,6 +791,16 @@ static void wwan_port_op_stop(struct wwan_port *port)
>  	mutex_lock(&port->ops_lock);
>  	port->start_count--;
>  	if (!port->start_count) {
> +		/* Mirror TTY semantics: drop DTR/RTS on last close of an AT port */
> +		if (port->ops && port->type == WWAN_PORT_AT && port->ops->dtr_rts) {
> +			unsigned int bits;
> +
> +			mutex_lock(&port->data_lock);
> +			port->at_data.mdmbits &= ~(TIOCM_DTR | TIOCM_RTS);
> +			bits = port->at_data.mdmbits;
> +			mutex_unlock(&port->data_lock);
> +			port->ops->dtr_rts(port, bits);
> +		}

[Severity: Low]
In wwan_remove_port(), port->at_data.mdmbits is updated by clearing
only TIOCM_DTR and TIOCM_RTS. However, ->dtr_rts() is then called with
a literal 0 rather than the resulting bitmask.

The new kernel-doc says the driver receives @mdmbits as a TIOCM_*
bitmask that the modem control lines should match.
wwan_port_op_stop() follows that contract: it snapshots the masked
value under data_lock and passes it on.

Here the driver is told that every bit is clear. Meanwhile the core's
copy still carries whatever else userspace set through TIOCMSET or
TIOCMBIS.

The commit message describes this as mirroring the last-close
de-assert path, but the two paths now give the driver different
values for the same event. The practical impact is small, since the
port is being removed. Still, a driver that derives its state from
the bitmask, as the kernel-doc invites it to, will see one value on
hot-unplug and another on close.

Should this pass the masked port->at_data.mdmbits, snapshotted under
data_lock, as wwan_port_op_stop() does? A small shared helper for the
drop path might keep the two from drifting apart.

[Severity: Medium]
The comment and commit message say this mirrors TTY semantics. Does that
hold for the close path?

In the TTY core, tty_port_shutdown() lowers DTR/RTS only when HUPCL is
set:

drivers/tty/tty_port.c:tty_port_shutdown() {
    ...
	if (tty && C_HUPCL(tty))
		tty_port_lower_dtr_rts(port);
    ...
}

The wwan core already saves termios in port->at_data.termios through
TCSETS/TCSETS2. However, wwan_port_op_stop() never checks c_cflag for
HUPCL. As a result, DTR is dropped on every last close of an AT port, and
userspace cannot prevent this by clearing HUPCL.

Before this series, closing a WWAN AT port never changed the modem's DTR
state. With the follow-up mhi_wwan_ctrl patch, the drop reaches Qualcomm
SDX55/SDX65 modems as an IP_CTRL host-state message with DTR=0.

Take a DUN port with a PPP or circuit-switched call up, on a modem
configured with AT&D1 or AT&D2. Could closing the last fd then put the
modem into command mode or hang up the call, even after HUPCL was cleared
with TCSETS?

Should this path check HUPCL in port->at_data.termios.c_cflag before it
clears TIOCM_DTR and TIOCM_RTS and calls ->dtr_rts()?

>  		if (port->ops)
>  			port->ops->stop(port);
>  		skb_queue_purge(&port->rxq);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261001204614.3481089-1-peter.hunt%40opengear.com
