Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793674699;
	b=4wLbYWid98PZAXBLtOVk16CJ7+O0DCrnuABjRrBPEzJSP0nDCsttANIKHOEWH29HkoYN
	 2Ycj7/qO8soSdeLHKMDuJg7I0nvrgcOJo2rVJ/DIZ7eX5L58x7yb6nCX9BLnckytGTJxl
	 mUY10JWJorm0GiM8/obd7lAwit4LFWUmWkvADapxjdPT6ptYpb1Pjji+QQbQEGNi/AMQT
	 WxZrIkDRHla7VmQUYbJvwWRempLB37ajcvvyxCw2CQ1wXPhlr9Or+OPF81J7+TgP1Mdm9
	 jNFLYl4yejIIjnQhW+2FkG3K2vCobB1COwMDg6sQwl2cOXAlB2Qd6kBn9ZLJo39PE2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793674699;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:In-Reply-To:
	 Mime-Version:References:Message-ID:Date:Subject:From:To:Cc:
	 Content-Type;
	bh=EBOBTMCBvbOa1Vdc4dwzLv3tXtzlfQzqk36T1YAPAwE=;
	b=p2m9gahaiY2+0Cbxs344PBcz4SIyaX3iIAnnqWyqtUdLhPD0p3bm/B943ofStu1XK3t2
	 WKW/sbe21AI3QlvdU4ruyLM89p/jGN9htmwu2WAiVD+JUwBoCzYIvNACV0V3BQ1Tc7tIh
	 ykh7FrqSJcjSOyPzQoDgfgBY3wLyv1a6BWNMRt23MtioLkRjhcwkF+rMa0dLkOqHEKSK7
	 IA7CNJXF4S6c5QQefyJv7wzYeLjWI01ZfvKutkts9uU2Psx+OzQNZoW2A8ajY/8soJMqn
	 0GoxVpl1d/ZO+bxoO9lsP8rv3fAouB/U5EzvYpx+jnCk1LtHWYgmGYr+LHg2m7HTKiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="Qoud/knC";
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09266606A324
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 02:58:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09266606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Qoud/knC
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-351788121cfso74390eec.0
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 18:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793674698; x=1794279498; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:date:message-id:references
         :mime-version:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EBOBTMCBvbOa1Vdc4dwzLv3tXtzlfQzqk36T1YAPAwE=;
        b=Qoud/knCW6YBSRnVdkAZoSzS0TcP3D4kgqABui9kkBDT7ynh6rcgzgvfcLZIPVCBOs
         ubt+NYpD7sqZd03wyzxHuJ3oShbcNh81WBzRSPdZHaLGQAD2Cuhzic9UzxNCT0ZXiBXk
         6oOqKYThBa349cO/MACQzgQmBwmqTx1bh4rA4pnJB6a27ovmhCj/4eR5d89D8ef2/bmJ
         3kXin8QlSIIyS53uJzv4VRO1z3XBMvP+vbSwjrLjCF+u96GF8bk/DT4v1ADAkuXWW9B5
         /DCOcEeBYBW5864Z69TxFO9CN/Ea3e6s2aWoQIM+WtkT+YtEpaMXQcKR/xXAk5re1Is0
         tRLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793674698; x=1794279498;
        h=content-type:cc:to:from:subject:date:message-id:references
         :mime-version:in-reply-to:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EBOBTMCBvbOa1Vdc4dwzLv3tXtzlfQzqk36T1YAPAwE=;
        b=I/obe5xPtCjUV5hSkt9uZOS81zPMuYyGU9yqGc/zz2hjWHuPiSGGrupjrT0dq2N5kf
         dWXJ67i6oqI+4knrXP6lWsSh3HIxEib6IGVzgyTt0r2JGK96HRLZ4Qj05o/LRiitOATB
         9OKM3M/a6O2KXevT0W649R7M7M2QpdERwg0ix4sx3B1rcLU+erhTGYqjNX6+NH5pemSv
         MB2xkEDLywRWJnMRVqJbLnbCEAQLpmsG2KipedWVpHHOU9tBdpfUNBiOzSP1bYMUR/Fn
         zD0qcwOXCHT1GfGMka55ECrCoKeoWtWnBAamuE7aYHKvjeBJPC/KusL7kRRn9w8L89Ej
         Sseg==
