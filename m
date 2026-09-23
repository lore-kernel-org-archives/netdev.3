Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CEA223336;
	Wed, 23 Sep 2026 23:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790207379; cv=none; b=NHlHdohneGeu7LrWU6ZQzzWRyK/S/Z3l/mL7dNkiF5zYs1lNydA9yw4VMULogjbrZ40k5U6wOI0AQXoSt2yPn49vynYmHwCiTfY0gGGhmyMyxr8sFhtM9y8SRKsRee3iNRKTbnqJ1zONHsjHhWNYwDpQqqXdLbMaeaDGRodv5Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790207379; c=relaxed/simple;
	bh=Zr1nYJNl4fn0L5Gam1s4Asx2OVAh2KUS8apN84p3AhU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PgP1QKdk9YhUguR1C4SMCxhwObwF721UMBrzmS7+T7c1L2zDPKpaddXWCTEQ4I3Uv9bMFfV0tyI6NSyTZWH8ai77Y+dbMbiibD7PXkmGiJy9UKxgSECQNpHsYphHa8xvYuzBgm0qTKsqxSdyq+ynI4O3MAs2hRGdCJzw6HR4Xz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UhptmaS2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UhptmaS2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 166171F000FF;
	Wed, 23 Sep 2026 23:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790207377;
	bh=a9/UucVIqHb25KnnOE/AwGFQJC6/iDR0IjtKpTUK/tQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UhptmaS2M5RfFg0ReOHSy3OiF+3lJZNYk8j6f8tYkJeSs/zdu+DbSqWDT4NTYJ7Wr
	 EOkYfWw484QWi3j+W0EQTt18UGGB1dnaBEnk4XAJr6epWclCXcSZDXIfxBwIwzqkbm
	 H5h1Y9hTQY5wA+xBjpBZgv1lERSWB57rsN9naw1rJEJSWNnHU5bx9mPOCyU75ZbMiX
	 H0dLHjzYXwMLaDUcZsNeExtrWqw/gcdagfWgTPZkU78JuLHmuo76T6aOQGZ/ZID2T6
	 RAmt83cA+L1XwK8UUkA7gz+B8t9f1KwaZYgk74m2FEKYamyAgaOieFcB1NGxH1yKG0
	 as605Knp3ggCA==
Subject:
 Re: [PATCH] net/tcp: check rnext_key for NULL in tcp_ao_prepare_reset()
From: netdev-bot+sashiko@kernel.org
To: benquike@gmail.com
Cc: edumazet@google.com, ncardwell@google.com, kuniyu@google.com,
 davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 23 Sep 2026 23:49:36 +0000
Message-ID: <179020737659.2160803.10081801619806922123@kernel.org>
In-Reply-To: <20260919213630.3313360-1-benquike@gmail.com>
References: <20260919213630.3313360-1-benquike@gmail.com>
X-sashiko-severity: High
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

