Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FB2412C17
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 11:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787914977; cv=pass; b=P95AlQ9rQhsm6Cani+BkEGasZXAxNatWXA2+2wlrN7DfPFLVKSled7faz3VzMv/WdhnEbsWV9gmJ+ufbpJtkAt2fwaFO96zgjaAxsbHJtYMIzKJ43MQHAh94Z9R7CmbVc/Xz2Z5knF6Pp17b8sRR82inO6L/44byM+yFlZ5byE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787914977; c=relaxed/simple;
	bh=gpIFjKFqNx1M+mi/+eHtLwGh46kv7Jb2uCc+Wo5YwJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a35fAkJq9U0+JSVNZKKfsNdBbYYx2oFL36UHWAin4CuRnbRRO24C6Fy9QKFLKM/DJEq3H65w8131xw3X6jfpWwzFbbV0eMUHQIK94SlvsnNg950/pAzhe3oidz3ZpPhd34BqqwoPxFQWY+MPMc08nJFn7DYSnaxl4koEf/SgGLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=pacftvbk; arc=pass smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="pacftvbk"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84f38f3b36eso863119b3a.1
        for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 04:02:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787914969; cv=none;
        d=google.com; s=arc-20260327;
        b=D7uVfCprfUDggs3sGNIitexgPtFy5syO4MRdZKs4enPo2FFwxqo5Q8iO/ZHUMuqicO
         s1FRHxxrnSBJCHoSqxXIMNmvthiH26HtISuAy83zZiAsuziDIOR3iepz/dJlkk4icK8U
         1Kewj8l9k8pQUiSXbytUHafSbnaWj43wwMWrLgtHU840n4fA4zxi/HxLwuvN3XfT0Y6T
         TjrkTkeFT8uGlkPY+XQ3+dq/GA19rvhG5Xp6uiwLdFiDfIL0KZHFwR9zFv/Psyx3Aup4
         bfWF7gsmsnjrP+YlgGSRqrY+RBDv/3/RlZSa+aW6eBnlH0p/ZGP53vWZzVzjlpm7FACk
         nuvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GZPn2t55uUQtWn+e2wBwLty86elpm5h5HddwIpEVEuo=;
        fh=VdIE8irQdMztvZvWd7pFJTH0S7KpJAO7/sagonXu1Kk=;
        b=N1UuU2EEkLuC0yd1znp9WiVmHDpCYto/K28JlInfLEgq4U3rLUc3quq2sE4P2DBn7b
         rZaWyUqodmAm+GZApZwCQy+u+GTgvc27jZQgmtLAmWQupm+1t4aDL9pkkjqkLI3cwZa+
         Tv/cQo7La/wRCEslxafCkZDhMzIt/lP0TG/mYhIIZrLrkYpYNDRar8VX9PMs1wLXFvMY
         CMD+JVCzPeiQmOv6fZEe8sCRKlE5fYU1JeOyFStQ0NJMD1Rcrw0pSUF5ppdDpnlqt92D
         sZfxKBpABI4ZVnnl3I7S8eDRAdwv3GcSGaFl1zeyBxuzxCWKTvSLm9Ew7/1mm/ZtOQ5U
         zFbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787914969; x=1788519769; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GZPn2t55uUQtWn+e2wBwLty86elpm5h5HddwIpEVEuo=;
        b=pacftvbkNgn6eWAQ+nvriBa9jGNbIr2Anq5uf/0V4Rs/uLfPOTESACwiQVdhO75JmB
         h0zW99O3SYFn6+qtkcw5HL4q/jO9Pmd/u01/9CK4n1DUP42WlNrc6h8VkVl19niki+Bg
         8xeLPwXluEA7tleq2ygEaO2k+g6oVmB4nYhtg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787914969; x=1788519769;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GZPn2t55uUQtWn+e2wBwLty86elpm5h5HddwIpEVEuo=;
        b=qFjctKVuS8QPbjL7DpQn9K8h6TUldd2wnPcc5p5yS1PMDA+eSFRV5JpeU3wAEog3Gh
         T4LOQ2jr42COek8DCZFcxT2oR503OO6jr/M6Q1UWMGGMpcw2I+JqliMGqQjdGexygAMH
         S4oj0QEycxPGVZI9g8GI9DqRgUfRU6CQFtEo2cfvc22GTiVzBxhBVwrHtfjY8EWBMd3D
         OqV5a4A5GBFeSbO7kv/2wSeVdeLFdZqRYLkRz3J4t0MVzPhog3zQ3XrWQOW5XvfWpJHB
         8+Ml2nvkVqMT7HDWiWLGuvLZZcW/+K0d1jO38rqH81W2I+OUKBc+vfgyr4OKtJWaZu6w
         EPjA==
