Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55084973B6
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 22:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789685130; cv=none; b=HrTGC0D0h32haWSg9o64LLmgw3YMWAIQFuZwQXCSu9YfWMcwEyVtdKRWsT8vs2+91mFEhohkeS2EeQyiTHER4ZPKsDE2QfaWursK7FG5xwOUPivQ6rTFVkB94umDWVGdSShRTeEPqLbxGrklakxLEk23jDCMS9kgRzqZA4m8Lxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789685130; c=relaxed/simple;
	bh=GaR7tK72UhOYX6a8NhLdaaBsymEAInGZ0uaE7GTJ4z4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gF5HvOme2k0hhjXo7YThRVh4anK1F/aw1aLWz49LgQ0H0JORwpPE/hnrxemOQoe2kN5V4KuEynPFywvZg5nN8czLUE8TI/IzEjHhY/b+muZq0XVyOgiCw6RjX67+j1CaktvfCsThWcMx3ZfUTVQMTkdCv1lXi2doi6CmbK5EAnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=U/s4jPnK; arc=none smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="U/s4jPnK"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-46accbdfc39so207339fac.3
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 15:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1789685127; x=1790289927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T/WZvUy/msibnqIoVEx8FYOzBJZt5qmYfHMJmhBcZqY=;
        b=U/s4jPnK6CgDESjuA0VLmCXiBsJcpvj6wlWs76ZpZW7mD9Zzinqzt+Lyq3I4ncu2Sd
         FLxeCJSs/IQJQ6ZMRrdJkp+JTINamWkoRtJZdVUMrI+aEBvyf4JdsLyk9BeM0vgL7P0I
         qcXcfsxt9xRgJ/B+3ugf9irvZopYHnXxqDg7GEukDYiC/yZ36cRLOHI0OQru/WgBmZj8
         E11mE3+2iZY7AWVmgaQztFhyQRFZnerGz/lL6+R+pFak2euD7/viDBotDsUz9vLUDE4n
         8VYJEbpVyMYE3Hhd7BLDUv0Gu41O+mCpYHiXq3UEIH50BkKCXc2m8aMnlxonZQloyPxT
         07XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789685127; x=1790289927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=T/WZvUy/msibnqIoVEx8FYOzBJZt5qmYfHMJmhBcZqY=;
        b=R9I5l7kt3vAjc6kxedaRFDo5S/MfoCABFCzLNKybEgoP+AV7he0gkYVc0MWMCmmEv7
         LYzF8VTNVEQIrotJa+3Yjr7rrP/hvaBoieqqcXUcORA5x8fJgBmxLGxaYHv501Ox+zN8
         9Uid5LY9QTQcWS6RFyGorVU9W8EOsHDsthJvxTHay12BdkXdHFBTXDbG3VCYR+xwO291
         9juBQirw2lXzvbnSoV4tFK9zQS1xmo6o4WS5AQQ81uM4oxp21EolhO6DCBn5ohs1ir9Y
         67wiGwsUPd4ZlqwWMypa4JeHdwAF/cQEvynX9H67FeYv2vhVQFoUERs66zqU7x2NEzXC
         eaOA==
X-Gm-Message-State: AFuF++mIQGs5yxDAjVbbftXayEUHj5Idp7ugi+/Y/xyshKaHPu2zSt0S
	ejfACO9n0aFBz3XR2RCM/lUFf2W6SjIKHXj+EPQhvBAfk7Mfk4nFhmSJ+GuW8EOFyoV5shTbq+B
	CozLRLN2TvxGH6XYhpgY2XWscvePWKVzW1fBhnMMDo4H4aBMmWwy7xQwsLn45KUBKACfBMOJhkX
	qSVT2p7vrdhRWPjRvIK6u2VfihXIxfQfIOFn/069N/JyJAU7g=
