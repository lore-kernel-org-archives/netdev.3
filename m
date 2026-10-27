Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793091323;
	b=OgxOnCiTfn4XK41oc/hn/4XgpnO1j+k7XkDx3+gWfHlMDCtP41XBUJqvqipB0U5x91Uo
	 GI89D2rK4BOh+Kg3LQrenJMy1owiWf/ihQwCmIJhGvTL7JaOOGctBzw4ZTxoLVN/AREHh
	 qVOfRRB7mKkcwVGwA8qJX3hbGN9JCvtRgKNiWPL9SyRmCRR+8fCp9LZQgF6pjv1ZV2IIa
	 6E/sFEOAGZa2RO+hpkNpmeI2WbpMQ4lYy7MstuxNs0DNT4tU3FyRlMj8LxvgZL+78pvqP
	 dI10tx4eCSqKMQMUZ4H5lcJF7w8PYV9CyrM4+iVcU3m4Wv1Yp/jeRFbGgHK09ioBFTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793091323;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=RYGIIRLJleypOVfIwOcBtPmaAc6iH0lPsv0VdUsb1Xs=;
	b=CORSzb/grMdyYNvVoBCTo2I8mYRDRsOiqoGC05Bwm3ToZRNPPFByZ02etwp3RhTZN5P+
	 wjQG3b3CigdCnp8qNhUUsU13LAW2gZvaeyaVaECnfrMlVagsEP9eoluVfkt01GRLOvgpd
	 B4gvnPsThXthZml5dc20qIvkaOnnIgpLvpU4bgVVEQ6K76uC1aIv6ERks51T1YijeK1JR
	 YQLKvQaveb/nFISSuALqgTMYanphRQQpbiXVUzcT69P5YZcw583dbfGLvGOYakZypugnu
	 yzr/lnnjsvXhuS4+zigLuC/o0K0Vk/Q9nPe5e5ZfKeQvUUYWj5HEbeyusEYgiImaLuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lu0au9NQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D84606A31A
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 08:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lu0au9NQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE01F1F01825;
	Tue, 27 Oct 2026 08:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793091322;
	bh=RYGIIRLJleypOVfIwOcBtPmaAc6iH0lPsv0VdUsb1Xs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Lu0au9NQOg9keKTYJj7WeCRVO90Eq2tSmN9ByyTtDkS6oU+5au9Q0RIAK0+cau/lL
	 nObTrk+TA3SsUfMLzd06/qccxOVFRddLXgAp2fHA2b+TS3iXqplVOOpqZ91zb+IuPI
	 L6MwNzO/q+cN75I66amTKFETAZNxsYPz3P6OetNQoApDGaJg1Afg/whzmzkh3r4UaV
	 hvvJ/U0tzuieH5sXa7gsPzHpOuVPPobb1lAJdiB+NlizmNUyVpreHkzSviI6aY6SgM
	 G+5xPpfKAfz+oat+E/2gVyjIW3vghunq0V7NUQ5vd31KkQ72XjeY53kVYwAq1jRaU2
	 vkdS0mfNXMUPg==
Subject:
 Re: [PATCH net 02/10] batman-adv: Close OGM aggregation before transmission
From: netdev-bot+sashiko@kernel.org
To: sw@simonwunderlich.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, sven@narfation.org, sashiko-bot@kernel.org
Date: Tue, 27 Oct 2026 08:55:21 +0000
Message-ID: <179309132139.3134.350154128482754175@kernel.org>
In-Reply-To: <20261026085309.1074911-3-sw@simonwunderlich.de>
References: <20261026085309.1074911-3-sw@simonwunderlich.de>
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

- [Low] The patch gives `struct batadv_forw_packet::num_packets` a second
  meaning without updating its kernel-doc.

--

batman-adv: Close OGM aggregation before transmission

This patch makes the OGM send worker mark the forwarding packet as a full
aggregate under forw_bat_list_lock before it calls batadv_iv_ogm_emit().
After that, no other context can append OGMs while the packet is being
emitted and cloned. The packet stays on forw_bat_list so interface purging
can still find it.

> diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
> index 158d2b8f04036..85e99506a53f5 100644
> --- a/net/batman-adv/bat_iv_ogm.c
> +++ b/net/batman-adv/bat_iv_ogm.c
> @@ -1909,6 +1909,11 @@ static void batadv_iv_send_outstanding_bat_ogm_packet(struct work_struct *work)
>  		goto out;
>  	}
>  
> +	/* Mark aggregate as full before forcing emit. */
> +	spin_lock_bh(&bat_priv->forw_bat_list_lock);
> +	forw_packet->num_packets = BATADV_MAX_AGGREGATION_PACKETS;
> +	spin_unlock_bh(&bat_priv->forw_bat_list_lock);

[Severity: Low]
This isn't a bug, but should the kernel-doc for num_packets be updated
to match this new use?

In net/batman-adv/types.h the field is still documented as a plain
counter:

	/** @num_packets: counter for aggregated OGMv1 packets */
	u8 num_packets;

After this change, the worker in
batadv_iv_send_outstanding_bat_ogm_packet() replaces the real count with
BATADV_MAX_AGGREGATION_PACKETS, whatever the number of queued OGMs is.
For example, an aggregate holding 3 OGMs reports 32 from then on. The
field is now both a counter and a "closed for aggregation" marker, and
only the comment at this call site says so.

As far as I can tell, nothing reads the inflated value today:

- batadv_iv_ogm_can_aggregate() rejects packet_num >=
  BATADV_MAX_AGGREGATION_PACKETS under the same lock.
- batadv_iv_ogm_aggregate() is only reached after that check passes, so
  set_bit(num_packets, direct_link_flags) cannot index past the bitmap.
- batadv_iv_ogm_send_to_if() walks the OGMs using packet_len and a local
  counter.

A short note in the struct documentation would help later readers who
rely on the field description.

>  	batadv_iv_ogm_emit(forw_packet);
>  
>  	/* we have to have at least one packet in the queue to determine the

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261026085309.1074911-2-sw%40simonwunderlich.de
