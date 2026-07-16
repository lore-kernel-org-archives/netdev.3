Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C71530BF67
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 11:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784202190; cv=pass; b=a24EUSGycRZzDbZZydsM4+8OpNuyvqc83oA6qww8IeIhpw+EqS71XDn3GdQOcv/aMNNcvZqfOnL+7bm8H/1Tqu4vEwMrkFT6c5xsRuFqlcxdSrTtZVUK6yOQimleGIGbWvV95Mr2LFy9SjSCbLcnc+SAyEvqP6KvAiGRp1QoLjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784202190; c=relaxed/simple;
	bh=7jX2el78Z4qXDp5GUOiAEV/a6gDt+AMIIngnAQWH+kM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q9Jd1jKVlPgOlX+vLgT0c6suF7mLQCQq/vHNH0BORLZxEDy2XrASbfZdQNJz4DTZKG5XYFgruQk388x/uHZPMK6tV5jpgmu21/aMeKvJlz+Qeh6zpUTIeZfwz2wYuaDAczkHBqGCbYMl3IQtR8GWvJqB2yCGcXosKk9cK6KyK9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G4Ws9QlA; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4Ws9QlA"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38dfe910e9dso3801370a91.3
        for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 04:43:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784202189; cv=none;
        d=google.com; s=arc-20260327;
        b=eNOqHYR0LO8IS35LVSJhtT6aEI+XF7IxNfODcUN/bx3De5pwHOinyDo1ZZ0p7NLiuq
         51SiAs5MJ+ndUesrjhlnDH70MgkwVPA+9REPYVN4/E1z6MojdiH3qSkBUCaI96MGsgDX
         50K7QKQNQUXQU+NHMglz0vH39iyyPWVuoNNS0uasKX0fWo/JCaiSDhW8eQFgga6Y9JYK
         h6WQNJ+W5xMp/PFOrrO4E9bUrgIhWGgse8toUXE8vUdQRWPrIZzwKh1lMWAWhNcZhMLQ
         Zgx3/cxTphZ1yzD96nDLOzkjP3Eqy1dtub7wd04gDkgVeg4lYlAcSN9vT8jLbn1TmUOr
         hGKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JovS+rCQDfsh3cyPYuCXkkxVWrghph9UOjUZsNYKjQE=;
        fh=iQyfmahMB3C/1k5ZOqTpS1ZCAShbyOWo1k7gUDQ9Q6o=;
        b=rCMCfEVJjVdGn7+lBvfg2VEGQ5zJ6Q8sS5+b/gaqjQ+9RVLUt80riQMQ3zdVsVpzAh
         drv6lBJ+oRUTUR+M0QylOrQn1nVDCFKWV01EghFMhqbaeIxJETNu2fNykA6OhqoXUFBf
         8GdH9C4UdqXMUG2BfvGkwRvg2DK2cIdarbNwdaq6/6BKSoP9eGWiDOSYtDx9XUP8Sqlo
         FBgw8lvbnbniCPIHl+gdGUm0Mw9YASg4b/ruLJDnAScjkKtxeCfkCgRGunc/QMK7Zutt
         uvrQkbh2nZJaE9n8RDguCN4tqgzoioozN6ZnlUHL8hXdt5Hzw8aJ3/4EzjuRnPZXK/nK
         f9pw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784202189; x=1784806989; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JovS+rCQDfsh3cyPYuCXkkxVWrghph9UOjUZsNYKjQE=;
        b=G4Ws9QlAKJ6gwBc9bvgszGegrSMMbj6E6awWqmGUAwDLGpzGJoYIZzMT/fVIscYYhw
         Octym6FzDGvanIyqUOhfvBKKOHA+3Z1BWgnSyHkGbH3bUR53hacdjJoEdOzQYQ6RnkFd
         p4ZZpc8T8D5xTH0peraI8GA4BN59RoL1gtntn6ap0MozNOeHrfUihLu8siJvtFrfLPZv
         3f7EIXTPOmdxEbuuWFBK6MXcfVJk6F7Nr0rRfBrlOqUYZzgS/xpXS8anpwMXLjaLGw8d
         XDO3fMWyJ/gmD3iXlE4CydaRErPQNDfO8EreXYkVzRrQRaAjJnqzI2wkwqwOGgeqMRxi
         XQsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784202189; x=1784806989;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JovS+rCQDfsh3cyPYuCXkkxVWrghph9UOjUZsNYKjQE=;
        b=dTEXf4FfTz5HEHwU/I6D9u0VP63oyPPyijsvJPpzzwgsiT//5g2Oe60K8zc97X669c
         gFFXJYKIyD38AG5kjT+jPonfodzh+GZRzxvWUc+3j1VeNqNjEsfpmbfRwhDq+kFtAsNh
         vh8Yk+24ipdWv09FBK1ljWT/93x01YJtxzZmtZ7MjrT1erm2IheLPQriniGHIDUjcrem
         YRam/6zABirhMCmdRif/2ISGKgukfD31IZUq2v0PHCP/hGDUW1NyrnzR4Gwf8J57X1qE
         2sDj17AYqEbXxblWGoBEUuDbkpix4VBKAkv5eQpS+Tnw5jEN7lA5FylEZRwNfZe4sdrf
         b9VQ==
