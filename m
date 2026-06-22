Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B05369D40;
	Mon, 22 Jun 2026 21:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782163124; cv=none; b=N8z5X95Q4W6QrzVwjPFwb2Yy2FPx+0txB0uqun+R0aKqphiTLHfY3aJFhPdFb5ANcNhCnKQhRuAMuPIW5a2vMHo1E/+7S3aGzbxrpYpsIBds2S42wl2WCKtDQkoyXspj8vemU/ZhE6L6sJYw56vIF1XLb0CSwgyjRJTHlv58M68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782163124; c=relaxed/simple;
	bh=aMkYnH5FAadZr0ppI4gIkaHmwkvjYQ65am2yTwayGUk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eKtXWfBkJV/9PODEcGP3l1WVBjFmGLOgtiCII20KJqcz1fCGE4pv0CkyR2L6RVl7OcoWkM4E9njQlAQHBE/8Wz913cZHEqmH12gfE8kWQfkSZ+J0+Jx8TvLyDJMJoBBl22TFDrIwWX5gXdBt5Hxq7G+3PzJI2jsiIUoN8lf84O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QcsuG53b; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QcsuG53b"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=B7tKrCczUlMLEb8Lu7002dsg9384hRyjGedyu9rlOxI=; b=QcsuG53blnXtYe4Ku/Q/xboF2Z
	mBCkiCU6KDg0d5wTL3UJrQCHRib9dqqV0KQGzlMs2BuzICxTivTIVk3CcWve7Va2yR66l5W6JH4Hm
	B8ZGO6Ki/KBxgRuF31l6XbHcAr/9cY3MImWHYve4wrb+BQB2TttZwSCP7GwHOy4TlzGoVLftvVJJp
	P/ekc7Gl9M0jhVIInxlGKpTfhP3k7gwjkR6846JenFroONwzqUOMRARkXzUB83bFLF4J7jnJsi7Fo
	PitsF9cKDoa+5vWtqoM51UmLjNJKfyIMwkJEr//nkhtKINZsQdr8tUyG+4kr4gxIo/pVY33xZGPNz
	LbbqFB0Q==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wbm2G-00000000KDs-0V68;
	Mon, 22 Jun 2026 21:18:33 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wbm2D-00000004R50-0E7M;
	Mon, 22 Jun 2026 22:18:25 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: Rodolfo Giometti <giometti@enneenne.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Miroslav Lichvar <mlichvar@redhat.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [RFC PATCH v3 0/4] Add ntp_error to clock snapshot, enable NTP_PPS on tickless kernel
Date: Mon, 22 Jun 2026 21:36:17 +0100
Message-ID: <20260622211822.1056437-1-dwmw2@infradead.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

The real time reported by the kernel's timekeeping sawtooths around the 
'ideal' time line that the kernel would like to report. Limited by the 
integer arithmetic, the kernel varies the 'mult' factor by ±1 each tick 
to achieve the correct rate on average over time. The reported time is 
further sanitized to ensure continuity when mult changes, even part way 
through a tick. The delta from the ideal to what is currently reported, 
is stored in tk->ntp_error. The sawtooth effect is more pronounced on 
tickless kernels, as the 'mult' value does not get adjusted each tick 
but only less frequently.

Both ktime_get_snapshot_id() and get_device_system_crosststamp() report 
the same sanitized time, but *every* user of those functions (PTP, PPS, 
KVM enlightenments) would be better served by the true ideal time.

Add snapshot_ntp_error() helper and use it from both of those functions 
to adjust the system time they report and return the more accurate 
result.

With this change, CONFIG_NTP_PPS works correctly on a tickless kernel;
enable it. And change the non-CONFIG_NTP_PPS code path in pps_get_ts()
to use ktime_get_snapshot_id() too, for the more accurate data.

Tested with a hack to make vmclock simulate a 1PPS signal, although there
are now better options for that. But it's enough to show that even the
tickless kernel converges to ±1ns of the PPS signal and remains there
(tested with a periodic PTP_SYS_OFFSET_EXTENDED to compare with the
vmclock reference).

[    0.653414] Run /init as init process
PPS: coarse-set CLOCK_REALTIME from vmclock
[    1.655824] pps pps0: bound kernel consumer: edge=0x1
PPS: enabled, bound to hardpps, STA_PPSTIME|STA_PPSFREQ set
PRECISE: dev-sys(adj)=+5609ns OK
EXT[ 0] diff=+5608ns
EXT[ 1] diff=+5262ns
[    2.917076] hardpps: PPSJITTER: jitter=5173, limit=0
EXT[ 2] diff=+4914ns
EXT[ 3] diff=+1197ns
EXT[ 4] diff=-297ns
EXT[ 5] diff=-103ns
EXT[ 6] diff=+0ns
EXT[ 7] diff=+0ns
EXT[ 8] diff=-1ns
EXT[ 9] diff=+0ns
EXT[10] diff=+0ns

David Woodhouse (4):
      timekeeping: Apply extrapolated ntp_error to clock snapshots
      pps: Drop the !NO_HZ_COMMON dependency from NTP_PPS
      pps: Always use ktime_get_snapshot_id() for pps_get_ts()
      [DO NOT MERGE] ptp: ptp_vmclock: Add simulated 1PPS support

 drivers/pps/Kconfig                 |   3 -
 drivers/ptp/ptp_vmclock.c           | 196 ++++++++++++++++++++++++++++++++++--
 include/linux/pps_kernel.h          |   4 +-
 include/linux/timekeeper_internal.h |   6 ++
 kernel/time/timekeeping.c           |  71 ++++++++++++-
 5 files changed, 259 insertions(+), 21 deletions(-)






