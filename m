Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFF455C1BF
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 14:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790087337; cv=none; b=WxYpzq9d3gBEGcR/XQwRk+FJ00Al4dWD2yx3PVLzRJfiTxnv9m3rtKc+KI6PuFP8LOTBvcC6wYgojy7ZEOajdcbTMXC55vl3lAitb3O7CRtxuxdjg08/6Xq6rwbz/L8D2aPN2u1iA/LLUw3z5/1gsAvDTdF/LEBjBwsQ0oLfYv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790087337; c=relaxed/simple;
	bh=LjFWXtBxX8T94YoQ6LqwowvWE59E53HE3eg72IgpkjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WDmlX3BQoHKk2gtIFrf1Aosy1rw3lLfNVzCGlTiWwdB9BzpBGEFSV1aC3noQa045JsrokdJhpsc4mjvSZsC23J5N2xyx823Pj9YkLWuibDa9OIH5EQznotNh3d+9SS5zkddFcU4R1g27KVM8v34X9KaHDoqDJqwkfM0YLX+u/Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YsTNHPDq; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YsTNHPDq"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5b5f21afe8cso1077313e87.1
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 07:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790087334; x=1790692134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ElzIfLW9vsgs9qj3Q3n1oLfTLliMNpKpVYJ0kUF5UpQ=;
        b=YsTNHPDqoCOie/hcailZHkczEXqKkCCPBmdDCFHxP1J9Xj+y77g6qfYb1AMxuvoM8l
         ozMeihLSbDRnU2779bgyG21CkCzYU1GDWefo8al69vTQI5n0SQGlgGYFIsUlXSO7wVV/
         UFZtq7hrLq6bjNYKEUzrG8qYcA5MHJ+lx9PfkYWexNbnk4LIuRQmB5dWu241lpZZDCA8
         8thUOkuqsq7GjDIQudK8brofRUZ6uA6tS23Se6nyi8K+I767XyKXoEeJ9o1wUU6GObVC
         F2OcMUAoplR9UfaQKQnTqkfpiWR6A9YdIQOIotyLoqf7pzo/igOsBVxMBHrxejDHFV0V
         bLQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790087334; x=1790692134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ElzIfLW9vsgs9qj3Q3n1oLfTLliMNpKpVYJ0kUF5UpQ=;
        b=RvUNHUL0QVXFTBdhYlGG5ynaZKrzYtCfGLr9pSlIdbXKMImewkdDsnjKpJ5IUuYXjM
         GU9TJvr4I+c2u/W41H0qclc72lh5naGOEUIjPvbwAijfvbJ7uQIPlTxB7mVKTiHzT43R
         Gdj8r0aRfR40teug5iyT0YECZ6cEoKLfsUrHGBNenAQ9AhDzFXJORYhYyIe6iRkjGgH5
         VORGo58bC3ZRQMdmBTtKjah4jXsyfgXrRLkTTIoYOYvkLgKT/vRlvNkz8Jc/hlUepCdX
         RiW1WUhCXbqZr74P6qBxO2PJbIVi+NgNtaCtTh0DyTBIHNGd48QQKDXjTqbKih9eqvEz
         YduA==
X-Forwarded-Encrypted: i=1; AKwUvBztClNRxI/vGpiOG+V5Dglm0Dy70T+oHZx5u6hB0iN5868DjJ6h7/dEtSiBKCuHVprxIBeGIOY=@vger.kernel.org
X-Gm-Message-State: AFuF++khObR403jZ4PP0x77G0a2tKlagRw0q/C0emw7fDU7oMQSz0HWE
	CJ6FVX2JUveYmMtfwNqMMdC1LeGkW29L0TBSvYexc/PRJQZnV/7lRRft
