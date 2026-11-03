Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793698812;
	b=OhkhhTF3T0ap9obNAzcXF2NK3EP5hNQRzZNAfuDzcy7wwYKvIX7+T/QfxzTxNQzWBJC2
	 f788xfoPbvodJZ9gL869bxv9zL65APW3LQt7u9biT9eTpDWPaFvVhzv4V0RdUTKDG43vv
	 dSTxR85vmxmm/nSkLPKe2NCc8rqdxyiwOzc3AbdMFNmYc6kLfwk9LWlkKsi4z4RGHm2kR
	 90H61ETQotlC/B28Lm7TEZHlrFa27sNc0AwpFRbbu1IkvKfhzc+vsVeqxcbxPOiqDHhsL
	 CmESCogWeqb+XEQUEtHoTJQ7Ju7PwKbpsLp0WQXdwu4DEOBPr4qUOJrRRa3KrghfhhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793698812;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=h+L9ibdOMNJx+pkmvkFkeAKNcyRvaFz5Po7XP8W8d2Y=;
	b=eNAKVWyXumY8G5viCb/u49uoccAwvfNmvcw/5u04swbV5oQeU4/zC3aQGarFlkt+84ek
	 rU39b0bnI+OYJcUTSiLLtak93yA8h+I7XaXLFqTnmTL6UOBKH1LKCFq+m6GT7QVLjWLY3
	 DwkB2k1qunJutV24HGm0Iyl5lDAD7Pq8y6wZrdh6h/1bY05fvy8kXjgIvDOtMrliYVZWc
	 eNI2uDCRpGpU3ZKC3ieeFg7ZKk+rvOwG16YcuIk9r8R7dp0fS1Skm5agPrGL8x47UQZzp
	 hSoAl8LMql3WtDLQk1a4QNNyysvVvZpZT+2hDbLGSxQBa9hyRiQVCZYSyfEuyF0hhfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Qri1PTgX;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F05606D838
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 09:40:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4F05606D838
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Qri1PTgX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793698810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h+L9ibdOMNJx+pkmvkFkeAKNcyRvaFz5Po7XP8W8d2Y=;
	b=Qri1PTgXb50Y+u8Ow8N3Z5jtFlPFPpCfxhRlDuCdR2MyCxJRmGY4TZU8/lZwLlFQ0amsmB
	BFqvEsHPsHhUZv+T/RBq//29nniFby9vnkzKSp50Y5Cpn2bW8MGIDNOrnTPeHmjsnhIvPg
	HVcOvl2i+5PYErvAETpBhpwlhtzH7xk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-376-Zf356r4YPVW4S3RjpjIrtA-1; Tue,
 03 Nov 2026 04:40:07 -0500
X-MC-Unique: Zf356r4YPVW4S3RjpjIrtA-1
X-Mimecast-MFC-AGG-ID: Zf356r4YPVW4S3RjpjIrtA_1793698805
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B50021955F15;
	Tue,  3 Nov 2026 09:40:05 +0000 (UTC)
Received: from poros-thinkpadp16vgen1.tpbc.com (unknown [10.44.32.42])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ED8597E2;
	Tue,  3 Nov 2026 09:40:01 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Ivan Vecera <ivecera@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next 07/14] dpll: dpllsim: Add support to get/set priority on input pins
Date: Tue,  3 Nov 2026 10:39:03 +0100
Message-ID: <20261103093910.596225-8-poros@redhat.com>
In-Reply-To: <20261103093910.596225-1-poros@redhat.com>
References: <20261103093910.596225-1-poros@redhat.com>
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

Add support for getting and setting the priority of input pins.
Implement the prio_get and prio_set callbacks and advertise the
priority-can-change capability for input pins, which includes the MUX
type pins since those are always inputs.

The initial priority of a pin is configured through a new prio
attribute of the pin directory, which takes a value between 0 and 255
and defaults to 128, so that a test can lay out the reference order
before the device goes live. Like the other pin attributes it is
writable only while the device is not live. Priority changes made over
netlink are stored and reported back, they will drive the automatic
reference selection once the simulation loop exists. The setter
rejects a value above 255 with EINVAL and an extack message. A priority
is meaningful for input pins only, so live fails with EINVAL when an
output pin was given a priority other than the default, next to the
frequency validation.

