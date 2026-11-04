Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793788467;
	b=jO84db0gnEHTg+bS23ZfSyDEsMU4XIF8jT4NviEtkIDoc7FKcUtjQpYJl/eArN1UrLKb
	 azQyHct9xdKt8gHbwtFaA/s0R23funVnSV4lsSDS2BUL+5gCkokuUPOtyhY1GayCcKzLl
	 xEookTEMaxuqmY0cLtuSCdz10/w+Ji1cVoUpLXIMQMZ599R4yWptoaVZwyiJqqT/MJtTm
	 GSMn3jyAjfd6wE1cH9jEP+9Ch8vsiNA/IC6Z0OXTfVyENfycYSfidBin0igiY585sG/JZ
	 rKIGIG21+K1d0Nu3ATWevwIjkNstL2Fk7VBSxr/ZB92/HPBW4RKH97jRQimk81hqYeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793788467;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=h/IyEnODLjG54iLprqGuhwix9RXe6REIL8RaNZR63d0=;
	b=Vf/M19v3cEh+tw4cbfd0liamqRdQg2gk8RQ6R2N8n71HJtCaEHfqoilw8GgJNFV7PpCh
	 xAFobBmaLzR4n/J9OnUCeRWtCPcHPDwimppSfqn8SMvcrrPelpIDkiim0t5B3uU9HooWO
	 5PwFnmbWZfUVI77aAYjiqSusRrwtMv3ggb4zWU0Ei9QeC63XFLHoMK0/KW0dclyCmTmyk
	 BaMQH3jpDEDKEldLNgVuAar+9VBkTP2WAsEATwE0RfelsqlkuKY/advmPX3+gqFJfxAK4
	 WWWCDQQzh6X4Vup+0K93dh3nZdCnDHY0O14Jg1KXcXF2kdT5QGQi4PPr3/sEDhfJXgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H0UYgqRB;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAF8606A31B
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 10:34:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABAF8606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H0UYgqRB
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48c5b7d5865so38369f8f.2
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 02:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793788465; x=1794393265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=h/IyEnODLjG54iLprqGuhwix9RXe6REIL8RaNZR63d0=;
        b=H0UYgqRBv3N1RDy5WALaO+DwGXv+cpb7/uVGz2PG2K8C9+GnrO9hjaoFeK/wPuA1O/
         aduIJ5lRrxepNZjuDICFbbDPyDcnpa2To1lLReQG3xRZuqdP7Mp9kF9/wswuMrDRWyTF
         Skq9uTYmNFd1Y55lWLhjsy8jcDENfH+maLhjRXGGOa55CgtXOpNjXc56qRGJO9xHbKKW
         3fRdYK9WrbPc4dUK/LrZRRnj/7pbPtb5x63h6O9BpkQr/IU4jqxbQ9ZRnuE/fcfoftZ0
         D1Od0704SoghcyZft4+eIXlaRAfPKuGBudLJPaJMwiBHPSBRArYwym9jNrlkGwtuGzaF
         abmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793788465; x=1794393265;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h/IyEnODLjG54iLprqGuhwix9RXe6REIL8RaNZR63d0=;
        b=GncoxMkgSNmboBZ9zpG3GppEe9XJhjEt9xpqvWah6O0cyXcpvJ7JjC1F3IGzbwJ4xp
         1J3JIkZTyzAJWZKc8KE44fPqjhPmy37oxgwBBcMqYeX5/ss6fh1NSKxOf6OAd0oD1HQt
         JEpTKsTSVSFfuv1zVlA4yb66o4juOAYXc+byN7QP5nzjnRQirHRgWZndwP1l/BaDP5tq
         Lwp4ekNtXNxeHdcZhaQNxVAJKw0vt9vNwIXUG1qvBt8FhftuFqGEB+61ni1KiGn9A9YM
         Ea06SoGT5QfXygZqNMC45J2IgRD/4uK5iVIUQmOeWCrR0ytNtg8hPBG1ZOFOGfmZtMW/
         07aw==
X-Forwarded-Encrypted: i=1; AKwUvBxxv2Ofy7t1ElofxCSkFtCo795vlHprlHaTnVfNlyqrI4sjEIFBRAwM+TmeqE2ibuUv5dMAenY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8XKRWlplJn1hMRZWIcux/srI3QPhD+hniZ4GIG6AqIdgd4sD2v
	BYBHraAMj9jLoCrvD4SIoDynSFwH4UFZl1KjxsIRR+yvNfyLNudfiRRU
