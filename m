Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415237;
	b=ArHP56keJLNtdUCDzxrCKqcpdF8tt1IibHanh+hPGEnSq4HqULZprxs8iBUAuDk9cvlB
	 HxUshFjBazgowrkEaUl3LxgALCE8/H/nvuaQ3KxFn9FVDfYpUbh4o4O5CUpDR3pEi6z0r
	 x21IugVp5+y2Ld/pTMtLBQCFmhyEizYtRC/jyDo1hP3kpNNjdqwNFs40htw1sX1r1HfqR
	 YhTjUqABBB+DkX+IFAXx/TzOtG4AuXOkZT3ukptDmGqAF+bwuj8d2STSce8/uLAMawK/W
	 SWf//CEpa7G8wJW1ZRSYSaW4oLNUslV4igymQUoBVquTqrTuMxSDT9pVSiF2/7VGkTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415237;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:MIME-Version:Content-Transfer-Encoding:X-Scanned-By;
	bh=NShsA9MlHZ9FwmFpGhwUtm1mborr1aSrRmco7ok7QSA=;
	b=BG1EVGv+VSp1zwh4QCasdcgpF4rd2xR9npKHZUYa3XbCw31Tod9CVqkiSIvaoxJjHYYU
	 2TMXL+3wx5BW/H0bYZpraEEnjog+S/Dm6dlWTLwZb5T9gs7EVsUxdEmqBRx3HnKafDq+h
	 iQdxwB6uYS2aqVBYxqHZH6WJ3xeJ3vos0wAIFMffVg3vGK1zTOTAzJpMCfWOd9GSe8Uap
	 M7RUrsbYmE3WbM0KF6HORz/jRkmgk/gfz1TFqH/rjEvzfhsV8ePADf/5Y4irT9+ixGicb
	 WBkR5lGkLSnOiXiZ7wzQvAacG7XwwX+h+ZheAs8Gov1keB0HhIL5WApBACOoXYxF12Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BC6117iP;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2783606A326
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 16:40:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2783606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BC6117iP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794415235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NShsA9MlHZ9FwmFpGhwUtm1mborr1aSrRmco7ok7QSA=;
	b=BC6117iPB7Nu3xK4KhSZ0dD/fN1ON7hujFOrh7hfSO8yPdsQUNqTUnJAbPoKq6740eE5Vt
	m138DFUfYkSPqVT47vnIp3foZm66tQRumBh/16is9uVuTR2tYNlH3DWJfKuP1jOM19TfXH
	TO+Nm3jBjUPazzJNj6AO8H6f9KKFBwI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-277-nIjXMsnDO9OwQ5BZKCeBBw-1; Wed,
 11 Nov 2026 11:40:32 -0500
X-MC-Unique: nIjXMsnDO9OwQ5BZKCeBBw-1
X-Mimecast-MFC-AGG-ID: nIjXMsnDO9OwQ5BZKCeBBw_1794415229
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A797C1955BC4;
	Wed, 11 Nov 2026 16:40:28 +0000 (UTC)
Received: from ivecera-thinkpadp16vgen1.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 40D41421;
	Wed, 11 Nov 2026 16:40:22 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Min Li <min.li@microchip.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	Grzegorz Nitka <grzegorz.nitka@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Petr Oros <poros@redhat.com>
Subject: [PATCH net-next v2 0/9] dpll: do not serialize driver callbacks under global dpll_lock
Date: Wed, 11 Nov 2026 17:40:11 +0100
Message-ID: <20261111164021.273409-1-ivecera@redhat.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

dpll_lock protects topology and object lifetime, but it also serializes
all driver callbacks in the system, so one slow device stalls every other
DPLL device, whichever driver it belongs to. mlx5 callbacks issue firmware
commands with a 60 s default timeout, and zl3073x callbacks can wait
seconds on a driver lock held across ToD writes and phase steps.

