Received: from mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F75E29CB52
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 05:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789106002; cv=none; b=FUXpW6ImsxRcwP5QuauNMa8X/tY9raW6OTXDGvLbMXAeKPF3rWd0d4igQxWK0EXvSNQNg+xYUOxE6tc3ewrcdwmKh8/FSAppnBhKCM6KrfXANRm6AGYj0j/sVPGW+TFntDa/GrXAyTCV9u9vOVMXOWhqCF7cze+fAVp1rm7JO4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789106002; c=relaxed/simple;
	bh=pt0Ku4WB6TncxMOZNl4r+bD/gdasweRhSpFBxWryUpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B0ElhZpXa2dwpUVgNlK9ZWhioPXFDjkipW1hgHdOlTQ4fIdMJAliPLMO4P+VhdgIeIswajtQWHlbcORPsiCcEgQcFyLqYVaZzLhrj3YPLzK9kuiaB4uEL/reK+WJ5DsQZ6YCmJNqoqpb0kZxFV85apBMSNFlD3nYMvO6GvPaJ7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wLRS8TON; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wLRS8TON"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=pt0Ku4WB6TncxMOZNl4r+bD/gdasweRhSpFBxWryUpU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789105996; v=1; x=1789710796;
 b=wLRS8TONi/FgX35pcGiTl2Z5L75VB+IaU5ncgSe4hE9ANzsWi4PZtPND+KeVeB7oR0yWm7zY
 60dJ5pcrXi9YaUqhSR5Q7VNMMe5kajmNcpXVfuPyuHf2r2JppHqTHl/BJMd3ZdK+gPsYemRCMO5
 wyo5t2TmeKKdQQmwzBwJt/Xw=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 0113e97d93c6f190;
	Fri, 11 Sep 2026 05:53:16 +0000
X-Mizu-Trace-ID: 0113e97d93c6f190
X-Migadu-Flow: FLOW_OUT
Date: Fri, 11 Sep 2026 13:53:08 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: =?utf-8?B?5p2O5by6?= <liqiang35@xiaomi.com>
Cc: "security@kernel.org" <security@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net] net/sched: taprio: fix infinite loop in
 taprio_dequeue_tc_priority()
Message-ID: <aqOXRLr98GPdeNVB@fedora>
References: <997210f347bf47b8b2644df8c4331594@xiaomi.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <997210f347bf47b8b2644df8c4331594@xiaomi.com>

Hi Li Qiang,

Please use scripts/get_maintainer.pl to Cc all the needed maintainers.

On Fri, Sep 11, 2026 at 03:37:14AM +0000, 李强 wrote:
> Hi,
> 
> I found an infinite loop bug in taprio_dequeue_tc_priority() while fuzzing the Linux Ethernet networking stack on embedded devices.
> 
> taprio_dequeue_tc_priority() contains a do-while loop that iterates over TXQs belonging to a traffic class using a persistent cursor (q->cur_txq[tc]). The loop termination condition compares the current cursor position with its initial value (first_txq).
> 
> However, taprio_next_tc_txq() reads the TC-to-TXQ mapping from dev->tc_to_txq[tc], which is a per-device shared field. When another qdisc (e.g., mqprio) is grafted onto the same device with a different queue mapping, dev->tc_to_txq[] is updated but taprio's private cur_txq[] retains the stale value from the old mapping.
> 
> This creates a situation where first_txq (from old mapping A) falls outside the new [offset, offset+count) range (from new mapping B). The wrap logic in taprio_next_tc_txq() confines the cursor to the new range, so it can never reach first_txq, causing an infinite loop
> in softirq context with interrupts disabled.
> 
> The loop manifests as a hard CPU lockup: the affected core spins indefinitely in taprio_dequeue_from_txq(), timer ticks stop, RCU
> stalls, and the rtnl_lock is held forever -- blocking all network configuration (tc, ip, netlink) and even reboot. Only SysRq hard
> reset can recover the system.
> 
> This is 100% deterministic with just 2 tc commands and zero network traffic:
> 
>   tc qdisc replace dev eth0 root taprio \
>       num_tc 3 map 0 0 1 1 2 2 0 0 0 0 0 0 0 0 0 0 \
>       queues 1@0 1@1 1@2 base-time 0 \
>       sched-entry S ff 1000000 clockid CLOCK_TAI
> 
>   tc qdisc replace dev eth0 root mqprio \
>       num_tc 3 map 0 0 1 1 2 2 0 0 0 0 0 0 0 0 0 0 \
>       queues 1@1 1@2 1@3
> 
> The second command triggers the graft path: mqprio writes dev->tc_to_txq[] with the new mapping, then dev_deactivate() fires
> a pending TX softirq that calls taprio's dequeue with the stale cursor -- instant deadloop.
> 
> Tested on:
>   - aarch64 (6.12.73-rt15+, stmmac physical NIC): 6.5h lockup
>   - x86_64 (6.8.0-138-generic, veth virtual NIC): instant lockup
> 
> Fix by clamping first_txq into the current [offset, offset+count) range read from dev->tc_to_txq[tc] at the start of each TC iteration. If the cursor is outside the valid range, reset it to offset. This adds a single READ_ONCE + branch per TC per dequeue call with negligible overhead.
> 
> Fixes: 2f530df76c8c ("net/sched: taprio: give higher priority to higher TCs in software dequeue mode")
> Signed-off-by: LiQiang <liqiang35@xiaomi.com>

