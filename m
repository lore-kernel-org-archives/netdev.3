Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1CD3C13FD
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 20:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780690863; cv=none; b=LYIjhgXyOdb8vk+s4QZ/AgKHwxOzgI4JtmRfECn2/mXtEQwa+IIA0ebvRslZmDK90MjZ/z3ncmWPLunEFz1dbfpBjqW5tsrJngpqDT5bIc9ZQsPr/TCo+F5nrZe+S+fTpevFiBP9r5kZCtRBJO/uKmW7K2jPqfwW11zDB5paJpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780690863; c=relaxed/simple;
	bh=qV4hSRgYCAlZ/cX5eOLisIxPMgz7Jx59zHgWJ0fU8Go=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RoYL7v7R7aJ7rZGQIUxPsAHKHhp5vg+He9797qV91IlPxJIyqpa09utvm5YyOLMrA4SiYCrPd69x+GOuXoRIe5dRUkiCm+Vr9Dgravo4C37LLJqcfGMmXg1OvWEnz0meQuO7koWTjI3EH5mla5AZMeskT+D4K5GCyg8T7Q/8jCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KqEB+Ha/; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KqEB+Ha/"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8423f52af13so1677053b3a.2
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 13:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780690861; x=1781295661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vd7mNB6n7oWwOEumxuPNE7buAh5DJvMLtPzxh9rFWLE=;
        b=KqEB+Ha/j5mreyDIlr5MVSAUF4c4aj0ocOvk4Yl7PBjfmClUl/BT6U1cFDGZUWLBWv
         2cqHjsXQi4NvF4k0WiXFX2aFMIHGli7SVMjYLw7VGQ5SINREAMkl8y6PsSx3clJIOoIO
         +/XXeAODMPdTj9agS0WUzQBOyPdwkkim6GZnOUjll2w28W+49JwgvJ+H1ogaFCCFghg/
         mp+p2ovTzR0vcSCiQ+3mb1wln1/tsdyDfQ6DHjdR7gYKcdfiRzljjqROM2S+L24Ff3Ka
         nFRhILpMgu17VgHvo16xwxPWGL/tmtu57QJZ3fHhl4dTVmbuF4f1/eo/ia4baYr2JyXM
         aMIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780690861; x=1781295661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vd7mNB6n7oWwOEumxuPNE7buAh5DJvMLtPzxh9rFWLE=;
        b=Ff/5ax5bVV14pCTUzhnEn2Lu0M3eNJUkdaK723oBCoD6yiTSFZuJ3pySt22RR2NKtJ
         OvUWKcWCuGtC2oUm8+wOpn9NWBRl4HBJ65JIzY4NADZi75J9Y2VwxaWnHYEOoBrGOLIy
         1bTHpdb/OLQX39ZFEVBOFKAkWGVf0gNiSpeiO+dUdxYHpPBv1WE9mkbXEfcl4WyzlHme
         JdCnAuSnGWR96ye6hoFBzdoZcqNA99jyspywgV2+eTk/wJcaTQAYK6E32toaHfBrDKtC
         7xthREp9+aF9o0eqjH+rs0p0EhdsHyKn5bmjq0/Vfq5+2Qg3/f3lyq02Sh6T/bhb8Jq2
         h4aw==
X-Gm-Message-State: AOJu0YxuGSmbN/Q/IcUYaCjRryszzmoTVcVL5VwTo45YQ+FnfSPXJQRM
	jugyKT8N94wF5Ci6eZezgCVtYUX6w2XCCutBgH+0EHovV5XFX+TPiyBj
X-Gm-Gg: Acq92OGz/kWiEtSwQpIe6OcuEeIUP5Qosymej9nXw4D/cw8FrC6+eSyID5pBwO8YuyF
	IZ4ROqQZ9xefGjawzPWZTvRZCRysuOb45ba04pnlwAWu8b4RR3wltr45Oga3tyAUxSLx6kMzq/A
	ZAcItiauvI8z9fncawdK/nssQvsizdZwMoH+MgZ/VxPUDgOJsr52pVIHI7FUmz8HAdbwGz/hbAl
	mXVW2TZ1x8tScNq62kecPxrcjK73AAxmD3fSvoEW9fZt/HLq+NNtQ1xBQKHximQpRVs9k2By8I8
	ilDYaJE/StxSRuJx2sWaU4pMb18K/SrrZqEEQ1msK60kGy3phsV/juuUr9xhZGO28Y8o6xRpqRc
	MZ37yczGIrijTgfl4AhbPH9MhpBj1YZ9lPDpfXbvc1qmUy6+josKA26ERMbD90PLV0zNgRzXA79
	kkn++zRBJf81sBz2BRkg6llXI=
X-Received: by 2002:a05:6a00:ab83:b0:842:2280:538f with SMTP id d2e1a72fcca58-842b0e74b30mr5280524b3a.16.1780690861026;
        Fri, 05 Jun 2026 13:21:01 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:8::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828821d0sm9956779b3a.28.2026.06.05.13.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 13:21:00 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	mykyta.yatsenko5@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 4/5] bpf: Remove WARN_ON_ONCE in check_ids()
Date: Fri,  5 Jun 2026 13:20:55 -0700
Message-ID: <20260605202056.1780352-5-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260605202056.1780352-1-ameryhung@gmail.com>
References: <20260605202056.1780352-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

check_ids() warned when it ran out of idmap slots, assuming this was
impossible because the slots are bounded by the number of registers and
stack slots. That assumption no longer holds: referenced dynptrs acquire
an intermediate reference that lives in refs[] but is not backed by any
register or stack slot [0], so a program can accumulate more reference
ids than the idmap can hold and exhaust it.

Exhaustion is fine for verification correctness. check_ids() already
returns false, which makes the states compare as not equivalent and
prevents unsound pruning. The only effect of the WARN_ON_ONCE() is log
noise, or a panic under panic_on_warn. Drop the warning and keep
returning false.

[0] 308c7a0ae885 ("bpf: Refactor object relationship tracking and fix dynptr UAF bug")

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/states.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index 06d9ae24f006..32f346ce3ffc 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -343,8 +343,12 @@ static bool check_ids(u32 old_id, u32 cur_id, struct bpf_idmap *idmap)
 		return true;
 	}
 
-	/* We ran out of idmap slots, which should be impossible */
-	WARN_ON_ONCE(1);
+	/*
+	 * idmap slots are bounded by the number of registers and stack slots.
+	 * Since referenced dynptrs acquire intermediate references that do
+	 * not live in either, so the map can be exhausted. Since it is unlikely,
+	 * fail the verification by treating the states as not equivalent.
+	 */
 	return false;
 }
 
-- 
2.53.0-Meta

