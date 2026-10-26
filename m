Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793038309;
	b=3MRV1kULW0ZGe5qZPY2G1Wz3E/AgeU4GsVeZFnpvQwVyCzJmaXu58eITXOVQVK0WT7oV
	 7Y140Vd9cV89Ar/ZiNVnkO71k7wJs1es6o6CHqUbdnKHiMbz8fayS825dsREQms2l1Owi
	 pMB3FiJhr98CncvqxwJejady21BevypvmzD1/xQyBlkSmpgygboRA2Wl2PiegHujsiFXq
	 imFO+VHp3kNIF5LS11+U/9I4v6DygNqNgqK4+BVI1jVxp1kpyaPBze9Bln6kmnxEZhoqJ
	 4IDdykTceGdcMdC88opFVgZkNHBAKOZ8bacRcD3+BKtGxZ2qJQJE5MylXx6yFfqjkWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793038309;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=dKZQGmpkqBbaYMDOWkJ2IvHQIpl030vIHdXqdzHEmeY=;
	b=TzzZr+pdHY6cfiHoqeVBB1yspXu6kmCrxAVbEgJYPPHrqu4buTK8tQNAZHfqajhhB4TP
	 fFb1yulo/PfFmXzKVyoofXL9W58nAO9vmABOaFi1H3sXyc02cudatz93uEM2EsQFG3e91
	 9L/g2zjTk8wsYxGJLSeF9C3vga6iB8p9xiCLhiITSlbwnJApkXk+TOr4khw2/H4D0urE6
	 le7Xw7F2vTNy9xfpC767rLRzfBN9rEx2paD7eom3frqfhnWy12zgKLzgz7zl5tq7B+Zpy
	 O4OIl1NdDrzdQHBdm7rg/bS/s5k6ZSth6REUTmZ0DEN9Qrd/eUt/VzekTp8ZM7vvOXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="N96cCwQ/";
	arc=none smtp.remote-ip=209.85.210.43
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A71606A320
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 18:11:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00A71606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=N96cCwQ/
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-825b40f8a26so1643686a34.1
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 11:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793038308; x=1793643108; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dKZQGmpkqBbaYMDOWkJ2IvHQIpl030vIHdXqdzHEmeY=;
        b=N96cCwQ/43Ar2T0LsDO5t0baZsWuCMSpKTC3NnKx+TRRhcbextYRuL3yMbs99AzRMa
         +/ejSMk5xs+FrDT3oA6yCczdIvzec/w02QBezremJ7/xfDs5/zet/hm3KHrGAr9eAVWy
         LD+BD7W/HCy69rkR5/6RBhkEHf+zRauDniBagleatWwEF2PldzTXS7U9hcn9+fud5M4Z
         QP/Tbr6xhkkun24k9C71hjxmcx2WpiZRGphNpHpgETOwkRUKXBrtnoLEsNvnV3Vj+08b
         9W/MxTrVn9wrFTqP55Z9axwqZLx+ZYGjg4ZFdCcI6wtfR/3vMweAap8sStFlRWI0G+7Z
         fPww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793038308; x=1793643108;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dKZQGmpkqBbaYMDOWkJ2IvHQIpl030vIHdXqdzHEmeY=;
        b=iPQMkbl9sDMk1gtrRfpjObk13A7hMhTxJet5ZHKWh6Ru2QbXc/MzfyEO6tLwXv9u9G
         6o3a5zAoCs4IO6vLly8sddtSIRltwx9AyiRMvM5XkjljVzzrICeV3P8ZFPw2cKZ9/wrY
         85eWNrxGCMQmYy/8A7jliAgIO0zsRTqYFU8qjskSFxeiUgBKR5MrCd7VgZlCcWFAoqpS
         hAnc4FU3cwONTUfN1rsiwOk4Zk2PcYSCZ/A5IS5dpa8o+rOgK4inxq0upp9SvwHUm+k1
         gBhpeHFlo0CAUfEoN+7RC8KM+T3bGGz3ccyyhcxBJSsdXZ1mTGIQMXBokU8Q3saAkjVx
         LqLg==
X-Gm-Message-State: AFq9FYLOdz614BSy1I0+yjEKnIgJfKVDjG3BoZIjjgs5QXh2nVDWs5J/
	Sd96MByT40mD+LlpPoCxJdLio+XyNx0OTsmFn9ogoqvByULOiZwmM5sQ
