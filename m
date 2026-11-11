Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415293;
	b=knQw60cGA0Hp4/enKcg3C2hc7mH16Nalk1waGI/Jqw6c6Amm2wyf/PEPAmoa58+DKQKq
	 lpaaTpY01IbzYW1Ez2uOdeHBZLxGpSIHqvA+WrHfbiRknaQv2eToeRpcI5f67y9s1ef/I
	 9aLucnrgOH7f8Xs1K4HEArnNxyv6PQ5YwK+mZUPCjQFlf6Zh3+zwUgLs84LhEibleaUn2
	 rw/nkCpzcK+5rc0MHo03xvxdTkgo7Sffr7zDjzLjcPK6A03r0Km9oitLNBfEswTeXefJl
	 t33A3zjs7wd3fmr8fOCB0U8CUh2ZEl/oMznT2GWN3xjxhmZp3lE6UHDVxWCHxBuSx6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415293;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=TC/qzi0GwbwJRPe4iytsw8ARC/xSRyQXvSanD2vms5g=;
	b=gFR9LMBMDuQfusgsEgd/uZrRxSxsG2w9RQw4sA3S605Nke3Ys1s3kXyd2paN6PZMG20E
	 ZnRprsWM9+/93IlBDdyD9BJ4fbmgzPWI0EotrOEYv7xjLyiZxjDOvAsJ5efk3cAfzbb+G
	 JGdAA1xaIFM/hqkbgDgxvl6V1UKi9vMYvrRq3jcKwIA52WAImR5sIXg+NOSoux35Q4IQC
	 KAV1wqh97LD8Y44EusJdfWQJ2n6Qt7GjPvFAmJQiYVd+REtycA5DbetiSFfdKltZ0vcG1
	 Va2j7Vf+iC8eVrpxNI4/by0SQUHYDWZzba5wdHUR4z3NMLFBm9epg98u0Of/C/7HZCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eFLt9ZFg;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8134E606A881
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 16:41:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8134E606A881
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eFLt9ZFg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794415291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TC/qzi0GwbwJRPe4iytsw8ARC/xSRyQXvSanD2vms5g=;
	b=eFLt9ZFgObMjUxZkbtptqLCSkcgHx3QPnVjP64wxp7LyxGv50eP8jrRYiRhtWbM8cKau7+
	YhXZke6sd1ucTrwg69ZqTTlk/vpl1+5ZV06K8ZcUY7ebcc0NH4ef5tv4QFHmkC/aL5WJMg
	TlxCzlGhEsnPNtq9hRtX/IB7ZeRRTKI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-QeALwB0-N6OvZSh1l3qmTg-1; Wed,
 11 Nov 2026 11:41:27 -0500
X-MC-Unique: QeALwB0-N6OvZSh1l3qmTg-1
X-Mimecast-MFC-AGG-ID: QeALwB0-N6OvZSh1l3qmTg_1794415284
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 337721955DE4;
	Wed, 11 Nov 2026 16:41:24 +0000 (UTC)
Received: from ivecera-thinkpadp16vgen1.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 47E5A410;
	Wed, 11 Nov 2026 16:41:18 +0000 (UTC)
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
Subject: [PATCH net-next v2 9/9] dpll: document locking rules
Date: Wed, 11 Nov 2026 17:40:20 +0100
Message-ID: <20261111164021.273409-10-ivecera@redhat.com>
In-Reply-To: <20261111164021.273409-1-ivecera@redhat.com>
References: <20261111164021.273409-1-ivecera@redhat.com>
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

Describe the lock levels of the subsystem, which domain a callback runs
under and the rules device drivers have to follow.

Reviewed-by: Petr Oros <poros@redhat.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
Changes in v2:
- Added a rule for reference sync pairs (Sashiko)
- Rules 1 and 3 also forbid waiting for a work item that notifies
  (Sashiko)
---
 Documentation/driver-api/dpll.rst | 48 +++++++++++++++++++++++++++++++
 drivers/dpll/dpll_core.c          | 13 +++++++++
 2 files changed, 61 insertions(+)