X-Gm-Gg: AYBFou1NPhUI0pIME74dNoXs891aFolkXZnwW+GXq6FAQw8kFCWf3HCA1KqNUyRL+1J
	QWrxHmRNGakm7kRAtOdgSGa61pWurpFAxXAZWgz6Tc+nu5ThnAnqriWlG94uGVBeOeUshuyVTva
	RgXlQ+i5XOuPJ9gLMQOjsSP/44WzkeLENu0vQrp65zMQxvHZuCg3De/TIzcEN8TxUEpV4TMyu6K
	GMUSeLu+AsaleN3WIqi5WwTqPX9V+ewC/eO0G2Ep++LnOSYO1bqVmKP93FkrLTgj+tjoaE3VeJm
	o/5vGtSWbvATQ7m+e8+YQB7ouP++U0P3f9Q/jZKGTrdUG+4mm8ZHRLrQ3LSalqPUNoJxBaE1U3E
	20Y0Pe4pvFw6zIhMJbZZPXQXZwIEMbJ6p94O7NZhQzSF4SBCEqZGYHiW1LTwQBtSjfePKEYvPC2
	AZbUFPBi0dQK0YRgmRyeyWYV947F15qAV9jNmq9bY9ogxzb5SeNlDSM1IXCVikLP0OfB+4aaekS
	t/e/uZh9yTE9kRVL/n9YCeEIhysPO2wgkfmLGEVaTXsewxv1s5hau0Iv7qLRXrk4ORz+32b9f4W
	rkewdR4grMvP0jVLe9pBE/85urJW4r0kP9yXHvziNsoRaNdBdoviHutLKNty4veAYRF1LdiIOP3
	rpx7vpMg0wy4ibSLKSV8=
X-Received: by 2002:a05:6870:889c:b0:448:89e3:4c58 with SMTP id 586e51a60fabf-486e6bc2f3emr664748fac.18.1789685127406;
        Thu, 17 Sep 2026 15:45:27 -0700 (PDT)
Received: from dev-rjethwani.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-4870ac16ec0sm88605fac.5.2026.09.17.15.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 15:45:27 -0700 (PDT)
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
Subject: [PATCH net-next v17 10/15] net/mlx5e: flag TLS RX records that failed device decryption
Date: Thu, 17 Sep 2026 16:35:21 -0600
Message-ID: <20260917224355.2288021-11-rjethwani@purestorage.com>
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

On CQE_TLS_OFFLOAD_ERROR the device could not authenticate the record's
payload. Depending on where the failure occurred the bytes may have been
transformed (XORed) or left as wire ciphertext, so set the new
skb->decrypt_failed bit (skb->decrypted stays clear) to let the stack
tell the two cases apart, and fall through to the existing tls_err
accounting.

This is consumed by TLS 1.3 device-offload RX KeyUpdate support in a
following patch: the re-encrypt path undoes the transform on any XORed
frag of a mixed record while software re-authenticates, while a
non-mixed record stays wire ciphertext and is decrypted directly.
Without that consumer the flag is simply ignored.

Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
---
 .../ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c  | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
index bca45679e201..8ec40f5fd5b5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
@@ -602,7 +602,18 @@ void mlx5e_ktls_handle_rx_skb(struct mlx5e_rq *rq, struct sk_buff *skb,
 		stats->tls_resync_req_pkt++;
 		resync_update_sn(rq, skb);
 		break;
-	default: /* CQE_TLS_OFFLOAD_ERROR: */
+	case CQE_TLS_OFFLOAD_ERROR:
+		/* The device could not authenticate the payload. Depending on
+		 * where the failure occurred the bytes may have been transformed
+		 * (XORed) or left as wire ciphertext. Flag it so that, during a
+		 * TLS 1.3 rekey transition, the re-encrypt path undoes the
+		 * transform on any XORed frag of a mixed record while software
+		 * re-authenticates; a non-mixed record stays wire ciphertext and
+		 * is decrypted directly.
+		 */
+		skb->decrypt_failed = 1;
+		fallthrough;
+	default: /* CQE_TLS_OFFLOAD_NOT_DECRYPTED: */
 		stats->tls_err++;
 		break;
 	}
-- 
2.50.1

