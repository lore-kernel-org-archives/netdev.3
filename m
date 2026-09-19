Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6BE349B15
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 14:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789828736; cv=none; b=sj+uIthAPVovH9DcialaERkXGNHUMhYuaQuoX2jhQRQy7dpasX7PiMRwpnEHhSe9BIo4PO4Voaknp74SWtvtJ+75Emb4WCm0fXftX6s48keFOtBbg++zOinFiA6vUQZGEjy/XjoCePVbBs9itlZeN0mEd4hr8GnNLmRy/IH8QPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789828736; c=relaxed/simple;
	bh=CyLVBdF6HZsyd/B8ZtdVAcP2QBNL8FUqGKolgEHBUho=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BiryO/kg297+nFjSlIeJ52YE6q5t0zP8Mna+mP84ppRfrPWDrUKiANozIyimtUJxdRNbJumuxQ8zOqHqhe9VKw/b3zdv3p1Jbk/TYfMHjrbz4WRxOCV3F5Cng9HpPhsJ9CB/3Ajprn+hni5mg4JmzN/QHkuPr5NvrRlIvk6Hyy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hy1ds6Ve; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hy1ds6Ve"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2dd4b43b20bso11539835ad.1
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 07:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789828734; x=1790433534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hsFrPyRZipOaZhEq/8OQA/iN9lQPDPtm3xyWhXDtLjQ=;
        b=Hy1ds6VeT6CEiGHKFJ0bKuU+98QVBAYZde/dp4cFuRK0D4Segv8bvU/Tdr813U4jRb
         Lp2C7YCERv8Rh7L+JzLMZnniACvyTKZ1NztBlFZRdaHY3tjza4TGnOZTADy7WDnv5Ivc
         lP66tW22/pd1tMTEzaJW3L+4I8d+7HlM5QO4r5BZ26569XlVNjlLrTmMFdDMdBqsttii
         RGf6gCEnw97oKFOOOOMdxzedYIO9A5XnIhFkW4j3w+Vu+KJaiLdsLd51OaHFkj23d+To
         njmG3vN1daPdSj8v2eGlb0I/RnD1dcfOyuVRCQx122IWc4ggT+IFu7GMi8Yez+VR7A7C
         xlwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789828734; x=1790433534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hsFrPyRZipOaZhEq/8OQA/iN9lQPDPtm3xyWhXDtLjQ=;
        b=InF/y0DNMcKpNPbbRtJ8+uKC63ysQBxqS7/N2mu5ATENMN3ghXSg7dQkRMvSEume0T
         6sg/yCoby+dYBgKIHW2bxBNEBu/2OAw6gvS9EYm3kbgRifW0vNRW1cf4PgbTV89ogC4B
         JMbss92PpaTUk4a4b8OBzwQa3KYFaOddrMYAzOwcC59wc2o6ny1oqz0KhuQh7fx8TfqD
         humYepWVX5cIypVO7IVlLuXeDz+A8e8iWsJs3pjt0S2h+tfmbo4Q81BnsarBF9bVWq5T
         /tyGaVSoed7HMAal3AgneuTFsb+bvyddi3+x3ZZx5WUq5cP3Is4z6vIwiduLmW0pYlPY
         gZ6Q==
X-Gm-Message-State: AFuF++m3pXTIhPkGAvJ6vIDW5IgDhBBe5cDTtg2CnTJvX0vWKew5X522
	VlrtwOF+qti10oRRcyB/5q3ZTRH/XXw/B6fv8IjPlkQXdnOk63MqpDab
X-Gm-Gg: AYBFou2jSk3/+5DeUr3J9RhAP73ARyRCItQwwoxK5iIxT3ZNA07jFKbyCYm2HgL7Pmu
	qmiTyKyDdXPXEc4+2vf7UMVp6BDFk/0MNbF11rXx9apQDN2OKsjVXApSuVULg7nVBt9VT7spN8j
	Dpv6tTi3hliJpyuV54V0aZdZYeVK9GlKdmHE2wh280z51rtOz+jX09+wC8gOo6vRRUSdUITLLNs
	1jBBKKRgh6gtNEHUqGCMvZ0NYLoN9XXtwayqWdu4JE+HPCbkmTxJyzUA5tvPALQk+Tfv+Ywu/PL
	2okfd+S5EgwfENcCfL1TPezNMX4o/r61PctEHBhkeLs7WTiTWz0Ar3D/lU2l2qClIX5U7IzywJt
	+5Dj6aIJI7OJUUQ3uajVXc79BI9fe217Y9HOmHGLBY0tqatH7i6qlZ1/TBpsfgemI9kcBY5yoFe
	prgmliJ2rDhsLA5UAenud4BokSCr7kBR0w2QQ1SoI7MoPceXzd+UqwqvDj2XwfZ7UYoaBb8lPAy
	iw3jANFD0tzOMUzAvnKoiiLVVXMy/Bev41oMaNbXojBbxUlw0zuf63jt/EsjrKXtLS/ubrtAUc7
	Xkx+XXd+EpHsW7VfkJihRB55/GejGyzEAbipkaPXbAeDUFBuSl0q/vNQohk=
X-Received: by 2002:a17:903:4b0d:b0:2dd:c100:424c with SMTP id d9443c01a7336-2ddc100456amr36507175ad.48.1789828734264;
        Sat, 19 Sep 2026 07:38:54 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc179ed79sm10711715ad.43.2026.09.19.07.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 07:38:53 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	willemb@google.com,
	kuniyu@google.com
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH RFC net-next 2/9] bpf: add bpf_ktime_get_real_ns() kfunc
Date: Sat, 19 Sep 2026 22:37:25 +0800
Message-Id: <20260919143732.11772-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260919143732.11772-1-kerneljasonxing@gmail.com>
References: <20260919143732.11772-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new BPF kfunc bpf_ktime_get_real_ns() that returns the
current CLOCK_REALTIME time. This allows BPF programs to perform
accurate delay calculations without clock domain mismatch issue.

Previously BPF programs only had access to monotonic, boot and
TAI clocks (bpf_ktime_get_ns/boot_ns/tai_ns), none of which can be
subtracted from a realtime start time.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
https://lore.kernel.org/all/20260518082344.96647-2-kerneljasonxing@gmail.com/
---
 kernel/bpf/helpers.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index b3cc5c8fc875..7a0db620a273 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2335,6 +2335,11 @@ void bpf_rb_root_free(const struct btf_field *field, void *rb_root,
 
 __bpf_kfunc_start_defs();
 
+__bpf_kfunc u64 bpf_ktime_get_real_ns(void)
+{
+	return ktime_to_ns(ktime_get_real());
+}
+
 /**
  * bpf_obj_new() - allocate an object described by program BTF
  * @local_type_id__k: type ID in program BTF
@@ -4972,6 +4977,7 @@ BTF_ID_FLAGS(func, bpf_task_work_schedule_resume, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_dynptr_from_file)
 BTF_ID_FLAGS(func, bpf_dynptr_file_discard, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_timer_cancel_async)
+BTF_ID_FLAGS(func, bpf_ktime_get_real_ns)
 BTF_KFUNCS_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
-- 
2.43.7

