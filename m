Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4EF364059
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 06:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791699146; cv=none; b=SE2QiiBw0V0to0jxrbv7ZLtp4ZWH7Q35QAlQ3xW6uRgdQCCfkl35ICAucShp4K9HscLOZkjbdMGrfcYu90PZQ8aMZFac4RlyMUWn/aaZzLYIoQQSNLPKsqOl9Sh3K4jX024PzNxO2ODz2y8U3al7OAuOqEH6GikX0fc6qVpWw5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791699146; c=relaxed/simple;
	bh=8mcpf4fWKopbOjHtENZajQAAxtMZ5hkTESDGeHBMIg8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qenDf1zmBxziRVh6NhzvTTRptnKMBHnssQGVyTx+WDLcK/G9hhuLsuwsepkXQV/HcH+NGJyJfSTn1dz90SLv9lnapPwzkrbin/+FD7dhnPGJubyAIiKy0L5SiqEvrKAh/2dC7VRJxEIqtx4j/9gLdLJ+09SZh3ly3w7zGrvPjos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=itCqxZsn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="itCqxZsn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791699142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3OtobsetNL97b3na+Zv6s/etqKf7cHIXUL0GqltxKxQ=;
	b=itCqxZsnmx1mk69A7DY16mThDlczKTb9mlOImdkFB+X2pDPXMf9AmL61J0gTL81cjuJZ5S
	qmAH48s58mfNFlNXbSzfqqGJBp0Ub7vkXVO9XjR4VdsB2Kxq7g6oYJjBAoYBg5cJLS21Dy
	Ii+3kzh+ioa8IAsXyR1CESBIpi6HBJ4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-Ml0CsKhiNmawW1NAGEPnog-1; Sun,
 11 Oct 2026 06:12:16 +0000
X-MC-Unique: Ml0CsKhiNmawW1NAGEPnog-1
X-Mimecast-MFC-AGG-ID: Ml0CsKhiNmawW1NAGEPnog_1791699135
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 018EF18009CC;
	Sun, 11 Oct 2026 06:12:15 +0000 (UTC)
Received: from ivecera-thinkpadp16vgen1.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 926FA1956095;
	Sun, 11 Oct 2026 06:12:12 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Min Li <min.li@microchip.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jakub Kicinski <kuba@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v5 0/5] dpll: zl3073x: fix output pin frequency, esync and sibling notifications
Date: Sun, 11 Oct 2026 08:12:06 +0200
Message-ID: <20261011061211.448373-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

This series fixes several issues in the zl3073x output pin handling:

1. Do not offer 0 Hz as a supported frequency, it leads to a division
   by zero.
2. Reject N-divided output frequencies that cannot be set exactly.
3. Reject output frequencies whose divisor is too small for the HW.
4. Update the eSync period and width when the output frequency changes.
5. Notify the sibling pin when a shared output setting changes.

Changes since v4:
- Reorder: the setter checks for N-divided outputs (now patch 2) come
  before the probe-time divisor check (now patch 3), so every commit is
  consistent.
- Patch 1: move the 0 Hz check in zl3073x_pin_check_freq() here from
  the divisor patch, so the division by zero is fixed at this commit.
- Patch 5: fix the comment in zl3073x_dpll_nco_pin_register().
- Say in each commit message how the issue was found.

Changes since v3:
- New patch 1 to fix a division by zero reported by Sashiko.
- Patch 2: keep the P-pin quotient in 64 bits and reject values above
  U32_MAX; check esync_n_period < 2 first; fix comments and extack.
- Patch 3: state that the check is necessary but not sufficient for
  N-divided outputs.
- Patch 4: report the eSync frequency and pulse from the registers again
  instead of a fixed 1 Hz / 25%; compute the pulse in 64 bits.
- Patch 5: fix the sibling lookup kernel-doc and the commit message.

Changes since v2:
- Added patches 2 and 3.
- Patch 4: simplify zl3073x_out_esync_is_enabled().
- Patch 5: add/remove pins from zldpll->pins around dpll_pin_register()/
  dpll_pin_unregister() so a registered sibling is always found.

Changes since v1:
- Patch 4: pass the actual output carrier to zl3073x_out_esync_enable(),
  drop a redundant "? true : false", fix a comment typo.
- Patch 5: commit message wording.

v4: https://lore.kernel.org/netdev/20261009192556.272263-1-ivecera@redhat.com/
v3: https://lore.kernel.org/netdev/20261006153116.347497-1-ivecera@redhat.com/
v2: https://lore.kernel.org/netdev/20261002074520.30048-1-ivecera@redhat.com/
v1: https://lore.kernel.org/netdev/20261001080648.1424172-1-ivecera@redhat.com/

Ivan Vecera (5):
  dpll: zl3073x: do not offer 0 Hz as a supported pin frequency
  dpll: zl3073x: reject inexact frequencies for N-divided outputs
  dpll: zl3073x: reject output frequencies with too small divisor
  dpll: zl3073x: make embedded sync follow the output carrier frequency
  dpll: zl3073x: notify sibling pin when shared output config changes

 drivers/dpll/zl3073x/dpll.c | 237 +++++++++++++++++++++++++++---------
 drivers/dpll/zl3073x/out.h  |  36 ++++++
 drivers/dpll/zl3073x/prop.c |  56 +++++++--
 3 files changed, 264 insertions(+), 65 deletions(-)

-- 
2.56.0

