Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B1F41B356
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 12:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782824153; cv=none; b=immnsO94SNdm1hGHiUWqLCs9p+4MVAiqRhmFS1CAB78gx7m0WYaM6WFTHL9Gepz7m0EhjuPSneF9FnFdsnTqspX2CW5KD2GJC0ul6BgoN8uLqrQxvqpzDmCRXKPQC5k1vPmf9InqLxXQ6FAtwdiLxRoIwVhLTE0/DZ+0puPyvBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782824153; c=relaxed/simple;
	bh=Q4MhErYfjaaIW5V/rgZEKqI4g5c+XId6wlyZPOvRywk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nqD7NkpSu0e4Ewm0hPBryL51dQzRkMz0GXVQxw7cEZJlX8kRfR/hUuncq7pE0rJn5LjHz0cIYLjZYQOHmJM6OgMUUgGUQc3VM+iIiSX8xhbNLG3YpQdQUwlxUnYyfOC2NtWI1OJxvi0RfgNlXu83TmwOh6SMCvAHpGxlO0U+L6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LNDO7wy1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LNDO7wy1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782824151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PgH1mUIeYALTFNvAFhcwg/JsaLWLxQZD6EFfc+CAtWI=;
	b=LNDO7wy1zZq3J6EwonwvMJMa9yWfdfpvQTpzXZB5zVKbgNPej/NLh80N353gX2lHJeDyEO
	sMf6GTMurGgs9IxumO5MyW8na5l5cwqsYtAB9sxy3s+UMEvy0xN4Yyp/MJr+WzMpv1QYPJ
	3Kud3YkesLeMX9nCKuaFjIcIXxEAe0Q=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-xGCPZmakNC2_6WuibAxP2w-1; Tue,
 30 Jun 2026 08:55:47 -0400
X-MC-Unique: xGCPZmakNC2_6WuibAxP2w-1
X-Mimecast-MFC-AGG-ID: xGCPZmakNC2_6WuibAxP2w_1782824146
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D524A1955D7A;
	Tue, 30 Jun 2026 12:55:45 +0000 (UTC)
Received: from p16v.bos2.lab (unknown [10.43.2.199])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DA7C818005AD;
	Tue, 30 Jun 2026 12:55:41 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Michal Schmidt <mschmidt@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Pasi Vaananen <pvaanane@redhat.com>,
	Petr Oros <poros@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Simon Horman <horms@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v6 1/5] dpll: add STATE_CONNECTED_OVERRIDE pin capability
Date: Tue, 30 Jun 2026 14:55:32 +0200
Message-ID: <20260630125536.720717-2-ivecera@redhat.com>
In-Reply-To: <20260630125536.720717-1-ivecera@redhat.com>
References: <20260630125536.720717-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Add DPLL_PIN_CAPABILITIES_STATE_CONNECTED_OVERRIDE capability flag
that indicates a pin can be set to connected regardless of the
current DPLL device mode, overriding the active input selection.
This is useful for automatic-only DPLL devices where mode cannot
be switched to manual, allowing userspace to directly connect
such pin from automatic mode.

The capability requires STATE_CAN_CHANGE to be set as well;
dpll_pin_register() warns if a driver violates this.

Document the new capability in the Pin selection section of
Documentation/driver-api/dpll.rst.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 Documentation/driver-api/dpll.rst     | 7 +++++++
 Documentation/netlink/specs/dpll.yaml | 6 ++++++
 drivers/dpll/dpll_core.c              | 6 +++++-
 include/uapi/linux/dpll.h             | 4 ++++
 4 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/driver-api/dpll.rst b/Documentation/driver-api/dpll.rst
index bae14766d4f7b..f83150917814e 100644
--- a/Documentation/driver-api/dpll.rst
+++ b/Documentation/driver-api/dpll.rst
@@ -91,6 +91,13 @@ following pin states:
 - ``DPLL_PIN_STATE_DISCONNECTED`` - the pin shall be not considered as
   a valid input for automatic selection algorithm
 
+Pins that have the ``DPLL_PIN_CAPABILITIES_STATE_CONNECTED_OVERRIDE``
+capability can additionally be set to ``DPLL_PIN_STATE_CONNECTED`` in
+automatic mode, overriding the active input selection. This is useful
+for automatic-only DPLL devices where mode cannot be switched to manual.
+When such a pin is disconnected, the device returns to automatic input
+selection.
+
 The actual hardware status of a pin is reported via the operational
 state (``DPLL_A_PIN_OPERSTATE``) attribute nested under the parent
 device:
diff --git a/Documentation/netlink/specs/dpll.yaml b/Documentation/netlink/specs/dpll.yaml
index 2bf83f6732ab0..526a5b2df2bd2 100644
--- a/Documentation/netlink/specs/dpll.yaml
+++ b/Documentation/netlink/specs/dpll.yaml
@@ -252,6 +252,12 @@ definitions:
       -
         name: state-can-change
         doc: pin state can be changed
+      -
+        name: state-connected-override
+        doc: |
+          pin state can be set to connected regardless of current
+          DPLL device mode, overriding the active input selection.
+          Requires state-can-change to be set as well.
   -
     type: const
     name: phase-offset-divider
diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index 2e8690cb3c16e..bb1e8650c9d59 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -884,7 +884,11 @@ dpll_pin_register(struct dpll_device *dpll, struct dpll_pin *pin,
 	    WARN_ON(ops->measured_freq_get &&
 		    (!dpll_device_ops(dpll)->freq_monitor_get ||
 		     !dpll_device_ops(dpll)->freq_monitor_set)) ||
-	    WARN_ON(ops->supported_ffo && !ops->ffo_get))
+	    WARN_ON(ops->supported_ffo && !ops->ffo_get) ||
+	    WARN_ON((pin->prop.capabilities &
+		     DPLL_PIN_CAPABILITIES_STATE_CONNECTED_OVERRIDE) &&
+		    !(pin->prop.capabilities &
+		      DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE)))
 		return -EINVAL;
 
 	mutex_lock(&dpll_lock);
diff --git a/include/uapi/linux/dpll.h b/include/uapi/linux/dpll.h
index 55eaa82f5f986..5d7ca6a413cdd 100644
--- a/include/uapi/linux/dpll.h
+++ b/include/uapi/linux/dpll.h
@@ -208,11 +208,15 @@ enum dpll_pin_operstate {
  * @DPLL_PIN_CAPABILITIES_DIRECTION_CAN_CHANGE: pin direction can be changed
  * @DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE: pin priority can be changed
  * @DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE: pin state can be changed
+ * @DPLL_PIN_CAPABILITIES_STATE_CONNECTED_OVERRIDE: pin state can be set to
+ *   connected regardless of current DPLL device mode, overriding the active
+ *   input selection. Requires state-can-change to be set as well.
  */
 enum dpll_pin_capabilities {
 	DPLL_PIN_CAPABILITIES_DIRECTION_CAN_CHANGE = 1,
 	DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE = 2,
 	DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE = 4,
+	DPLL_PIN_CAPABILITIES_STATE_CONNECTED_OVERRIDE = 8,
 };
 
 #define DPLL_PHASE_OFFSET_DIVIDER		1000
-- 
2.53.0

