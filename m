Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792651481;
	b=fFBwkZmrXF0Y+b8sCv1luQEiiF4pznENXNbmJDws9f69ZO88mH68qZ8selLxmzjZxdQH
	 qOjmuTTK9hdsyJsdj421jsVkfOB5tW1GnGYNwjX2xH7Oi1plTrbgGNZEYVjnUUFSMrAhP
	 Ea66gTKkvreXtDctLVL7bVXyKL1KMuMbT79HjsnmKLh3xSfSiL3WR0kPhwoLsqu1MC7jT
	 0jEdv7n9KyWFFPTIXsaKo6WNEC+3XGMA3DyzkxRCNQFsEXkiD2Z8AqPtfaxHEKG7zaUnA
	 uaBlQQnP7rL8DQiTBmhQmqsVs76kPe9w2DACSdeERMOEt4u8/ovHOUOSCuAYGBEfgUQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792651481;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=MCbHWxaDd5m11mX2OMZtLnTaVB23BBdwrqf1zDi64Lg=;
	b=kkbqCmn1clhOP/PPnhYDLEy5Nsze8ev1c34XW5nUArRHFRzm0Ij5zPXIuxfxpcBl71bR
	 EChHfcPibD6giq48oLwI1t17b2EcjBhyFLqUU3/qbbLTSDbE3ROg2E0GXIheRti8jRzbI
	 YABrpPnl3rUbVNLN6rghUf2VdJiNTTRh+tfMNKe5W0eXz6LP7YVPqdezGc/8M8u7iNj4+
	 x62mtfxI8Gc6Tv9y13WE1dwogzcdrP1Q79q+QjJTCZs1Qw5NX55rBK8ycwqrbrtNQgv5Y
	 vKmixtV4rKFULz4PTwYdKOTM4e1Rct5r+zehmFICgv5hPaQYbILKodzI9/X0Y1r9KPA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qrator.net;
	spf=pass smtp.mailfrom=qrator.net;
	dkim=pass header.d=qrator.net header.i=@qrator.net header.a=rsa-sha256 header.s=google header.b=Aucjghc7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE465606A321
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 06:44:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE465606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qrator.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qrator.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qrator.net header.i=@qrator.net header.a=rsa-sha256 header.s=google header.b=Aucjghc7
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-35b2c599f43so3399349eec.0
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 23:44:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792651480; cv=none;
        d=google.com; s=arc-20260327;
        b=bMbxWQwC4thOlduRFL/IMq+OClYODOvgGttNRTS+zmmiSu99rOqkoghDFvcl4rbVIr
         znoYS7TmEsR6t8s0NeCMg+IH+ejvYiDSkeY1bOSHfBn3ibFIEnacIyS0ujHqwGu8tY/M
         ON4z+gK5ZibVEoaJsdz0iEqK7OuQdyxMKAZ9vtn0jFSAucxcYUHIrsyCDYrLwFfzEQVd
         jq00ToW/ntRh9SlJzf7YFfvNyoC+q94fNthu1MThxr80kh0kGN6cz9gLpxAvQgsvBreG
         FMSTfl9TRUbWcV1sK26T0p9c4WdAceot8X55lCcVkYSnfF1/ngbcvXUnctsOkHaxvQYK
         LYhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MCbHWxaDd5m11mX2OMZtLnTaVB23BBdwrqf1zDi64Lg=;
        fh=YYrWdH1UQGUpmYqBNI2jHWR7yXanqTHP6Q5NEB3RuUg=;
        b=CLyv9AIicxxb6s++heLU4YEaqnGPFGErTU9780+4BFtzwLILvQaJPQFRTf6MgNzdlq
         qEdvwqdn0P/p342dnODIBvlgkaaqNJkYHD3nuqXHkIWZT2yooVW8nLBTtBnXibR9AhwM
         X0w/A8osbe2OA2Z9padVo3yxEvzYm2sKTSgdjwJigfqWuO479q5eKImnQRArJcPv4vBx
         gbqYDozy75vi+Uu+V2e+eOjIpMpx6ce27X6Rhfel/WPjOIpj2zlKJa6IYINBkKIsZt0q
         GO2TTSUXHRtQ/F9Tccndv4z8SGS/bwPIW8ILDIzOPf/X73SZDyy3l44vYW3JtfrjLBFH
         l/5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=qrator.net; s=google; t=1792651480; x=1793256280; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MCbHWxaDd5m11mX2OMZtLnTaVB23BBdwrqf1zDi64Lg=;
        b=Aucjghc7qN1wHZZyUHPpVDY2KCblcA3gEKXW6x3UcedCP0wRruv2l0W3wfmBQ6MGPC
         SDgjFwaXuUxDCGRrx4b5StFGoMExEqjlgBNTvkFVGB2NdS0HA/zovGWBatCgCZi0nd8r
         5a4B21qjhXVgUQSYtVkYVwPMr7TlXV/ucq4xM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792651480; x=1793256280;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MCbHWxaDd5m11mX2OMZtLnTaVB23BBdwrqf1zDi64Lg=;
        b=aWov4upGvqnxIc+QP/lJagrf8SZpoNH+ZJ04GKCEvNHQEI2qE3ADAaXVUiw7bFMN4d
         VKz+nuWFym3GltNObrMFFFRxN3mGa+Qs3bv6FZQEQMpLZeYgj1LLD8pAZ6DXiWP4F4qJ
         lHdYSy/CvQRgotsm25GfFSx5HPZxRIbDd3MLYlloDq7Krz3KaQU7IXnE0lrKYxp8MxbV
         mZs17JAnqvzQFTA+Esh8LIUIt3iYDq+bQuaMsL4UvmJMM0FWWhr/fTr2Ztv8spjo6VWa
         QRHHfU5ku7hTK20LDGoMSj7vH0q4hon8bShKH26Zfjz97urYvSe9lHGmyZ8+NLEqR8RD
         d4Rw==
