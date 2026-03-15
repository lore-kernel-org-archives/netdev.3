Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7462D370D54
	for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 15:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773587995; cv=none; b=j6WzAG2ZmVZBq/FNPF3+nMXfqynGwc8CW4pNVqzqr/YXlS24EKKimH/1CNEpDYEhsjqnOreHHvbIcMsZBDcRW0aaVCPLV6CGZ1cG29VtytBQxxOTDnndpJ7Dscs63XLl830u6YOifFeNwSO6RH5NQejCeHszjkfs6Iu+n2mtTHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773587995; c=relaxed/simple;
	bh=2cjG7RpEzXN13fDwC1v97B3B86wal4Zb0PMdcCfmWbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eNnvxF3v00GLd/M+m/eqZxhCm5OaWJ5rhj/6EdwQQfvujNJIku1HsHuq0ZQVjZ7WwG3y5ZumWHZhCyFwS0Gj+XC8wHJ2G2Ip1JW8s/vu8d0Nxd5MNNryGx0LyLVNGESnIqCHo22FDMZyx5C1o5fkyig6yga0gBMKGAxNLoXR64E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gq+Ggk8Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gq+Ggk8Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8579C4CEF7;
	Sun, 15 Mar 2026 15:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773587995;
	bh=2cjG7RpEzXN13fDwC1v97B3B86wal4Zb0PMdcCfmWbQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gq+Ggk8Zu+M6Oo+q0p50y2rjh4+0G5lHcPBDfZmlfuFh17wsE3K+udJsixYBMZN7z
	 TKeJS9vAcIKzrg4TIguNvBCiENtEo3v5XxmoZKZkD8y1WgzYt4QSaOV1zphvO38mvA
	 Tv9uukPJF1uRojDuBEMOg+DBXOe8Y7Boe+X0dm3/msg3a7/3p/ln52PQd3SgmcQJwD
	 gIQABDdKUjTBcKvobsnGBfAD1H+myEL+v1OKc2YbFqbtbMJjHCBdetUVeGyUtDytO7
	 53nqEQawDDyZrsm3s8U9bFL9lIkOYYjjFsOC1PBCl1pWYff6H0O8ZBia1iH2cUxajD
	 DKEmJWoEqmM+g==
