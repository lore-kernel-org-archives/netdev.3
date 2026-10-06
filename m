Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16A3497B90;
	Tue,  6 Oct 2026 15:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791298849; cv=none; b=cdEJXoeyMO8gf/iscrStnL8cuz3Iv9FsCYI2+mxN0gtMDELZlpXu78IgArprD7Uj6ZNmo2lqDHEXfckjuw52YywiSYo2qkWJ9InwLsUHGazL594xfSTGOJR0JsbjDUyh91d6ZQphh5biwlSIPlcK5M8v4c7HnLkRKNk75YCKtyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791298849; c=relaxed/simple;
	bh=WnlK7foRCV0BLYNqr4edM9RtUhy6JHhwVBj8zXiX0VI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oKBM8kbV/W1gt4xGXj+KapCc0VBcPljNJYy9bY0nzkuFx+uusGDU5Bpc62G104FMQyE+Hpynk//DaNQ/sDlr+33J5yDcZENnLeRiLiWSbRW5SX4Dw++rBkPes/liWYQeYfa7H6boQcZRtwvv0fTO7UrQWJzgcViah9S17CGICrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DUae81y0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DUae81y0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08BD11F0089B;
	Tue,  6 Oct 2026 15:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791298847;
	bh=LvteLtT2DtFUhLxR0FBmkdivNEg1tgUAE88ZH2UGsWg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=DUae81y0aFE6yyuSQblny3Hz8L92GJOJIzfG9ltJEWG1Kv5w++ud378tN7e9UOJwP
	 OLQ4cnTvV09vYeO2hiWdwtRvGjFs91SLZWj5UBQYSXxjRZiEPESk/J282lbpQ4bMyM
	 jZlrqpaX1P2scYXiztfx1MBd1YRjXyFbExx+5VTic5WSrwaSGjUwrnczW7KQNATXOC
	 0Fqs8Tn2uqjppiCMjeWd5u9V7zzCwrB0Gm52JrEazgNGLBuf27X/jUMF18MDrrJpZn
	 e6/hTW0tOQDN86fY0X7kX6XUR17NBofALoSOcYZ6ZbL9B9wPrTtKDaeGKfqkeCr75W
	 KbX+sYO5ecbCw==
Subject: Re: [PATCH net-next 1/4] net: rmnet: use fast monotonic time for tx
 aggregation
From: netdev-bot+sashiko@kernel.org
To: koen.vandeputte@citymesh.com
Cc: netdev@vger.kernel.org, quic_subashab@quicinc.com,
 quic_stranche@quicinc.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, dnlplm@gmail.com,
 linux-kernel@vger.kernel.org
Date: Tue, 06 Oct 2026 15:00:46 +0000
Message-ID: <179129884653.434549.9845948180140319159@kernel.org>
In-Reply-To: <20261002143529.3217189-2-koen.vandeputte@citymesh.com>
References: <20261002143529.3217189-2-koen.vandeputte@citymesh.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 (1) · Medium: 3 (2) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message describes the new clock source wrongly and
  gives no measurements for its performance claims.
- [Medium] The patch calls ktime_get_mono_fast_ns() from a driver and
  describes it as monotonic.
- [Medium] rmnet: stale timestamp assigned to agg_time causes premature
  tx flush
- [Low] Dropping the `diff.tv_sec > 0` term quietly changes the in-path
  flush behaviour of rmnet_map_tx_aggregate() for tx_aggr_time_usecs of…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but there is a
  time-of-check/time-of-use race in rmnet_map_tx_aggregate() that leaks…
- [Medium] This problem wasn't introduced by this patch, but
  rmnet_map_update_ul_agg_config() computes…
- [Medium] This problem wasn't introduced by this patch, but both flush
  branches of rmnet_map_tx_aggregate() (lines 637-645 and 658-667) call…

--

net: rmnet: use fast monotonic time for tx aggregation

