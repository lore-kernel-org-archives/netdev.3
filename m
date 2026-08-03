Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727B43B14C7
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 20:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785788267; cv=none; b=OZ3ls3recC4PhLo9dKW/kW8UcOcoW6XejLO8ix5ss1vql2yHn5FfE34O3C6KEJI5QYyOgkSrky9J6d7J0Ry6YEjlC5F1XheZvXZShuR7+dKPd19Y4+hJliueZim8atJ7SHc361+lLQ8bw33UHQhs+QR33lCLZT46CYf7UJcuLe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785788267; c=relaxed/simple;
	bh=xBC8RfiRmLQxJc0KR/6PjJbkdZl1/Dv0GkypCJyJVl8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rIzqTncvlpkfdCqM85wjIU6Dr35dc91Sb3+7nzzh9wTF4nZS/dUNK/nqTrqvD0dDWNRUBZt0qb49l6Zsa4flPJU8qZZ6ZCuiFKZMpvPwN0JE7YEZqZxpI4R92KL5xyiGryGGpffAmEtjeakYbNjS7NyaCcifeQSUpXWM0r6AW/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--thaisonphan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KsAgc17K; arc=none smtp.client-ip=209.85.222.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--thaisonphan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KsAgc17K"
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-9771c8f5045so3506605241.3
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 13:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785788264; x=1786393064; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VqZh8sZuThEFyq0PldOP8TMB8ZECNpHPSl4JF/PtYzc=;
        b=KsAgc17KDfc6KvKjALV19ZukWZYTImABDj9vd3LaHS5OHdM5/pyCITAluszUPmD9UZ
         IEzPbCPfv9SwHf29LgwL9BejMXiSpjT/gvFGmu8FZbKhZ2ZIT3tmjgr7FP9y7R6UZtj+
         6ceoC/Z6c8AjnhkI5r1p2tVrgkGJ4GUP3/QrtOl/h+2S0LVvOCLzEK0QbUhKnV0fw3Jt
         OSl9nr2I5ElmAK/fH3gMzoQSXZ3w5RZ6reY7+QtvW4EQv45oDtVIvJlBvFiUqc+9VG6w
         Or5cpVrf32SASD0u5aVgqiWqrr7ToOI6cDtx5bLnG9FMD0KW5nFMqQ0vCo4J/hN5PT5T
         cszg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785788264; x=1786393064;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VqZh8sZuThEFyq0PldOP8TMB8ZECNpHPSl4JF/PtYzc=;
        b=mGNk1jPklub8XOA9r8uro5SA0BhQS+1QL/tl68jHmK879HXhj6irq3ufA1WPbXBek2
         cXNpXqs2m/Tb+F2F8ff0m9+CW4UI2CW4FvJJOp9pOdqSJISMrHMzgZb2M+OmW4fmgaG5
         Ycd/imJ33X+WnH7xUeqtQ94BdGGqHs4d3O2NShP3t0HKpv0I4dlhoiWlkxvaTyf3Yw7a
         xFRD+BDwjSph0NOOT/uTIt+ZkIajXWNLjWs51Ge+3atBwOU3oVC83rwjo0TGrmswcHNb
         nbZaQ11E5EyYf22z3tAbv1Kqsz4DF2ggR+Ph9CBnhsUS22Pfg+UShb/qVlz04eb9NmIx
         Y//w==
X-Forwarded-Encrypted: i=1; AHgh+RquL59zIWRJrr7hCV/hq/jOJFzNTkerkjnZ3PpTrd+qfqnvbzs0n0Fne4UnyWOYzpYcXOkUkTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQTn8ahHbsNzSoyQB8BzDamHp96bZX4DWlkKU1Id87hKMiHAJP
	N7HdJf/gpSZG8U8A2Pz5hB7Rf4YSLdJO+v67Ykd38tchf78wlw2zwhrmcgx04andbmrO2W0pyAV
	lZyYPBG9GcxNApr9R4ZmawsE0bw==
X-Received: from vsto13.prod.google.com ([2002:a05:6102:e0d:b0:73e:fc7a:f827])
 (user=thaisonphan job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:6898:b0:737:e816:b26f with SMTP id ada2fe7eead31-75b23a65804mr10207145137.10.1785788263971;
 Mon, 03 Aug 2026 13:17:43 -0700 (PDT)
Date: Mon,  3 Aug 2026 20:16:51 +0000
In-Reply-To: <20260803201652.2752685-1-thaisonphan@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260803201652.2752685-1-thaisonphan@google.com>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260803201652.2752685-2-thaisonphan@google.com>
Subject: [PATCH net-next 1/2] tools: ynl: check for null ptr on dump free
From: Thaison Phan <thaisonphan@google.com>
To: Jakub Kicinski <kuba@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
	"David S . Miller " <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Fengyuan Gong <gfengyuan@google.com>, 
	Stan Iliev <stani@google.com>, 
	"=?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?=" <ast@fiberby.net>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
	Thaison Phan <thaisonphan@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Static analysis detected code paths where freeing a dump list after early
errors when creating the corresponding dump list like in ynl_exec_dump()
can result in a null pointer dereference since the first node in the
ynl_dump_state would still be zero initialized. To prevent this potential
problem updated the ynl c generation script to check for a NULL pointer
before continuing to free the nodes in a dump list.

Signed-off-by: Thaison Phan <thaisonphan@google.com>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index cdc3646f2642..2fd68c738075 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -2747,7 +2747,7 @@ def print_dump_type_free(ri):
     ri.cw.block_start()
     ri.cw.p(f"{sub_type} *next = rsp;")
     ri.cw.nl()
-    ri.cw.block_start(line='while ((void *)next != YNL_LIST_END)')
+    ri.cw.block_start(line='while (next && (void *)next != YNL_LIST_END)')
     _free_type_members_iter(ri, ri.struct['reply'])
     ri.cw.p('rsp = next;')
     ri.cw.p('next = rsp->next;')
-- 
2.55.0.571.g244d577d93-goog

