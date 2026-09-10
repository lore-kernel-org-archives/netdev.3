Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6A3513576
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 18:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789064270; cv=none; b=SHbrnwUpOlPrElrLxpNGZgQ9HJK+BEALFd7VrQ1QjzuJel9jPVCwjRyaMNj5J8EFA9QvcjTlKsD/4WXierzM3nmQKotB+cTzS6mq0vk8HjGhLd+/4U7AKBttxL8WHX5dZFRhzz4IHzQg4XuxrsKvqi33nyonpB0f8Vkka4Ghjas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789064270; c=relaxed/simple;
	bh=PkLazTUBfgnHFJX/6j/z6D+G9f+NFxfIEs9XpadXfmM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bN4hxQDiPvGgrWcxHt6ANcBca+auZEpUYF8AITV1Yb6c/XzhjJJ2k6yH2hH4wZesaCyLz0j1qS631DXPNXeaHFjmlnQP6EnA3rHG23/yE5DrRUzaoF2YN9RU4tyXEIslptPf60jvlgLP9GOZkKzVea46CVHhwmsMSX9zKNKCUmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qJOZ3BS3; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qJOZ3BS3"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49b8ce9b733so1151675e9.1
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 11:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789064267; x=1789669067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IUTLqgsQRaPjkfGX1A5Z4hZOpq+shaE/5Jc/zgW3F80=;
        b=qJOZ3BS3KJJDJD5kOy/Ksp7zHq7utotgeahdmTp2zsywk8bqvHTV2zc4S5bbYnjzik
         GHj8g+zp5xSSGOjEYOrLjbiwTX9+Vx4oaM1CaXX1NS4WR5NKjAyUTmX1z5iY/NBq+oxi
         ChhNUEUZQeBUlAUu+Be788nOfZwLViHq37IJvAe0csbFL+DGEYWkiUY3HYVQFPyaCqGu
         uVTQb97VBViS6sPO5fuRIqRG2mlMIErNQCeNqYNICgq0yB0P/Jbq+cH5pC7eA3i8Uel5
         OEznWIPpDj0qahugyOjjPS1xSAOJNEIP6LyPcztVORus7AhHMBG8sXknov27binfYVsz
         LCbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789064267; x=1789669067;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IUTLqgsQRaPjkfGX1A5Z4hZOpq+shaE/5Jc/zgW3F80=;
        b=cbYFAAhFPgnNNko8h/kFuxI/9b3IwtX1LAlqcCPpBLBlwbAgI4wiuupycgv7zXGHja
         awrlPVrv1d/PkWg8iQsP5MFv+TG0uyCRZIWqjSVsVQ2azVGgYJrG1obK0d8kg64gwPM5
         lk8JzjNWiiRM8NvpEu3r4VlMqqbCsYvwZmFr9CXedorpAslue0odOQoBahJlBnDdUcPu
         TBj60HOhDuPKH61f88yoI3ojMHfgChJ0F9TW09mVgHsVtq2EkiJyf5Fx9eGR008F/OKO
         b/2WpIASdA+0GWt/e3WJHzumS6AXQtxfKyxPYOs8lONnEbE0cT6auoJsxUBUvquWoVFW
         px7Q==
X-Gm-Message-State: AFuF++kzzW8JYuca3NipD02v09OcIZs4PLOCf3QKu/MTMXMWCKov7gm5
	bHYEY9pEuKDS+HyNH/BV36/adMnk8x0HW2lbBx9yAhA0qlnAubxo7J55
X-Gm-Gg: AYBFou2v96MJ3UAhs7DRIdM2rpRJLcOmSDUSXI52zfLmDkuR0+Js+zchC9zxDtvQqum
	jCVpMdPaIkkdwXz72FfIb9gruInNxNTlhQfQlf8hUv5Ctjg78IFDUfHN6fe1plJzIsags8qsylQ
	Ce7UQW9mi7LvH6WGh0NdH5R888xQWQPf9Q8SBovu8MgLo5CYLpJX+dkYLCz37lqFd8UrdJGSrFM
	VeiORSLA3ITMfG0+G3U2DHrHsiffuQGEllYmenXHk2yHhfEgXCPeS6+mIp0pvjhD0F7xOaMfV/h
	nD6L3rrAMp/PkKcH9odlSyaKZFV8A3G2XHvzF6YEyUr32JK8qOSKYrtPHheOVa7w2RDg+Fb1u37
	qR1HeYFP8MHu8J3jMLM5B/bg6W3oScj002VwHtRJgoiO1knT9BZi4jklu4ZAtoIfrkwFB05ItRm
	kDsV+mvtCnlhMbm9dAwYDzaIIW9KAnLPnfeHcL75FojgVPivb7G2HcKOzFJEWV/u62Upyfx1zLj
	O4zFoiXubxtIBltdZPfOubGRDcF81fSFpEM9qJ3zjR91o4Al0848too3dYyHUxnd0p5z63smDuI
	dzBOoZVuwJk=
X-Received: by 2002:a05:600c:3acb:b0:49c:dcec:bd27 with SMTP id 5b1f17b1804b1-49e61987ecfmr3015785e9.8.1789064266810;
        Thu, 10 Sep 2026 11:17:46 -0700 (PDT)
