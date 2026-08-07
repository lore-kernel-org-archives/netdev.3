Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3072266B72
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 18:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786128021; cv=none; b=b711/nf2Az/AXxHKjlPTRguzMW+PRLBclGx6DClfgwQ5QZ20815Sg1cz9zZEdDNgrOaJxPHRqlRMUNY/JiQGa/ROEf6jwcu0YgtrCScYfUI1YcBFw18LCjWY3KbQn73dqEN3nRRV9flxGtgLCKaE+5hWmGwmnpMq4UjWoYQR1s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786128021; c=relaxed/simple;
	bh=PbpsyBqlyfLOm2yUMIlijD/3eU1sKNNML5naBZ1fNqc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P1N8kC1EwQRbx5uOZHP7cU/io/+MPIcHhMjcXrS+G6OYTaZ9P5zbfKQ04RlU3/LR/YsQulDH4LnP501SEli3/NsbZfof1O6mkkVthOeSDA1MvOChKxRz3RPwXXb4vZ07042yStKSnjwuUXvDpVeUqH6N5X4/ff9Js4r/vqCzOLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=HKdzxgRT; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="HKdzxgRT"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49954b88fffso20608045e9.0
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 11:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1786128012; x=1786732812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FA1HKas/N+K/KqBCtH93LwnN/ykTc81uTOOCGQWK/6U=;
        b=HKdzxgRTyYy+M/AZYXcKoiHyftl2kPlEp3AMlbCgGgKW675/Kva3FKOAvkoxbuqYr4
         oQ+AYOuvF8MWLRp5crO5NLLJxvzEuNdQfcnRA69pmUyEeOXriPGhNGVPhdNyzPLZtNLD
         W8fbtNxxU1H28t9YcStETHaN1y64qe7YqcV+KiV8zYSIsF2FA7IXhMG2r3ts6koatRJw
         uY3k4j371sID7pq6KPQBQt/NUENoWKklobs+WxvjMj2VN3l/mH3RngGf3p1v3qPUq6x1
         coDMnv1DM2UlHGwYsZ3ryNraQzDaOEcDYYT5QwwJtu7WlgO4wZ/D3cP23FhdsrWURwiu
         uqIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786128012; x=1786732812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FA1HKas/N+K/KqBCtH93LwnN/ykTc81uTOOCGQWK/6U=;
        b=Oo2lqWVx7kLRM9/0Km728GFeUu1YJ6bQaeeh5r+3xNgH/IwxTlCJe8eTXFy6YApsB4
         g1nVI6FmGYl59bp2NvreRf4LNVJrtxrRXbeRI4GeCgGSXPG5wSVyeiV3Rctky9u/Ksc7
         z01ZUTW/wOn6CLfz0lpECDzmRPiQLJYRI69ojLdP8HZPMebDM9tGVmr1vHPy45rpOV8n
         Q4YK8kjLrbwhEWUiPVxILUy3s6TftwYsFsepzREy2L3iVHuuIGN+1JP7U3NkH01hBgS4
         aJFYvkVszpZ3c7cWq1atpIAdajJ9GWqg29tfN3Se/NmzQIPFCKGzApbJKGQ7sHDVjdlC
         HgUQ==
X-Gm-Message-State: AOJu0YyzkI4PfYBkqsf3XNi1AhdsgN6aVbLS3LWH7UQ6MtM0jd87+gBp
	LsV7H89cBtvA6wGG98FScAnyBlM3m58BX0eUo31TXHtwLeq9ZcdeQEjs9BQ8nfCj1ohqIXDSP9D
	yZje2+2yh0m/j+Ols13D67RfeuJ8R0QTiZoySiRMQvDKWcKm6EM5CBLShAVkLEP5CJg4CC+NFkK
	Re3Ha0mbLtb/aMeDJVNccrTAkgKMzP030YlEsykf6EM5LhjF4=
X-Gm-Gg: AR+sD11KJE3Faj/iSQIvB66qfkec0Id65ByPkYlwT+2ZRB0OiQ/VsWwdHsWAmmqNjnE
	iAtU6rQ0VNkkLSdPLPDbAaPN+BAtZcRJjxlvhUwjZTzcQIQrf4/eNVuXvRfuHCOPe2dpTCzwrht
	5DsWREOW35nW1FUpa9dQTpRPsPgKn95nDsmS7Xdjxwkcvd5vVQmpF/AqJUv04UwzNzkrj7Wh/w3
	XJxgRPk6ktx/GheTYJIOk715g42nI5ZruglmfG/yQAjbc1rBrJm9DK9lWsPMDsQJBqkFwfqzwEm
	34zkf20NlXQO6lFKqV+zTlwHkUzHAL5MuEFI3kl78CpRQ//9zFSbYhhlwPQarSVnqBRH8ilY4S/
	3Dv8V2m/nxIYRB+KsipWzn7So4McuihF9+CVDtvrzKr4q+waIgOXzAbv0ZcKNGMzBzQTwGQ1o7B
	BPVlOdo9YYUOa2fccSlTBUMIS9PJuzCqxjGT3rxJdsLxnkPSgaDP9aoIQLCU+gASUuX2XjKsnwO
	syLqllSSDpbvh8dARnDIifdRc9f+/YCXRLyBHsyKcNsLxdhux72r46fQyMIzmFAZYJICvJsCrTg
	vfV4IHF5m8YsnkPi0/61qZsVyRMeljj0GJvNE+2YmLc1XFA9kavhOuv3GD23rF2Z0zoQM2HxQEL
	6BOaPbLA=
