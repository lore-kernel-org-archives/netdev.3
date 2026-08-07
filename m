Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7D0327204
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 17:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786122907; cv=none; b=hYpTj8epuyLEfAE3XH9IrWDKdATBHkD6EyMXM6thcrg1bKVEEc497cVm/+AbHpw1nN0WtAnLZ3UU3qb/KvuhURptklW3KqERx8gvC1S+UbgKK3c2XGjg4FQ/kQ4UJKQ8evV707v1UQ6/tWPeaQ6iw3fL/hWErMDdrSxSFzmMeFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786122907; c=relaxed/simple;
	bh=B86lZOWcfD8VsoPi7dHKyNrkavkB8ZlkCLBOTa9shf4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=K9VRq+Kqyt5n8rWvQ9OAKyrHT5vm+k0jF/8+nn1B6vafqM+z9lYh0SAiLzRWmzpailygiHyAvN7u67DEmkSyf/oWdCtcTOytSG2qXThcl6w516cOEc2JemlX/NaKy7Yz8UOAhOAszl9FIygOAawNYQ4UFfjZNXQwQ74qf439Rcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--thaisonphan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nstyVDiy; arc=none smtp.client-ip=209.85.221.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--thaisonphan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nstyVDiy"
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5c123b3f7a2so807299e0c.3
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 10:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786122904; x=1786727704; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RuEaxoPBw1+WKiOtbncnQ6tQGAJ/e1/TXA6sNxcAvrI=;
        b=nstyVDiyP3mccPbRlcswWpBgempw8Rk05jGh2k+GbelmjGdHs6huHhMcaXPbHsP9bA
         UdcsDf4eDP7DjiSx0HgCcqvsh9lpm5hwxPCknWVcXcUeczaaHOWG4ohzRBft58cUEKtj
         vEf26QrJ2KmFlp1w04T7qCJmOrgtjPmeIrkThYbhtqr84FprRX8Htg3fapY9de4H//RJ
         mwXKAT5Z1vkdqTYIsiZRqrleV3PFRGx4Th6vmxYqVizC81nbNG7D2jrH+V6wAsqlS0hf
         pAu0fLiVrMqyeMkrqHy+Q7Zci4fXZ6teXUQKlGs+QD36UJDdi4wpdg1eloSCeLGcWZDB
         mQAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786122904; x=1786727704;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RuEaxoPBw1+WKiOtbncnQ6tQGAJ/e1/TXA6sNxcAvrI=;
        b=iaNIX8LPbyMQIPulAmC4Lu+q8lBT5LbiP8AhMAV3NhP0f6paoMUPqxPR6iDsrnFwri
         oecV0LjLnj2NJfno6kzit3TMPq+MnLtbqiXvothVRZ3hJpq+WEdcaLFBzI42E3oHBapw
         UDoPfxN+sE1aEKe+yp+YzFIw5trLdF1SLN494xLSOqd+yX9T8wePfK/14CPbX5jxnYIk
         +ZVEbGl0eVblqpjupMzpQ4WWE2KAAJMp+5S6So+dQYO7nMyBlOiEE3IkGxVE8zdwJOfZ
         zXejpteWo4jRelNnnNg+MvKAPuusv/LorcPzFjBKghMhQ6/pjk18nqyKSzY4QSxSLUMR
         NpCA==
X-Forwarded-Encrypted: i=1; AHgh+RqL9zzqifD3BcLTKRynCL8ykFhUeWjjbpG1dytCSBGs9XsrWkwmPzAC2uEWwLhFB0N/GezVZbo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/CHIsKWq0XDng1azjZQTzLYqvO5Bsrhs9NIykYlG7gNxAcNyC
	so3FttneCrChwUoMqDm/YePX+GWI6Gc0F9ETUYYJe/TkrFZJjVzZS6Oz0c50/2/ES+F+q+RRKXe
	hnEc8uZVIQvT2vAG6nMa7zB1sEA==
X-Received: from uabib25.prod.google.com ([2002:a05:6130:1c99:b0:95f:f376:3bef])
 (user=thaisonphan job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6122:e253:b0:5c3:8568:d540 with SMTP id 71dfb90a1353d-5c4116a4417mr412661e0c.13.1786122904004;
 Fri, 07 Aug 2026 10:15:04 -0700 (PDT)
Date: Fri,  7 Aug 2026 17:14:59 +0000
In-Reply-To: <20260807171500.7188-1-thaisonphan@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260807171500.7188-1-thaisonphan@google.com>
X-Mailer: git-send-email 2.55.0.654.g21b8a5bc05-goog
Message-ID: <20260807171500.7188-2-thaisonphan@google.com>
Subject: [PATCH v2 net-next 1/2] tools: ynl: check for null ptr on dump free
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
v1 -> v2: Updated to check for NULL outside of while loop to make intent of
check more clear since there can not be a NULL while iterating the list
(Suggested by Jakub Kicinski)

v1:
https://lore.kernel.org/netdev/20260803201652.2752685-2-thaisonphan@google.com/

 tools/net/ynl/pyynl/ynl_gen_c.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index cdc3646f2642..95502dbaec94 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -2747,6 +2747,9 @@ def print_dump_type_free(ri):
     ri.cw.block_start()
     ri.cw.p(f"{sub_type} *next = rsp;")
     ri.cw.nl()
+    ri.cw.p('if (!next)')
+    ri.cw.p('return;')
+    ri.cw.nl()
     ri.cw.block_start(line='while ((void *)next != YNL_LIST_END)')
     _free_type_members_iter(ri, ri.struct['reply'])
     ri.cw.p('rsp = next;')
-- 
2.55.0.654.g21b8a5bc05-goog

