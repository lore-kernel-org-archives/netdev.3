Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB177448BB5
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 06:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789627668; cv=none; b=UDedXuDgYZkYMcuSLIZ7vKQcDRBRwIF7ZY2aKdjQ/hDez85QIoF26dHRxG6FBggAikzgWO2DbGcdYWnF1Gjxjubji1nMUVN3PQ0jNOKFuFZMRLygZ8vgmQ55Jc9utTxqIxSfoWDDo6+FZHlZMwAJQs0dQzRdt2KYNrjSPmibYuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789627668; c=relaxed/simple;
	bh=3AdI/BQYPg6y23Mk+YkLKGWL7iI3glitB+qiS7zTldk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZPtlJy2L/N4+5EMq+R33//zWgsADdqVSARIOCeuUOB+9heVVfxWuwknmHA9i3NQKiUh3teeCLxNBd0awvw9vMf+4q8FBFv1J4SWEcaNT/nysVzTN9pitCiFLtR2ikr0dn8ubv/vM/CbNeQzYtREh4F3OMexQ5qa+6JJajxHNeTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OTD4+RoM; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OTD4+RoM"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b965f447cso3711325e9.3
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 23:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789627664; x=1790232464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=y3wbvAbBWnutdIwHnF3F6m/7uEF6jqU2B+avYv0omNg=;
        b=OTD4+RoM5uTERP3mOlPQntz1c/c6k9oR7kAwKmVnnSEeUVZh0AXJ7rR2JE3mw7v5Ts
         JksLeD1O37XZWAITYjFxSdcfSWknGG9MV2xnWMsdtDg/P4fwM6adS/y5LETFkn31gLAc
         kFGkB8OpXiTo70mDlI+DWVUAeshK5lUC9zIrjHszqLM+HL7ogoFk2fjqpKsdAMDBClKu
         ThjsBWFcpI4P4RwdfE1NxpRJG1nnA88KCIdoz3HXf+6zktfMyQbnZPiaoePBk2M3tDkg
         wCKaFdZmpIEwtn48SLfezt30nJQIE/l3/ETu9I+IslMkRl8+2g17ZhgRBWRNTAFwAe4x
         tWAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789627664; x=1790232464;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y3wbvAbBWnutdIwHnF3F6m/7uEF6jqU2B+avYv0omNg=;
        b=en4v4UibwYstmi2k7GaexITeunCvOc+/CnF19KY2vWvCPFJHzSv6fSImJq6eYMjNgg
         qz8HVq0ar4fIjDqabWQX3Eyyp+dIwoJSo6XquUToXkbUibhyYZF5nlmcqe7EFzoR9rnJ
         q2PFP5SLGvdAb4UO7H0e2XB9j/FQ1VxXJUIsoVD7bheLemLTXE1vfnWNqZ+eRtNfx3HY
         5NWGw3JvWVzJqa385B+6Gec0AMmOUjO7RcfK6KpSSR5X0Qfb9m8joXKrL6mrT0ZA7hbD
         zc2oh/ej3n9xUNLUV/VHu556glmyBHVIxbXzJJbQI9Fu3BDVMMiV7YS2mzQFT7gvtf4t
         INkQ==
X-Forwarded-Encrypted: i=1; AKwUvBz1K9p5KOKzILStPc7211CB5kl2bPdahlt7U7mwm3xY03saIUktmWEIkvtFi3qj+5fgCfe+9qI=@vger.kernel.org
X-Gm-Message-State: AFuF++lZRvib90nGZoYY5QSpzN+3OB3D82QR1pBfCIcB50Pj0q/1zsCR
	2G3e5WwXzmKE5XR3irf8t5O+tkpc4A9LgRpK/mHLKfhmW0p4DW1JcGeH
X-Gm-Gg: AYBFou06jxAmjeBM1lWcPhvNXT6Wm8xOPtNGSw1DmBaGhqOhcCJ6SSOM/LQzZ3Wry+N
	G6HMmhEGWYDlL9vTQEbX7UuPzlEPhOi78rmFKKwisSn+JTgrk4YRdPen3ykXMiK8AcKHtXvDxy7
	Z9fFd1i2arrXW364AI5fZGqnBg2Zp7/ZPsWffPUMchiigccAS86LJ//u7XvnZvlCbRLTBgUcF5R
	UJirNbdOKV77bS4blsgFncACv5GHXzVrzOPdGfwVJNw4P5/8PhaR2CObNk8ZKSkhELVoQFVUFt5
	zx++Tg0yS+ZxEkieqqb1/9xHjoRFYYfBJ2yX/b0pzwv19Miz5J7faBjMxjszqRXc1XosVnxcxEY
	pfHRMR5SJppO6iHtzn82ZknpHibewK9wOdPuwvUU9hWd6/UTXoEoX6XXEWprj0IFHbKksOyjFuS
	lXPjET/cV8oCBz0aVN97Ltk3/HqRb8pLO+v0Ffb5HvB23ceAozCrwqn5/JbgGwP2vTAFeb8G+CQ
	Y2REA1Wtw9s6WwQSvxerXf8sWv8OnNjDI0ECpGWfkRfK0zRy2RSWES67AsAx5LwdwVGUmInDAKv
	lrHOnBKoSYg0bIe818STkkp1zuRtxRZbLo5Mp59B/8v7DrSTyhhyieyWWnAakd7cWZUT69ef8Gg
	A
X-Received: by 2002:a05:600c:8b17:b0:49c:fa20:cc0a with SMTP id 5b1f17b1804b1-49eb7339522mr57916485e9.33.1789627663778;
        Wed, 16 Sep 2026 23:47:43 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-9dc6-c001-54ee-4741-4927-0a28.310.pool.telefonica.de. [2a02:3100:9dc6:c001:54ee:4741:4927:a28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf438fbsm13129266f8f.36.2026.09.16.23.47.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 16 Sep 2026 23:47:43 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	UNGLinuxDriver@microchip.com
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <david@davidgow.net>,
	Rae Moar <raemoar63@gmail.com>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: microchip: vcap: Stop selecting DEBUG_FS for KUnit tests
Date: Thu, 17 Sep 2026 08:47:36 +0200
Message-Id: <20260917064736.77354-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

VCAP_KUNIT_TEST enables DEBUG_FS even when the kernel configuration
leaves it disabled. Remove the selection, following the dependency rule
in Documentation/dev-tools/kunit/style.rst.

The debugfs implementation and its tests are already built only with
DEBUG_FS. The other VCAP tests can run without it.

Fixes: 552b7d131aa0 ("net: microchip: sparx5: Add VCAP debugfs KUNIT test")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Validation on net c9151088f167: x86_64 LLVM builds and QEMU runs
with DEBUG_FS disabled and enabled. The other VCAP suites pass in both
configurations. The debugfs suite is present only with DEBUG_FS=y and
all four cases pass.

 drivers/net/ethernet/microchip/vcap/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/vcap/Kconfig b/drivers/net/ethernet/microchip/vcap/Kconfig
index 97f43fd4473f..1af30a358a15 100644
--- a/drivers/net/ethernet/microchip/vcap/Kconfig
+++ b/drivers/net/ethernet/microchip/vcap/Kconfig
@@ -40,7 +40,6 @@ config VCAP_KUNIT_TEST
 	bool "KUnit test for VCAP library" if !KUNIT_ALL_TESTS
 	depends on KUNIT
 	depends on KUNIT=y && VCAP=y && y
-	select DEBUG_FS
 	default KUNIT_ALL_TESTS
 	help
 	  This builds unit tests for the VCAP library.

base-commit: c9151088f1674fd29ff26a20f5fc687acf53a2f0
