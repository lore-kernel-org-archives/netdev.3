Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C9B4F85B1
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 18:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790015018; cv=none; b=ETlmc3ie9XzmYUhuzxI5gMYNwGgeqbSkUCQ+Bn2DtZ50ZNN8QqyIVvAOilAhIpxADmGMfQJMYKd3Cenvn6OlTVgGWirQJBLahzBCDduDkaKl+ea6IaJi35pSeriVTr6NtKDoBc8L2rwZqwNN7ZJ+8YTI7pzSw1ByuxrSDOyXJmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790015018; c=relaxed/simple;
	bh=bmpOwCmyBfym+bmRNeuZ5zx9NhewvCIDN0AbyVF/xyw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NsosS7YJ9+Y7A4lBnlJ5q4krXM0lHHjkKYeJcXbG0xuBsATXZkdbBHMj8nTHw3cvnAGXiNiMwmh8J5mNcz7IYbv/n3zxld865W1NrgQ3E/UvfRZF6/4KirRvqC8TddOlYgMeA/1/zUm0m2eanU0aHgZ3yR1CPvvrVJzJKLuOd6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=cUiqEW39; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="cUiqEW39"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccafb752so2748209a91.0
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 11:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790015016; x=1790619816; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/RaJVJ7Ve3EUMsN3RGuElHe7Bsrf4WoOSmglC49sp00=;
        b=cUiqEW39VAtyOzNE8bqJ4temXF85DWhecNd/+5bPVVQilQeMI/c4wsciAxo8GdJ8kD
         br+JeGQ8V1zVwlYET3NeLReTuA7yB8xAD6fZD9Bm8rJudZPgUjdzapVuqoM6GIgepzad
         F9Pk0Tdyjo9689qPaDIewcNq+2r6oSyn3qfjGwzs1NC7wPrVGvqFMq5LP2U7yq6yG5Mg
         2VpMbGX/Q4Oc2chhMpyg6G4j5WRiEIHEzYFABBWGi3JT+BwU5AMq/7KhA4+cv58mlWmg
         zsMtSi6CQ1t0D/f+h8sRbrs80Fzzoi62OLmhnFP1hzzvA3r4s507Wmwrn7uEbEHvAQgl
         UaAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790015016; x=1790619816;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/RaJVJ7Ve3EUMsN3RGuElHe7Bsrf4WoOSmglC49sp00=;
        b=MvEPb7uVWgd36gD3kxiTM8o9eQ0MnyzNtFJrnlxgQOT0QWqsOzjfXk6cuha4hhWwse
         QucPmRzmHH7bHLQ4J2MVeDsnKbGmGdRSqTLtZRuTZCo72My7qsyzeQHG4XQzBC3jyzIY
         uTUBWj+ZvVq2OdrOKmwLymaiKlcO8qfWP1BVg+LsMG3PS7M6L+847BBoPBouRzzO7gxd
         4k5T3q1lFVMMkUJ7lavV9Jonp3OEymOqpMdHHeNZOmnrFeBD5W0fB7ePj+gC7H9L+elf
         /GVQAVexmlgqkmTSNS+0IYwrYtN8/iJWgj+CvWe2mRj7JRQVFGVmprps96ouBFagcpqs
         tIgQ==
X-Gm-Message-State: AFuF++mtvGewbnVTrQaVNtinPXwGTDbVUlIIMl99OxLs9dT5+3BzEsXI
	6OCwk53jnt5LoRlMcBI6/Y6aoddfls5zVOct1zm50LGz9VpXfBCHEmLlu4HN6hdYZ5Y=
X-Gm-Gg: AYBFou2kiDSx7HjnReGHtDgP3e8hKJ+QrLr44s6f0845F3k07gyt6PwxT2dr0QOE56b
	jPaVXgEkX6kUDdEDPhmywBOMqScS71NhTlt0+rJ+4ZJ194tqlSyU00eoW+ueWIDB91M5G9G+utl
	vpAMIjlElv1khWgLtWTr8PmUsSeJbe4Ot6Qq7F4Cwv6q8EXgJEnBl2hqKJnCM097UsY3wEuMK+6
	2kWgBk4Mdxjcjduf61bFcxqpXB5jcUoZyobpqAzOaAPP0hI+Z0hrHFS1vYVdYfKM7hIzzuW2yEe
	1w06cpz04+hwi+NvPshEs5SuMmxAqPzvgipVYNvfyllq6d6QDEEc36KvHqW0eVuPVN1k3yCfUaf
	oNKM3wt4g+F7wNcuNrrEmr2hWq7TL0hx+15ipefnWoa7G54ubseioDuX6muug4PknjZoRFOT+Ar
	CkzLVGU6k3GgzxmGY51YM61ZMglvVxwAhnjwsPjEK5d/ygn1TuK1OPyDpa35baxG1o79LufQnGY
	wY9DypFJ3aBpwKy+m+XHEd8fWclfkgOF1iwrWakgs2by44fdgs=
