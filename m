Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C45E4AB3BF
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 22:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789685108; cv=none; b=Loo/LPT/AC3Ixn77NZUqu0F80thf1sA2fDPpoA56cu4DNOGanBtuVzVV89dTJbsISsmNF5aZTZZJIYRTLFUWBJd6UdgeiI6/Momdax35SCDOMcg3/WFo281SLmCHYwBmiAOVP9/B7vlkTZEgKTP4tycBpg3n3buRRknXFb8DgmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789685108; c=relaxed/simple;
	bh=RKQNCzP+JHeS+xInqU+AFV29ihQiN9fS3CMuRpQPnN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FEExURi9Qar/5uA5RedoyAegiZfQjwqUTEBIramR+DKTSekbmQmbCMEzS/u/sAm6YBJQ1hRjC7ecX+uhwMjB9D6SVYgGqzLwBflEifHz4p43Kf9z+FCgLdLwqP/gxjiUobo2zHGN4KrvYuJ3EpGG7JU4Qyx8YX9N6nKbSOH4los=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Mgkvo/oF; arc=none smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Mgkvo/oF"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-466ccde2ad8so156205fac.2
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 15:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1789685105; x=1790289905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kG9wJf7wOlOfl2szReZ6mtUNI6Mu8NLLoXAAQ8ornfk=;
        b=Mgkvo/oFm5aRKKOGNxfTQS6n0OuxqNwWil86oweq4MeNmbYg1eOOPwuRzGZNThrekM
         P/XMgkpDk9J5xYP1uZqaxnT4N8mLH/oEHA0GOXZSFDD6Rr7P0my9soq04vNUxWF7IErJ
         f7A5O+rfE/TbQKWmw72DJu3Eix+t2hLZDIfjijNvr4G0PmyiVaKzNOWMC+Eq80KHnFIk
         hzV7ef50Qu3xvVlyGfOCGs6kCCR0OZfdkXO8MB2hfLMHAebhVLwNFnk8kt9FTnsVQS9f
         mMKmuRzmSpSPmGVnjKrRsS/V+TiHAJr37/aqTKaIm6XacUSxvlojy4+P4QbLGyyy+PcR
         8ulQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789685105; x=1790289905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kG9wJf7wOlOfl2szReZ6mtUNI6Mu8NLLoXAAQ8ornfk=;
        b=mKlBOOwgcDY43zL/niXB7YDMsQlQ6YP+hYwvcAJrGiRAMP3EMUxm1fsc1J+Fqy7w+0
         CBeow00YhEf2m9b4flx0m25XJ912iQsP2kRgzp+qAdjEF/ZDVW5MoszVOrWmqJ8xyjPT
         Bw1hI/biwW9bUqWL0hJcHqc3SRMW+6eNqUj5GKBheMDaZ82Ln3oJuv/dj+7epbX/vHxj
         5r0y/CY3qxYC2ZnwzIos996FboShMvMm5k9pOMMaUI0+M7giN7WaECav0XJjTs9HewSa
         M7D9cvSEUSSayHkbWrtbYhTLQHrMmr3nprd/o6fMxhXz7phFC25fs5Z6PH+/FEqMFXIW
         RomA==
X-Gm-Message-State: AFuF++lHIGL+Mupb6JfnhYXTN85ByN7szvVowtDUtSSUJ03XrLVVqwvP
	OvlZJF/yeqDWEI53CjjPBIeo1CuJzvGCuxyUI9b87tPOb1tXWn6DVrQZBE7OAvXqZ2iAXfI16yU
	qJ4kHtyaYmPIIPhpAdt858fxGWtfVAJ9aod4W01+G+DZsGVSBQ4TsZ6Mm/aMzgSCOSls4olFWhh
	XxsaSaE53Oz17QFBILG4FnJOPZQiq1tA3a0U1p9W8sI9xsfOw=
X-Gm-Gg: AYBFou2Bt96rJaUiOBL2rLUpR3MVSYB9/NqAElZPqOmDxNXfKEUXMSTIfXJXTwu+v0z
	vQZXjPbeHDlJ1ziC89CDMeU6EM2AKpZo9hrZjD61dOmhrxLyEkFivOsoWMnqep3IIPIy6pxOdX/
	oq9kj6QpK+5MjdWbfxnPQpp/evoo9m6PoJOza9XyecmEwW01jRDhF9EL6a3Xe1omewBI53Ki9lw
	4pN/5aoxDlqezVvUb1DVcXd4p4r9h4yu3B6n8m44XcmL+Uunchb6Ob1C1uum/nFFOnW9TrchOPy
	gn2NlPA66uuBorLbQd59qK7gmi3TYwBygzg6n43x+rVOCsigpmB2E/VyOfHY8lSf18Ckmj8sQg5
	PKhzYUlBIHKdwnZZg7d8rQCo51qs99OE4Veils+sqywLgOOUamM4MaSSv/K1CwN2klp1JFnx/R0
	sumWcUgMQBKpMgcFgUUwIaP56vPwzD8SyrcbGgWY3Uc8LXlIbDUfoST6HLNGZJJLHwOjSvv3ZWz
	JtXfuCeZT0ReIF1c3JNd9Vs4+qGxmBAwINGGcRvPRLlx41nuC+Rhkc9p/hI557cQ5hzkmW33RdI
	VABsYu0NbstRhMp7UNsuAGca6hA4Dsr436uqNqfCQZa3FynypFjYOjgAS4hn8mKXg8DDtcKaUeQ
	6rSZg5zp6Rjt4szK3v28Dky8M/egv
