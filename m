Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7B334572B
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 17:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786122906; cv=none; b=oPZaM0J1BZTg19VQFmBV9oqqPwj5dDCuK+8Lu/etncgtJif6hzvvYrBn1ElLHcLgZEUGjN5SyX5kVD+Xf+C3/RghJNOhG8NEI60vkwvGZuDSozJJeWocyHGSeeYIx3E1shGgJZJ5exqkPWNf5eJpgDQ6fsWvCXPZctdPAPF06R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786122906; c=relaxed/simple;
	bh=OPj7WAypDKwf3aLNyi8545ZAJjI3CvHbvjLOjZoRVyk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Ijftqbj+ZLftsbrIQ7DplY80LtNGfHt/MlINDNVZBd1lh01CaCN5dhcCspDwMF+f+aIW5N/wLB2vW/tOOPMN5BImUpouHBRsrqTMvH3Y/0ofMnJ3c0cKuYymxJZsCqnkfCeBSRhFPzdHe/GhP6+9w1vx6VMw6HwRswBZ6d5HHwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--thaisonphan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XEwx5rtE; arc=none smtp.client-ip=209.85.217.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--thaisonphan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XEwx5rtE"
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-6751db2792dso707426137.3
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 10:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786122903; x=1786727703; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zvF2mAoiUWPF2zF5L63r0QYdV/q6pFk0ZjE4Xr2hQIQ=;
        b=XEwx5rtEzabWiDNXT69CoarfU56deyp3tgYNFk1ZbQVS4AlqwI9b/WdLGTc0+eP6Ab
         KTLke6yNYfTcEoxW2VAoF5x8V4ExJKNVKEirD2wCSEycYAf+3KDzL/tXfYPGhWlmu7xZ
         YeR0cBTkTdnZkLkVUSOeRX5YsCCshu3w96XUBrD08KN+9c+5+1+J99fI85dR0B3po3Wh
         bc3WjOmLEWXT9sc74AI18ho6jUPiRApDdBdlns2SAf/iVsgU0UJdFTKKPQnhc7nbo1PV
         eJKcW+VuRaaSoAEN0fkXlSLUEGoO/x7Jz0f/eGZOV6HiiilQ5KPWNJ0uACz9zYfAbeBU
         h9jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786122903; x=1786727703;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zvF2mAoiUWPF2zF5L63r0QYdV/q6pFk0ZjE4Xr2hQIQ=;
        b=YbYNCso2Wch+OZc8VotrMuf+b4Mf506d0G0iFFr5Bgr3L8lUUa5Opfz4LmXq6bUjJs
         SIxq97LIvR9xVHbntoNLfxAajz9jzY3tixyBjFb/wH1XEtZD8iNuWrcA6rTz4kzMjyEZ
         QB48FkogGC/hxX7wYLwf00RywwdGR0Not3Os0krkdHUK73iKXMvOdbKObDmRE79ralGr
         OS+YbMelGRC+6KvSb5/6aImkoi1p6e9S9x5uRfb8LId7aH6uWSxKz4njLzHPr8yvdU+k
         FdDWD365lj0/CRjn0qo93X+dm7RqTq/8p1nu0bDHtPgDaHm/q3Q+IZIOuEl/JuaQfFYK
         4gOg==
X-Forwarded-Encrypted: i=1; AHgh+Roy32m+pdQVBffqrM0teqfElW8GW/HPbzAd2pjr2yIZtZ0cQUb6H7ACxpckgKlRzvzbbmMPR24=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlHFhl0ypGwzg0J5x1ups9IJ8uHQgLLsOYh10r4iwwOCrx7lwD
	0D6/z4QHiLRIGT2AKBYUV0E/Ni3GUqyxv/xbt54DqiDaEG1CXLJ+1pFlU4FPaV396SFSw9Dn0U6
	x1NRdzFAOUkrnp9Bmgf2CBnSm2A==
X-Received: from uad22.prod.google.com ([2002:a05:6130:8016:b0:977:5b70:d8e0])
 (user=thaisonphan job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:3fa8:b0:738:9c79:7506 with SMTP id ada2fe7eead31-760e80f94f8mr6128790137.7.1786122903124;
 Fri, 07 Aug 2026 10:15:03 -0700 (PDT)
Date: Fri,  7 Aug 2026 17:14:58 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.654.g21b8a5bc05-goog
Message-ID: <20260807171500.7188-1-thaisonphan@google.com>
Subject: [PATCH v2 net-next 0/2] update NULL pointer handling in generated code
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

This series fixes potential NULL pointer dereferences in YNL-generated C
code during dump list freeing and memory allocation in parsing getters.

Changes in v2:
	- Moved null check in dump list free to be separate from while loop
	- Updated allocation checks to only be for getters as setters will
	  be handled in a separate patch.

Testing:
- Regenerated all c headers/sources under tools/net/ynl/generated/
- Built libynl, ynltool, and test binaries without errors or warnings
- Ran make target run_tests in tools/net/ynl/tests successfully
- Ran tools/testing/selftests/drivers/net/psp.py in QEMU x86_64
  successfully

v1:
https://lore.kernel.org/netdev/20260803201652.2752685-1-thaisonphan@google.com/

Thaison Phan (2):
  tools: ynl: check for null ptr on dump free
  tools: ynl: check alloc fails in generated getter code

 tools/net/ynl/pyynl/ynl_gen_c.py | 35 ++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

-- 
2.55.0.654.g21b8a5bc05-goog

