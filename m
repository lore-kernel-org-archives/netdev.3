Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CC63BF684
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 18:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790621769; cv=none; b=VRmxYfCJ4qcn/gNCtQLdzcp5FDhDvZ/q+fzXHwpPNh+1O6kBLRccqsCxIKCUWXqsGsUnDuZY79ttVcoeadeCGzVJFSwAD3y65F9cLC3WKwlBRhfslvMPh3WesepU89XbtLgurnJjJJNeEw9OoF74BBdINwV2gcnPn04YZMgzBm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790621769; c=relaxed/simple;
	bh=Q7a/2WOLISrPpjktBTSM4HNNcVgcYG3/kt7Vv5gaGm4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CHC4I4/qQaRI0CnFMr6/m77jrQRbaeQn3STtF9qMJK/Fx2luPPh0z3CaGzPlijRdx1eWbbAwTjtyysRWuf3oJDCvpVWH3X5SuzjusEMemhcJa0FFcEDcrcBqSio5QEYGsMVeOSaOzEJ9rUnPfzn+lEvQIpJ4PEa7e/wpBxSY1TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B0tsPH7U; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B0tsPH7U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790621762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RPHwv64bYOJLEhu3rlWzpgW8vJaHws32Y+2XFIh0sSw=;
	b=B0tsPH7UK4n36k6f1DMDZzH1uZcEswW4yYkg0TZibKN/nPmv3pc0GarMiqg+PjJ1BYxNNa
	NxSNelRBXfsv5qQqcMnhiXM/azuK7fmUb2tRrzxirqx5jWunnd1cVQq5EOavgcUf3BcQR/
	6KcC4Mq93RvTHO67pxjvV882EBfKWzY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-261-XUF3WCjDNTWcQRcwz7k5OA-1; Mon,
 28 Sep 2026 14:55:59 -0400
X-MC-Unique: XUF3WCjDNTWcQRcwz7k5OA-1
X-Mimecast-MFC-AGG-ID: XUF3WCjDNTWcQRcwz7k5OA_1790621757
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 10AA7184139D;
	Mon, 28 Sep 2026 18:55:57 +0000 (UTC)
Received: from p16v.luc.cera.cz (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B49AA1956041;
	Mon, 28 Sep 2026 18:55:53 +0000 (UTC)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/6] dpll: zl3073x: add PTP periodic output support
Date: Mon, 28 Sep 2026 20:55:46 +0200
Message-ID: <20260928185552.1103515-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

This series extends the zl3073x output pin support and finally adds PTP
periodic output (perout) support on top of it.

Each zl3073x output exposes a P-pin and an N-pin that share a single HW
output and most of its configuration registers. Patch 1 makes a change
requested on one pin notify the sibling pin as well, so userspace on the
sibling is told when its effective frequency, esync or phase adjustment
changed.

Patches 2 and 3 add the plumbing to control an individual output pin:
GPO override registers and a clean stop/restart of an output (patch 2),
and then per-pin enable/disable through the state_on_dpll_get/set
callbacks - differential pins via the output stop condition, CMOS pins
via the GPO override bracketed by a glitch-free stop/restart (patch 3).

Patches 4 and 5 are preparatory: the per-pin 'esync_control' boolean is
replaced by an extensible 'caps' bitmap, and the divisor/N-division
computation is factored out of frequency_set() into a helper that
updates a struct zl3073x_out without committing it.

Patch 6 registers a PTP periodic output pin for each output pin that
supports step-time and declares 1 PPS support in firmware. Any perout
channel can be assigned to any such pin; only 1 PPS is supported.
Enabling a channel programs its pin for 1 Hz and connects it, disabling
disconnects it, reusing the helper and connect/disconnect primitive
introduced earlier in the series.

Ivan Vecera (6):
  dpll: zl3073x: notify sibling pin when shared output config changes
  dpll: zl3073x: add GPO support for output pins
  dpll: zl3073x: allow enabling/disabling output pins
  dpll: zl3073x: consolidate pin capabilities into bitmap
  dpll: zl3073x: factor out output pin frequency helper
  dpll: zl3073x: add PTP periodic output support

 drivers/dpll/zl3073x/core.c | 117 ++++++++
 drivers/dpll/zl3073x/core.h |  30 ++
 drivers/dpll/zl3073x/dpll.c | 539 +++++++++++++++++++++++++++++++-----
 drivers/dpll/zl3073x/dpll.h |   4 +
 drivers/dpll/zl3073x/out.c  |  50 +++-
 drivers/dpll/zl3073x/out.h  | 138 ++++++++-
 drivers/dpll/zl3073x/prop.c |   2 +
 drivers/dpll/zl3073x/prop.h |  21 ++
 drivers/dpll/zl3073x/regs.h |  20 ++
 9 files changed, 834 insertions(+), 87 deletions(-)


base-commit: 014d795c73837ea2339a4ea8e8f82c6e959b845d
-- 
2.55.0

