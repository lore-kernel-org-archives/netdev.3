Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792609883;
	b=U2klYtc/oel4hFU3r0BHU1eCcsTclfsDdP8Bne1M9to1lIBohBuYbCA7pEbSQztRZosy
	 Qrnj2661r7Kit9ElH/CsaJ7pXpF9vpBnfy8qF1aumNzx+uEKl6k0+VGX/rAs4E8X139RW
	 /dVo8mABPYlSVs/mJHHN+b6bPX+zAEScKWG4J7Zdn2Xe3dbFJbkjQC0PUG6wQKHZ3NlY4
	 5vAZmo5h+f8DYMarJiFl8xnszIqA6F4DRa+MdiBbKREnZz7nrACzeNNoo7ghp+B7GUUZ7
	 OKA7zRuJtc+5tOjleDPDz5eSWXo8srgoXXRCLRWiLi5lB6er7bYIz7NgP5H17hkKDtg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792609883;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=+JKXqhdtW6oX94eZMED7N51uhKdO+qZKQDvb/WZHHvU=;
	b=vLC62OIWaafoNz9LtQAy51PMJb9GECFa8HCAfkpRYDnB3uYgckdxK2iGfJjM3pktOMuE
	 02/yq6nor7zHkrQTWk3E6j0wCYyTn2U2DqVWuZA2nm7yJTTPL1HJAwLhq27TOvE1MzBBQ
	 oBJG8kZ/9/tycIJFAdbpEXUc7xhAaza0whPYk1Zdv9AOhfO9j2w/i+RA0GX6A2e8o6zPL
	 iQrft/Fyd96H3mqQDfhTij98s10UcopqmY4aiJepccdEsMg+qtF+hXd2TP+9N4JaljCMD
	 DFz2UFGMtm5B9MiFUn0s/1nBRsYEBCjqdgXVzzHfAEIBUDGYYHHHHubI+daae5MaYaA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jN7wO2dV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254DF606A319
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 19:11:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 254DF606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jN7wO2dV
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2e8ad5b31c7so6227565ad.3
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 12:11:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792609882; cv=none;
        d=google.com; s=arc-20260327;
        b=lQlkuf87w7bSHoJkcyg8BVIFuLWGhn5piN3gD4lUGveQOqO2IGMnUtUeEivLX9xK71
         ZZzHil/8PgxKPKei1cFztqlftx1of3gwwOd993m6+ZVCf2Py6xN84v1seFMLHorWM+8s
         3ueVINyTZEjmWEDWLwdzOqaopVVPMjQLN0vOuaXJKi6DDiEi5j/Te+oY53ULHqM+ZmIJ
         /Jqvn+4N7vTKgpm3eV7gYTvMjFVgnPmGAZockYqY9HVMXQKSWWH5EDkDGV2ZCw/hGOm3
         I0XgloJ64i3Ly0fceZc3R4v29LsOAaQgbwdLA9mhrsXu9o4ECONSauMg5Sd2g+0tJIXo
         P+jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+JKXqhdtW6oX94eZMED7N51uhKdO+qZKQDvb/WZHHvU=;
        fh=S0v7RGWd9aS3yFv3HpKHlX7iB3PbfqYNXzPScLEex+E=;
        b=qKlaPuNoIwil5JQKC9bEDzZD0P50ac7bcMGjtX8zoKgEE79ZHff+i6CqKHdujAqj4S
         8utD8Sgv9GVgLJMaZsXJr5nBMKJqkdDl95KU6Tkc9d6ljATGw10jCGBu7Ljmxxc1PywO
         w8gTVCnoyaY1kf+Y4974w+TDx9Yc3oKsaeMcaua/FwwAPqPumK13DBUQ9r/r64S24ZrI
         5n7WLCO6mMQ3QC+0U5/GkwSqEu+ETvRpDQAmjnXPrJ4cTOjOFbIozxaCzgsrEcchfPPD
         P14MOfiFfeJQvJXxZgUbYpFlriKxaYiGQynItXVQ0LSd0nZG4ZguEtXcmtoGOFfs37qJ
         hFtA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792609882; x=1793214682; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+JKXqhdtW6oX94eZMED7N51uhKdO+qZKQDvb/WZHHvU=;
        b=jN7wO2dV3E9BbWv3oyipvcrffEcDvMZngkqDnRbSSfpW+tQQOdtHedrQS8qWWhV9pX
         ikwU4K2J0Dvdqz/JWuvjDXgMgn0SCdHl92Rmux+1fRwqv2bJVQdEXo71/jF+MPDYT+NR
         pDbFOYJN7Trxi/KrzIVzpebmGy2XN/EWR5vAenBEQQTaSVb1GbNB7XlGl02Be2NnjNVs
         Y5qeC3i0ONCjYWf+tCTAhfN6B2sGjSzFV4+dcDUCc/LdRVi1tpaPP21mn06daZ7xcNzK
         38yNFeuhdV5RrOkmM/RS6/T3HeA0leXeN6QZgaV0xNZYxigOGrlcyNBZPidD/ZHie8oC
         RR8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792609882; x=1793214682;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+JKXqhdtW6oX94eZMED7N51uhKdO+qZKQDvb/WZHHvU=;
        b=FVRjKindx4ArfGSM3KU2fmc7Lgti+DLytlVr8ml0h6BdVv8rlFaDKZ5gtMLfsLa7QY
         tCI4xmGATVUBhJ6wZ135DkMTb44cfrvPbIeqH/FHPlDAzvO76P43KzBYsEZm6exPbDGv
         tbBfA6MiWCJ9vT2py8bkQwLDBH626jROkVrULy0iuZ1zTE5GLoDeTFZPKAtsGEmmriPz
         6iu6sUCG72ly4xJRFAddy+mXs8o13isS3o4+bnBB0inNy8JnmNU/ra4BHTtWetejGYRg
         TS9bKVN4bXk1vHsE1fsxJhgm9Y6IczknUboit7n8lYiWbiEOKv8sF94PG/TwZETR/BHZ
         /zIQ==
