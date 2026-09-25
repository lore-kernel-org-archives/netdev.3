Received: from mail-pj2-f7.google.com (mail-pj2-f7.google.com [74.125.227.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3C64A3D3C
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 13:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790343941; cv=none; b=S9Itlhyoyg1SHRBWgmtVNWtB/o3XrgJ91RdLI0eXqlmheCnWHoV34CPG+KRvY7dgZ9sms2/K4vq4EPHE6xXcTDBtihuUmN8wxcjrobAacbXrhHc5pqKnHKN9Uq/YILy61iQQara7t18RmUMNchhRrsCz1N2Nyhq3/VNTeqzhfPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790343941; c=relaxed/simple;
	bh=+bHbt8SK7E24aPNItB5CMZDFsNJpeB4IQt7eWvoUkAI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PJx4i7eoODHZkIAgbAWnds92DusIotUaHfkv5tIHSVbsQ5H4pIPaFgkg361coV53/399SGvgqQGUXJyctQ5jnNuE2bV02WkEWTEd/z82aDWNYFQoy/nTDoXU0MBm+vS8Loh2nMHISPcK6C4fD7xgFdb4nJ1wKXsdl4Tw6bwda+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W+yGQ5GG; arc=none smtp.client-ip=74.125.227.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+yGQ5GG"
Received: by mail-pj2-f7.google.com with SMTP id d9443c01a7336-2d561173f9fso5503095ad.0
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 06:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790343936; x=1790948736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8HYnEX5a9U5CNmxLV9uO4x7KkybD9D/59hOB7uKTMWg=;
        b=W+yGQ5GGlvyQ2lDy1yDA1oEN9Db4EGPOx4Vczy99XzYVU1hiau8VMtVJslh8ADwdbo
         IIRZnxLqa0397nc+EJE8ROONfMmfIEDihcZ0y/MjdUMVlQArygfXVUXf+uPaqQv+yyb2
         29SXZyXLzpg3OtQCNIim6CxIznhEWgZffF7ulYYYiNdD6xJebowYa9tW7SwGNrWosT5N
         w/p0+ifXY448B0oN2VME9TzodGONEgBgYbRFFO424KIPKEbYUxZgS/UjvS6ulQ7CXfbD
         Y1NRtuA1D3gLimVdmsvnQEFBLndr4Dc77y4rWLGFYxDSTqV3saQOUbFUajNfUCHD7xqc
         Ks4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790343936; x=1790948736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8HYnEX5a9U5CNmxLV9uO4x7KkybD9D/59hOB7uKTMWg=;
        b=xREAwWQEa7oS6kMZakBETIrVkM4mfklsA9R9YIf0S9qNlJREL6Z4nhGdgZL6iOpKcU
         QSXDLSy43tmniAEX9B0mc+EcK37zvCDvH3wjyMNyGzUl14aLnCFieVkgx06tPA2tUhmf
         Q8vgd+8LJlSOasEIK8IUNqgAnyhYZZvsgcS6VVhiEruGFdhed8E8KH9iCR2wNltxzxTu
         TMZNVt3wyImFO9+xbrHNWF5vPYoZczQGG+hRdus9eHrUBrsjSoXyq/T2yTECeMCHZlef
         ZwXr0FV+oca9/XPzzB+FXQyovhBmLtaDVaP8MQ3pzbMZ6RbpY8G2Skg3geR6x7iPE5nH
         1Ctw==
X-Forwarded-Encrypted: i=1; AKwUvBxetXQhZOIZ0uHJMHB3OaBBwxgK7HFMUoX8L3X5i1whVhGx29V7XL0ck2dWE6tBL1M10ZQabW8=@vger.kernel.org
X-Gm-Message-State: AFuF++kHfWFV0sDCk7GKLheglkoeysDoNhgMSniBgHwCO6m6MHe5mHLv
	veF3orQUrM1aswCWLZK0zEC0NE51LFYCH4MfXiIrwM3SnnPez59NC5/y
X-Gm-Gg: AYBFou0P2E0We1HcOCDN8fhDlnQgKV6Ix89ifzxOmb2ZfuGVoG+Y5NgS466MkEXRRv3
	vRy2PmcGPjvf82f/FllhAeIdGcpNNZNlNfalXpRT01q/FQ9RFMuOyCPK2KUPKwp0TMVXDSWWxRM
	Kuc0pIu0jB4NkMSC05qq/vCZ2CMfzjWwwDOu4TmO9tYBTcNro3QIWmpSqNU1pQb3MjqbE2fXKPr
	sFVTmHcdV2mkYbXfWrCpJRmOMp+BvA3g4pWQ9hVDeBgL+S8BAcT1nNOm3nXRXMrspiVm/i5DczS
	pQ1Z1GmkwmGpQ9boiLGFslm+NoVyVOP9r+cwl8/XMw1oAq18vtswcTz0LKYVOvbMa2Z5GMmdi90
	Ysl8OoG3wfQPSjDTn1CAdScZ4dLOziuGyBwvyrUcwD94Ttmt3s6oM5FvcLr6cOeYnHTGFMiw5+M
	7RHMU6nEVTWeN+eJMjOmbRgU/2B5dsgQ5v6ktKJm2WWivXCkJr3vmuN4BWR9LCFFBIEcvViRVuw
	1ul9SVgEpw/hA==
X-Received: by 2002:a05:6a00:f0f:b0:846:bc60:5bf7 with SMTP id d2e1a72fcca58-87e989907acmr5030603b3a.6.1790343936100;
        Fri, 25 Sep 2026 06:45:36 -0700 (PDT)
Received: from localhost.localdomain ([112.49.112.188])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8804595820esm905394b3a.57.2026.09.25.06.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 06:45:35 -0700 (PDT)
From: xiaoshoukui@gmail.com
To: tung.quang.nguyen@est.tech
Cc: edumazet@google.com,
	jmaloy@redhat.com,
	netdev@vger.kernel.org,
	w@1wt.eu,
	tung.quang.nguyen@dektech.com.au,
	xiaoshoukui@ruijie.com.cn
Subject: Re: [PATCH net] tipc: fix memory leaks in bundle and fragment paths
Date: Fri, 25 Sep 2026 13:43:41 +0000
Message-Id: <20260925134341.11418-1-xiaoshoukui@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <DU4P189MB37506A937448D1ED977C7BFCC6842@DU4P189MB3750.EURP189.PROD.OUTLOOK.COM>
References: <DU4P189MB37506A937448D1ED977C7BFCC6842@DU4P189MB3750.EURP189.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Tung,

Thanks for bringing this performance concern to our attention and
sharing your benchmark results.

> This patch tries to address an unreal use case. I am waiting for
> your real reproducer and explanation on how data part of bundling
> and fragmented messages can contain invalid types/users.
> Of course, tipc_data_input() drops invalid types/users as designed.
> The check is redundant because tipc_data_input() never returns false
> after calling tipc_msg_extract() or tipc_buf_append().
> This is not correct. If tipc_data_input() returns false, the skb
> will be dropped.
> tipc_data_input() releases invalid skbs as expected.

Your observation regarding truly illegal message users is correct. In
the default case, tipc_data_input() drops the skb with kfree_skb() and
returns true. However, this issue concerns the recognized internal
control users. For these users, tipc_data_input() returns false without
freeing the skb:

static bool tipc_data_input(struct tipc_link *l, struct sk_buff *skb,
			    struct sk_buff_head *inputq)
{
	...
	switch (msg_user(hdr)) {
	case TIPC_LOW_IMPORTANCE:
	...
	case NAME_DISTRIBUTOR:
		...
		return true;
	case MSG_BUNDLER:
	case TUNNEL_PROTOCOL:
	case MSG_FRAGMENTER:
	case BCAST_PROTOCOL:
		return false; /* <--- Returns false WITHOUT kfree_skb() */
	...
	default:
		pr_warn("Dropping received illegal msg type\n");
		kfree_skb(skb);
		return true;
	}
}

The two receive paths where this occurs are:

1. Nested Bundle Path
   crafted packet
     -> outer msg_user = MSG_BUNDLER
     -> payload contains a structurally valid inner MSG_BUNDLER
     -> tipc_msg_extract() allocates and extracts the inner skb
     -> tipc_data_input() sees MSG_BUNDLER and returns false
        without consuming the skb
     -> the bundle extraction loop ignores the return value
     -> the extracted inner skb is leaked

2. Fragment Reassembly Path
   crafted fragment sequence
     -> reassembly completes in tipc_buf_append()
     -> the complete reassembled skb has msg_user = MSG_FRAGMENTER
     -> tipc_data_input() sees MSG_FRAGMENTER and returns false
        without consuming the skb
     -> the fragment completion path ignores the return value
     -> the reassembled skb is leaked

The reproducer source code and instructions have been sent to you
separately.


> Note that we do not want to add check for unreal cases because it
> causes performance regression.
> I tested your patch and it showed regression as below:
...

Regarding the reported performance regression, We conducted two
investigations: an assembly-level analysis of the hot path,
and a clean-environment performance benchmark with strict
CPU affinity.

1. Assembly & Hot-Path Analysis
--------------------------------
We compared the generated disassembly of baseline, patched, and
unlikely()-annotated builds using identical compiler toolchains and
optimization flags.

For the bundled-message receive path:

Baseline:
	call	tipc_data_input
	...
	call	tipc_msg_extract
	test	%al, %al
	jne	<next_extracted_message>

Patched:
	call	tipc_data_input
	test	%al, %al
	je	<drop_reason_path>
	...
	call	tipc_msg_extract
	test	%al, %al
	jne	<next_extracted_message>

The disassembly confirms that adding a single `test` + conditional
branch on a register cannot account for a 10%--15% throughput drop.

Adding unlikely() shifts the basic-block layout and branch direction
as expected:

	call	tipc_data_input
	test	%al, %al
	jne	<next_extracted_message>

Nevertheless, using unlikely() makes the exceptional path explicit,
improves readability, and is consistent with kernel coding
conventions. The fragment-reassembly path is similar.

2. Benchmark Methodology & Results
----------------------------------
We re-evaluated the patch series in a high-throughput, CPU-isolated
network namespace environment (`netns` + `veth`) to eliminate
external hardware I/O bottlenecks and measure pure kernel hot-path
overhead.

To eliminate thread contention and CPU migration jitter---which
previously caused bimodal performance drops (fluctuating between
~32 Gbps and ~48 Gbps when threads floated across cores)---we strictly
isolated CPU cores via taskset:
  - Client side (netperf): Pinned to CPU 0 and CPU 1
  - Server side (netserver): Pinned to CPU 2 and CPU 3
    (taskset -c 2,3)

Under identical hardware and isolation conditions, we ran 10-iteration
benchmarks comparing unpatched vs. patched kernels with NAGLE disabled.

The average throughput was:
+----------------+----------------+---------------+------------------+
| Message Size   | Unpatched      | Patched       | Delta (%)        |
+----------------+----------------+---------------+------------------+
| 64B (Small)    | 69.80 Mbps     | 68.58 Mbps    | -1.22M (-1.75%)  |
| 65,536B (Large)| 46,992.62 Mbps | 45,834.77 Mbps| -1.16G (-2.46%)  |
+----------------+----------------+---------------+------------------+

The results show NO statistically significant performance regression
(< 2.5% variation, falling entirely within standard measurement noise
and thermal throttling).


3. Explanation for the Previously Reported Degradation
------------------------------------------------------
During troubleshooting, we observed that if `netserver` (or softirq
handling) is not pinned to dedicated cores separate from `netperf`,
the Linux CFS scheduler frequently migrates `netserver` worker threads
onto the core running `netperf`.

When client and server threads contend for the same core, cache
bouncing and time-slice preemption can reduce throughput by 25%--30%
in 40Gbps+ testing.

To help align our benchmark methodologies, could you share a few
details about your test setup?
- The exact netperf repository version/commit used;
- Whether `netserver` and softirq handling were CPU-pinned;
- Whether node1 and node2 were physical hosts or virtual machines;
- NIC / link speed and CPU model;
- The exact method used to disable TIPC Nagle.

Thanks,
Xiaoshoukui
