Received: from mail-pj2-f39.google.com (mail-pj2-f39.google.com [74.125.227.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFB436DA15
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 21:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789508051; cv=none; b=nzT1/aTuXzc4bBMNnMdV7BCPEa751zWk3H0BsVJG5XoZNHiruA4yaYrrb4q9Uh5zI6IHxgfJCGN7tI20aqjhlnzMUfTQaZi80Xl/EHN0kzD2Cjf10EyxFhGcQPHzAZt/AE588Ijr0A9Uo0mpX6bD1GkHbrMmMXKr0OHVx1/t3cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789508051; c=relaxed/simple;
	bh=DXxzztDVMtR0dQkLvBesvRVacygPwwtLpVdILBXYKSA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tX4sEq34rSNSduQ928vkjfV/mhORzRGW7wHmnFeiox0urd9p2IV2EZwmVmP8lpjdZuOdUG8bfipEW0jfDUdJ27w56oiKn6ltkahok73zQfM7hawdATeJHy6PNfWqznjrOFQAtOtADtO/YBOACsTn+WoHlqUzq42OnimXPoblaFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=eE0YGdjA; arc=none smtp.client-ip=74.125.227.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="eE0YGdjA"
Received: by mail-pj2-f39.google.com with SMTP id d9443c01a7336-2d8fe517774so3276495ad.0
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 14:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789508049; x=1790112849; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3MT/ryy+CZVZg0oLqRQ6Vnctpg9HDkGy+cOIDpZMnqQ=;
        b=eE0YGdjAnHgBD+9v91NZ1Nscsrl55JOAYzDLRB+NU+KUF1XrGFvauS0bfAUo8yx4JK
         RvF8qCKKA0eeA8KTOlyTNBFrgKulHiqge7P5ylWmjv3ejJ1zHwichDmsjgo1UcbeM+eq
         y+OFP5gmDZIM4roOmkpsmn9Vv/QXoKuQqOKJEpi4ffa9xX4fQoZtW+QnO5RLZZL+SCux
         gp9SGbp53/vRSCLW3azKJ3Q1QNzmtVFqEDIDLkftOZF8Y6KkAOaExbZO+Akx6cNgxpAi
         wc1VT7a6V941qFxCFJHCNHqSnSCs0pAPlSZwbSY3KKed7Fm4O7CQtebyyyHy6mFOMnVo
         FjZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789508049; x=1790112849;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3MT/ryy+CZVZg0oLqRQ6Vnctpg9HDkGy+cOIDpZMnqQ=;
        b=qWfVZB/rrzwVmffVugz18nBZ9aMcYe/QE/JBASYGHm2IdAr62sqOb5wgT7u5HxW8GU
         mr/EGGcNqiUXc9m9X80USGf8cryaxf1w56W39BUrcjMetatVAWM5g+5Xfq009Yp6fM4N
         1p5qRnm6jPF3iHGnDDMIuBxYZL7ULvVmYiuOw7jTyZsHmre8vHr7FWzoGB3MOZr2VqLe
         VohMqAqijt4vJ4K6RgAn1L1b481MEqBfWTwz2s36uJszJz6SvMzH5w06PtoGX3Jc+gw+
         Rzum8ManxWkM6RBvqhmz4stmqyPEb7qeO9OviC7Ha++pvje+H/Hrt2Dieq5H+jSRHy99
         GMmw==
X-Gm-Message-State: AFuF++nTrBafKflKZm/47CwUt2mK5BmpjDv9O5qiMjEq3lClv9P1+wyq
	Od63rNH9udnCn9pYt989GGwmNkIPW9RLv2hKVPeBd6GHne7wmf8k/lZLC7yS+0f9ZVBT6ylTKFz
	GyjAwFiUzpw==
X-Gm-Gg: AYBFou1jBl6i+/rI9RepaxyIB9liM1Zfj4UhAbXMX8A4H3eI5yhX5T9CT6JQt6epjxG
	wlNMdAK89E7oaPg/1a/kyMGV3b2UqR5JBfSL7Ewkp0xIJEVSxv2WQm1oNvkzK/raLjDZvUeT1Fx
	70a0IVaujldrMpqsmmaPPt8FAfpaaUnZ8oxUz8HGmYs65KtnSql4+oDco0PKi3hCloSeqZhQmbG
	B/mfHPthnTLqHb6kRxLFjDInrq6Vwuqk9YHvbISpYIoqYJyE9SqdNysK8bQXpzMbvrZ1+CtvPYG
	vsT4cFa4tM3Akh1747ZOLik+W3Yuk5SrAYQp4N90k8cmChknCvtyRqVNx+8J8TvvY42VCj2XuAb
	IFBnIDehrrlxU+NrOgOqDjSLRXXCeCoDqguio+Eu18oF8v51y4VgoeH8gq/yMA81tMOypxiMrB9
	cVmTXCOCcC1vkOhhov7o1JpuqKjFBkH6mdKqS5EhPJmpQY7E8kiC8knoaPJRqZjxEw1oHceUPpy
	hdHK/t5tWSHIwsum4P/r1/tX8S/e1JCx+JMlRPx
X-Received: by 2002:a17:903:8c3:b0:2d8:d4cc:be63 with SMTP id d9443c01a7336-2dd8e76d9f8mr2008845ad.16.1789508048656;
        Tue, 15 Sep 2026 14:34:08 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89f331b7sm1446115ad.82.2026.09.15.14.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 14:34:08 -0700 (PDT)
Date: Tue, 15 Sep 2026 14:34:02 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Prabhakar Pujeri <prabhakar.pujeri@dell.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH iproute2 v2] ss: drop the /proc parsers for packet and
 netlink sockets
Message-ID: <20260915143402.39daa335@phoenix.local>
In-Reply-To: <20260902035633.1978-1-prabhakar.pujeri@dell.com>
References: <20260902035633.1978-1-prabhakar.pujeri@dell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  2 Sep 2026 03:56:33 +0000
Prabhakar Pujeri <prabhakar.pujeri@dell.com> wrote:

> packet_show() and netlink_show() fall back to parsing
> /proc/net/packet and /proc/net/netlink only when the sock_diag
> netlink dump fails.  That fallback exists for kernels without
> sock_diag support and parses each record with sscanf() without
> checking the conversion count, so truncated or malformed lines
> leave fields used by filtering and printing uninitialized.
> 
> Remove both sscanf() based parsers instead of trying to validate
> them; kernels new enough to matter answer the sock_diag request.
> packet_show_line() and the PROC_NET_PACKET/PROC_NET_NETLINK hooks
> have no other users.
> 
> Signed-off-by: Prabhakar Pujeri <prabhakar.pujeri@dell.com>
> ---

This makes sense and looks good to me, but AI review spotted some nits:

Subject: Re: [PATCH iproute2] ss: drop the /proc parsers for packet and netlink sockets

On Wed, Sep 2 2026, Prabhakar Pujeri wrote:
> packet_show() and netlink_show() fall back to parsing
> /proc/net/packet and /proc/net/netlink only when the sock_diag
> netlink dump fails.  That fallback exists for kernels without
> sock_diag support and parses each record with sscanf() without
> checking the conversion count, so truncated or malformed lines
> leave fields used by filtering and printing uninitialized.

The direction is right and the diff is mostly mechanical, but the patch
stops one hunk short: it removes the fallback without removing the code
that exists only to *trigger* the fallback.  That leaves a real behaviour
regression.  Details below, plus two pre-existing issues the removal
makes user-visible.

1. packet_show_sock() still bails out to a fallback that no longer exists
---------------------------------------------------------------------

misc/ss.c:4776

	/* use /proc/net/packet if all info are not available */
	if (!tb[PACKET_DIAG_MEMINFO])
		return -1;

This is the last remaining reference to /proc/net/packet in the tree, and
it is not just a stale comment.  That `return -1` was the mechanism for
requesting the fallback: it propagated up so packet_show() would retry
via net_packet_open().  With the fallback gone, the -1 is returned from
an rtnl_dump_filter() callback, which aborts the entire dump.

So on any kernel that answers the sock_diag request but omits
PACKET_DIAG_MEMINFO for a socket, the old code printed that socket from
/proc.  The new code silently truncates the listing at that socket:
everything already dumped before it has been printed, that socket and
every socket after it are dropped, and the exit status is still 0.  If
the very first socket is the one missing MEMINFO, the output is empty.
Before, missing MEMINFO degraded to a less detailed listing; now it
degrades to silently incomplete output with no error.

Note MEMINFO is only requested because packet_show_netlink() sets
PACKET_SHOW_MEMINFO unconditionally (misc/ss.c:4909) -- it is not
something the user asked for, so aborting the dump over it is the wrong
trade even ignoring the dead-fallback issue.

Suggested fix -- drop the check with the parser, and let the existing
`if (tb[PACKET_DIAG_MEMINFO])` guard below at misc/ss.c:4786 do its job
(it is already written to tolerate the attribute being absent):

	-	/* use /proc/net/packet if all info are not available */
	-	if (!tb[PACKET_DIAG_MEMINFO])
	-		return -1;
	-
		stat.type   = r->pdiag_type;

stat.rq simply stays 0 in that case, which is the same thing the netlink
path already does for every other optional attribute.

2. No diagnostic when sock_diag is unavailable
----------------------------------------------

packet_show() and netlink_show() now return the netlink result directly,
and main() (misc/ss.c:6183-6186) ignores the return value:

	if (current_filter.dbs & (1<<NETLINK_DB))
		netlink_show(&current_filter);
	if (current_filter.dbs & PACKET_DBM)
		packet_show(&current_filter);

On a kernel without CONFIG_PACKET_DIAG / CONFIG_NETLINK_DIAG (these are
separate config symbols and are genuinely off in some minimal builds,
independent of kernel age), `ss -0` and `ss -A netlink` now print a
header and nothing else, exit 0, with no indication that anything
failed.  The commit message argues such kernels do not matter, which is
defensible for the fallback itself -- but silently succeeding is not the
same as not supporting it.

This is consistent with how vsock/tipc/xdp already behave, so I would not
block on it.  Still, a one-line stderr hint when the dump fails would
save users a lot of confusion, and it is cheap to add.

3. packet_raw / packet_dgram filtering is now dead in all cases
---------------------------------------------------------------

To be clear up front: this patch did not introduce this bug.  But it
removes the last environment in which the filter ever worked, so it is
worth calling out in the commit message at minimum.

The removed packet_show_line() carried the only type filtering that ever
existed:

> -	if (type == SOCK_RAW && !(f->dbs & (1<<PACKET_R_DB)))
> -		return 0;
> -	if (type == SOCK_DGRAM && !(f->dbs & (1<<PACKET_DG_DB)))
> -		return 0;

There is no equivalent in the netlink path.  packet_show_sock() reads the
type at misc/ss.c:4780:

	stat.type   = r->pdiag_type;

but neither it nor packet_stats_print() ever tests f->dbs, and
run_ssfilter() does not look at s->type.  Since the dispatcher gates on
PACKET_DBM (misc/ss.c:6185), which is the OR of both bits, selecting
either `packet_raw` or `packet_dgram` runs an unfiltered dump and
displays all AF_PACKET sockets.

Because packet_show() already preferred the netlink path before this
patch, `ss --packet_raw` was already returning dgram sockets too on any
kernel with packet_diag.  After this patch it is unconditional.  The
option is still documented (man/man8/ss.8:411) and still accepted by
filter_db_parse() (misc/ss.c:403-407), so users get a silently wrong
answer rather than an error.

The fix is a packet_type_skip() mirroring the existing unix_type_skip()
(misc/ss.c:4443) and vsock_type_skip() (misc/ss.c:5237), called from
packet_show_sock() once stat.type is populated.  That is arguably a
separate patch -- but please either include it here or note the known
gap in the commit message, so it is not mistaken for collateral damage
from this removal.

Minor notes
-----------

- unix_show() keeps its /proc fallback (misc/ss.c:4597).  If the argument
  is "kernels new enough to matter answer sock_diag", it applies equally
  to AF_UNIX.  Worth a sentence in the commit message on why packet and
  netlink were chosen and unix left alone, so the asymmetry reads as
  deliberate.

- The PROC_NET_PACKET / PROC_NET_NETLINK env overrides went away with the
  macros.  I grepped the tree: nothing in man/, README*, or testsuite/
  references them, so there is no doc or test fallout.  Confirming for
  the record, not asking for a change.

- netlink_show_one()'s getenv("PROC_ROOT") at misc/ss.c:5127 is unrelated
  (it resolves a peer PID's name from /proc/<pid>/stat) and correctly
  left alone.

- Builds clean -- no unused-function warnings.  packet_stats_print(),
  netlink_show_one() and generic_record_read() all still have callers on
  the netlink and tcp/udp/raw paths.

I will send its suggested changes
