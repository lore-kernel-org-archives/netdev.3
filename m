Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793091326;
	b=0B9+pwzc0TdQbbPk3gDZ5TxIdqV/qhc0a81DItCCW90oEatPi6DiwlOhO/pcFSUyWvsN
	 AQouPgOMX9uia/SjmRbQbpEvCBoKSxqDGuN18Uh4b1Z989ZsgoZk4HVhlYLeCA7QMkbAB
	 bT6SRLqVZ74XF9JMf5rsdQAWniU+aprPCT1dxUTArHSQFPpgFN0JZz0GkcX2xNiGDah0N
	 JDUGjGpHGQe56gkmfxI3ZH9W+KwM9pbl62uvH3IHNIo5HEtNJiPFpcPxMyXtGJXF53tCn
	 jR3+TaEh5fttmUzs7iG3Y/YRG5j3fBDlMnb29iy/h5+G3Gqtv8Wz764sHOYcggMzA1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793091326;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=KYcSGHUrAWvm7VQvDtNi8wcu3ZV41LzIcdxIJ2/UMio=;
	b=Pwn1wXzmemTaoufD3YQa3UZUC8TPc8zSaRlu3KQuFWvRXZJJWylogTsyvQZfAyv6WfPx
	 tGm4VmgP0mWFxcYejNbnuOTi9w2vdJzD9tNstf8YinSDyVYTn8DqnF7CiglopKOthqEoU
	 02jmMp5c5UQ3dvAJLt94u8wKOrml3Cuqw+6tW4T9rOR5FrBT13kQyR5cAU5RzXdwXQXTH
	 vg8B37vcZxQiqlpRQtxW0uf7dhvOZ1wE/NYNoabVHws9ZigmBLIZprwdJ2x4SbdFI3XYs
	 QaqXf6Cqr8UQw8ZW+m7yN0PyFfgjU4KaJS/ukjnqKr2Iv0BdWdPSd83AmmJxy/dIwug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bAD7rJZ0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1196D606A324
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 08:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bAD7rJZ0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3809F1F01825;
	Tue, 27 Oct 2026 08:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793091325;
	bh=KYcSGHUrAWvm7VQvDtNi8wcu3ZV41LzIcdxIJ2/UMio=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bAD7rJZ0QW1LdgPwjT6Dt3d28NY0PsjBfpvJaGWHTcG1XnxkCfyeZ8xjkUdENuAVV
	 ws7dlnqYAXTJQook8iYJNxPbjyv3xqIPPTbzRa+yf/cBcgGa1GQNjoDQhR7hnHxIbb
	 V1mTduBRsLkxZzq941vDDzb5XVDa3pmSwQpISkyWAGdEs1hf8rqLEvigHSOZt37hMw
	 Ui3+5suaNRk5gBNvVl11Lk4lgHsi1PISnFQEK9Oh46z8Q3wionPYafJC/4KIzF5eJH
	 WCSddpodg28jnij5fGhMkYgM6wxLwvKozBq6E3Kz2n8CNUsLM9mq9reN3dziRs5qV5
	 lJh/hGVzc2uqQ==
Subject: Re: [PATCH net 10/10] batman-adv: tt: limit local table to single
 TVLV response size
From: netdev-bot+sashiko@kernel.org
To: sw@simonwunderlich.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, sven@narfation.org, sashiko-bot@kernel.org
Date: Tue, 27 Oct 2026 08:55:24 +0000
Message-ID: <179309132480.3134.3568656714789779480@kernel.org>
In-Reply-To: <20261026085309.1074911-11-sw@simonwunderlich.de>
References: <20261026085309.1074911-11-sw@simonwunderlich.de>
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

- [Low] The Fixes: tag points at 85fb027f611b ("batman-adv: tt: reject
  VLAN/TT entries before reaching size limit"), but that commit did not…

--

batman-adv: tt: limit local table to single TVLV response size

This patch caps the reservation of local TT entries and VLANs at the
smaller of packet_size_max and the largest full table response that fits
in one unicast TVLV packet, since tvlv_len is only 16 bits wide. A new
helper, batadv_tt_local_transmit_size_max(), computes that limit. The
helper is used in batadv_tt_local_reserve(), in the related log messages
and in batadv_tt_local_resize_to_mtu().

Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930094558.3723766-2-sw%40simonwunderlich.de?part=8

> Fixes: 85fb027f611b ("batman-adv: tt: reject VLAN/TT entries before reaching size limit")

[Severity: Low]

Does this Fixes: tag point at the commit that introduced the problem?

85fb027f611b removed a check from batadv_tt_local_create() that already
limited the table by packet_size_max only:

-	/* Ignore the client if we cannot send it in a full table response. */
-	table_size = batadv_tt_local_table_transmit_size(bat_priv);
-	table_size += batadv_tt_len(1);
-	packet_size_max = READ_ONCE(bat_priv->packet_size_max);
-	if (table_size > packet_size_max) {

That older check had no cap at the 16-bit tvlv_len either. So the missing
limit seems to predate 85fb027f611b.

Blame on the parent of 85fb027f611b points at defa87f5ce75fe
("batman-adv: tt: extract allocation of new local entries"). That commit
only moved this code, so the check is older still. The original commit
was not identified.

Kernels without 85fb027f611b can still let the local table grow past what
one unicast TVLV full table response can carry. This happens with
fragmentation disabled and a hard interface MTU above
sizeof(struct batadv_unicast_tvlv_packet) + U16_MAX. In that case,
batadv_tt_prepare_tvlv_local_data() hits its check_add_overflow() path and
returns 0, so no response is sent.

With the current tag, stable tooling would only pick this fix for trees
that contain 85fb027f611b. Could the tag name the commit that first added
the packet_size_max-only check? Or could the commit message say that
older trees are affected too?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261026085309.1074911-2-sw%40simonwunderlich.de
