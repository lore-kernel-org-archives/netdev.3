Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDEC3E95AE
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 17:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773942525; cv=none; b=dHgl9I0QkJKjMUPIyzqn7fAYHhX93IflwjtHID9sX9kIObpl/fFj4/HtSqCwnOrWbCH8XAb4+4/WjUitIoz+38NxhDl3pUg2KEIxTWvFYFveDi2XMTt0TBe54GdN9ZtHvRRRV0xDtK8mA1vxts6ynSNRykHh7G1AUyAhJRVVCcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773942525; c=relaxed/simple;
	bh=Le5FPuV4lJ01BoEVLkgjiw8SLtJjr2q3Lgxw4c/SqkM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OkRUF1aD6BTn5SUoXYJhrFNw9xMkULv/wVv0Yax2iM2WTtYNTliP1rVhFxSwphD+E3+IvW/myyyvbDi0b/NGWpgAElqSoZ6yswJKD56Ek/B6Yumv0/8jwbL9XBvaeHSPwpE+luuxLC3YEGmyxawk3+r+rJkOvpmpmOLU+Wf2iWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tt5CitEl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tt5CitEl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773942517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=L6y/GMVYqx4vKA4/izsZJoWa5lmc2GZOwuVVsxL038Y=;
	b=Tt5CitElNTHyjNlEg2ikFw4piDh+zUrJ1iz74loc1MdfaZF7pwiAM/cys6dwNqxprBrc6h
	Hbrcc9E17F/86WN1fYZA2sRPCd921dbDQnKlx6a5HLIjh6d19KbsxlNCsMscdUIV6S36wn
	hNy93t7j7Rmb8lWsCJhWK1d+Oq7UTUY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-529-klSQNIZBOpWGFo_fwGp6Mw-1; Thu,
 19 Mar 2026 13:48:34 -0400
X-MC-Unique: klSQNIZBOpWGFo_fwGp6Mw-1
X-Mimecast-MFC-AGG-ID: klSQNIZBOpWGFo_fwGp6Mw_1773942512
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 103BE1955DDB;
	Thu, 19 Mar 2026 17:48:32 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.32.41])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 167BB30001A1;
	Thu, 19 Mar 2026 17:48:27 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Michal Schmidt <mschmidt@redhat.com>,
	Petr Oros <poros@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Simon Horman <horms@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	Pasi Vaananen <pvaanane@redhat.com>
Subject: [PATCH net-next 0/5] dpll: zl3073x: add ref-sync pair support
Date: Thu, 19 Mar 2026 18:48:21 +0100
Message-ID: <20260319174826.7623-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

This series adds Reference-Sync pair support to the ZL3073x DPLL driver.
A Ref-Sync pair consists of a clock reference and a low-frequency sync
signal (e.g. 1 PPS) where the DPLL locks to the clock reference but
phase-aligns to the sync reference.

Patches 1-3 are preparatory cleanups and helper additions:
- Clean up esync get/set callbacks with early returns and use the
  zl3073x_out_is_ndiv() helper
- Convert open-coded clear-and-set bitfield patterns to FIELD_MODIFY()
- Add ref sync control and output clock type accessor helpers

Patch 4 adds the 'ref-sync-sources' phandle-array property to the
dpll-pin device tree binding schema and updates the ZL3073x binding
examples.

Patch 5 implements the driver support:
- ref_sync_get/set callbacks with frequency validation
- Automatic sync source exclusion from reference selection
- Device tree based ref-sync pair registration

Tested and verified on Microchip EDS2 (pcb8385) development board.

Ivan Vecera (5):
  dpll: zl3073x: clean up esync get/set and use zl3073x_out_is_ndiv()
  dpll: zl3073x: use FIELD_MODIFY() for clear-and-set patterns
  dpll: zl3073x: add ref sync and output clock type helpers
  dt-bindings: dpll: add ref-sync-sources property
  dpll: zl3073x: add ref-sync pair support

 .../devicetree/bindings/dpll/dpll-pin.yaml    |  11 +
 .../bindings/dpll/microchip,zl30731.yaml      |  30 +-
 drivers/dpll/zl3073x/chan.h                   |  17 +-
 drivers/dpll/zl3073x/core.c                   |   3 +-
 drivers/dpll/zl3073x/dpll.c                   | 295 ++++++++++++++----
 drivers/dpll/zl3073x/flash.c                  |   3 +-
 drivers/dpll/zl3073x/out.h                    |  22 ++
 drivers/dpll/zl3073x/ref.h                    |  46 +++
 drivers/dpll/zl3073x/regs.h                   |   2 +
 9 files changed, 348 insertions(+), 81 deletions(-)

-- 
2.52.0

