Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2623B42E004
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 22:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789685127; cv=none; b=Lf6oIvUw7mDa7mREsnCjkLGVRuuQVVY5TKIZriSdaRpc0uzYienr7okl0tEiyVbeQIdZJrSHoqYyMHrssHP00y1chEzgFsLPAG3tcEuivDYaLOcHZd0hkJ2tA9EP1xOJr55bCWDrScTxsqR0k33uC6AqkDN7oy4RYjQVwDLE+Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789685127; c=relaxed/simple;
	bh=MTPJOtY6YdLCIQ5+9EOxOLUGY9+hO6vW8XFZ2+ibEVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jVfzgjrx/DKMfv9cRQ1YyYWr/aewKPBlzco43h/gQDD7+SlmF+zRFvDB8I94XqVXINwuodbyk7PICXE9CCgrz6DgToSvTaHWA6NOd7NRFVaFbrCgK/DJxSINF8zmqYHo9BxAsDQ0clWwstTIAivObf+314BVxxoTaLr0rFjlmzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=KNqY8CyA; arc=none smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="KNqY8CyA"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-46accbdfc39so207304fac.3
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 15:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1789685125; x=1790289925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RTDof+oTcBq6BxPYnHQgwWpfwqaFH61rIq/TMQyw0HQ=;
        b=KNqY8CyA1XadsfOLx/yyrlV0VCBot2brfkE+Eu7dw5ibZYveOAUp60bakTzIifmrnO
         Gh6VT4dBvaxAqeJY4I+Qkll1H+rdCYEFHwCoGUXuFckCE8/Zab6JR+p6C/X+A1kKazoc
         N/bwAUFnyg2B7dvQDSATgHdNHLxbtFZnWjvoS42uK1m6apswCc9/YnJCMVe+dXUb5s6z
         +ke+/xMaM7dR/+au+D/1d7UQjR6KgtUdSjdA4vCpND1OYJa5822FiCrSzvEb6402GpyE
         QlOZhACoOf+5UK9X/IpWxoSwN7WNrDgsw2sewmSKQvEfO4yRcuX4H9GiJLh07894M+QZ
         cOOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789685125; x=1790289925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RTDof+oTcBq6BxPYnHQgwWpfwqaFH61rIq/TMQyw0HQ=;
        b=Z/ROxIG65mIfJidg0ebRYXdBA23i9rCk2nbYCIOBB/8vQEPwF4TilSYXPJ1fb5kBmR
         fEPSAHFA9zJLDG+sBjsXuYTnsBlStEIyQzeax7QWAGOuvJ2TkClRBGVp4UpQTtcTtp02
         d/4hhd7Eq/KmMOixr6pkkV9U7W4WcbaO67v6YIxy/4AXlW8VlgntrGQ3jKwJY0vDKqk0
         CsCNu+DAbpr4OF8+Jd++mOLzag04WXzwtThS4au0Ud+gOYfNuFQbQIm18LWuBbnudLad
         Lx7wbfYZjRDUQf2VyU6E7htkdC1a0/XepG8zyH98R/FKO6wd7Ivyeq0NX4vfoznJhKmO
         FCcQ==
X-Gm-Message-State: AFuF++nwYtvpGL74YYu5Yiq+qyhKEDoq3GGJKYlKWQQ/D/owm9jashDv
	Xs9Hx1dTbDRTxd/GOuuwmf7Vz+dh7VB8nXRVC/REkujTnCrQYR8hQ20JH5ZQ69ucQ/h7ruI6wPn
	AvUvnOqd2oJhnxDFpBcb5LwANuLO+2HT2HuQjT9hx5yckepe30eyzIypBTp043B3fUAtABz7r2b
	lzycPW04PeooaxUNczigLBiSFUDvwyW/MnYX20QNiygIUnVn8=
