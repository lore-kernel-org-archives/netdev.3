Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794202370;
	b=Vi1mNKLaV8ZPOkC2nVqPf118+V8SUtKJWMSCXs22BsnNpKx/KSKnJVEg15ZeLZXD9ShJ
	 3aDmasEjN605NyO8Hhc8N/1vkjZdbiMh31WiJHVSqFe8++y6Wy3pE0hj51uE1aCAK2QzP
	 TA0+37mNTB5fDRpg/7EUoUKJrHnPLTBbY2Bkmlwk2DhbklHnHZj9jvmzxSoaSxp6ps33v
	 Gube8TyF+pXIT60HEuvOdsPuT7uW3RJlDHvRJgUS9j9aRV3dLZfoSGiZFl+xZxvoNDVvu
	 BvHL0hVhvEfmikditGI9VahGpLe1vQMePBkNfZnIWoMyaWR2xYjWanDGDDP6fHOcgTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794202370;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=M9ZETq7T1R9UCyvYbLAPs+OEJSYPIyDzuF8XiKAv+tI=;
	b=y2tLuUINgzHvWRGsM7t+yVrCKic9/k6kcWS++g4T9c409kf8B8pNx4mKW+O0QFttKcwu
	 qJvTP4d93HnqpFfpCx6WTKtFQaci2Mgz+qu6wgXfFWfqw+jvddLIaYRhfpVg90nuniyGF
	 qsKcak4BxIfGsTwDO3PlsugBZbUvzUHdZjO17RGihhkWV5l2Zp1W9Yku6lIZ4H8SV44tV
	 lyx7EGk+BeaJ99wqKJ7s5vqeuwhpoP9Av0vK1w4hgSD16maGTS4Ohqk4H29VhaResfWBJ
	 PPgIL4tsmhwgFIuGhvdfOKApxWIYqctAxnffvJ5OHrWzk/cQUzHDBdFDZ62YrFkB7Xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=ER1getbt;
	arc=none smtp.remote-ip=220.197.31.2
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEFC606A31C
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 05:32:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4AEFC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=ER1getbt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=M9
	ZETq7T1R9UCyvYbLAPs+OEJSYPIyDzuF8XiKAv+tI=; b=ER1getbt7GwEtXuQvH
	GTKsQM1zxnebEWJMQ6BAo4XQqeB4pazDnuuoTd/Qec2bJTtPDNkyTov0HJHil5To
	yaNrlM0sKK7O7uEbUPbrkGUf2gSVfJz313o82io1wNSceMX/ndmuRKOLVjm5EC2a
	iy1X31lf+AgD8goMRyOzibFw4=
Received: from device-ubuntu.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD3v47gWvFq37XTFw--.24970S3;
	Mon, 09 Nov 2026 13:32:36 +0800 (CST)
From: Fang Jiabao <kaquoin@163.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org,
	Fang Jiabao <kaquoin@163.com>
Subject: [PATCH iproute2 v2 2/2] ip nexthop: use the request size as the limit when adding encap
Date: Mon,  9 Nov 2026 13:32:09 +0800
Message-ID: <20261109053209.65753-2-kaquoin@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109053209.65753-1-kaquoin@163.com>
References: <20261109053209.65753-1-kaquoin@163.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3v47gWvFq37XTFw--.24970S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kw13Kr13Jw4fJFy8ZrW7CFg_yoW5Jr48pF
	Z3KFWDtrZ5JrWIya9rta1Ik3yUCw4xKayUCF1vk34qyFs8WF1SvFyIyrWYgrWUG397Jw4k
	trZrKw15GFWq93DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRsa9-UUUUU=
X-CM-SenderInfo: 5ndt30llq6il2tof0z/xtbC9RTqX2rxWvTb2QAA3j

ipnh_modify() passes a hardcoded 1024 as the size limit to addraw_l()
when it adds the encap attribute, and ignores the return value. Every
other attribute in this function is bounded by sizeof(req). If the encap
attribute does not fit, for example a seg6 encap with 59 segments,
addraw_l() prints "addraw_l ERROR: message exceeded bound of 1024" and
returns -1, but ip sends the request without the encap attribute and
exits with status 0. A nexthop without encap is then installed silently.

Use sizeof(req) as the limit, like the other attributes, and return an
error if addraw_l() fails instead of sending an incomplete request.

Fixes: 63df8e8543b0 ("Add support for nexthop objects")
Assisted-by: Claude:claude-sonnet-5-5
Signed-off-by: Fang Jiabao <kaquoin@163.com>
---
Changes since v1: new patch, the same problem in ip nexthop, as
requested by Stephen Hemminger.

Tested on current main (d95f6650, "man: ip-neighbour.8: document
protocol keyword"), in a network namespace with a dummy device, with:

  ip nexthop add id N via fc00:ee::1 dev d0 encap seg6 mode encap segs <N SIDs>

Before: with 59 segments or more, addraw_l() prints its error, the exit
status is 0 and the nexthop is installed without encap (observed on
e4cd9f1d, the only commit since then changes a man page). After: 58, 59
and 60 segments are added with encap, exit status 0. With 61 and 62
segments "addraw_l ERROR: message exceeded bound of 1048" is printed,
the exit status is 1 and no nexthop is installed.

The request buffer in ipnh_modify() is only 1024 bytes, so sizeof(req)
is barely larger than the old limit. I did not change the buffer size.

 ip/ipnexthop.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/ip/ipnexthop.c b/ip/ipnexthop.c
index ad8ad0c0..ae6a28d4 100644
--- a/ip/ipnexthop.c
+++ b/ip/ipnexthop.c
@@ -1108,10 +1108,10 @@ static int ipnh_modify(int cmd, unsigned int flags, int argc, char **argv)
 			lwt_parse_encap(rta, sizeof(buf), &argc, &argv,
 					NHA_ENCAP, NHA_ENCAP_TYPE);
 
-			if (rta->rta_len > RTA_LENGTH(0)) {
-				addraw_l(&req.n, 1024, RTA_DATA(rta),
-					 RTA_PAYLOAD(rta));
-			}
+			if (rta->rta_len > RTA_LENGTH(0) &&
+			    addraw_l(&req.n, sizeof(req), RTA_DATA(rta),
+				     RTA_PAYLOAD(rta)) < 0)
+				return -1;
 		} else if (!strcmp(*argv, "blackhole")) {
 			addattr_l(&req.n, sizeof(req), NHA_BLACKHOLE, NULL, 0);
 			if (req.nhm.nh_family == AF_UNSPEC)
-- 
2.43.0

