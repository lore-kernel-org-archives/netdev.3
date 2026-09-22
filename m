Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B67355C1C5
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 14:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790087340; cv=none; b=S5YFRKh1OjDXGcvF6VOycVoaLH/bSBwxbEFwuWrZLcHt3rypFl80Xz7br2C5bix9G3/wHEM+ehXXZfr5CQ9h/njiu5thevuTBFFYcop1YtIfU1Ofi56dD9taXCuHhNec0pu/KytQ+jKe/wA94+IAU03V+6yDICvwUYO6TtdwV70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790087340; c=relaxed/simple;
	bh=tp2C5wgYQL0+H/MstzejuqB0z6Y4qPGa9hNfxih8Myc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZYIErWEfXmnTaV9squ2+WI9MwJi9Wejj83stgv6DYZ0GaEqnE7EOWQA6zsbKGC7UQzpPEbZciDUlbUZUfC7MPiZxUPEk46MjGatH9TbF0MAbvLsARC1jLrsLj3zqH1f7Afex8GT1HWguSBLVonDAEWjk/OidHdRlP3JDbtv5PLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nxX2jk/Q; arc=none smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nxX2jk/Q"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f1801fso4229966e87.2
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 07:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790087336; x=1790692136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DWnL/kcGD9BgwQHJ1ulieSSx0+mb/wdvY4wv1lor7jg=;
        b=nxX2jk/Q3+RMc1UIK03+z7NwXbmC4TZgNllhKUt2tbFDttnI6YUM+lagN8P6p88sc9
         KNAc8a5rx3cIjbBI5u1KNZKjYc+P9Syws6QBgrLj1v3z9rCO6oklhpAp8DyailwRn8MG
         ugAExIj2tsdmVIBlOJageTbX7TckfGG7Fs97kH1UQf1IRwRN7B2nZ5qiqR1fDCRGmjdi
         5KIXs/d1UPcmZmxfc74lyqA5FKKCeYsLmNMkTu4TEk/1KL6shSEw2FrJKrBd4pRUDoAO
         EZDtZrm7/j7vs5HmgbOLl6BX+g/Hqi6U1ffcfSzGPQUwsNWandKRfPQiWQOgY9H4fs2K
         QS6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790087336; x=1790692136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DWnL/kcGD9BgwQHJ1ulieSSx0+mb/wdvY4wv1lor7jg=;
        b=AaZwq8iT49ocEZbpqA5rCBr+dsvXV/4nw7aYe7ZrZfCgaaXooeMgxcxv7dI9HtJp/H
         wWl6ie55/DqBtxvJAcJWbEck1jq1P2zyKE5aKbhw/V5enG4YXmMnzBCT52Q4ekobBCPc
         XhXdAaCs61vb2J+fp61mZNm1AXJ0Rw2lwoNB/gArB1NCCs+H2xtOsB7FmUXHymSmLXmH
         f2Al4Q+lsJsAEe9LgnCvAz/gv5H+114eFEtx+u15mpgNoGyI5QUXDplRhCZaeZWRnP6R
         ht1y3LcQFk/QfafYBjK2BY5WmoA6A0vAeAJVrMTas7lvpxNe8AHXwV5thPjEtByIF1eB
         sdWg==
X-Forwarded-Encrypted: i=1; AKwUvBxXJoB0ZfgZ3sD32z3P6luYdjEV8zQly6p7OlsCYTSTJMIKhoGF7z/DX1Bot+yRZ2OUuwf1kp8=@vger.kernel.org
X-Gm-Message-State: AFuF++n1ws3cP6UdW2ORO522nKhAUFOvmM/uoAITvC2Ym3P0KHtj1Z+b
	kxylfSu4olJfeJLj0/zFjlmjH8lT/g5KYNF3i2pvTL4733/G2GrlnIOJ
X-Gm-Gg: AYBFou1qY4ZjglEoXshnS3EgAZ9UH/7gBcF0/yhxFsmUttix374aKeGzfm2iMw63+Qo
	TMjc0ivBVQZtJ604+C5ilRu8VURKqCC790pcZqBHfwSqBvhEKzQIDOgtcWqQT4inaNJng2oXRqw
	O1nP9wHnGmyaO4MjkwywM8id8u1k1o6g+cciC+UC2BmIIKD030X6hhsfBRvw6Hyhl2M+Ea9Dkv3
	hop4lf1wE0RlGXQqVPtLI1UdjZq/OYyF8uzhK/6SHaAK4vGoZ/mHeFUR5tKmlJpMHXru/0it2e4
	I6HhmEZE+RzEN/giclL1KBk535vylKKQl8O97U1oY6wNbA7IFccdZvEaqJw8PdpR8AOxbZpiImi
	VJtX3yezsrQXBqUfqd4UkcmOxvgw+0F/FDs9DpGKkRTuTRwCMMes1p1mWORA3bQgKzYWZ87Ocuy
	D1RCQ7AvCZHpjrPYx1cS7Tk4HUqniZggWcd4UaLKZmxfYr1gUAct86bju+pK9WYAEUVr0Q5UtTv
	SDO3d6v8SzcrAgZdza7SSTTSf6z1TiCCWH667et