X-Gm-Gg: AYBFou3zmNms9zjrz/I6WmORja4DqcsRgi4h7/FTlCSwctCckvN0RD7Gm67wL6OFJXc
	bJxOnWzXA82TyQYkKI5GPogIgKmeqYSb4dEK/GrX3VmDd/WmJNDHXegd4bdrNOGA61zJmAoHq8E
	KvJjYi+nuEC833yPlrwtqI/NqKpgZUTaPA17Z9ZS7FRwLG/Hg3iIASMIsydkkgFnC9R3/wVBhvK
	0KwJu79OxLG93yavqoI5tvL9AQlbsvwOCZcD1o515rjqjf5i+fD5cIKTgQIF0UTRdo7ecDecNYy
	Dg3TFkXojJ+yUaA4HLmyeeFj0AHASmP51Si7Bc3C3RGnsJXXGdCTWfMi93TLXR2mfLRM0/hMibL
	BXsJbsd3NNLWstGWNi/7VAWeh+IY/mGM5Zz1d05ZvzWGAC3Gd4/1tcFDHQrfQmmXTCJ/GeOGyW6
	LD6BZunfkTLcPirvX9Jtq6m3jWj+7r54nxod25dvv3gIN35ROOzlco58ZH/6Em4TSZVdjHpF3Yp
	AuSEQU18xv8qa/LMsQsrZeQYdmOIOTzn8LyC9bbGeIF+sIluRqNfnlR4uiY9/MFpMT5tJcL0KhY
	U903lG4ZVVqi5lCvGZQaQntTONazNNEU5Cc2+vBapttAS6Tu6W/HFFpNFIXVI7Gqf0TpwhaI4Vg
	YOz8fWrB6h+9WeEKMcBf8juL4yN0x
X-Received: by 2002:a05:6870:8452:b0:482:58c9:b675 with SMTP id 586e51a60fabf-486e70f85aemr597420fac.26.1789685124728;
        Thu, 17 Sep 2026 15:45:24 -0700 (PDT)
Received: from dev-rjethwani.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-4870ac16ec0sm88605fac.5.2026.09.17.15.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 15:45:24 -0700 (PDT)
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
Subject: [PATCH net-next v17 09/15] net: skbuff: add skb->decrypt_failed bit
Date: Thu, 17 Sep 2026 16:35:20 -0600
Message-ID: <20260917224355.2288021-10-rjethwani@purestorage.com>
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

Add skb->decrypt_failed, set when hardware could not authenticate an
skb's TLS payload. The payload may have been transformed (XORed) or
left as wire ciphertext, so software must re-authenticate the record
and undo the transform on any XORed fragment before it can be
decrypted. Propagate it in skb_copy_decrypted() alongside
skb->decrypted. Guarded by CONFIG_SKB_DECRYPTED like skb->decrypted.

This is a prerequisite for TLS 1.3 device-offload RX KeyUpdate support,
where the NIC flags records it could not authenticate across a key
change.

Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
---
 include/linux/skbuff.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 421f6fc45451..5da2c1149d98 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -851,6 +851,10 @@ enum skb_tstamp_type {
  *		unreadable.
  *	@dst_pending_confirm: need to confirm neighbour
  *	@decrypted: Decrypted SKB
+ *	@decrypt_failed: hardware could not authenticate this skb's TLS payload.
+ *		The payload may have been transformed (XORed) or left as wire
+ *		ciphertext, so software must re-authenticate the record and undo the
+ *		transform on any XORed fragment before it can be decrypted
  *	@slow_gro: state present at GRO time, slower prepare step required
  *	@tstamp_type: When set, skb->tstamp has the
  *		delivery_time clock base of skb->tstamp.
@@ -1025,6 +1029,7 @@ struct sk_buff {
 #endif
 #ifdef CONFIG_SKB_DECRYPTED
 	__u8			decrypted:1;
+	__u8			decrypt_failed:1;
 #endif
 	__u8			slow_gro:1;
 #if IS_ENABLED(CONFIG_IP_SCTP)
@@ -1716,6 +1721,7 @@ static inline void skb_copy_decrypted(struct sk_buff *to,
 {
 #ifdef CONFIG_SKB_DECRYPTED
 	to->decrypted = from->decrypted;
+	to->decrypt_failed = from->decrypt_failed;
 #endif
 }
 
-- 
2.50.1

