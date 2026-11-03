Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793673433;
	b=AaF8vPVU/oziHUf0WJT1qMFzBY0e/FH1vLqfeg2rWPoMJeRsm3GnASmBkN+lGn23k3qG
	 WmLyH8+TvJUZP5LgDXo0PMuhPxEhO2E9KX/4XyBSLcar2cUsMyb/gw51VBWTEyNmEByks
	 YusdXvTZYitkgUecLLCcWBiKGQiOfblwW09awmTYSR7nDnpxhE23JP76Nw7Qq904SUVQU
	 UbfhI4WmZK/+G1HI2ba1BJxcGF52nS878TbZ+3rgZ4hpBFEP56KSFON9pmmnru8BVsWmM
	 sutMD6s9qJQn/09ybNyIRTLXU/5SwtKJUOn4xAsVpn/o18W99mn/oG3N94QPZzoU7Jw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793673433;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=fqTX7BP0mkUbiNPaPzqmPJM6ISWnYd5yW6X5U8Sw0eo=;
	b=Y79h9I9R4hGOHcibe64yTZQslmoYpiX0yD/5dw+75a36nn2wr9v7eYsIMBx9AOG3LqK7
	 Wl89bREGwtiEoEBg48Qfj3b2RjRBj97Gy4ryWdUugvMLsZVpuR0UwVcW3kCcvz2Am3vtx
	 vy1TC4aJYFVQ8k8GvNt8ZkEND07nM9Yf5C6bOyE7R8XBqcyviR7pKXuZi4ppbKqBD3bHW
	 8S3LXYLRvpFdVVd5vtWSmXztk9pBC3gFvnAxUfFhn6eM5cF71wFbBxJS2AA94oq3QeL9C
	 xX7kFJTFCN8q9F001qhPCwl2B6JEQCgKtU7VZkcu1cZOPnfebCXavYQNXny8Kvvak3w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=l2t59kFY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34539606A324
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 02:37:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34539606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=l2t59kFY
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6b1aa36fc0eso5163a12.0
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 18:37:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793673431; cv=none;
        d=google.com; s=arc-20260327;
        b=jrQ7vK0PxRzUVqO5YLe7VTfnK9dsUqO0+aoMk/syu6WWqzf70ximpFnfIv4pIe9lXX
         6Y5UGAZO/UScTUDy3JtTpBMH9pdKnGITKRtRCkBq876PfMyIMshU6/qP02PJJBvbFndZ
         uPachSmZ/zKvmUGcP24mmZK3BbICyHAS7hpzm5uifEl8iemd9jK0+XjfgFoK5c6QW3Nb
         2MS1+Ixlatri4ZY5IgZulPwdw63tk8jaw291LVrCbxfakR4fD6Zqw3we11mqevASCzAV
         F9fE4IQkE1PydAj8vDCKKPAuP0YlYE5hfqTxPVAQrWM43P3ozV7uRrmDQa7FiwUfju4j
         qtCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fqTX7BP0mkUbiNPaPzqmPJM6ISWnYd5yW6X5U8Sw0eo=;
        fh=bTdKD/20SzgjyOsFLdx8pbU3ygyuWmQ3hljkGbKOQdo=;
        b=jqmlafadz/ojaGuQ03BkW4xctMayWgfbNLVr9ZYARFy0tp/2pfjHS3ys8CdnNNedEB
         VcSfeulz5okHcHQQ4kseVC9YWl16AxYHetrOq2VnwosF4apXgAisMaE1Pm5IOrT3PE1g
         RnJDTKtwgCjiFAz6WDtkZO/ARgIPFcZmlWP6EHSEbPufH3v8xuAeWUUeWrH+GJHg6TJH
         RBO25b32XeyIXPBhkud/V2w/AkBTuXhYUkU0uACGLS+Dz5AIhwnDboUAjAgNcJtBGfdv
         Gd2qN6Iu7wkIC6NgR4gjPbtHTExQeOD8kAOM/0rePgse6LNbFK7HKkxRf1+ieJCQsNug
         9N8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793673431; x=1794278231; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fqTX7BP0mkUbiNPaPzqmPJM6ISWnYd5yW6X5U8Sw0eo=;
        b=l2t59kFYVdwqJFxqcKt18zIXti+m/MMfKouFTdxvEwz51FYyAUSm1sdb3PzY5j63PZ
         js94sMHvX1Y9fxuMa3V/IFC0SM/yEkVoEKpXWqz9srK2BU4Da3KifQDE9YySoOdSpQAH
         SRrfGizSE9cY/Tc6lvxhDwsxP1Ts/Rrd4Y9gcxL1+OQQU/0HPVXefiySvwv6RUs3/L09
         BTHE+FqYidzkOCKk4Hli2e5aM0MX9b2Xi0X0Yos/cKYLqMzvpbgHS38ZCmtX0u8MINnD
         DylHoWKuoRo8m9G1LdHmjkdOyfvMvBWhF7tdei3XG5q+pGfzvfymcsA4GYRoUwsrqpjE
         RXeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793673431; x=1794278231;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fqTX7BP0mkUbiNPaPzqmPJM6ISWnYd5yW6X5U8Sw0eo=;
        b=xPPvT9FsM13h60etyDXBLsnymed7qbBBoqf5rwcmdE4yWyql3xLljt4TLV6Bom38Sy
         upi55ywwPZtzauGXSlM5XvibWgzrVfWDNUXmgTcTa5H2HQm3hCRBpGqMNp/+nVGkBwcg
         QwfIkBUG4pQHbZOWwsE6g6uVjX81nL1AGvyyLMOd7LJWNddx7iR1GrOGGnYqKWdgJYJY
         FHxLAY9ia+Ir/3713h5Hup2MzRJGRaNLGqmXH8/x2mXuknoJfxmVByJ7hDGZKjEVaOV6
         RKp2/eckUn4HOCF07afLV929fwcI+Ru72pu2EworUQdeYETbSYKU7S9VJQW6Lpxrkukk
         Qpiw==
