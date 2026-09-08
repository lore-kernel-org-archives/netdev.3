Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BCD4FECF6
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 22:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788908265; cv=none; b=BtMbL2J0WXod8zdvNml6OX4G5/hNXr59dric9Q7PEn6I2jrwGQ23ah4Lou1Q0RUavFFfr8rQWhN6ZuEAIS6BHvEP44S2OdtGLvwMEnmgSQV+LbRK0pBb7+6JWR5WooxhrPGscMGKsEZKiJUguRcIOu7mtEmr5TD8zM+WbtQIyW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788908265; c=relaxed/simple;
	bh=rkKyl75oNGSh9argBDO65R8TRc+7/cMdzZ2u2kUAnOg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pXQNO5oas42wAFjvKuPmM2o5h3aHln3/5D+sC4n1Ewbdo6ttKj3Q3UTo4USuXvRROUehXMjlnfAoeOMuy3NGHHRl4LUzThm27QEL4V9na+qJkQNYVhvpKI6dSkRGrP03l0CDzLy7aXav9RHIUpJqsESWkZCxRGgFahN4kpp/Vt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sX2n17ka; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sX2n17ka"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-398b3d66515so5085444a91.0
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 15:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788908260; x=1789513060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dc0GX5Div10dtBv7GvQstkhNGLImZIuVjBsaWt2c5iA=;
        b=sX2n17kaiGgHH6AD+8GmtskgzlMfU1KmRrrXB1nJ1dTYB73Z09J7PElYBGKMVxKmNW
         lLHJmfUJW/hqx1TV87Ny1iij0rx3nAeGEVSxpJaKcYKN5BqvrbU+3oc8RGx58kdOueN4
         m4gBT2rEMJm7Peifv5e7Aboqkx5btPC6nXZFZqbKq0U46m/bOUBsOsPoNCx/f83d9WhP
         ZLgu9XcnClxWOMxUWehIyaYXq+FDCV+BTwJ2WT1qy3Yg+LEL/Y0k/XklKSlm/l0NDYOe
         feYbBMIyJI7H41kInv5fYzloU4bCpxZzOvS9Iwn/g9VYlAO52e4n0Sp4UwYtZhKkjUpw
         YPRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788908260; x=1789513060;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dc0GX5Div10dtBv7GvQstkhNGLImZIuVjBsaWt2c5iA=;
        b=H4qNdxVWmp9ebWbuvm0LPUMVP+mQIWbweru3cCXF7HPREYwbvlQ8qjJicSJ6uZIfT9
         XSUcJZRjdxPIERBOnnemOa7owrY/wv3O1FOycRQyfjh7979QrYMgc3pMtsEqzhCPqyNq
         fXacaW7x7B5eFHZYc02ODDuM04irQWjy+SvvzePK7bv0ORq5JQq8+SR6EYbf+vGA12yg
         7/iSssrZ4VXjz3RjMqDiIm5JRjbERyVBhnX/2y1AFN+3JFKPzs0MwqUhw0y1bZI4Hbr7
         u01KW8aSySf1+L6Bo+NHp5RzAkUazr//CEZStR23kpzqglgPS5av7Vs55U8RPLrMKcma
         hKWg==
X-Forwarded-Encrypted: i=1; AKwUvBwEfybf2lwZflYBEOiDzJNbcZbYVCdd18E4W3G4+YpZKvFGK9uWPlg21C5sg8pNZQdiTX3eiIA=@vger.kernel.org
X-Gm-Message-State: AFuF++mn0lyRud7g6Cf/XdgTQaRsv+qZlYsVLFm8ivAfLNp2P7MqjqrL
	melOWgGDofsTklmuiVmJdoo55Fo09W0pmEpGV9gFVQQBJkwKnJdPbZO7
X-Gm-Gg: AYBFou0rTBI9D6CoMvfyxNivndOF+8boJZj8pUzVtSal7ukD35HU/xGauIUv/YRKL0f
	1DiPq8qApsfMjM+pbFsEiz+0ILnDFKAwX6/Tbf8WHic2B7qwXqYWquNVxc8Hc2saJ2gVTKGL6q8
	/ix6T5sWiij+FakNF9QPq+pxB60v/7GtFSCxeBpZyaxEc7AYCP47ggS1nsUbPbCb4sCXhQ0vEDv
	VKraa/oQrLKZMjgmc9Ei2WT0DAJ+kqJZ/wf1RNhkhNBmKhKDQbojmpIG6uHoUAefI9thO9giubC
	vX8YO23b+hlF59vUT1l/XVSfFZH5twTZ+cBkK8NBp3+ZgykEXHD9rrmJ7Jd64DSpBjWQMD0dmmY
	Ej74L/39HlofYO0IV9njiwjyzCr2ZPjM5ahymWk06nj+1AMLejvUxnw8OnlWNTC0CY1gEtG6eyw
	Hacmm4pwh3OcjXNnEiw+H8wFrqL8EQu/l8DSjUzII2oZg2TwbXiZobw/+os6XyniRAAHo=
X-Received: by 2002:a17:90a:d64e:b0:38e:2517:5d1f with SMTP id 98e67ed59e1d1-39b2612eb54mr47140729a91.9.1788908260481;
        Tue, 08 Sep 2026 15:57:40 -0700 (PDT)
Received: from localhost ([2620:10d:c090:500::6:91c1])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-143243bfbe3sm36187940c88.11.2026.09.08.15.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 15:57:40 -0700 (PDT)
From: Zinc Lim <limzhineng2@gmail.com>
To: alexanderduyck@fb.com,
	kuba@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	linux@roeck-us.net,
	horms@kernel.org,
	mohsin.bashr@gmail.com
Cc: kernel-team@meta.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	zinclim@meta.com,
	limzhineng2@gmail.com
Subject: [PATCH net-next v3 0/6] eth: fbnic: expand hwmon sensor support
Date: Tue,  8 Sep 2026 15:57:31 -0700
Message-ID: <20260908225737.3034403-1-limzhineng2@gmail.com>
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

Changes from v2:
 - Addressed Jakub's patch 3 feedback on jiffy comparison when
   checking cache validity.

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
 drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c | 262 ++++++++++++++++--
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c   |  55 ----
 drivers/net/ethernet/meta/fbnic/fbnic_mac.h   |   2 -
 6 files changed, 348 insertions(+), 84 deletions(-)

--
2.53.0-Meta