X-Gm-Gg: AYBFou1CDKy9R2UlbS7lyxR9BPGByV7cYx2etB7xQu2QwWqPww21rEN1HrObGudXlgF
	uKoPH5ZrOut38usn84nYablXWWTCcXLMgHop0s/oCDoeRXcsRGFFLfI8ToD76/QEn0p4WO41IMy
	o6R75UwJxtoUGuXj7eFJHIdp7HkPAdlYgRlbZ/sTNJ/QpBVJfjUSfXMI++u0oj6QDIKEh59vPG9
	KiYE1qru9N59Wuz8PqDo/Oc6PTnVbHFHiSTwK0Inss86bciZaXBv7XV0UUQgFpkjyDhtCxsvShS
	SecniR1AGlBrTIbL9SlGdHOQCMGWWWomyWapZNYMQVFZunzpw5nBu82xjxKZfw6d8IC9HpNSQBH
	Z2E6SYGDgTKKBN1eY+9Gplsv+YKSCbWgSyWsON7yvgDLRjhWTLV7hB3uYULIzHF0kJxyYDuZIwr
	uV3Az0GH09oU+eBA3P06IFUIeZEVOcwV90cOc04O/9M2iW7la1boCGbftGmYdGuWyeYXUkPRQgY
	wBSZkQJODEvcfnmWaRkATmr70jORU/kywwhTR1NxqJQTx6KuifSF4TXPg1ZUOxuA6LcFlTqBDgm
	lY+yoK863/IM4NHfmufM+lcMA3zBOXEVV1aAj62qkGvQXQ96s4fjYmR5UUrtka4+3jdACyfGyxn
	Zt8VWBvPY670twCE0Cg0=
X-Received: by 2002:a5d:608e:0:b0:48c:698b:502c with SMTP id ffacd0b85a97d-48e6e2bcec8mr28938089f8f.1.1793788464784;
        Wed, 04 Nov 2026 02:34:24 -0800 (PST)
Received: from thomas-precision3591.paris.inria.fr (wifi-pro-83-006.paris.inria.fr. [128.93.83.6])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48fed552afcsm3105132f8f.41.2026.11.04.02.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 02:34:24 -0800 (PST)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Hariprasad Shenai <hariprasad@chelsio.com>,
	netdev@vger.kernel.org (open list:CXGB4 ETHERNET DRIVER (CXGB4)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] cxgb4: clear the sge maps and bitmaps freed on adap_init0()  failure
Date: Wed,  4 Nov 2026 11:33:08 +0100
Message-ID: <20261104103309.24360-2-fourier.thomas@gmail.com>
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

The bye: label of adap_init0() frees sge.egr_map, sge.ingr_map,
sge.starving_fl, sge.txq_maperr and sge.blocked_fl but leaves the
pointers set. If the call of adapt_init0() from eeh_reset_done() fails,
then a subsequent call to remove_one() may call free_some_resources(), and
free the resource again.

Clear the pointers after freeing them.

This bug is theoretical and was found statically.

Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
Fixes: 4b8e27a86d20 ("cxgb4: Allocate dynamic mem. for egress and ingress queue maps")
---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
index d449cca00608..9176653c7d70 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
@@ -5402,11 +5402,16 @@ static int adap_init0(struct adapter *adap, int vpd_skip)
 bye:
 	adap_free_hma_mem(adap);
 	kfree(adap->sge.egr_map);
+	adap->sge.egr_map = NULL;
 	kfree(adap->sge.ingr_map);
+	adap->sge.ingr_map = NULL;
 	bitmap_free(adap->sge.starving_fl);
+	adap->sge.starving_fl = NULL;
 	bitmap_free(adap->sge.txq_maperr);
+	adap->sge.txq_maperr = NULL;
 #ifdef CONFIG_DEBUG_FS
 	bitmap_free(adap->sge.blocked_fl);
+	adap->sge.blocked_fl = NULL;
 #endif
 	if (ret != -ETIMEDOUT && ret != -EIO)
 		t4_fw_bye(adap, adap->mbox);
-- 
2.53.0

