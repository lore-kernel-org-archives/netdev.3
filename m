Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD1D4D990A
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 22:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792362733; cv=pass; b=WQyvKHBuSn4QCD6DwpcQwGVD5kfAwUl4KSo5XdKXaRIOAb+D+XtMm/WEJ/uWtfbCY9kUsykiy9jJ0OtOwL6OHy99keuV9X2Kek3MNY94IPyEDq5xX+d/izwVuvQYlSXrGffd9dA4m6YA//ooo0++pdcH6y9NSvQgL+bIoUNBh4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792362733; c=relaxed/simple;
	bh=EpvAQ69oX2PZfPd7/XNk/kWpL7ZP4lCDG9GHkZbyLdg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a/lzGPh4bM3u1sTbBBpeCCDI0UYOHfJEujypXKWMJloF/Iui6RNAqkFi1neS4I6R/8X3UkQBv8Si225870KNRRNPDlXMVTyz6Ln7+DYR+GxtOeQ8/xUtu4G/j4ACb0eO6LGVqwJngqpUUFoCXagWwE/q8Kfzlq+1W/OnFkFh7OY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=LNoH3+WV; arc=pass smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="LNoH3+WV"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8a052aff9e9so857891b3a.0
        for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 15:32:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792362730; cv=none;
        d=google.com; s=arc-20260327;
        b=L+R1cfb2NEUj77jNFIhgqWSiA9FDPUVN7vzD8EJm5e51lEKQNqZIuBXHecBAInpZPc
         DaWNOIZpSmj+jiUB9XKDBbE6pAp1P0OYEC0tcKd+G5YSKC5k429D0cKh6UWKm9Ty+2Vk
         CPPsFE+DTX/ROSqxoxZ9Zl81/mx1gWLUT8HKsWytsdUOgvwEHJ7+wXd/CSxVPkm+cbZC
         rvFFIBXusYuwX3xgvIla6321x2tqlv1zM3Bww+FVt5aaUCKG0w+OFW9qJJYpJgVyDWeM
         0zReUPPjWGoTvw+UnQas3saj/neRJdV64xeWhnFGdIvkLnZz6t/ZM8eC5JA9dnodXUX/
         WeaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=538lzUoX6jPHx1owv0jysMnR5L7Iq3ebRGIPhVTonyc=;
        fh=9xNLnmA1j3K9b7tSiC2ucxw35zvgnH4CLwMd+I+lXKg=;
        b=SOhXvEuOrMcDA9mqgP5yFv03Wij2ES0xjieGpAYs6PUbrlASdY3/V5xrJZBGJ2dmIm
         A6IL4NEhRngGTShHfpO6uKl9tPoMfUaFgrziQytnl8nCSx522R2VoZbdMaXmJJRVOb5A
         4u6BUqhh30hnyQiY6xqEnmsss+4GmhWxBdFjEiK8jVXA/gwGetQ6vuVY9eK829BI9d+n
         ZJK73B9SY3GQmgaBlS786wnoBkkWvhbKHC6elNJkvMnpqNTtjuvk3rOjP5DCsxmvYSPf
         T3hmXwpm0yn4Rblid+DIqTLa2eeYKv6ZocpJjPQwZFkDze5uBecmpOFRhEZVm8wKHjGG
         W95g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792362730; x=1792967530; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=538lzUoX6jPHx1owv0jysMnR5L7Iq3ebRGIPhVTonyc=;
        b=LNoH3+WVb7kGda3VE5gFJR8BANrFitkoH6oaDhF35fOETpLhewxipz7OjK8rkYwiVQ
         GjQvKysNO2cIfIuxMKvtJekWsPjlEoW4u9lKz6FboKCxGwznA4RHpTYsYUI3SV6ZHRox
         b4Yo6MS5kltt+RWGy8eLAf5CbvK5aEEy37OCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792362730; x=1792967530;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=538lzUoX6jPHx1owv0jysMnR5L7Iq3ebRGIPhVTonyc=;
        b=R21iqNzbZlnqXlMAfwoI8f0mGrU+P7bF2tZYiK7I/FF4daKezxVZs06ZTCHuZ0hXGc
         9EDjw/TECCUY3ZmtM+PdTwpwMeEa1SIYhS9Z0CqRBcM6tsdwzDF1mMUU1uSJwo+qBbCZ
         1ioqC9niF/mC+j9VdY078TKzpDSOrE5oMuHdvfC30fBpZBlo4o0X2cMQm5AB6K314Dt7
         3zqyvaGyz/HvIUPko5pGhdb1ZfxkH2W2NL8veeWF+TZRRqyZH6Gy8+sj058ZSyyyKbWU
         cUndGaBxqL3hVMprOX8FLZriNqE8uMJ92eXWiuXhYPtbCV5bRemeqSisQiVKjva3PRS7
         yZTA==
