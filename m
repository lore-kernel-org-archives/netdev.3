Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793400028;
	b=dhwyeP5/m3w5jXL7AtmGi66xaC7/PEOD63GCUdADKEAeBB/jVLDs23PMZO4ED1JnsYzR
	 99Asimw/8TEBqQ9ozu8BfM4oC6EbJDJtzPoHl/LrL51QtAKwYc4lyasQPgUVOaTmvATmC
	 kSu/++VGjUYx8YuRjdyqjP5QxPEZmffZQDy1xPAPHtsyf/j4GD7ebhbb4YKV72PiStZG/
	 MGNwW1XTkYWEg8kDAKUh9bPiSoOHahj5xiDTpCQQGNaZ/9zcM0kIZmaAOkRTMzWsR/+ZG
	 7rn3MttsyVW3W23Y8N15U3oPeOWMzaOMTqlB5tivsZPGr+hA7reQzeClpMhNvYz2WFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793400028;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=xMKFo9NeAp6VSM4Q6y13qEB/LpKXUGXdFSRrfyC/258=;
	b=sStzMlejKqGlwXeELQQwulUI6yxwf2Z85izbXpio24szFOpTqKsSAETtelZDi0qt8O8h
	 I4lY5xn5y5apDyoNohOno6y/ZdS/W/UYWyEsH6BsoNninAYC4kOY8syFtgFwcldd0/4fg
	 xNH+cOFryvuNV0PWWrJJGZUOVTF2xyuNYf0Y9uYAgSnIeNOzZE6dICqHzPKB7D6UjHlcP
	 YZcmB7P5HJdUsuDtjg8CIrxHcnp0+9K1pjLxD9oQcqNtdXnzIm4zFyQwK/pnXS2QXu5jg
	 5gIBVx3bjqpxI0rYjKEnBsGx0GeRTuakbpBakKBK/3VZFufdVA+uxzcnsRQ26RB3E+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F589kPpg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6494C60A2603;
	Fri, 30 Oct 2026 22:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F589kPpg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68D7D1F00A02;
	Fri, 30 Oct 2026 22:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793400028;
	bh=xMKFo9NeAp6VSM4Q6y13qEB/LpKXUGXdFSRrfyC/258=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=F589kPpgEFOTS7Nkeqt0YRYTiWCWHSmfk8NtAG5GeDDrv7v/lsRc6veL2ID7lGfvW
	 pfyNHWyAFlOILoKY9HNjBkLOYwd1UXXfBTSPaYKAsEcrEOBn+Rs40LPUbrRtnkok5S
	 H+5eHQEIPxYIv/2Xl5Qr6RoBXY7U8DXndbfEczBeRDYJSUG4eaF68yKQr+o4Dks0J+
	 7JS+2nfGFNdYccw3j0nMRxQ0GxkBbLVEfuK59LA65aHuAeA5XvpiNe0en2w73KK2KP
	 DQTjuixBCUxbZnNPHNcBqwB/o3EDQvDwxR18ger8fS1NziHYZOwHR1exDiZxNvZBma
	 ntKIc7hDG1FUg==
Subject: Re: [PATCH net v2] net: wwan: mhi_wwan_ctrl: send a DTR drop before
 it can be coalesced
From: netdev-bot+sashiko@kernel.org
To: peter.hunt@opengear.com
Cc: netdev@vger.kernel.org, loic.poulain@oss.qualcomm.com,
 ryazanov.s.a@gmail.com, johannes@sipsolutions.net, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 dnlplm@gmail.com, linux-kernel@vger.kernel.org
Date: Fri, 30 Oct 2026 22:40:27 +0000
Message-ID: <179340002701.3131.15535297427661129303@kernel.org>
In-Reply-To: <20261027171055.1796482-1-peter.hunt@opengear.com>
References: <20261027171055.1796482-1-peter.hunt@opengear.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The fix still loses a DTR drop when the transport refuses it.
- [Low] Two existing comments in drivers/net/wwan/mhi_wwan_ctrl.c no
  longer match the code after this patch.

--

net: wwan: mhi_wwan_ctrl: send a DTR drop before it can be coalesced

This patch flushes the DTR/RTS work item in mhi_wwan_ctrl_dtr_rts() when
DTR goes from high to low. The aim is to keep a following raise from
coalescing the drop away. It also flushes the work in mhi_wwan_ctrl_stop()
so that pending state is sent before the channel is stopped.