This commit replaces ktime_get_real_ts64() with ktime_get_mono_fast_ns()
in rmnet_map_tx_aggregate(). It also changes agg_time and agg_last in
struct rmnet_port from struct timespec64 to u64 nanoseconds, so the bypass
and flush age checks become plain u64 subtractions.

> Calling a wall-clock time function on the transmit hot path introduces
> significant performance bottlenecks, causing cacheline bouncing and pipeline
> stalls when processing high packet volumes.

[ ... ]

> Replace ktime_get_real_ts64() with ktime_get_mono_fast_ns(). This reads a
> lockless, per-CPU timestamp directly in nanoseconds, returning a simple u64.

[ ... ]

> This optimization significantly reduces CPU overhead, eliminates struct
> timespec64 math, and provides a much faster, cache-friendly timekeeping
> mechanism for high-throughput egress traffic.

[Severity: Medium]
Is this description of ktime_get_mono_fast_ns() accurate? In
kernel/time/timekeeping.c it reads from a single global object:

static struct tk_fast tk_fast_mono ____cacheline_aligned = {

u64 notrace ktime_get_mono_fast_ns(void)
{
	return __ktime_get_fast_ns(&tk_fast_mono);
}

__ktime_get_fast_ns() then runs a latch seqcount retry loop and reads the
hardware clocksource. ktime_get_real_ts64() does the same:

