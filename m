Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792771820;
	b=38cHiHet6pSdS94vaoQaoKwu4U86Zg2uuVEPAjrSuafxMYXWxRro7HYU6GFFtDc7a4tv
	 gdUIeui5vHHu63qailQ/H4vMExkfHzlFq85vJpTvbUwR2Ff+ZUx9Gx3ZTvrnqUjcMsq70
	 8lqwROw2eEBAU01QBk5dtel+xaVYy/1/pKr1+JtGh9C0JY8tN1RFqNlR45o7v2TfY5gsE
	 bHvvQck3Q2ZEmVZvfbvljAYufEp3Ryr1XvGTSJ02152uEcqXtlkfroYMBJpGfkJHU6w/A
	 z8TzhMUYC//OVQbcPiDjIEPd0L68Iw6gmB8QqrABZpGSFIINPHxp2Z6jdeOT6h1WXiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792771820;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=iOEfPbJk2YF0NeuGN15ZMHmTQgc5Fhu5fYzvaP6ukBM=;
	b=pWi66qKj71Z/ed6l3mlrsxytWijXY60IZ7k7HVYQHeAuGrojvcAFCSfJVVPaLZnPev8K
	 PKkJuCkKXQWhVitoMPmSdLRNPK8GnxnMdwQQsQaCsqLDqILi/VQ2U604rX3vymcYa1gT+
	 xbXMdTQewco0lZzdzrpWniz7uztK6N9wA92KSEjsHmH6HTBpSLmVN3PN2NCG4XIF2NX5Y
	 rquvvaVbFJoBgQ0pNrokftXwgrtxJFjZt2shF9/o4FWQnT7edCkjiTFUxiuh3jK+TTCs9
	 baMp9yucGFerSeALUCWzuRN18IRfi0gPNImbmcV94waKhxHdS0g5EZurMjLbgW2EmNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ltcSzkFM;
	arc=none smtp.remote-ip=209.85.221.177
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47281606A322
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 16:10:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47281606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ltcSzkFM
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5ea929b2933so56483e0c.1
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 09:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792771819; x=1793376619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iOEfPbJk2YF0NeuGN15ZMHmTQgc5Fhu5fYzvaP6ukBM=;
        b=ltcSzkFMfD4/BWQo/UmUur+b52qayGQxhZW8PKkCjYmQ7LMKwLZPWxxZpiHpXjzO0P
         ODm/aRPTa0E8rcp+JI350LjKezlP4Gp3RL8Io3aDl6w2riqnoAGI9Ou9/BQLR2BmfA0A
         MoTJX+JJ4Ky2PiGdIhv0apY1B/TqVXf//TZC5iUAPMoXem1L9qnVl216IN5EHB4AsRrP
         D9WTetF4Bokb46/+5+xSDNj5XaV3bslw88Y1WSV51rrPuRqUvgZQ7tLqJMnztRoQvNZm
         ptiVePtcWLseFGVL1VPT6bfgKrYCpbtBjM7vxZv+apBtRapbDWPldX7QdSTNCFasch/f
         jcqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792771819; x=1793376619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iOEfPbJk2YF0NeuGN15ZMHmTQgc5Fhu5fYzvaP6ukBM=;
        b=mW3k/MCBz6GrHBo0IBX4V0Bb5satVPxfSBRbSStWgPIuOgs2It6aEX5z7TY24g93sC
         1q3QV4y/gxcbpk/EpmsVl6mvDjxxAe9Gixad+KfgaTnba20ahPB8glqXq0jWggjiN+FI
         hHQOVfy7QwHL9N4S5fnrRSxCacmvxu/FOduskecrQBkLy/QAZu2CMg8oS5JNoSSkXSaZ
         xChCcMg5UdOvJWJYMmLYjoQr0N7PNH42XrXpDYQAX1AZmJUAh13WIvHoM38KqpyMmmxJ
         RxQbKDCeZF5tkAsmCCMejhwHDLcLVHni+YrQQf1GBAhGNnglEqYXM3ewJ+66SE+eZK0C
         o7Og==