X-Gm-Message-State: AFuF++mfH7oz9Fv9dmX9UIMrBUF1kcMZ0YuSdXpcU+bCgsl62jfDEmnu
	ydfxb/fdIDe2mtZ4uqLaHGQGY0fELK7/31dsaM9qD2OIiWnhNJFKvacSL3JTsWVimDOtoGWZhFq
	lEjsJra6pxykI6zy3KldGeYaQoV5qV0cGSGLcoUwt
X-Gm-Gg: AR+sD11enCz0eBHM23BnqmTMrvHxnXK0025WABogMcvddJSvA467JF8iEdSYiEsaSmN
	KNtHeZRP921Bfv958+QcBm85NNGE18fAz11QY/ntg3sVmRwXn2bbVNtAZEEEQ3eWuys+bdgJhrx
	B+70UtlBxwtqwm8Z7CuIkANZ1AR9bHlYCA+xtAAQh+u9M2/oHkroaDO/9Wz+AKf3onAP0PH7zvO
	3mMgvJyCRZrlcY92LD5hs2DpB/LDALIqUCIMNM8o3HpIxjqeCBCVSrkosW73wvrpD4FYQ4BF8dl
	QyEI9XghN0ef0iqh2QAiHyyTxU2JJy9zDaIRDzvLyhtU6T9OWo7jREiea053oCeEwgHXomeVWhP
	cr5u1R8mr9aD8Q9LGxAMCDD0NeaY=
X-Received: by 2002:a05:6a00:f04:b0:848:2c2e:c79e with SMTP id
 d2e1a72fcca58-8562b498507mr13806728b3a.12.1787914968372; Fri, 28 Aug 2026
 04:02:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825081751.134086-1-jhs@mojatatu.com> <daceef26-eae7-49c3-acd8-0908bd6a31dd@redhat.com>
 <CAM0EoMkJdo_e5VYPRcPN2mZpNyrTQ43FxNvkqFSNDjyV9x45dA@mail.gmail.com>
 <38a2e111-799f-4c8c-b46b-501999f71e52@redhat.com> <CAM0EoMnV66aObnjNJg-FLbvXaE21b1_K-yOJ1s==+z+xj5RnEg@mail.gmail.com>
In-Reply-To: <CAM0EoMnV66aObnjNJg-FLbvXaE21b1_K-yOJ1s==+z+xj5RnEg@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 28 Aug 2026 07:02:36 -0400
X-Gm-Features: AcwNN1VoHD5i7PF84EaS3zQlKqco2v_CfCqD7w1P9-OmJDzCtP7wO0_FbEQP4Xs
Message-ID: <CAM0EoMkXybVnrmic2NDfRR_U=MyQo9UwNJqxhnSqaydU0wPzmw@mail.gmail.com>
Subject: Re: [PATCH net v2 1/2] net/sched: pfifo_fast: reject oversized ring
 and account to memcg
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, stable@vger.kernel.org, vega@nebusec.ai, 
	Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 6:29=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Fri, Aug 28, 2026 at 2:28=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> w=
