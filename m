Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FB9364043
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 17:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787593864; cv=none; b=iI3QWVgs4UES4U61RzveQ//gmgMZomnEYlfwGqZzryho7q0Do5W1UJbdkvyjrBiwkbRcKXZa7VZoAUpQmMaRg+KXW/+HwHmlmmI4pUcM4DLJQliNwoZ++Dvnm/2oMsJw+psM0CwGHp5Dib1Vs7I9ZQnn1YeL8ZbUjVRejeU5FIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787593864; c=relaxed/simple;
	bh=j+4P5I1w7yupkjtI1aHIdS2EV8F3BTV+hCLwZ4e00/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=do1ENfgcplZ6jMyEFn822TCGBqUs7xP4bOlyefvtccA4qseZIGcQcD5na0nIPH03++VJ2sNjNkCiuKn7n8gdPsv9Qva6pjX87W0pEPSM89Cz72EbImW1H+FnNWrhN0GB8dWKAJbEIEU3veYFT+8JfnPrivEeE2qtv/WQ1mxuSiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qLsQeXgz; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qLsQeXgz"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cbe827e3cb4so4336658a12.3
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 10:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787593862; x=1788198662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tAf9E7CenHe6l5YzESk+eJosOnuoeSazKjhyH+9ql1Q=;
        b=qLsQeXgzu+15APZs86ZxH5A4GWc0YvJppIAxI8cgH1VAekYqW1OXsOvwtr0yFqsrIo
         HWiFb9Ee7tnpw5Got1QbAVpWrKsolAOCMMYLZHfk9dQzhQETMrEIJxojR81ceduU1TXC
         qt04DBFoPj16Jr8SHTZFJBTDSbG0p0sd1aqDQCeNiJn3HPJbrWcmviQxbrcapk8g6JvD
         AyG7IWOP56lpph1ax1/GurpUlwm4jN7trLz3uaWXdFD8IzFV59ITt9XbB6b8KWl03lNo
         TfxC+Zu3CoXMB6BkUj5aVehmPzurxmPHl1wUWAOMLh/7rIAtGLaxeTUZqO0RLO+JW2dT
         D94g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787593862; x=1788198662;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tAf9E7CenHe6l5YzESk+eJosOnuoeSazKjhyH+9ql1Q=;
        b=Xy+QTfVN42cbTZdo/YbSRCOpEiJwF6jw56OLUWqLYxHxLE0Xyr0Pdl51wgkjivEm2H
         Rujl3CHzY13pYnp4P2/QGPQ1FmzH0rKwxmRJOGaw36I7XG9pfWo+d423R/tXf5grGPsO
         crXn/G7ldOcdCoWMPsuob7U3qT7phEkoYikFqkgdzM0PR9Z4MQIimuD4ZUUq7yM53Y2x
         lnIKBNvrdyK9T7FWG65CpIpeXniGaULRqVPy9YyXTjnlRDZFBLhuDpk955MpveYcj84b
         oWkENnj+BGSpbXCdnZiTEsAiBfBiCmc0vLFXFxSyw51hpe+x0KvJYezZ/dYVM9CRzQ9x
         NY8w==
X-Forwarded-Encrypted: i=1; AHgh+RrKx1Ye+Yap3Q4Xqb6m+qWwieGW3AFN9AGzC9mteughKOmTnB5PbxTQbKSSJxftuTjaFOXc/xo=@vger.kernel.org
X-Gm-Message-State: AFuF++lBqnHkX0UXuYh7ANDrk2gpmHxLGN3jYaFFtbL0PTMG5kJbk3ST
	V/0ivpc5NwpfbV5/AA6m7xsQ2kLJySvT7Ic13WsMOOE/3p4l0c5eAW/+
