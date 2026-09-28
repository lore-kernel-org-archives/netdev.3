Received: from mail-yx2-f39.google.com (mail-yx2-f39.google.com [74.125.224.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E0B37E2E9
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 06:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790576655; cv=none; b=ovHIQEEWq8Luwqvooca12qAutZViXijhwfaugosnvavIoTo7s2g3dl2MoVvQ3xuzuqbRg6bnhCcYlu4M/z+SxLgNueiMv9JpnCJNg6dfttzfbiEZNTU5RIpj1cPvkLFKF/2rXcOolujBCBvNorL/djMDuG/GaMsRdNCLIpQ5C/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790576655; c=relaxed/simple;
	bh=Fuhci/NNQLVUzWkpUJ9YcTdRVY+06L73ZSAsWbc+3VE=;
	h=Message-ID:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IA5b86aJPrb4DqoKSrIXdAMhXPaZ7USfU7XkzcGQVo1unARSpJesx3u+ekpYtMkK3/obu3unQN7ngTHIJ8tYIyEf8Z9/7ERu+cWqFaS6RPd48pHuhznJwzKptIBB7ragpeSDA1TfCCZWlNe6N7uoxv9GlKbahnvuA4/IDpJliVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lwhbLYPl; arc=none smtp.client-ip=74.125.224.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lwhbLYPl"
Received: by mail-yx2-f39.google.com with SMTP id 956f58d0204a3-67534eb4effso730695d50.1
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 23:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790576653; x=1791181453; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:subject:cc:to:from:date:message-id:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NgBUoAGMce0wDtJT/5tr5PejNWm/4KbKs95+kgenKk4=;
        b=lwhbLYPl64zWjoPjXWDqJSw4cdTJLhD/Nr/crQNjqiUD6XiCKfFeTIPvEXhCdZ0mre
         mFBx0rU9DBt9ioC07p3a9hsTI4CbrD1o+oAXQiTL2WspaDVX27vTfnFdTdRCtaT+hA+u
         4lk9nCkNZPgrCwFoZOAdsOLXea/Cb+gAyZyc9lyLJHQTS2AVEMwrIEwFvyIVY0flVUeR
         teo7bwE/oHbL/oENB1lSYFqVTHn9xRoNpUUVwemul0zUkBOyjr8Q/z7XixeaGOaGvXGe
         RY40FAhjeVnE6U2urvMol5gubOXBNwfLCGnIdB3AZfzM8qrol1haTXmuJplIAOW0CpGD
         w7Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790576653; x=1791181453;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:subject:cc:to:from:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NgBUoAGMce0wDtJT/5tr5PejNWm/4KbKs95+kgenKk4=;
        b=IQPbQLyG44Vm+VkEHcdpyg4a/fYNJSBfdn9CeblajevquDCfxfBqzo/4FpjCWW0rDs
         sC5909MYWz4OJLhspa2v6Px3wmz/B5Jmu+aJfCNpb1QBRjKT3Twc4Y/X9d1DrZZmzY19
         3OoLDloxAjlq0tKzc+m9LxIv19UR+86q7CE4WRFoJVAj2puXpO5dKKsSpFUa+lx9bGmH
         wALEY1n3R7jfjFxjG/o3ENbzo84i8fBti+12gvr3+M6E9JVmHvki80opK4mwI9Ag9VR+
         axXOObrklKlJe/HT/kOzOY1R9+oYS65t3yiFEGIdYix9WxBsrgZLtrSiOQZkSK7KY3xy
         7IEg==
X-Forwarded-Encrypted: i=1; AKwUvByQSjAV+oidCpO0nVpGMgrecvwA3FUcbfldjBT82Bg0pvNUNwIFD5WjdpihjfQ7F9LSv5b9Fn0=@vger.kernel.org
X-Gm-Message-State: AFq9FYK6NPvWgqs0nyqm8j+a+EK+kOU6TOiwf48oa7WT4PTmR63ViTyn
	c0meIlkbEqGxACdbnyMp0ZE1QNp2nzkoMRYssMMG2I8nn0+3R2M/Jmyf
X-Gm-Gg: AYBFou0JUK1or3wGUSww3yQQnU+VGTU6PYq8UONl7KyRV6g8mMs6BnYyJ3aq95+YHQq
	eDUAAet+rDc6xXg3Crxx03FiyZl1Nff7wG22LQuXEJajofadxlEa5xdk3xlF0MYRrugcWb8qvsU
	+6+ZwtxQ4ExB3nt3hR4FPjFaQvNPVtVIyhS6Ap1h4WAtvMSB5fDaEsJ3QpHl5X3uaLElw+Lmi8j
	rtGbFCX673waFaIenD/SRL+cM55RcppZTozPRRgOzisTu8a98S5KwuODicWhzNylyZiXFnFCdEG
	Yy5xwp8rCTrjCEILU0isw0S/K/z2lZMvk53PG6q8NQLAkcvQBlUCxKbs8T0zJ702SS3UnCJ1Y+X
	778DS6io31X1YKC3kvuNRo5abjNALLUJM1nlRhtof84QWuT8y+rux0DFZCRsNdwNctiJpFQM6iA
	DqKPrcBdGS1dZUU2hzXfvNEfxWvtUQ4KdavOUIm+tC7hOKTLlCcUUX6YfnbvGTHit7kifkaSCjG
	bAgeJBZ7TNkrchTtb42JF69P0j6aguepdiyPgcXv71WxboQOAX8MN36FVviq+qlrQXy5YkABHAC
	45yrLIo44VyZuAWWfIcaKr/uZ4uDnuP+GrpQodP3iv9Aew6r5O0zTgoEQnSaUkPVxrHb0xRvV2+
	s6CjB5TZ7hnrylte4NjmOymZ2AwspHoYecVt46Dl/92tIInAa9OTaTzoWdtnweKh1ZKoZ5OYpOA
	VEjONXO/jGqNnSlcRUuNRyhJs3Vwky3SbmC/3+
X-Received: by 2002:a05:690e:803:20b0:675:47ba:21b3 with SMTP id 956f58d0204a3-67547ba2609mr574124d50.103.1790576653226;
        Sun, 27 Sep 2026 23:24:13 -0700 (PDT)
Received: from [10.0.0.19] (c-73-137-217-102.hsd1.ga.comcast.net. [73.137.217.102])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8a86108f052sm39434077b3.49.2026.09.27.23.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 23:24:12 -0700 (PDT)
Message-ID: <6aba080c.b933486d.297b72.5042@mx.google.com>
Date: Sun, 27 Sep 2026 23:24:12 -0700 (PDT)
From: Atharva Vartak <atharva.a.vartak@gmail.com>
To: security@kernel.org
Cc: alibuda@linux.alibaba.com, dust.li@linux.alibaba.com,
 mjambigi@linux.ibm.com, sidraya@linux.ibm.com, w@1wt.eu,
 tonylu@linux.alibaba.com, guwen@linux.alibaba.com, linux-rdma@vger.kernel.org,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH] net/smc: hold a reference on net_device returned by
 pnet_find_base_ndev()
In-Reply-To: <arn3qTu_SeM8Yrjj@1wt.eu>
References: <arn3qTu_SeM8Yrjj@1wt.eu>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

pnet_find_base_ndev() resolves the base net_device for stacked devices
under RTNL, then drops the lock and returns the raw pointer without
taking a reference.  All three callers dereference the pointer after
RTNL has been released, creating a use-after-free window if the device
is concurrently unregistered.

Take dev_hold() before dropping RTNL and add the matching dev_put() in
every return path of the three callers:

  - smc_pnet_add_eth()
  - smc_pnet_find_roce_by_pnetid()
  - smc_pnet_find_ism_by_pnetid()

Fixes: 0afff91c6f5e ("net/smc: add pnetid support")
Fixes: 1619f770589a ("net/smc: add pnetid support for SMC-D and ISM")
Cc: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: Dust Li <dust.li@linux.alibaba.com>
Cc: Sidraya Jayagond <sidraya@linux.ibm.com>
Cc: Mahanta Jambigi <mjambigi@linux.ibm.com>
Cc: Tony Lu <tonylu@linux.alibaba.com>
Cc: Wen Gu <guwen@linux.alibaba.com>
Cc: Willy Tarreau <w@1wt.eu>
Cc: linux-rdma@vger.kernel.org
Cc: linux-s390@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Atharva Vartak <atharva.a.vartak@gmail.com>
---
Apologies for not Cc'ing the maintainers on the initial report, will
follow the process properly going forward.

Based on v7.3-rc5. Passes checkpatch and compiles cleanly.

 net/smc/smc_pnet.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
index ff9c9c35c..d6e2f4454 100644
--- a/net/smc/smc_pnet.c
+++ b/net/smc/smc_pnet.c
@@ -367,8 +367,11 @@ static int smc_pnet_add_eth(struct smc_pnettable *pnetta=
ble, struct net *net,
 	if (ndev) {
 		base_ndev =3D pnet_find_base_ndev(ndev);
 		if (!smc_pnetid_by_dev_port(base_ndev->dev.parent,
-					    base_ndev->dev_port, ndev_pnetid))
+					    base_ndev->dev_port, ndev_pnetid)) {
+			dev_put(base_ndev);
 			goto out_put;
+		}
+		dev_put(base_ndev);
 	}
