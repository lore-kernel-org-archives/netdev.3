Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792579793;
	b=fXFIICqf3b+7y0iNgNGrQXQ5HsvuPrOspVor+9fBxDrNCudlA8LJ8ZELZVlksBBTNwqF
	 +B8cq7hdMEWWG3MSgbn8aJwjXUGAPquzk1kj/VlRYEKZ/jnCGRY+7adcR5WEFT+3VFJek
	 pMwY56AGOkq4L55IOfbNJXGaqT78fQva39IKUfhRP/EYufXWSLjXxwtHBrCL2SJ4u+Ksr
	 P8QJoEYp4wZBvowfxM1vlusXdGJOpMuQ81vZxGkWZ0Z8JEPCnv1/2p14SgdADy80vb0NI
	 vgsW3/F99DxXAvudI4ZMyFmErhZO5QopE92kaEoJBbHRABSEf0QI4zuts4FmmXXvyKA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792579793;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=eeX6PAsV0Y3sIsjFLfktRyMYpLkWyx6uIk1AtOWozmY=;
	b=HaZeACDqDVDv2IoJIBp/wBMB+a+U/GqsqaVrJwnvSEU+kUlmtdA9j4ireCA1QHExYwBD
	 R7C0XQowQUaJiCOGpT1MEZ86virRzZa+e9NgbIkr62ETufLHek79rgzzfAJkKKo5XfuYe
	 nLtAVCWcLhFfyhqTHvww6WPFUFy1ztRRhyDrjBngeurorUya8dhYPfO39gRYmBlLdK0LJ
	 nwWpNvmkQ1075Y1Stthl4EtY1I/V5D7lCHetI1vOwFmh1JeGBNY3wdC6Fh56IVnWYuhEx
	 X/S70tjqy/3XEj44nSVAuKnw4U+AcZzEj0PFvQkiNxIVWUYo4JFeV+N/SuM3jq+85Ag==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KIYq8xDU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596BC606A32C
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 10:49:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 596BC606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KIYq8xDU
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3ac9f49b984so368445a91.1
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 03:49:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792579793; cv=none;
        d=google.com; s=arc-20260327;
        b=aRGm0HnZFcNjBRWAmPTQLm0jg8y0mxnrkHmdUJZgRTbjvfYrfio7FJtMtchGL6MANX
         JcaX9KNdSH0vUHe5YmuxOsZ79lHPR/a6s9es5oAaoMkOR/pVveBBdVy2uNMo9Q4yaXj1
         Oz4PlHIsjp2dGUQNHQ5kixlTo7VNz90a1MTlkEd5UpW3RgVNULQHmzAEiyLLby9Jxsdj
         jFbI019belGWNnDVUF2Yh/MzJaYYPe5/xr54f5135UCLuenjfEHe3d21j5OkbOxtMpM3
         X0y6E/aR4VwTFQfD0uLTj91T2RogVksN4vTt28IG6UCTz2pswhcxcqbIUA7Z8Q/9Nj4c
         Z76Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eeX6PAsV0Y3sIsjFLfktRyMYpLkWyx6uIk1AtOWozmY=;
        fh=H+ywUV9nN5PbpKNliESxkCnMY9ejWLbBwQAJyGjKbXA=;
        b=JMRYcVftv695f9ev71g4Hyg5RTH7D1EZcfmEXjh1vtc9tgSTqU60F7j5KylVaqzmiU
         KdGrQ6qiOb3HoYK4fBxHwzFs01AeUhEdw4eQGKO7PevWTY0TkMf3c0Ac319JHR4q6hG4
         r09O8Tojc6N01kC9b83Z+9xQ6G73ok7l2172KzYeV0WWlfuZJldbotKtvRWmDab74Hwo
         yN/Yrx+/Hf3kN7+YFEDpIpsVCEdfvx/y0YODrbOTZ8wFmg2PZNZxg+nLIHiPV917Xe2C
         etP7cLzB8jwCSqVPwnSh05oSRNc0q5OCUgTe90t0LPrIpsFkEt7e8wLWoESWm14jjNLd
         RYVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792579793; x=1793184593; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eeX6PAsV0Y3sIsjFLfktRyMYpLkWyx6uIk1AtOWozmY=;
        b=KIYq8xDUOhEjw41u1XCqU8cJQRE/MwbECB7weNWx6k29Bu2BBmr1VG7CBU0ohDDe3B
         avi3I+JmpmeRvIQuqq68kUrNTBW74tIHG+q0sROFel6Z6560/nQXvNCBnmiArVFnX/fm
         PTf8ryT8hd2uQlCi00SC8tW2OR1urvLODfhCjlZChhkUgDnQeylSvoj5R5rFjxL/0o9X
         DacW+O/ijkgjuQ9ubfNZrmGOfiXZTDd4vO5dB4fqaM/oj9uP8385cQ39dvTWQrYISw9G
         5lRC+8ohmj3QRoliiYGno5C1cCQ+LlWkraG0ZnEiSgixqmm2U9PkqRewpxQWgrGufu9E
         RrJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792579793; x=1793184593;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eeX6PAsV0Y3sIsjFLfktRyMYpLkWyx6uIk1AtOWozmY=;
        b=Y994vNGzvep+030Iue3i0h6t4lK6iH+JTpGy5jdr6hr3dsbnDcyeU0L3GWtfEiDyZf
         NXywK8Iq0kC6DPZcoe3VzQ50n6mb2qjshi6FFgjWs8lJk1yem4KVkaq4v2evLrgW4pos
         b8y32szW8DDOESctGWuYREk8tP3JzNLMR9Swp1eKA8fXp1FA9qMClWucFnNiMRGnJLvX
         MVTYQwUn0PxHRg+3O1ApgrZqc1nMFi+V3H13akTZouRg4QbzjIEDKzT5RL12KkHnE7Xg
         FhakubE2DOlX/zORnTslWwma35+3vE6r1Kp24ryqgPbznsDjoIXXZgbI/tLkFQfYLe/W
         6Y+g==
