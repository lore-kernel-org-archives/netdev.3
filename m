Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794118694;
	b=kQwdYwXGMexjymY4rZRa9n/WFKWKUz7Y61AAwXWtGEGxgs+wgs908U48WVVVYgFMbdFD
	 Qku0Z6doWB0b6doxT2OF5WAIXRQEU91Aoj0726EW0Ep7Iwtf98Di+/4mLVFuUPH/8e2Uz
	 6Ch0wwfV2V5PFPqkznDVbDNgElLnqbe0CnEq425NRww3muJyjDjHtwCYatURU1FBRffkD
	 L9n+v0c1Hf81VcZGCisJ1DquMMnrL4XTVFXE6pvkjW+nqHMMeriu+9Was4Gi68QItD6/4
	 nbHrXSA0AP6H2zfsgLG9E2elr2PUN2bSQL4BWs+gEG2wmsgo8aThyQIFiLFwH7Dar8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794118694;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Mcozko3cpjsd4Fb6V5y36/b9iev/kYzZlS9QuT6BrZc=;
	b=i+pQoRiFlpA8LRMw8ejueIDXsR6LL1JSwE3skV3JF5XURVqf7pqQUXk+yI79Ey6goIZS
	 RJPZncfbFAI8kZnq1HuneDxfvvtgwFAu51iwf2dD/nY3KOq3mqM8Trvaqkq0zEx2gfEZx
	 QXnlGBw3LdB07r1xHYQ0MDtyQwacJGKqWZO1nRUGVCoSdk3lv/bb8CRRsHE/PZByB4JTx
	 zWeu/LelMUv7lxbqPTeKFmEsx1N1rW3FVLlK+nIu8v02Xcx2PlYpZ6u7/7xMEEoZbB2q3
	 zI4eweWFbwBvX3xVsPBGdCsRmZqIM3gXLR9G1SuSWT7XPDhS9/KFrM+msqN5tdBnCiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=niXzWDD3;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC6B606A31A
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 06:18:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAC6B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=niXzWDD3
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1a2761c69fbso522080c88.0
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 22:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794118693; x=1794723493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Mcozko3cpjsd4Fb6V5y36/b9iev/kYzZlS9QuT6BrZc=;
        b=niXzWDD37PKYpBFRkqWDTihy/W3R4h/GAC8tTa1OPPMrT58BdfYps9O1lw+lAHqOOW
         ndCpG4Js/Bs2q3kPesofjxYM79x8xFHQgdWGulBqUJRg9JZqUpfrkf4szH63lo1U4Lnc
         qPj/Gr4IBJtkGxSKu5stljLMdTzWuy3s7UCKRE3a3S1vcPkGKG61I40ttKPH965/EFqU
         RdgudLmgUiBKFVcb8fEK+mUjHJFN1QZWfCE4plGPJ883+3NM+1cJ9Y9PDmWnGUXA/SPs
         zR0pwZXFDQyNFf2vxTX4WNjiDC5u+G9yoC4aqZA9koFuFGYbiRU/hzOZ4lcC8q8D/HPO
         G7lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794118693; x=1794723493;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mcozko3cpjsd4Fb6V5y36/b9iev/kYzZlS9QuT6BrZc=;
        b=UMmFethe1tcNYNZ69o/86pW1qCOBqzQGkmTtlY+iUGxr+6O+zqUmzs6SG9sM06+Ji8
         RhwacSzLFex7wl45BPXFIgkPtjvRJ8BRVMfoDpKTFycyYA90lfEQtPGNH/toJfkWGr4e
         DdFWrFHgBzskaV82wIvHEOeYkd961kIn8wd1ISDrVJkd5nj4s3m10lnFxIj6MKtJP+kY
         V8PDC8WQNdXCv7NQBElrJ0+d6sAUGkqu0yFgQXzRs4F/1EUDfK58KcLdW3FpDesTtQdD
         l2eZJBQMy4I3ErMPj7ITv9vuVg9rhcyewpv/tuCQGdiAYCiJh5ssu+OsBXtoHRanysiM
         IBiA==
X-Gm-Message-State: APuU4Z++wBHnhgrfLquMB2NQAnnOQlQO3RCntsPY0bwfVcRWyBX7n9MF
	YfeWz7AffjPRxrf/OWZn+UZ+LREEw53hdsDIyTw6vnqpFXW9nq5WCuS0J0ZWfsESM3s=