X-Gm-Message-State: AFq9FYILkN+0SrbJ9LZl1yBHcT7lB7snFqIwDVOqr6upoB0xkfwR1jlw
	7mJjCMHwt29PQyYO2+4bl7+fABrCHQCz6QWteYu/hTgRvnocveWr94i0MeNJZ+bnj6XHVLHQU6E
	H13G4n/0msmVISyZsEG6VEgJYxy5WEHMZMMXIslJJ
X-Gm-Gg: AYBFou0xf7mjX0TWjBit1J4KzcRTGbtZj+QD0TEaFMkZTL5aFIVkQ9xoZGC58qA3MDA
	/SZ1hW28B8Mw1W7SvlT9paEm/zs1B7PiJIm3ij/JFX/QdoXT2tnY5cpGE+3QLmoAFRZe0QdVXbg
	NDM5J+eDgpglx0b/FMMIE0bLwcyMgfhB7aJ0gxvJ7uu1g30EgNn5ZliJdrT9dz2M+FDHDfmPr5R
	i2/6/wXWYybFCvFHrDhpfNsgTvYT6kReEOvGY/LhpTjeMLkMkVpYUTyZQvYk+HKHMBQWd3FTPiY
	MyX6aTMYtj3jagM8OM1+TAs62z7bdup92z9dWJAJxYVG/Ayz2Y7dA0Mb0Xl3wWGR5bXMXd+j9pC
	tN4Iprm8ctCNuOHAXqol7lcJrwZ3DViLbIA==
X-Received: by 2002:a05:6a20:4310:b0:3de:80a3:cc30 with SMTP id
 adf61e73a8af0-3e225fe03f2mr4804348637.19.1792362729717; Sun, 18 Oct 2026
 15:32:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_2D4F4848C75F5AE9E26589170CF60CC4DD08@qq.com>
In-Reply-To: <tencent_2D4F4848C75F5AE9E26589170CF60CC4DD08@qq.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sun, 18 Oct 2026 18:31:57 -0400
X-Gm-Features: AclHuK8Fr-SvjE7bV0jfcKnvIZEK1eXgf_dfYq6_pa6v26cqsECV8L2OQiffThk
Message-ID: <CAM0EoMkBPWyMKBem2pjvL9Ko0zwpHvBRt7JB7H1rg7L8+zc25g@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: act_api: collapse duplicated slots in DELACTION
To: Hang Nan <2122295973@qq.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 18, 2026 at 12:58=E2=80=AFPM Hang Nan <2122295973@qq.com> wrote=
:
>
> A batched RTM_DELACTION takes one reference per slot in
> tca_action_gd() and drops them one by one in tcf_action_delete().
> Every slot also calls tcf_idr_delete_index() with the index it saved
> before the put, and that helper drops the IDR reference as soon as
> the count reaches zero.
>
> Nothing stops userspace from naming the same action in several
> slots.  With N slots holding the same action the request takes N
> references, performs N puts, and calls tcf_idr_delete_index() for
> every slot whose put did not reach zero; that helper drops the IDR
> reference again each time.  From N =3D=3D 3 on, one drop lands on an
> action that has already been freed:
>


Nacked-by: Jamal Hadi Salim <jhs@mojatatu.com>

See: https://lore.kernel.org/netdev/QDISC-K1TH.v1.r3.20261012134653-1@mojat=
atu.com/