Signed-off-by: Petr Oros <poros@redhat.com>
---
 Documentation/driver-api/dpllsim.rst |  5 ++++
 drivers/dpll/dpllsim/core.c          | 31 +++++++++++++++++++
 drivers/dpll/dpllsim/dpll.c          | 45 ++++++++++++++++++++++++++--
 drivers/dpll/dpllsim/dpllsim.h       | 10 ++++++-
 4 files changed, 88 insertions(+), 3 deletions(-)

diff --git a/Documentation/driver-api/dpllsim.rst b/Documentation/driver-api/dpllsim.rst
index e7c5ee93392c21..5109d67325f140 100644
--- a/Documentation/driver-api/dpllsim.rst
+++ b/Documentation/driver-api/dpllsim.rst
@@ -36,6 +36,9 @@ Pin directory ``/sys/kernel/config/dpllsim/<dev>/pins/<pin>/``:
                (default 0, which is rejected)
 ``direction``  ``input`` or ``output`` (default ``input``), a ``mux`` pin
                must be an input
+``prio``       Priority 0-255 used for automatic reference selection,
+               input pins only, output pins must keep the default
+               (default 128)
 =============  ===============================================================
 
 The pin directory name becomes the board label of the pin. Pins are
@@ -53,8 +56,10 @@ output, then make it live::
     mkdir pins/gnss0
     echo gnss > pins/gnss0/type
     echo 1 > pins/gnss0/frequency
+    echo 0 > pins/gnss0/prio
     mkdir pins/ext0
     echo 10000000 > pins/ext0/frequency
+    echo 1 > pins/ext0/prio
     mkdir pins/out0
     echo 10000000 > pins/out0/frequency
     echo output > pins/out0/direction
diff --git a/drivers/dpll/dpllsim/core.c b/drivers/dpll/dpllsim/core.c
index 97b3cf48772e7f..ee728a7f0c21bc 100644
--- a/drivers/dpll/dpllsim/core.c
+++ b/drivers/dpll/dpllsim/core.c
@@ -132,10 +132,40 @@ static ssize_t dpllsim_pin_frequency_store(struct config_item *item,
 }
 CONFIGFS_ATTR(dpllsim_pin_, frequency);
 
+static ssize_t dpllsim_pin_prio_show(struct config_item *item, char *page)
+{
+	struct dpllsim_pin *pin = to_dpllsim_pin(item);
+
+	guard(mutex)(&pin->dev->lock);
+	return sysfs_emit(page, "%u\n", pin->prio);
+}
+
+static ssize_t dpllsim_pin_prio_store(struct config_item *item,
+				      const char *page, size_t count)
+{
+	struct dpllsim_pin *pin = to_dpllsim_pin(item);
+	u32 val;
+	int err;
+
+	err = kstrtou32(page, 10, &val);
+	if (err)
+		return err;
+	if (val > DPLLSIM_PIN_PRIO_MAX)
+		return -EINVAL;
+
+	guard(mutex)(&pin->dev->lock);
+	if (dpllsim_dev_frozen(pin->dev))
+		return -EBUSY;
+	pin->prio = val;
+	return count;
+}
+CONFIGFS_ATTR(dpllsim_pin_, prio);
+
 static struct configfs_attribute *dpllsim_pin_attrs[] = {
 	&dpllsim_pin_attr_type,
 	&dpllsim_pin_attr_direction,
 	&dpllsim_pin_attr_frequency,
+	&dpllsim_pin_attr_prio,
 	NULL,
 };
 
