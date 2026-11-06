Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793967086;
	b=kM67v+Ks+iavk/+ts9xjb+wTrG5VIzkrJNf1/D7U5POzGFglpYLPZgYozmUp9IsEpz9y
	 jovVFeipPnUN6167GplpeM3e75NqttKjIqTMDsOWyy8yoj1nDZhvgP9kGptOudxmqmju8
	 Muisn9NdM0LntJR58VhxCMNTwjo5duul+U0A54Ok1NS7l3ASkUet3M/VSakTQgXzIx/re
	 RAkzcSgFs+YYqDChD2NYBYtRdlKFJz5Jjp+WzL5aqbxRa9R2WRCxLXsGD+OApZEnTdPmt
	 EOx9mEecGj//OuPLpvxTUMQmL1bCqT+TutSMJfSbIjnLLrDY40vqV8gPphlIy22VPOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793967086;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=TVpanGIw2g4nYXoI3Lr8qP223FRJ1wL4lNRIegjpzew=;
	b=csgDpNiDW8asksNrrVhgFbfTnZmffTdjWb1anuTe2vkA4/42bDeQ0KT7P4T2GtF8HY8P
	 N7/wpvm+vb5qLfurZEmuOjtMFfwxymeXn5QIr2yZGaT8dCxxeiOYV0yljsiiB9RWF8vLD
	 D17AI6La/45pQ57T0LpY83ETcmfyOhiCMcOWVj6zCPOPCpOD8Dst8eFktVSKCuVa12nrG
	 EhKe4UeUlB6XkuPTG70r8PX6LHU3nc0Zg68SggW9XA9WtFH0/u9ydyej/NY0O27m24mVo
	 FRw1GqjnUn7R3ka7Ud47QAa52xtir3rjlsgnTQYz5Jj1Xr7ufYWwIrycaFVn60zWONQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aioG8H+G;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92075606A32E
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 12:11:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92075606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aioG8H+G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793967084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TVpanGIw2g4nYXoI3Lr8qP223FRJ1wL4lNRIegjpzew=;
	b=aioG8H+GUyuo/sGKecE48m5LgUNOcJbJfZVslEh8+UswnBgLd776Ir9ALoFw8qHQqdxHgK
	aZM25hsvXBPWlPTSLHrHS4eIQUHKxJJ0YCUEWa/oLUIAjoynL5hqyDwigxESlvf3zDxjm5
	/oWUEUzVdRAo/1+539otCYJawgGI0is=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-323-A79W0gvCPi2jGt0n8R7u1Q-1; Fri,
 06 Nov 2026 07:11:21 -0500
X-MC-Unique: A79W0gvCPi2jGt0n8R7u1Q-1
X-Mimecast-MFC-AGG-ID: A79W0gvCPi2jGt0n8R7u1Q_1793967078
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 37C4F18004BB;
	Fri,  6 Nov 2026 12:11:18 +0000 (UTC)
Received: from ivecera-thinkpadp16vgen1.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E264718004D2;
	Fri,  6 Nov 2026 12:11:11 +0000 (UTC)
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
Subject: [PATCH net-next 10/10] dpll: document locking rules
Date: Fri,  6 Nov 2026 13:10:05 +0100
Message-ID: <20261106121005.1327603-11-ivecera@redhat.com>
In-Reply-To: <20261106121005.1327603-1-ivecera@redhat.com>
References: <20261106121005.1327603-1-ivecera@redhat.com>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Describe the lock levels of the subsystem, which domain a callback runs
under and the rules device drivers have to follow.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 Documentation/driver-api/dpll.rst | 44 +++++++++++++++++++++++++++++++
 drivers/dpll/dpll_core.c          |  9 +++++++
 2 files changed, 53 insertions(+)

diff --git a/Documentation/driver-api/dpll.rst b/Documentation/driver-api/dpll.rst
index 7c117ae37cc1bc..40d5037ff3bb0f 100644
--- a/Documentation/driver-api/dpll.rst
+++ b/Documentation/driver-api/dpll.rst
@@ -675,6 +675,50 @@ In the error path we have to rewind every allocation in the reverse order:
 
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
+
+Device drivers have to follow these rules:
+
+- A callback must not call dpll_device_change_ntf(), dpll_pin_change_ntf() or
+  any function changing the topology.
+- A callback notifies about objects of the domain it runs under with
+  __dpll_device_change_ntf() or __dpll_pin_change_ntf(). Other objects have to
+  be notified from a context that holds no domain lock, for example a work item.
+- A driver must not call dpll_device_change_ntf(), dpll_pin_change_ntf() or any
+  function changing the topology while holding a lock that its callbacks take.
+
 SyncE enablement
 ================
 For SyncE enablement it is required to allow control over dpll device
diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index 84377f8ba16036..6ad40fb9eee855 100644
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
-- 
2.56.0

