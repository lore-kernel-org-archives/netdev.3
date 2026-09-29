Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEAA3AE1A9
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 07:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790668768; cv=pass; b=jhJC1YLimCZgF2ZYXfNA09d7eV7kXGJi0XXVOss/xEBnNXZLgSnfGFjQFY5PFKrc6KGkafyYykTBJYNoVc0AJFhfe1VK6Z8bGnvr7Y1zy9AXoEvOQtdyusVyf6aRlXsAK04fKjf5xfGBGRjbTWWcwkacF5ilZSKjLeztwvtKcmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790668768; c=relaxed/simple;
	bh=+c9CaXcVsE5LXfWUXY3RZpGZB5aXlbGB9s1bsp1BM/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LxFFBIc3WItedZGp/Zb0cuyXvSLx7vDxKTQdaKEBr0w1KLsFwEErE38w9WMMZt9m6Ixn6+9hzqDk/YkHEnqvK9SskdEuT73EliF85OwTyURtF46B77nq5zTtlkDvREIUMMROKwoVy3bYMkGlee1Oks12pXih7xq/oEA6nbDPwIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=j+S4jwKV; arc=pass smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="j+S4jwKV"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4aa0f1766so2079708a12.0
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 00:59:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790668766; cv=none;
        d=google.com; s=arc-20260327;
        b=b2NiZfwdmjAzGJBhgAhs7MVz2YJUJMc89JpX7fhr41mIhyBDeLMUwXCDMNGVeB4EQe
         EcoqoFBgQe+gye02bdp3C2lefcpR8zuL93DK9uabN2TEiyIpkZaD/fIcxW43VIZUYAwa
         4bD5wQnQYfZ+bsW9mOruwkDLztbnxYgG+zf30X4hYS3vcvVhBvhV4uiPoyqr+5qO80ru
         bIfhsdRFf7StFJ2yKUrYt+Javh/wiefZZGT+nPXu+XjL0/l8pyPIAtgchOz8Gl40jGf+
         0oQhQJfnhxxeRm12wO7f+04O55sxcfjd4xWbLAK/B5UwjzFFSkoDNBirwjd6IXVvNWFG
         Uc7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KPz3exU3bEoQdiHlrFqJmk2ezPovXeSnJsGmP91aYCs=;
        fh=v7tmpfrnO1gyT1bseUtGw9DH4It7MgSJeuUZLuzY804=;
        b=mjXLLLzqSNvrmcnfZ1AtTctDoG7v0TIdG1RCn+kP2N8xYXAiMYDd+wxQE+lMMe2atg
         F4Ed2QhJz8eP2YT9t0oOOTadWRaAjFndLzqch3+L4RVmmzTROncDMKXmibsKgdXmRqxH
         MjHeii375F7kGV9Kvj4K7qWk5hdtOwp6I2BwuOMX6UChQH4g2Bp6GtXj/S78LBbQa9DW
         gXTXNqzlsDLRKU0QIdtFonf/5euN4WMd4dS2Ul39fUIn4YxhzgrpIafQO5gQRkvS0Ilr
         atWgCOS8ukd3a02TeNDoK9Elel4cvw3GnzEPzE/xtejGJMlmP2TMEdYaJ2NM/7B5Rdcl
         qGlg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1790668766; x=1791273566; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KPz3exU3bEoQdiHlrFqJmk2ezPovXeSnJsGmP91aYCs=;
        b=j+S4jwKVI4nG3Key4M9cRw0Y9dr3VPyT62Ef+uRNDBeL8dczs7F3wU4bkltJVoHjCA
         WYnGLo+cnUXBvJIIZTFRktmwT5/rjeK9+IQCbC5+wUNr5+E6w/qAdGk9gPEZ+C3SXxOi
         zrgtXzsZbKs7J/qX8N7U6ch9/INQtIOgCqShc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790668766; x=1791273566;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KPz3exU3bEoQdiHlrFqJmk2ezPovXeSnJsGmP91aYCs=;
        b=uVphYwUEYJpLi33vhTRgYaj5xfBU4So2K1JLUGEsb3NgGS6SIqE8qOWEUb8Xpja12Q
         JyUcPc4gmIHW2kre2fshE/Rf7otktnykCkZNNpbNkFNthZbfCW21PXLmuiJumI+2m2aW
         9Y8mRZBRhdplGZUxpsPc9UBLno+IagYHMaM84++duEjb2Zh6zVzACXxayP/6mdWGNd9A
         DEdNnGDrAfcm7CzBGejsWSs5xqPXH6NH3MITbtucK8HZ8npa5zMeN1QIdNNO8hnfavm+
         jQ9X8FesNdwHgHGt2ZOIVg/fJe6VKpRgb7W8DgyphanY2jsL4nUCGHBdIcdXOeLLaS/d
         aPWw==