X-Forwarded-Encrypted: i=1; AKwUvBw5FL0VxqwW5vwDN1CPxEBqec03WXcfJaapzNtFrrvofLENVwbsBikzDro6ZgIMpWsh7MYBwss=@vger.kernel.org
X-Gm-Message-State: AFq9FYKUPVb2X4bo884YwP2LumrpPjbH+camMHI5cbm4Mg8xvX7XuWnE
	PEHLMlaauskcfl7RGSeS/R+G7cpsYX4paCnsSAlnS/dUjRcweIxAPQ2uZVtzJ5xX51K4RMsHi09
	lisu0hWWJ0V83fdts1Eaj1WJKPZKnMVk=
X-Gm-Gg: AYBFou1L5yOrN15VyGjx+3bWyk4Etd39yebXIbKsl+IbU170N+pOYiamxjIFTJ27O+W
	g1SyJPIffeH7Lk9QR3/ihD6RYkEoyHu/0i2oKZvue9DqSMhYSXoHhha/xT6aYdXCkD3P0FCRMX8
	lFDpzu9AiE9iTgYqGd9fpQN/XKoezj4wN6zroLfFEgoyVNhX+p1K/tEKuqq2knRW2jL6JMR7+Qu
	KLpgRfGsfrsrr5PT3Ri5b7BuHi5DdYXJb61/GM2gMEF62Nmp231Ja5vPfh9Q4QrkCOX03dPcedz
	Sgbb+VtTqqdS35ne+MfhQmwZYq4tnapkiu26JgQKiT7YtDmQCpIsFRVZQd9cqaFUz46m4El1OoX
	XFSb7QWknXxk2wKxqVz3rlXWDEQsBoLhCLw4d/UwnO5A+jfPYRIKVLLJbEZ+fFT2pfJshpec=
X-Received: by 2002:a17:90b:3ec5:b0:3ac:b764:8521 with SMTP id
 98e67ed59e1d1-3ad6571ad27mr3402578a91.38.1792579792717; Wed, 21 Oct 2026
 03:49:52 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020230211.75665-1-andrebrait@gmail.com> <20261021095756.0f5770e6@pumpkin>
