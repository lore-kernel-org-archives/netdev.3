Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAEB38E5DA
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 05:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786945010; cv=pass; b=rF++mrcGtDwjwe2XG0u/xv7iMjeDo1L/moe8lErGwX5StjQ2xltQbg4oqhr5ChcKxSbzQLBmdICmTeKAa8+bHq5L5b6qEjQyvBRF/xD+8omvS8mfVnSaK3Q+PE+yVxYD4er60kTXwD9rFWZxs9OK8tOhmRYY+v+2nF34NhgAXAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786945010; c=relaxed/simple;
	bh=5ARhpaNgj1YgyqYtG3+vKqC8U27pj3Ms1FZigYJs9wM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B/6IrMZzaFM3ZXl8Jcg6Y46uFVAQu8BAMzI+zQgtftxFI5YsqZ8/Ds1k60xgNJJgheCbdcn9VcKIWe4TWnP6VokOaKyfvJg1qgvc8EzjNWFehoOCPpAiSq4b4igpVvXvS2UTgtTBS5YTrgWUi21YCg1Ih/wK+hcad1LRU8LS8Ug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IWELpIBM; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IWELpIBM"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51c1372f84dso20836501cf.2
        for <netdev@vger.kernel.org>; Sun, 16 Aug 2026 22:36:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786945007; cv=none;
        d=google.com; s=arc-20260327;
        b=DwKZ94wAOoWqhFpWwISTG6qb+MtFYPY/1JtmygKdnU/mXVhZUBDriYC0wzz+43ql7a
         mcB41nt7XrCjjQgDFOFSGh/RYQl3u9RQ2nFIBaDelFbTVXt7ikL8oi7QimfE4/2WwRGA
         71i0pQ7s2lJOBvrhOw/wcDq5Zmg1dz5BKbYs7gIqca5TWydM1dqv9SHbzhXdbMUmQ9su
         Et1pGCnr9vfz1aQdjUri4Piwu/vPqaThQyt5rbj5JgMIlVQEWSki6Y40Wq0bDKhspUfV
         R2BtxcGq11LkZmKif8uiVxtf+BjjYFv2iY35sosaYD78uNMk6u8o18yXAyuVkAEu3mTI
         nHFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CeDevZ7cdK1O4Cwh/dUTCyuk4LDTBhPugIXaYpgRn+4=;
        fh=ZMaRGZvi5/cR8bmSdaJz7Wc6JLd/BTsGw7edE7OPiEs=;
        b=f2TMym/cS79KFgL9ROOrCW4SxP58tBG+W18E5LGmXGqPdy0coG1R5O74+IH69QEkzQ
         qvTfyXJ0XS9V9Z4url699aQvLYM83kgQHIUoLcsmg72AHN6xmUsdztXlQ0FRSZtdqXix
         ezJhmQbGj5aWIZM+HyfV+plPk5Y3jm3Rz6LAmTFwcAT4nD95WZLP9mgR5foPKNm3Ifzp
         0BLuJYQyfXa/gvCwtw42wrRAdOv0Rsm+xqqfiTpd/n0uGAsYDAoHNUMqmqXJLnbCLg1o
         C4eBLe6LPRGYZpSBh0Vjsd1MdOeXzmuazerU1C+/rbILyQgakbLrnB4O0pGvbZLp/QWo
         ol7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786945007; x=1787549807; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CeDevZ7cdK1O4Cwh/dUTCyuk4LDTBhPugIXaYpgRn+4=;
        b=IWELpIBMp02+UF3onyrBmmLJdyPXTUBcbCENOnxEW95ecICHn/SgLTzzNLveoKfrPJ
         JDEWU3rdl0jDpdg0hqJOAVriG4MhixfyGXrgYfQWH42T+TS96cvRI3moMsEkvDBPdxYr
         E9P26/Aj1qgLyDQHq9ygXdpm9dd2Mec+g74FxyYf17TlPOuXQpgHETSMyV0TcV5NGBKu
         FmXfoljD9Cz1VvX3MJZkj4Fy6sDOWgQ2ELmuuXkkN3CX7GFiN66BklyT0soEwfv7ceai
         rK8gNNaaBowgprV1oW45oqgLgxZz79J4MxJ9BsfXP5grMIs+4AhjkiNNNY72XJCyKJyx
         6h6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786945007; x=1787549807;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CeDevZ7cdK1O4Cwh/dUTCyuk4LDTBhPugIXaYpgRn+4=;
        b=VgpmkXDYA8Su3IdBGhcQYcldvc/+ZNXKhxMSdW6G1AfdAuanXPYzbLtdGcvf7WauSB
         7oFmIYetL4i3QQYoHMCZGpSUvsBkB7QOSFl88KjhTCud63CSpfogyadD6cC4LAuhbVpP
         6SeQ/r1RekiJIYrEzS4tL/B3j43qOrESjW/Ns3YbIf56WDsCieZ76o2akTPecfFzVv69
         IeTDA+/Kl0gzkCv6+/G7QrlcTuY8RCrAGhiedKpyGK4PTjG2430H0Yj9vQ7bZuceJL9j
         oa4E66kgGjpvnUQWr2r5mhg/TQLVRy0V3sE56qQLbUitopR2lPwjQeMn/XwcTn3lEw63
         hSMw==