X-Gm-Gg: AYBFou3aDh3SGI+01E8ZjS7Iw4WVT4zjD3mwW1A1KzsPUQGoMf3pPe5r3iHiKSXedNG
	/eB7JW87F5sbP+RYZR5PzpXbInYn8uIjnfO4ByYN7nt6jD/QKbTmSTzmR4sHDKkfn7jxp//PQU+
	pOAg7DZr+LSbZ8gH2vGO5PJAhXBGWedli3CeDtAuDhky904VyxXvmjBSSYkHgu5Z2bvJUpqXoZ8
	9jTfOm/R2F/0wOIF6DmaSnAV8h3f9Gb7gwFYXxHmWGPFj8HB6XyEV0qp7Hgl968LFs95JcvobDk
	JxETWtpxg+Bwu9s2cJ1dJ3TdK7+3c52L7g1sY32SML8N16xHMB0D41fnlW3ttElYjoRM7rswu0z
	f63qmPWq7LVc8tW6/HWTxSkBw5EZiw3AeT6MP58UC870+Yy9prYgOqe+o5qHBvKGlk+eMD6J3jE
	CCUBLk3x4RerySP54JsbqEPaubjmVVtalWQwSd6rBkhfEzx3syjssI8EvII4W7JblOT7wa89oOd
	/BfUBPZGsrHnaL822c27D8d3lYPwQeQ2APxqVh2
X-Received: by 2002:a05:6512:1242:b0:5b8:9a95:e251 with SMTP id 2adb3069b0e04-5b8d293525bmr961353e87.25.1790087333547;
        Tue, 22 Sep 2026 07:28:53 -0700 (PDT)
Received: from fedora-tap.advaoptical.com ([82.166.23.19])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8d46d2064sm589691e87.24.2026.09.22.07.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 07:28:53 -0700 (PDT)
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
Subject: [PATCH net-next 8/9] ptp: ocp: tolerate a latched FAILED when entering configuration mode
Date: Tue, 22 Sep 2026 17:28:28 +0300
Message-ID: <20260922142829.57740-9-maimon.sagi@gmail.com>
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

The first status wait after EN_CFG_TP used adva_x1_cpld_wait_ready(),
which turns a set CPLD_STATUS_FAILED into -EIO.  FAILED is latched across
operations and nothing in the driver clears it - the failure path only
sends DIS_CFG - so once a part had failed an operation, every later
"devlink dev flash ... component fw.cpld" would return -EIO at the enable
step, before reaching the ERASE and REFRESH that would put the part back
into a defined state.

That contradicts the recovery this driver relies on elsewhere: the page
loop documents an aborted update as recoverable because fw.cpld stays
advertised so the image can be written again.

Use adva_x1_cpld_wait_idle(), which waits the operation out whatever its
outcome, and let the CPLD_STATUS_ENAB check that follows decide whether
the part actually entered configuration mode.  machxo2_write_init() in
drivers/fpga/machxo2-spi.c tests FAIL the same way, after the enable has
completed rather than as a precondition for it.

Fixes: a4b7c15aa78f ("ptp: ocp: add TAP CPLD flashing via devlink")
Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
---
 drivers/ptp/ptp_ocp.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index 0d6d0c02882c..4f2bf54a23c2 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -5018,9 +5018,16 @@ static int adva_x1_cpld_flash(struct ptp_ocp *bp, struct devlink *devlink,
 	 */
 	bp->cpld_in_config_mode = true;
 
+	/* wait_idle(), not wait_ready(): FAILED is latched across operations
+	 * and nothing here clears it, so treating it as fatal at the enable
+	 * step would make every later flash of a part that has failed once
+	 * return -EIO before reaching the ERASE and REFRESH that put it back
+	 * into a defined state.  ENAB below is what says the enable worked;
+	 * machxo2-spi.c likewise tests FAIL only after ISC_ENABLE completes.
+	 */
 	err = adva_x1_cpld_write(bp, CPLD_CMD_EN_CFG_TP);
 	if (!err)
-		err = adva_x1_cpld_wait_ready(bp, 5000);
+		err = adva_x1_cpld_wait_idle(bp, 5000);
 	if (err)
 		goto exit_config;
 
-- 
2.47.0