X-Forwarded-Encrypted: i=1; AKwUvBxiv7Dlr2oOQk7GskIyxsnczCbUT7jeSZ5toiTQJ9jqP0xzhMnM7hJ8bVlGEtfS3fHZFjMZCcs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJuYooNm5XZbDw/GcKCZewq79akOzBItW/5nHchFg1bpt2sT/ON
	JCzaWGw0twSePdzhWjMUH2/c+iSarYZGCYfvTSJOLISAQyHDybjWVwvk+bPIdoQ8eRfsXoOE1U/
	lTvpZs2l3ppDFI/l2xOus0a7PcwD14UE=
X-Gm-Gg: AYBFou2MjDE02pDOuYH+6YEP3kO0h1Hke32IeBNEqXkY0flNFNjdELATchmCrDQGzQE
	JSdeDCstywKH3Yfjr2+UvKwv5NS379HIlBpUkxj3DcYrpUik5mVe1GZYgPubvGyaLQTsH8jwTQJ
	QWQAcaI8d0ywfVCIWSO/UtE49Jv6V5BuNpl80qwRQx/dI3VG2RABfslbNo9orS7KnLRN7KBqN4w
	6KUpyjwl4XrKlJPk0ds2xX/HAUCuFPm8d3KMPPoUJ78unKL+zkBhqr9WAGucS2jSZix7XXVLnbF
	emD9dxycKqA6v7a/GyazKNZv0aUtLnL/pn7pvj9QwfcvOjZPAkymlnYkkVIlOFftbBxRpGMYLwc
	1sZ6KvyiTUOpadoFir/TzknpnYMdAWxOzE3x23J2zC8Jn+RiPlyVKFcv9ZZFtL8jfiCKzjmAMk+
	aZtEKbYPTSw4tJU3nB
X-Received: by 2002:a17:903:8cd:b0:2e9:851a:7188 with SMTP id
 d9443c01a7336-2ea43d8873bmr24797245ad.23.1792609882354; Wed, 21 Oct 2026
 12:11:22 -0700 (PDT)
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
 <CALhGy9n9EMvV2JN8s4kpKb3Wsc3rjRVfibpNvVdAw_rHT=dYeQ@mail.gmail.com> <20261021140303.5533fb2d@pumpkin>
In-Reply-To: <20261021140303.5533fb2d@pumpkin>
From: =?UTF-8?B?QW5kcsOpIEJyYWl0?= <andrebrait@gmail.com>
Date: Wed, 21 Oct 2026 21:10:45 +0200
X-Gm-Features: AclHuK9y-kelxIPCKCCYwgl-lGFUlZEOjWFrkkhIKj9n4uzUrTg95ra_u3iGOOc
Message-ID: <CALhGy9kqmeLRH-p9OrdPObC7KHUW9gmD9o7h8Cmr8+nnx6aRAA@mail.gmail.com>
Subject: Re: [PATCH iwl-net v2] e1000e: work around TSO erratum that corrupts
 data and hangs Tx
To: David Laight <david.laight.linux@gmail.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, 
	g.goller@proxmox.com
Content-Type: text/plain; charset="UTF-8"

Hi David,

> You could just comment that that count++ is in case the linear part
> has the extra fragment.

> Put that in the commit message.

Will do both in v3.

> c) Adjust the DIV_ROUND_UP() for the linear part.
>    I think:
>     DIV_ROUND_UP(len + adapter->tx_fifo_limit - 372, adapter->tx_fifo_limit)
>    is right.

For TSO packets, yes, although it would need min(tx_hdr_buf_max,
tx_fifo_limit) for parts with a larger max_read_request, and without an
mss check it also changes the count for every other packet. I'd keep
that, the unconditional context count++ and pre-calculating the
post-transmit limit for a separate cleanup.

> Although I wonder if you really want to be doing all those divides?
> I'm guessing that tx_fifo_limit is usually 24k (and the actual buffer larger).
> So the result is almost always 1.

Not on the I219. PBA reads 0x0006001a there, 26 KB for Rx and only
6 KB for Tx, so tx_fifo_limit is 6048; in the ring dumps from my test
host, 127,676 data descriptors were exactly that size:
https://github.com/andrebrait/e1000e-i219-tso-hang/blob/5f247ecec758/evidence/related/tx-allocation.txt
Page fragments of up to 32 KB take several descriptors each, so the
divides do matter there.

> (Indeed, does TSO and checksum insertion work if the packets are longer
> than the real buffer?)

TSO does: in a 3-minute window on the patched driver, 39,725 of
40,223 TSO packets were larger than 6048 bytes, up to 65,226 (45
segments), and the receiver verified every byte:
https://github.com/andrebrait/e1000e-i219-tso-hang/blob/5f247ecec758/evidence/related/tso-larger-than-tx-buffer.txt
Only each descriptor has to fit, hence the cap. Plain checksum
insertion only sees frames up to the MTU; for jumbo frames
e1000e_reset() moves space from Rx to Tx to fit two full frames. I
haven't tested jumbo frames. Nothing in the patch depends on the MTU
(it only shortens the first descriptor of a TSO packet), so I don't
expect it to change their behaviour, but I can run the same tests
with jumbo frames if you'd like.

Andre