X-Gm-Message-State: AFq9FYIGMt8F7IvgG4jHC3cc7O7bEAneDRxmOhcz6A8340KqXGD3twML
	JRiBTGkHDvu/CgFT3KYxCIbsyXbZxzApI9GyCTrm+OfRo22BYICoN7Ao4axIjPdpHZI1uMM7I9w
	Wi8igXGND68sD824WI9ZKlY0Mt1rySejn1gDeZh+1btt7nkOmLmuddfA=
X-Gm-Gg: AYBFou3LF4OUSpp/c29f0BV7jdLYCamlVc9Cjw4bPXH8iyjZRdpt/TEBSUxI1szAmIW
	LXmbfI4/FMDG0daveFMnYGZSU4HNFAI9qhwatdysYw+XTgwLP5E+hx6D1B45F/pAvXQSFzTlkLO
	9HrqIL4F2f75cwzy4iDYhjFBHCfTVNf0XgeGYRMUiU4/oIRYkQlwvMGDdILw7hF5VbC7mRUnquc
	wvqZ8gdzJsUFtDRhhNx1cq6rwC2cvP25VJg2apded5vzjzZr1Dt1etMp+IhvNIe1mupReAy0Ofz
	2Uv7ojYlRFkqraFY1w8SD3V8GgDAjUIHWCcGuNPG9uIOTh7P3tnb4jIIQqjzj6q6aaBk1v2M75m
	br55sNNfVpQOHy0M9zRbdeGpW7lNbGmQ93yYiPPICYVXGss3HQwdW+D8LLWZAr26uwOQG6nNNCW
	eQF8a05D2O11HyMCE8VJALytUxnnClKZyLe4MXkDBmu8MLlmnzChgZrWA=