X-Received: by 2002:a05:600c:3501:b0:495:5e86:4e11 with SMTP id 5b1f17b1804b1-49961983990mr23318985e9.12.1786128009758;
        Fri, 07 Aug 2026 11:40:09 -0700 (PDT)
Received: from dev-rjethwani.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-499541b86f5sm166106135e9.0.2026.08.07.11.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 11:40:09 -0700 (PDT)
From: Rishikesh Jethwani <rjethwani@purestorage.com>
To: netdev@vger.kernel.org
Cc: saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	sd@queasysnail.net,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	leon@kernel.org,
	andrew.gospodarek@broadcom.com,
	Rishikesh Jethwani <rjethwani@purestorage.com>
Subject: [PATCH v16 03/10] tls: reject rekey attempts on an existing HW-offloaded connection
Date: Fri,  7 Aug 2026 12:38:46 -0600
Message-Id: <20260807183853.2288959-4-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260807183853.2288959-1-rjethwani@purestorage.com>
References: <20260807183853.2288959-1-rjethwani@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On a TLS 1.3 rekey, do_tls_setsockopt_conf() must not dispatch to
tls_set_device_offload{,_rx}(): reject the rekey with -EOPNOTSUPP for a
HW-offloaded connection (HW KeyUpdate is not supported yet, and we must
not fall back to software mid-connection), and for a SW-offloaded one
re-init the software crypto state via tls_set_sw_offload() directly.

Prep for the following patch ("tls: add TLS 1.3 hardware offload
support"), which drops the TLS_1_2_VERSION guards in those helpers.
Those guards currently also reject a (TLS 1.3) rekey; once gone, a rekey
reaching tls_set_device_offload_rx(),which has no other early guard,
would set up a brand-new device offload instead of a key update.

Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
---
 net/tls/tls_main.c | 85 +++++++++++++++++++++++++++-------------------
 1 file changed, 50 insertions(+), 35 deletions(-)

diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index fbb274287aa5..a62e94508c8b 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -710,49 +710,64 @@ static int do_tls_setsockopt_conf(struct sock *sk, sockptr_t optval,
 	}
 
 	if (tx) {
-		rc = tls_set_device_offload(sk);
-		conf = TLS_HW;
-		if (!rc) {
-			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXDEVICE);
-			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRTXDEVICE);
-		} else {
-			rc = tls_set_sw_offload(sk, 1,
-						update ? crypto_info : NULL);
-			if (rc)
-				goto err_crypto_info;
-
-			if (update) {
-				TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXREKEYOK);
-			} else {
-				TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXSW);
-				TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRTXSW);
+		if (update && ctx->tx_conf == TLS_HW) {
+			rc = -EOPNOTSUPP;
+			goto err_crypto_info;
+		}
+
+		if (!update) {
+			rc = tls_set_device_offload(sk);
+			conf = TLS_HW;
+			if (!rc) {
+				TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXDEVICE);
+				TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRTXDEVICE);
+				goto out;
 			}
-			conf = TLS_SW;
 		}
-	} else {
-		rc = tls_set_device_offload_rx(sk, ctx);
-		conf = TLS_HW;
-		if (!rc) {
-			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXDEVICE);
-			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRRXDEVICE);
+
+		rc = tls_set_sw_offload(sk, 1, update ? crypto_info : NULL);
+		if (rc)
+			goto err_crypto_info;
+
+		if (update) {
+			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXREKEYOK);
 		} else {
-			rc = tls_set_sw_offload(sk, 0,
-						update ? crypto_info : NULL);
-			if (rc)
-				goto err_crypto_info;
-
-			if (update) {
-				TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYOK);
-			} else {
-				TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXSW);
-				TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRRXSW);
+			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXSW);
+			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRTXSW);
+		}
+		conf = TLS_SW;
+	} else {
+		if (update && ctx->rx_conf == TLS_HW) {
+			rc = -EOPNOTSUPP;
+			goto err_crypto_info;
+		}
+
+		if (!update) {
+			rc = tls_set_device_offload_rx(sk, ctx);
+			conf = TLS_HW;
+			if (!rc) {
+				TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXDEVICE);
+				TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRRXDEVICE);
+				tls_sw_strparser_arm(sk, ctx);
+				goto out;
 			}
-			conf = TLS_SW;
 		}
-		if (!update)
+
+		rc = tls_set_sw_offload(sk, 0, update ? crypto_info : NULL);
+		if (rc)
+			goto err_crypto_info;
+
+		if (update) {
+			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYOK);
+		} else {
+			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXSW);
+			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRRXSW);
 			tls_sw_strparser_arm(sk, ctx);
+		}
+		conf = TLS_SW;
 	}
 
+out:
 	if (tx)
 		ctx->tx_conf = conf;
 	else
-- 
2.25.1