> diff --git a/drivers/net/wwan/mhi_wwan_ctrl.c b/drivers/net/wwan/mhi_wwan_ctrl.c
> index e3c2075889565..7723199278671 100644
> --- a/drivers/net/wwan/mhi_wwan_ctrl.c
> +++ b/drivers/net/wwan/mhi_wwan_ctrl.c
> @@ -209,9 +209,17 @@ static void mhi_wwan_ctrl_dtr_work(struct work_struct *work)
>  static void mhi_wwan_ctrl_dtr_rts(struct wwan_port *port, unsigned int mdmbits)
>  {
>  	struct mhi_wwan_dev *mhiwwan = wwan_port_get_drvdata(port);
> +	bool drop = (READ_ONCE(mhiwwan->dtr_mdmbits) & TIOCM_DTR) &&
> +		    !(mdmbits & TIOCM_DTR);
>  
>  	WRITE_ONCE(mhiwwan->dtr_mdmbits, mdmbits);
>  	schedule_delayed_work(&mhiwwan->dtr_work, 0);
> +
> +	/* A DTR drop matters on its own, e.g. to hang up a modem set to AT&D2,
> +	 * so send it now rather than let a following raise coalesce it away
> +	 */
> +	if (drop)
> +		flush_delayed_work(&mhiwwan->dtr_work);
>  }

[Severity: Medium]
Can the drop still be lost if the first send attempt fails? On a transient
error, mhi_wwan_ctrl_dtr_work() re-arms itself:

    ret = mhi_wwan_ctrl_send_dtr(mhiwwan, READ_ONCE(mhiwwan->dtr_mdmbits));
    if (ret == -EAGAIN || ret == -ENOMEM)
        schedule_delayed_work(&mhiwwan->dtr_work, msecs_to_jiffies(10));

mhi_queue() returns -EAGAIN when the IP_CTRL UL ring is full. -ENOMEM comes
from the dtr_msg allocation in mhi_wwan_ctrl_send_dtr().

flush_delayed_work() only waits for the instance it queued itself. Its
kernel-doc says it "only considers the last queueing instance". So it
returns after one failed attempt, and the 10ms retry timer is still armed.

>From userspace on the AT port, the sequence would be:

TIOCMBIC(DTR)
  mhi_wwan_ctrl_dtr_rts(port, 0)
    drop = true
    flush_delayed_work()
      mhi_wwan_ctrl_dtr_work() -> -EAGAIN, re-arms 10ms timer

TIOCMBIS(DTR)
  mhi_wwan_ctrl_dtr_rts(port, DTR|RTS)
    drop = false, since dtr_mdmbits is already 0
    WRITE_ONCE(mhiwwan->dtr_mdmbits, DTR|RTS)
    schedule_delayed_work(..., 0) is a no-op, work is already pending

10ms later
  mhi_wwan_ctrl_dtr_work() sends DTR|RTS

Wouldn't the modem then see only the raise? That is the case this patch is
meant to fix. drop is computed against the last requested state, not the
last state that was actually sent.

The commit message says a drop that hits a full UL ring "is still retried
with whatever state is latest by then". The new comment says the drop is
sent "now rather than let a following raise coalesce it away".

Would it be better to keep track of an unsent drop until the transport
accepts it? One option is a drop-pending flag that dtr_work sends before the
latest state. Otherwise, the comment could say this is best effort.

[ ... ]

> @@ -246,6 +254,9 @@ static void mhi_wwan_ctrl_stop(struct wwan_port *port)
>  
>  	cancel_work_sync(&mhiwwan->rx_refill);
>  
> +	/* Send any pending DTR/RTS state before the channel stops */
> +	flush_delayed_work(&mhiwwan->dtr_work);
> +
>  	mhi_unprepare_from_transfer(mhiwwan->mhi_dev);
>  }

The same limitation applies to this flush. After one failed attempt,
mhi_unprepare_from_transfer() runs while the 10ms retry is still armed.

On a plain last close nothing cancels that retry. disable_delayed_work_sync()
is only called from mhi_wwan_ctrl_remove().

Could the DTR message then be queued after the channel named in its dest_id
has been stopped? Could it race with a later reopen?

[Severity: Low]
This isn't a bug, but two existing comments in mhi_wwan_ctrl.c no longer
match the code after this change.

The struct mhi_wwan_dev comment still describes pure coalescing:

	/* Latest DTR/RTS state for the modem, sent from dtr_work so a burst of
	 * changes is coalesced and only the final state has to get through
	 */

mhi_wwan_ctrl_dtr_rts() now flushes each DTR drop so that it is not
coalesced.

mhi_wwan_ctrl_remove() has this comment:

	wwan_remove_port(mhiwwan->wwan_port);
	/* Give the DTR/RTS drop from removal one attempt, then stop the work */
	flush_delayed_work(&mhiwwan->dtr_work);

When start_count is set, wwan_remove_port() calls
wwan_port_drop_dtr_rts(port, false) and then port->ops->stop(). After this
patch both of those paths flush dtr_work, so a removal drop can be tried up
to three times.

Should these two comments be updated to match?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261027171055.1796482-1-peter.hunt%40opengear.com
