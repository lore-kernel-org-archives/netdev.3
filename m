Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F82E41DEF4
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 09:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789379926; cv=pass; b=fxb9SPUxKGVTDHPXSVXWIQmdnHpmfuubJKiFKhNcHnTCIxRn5yhmUy1OL4BSixrDk+nndalSQsP29gZOGD9E75FOVSbT/xKTP8o5nShEDVfwFSd+g6mOylN7LMJWY9cC0U79s08YsQMxKzUSmKka6ZxlHqguD6iI1b5Cmg0wduQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789379926; c=relaxed/simple;
	bh=ekZMqPqix1SfSP0Jg3oOTYIzLY1yHdpuXfG/BQXJszg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YhxFMg8X+ly20sNDMOLaOYtrfvJPBoE3VCAZuKl5S8vH2CCboguAllMNa6AprXK30lXCH+f1EchszZVdcTmOHP9sfc0KG+oBs4gSqIWxYAzMTs9ZeT6JUPPAqX2FcWDW32c1EdK8XgmZ4SSu4awF9BjzbkNKIBLKdub2IYdVLT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=fOqlnwcA; arc=pass smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="fOqlnwcA"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469a34907so1614284b3a.1
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 02:58:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789379924; cv=none;
        d=google.com; s=arc-20260327;
        b=A7drcONQ3frTUI/KkliV2A9gMv4OkK3E56iJxHLd65ZR/1Qfry/c0j/9aa0OnW/MWb
         CWCJEvFuI24Vm9BD5rJQSDEeH+CNUp/ldHLZH9AMmXhsiJZibO3SvE82gPALOAtne6Wc
         inoyfizEWXm1b0rrdAw7tEGlgmxxKk+/at96qx6ppbpwNGbbh2UPTqN4bdF7b5HHlR2A
         mdwHnK4TxNQvo8InfEozBSTwT6EBUVQ3DI8BoG4KpabMNGbjVwgr2EwiYVZIIhSom9Oa
         nJVi/gZduAuH+nGhN2F8/uuuAY6NT3Eui3hsLz+hbZGZGndS0jrhkkis/lQJpXw9ss5/
         YzOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BUfuwTxWoTd9y0Vz5pkLwXMFS5QksVwR4BkTSHrTGWs=;
        fh=4kV6CtTEL24+0sDCgpZbDUgZbxTipZsdP1DV10uyfeo=;
        b=V0UGGPXCBCpQ4gEG8sB7bJcOxjS0NMzNszDZEhTtiopzlNdVBhXV/bffQ6H4SC4Rcr
         3Ea85D0uk21zrJBgDG5JvPNmFUYzdKCf+B5hWvD4BTuAQxRTq7hyNkT+wfFrmL6bE7rd
         wfvDpxxdb9SqOcqU7teNqIQGjvegOR+9UWrzMd0MFDJL5wzt/CEnW9i7mGWA0ZBSyWGe
         /TKL8oTY36cqgjSsbw/qan0QtiaMVtYe5VRO/CN1LE9Pv5pjn5mndOYic1sBLAaV0xa4
         3RhQrnKJv/htweVqSuPLFcZJyVZTS7eLwF0l0xr+0QWAp1b3+rofsIwbTxs80Y9rXEUE
         X4xQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1789379924; x=1789984724; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BUfuwTxWoTd9y0Vz5pkLwXMFS5QksVwR4BkTSHrTGWs=;
        b=fOqlnwcADDqMlbQQYzNj+1S4I93vphCKDJkd5RG3EstL6/VcFbWd+3b7TGYiYSvKrR
         ag7WcZ6g8IkDs0AEqLjBtQzzoh9tIUgOQczP49+RTeBouQf5+xhDYaNHUCX1/d2/rKrI
         kcaMH9c1oZ1ejOYJ0sWnwpifzVnt/6HiE3aHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789379924; x=1789984724;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BUfuwTxWoTd9y0Vz5pkLwXMFS5QksVwR4BkTSHrTGWs=;
        b=i5cPCC7drdi8uP39dSOsqTPncXvDMvsLVYwAVGeFdTSSgvO/wJ57ZByeauzL9AdhPD
         HxHru1mi1ceIrqFM4d3KAj4FrOmZf6DryWOhTq+TKFz6xD5Rj5Zf/SnWeHumc3vyQlzp
         B1Mj3QuONiehuCkHHKUGLERkKjqtAaAZDxADsJYeltBaQ8CAmyYP1RoJtkCyBVWPTO0D
         9gCMtM+M43K4Gacytx4D3vyGAr1OZFcqixVNaRotSgRf4KW5uOag4WJJSKjOzSdJu0gY
         QH38Q8EptRba3ku0Dmr2pdRFu5Gwp9pzFxnHkO85h5t9zdl5C6QVVmCAxzeDxv1lKlxH
         ZB7g==
X-Forwarded-Encrypted: i=1; AKwUvByOy16KvAMX5TkX4SSK8eC5SLjK9XjDE8sdoxM0dDTSB9J4ENWfZuGy9XMjChLjOKw62E2q7wU=@vger.kernel.org
X-Gm-Message-State: AFuF++n8x4gX/oBmMhPiBF8Jx/flpH4OCXfDM9h6yNSHlPlaFkZyr6ze
	z0lgSoaJlwQyTjjdIIQ8W7ODsnJFstnSZuSO8CLb1uTrMliKzkZfImxxlw0uN7eL5zLkl1b8zHQ
	zqE6k24wlQUaMrgKSqq2Oe0dPs9PAOCIqkZG8DIhd
