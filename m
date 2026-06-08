Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E35F343894
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 23:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780961492; cv=none; b=EfX4EXw+qIlv+/5Lsmxbn0c3Jwk8JwoiUQ0ruDFjYihmZDmMdhdA542Btb47qgifHGjG2xWDr1bZDPZPJJq54ZgfHS3hdWZbn74ypcDBAwwq9Zn/RTzp379bteopCSElvjTfOK7C2DEEwgblAjCfmHCuX030HN93oKoZAclGjhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780961492; c=relaxed/simple;
	bh=n8jvIh8rSy5l4r1sikRBZ0KKujywm2brYKxHwyQnGmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pKWihI19x4ukQV2U9qDnbtvHlcig1SZuO2kcN5J4dUH5TKqDMupYG9pa84B6+lqspZVT/UG1a2EgyWUIP6KJUgXfF+aerLYgvpX1d/yAXsjqZC9euxQDt2B8RCmUEjIRs0BL7pWjftVLNXeme5NXI5o6iWWxwbUqnL7ybgoKplk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UM/aI7wv; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UM/aI7wv"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7e2f9471acbso5639587b3.1
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 16:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780961488; x=1781566288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K41qv9ZHZPYFOsHREWMOzv3cTvIXZflhgrFt4tffsU8=;
        b=UM/aI7wvjxMUtWp4LkcROSG6kYvwo+VbBZg/5tO0xazDTCxZk43XNYC6fB1IHJM7uX
         us20mh170RNGTmygkPe6M3gse/Vv/kv3gKZYqv7y4RGau6nLw8lOd8G3hOy/z+3nlxtD
         wL8TPEWlb2VCwD0EOmFZeC0kgwEOyFno+eMaFOmYcqyldYKpHwM47APWyLyBG+gN/YN9
         9DaxiI9ocChS5JYumg+UpikW4x3x5rGcgzamkSViOqpnGD6+ExDxyNgdOGH+gvlCBEqG
         TL6UvESDxLCr/cMkzZo0XgIaOKyqeUMIc6/RUo8871oln5EHmamKFSVT2smI8XFVIskO
         ECeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780961488; x=1781566288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K41qv9ZHZPYFOsHREWMOzv3cTvIXZflhgrFt4tffsU8=;
        b=eG7e+gVajPGRwRpVRPPaGzY2WKZ1lHgf5w01ZUbYwEgVQN+KlIf0ose9PxHvpIsSSG
         GA8k+tb/JcBbkX5hNTAeek0TfEoAhG68CWgldJm34zDFIGrIgXnbiVtDTEUEzprabB8F
         m8tnIikONSGK//cZToWtyMkIDpDFHxUWgCLpxv/0K3RpPIeKwJQ04IMc61tWTfBlgMEc
         sJK2IwKNwvfYQRUSwl6TkSBjyyBmsoVectyTx9hElC+7Hubi9YKZ4QdmCoKx6sQW6FDf
         8ZI6XGtZ9V0nFRN0BFx4mLHpCwHrT9BcNUhJZX8s+deOKyWadBYY3eZFzIReGhi+7DS4
         VZnQ==
X-Gm-Message-State: AOJu0YxqAYMf9WbRBmJoK8Mxu9ExjOUUnm2acE0GRjuQoLLVWGT1mx3/
	jkIyxY1HQV6gtar98fLVE8pCq0DjcRjRSnEHViXVd1daatCrlREuISbctRgfzA==
X-Gm-Gg: Acq92OG770TXRKm6OD9kkVa/WVCwZxEKQ62HWlKQZwhcCVUJRo6xuKPCLBHLrFzO1wS
	xsFNi7SsbF5zm9nRLIWX55p43SFepfpzKRQJw8izzLzZpKYOIfIWnvr9bY+NJEiDowUY2E7pF0J
	BeiyfC5nduC0p4sJNhv/8cFVZ9MtgUFsmNZADtfkppWXf378FeV/ogU7QJ1yOnv4lgTpeDVjpx8
	jSYr7X/8NqPvIjea9W261CyMO8tqo77n8I6ZWKMi5DupaTNNR0/7Yy+5qS/ql9+h9RNJD81h7Qg
	iE/ZtK1tpp061FC7NzKcw5PtD9A+R4vLETu3LK6wAlVxoII3ZZJi4d9Cb0ltxnuD7lYjaWsBSnp
	pSF22df2Ky3oEOB7uae7AHTodR+Rsvw7Ho6Kss2l+Gt8PboHymxvmzJ8OhOy1ta42+H8X63nFjM
	H4E2L+52SbRptuz8IX1HTDOjqbZejHYIDY6ek=
X-Received: by 2002:a05:690c:c510:b0:79c:adbd:4f15 with SMTP id 00721157ae682-7ed0acc4870mr100136117b3.2.1780961487571;
        Mon, 08 Jun 2026 16:31:27 -0700 (PDT)