Make dpll_lock an rwsem for topology and lifetime and add a mutex per
domain for callbacks. A domain is all objects created with one (module,
clock_id), in practice one chip or card, so channels of one chip stay
serialized as drivers expect, and they still block each other. Device
callbacks run under the domain of the device, pin callbacks under the
domain of the pin, whichever driver registered them. Only one domain lock
is ever held, so domains have no lock order. A lock per device would not
work, because pins are N:M with devices and callbacks notify sibling
channels.

The driver API does not change, but a callback can now notify only
objects of its own domain. Patch 1 changes the one in-tree callback that
does not follow this.

Registrations across domains exist in the tree only on E825, where ice
registers fwnode pins of an external DPLL with its TXC and TSPLL DPLLs.
These callbacks are no longer serialized with TXC and TSPLL, they rely on
pf->dplls.lock, and requests about these pins wait while the external
DPLL is busy. Intel folks, please check that this is fine.

Each complex of a dual complex E825 has its own DSN and so its own
domain, but both use the CGU of complex 0. The lock for the registers
they share is in a fix sent to net [1], which this series needs. Without
it a test lost updates of them.

Patch 4 is the only patch that lets callbacks run concurrently. Patch 5
adds KUnit tests. I also tested each commit with a mock driver and YNL in
QEMU, with lockdep and KASAN, and the tip with lockdep on two systems:

- A board with ZL30732A: every notification the driver sends from a
  callback, concurrent traffic with PTP, driver reload and rebind.
- GNR-D with dual complex E825 and zl3073x: callbacks of the pins shared
  by both drivers, TX clock switches, RCLK pins of both complexes, a port
  going down and up, and both drivers unloaded and loaded in either order
  under load.

mlx5 is build tested only.

On GNR-D, with ToD writes running on the zl3073x and requests waiting for
them, requests to an ice DPLL took 1448 ms in median and 3.9 s at most
before this series, 0.2 ms and 0.3 ms with it, the same as when idle.
Requests about the pins shared by both drivers still wait for the zl3073x.

Changes in v2:
- Dropped "ice: dpll: serialize changes of the SyncE CGU registers", sent
  to net with a fix of the SyncE divider [1]
- Addressed the Sashiko review, see the patches for details
- Added Reviewed-by tags from Petr

v1: https://lore.kernel.org/netdev/20261106121005.1327603-1-ivecera@redhat.com/

[1] https://lore.kernel.org/netdev/20261110094350.184185-1-ivecera@redhat.com/

Ivan Vecera (9):
  ice: dpll: notify TSPLL lock status from the periodic work only
  dpll: add domain object
  dpll: take domain locks around driver callbacks
  dpll: convert dpll_lock to rwsem
  dpll: add KUnit tests for core locking
  dpll: reject measured_freq_get for foreign and on-pin registrations
  dpll: zl3073x: update locking comments
  ice: dpll: update locking comments
  dpll: document locking rules

 Documentation/driver-api/dpll.rst         |   48 +
 drivers/dpll/.kunitconfig                 |    5 +
 drivers/dpll/Kconfig                      |   13 +
 drivers/dpll/Makefile                     |    1 +
 drivers/dpll/dpll_core.c                  |  204 ++-
 drivers/dpll/dpll_core.h                  |   34 +-
 drivers/dpll/dpll_core_kunit.c            | 1580 +++++++++++++++++++++
 drivers/dpll/dpll_netlink.c               |  117 +-
 drivers/dpll/zl3073x/dpll.c               |    9 +-
 drivers/net/ethernet/intel/ice/ice_dpll.c |   24 +-
 drivers/net/ethernet/intel/ice/ice_dpll.h |    5 +
 11 files changed, 1919 insertions(+), 121 deletions(-)
 create mode 100644 drivers/dpll/.kunitconfig
 create mode 100644 drivers/dpll/dpll_core_kunit.c


base-commit: 368fbf5d82da9ebce309449c74fc0b128f7d0219
-- 
2.56.0