X-Received: by 2002:a05:7301:92e:b0:342:645a:5cf with SMTP id
 5a478bee46e88-3674b82bb89mr5836454eec.1.1792651479652; Wed, 21 Oct 2026
 23:44:39 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260926193136.9715-1-green@qrator.net>
In-Reply-To: <20260926193136.9715-1-green@qrator.net>
From: Alexander Zubkov <green@qrator.net>
Date: Thu, 22 Oct 2026 08:44:12 +0200
X-Gm-Features: AclHuK8oMTaAIjshAC4qw-ROm2BYzxKWd_TuU2k9ktru_iGtqMEwhAn1I6rs6h0
Message-ID: <CABr+u0Z+iYwnEoSZLW80Buq7y0B2kXi8EJ84oQhzmCLY6sadyw@mail.gmail.com>
Subject: Re: [PATCH iproute2 v4] ip: ipstats: Merge statistics split across
 several netlink messages
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, Petr Machata <me@pmachata.org>, 
	Ido Schimmel <idosch@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stephen,

Have you had a chance to look at the updated patch?

PS. Some recepients might have already received the copy of this
message, but it contained HTML elements and was rejected by the
mailing list. I'm sorry for that.

Regards,
Alexander

On Sat, Sep 26, 2026 at 9:32=E2=80=AFPM Alexander Zubkov <green@qrator.net>=
 wrote:
