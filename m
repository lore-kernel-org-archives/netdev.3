Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1E63368B2
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 12:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785758577; cv=none; b=PQ1opb5Y5tW0fLFJe1ea5gLYsJK4qayPlFbKR2yQCJ2zYThYWY9LU1ihisjluBGypwlT0vEBBZlmmHTpf8eL/MKKpiapOXWN/R6Meun+edx5u3kgU0RjPLATlQtZp4vb+YZr1gfrthi8hFqu8aOKbmg4RDmdxHG9aqgrnsuBh3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785758577; c=relaxed/simple;
	bh=y/KHBEoLZ7Z5Pbrb3AkUkUiGgdxRRVZKCX5PraFPT44=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OjK2yITIuplB6gGaQjYC+cJ2kH47LIXbNvybX5X0NN/IuYoDHJ/3ak2DmEWUIeQTm3CRRwe4YK+XqPsov8ZEzcxHTBLyWnNNuvbctwmeg0V9Hse71pcsBkMbtFg1fvzCAAydin8Qv/W4LSwBxTFYio+5cfAikB/wKfPY5hYqbgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BDjTiw11; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BDjTiw11"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785758575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hAIlAET9Pe/rO9zc5zB+hdrx3XmBErEfm3n+MiQ1T88=;
	b=BDjTiw118ZotTes5HkW5FSs1rj4LwMuElFxCX1i2qbIiiNbl5SO04Pujm9tlCROjkf1g3r
	uEhBn5CUcMLg1A16KPahyYOOysnmgEK6JgVqwIqhnNlCuPf4vawYxJO6qO363uSzDXab1M
	aUp/Y8XfeSvbghgq4B/F5AS/b4Fk8IA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-117-sssIOecNOiuskB6TR9JIMQ-1; Mon,
 03 Aug 2026 08:02:53 -0400
X-MC-Unique: sssIOecNOiuskB6TR9JIMQ-1
X-Mimecast-MFC-AGG-ID: sssIOecNOiuskB6TR9JIMQ_1785758571
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BB6AE1954B09;
	Mon,  3 Aug 2026 12:02:50 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.33.235])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3367241C;
	Mon,  3 Aug 2026 12:02:46 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Paolo Abeni <pabeni@redhat.com>,
	Petr Oros <poros@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/2] dpll: use pin owner's dpll ref for pin-level set callbacks
Date: Mon,  3 Aug 2026 14:02:43 +0200
Message-ID: <20260803120245.56046-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

Pin-level attributes (frequency, phase adjust, embedded sync, reference
sync) are properties of the pin itself. The get callbacks already use
only the pin owner's DPLL reference, but the set callbacks iterate over
all registered DPLL devices — resulting in redundant HW writes for
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

v2:
  - Split zl3073x ref_sync_set fix into a separate preparation patch
  - Update dpll.rst documentation to match the new behavior
  - Expand commit message to describe the -EOPNOTSUPP check change

Ivan Vecera (2):
  dpll: zl3073x: update all DPLL channels on ref_sync_set
  dpll: use pin owner's dpll ref for pin-level attribute setting

 Documentation/driver-api/dpll.rst |  10 +-
 drivers/dpll/dpll_netlink.c       | 213 +++++++-----------------------
 drivers/dpll/zl3073x/dpll.c       |  46 +++++--
 3 files changed, 89 insertions(+), 180 deletions(-)


base-commit: 69963a0678a347d57c4ac8b16939dba216eb95ce
-- 
2.54.0