cheers,
jamal
>     refs =3D 1 (IDR) + N
>
>     slot 0: put -> N,     delete_index -> N - 1
>     ...
>     slot k: put -> 1,     delete_index -> 0  (idr_remove + free)
>     slot k+1: put on the freed action        (refcount underflow)
>
> With two slots the second put is the one that reaches zero, so
> __tcf_action_put() returns 1 and that slot skips the
> tcf_idr_delete_index() call; the accounting stays balanced, which is
> why the bug needs three slots.
>
> A three-slot RTM_DELACTION for an unbound gact action (index 0x1002)
> on 7.3.0-rc7-00245-g32c52ec87d62 reports
>
>     refcount_t: underflow; use-after-free.
>     WARNING: lib/refcount.c:28 at refcount_warn_saturate+0x59/0x90
>     Call Trace:
>      __tcf_action_put+0x7e/0x80
>      tca_action_gd+0x439/0x640
>      tc_ctl_action+0x10a/0x170
>      rtnetlink_rcv_msg+0x14c/0x3f0
>
> and returns -ENOENT, because the IDR entry is already gone.
>
> Collapse a repeated action while the slots are being resolved: the
> batch keeps the first reference and releases the extra ones, so the
> IDR reference is dropped exactly once and the delete succeeds.
> Comparing the resolved pointers is equivalent to comparing
> {kind, index} and also covers actions that live in a per-action
> IDR.
>
> Fixes: 97a3f84f2c84 ("net_sched: remove unnecessary ops->delete()")
> Signed-off-by: Hang Nan <2122295973@qq.com>
>
> ---
> This report was produced with the help of AI tooling, so per
> Documentation/process/security-bugs.rst it is being reported publicly; th=
e
> reproducer is not attached and is available on request.
>
> The two kernels were built from 32c52ec87d62 with the same config
> (CONFIG_NET_ACT_GACT=3Dy) and run the same initramfs.  A batch of two dis=
tinct
> actions is deleted on both.  Two duplicate slots also delete cleanly on b=
oth.
> With three duplicate slots the unpatched kernel prints the warning above =
and
> returns -ENOENT, while the patched kernel collapses the batch and deletes=
 the
> action (no warning, rc =3D 0).  Each kernel was run twice with the same r=
esult.
>
>  net/sched/act_api.c | 29 +++++++++++++++++++++++++++--
>  1 file changed, 27 insertions(+), 2 deletions(-)
>
> diff --git a/net/sched/act_api.c b/net/sched/act_api.c
> index 9eb1dec..dc51ccf 100644
> --- a/net/sched/act_api.c
> +++ b/net/sched/act_api.c
> @@ -2021,11 +2021,28 @@ static int tcf_del_notify(struct net *net, struct=
 nlmsghdr *n,
>                             n->nlmsg_flags & NLM_F_ECHO);
>  }
>
> +/* A batched request may name the same action in more than one slot.  Ea=
ch
> + * slot takes its own reference, but tcf_action_delete() drops the IDR
> + * reference once per slot, so a duplicated action must be collapsed bef=
ore
> + * the deletion starts.
> + */
> +static bool tcf_action_batch_dup(struct tc_action *actions[], int n,
> +                                const struct tc_action *act)
> +{
> +       int i;
> +
> +       for (i =3D 0; i < n; i++)
> +               if (actions[i] =3D=3D act)
> +                       return true;
> +
> +       return false;
> +}
> +
>  static int
>  tca_action_gd(struct net *net, struct nlattr *nla, struct nlmsghdr *n,
>               u32 portid, int event, struct netlink_ext_ack *extack)
>  {
> -       int i, ret;
> +       int i, ret, nact =3D 0;
>         struct nlattr *tb[TCA_ACT_MAX_PRIO + 1];
>         struct tc_action *act;
>         size_t attr_size =3D 0;
> @@ -2050,8 +2067,16 @@ tca_action_gd(struct net *net, struct nlattr *nla,=
 struct nlmsghdr *n,
>                         ret =3D PTR_ERR(act);
>                         goto err;
>                 }
> +               if (event =3D=3D RTM_DELACTION &&
> +                   tcf_action_batch_dup(actions, nact, act)) {
> +                       /* The IDR reference is dropped once, by the firs=
t
> +                        * slot that names this action.
> +                        */
> +                       tcf_action_put(act);
> +                       continue;
> +               }
>                 attr_size +=3D tcf_action_fill_size(act);
> -               actions[i - 1] =3D act;
> +               actions[nact++] =3D act;
>         }
>
>         attr_size =3D tcf_action_full_attrs_size(attr_size);
>
