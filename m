Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794513660;
	b=DvYMXMVCiS0kv33VW+2rn16g2qinQbZcm+J8da3P2xrxy/qpPx77ktgJ+f+pceX+5boo
	 NAlwwH8OsL9nCR4wEzPD2AlRbjX4wNwLHJvN6ANK4KGXYKRmRi/9tLsFCtuzDADdeyDrH
	 MRoN/R1JxazpIAovszohOStQh6rS9hTRkF3Kt53VTAIlw2yWWzFe4uo317iuG0+hBvqr1
	 +OfcenChPLGKAAPsjtTQOhgFwXSBxHfDWn9fAYwEKI4prv/6YrQIj4NnwUWI2vx8aTP5U
	 VjPDhgkMr8uFW+/EuFYXfHczID4PclYlGt2s59xBRoqLOGJnTGzi/tW1kMvhu8TJ7tQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794513660;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=F/Hg2coMmHkiIqnzf933QhnLSn+k+5t1rXcwldo0OvI=;
	b=Ox93UFwii7iIQnPP7RqdauwnWaLFpj9Hb1fu0KNjjpu/LZdMhNy8aWd7JVMKflnWxVln
	 lwFQGxydI0HNtTIlmQ9crxAJwPlb+zo6mBv3F6e7cNGKDR8O3td90ngbLP6e0wC6tiIuX
	 kIbuV7HD0Hm5XdNINTKfHFxs/odk0j3an40H4Mj/XfzsD7NKF+0hyXUFYS/vIAsLZowHB
	 vjSW+zZ8SnN9esqIh3UcUvsEQcQbrxClpsFQ0PBcd/dZtooBTzT2qivzvbKBJ5HujuXt4
	 yg8xA7AmM2h8D9r+x1AUG9/jR+g1kn894APJ4RUMQXMddBx5JTGOzUHKz/+3R6p8t6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=nrZPlKER;
	arc=none smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B877D60A260B
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 20:00:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B877D60A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=nrZPlKER
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8a070755c8cso111935b3a.0
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 12:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794513659; x=1795118459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F/Hg2coMmHkiIqnzf933QhnLSn+k+5t1rXcwldo0OvI=;
        b=nrZPlKERO7eMRdsNMturq4R1DeCcIjJAtzh8NzO95UFSTIHZKtQT4vG6HOeBAN/r9y
         wG/flMRAngESix9v7s4VG2yQ5GjyCMNXDaIhE1Ldu/+fJnlj70OtjVasDdqtLv3XCyXM
         Y8H8Yq1anuI1FPAeHoUxtMzt0yFjGeiYBH1QRyXCtborm7Q4/oTbKDlX9/t+e2SF2dll
         P0Ax4K/nREK4pGWx9B60dfxSaUdvl3ePrxTq1Tv++lfzkr/exL4Xizc9AL6GRD1oYCmL
         hFbBEmcHosVGC7Wod5ErEZ7Swpw6nlE74ibQOByws+YPo58nqQo54BrRLbRGMf88UIGj
         vQ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794513659; x=1795118459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=F/Hg2coMmHkiIqnzf933QhnLSn+k+5t1rXcwldo0OvI=;
        b=wURv8sChsqQMbKkDN4lMJ+f2q9jrBYABporZ7itwGOhB23PjG0tIQuVKxlsnAAoUgG
         fR7mvcawtMwIKd86AA3WlmV0yGEsyXYKI/kWK6KzYGdszWFoN5XK9uD3Fo4Nr5GQ3WZj
         uMeM+bljWIzXYsr7qBcosiCb89U6UgcqxTaUKW6QHsygBAokAv6Vxx2S8PIZAODiHCS2
         9eh1Iy+3ABaZGQwUE5C1rXf8Fnl/S4RK332+0MLE63goTubolQdYWFkIV82LQsCYjqcF
         AC0V9VyGjQsdtE33cNlEPHw3pMlIOT1WDmn/JxfHarOCFyzO2/F3jooBQWCkD83mVy6H
         +zgg==