X-Gm-Gg: AYBFou30GoWK36pGxQmZFybNGfbmHGwYpMlzMq3IvU56I4QA9x0PDw7hNqIlR87KwF1
	eDolv9Og3BYowz566HLJEYunCrxYO8i2vhkWSJGaDsjakHwkD8+myM3XtTZ3byHHRpyd2LeVXrm
	aIDgOvX5mm9SUGhdZHgDi7zScFK0ePFu/cK2pAl3PomsfEqs+jLu8/KDCnvjWqW88hmyjTCT0Fc
	/T4AXEpr2mQKJbbf8cyXWrF1k2rJsCqSCymlp/Mk3KO99RYzNQeXKSq7SstI5SFHkSG6Us8cRor
	L9gUoSLdmCk6I7O9UB9FsXfuHpWUnhGhbJdxabWE/GXv0kxsbxxPvJkbo92TtQWFqoLqyGt/K4T
	pPk8JU39VGcsuAmpKXuSucu2vPO2Qx7arSu8V7qxjPmS5REWeptrbnr7MJM0IyNWxSA/oFVR5jT
	yLZD9bm1Z90CNjyjdJVUlJUsASvLwMaqaIay1bdl5UfESE+P0NTzR2qYpZ9dVMAUMIay47hu31a
	7UqndwvZWD7tLs+FNoVrMIY0hqVVSquW/LplwVqgZnt4ygjga24IyyRhmAUjrKv54VStTCKZz6j
	yioxGwdt1/XO9e1Z47LZ4JYJZ5/xtXbfeZT17aKvPFGZrOK763M73xF2r90pj9nQjGDzqQZcBRl
	mFY3789Gg7iS/yN6XhaPjQpfyA/aAk2jnh+Cy0X4V78G2vt5Rqht/HcF7B3Jves7WwFJd/W/cuV
	yz3mG8O/K6rvwtVNqXgDxpQA9udjtg6lPkHi5v4hQ071RJvDRYAd0=
X-Received: by 2002:a05:6808:1919:b0:4d6:90d4:6bc with SMTP id 5614622812f47-55c002d9eb8mr6400473b6e.46.1793038307885;
        Mon, 26 Oct 2026 11:11:47 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-55c043115bcsm5795251b6e.15.2026.10.26.11.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 11:11:47 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 26 Oct 2026 12:11:31 -0600
Subject: [PATCH net v6 5/5] ptp: vclock: preserve missing hardware
 timestamps
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-ptp-vclock-sampling-v6-5-e705612541f1@gmail.com>
References: <20261026-ptp-vclock-sampling-v6-0-e705612541f1@gmail.com>
In-Reply-To: <20261026-ptp-vclock-sampling-v6-0-e705612541f1@gmail.com>
To: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Yangbo Lu <yangbo.lu@nxp.com>, 
 Miroslav Lichvar <mlichvar@redhat.com>
Cc: Eric Dumazet <edumazet@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

Socket timestamp delivery converts hardware timestamps to a bound
virtual clock before checking whether a hardware timestamp is present.
A zero timestamp means that the packet has no hardware timestamp, but
timecounter_cyc2time() can turn that zero into a nonzero virtual time.
The socket then reports a hardware timestamp which was never supplied.

Return zero without conversion when the input timestamp is absent.
This also covers skb_get_tx_timestamp(), which checks for an absent
timestamp after the same conversion.

This was identified during review of virtual clock sampling changes.

Fixes: d7c088265588 ("net: socket: support hardware timestamp conversion to PHC bound")
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/ptp/ptp_vclock.c         | 2 ++
 include/linux/ptp_clock_kernel.h | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ptp/ptp_vclock.c b/drivers/ptp/ptp_vclock.c
index 679ae40916f7..e9cf4da3ed8a 100644
--- a/drivers/ptp/ptp_vclock.c
+++ b/drivers/ptp/ptp_vclock.c
@@ -326,6 +326,8 @@ ktime_t ptp_convert_timestamp(const ktime_t *hwtstamp, int vclock_index)
 	u64 ns;
 
 	ns = ktime_to_ns(*hwtstamp);
+	if (!ns)
+		return 0;
 
 	srcu_idx = srcu_read_lock(&vclock_srcu);
 
diff --git a/include/linux/ptp_clock_kernel.h b/include/linux/ptp_clock_kernel.h
index 36a27a910595..56f6ab1855d3 100644
--- a/include/linux/ptp_clock_kernel.h
+++ b/include/linux/ptp_clock_kernel.h
@@ -496,7 +496,7 @@ int ptp_get_vclocks_index(int pclock_index, int **vclock_index);
  * @hwtstamp:     timestamp
  * @vclock_index: phc index of ptp vclock.
  *
- * Returns: converted timestamp, or 0 on error.
+ * Returns: converted timestamp, or 0 if @hwtstamp is zero or on error.
  */
 ktime_t ptp_convert_timestamp(const ktime_t *hwtstamp, int vclock_index);
 #else

-- 
2.53.0