>
> The kernel can split the statistics of one interface across several
> netlink messages. ipstats_dump_one() formats every message on its
> own, so the interface is shown twice and the attributes of the second
> message are dropped:
>
>     109: vlan859: group offload subgroup l3_stats on used on
>
>     109: vlan859: group offload subgroup l3_stats
>
> Buffer the message instead, merge into it the following messages with
> the same ifindex, and format it once another ifindex shows up or the
> dump ends.
>
> Fixes: 54d82b0699a0 ("ip: Add a new family of commands, "stats"")
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Alexander Zubkov <green@qrator.net>
> ---
>
> v4:
>  - Fix the truncated message guard, NLMSG_PAYLOAD() is unsigned so
>    the test never fired.
>  - Return -ENOMEM, not an errno the fprintf() may have clobbered.
>  - Drop patch 2, unreachable once this one is applied.
> v3: https://lore.kernel.org/netdev/20260910092057.3980-1-green@qrator.net=
/
>  - Merge rewritten along the lines Stephen suggested: no attribute
>    counting, no classifier, no refusal. Only the top-level nest and,
>    for bridge xstats, the one inside it can be reopened.
>  - The invariants moved from the cover letter into the comment above
>    ipstats_merge_attrs().
>  - Mask rta_type with NLA_TYPE_MASK, drop the dead addattr_nest() NULL
>    checks, malloc instead of calloc, no err out-parameter and no
>    separate ipstats_msg_merge().
>  - One deviation from suggested version: the depth =3D=3D 2 test is moved
>    above the two scans. At that depth there might be no nested
>    attributes.
> v2: https://lore.kernel.org/netdev/20260908181225.31712-1-green@qrator.ne=
t/
>  - Trimmed the comments and the commit message.
>  - Dropped IPSTATS_MERGE_MAX_DEPTH.
>  - Only the boundary attributes are merged.
>  - All of the merging decision is in ipstats_merge_classify().
>  - Do not index ipstats_stat_ifla_max[] with attribute type 0 (padding).
>  - Use addraw_l() to copy attributes.
> v1: https://lore.kernel.org/netdev/20260830181949.1096-1-green@qrator.net=
/
>
> Notes:
>  - Reproduced on Linux 7.1.5 / iproute2-7.0.0, Mellanox MSN4600C with 121
>    netdevices, 31 with l3_stats; the split is visible in strace sa two
>    RTM_NEWSTATS messages with the same ifindex.
>  - The merge was also exercised by Claude out of tree against offload
>    xstats cut between HW_S_INFO and L3_STATS, bridge per-VLAN xstats cut
>    between two BRIDGE_XSTATS_VLAN entries, and a leaf attribute in both
>    messages.
>
>  ip/ipstats.c | 140 ++++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 133 insertions(+), 7 deletions(-)
>
> diff --git a/ip/ipstats.c b/ip/ipstats.c
> index 8a2ac85e..47fdce2e 100644
> --- a/ip/ipstats.c
> +++ b/ip/ipstats.c
> @@ -850,12 +850,68 @@ ipstats_show_one(int ifindex, struct ipstats_stat_e=
nabled *enabled)
>         return err;
>  }
>
> -static int ipstats_dump_one(struct nlmsghdr *n, void *arg)
> +/* The kernel resumes a split dump by reopening the top-level nest it st=
opped
> + * in and, for bridge xstats, the nest inside that. Everything below is =
whole
> + * and nothing at those two levels repeats, so join the two halves at th=
e
> + * boundary and copy the rest.
> + */
> +static int ipstats_merge_attrs(struct nlmsghdr *n, int maxlen,
> +                              struct rtattr *a, int alen,
> +                              struct rtattr *b, int blen, int depth)
> +{
> +       struct rtattr *last =3D NULL, *rta, *nest;
> +       unsigned short type;
> +       int rem;
> +
> +       if (depth =3D=3D 2)
> +               goto copy;
> +
> +       /* type 0 is 64-bit padding, possibly on either side of the split=
 */
> +       for (rta =3D a, rem =3D alen; RTA_OK(rta, rem); rta =3D RTA_NEXT(=
rta, rem))
> +               if (rta->rta_type)
> +                       last =3D rta;
> +       while (RTA_OK(b, blen) && !b->rta_type)
> +               b =3D RTA_NEXT(b, blen);
> +       if (!last || !RTA_OK(b, blen))
> +               goto copy;
> +
> +       type =3D last->rta_type & NLA_TYPE_MASK;
> +       if (type !=3D (b->rta_type & NLA_TYPE_MASK) ||
> +           (!depth && (type > IFLA_STATS_MAX || !ipstats_stat_ifla_max[t=
ype])))
> +               goto copy;
> +
> +       if (addraw_l(n, maxlen, a, (char *)last - (char *)a))
> +               return -EMSGSIZE;
> +
> +       nest =3D addattr_nest(n, maxlen, last->rta_type);
> +       if (ipstats_merge_attrs(n, maxlen, RTA_DATA(last), RTA_PAYLOAD(la=
st),
> +                               RTA_DATA(b), RTA_PAYLOAD(b), depth + 1))
> +               return -EMSGSIZE;
> +       addattr_nest_end(n, nest);
> +
> +       b =3D RTA_NEXT(b, blen);
> +       return addraw_l(n, maxlen, b, blen) ? -EMSGSIZE : 0;
> +copy:
> +       if (addraw_l(n, maxlen, a, alen) || addraw_l(n, maxlen, b, blen))
> +               return -EMSGSIZE;
> +       return 0;
> +}
> +
> +struct ipstats_dump_ctx {
> +       struct ipstats_stat_enabled *enabled;
> +       struct nlmsghdr *pending;
> +};
> +
> +static int ipstats_dump_pending(struct ipstats_dump_ctx *ctx)
>  {
> -       struct ipstats_stat_enabled *enabled =3D arg;
>         int rc;
>
> -       rc =3D ipstats_process_ifsm(stdout, n, enabled);
> +       if (ctx->pending =3D=3D NULL)
> +               return 0;
> +
> +       rc =3D ipstats_process_ifsm(stdout, ctx->pending, ctx->enabled);
> +       free(ctx->pending);
> +       ctx->pending =3D NULL;
>         if (rc)
>                 return rc;
>
> @@ -863,9 +919,78 @@ static int ipstats_dump_one(struct nlmsghdr *n, void=
 *arg)
>         return 0;
>  }
>
> +#define IFSM_PAYLOAD(n) NLMSG_PAYLOAD(n, sizeof(struct if_stats_msg))
> +
> +static int ipstats_dump_merge(struct ipstats_dump_ctx *ctx, struct nlmsg=
hdr *n)
> +{
> +       int hdrlen =3D NLMSG_LENGTH(sizeof(struct if_stats_msg));
> +       int maxlen =3D ctx->pending->nlmsg_len + n->nlmsg_len;
> +       struct nlmsghdr *merged;
> +       int rc;
> +
> +       merged =3D malloc(maxlen);
> +       if (merged =3D=3D NULL) {
> +               fprintf(stderr, "Error merging netlink answer: %s\n",
> +                       strerror(errno));
> +               return -ENOMEM;
> +       }
> +
> +       memcpy(merged, ctx->pending, hdrlen);
> +       merged->nlmsg_len =3D hdrlen;
> +
> +       rc =3D ipstats_merge_attrs(merged, maxlen,
> +                                IFLA_STATS_RTA(NLMSG_DATA(ctx->pending))=
,
> +                                IFSM_PAYLOAD(ctx->pending),
> +                                IFLA_STATS_RTA(NLMSG_DATA(n)),
> +                                IFSM_PAYLOAD(n), 0);
> +       if (rc) {
> +               free(merged);
> +               return rc;
> +       }
> +
> +       free(ctx->pending);
> +       ctx->pending =3D merged;
> +       return 0;
> +}
> +
> +static int ipstats_dump_one(struct nlmsghdr *n, void *arg)
> +{
> +       struct ipstats_dump_ctx *ctx =3D arg;
> +       int rc;
> +
> +       if (n->nlmsg_len < NLMSG_LENGTH(sizeof(struct if_stats_msg))) {
> +               fprintf(stderr, "BUG: wrong nlmsg len %d\n", n->nlmsg_len=
);
> +               return -EINVAL;
> +       }
> +
> +       if (ctx->pending !=3D NULL) {
> +               const struct if_stats_msg *pending =3D NLMSG_DATA(ctx->pe=
nding);
> +               const struct if_stats_msg *ifsm =3D NLMSG_DATA(n);
> +
> +               if (pending->ifindex =3D=3D ifsm->ifindex)
> +                       return ipstats_dump_merge(ctx, n);
> +
> +               rc =3D ipstats_dump_pending(ctx);
> +               if (rc)
> +                       return rc;
> +       }
> +
> +       ctx->pending =3D malloc(n->nlmsg_len);
> +       if (ctx->pending =3D=3D NULL) {
> +               fprintf(stderr, "Error saving netlink answer: %s\n",
> +                       strerror(errno));
> +               return -ENOMEM;
> +       }
> +
> +       memcpy(ctx->pending, n, n->nlmsg_len);
> +       return 0;
> +}
> +
>  static int ipstats_dump(struct ipstats_stat_enabled *enabled)
>  {
> -       int rc =3D 0;
> +       struct ipstats_dump_ctx ctx =3D {
> +               .enabled =3D enabled,
> +       };
>
>         if (rtnl_statsdump_req_filter(&rth, PF_UNSPEC, 0,
>                                       ipstats_req_add_filters,
> @@ -874,12 +999,13 @@ static int ipstats_dump(struct ipstats_stat_enabled=
 *enabled)
>                 return -2;
>         }
>
> -       if (rtnl_dump_filter(&rth, ipstats_dump_one, enabled) < 0) {
> +       if (rtnl_dump_filter(&rth, ipstats_dump_one, &ctx) < 0) {
>                 fprintf(stderr, "Dump terminated\n");
> -               rc =3D -2;
> +               free(ctx.pending);
> +               return -2;
>         }
>
> -       return rc;
> +       return ipstats_dump_pending(&ctx);
>  }
>
>  static int
>
> base-commit: ac0b672924c8993a2da2cb9b6f97908967095a97
> --
> 2.55.0
>