The description is too long. It's prefer a maximum 75 chars per line.
You can check it with scripts/checkpatch.pl.

> ---
>  net/sched/sch_taprio.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
> index 39ac5b97a..9ae0de007 100644
> --- a/net/sched/sch_taprio.c
> +++ b/net/sched/sch_taprio.c
> @@ -781,6 +781,7 @@ static struct sk_buff *taprio_dequeue_tc_priority(struct Qdisc *sch,
>   struct taprio_sched *q = qdisc_priv(sch);
>   struct net_device *dev = qdisc_dev(sch);
>   int num_tc = netdev_get_num_tc(dev);
> + struct netdev_tc_txq tc_txq;
>   struct sk_buff *skb;
>   int tc;
> 
> @@ -790,6 +791,19 @@ static struct sk_buff *taprio_dequeue_tc_priority(struct Qdisc *sch,
>   if (!(gate_mask & BIT(tc)))
>   continue;
> 
> + /* Clamp the persistent cursor into the current tc_to_txq
> + * range. Another qdisc (e.g. mqprio) grafted onto the same
> + * device may have rewritten dev->tc_to_txq[] since taprio
> + * last set cur_txq[], making first_txq fall outside the new
> + * [offset, offset+count) interval and the do-while exit
> + * condition unreachable -- an infinite loop.

No need to comment it here since you have describe the problem in commit
description.

> + */
> + tc_txq.combined = READ_ONCE(dev->tc_to_txq[tc].combined);
> + if (tc_txq.count == 0 ||
> +    first_txq < tc_txq.offset ||
> +    first_txq >= tc_txq.offset + tc_txq.count)
> + q->cur_txq[tc] = first_txq = tc_txq.offset;

All the code format is broken. You can try git send-email to send
plain text patch.

> +
>   do {
>   skb = taprio_dequeue_from_txq(sch, q->cur_txq[tc],
>        entry, gate_mask);
> --
> 2.50.1
> 
> 
> Best regards,
> LiQiang
> Xiaomi ShadowBlade Security Lab
> #/******本邮件及其附件含有小米公司的保密信息，仅限于发送给上面地址中列出的个人或群组。禁止任何其他人以任何形式使用（包括但不限于全部或部分地泄露、复制、或散发）本邮件中的信息。如果您错收了本邮件，请您立即电话或邮件通知发件人并删除本邮件！ This e-mail and its attachments contain confidential information from XIAOMI, which is intended only for the person or entity whose address is listed above. Any use of the information contained herein in any way (including, but not limited to, total or partial disclosure, reproduction, or dissemination) by persons other than the intended recipient(s) is prohibited. If you receive this e-mail in error, please notify the sender by phone or email immediately and delete it!******/#

And you email client add these info.

Thanks
Hangbin
