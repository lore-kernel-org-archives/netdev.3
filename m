Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792641251;
	b=n866RDxeFCZlL4yNMGShtKs8dtUIIPp5tNU56I65cNB5J0IF1KhzwHy1uTJJw5lzL7Nu
	 jnFKOEXSIIGYrW0DclmWOQ4+TptUEU+tRTvxYTacVL6RMbI2oqjqPvCM78XORcscvpTbC
	 Y0Br3pR2rTUoOPmHFGL/0jOtAhMlgU/Wu7BrlcuhX/0dXIamTukBZ0StotwWckYEgHHnU
	 rKqUa0dkzMRqSBC+zPWagSC5seUCVRk9mTb36CfwQyZbZ6nzYj6SNTwgJKO3xlFpjHj+4
	 gjGRW65sf3eJqYI53DocOHbpK5PM3+kKZR47Zm2tlICmJbjeFOIoTTTH43upQb+qmvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792641251;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=xEoTQ9N/Tf+sH4oyVMEnoem256sSy7IUWX9i50eKFv8=;
	b=derzU9HOXLN/c6AroiNoR9gz+xzjh6PXoiT/Tt3Rily4OMpvCubiiqgvzFmjsAlYPg6o
	 u+XXEmS+UeXahjLVCsUuLEpmeHkYx3HD3aF9LxC7fv9nYprgC9MCy7rZSQQ9y28ndAS4c
	 i72wHXjfY87fo5FOMycqN1OLCjOtrDtfCu4A96irshiKAf84W+3Rlu3m2xGa1SN+7D0JI
	 yV0Xp2Vf18tg2dz9IPfyrOI4mRJ6BwqxGn56CvIWoaxWCYt+5U6rGnJdOvPlCzZuKZr3Y
	 9iFa0ovDI5vAglU80VPIEXF2MklDj94pGuCxBAsSvHp1Y+rZvCgn0qwQSqg/riP2oFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=baBKQxV+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51911606A327
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 03:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=baBKQxV+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2D451F000CD
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 03:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792641249;
	bh=xEoTQ9N/Tf+sH4oyVMEnoem256sSy7IUWX9i50eKFv8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=baBKQxV+L2zV88aADSZl53MJEoBXHTQUWT553YgvDZ4Fub7KVSSh/iwPCIo61JpGi
	 iaUKQSnlHxkfFa89o6QfoJzwnYvbQHnxoq3JlLItBhR4KNky6ros29878rdmM3Zain
	 01zgmpKMWCm+RKOtwWlB7nj8XuQuPmW8JEkpw/9VBVXtXjPFdVKC9qwRT2Ku+9WWuE
	 /maDT98FV74H7Gyjrw0VSeuXcoNjUhwyJId6k3TxJwcxhnN3usnK7zF5XU05+qWZW2
	 8iaEI9cjUPvy3H0iQ5TKGH03ZZOm8eJWMTB0dL3PoLnWGdL9Xd5m53LJ+3yDT/NxYv
	 V68zO2A1sNp2w==
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6df7f544919so803838eaf.1
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 20:54:09 -0700 (PDT)
X-Gm-Message-State: AFq9FYJNxGB4cIHxfwhp62W8Dpb1XGyrBTS+FGjk35fgu4+LDApl1Qxc
	GtOOPVBL4J/6k9NXkQ0e+floeecaHAMlvVBjdfbilp8jHZca6oFCCGSuXMDC0BD7+EzhTDVTQU1
	Now25Hqln1G9DAaS9ACfpW6f2rCyH2U4=
X-Received: by 2002:a05:6820:c8b:b0:6d6:bd40:5cc9 with SMTP id
 006d021491bc7-709422cb82emr2490276eaf.90.1792641249241; Wed, 21 Oct 2026
 20:54:09 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1792607608.git.zhilinz@nebusec.ai> <2773af2572ff59055933e407a135b39bca537381.1792607608.git.zhilinz@nebusec.ai>
