Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.77.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D782D617
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 14:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.77.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783779031; cv=none; b=aAfeJ1zeXhc9nmNEQvB9zHmYto4G1nzwx+bDeqwcKYPqix/Zw1mhZ3qb2GAUeqODW9pjLM7VgvaV4nls/OoDvq/DYUD16jpn6w08HJ9MQPr0Wif5AwmfwF/vuP5f54yaCDXP7ZN294svbFei6kQ8t2x7ia2IITgg2W3HsyeNLvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783779031; c=relaxed/simple;
	bh=qQzG8LihjOK0cMyeTF0aPqL37/1zDlQWySjfLyQ/OmY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WgbQiuu0veL5sM2RQgSf+GgTw8RuzM2ukA3d+vdyX79NW6mcNZX6U5OcUGsI+2tss0WtOxIuTwrbiGII4XE1yz5y2VsrZjo/nppxKeOYk9s9WlLHb/45NXLTZoqgQ9frHJMG7KkujEXQmtZejFN3iywcdwGbdLG2jO4DHJMAnC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=mJqsE0dH; arc=none smtp.client-ip=44.246.77.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="mJqsE0dH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1783779030; x=1815315030;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Zc0IUqfspWIdsBdj6E5oaopTppe3egV9yGHAAdC4TAI=;
  b=mJqsE0dHpLNbcfzMZ5SfSGhG6Vl0x33YSghEJQZjWXGFR3yPX/bUlwk0
   POBi0HdK1UrD5wSSgmLFKb5jYOpro/8UqYwxRJipVETyRj1rmPMJoVccG
   uWXFfL6+2hELuVgM2qXjtsOMOkY8HMyP3xvJDmj+AUiMd1kKjANxcEgxI
   xb75rtyBKY6r7NEVTxrfH1FSiNBQmLMP3QY4kNbwHu75e0ByhPsT18L8X
   +Kds5geH040pXFk/SY+Yj4Jla7fr5s3nqnr89baPlU1FwTzfax8eN0nkn
   PNIPDnGKqTl+IRdPGNktViH1wGfV3BDkbcuuld97TlzFb01XuWAuAu1ga
   w==;
X-CSE-ConnectionGUID: 4Uyi22c0R0CG1YR4/xKX1w==
X-CSE-MsgGUID: hFvdzhlhTTevAeQy5Iffjg==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; 
   d="scan'208";a="23482300"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 14:10:27 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:3701]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.54:2525] with esmtp (Farcaster)
 id 499d36dd-89d8-4b4d-98b7-8d97e3555623; Sat, 11 Jul 2026 14:10:27 +0000 (UTC)
X-Farcaster-Flow-ID: 499d36dd-89d8-4b4d-98b7-8d97e3555623
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 14:10:26 +0000
Received: from 603e5f7bc1fe.amazon.com (10.37.245.7) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 14:10:24 +0000
From: Takashi Kozu <takkozu@amazon.com>
To: <anthony.l.nguyen@intel.com>
CC: <aleksandr.loktionov@intel.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <enjuk@amazon.com>,
	<horms@kernel.org>, <kohei.enju@gmail.com>, <kuba@kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <piotr.kwapulinski@intel.com>,
	<sx.rinitha@intel.com>, <takkozu@amazon.com>
Subject: RE: [PATCH net-next 04/11] igb: prepare for RSS key get/set support
Date: Sat, 11 Jul 2026 23:10:07 +0900
Message-ID: <20260711141009.52519-2-takkozu@amazon.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <70999e07-114e-47af-a8b1-912a30eccb8a@intel.com>
References: <70999e07-114e-47af-a8b1-912a30eccb8a@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWA002.ant.amazon.com (10.13.139.32) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On 7/1/2026 2:02 PM, Tony Nguyen wrote:
> > From: Takashi Kozu <takkozu@amazon.com>
> ...
> 
> Hi Takashi-san,
> 
> Sashiko flags this for the power management path.
> 
> "
> Will the new ASSERT_RTNL() in igb_write_rss_key() trigger a false-positive
> kernel warning during runtime power management resume?
> When the device undergoes runtime PM suspend and then wakes up,
> igb_runtime_resume() is called. This passes rpm=true to __igb_resume(),
> which
> explicitly skips acquiring the rtnl_lock() to avoid deadlocks.
> __igb_resume() then calls __igb_open(), which cascades to igb_configure(),
> igb_setup_mrqc(), and finally igb_write_rss_key(). Because the lock is
> intentionally not held on this path, the ASSERT_RTNL() will fail and
> trigger a
> WARN_ONCE.
> Is it possible to remove this assertion or adjust it to account for the
> runtime PM resume path?
> "
> 
> Kohei-san's version in igc did not have this and it does share similar
> flows with igc. I'm not sure if you added this for a specific reason but
> would you be able to send a follow up patch to adjust or remove this?
> 
> Thanks,
> Tony

Thanks for the suggestion. Sent a follow-up patch as requested:

https://lore.kernel.org/all/20260711133239.29270-2-takkozu@amazon.com/

Thanks,
Takashi