X-Forwarded-Encrypted: i=1; AKwUvBzzyrspsSLn9z0hF+Q8a712mgx6AzsUpiIeHWytFGuiKrTUzGdBQAyQw0+duTg3T5Jt1Zhpawc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+QjxlOJaGg/Ld0zr2oyP1MImglFAOx9w4d/IGYjXVe6puyYBJL
	T7S7kjAgN6VoZLgLBGHRW+WVSnq1JTKI9OrdWUEX9Gtgo3mhuFuMHNP90Y+4cB1rFfBO34JJ53P
	wPheXZgG/54IZwop9BSv6OrbBvLGa5ZpbQrC4/Gna
X-Gm-Gg: AYBFou1i/r/FFusX4aWz+TN5nOd9tUwaF9LGxck4o8eQkObKFmvHu517yMmbihhOztu
	LOMmBmKzp1fKHiscDpgrC3nkENPaPPBKLw3aNiwpuhdbsCQlt2jiS0pz74KvjbxSzCAFAReyC6u
	rV1yMIjF3njgxIgdBbssdzV8WIJcufKkh3qXBR3gEqzYgowkqMJhEvSQHMWALKf3VHDKn/zVMQz
	AJPjlD4LxcvJ1zut+9+VNGAADdOnXG/CCO7daxA1gb5+oUzu85e8WDeaBT3U+0YZ6FLiDufR2AJ
	8AjNf4GRimmv9zPdnHRuDQFQC3uHXVjpoVDU2yMAZYcoykrgLBtPP2Oamu3Hf6mWsDl4JZ16dyn
	vPl/F4mb9VtrwekcT2pUAX9KlvPrI+JmKwaxVmGE=
X-Received: by 2002:a05:6402:15d4:b0:6b1:aa31:a627 with SMTP id
 4fb4d7f45d1cf-6b539cf5521mr25672a12.4.1793673431151; Mon, 02 Nov 2026
 18:37:11 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103-b4-skbuff-bug-on-followups-v3-0-54ad0ab57614@toxicpanda.com>
 <20261103-b4-skbuff-bug-on-followups-v3-4-54ad0ab57614@toxicpanda.com>
In-Reply-To: <20261103-b4-skbuff-bug-on-followups-v3-4-54ad0ab57614@toxicpanda.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 2 Nov 2026 18:36:59 -0800
X-Gm-Features: AclHuK_KyosV2S6Hhot3QjeUrSUtUS3-59PgfB2gDmKhS-ed2_dJAQ5EnLrTGm8
Message-ID: <CAHS8izMxdrp-J8yo1B5CPBwPcy8np8+uz8qBxO2GSi0+9eRQLA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 04/15] net: skbuff: fail segmentation when a
 segment can't be checksummed
To: Josef Bacik <josef@toxicpanda.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Juergen Gross <jgross@suse.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Fernando Fernandez Mancera <fmancera@suse.de>, David Laight <david.laight.linux@gmail.com>, netdev@vger.kernel.org, 
	xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 6:28=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> w=
rote:
>
> When the device can't checksum the protocol, skb_segment() checksums
> each segment with skb_checksum().  If the segment has unreadable frags,
> or its lengths don't add up, skb_checksum() returns 0 and the segment
> goes out with a checksum that doesn't cover its payload.
>
> Devmem TCP doesn't get that far today.  Its skbs take SKBFL_SHARED_FRAG
> from the zerocopy uarg, so skb_segment() tries to linearize the segment
> first, and that fails with -ENOMEM for unreadable frags.  No other path
> is known to bring an unreadable segment here either.
>
> Use skb_checksum_full() and fail the segmentation with -EFAULT, so that
> the checksum doesn't depend on that flag.
>
> Found by the Sashiko AI review of an earlier fix for the same path with
> SG off.
>
> Link: https://lore.kernel.org/all/20261009-b4-skb-segment-nosg-unreadable=
-v1-1-7e2334a55fe8@toxicpanda.com/
> Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>

Acked-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina
