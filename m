Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2AC37F8B6
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 01:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790042169; cv=none; b=jJx9355P2X73FFcdjo4LXXuIqmx4AEhVFOlLrLZoFfrisUPHk026ODwBno4KAUiPM8V/cL46By/EMxf2QS+KVvxdwHBQ3HI4JMrh/I7JvXMNCDg4bNUwvRr5gwFLqh6YRQe6smQiyzKjkVzA54fZegF/AAC9Wk53raK4AFXKBqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790042169; c=relaxed/simple;
	bh=CcUwxQFEusO4FuByUdLamrfvOYeGfle3L9iT5IfliHo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D4fK3fdCzSUK8Us534b69E67TnA6qa5+rvdCN7JA4YU42mZx/bQxtx8Ye4yzaEvvkM6bzEX1YprUEjsMkuRshjmDPwWkmKRy/PLdtibdKAQCB6cF1iqaVu4x8kpjaaH7LQ4wibcIR3AnQrkLvStOBPY7/YbNakhksTSqn6p9Rg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XpZwHkc6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XpZwHkc6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9249E1F00893;
	Tue, 22 Sep 2026 01:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790042167;
	bh=GRLRGTQ+TNU1bI48qcBRJrGhM/kF03R8t7D4309L1UQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XpZwHkc6FeJO+F58OQRpUYATiJblv7m9Rowq7cYtT18qjo4/VtKzdSnqRqFwVgbr/
	 mlPZrFbksR+VUoVye4Luce9W9kWidzSa9T46qRwDIntC7yDQ1q4cJtifia0/fCvWLX
	 5By+nZ1A81qe0OuWI/mE6cUavbAHcbpKifE+zPXJXane2xec/Gk2Biu46izIHa7+7x
	 cGXy1/2oIrrup6T0NlAcDt67qkD1eKQqhNaFdB8U3fzIlmc352wbEKMhGmJMwYbCkJ
	 BMOo2A0cTGZwMgqXXlmdPz7T//Z45WVh8KUZpchA9xTTJsSEq/364+sG4bCmabk8HP
	 8L7HWirn2pc7Q==
Subject:
 Re: [PATCH net-next v17 09/15] net: skbuff: add skb->decrypt_failed bit
From: netdev-bot+sashiko@kernel.org
To: rjethwani@purestorage.com
Cc: netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, borisp@nvidia.com, john.fastabend@gmail.com,
 kuba@kernel.org, sd@queasysnail.net, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, leon@kernel.org, andrew.gospodarek@broadcom.com
Date: Tue, 22 Sep 2026 01:56:06 +0000
Message-ID: <179004216615.2160803.3526982338687355382@kernel.org>
In-Reply-To: <20260917224355.2288021-10-rjethwani@purestorage.com>
References: <20260917224355.2288021-10-rjethwani@purestorage.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch makes `decrypt_failed` a per-SKB (per-segment)
  crypto-state bit that is propagated by `skb_copy_decrypted()`…

--

net: skbuff: add skb->decrypt_failed bit

This adds a new skb->decrypt_failed bit under CONFIG_SKB_DECRYPTED, set
when the NIC could not authenticate an skb's TLS payload, and propagates
it in skb_copy_decrypted() next to skb->decrypted.  It is described as a
prerequisite for TLS 1.3 device-offload RX KeyUpdate support.

> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 421f6fc45451..5da2c1149d98 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -851,6 +851,10 @@ enum skb_tstamp_type {
>   *		unreadable.
>   *	@dst_pending_confirm: need to confirm neighbour
>   *	@decrypted: Decrypted SKB
> + *	@decrypt_failed: hardware could not authenticate this skb's TLS payload.
> + *		The payload may have been transformed (XORed) or left as wire
> + *		ciphertext, so software must re-authenticate the record and undo the
> + *		transform on any XORed fragment before it can be decrypted
>   *	@slow_gro: state present at GRO time, slower prepare step required
>   *	@tstamp_type: When set, skb->tstamp has the
>   *		delivery_time clock base of skb->tstamp.
> @@ -1025,6 +1029,7 @@ struct sk_buff {
>  #endif
>  #ifdef CONFIG_SKB_DECRYPTED
>  	__u8			decrypted:1;
> +	__u8			decrypt_failed:1;
>  #endif
>  	__u8			slow_gro:1;
>  #if IS_ENABLED(CONFIG_IP_SCTP)
> @@ -1716,6 +1721,7 @@ static inline void skb_copy_decrypted(struct sk_buff *to,
>  {
>  #ifdef CONFIG_SKB_DECRYPTED
>  	to->decrypted = from->decrypted;
> +	to->decrypt_failed = from->decrypt_failed;
>  #endif
>  }

[Severity: Medium]
Should skb_cmp_decrypted() be extended with the new bit as well?  After
this patch the copy side carries two bits while the compare side still
only looks at ->decrypted:

include/linux/skbuff.h:
static inline int skb_cmp_decrypted(const struct sk_buff *skb1,
				    const struct sk_buff *skb2)
{
#ifdef CONFIG_SKB_DECRYPTED
	return skb2->decrypted - skb1->decrypted;
#else
	return 0;
#endif
}

skb_cmp_decrypted() is the only merge-compatibility gate the receive side
has:

net/ipv4/tcp_offload.c:tcp_gro_receive()
	flush |= skb_cmp_decrypted(p, skb);

include/net/tcp.h:tcp_skb_can_collapse_rx()  (tcp_try_coalesce(),
tcp_collapse())
	return likely(mptcp_skb_can_collapse(to, from) &&
		      !skb_cmp_decrypted(to, from));

net/tls/tls_strp.c:tls_strp_copyin()
	strp->mixed_decrypted |= !!skb_cmp_decrypted(skb, in_skb);

net/tls/tls_strp.c:tls_strp_check_queue_ok()
	if (skb_cmp_decrypted(first, skb))
		return false;

net/core/skbuff.c:skb_shift()
	DEBUG_NET_WARN_ON_ONCE(skb_cmp_decrypted(tgt, skb));

A decrypt_failed segment and an untouched segment both have
decrypted == 0, so all of the above treat them as compatible.  Can two
such skbs then be coalesced into a single skb that carries only the
head's decrypt_failed value, and can the same mismatch leave
strp->mixed_decrypted clear so tls_strp_copyin() flattens the bytes?

The consumer added later in the series works at fragment granularity:

net/tls/tls_device.c:tls_device_reencrypt()
	if (skb_iter->decrypted || skb_iter->decrypt_failed) {
		err = skb_store_bits(skb_iter, frag_pos, buf, copy);

If a merged skb reports decrypt_failed for a byte range that was never
XORed, or loses the mark for a range that was, does this restore the
wrong bytes and make the record fail software authentication with
-EBADMSG?

tls_device_decrypted() reads the mark from the message head only:

	bool nic_touched = !is_encrypted || skb->decrypt_failed;

If the head is the unmarked segment of such a merge, can nic_touched come
out false for a record the NIC did transform, retiring
rekey.old_aead_recv early so a later XORed record is reconstructed with
the wrong key?

The documentation patch in this series states the asymmetry is intended:

	Coalescing (GRO, socket layer) and record classification are keyed on
	:c:member:`decrypted` alone, so :c:member:`decrypt_failed` segments may be
	merged with unmarked ones.

but the same contract then requires that, within a mixed record, a
decrypt_failed segment holds XOR-transformed payload while a segment with
neither mark holds the payload as it was on the wire.  How is that
per-segment property preserved once the merge described above happens?

For what it is worth, this does not look like an authentication bypass:
mlx5e sets decrypt_failed without also setting decrypted, and an skb with
decrypted == 0 is still never merged into a decrypted == 1 skb, so the
record is always authenticated in software.  The failure mode appears to
be a rejected record and a torn-down kTLS stream instead.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917224355.2288021-1-rjethwani%40purestorage.com
