Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5067113C908;
	Sun, 18 Oct 2026 09:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792314206; cv=none; b=VqmWvDiPsSft7jOnPw7pqvOeP74u/8jCs8xnImROpdeaLrmbCs9ddt8sii3hf8abogklYdqo6A8r/Z7i6hdbd4Sp+kvTfV4Uo+z+C+r2T9AcB6gzOeVhKypqyGXVS2wjtBBgHw/smpuSJ/bbrH8VJ43L7ql8fnwZ7ILDhK4f3/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792314206; c=relaxed/simple;
	bh=T5c5NmSRvnu4StTaxkoP31O9u3PJ1ybPYmwfRckWBp8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UXOC6OVDGrI8LSUn7n/qMkhrGHLx1TA4kClIgH8K1I7Z1Bdj1WKxXQ7Je9i6XbJZlhxT1881QRVnuHAddQfxjwbe5ZzPZv7mW1n6Vbo54Yh8Hva0tFOS8qyXAxt8pqX58B7XmV4mAJghAMPD2mWjNmmwwyIeGQkiVg7fJzy8H90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.b=rBjOoaY/; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.b="rBjOoaY/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=rBjOoaY/MO7B+P0K1+7ZpAQRnqe2qwmSI+Rq9cElaOTNrNvQVMWIfaX0/7uiwo8vGx6uLfBUy60j+
	 8DKKRq0n+d6kQ8dYwENiZjgYoMYCTO+3tc/Vc9MTLWhe9S3yItCnLXuNTM/llfrA+AHSdQTvpZxo+f
	 zaZsTa8UKV2F4ng8=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee76ad48b4f2e4-08979;
	Sun, 18 Oct 2026 17:03:12 +0800 (CST)
X-RM-TRANSID:2ee76ad48b4f2e4-08979
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from openEuler-24.03 (unknown[112.22.251.201])
	by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea6ad48b34aee-7c1c3;
	Sun, 18 Oct 2026 17:03:12 +0800 (CST)
X-RM-TRANSID:2eea6ad48b34aee-7c1c3
From: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	William Tu <u9012063@gmail.com>,
	linux-kernel@vger.kernel.org,
	Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Subject: [PATCH net-next 0/2] erspan: fix two header parsing issues on receive
Date: Sun, 18 Oct 2026 17:02:34 +0800
Message-ID: <20261018090236.2487997-1-yanhaishuang@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ERSPAN type II and III receive paths, in ip_gre and ip6_gre, trust
the header more than they should:

Patch 1 drops packets whose ERSPAN version is neither 1 (type II) nor 2
(type III). With version 0 the ERSPAN header was passed up as the start
of the inner frame, and collect_md copied the metadata from bytes that
were not pulled. This is not urgent, so it goes to net-next with the
Fixes tags.

Patch 2 skips the optional platform specific sub-header of type III,
which follows the header when its O flag is set, as described in
draft-foschiano-erspan-03. Without it, the 8 bytes of sub-header ended
up at the start of the mirrored frame.

Both were checked with hand-built GRE/ERSPAN packets sent over a veth
into erspan and ip6erspan devices, in plain and collect_md mode: before
the series, the version 0 and the O flag packets come out corrupted;
after it, the first is dropped and the second comes out intact, and
type II and type III packets without the sub-header are unchanged. Ping
over erspan and ip6erspan, version 1 and 2, still works.

Haishuang Yan (2):
  erspan: drop packets with an unknown ERSPAN version
  erspan: skip the platform specific sub-header of ERSPAN type III

 include/net/erspan.h |  4 ++++
 net/ipv4/ip_gre.c    | 14 +++++++++++++-
 net/ipv6/ip6_gre.c   | 13 +++++++++++++
 3 files changed, 30 insertions(+), 1 deletion(-)

-- 
2.43.0



