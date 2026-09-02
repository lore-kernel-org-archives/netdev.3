Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D683515EB
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 04:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788321807; cv=none; b=ZDziGaKM+90MnYJ0hlSZD4VQ5xgVD2M/0uH5X0JVAa/iV/6x3A+5ZdPZbDheKW1aCUeMYbRKiv8fk38co1XncrEoTlMwunQMpPDvOoHiv5TF2egK5MWDfBa17bxGSfdkfjC/TsR/f6CKZiYIZr4RzqmHF+kIVRetzPlKZMnhO9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788321807; c=relaxed/simple;
	bh=BJ82qEZX6k4O1D821wuWjRT5Ni/zDBh3SF9te58rf/w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cjgVppeGPnKnk8WjRB6BdIYhKLUjUa4v+cvsTH+7gJLhW20hr8c8StMghCcxWzrrQNxqJyhWq3Cp05FBkGspMRUrtEbO22j0zN6RVQ5z6kmyZ/4PoUysRln0m4lulLJolRpfiZKRBd0nlrbSfX/dloIeWWihfz8E8jrCCmyBdro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NGipKqop; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGipKqop"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-398a5aad413so517452a91.3
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 21:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788321800; x=1788926600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zSdYkhbRTezSkFkWLoI11mcSPh2b10Yb/gYreO5PKeY=;
        b=NGipKqopDW53DL5tQiDK+O9iqBYxLLxPH093uLgpHVrjhqSt8kmtr9PBC17X5tNH++
         AMLuHNarr6wt5fnRbc2Etg6+IUkcmL0bV573S4TcBFzHghdcL6JpW1zkxLfXMFuqoUzI
         inC4feXh/RgdCviATmF4DbPcp+TpJAzqdtJj6JW/Tdprn3w4K0fE8MEhPDMvqa3/ZyGy
         J/f8xiJ5KtTx4NI+NzbmeBlaAgMGrK0cb9552rL4IyjT6sVMXGov4qByNmmvDPbFxaJh
         MV/W3bdmHrP3TA4xoU3wE9YUk0MwZ1TzyZTnW8EpkwuKemSUrYHpxVOvyU+RKnh1/C3c
         H+hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788321800; x=1788926600;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zSdYkhbRTezSkFkWLoI11mcSPh2b10Yb/gYreO5PKeY=;
        b=VC6L4nQo1g+E48ebr5nNVwDBmu0Pssvk0z7dhZIy5FE5TFxDx7E7x6NAXxPh/Z93do
         D9JzvlboA7xmJyQBTfoDL+hj0vBtM417TV6dYq+tlPWvAKrODzwDby8GnEJXKsCsZ0NF
         JsYkp6oRnZOzpOkWapYNnfDl492rUeJUrdeL6m3BqkfJJzG04dQcQlKM+7tyS77hcioH
         IC25DC//tRmYRkHl6nNJco+PYWQv/34V0SsjAP0vK4j7v3qWpy646Q5PQLR9Q7EeqJUv
         ssoO1kzKBGCfWTTpK0j0a0K/0k1MsHKkqMCs5oF6V9Ie2ORT8rKGUujmZkqpVpkgff92
         Mg2Q==
X-Gm-Message-State: AFuF++ljjK8gNilyM0KT4rhEE86I5Wy3W22CDbw9SQyPkKqoAZ2D4fQR
	1pXoDX5WieCBnXD/xBA34ljpZ+ts0C+zKROCozcMnaCV/qfZYjG+pIBBjYwUHq/u
X-Gm-Gg: AYBFou2EdJ3smNC4lvpYjTpEht7kd1epq6P2AWQoPxvq0pwQToaCkJifOZLiZG35qUg
	TLUMtpFC0i7ujE2nh5P4WqEHALvwqQa/UDXcbb6Gusgm7ln79RImFxwKqjANbA8tIQBmdjmbxNr
	wn2TZX7pp4X2ZOkmBqdTCMrizyodtJsgyaTG0WMpF8xU3SQHIX9+ZMp7PeOgIQvHhlvbxMti0t9
	lPsdKNiY8gc2O3Yi3OpjjLYDop/YYSWObbMg8ACn76ew0oLbIlhIWE/BzhxMqKgYloFhXlqmAS2
	AZz8VTwtASWpBLJqZca3C50et2dnmAd213x9QGDlCMlq1PuzHl5UAAs6CqCbLQeIChttBxjO+vF
	dgzZuWt5it8/Bl4BmZFGQr8kis5HprSaIYoMG0ILDAj59A7ro2FZyDRyHPXVimCw0dSsRVfVKuJ
	6c+UrGCU9j6HgFHn+VGv0+qwKm7y3++MrcQ1101kGKXTeMd9lwgrPfy8jgkO5haTlJrx90gsgJC
	0lSyQyOF8irJ1wTVXC7rYhFNSiUQ8jskQ3iITbk371q0GEFK1SEZKto3He0Akci
X-Received: by 2002:a17:90b:2552:b0:38e:c232:9d3f with SMTP id 98e67ed59e1d1-39aedec7bbbmr2995232a91.5.1788321799689;
        Tue, 01 Sep 2026 21:03:19 -0700 (PDT)
Received: from Inspiron-14-5420.. ([2402:e280:21c6:671:5fdf:d463:f07:1882])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32f07baa594sm3364529eec.22.2026.09.01.21.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 21:03:19 -0700 (PDT)
From: "Hemendra M. Naik" <hemendranaik@gmail.com>
To: netdev@vger.kernel.org
Cc: jiri@resnulli.us,
	jhs@mojatatu.com,
	linux-kernel@vger.kernel.org,
	vishy0777@gmail.com,
	tahiliani@nitk.edu.in,
	"Hemendra M. Naik" <hemendranaik@gmail.com>
Subject: [PATCH iproute2-next v5 3/3] tc: correct tc_pie_xstats field documentation
Date: Wed,  2 Sep 2026 09:32:21 +0530
Message-Id: <20260902040221.83734-4-hemendranaik@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260902040221.83734-1-hemendranaik@gmail.com>
References: <20260902040221.83734-1-hemendranaik@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct the comments describing the delay and avg_dq_rate fields in
struct tc_pie_xstats to match the values exported by the kernel.

Update the documented units for delay from milliseconds to
microseconds, and for avg_dq_rate from bits/pie_time to
bytes/second.

These are documentation-only changes and do not affect the UAPI or
runtime behavior.

Signed-off-by: Hemendra M. Naik <hemendranaik@gmail.com>
Signed-off-by: Vishal Kamath <vishy0777@gmail.com>
Signed-off-by: Mohit P. Tahiliani <tahiliani@nitk.edu.in>
---
 include/uapi/linux/pkt_sched.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/pkt_sched.h b/include/uapi/linux/pkt_sched.h
index 776e86e5..1a3b32e4 100644
--- a/include/uapi/linux/pkt_sched.h
+++ b/include/uapi/linux/pkt_sched.h
@@ -920,9 +920,9 @@ enum {
 
 struct tc_pie_xstats {
 	__u64 prob;			/* current probability */
-	__u32 delay;			/* current delay in ms */
+	__u32 delay;			/* current delay in microseconds */
 	__u32 avg_dq_rate;		/* current average dq_rate in
-					 * bits/pie_time
+					 * bytes/second
 					 */
 	__u32 dq_rate_estimating;	/* is avg_dq_rate being calculated? */
 	__u32 packets_in;		/* total number of packets enqueued */
-- 
2.34.1

