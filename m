Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D0D140E5F
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 12:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790598847; cv=pass; b=KCdJGj7MNC06g3hZmzC+POOZcwCtyTYo6WorNmh/Tw+KL2/Rr9O5cPBJPuYWWGzFdvvbLejGVx7Q/153FDkhamNpnRPmwugdA0VfucSPXnovj93xZwbfAo8SBNvbxODt9eo7nuLbllhzSmJLeGYFlwt0R0nuZno9DKNj9I3oQPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790598847; c=relaxed/simple;
	bh=Owjh33g6i0pCXKgFwfHmOLLCD1SdIrozUP34tvIBMns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qW7cQ75RsoPJRrvQOCuR6/ue+h56ol1VIFMFY1bVkn0xQIaAjcvzNHDOrYDYT8x/5Vpg1+Jp5WNz9kkqhWI2298rpIIHrEQOonYZCLYFo2YOhWMb+bS8WJwd0g8vUQBpKBCg8tUMA0EghmRY+eOI2qpFAG/Y74mOIQ8lLvUMmYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q3nXc4lv; arc=pass smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q3nXc4lv"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-530e28a62abso47341511cf.1
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 05:34:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790598845; cv=none;
        d=google.com; s=arc-20260327;
        b=CZL2yGjCFrElUl6d3sdGjIRyP25BKXihnQuzKqzYlLcGL79ZWm5HuOR3KMK75aldp/
         mv0UtEJ/aoJ5HNsRvhcw/P9uiSdt8ESZtAG6YY4rCNLX302Q73E6m8fAGLALHPH723ar
         M0gWuwa6k+cv49zQa7JDSlgwm3SKQufK9LST83ToAOPoG9Vor8YWYNR+O/BARcf9VRLJ
         2Lhb1rOuiHIaq4Fyx2K3VWYJeQQcSKS0PH94Hbrn/h84nEXtvfrok/VbnSF4Vw7Myaxj
         3kWNPeudRDFYvVm+rSj6RrlF2T5xOW11AFbSypQ5TY57QgSMBc1RLjnXuVgAIxsMi9sq
         JLiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U7l+r5+9U0CBVRhBEzoj9hWYpVtHLgr+opW35WkRHB0=;
        fh=ZBqB0NHB3G+gfuKM/R8+S6nA0gcasGrOH96gCEpvEhU=;
        b=NDiQExxiO+Ym2hMePYW3LJqx3EdK8w82y/fffoKOALtZ8jyIH+kM746vc31PJOgjYI
         khHZEjpk5K+TxvUs84GAGYKlZVcZX7hvCyM5DMqXsb8wpd2MK9D0teeUvvS+5xsrpoh+
         P56jexhxCql4iGGcXVAlcnkAiN7zzX00Mn0CLnolpl7OhT66+DfwJOphh0/uKBJpd9VA
         HG33HnParuGLJ+riqX5eBi7qYXwAPczVxMZzmubzvGjGA/sMk+rfd8iI8xvr0rPHwaD9
         1MtQe321KPZxuRz/9NbDch0XVM2XqJuoYkrsXwxPXbiF756h+g7nhj9rCdJWXIMWv9jK
         NZXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790598845; x=1791203645; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U7l+r5+9U0CBVRhBEzoj9hWYpVtHLgr+opW35WkRHB0=;
        b=q3nXc4lvHnx5fMOD9WoyfGwYz16hmC0hANkEy12dKP1DMLEK5s9Y0J0LZhOfcMOJ5L
         zOJHkNDT410PKFeWDa6NCZ5KClUiY8C5FG1B3baehAsDkdXhafPkkaoO4HAtek9ZnVyz
         GwxVguEAe3Ng2w6kyiPCUkhJIIFvtUbd6hdTjfIYCPjTB84OEu+6SeTe5D1GfXP6kmQS
         edNOEkxAZayWv/MIWHEG5R/izbR2P4mNDNTB0AR6ttUC+iho421GvNdBNlg0QBUnEoi1
         qkR1dikzcn76EiGUBEuYpq/h+s2xWaZdbmgbhzg2qR7jIq8inCYUPR4TkpX8uQJRZCDn
         hE5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790598845; x=1791203645;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U7l+r5+9U0CBVRhBEzoj9hWYpVtHLgr+opW35WkRHB0=;
        b=fE0VjbirMz/syYMtWIgZaQMaJ/qaSq7JaPohwHFrDo1oT70OA3iNObCeBc7nrIVUHw
         hW6fShSZ5rThANS6CbDydw9jgkUEFgxXzEIyI7nXwozqX5WrDEGzWF4ogRQjzzW76mLs
         ZJoUf1Mh43wcFoe7o1gPeIgomBMWfm4c+fKF1+CMLr1jBxreuuZvVbgdt8AjAXGqJ/Ri
         reX6c8oqB4cDejNeYJewzaxnZANhUFOsEJ7O9Fna2dQUSeX+lqrj+AxSVMVygt/f4dWl
         G1Bpuvf7AbdE6vcaEIOzIEVgQ/Rz+g3N7TFNKs/7c/lc4KBdLzCYzbLhhSwVmKiurvr+
         STmQ==