X-Received: by 2002:a05:6512:3e25:b0:5b8:d078:da8e with SMTP id 2adb3069b0e04-5b8d078e2c7mr1792641e87.28.1790087335967;
        Tue, 22 Sep 2026 07:28:55 -0700 (PDT)
Received: from fedora-tap.advaoptical.com ([82.166.23.19])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8d46d2064sm589691e87.24.2026.09.22.07.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 07:28:55 -0700 (PDT)
From: Sagi Maimon <maimon.sagi@gmail.com>
To: Richard Cochran <richardcochran@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	netdev@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sagi Maimon <maimon.sagi@gmail.com>
Subject: [PATCH net-next 9/9] ptp: ocp: confirm the CPLD really left configuration mode after REFRESH
Date: Tue, 22 Sep 2026 17:28:29 +0300
Message-ID: <20260922142829.57740-10-maimon.sagi@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260922142829.57740-1-maimon.sagi@gmail.com>
References: <20260922142829.57740-1-maimon.sagi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The post-REFRESH check required DONE set, BUSY clear and no error code.
Those three conditions are already satisfied by the state SET_DONE leaves
behind, so they cannot distinguish a REFRESH that rebooted the part from
one whose frame was ACKed but never latched - and the I2C ACK alone was
taken as proof, clearing cpld_in_config_mode.

A part left that way stays in configuration mode running the old image
while "devlink dev flash ... component fw.cpld" reports success, which is
the opposite of what the documentation promises.

Test CPLD_STATUS_ENAB as well: leaving configuration mode is the one
thing only a REFRESH does, so it is what separates the two cases.  Put
cpld_in_config_mode back when ENAB is still set, so the exit path and the
recovery at the start of the next flash can act on it instead of
believing a mode change that never happened.

Fixes: a4b7c15aa78f ("ptp: ocp: add TAP CPLD flashing via devlink")
Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
---
 drivers/ptp/ptp_ocp.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index 4f2bf54a23c2..9c2b7403bfd0 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -5135,6 +5135,9 @@ static int adva_x1_cpld_flash(struct ptp_ocp *bp, struct devlink *devlink,
 
 	/* REFRESH reboots the CPLD out of configuration mode, so the exit
 	 * path must not send DIS_CFG afterwards even if a check below fails.
+	 * The ENAB test below confirms it really left; until then assume it
+	 * did, because sending DIS_CFG to a part that has rebooted is what
+	 * this flag exists to avoid.
 	 */
 	bp->cpld_in_config_mode = false;
 
@@ -5156,12 +5159,21 @@ static int adva_x1_cpld_flash(struct ptp_ocp *bp, struct devlink *devlink,
 	/* Require DONE set, not busy and no error code, as machxo2-spi.c does
 	 * after a refresh: without it a CRC or preamble error reads back as a
 	 * successful update.
+	 *
+	 * ENAB has to be clear too.  Those three conditions are already met
+	 * by the state SET_DONE leaves behind, so on their own they cannot
+	 * tell a REFRESH that rebooted the part from one whose frame was
+	 * ACKed but never latched - which leaves the part in configuration
+	 * mode still running the old image.  Leaving configuration mode is
+	 * the one thing only a REFRESH does.
 	 */
 	err = adva_x1_cpld_read_status(bp, &st);
 	if (err)
 		goto deselect;
+	if (st & CPLD_STATUS_ENAB)
+		bp->cpld_in_config_mode = true;
 	if (!(st & CPLD_STATUS_DONE) || (st & CPLD_STATUS_BUSY) ||
-	    (st & CPLD_STATUS_ERR)) {
+	    (st & CPLD_STATUS_ERR) || (st & CPLD_STATUS_ENAB)) {
 		dev_err(&bp->pdev->dev,
 			"CPLD refresh left status 0x%08x\n", st);
 		NL_SET_ERR_MSG_MOD(extack, "CPLD did not come back configured");
-- 
2.47.0

