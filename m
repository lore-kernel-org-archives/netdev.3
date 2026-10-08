Received: from mta1.migadu.com (out-115.mta1.migadu.com [95.215.58.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB554772BE
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 09:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791451619; cv=none; b=bPHGpSc/Gi5ewmoA25Jvz/DrMhCTvklR/z1TvyzJplaq7ZS3q4BSLs0KQggb5HYyt9lcsD86+enPpskVC804CXtDv5D2qX7L4qnATyEyKZw9iLxnVyqt6pit3/yQpjSscEeRLEvy2tdHwVBt//b9BPHwQaiOv4lF2qeDKgZ1evE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791451619; c=relaxed/simple;
	bh=Y1rf2j04YK4K3tregMLbbNu8jvv63q8HotPNJjCj6lQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dU/naK52KmlzKMciaslOclTteZT5ml9ieHWRpTU4G1NBWXPe3xjv0zmAc+X5uG1fFSRFdw4P1bLrIspRuWhLri2WhXIEJfPG1/ZqnrIFhQ4+ybRVZLpsjOaIt7saKsv6YSvRXk7dpDMTM6fSkQIrf5JY69N2cPWo14Z+o5OnAcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=whPFHCmE; arc=none smtp.client-ip=95.215.58.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="whPFHCmE"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Y1rf2j04YK4K3tregMLbbNu8jvv63q8HotPNJjCj6lQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791451611; v=1; x=1792056411;
 b=whPFHCmEUwetvzBe7QSNGl3M/wiBvESnD4K2d/ZWz0ZIIRb/W1kJEeU0n4y+5h92aiUyaa5L
 +gT2/hU0DqfdzXM6WEmDzusi6BhmYUiu8w4w/+Sfzt7Y7zEk8447SnFnEUK3VypGtEo8fdSkhay
 xMc76MG0pt3dh9iTQzQhO+RU=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 71b16418b4e1fdce;
	Thu, 08 Oct 2026 09:26:51 +0000
X-Mizu-Trace-ID: 71b16418b4e1fdce
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 0/3] tcp: fix a few divide-by-zero in congestion control modules
Date: Thu,  8 Oct 2026 17:26:33 +0800
Message-ID: <20261008092641.140777-1-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1 and 2 were reported by VEGA <vega@nebusec.ai>.

Patch 3 was found while reviewing the other TCP congestion control
modules for the same kind of divide-by-zero on module parameters.

Target net-next since it is not a big problem.

v2 -> v3:
- Patch 3: spell out the divide by zero in the commit message (Kuba,
  Neal), read beta once with READ_ONCE() (Eric).
v2: https://lore.kernel.org/netdev/20261001112948.322463-1-jiayuan.chen@linux.dev/

v1 -> v2:
- Patch 3: rework as suggested by Eric.
- Patch 1 and 2: add Eric's Reviewed-by.
v1: https://lore.kernel.org/netdev/20260930100937.206377-1-jiayuan.chen@linux.dev/

Jiayuan Chen (3):
  tcp_bic: fix divide by zero on max_increment == 0
  tcp_hybla: fix divide by zero on rtt0 == 0
  tcp_cubic: fix divide by zero and endless loop on bad module params

 net/ipv4/tcp_bic.c   | 14 ++++++++++++--
 net/ipv4/tcp_cubic.c | 14 ++++++++++++--
 net/ipv4/tcp_hybla.c | 16 ++++++++++++++--
 3 files changed, 38 insertions(+), 6 deletions(-)

-- 
2.43.0

