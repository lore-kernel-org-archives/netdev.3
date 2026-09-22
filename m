Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FC456260A
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 17:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790097647; cv=none; b=FHstgdLamWvo7IDOlW+1WVAekDHCunXsblFeP/1zo1aQruvN0jZseIz4XIv6X2wvXElo5cO/B4F0gidvf0hMQ5M7jfoHM4pgN2w1AHm1jo49TuVtoCC/3++D+fdC7TeZWQZ4k0cR56nxB6afS9XeEJSz6PvHB8Cv9f9vcHxi+UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790097647; c=relaxed/simple;
	bh=L9TmFUkltNMaiDYftOPLxaplpNe94rPN0sOUsEh0AFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k6/xWx1cjyRSO886bztfUw1Z0DuF7W7gh1QTxtW2GrVFDJvLF0FmLrUN2OYlq/UPiA0qWjoJee2wcSQMonJFk2i4/CdDD2IUpgOMg2MrDWA0ADYnjfGmITgb5c1lH/nntYreIBQWgdbq5yEP0JMTO1FeXmCOKY3JlUC274EJueA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=S9ihpjPc; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="S9ihpjPc"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-398a1676000so110242a91.2
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 10:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790097644; x=1790702444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hl3c77EoYM1aOqZiOf7+XyVVsyKQOXFXmz+T1DEuNRw=;
        b=S9ihpjPcDbr+DDxLID3solQr7AQwKf3G6Mnht7wl8BH/1Z2SafUupSW12QppAdY4vh
         kKP4JYfETLtzJXlT5hvUMAHeEEhM/XIMkeTzQexFRy07+/l4ur4DnPlwVs8k2pYaFt1y
         Z1Hg5lZphTyJ3gET6IGPI5APFHv/e5/Yx7PCPdeJK9csL40BOfJBnJv7FsOgX+tO7JOQ
         jnx8IFS5Sf1x9cqKNywmW33qnr5Vl/8TW50Rr4MXHAWP7ftZ3D9BLMJgIvXVX8JqRUkE
         xXOel5K131A7tX+DJlRrT0jv158pOzXtN4d/q80x06jkSUY9YBYOhiaDg6WdJjnJtChT
         CLEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790097644; x=1790702444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hl3c77EoYM1aOqZiOf7+XyVVsyKQOXFXmz+T1DEuNRw=;
        b=OH0w19/BhHXEyPBWyiWX8ifyucK03MO3M/YAIPzscqbnTnd7JU6Wsx4DcaHtUyLVEE
         X1klvSdCyo/qv+t95br4o5tu+bZqoNmTe06JgPY/TmGzoxmRN+nPaEL8VnoQbaJKhN8k
         6Rz8GtHL8anWyudAbp6c2s0M9lm8Yf0+uBEbk8MsHzPyjCid6/UKhSivQYDWuU26w8ql
         636Hdpg6wHVgsvnuHiFlO8cSsB5TeE6oiFkNBU8WGJqAkIt87wNllIYmETSLQeZJ9V+9
         jYTQvKdlo1vbm9m6JD34NpOtEkiDIePqOMpZsOpA4OEC9VIHQ9DnLRwMU7fQiga8IIBs
         Hn3g==
X-Forwarded-Encrypted: i=1; AKwUvBwZjcFXwcRmiKkpZyd/1t43hxwixkMJgC2c7HlwKY8y/pXAB34n/m0XrZgwLCBdYBgXLdSgdZc=@vger.kernel.org
X-Gm-Message-State: AFuF++kWAN/IiEllVqw0lGZXfnVvPQn29PMhZJtPHgPxHX+Gibqago5p
	W79NRmbSdMUjLhWF00S2kR7293bXjCVl07LEIvtkIYvkzT5e+5qoFbU4FuCEzlpG1oY=
