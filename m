Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A29D3164BB
	for <netdev@vger.kernel.org>; Sat,  9 May 2026 11:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778324476; cv=pass; b=uXi9mGsvLUc+DVNfXYauysU2l9c/pdwcnA+8DcHKURM6ES9Q/J5DVSpMDddfSuHo8XXGOz/MrhcbQ0uwaPeaKLEpo0CCTGGnMf5V6jysEuPSUZfeo3870Y8bzEnDh8UxhfZRVvdQFinv10Kdwr63RauWf0i+lVxKGqa+Ze/WUl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778324476; c=relaxed/simple;
	bh=9zJ/Jp0AIo86B4ZPDMd67viV7ao0qHIhk0miTEb1P1Y=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=E+Y2mOc1/iyPtGUEmg0uXBZaev63SbADaAXMY4lcAbJTjyVK5xwuim3U5pVtpbb/DVxOQMAX1YpncCH/gtsgcehtSQ6HnX8PZJYrV3Y4oYZAnbLYPKoarWR7WLDe46vaZR/Bq6OSSB+lyEiBK3sKYnAs9DXhw7SvoK7xBw5VxEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YAeTUw7R; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YAeTUw7R"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7bf1eaba464so21347677b3.1
        for <netdev@vger.kernel.org>; Sat, 09 May 2026 04:01:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778324474; cv=none;
        d=google.com; s=arc-20240605;
        b=DQjDdNIYtDItVO0Z104BsJT3VuSARgzGK6DIWdK1zHTHUsn0I8MnaUyKTDpwO3Fupy
         dKt3hlM1kV0wS/stXu7W/Ktwx5PULRVCrACX6G4NGan8UmMkzUFiwznF05IeoPwNv+v4
         uuH9GGIWuSf1qFMhu8wOYbf3QQufxPx3e+4RHv47pgQCizIyAR20qJDgRvnFLFuVAwEi
         hrCADAPY06aO1m99wX6o7nQIWumnOhrGdlLdNvC6blw/YKWqhzd36+uOGURTzGYBqsm7
         JIjUY1+7g6GM6BFZKFnOSDc7EpvZvgLBY3DLIQJutuTP5M8cVuAGwYUnhYROixKGLUQg
         45Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=iIt0P0A7yVCeb9NAEa3+HLFnhyLLlsPvHqZAy7iz+x8=;
        fh=3Etnd0lWGNCzgDGAo6Q8H87CXivA1zRdTbczi3nPIKA=;
        b=C5bNh4IJH8bKfTulNkI6Yi2zLZa1EgiIJtK/CVCkOTNRG2zz37TYgLEHruB/4TyPOq
         heUCzAXAq0VzoGC9ghLrNX31hv8RH+ak03lgmSoHy2NIZhBR4/FgnX8qzu6bovdkZCfH
         ZS5j4X5bB5rwMKWkHRwCxxC3goDJDcc4Om5YQEKkU/MDvDfu1Yl+mC4JstJqZZMu5erJ
         S0AD4+WYMWRMdLbkMGWxAhABIwIbwwNNAo8RnuYfXhd5WLb/35Qv3F60Yal/UfAOyTHg
         62HGtHZGCBsXsbVC3SG9ho0woGeCvquUecHxA3tDRsYNEAcc/HYLP0lKa6R1v0wNVZsA
         IT6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778324474; x=1778929274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iIt0P0A7yVCeb9NAEa3+HLFnhyLLlsPvHqZAy7iz+x8=;
        b=YAeTUw7RdhE+KGH22BJXrVVDLE+iBu3X6MApbDMeMbMfUJF02/AgJ34216Ad9y03mg
         3u5h8QCUUPB7Jd9/v2hcH+R/gGBrPzSSkCXXt1n97Z5q4+tHorLGWCAJvEG9NxCdO8we
         uvI3POV4DDGpHkNM1Fk+LiAiIh5GTc78XpiD0h2Gux1jHC/oIxf0Y8hsRR76aNLKgNfU
         YSRTIhyRfg/jeROS7kWvfn7kXVHfmbs5yY2POhy/Qd/QW7gq+daGRS2OsMRcJmey8hJE
         AEImZxhq5gLKFoId6lAQw3XfTJ7M9iMELP1gg7dSPKiRIbzeRQOngIUyxQ/ewtV/PJUv
         Ah6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778324474; x=1778929274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iIt0P0A7yVCeb9NAEa3+HLFnhyLLlsPvHqZAy7iz+x8=;
        b=sSbZDP47VJLoK8pfqrykyk6XgAY9HXgqDYydDxPYGKl1bFKayPFxtICzC8ye4yEK8d
         D3/WsQxKWVUVk8pNOL7GDet0CmwD2v+46+wahmLX7G7Zuf20fGvPOpba/CYuVnryZGCv
         ddbAhJBloRBM2Sa5wmFVL+kqQkEeqdOrxDnQjaiAbI6EHN9pZxFCWK5bQLwYMk9PWPaV
         pjVhgumy5kNeQbHNOcLrLS3kJu/A+Wzgk/o7BnL3mNfoBlaVW8SGnH7s2IFX2epVvW+3
         xb+daaYdPgstGq6SV9W/yoQ1eBdWmopTvT7DhGoCpmpTsDOIlK8+OUNXPPMTlrT97p12
         /Nrg==
