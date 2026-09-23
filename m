Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D52F47F2E7
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 22:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790203004; cv=none; b=gUYTJderutOSJsVBnYmdsiBGaNzByybfJZlu7rEu0u0/4puq55gszmUNhbOY8gkqu3juKf8NqQ1inN9Ovr89aQ9fm+TdSjW3zp6vhGaZ8OcqodCIQElSdVTqg+9+zMnspSPHAfRqVzaJalF5aryiUXLeTspRAP8Klh1LQtwxwQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790203004; c=relaxed/simple;
	bh=a+vc5/hay6kryOUzhzG+WQsCQXasRWjlrH4Fz0hfcM0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h5k2ZjUxHJdCeb5MM6qWhyXrWzYRwvUqYgR/ZdFSQ49kbpF6rU1ir33b/e9t3UUXNicGQ/AxDbI7l5bZ66BKrWOO9qOlUmwREDSnAVg/bUPHplC9DqCUVHRFYBo2FMtdVc33WzXjl2f1DIUcjOwa9+R8vKDcLn+T5q2aWU1J7bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c/XT6fGn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c/XT6fGn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B68BB1F00898;
	Wed, 23 Sep 2026 22:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790203003;
	bh=nzzksm+P+9EH2hVHoE87ODN5/JalVz4Kf+eAMIwnoq4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=c/XT6fGnlI8y7Zm+a6HtlCVeQb7gcUS1lko5ahsO853DLrxpwjc++ec3ez52Mfi2B
	 1lTx/hV9hSscV/FMSSINj0AFdMR9EwTTdksGdCCnG9bLLpSRKO0VnJeqwwJW35bMIg
	 wHzg8ICzt0yu0NbHWldEVCrF40a2vGoN3C3Vdp36pxFZlDWX240v+nu4K3jDhcgjkf
	 dObswbh0OKP2tANIkwUlVEpcxJNbbAdkk5LkkWy64UJ3p383WCIElQM32QFbvAmLhs
	 p+u58AtQuBpJDbFGoIzWgrEeIncC7KE3bP15NsKxgqoPA1SY0127pCMr5kuEUQi/OS
	 Fo41qS3Dj3+uw==
Subject: Re: [PATCH v2 net-next 2/4] net: ethtool: generate RSS keys that
 spread flows over all queues
From: netdev-bot+sashiko@kernel.org
To: edumazet@google.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 willemb@google.com, horms@kernel.org, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
Date: Wed, 23 Sep 2026 22:36:42 +0000
Message-ID: <179020300229.2160803.17928745811588370151@kernel.org>
In-Reply-To: <20260922163458.3900996-3-edumazet@google.com>
References: <20260922163458.3900996-3-edumazet@google.com>
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

Critical: 0 · High: 0 · Medium: 2 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] netdev_rss_key_init() (net/ethtool/common.c:1546) is invoked
  through DO_ONCE() from netdev_rss_key_fill()…
- [Medium] The fixup introduces key-independent collision families in the
  bit that selects the queue.
- [Low] Stale cross-file memory-ordering comment.
- [Low] net/core/dev.h:93 introduces the block with '/* sysctls not
  referred to from outside net/core/ */', and this patch adds 'extern u8…

--

net: ethtool: generate RSS keys that spread flows over all queues

This moves netdev_rss_key and netdev_rss_key_fill() from net/ethtool/ioctl.c
to net/ethtool/common.c and replaces the plain random draw with a generator
that forces some key bits so the Toeplitz matrices of the q lowest bits of a
hashed field are non singular, then rejects keys where two 32-bit key windows
alias.

> diff --git a/net/core/dev.h b/net/core/dev.h
> index 0127b4d03e525..a5e22b2eae523 100644
> --- a/net/core/dev.h
> +++ b/net/core/dev.h
> @@ -95,6 +95,7 @@ extern int		netdev_unregister_timeout_secs;
>  extern int		weight_p;
>  extern int		dev_weight_rx_bias;
>  extern int		dev_weight_tx_bias;
> +extern u8		netdev_rss_key[NETDEV_RSS_KEY_LEN] __read_mostly;
>  extern bool		netdev_rss_key_initialized;

