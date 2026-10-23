Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792757611;
	b=YtQBMrjm8AUSrPyeRlca+K2cR7uIM4UsQFX3SSn9GsqjQXmAn4a+JrskcTIBwZ5tyEyC
	 6BSe+zb5yY4dkHcw/139wrYP9KBkXGNGW2BUJWidETk/qvCzjbzm0Ei3euTMpkVzsAwyz
	 oeKkS8VPBsDOk9lmGG2B+9j+beZqjWtRSRK52QG0jna6ZOcedGL97OnMeFSXkq1AfapXz
	 0nEM+skkYhv/WWPysSBQou1nOcCmB9qm6Astf7+GiYpTO2QCeC4qVsAumAuTlwTdL5aFx
	 k55WrnTFFD8ouNVt9YYiOI47cL3yZGiPFTv1Lhx3MVK1G9NCbJYr7XEK08SKvx/zfnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792757611;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=wnqBY0Dj8JK3jWiYu+1DNG27SSaalJKsMIrKfhj2/yc=;
	b=xj+xEJa1f/MlwMPU3Y+AwzguBH+vikYrVy/D+cQXE4XmIFzKSBmRIfO271XDzm3Tgd2I
	 eCMVtm93hWvqKarEGVUYBGW5RAWiR4+VrAKjmYy9mpPaICvjpge1cHVCL3SOmoWFsvsPw
	 w/WhEIksdOihTirbk/rqoVfrWW92YsfaE1Pl1XRczBGsElgGIa1zZuQIOXVBrhivzj/Bh
	 VPSVCwhS3NOdBJMDptupeWv6rS4BwxdVune/EuT3nTKKoBx9tHw0ZmghXHfePp+ErnhMz
	 vEzb6XOmDUAbYC7rwBQ6b8xHWGfPI524gDA40TvC/6Etup76/MUwlwNh8ASawcsNe0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=epf6z63L;
	arc=none smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB298606A31A
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 12:13:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB298606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=epf6z63L
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c247f6687dcso115855766b.2
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 05:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792757609; x=1793362409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wnqBY0Dj8JK3jWiYu+1DNG27SSaalJKsMIrKfhj2/yc=;
        b=epf6z63LZOFhnDIZMiGczDNlhfkv5G8HO0VDaHdI6lgqu0iGL8To2rePaomA9GMle5
         wzNaW+M8CyFZcyoT6Q/QjzcjI0JNa67G81wSNWT6ktgT4Lq6PQk9TtwiGbeER0SLr+Kj
         EBipK2m32mZr7YLAa+rAyCE/DLDJXlqG1dhm3hZ4CZEKvz/D6b0U1he83xQdKtS5WkTH
         ZM6hanVsc3aZWAr5lRuhrjCWczNWBneQAyEgwZtU9Xr1JKjVA774OSU+vVwcPLyLb9/K
         UDHQnw+MawwlY3hOGugu1Mmg9jjqhf4IQIKkNOhEznqIH+4YX/whFVRXZmh8PwTcvnX1
         zjdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792757609; x=1793362409;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wnqBY0Dj8JK3jWiYu+1DNG27SSaalJKsMIrKfhj2/yc=;
        b=wTAkZ1sE1MBPbkDzisY7oLozlioa8GTGMuv5nUZG6peCNsE65sKnpc3/vzuk4Stb7B
         6wHYQJb/Se/vbvccdcGs9qLI8XMpPd5T9F+LtfCwjtAD+YbSRjkMhfvi4xsE4JUaoxHh
         OQHPDf0Vz6mmua7FGdaQA/7Lnf7E42l1VCyS2NFjjeSkFfiHX5Zm2/eCYBP4cgwPPyBc
         FZD2gswe3k1xFSby6P/4AW8DBt93+VAzW1gl//GLH7ckwfLfUuzWQsRuMlJkyyHwynmi
         p60Vk1yPp3QWmYRjBuQ0zFbSJYoV3iQvP3W4ZlmDmrD6MGtNc26jQPd9rxWjwyOD/xvr
         7IQw==
X-Gm-Message-State: AFq9FYK1dhaA42OLRFUj+aWvxIFojLT7UMCunGgaedcrfF2ZHLZyXJ59
	Zqgx456uuXVHi2D8N+QxtWLx1J020Orlmq1JbCttyqH1OiG1XGIfasAp/EyhYBcqkajwfQ==
X-Gm-Gg: AYBFou2G70YhnpZQJpS/q/aZO9TxBf4QMFG71SEOGrIEn36lsBkiPl2sLOyLD7jRBSg
	e6miapR7yKjo+IEmOkY4fWfzwLfssf+iam5ppWGMIfIJDDuTtA8fZqRCEAeU8VYt8xFMh5nstv+
	IMI/xWovoUbkqBWMLrTePmbeRk7c2UifSixArDFwp524cB83xLY2nLZCwcmrE2W2tIa6PlaRBXe
	tVY4pH7a1Bu90IlyM2nKfF5EBPTQP/N0RJ5D99oIFdo37gZsLqTtdSUknom/TEb3LzxT65efyub
	rJVjsKLMw6BFLZLNyk66pOMiZdtQDS0aUagqDa6EcCKUftzQ8JFvisb93NDL7qGPqPq50tg9TmF
	6YkPzcTioForTN/1NhxABAbnhJvnsYCeby4+mQwD4CCy+t2GKw+uQCeAnM5QSQ+cS8dexyQWlH3
	GxL8ng1eyXkBL8Uxp1FblKrfKYKLauDl5NQ9EeBrzVdG8D+0bYLkmZ+aR8Jtc7oFal8KL5uv9V1
	HxG++2usXh4bOmJUavTHXlwEAJwOiOpD+aSHY1FybBGs1YKq6z7P4focAJ41ot6QAPLKOE=
