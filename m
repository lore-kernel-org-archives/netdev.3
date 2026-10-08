Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4063A9D8F;
	Thu,  8 Oct 2026 16:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791476254; cv=none; b=E1If6pMPwpedsRykEX//nsAhJdFiALr6Dm5BOXI9yNlgAgbhT6Vj2sLu7nWmi5vuwtsSwZDQdYpf3BZICBtIr0ZRgUhQ3UhbrtNgoYctdYjnTIBQWuNsdZsH3E0DBFBCr8lxta7pKDD9ndDdy/Z/WMYkzXAb2/P9wBMc9CA/baE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791476254; c=relaxed/simple;
	bh=OwDMbg4HS2K3cbm7ThURQ2BsrxBel1QJaN7B1jSC5pw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L3UdW2pRvTuYxsVvvFHTlxqUeb8YM4JYPM6XVCv7mNyz4+BObTWIiqoeQSgcZsjL6dBrGSuDnEalTSE2AxfrrCxTDtkKdACIgE6A4PEuaoxgkEi59/bFxJjavcy646RsLdehFHeZKrrsKHsUjLPMcF50ATFsY8S1IJ/oBa3k16A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gNm6UU+H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gNm6UU+H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C381F000FF;
	Thu,  8 Oct 2026 16:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791476253;
	bh=exmGulorvnjMrpq9YAnuYsgaGXLHC/0fKR2L0PblnAs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gNm6UU+H0kfPKSnelpVGRph/XNud64HiX5Qi91CZjhhZoo8NEyz5SwKJFTf0pHUmJ
	 RnzektZbAvCPd9ujPEe8Judz+1RGRyfiFdHNSX+/jbusHelmhkXLfe34YREUyi1aQr
	 jlLBVitS7ZAHMepPBee8o/uCuLec/zz72tfDxAMIrJBFbsn4TqPZJq2JSTwgi/WTlg
	 j9p2AeA+fr37a2wPLIk/RsMfCbKYehqn18ByB5iOGU+aBQDsB6MX1rJvZy8/g8swyp
	 xfFXYqep5t3x//zBryt22oTu006Koc6rqiAps5HcQpGlzx7WCUee5DJIs/D6a1T0S8
	 +Fr7szRiRsO9g==
Date: Thu, 8 Oct 2026 09:17:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Krystian Kaniewski <krystianmkaniewski@gmail.com>
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/2] net/sched: taprio: fix RCU stall from replayed
 schedule entries
Message-ID: <20261008091732.7794253a@kernel.org>
In-Reply-To: <20261006113335.241564-1-krystianmkaniewski@gmail.com>
References: <20261006113335.241564-1-krystianmkaniewski@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  6 Oct 2026 13:33:33 +0200 Krystian Kaniewski wrote:
> syzbot reported an RCU stall with a software taprio schedule made of a
> single 127 ns entry. When advance_sched() falls behind, it replays every
> missed entry inside the timer interrupt and the backlog only grows.
> Patch 2 makes it continue from the entry in progress instead.
> 
> Patch 2 then checks for an admin schedule handover once after catching
> up. That requires the cycle_time_extension comparison to be monotonic,
> so the sum now saturates instead of wrapping. As a result a large
> extension can hand over to an admin schedule whose start time leaves no
> room for the timestamps derived from it. Initializing such a schedule
> already overflows today, and a carefully chosen extension can already
> reach it. Patch 1 rejects these schedules at configuration time and
> comes first, so the series never hands over to one.

The coccicheck CI job flags a new warning introduced by this patch:

  net/sched/sch_taprio.c:972:8-13: ERROR: invalid reference to the index
  variable of the iterator on line 959

This points at the new taprio_entry_at() helper:

    list_for_each_entry(entry, &sched->entries, list) {
            entry_end = min_t(s64, elapsed + entry->interval,
                               sched->cycle_time);
            if (offset < entry_end ||
                list_is_last(&entry->list, &sched->entries))
                    break;
            elapsed = entry_end;
    }
    ...
    return entry;

`entry` is read/returned after the loop. Even though every code path here
actually breaks out of the loop on a real list element (the
list_is_last() check guarantees this), Coccinelle's generic
use-after-iterator check cannot verify that and treats any post-loop use
of the loop variable as a potential bug, since on a normal (non-break)
loop exit `entry` would point at the list head sentinel rather than a
valid `struct sched_entry`.

Could you restructure the helper to avoid reading `entry` after the loop,
e.g. by tracking the last matched entry in a separate local variable set
inside the loop body before the break, or by adding an explicit
"not found" fallback assignment after the loop? That should keep the
logic identical while satisfying the checker.
