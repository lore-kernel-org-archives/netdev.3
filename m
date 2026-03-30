Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244F9391848
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 10:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774868122; cv=none; b=C9mB4c4g6EBUOvT3BINkM8pdEHRclPgBs/PlNp4mW3xTn/9hGguaYCb0UWseEoYiLD4ucluAwjO8KEJYHdXBn3iyLFsQ8SO8d2Bh9KoycSJtcg94pgAUsXUo+FWhxdLZW93oBwKCErcZp5KdoiyA9g6QG6Jc7iFX0E/0VGD07I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774868122; c=relaxed/simple;
	bh=7kN4ilpjSi9336S5CQj/K+/jiOQNBm30qLzcIisLOzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BZTN0QRTLjgsheTXAafOfAEl0ONSah2nhzKWSAoMV1PsXQot0Zfz7zNvDclFsbm4siqklUjsrgpGtJe2POhjqsLsXsTQn3Ukmkrv8l8MYNExHSKu4OQUmfk4VsObv+0kAep6I6sSfzmbmHDl3F6g52E+WAEMX3iOT7IlRkD/5Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WX6Lv7Cd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WX6Lv7Cd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774868120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KYfPGZrErX1DdGRwup2PVT48zU16idFZG47YSus0fQg=;
	b=WX6Lv7CdS1Rn4+ukPVIcanNiiZjsbExZSi6sTHtonk/awin2iaO2XI/ZYCmzgl6VZnUZkv
	ApP3iTaSxzX7uniavr5tAF5GsLnEpXdpJ4ztjeP/aSwoiTBwO0jVvNLxlKtyhynBdODlyU
	bpo1ze/imWXZkfFzxKtUjqgkWDmBoYE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-674-6K1K1H1UNMK8urJB0zJP0A-1; Mon,
 30 Mar 2026 06:55:14 -0400
X-MC-Unique: 6K1K1H1UNMK8urJB0zJP0A-1
X-Mimecast-MFC-AGG-ID: 6K1K1H1UNMK8urJB0zJP0A_1774868113
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 608AA19560AA;
	Mon, 30 Mar 2026 10:55:12 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.33.70])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4989830001A1;
	Mon, 30 Mar 2026 10:55:07 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Petr Oros <poros@redhat.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/3] dpll: add frequency monitoring feature
Date: Mon, 30 Mar 2026 12:55:02 +0200
Message-ID: <20260330105505.715099-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

This series adds support for monitoring the measured input frequency
of DPLL input pins via the DPLL netlink interface.

Some DPLL devices can measure the actual frequency being received on
input pins. The approach mirrors the existing phase-offset-monitor
feature: a device-level attribute (DPLL_A_FREQUENCY_MONITOR) enables
or disables monitoring, and a per-pin attribute
(DPLL_A_PIN_MEASURED_FREQUENCY) exposes the measured frequency in Hz
when monitoring is enabled.

Patch 1 adds the new attributes to the DPLL netlink spec (dpll.yaml),
regenerates the auto-generated UAPI header and netlink policy, and
updates Documentation/driver-api/dpll.rst.

Patch 2 adds the callback operations (freq_monitor_get/set for
devices, measured_freq_get for pins) and the corresponding netlink
GET/SET handlers in the DPLL core. The core only invokes
measured_freq_get when the frequency monitor is enabled on the parent
device.

Patch 3 implements the feature in the ZL3073x driver by extracting
a common measurement latch helper from the existing FFO update path,
adding a frequency measurement function, and wiring up the new
callbacks.

Changes v1 -> v2:
- Renamed actual-frequency to measured-frequency (Vadim)

Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Ivan Vecera (3):
  dpll: add frequency monitoring to netlink spec
  dpll: add frequency monitoring callback ops
  dpll: zl3073x: implement frequency monitoring

 Documentation/driver-api/dpll.rst     | 18 ++++++
 Documentation/netlink/specs/dpll.yaml | 17 +++++
 drivers/dpll/dpll_netlink.c           | 90 +++++++++++++++++++++++++++
 drivers/dpll/dpll_nl.c                |  5 +-
 drivers/dpll/zl3073x/core.c           | 88 ++++++++++++++++++++++----
 drivers/dpll/zl3073x/dpll.c           | 88 +++++++++++++++++++++++++-
 drivers/dpll/zl3073x/dpll.h           |  2 +
 drivers/dpll/zl3073x/ref.h            | 14 +++++
 include/linux/dpll.h                  | 10 +++
 include/uapi/linux/dpll.h             |  2 +
 10 files changed, 318 insertions(+), 16 deletions(-)

-- 
2.52.0

