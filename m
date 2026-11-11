Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794367314;
	b=ou+OngJSJR/3Zq8gL7ZJ+jHQPezJSbnFWd3+jTLUxpHYjn4C/zx3bwi1RPv13TtcrG+r
	 LH9/vJWkUE4n2yFfZIsEfwbVFf/zPbHZg78YoIkGxHgIkK5Bfg3p1L+3XRsVxbhvR9sFs
	 Hj/3Ufj+6d568GJApBKAQm7d1Y0CuyCB9WHdKt9WkGrqR2kD+U89E4ORAvSnfCW9DG8FA
	 6V5mZjCR2olcze8YrjLfcOSZFDpwG7J/wiO8HAEUpBjYyXOr/72/rSYh4VjBX6mRO/Pi1
	 Rq+AAg5KMjONv4mwAIXjE6n81ZkpwsnIoREAtTD6pAHyywdeM/BIbilLBpGb9FmFUlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794367314;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Faprzkg6fWuPAvDPMXDs7xk+PBjqYZ7BOB85tMAo618=;
	b=qSLC4BHvcSpEKAGq2Lns98g7lW1MtbjkpRaxKp4BgLzmws28nM2NrZynykV5ubqeXJWD
	 rVTuFHxtxqD6UB84Mt98uVHs/0/Z+1h/1p4kosFuGRwF8Qw+CwFwsf8L7Nbl2wwPVwENs
	 /QaeS1YUdfcfZzr4zNG16XQCjqRHpV5Is5KM0em2aHJ4J5m60Mx5c9003ZIcKgsAZzi9b
	 39fHIhFr9It+4+29VNLrvsQ/QxX0jcT6Pb/iJQQT1QQKX1VjCEs6rCxlcr6415zjAeZqN
	 dn674SgnL9Ko6k/u4/57zfHMER+SL7t9gacLvb/4lWdSdbSqE4wOsPglxflk85LgToQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uvs73N0p;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07799606A33A
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 03:21:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07799606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uvs73N0p
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-36f8cdd30beso4507591eec.1
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 19:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794367313; x=1794972113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Faprzkg6fWuPAvDPMXDs7xk+PBjqYZ7BOB85tMAo618=;
        b=uvs73N0pqjTjkgtlsNddop169hBs5NczvKcImx6xE5AyWuz51JqbAbQ+GrPDvgmCIl
         q+7Z9arn7JwI2xm6l1F+JHTX7SJa5vs58q7/TWk1RkRGh1FkMIwJy+ebGukPz/WW2Hp/
         hR7VBkML8xQ4+4YLW2bqFG7HbE7qMYnTKF2WqfMyOr4OfkIe5tYrDQco3oJMEqZ7iRYT
         lkYepcHs0uZknCOXliZNoeTrdjEMh4lpHhGfxmlUsBJ6DZMQnq1UeshT97/XavD6KbC1
         XQRW76kjlWiYw9ZTFFWExWtJevo3Bt3LhooHy9bk0l+9Mc0Em16qV9gJBwNabWkvjCO3
         Y6lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794367313; x=1794972113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Faprzkg6fWuPAvDPMXDs7xk+PBjqYZ7BOB85tMAo618=;
        b=WxZ3pVmLZcewr8TivY0zMtnccW5JZK8cC9lIZM7s+RojChm6kLA4weIE1M7dewfMZW
         MGuzxhOMnBycV/FCiqbPlYFCPs82Vgz73IUOTw+HuR6ZohPmH2W1MmSPIrr3y4T3zG48
         o2vJ/XKrKBIOJiyXgc8CHD+ezZ2VrRKP88B8QYNl/H+loiFnmVD9zCodJmLiT8FLmO0E
         fZzsV3b3rVe0beACQF4dkS/dKiVMwFubJNesc0AbPrqNmnv74HQ4HYUqA4xUYkBqzVrA
         8/1P1Xt5Xuw999R5DcVuTNou6VC+GuCL14Pmy8+lGXUdd5sWE9t/8czQWbS9v+/08GK/
         G2PQ==
X-Forwarded-Encrypted: i=1; AL+hErG/dHqbQIaipgZCvJseSAoRuhRDbVS8Mz1lOdlRdHI/r3lK+kSFj7mwYuGTEM6pwKqFgKNjoQY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9dDDOOL0owIlP+/XRcMI1n0f0sHPTP7YAMQ+1qSshAkrAPXO9A
	U6gP0ZCYeLRlDs9p3bz4SCidQZyjdgJ5uttPzAdK4IfYFaw6JqoXZTSC