X-Received: by 2002:a17:90b:440e:b0:39e:6c69:7777 with SMTP id 98e67ed59e1d1-39e6c697978mr10887836a91.32.1790015016358;
        Mon, 21 Sep 2026 11:23:36 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a069a0c7aesm39051a91.16.2026.09.21.11.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 11:23:36 -0700 (PDT)
Date: Mon, 21 Sep 2026 11:23:27 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Alexander Zubkov <green@qrator.net>
Cc: netdev@vger.kernel.org, Petr Machata <me@pmachata.org>, Ido Schimmel
 <idosch@nvidia.com>
Subject: Re: [PATCH iproute2 v3 1/2] ip: ipstats: Merge statistics split
 across several netlink messages
Message-ID: <20260921112327.7678123e@phoenix.local>
In-Reply-To: <20260910092057.3980-2-green@qrator.net>
References: <20260910092057.3980-1-green@qrator.net>
	<20260910092057.3980-2-green@qrator.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Sep 2026 11:20:56 +0200
Alexander Zubkov <green@qrator.net> wrote:

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

AI review found somethings here.


On Thu, 10 Sep 2026 11:20:56 +0200, Alexander Zubkov wrote:
> +#define IFSM_PAYLOAD(n) NLMSG_PAYLOAD(n, sizeof(struct if_stats_msg))
> +
>  static int ipstats_dump_one(struct nlmsghdr *n, void *arg)
> +{
> +	struct ipstats_dump_ctx *ctx = arg;
> +	int rc;
> +
> +	if (IFSM_PAYLOAD(n) < 0) {
> +		fprintf(stderr, "BUG: wrong nlmsg len %d\n", n->nlmsg_len);
> +		return -EINVAL;
> +	}

This check never fires. NLMSG_PAYLOAD() expands to

	((nlh)->nlmsg_len - NLMSG_SPACE((len)))

and nlmsg_len is __u32, so the subtraction is done in unsigned arithmetic
and the result is promoted to unsigned long, not int. A truncated message
wraps to a huge positive value instead of going negative, and the compare
against 0 is always false. Compiled and confirmed: with nlmsg_len = 4,
NLMSG_PAYLOAD() yields 0xffffffffffffffe8, and "IFSM_PAYLOAD(n) < 0"
evaluates to false.

To be clear about severity: I do not think this is reachable from a
correct kernel. RTM_NEWSTATS messages are built with a fixed-size struct
if_stats_msg, so a short one should not occur in practice, and I am not
reporting a live crash. But the check was clearly written to catch
something, and as written it cannot.

It is worth fixing rather than deleting, because nothing else on this path
does the job. NLMSG_OK() only validates against sizeof(struct nlmsghdr),
not against the 28-byte if_stats_msg header, so libnetlink hands the
message to the filter without checking the family payload.
ipstats_process_ifsm() does have an equivalent check that works, because
it computes into a signed int first:

	show_attrs.len = (answer->nlmsg_len -
			  NLMSG_LENGTH(sizeof(*show_attrs.ifsm)));
	if (show_attrs.len < 0) {

but that only guards the print path. The new merge path runs before any
printing and passes the payload lengths straight down:

	rc = ipstats_merge_attrs(merged, maxlen,
				 IFLA_STATS_RTA(NLMSG_DATA(ctx->pending)),
				 IFSM_PAYLOAD(ctx->pending),
				 IFLA_STATS_RTA(NLMSG_DATA(n)),
				 IFSM_PAYLOAD(n), 0);

ipstats_merge_attrs() takes these as "int alen"/"int blen", so on a
malformed message the wrapped value truncates back to a negative int and
feeds RTA_OK() and addraw_l(). So the guard in ipstats_dump_one() is the
only thing covering that, and it should work.

Simplest fix is to compare the length rather than the payload:

	if (n->nlmsg_len < NLMSG_LENGTH(sizeof(struct if_stats_msg))) {
		fprintf(stderr, "BUG: wrong nlmsg len %d\n", n->nlmsg_len);
		return -EINVAL;
	}

or assign to an int first, matching what ipstats_process_ifsm() already
does.

> +	merged = malloc(maxlen);
> +	if (merged == NULL) {
> +		fprintf(stderr, "Error merging netlink answer: %s\n",
> +			strerror(errno));
> +		return -errno;
> +	}

Minor: fprintf() may clobber errno before it is read back for the return
value, so this can return an unrelated error (or 0). The sibling failure
path in ipstats_dump_one() gets this right by returning -ENOMEM
explicitly; please do the same here.

The rest of the series looks correct to me. In particular the merge itself
holds up: maxlen cannot be overflowed since the merged content is at most
the sum of both messages minus a header per merge level, addattr_nest()
is passed the raw rta_type so NLA_F_NESTED survives, padding attributes
are inert on both sides of the split, and the allocation paths are
balanced -- free(ctx.pending) on dump abort, free(merged) on merge
failure, and the iterative scheme handles three or more messages for one
ifindex.