X-Gm-Message-State: AFuF++lS8ndC1ED0Zh4/czT1iyYvum/OW4dBCizBI4Bd2indp50u0Br4
	6NhEu5ulx+lmw0WC8uTXZZkna6+Gf0SCu7spGjxgtByKFL7j9zsUrFqxDoTMDjDrrZ0/tpXH9pF
	13NGQemwSTcNi2oAXAX2tHMd11uouRAa/daleowPD
X-Gm-Gg: AYBFou0yMpLckMDfHutGTMuKO79Lwt0K3UsmqfhafRvGcShhvHPMLEeYap6YdYTIb0R
	pK6GsR/P2Hol0wtNlSDTnYZ1K/1iGTo/D7exWwpXEOnu+1kY9AYhwgb7LYPrCXs21WCz3AwwED3
	9BDGsnANaKpdUiVEvwXSGgHNPKsU7h56wWiiHqVw8QeLbENDqCY4Twrdsfd/Oa0RUBzINrhkJSI
	FkZIizhR7SL90+QtLcKxQL22T2ZerTMuEADem2844SaLQh9fb5G7gR6liLq3WoVHg2pgca2Uu36
	Glyj+DVuGe4PTHCyuF1Bamgklvybaw/tQUhrMms8lPS2Dt9ki2s/LGNKZFWiC4Y8oaB+Gdr/19w
	n6V3J1409bcsWkJUAdbGD5YEu2RcbQPX0PQ==
X-Received: by 2002:a05:6a21:a394:b0:3dd:a007:cb2d with SMTP id
 adf61e73a8af0-3de26db6f57mr10473666637.41.1790668765702; Tue, 29 Sep 2026
 00:59:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-BA27.v2.20260926123300@mojatatu.com> <CANn89i+99jPh7JjZf=G3Ouaom2tuOtAEiHUf2MEsRdVPd=nz4w@mail.gmail.com>
In-Reply-To: <CANn89i+99jPh7JjZf=G3Ouaom2tuOtAEiHUf2MEsRdVPd=nz4w@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 29 Sep 2026 03:59:14 -0400
X-Gm-Features: AclHuK-XjHMnvK2h7VZJ_VfwefFe2EjB9zY891AR4NBwsMK0bxiTSEY--zE7rLg
Message-ID: <CAM0EoMnH_k1Zk_rDt_vCHGBQRCePG9=g8LKkFkXAVSOSNQE0Ng@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net/sched: cap the accounted backlog before
 it can wrap
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Victor Nogueira <victor@mojatatu.com>, hybris <hybris@mojatatu.ai>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>, moeller0@gmx.de, 
	cake@lists.bufferbloat.net, Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 8:34=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Sat, Sep 26, 2026 at 7:49=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.co=
