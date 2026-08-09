Received: from sender-of-o58.zoho.eu (sender-of-o58.zoho.eu [136.143.169.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CCD126C02
	for <netdev@vger.kernel.org>; Sun,  9 Aug 2026 23:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786316610; cv=pass; b=TinUaTQbbatio0P8CsG/oPv7dQuhVj8YV2DXUe05L9T8btDuZl837b8sIQrYA+LA3dk2bjF8Azi8VhtHdqZEmvfkos+jjFIcyaTGtTROpzwUrPGi1CY5nof4zcN4xM8Efw6BxArZQhdfkBnes88qrh/glFFUyWmBKp4SUujkWNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786316610; c=relaxed/simple;
	bh=yUt/eCSIwHeda2sRTW3mHkj7tHB2dVZKWIpImZGob0U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a8N6cBtpZSZXGsl1GgFd20CYdh54U5tftqF0LmlK4qad3i1LRE27anIb14aYjpgWoSiu9RNOaRx1xEiWiSHKH65N2ysdZ7tNi08LTXhqZ6/uowsC6Nztx13uy3l4zS65uHRwHG/lQy3cKZhrqFVxqyswxKdD/gD1s7gQvNZYrPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com; spf=pass smtp.mailfrom=iusegentoo.com; dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b=LUjypAj3; arc=pass smtp.client-ip=136.143.169.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b="LUjypAj3"
ARC-Seal: i=1; a=rsa-sha256; t=1786316593; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=ikNwEpwovMgWuJ0mIJk4lrm25NpZt7uNdH8yQwU8C4DyQtoXNXHYxIEEFY0r+KSu2rGPdQhHBk5+Obl1uKFmtV2KhiwrBAN4FhQvZJJReeF7ow3klLnr9xprW3wrWGAWIBZ4h7LGQL7wWrP97mfBuR/JPctbqA+/QO23Ity4rpU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1786316593; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=yUt/eCSIwHeda2sRTW3mHkj7tHB2dVZKWIpImZGob0U=; 
	b=CQiRyVzs8KRefH0/TZIhXTvkzqLtF2pw3znjK5tOTNMZy+CnbTAPajmfanWAe6fD+bWt0S0qU6sxde/K+ZuYebPgHRm5hftk2DuQqmXZuSQMK/OUjESZ1fcI92d11n06XBcyUs4FAnS4fIQIw7IaPknSrn1bQ3jygyApyiDfVtk=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iusegentoo.com;
	spf=pass  smtp.mailfrom=ali@iusegentoo.com;
	dmarc=pass header.from=<ali@iusegentoo.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786316593;
	s=zmail; d=iusegentoo.com; i=ali@iusegentoo.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=yUt/eCSIwHeda2sRTW3mHkj7tHB2dVZKWIpImZGob0U=;
	b=LUjypAj3ZO0BQlIcRr2WeN7XsP7iP84UfIAbeE/Me8plasuJtq7WOyuKl9tD+SqI
	nTzQpFrZOGUnc/PK4znQvNdamG2LfY96CEMH5wXuwktctiMQJK1D/5KIEuPq0O63lC4
	orMVhJof/XyAscIVzwlz3Z+DgL5HEXcGGxcgGhCE=
Received: by mx.zoho.eu with SMTPS id 1786316590763226.00613751345168;
	Mon, 10 Aug 2026 01:03:10 +0200 (CEST)
From: Ali Ahmet Memis <ali@iusegentoo.com>
To: Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	netdev@vger.kernel.org
Subject: Copa congestion control: in-tree or BPF struct_ops?
Date: Sun,  9 Aug 2026 23:02:58 +0000
Message-ID: <20260809230259.726772-1-ali@iusegentoo.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi,

I'm considering implementing Copa congestion control for Linux TCP, and
wanted to check whether an in-tree implementation would make sense before
doing the work.

As far as I can tell, there is no in-tree Copa implementation in mainline
Linux today. Copa has been implemented using CCP, with an out-of-tree Linux
kernel datapath and the congestion-control logic running through CCP. There
is also a Copa implementation in mvfst for QUIC.

Meta evaluated Copa with QUIC on Facebook Live at scale. Their initial
deployment used a fixed delta without Copa's competitive mode, and they
reported lower latency than CUBIC together with good goodput results.

I don't see anything obviously missing from tcp_congestion_ops that would
prevent a native implementation. Copa needs RTT history for its RTTmin and
RTTstanding estimates, pacing, and per-flow state for delta and competitive
mode. BBR already maintains its own min-RTT state and controls the pacing
rate, so these parts seem possible with the existing TCP congestion-control
interface.

On the other hand, the real-world Copa use I can find is mostly in
userspace QUIC rather than Linux TCP. BPF struct_ops also supports
tcp_congestion_ops, including cong_control, so perhaps that is a better
place for an algorithm like this initially.

Would an in-tree Copa implementation be worth submitting, or would you
rather see it implemented using BPF struct_ops?

If an in-tree implementation is reasonable, what kind of evaluation would
you want to see with it? I can compare it with CUBIC and BBR across
different RTTs and buffer sizes, and test coexistence with CUBIC and
variable-rate paths. I'd rather focus on the cases that would matter for
review.

Some references I looked at:

Copa paper:
https://www.usenix.org/conference/nsdi18/presentation/arun

Copa over CCP:
https://github.com/venkatarun95/ccp_copa
https://github.com/ccp-project/ccp-kernel

Meta's Copa/QUIC evaluation:
https://engineering.fb.com/2019/11/17/video-engineering/copa/

Current Linux TCP BPF struct_ops implementation:
https://github.com/torvalds/linux/blob/master/net/ipv4/bpf_tcp_ca.c

BBR implementation for comparison:
https://github.com/torvalds/linux/blob/master/net/ipv4/tcp_bbr.c

Thanks,
Ali
