Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2070040DFBE
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 14:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778684226; cv=none; b=aPPDgNUabkUzwrfwOGaXS4o8f6JF+kWBkMn8itQGtyPAgpIiCsbeJ1uZQO4zlEcojV9wF3vey0gu41CVAANU6/dGoKH6VYNtl8g/h8MNneqfrFrPeSWGIP/cSds88PI6mVTOUQutBAYOKggzWQFPzF5SgY/7pp9Z9edp9B8sWIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778684226; c=relaxed/simple;
	bh=WjkmBK4assTSqnUx8k2PfrhtvN8EVJqdkPymYJ9vx8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uCpffrZqxT0pmuxx4DavgUC67gEe/ZQ60p8R3Hc1oM/ehI0RiDtLgE/LPVAevIhpoGUJDDrc4OgzSEQhU0McT0eErIbkdI78UumpRVMDA83ar7tpPliYmT9nKCaP2b8riybobCqb3k5rUC5R2gqyZeBeTpltdCxCNB+vJF9eQfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mp4weQb5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mp4weQb5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778684223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jeu3U5fuD7zLve/CUe59/D1xkdYPoJVdvUuUlFX8zRE=;
	b=Mp4weQb59/zAMVBGCUg8axsRP/bhj1ELltDyXivTghyUH8fm8Nlhm0avxpcinl4A/h1oC9
	WIgZe94Eqx14nWzhv+Jbe5iYYcM3hGz2RZe5vUHRPlO1FsVeMGyHaiasv/ahQvTzJusDUy
	D7e0ZTWQ2nPUEWoilw2vqzQnRxOquA0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-70-uppo7RgYMFClc5GqLld2HQ-1; Wed,
 13 May 2026 10:56:59 -0400
X-MC-Unique: uppo7RgYMFClc5GqLld2HQ-1
X-Mimecast-MFC-AGG-ID: uppo7RgYMFClc5GqLld2HQ_1778684218
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C4B2E18005BE;
	Wed, 13 May 2026 14:56:57 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.33.20])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8D40B19560A3;
	Wed, 13 May 2026 14:56:52 +0000 (UTC)
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
Subject: [PATCH net-next 1/2] dpll: add DPLL_PIN_TYPE_INT_NCO pin type
Date: Wed, 13 May 2026 16:56:44 +0200
Message-ID: <20260513145645.175451-2-ivecera@redhat.com>
In-Reply-To: <20260513145645.175451-1-ivecera@redhat.com>
References: <20260513145645.175451-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Add DPLL_PIN_TYPE_INT_NCO pin type for device internal numerically
controlled oscillators. When connected as a DPLL input, the DPLL
operates in NCO mode where the output frequency is controlled by
the host.

Update the fractional-frequency-offset-ppt attribute documentation
to note that for INT_NCO pins this attribute represents the DPLL's
delta frequency offset.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 Documentation/netlink/specs/dpll.yaml | 12 ++++++++++++
 drivers/dpll/dpll_nl.c                |  2 +-
 include/uapi/linux/dpll.h             |  4 ++++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/dpll.yaml b/Documentation/netlink/specs/dpll.yaml
index 91a172617b3a9..159de8ad8b00b 100644
--- a/Documentation/netlink/specs/dpll.yaml
+++ b/Documentation/netlink/specs/dpll.yaml
@@ -162,6 +162,12 @@ definitions:
       -
         name: gnss
         doc: GNSS recovered clock
+      -
+        name: int-nco
+        doc: |
+          Device internal numerically controlled oscillator.
+          When connected as a DPLL input, the DPLL operates in NCO mode
+          where output frequency is controlled by the host.
     render-max: true
   -
     type: enum
@@ -453,6 +459,9 @@ attribute-sets:
           offset on the media associated with the pin. Inside
           the pin-parent-device nest it represents the frequency
           offset between the pin and its parent DPLL device.
+          For pins of type PIN_TYPE_INT_NCO this attribute represents
+          the DPLL's current delta frequency offset when the NCO pin
+          is connected.
           Value is in PPM (parts per million).
           This is a lower-precision version of
           fractional-frequency-offset-ppt.
@@ -499,6 +508,9 @@ attribute-sets:
           offset on the media associated with the pin. Inside
           the pin-parent-device nest it represents the frequency
           offset between the pin and its parent DPLL device.
+          For pins of type PIN_TYPE_INT_NCO this attribute represents
+          the DPLL's current delta frequency offset when the NCO pin
+          is connected.
           Value is in PPT (parts per trillion, 10^-12).
           This is a higher-precision version of
           fractional-frequency-offset.
diff --git a/drivers/dpll/dpll_nl.c b/drivers/dpll/dpll_nl.c
index b1d9182c7802f..2dab99202764f 100644
--- a/drivers/dpll/dpll_nl.c
+++ b/drivers/dpll/dpll_nl.c
@@ -61,7 +61,7 @@ static const struct nla_policy dpll_pin_id_get_nl_policy[DPLL_A_PIN_TYPE + 1] =
 	[DPLL_A_PIN_BOARD_LABEL] = { .type = NLA_NUL_STRING, },
 	[DPLL_A_PIN_PANEL_LABEL] = { .type = NLA_NUL_STRING, },
 	[DPLL_A_PIN_PACKAGE_LABEL] = { .type = NLA_NUL_STRING, },
-	[DPLL_A_PIN_TYPE] = NLA_POLICY_RANGE(NLA_U32, 1, 5),
+	[DPLL_A_PIN_TYPE] = NLA_POLICY_RANGE(NLA_U32, 1, 6),
 };
 
 /* DPLL_CMD_PIN_GET - do */
diff --git a/include/uapi/linux/dpll.h b/include/uapi/linux/dpll.h
index cb363cccf2e2a..dab7ffbde11b7 100644
--- a/include/uapi/linux/dpll.h
+++ b/include/uapi/linux/dpll.h
@@ -127,6 +127,9 @@ enum dpll_type {
  * @DPLL_PIN_TYPE_SYNCE_ETH_PORT: ethernet port PHY's recovered clock
  * @DPLL_PIN_TYPE_INT_OSCILLATOR: device internal oscillator
  * @DPLL_PIN_TYPE_GNSS: GNSS recovered clock
+ * @DPLL_PIN_TYPE_INT_NCO: Device internal numerically controlled oscillator.
+ *   When connected as a DPLL input, the DPLL operates in NCO mode where output
+ *   frequency is controlled by the host.
  */
 enum dpll_pin_type {
 	DPLL_PIN_TYPE_MUX = 1,
@@ -134,6 +137,7 @@ enum dpll_pin_type {
 	DPLL_PIN_TYPE_SYNCE_ETH_PORT,
 	DPLL_PIN_TYPE_INT_OSCILLATOR,
 	DPLL_PIN_TYPE_GNSS,
+	DPLL_PIN_TYPE_INT_NCO,
 
 	/* private: */
 	__DPLL_PIN_TYPE_MAX,
-- 
2.53.0

