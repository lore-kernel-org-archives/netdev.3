Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B843AFCF4
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 16:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255297; cv=none; b=uNxcqUGU/MKfDztKj9676hJwU9aGnjrFUxREqd7UQWOkTsJi8nZGEflh/6s+pO79OU4H9yHO4viIrnZKJS+oOaWbqpV7N7Z5f70RXdBU9LypJI1u/+3MFEWUXNyO1EOY6auocb/xZnF3zFCZWTVPQ3CWDA6DZ76icGMbo89KUVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255297; c=relaxed/simple;
	bh=rWcVk57bd7XJ6aqHjIBKbQ1NUfIUN7X6g0abtAxWmhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BXowkNM/DzKAlerL/cjKaYlKbHzH055f6AuQ3Q4c9v21NKvNuBfTYCDA3hIulEytaLYHtmCMlZtzjvnJywwDo2eXsvAkwqJebSB5ptLYygs1rtPZlBc5S6YnZ3AAIlrWEt5aN6Qi3ncnu3bOTznkKj3H8G4XBGO/Pd/kg2aB8uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FEI/CzTY; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FEI/CzTY"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2e9d1114320so246575ad.3
        for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 09:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792255295; x=1792860095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NdXziGzorg1BVqALTIMKJSo9S3AbmbdZUCYUiZVmWiQ=;
        b=FEI/CzTYq4YHlbz75Rb3ewLU7jxxgW+7RbqfwpnDrG03QQLJqIuOlTKfbtBNf8vwYX
         zX70WeqLfW9r3ir+e3fjDj0R7zTcVXGqRONC27SFm9uED/DUV5Ilseafp+s3TbarigkB
         0LpuzXb5XRmMsVcERlfrWx39oybPTHRE4Sg8QYqlLZ7bY7dzAho5wZKysLm2CvPtamga
         ZEjt9/eDFeLo5QJfWAlFlPV9L9uTgaHkstyXUirTqsfC9hc4LVJALyUR1+HWV6nUA1/N
         wPLiub8eEVoeKmkLTcaA0zM4xK3RIUbscqvzgI0gDm5QfoukxalV+KAPGHZmRRh1A3pl
         LQGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792255295; x=1792860095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NdXziGzorg1BVqALTIMKJSo9S3AbmbdZUCYUiZVmWiQ=;
        b=PESCphLXErlF/iSZusVKiZ1Yc5AKexMoMfolbs3VZq5L5cbV/id6CqmvVDwV6U/TTh
         e93Kcl0uge+ZU535oNV1GZaSi5BLgFbN1jUCW6TUdOnjy6sBKB2vNvymtx77bRgaybz+
         DaH81lN8xQNY6i1xpwWnJIIBfA9XH55P06KGHJaQ7AGxLyZCHeLIe9KuEwBrMw/xgS6G
         ubye9sInQmaZzgnV97ztGAwUSQOxaWjvpEZ3R00RItKo8adRV2CMlLjBLXJhCJ92ztrA
         RbwxpeUZxiHeREgm0nUYi//XhUKC7OPRwWWR+UOXw3gY56Ayg2Zkr13MtlavImfkBQLQ
         z4Tg==
X-Forwarded-Encrypted: i=1; AKwUvBxnxKhIOZf2Wqh5ln30YDUKtFyf2uRO6cHb8ascsEDukIJM8WFH3HW2nFBUarXp59IxjjHd4Kk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJcCCA8Dx0W9txu2NLrnAUUR0ekiJcoEHvnD81OpxfRQWxh/P2o
	AvHZmaH9WEktp4cnB3esM9U7HSv98ZW8bigYD+Grzq6anawKiT5sBFKJ
X-Gm-Gg: AYBFou2SXGV6QMPXAxtYay2Am7FZMTb3JSLMhFmpHxgV5/XBK0I5txwd5U+QsVcU2+W
	c4pIkfuI2lhTjVjsQ5n8mFxuWOK5VIzkSvLUvb//QnMA9xqfkQsEsw8swHPA6q7cUYBoOip0ZjB
	3hAq/VNt+xcExjA7u9tZjAE1OIU5S98+35H/daWHaw3uj97l2DCglTNWq66iJirPSC+TY1isAlG
	XQ14GT1WrPwfjh46YaGxuV/+3uIvoU4zrYVoaiPaWU82ZI1W7fhdk40gWtpnfRdK7OFYRBQMue3
	hlNbmPYIaa5K09+vfectOO6XlT4pycNIDmFjsmc1OLrtT71Von8ehHsX9DJCpfbFpSTrwoT6SLU
	AeJebEv9Xaegu9fZNWAO3iMRqRiBwQwY7LknXSCNhCFErqzeC3q2+GdIDURgC568F/5o0Uq7xEf
	/jskk9HD3mj/czW17IbBkotoD3khKXObEzfRCmMyM2Swkm/yR0RGYqxg7Oev7GBMvOpr0KsSr8H
	r8qE+QbUiWYdPX3nrcmwsl+dA0kDcAm5CVjuBfdrx+Ge/O+p6RNAVfA/Ok3EPewK2RmlApunIvD
	KPhj2bp5YHE+Jvygf1UZ/k9oLRSm5ZYFPQKkgwl4Dzs=
X-Received: by 2002:a17:903:22c1:b0:2e9:6788:9372 with SMTP id d9443c01a7336-2e9a6d3668fmr29282385ad.62.1792255295091;
        Sat, 17 Oct 2026 09:41:35 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e5d51a6sm23265505ad.12.2026.10.17.09.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 09:41:34 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next v2 37/43] bpf: Let bpf_dynptr_write() mark a global function
Date: Sat, 17 Oct 2026 16:37:39 +0000
Message-ID: <20261017163745.3341787-38-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017163745.3341787-1-alexei.starovoitov@gmail.com>
References: <20261017163745.3341787-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

The caller of a global function loses its packet pointers if the function
may change packet data. That is found out by a scan for calls of the
helpers which bpf_helper_changes_pkt_data() lists.

bpf_dynptr_write() is not on the list, because it depends on the type of
the dynptr: check_helper_call() looks at it. The scan cannot do that, and
so a global function which makes a dynptr from the skb, or gets one as an
argument, and writes through it counts as harmless. The write can
reallocate the head of the skb, and the caller goes on with pointers into
the old one, which has been freed.

Let every call of bpf_dynptr_write() mark the function, as a tail call
does. The same mark decides whether a program may replace a function.

Fixes: b5964b968ac6 ("bpf: Add skb dynptrs")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/cfg.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
index bce7b5abcfda..2ee950e9ac82 100644
--- a/kernel/bpf/cfg.c
+++ b/kernel/bpf/cfg.c
@@ -598,7 +598,9 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
 			 */
 			if (ret == 0 && fp->might_sleep)
 				mark_subprog_might_sleep(env, t);
-			if (bpf_helper_changes_pkt_data(insn->imm))
+			/* nobody knows yet whether the dynptr is that of an skb */
+			if (bpf_helper_changes_pkt_data(insn->imm) ||
+			    insn->imm == BPF_FUNC_dynptr_write)
 				mark_subprog_changes_pkt_data(env, t);
 		} else if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
 			struct bpf_call_arg_meta meta;
-- 
2.55.0

