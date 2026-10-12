Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C164F3CF698;
	Mon, 12 Oct 2026 22:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791844606; cv=none; b=O2Nv/3Dc2UKHTy6CuS4FO3twKD8fIQzEENbjGhpOeg51gGfm66DtuYbckgO45G6iYVv+Vk+vqUNPmwhUh/V4czVekkNafG+992nWyZGFZXSz92+KWpAC6w6bpr2a1x8AwMAnP2lED/vW13QZ7/Q2UQWUicad9e1tQxv+yzyOTS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791844606; c=relaxed/simple;
	bh=H282eFWuh9QjEZss/a4ntW/J0HsTATvCkzDshh2ovmk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BaGDiMmXVil/l4BiMMdnPVWt1EfLpGP0fPABMKlpNtORX3RnxDgslWVJXD9xH62QlaoV/mWKnRLO8MqRiOpKm5Tj5DJCT3D4truQTEqHCaCx8/HKIJW5E+L7nP3mRls+0gM3mVLa4brTfF6hIEMc1eGUXOgC6CdaWcz/ddszEfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b1NrtFLC; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b1NrtFLC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791844605; x=1823380605;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=H282eFWuh9QjEZss/a4ntW/J0HsTATvCkzDshh2ovmk=;
  b=b1NrtFLCoe5Zj1UfUSgEjHsrTHRb8g9Hut5TC2WXlS0QU6ekAjU4AWUf
   aYVjf6mfBUx1ExT9qxNMdVatqJQ8TWOx5Hih2F9L3xkIC+oysHJEnN461
   /3rx6ENqPpNsTgLdpXxQFp63cEmBf+0GXxGFuDTNtovAVP+vwwyXgginq
   HoIwRdRv3KyJtFatgJt0AHPw12XA9l7ClxTh87Z9l4QKCn0qlg/WtJE0z
   JQtl9JZt3YllUsbiN5Ft9FuP++II0uvxeSb/akd74a4s8tffkHqvpaDM0
   ogDT1Mf4vadpshX4+YZTRRxX6x9c39v1WcSjWXNwnpb9j2Y3YUsjOzmkw
   w==;
X-CSE-ConnectionGUID: jkFq5Dr0Rhmtcr4Mo+5i1A==
X-CSE-MsgGUID: BH6XGseGSqCTkp3gnjCgUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="466569"
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="466569"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 15:36:44 -0700
X-CSE-ConnectionGUID: FS55T8z3TBSDLIx4BA/LVA==
X-CSE-MsgGUID: fVBF2ak0TfSPh4IadLpIkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="1327891"
Received: from vcostago-desk1.jf.intel.com (HELO vcostago-desk1) ([10.241.243.117])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 15:36:44 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Krystian Kaniewski <krystianmkaniewski@gmail.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 1/2] net/sched: taprio: reject software schedules
 that overflow their timestamps
In-Reply-To: <20261009123309.284193-2-krystianmkaniewski@gmail.com>
References: <20261009123309.284193-1-krystianmkaniewski@gmail.com>
 <20261009123309.284193-2-krystianmkaniewski@gmail.com>
Date: Mon, 12 Oct 2026 15:36:43 -0700
Message-ID: <87mrsilf5w.fsf@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Krystian Kaniewski <krystianmkaniewski@gmail.com> writes:

> taprio takes base-time as an unbounded signed 64-bit value. A base time
> in the future is used as the schedule start unchanged, and
> setup_first_end_time() then adds the cycle time, the first interval and
> the gate durations of the first entry to it. With a start close to
> KTIME_MAX these sums overflow, and the software schedule starts with end
> and gate close times that lie far in the past.
>
> If this is the first schedule, the qdisc timer is armed for its future
> start. With an operational schedule running, taprio_start_sched() keeps
> the earlier operational expiry instead. A large cycle-time-extension
> can then trigger an early handover to the pending admin schedule.
> advance_sched() uses the invalid entry end as the next expiry and can
> keep restarting inside the same timer interrupt.
>
> Before a software schedule is initialized and published, check that the
> computed start is not negative and leaves room for every timestamp
> initialized from it, and reject the schedule with -ERANGE otherwise. Full
> offload and txtime-assist do not use the software timer and are not
> affected. Schedules with a reasonable base time behave as before.
>
> Fixes: 5a781ccbd19e ("tc: Add support for configuring the taprio scheduler")
> Assisted-by: Codex:gpt-6.1-sol
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Krystian Kaniewski <krystianmkaniewski@gmail.com>
> ---

Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>


-- 
Vinicius
