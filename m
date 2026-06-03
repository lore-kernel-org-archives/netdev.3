Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296334DD6CE
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 23:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780531196; cv=none; b=cQhBvXMKMZAxpcLyqqvST92YNTacxyAjJRgvaZOh7a7mBMfNtd3Ce4ofRgK6wCGjPzsDRIEha49tBT3quGa/HRgGIqRZYcCbhqPZE7ANrC6qjvJEpYiGg1S2TWh92/UqG4T6TZgeBAF+ueiZqv6TiqoLoWaZmUVnoC2FiXYUkkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780531196; c=relaxed/simple;
	bh=Q6yivGGVJOW60EZcnf6PAP7uUyP30l6Z4AZyymAy4VU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c8dcgxdMCBfFpn1vZh6YLw8QVbuPsDEvi5fWHdNuhahxn059p5AzXcRsiE+gwfJTicopf9sEI7wH/kdD48EaBtqseBLKhTfns6OvKUsVawe3+ucAZmJ+BZFAdNMN2AEa3DtFmLhUX6lCFHPa5OY4o1qG1ejQ7s31SB0+SDradak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j2XlGRv0; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2XlGRv0"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-66050f7af22so25753d50.0
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 16:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780531194; x=1781135994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lPcUswk5Zk6wNLB0Hr4KXSt6/tk8QkDBjbN8eLXHrp8=;
        b=j2XlGRv0LwKhsPyAjLrRv48VdYb/Zo0ObtWh7AR9pTFxDahCmiS5+E0NvZBgkoLVBu
         SJsYq4tVnsE3kjrcZ1OCSLTq/h4xCc1D57YjTcMvWmUt5hzqbCJ6GLxlHDcwQxJcSSB+
         UPyRZuEdUOSafmabLcGEd9XEIcBNvMPQwicCgXyOUxOQmOn8BLQB/t7N6Vg0xN9+ifdS
         oSm7GimJdxIP0aQExP2IDJcHzYYmldD2ay16zGMC91tTTtIlmvlL1zJHANLRdS9rj28w
         81l5E4bnY21pMK28Sw6lBtmYxDnFAk+Sel0W2w1oGLyU4VO2whND1RFX3/TFHkAhIWCo
         iqNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780531194; x=1781135994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lPcUswk5Zk6wNLB0Hr4KXSt6/tk8QkDBjbN8eLXHrp8=;
        b=lSoGfF58ZpHrpXVRrRbDAhwP6ZpNkUJvD7CFUnk5TTwXsgeYuuOMFHVz7D48NrVMYt
         wNp/TJWGeKxp90sZjYufk0RZ4oFgrWDeiaLl8zom9NOOKjXqEeoIlgCwgE7NdVwlC6It
         vq590CFJnACGLruZf6rT/crdb65qVZlVKgMjQAeY1T0ltVY7bvXf/VtYEk1wIx1Owd6Z
         ODSmk/r0V/rf+Sn+4xjLf1OZWiYPoPWks6yHvgqPR5YEKu8h7QSiO29WE1/+3WEZVkT3
         Ung4TQOoR0UW5zRdiV3C7JREfTV0nUue5WHvNcO7DCghgxsUleGjGlBqbUByrQpFribU
         LAeQ==
X-Gm-Message-State: AOJu0YxJnCO7LhPKFCAaAxu43CiLCorvAjN3wQwi7713KU07W4BFZlSa
	6x6qqikaZFjodi0T/B44cXIBAxx3TDsFM/yxij3kFpQFPQOBe2l0vfhx6H9Vew==