=20
 	/* add a new netdev entry to the pnet table if there isn't one */
@@ -949,6 +952,8 @@ static struct net_device *pnet_find_base_ndev(struct net_=
device *ndev)
 {
 	rtnl_lock();
 	ndev =3D __pnet_find_base_ndev(ndev);
+	/* keep ndev alive after dropping RTNL, callers must dev_put() */
+	dev_hold(ndev);
 	rtnl_unlock();
 	return ndev;
 }
@@ -1094,8 +1099,10 @@ static void smc_pnet_find_roce_by_pnetid(struct net_de=
vice *ndev,
 	    smc_pnet_find_ndev_pnetid_by_table(base_ndev, ndev_pnetid) &&
 	    smc_pnet_find_ndev_pnetid_by_table(ndev, ndev_pnetid)) {
 		smc_pnet_find_rdma_dev(base_ndev, ini);
+		dev_put(base_ndev);
 		return; /* pnetid could not be determined */
 	}
+	dev_put(base_ndev);
 	_smc_pnet_find_roce_by_pnetid(ndev_pnetid, ini, NULL, net);
 }
=20
@@ -1108,8 +1115,10 @@ static void smc_pnet_find_ism_by_pnetid(struct net_dev=
ice *ndev,
 	ndev =3D pnet_find_base_ndev(ndev);
 	if (smc_pnetid_by_dev_port(ndev->dev.parent, ndev->dev_port,
 				   ndev_pnetid) &&
-	    smc_pnet_find_ndev_pnetid_by_table(ndev, ndev_pnetid))
+	    smc_pnet_find_ndev_pnetid_by_table(ndev, ndev_pnetid)) {
+		dev_put(ndev);
 		return; /* pnetid could not be determined */
+	}
=20
 	mutex_lock(&smcd_dev_list.mutex);
 	list_for_each_entry(ismdev, &smcd_dev_list.list, list) {
@@ -1123,6 +1132,7 @@ static void smc_pnet_find_ism_by_pnetid(struct net_devi=
ce *ndev,
 		}
 	}
 	mutex_unlock(&smcd_dev_list.mutex);
+	dev_put(ndev);
 }
=20
 /* PNET table analysis for a given sock:
--=20
2.54.0