Date: Sun, 15 Mar 2026 08:19:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net v2 00/10] netem: fixes and selftests
Message-ID: <20260315081953.3ceb7a84@kernel.org>
In-Reply-To: <20260315001649.23931-1-stephen@networkplumber.org>
References: <20260315001649.23931-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Mar 2026 17:14:04 -0700 Stephen Hemminger wrote:
> The check_netem_in_tree() restriction added for CVE-2024-45016 rejects
> valid configurations such as HTB or HFSC trees with netem on multiple
> branches -- including examples from the netem documentation itself.
> This has been an open issue for over a year (kernel.org bug #220774).
> 
> This series replaces it with a per-CPU recursion guard, restructures
> dequeue to fix the HFSC eltree corruption, and addresses several
> additional bugs found during a code audit.

# not ok 379 7a01 - NETEM passes traffic with delay
# Could not match regex pattern. Verify command output:
# qdisc netem 1: root refcnt 33 limit 1000 delay 1ms seed 151499771072372938
#  Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0) 
#  backlog 0b 0p requeues 0
# 
# not ok 380 7b02 - NETEM passes traffic with duplication
# Could not match regex pattern. Verify command output:
# qdisc netem 1: root refcnt 33 limit 1000 delay 1ms duplicate 50% seed 4449138859105539433
#  Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0) 
#  backlog 0b 0p requeues 0
# 
# not ok 381 7c03 - NETEM passes traffic with loss
# Could not match regex pattern. Verify command output:
# qdisc netem 1: root refcnt 33 limit 1000 delay 1ms loss 30% seed 17755509090945397811
#  Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0) 
#  backlog 0b 0p requeues 0
# 
# not ok 382 7d04 - NETEM passes traffic with corrupt
# Could not match regex pattern. Verify command output:
# qdisc netem 1: root refcnt 33 limit 1000 delay 1ms corrupt 10% seed 15571003730150948945
#  Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0) 
#  backlog 0b 0p requeues 0
# 
# not ok 383 7e05 - NETEM passes traffic under HTB with two netem leaves
# Could not match regex pattern. Verify command output:
# qdisc htb 1: root refcnt 33 r2q 10 default 0x10 direct_packets_stat 0 direct_qlen 1000
#  Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0) 
#  backlog 0b 0p requeues 0
# qdisc netem 10: parent 1:10 limit 1000 delay 1ms duplicate 25% seed 7229481943258718053
#  Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0) 
#  backlog 0b 0p requeues 0
# qdisc netem 20: parent 1:20 limit 1000 delay 1ms duplicate 25% seed 2614650852791982394
#  Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0) 
#  backlog 0b 0p requeues 0
# 
# not ok 384 7f06 - NETEM passes traffic under HFSC with duplication
# Could not match regex pattern. Verify command output:
# qdisc hfsc 1: root refcnt 33  default 0x1 
#  Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0) 
#  backlog 0b 0p requeues 0
# qdisc netem 10: parent 1:1 limit 1000 delay 1ms duplicate 25% seed 1742473429681626986
#  Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0) 
#  backlog 0b 0p requeues 0
# 
# not ok 385 7a07 - NETEM passes traffic with nested netem
# Could not match regex pattern. Verify command output:
# qdisc netem 1: root refcnt 33 limit 1000 delay 1ms seed 959619114654116267
#  Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0) 
#  backlog 0b 0p requeues 0
# qdisc netem 10: parent 1:1 limit 1000 delay 1ms duplicate 10% seed 1402527459214356892
#  Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0) 
#  backlog 0b 0p requeues 0
# 
# not ok 386 7b08 - NETEM passes traffic with TBF child
# Could not match regex pattern. Verify command output:
# qdisc netem 1: root refcnt 33 limit 1000 delay 1ms seed 3026058286388988065
#  Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0) 
#  backlog 0b 0p requeues 0
# qdisc tbf 10: parent 1:1 rate 1Mbit burst 10Kb lat 50ms 
#  Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0) 
#  backlog 0b 0p requeues 0
# 
# not ok 387 7c09 - NETEM passes traffic with all impairments
# Could not match regex pattern. Verify command output:
# qdisc netem 1: root refcnt 33 limit 1000 delay 1ms  500us loss 5% duplicate 10% reorder 25% 50% corrupt 1% seed 4173999615992747611 gap 5
#  Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0) 
#  backlog 0b 0p requeues 0
# 
# not ok 388 7d0a - NETEM passes traffic with reorder
# Could not match regex pattern. Verify command output:
# qdisc netem 1: root refcnt 33 limit 1000 delay 10ms reorder 25% 50% seed 16878270064950901169 gap 5
#  Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0) 
#  backlog 0b 0p requeues 0
# 
# not ok 389 7e0b - NETEM passes traffic with slot pacing
# Could not match regex pattern. Verify command output:
# qdisc netem 1: root refcnt 33 limit 1000 delay 1ms slot 20ms 40ms packets 5 bytes 1500 seed 12148330044418512905
#  Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0) 
#  backlog 0b 0p requeues 0
# 
# not ok 390 7f0c - NETEM passes traffic with rate limiting
# Could not match regex pattern. Verify command output:
# qdisc netem 1: root refcnt 33 limit 1000 delay 1ms rate 1Mbit seed 17545598048030611383
#  Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0) 
#  backlog 0b 0p requeues 0
# 
# not ok 391 7a0d - NETEM passes traffic with SFQ child
# Could not match regex pattern. Verify command output:
# qdisc netem 1: root refcnt 33 limit 1000 delay 1ms seed 7568266806072117190
#  Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0) 
#  backlog 0b 0p requeues 0
# qdisc sfq 10: parent 1:1 limit 127p quantum 1514b depth 127 divisor 1024 perturb 10sec 
#  Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0) 
#  backlog 0b 0p requeues 0
# 
