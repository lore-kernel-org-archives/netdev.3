Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F48D559C92
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 14:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790087334; cv=none; b=Ut1599EmTWNc/mTWoNa8JMgLP0t5yxRi3H50gx4PmKFcx63wExb5+n/GYeWb0XboTLsQ8AuYhVHFhvVCu0v6m+niucNOID80vEhCgUZ41YugMDK36T22sit6sUb+MwJHvCyKNtXHxUCe16u0JcdQJseX3yIq4EjogkZ69K+Z+PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790087334; c=relaxed/simple;
	bh=vmXda7q3sDpJEX8AFmmpa4DPRcImaRBMRm6OQHAWGGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E6i/m1dtXMmc0x9bbs3QDweDBkNTQ6DCMS27Dj8bFEgD9fBn810n27DkPfayO5CYiY/bL7QvUSa+Fb9Zfy15StEcbUYngu44ioG0CsUKXYh4nNNALgmqUYmO1XFrBglJYeE9EewbNiwYcZFm4ytTNM5YHqM2O7aIcmg8t/+uxhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VijQ3XL8; arc=none smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VijQ3XL8"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b8c9954ccbso2563054e87.1
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 07:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790087330; x=1790692130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tCnqW3uWQK4vADqWc0y/sNw0Dm5EpPQnotxldEeM2YU=;
        b=VijQ3XL8mcNzlFTQCPeDqWlpAWFBrdyBLIiesM/qzOa/uiameADm5DzLR49ACYIN27
         w3ysbVpjEBSUX8ZXwH3ccjFzObRtXLANTGHvVwJ4kDPGAX5+Xy3tyJ++uJ6k97PptoSW
         tEIAkUrg657+mfUuSxRFNAqvbOLRkw2TwOvuhBCIufALBg9LJHLdCKv8+EXY5UBQljtb
         RIKrj+KdfVVhmx2q1bxH0Y6sz6xF+6TvkOZNkJDhaTeKv2JITQpHkXseSYEjTa//06wh
         0tODbO1HYl7B4zXwtEipB/SLDni+3RcfDrGIzYO7jozKH3kvnHtfcp1yxKWxHlHWLJ6y
         RikA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790087330; x=1790692130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tCnqW3uWQK4vADqWc0y/sNw0Dm5EpPQnotxldEeM2YU=;
        b=ztLrrkBG/do6wJneNPf7603wXCHVepJIl9VO4AMA5udpcR4OoCzZX8dNtJ688I5a3W
         avleOQK6UKH9NppYvRnoaY9HNZ2SSivH0AaGEniK+nMFSyD4CmvRQNo4x42zQD+27yPV
         0DhG/q/wPkVoYC5Bc742S6QaTUWiiNnbTu9OexLA8J/vX6/2T+TxzG0enZkm1n3FrgDT
         pv3R5aB68GqOn/o/31haKCachyntJZ5NrfaNCwyRXwxfIJSnmlu/22rYf4lJe4OEdeLG
         jKGdTIpD8nqOhOsq+Qdln/74aG3dibq/fxIWFXS/+85RVCCc57tr4Q4ZBsTDiJQ0xH5h
         4T9A==
X-Forwarded-Encrypted: i=1; AKwUvBxsq30ZeMF3h6yc7Cc61FDqpCa/gZv//rPsfmeIuMQ5u5x1sCs/ptEPigmb3C8Vr349Xa2dxzA=@vger.kernel.org
X-Gm-Message-State: AFuF++kzohzYVCrExs40wouqpsW6pOhVcIqv97laiz9U0r1yDbE40BLK
	5Q+pF7qh2oB6N9FmconJkCSLcpujp0ptAzA6uX2A2IVx0/H34/5ffGBF