X-Forwarded-Encrypted: i=1; AFNElJ+9G8cJPCaIOcO9Fb34bYJBnPizQ2QJWN9daH2bMn3/kgu83M/OD4MN/UjVnVeQsiQw1rqNTaI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3KWCtCQpuYmWDYPsTSKtPzw8eirQUzuQy1vUt4pNUcr6igPjh
	5f+jMm94VbQVtL7Htr8/aeiK3LiJn/lqUiBRYfdYVxZU+FI8M+5pn2F6u6UaEutBclOiNB32hUT
	i2HLzcQzKZMyscw8liRR5jtJFK/LnFy0=
X-Gm-Gg: Acq92OGE8ZlHG324UHfse9aKa4z/pBmihhmhRmWv+/kBzBu/+N29Z4QfT9ZRCs1qJZX
	Nh1IbcD1yusF42mDtPu3Dw5e2JJmZbWHcylPmFWtTEzEulf0MC4k/p067UuIJ3vh2fyXYWvfiew
	b/pn28jEy7k6xIuYb6SKGCAXrNzIK2E1ZFvrOBaWWhIlaN4U9N48FkAkTe4lJyllce5wV6RINnI
	0ZZmhPmphPcmcNKevlN2/MXodkIcaAM7MAzm9tQRfhxKGjyEIDyxabxfwxK1PhCQZKqvbKvhcDf
	pPmMfNE=
X-Received: by 2002:a05:690c:e3ed:b0:7bd:6a98:58e4 with SMTP id
 00721157ae682-7c104bb091emr20425757b3.27.1778324474394; Sat, 09 May 2026
 04:01:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Nicol=C3=B2_Coccia?= <n.coccia96@gmail.com>
Date: Sat, 9 May 2026 07:01:02 -0400
X-Gm-Features: AVHnY4JmYlXDKdj4Xp-aA7FtSfefy9b28FYyhJ4KqsK6_4gIiVDKucQbACylHK8
Message-ID: <CALSA8UZaE8FR2K-60fPYE6uSUvUNuLnH=8pPq0Hak2ADQpp1Qw@mail.gmail.com>
Subject: [PATCH net] net/smc: fix sleep-inside-lock in __smc_setsockopt()
 causing local DoS
To: alibuda@linux.alibaba.com, dust.li@linux.alibaba.com, 
	sidraya@linux.ibm.com, Wenjia Zhang <wenjia@linux.ibm.com>
Cc: Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>, 
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, mjambigi@linux.ibm.com, 
	=?UTF-8?Q?Nicol=C3=B2_Coccia?= <nicolo.coccia@leonardo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

A logic flaw in __smc_setsockopt() allows a local unprivileged user to
cause a Denial of Service (DoS) by holding the socket lock indefinitely.

The function __smc_setsockopt() calls copy_from_sockptr() while holding
lock_sock(sk). By passing a userfaultfd-monitored memory page (or
FUSE-backed memory on systems where unprivileged userfaultfd is disabled)
as the optval, an attacker can halt execution during the copy operation,
keeping the lock held.

Combined with asynchronous tear-down operations like shutdown(), this
exhausts the kernel wq (kworkers) and triggers the hung task watchdog.

[  240.123456] INFO: task kworker/u8:2 blocked for more than 120 seconds.
[  240.123489] Call Trace:
[  240.123501]  smc_shutdown+...
[  240.123512]  lock_sock_nested+...

This patch moves the user-space copy outside the lock_sock() critical
section to prevent the issue.

Fixes: a6a6fe27bab4 ("net/smc: Dynamic control handshake limitation by
socket options")
Signed-off-by: Nicol=C3=B2 Coccia <n.coccia96@gmail.com>
---
v1 -> v2:
 - Rebased against netdev/net tree
 - Added Fixes tag

 net/smc/af_smc.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 185dbed7de5d..da28652f6810 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -3054,18 +3054,17 @@ static int __smc_setsockopt(struct socket
*sock, int level, int optname,

     smc =3D smc_sk(sk);

+    /* pre-fetch user data outside the lock */
+    if (optname =3D=3D SMC_LIMIT_HS) {
+        if (optlen < sizeof(int))
+            return -EINVAL;
+        if (copy_from_sockptr(&val, optval, sizeof(int)))
+            return -EFAULT;
+    }
+
     lock_sock(sk);
     switch (optname) {
     case SMC_LIMIT_HS:
-        if (optlen < sizeof(int)) {
-            rc =3D -EINVAL;
-            break;
-        }
-        if (copy_from_sockptr(&val, optval, sizeof(int))) {
-            rc =3D -EFAULT;
-            break;
-        }
-
         smc->limit_smc_hs =3D !!val;
         rc =3D 0;
         break;
--=20
2.51.0
