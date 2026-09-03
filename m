Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26E74CA79A
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 17:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788458283; cv=none; b=DX4YFjXzCKsaKrBsBE9JA3SyicbId15/X0lHf5jfidVb5CEvPEz7CEFShw+IZO7ok+RmNsDn4T9NShD7V04FYWA4EhGLXX+jDQJygk8R5VvOqv+gMJNis8+ERwnlp23cCRs+hI4di8JvpAoEdnsQJ8NiOeo+cDoAKXxnTA9HwlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788458283; c=relaxed/simple;
	bh=pemzhUbdQud36142a3Q674EA4/JDBa78g95gEDDwadI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kmie2GfC2NK+IFauAMhRZWnWBhdZpEnGgOLy6L+joGHYVHxqL0ECGy4lbIcWWuh1FCVXL2p2Z5UeOahbmzdf7rIfZ/mqgTmarrhh4DZBWazNuoMpKe8fYoVDbZJr+F6xo/tElTZ1CTmtvzt+JsEEUL5gsLLt3jUVQpC3Y4mQDFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GD2ROZ9F; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GD2ROZ9F"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2d71a50caa9so1750475ad.0
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 10:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788458281; x=1789063081; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=kVEIWX8vVeVfnpunxGyoiZRSexSG1pvu0ekTIVaP1l0=;
        b=GD2ROZ9FPeoHzzvxfA8fAR071375NU5M+orcxTIkDsp4MFH9krbTpv4Iza3V3oCg10
         SPDrjiBQrwXsa0FX8UgPxch9k2CHKCQti10Z+Jzm6sN0BxJ/kMMVm+aEcPHhHW+whV18
         vgA9Q9SADDpqdbsB2zb5z2TJ0Fc2DUwfFfhBdfZfQdxCo663+NXj6qPt3+HZ9S6656Pr
         3l+dRgYPzAXnj6vHapp20KejxSYVkFjNAxgYOAPU6wuiMkVsg3TQplpqxkyOra+wbotr
         nUZUN9sYCduXtXsJELTIu85s3KZRlFBwaix1263e8CqtzIOoE+AHbqo2wo+RXMK4CWs+
         fT3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788458281; x=1789063081;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kVEIWX8vVeVfnpunxGyoiZRSexSG1pvu0ekTIVaP1l0=;
        b=DrA9fNXNJuZiIsM6zHOR9CwFs5OFQv96RnTER2XtizOqMzvZPo7jy+aCjIpH2gQL1G
         cDAv0SeNDlLGyYS5APR4ZEUx0QikovDlsyiSZNUHE30FxArNFF1jquwYQr57Sj3Bd7Y/
         kttj/5UfO/x6Pf0w9fI1zuU2hPJ8ro0nQcFYysVeukIY/cKVdZ3D2N+GqKuRCJ6Ox57S
         w4GLbR8viJ8KvIoYpkj7+7eWhnzyg92XIL7Q0vYoRDRZwVx0tnbrTMnJ+ntzYhwRq5FS
         fhIXBrnYQs6m4ToCf9qqw55knZ4VFIY4A+OGaNJP4UU6mB4MEc3z430KjsYq4ITRrGQZ
         TLAA==
X-Gm-Message-State: AFuF++njE9a93r6V3weFBm+alqv41cg8/CIKYPYfO+pIDWWKHX13EUzV
	/l8vIH2ZWq5gDv6pN/GFz2d3UJ9VexuLPM4Q9rpZVscd0m5N7f6e/mv5
X-Gm-Gg: AYBFou1BfMIKRdPU7h/fuw8p/cbbX+ezUnfahv036egButhwVTFBXG9gOgNuKQY1dq8
	gvmYWrttpBVxB6qUq9eZJHgF26JEUrUodvuwMDJw1gxiiEtuWRy4WEWoF0C5Ki8QAesx1mnN9ke
	Eu17cAUTPCznkIij2E6QQJQFXBJJCi3XBeRTj0nJQNwlYxy3rlNP4tKPHRPJA4BFegPY6mGJvSO
	FYyXA5M1FUWSehr1yiFH5C9YG9X6qYoGnGGDb9TbNOuEczkiHCC6oSriY/WmVu6HcE+9kJEsXBb
	1cJaPa3E9JwM5bp09Dv6t9HJO8fQh0+TwaQGKs9u6AqDZb5jnIOzqel8liZHq148gKBu6tPv1Nh
	AFSmsPsxpBoUGqCXqFXJEMLbYX6O2QJwAC4Japs4L9ptzA7l+xUQat9L/+WE8k2OzsRI2EAmfOm
	zTfV98AMfR4I89rKi28LQLKeianbSqJXg1Ssa2zICbq5z+y6Yy+w+LJNpszyaEBGCivprJCBcdh
	stEjbMJRaeaP4256hwVLY9WzBDIO63yx02kENrtfpwhUh0luEGyo0ofO4cQ46/8EGbo0jBKDPFw
	HzAu+iCh