X-Gm-Message-State: AFuF++kA6TmcrfyyRVUwyAI7NuPm6Mg6CtX1pXWAuWZPsGlxxzFAtGGa
	kVqlYD0mQcTFN4QJ2fyJJXrx6K7H69+UD2bnjsosGa2f6KPklRjxiPPyGhDdQbzYRq7vnM6iT3j
	813OztdwlNmYKTWBLhReW+vPfcRZlTFufLjqEP5FP
X-Gm-Gg: AYBFou2CG5wCIW9pfp+yLKDJCLtFaMsfUyzPJ3Su/fwn1GFYCf6I0iX6oOUvKrKM1YW
	+sY8Y3UVkLv5acLINuzLuUTF2b+St7M7uKWSpS9venlLbLesXn5IXKPS57xmYT8Coq0abg7Funw
	Zptye28YzHl1SPVPT1uZo0/XvdWqr0XQYqfDYt3cAMDMtQqV0ZUIs0tZ54NuPvgFOMluE71gKeS
	ysEtqtEAbE+6djtwWFNN5f9x9krtXVnhF6V100hJrSex+Ri5zznR/Bz+FWNpfAAw4IsI5Cmq/Ik
	/Q8GmLqaNrplgF2sEoCs0QE7Fa23Mozza61VxEALreLFY5+QMlfdMDhudvzvQ+f/Bb1JsXGMh6P
	W/u3j1xXW5KMRk/2Qsn5QBAAU6djs5KPhWuE4TmdIK71a1PDB3Z2tkT/IhJvL2MlkqiTP
X-Received: by 2002:a05:622a:5588:b0:531:218b:ee3f with SMTP id
 d75a77b69052e-5330dc5ca37mr213290801cf.25.1790598843947; Mon, 28 Sep 2026
 05:34:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-BA27.v2.20260926123300@mojatatu.com>
In-Reply-To: <QDISC-BA27.v2.20260926123300@mojatatu.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 28 Sep 2026 14:33:50 +0200
X-Gm-Features: AclHuK8RHBXbb0dCnDGM6uMwoUbwRNmxLUMXWKrgWCkdRRhvNALrs_kLAxdH6oU
Message-ID: <CANn89i+99jPh7JjZf=G3Ouaom2tuOtAEiHUf2MEsRdVPd=nz4w@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net/sched: cap the accounted backlog before
 it can wrap
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Victor Nogueira <victor@mojatatu.com>, hybris <hybris@mojatatu.ai>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>, moeller0@gmx.de, 
	cake@lists.bufferbloat.net, Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 26, 2026 at 7:49=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> fq_codel, cake, codel, pie, fq_pie and dualpi2 account every enqueued