X-Gm-Gg: AYBFou3oQCFEBjnIPPr0r+Q+YQmhC+gFgnfVG9BGgKfzBuQNsKPaNpLWSim0fdoB32f
	xckiMS3EMbbNJDSVgA7xSymsUhKMdUye+CZJ4GuPT8aALk+/6TGAY1iwiMHuSywBenaFBjGEcL3
	n2A1EOg0AiHHFELjltoCvr1K4Ydc+Hw7TVkGnY11uOEh11Dia6aIX/l4Vte998X+AvW+ymaAw4D
	XqvC3ryL0UGlP0j8r8/Jg+cOPuvjX8vd6NPls4La+i+qIwNZFJIKRLQDc7rB+E7d0l0cTY5GILf
	J1DqjJ598v6q/81kv9Qhx40g9lhDamOKShj5+4Qd6tSMshHEw/P2jbK+WgM6ytv6/yXeb2mfUpd
	MQP2aMVtdYnjo9T0tEEbOZy5MT4alpYr5yA==
X-Received: by 2002:a05:6a00:94d3:b0:857:7337:5db8 with SMTP id
 d2e1a72fcca58-86f85ae8211mr3629691b3a.22.1789379923820; Mon, 14 Sep 2026
 02:58:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914065123.4109709-2-bestswngs@gmail.com>
In-Reply-To: <20260914065123.4109709-2-bestswngs@gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 14 Sep 2026 05:58:32 -0400
X-Gm-Features: AcwNN1U_PEiBsILbnOHs9gCzos_UIObxVxzcwVGwW6bTJBXfjAYney-md8aD38E
Message-ID: <CAM0EoM=7jH_OqmbERPVNrFg7Q079g2f1oWOKiO4nRLA3Zxcm3A@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: reject IDR error pointers when deleting actions
To: Weiming Shi <bestswngs@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Vlad Buslov <vladbu@mellanox.com>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
	Xiang Mei <xmei5@asu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 2:51=E2=80=AFAM Weiming Shi <bestswngs@gmail.com> w=
rote:
>
> tcf_action_delete() drops the reference held by its lookup before calling
> tcf_idr_delete_index() with the saved action index.  An unlocked
> classifier can remove that action and reserve the same IDR slot with
> ERR_PTR(-EBUSY) in between.
>
> tcf_idr_delete_index() only checks the lookup result for NULL.  It
> therefore treats the reservation as a tc_action and dereferences
> tcfa_bindcnt.  A hardware execution breakpoint was used to schedule the
> interleaving without changing the kernel source.  KASAN reported this
> decoded trace:
>
>   BUG: KASAN: null-ptr-deref in tca_action_gd+0x5b9/0x1010
>   Read of size 4 at addr 0000000000000010 by task poc/150
>   Oops: general protection fault, probably for non-canonical address 0xdf=
fffc0000000002
>   RIP: tca_action_gd+0x5c0/0x1010:
>     arch_atomic_read at arch/x86/include/asm/atomic.h:23
>     raw_atomic_read at include/linux/atomic/atomic-arch-fallback.h:457
>     atomic_read at include/linux/atomic/atomic-instrumented.h:33
>     tcf_idr_delete_index at net/sched/act_api.c:766
>     tcf_action_delete at net/sched/act_api.c:1859
>     tcf_del_notify at net/sched/act_api.c:2014
>     tca_action_gd at net/sched/act_api.c:2064
>   R13: 0000000000000010 R15: fffffffffffffff0
>   Kernel panic - not syncing: Fatal exception
>
> R15 contains ERR_PTR(-EBUSY), and adding the tcfa_bindcnt offset produces
> the address in R13.  With the guard applied, the same reproducer returned
> -ENOENT without a KASAN report or panic.  Treat error pointers as absent
> and return -ENOENT.
>

We test all submissions to tc. Can you provide a tdc test or reproducer (Po=
C)?
Please remember tto do his for any future submissions. If the
information is sensitive, please send it to me privately.

cheer,
jamal


> Fixes: 0190c1d452a9 ("net: sched: atomically check-allocate action")
> Cc: stable@vger.kernel.org
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Assisted-by: LLM
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
>  net/sched/act_api.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/sched/act_api.c b/net/sched/act_api.c
> index 19501dc99..eabe612b7 100644
> --- a/net/sched/act_api.c
> +++ b/net/sched/act_api.c
> @@ -758,7 +758,7 @@ static int tcf_idr_delete_index(struct tcf_idrinfo *i=
drinfo, u32 index)
>
>         mutex_lock(&idrinfo->lock);
>         p =3D idr_find(&idrinfo->action_idr, index);
> -       if (!p) {
> +       if (IS_ERR_OR_NULL(p)) {
>                 mutex_unlock(&idrinfo->lock);
>                 return -ENOENT;
>         }
>
> base-commit: e6b6078ea1731b05b3b552497b3bce4bf8b014ae
> --
> 2.55.0
>