X-Received: by 2002:a17:903:b8d:b0:2d7:1e07:4859 with SMTP id d9443c01a7336-2db125cd33emr11121185ad.2.1788458280773;
        Thu, 03 Sep 2026 10:58:00 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:4db7:e37c:a6be:f5bf])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dafe62d9easm13581175ad.17.2026.09.03.10.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 10:58:00 -0700 (PDT)
Subject: [net-next PATCH 1/2] fbnic: Don't reject capabilities when BMC is
 present without a MAC
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 kernel-team@meta.com, Simon Horman <horms@kernel.org>
Date: Thu, 03 Sep 2026 10:57:59 -0700
Message-ID: 
 <178845827907.2787.3876388161665795031.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <178845766796.2787.6001399537275460493.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <178845766796.2787.6001399537275460493.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Alexander Duyck <alexanderduyck@fb.com>

fbnic_fw_parse_cap_resp() returns -EINVAL when the firmware reports the
BMC present but includes no BMC MAC address array. The firmware reports
the BMC present as soon as its NC-SI channel is enabled, which happens
before the BMC has been assigned a MAC address; during that window the
message legitimately carries no MAC array.

The firmware and link fields are parsed earlier in the function so they
are retained, but returning -EINVAL abandons the rest of the response:
the BMC presence state, the all-multi flag and the anti-rollback version
are never recorded, and need_bmc_tcam_reinit is left unset so the BMC
TCAM is not refreshed. The parser also reports the whole capabilities
message as malformed even though it is well formed.

Treat a present BMC with no MAC array as the BMC not being present: clear
the stored BMC MAC addresses and continue parsing the remainder of the
message. Factor the BMC capability handling out into
fbnic_fw_parse_bmc_cap() while here.

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c |   56 +++++++++++++++++++---------
 1 file changed, 37 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
index ff1674eff7ad..bf8006710f46 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
@@ -607,6 +607,40 @@ static int fbnic_fw_parse_bmc_addrs(u8 bmc_mac_addr[][ETH_ALEN],
 	return 0;
 }
 
+static int fbnic_fw_parse_bmc_cap(struct fbnic_dev *fbd,
+				  struct fbnic_tlv_msg **results,
+				  bool *bmc_present, u32 *all_multi)
+{
+	struct fbnic_tlv_msg *attr;
+	int err;
+
+	/* The FW reports the BMC present as soon as its NC-SI channel is
+	 * enabled, which is before the BMC has been assigned a MAC address.
+	 * In that window the message carries no MAC array; there is nothing
+	 * to program, so treat the BMC as absent. On any absence clear the
+	 * stored BMC MAC addresses and report the BMC as not present.
+	 */
+	if (!results[FBNIC_FW_CAP_RESP_BMC_PRESENT])
+		goto no_bmc;
+
+	attr = results[FBNIC_FW_CAP_RESP_BMC_MAC_ARRAY];
+	if (!attr)
+		goto no_bmc;
+
+	err = fbnic_fw_parse_bmc_addrs(fbd->fw_cap.bmc_mac_addr, attr, 4);
+	if (err)
+		return err;
+
+	*all_multi = fta_get_uint(results, FBNIC_FW_CAP_RESP_BMC_ALL_MULTI);
+	*bmc_present = true;
+	return 0;
+
+no_bmc:
+	memset(fbd->fw_cap.bmc_mac_addr, 0, sizeof(fbd->fw_cap.bmc_mac_addr));
+	*bmc_present = false;
+	return 0;
+}
+
 static int fbnic_fw_parse_cap_resp(void *opaque, struct fbnic_tlv_msg **results)
 {
 	u32 all_multi = 0, version = 0;
@@ -671,25 +705,9 @@ static int fbnic_fw_parse_cap_resp(void *opaque, struct fbnic_tlv_msg **results)
 	fbd->fw_cap.link_fec =
 		fta_get_uint(results, FBNIC_FW_CAP_RESP_FW_LINK_FEC);
 
-	bmc_present = !!results[FBNIC_FW_CAP_RESP_BMC_PRESENT];
-	if (bmc_present) {
-		struct fbnic_tlv_msg *attr;
-
-		attr = results[FBNIC_FW_CAP_RESP_BMC_MAC_ARRAY];
-		if (!attr)
-			return -EINVAL;
-
-		err = fbnic_fw_parse_bmc_addrs(fbd->fw_cap.bmc_mac_addr,
-					       attr, 4);
-		if (err)
-			return err;
-
-		all_multi =
-			fta_get_uint(results, FBNIC_FW_CAP_RESP_BMC_ALL_MULTI);
-	} else {
-		memset(fbd->fw_cap.bmc_mac_addr, 0,
-		       sizeof(fbd->fw_cap.bmc_mac_addr));
-	}
+	err = fbnic_fw_parse_bmc_cap(fbd, results, &bmc_present, &all_multi);
+	if (err)
+		return err;
 
 	fbd->fw_cap.bmc_present = bmc_present;
 