X-Gm-Gg: Acq92OETqEQdwlVoM+MD1g6kna3L39+EhCyIO2jbahPQRvKr2eqib/9+QUEE4EGyNXX
	YqITElZ3DtXtqiGFaf51pQ9r0qD6k+sn1wEEHCE/i14JQUvBx/G22b9yc8CwIWfny5pyj004J0p
	0Rnknfpv0WtlwDrno+E8JcwgMFmzkIEhx/bmXA/XB63xonSVyVxcetQP/N5HqNvNGhnnDqvbVSG
	dcnjSBkIqp7j+b/UhtMgsl6lpYEjdktyOt/4fCMZ8DMZhoZWai2BNCfREeA/fMTYrjXG7PWND8D
	RY+eApH+VxRr0VAnp8PbhMfA71sm9tfxzxOU4dzDzcyudSddMl2A9jKIdOQcxqHoSZ42d0yiBKl
	At+/nAZKO6Fp+aTbPnqxgY9xvLkh/QZLQasNPl871m1rnADvOZzOtjEBM50pn5EjaaLKBZQ3TEv
	PeORse/5mnufvp5+n0owXWbvIrgmdPPmTCMBs=
X-Received: by 2002:a05:690c:6612:b0:7b4:ce18:1079 with SMTP id 00721157ae682-7ebd3266aacmr3410887b3.0.1780531194156;
        Wed, 03 Jun 2026 16:59:54 -0700 (PDT)
Received: from localhost ([2a03:2880:21ff:70::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7ea20ea816dsm25623067b3.7.2026.06.03.16.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 16:59:53 -0700 (PDT)
From: Wei Wang <weibunny.kernel@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Wei <dw@davidwei.uk>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Wei Wang <weibunny@fb.com>
Subject: [PATCH v15 net-next 05/10] selftests/net: add _find_bpf_obj() to search hw/ for BPF objects
Date: Wed,  3 Jun 2026 16:59:34 -0700
Message-ID: <20260603235947.2986110-6-weibunny.kernel@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260603235947.2986110-1-weibunny.kernel@gmail.com>
References: <20260603235947.2986110-1-weibunny.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wei Wang <weibunny@fb.com>

Add _find_bpf_obj() helper to NetDrvContEnv that searches the test
directory first, then falls back to the hw/ subdirectory. This allows
tests outside drivers/net/hw/ (e.g. psp.py in drivers/net/) to find
BPF objects built in the hw/ directory.

Update _attach_bpf() and _attach_primary_rx_redirect_bpf() to use
_find_bpf_obj() for BPF object discovery.

Signed-off-by: Wei Wang <weibunny@fb.com>
---
 .../selftests/drivers/net/lib/py/env.py       | 21 +++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
index ef317aef3a0a..42c0cb777fb6 100644
--- a/tools/testing/selftests/drivers/net/lib/py/env.py
+++ b/tools/testing/selftests/drivers/net/lib/py/env.py
@@ -510,10 +510,19 @@ class NetDrvContEnv(NetDrvEpEnv):
                 return map_id
         raise Exception(f"Failed to find .bss map for prog {prog_id}")
 
+    def _find_bpf_obj(self, name):
+        bpf_obj = self.test_dir / name
+        if bpf_obj.exists():
+            return bpf_obj
+        bpf_obj = self.test_dir / "hw" / name
+        if bpf_obj.exists():
+            return bpf_obj
+        return None
+
     def _attach_bpf(self):
-        bpf_obj = self.test_dir / "nk_forward.bpf.o"
-        if not bpf_obj.exists():
-            raise KsftSkipEx("BPF prog not found")
+        bpf_obj = self._find_bpf_obj("nk_forward.bpf.o")
+        if not bpf_obj:
+            raise KsftSkipEx("BPF prog nk_forward.bpf.o not found")
 
         if self._tc_ensure_clsact():
             self._tc_clsact_added = True
@@ -533,9 +542,9 @@ class NetDrvContEnv(NetDrvEpEnv):
 
     def _attach_primary_rx_redirect_bpf(self):
         """Attach BPF redirect program on the primary netkit ingress."""
-        bpf_obj = self.test_dir / "nk_primary_rx_redirect.bpf.o"
-        if not bpf_obj.exists():
-            raise KsftSkipEx("Primary RX redirect BPF prog not found")
+        bpf_obj = self._find_bpf_obj("nk_primary_rx_redirect.bpf.o")
+        if not bpf_obj:
+            raise KsftSkipEx("nk_primary_rx_redirect.bpf.o not found")
 
         if self._tc_ensure_clsact(self._nk_host_ifname):
             self._primary_rx_redirect_clsact_added = True
-- 
2.52.0