X-Forwarded-Encrypted: i=1; AHgh+RptEjocU2ck0uO8isZmMo36DENv0qMUJ4hf+qdaZuDJ/5a/zZHChg1EhDzcuBMZYjPgsrWNKCI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5b5i7Dp4UL+FpwMkTccWqymWck2CR/xbGm2/XUtxkw7SRarHw
	sPbfoRLWq1qRvTFWMyiN9DbukVYjf3yq5jXVOJqu9oL3xWCOFrFatcoPgUQN6Xly7jDTGVqGZcO
	1T+aZ8CapFQOFRcfh0anATomXTaBq/8/T9Y7QiqUUl9yAybpZXaM8BtHRaY4=
X-Gm-Gg: AR+sD12sbnjokYNcs2ebzsn2qQgN4QTjMeV+JvpB+Pm10xA1KBiBQifn9BwcSJ8229h
	Fr2vw/lV5mEgEqosO8avEQzU9xTdaYTBhrvcsA1I2GxFiVljcRmLypx2nqhLrKCnjLtfY3jF3Ln
	JF/ucv9yuW0bZdeJ2uj5mnAnvbhHNqJHMLe6rit4coW5W3knGk2zXV5oPOIinplvLF4uE1NTeVN
	ACv9mgMegkFCQKBMhj9YGqVDclDoH2XH0QEprn1akT6YallZxQok0wv/a2ElMP4RG1xPrW9kdhH
	axzUjViQ3Mvn2WNoP7sm2q3IrmloITG3PGYJettz7HAPw3pgDaZsm+OsaklBe6ctgzISmotJ6EZ
	a0g3Wo3bPrL+16nrnarlGvHdNHU33j6qDCALzEx+ndHaXQ2F/d1XDwsBL0gA7XpLxijCR9OveuG
	g/fwA+agqcntDiC1mwkQOqP6mz/Q==
X-Received: by 2002:a05:622a:c9:b0:51c:bb79:a52d with SMTP id
 d75a77b69052e-52d854221b7mr212476131cf.14.1786945006478; Sun, 16 Aug 2026
 22:36:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <af7dabf3-d0d7-46dc-a878-e1715b3c9ac6@I-love.SAKURA.ne.jp>
In-Reply-To: <af7dabf3-d0d7-46dc-a878-e1715b3c9ac6@I-love.SAKURA.ne.jp>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 17 Aug 2026 07:36:34 +0200
X-Gm-Features: AcwNN1V79Tx8968YxpaZBfBp4Ao_S6G5jM-sTJxrZ2GUli7UCFD1ASkCDTD8bqc
Message-ID: <CANn89iJbT_e5CxtStQNcsCTt5OqaqsexUPgdDk5MY8R6jn2Tdg@mail.gmail.com>
Subject: Re: [PATCH] net: add missing ref_tracker_dir_exit() to net_passive_dec()
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Jakub Kicinski <kuba@kernel.org>, Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 16, 2026 at 2:26=E2=80=AFPM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> I found that trying to read /sys/kernel/debug/ref_tracker/* causes NULL
> pointer dereference crash when alloc_netdev_mqs() via unshare() returned
> NULL, for commit 9ba74e6c9e9d ("net: add networking namespace refcount
> tracker") added ref_tracker_dir_exit(&net->refcnt_tracker) to only
> __put_net() path.
>
> Since preinit_net() calls ref_tracker_dir_init(&net->refcnt_tracker) and
> ref_tracker_dir_init(&net->notrefcnt_tracker), we need to make sure that
> both ref_tracker_dir_exit(&net->refcnt_tracker) and
> ref_tracker_dir_exit(&net->notrefcnt_tracker) are called before
> net_passive_dec() schedules for kmem_cache_free() via net_complete_free()=
.
>
> ref_tracker_dir_exit(&net->refcnt_tracker) is called via put_net() when
> ns_ref_put() returned true. But put_net() is not called when copy_net_ns(=
)
> fails. Therefore, call ref_tracker_dir_exit() from net_passive_dec() if
> put_net() is not yet called.
>
> Analyzed-by: sashiko.dev (no mail address)
> Link: https://sashiko.dev/#/patchset/b06ce35d-e7bc-47a5-8e0a-e82be7e4dd08=
%40I-love.SAKURA.ne.jp
> Fixes: 9ba74e6c9e9d ("net: add networking namespace refcount tracker")

Note that the crash only became possible when debugfs support was
added to ref_tracker (via Jeff Layton's
patch series: "ref_tracker: add ability to register a debugfs file for
a ref_tracker_dir").

Once ref_tracker_dir_init() started registering entries in debugfs,
failing to call ref_tracker_dir_exit()
left dangling debugfs nodes / state pointing to freed memory after
kmem_cache_free().

Reviewed-by: Eric Dumazet <edumazet@google.com>

> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  net/core/net_namespace.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
> index 6e9a0c29a9a0..4915ea7b2374 100644
> --- a/net/core/net_namespace.c
> +++ b/net/core/net_namespace.c
> @@ -530,6 +530,8 @@ void net_passive_dec(struct net *net)
>
>                 /* There should not be any trackers left there. */
>                 ref_tracker_dir_exit(&net->notrefcnt_tracker);
> +               if (!net->refcnt_tracker.dead)
> +                       ref_tracker_dir_exit(&net->refcnt_tracker);
>
>                 /* Wait for an extra rcu_barrier() before final free. */
>                 llist_add(&net->defer_free_list, &defer_free_list);
> --
> 2.55.0
>
