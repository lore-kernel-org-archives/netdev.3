Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F473B058A
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 16:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255235; cv=none; b=Fmo7Nvl3s+jWS8ZP/+Odyf2X4GdjsenriXDwYp8q8P1+AqgUbwOLFLjESNpo1mw8ubH8eNAoU6yi1A4dOiK91ob6+0Hl9NDzrKpee5w3EV1HmIzqRvnnyncNhFVoG7MqxjYv9cY9nkiIU8ERJv5fraCEvs+5mqUl42jPQ3mYe80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255235; c=relaxed/simple;
	bh=4CNEN7wC8Pe/7XrtPhrG7zkTQrJox5iMYzUoLmJvEaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=coSTyKkg1uw9h4tbFVdFXYZsjBfpx6sgqHIY2PGipT50XfPLSMyJTdcw66NH6xSv4UcQu9plKLBBYtqOn0ubMajiDBuPV0Rwwr6sPMEv0ZZujm7XXi0c06amBrlJGKZ/83NpEKWOKcwDtVQh++1gGkvqUXRSerVj0M/trvekhnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NEueKNrS; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NEueKNrS"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3ac7842c17dso534713a91.3
        for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 09:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792255232; x=1792860032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GNgrelxi6eEq7P7hlNUFtYxqdxmASU5JrfOLjioF/SE=;
        b=NEueKNrSy2vxjgPni7UZL4P2D4ZRa9Xpp/ieOeIKFsprEoCuMdXvERAKswT0vigjqH
         2U0Mgpbk2saaOJU8hRiOrJr9ao3ZAf3VkrVxsuZhmpo8Miy9ce0MjgGCIYBJxMqY4g9W
         /GJV6U0Jl7noJQEiek64X80J2j4xDPqK+E8Ignxa0R2rFnjj6f7oWyIM6P9ZZIvgNfZw
         AziffqLCZjcueIgc7lvfUPoRbf6N5OTIgaMZzhjsjUXXIaEGnU1xN7nsDNJiENa7O6r6
         zfLq3EfBJw3r1L5Gx4/in3QbzT4bSovSPlpHNUQ3qctZ1GzK7/kNBFd6S0cT3zjaw4LZ
         fD8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792255232; x=1792860032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GNgrelxi6eEq7P7hlNUFtYxqdxmASU5JrfOLjioF/SE=;
        b=LXd7CBTV2JxgQ7evwM4glPBwpOtCxXdGXypEqcHWwO5J+DZsSUEVT19kyvDtyfS42Q
         oYK8dQA8iWVE/cO2yr2jz4Pvf2wK7MZjNSYB6TMQKkjjahQ4fmk79YtnSEoUmWFn9G7C
         pQSljgjAQmFAficlY/5G6BTXlWP3e4N32EdeLV11m98Bka5q/jR/XrtnJgPVTkrVTMw1
         ixmZzbhe7O5YZZMNTU6bon/VFUbaxsIU5+FH4mmALusRxxgVzTkFuN5qdt1Bh6xyL3W1
         tL/CRJ3EfITt0YhPi747ht6FykKDbJZotWGcTikWJq0nyhtohqMaiGRjRwxySnbii77U
         sb2Q==
X-Forwarded-Encrypted: i=1; AKwUvBy4Xn0IisrJFo4qTCFIzgK1SWvEMfjkTsXDfuhFyNWpn3zxjaTJHwuyiWoqWXXpjXGE9gW9d/U=@vger.kernel.org
X-Gm-Message-State: AFq9FYL4WjgTBCp/pvTR5q5M1Zh+9b+TKO6CZBno8wIkhIsKrNf/Z72L
	zlm/EYSv1ts7MjI4Q5AwsJgs4oHldhy3YodZBe0BUraCfhUDCM5GuKfV
X-Gm-Gg: AYBFou2WlwWL4vKGr33hCxIJQ/n/QVQnM8JbCvazULaPdpXnrwjn5zNxxWEQWw7Rdem
	Tq1q9ruLBBawJ5UGE9SDlog7k3h9qvV+Dj21QF3Nx4pDSVLzhqcfQZIx9HgydvSeK9E2eoPsVu6
	C1Bbc+tI+PVh+MfUlH0uHAl1QCmlXaalVnV85Jw5i2dUEB3jY9WVtQSSQdj+LxWw8nggSAi4sme
	bSCfpSf3m8M/YPSAnV06uEF6tMEw6u3SzrejCtlank0kAR9wg+nxltAYr6unM51xveJqXNofDmV
	0vxH7bE3RZNfVXGWAFy0dSWmthgM+2bnR4ygFgB29gebrHsJ1K3moGiJjYNcFW3yXC01fNFNw2U
	b99Wz/n4X70ElkYgxU0/BWUSXg1KXweV5sq8MkFkRR+gQW3qrrP/8rgnfZK3lY8VFC5/+twinUn
	dHC+Tce29yG2M8L6z/nU16Mzc6cTl/q52W8lzY/8K7HYG1zgE/+qre9or39dLB7YrUOAKXdPoHQ
	gbhoxUogg4HWwKcS0rVy0dWpSc1yjp/d1PRTpqpbWUXhDNT8y7maOBRB6snhB0GLICLAybjyOyw
	BPEYIJy7ceJXAwB+37jYXji8Q1XEClhFXTFkTy8qD1aC
X-Received: by 2002:a17:90b:2247:b0:3ac:17c:6e74 with SMTP id 98e67ed59e1d1-3acef518d7fmr2516583a91.53.1792255231912;
        Sat, 17 Oct 2026 09:40:31 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acd0aa3c24sm4682821a91.4.2026.10.17.09.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 09:40:31 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next v2 27/43] bpf: Assume no bounds for a writable tp with tail calls
Date: Sat, 17 Oct 2026 16:37:29 +0000
Message-ID: <20261017163745.3341787-28-alexei.starovoitov@gmail.com>
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

A writable raw tracepoint hands a buffer to the program.  The verifier
notes how far the program reaches into it, and bpf_probe_register() refuses
a program that reaches further than the tracepoint allows.  A program that
does not touch the buffer passes, and can tail-call one of its type that
reads and writes behind it.

Take a BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE program with a tail call to
reach as far as can be, as for the stack, the packet and the buffers of
iterators.  It cannot be attached any more.  Plain raw tracepoint programs,
for which the limit is zero, cannot get at the buffer, and a tail call
stays within one type: they are left alone.

Fixes: 9df1c28bb752 ("bpf: add writable context for raw tracepoints")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/fixups.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 002c3935a8eb..fe59e3114d82 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -2153,6 +2153,8 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			prog->aux->max_pkt_offset = MAX_PACKET_OFF;
 			prog->aux->max_rdonly_access = U32_MAX;
 			prog->aux->max_rdwr_access = U32_MAX;
+			if (prog->type == BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE)
+				prog->aux->max_tp_access = U32_MAX;
 
 			/* mark bpf_tail_call as different opcode to avoid
 			 * conditional branch in the interpreter for every normal
-- 
2.55.0

