Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5021F3F0A96
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 09:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786096785; cv=none; b=OWwtQPC+m+YDb4biBWKpsKt94yl4hJBS7Jcd0cCnQHCBbvVXKvOMp1jjemZdCa3gT2FhveuCw9rD8S1wEQ+hgnN2awct7UCBdx9KkHaEwxZoomJsbHUsnHY5J0PnbiaRuVTrqvj28aXKBuoI8EUwDREQhJcPkLFZnfynO8XWAMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786096785; c=relaxed/simple;
	bh=leTIKTOZ0GnO9FZnRu0QnM1ED+Wv3RNGLRyr5csLjzk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AF+lrMg050Fc8AZxE2vPDEAz/UlTWli3oQ79mtehT8wks/BJdgy3uABKed79UJ0tbS4cNi83lwzVA+o5UwlwA9lLiGleY3jzsHrSSZW6PeQ855lA4hMEJedFK/HF786Tp53OIFr94hJibjuNS7d5xMUK3wV5PM5ozCv3MPwQ2Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VWwbRhTm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VWwbRhTm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786096783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3ZHu+R2BL4GYF3C8MVDRVa2d/c+Q9hmKZdJFWVNxeRY=;
	b=VWwbRhTmvdigZFJhoxgDTkO9+Kr/bZec85ivntNvGiUpGXdr+EUFA1JdeEw1A1r6QteIAg
	5xRUE6YlWPSb+yjyctMHszZZo/zr/n7N0tI0Hg6zU38v4CfJeiEW39UAw5O3PX8sFWcsJe
	52Uj/Oa9xD7nHHjpEKUUGsftN0MC4sw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-513-ZDFppDSdP9KSidHGYzBpuA-1; Fri,
 07 Aug 2026 05:59:33 -0400
X-MC-Unique: ZDFppDSdP9KSidHGYzBpuA-1
X-Mimecast-MFC-AGG-ID: ZDFppDSdP9KSidHGYzBpuA_1786096772
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AEC60195608B;
	Fri,  7 Aug 2026 09:59:31 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.32.215])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D76AE30001A2;
	Fri,  7 Aug 2026 09:59:27 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Min Li <min.li@microchip.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Petr Oros <poros@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-doc@vger.kernel.org
Subject: [PATCH net-next v3 0/2] dpll: use pin owner's dpll ref for pin-level set callbacks
Date: Fri,  7 Aug 2026 11:59:24 +0200
Message-ID: <20260807095926.386923-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Pin-level attributes (frequency, phase adjust, embedded sync, reference
sync) are properties of the pin itself. The get callbacks already use
only the pin owner's DPLL reference, but the set callbacks iterate over
all registered DPLL devices, resulting in redundant HW writes for
drivers that share a pin across multiple DPLLs.

This series simplifies the set side to match the get side: call the set
callback only through the owner's reference.

Patch 1 prepares the zl3073x driver whose ref_sync_set callback had
per-channel behavior (setting priority on a single DPLL channel). It now
iterates all channels internally so it remains correct when invoked only
once.

Patch 2 drops the xa_for_each loops from dpll_pin_freq_set(),
dpll_pin_esync_set(), dpll_pin_ref_sync_state_set() and
dpll_pin_phase_adj_set(), along with the rollback logic and the per-ref
-EOPNOTSUPP validation scan. The dpll.rst documentation is updated to
reflect the new behavior.

v3:
  - Fix missing mutex_unlock on the normal loop path (was only on
    the early-continue branch) - folded into patch 1
  - Skip channels where sync ref priority is already NONE
  - Send __dpll_pin_change_ntf for the sync pin when priority changed
  - Reword dpll.rst to describe observable effect, restore rationale
  - Align changelog: "recommended" instead of "must"
  - Use 7-bit ASCII throughout
  - Rebase onto current origin/main
v2:
  - Split zl3073x ref_sync_set fix into a separate preparation patch
  - Update dpll.rst documentation to match the new behavior
  - Expand commit message to describe the -EOPNOTSUPP check change

Ivan Vecera (2):
  dpll: zl3073x: update all DPLL channels on ref_sync_set
  dpll: use pin owner's dpll ref for pin-level attribute setting

 Documentation/driver-api/dpll.rst |  11 +-
 drivers/dpll/dpll_netlink.c       | 213 +++++++-----------------------
 drivers/dpll/zl3073x/dpll.c       |  58 ++++++--
 3 files changed, 104 insertions(+), 178 deletions(-)


base-commit: 4fa4977a0d900f936bcae5cd2c510be5554e8dd6
-- 
2.54.0