X-Forwarded-Encrypted: i=1; AKwUvBy6Y3EFc7tasOh1URJXvQhEMKicS2z6Ur8VYTJnJ1Hn7ZSRBT+XqwJMPvRuKcBQMKzhIZdZDhI=@vger.kernel.org
X-Gm-Message-State: APuU4Z965kyRDfjDDupyIQEE6XHXcD9lW8nIsQqTF/qLAf/1kradQi4v
	m5ul0moEBYeGv9zSr64rF6oaUt3kS0WKD9nE6ktq4xmmlKdrSUQfl+Kljb/kSX/7S/D+j351duy
	dXoOgNuXqnatvNKD77JnJNsS/Ag==
X-Received: from dyaz28-n2.prod.google.com ([2002:a05:693c:639c:20b0:351:16da:ebbc])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:693c:6092:b0:361:7ab9:479d with SMTP id 5a478bee46e88-36a423ee70bmr21653405eec.27.1793674697439;
 Mon, 02 Nov 2026 18:58:17 -0800 (PST)
In-Reply-To: <20261103-b4-skbuff-bug-on-followups-v3-1-54ad0ab57614@toxicpanda.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261103-b4-skbuff-bug-on-followups-v3-0-54ad0ab57614@toxicpanda.com>
 <20261103-b4-skbuff-bug-on-followups-v3-1-54ad0ab57614@toxicpanda.com>
Message-ID: <18e469a24f30b4cf.3137322e32382e36372e3935.167b2f.0000sendgmr@google.com>
Date: Tue, 03 Nov 2026 02:58:17 +0000
Subject: Re: [PATCH net-next v3 01/15] net: skbuff: make skb_copy_and_csum_bits()
 report unreadable frags
From: Mina Almasry <almasrymina@google.com>
To: Josef Bacik <josef@toxicpanda.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Juergen Gross <jgross@suse.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Fernando Fernandez Mancera <fmancera@suse.de>, Mina Almasry <almasrymina@google.com>, 
	David Laight <david.laight.linux@gmail.com>, netdev@vger.kernel.org, 
	xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"

On Mon, Nov 2, 2026 at 6:28 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> skb_copy_and_csum_bits() has no way to fail.  When it reaches unreadable
> frags, or runs out of skb before @len, it zero-fills the rest of the
> buffer and returns 0.  Its callers can't tell that the copy didn't
> happen.
>
> In the !sg && !csum branch of skb_segment() that turns a devmem TCP
> payload into zeroes under a valid TCP checksum, and the peer accepts
> them as stream data.  It takes a device with both SG and TX checksum
> offload turned off.  A test module that segments an skb with 3000 bytes
> in an unreadable frag gets 3 all-zero segments before this patch and
> -EFAULT after it.
>
> Return 0 or -EFAULT, hand the checksum back through a pointer, and mark
> the function __must_check.  Every caller takes the error path it already
> has for a failed copy.  skb_copy_and_csum_dev() can't return an error,
> so it zeroes the whole frame.  csum_partial_copy_to_xdr() no longer
> checksums the bytes it didn't copy.  That only ran when the function was
> about to fail anyway, and skb_checksum() warns on an unreadable skb.
>
> The frag_list loop takes the address of a local, so it moves into a
> noinline function to keep a stack protector out of
> skb_copy_and_csum_bits().
>
> Found by the Sashiko AI review of commit ab9414ed70bd ("net: skbuff:
> don't leave stale bytes in skb_copy_and_csum_bits()").
>
> Fixes: ab9414ed70bd ("net: skbuff: don't leave stale bytes in skb_copy_and_csum_bits()")
> Fixes: 417261779eab ("net: skbuff: don't BUG() on leftover length in skb_copy_and_csum_bits()")
> Fixes: 65249feb6b3d ("net: add support for skbs with unreadable frags")
> Link: https://lore.kernel.org/all/179148235783.434549.14322374227477832817@kernel.org/
> Suggested-by: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Mina Almasry <almasrymina@google.com>