diff --git a/Documentation/driver-api/dpll.rst b/Documentation/driver-api/dpll.rst
index 7c117ae37cc1bc..9cc6a912c58913 100644
--- a/Documentation/driver-api/dpll.rst
+++ b/Documentation/driver-api/dpll.rst
@@ -675,6 +675,54 @@ In the error path we have to rewind every allocation in the reverse order:
 
 More complex example can be found in Intel's ICE driver or nVidia's mlx5 driver.
 
+Locking
+=======
+
+The subsystem uses two levels of locks, always taken in this order:
+
+- ``dpll_lock`` protects the topology of dpll devices and pins and their
+  lifetime. Functions changing the topology, for example dpll_pin_register(),
+  take it for write and send the create and delete notifications under it.
+  Netlink requests, each part of a dump and change notifications take it for
+  read for their whole duration.
+- A domain lock serializes driver callbacks. All dpll devices and pins created
+  with the same module and ``clock_id`` belong to one domain, in practice to
+  one chip or card.
+
+A netlink request addressing a device or a pin by its ID holds the domain lock
+of that object from start to end. A notification holds it while its message is
+built and sent, so messages of one object are sent in the order they were
+built. Only one domain lock is held at a time, so domains have no lock order,
+and callbacks of different domains can run concurrently.
+
+Callbacks of a dpll device run under the domain of the device. Callbacks of a
+pin run under the domain of the pin, whichever driver registered them:
+
+- A driver registering a pin of another driver with its dpll device has these
+  callbacks serialized with the driver that created the pin, not with the other
+  callbacks of its device, so it has to protect the state they share by itself.
+  A callback stuck in such a registration stops the domain of the pin.
+- The parent pin of a pin registered with dpll_pin_on_pin_register() and its
+  dpll devices can belong to another driver, so the callback must not
+  dereference their private data.
+- The frequency monitor belongs to the dpll device, so only callbacks of a pin
+  of the same domain registered with dpll_pin_register() can include
+  ``.measured_freq_get``.
+- The reference sync callbacks of a pin get the private data of the other pin
+  of the pair, so both pins of a pair added by dpll_pin_ref_sync_pair_add()
+  have to belong to one domain.
+
+Device drivers have to follow these rules:
+
+- A callback must not call dpll_device_change_ntf(), dpll_pin_change_ntf() or
+  any function changing the topology, nor wait for a work item that calls them.
+- A callback notifies about objects of the domain it runs under with
+  __dpll_device_change_ntf() or __dpll_pin_change_ntf(). Other objects have to
+  be notified from a context that holds no domain lock, for example a work item.
+- A driver must not call dpll_device_change_ntf(), dpll_pin_change_ntf() or any
+  function changing the topology, nor wait for a work item that calls them,
+  while holding a lock that its callbacks take.
+
 SyncE enablement
 ================
 For SyncE enablement it is required to allow control over dpll device
diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index a73abb0772cc6b..9a0843bba184af 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -932,6 +932,10 @@ __dpll_pin_register(struct dpll_device *dpll, struct dpll_pin *pin,
  * @ops: ops for a dpll pin ops
  * @priv: pointer to private information of owner
  *
+ * The callbacks run under the domain of @pin. If @pin belongs to another domain
+ * than @dpll, they are not serialized with the callbacks of @dpll and @ops must
+ * not include .measured_freq_get.
+ *
  * Context: Acquires dpll_lock and domain locks
  * Return:
  * * 0 on success
@@ -1049,6 +1053,11 @@ EXPORT_SYMBOL_GPL(dpll_pin_unregister);
  * Register a pin with a parent pin, create references between them and
  * between newly registered pin and dplls connected with a parent pin.
  *
+ * The callbacks run under the domain of @pin. The parent pin and its dplls can
+ * belong to another driver, so @ops must not dereference their private data.
+ * The frequency monitor belongs to a dpll, so @ops must not include
+ * .measured_freq_get.
+ *
  * Context: Acquires dpll_lock and domain locks
  * Return:
  * * 0 on success
@@ -1137,6 +1146,10 @@ EXPORT_SYMBOL_GPL(dpll_pin_on_pin_unregister);
  *
  * Once pins are paired, the user-space configuration of reference sync pair
  * is possible.
+ *
+ * The reference sync callbacks of each pin get the private data of the other
+ * one, so both pins must belong to one domain.
+ *
  * Context: Acquires dpll_lock and domain locks
  * Return:
  * * 0 on success
-- 
2.56.0

