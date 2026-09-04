Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF5929ACCD
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 19:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788549266; cv=none; b=CKz4EBEIJFHeMcIuzjiPM8l6U0aVcd2d/fLRjvdIQOvEi9Ip+u6Wnh6MJJ0Q5itqApbVS8z5MwdadzHDER7PXplp1Af+AiXxauIj6NokORVsoo6fBvO4rXVlurOVYmuG+cUK2zfdmASIHVkgy7coV16CzIzHvHCL1CDtdQl43c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788549266; c=relaxed/simple;
	bh=02w3WpyFCFxAyFMQrYiHQqmAb0ZWNeb1N4XM7BUhWy8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GdWyGNLKFAveanpDnNSs1YprNh24PJ/4HPQSR0Vn1K1FEszcMXxV/wRWNSdP2UQvRuwzPRBcxlsAkZEVQUiX6OGKowtvH7GvEDlXYXeYH5havGWaGRNWDwAiQdrWHIrmx+6ur0JmPXLErkas0T5Z+NnqcKWbu52Yicex9rl1EjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IFnFAdLZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IFnFAdLZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BD5B1F00A3D;
	Fri,  4 Sep 2026 19:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788549260;
	bh=H5ishavciBRmZSnh1hkyFP1hulJJSD2xD3S8GXXR6As=;
	h=From:To:Cc:Subject:Date;
	b=IFnFAdLZaKJTGq4njmRFrsaMQnJmGxfuacb7/jY0Bt7IQ9kSjW6mAquIvCPe+o86b
	 QeoAMax3Ur6xSy7WKx3+t4ffhiDpnlTdqKCyRPxI70fHnONWpa4Ex8diBTbT/fgWHk
	 G6I0dX8sU0cFrylUVemCYTXuwOtgum5Hh9LE2c0XcWb9zAKg/6kROGTGMSL8wAPwvv
	 /nLYUB/YqIDMDlIDKl8u30u39CAEHOA6Bj0T2VXd7Zr1Btfw78cfHAI0arlAl4qmks
	 QS3I2zatn2lsyGdBDFWUHXnft+3gi39X7G748VBSsPIcOPbicJ4toYLJXv5Gag/gkk
	 KKgLNs1hnVyGQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	kuniyu@google.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/3] netlink: specs: fou: spec tweaks
Date: Fri,  4 Sep 2026 12:14:09 -0700
Message-ID: <20260904191412.3872344-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FOU was one of the initial families I used to develop YNL against.
It's not using YNL features which were added later, fill in the gaps.

Jakub Kicinski (3):
  netlink: specs: fou: add af to the shared attribute list
  netlink: specs: fou: local-v4 and peer-v4 are big endian
  netlink: specs: fou: link the type attribute to the encap-type enum

 Documentation/netlink/specs/fou.yaml | 4 ++++
 net/ipv4/fou_nl.c                    | 6 +++---
 2 files changed, 7 insertions(+), 3 deletions(-)

-- 
2.55.0

