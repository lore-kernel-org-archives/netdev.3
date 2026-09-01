Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D393D34AC;
	Tue,  1 Sep 2026 02:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788231052; cv=none; b=gMBXrrXx8Gg4/0ujGxRNn1dB3NiSLJAopdyDAiXNqGJoqEzQSBW3tpInorSaxi0k1tQYgCRp3EucuCwd3b0RbHK5HxHHI+5d6RYLNcayX951J/1jRAJMgyAncUpP8+qc6u0dq2d+jLk0byFf8ryt3VY0ziBXXVq/RX248ntH5nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788231052; c=relaxed/simple;
	bh=ZgbpiglFmXriEEzaxEnIAR4/mOVrlXP3jDIVgf830oc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dw0/k9lhhv7wiI9AFbeD4ExAe3CTQXc25rLsYC4RoloeYCGU1nJhhOCRiXOFx7YX8XpD2n0H23l1kOMzTXZShg1HRb7lZGwEZAHwiaUFS7xij8R0jtsJd3YnmbnWo2VlxJWckplSIU3QDMp203w5BGQAl7EN/HppMLBDznYPxfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cwx+fyaT; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cwx+fyaT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788231048; x=1819767048;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZgbpiglFmXriEEzaxEnIAR4/mOVrlXP3jDIVgf830oc=;
  b=Cwx+fyaTpvIhXIgPqvpI2ij+MZddEWZwA+v3bt5sRanNW2Qg6rJFLiLq
   49K3+f//DzBPZKB+YQebM8QQs1Cmv3LDeZYqSXkx5lsgPBe6uCi7BjK6O
   mp3KaFcbrNa9HcR4NaP5YyZ/uoeQYHfCZEVzH2pRLHGv8A8FYd91/I4qO
   BPMls76DwsMnk6JZnYcvvpcvJpqK5qcyrqfjQW9J3t4LRznnChXri/qwm
   UW2H0CLqdKYAyBBK6nJVhbPdL8KEZlN0pcxsmU8oBOhhR8FhujUl2jVZb
   uaDlG5YdqSxCH6pVnhpeeB2pgjy9ze9Fs1X5R4DE88GBSKxC1qrk4va9G
   A==;
X-CSE-ConnectionGUID: 76WxSiWeTaOsJgUrrthxCA==
X-CSE-MsgGUID: NyGSjhTER/+QugYI3+dRfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="87784667"
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="87784667"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 19:50:46 -0700
X-CSE-ConnectionGUID: Z5kr0kPFSuiDHesALIYv1w==
X-CSE-MsgGUID: ykezKnKsSf2uySwfGfH1kQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="272471874"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 19:50:44 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: David Ahern <dsahern@kernel.org>
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	idosch@nvidia.com,
	fmancera@suse.de,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: dropreason: add SKB_DROP_REASON_IP_TTL_EXCEEDED
Date: Tue,  1 Sep 2026 10:50:32 +0800
Message-ID: <20260901025032.418077-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <7afff157-a5ed-459a-9b40-47123efd71e1@kernel.org>
References: <7afff157-a5ed-459a-9b40-47123efd71e1@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Aug 31, 2026 at 8:23 PM David Ahern <dsahern@kernel.org> wrote:
> what about icmp_unreach, ip_expire, and other sources of
> ICMP_TIME_EXCEEDED? The reason code applies to more than just forwarding
> paths.

ip_expire and ip6frag_expire_frag_queue already report
FRAG_REASM_TIMEOUT. That is the reassembly timer (code FRAGTIME), not a
TTL, so it stays.

icmp_unreach is the receiver of a time-exceeded; no packet expires
there.

That leaves IPVS decrement_ttl(): it sends the ICMP, and the callers
then free the skb at their tx_error labels with plain kfree_skb(). A
reason there has to come out of __ip_vs_get_out_rt(), so that is a
separate patch.

> similarly for IPv6, there are more ICMPV6_TIME_EXCEED cases than just
> the forwarding path.

Same picture: frag expiry has FRAG_REASM_TIMEOUT, IPVS is the gap, and
ip6_err_gen_icmpv6_unreach only translates a received v4 error for sit
and gre.

The kernel-doc says "on a packet being forwarded"; v3 drops the
qualifier.