X-Received: by 2002:a05:6870:89a6:b0:485:d31b:775c with SMTP id 586e51a60fabf-486e7310238mr612723fac.26.1789685104548;
        Thu, 17 Sep 2026 15:45:04 -0700 (PDT)
Received: from dev-rjethwani.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-4870ac16ec0sm88605fac.5.2026.09.17.15.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 15:45:04 -0700 (PDT)
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
Subject: [PATCH net-next v17 03/15] tls: reject rekey attempts on an existing HW-offloaded connection
Date: Thu, 17 Sep 2026 16:35:14 -0600
Message-ID: <20260917224355.2288021-4-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260917224355.2288021-1-rjethwani@purestorage.com>
References: <20260917224355.2288021-1-rjethwani@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On a TLS 1.3 rekey, do_tls_setsockopt_conf() must not set up a brand-new
device offload: reject the rekey with -EOPNOTSUPP for a HW-offloaded
connection (HW KeyUpdate is not supported yet, and we must not fall back
to software mid-connection), and for a SW-offloaded one re-init the
software crypto state via tls_set_sw_offload() directly.

Do this by moving the reject into the device-offload helpers and shaping
the dispatch in its final form:

  - tls_set_device_offload() and tls_set_device_offload_rx() reject any
    non-initial call (tx_conf / rx_conf != TLS_BASE) with -EOPNOTSUPP.

  - do_tls_setsockopt_conf() always calls the device helper and, on
    failure, either propagates the error (rekey on a HW connection) or
    falls back to tls_set_sw_offload() (initial install, or rekey on a
    SW connection).

Prep for the following patches: "tls: add TLS 1.3 hardware offload
support" drops the TLS_1_2_VERSION guards in those helpers (which today
also happen to reject a TLS 1.3 rekey), and the KeyUpdate patches replace
the reject guards above with real rekey handling in the helpers, leaving
the do_tls_setsockopt_conf() dispatch unchanged.

Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
---
 net/tls/tls_device.c | 18 ++++++++++++++++++
 net/tls/tls_main.c   | 22 ++++++++++++++++++----
 2 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index f11d0528fc43..f5e1b6b61ce3 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -1077,6 +1077,15 @@ int tls_set_device_offload(struct sock *sk)
 	ctx = tls_get_ctx(sk);
 	prot = &ctx->prot_info;
 
+	/* A rekey (setsockopt on an already-configured socket) is not
+	 * supported on the device offload path yet; reject it here so the
+	 * caller can decide (propagate the error for a HW connection, or
+	 * re-init software crypto for a SW one). KeyUpdate support replaces
+	 * this guard with real rekey handling.
+	 */
+	if (ctx->tx_conf != TLS_BASE)
+		return -EOPNOTSUPP;
+
 	if (ctx->priv_ctx_tx)
 		return -EEXIST;
 
@@ -1202,6 +1211,15 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
 	if (ctx->crypto_recv.info.version != TLS_1_2_VERSION)
 		return -EOPNOTSUPP;
 
+	/* A rekey (setsockopt on an already-configured socket) is not
+	 * supported on the device offload path yet; reject it here so the
+	 * caller can decide (propagate the error for a HW connection, or
+	 * re-init software crypto for a SW one). KeyUpdate support replaces
+	 * this guard with real rekey handling.
+	 */
+	if (ctx->rx_conf != TLS_BASE)
+		return -EOPNOTSUPP;
+
 	netdev = get_netdev_for_sock(sk);
 	if (!netdev) {
 		pr_err_ratelimited("%s: netdev not found\n", __func__);
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index fbb274287aa5..15e83e853f22 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -713,8 +713,15 @@ static int do_tls_setsockopt_conf(struct sock *sk, sockptr_t optval,
 		rc = tls_set_device_offload(sk);
 		conf = TLS_HW;
 		if (!rc) {
-			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXDEVICE);
-			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRTXDEVICE);
+			if (!update) {
+				TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXDEVICE);
+				TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRTXDEVICE);
+			}
+		} else if (update && ctx->tx_conf == TLS_HW) {
+			/* HW rekey failed - return the actual error.
+			 * Cannot fall back to SW for an existing HW connection.
+			 */
+			goto err_crypto_info;
 		} else {
 			rc = tls_set_sw_offload(sk, 1,
 						update ? crypto_info : NULL);
@@ -733,8 +740,15 @@ static int do_tls_setsockopt_conf(struct sock *sk, sockptr_t optval,
 		rc = tls_set_device_offload_rx(sk, ctx);
 		conf = TLS_HW;
 		if (!rc) {
-			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXDEVICE);
-			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRRXDEVICE);
+			if (!update) {
+				TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXDEVICE);
+				TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRRXDEVICE);
+			}
+		} else if (update && ctx->rx_conf == TLS_HW) {
+			/* HW rekey failed - return the actual error.
+			 * Cannot fall back to SW for an existing HW connection.
+			 */
+			goto err_crypto_info;
 		} else {
 			rc = tls_set_sw_offload(sk, 0,
 						update ? crypto_info : NULL);
-- 
2.50.1