m> wrote:
> >
> > fq_codel, cake, codel, pie, fq_pie and dualpi2 account every enqueued
> > packet's stab-adjusted length into a 32-bit sch->qstats.backlog.
> > fq_codel/codel uses it do decide if they should drop a packet at deq;
> > cake uses it to prune the longest-flow heap from per-flow backlogs;
> > pie and fq_pie use it to make early drop decisions and, dualpi2 decides
> > must_drop() on it. RED can can decide on a child's backlog based on it.
> > A crafted tc size table (TC_STAB) inflates qdisc_pkt_len() up to
> > QDISC_PKT_LEN_MAX (1 MiB), so a few thousand packets wrap the counter
> > mod 2^32. The AQM algo then reads a small backlog and makes the wrong
> > drop decision, and the dequeue-side subtractions keep the counter corru=
pt.
> >
> > Fix:
> > Drop at enqueue once the accounted backlog would cross QDISC_MAX_BACKLO=
G
> > (U32_MAX - QDISC_PKT_LEN_MAX), the largest backlog one more maximum-siz=
e
> > packet cannot wrap.  This follows the existing bfifo/gred approach
> > (safe because its limit is checked against the accounted packet length)=
;
> > the fixed qdiscs' limits are packet counts or otherwise do not bound
> > the aggregate bytes, so they need the byte bound here.
>
> Hi Jamal,
>


Most of these look reasonable.

pw-bot: cr

cheeers,
jamal
> Thanks for reworking this for v2. A few comments on the implementation:
> 1. QDISC_MAX_BACKLOG check
> Since QDISC_MAX_BACKLOG is already defined as
> (U32_MAX - QDISC_PKT_LEN_MAX), it already reserves QDISC_PKT_LEN_MAX
> of headroom below U32_MAX for the incoming packet. Doing:
>     if (unlikely((u64)sch->qstats.backlog + qdisc_pkt_len(skb) >
>                  QDISC_MAX_BACKLOG))
> accounts for the incoming packet size twice and forces a 64-bit addition
> at every call site.
> Why not just check unlikely(sch->qstats.backlog > QDISC_MAX_BACKLOG)
> (or provide a small helper in include/net/sch_generic.h)?
>
>
> 2. sch_cake.c (cake_enqueue)
> There are a few issues with how cake_enqueue() is handled:
> - The first check is placed after cake_classify(), which has already
>   modified the packet's DSCP (cake_handle_diffserv()) and updated
>   set-associative hash state and host bulk-flow counters in cake_hash()
>   (srchost_bulk_flow_count / dsthost_bulk_flow_count) assuming the
>   packet will be enqueued into flow.
> - In the CAKE_FLAG_SPLIT_GSO branch, the second check runs after lines
>   1780-1801 have already updated b->max_skblen, shaper timestamps
>   (time_next_packet), qstats.overlimits, and scheduled &q->watchdog.
> - Walking segs a second time on every GSO packet just to sum slen is
>   unnecessary, and calling both kfree_skb_list_reason(segs, ...) (under
>   the qdisc lock instead of via to_free) and qdisc_drop_reason(skb, ...)
>   triggers duplicate drop tracepoints for both the segments and the
>   parent GSO skb.
> Since QDISC_MAX_BACKLOG already leaves QDISC_PKT_LEN_MAX (1 MiB) of
> headroom, a single check at the very beginning of cake_enqueue() before
> cake_classify() is sufficient and avoids touching the GSO split path
> altogether.
>
> 3. sch_fq_codel.c (fq_codel_enqueue)
> Can we move the backlog check before fq_codel_classify() (or in the
> !q->filter_list fast path before fq_codel_hash()) so we do not compute
> the flow hash for packets we are about to drop?
> Also, please mention in the commit message that wrapping q->backlogs[i]
> to 0 in fq_codel causes fq_codel_drop() to leave idx =3D 0 and dereferenc=
e
> a NULL flow->head if flow 0 is empty.
>
> 4. sch_red.c and sch_fifo.c (pfifo)
> In red_enqueue(), red_calc_qavg() reads child->qstats.backlog. In your
> commit message example, child->qstats.backlog wrapped because the child
> was a packet-limited pfifo (limit 100000).
> Shouldn't pfifo_enqueue() and pfifo_tail_enqueue() in
> net/sched/sch_fifo.c also guard against qstats.backlog wrapping when
> used standalone or under other classful qdiscs?
>
> Thanks!
