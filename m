Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20933364EB8
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 17:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788887976; cv=none; b=fDJdg0P8nW0G3buq/RtxNKmdpTo+3Oh8tTt7n3k71gEA/whwSHziQWKEMZPxF9pR2Yod19Vp/NqgEOgNZq0K4+G9PRGA+hCvkZsYw71JPk1KX9PQzcEYAVn/7oKy/qscDM5xfI+D29HQZggEcCRzc/nLYwmUZgc4I28Ri9k2vYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788887976; c=relaxed/simple;
	bh=f9Z1FJijA8EzJ5galWwOtkmdX0E+PiuwhQ6tFxw2D+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xk+DZe8fFP6R83VjxpgJeOA4cum02UAtDiUsQn2TazeGXdHwJ9gNsbk4t0450EuPfFLdSbg5VZRRxLt0pogJV+vTMKuE4fCGczqPC5VRDLz+Qyoc2ajx/26OAD+GWB1RjnivUoH7oSrM/UgLSmD5m5Cs3mpfH4RM6EXVTjVVQCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MSFlzCPR; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MSFlzCPR"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5303932c4f3so22854721cf.2
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 10:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788887974; x=1789492774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NMrY744BXEZak8MUHT+RAZHl/UnRJ0zoUGP6YjdmxXw=;
        b=MSFlzCPRb+TdOvM2TrrY3PWwviJkVn3v0fea5QgBiFC3sxHqw+QR7rSF0nMKmyh7ot
         U3jjKGrMb2fAhYkOLonFAFEhfE7ULzoNGT6uIl/sQwqlmokg0Wn/dQonjHtsM+mgwApE
         kHJQiI7timQLwYZu3wJhF0Au2yvSVvwb3O9dOSv9ZzIZlrWBUxEGnA7fLRZh4bHGKmPY
         wbAawAdc0g/2HTEJ/IPVn1Il3rg33OlcFnNqF2RhAKJeADOKVB8X1R7crtg4wHL4NHPC
         aWt0gPHSPiF4bF1YUN+CWegavGAHediUQMz+nwc0z5LB5cIpyeTyStstDTJv02EVrbQ0
         P62Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788887974; x=1789492774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NMrY744BXEZak8MUHT+RAZHl/UnRJ0zoUGP6YjdmxXw=;
        b=F5f47Gv67+qEi0HSH3pZtUn+8uXvkFtzOPfMzE0OKgLbMJE9CwcW9hbMk3Rf15GbDq
         eYjdhD23T7oBBzSIbrK30qeHH2XQdiP5iEgst9U6WvXfqLDgMtIqLFo1KANqNPHAYgLj
         wg5Pwla2IwFmHSlBdSCz/WqiX583dCkPf+9T5VazWcZffMDai4/dRDSb9sG2w2rBBgOs
         V3eoPa908CViA3suPZQrtZ2NmuwyQCP0ewO57PR4qhiUHSQWbcI6f2uVB3plUJ3+SGaL
         Bx2tOy9fGZ99jaDePZrEq2ry43z5k5WMPXAcTLUHW4U4NVhNzX1w9U0M2xIZ9DLd6iTc
         PRJA==
X-Gm-Message-State: AFuF++kwNT0zBByioait4hC11OLxdz4VI7Popjn9rmHyIacJQfgAp7/d
	FM/XWBcVzeZjyGWT/K7TFg9fGm1fk0pvd+/4Fx8m0Am/r1y4JSHWJyrr4S/tVFZR
X-Gm-Gg: AYBFou3CC9aoYkJlcxZyB2hdfebFj/cxOcY2W1fGeGH2fQc5kzuD16SrCpqNT5E7iyv
	lbqIifbZeRSjN3QvHbswHJsYCJPPaVJEon8AqHm57hjiY2KUSh3e2aZSANniwIpT4/IdIvMqkK/
	qYpdsflyQNJoKUJ4lAoqEOHN5pcPyf1A3L+CWrLasDKxEnQ7K/CZsnW6xz1d3u5umbZpyF6oW05
	8mlebfoDm+4MFoQ/Sr/l+n7cmmm8f+KAicttbvdDlqiZAS/G+BKYFtok9EcvVyQmu1M1SQ397Ba
	qDZmr2nzc4JMfX8KxhSvsjPFR1dz71OpFQy06Ojx+Iu4/PgptOhsq8dm4UFRlrjdWo1Dt2emucl
	0Yf2jsFcTpolRSdVfoIVBs0EZt2J+XktbeNqqnxnD5najHrInnVawEi7glmJSqXxn51MCVD1v2V
	s2LjtxMhwwARsNMbOaFDTFsrr1qVP6HMv4LaaVbJJz4khyNPctpuuKtVU=
X-Received: by 2002:ac8:5ccb:0:b0:528:38b1:b54c with SMTP id d75a77b69052e-530547d39bbmr379290841cf.2.1788887973659;
        Tue, 08 Sep 2026 10:19:33 -0700 (PDT)
Received: from houminxi ([104.167.197.198])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530541c94ddsm120081361cf.23.2026.09.08.10.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 10:19:33 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: aconole@redhat.com,
	echaudro@redhat.com,
	i.maximets@ovn.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	dev@openvswitch.org,
	linux-kselftest@vger.kernel.org,
	Minxi Hou <houminxi@gmail.com>
Subject: [PATCH net-next v3 4/4] selftests: openvswitch: suppress pylint complexity warnings
Date: Tue,  8 Sep 2026 13:18:59 -0400
Message-ID: <20260908171859.1967327-5-houminxi@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260908171859.1967327-1-houminxi@gmail.com>
References: <20260908171859.1967327-1-houminxi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The module-level disables cover complexity and structural warnings
that match how the tool is written (large netlink message classes
with long attribute tables) and are not worth restructuring a
selftest helper for.

Signed-off-by: Minxi Hou <houminxi@gmail.com>
---
 tools/testing/selftests/net/openvswitch/ovs-dpctl.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
index dc88cb1b20c13..7ea0d52044011 100644
--- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
+++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
@@ -1,6 +1,14 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0
 """OVS datapath control utility for kernel selftests."""
+# pylint: disable=invalid-name,too-many-lines
+# pylint: disable=too-many-ancestors,too-many-arguments
+# pylint: disable=too-many-positional-arguments,too-many-branches
+# pylint: disable=too-many-locals,too-many-statements
+# pylint: disable=too-many-return-statements,too-many-nested-blocks
+# pylint: disable=unused-argument,broad-exception-caught
+# pylint: disable=no-member,not-callable
+# pylint: disable=non-parent-init-called,super-init-not-called
 
 # Controls the openvswitch module.  Part of the kselftest suite, but
 # can be used for some diagnostic purpose as well.
-- 
2.55.0