> packet's stab-adjusted length into a 32-bit sch->qstats.backlog.
> fq_codel/codel uses it do decide if they should drop a packet at deq;
> cake uses it to prune the longest-flow heap from per-flow backlogs;
> pie and fq_pie use it to make early drop decisions and, dualpi2 decides
> must_drop() on it. RED can can decide on a child's backlog based on it.
> A crafted tc size table (TC_STAB) inflates qdisc_pkt_len() up to
> QDISC_PKT_LEN_MAX (1 MiB), so a few thousand packets wrap the counter
> mod 2^32. The AQM algo then reads a small backlog and makes the wrong
> drop decision, and the dequeue-side subtractions keep the counter corrupt=
.
>
> Fix:
> Drop at enqueue once the accounted backlog would cross QDISC_MAX_BACKLOG
> (U32_MAX - QDISC_PKT_LEN_MAX), the largest backlog one more maximum-size
> packet cannot wrap.  This follows the existing bfifo/gred approach
> (safe because its limit is checked against the accounted packet length);
> the fixed qdiscs' limits are packet counts or otherwise do not bound
> the aggregate bytes, so they need the byte bound here.

Hi Jamal,

Thanks for reworking this for v2. A few comments on the implementation:
1. QDISC_MAX_BACKLOG check
Since QDISC_MAX_BACKLOG is already defined as
(U32_MAX - QDISC_PKT_LEN_MAX), it already reserves QDISC_PKT_LEN_MAX
of headroom below U32_MAX for the incoming packet. Doing:
    if (unlikely((u64)sch->qstats.backlog + qdisc_pkt_len(skb) >
                 QDISC_MAX_BACKLOG))
accounts for the incoming packet size twice and forces a 64-bit addition
at every call site.
Why not just check unlikely(sch->qstats.backlog > QDISC_MAX_BACKLOG)
(or provide a small helper in include/net/sch_generic.h)?


2. sch_cake.c (cake_enqueue)
There are a few issues with how cake_enqueue() is handled:
- The first check is placed after cake_classify(), which has already
  modified the packet's DSCP (cake_handle_diffserv()) and updated
  set-associative hash state and host bulk-flow counters in cake_hash()
  (srchost_bulk_flow_count / dsthost_bulk_flow_count) assuming the
  packet will be enqueued into flow.
- In the CAKE_FLAG_SPLIT_GSO branch, the second check runs after lines
  1780-1801 have already updated b->max_skblen, shaper timestamps
  (time_next_packet), qstats.overlimits, and scheduled &q->watchdog.
- Walking segs a second time on every GSO packet just to sum slen is
  unnecessary, and calling both kfree_skb_list_reason(segs, ...) (under
  the qdisc lock instead of via to_free) and qdisc_drop_reason(skb, ...)
  triggers duplicate drop tracepoints for both the segments and the
  parent GSO skb.
Since QDISC_MAX_BACKLOG already leaves QDISC_PKT_LEN_MAX (1 MiB) of
headroom, a single check at the very beginning of cake_enqueue() before
cake_classify() is sufficient and avoids touching the GSO split path
altogether.

3. sch_fq_codel.c (fq_codel_enqueue)
Can we move the backlog check before fq_codel_classify() (or in the
!q->filter_list fast path before fq_codel_hash()) so we do not compute
the flow hash for packets we are about to drop?
Also, please mention in the commit message that wrapping q->backlogs[i]
to 0 in fq_codel causes fq_codel_drop() to leave idx =3D 0 and dereference
a NULL flow->head if flow 0 is empty.

4. sch_red.c and sch_fifo.c (pfifo)
In red_enqueue(), red_calc_qavg() reads child->qstats.backlog. In your
commit message example, child->qstats.backlog wrapped because the child
was a packet-limited pfifo (limit 100000).
Shouldn't pfifo_enqueue() and pfifo_tail_enqueue() in
net/sched/sch_fifo.c also guard against qstats.backlog wrapping when
used standalone or under other classful qdiscs?

Thanks!