X-Gm-Message-State: AOJu0Ywp9NKjRYwmpFu/9h1AJdQwfjLP1sWPT8637pp4A6qMzVcc0FvH
	hSzTSnZZ7sBj7Qdbf8VaBtHiS3DbFdnisHKrhbprMSWM82rnzzh/XYx37LwVVxO4aorKWjuCQse
	tci8hhzKw3zoP+zXf0N//76CudkiQKkk=
X-Gm-Gg: AfdE7cnCYxuT8+1og2JPgC6OGGeHsU+p0TFXg0XzNeZdmVP3refwty4qxdBKvDmksqr
	SviFJezascIMD5WkjIfrGL/Sk02FU1yyAqNKAu7cNSc0xTXuA5T6/4y2qwRO/JsjjZhCL2eiV3K
	9FisUBQHSmWSZB5JUpsjFORlKtmMLtdJ5TWwIi0Tpz60+r0a+sytrGoKXLp8xRQLf/k03pwf1Hc
	Iz3/KFak3xb8c+puWxLjUlrJ2FXCi9SZzp4/Q0PkvCpne9tUITuVbL5n8c9pkiEJGqKV5Kz6NsZ
	hUR7Y4bmEEe7qFiDlbW0CKiLt3zdVZrlV7vHyvJ8kPymZsGviSFleQUKcZFr9WmWi0ynrIeJoXi
	/Dw==
X-Received: by 2002:a17:90b:3842:b0:387:e0cb:7f4 with SMTP id
 98e67ed59e1d1-38e17fa8e74mr11239037a91.40.1784202188739; Thu, 16 Jul 2026
 04:43:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714140722.111645-1-maciej.fijalkowski@intel.com>
 <20260714140722.111645-2-maciej.fijalkowski@intel.com> <CAL+tcoAc7d8MSCqK23_pmL2G8tSS-MpfM53brijPntv5A+BA2Q@mail.gmail.com>
 <ali/sIjljiNm9RmI@boxer>
In-Reply-To: <ali/sIjljiNm9RmI@boxer>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 16 Jul 2026 13:42:28 +0200
X-Gm-Features: AUfX_mxN1Ir_5WiSskAyAn49z75NXsXgLWgUizzsp6h8K925OgrttctYn20cySg
Message-ID: <CAL+tcoBGJDC-Kx=qvxoQtd4BUPCDBv00Gta1SOvejx9nNvVo3w@mail.gmail.com>
Subject: Re: [PATCH v3 net 1/6] xsk: fix buffer leak in xsk_drop_skb() for
 AF_XDP multi-buffer Tx
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com, 
	stfomichev@gmail.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	bjorn@kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 1:25=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Thu, Jul 16, 2026 at 01:22:24PM +0200, Jason Xing wrote:
> > On Tue, Jul 14, 2026 at 4:08=E2=80=AFPM Maciej Fijalkowski
> > <maciej.fijalkowski@intel.com> wrote:
> > >
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > This patch is inspired by the check[1] from sashiko. It says when
> > > overflow happens, the address of cq to be published is invalid.
> > > Actually the severer thing is the whole process of publishing the
> > > address of cq in this particular case is not right: it should truely
> > > publish the address and advance the cached_prod in cq as long as it
> > > reads descriptors from txq.
> > >
> > > The following is the full analysis.
> > > xsk_drop_skb() is called in three places, which all discard a partial=
ly
> > > built multi-buffer skb:
> > > 1) xsk_build_skb() -EOVERFLOW error path: packet exceeds MAX_SKB_FRAG=
S
> > > 2) __xsk_generic_xmit() post-loop cleanup: an invalid descriptor in
> > >    the TX ring prevents the partial packet from completing
> > > 3) xsk_release(): socket close while xs->skb holds an incomplete pack=
et
> > >
> > > In all three cases, the TX descriptors for the already-processed frag=
s
> > > have been consumed from the TX ring (xskq_cons_release), and CQ slots
> > > have been reserved. However, xsk_drop_skb() calls xsk_consume_skb()
> > > which cancels the CQ reservations via xsk_cq_cancel_locked(). Since
> > > the buffer addresses never appear in the completion queue, userspace
> > > permanently loses track of these buffers.
> > >
> > > Fix this by letting consume_skb() trigger the existing xsk_destruct_s=
kb
> > > destructor, which already submits buffer addresses to the CQ via
> > > xsk_cq_submit_addr_locked().
> > >
> > > Note that cancelling the descriptors back to the TX ring (via
> > > xskq_cons_cancel_n) is not a appropriate option because an oversized
> > > packet that always exceeds MAX_SKB_FRAGS would be retried indefinitel=
y,
> > > which is an obviously deadlock bug in the TX path.
> > >
> > > Also move the desc->addr assignment in xsk_build_skb() above the
> > > overflow check so that the current descriptor's address is recorded
> > > before a potential -EOVERFLOW jump to free_err, consistent with the
> > > zerocopy path in xsk_build_skb_zerocopy().
> > >
> > > [1]: https://lore.kernel.org/all/20260425041726.85FB3C2BCB2@smtp.kern=
el.org/
> > >
> > > Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx =
path")
> > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> >
> > Maciej, maybe your tag is missing here?
>
> IIRC this has been taken as-is from your patchset. The next one has been
> touched in few ways and I included my co-developed tag there.

Yep, I mean maybe you can simply drop your reviewed-by or acked-by tag
here if you approve.

Thanks,
Jason

>
> >
> > Thanks,
> > Jason