	do {
		seq = read_seqcount_latch(&tkf->seq);
		tkr = tkf->base + (seq & 0x01);
		now = ktime_to_ns(tkr->base);
		now += timekeeping_get_ns(tkr);
	} while (read_seqcount_latch_retry(&tkf->seq, seq));

Nothing in this path is per-CPU. Seqcount readers also never write the
shared cacheline, so the old ktime_get_real_ts64() reader path wouldn't
cause cacheline bouncing either.

The real savings appear to be a latch seqcount in place of a plain
seqcount, plus no timespec64 normalisation and no two-field compare.

Could the commit message describe that instead? Could it also include
measurements to support "significantly reduces CPU overhead"?

> diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
> index 39d6d084e73f0..2eafb1d969c1a 100644
> --- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
> +++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c

[ ... ]

> @@ -591,21 +591,23 @@ static enum hrtimer_restart rmnet_map_flush_tx_packet_queue(struct hrtimer *t)
>  unsigned int rmnet_map_tx_aggregate(struct sk_buff *skb, struct rmnet_port *port,
>  				    struct net_device *orig_dev)
>  {

[ ... ]

>  	spin_lock_bh(&port->agg_lock);
> -	memcpy(&last, &port->agg_last, sizeof(struct timespec64));
> -	ktime_get_real_ts64(&port->agg_last);
> +	last = port->agg_last;
> +
> +	now = ktime_get_mono_fast_ns();
> +	port->agg_last = now;

[Severity: Medium]
Is ktime_get_mono_fast_ns() a good choice for a driver? Its kernel-doc
says it is not strictly monotonic:

 * This timestamp is not guaranteed to be monotonic across an update.
 ...
 * So reader 6 will observe time going backwards versus reader 5.
 ...
 * Callers need to be aware of that and deal with it.

Documentation/core-api/timekeeping.rst also says:

	machine check reporting, but most drivers should never call them,
	since the time is allowed to jump under certain conditions.

port->agg_last and port->agg_time are shared across CPUs.
rmnet_vnd_setup() sets rmnet_dev->lltx = true, and several muxed rmnet
devices can share one rmnet_port. As a result, rmnet_map_tx_aggregate()
runs on several CPUs at once. agg_lock serialises the transmitters, but
it does not serialise them against update_fast_timekeeper().

Suppose CPU A reads now from the old base and stores it in agg_last. CPU B
then reads from the new base after the latch switch. B's now can be
smaller than last.

Neither unsigned subtraction guards against that:

	diff = now - last;
	...
	diff = now - port->agg_time;

In that case diff wraps to roughly U64_MAX. That either forces the
sparse traffic bypass (diff > RMNET_AGG_BYPASS_TIME_NSEC) or flushes a
partial aggregate early (diff > egress_agg_params.time_nsec).

The effect is small: one packet skips aggregation, or one aggregate is
flushed early. The old timespec64_sub() code took the same paths on a
negative delta. Even so, the commit message calls this clock monotonic.

Would ktime_get_ns() fit better here? It is monotonic, returns a u64, and
still avoids the timespec64 math.

>  
>  	if (!port->skbagg_head) {
>  		/* Check to see if we should agg first. If the traffic is very
>  		 * sparse, don't aggregate.
>  		 */
>  new_packet:
> -		diff = timespec64_sub(port->agg_last, last);
> +		diff = now - last;
>  		size = port->egress_agg_params.bytes - skb->len;

[ ... ]

> @@ -625,11 +626,12 @@ unsigned int rmnet_map_tx_aggregate(struct sk_buff *skb, struct rmnet_port *port
>  		dev_kfree_skb_any(skb);
>  		port->skbagg_head->protocol = htons(ETH_P_MAP);
>  		port->agg_count = 1;
> -		ktime_get_real_ts64(&port->agg_time);
> +		port->agg_time = now;
>  		skb_frag_list_init(port->skbagg_head);
>  		goto schedule;
>  	}
> -	diff = timespec64_sub(port->agg_last, port->agg_time);
> +
> +	diff = now - port->agg_time;
>  	size = port->egress_agg_params.bytes - port->skbagg_head->len;
>  
>  	if (skb->len > size) {

[Severity: Medium]
Does this change when a new aggregate's age starts counting on the
goto new_packet path?

now is read once, at the top of rmnet_map_tx_aggregate(). Sometimes
the incoming skb does not fit in the current aggregate. The function
then drops agg_lock, calls hrtimer_cancel() and rmnet_send_skb() for
the old aggregate, re-takes agg_lock and jumps back to new_packet. A
new aggregate started there gets agg_time set to the timestamp read
before all of that.

The old code called ktime_get_real_ts64(&port->agg_time) at this
point, so agg_time was a fresh reading taken after the flush. With
this patch, agg_time is backdated by however long hrtimer_cancel()
and the nested dev_queue_xmit() took. hrtimer_cancel() can spin until
a running rmnet_map_flush_tx_packet_queue() finishes.
dev_queue_xmit() on the real device can contend on the qdisc lock.

The next packet computes now - port->agg_time against that stale
value. It is therefore more likely to exceed
egress_agg_params.time_nsec, so the new aggregate is flushed earlier
than configured. The hrtimer armed at schedule: uses an expiry
relative to the current time. The timer and the age check therefore
no longer agree on when the aggregate started.

This path runs on every size-triggered flush. Under sustained traffic
that overflows aggregates, it seems to work against the throughput
goal of this patch.

Could agg_time take a fresh ktime_get_mono_fast_ns() reading after
agg_lock is re-acquired on this path, as the old code effectively
did? The bypass check at new_packet compares against last. It used
the entry-time agg_last in the old code too, so only agg_time seems
to need the fresh value.

[Severity: High]
This isn't a bug introduced by this patch, but can this branch leak an
aggregate that another CPU built?

	if (skb->len > size) {
		agg_skb = port->skbagg_head;
		reset_aggr_params(port);
		spin_unlock_bh(&port->agg_lock);
		hrtimer_cancel(&port->hrtimer);
		rmnet_send_skb(port, agg_skb);
		spin_lock_bh(&port->agg_lock);
		goto new_packet;
	}

The new_packet label is inside the if (!port->skbagg_head) block. After
agg_lock is retaken, the goto skips that check.

With lltx = true and several muxed devices sharing one rmnet_port,
another CPU can run while the lock is dropped:

CPU A                              CPU B
reset_aggr_params()
  skbagg_head = NULL
spin_unlock_bh()
hrtimer_cancel()                   spin_lock_bh()
rmnet_send_skb()                   sees skbagg_head == NULL
                                   small diff, A just set agg_last
                                   skbagg_head = skb_copy_expand(...)
                                   spin_unlock_bh()
spin_lock_bh()
goto new_packet

If A's diff is small when it resumes, A overwrites the head without
checking it first:

		port->skbagg_head = skb_copy_expand(skb, 0, size, GFP_ATOMIC);

Nothing references B's head skb or any frag_list entries appended to it
after that, so they leak. Those packets were already counted as
transmitted in rmnet_vnd_tx_fixup_len(), but they are never sent.

If A's diff exceeds the bypass threshold instead, A sends its skb directly
ahead of B's pending aggregate, so packets are reordered.

Could port->skbagg_head be re-checked after the lock is re-acquired? For
example, the goto could target a label placed before the
if (!port->skbagg_head) test.

[ ... ]

> @@ -653,7 +655,7 @@ unsigned int rmnet_map_tx_aggregate(struct sk_buff *skb, struct rmnet_port *port
>  	port->skbagg_tail = skb;
>  	port->agg_count++;
>  
> -	if (diff.tv_sec > 0 || diff.tv_nsec > port->egress_agg_params.time_nsec ||
> +	if (diff > port->egress_agg_params.time_nsec ||

[Severity: Low]
Is it intended that removing the diff.tv_sec > 0 term changes flush
behaviour for timeouts of one second or more?

tv_nsec used to be normalised below 1e9, so the next packet flushed any
aggregate that was at least 1s old. In effect, a configured time_nsec of
1s or more was capped at 1s when a packet arrived.

The full configured timeout now applies. rmnet_set_coalesce() passes
tx_aggr_time_usecs through without an upper bound, and the netlink
policy for ETHTOOL_A_COALESCE_TX_AGGR_TIME_USECS is plain NLA_U32.

With a 2s timeout, a packet that arrives when the aggregate is 1.1s old
used to trigger a flush and no longer does.

The new behaviour matches the hrtimer, which was always armed with the
full time_nsec. Could the commit message mention this change?

[Severity: Medium]
This isn't a bug introduced by this patch, but on 32-bit builds the
time_nsec value compared here can be wrong.
rmnet_map_update_ul_agg_config() does:

	port->egress_agg_params.time_nsec = time * NSEC_PER_USEC;

time is u32 and NSEC_PER_USEC is 1000L. On 32-bit, long is 32 bits, so
the product is computed as a 32-bit unsigned long. It wraps before it is
stored in the u64 time_nsec.

rmnet_set_coalesce() bounds tx_aggr_max_frames and tx_aggr_max_bytes,
but not tx_aggr_time_usecs. Any value above about 4294967 usec wraps.
For example, 5000000 usec is stored as 705032704 ns, and
rmnet_get_coalesce() reports 705032 usec back.

Both the hrtimer and this age check use the wrapped value.

>  	    port->agg_count >= port->egress_agg_params.count ||
>  	    port->skbagg_head->len == port->egress_agg_params.bytes) {
>  		agg_skb = port->skbagg_head;

[Severity: Medium]
This is a pre-existing issue, but can a new aggregate end up with no timer
armed? Both flush branches do this:

		reset_aggr_params(port);
		spin_unlock_bh(&port->agg_lock);
		hrtimer_cancel(&port->hrtimer);

reset_aggr_params() sets agg_state to 0, and the lock is released while
the old hrtimer is still queued.

Suppose CPU B creates a new aggregate in that window and reaches
schedule:. The old timer is still active, so this check fails:

	if (!hrtimer_active(&port->hrtimer) && port->agg_state != -EINPROGRESS) {

B then neither arms a timer nor sets agg_state. CPU A cancels the old
timer next, which leaves B's aggregate with no pending hrtimer and no
queued work. It stays buffered until the next egress packet on the port.

If the port is torn down first, rmnet_map_tx_aggregate_exit() only frees
skbagg_head when agg_state is -EINPROGRESS:

	if (port->agg_state == -EINPROGRESS) {
		if (port->skbagg_head) {
			dev_kfree_skb_any(port->skbagg_head);

In that case the stranded aggregate also leaks.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261002143529.3217189-1-koen.vandeputte%40citymesh.com