Received: from localhost.localdomain ([41.90.145.1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb33fd3bsm221063f8f.19.2026.09.10.11.17.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 10 Sep 2026 11:17:45 -0700 (PDT)
From: Kenneth Kabogo <kennethkabogo2@gmail.com>
To: Alex Elder <elder@kernel.org>
Cc: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Kenneth Kabogo <kennethkabogo2@gmail.com>
Subject: [PATCH] net: ipa: validate QMI sender for modem-only server requests
Date: Thu, 10 Sep 2026 21:17:37 +0300
Message-ID: <20260910181737.55570-1-kennethkabogo2@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IPA driver's QMI server has two request handlers,
ipa_server_indication_register() and ipa_server_driver_init_complete(),
that are only ever legitimately sent by the paired modem. Neither checks
the sender address (struct sockaddr_qrtr *sq) against ipa_qmi->modem_sq,
which the driver already caches when the modem's QMI service appears in
ipa_client_new_server().

Both handlers set a readiness flag (indication_requested, uc_ready) and
call ipa_qmi_ready(), which starts the modem netdev via ipa_modem_start()
-> register_netdev() once both flags are set. A local process able to
send QMI messages on the qrtr socket, other than the modem, can spoof
both signals and drive ipa_qmi_ready() to completion before the modem
has confirmed its endpoint configuration, bringing up the modem network
interface out of sequence with real modem readiness. The realistic
outcome is a data-path stall requiring a subsystem restart to recover.
It is not a memory-safety issue.

On Android the qrtr socket is not reachable by untrusted apps (SELinux
neverallow on qipcrtr_socket), so this is gated to privileged system
components, hence the low severity. It is still a missing trust check on
a cross-processor control interface.

Reject server requests whose sender does not match the cached modem
address. modem_sq is populated before the modem sends these requests and
is zeroed in ipa_server_bye(); a zeroed modem_sq does not match any real
sender's address, so requests arriving during the teardown window are
rejected without a separate check.

Found by code inspection; no runtime proof-of-concept.

Signed-off-by: Kenneth Kabogo <kennethkabogo2@gmail.com>
---
Build-tested only (arm64 allmodconfig); I don't have IPA hardware to
test at runtime.

This assumes modem_sq is always populated (via ipa_client_new_server(),
the NEW_SERVER path) before the modem sends INDICATION_REGISTER /
DRIVER_INIT_COMPLETE. That ordering looks right from the code, but QMI
delivery is asynchronous - if the modem's request can legitimately
arrive before we've processed its NEW_SERVER event, this would wrongly
drop it, and the check should instead only be enforced when modem_sq is
non-zero. Happy to respin that way if you prefer.

 drivers/net/ipa/ipa_qmi.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/net/ipa/ipa_qmi.c b/drivers/net/ipa/ipa_qmi.c
index d771f3a71..a7cc98b27 100644
--- a/drivers/net/ipa/ipa_qmi.c
+++ b/drivers/net/ipa/ipa_qmi.c
@@ -168,6 +168,14 @@ static const struct qmi_ops ipa_server_ops = {
 	.bye		= ipa_server_bye,
 };
 
+/* True if a QMI request arrived from the modem we are paired with */
+static bool ipa_server_from_modem(const struct ipa_qmi *ipa_qmi,
+				  const struct sockaddr_qrtr *sq)
+{
+	return sq->sq_node == ipa_qmi->modem_sq.sq_node &&
+	       sq->sq_port == ipa_qmi->modem_sq.sq_port;
+}
+
 /* Callback function to handle an INDICATION_REGISTER request message from the
  * modem.  This informs the AP that the modem is now ready to receive the
  * INIT_COMPLETE indication message.
@@ -185,6 +193,13 @@ static void ipa_server_indication_register(struct qmi_handle *qmi,
 	ipa_qmi = container_of(qmi, struct ipa_qmi, server_handle);
 	ipa = container_of(ipa_qmi, struct ipa, qmi);
 
+	if (!ipa_server_from_modem(ipa_qmi, sq)) {
+		dev_warn_ratelimited(ipa->dev,
+				     "ignoring QMI request from non-modem sender %u:%u\n",
+				     sq->sq_node, sq->sq_port);
+		return;
+	}
+
 	rsp.rsp.result = QMI_RESULT_SUCCESS_V01;
 	rsp.rsp.error = QMI_ERR_NONE_V01;
 
@@ -214,6 +229,13 @@ static void ipa_server_driver_init_complete(struct qmi_handle *qmi,
 	ipa_qmi = container_of(qmi, struct ipa_qmi, server_handle);
 	ipa = container_of(ipa_qmi, struct ipa, qmi);
 
+	if (!ipa_server_from_modem(ipa_qmi, sq)) {
+		dev_warn_ratelimited(ipa->dev,
+				     "ignoring QMI request from non-modem sender %u:%u\n",
+				     sq->sq_node, sq->sq_port);
+		return;
+	}
+
 	rsp.rsp.result = QMI_RESULT_SUCCESS_V01;
 	rsp.rsp.error = QMI_ERR_NONE_V01;
 
-- 
2.50.1 (Apple Git-155)