Received: from localhost ([2a03:2880:21ff:70::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7ea20fa250dsm89644677b3.5.2026.06.08.16.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 16:31:27 -0700 (PDT)
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
Subject: [PATCH v16 net-next 08/10] selftests/net: psp: add dev-assoc data path test
Date: Mon,  8 Jun 2026 16:31:16 -0700
Message-ID: <20260608233118.2694144-9-weibunny.kernel@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260608233118.2694144-1-weibunny.kernel@gmail.com>
References: <20260608233118.2694144-1-weibunny.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wei Wang <weibunny@fb.com>

Add _assoc_check_list() test that associates nk_guest with the PSP
device and verifies the assoc-list is correctly populated.

Add _data_basic_send_netkit_psp_assoc() which tests PSP data send
through a netkit interface associated with a PSP device. The test
associates nk_guest with the PSP device, then sends PSP-encrypted
traffic from the guest namespace.

Signed-off-by: Wei Wang <weibunny@fb.com>
---
 tools/testing/selftests/drivers/net/psp.py | 72 ++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/psp.py b/tools/testing/selftests/drivers/net/psp.py
index 015af92c8d7b..f07d0becfede 100755
--- a/tools/testing/selftests/drivers/net/psp.py
+++ b/tools/testing/selftests/drivers/net/psp.py
@@ -19,6 +19,7 @@ from lib.py import ksft_variants, KsftNamedVariant
 from lib.py import KsftSkipEx
 from lib.py import NetDrvEpEnv, NetDrvContEnv
 from lib.py import NlError, PSPFamily
+from lib.py import NetNSEnter
 from lib.py import bkg, rand_port, wait_port_listen
 from lib.py import ip
 
@@ -602,6 +603,71 @@ def data_mss_adjust(cfg, ipver):
     _data_mss_adjust(cfg, ipver)
 
 
+def _check_assoc_list(cfg, psp_dev_id, ifindex, nsid=None):
+    """Verify assoc-list contains device with given ifindex, no duplicates."""
+    dev_info = cfg.pspnl.dev_get({'id': psp_dev_id})
+
+    ksft_true('assoc-list' in dev_info,
+              "No assoc-list in dev_get() response after association")
+    found = False
+    for assoc in dev_info['assoc-list']:
+        if assoc['ifindex'] != ifindex:
+            continue
+        if nsid is not None and assoc['nsid'] != nsid:
+            continue
+        ksft_eq(found, False, "Duplicate assoc entry found")
+        found = True
+    ksft_eq(found, True,
+            "Associated device not found in dev_get() response")
+
+
+def _data_basic_send_netkit_psp_assoc(cfg, version, ipver):
+    """
+    Test basic data send with netkit interface associated with PSP dev.
+    """
+    _assoc_nk_guest(cfg)
+
+    # Enter guest namespace (netns) to run PSP test
+    with NetNSEnter(cfg.netns.name):
+        cfg.pspnl = PSPFamily()
+
+        sock = _make_psp_conn(cfg, version, ipver)
+
+        rx_assoc = cfg.pspnl.rx_assoc({"version": version,
+                                       "dev-id": cfg.psp_dev_id,
+                                       "sock-fd": sock.fileno()})
+        rx_key = rx_assoc['rx-key']
+        tx_key = _spi_xchg(sock, rx_key)
+
+        cfg.pspnl.tx_assoc({"dev-id": cfg.psp_dev_id,
+                            "version": version,
+                            "tx-key": tx_key,
+                            "sock-fd": sock.fileno()})
+
+        data_len = _send_careful(cfg, sock, 100)
+        _check_data_rx(cfg, data_len)
+        _close_psp_conn(cfg, sock)
+
+
+def _assoc_check_list(cfg):
+    """Test that assoc-list is correctly populated after dev-assoc."""
+    _assoc_nk_guest(cfg)
+    _check_assoc_list(cfg, cfg.psp_dev_id, cfg.nk_guest_ifindex,
+                      cfg.psp_dev_peer_nsid)
+
+
+def _get_psp_ver_ip6_variants():
+    for ver in range(4):
+        yield KsftNamedVariant(f"v{ver}_ip6", ver, "6")
+
+
+@ksft_variants(_get_psp_ver_ip6_variants())
+def data_basic_send_netkit_psp_assoc(cfg, version, ipver):
+    """Test PSP data send via netkit with dev-assoc."""
+    cfg.require_ipver(ipver)
+    _data_basic_send_netkit_psp_assoc(cfg, version, ipver)
+
+
 def _try_disassoc(cfg, psp_dev_id, ifindex, nsid=None):
     """Best-effort disassociate, ignoring errors if already removed."""
     try:
@@ -713,6 +779,12 @@ def main() -> None:
 
                 cases = [data_basic_send, data_mss_adjust]
 
+                if has_cont:
+                    cases += [
+                        _assoc_check_list,
+                        data_basic_send_netkit_psp_assoc,
+                    ]
+
                 ksft_run(cases=cases, globs=globals(),
                          case_pfx={"dev_", "data_", "assoc_", "removal_"},
                          args=(cfg, ))
-- 
2.52.0

