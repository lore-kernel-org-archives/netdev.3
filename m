Received: from sender4-of-o55.zoho.com (sender4-of-o55.zoho.com [136.143.188.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7393D2848BB
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 14:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771509942; cv=pass; b=W2TlY1xQpjE6LuLJ9vM4bloTIY2QxR4Qa/1fi7yjb6jOpXIhN17aB7ugQSKWTyp67kVJy1vuijvrb2QxgqaJJkJzXvn5GD9ovx1KDGld6PAyS9Afjirx9IBGFHKaGOogeQuV1CqBiw1kYDI/OE5WsfOtLjbruxh8CfPJh88yANo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771509942; c=relaxed/simple;
	bh=NBxLXlpfIsK6XOgW3Ibu+mG4Sw0zKY+rDDAVcBQqtPw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VqE/u3yUgKgCt+bDlmIUIjKoHchxy1YmCGiI3BCr7eQALH3u2ZsX7JD3YjlNIN6FNazTNwAMLSELWnGmiNi4v5GoQW+YxbujLJUDafpjjJE+IoZwbHmRvfMG40ivpp8wBWGIcM45FlEK+UuGSw8wbaPZhWKaU2Azt5NnEZ4XgHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net; spf=pass smtp.mailfrom=machnikowski.net; dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b=BuWrVhXt; arc=pass smtp.client-ip=136.143.188.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b="BuWrVhXt"
ARC-Seal: i=1; a=rsa-sha256; t=1771509936; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=gNuC1YxFcWSiOq/b9i8TR6H+iWh1XukxXjnX4jakUqP663K7pwWQLmz1q7HEebEkz1pgObSbGte9Spkn0zYMmaqLSZct7/AUrbPsGqqhx+BPKuBRV0t5drjt8vkHLZMeAFRclh2CAMUJE64+BydwN9TT4URs0WgS0Qmt6bV80GU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1771509936; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=H9xt4aJnquoZ/6ouPijJwUcqh9Lky1VLOzoMWI0zH10=; 
	b=P5qO2gxeBQqMj7xPfg7SVXebMH8TBViuuRlWqo3YSVF60XcNHSwJ8yvZGbEvu8Pf5y7gGKsQnb4FR1JoHcg7doEjIBHlbSa/ejPHcqamerknwwomcEOf1nqXiBjlB10u1Q0h5JgwuH510hf5KjUpritobRwsobATQSS3fa2xYhc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771509936;
	s=zoho; d=machnikowski.net; i=maciek@machnikowski.net;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=H9xt4aJnquoZ/6ouPijJwUcqh9Lky1VLOzoMWI0zH10=;
	b=BuWrVhXtqSW+SbNTpKsjnexCW7CAKmk0pjkc7NyS6jLeS/VsSpFuVwy5mo3LFQu6
	d8VPKHZd9vblO+4cXQVtuuD17GOTgHktvX+RYWzjU+/dxuKTUf/bS8u4BiLdpeR5njh
	CElkegxHxNk4x7H+7YSdFVUadrQD6NDauo5Ic76U423nk4PPFtS4BV/PsKPcKCpbMz1
	ae+7kKIGZlKYT0OL3o8/EF3GsLx3VRgylUeFxnQPfcYjwkBHKHFu5QzOy5YOiqFLHbk
	GjzTs0c8umR5MzFl9XizmlEdgXGgp9i3yyATt7XpkS5IFAIflo4dAzwEafXqATjv9gt
	qBwwpZl7Hg==
Received: by mx.zohomail.com with SMTPS id 1771509933199569.7670084828798;
	Thu, 19 Feb 2026 06:05:33 -0800 (PST)
From: Maciek Machnikowski <maciek@machnikowski.net>
To: kuba@kernel.org
Cc: maciek@machnikowski.net,
	richardcochran@gmail.com,
	netdev@vger.kernel.org,
	milena.olech@intel.com
Subject: [PATCH net-next 0/2] Implement PTP support in netdevsim
Date: Thu, 19 Feb 2026 15:05:28 +0100
Message-ID: <20260219140530.2148-1-maciek@machnikowski.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

This patchset adds support to the PTP HW timestamping emulation in the
netdevsim. It uses existing binding between netdevsim and ptp_mock
driver to generate transmit and receive timestamps.


Maciek Machnikowski (2):
  ptp: Expose ptp_clock_info to external drivers
  netdevsim: Implement basic ptp support

 drivers/net/netdevsim/ethtool.c   | 12 +++++
 drivers/net/netdevsim/netdev.c    | 90 +++++++++++++++++++++++++++++++
 drivers/net/netdevsim/netdevsim.h |  1 +
 drivers/ptp/ptp_mock.c            |  6 +++
 include/linux/ptp_mock.h          |  5 ++
 5 files changed, 114 insertions(+)

-- 
2.53.0

