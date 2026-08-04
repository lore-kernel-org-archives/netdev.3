Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8749E2DF132;
	Tue,  4 Aug 2026 01:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785808557; cv=none; b=bL7nKv/foIZaTXyrTTiJjiSztDVoU/K/VHOkvF9ZwEsm9pRFdFwknuMsoXGf15hlnn++/v6utTABUfJupLjdv/CePcMuqKXk60UUBJgERUPr8hy1v3FXG0V7eJZSFvsFrIT8QRjKFUNtF86673jaZmQuignYzZeJmNm+buuJSrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785808557; c=relaxed/simple;
	bh=DUg0rv0jTYhujFDz1jgpvjK7v97ovv6zvnUsjUVQHB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LQd/a5jbadv9txdFqmGOakwIK4v3YYE9c5BtwNpEe2omF6H2pBGEJWsf720vISjdkYE91wV6gU0RYbtwUWryVw/XyyykCSzcPpYPcofXiwSxwoNhUDtzVhOWVSWBoGn46su4qCN8rvvicXKGwleton2EQjAEOCMCBf2pJGgWses=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cJ+/4h4n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cJ+/4h4n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7B381F000E9;
	Tue,  4 Aug 2026 01:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785808556;
	bh=g4K9MOpy1qJIJEehjHf2KBECn9hyc0IvRb3u+wdSoKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cJ+/4h4n6UA3JPhe+5nO0YO+bLy1xkch2XPCCi9JWML7TMrYExulJU4DmvdoJm7Pz
	 06aRtQ4vdaqYaoB/FQdXTAJ1N+sCELgl3UJkUk6Ptr995m7nsJM5H/N42Yu88o7+fI
	 pu0BaLlqZOAPhCTsU86zd39ozfXA8xZI+9Wz7Gn+lTQ7xotHRH/vB29cFXqmrFb13W
	 6EWbRy/nYDKjLvCSABE4wt2wtyMsVPVxNwHKtVgiXYRd0e4qG0Uz7pwH12uJWeCaDa
	 5Xppn6/0SVwyhixUIOBJdqQFLhCiZevhsGaEm98U19pHarHvyHk6WWQxsVv6e/MaYD
	 g82L6dmuZz0bQ==
From: Jakub Kicinski <kuba@kernel.org>
To: l1138897701@163.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] sctp: sm_statefuns: Fix zero window detection in T3 timeout handling
Date: Mon,  3 Aug 2026 18:55:55 -0700
Message-ID: <20260804015555.2548414-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260730063344.770679-1-l1138897701@163.com>
References: <20260730063344.770679-1-l1138897701@163.com>
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
--- Patch [1]: [PATCH net] sctp: sm_statefuns: Fix zero window detection in T3 timeout handling ---
commit e24cf7acae572e3936b6d8fbcb1d3942444ce068
Author: Qing Luo <luoqing@kylinos.cn>

sctp: sm_statefuns: Fix zero window detection in T3 timeout handling

This drops the asoc->state == SCTP_STATE_SHUTDOWN_PENDING qualifier from
the zero-window branch of sctp_sf_do_6_3_3_rtx(), so the T5 shutdown
guard timer is now started whenever asoc->peer.zero_window_announced is
set, in any state that dispatches the T3-rtx timeout.

No Link: tags were present in the commit header.

> diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
> index 708fa07d5fffc..b01db33bbc360 100644
> --- a/net/sctp/sm_statefuns.c
> +++ b/net/sctp/sm_statefuns.c
> @@ -5842,8 +5842,7 @@ enum sctp_disposition sctp_sf_do_6_3_3_rtx(struct net *net,
>  	SCTP_INC_STATS(net, SCTP_MIB_T3_RTX_EXPIREDS);
>  
>  	if (asoc->overall_error_count >= asoc->max_retrans) {
> -		if (asoc->peer.zero_window_announced &&
> -		    asoc->state == SCTP_STATE_SHUTDOWN_PENDING) {
> +		if (asoc->peer.zero_window_announced) {

[Severity: High]
[Finding: main-1-0]
[Sources: opus-5]

Is the T5 timer actually handled in the states this now arms it in?

sctp_sf_do_6_3_3_rtx() runs in COOKIE_ECHOED, ESTABLISHED,
SHUTDOWN_PENDING and SHUTDOWN_RECEIVED per the T3-rtx table in
net/sctp/sm_statetable.c:

  #define TYPE_SCTP_EVENT_TIMEOUT_T3_RTX { \
        ...
        /* SCTP_STATE_ESTABLISHED */ \
        TYPE_SCTP_FUNC(sctp_sf_do_6_3_3_rtx), \

But the T5 table in the same file dispatches the expiry to
sctp_sf_timer_ignore() for exactly the extra states this patch adds:

  #define TYPE_SCTP_EVENT_TIMEOUT_T5_SHUTDOWN_GUARD { \
        ...
        /* SCTP_STATE_COOKIE_ECHOED */ \
        TYPE_SCTP_FUNC(sctp_sf_timer_ignore), \
        /* SCTP_STATE_ESTABLISHED */ \
        TYPE_SCTP_FUNC(sctp_sf_timer_ignore), \
        /* SCTP_STATE_SHUTDOWN_PENDING */ \
        TYPE_SCTP_FUNC(sctp_sf_t5_timer_expire), \
        ...
        /* SCTP_STATE_SHUTDOWN_RECEIVED */ \
        TYPE_SCTP_FUNC(sctp_sf_timer_ignore), \

So in ESTABLISHED the "one last chance ... before aborting" described by
the retained comment never happens, since sctp_sf_timer_ignore() only
returns SCTP_DISPOSITION_CONSUME.

Does this remove the Association.Max.Retrans enforcement for those
states?  The else branch, which is the only place that does
SCTP_CMD_SET_SK_ERR(ETIMEDOUT) + SCTP_CMD_ASSOC_FAILED and returns
SCTP_DISPOSITION_DELETE_TCB, is now skipped whenever
zero_window_announced is set.  Each later T3-rtx expiry still sees
overall_error_count >= max_retrans, so it only queues STRIKE + RETRAN
and re-arms the (no longer pending) T5, because
sctp_cmd_interpreter() in net/sctp/sm_sideeffect.c re-arms on
SCTP_CMD_TIMER_START_ONCE whenever the timer is not pending:

  case SCTP_CMD_TIMER_START_ONCE:
        timer = &asoc->timers[cmd->obj.to];

        if (timer_pending(timer))
                break;
        fallthrough;

Can the sender then retransmit indefinitely with no error reported to
the application, keeping the association, its outqueue chunks, sndbuf
charge, transports and socket pinned?

Note the flag that now solely decides abort vs. no abort comes straight
from the remote peer, in sctp_outq_sack():

  asoc->peer.zero_window_announced = !sack_a_rwnd;

so a peer that announces a_rwnd == 0 and then goes silent controls the
trigger.

The heartbeat path sctp_sf_sendbeat_8_3() is the only remaining
teardown for this condition, and it looks deferrable: every
retransmission refreshes transport->last_time_sent in net/sctp/outqueue.c,
while sctp_generate_heartbeat_event() keeps rescheduling instead of
feeding the state machine:

  elapsed = jiffies - transport->last_time_sent;
  timeout = sctp_transport_timeout(transport);
  if (elapsed < timeout) {
          elapsed = timeout - elapsed;
          if (!mod_timer(&transport->hb_timer, jiffies + elapsed))
                  sctp_transport_hold(transport);
          goto out_unlock;
  }

Since sctp_transport_timeout() is rto/2 + hbinterval, does any
configuration with hbinterval > rto/2 (for example the default 30 s
hbinterval with net.sctp.rto_max lowered, or hbinterval raised via
net.sctp.hb_interval or SCTP_PEER_ADDR_PARAMS) push the heartbeat event
out forever so no abort ever occurs?

[Severity: High]
[Finding: main-1-2]
[Sources: opus-5]

Should the matching cancel site be updated too?  The only place that
stops T5 on forward progress is still state-qualified, in
sctp_check_transmitted() in net/sctp/outqueue.c:

  if (asoc->state == SCTP_STATE_SHUTDOWN_PENDING &&
      timer_delete(&asoc->timers[SCTP_EVENT_TIMEOUT_T5_SHUTDOWN_GUARD]))
                  sctp_association_put(asoc);

A T5 armed while ESTABLISHED is therefore not disarmed when the peer
reopens its window and acknowledges data: sctp_check_transmitted()
clears transport->error_count and asoc->overall_error_count but skips
the timer_delete() because the state is not SHUTDOWN_PENDING.  The
remaining SCTP_CMD_TIMER_STOP(T5) sites in net/sctp/sm_statefuns.c are
ABORT/close handlers, and the T5 SCTP_CMD_TIMER_RESTART lives only in
sctp_sf_do_9_2_start_shutdown(), which is not reached with a non-empty
outqueue.

The timer then stays pending with its ESTABLISHED-era deadline
(asoc->timeouts[T5] is 5 * rto_max, 300 s by default).  If the
application later calls shutdown()/close() with data still queued,
sctp_sf_do_9_2_prm_shutdown() moves to SHUTDOWN_PENDING without
touching T5:

  sctp_add_cmd_sf(commands, SCTP_CMD_NEW_STATE,
                  SCTP_STATE(SCTP_STATE_SHUTDOWN_PENDING));

  disposition = SCTP_DISPOSITION_CONSUME;
  if (sctp_outq_is_empty(&asoc->outqueue)) {
          disposition = sctp_sf_do_9_2_start_shutdown(...);

In SHUTDOWN_PENDING the stale expiry now reaches
sctp_sf_t5_timer_expire(), which unconditionally aborts:

  reply = sctp_make_abort(asoc, NULL, 0);
  ...
  sctp_add_cmd_sf(commands, SCTP_CMD_SET_SK_ERR, SCTP_ERROR(ETIMEDOUT));
  sctp_add_cmd_sf(commands, SCTP_CMD_ASSOC_FAILED, SCTP_PERR(SCTP_ERROR_NO_ERROR));
  return SCTP_DISPOSITION_DELETE_TCB;

Can this tear down a healthy, fully recovered association and discard
queued user data with far fewer than Max.Retrans shutdown-phase
retransmissions?

Also, can the legitimate shutdown-guard arming still repair the
deadline?  SCTP_CMD_TIMER_START_ONCE short-circuits on timer_pending()
and the SCTP_CMD_TIMER_START fallthrough uses timer_reduce(), which
only moves an expiry earlier:

  if (timer_pending(timer))
                  break;
          fallthrough;
  case SCTP_CMD_TIMER_START:
          ...
          timer_reduce(timer, jiffies + timeout);

For reference, the arming and the SHUTDOWN_PENDING-gated cancel were
added together by f8d960524328 ("sctp: Enforce retransmission limit
during shutdown"), so the two sites appear intended to be paired.

[Severity: Medium]
[Finding: main-1-1]
[Sources: opus-5]

A question about the changelog rationale as well.  It states:

  "This caused premature ABORTs when the receiver's rwnd was closed but
   the association was still in ESTABLISHED state."

In ESTABLISHED (state < SCTP_STATE_SHUTDOWN_PENDING) the counters that
gate this ABORT are already reset on any sign of life from the peer.
sctp_check_transmitted() in net/sctp/outqueue.c has a zero-window probe
block:

  if (!q->asoc->peer.rwnd &&
      !list_empty(&tlist) &&
      (sack_ctsn+2 == q->asoc->next_tsn) &&
      q->asoc->state < SCTP_STATE_SHUTDOWN_PENDING) {
          ...
          q->asoc->overall_error_count = 0;
          transport->error_count = 0;

and sctp_cmd_transport_on() in net/sctp/sm_sideeffect.c clears the
counter on every HEARTBEAT ACK:

  if (t->asoc->state < SCTP_STATE_SHUTDOWN_PENDING)
          t->asoc->overall_error_count = 0;

Given those, can overall_error_count reach max_retrans in ESTABLISHED
unless the peer acknowledges neither data nor heartbeats at all?  If it
cannot, is the ABORT being suppressed here the RFC 4960/9260 section 8.2
behaviour rather than a premature one?

Two further points on the header:

  Fixes: 8a0d19c5ed41 ("sctp: start t5 timer only when peer rwnd is 0 and local state is SHUTDOWN_PENDING")

That commit added the zero_window_announced conjunct.  The
asoc->state == SCTP_STATE_SHUTDOWN_PENDING condition being removed came
from f8d960524328 ("sctp: Enforce retransmission limit during
shutdown"), which deliberately confined the T5 guard to the shutdown
phase.  Should the Fixes: tag point there instead, and can the changelog
address that commit's rationale?

  "According to RFC 2960 Section 6.1, zero window probing is a normal
   protocol behavior."

RFC 2960 is obsoleted; RFC 4960/9260 would be the current reference.
T5 is defined as the shutdown-sequence guard (RFC 4960 section 9.2, see
the comment above sctp_sf_t5_timer_expire), so could the changelog also
explain why reusing it as a generic zero-window guard in ESTABLISHED is
appropriate, and update the "one last chance ... before aborting"
comment that no longer describes what happens in that state?
-- 
pw-bot: cr