X-Gm-Gg: AR+sD13UHCM88/xMzlC80DnDx7+ii3EuQgrelFkiTu+h8HGoeol3HwZjiNn+E59xn5G
	W32HGf4OlYfI0D2h8GhIMFNj4agT+JDkNcORV5OHk8UPaPStXrGWJmynzBwMHv7zyYIlF/gz7HW
	z1u8nyHMHwLmqAAsuKVJ8429VA+8XTRhGbSCDPDMnyr3Mj2E7WyHiYV9xHskGknHK3wKnn4UDlM
	+leTPDFE0m67Qn8u5LZtOmgnoj+vNCVBkCGmsUs3C3wonXSkghZxMtKm9hGDi0b6MqNsDHZs5bq
	My8+KXqwfI0pYvp6zLcSeYb8qQqhFsOdMMwrnmKTat/OIUBw1cV3UqQa+Zg1lm0/BhmRPEvzujZ
	N3xKjpxGTsGK3MX0tGvZgz6F1WskgNoOCkKtxwXLkMIlNl0rITJFUHJx0zU5sqaMMXDYD3dp8Zu
	MpIkx+TYghjdAwK5rpebhO1/O7JLmYUCQM9V1U30morGxs0vY+54HqByrDOrzkOr0Y/YN1MWJ7+
	Cxy1w==
X-Received: by 2002:a05:6a20:918c:b0:3cc:8f53:26c0 with SMTP id adf61e73a8af0-3cd301a21c1mr51934883637.17.1787593862323;
        Mon, 24 Aug 2026 10:51:02 -0700 (PDT)
Received: from localhost ([2620:10d:c090:500::4:ddd2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f91d2d1esm29482466eec.17.2026.08.24.10.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 10:51:01 -0700 (PDT)
From: Zinc Lim <limzhineng2@gmail.com>
To: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Simon Horman <horms@kernel.org>,
	Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: kernel-team@meta.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	zinclim@meta.com,
	Zinc Lim <limzhineng2@gmail.com>
Subject: [PATCH net-next v2 0/6] eth: fbnic: expand hwmon sensor support
Date: Mon, 24 Aug 2026 10:50:53 -0700
Message-ID: <20260824175059.2485048-1-limzhineng2@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fbnic currently exposes only the raw temperature and voltage readings
(temp1_input, in0_input) via hwmon. This series builds that out into a
complete sensor interface and hardens the read path.

The firmware capability response already carries per-board sensor
thresholds, and the firmware can asynchronously report when a sensor
crosses one of them. This series surfaces both to userspace and cleans
up the supporting plumbing:

 - Move the sensor read logic out of fbnic_mac, closer to its only
   caller in the hwmon code, and drop the now-unused get_sensor op.
 - Expose all hwmon attributes unconditionally as read-only (0444).
 - Cache the temperature and voltage readings for the current jiffy so
   a burst of attribute reads issues a single firmware round-trip.
 - Parse and expose the temperature (min/max/crit) and voltage
   (min/max) thresholds. Thresholds the firmware did not populate read
   back as -ENODATA.
 - Add the corresponding alarm attributes, computed by comparing a live
   reading against the stored thresholds.
 - Translate the firmware's sensor-threshold-exceeded message into an
   hwmon event so userspace is notified on the relevant attribute.

Changes from v1:
 - Addressed Jakub's patch 6 feedback on including a
   if (!IS_REACHABLE(CONFIG_HWMON)) return; guard.

Zinc Lim (6):
  eth: fbnic: move sensor read logic out of fbnic_mac
  eth: fbnic: expose all hwmon attributes unconditionally as read-only
  eth: fbnic: cache hwmon sensor readings
  eth: fbnic: report temperature and voltage thresholds via hwmon
  eth: fbnic: report temperature and voltage alarms via hwmon
  eth: fbnic: firmware notifies hwmon on sensor threshold events

 drivers/net/ethernet/meta/fbnic/fbnic.h       |   8 +
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c    |  75 +++++
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h    |  30 ++
 drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c | 263 ++++++++++++++++--
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c   |  55 ----
 drivers/net/ethernet/meta/fbnic/fbnic_mac.h   |   2 -
 6 files changed, 349 insertions(+), 84 deletions(-)

--
2.53.0-Meta