@@ -178,6 +208,7 @@ static struct config_item *dpllsim_pins_make_item(struct config_group *group,
 	pin->dev = sim;
 	pin->type = DPLL_PIN_TYPE_EXT;
 	pin->direction = DPLL_PIN_DIRECTION_INPUT;
+	pin->prio = DPLLSIM_DEFAULT_PIN_PRIO;
 	list_add_tail(&pin->list, &sim->pin_list);
 
 	return &pin->item;
diff --git a/drivers/dpll/dpllsim/dpll.c b/drivers/dpll/dpllsim/dpll.c
index 2b0c053a7b6087..8a302c2537c880 100644
--- a/drivers/dpll/dpllsim/dpll.c
+++ b/drivers/dpll/dpllsim/dpll.c
@@ -116,11 +116,43 @@ static int dpllsim_pin_state_set(const struct dpll_pin *pin, void *pin_priv,
 	return 0;
 }
 
+static int dpllsim_pin_prio_get(const struct dpll_pin *pin, void *pin_priv,
+				const struct dpll_device *dpll,
+				void *dpll_priv, u32 *prio,
+				struct netlink_ext_ack *extack)
+{
+	struct dpllsim_pin *sim_pin = pin_priv;
+
+	guard(mutex)(&sim_pin->dev->lock);
+	*prio = sim_pin->prio;
+	return 0;
+}
+
+static int dpllsim_pin_prio_set(const struct dpll_pin *pin, void *pin_priv,
+				const struct dpll_device *dpll,
+				void *dpll_priv, u32 prio,
+				struct netlink_ext_ack *extack)
+{
+	struct dpllsim_pin *sim_pin = pin_priv;
+
+	if (prio > DPLLSIM_PIN_PRIO_MAX) {
+		NL_SET_ERR_MSG_FMT(extack, "Pin priority must be in range 0-%u",
+				   DPLLSIM_PIN_PRIO_MAX);
+		return -EINVAL;
+	}
+
+	guard(mutex)(&sim_pin->dev->lock);
+	sim_pin->prio = prio;
+	return 0;
+}
+
 static const struct dpll_pin_ops dpllsim_input_pin_ops = {
 	.frequency_get = dpllsim_pin_frequency_get,
 	.direction_get = dpllsim_pin_direction_get,
 	.state_on_dpll_get = dpllsim_pin_state_get,
 	.state_on_dpll_set = dpllsim_pin_state_set,
+	.prio_get = dpllsim_pin_prio_get,
+	.prio_set = dpllsim_pin_prio_set,
 };
 
 static const struct dpll_pin_ops dpllsim_output_pin_ops = {
@@ -165,7 +197,8 @@ static void dpllsim_pin_props(struct dpllsim_pin *pin,
 
 	/* Capabilities follow the ops the pin is served by */
 	if (dpllsim_pin_select_ops(pin) == &dpllsim_input_pin_ops)
-		prop->capabilities = DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE;
+		prop->capabilities = DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE |
+				     DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE;
 	else
 		prop->capabilities = 0;
 }
@@ -191,6 +224,13 @@ static bool dpllsim_pin_direction_valid(const struct dpllsim_pin *pin)
 	       pin->direction == DPLL_PIN_DIRECTION_INPUT;
 }
 
+/* Priority is meaningful for input pins only */
+static bool dpllsim_pin_prio_valid(const struct dpllsim_pin *pin)
+{
+	return pin->direction == DPLL_PIN_DIRECTION_INPUT ||
+	       pin->prio == DPLLSIM_DEFAULT_PIN_PRIO;
+}
+
 static void dpllsim_pin_reset(struct dpllsim_pin *pin)
 {
 	pin->ops = dpllsim_pin_select_ops(pin);
@@ -205,7 +245,8 @@ static int dpllsim_order_pins(struct dpllsim_dev *sim)
 
 	list_for_each_entry(pin, &sim->pin_list, list) {
 		if (!dpllsim_pin_frequency_valid(pin) ||
-		    !dpllsim_pin_direction_valid(pin))
+		    !dpllsim_pin_direction_valid(pin) ||
+		    !dpllsim_pin_prio_valid(pin))
 			return -EINVAL;
 		count++;
 	}
diff --git a/drivers/dpll/dpllsim/dpllsim.h b/drivers/dpll/dpllsim/dpllsim.h
index 73b846b66f79c7..f9fced337dc881 100644
--- a/drivers/dpll/dpllsim/dpllsim.h
+++ b/drivers/dpll/dpllsim/dpllsim.h
@@ -12,6 +12,9 @@
 #include <linux/list.h>
 #include <linux/mutex.h>
 
+#define DPLLSIM_DEFAULT_PIN_PRIO		128
+#define DPLLSIM_PIN_PRIO_MAX			255
+
 #define DPLLSIM_MAX_PINS			128
 
 struct dpllsim_dev;
@@ -21,10 +24,15 @@ struct dpllsim_pin {
 	struct list_head list;
 	struct dpllsim_dev *dev;
 
-	/* Configuration, writable only until dpllsim_dev_frozen() */
+	/*
+	 * Configuration, set through configfs only until
+	 * dpllsim_dev_frozen(). The netlink prio setter changes prio at
+	 * runtime under dev->lock.
+	 */
 	enum dpll_pin_type type;
 	enum dpll_pin_direction direction;
 	u64 frequency;
+	u32 prio;
 
 	/* Resolved at live=1 */
 	int idx;
-- 
2.56.0