In-Reply-To: <20261021095756.0f5770e6@pumpkin>
From: =?UTF-8?B?QW5kcsOpIEJyYWl0?= <andrebrait@gmail.com>
Date: Wed, 21 Oct 2026 12:49:16 +0200
X-Gm-Features: AclHuK8XYSgL4sJ6lwVw4WXh8iC7jNprlbe1Q1YOL50NcC6qXVcAOpwDNKlpvC0
Message-ID: <CALhGy9n9EMvV2JN8s4kpKb3Wsc3rjRVfibpNvVdAw_rHT=dYeQ@mail.gmail.com>
Subject: Re: [PATCH iwl-net v2] e1000e: work around TSO erratum that corrupts
 data and hangs Tx
To: David Laight <david.laight.linux@gmail.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, 
	g.goller@proxmox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 10:57=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:

> > Apply it to all e1000e parts: limit the first data descriptor of a TSO
> > packet to 3 * (max_read_request - 4) bytes (372 on the I219, where
> > pcie_get_readrq() returns 128). The rest of the linear part goes into
> > the next descriptor, which e1000_xmit_frame() already reserves;
>
> Aren't you using an additional descriptor over and above those the code
> might already use?
> So either it was reserving one too many, or you need to reserve another o=
ne.

You're right that the split can use one more descriptor than before.
The count already covers it, though: the bare count++ in
e1000_xmit_frame() is never used by e1000_tx_map(). It comes from e1000,
where that descriptor pays for the 4-byte TSO sentinel ("premature desc
write-backs in TSO mode"); e1000e dropped the sentinel but kept the
count++. With this patch the linear part takes
1 + DIV_ROUND_UP(len - 372, tx_fifo_limit) descriptors instead of
DIV_ROUND_UP(len, tx_fifo_limit), at most one more, so it uses exactly
that spare.

If we want the count to say so, I see two ways:

a) Count the split explicitly and keep the spare:

if ((mss) || (skb->ip_summed =3D=3D CHECKSUM_PARTIAL))
count++;
count++;
+ /* the headers go in a first buffer of at most tx_hdr_buf_max */
+ if (mss && len > adapter->tx_hdr_buf_max)
+ count++;
count +=3D DIV_ROUND_UP(len, adapter->tx_fifo_limit);

   The split pays for its own descriptor and the old spare stays a
   spare.

b) Replace the spare with the explicit count:

if ((mss) || (skb->ip_summed =3D=3D CHECKSUM_PARTIAL))
count++;
- count++;
+ if (mss && len > adapter->tx_hdr_buf_max)
+ count++;
count +=3D DIV_ROUND_UP(len, adapter->tx_fifo_limit);

   The count becomes exact, and one lower for every other packet.

Neither fixes a bug I have seen: the reservation already covers the
split, and in about 3.5 hours of test traffic on the patched driver the
ring reached its stop threshold over 300,000 times without a stall. b
also changes the reservation for every other packet, which I haven't
tested. So I'd keep the patch as it is, the smallest change that fixes
the bug, and leave the descriptor accounting for a separate cleanup.

If you'd rather have the dependency explicit, I'm happy to fold a) into
a v3; it only reserves one more descriptor for those TSO packets.

> I'm not actually sure all the logic there is actually needed.
> The code calculates the number of descriptors the packet is expected to n=
eed
> and gets the packet requeued if there aren't enough, but there is also th=
e
> 'post transmit' check that stops the transmit if there isn't enough room
> for a full length packet.
> If the latter is valid you don't need the former.
> Although a sanity check that the ring isn't being wrapped might not do an=
y
> harm.

The post-transmit check reserves (MAX_SKB_FRAGS + 1) *
DIV_ROUND_UP(PAGE_SIZE, tx_fifo_limit) + 4, which assumes no buffer is
larger than a page. The linear part and high-order frags can be, so the
per-packet count is still needed.

Andre