X-Forwarded-Encrypted: i=1; AKwUvBwkwaYAH75VYneuBsEPpdY4xWFRrhTL7FYKFP5EN5JVWk6U3ixtg0LtagjV20IaqLCftitaX0A=@vger.kernel.org
X-Gm-Message-State: AFq9FYIGBFUN9PzPWaGB3fpE0uCijDcxIMfEYY7Ui7vxQ3Fmn8CbyGD4
	0gBI+lf7L1AyfFoZ0/zgXuIBWKTICNNZOu90AHnx0cd75gtUyGh40Kuv
X-Gm-Gg: AYBFou1OA/2n4eoMTDx+lxYonqFbSgMXRR4U+HnAqHmUDHinvQC5ZRV/vgdl5RttqCj
	XTygOmGKdD5bzodKYIcnICpuj6f5e16bDveZR39/aGIvuAiSeiPFTsRKXNw0nnuKzWrNZ2tlz73
	jM7M3Fnt2d6Q3aG7mrwcIlPncuqlNv87XpuHyGkyihaSz+uG1ysOXkTiPqWaQlmwCsa7sNHpq1g
	x/Bl1kHdgzDJWfwJzaCIcBh8HXUE7mlLWe7wzLRbGXHMJ0ywSYo71++rfH/Pta4jyIgyILWxZnq
	5Qis+Z1xD5cXQA2vQa+4Qv1UNO5xsbuzYZLGSbSVANtsFqGcoQuhMz5+tIweFdAEqWGoz1d/sPA
	0/KcUJFlnMFfkltAscn2TB3s0xhrrvBo9vpm2OHAfA/1cABzDIFrGh/sXGiY3GRaLWtrAf+kSy/
	9erfyIaUJCTjhMlKSRhJGxthpHYqO3HtYsuauUlXouYf97kt4Cvp9PWfcOZiKgzXGm0kJqktkvM
	Dy6jayrS6E0qWRIygRaYYvFYb0vfoSDMz7Qa+bwXle1HMpELOkmC2s3oMAomgnJtdL1ZScFxPkW
	Mgz3XYIeez0YWsbXEgLS8ym2H31C6d0uaoP6F5yz
X-Received: by 2002:a05:6122:e008:10b0:5ce:23fe:84d8 with SMTP id 71dfb90a1353d-5ec1476d39cmr1117984e0c.0.1792771818785;
        Fri, 23 Oct 2026 09:10:18 -0700 (PDT)
Received: from yes.c.googlers.com.com (215.177.86.34.bc.googleusercontent.com. [34.86.177.215])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec1fd11d42sm588709e0c.2.2026.10.23.09.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 09:10:18 -0700 (PDT)
From: Neal Cardwell <ncardwell.sw@gmail.com>
To: gnault@redhat.com
Cc: Tom.D.Williams@morganstanley.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	horms@kernel.org,
	kuba@kernel.org,
	kuniyu@google.com,
	ncardwell@google.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	ycheng@google.com
Subject: Re: [PATCH net] tcp: Fix dup-ack detection on non-SACK bidirectional data transfer.
Date: Fri, 23 Oct 2026 09:10:13 -0700
Message-ID: <20261023161013.3079347-1-ncardwell.sw@gmail.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
In-Reply-To: <2ab9dc5f5b5e9f50d7a4aa02a6b6759fc86314c7.1792658454.git.gnault@redhat.com>
References: <2ab9dc5f5b5e9f50d7a4aa02a6b6759fc86314c7.1792658454.git.gnault@redhat.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Neal Cardwell <ncardwell@google.com>

On Fri, Oct 23, 2026 at 7:54#AM Guillaume Nault <gnault@redhat.com> wrote:
>
> On Thu, Oct 22, 2026 at 11:46:48AM +0200, Eric Dumazet wrote:
...
> > >
> > > When receiving a pure ack from a peer that also sends data, we can
> > > have SEG.SEQ > SND.WL1, even though the segment contains no data. This
> > > makes tcp_may_update_window() return true (because of the
> > > "after(ack_seq, tp->snd_wl1)" condition), and tcp_ack_update_window()
> > > then adds FLAG_WIN_UPDATE to the segment set of flags, even when
> > > there's no window update.
> >
> > Nice catch. This also matches RFC 5681 dupack definition, (e):
> > "the advertised window in the incoming acknowledgment equals the
> > advertised window in the last incoming acknowledgment".
> > Maybe worth quoting in the changelog.
>
> Good idea, I'll add the quote in v2.

Thanks. I agree this is worth mentioning in the changelog.

> > > Since FLAG_WIN_UPDATE prevents the segment from being considered as
> > > dup-ack (as it's part of FLAG_NOT_DUP), this can inhibit fast
> > > retransmit on non-SACK connections, making recovery very slow as it
> > > now entirely relies on RTO.
> > >
> > > Avoid this scenario by setting FLAG_WIN_UPDATE only when a window
> > > update actually occurs. Pure acks with SEG.SEQ > SND.WL1 can now
> > > be detected as dup-ack and trigger fast retransmission.
> > >
> > > Add packetdrill selftest. Before this patch, the 1001:2001 segment was
> > > retransmitted upon RTO, now it's sent right after reception of the
> > > third duplicate ack.
> > >
> > > Thanks to Tom Williams for the investigation help and initial
> > > reproducer.
> > >
> > > Reported-by: Tom Williams <Tom.D.Williams@MorganStanley.com>
> > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > > Signed-off-by: Guillaume Nault <gnault@redhat.com>
> > > ---
> > >  net/ipv4/tcp_input.c                          |  2 +-
> > >  .../tcp_bidir_fast_retransmit_nosack.pkt      | 42 +++++++++++++++++++
> > >  2 files changed, 43 insertions(+), 1 deletion(-)
> > >  create mode 100644 tools/testing/selftests/net/packetdrill/tcp_bidir_fast_retransmit_nosack.pkt
> > >
> > > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > > index 99baf14afdfd..ef20bb5a0523 100644
> > > --- a/net/ipv4/tcp_input.c
> > > +++ b/net/ipv4/tcp_input.c
> > > @@ -3959,11 +3959,11 @@ static int tcp_ack_update_window(struct sock *sk, const struct sk_buff *skb, u32
> > >                 nwin <<= tp->rx_opt.snd_wscale;
> > >
> > >         if (tcp_may_update_window(tp, ack, ack_seq, nwin)) {
> > > -               flag |= FLAG_WIN_UPDATE;
> > >                 tcp_update_wl(tp, ack_seq);
> > >
> > >                 if (tp->snd_wnd != nwin) {
> > >                         tp->snd_wnd = nwin;
> > > +                       flag |= FLAG_WIN_UPDATE;

Thanks for the fix!

> > One behavior change to keep in mind: because of the "|| !nwin" clause
> > in tcp_may_update_window(), every zero-window ACK used to carry
> > FLAG_WIN_UPDATE and was never considered as a dupack.
> > After this patch, repeated "win 0" ACKs at snd_una with outstanding
> > data (receiver dropping in-flight packets because its queue is full)
> > will be counted as dupacks and can trigger fast retransmit + cwnd
> > reduction while the peer is simply stalled.
> > This is RFC compliant, I think this is fine, but a packetdrill test
> > covering this case would be nice.
>
> Indeed, I also think this new behaviour is valid.
>
> > Also, the header-prediction branch in tcp_ack() still sets
> > FLAG_WIN_UPDATE unconditionally, so CA_ACK_WIN_UPDATE (only visible to
> > BPF CC) is now inconsistent between fast and slow paths.
>
> I feel I'm missing something about this header prediction code. The
> comment says "Window is constant, pure forward advance.", so why does it
> set "flag |= FLAG_WIN_UPDATE;" right afterwards? Do I misread the
> comment?
>
> My (theoritical) understanding of header prediction is that one of the
> precoditions for it to happen is that SEQ.WND == SND.WND. In that case
> we could just drop the "flag |= FLAG_WIN_UPDATE;" line. However, I
> can't see any such guarantee in the code (but I may have missed
> something).

I agree that setting the FLAG_WIN_UPDATE bit in the "Window is constant, pure
forward advance" code path looks incorrect.

> In the end, should I just add a chunk like the following?
>
>                 tcp_update_wl(tp, ack_seq);
>                 tcp_snd_una_update(tp, ack);
> -               flag |= FLAG_WIN_UPDATE;
> +               if (tp->snd_wnd != ntohs(tcp_hdr(skb)->window))
> +                       flag |= FLAG_WIN_UPDATE;
>
>                 NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPHPACKS);

Keep in mind that tp->snd_wnd is after shifting for window scaling, and
ntohs(tcp_hdr(skb)->window) is before shifting for window scaling, so they
probably should not be compared.

But in any case AFAICT that code should not be needed, because if we get to
that block header prediction succeeded, meaning there is no window update.

> I posted it to net because I considered it's a bug in the duplicate ack
> detection. But if maintainers think this should be for net-next, that's
> okay too.

I agree it seems lke a bug fix, so "net" seems reasonable IMHO.

I asked two different frontier LLMs to take a look at this thread, and they
both pointed out an intertwined issue we haven't noted yet, which is that when
an ACK advances tp->snd_una by less than 1 whole segment of the head skb in the
retransmit queue, tcp_clean_rtx_queue() breaks out early without setting
FLAG_ACKED. Previously, such a pure ACK relied on FLAG_WIN_UPDATE being set in
order to have FLAG_NOT_DUP set and avoid being treated as dubious by
tcp_ack_is_dubious() in TCP_CA_Open, and thus avoid calling
tcp_fastretrans_alert(). If we fix the FLAG_WIN_UPDATE code in this way, then
FLAG_WIN_UPDATE does not get set on sub-MSS ACKs, and such cases will make
tcp_ack_is_dubious() true and we'll call tcp_fastretrans_alert().  AFAICT
nothing serious should happen, since FLAG_SND_UNA_ADVANCED should be true and
so num_dupack should be 0 and nothing should happen to the connection state,
and nothing spurious should be sent. But it's performance overhead, and a
confusing dynamic that might lead to bugs down the road.

Below is a proposed patch, cooked by a frontier LLM and lightly edited by me,
that should factor in all these considerations. This is compiled but not yet
tested. I will kick off some tests for it.

~~~~ possible patch:

Currently, FLAG_WIN_UPDATE (/* Incoming ACK was a window update. */) is set
in two places even when tp->snd_wnd does not change:

1. In tcp_ack_update_window(), flag |= FLAG_WIN_UPDATE is set whenever
   tcp_may_update_window() returns true, outside the if (tp->snd_wnd != nwin)
   check.
2. In the tcp_ack() header-prediction fast path, where tp->pred_flags has
   already verified that the advertised window is unchanged
   (ntohs(th->window) == (tp->snd_wnd >> tp->rx_opt.snd_wscale)), line 4357
   unconditionally sets flag |= FLAG_WIN_UPDATE.

This causes two issues:

First, on the slow path in tcp_ack_update_window(), a pure duplicate ACK
(ack == tp->snd_una) with an unchanged window (nwin == tp->snd_wnd) still
satisfies tcp_may_update_window() whenever after(ack_seq, tp->snd_wl1) is true
(or when ack_seq == tp->snd_wl1 && !nwin). In particular, when the peer sends
an in-order data segment of length L > 0 with sequence number S, tcp_update_wl()
sets tp->snd_wl1 = S while tp->rcv_nxt advances to S + L. If the peer's next
packet is a pure duplicate ACK with unchanged window, its ack_seq is S + L >
tp->snd_wl1. tcp_ack_update_window() therefore sets FLAG_WIN_UPDATE (which is
part of FLAG_NOT_DUP), preventing the ACK from being counted as a duplicate ACK
(RFC 5681, Section 2, condition (e)) and inhibiting Fast Retransmit on non-SACK
connections.

Second, tcp_in_ack_event() maps FLAG_WIN_UPDATE to CA_ACK_WIN_UPDATE and passes
it to icsk_ca_ops->in_ack_event(). Because both the fast path and slow path set
FLAG_WIN_UPDATE whenever snd_una or snd_wl1 advances, CA_ACK_WIN_UPDATE is
falsely reported on every cumulative ACK even when the peer's advertised receive
window is unchanged.

Note that when an ACK advances tp->snd_una by less than 1 whole segment of the
head skb in the retransmit queue, tcp_clean_rtx_queue() breaks out early without
setting FLAG_ACKED. Previously, such a pure ACK relied on FLAG_WIN_UPDATE being
set in order to have FLAG_NOT_DUP set and avoid being treated as dubious by
tcp_ack_is_dubious() in TCP_CA_Open, and thus avoid calling
tcp_fastretrans_alert().

Fix this by:
1. Including FLAG_SND_UNA_ADVANCED in FLAG_NOT_DUP, since an ACK that advances
   SND.UNA is by definition not a duplicate ACK.
2. Moving flag |= FLAG_WIN_UPDATE inside if (tp->snd_wnd != nwin) in
   tcp_ack_update_window(), so FLAG_WIN_UPDATE is only set when tp->snd_wnd
   actually changes.
3. Removing flag |= FLAG_WIN_UPDATE from the constant-window header-prediction
   fast path in tcp_ack().

This updates FLAG_WIN_UPDATE to match part (e) of the RFC 5681 dupack
definition: "the advertised window in the incoming acknowledgment equals the
advertised window in the last incoming acknowledgment".

This updates FLAG_NOT_DUP to include part (d) of the RFC 5681 dupack
definition: "the acknowledgment number is equal to the greatest acknowledgment
received on the given connection (TCP.UNA from [RFC793])"

---
 net/ipv4/tcp_input.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 99baf14afdfd..1feb370804b1 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -107,7 +107,8 @@ int sysctl_tcp_max_orphans __read_mostly = NR_FILE;
 #define FLAG_TS_PROGRESS	0x40000 /* Positive timestamp delta */
 
 #define FLAG_ACKED		(FLAG_DATA_ACKED|FLAG_SYN_ACKED)
-#define FLAG_NOT_DUP		(FLAG_DATA|FLAG_WIN_UPDATE|FLAG_ACKED)
+#define FLAG_NOT_DUP		(FLAG_DATA|FLAG_WIN_UPDATE|FLAG_ACKED|\
+				 FLAG_SND_UNA_ADVANCED)
 #define FLAG_CA_ALERT		(FLAG_DATA_SACKED|FLAG_ECE|FLAG_DSACKING_ACK)
 #define FLAG_FORWARD_PROGRESS	(FLAG_ACKED|FLAG_DATA_SACKED)
 
@@ -3959,10 +3960,10 @@ static int tcp_ack_update_window(struct sock *sk, const struct sk_buff *skb, u32
 		nwin <<= tp->rx_opt.snd_wscale;
 
 	if (tcp_may_update_window(tp, ack, ack_seq, nwin)) {
-		flag |= FLAG_WIN_UPDATE;
 		tcp_update_wl(tp, ack_seq);
 
 		if (tp->snd_wnd != nwin) {
+			flag |= FLAG_WIN_UPDATE;
 			tp->snd_wnd = nwin;
 
 			/* Note, it is the only place, where
@@ -4354,7 +4355,6 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 		 */
 		tcp_update_wl(tp, ack_seq);
 		tcp_snd_una_update(tp, ack);
-		flag |= FLAG_WIN_UPDATE;
 
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPHPACKS);
 	} else {
-- 
2.47.3