X-Gm-Message-State: APuU4Z/0OG5/hcJ8L1KfSWu7y6CKwRzloFxiq+J8av/Z6y+i/VDwbCaG
	eRZnkXb9soHt/M7NgLBpI6CkCGWzQAdDpTuiMfAatN57eLuBmA3+NqxQ7u6iDGpFAe5uq9GtPyv
	RsJ4D
X-Gm-Gg: AYBFou0LvBYmzcY/3yrauZ2GjyNj3o1FqApToo78AG8+26CURkpVCYxDFgNSgwJQJwd
	umsOIApSvwsNtDnnWhUTGMI9xfNsc2Ulzd6Jb5pR+3sY1gd+BtqGEPBOaupoctTAcumc2QeZhCm
	uLWNBC2cf3TTBT7xSdblI9Eh+omm7fg4EGmA7vl5fXbY2iFDwvL/z+URzvoSKIgXjF0MFoNPeYy
	pRyYBKMQGn/yGVwU9rlJYtB7D/I8O/N32zdXK5/9HiJM/vDmG6ms/4bkfbftX8sb/XzpX5DC2EH
	txyAVFj9zClPBRkbSBL+rsepl/7uuJ3T75QQzCAk/2RqD0P4Uw4X+x41kZjTGTgE6ZME89AU6/L
	Q/bD8yUv6dAqg+tsb4T9SbRnZbQmN5B3j6UkJr31GcpN+Kr136tuh42hx9OLNgz60171v65nkCr
	ZEb3jegtCtKfqfsgvy9bNgcuYrmGNpoXJxCYnd0/cjKfacrSdKi1wf5E7wtTTzT8EvycgMSPVoR
	szZFE1EDeDskhqHiYeVDsN4gVSgw447tUb7lQ0GUtfkK57YKWxzIhW/EnZcdTc3SOAOplgCK1AH
	9K0qxNsC0+8CMLsqruA/lEKB98N2EdZcqQlI7MNzkpeXGZKuxYUiPu4Hx58oFEcEGG7byUM=
X-Received: by 2002:a17:90b:528c:b0:3ad:8a14:bc73 with SMTP id 98e67ed59e1d1-3b1b0a4de36mr120403a91.50.1794513658955;
        Thu, 12 Nov 2026 12:00:58 -0800 (PST)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d27d26sm5967123a91.13.2026.11.12.12.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 12:00:58 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2 11/11] ss: report a failed SCTP or MPTCP dump
Date: Thu, 12 Nov 2026 11:59:24 -0800
Message-ID: <20261112200046.2164391-12-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112200046.2164391-1-stephen@networkplumber.org>
References: <20261112200046.2164391-1-stephen@networkplumber.org>
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

sctp_show() and mptcp_show() discarded the return of
inet_show_netlink(), unlike every other family, so ss -S and ss -M
printed only a header and exited 0 when the kernel could not dump.

Neither protocol is dumped unless asked for, and sock_diag_error()
already reports a missing module as lack of support, so this does
not add noise to a default run.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 misc/ss.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/misc/ss.c b/misc/ss.c
index 7c47d377..f4160f59 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -4105,7 +4105,8 @@ static int mptcp_show(struct filter *f)
 	if (!filter_af_get(f, AF_INET) && !filter_af_get(f, AF_INET6))
 		return 0;
 
-	inet_show_netlink(f, NULL, IPPROTO_MPTCP);
+	if (inet_show_netlink(f, NULL, IPPROTO_MPTCP))
+		return sock_diag_error("MPTCP");
 	return 0;
 }
 
@@ -4114,7 +4115,8 @@ static int sctp_show(struct filter *f)
 	if (!filter_af_get(f, AF_INET) && !filter_af_get(f, AF_INET6))
 		return 0;
 
-	inet_show_netlink(f, NULL, IPPROTO_SCTP);
+	if (inet_show_netlink(f, NULL, IPPROTO_SCTP))
+		return sock_diag_error("SCTP");
 	return 0;
 }
 
-- 
2.53.0

