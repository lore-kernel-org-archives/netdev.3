Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CFE24293C
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 17:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783530340; cv=none; b=bu9C0HuphUlxsPZKHeZRnGFGhry0wTMUCoRjczibu9tWrhhbNAz1z2fV+a01g02O94A1esErZlkIGzROo5QS0zMVYdqW2fXERxh1HcnNbdGuVO5IcJrTZ/+zZTqPy2R1n3BKJN1rgHWnZ9yx7ui/mqpUGOFKJ1IVlp9nzEd4gXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783530340; c=relaxed/simple;
	bh=AMRkLzyiB5i3JMQPLkZMZH5BinpullLCQ8jwbASnzE4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B55X+Seg2miy+tzBYzyH68mReFxkzs3URHHkE1Fmu+GJSYPMeHMQRnAIJiIJQExbcuxivMdOBnthZc6fe24EuGirP5qT0H6ud+BsznZ7wUPNr6g9jElSNisHpYn+kTG+XXdFPIL62XdWOoFgQf264vf5JvttlVe1D36ra7fkCV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c4auNSH1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c4auNSH1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783530337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=08zkJt+XFu3Cfo28xiFdMRI98lhX3XbfdcY7juf8PLQ=;
	b=c4auNSH1HxCQb6+VxiRV6bIEN5XWqtWTN2xebfmJgSYQzjIPd2qEB2JfdVqG/2iguV9b77
	tgOwga4XaLHk8h8J3yL/QDYVs3eQLxZ10xDQxUcNJYsnQhfF6cIiX04q1hiEwdba3dBOqU
	XiDW9SN5QnHLWeFnWLuV7sjlAGRSkxY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-696-ljC84MB1MgWx26Tohkqydw-1; Wed,
 08 Jul 2026 13:05:36 -0400
X-MC-Unique: ljC84MB1MgWx26Tohkqydw-1
X-Mimecast-MFC-AGG-ID: ljC84MB1MgWx26Tohkqydw_1783530334
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2FD6118001D1;
	Wed,  8 Jul 2026 17:05:34 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.50.138])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6CEEA195606C;
	Wed,  8 Jul 2026 17:05:29 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Michal Schmidt <mschmidt@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Pasi Vaananen <pvaanane@redhat.com>,
	Petr Oros <poros@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/4] dpll: zl3073x: add PTP clock support
Date: Wed,  8 Jul 2026 19:05:23 +0200
Message-ID: <20260708170527.916035-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Add PTP hardware clock support to the zl3073x DPLL driver.

Patch 1 adds channel ToD read/write, phase step and delta frequency
offset operations as low-level building blocks for PTP callbacks.

Patch 2 registers a PTP clock device for each DPLL channel with
gettimex64, settime64, adjtime, adjfine and perout callbacks.
The adjtime callback splits multi-second adjustments via ToD
read-modify-write and sub-second remainders via output phase step.

Patch 3 adds a channel TIE (Time Interval Error) write operation
for sub-picosecond resolution phase adjustment.

Patch 4 adds PTP adjphase and getmaxphase callbacks using TIE write
for phase adjustment in AUTO and REFLOCK modes, extends adjtime to
handle non-NCO modes via TIE write, and removes the NCO-only gate
from PTP clock registration.

Ivan Vecera (4):
  dpll: zl3073x: add channel ToD and phase step operations
  dpll: zl3073x: add PTP clock support
  dpll: zl3073x: add channel TIE write operation
  dpll: zl3073x: add PTP clock adjphase and TIE support

 drivers/dpll/zl3073x/Kconfig |   6 +-
 drivers/dpll/zl3073x/chan.c  | 307 +++++++++++++++++++
 drivers/dpll/zl3073x/chan.h  |  48 +++
 drivers/dpll/zl3073x/core.c  |   8 +
 drivers/dpll/zl3073x/core.h  |   8 +
 drivers/dpll/zl3073x/dpll.c  | 575 +++++++++++++++++++++++++++++++++--
 drivers/dpll/zl3073x/dpll.h  |   6 +
 drivers/dpll/zl3073x/regs.h  |  56 ++++
 8 files changed, 978 insertions(+), 36 deletions(-)


base-commit: 4a13f31a92f35161b499bf29638336885259da78
-- 
2.53.0

