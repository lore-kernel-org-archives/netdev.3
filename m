Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DE613D891;
	Sun, 16 Aug 2026 14:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786890538; cv=none; b=iIhISjuAMeZg3BEendv5pj6JKxUEBAklrYHh64EbxYunQC8A0fJA6ptCtImPoJgD5odFZf/SnXpP1SrXOt2lm50ST2c66O4MNrN09ydLtvAwZ2FZ5o4EPvswrrdiCa2lO3/A14E3jn47Y00OvS8g8NxR3BK1W20gyn8PPYXPU7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786890538; c=relaxed/simple;
	bh=x5aLQi4JWhP7oOZ4lbsquE+niaxd9swdsXIqxiBGSTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CLWWvNtT40kie2QZhqkcQEtm4H4XyUD8tr696yZ+9c+zc9f1xoDzJ/Gu2EkfpyHtJQiA5/0MeBxUXe06ZmWjWbWR5x9b5chIKf85iD8bW0U88AwqE8BI6PvlmlJ00H6hVRNygGX+F8xW2m8u+G0D6NDRaQxnR5okoAY0TUyzEuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EEw+d1n6; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EEw+d1n6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786890537; x=1818426537;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x5aLQi4JWhP7oOZ4lbsquE+niaxd9swdsXIqxiBGSTM=;
  b=EEw+d1n6EOTIntfAWiV3rV3h8sgAQF8GrGGlmOMI6YuA0Oaj/e5Zd3fj
   sY44UgXxgwbDyPf25RMKKRjLKqd7ZdF/faFQjfuUPkTX0hUqw0NTtZA8Q
   v46MUsU0koLOqYfwEmHUBfobPTnefKrIzoAwUwtXqzyB7kFuuK/7qcxrt
   bdhzvOc1BPiZubX+94D1yc8ou3JPG4TDIDoWj+PvtnL4E5I2qnPLSqYlm
   aHOpJSsc3tNXhJ9gXvp8HMNMz+5fEcl9Kg2231lCPyXnnDbUpe7/iI4E4
   WSlKJJXa39FG3hV9EYx80JHT5sTLEXSV81JD4+ypo+8lxaGiz+YGfIoCB
   Q==;
X-CSE-ConnectionGUID: 0fVku61eRnek6Gr7VzQNLA==
X-CSE-MsgGUID: bj3moSanSESJZnIUIG8VDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="86506570"
X-IronPort-AV: E=Sophos;i="6.25,227,1779174000"; 
   d="scan'208";a="86506570"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2026 07:28:55 -0700
X-CSE-ConnectionGUID: jE+FZ/g0SieGxLB2zUHAZw==
X-CSE-MsgGUID: vid6bwIOScGDzsR2WTwipg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,227,1779174000"; 
   d="scan'208";a="268171511"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2026 07:28:52 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Uladzislau Zhauniarovich <uladzislau.zhauniarovich@gmail.com>
Cc: Simon Horman <horms@kernel.org>,
	Hillf Danton <hdanton@sina.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+19d01f6082ec61dd45b2@syzkaller.appspotmail.com
Subject: Re: [PATCH] net/sched: taprio: enforce minimum software scheduling interval
Date: Sun, 16 Aug 2026 22:28:47 +0800
Message-ID: <20260816142847.227167-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <afe041f6-ef7d-4434-b2d0-096be49b5bcb@mail.kernel.org>
References: <afe041f6-ef7d-4434-b2d0-096be49b5bcb@mail.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 14 Aug 2026, Simon Horman wrote:
> Does this limit erroneously catch TXTIME_ASSIST offload configurations?

It does. Only pure software mode arms the per-entry hrtimer:
taprio_change() doesn't call taprio_start_sched() in txtime-assist
mode, and taprio_start_sched() returns early for full offload. So I
think the check wants to be

      if (!FULL_OFFLOAD_IS_ENABLED(q->flags) &&
          !TXTIME_ASSIST_IS_ENABLED(q->flags))

I gave that a spin on a patched kernel: a 2x50us txtime-assist
schedule on veth is still accepted, while the same 50us software
schedule is rejected.

On Fri, 14 Aug 2026, Hillf Danton wrote:
> Better if you specify why interval like 2us is ruled out.

The yardstick is the service cost of one expiry. On a release build I
see ~5.1M local timer interrupts in 5s on the owning CPU for a 700ns
single-entry schedule on veth, so the whole per-expiry service path is
around a microsecond; Uladzislau estimated ~10us per invocation on the
syzbot debug config earlier in the moderation thread. A 2us interval
still livelocks a debug build, and on a release build it pins a
permanent ~500k irqs/s on one CPU. 100us keeps margin above the
debug-config cost.

One more thing that came out of testing this: the floor only covers
half of the problem. A valid schedule that falls behind replays its
whole backlog one hrtimer expiry at a time. With a 4x200us schedule
and CLOCK_TAI stepped forward 72h (think ptp4l's first big step, or a
VM pause) I get an RCU stall with the owning CPU stuck in hrtimer
expiry processing, and no admission check can catch that; syzbot's
reports show the same stall with advance_sched() on the stack. A
bounded catch-up in advance_sched() fixes it. Conversely, catch-up
alone doesn't help the storm case: the 700ns schedule is still
admitted and sustains ~1M irqs/s.

I have both halves ready as a series - a bounded catch-up in
advance_sched() plus this patch with the exemption folded in - tested
by syzbot against both reproducer buckets on net.git dd057113ac7b,
with a tc-testing case. I plan to post it in a day, keeping your
Signed-off-by on this one, unless you'd prefer to respin it yourself.