Critical: 0 · High: 2 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch closes only the RST-generation site while the same
  broken state it is built around — `ao_info` alive with `rnext_key ==…
- [High] net/tcp: silently dropping RST when rnext_key is NULL
- [Medium] The changelog describes a trigger that cannot exist.
- [Low] Concern that the fix is incomplete because peer readers of
  `ao_info->rnext_key` stay unguarded: `tcp_inbound_ao_hash()`…

--

net/tcp: check rnext_key for NULL in tcp_ao_prepare_reset()

The patch adds a NULL check on ao_info->rnext_key in the
established/time-wait branch of tcp_ao_prepare_reset() and returns -ENOENT
instead of dereferencing rnext_key->rcvid.  No Link: tags are present in
the commit header.

A few questions about the changelog and about the scope of the fix.

> In `tcp_ao_prepare_reset()`, when an active reset is sent on a TCP-AO
> socket (when `skb` is NULL, such as `tcp_send_active_reset()` during
> `tcp_disconnect()`), `rnext_key` is read via
> `READ_ONCE(ao_info->rnext_key)` and immediately dereferenced at
> `rnext_key->rcvid` without checking whether `rnext_key` is NULL.

[Severity: Medium]
Can tcp_ao_prepare_reset() actually be called with skb == NULL?

There are only two callers, tcp_v4_ao_sign_reset() and
tcp_v6_send_reset(), and both are driven by a received segment: they
dereference tcp_hdr(skb), ip_hdr(skb)/ipv6_hdr(skb) and parse aoh out of
that segment before calling in.

Also, the very first statement of the function dereferences skb:

net/ipv4/tcp_ao.c:tcp_ao_prepare_reset() {
	const struct tcphdr *th = tcp_hdr(skb);
	...
	*key = tcp_ao_established_key(sk, ao_info, aoh->rnext_keyid, -1);

so a NULL skb would oops at tcp_hdr(skb), and the else branch also reads
aoh->rnext_keyid before reaching the newly added check.  Would the new
check help at all in a NULL-skb scenario?

For the active reset path, tcp_send_active_reset() does not call this
helper; it emits AO options via tcp_options_write() ->
process_tcp_ao_options(), which already handles a NULL rnext_key:

net/ipv4/tcp_output.c:process_tcp_ao_options() {
	rnext_key = READ_ONCE(ao_info->rnext_key);
	if (WARN_ON_ONCE(!rnext_key))
		return ptr;

And tcp_disconnect() on a deferred-connect socket does not send an active
reset either: tcp_need_reset() covers only ESTABLISHED, CLOSE_WAIT,
FIN_WAIT1, FIN_WAIT2 and SYN_RECV, while TCP_SYN_SENT takes the
WRITE_ONCE(sk->sk_err, ECONNRESET) branch.

The state that does look reachable is different: TCP_AO_ADD_KEY issued
while the socket is TCP_CLOSE leaves both pointers unset, because
tcp_ao_add_cmd() only assigns them for other states:

net/ipv4/tcp_ao.c:tcp_ao_add_cmd() {
	if (!((1 << sk->sk_state) & (TCPF_LISTEN | TCPF_CLOSE))) {
		tcp_ao_cache_traffic_keys(sk, ao_info, key);
		if (first) {
			ao_info->current_key = key;
			ao_info->rnext_key = key;

combined with TCP_FASTOPEN_CONNECT, where tcp_v4_connect() returns at
tcp_fastopen_defer_connect() and never runs tcp_ao_connect_init().  Could
the changelog describe that sequence instead, so the Fixes: tag and any
stable backport can be validated against something reproducible?

> diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
> index bb7bbc20ba3f..18aca0dd5252 100644
> --- a/net/ipv4/tcp_ao.c
> +++ b/net/ipv4/tcp_ao.c
> @@ -857,6 +857,8 @@ int tcp_ao_prepare_reset(const struct sock *sk, struct sk_buff *skb,
>  			return -ENOENT;
>  		*traffic_key = snd_other_key(*key);
>  		rnext_key = READ_ONCE(ao_info->rnext_key);
> +		if (!rnext_key)
> +			return -ENOENT;

[Severity: High]
Returning -ENOENT here does not only skip the *keyid assignment, it
suppresses the RST entirely.  Both callers treat any non-zero return
from tcp_ao_prepare_reset() as "give up on this segment":

net/ipv4/tcp_ipv4.c:tcp_v4_send_reset() {
		if (tcp_ao_prepare_reset(sk, skb, aoh, l3index, seq,
					 &key.ao_key, &key.traffic_key,
					 &allocated_traffic_key,
					 &key.rcv_next, &key.sne))
			goto out;

and tcp_v6_send_reset() does the same, so the outgoing RST is dropped
silently: no MIB counter, no drop reason, nothing in the tcp_ao_counters
that an operator could look at.  The remote peer is left holding a
half-open connection until its own keepalive/retransmit timers expire.
For a fix whose stated purpose is to make a reachable configuration not
crash, trading an oops for an unobservable protocol stall on every reset
attempt in that state seems worth spelling out in the changelog at
least.

Is the error return actually the behaviour you want here?  Note that the
listen/TCP_NEW_SYN_RECV branch a few lines above solves the same problem
differently: it never consults ao_info->rnext_key and instead uses

	*keyid = (*key)->rcvid;

where *key is the key just selected from the incoming segment's
aoh->rnext_keyid.  In the established/time-wait branch *key has already
been resolved by tcp_ao_established_key(sk, ao_info, aoh->rnext_keyid,
-1), so (*key)->rcvid is a valid receive ID for this connection and would
let the RST go out properly authenticated, as RFC 5925 requires, rather
than not at all.  Would falling back to (*key)->rcvid when
ao_info->rnext_key is NULL be preferable to bailing out, and is there a
reason the two branches should disagree about where the RNext KeyID of
the outgoing segment comes from?

If you do conclude that the segment genuinely cannot be signed in this
state and must be dropped, could the drop at least be made visible --
something along the lines of the existing TCP-AO counters or a
SKB_DROP_REASON -- so that a silently missing RST is diagnosable in the
field?

[Severity: High]
If the socket state being guarded against here is "ao_info alive with
rnext_key == NULL", does the transmit path still write a MAC through an
uninitialized stack pointer for that same state?

The state is user-constructible.  TCP_AO_ADD_KEY on a TCP_CLOSE socket
skips the current/rnext assignment in tcp_ao_add_cmd():

net/ipv4/tcp_ao.c:tcp_ao_add_cmd() {
	if (!((1 << sk->sk_state) & (TCPF_LISTEN | TCPF_CLOSE))) {
		...
		if (first) {
			ao_info->current_key = key;
			ao_info->rnext_key = key;

and set_current without set_rnext is accepted, so current_key != NULL with
rnext_key == NULL is possible.  With TCP_FASTOPEN_CONNECT and a cached
cookie, tcp_v4_connect() returns before tcp_connect():

net/ipv4/tcp_ipv4.c:tcp_v4_connect() {
	if (tcp_fastopen_defer_connect(sk, &err))
		return err;

so tcp_connect_init() -> tcp_ao_connect_init() never runs and the NULL
rnext_key survives on a hashed, transmit-capable TCP_SYN_SENT socket.

An AO-authenticated bare SYN for that 4-tuple then reaches the
simultaneous-open branch of tcp_rcv_synsent_state_process(), which calls
tcp_send_synack(sk).  On the way out, hash_location is deliberately not
cleared:

net/ipv4/tcp_output.c:tcp_out_options {
	/* Caution: following fields are not cleared in __tcp_transmit_skb() */
	...
	__u8 *hash_location;	/* temporary pointer, overloaded */

and __tcp_transmit_skb() declares struct tcp_out_options opts; with no
initializer, memset-ing only opts.cleared.  tcp_get_current_key() sets
type = TCP_KEY_AO whenever ao_info exists, tcp_syn_options() reserves the
AO option space, then process_tcp_ao_options() returns early:

net/ipv4/tcp_output.c:process_tcp_ao_options() {
	rnext_key = READ_ONCE(ao_info->rnext_key);
	if (WARN_ON_ONCE(!rnext_key))
		return ptr;
	...
	opts->hash_location = (__u8 *)ptr;

so opts->hash_location is never assigned, yet it is still handed to the
MAC writer:

net/ipv4/tcp_output.c:__tcp_transmit_skb() {
	} else if (tcp_key_is_ao(&key)) {
		tcp_ao_transmit_skb(sk, skb, key.ao_key, th,
				    opts.hash_location);

net/ipv4/tcp_ao.c:tcp_ao_transmit_skb() {
	tp->af_specific->calc_ao_hash(hash_location, key, sk, skb, traffic_key,
				      hash_location - (u8 *)th, sne);

Can this write the MAC through stale stack contents at a garbage offset,
and can the reserved-but-unwritten AO option bytes leak uninitialized skb
head data onto the wire?

There is also a sibling state: a key added on a closed socket with neither
flag leaves current_key == NULL while tcp_get_current_key() still reports
TCP_KEY_AO:

include/net/tcp.h:tcp_get_current_key() {
		out->ao_key = READ_ONCE(ao->current_key);
		out->type = TCP_KEY_AO;

which makes tcp_syn_options()/tcp_established_options() dereference
key->ao_key inside tcp_ao_len_aligned().  Would it be better to repair the
invariant at the source, for example by running the AO connect fixup for
the deferred-connect case, refusing that configuration, or failing the
transmit, rather than adding a check at one consumer?

[Severity: Low]
On the receive and time-wait sides, the other readers of
ao_info->rnext_key remain unguarded, for example:

net/ipv4/tcp_ao.c:tcp_inbound_ao_hash() {
		key = READ_ONCE(info->rnext_key);
		if (key->rcvid != aoh->keyid) {

net/ipv4/tcp_ipv4.c:tcp_v4_timewait_ack() {
		rnext_key = READ_ONCE(ao_info->rnext_key);
		key.rcv_next = rnext_key->rcvid;

These look unreachable with a NULL rnext_key today: the
tcp_inbound_ao_hash() read sits behind the TCP_AO_ESTABLISHED state mask,
which excludes TCPF_SYN_SENT, TCPF_SYN_RECV, TCPF_CLOSE and
TCPF_TIME_WAIT, and the only writer that can publish NULL outside a
socket-locked window in tcp_ao_connect_init() is the del_async path, which
tcp_ao_del_cmd() restricts to TCP_LISTEN:

net/ipv4/tcp_ao.c:tcp_ao_del_cmd() {
	if (cmd.del_async && sk->sk_state != TCP_LISTEN)
		return -EINVAL;

Is that the intended invariant, i.e. that rnext_key is only ever NULL
before a connection becomes established, and if so should the comment in
struct tcp_ao_info say so, given the new check implies otherwise?

>  		*keyid = rnext_key->rcvid;
>  		*sne = tcp_ao_compute_sne(READ_ONCE(ao_info->snd_sne),
>  					  snd_basis, seq);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260919213630.3313360-1-benquike%40gmail.com