X-Received: by 2002:a17:906:f598:b0:c31:8441:35ff with SMTP id a640c23a62f3a-c46a90fa068mr313874366b.48.1792757608969;
        Fri, 23 Oct 2026 05:13:28 -0700 (PDT)
Received: from localhost ([2a03:2880:32ff:47::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46a5ceb7efsm94688866b.73.2026.10.23.05.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 05:13:28 -0700 (PDT)
From: Vlad Poenaru <vlad.wing@gmail.com>
To: netdev@vger.kernel.org
Cc: Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Jinqian Yang <yangjinqian1@huawei.com>,
	Andrew Preece <apreece@meta.com>,
	regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] bnxt_en: Don't keep MSI-X vectors added before FW reserves them
Date: Fri, 23 Oct 2026 05:13:21 -0700
Message-ID: <20261023121321.2127263-1-vlad.wing@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When dynamic MSI-X is supported, bnxt_check_rings() grows the MSI-X
vectors with bnxt_change_msix() once FW says the new rings would fit,
and keeps them.  FW only reserves the extra IRQs later, in
__bnxt_reserve_rings() on the following open.  The MSI-X table entries
beyond the function's reserved IRQs are not backed until then: the
MSI message written when the new vectors are activated is lost, and
the entries read back as zero.  After FW reserves them they are live
but still zero, so the NQ rings bound to them signal address 0 and
every completion on those rings is lost.  The next ring change (for
example ethtool -G) then times out freeing each of those rings and
the TX watchdog fires:

  bnxt_en 0002:01:00.0 eth0: Resp cmpl intr err msg: 0x51
  bnxt_en 0002:01:00.0 eth0: hwrm_ring_free type 1 failed. rc:fffffff0 err:0
  ...
  bnxt_en 0002:01:00.0 eth0: NETDEV WATCHDOG: CPU: 17: transmit queue 18 timed out 5716 ms

On x86 this is hidden: GENERIC_IRQ_RESERVATION_MODE makes the PCI MSI
domains MSI_FLAG_MUST_REACTIVATE, so the message is composed and
written again when the IRQ is requested, after FW has reserved the
vector.  Since commit 0d6a7c417983 ("irqchip/gic-v3-its: Enable
dynamic MSI-X allocation"), arm64 GICv3 systems take the dynamic path
as well, but write the message only once, at allocation.  On an
NVIDIA Grace system with a BCM57508, raising the channel count from
18 to 32 left MSI-X entries 18-31 all zero, and the 14 rings using
them lost their interrupts.

Keep the allocation in bnxt_check_rings() as a check that enough
vectors are available, but free the new vectors again right away when
FW manages IRQ reservations (BNXT_NEW_RM).  bnxt_reserve_rings() then
allocates them on the following open, after __bnxt_reserve_rings() has
reserved them.  Without BNXT_NEW_RM there is no IRQ reservation and
bnxt_reserve_rings() does not grow the vectors, so keep the current
behaviour there.

Fixes: 2d51eb0bd81c ("bnxt_en: Add MSIX check in bnxt_check_rings()")
Reported-by: Andrew Preece <apreece@meta.com>
Closes: https://lore.kernel.org/all/20261022193620.2152038-1-vlad.wing@gmail.com/
Signed-off-by: Vlad Poenaru <vlad.wing@gmail.com>
---
Tested on an NVIDIA Grace system (GICv3 ITS, ACPI) with a BCM57508,
FW 230.0.165.3: the boot-time channel change (18 -> 32) followed by a
ring resize no longer loses completions.  With instrumentation, MSI-X
entries 18-31 read back as all zero after bnxt_check_rings() allocated
them, and read back correctly once bnxt_reserve_rings() allocated them
after the FW reservation.

This conflicts trivially with "bnxt_en: Clear bp->total_irqs when
disabling IRQs" from the "bnxt_en: Ring accounting fixes" series on
net-next, which adds a bp->irq_tbl check to the same condition.

 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 0682060b048ce..2d14d991a3ead 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -15093,6 +15093,7 @@ int bnxt_check_rings(struct bnxt *bp, int tx, int rx, bool sh, int tcs,
 			hwr.cp = min_t(int, hwr.cp, bnxt_get_max_func_irqs(bp));
 		}
 		if (hwr.cp > bp->total_irqs) {
+			int old_total = bp->total_irqs;
 			int total_msix = bnxt_change_msix(bp, hwr.cp);
 
 			if (total_msix < hwr.cp) {
@@ -15100,6 +15101,17 @@ int bnxt_check_rings(struct bnxt *bp, int tx, int rx, bool sh, int tcs,
 					    hwr.cp, total_msix);
 				rc = -ENOSPC;
 			}
+			/* FW has not reserved the new vectors yet, and writes to
+			 * MSI-X table entries beyond the reserved IRQs don't
+			 * stick (seen on BCM57508).  Free them again;
+			 * bnxt_reserve_rings() allocates them after
+			 * __bnxt_reserve_rings().  Without the new resource
+			 * manager there is no IRQ reservation and
+			 * bnxt_reserve_rings() does not grow the vectors, so
+			 * keep them.
+			 */
+			if (BNXT_NEW_RM(bp))
+				bnxt_change_msix(bp, old_total);
 		}
 	}
 	return rc;