X-Gm-Gg: AYBFou32KmfvbvyX8mXDKccF/1skGTqguT3SjCSqsUfVlYYd8tG1lxBTFrHZpxM8G3y
	oICJYS4mXXxdJJLJLh2EpDirDnK/GJJnZf1K04RO3021Sfw5cJwebG4Fq2+/UTERaKMWvPK3dtl
	dMxnmLoXxnJlJYpGJf1sT+Yq43r+YLSXRoNrG2LAMA9InPMu32IWgG5L8BraBjluKWXEyP+uGNW
	8/3hCKLGfg8F7JDyw4NLlowaeZhKNGT3+C7BVkR1q/fTROT7yxHZ3fO/iC43uUoYmgDiO7gn4Is
	MFdqxASixuKupZN+hghh0vQNmHdXmk1zBo3IHdPnHBvMHnWC7odeMFF523nj8wauva34/tokpQ4
	IlXDXY5utUfAP2nK+oxqmuFSOaHKqWmOOw5f9eK10L3ozqxC8339nT1/q2ZwrOLizYAUmz3+8qR
	+xEw3Sf6ltfOUyqBYUwjP0Xy+jZvRLotXhpqIADR7+I5Wy2SkmGN0fcoeB9vCaLjZ+c/sf8oeIv
	ItY9OLYGr0sS/vLq4iNrvy3gVJzRckOOJUHgMo9
X-Received: by 2002:a05:6512:3b2a:b0:5b6:1a81:1c8d with SMTP id 2adb3069b0e04-5b8c197976cmr4302647e87.66.1790087328717;
        Tue, 22 Sep 2026 07:28:48 -0700 (PDT)
Received: from fedora-tap.advaoptical.com ([82.166.23.19])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8d46d2064sm589691e87.24.2026.09.22.07.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 07:28:48 -0700 (PDT)
From: Sagi Maimon <maimon.sagi@gmail.com>
To: Richard Cochran <richardcochran@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	netdev@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sagi Maimon <maimon.sagi@gmail.com>,
	netdev-bot+sashiko@kernel.org
Subject: [PATCH net-next 6/9] ptp: ocp: report fw.cpld with an empty value until the USERCODE is read
Date: Tue, 22 Sep 2026 17:28:26 +0300
Message-ID: <20260922142829.57740-7-maimon.sagi@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260922142829.57740-1-maimon.sagi@gmail.com>
References: <20260922142829.57740-1-maimon.sagi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The fw.cpld running version was published as the literal string "unknown"
before the USERCODE had been read, which contradicts both the changelog
and the .rst entry describing it as the USERCODE formatted as 0x%08x, and
is not a version anyone can use.

The string was there because naming the component is what lets
"devlink dev flash ... component fw.cpld" through, and a part left holding
a bad image answers neither READ_ID nor READ_USERCODE - gating the
component on the read would make exactly that state unrecoverable.

An empty value gives both: devlink_info_version_put() invokes its
version_cb, which is what devlink_flash_component_get() collects names
with, before returning early on an empty value, so the component stays
flashable while no version attribute is emitted.

Suggested-by: netdev-bot+sashiko@kernel.org
Fixes: a4b7c15aa78f ("ptp: ocp: add TAP CPLD flashing via devlink")
Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
---
 drivers/ptp/ptp_ocp.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index e10f6b5149c9..4ce86df6e196 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -2264,15 +2264,20 @@ ptp_ocp_devlink_info_get(struct devlink *devlink, struct devlink_info_req *req,
 		/* The flashable component.  Naming it here is what lets
 		 * "devlink dev flash ... component fw.cpld" through, as the
 		 * core matches the name against the versions reported here,
-		 * so it is reported for every board that has the part and not
+		 * so it is named for every board that has the part and not
 		 * only once its USERCODE has been read: a part left holding a
 		 * bad image answers neither, and gating the component on the
 		 * read would make that state unrecoverable.
+		 *
+		 * An empty value still registers the name with the core -
+		 * devlink_info_version_put() runs its version_cb before the
+		 * empty-value early-out - while emitting no version attribute,
+		 * so nothing is published until the USERCODE has been read.
 		 */
 		if (smp_load_acquire(&bp->cpld_usercode_ok))
 			sprintf(buf, "0x%08x", READ_ONCE(bp->cpld_usercode));
 		else
-			strscpy(buf, "unknown", sizeof(buf));
+			buf[0] = '\0';
 		err = devlink_info_version_running_put_ext(req, "fw.cpld", buf,
 							   ver_type);
 		if (err)
-- 
2.47.0