X-Gm-Gg: AYBFou3G7sa/l2swuQSOZE2bsg7yYVlfVYV9dOS+YR9P6udU1bEToIyvF4T0rJx9JkA
	w/2x9nTWeRMgeMTIfkucR4oebQUae3pQ3NULJy5MHGTSVPNVsFPiRHVvh5DbWNrCic+weilIH7Y
	DfML64HXwVBMEq52kT3tGJmvACYFBMBPSzm7bnzI1Y97R+OKfzUyggTtOLnEcB+gtye/NXDhf3d
	qJ7ukyZUrMUiBAUizGXiJ7O729+YqyzZqQb+E0xlvmL1w8POcwMxmEBcky2aXiaVVINB1FtTLqy
	Jdbs6pDM9xF3+s6hVm+BtENmle8NdoSIg8ILLQtLJoW12bJSSU68NaiHtvxayLPCnzAsq/wWTTk
	JNOzWAy2XPzF5RJ+qWVmSk3Br3dptndDOLxOuv1Ro5YAAfv45IgUYCNjpo1Wf9r6XjYawa4GJSd
	FtZzseqXvg8CUZcHO5eQ9YPGIbhlDSci3a7B2gIFwQN7mNlM6hE4HOzd/133hPBRDbRvPEiGMcd
	E1GElegFVccf0oYYXCKbGLaWmT+4LWTzuus1Sd8AA==
X-Received: by 2002:a17:90b:2ccc:b0:39e:58e4:dc2f with SMTP id 98e67ed59e1d1-3a07e56753amr137778a91.5.1790097644466;
        Tue, 22 Sep 2026 10:20:44 -0700 (PDT)
Received: from alpine05.ht.home (69-172-153-146.cable.teksavvy.com. [69.172.153.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a06cb7159fsm1774824a91.4.2026.09.22.10.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 10:20:44 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	netdev@vger.kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Nicholas Carlini <nicholas@carlini.com>
Subject: [PATCH bpf v2 05/11] bpf: Reject pkt arguments in mutating subprogs
Date: Tue, 22 Sep 2026 17:20:22 +0000
Message-ID: <20260922172028.6269-6-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260922172028.6269-1-emil@etsalapatis.com>
References: <20260922172028.6269-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The verifier tracks changes in how PTR_TO_PACKET registers'
bounds are modified across subprog boundaries. PTR_TO_PACKET
registers are actually passed as PTR_TO_MEM, which is assumed
valid for the entire call. This is not the case with packet memory,
where a pskb_* call may invalidate its memory region.

Reject BPF code that passes PTR_TO_PACKET pointers to subprogs that
may mutate a packet. We cannot pass the pointer as a true PTR_TO_PACKET
because we would also need to somehow pass the PTR_TO_PACKET_META
or PTR_TO_PACKET_END to the subprog. Since we cannot avoid representing
the pointer in the subprog as PTR_TO_MEM, only permit it if the
subprog is guaranteed not to mutate the packet.

Fixes: 80f281664f5a ("bpf: Support pointers in global func args")
Reported-by: Nicholas Carlini <nicholas@carlini.com>
Suggested-by: Nicholas Carlini <nicholas@carlini.com>
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 kernel/bpf/verifier.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d62c0f74c..71ad07a9d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10421,6 +10421,16 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 			if (check_mem_reg(env, reg, argno, arg->mem_size, BPF_READ | BPF_WRITE, NULL,
 					  NULL))
 				return -EINVAL;
+			/*
+			 * PTR_TO_PACKET get passed as PTR_TO_MEM, preventing
+			 * us from adjusting bounds tracking info.
+			 */
+			if ((reg_is_pkt_pointer_any(reg) || reg_is_dynptr_slice_pkt(reg)) &&
+			    sub->changes_pkt_data) {
+				bpf_log(log, "%s is a packet pointer, but func#%d may change packet data\n",
+						reg_arg_name(env, argno), subprog);
+				return -EINVAL;
+			}
 			if (!(arg->arg_type & PTR_MAYBE_NULL) &&
 			    (type_may_be_null(reg->type) || bpf_register_is_null(reg))) {
 				bpf_log(log, "%s is expected to be non-NULL\n",
-- 
2.54.0