X-Gm-Gg: AYBFou2GoAfNZMSNYwvuPh6j1jzbK7X37QB27Fel9/IvT3L8h9QClFqpqfJyOwpMJQf
	UAl9NBvFwyitT8NsoyBb0V/hctwMVTxtAiF/IEyg8KayNnEdzFvG7xk5QWl98H+bRkeAM2zVc5J
	/u6ynNwH3EJfcBWIz3oxkC4N9PwnjHENdBr9s6uVpclHuDKnO3stGzRSmzGMb+34Yz3bNUuIlvy
	40+oFnggCOi5lwqDvCZnTwn2bQTsTpB9d6sYiPqE5vuMmfECE8SNg7XfOzlhoDB0czBygH/TAcw
	eMkMtB0wZUyfw38+wr5GCghU63k8cViA/lKZkfCO96pboMtKjrSOCXlF+xsdIRlyo7RSyBcWB2O
	B3Lrt+WBOAI47FAMjfwiwfRrsi9R/pVeFn7MlbSsEKZpVHcESFVnQwHsWpgVdAoF4CZcITWHP2L
	1iG/npsbATybbps3CSS3FkNEvH2S/hv4g2FJOIsttTxBDLxSflt09Zc+gkFDAmqqTJiuPEziYfR
	+25S/eyfD0DmBzLRl2l7MAXsqp3yTmjUfiwPkxJ2X1ae1StX8RVtLHw4BnPbQ26Z+RB+pXJrtLr
	nPEtXZz2LOOXH2Kf+42TVYcXO+px/6BbcyrFTysBeOdo9h8KuHF2LhNboBbZ6jqYi/c=
X-Received: by 2002:a05:701b:42c6:10b0:174:cf1b:235c with SMTP id a92af1059eb24-1b39fed16edmr1123611c88.43.1794118692861;
        Sat, 07 Nov 2026 22:18:12 -0800 (PST)
Received: from LAPTOP-KD1TH5BD.tail375eb4.ts.net ([47.11.96.146])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b37314626dsm4838725c88.1.2026.11.07.22.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 22:18:12 -0800 (PST)
From: Gopal Malaviya <gopalmalaviya53@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] docs: net: fix outdated default values of four sysctls
Date: Sun,  8 Nov 2026 06:17:46 +0000
Message-ID: <20261108061746.32090-1-gopalmalaviya53@gmail.com>
X-Mailer: git-send-email 2.43.0
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

The defaults documented in ip-sysctl.rst for four sysctls differ from
the values the kernel actually uses:

  sysctl                  documented  actual
  cipso_rbm_strictvalid   0           1
  flowlabel_state_ranges  1           0
  router_solicitations    3           -1
  regen_max_retry         5           3

Each one went stale when the code changed and the documentation was not
updated, or was wrong from the start:

- cipso_v4_rbm_strictvalid has been initialised to 1 since CIPSO was
  merged, while the documentation added with it said 0.
- Commit be26849bfb6f ("ipv6: Disable flowlabel state ranges by
  default") changed the default of flowlabel_state_ranges to 0.
- Commit bd11f0741fa5 ("ipv6 addrconf: implement RFC7559 router
  solicitation backoff") changed MAX_RTR_SOLICITATIONS from 3 to -1,
  meaning that router solicitations are sent without a limit. The
  documentation was not updated and never mentioned -1.
- Commit 76f793e3a471 ("ipv6: updates to privacy addresses per RFC
  4941.") changed REGEN_MAX_RETRY from 5 to 3.

Update the four defaults and note that -1 means no limit for
router_solicitations.

The mismatches were found with the help of an AI assistant (Claude),
which compared the defaults documented in ip-sysctl.rst with the values
under /proc/sys/net on a running kernel and with the initial values in
the source. I confirmed each value with sysctl on a running kernel and
against the net-next source and the commits below. The commit message
was drafted with the same assistance.

Tested by building the networking documentation with
"make SPHINXDIRS=networking htmldocs": the change adds no warnings and
the four defaults render as updated.

Fixes: 8802f616f6de ("[NetLabel]: documentation")
Fixes: be26849bfb6f ("ipv6: Disable flowlabel state ranges by default")
Fixes: bd11f0741fa5 ("ipv6 addrconf: implement RFC7559 router solicitation backoff")
Fixes: 76f793e3a471 ("ipv6: updates to privacy addresses per RFC 4941.")
Signed-off-by: Gopal Malaviya <gopalmalaviya53@gmail.com>
---
 Documentation/networking/ip-sysctl.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index bc22400b53..0b7bfbd98a 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -1587,7 +1587,7 @@ cipso_rbm_strictvalid - BOOLEAN
 	- 0 (disabled)
 	- 1 (enabled)
 
-	Default: 0 (disabled)
+	Default: 1 (enabled)
 
 IP Variables
 ============
@@ -2418,7 +2418,7 @@ flowlabel_state_ranges - BOOLEAN
 	- 0 (disabled)
 	- 1 (enabled)
 
-	Default: 1 (enabled)
+	Default: 0 (disabled)
 
 
 flowlabel_reflect - INTEGER
@@ -2956,9 +2956,9 @@ router_solicitation_interval - INTEGER
 
 router_solicitations - INTEGER
 	Number of Router Solicitations to send until assuming no
-	routers are present.
+	routers are present. A value of -1 means no limit.
 
-	Default: 3
+	Default: -1
 
 use_oif_addrs_only - BOOLEAN
 	When enabled, the candidate source addresses for destinations
@@ -3034,7 +3034,7 @@ regen_max_retry - INTEGER
 	Number of attempts before give up attempting to generate
 	valid temporary addresses.
 
-	Default: 5
+	Default: 3
 
 max_addresses - INTEGER
 	Maximum number of autoconfigured addresses per interface.  Setting

base-commit: fa5196392691051963726787944db872420dfa75
-- 
2.43.0