X-Gm-Gg: AYBFou1PAI8xWCZVVQ4sHYwdr8zDEoVZp9fCq1nAcpUN1HT89KlPR8dJh42e/6J4nYf
	ODjDT9iefKNrtRV016IfkMiiUOr/iitkeGssKeH84le6Z5TmJTKWGsbaxHOUoxae9Q2REfVTcW0
	ZJZEgmoGQYJkhi1GI2dxXywdkb6yINO2tmlcCW26V7CkZaHSfwRN3eBVnWoCO21mw7Df6s9lfdF
	Tb8ZDxV29/S1aFNYsbbVgPRtozWbouwS8oGaxMYZ/NH8Jzf5AJpT+9tj1NFgGbnd6CIKPEN5RXK
	P6gs/PKVOims1F6kDHwkz/iV8WUVb5KONyXTaWzyTe37j+4Y9Lznb+TbnV9gNo3l7XcXHaLZB/P
	HIRkufrjA0BL706PDnHfnEs4Mo2rBxMe14BGSLnq8yZ7hdSDyeFbAz9fmx1Aue/vKB9W/SMcly3
	PG58oImpaJHOyIDGM5jTdtsJNUHz731kByEPoMSifhN+Zd8VqHMSiknSMYqaBSJTa9wxD3DutcJ
	htS6xw2qpAmRyTWA7P/0laPIflOLsrTZbX6tqzJ2gHnqI/3Fh7AANRLsJBTrpNme+omTHzbUNtg
	N3+hli+K7KyBD1/ZEQpMHmF/hxo4Rzk/hxf7jVHOAmPz6E8OZ0u7TCbTHc+d0NY=
X-Received: by 2002:a05:7301:906:b0:35d:4185:5395 with SMTP id 5a478bee46e88-37686171e97mr2082971eec.16.1794367313086;
        Tue, 10 Nov 2026 19:21:53 -0800 (PST)
Received: from build2026.lan (67.230.168.206.16clouds.com. [67.230.168.206])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751ad6f11csm9801896eec.0.2026.11.10.19.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 19:21:52 -0800 (PST)
From: ThisSeanZhang <thisseanzhang@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	netdev@vger.kernel.org,
	Nick Hudson <nhudson@akamai.com>,
	Felix Fietkau <nbd@nbd.name>
Subject: [RFC bpf-next v3 1/3] bpf: Add KF_CHANGES_PKT kfunc flag
Date: Tue, 10 Nov 2026 22:21:39 -0500
Message-ID: <20261111032141.525444-2-thisseanzhang@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261111032141.525444-1-thisseanzhang@gmail.com>
References: <20261111032141.525444-1-thisseanzhang@gmail.com>
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

The verifier invalidates packet pointers after a call to a helper that
may change packet data, see bpf_helper_changes_pkt_data(). Kfuncs have
no equivalent: bpf_is_kfunc_pkt_changing() special-cases
bpf_xdp_pull_data() by ID, and the kfuncs that write through a dynptr
are listed in dynptr_write_kfuncs, because the dynptr type is not known
when the arguments are checked.

Add KF_CHANGES_PKT so that a kfunc can declare this where it is
defined, instead of adding another entry to the kfunc lists in the
verifier. The verifier then invalidates packet pointers after a call to
such a kfunc, like it does for the equivalent helpers; a stale packet
pointer kept in a callee-saved register across the call is rejected at
verification time.

The same predicate is used by the CFG pass to propagate the
changes_pkt_data property to the callers of a subprogram, so a kfunc
called through a subprogram is covered as well.

This is needed by the PPPoE encap/decap kfuncs added later in this
series, which adjust the skb like bpf_skb_adjust_room() does.

Signed-off-by: ThisSeanZhang <thisseanzhang@gmail.com>
---
 include/linux/btf.h   | 1 +
 kernel/bpf/verifier.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 87fad4076..0ec8b939a 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -83,6 +83,7 @@
 #define KF_SPINLOCK_SAFE (1 << 17) /* kfunc is allowed inside bpf_spin_lock-ed region */
 #define KF_PERFMON      (1 << 18) /* kfunc requires CAP_PERFMON */
 #define KF_ITER_RET_INDEPENDENT (1 << 19) /* next result outlives the current element */
+#define KF_CHANGES_PKT  (1 << 20) /* kfunc may change packet data */
 
 /*
  * Tag marking a kernel function as a kfunc. This is meant to minimize the
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 20b1b9ff5..62536bb98 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14411,6 +14411,7 @@ static bool is_kfunc_dynptr_write(struct bpf_call_arg_meta *meta)
 bool bpf_is_kfunc_pkt_changing(struct bpf_call_arg_meta *meta)
 {
 	return is_kfunc_call(meta, special_kfunc_list[KF_bpf_xdp_pull_data]) ||
+	       (meta->kfunc_flags & KF_CHANGES_PKT) ||
 	       is_kfunc_dynptr_write(meta);
 }
 
-- 
2.47.3

