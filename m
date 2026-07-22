Received: from outbound.ci.icloud.com (ci-2005i-snip4-1.eps.apple.com [57.103.89.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8AF4C77B5
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 10:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.89.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784715896; cv=none; b=sc+tSxQrIJXz3HVkSXz4n7gpYwO/prJtamcUA94uLV8Sv0EGUGRjwgHcehWwCpf1g2Inr8GSXij5nkiXYiJ+2bhWmtni1kDnZetFwTcqI2jlZ9tpOMb6Y/WD0BBymAqPWmlQuriE6g1hKiGJiHg6Y8AtoKhuYHSatewO2w4isZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784715896; c=relaxed/simple;
	bh=v+ib2dRWpZc6cejiBpvWLhHBsW9p7G2032Ilkk/3G9o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RnHBoliAZiKhrxPA/o/LKggzcHyeoPG45/cgkffOiXAkVUU1/f8ABwHGDH+4VuvhNbg2Xdo8NJyp7lJDEau2xhRJZ97eeWSBjIbU/x6MDFMebgUMBWUXlMWpMGids7FqA/iMANjpARO/tWETlJNDfxbmCZ122q0l4FwwXKKwqyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thehaxbys.co.uk; spf=pass smtp.mailfrom=thehaxbys.co.uk; dkim=pass (2048-bit key) header.d=thehaxbys.co.uk header.i=@thehaxbys.co.uk header.b=x3wX2Eht; arc=none smtp.client-ip=57.103.89.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thehaxbys.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thehaxbys.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thehaxbys.co.uk header.i=@thehaxbys.co.uk header.b="x3wX2Eht"
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-central-1k-60-percent-8 (Postfix) with ESMTPS id 6C4981800133;
	Wed, 22 Jul 2026 10:24:50 +0000 (UTC)
X-ICL-RepId: 019f895b-4e37-750a-92c3-01f450a07315
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQtJBEMGXgdeAFYCWgBLVxQEElAFdx9aFVEZSw9OGBwTVlZGBhcNVk1NEFYFVhNQCUpWUAIZHllQSxsOWRcDVxxWRVwYQwldBVccHQ5eRVsTVRdGCRkIXR0ZCEcfCjADQg5WA0MHRQAtGRxXUEMDVxhYAFEUREVRHxcNWE1aAlZNBUoDXwFbBUILSQNfA18DXgFPBV8aWh8aWhBzGV8OWhFBGkoeGQhdXkwTDU1DEkIVBBtGHkMEXy9dF14MXgU=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thehaxbys.co.uk; s=sig1; t=1784715892; x=1787307892; bh=Ym4CnQ83I9M1zT+uXLcZh8HICnLIvGZK5ngCQ19Iwi8=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=x3wX2EhtiKLDlhFNBgx7a3f3yJW+IOLZRvmbSlAnLaThGmBLxarcw2pcMIGXBSjo+0dbdrFG4/nbsNVPF5ISEmg27/dQBK8U3m7BKkDw2XFCsBLbd+BRIcNerLwg693zbJWVICmxMinvuaWyHZep/pY4L3zX4a7KDF3ebXnaT4jqeZoU71cXIqdZ1rxSKK0EdBkMetqkJRpNSr1AEfxpaAmc5Kdst2t8Y2Pk/8LMW7ggrr8lJ+iEX1V8WrmbzLp1E2tMyM5ZtUnnqGZAGD0GYGKKZY+cZrC0DCE+AxIQg246DMVeizG2ryC1E1Ku/eMUYMbXw7U8uKFCxP3wkO0eow==
mail-alias-created-date: 1318449231000
Received: from localhost (unknown [17.57.156.36])
	by p00-icloudmta-asmtp-us-central-1k-60-percent-8 (Postfix) with ESMTPSA id E25AD18004B6;
	Wed, 22 Jul 2026 10:24:47 +0000 (UTC)
From: jch@thehaxbys.co.uk
To: dsahern@kernel.org,
	idosch@nvidia.com
Cc: netdev@vger.kernel.org,
	John Haxby <jch@thehaxbys.co.uk>
Subject: [PATCH 0/1] net/ipv4: discard icmp timestamp requests
Date: Wed, 22 Jul 2026 11:24:40 +0100
Message-ID: <20260722102441.8762-1-jch@thehaxbys.co.uk>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: gkqW7uSvMpnXJC1_0RvsFHjKDoUEIkDS
X-Proofpoint-ORIG-GUID: gkqW7uSvMpnXJC1_0RvsFHjKDoUEIkDS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDEwMCBTYWx0ZWRfX32alqj0hjoaR
 LyU+Da+SzOhtD/WYi73WXl4yQo5duB+Z3fO9F+1v604PHf2Jv+R8DdPdVLe6fplKYsuR4lCg9HU
 f5Ihl7SAyzstj/xvubPlDs9e1mEyVnWXSuYK9WxWFfnUGq0K3f1Xz9bpPSFWLw4D/aeQJ4PN1cV
 QvmRh3Vj6GJ0M6IdZ4cuqBcpZu+JlqFOgkm0ePM23+lq7ALKbyr1cBHRUgMG0jp/EN5A7JSaFM/
 jtNJd5Sn32xWMcomykpG3Nz9VSU3mGQwYROr8qIMXAo4FPZyGYZXVPqXiQDtjmNbkbZwz9wyYDB
 zgg+ONPLF1b4a4gBVkC

If you google "CVE-1999-0524 fix" you'll see quite a few comments along the
lines "this recently showed up in vulnerability scans, this is how I fixed
it".  It shows up because in late 2022, the CVSS score for that CVE changed
from 0.0 to 2.1.  There are actually two part to this: one relates to
disclosing address information (which is long gone from linux) and the
other relates to disclosing timestamp information.

This is regarded a a vulnerability because it allows you see the host's
count of the number of milliseconds since midnight.  Indeed, according to
RFC 0792, and back in 1981 it had a potential use for time synchronisation
across hosts.  That early use-case has long since been supplanted by NTP so
you know how many milliseconds there are since midnight: it's the same as
on your host, your smartwatch, your phone and practically any other
computer you care to mention.

It's not as though the ICMP timestamp is an actual vulnerability, it's just
a pain in the neck because world+dog wants to know how to configure
iptables or nft to just discard this, so let's help everyone out by
discarding it in the kernel.

jch

John Haxby (1):
  net/ipv4: discard icmp timestamp requests

 net/ipv4/icmp.c | 42 +-----------------------------------------
 1 file changed, 1 insertion(+), 41 deletions(-)

-- 
2.55.0
