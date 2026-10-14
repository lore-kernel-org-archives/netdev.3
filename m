Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2984361DA6
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 09:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791969344; cv=none; b=II241FpcGqtJq4eu79NZMHH+P7rbrVqfvoMkKJIqfjknR7IEh7HZSzqWkwHxsRUrwB0G4BIR1XDvmy9QM4SVl+n6IJQhBjP6UT5+YjrhFEKIFCO86tm8lxAxYW1SrT6lM+efajbjsKjk7P8fwlh5nLPQQZGy8a86hjnaIz/2X28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791969344; c=relaxed/simple;
	bh=ONftr+71LdmCakuIsRBeyuHdgD64UegCBXp+9tXzfJ8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=vFuQ66snlDyBBzwEk+lElbvxs2RV2tecWMyJBJEiqJL64oFz0bjvD7/WmWN+Sv46kQWPrCuquwWTp4xHy0/mX5OY+bYva5ZTJGHayzNGPuwKEn9gR+V2cdyC7bcocJs+RaLyYkp3im4UHu0weUEmVxJiURYxuPEoI+IUR+tYe0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SfpTnTLI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SfpTnTLI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E86491F000FF;
	Wed, 14 Oct 2026 09:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791969343;
	bh=HAupBBnrhUn5g7Eg8agGKDrjQiONRRQZP2fRPir9eJc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=SfpTnTLInV63OtZ/r8+TdPsgHAIZRAnHIOUMAM3lgFgPHbdrAcral8gAMAe3NgGpv
	 7N22QMYB2DyLOE6sKlyar7vuBNbC2JvTQxvgn59ahH41NRQDJeY/IfUAIDfeeLgtBL
	 yDTRePIUHu34qRRtojXJ4E9adh61IKvxHiOH6K7yMWBCP3N8g7olYhXkLxt/oYBzQo
	 j2EXq67F0FYUukpkKmQ4NqMt0xyNoGb4ARlx65bpUufvX+WRIrqLF2+WG2owRUSuoR
	 qF658KzQYy/GJboWDwlaoVx5SUtuuBGi+FyIF52j7Iak3rCBeA4hFvCfnN3DOz2PD1
	 PHJm3w1s7XCHQ==
Subject: Re: [PATCH net-next v3 4/5] net/sched: sch_taprio: cap the number of
 schedule entries
From: netdev-bot+sashiko@kernel.org
To: jhs@mojatatu.com
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 victor@mojatatu.com, p@1g4.org
Date: Wed, 14 Oct 2026 09:15:42 +0000
Message-ID: <179196934250.434549.3727964213226775425@kernel.org>
In-Reply-To: <QDISC-H19Z.v3.r0.20261012193813-4@mojatatu.com>
References: <QDISC-H19Z.v3.r0.20261012193813-4@mojatatu.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] sch_taprio: hardware capability regression for SJA1110 due to
  1024 entry cap

--

> diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
> --- a/net/sched/sch_taprio.c
> +++ b/net/sched/sch_taprio.c
> @@ -49,6 +49,13 @@ static struct static_key_false taprio_have_working_mqprio;
>   */
>  #define TAPRIO_PICOS_PER_BYTE_MIN 17
>  
> +/* Each entry is a separate 368-byte sched_entry and, in full offload, is
> + * also composed into a per-entry offload array. The u16 nla_len admits
> + * roughly 5460 minimal 12-byte entries, pinning ~2 MiB; 1024 matches the
> + * SJA1105 schedule-table capacity (SJA1110 provides 4096) and the act_gate cap.
> + */
> +#define TAPRIO_ENTRIES_MAX	1024U
> +
>  struct sched_entry {
>  	/* Durations between this GCL entry and the GCL entry where the
>  	 * respective traffic class gate closes

[Severity: Medium]
The commit message notes that the SJA1110 schedule table holds 4096
entries, but TAPRIO_ENTRIES_MAX is set to 1024.

Before this patch, a user could install and offload a taprio schedule
with anywhere from 1025 up to the SJA1110 hardware limit. With this
patch, parse_sched_list() fails those same configurations with -E2BIG
before the driver ever sees them. So a working full-offload setup on
SJA1110 stops installing after an upgrade. The commit message calls
this net-next hardening, but it is still a user-visible regression for
that hardware.

Why was 1024 chosen over 4096? Is it only to match the act_gate cap?
The allocation concern in the changelog would still be well bounded at
4096. Drivers that offload already have to check the entry count
against their own table size, so a software-side cap at the largest
known hardware capacity seems sufficient.

If 1024 is intentional, for example because schedules above roughly
900 entries cannot be dumped anyway, could the changelog say that
explicitly? It should state that SJA1110 users with more than 1024
entries will be broken by this change.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-H19Z.v3.r0.20261012193813%40mojatatu.com