[Severity: Low]
This isn't a bug, but the block these two lines join is introduced by:

net/core/dev.h:
	/* sysctls not referred to from outside net/core/ */
	extern int		netdev_unregister_timeout_secs;

netdev_rss_key is now defined in net/ethtool/common.c and read from
net/ethtool/common.c:netdev_rss_key_fill(), and netdev_rss_key_initialized
(added by the preceding patch of the series) is defined there too.

Should the grouping comment be adjusted, or should these two declarations
live somewhere that is not described as net/core/ private?

> diff --git a/net/ethtool/common.c b/net/ethtool/common.c
> index 23db40618fed1..b4e766e60d38a 100644
> --- a/net/ethtool/common.c
> +++ b/net/ethtool/common.c

[ ... ]

> @@ -1400,3 +1403,174 @@ enum ethtool_link_medium ethtool_str_to_medium(const char *str)
>  	return ETHTOOL_LINK_MEDIUM_NONE;
>  }
>  EXPORT_SYMBOL_GPL(ethtool_str_to_medium);
> +
> +u8 netdev_rss_key[NETDEV_RSS_KEY_LEN] __read_mostly;
> +bool netdev_rss_key_initialized __read_mostly;

[ ... ]

> +static void netdev_rss_key_fixup_field(u8 *key, unsigned int lsb)
> +{
> +	bool d[NETDEV_RSS_KEY_SPAN];
> +	unsigned int i, t;
> +
> +	for (t = 0; t < NETDEV_RSS_KEY_SPAN; t++)
> +		d[t] = netdev_rss_key_bit(key, lsb + 31 - t);
> +
> +	for (i = 0; 2 * i < NETDEV_RSS_KEY_SPAN; i++) {
> +		bool value = true;
> +
> +		for (t = i; t < 2 * i; t++)
> +			value ^= d[t];
> +
> +		d[2 * i] = value;
> +	}

[Severity: Medium]
Does this fixup create collision families that hold for every generated key?

d[t] is the key bit that field bit t contributes to the lowest hash bit, and
the loop above enforces, for i = 0..7, that the XOR of d over the set
S_i = {i .. 2i} equals 1:

	d[0] = 1
	d[1] ^ d[2] = 1
	d[2] ^ d[3] ^ d[4] = 1
	...

XORing any two of those relations gives a set of field bit positions over
which the contributions to the lowest hash bit cancel for any key the
generator produces. On a 16-bit field, S_0 xor S_i for i = 1..7 gives seven
independent masks:

	0x0007, 0x001d, 0x0079, 0x01f1, 0x07e1, 0x1fc1, 0x7f81

So starting from source port 0x8000 and XORing arbitrary subsets of those
masks yields 128 distinct source ports, all of them above 0x8000 and so all
unprivileged, that always land on the same value of the lowest hash bit.

With ethtool_rxfh_indir_default(), the queue is index % nq, so for a
power-of-two queue count those 128 flows are confined to half the queues,
and to a single queue when nq is 2:

include/linux/ethtool.h:ethtool_rxfh_indir_default() {
	return index % n_rx_rings;
}

drivers/net/ethernet/google/gve/gve_main.c:gve_init_rss_config() combines
both, filling hash_lut with ethtool_rxfh_indir_default() and the key with
netdev_rss_key_fill().

netdev_rss_key_aliases() does not catch this since it compares whole 32-bit
windows, whereas the relations above are XOR relations among their lowest
bits only.

The changelog says the key "is a secret that stops a remote attacker from
steering flows onto a single queue". With the relations being forced by the
q = 1 and q = 2 guarantee (non-singularity alone gives d[0] = 1 and
d[2] = 1 ^ d[1]), is that still accurate, and could the commit message and
the new scaling.rst paragraph say what a chosen-port attacker can still do?

[ ... ]

> +static bool netdev_rss_key_aliases(const u8 *key, unsigned int bits)
> +{
> +	u32 windows[NETDEV_RSS_KEY_LEN * BITS_PER_BYTE / 16];
> +	unsigned int i, j, n, r;
> +
> +	for (r = 0; r < 16; r++) {
> +		n = 0;
> +		for (i = r; i + 32 <= bits; i += 16)
> +			windows[n++] = netdev_rss_key_window(key, i);
> +
> +		for (i = 0; i < n; i++)
> +			for (j = i + 1; j < n; j++)
> +				if (windows[i] == windows[j])
> +					return true;

[ ... ]

> +static void netdev_rss_key_init(u8 *key, size_t len)
> +{
> +	unsigned int lsb, bits = len * BITS_PER_BYTE;
> +
> +	/* Four keys out of five come out of the fixup free of aliases, so
> +	 * drawing another one is both simpler and cheaper than repairing.
> +	 */
> +	do {
> +		get_random_bytes(key, len);
> +
> +		/* A field ending at bit @lsb uses key bits [.. , @lsb + 31],
> +		 * so stop as soon as a 32-bit window no longer fits in the
> +		 * key.
> +		 */
> +		for (lsb = 15; lsb + 32 <= bits; lsb += 16)
> +			netdev_rss_key_fixup_field(key, lsb);
> +	} while (netdev_rss_key_aliases(key, bits));

[Severity: Medium]
How long can this loop keep hard interrupts disabled?

DO_ONCE() below runs the callback under the global once_lock with IRQs off:

lib/once.c:__do_once_start() {
	spin_lock_irqsave(&once_lock, *flags);

and the lock is only released in __do_once_done() after the callback
returns. Previously the callback was a single 256-byte get_random_bytes().
It now does get_random_bytes(256), 126 netdev_rss_key_fixup_field() calls
and netdev_rss_key_aliases(), which builds up to 127 windows for each of 16
residues and compares all pairs.

The changelog measures one pass:

	"DO_ONCE() runs the generator under a spinlock with hard IRQs
	disabled, so keep the windows of a class in an array rather than
	recomputing both sides of every pair: 116 us instead of 254 us for
	the worst case"

and the do/while has no cap, so with roughly one draw in five rejected the
duration is only bounded probabilistically. Other CPUs entering
netdev_rss_key_fill() spin on once_lock for that whole time.

Would it be reasonable to generate the key outside the once lock and only
publish it there? Note DO_ONCE_SLEEPABLE() does not look usable as a
replacement: tg3 reaches netdev_rss_key_fill() from tg3_reset_hw(), called
by tg3_init_hw() under tg3_full_lock(), i.e. with a spinlock held.

> +
> +	/* Pair with smp_rmb() in proc_do_rss_key(). */
> +	smp_wmb();
> +	WRITE_ONCE(netdev_rss_key_initialized, true);
> +}

[Severity: Low]
The barrier moved here from netdev_rss_key_fill(), but the reader side still
points at the old place:

net/core/sysctl_net_core.c:proc_do_rss_key() {
	initialized = READ_ONCE(netdev_rss_key_initialized);
	/* Pair with smp_wmb() in netdev_rss_key_fill(). */
	smp_rmb();

After this patch netdev_rss_key_fill() contains no barrier at all, so only
one half of the documented pairing names the other. That reader comment came
in with the preceding patch of the series ("net: synchronize
proc_do_rss_key() with netdev_rss_key_fill()") and no later patch in the
series touches net/core/sysctl_net_core.c. Should it be updated to name
netdev_rss_key_init()?

> +
> +void netdev_rss_key_fill(void *buffer, size_t len)
> +{
> +	if (WARN_ON_ONCE(len > sizeof(netdev_rss_key)))
> +		len = sizeof(netdev_rss_key);
> +	DO_ONCE(netdev_rss_key_init, netdev_rss_key, sizeof(netdev_rss_key));
> +	memcpy(buffer, netdev_rss_key, len);
> +}
> +EXPORT_SYMBOL(netdev_rss_key_fill);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922163458.3900996-1-edumazet%40google.com