rote:
> >
> > On 8/27/26 7:39 PM, Jamal Hadi Salim wrote:
> > > On Thu, Aug 27, 2026 at 7:26=E2=80=AFAM Paolo Abeni <pabeni@redhat.co=
m> wrote:
> > >> On 8/25/26 10:17 AM, Jamal Hadi Salim wrote:
> > >>> pfifo_fast_init() and pfifo_fast_change_tx_queue_len() allocate skb
> > >>> ring arrays sized by dev->tx_queue_len with GFP_KERNEL and no upper
> > >>> bound. An unprivileged user (via unshare -Urn) can set a huge
> > >>> tx_queue_len and attach many pfifo_fast qdiscs to exhaust global
> > >>> memory, causing a system-wide OOM.
> > >>>
> > >>> Reject tx_queue_len values exceeding S16_MAX (32767) with -ERANGE
> > >>> in both pfifo_fast_init() and pfifo_fast_change_tx_queue_len().
> > >>> Note: For the init path, NL_SET_ERR_MSG_FMT_MOD reports the error
> > >>> via extack whereas for the resize path, the error propagates to
> > >>> netif_change_tx_queue_len() which rolls back dev->tx_queue_len to
> > >>> the original value. Use GFP_KERNEL_ACCOUNT so the ring allocations
> > >>> are charged to the allocating process's memory cgroup.
> > >>>
> > >>> S16_MAX is the virtio virtqueue size limit: the virtio specificatio=
n
> > >>> stores the queue size as a u16 with a maximum of 32768, so 32767 is
> > >>> the largest tx_queue_len any in-tree driver can meaningfully use.
> > >>>
> > >>> Conditions to recreate the bug:
> > >>> - CONFIG_NET_SCHED=3Dy, CONFIG_VETH=3Dy, CONFIG_USER_NS=3Dy, CONFIG=
_NET_NS=3Dy.
> > >>> - Unprivileged user in a fresh user+net namespace (unshare -Urn).
> > >>> - Create a veth pair, set tx_queue_len to a huge value (e.g. 500000=
)
> > >>>   while the devices are down.
> > >>> - Attach mq at root, then replace each child queue with pfifo_fast:
> > >>>     tc qdisc replace dev veth0 root handle 1: mq
> > >>>     tc qdisc replace dev veth0 parent 1:1 pfifo_fast
> > >>>     tc qdisc replace dev veth0 parent 1:2 pfifo_fast ...
> > >>> - Repeat across many veth pairs. Each pfifo_fast allocates 3 skb_ar=
ray
> > >>>   rings of tx_queue_len entries (~12MB per qdisc at QLEN=3D500000).
> > >>> - On the unfixed kernel this exhausts global memory in ~28 iteratio=
ns
> > >>>   on a 2GB guest -> OOM panic. On the fixed kernel the oversized
> > >>>   tx_queue_len is rejected with -ERANGE.
> > >>>
> > >>> Fixes: c5ad119fb6c0 ("net: sched: pfifo_fast use skb_array")
> > >>> Reported-by: vega@nebusec.ai
> > >>> Tested-by: Victor Nogueira <victor@mojatatu.com>
> > >>> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > >>> ---
> > >>> v1 -> v2:
> > >>> - Replaced silent clamp + pr_warn_ratelimited with reject (-ERANGE)=
 (Jakub)
> > >>> - Changed cap from 65535 to S16_MAX (32767), matching virtio's
> > >>>   virtio16 ring size limit.
> > >>> - Dropped the doubled module prefix in extack (NL_SET_ERR_MSG_FMT_M=
OD
> > >>>   already prepends KBUILD_MODNAME).
> > >>> - Added resize-path tdc test case (Sashiko nipa gpt-5-6-sol-1-2).
> > >>> - Fixed tdc teardown to use JSON list form for acceptable exit code=
s.
> > >>> ---
> > >>>  net/sched/sch_generic.c | 14 ++++++++++++--
> > >>>  1 file changed, 12 insertions(+), 2 deletions(-)
> > >>>
> > >>> diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
> > >>> index ef2b4bf51564..eb5c0d3f67c2 100644
> > >>> --- a/net/sched/sch_generic.c
> > >>> +++ b/net/sched/sch_generic.c
> > >>> @@ -910,11 +910,18 @@ static int pfifo_fast_init(struct Qdisc *qdis=
c, struct nlattr *opt,
> > >>>       if (!qlen)
> > >>>               return -EINVAL;
> > >>>
> > >>> +     if (qlen > S16_MAX) {
> > >>> +             NL_SET_ERR_MSG_FMT_MOD(extack,
> > >>> +                                    "ring size %u too large (max %=
d)",
> > >>> +                                    qlen, S16_MAX);
> > >>> +             return -ERANGE;
> > >>
> > >> Sashiko noted that setting a large tx_queue_len to a down
> > >> interface gives an inconsistent behavior:
> > >>
> > >> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260825081751.1=
34086-1-jhs%40mojatatu.com
> > >>
> > >> (all other comments are IMHO noise and should be ignored)
> > >>
> > >> I don't see and effective way to avoid that, short of falling
> > >> back to v1, WDYT?
> > >
> > > I changed my mind on this. See this thread and let me know what you t=
hink:
> > > https://lore.kernel.org/netdev/CAM0EoMk8fAACt11fe1pUsFeG9np3SdsV0YUNm=
EevLu=3Di=3Db+xKg@mail.gmail.com/
> > Whoops, I missed the last message in such a thread. I think it makes
> > sense and will cover all the sashiko-reported concerns. You can probabl=
y
> > also additionally get rid of the old test:
> >
> >          if (new_len !=3D (unsigned int)new_len)
> >                 return -ERANGE;
>
> Good catch; that check becomes dead once the S16_MAX cap is in place.
> I'll drop it
> How do i "withdraw" this patch? Is it sufficient to say:
> pw-bot: cr
>
> Based on what you said to Victor: Should i keep GFP_KERNEL_ACCOUNT or
> make it a followup to net-next?

Ignore this part -  i am not going to make any changes to pfifo.

cheers,
jamal
> The tdc test patch is still valid.
>
> cheers,
> jamal
>
>
> >