In-Reply-To: <2773af2572ff59055933e407a135b39bca537381.1792607608.git.zhilinz@nebusec.ai>
From: Eric Dumazet <edumazet@kernel.org>
Date: Thu, 22 Oct 2026 05:53:57 +0200
X-Gmail-Original-Message-ID: <CAL4WiioBzbo81K2EVw8UQG6w70JS3D80GNoDndXFfcG-qAhUEw@mail.gmail.com>
X-Gm-Features: AclHuK8N5ds3Fw9LF2Dx9sFZR46QYMs5QxSl65xz5Fzea10VnJ8VVtAmE9IYTNI
Message-ID: <CAL4WiioBzbo81K2EVw8UQG6w70JS3D80GNoDndXFfcG-qAhUEw@mail.gmail.com>
Subject: Re: [PATCH net 1/1] tcp: release congestion control reference on rejection
To: Zhiling Zou <zhilinz@nebusec.ai>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, ncardwell@google.com, 
	kuniyu@google.com, davem@davemloft.net, pabeni@redhat.com, horms@kernel.org, 
	jonathon.reinhart@gmail.com, vega@nebusec.ai
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mer. 21 oct. 2026 =C3=A0 20:57, Zhiling Zou <zhilinz@nebusec.ai> a =C3=
=A9crit :
>
> tcp_set_default_congestion_control() takes a reference to the selected
> algorithm before checking whether a non-init netns may select a
> restricted algorithm. When the check fails, the function returns -EPERM
> without dropping the reference.
>
> For BPF struct_ops algorithms this keeps the struct_ops map and its
> programs alive. For module-backed algorithms it leaks the module
> reference as well. A network namespace administrator can repeatedly
> trigger the rejected request after the algorithm has been loaded.
>
> Drop the reference on the rejection path.
>
> Fixes: 8d432592f30f ("net: Only allow init netns to set default tcp cong =
to a restricted algo")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: LLM
> Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
> ---
>  net/ipv4/tcp_cong.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/net/ipv4/tcp_cong.c b/net/ipv4/tcp_cong.c
> index 8e83ef81fc187..907c63af14785 100644
> --- a/net/ipv4/tcp_cong.c
> +++ b/net/ipv4/tcp_cong.c
> @@ -293,6 +293,7 @@ int tcp_set_default_congestion_control(struct net *ne=
t, const char *name)
>         } else if (!net_eq(net, &init_net) &&
>                         !(ca->flags & TCP_CONG_NON_RESTRICTED)) {
>                 /* Only init netns can set default to a restricted algori=
thm */
> +               bpf_module_put(ca, ca->owner);
>                 ret =3D -EPERM;
>         } else {
>                 prev =3D xchg(&net->ipv4.tcp_congestion_control, ca);

Thanks for the report.

Instead of taking a reference only to drop it, please move the
restricted check before bpf_try_module_get(), as
tcp_set_congestion_control() already does:

        if (!ca) {
                ret =3D -ENOENT;
        } else if (!net_eq(net, &init_net) &&
                   !(ca->flags & TCP_CONG_NON_RESTRICTED)) {
                /* Only init netns can set default to a restricted algorith=
m */
                ret =3D -EPERM;
        } else if (!bpf_try_module_get(ca, ca->owner)) {
                ret =3D -EBUSY;
        } else {

Also for v2:

- BPF is not needed to trigger this, and the module case is the
  interesting one. Any restricted module CC already loaded by root
  (e.g. tcp_bbr, not listed in tcp_allowed_congestion_control) leaks
  a module reference on each rejected write from a non-init netns.

  module->refcnt is a plain atomic_t: after 2^31 rejected writes it
  becomes negative, and every following module_put() hits the
  WARN_ON() in module_put(). An rmmod would then hit the BUG_ON()
  in try_release_module_ref().

  BPF struct_ops use an atomic64_t refcount, so they cannot overflow

  Please describe this in the changelog instead of the
  struct_ops/OOM scenario.

- No need for a cover letter for a single trivial patch.
  Your cover letter is adding noise, any LLM is able to rebuild a POC just =
fine.

Please wait 24 hours before sending v2.

Thanks.

pw-bot: cr
