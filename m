Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD1C33438F
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 20:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785788263; cv=none; b=I8cDgEVWISeWITDM5zcBKPpr0V2+cCgHezQ+qjNPHvENA91d8K9E1eR18EdWnlTD4/9KXFnWY/QvVzqTlnWwYLo/xBtRJCTO7EB6ZVSkCgl+H1dfe007ZlfWYx1m8VVwr6GZQrlokMwmWBKeNwbQJAkT+EDbBvF5CkLPtmG3fLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785788263; c=relaxed/simple;
	bh=07YfUTUIkVXxxxQ5nDJp2cU7fS0xKI2x7ZXp1hvDTtQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=NEVY3Lbkf8bGEb7DqZVde6pUtfd3Vy5k09Pf//44ZkUPYUR+3JQrZkGCbldiLkqdS7A9qBWwxYrkl4JCtTdzzcem/kk6fxnp2BHfMACeJtavY5+Zrf1wFyPTgqRlcmVz8D4Qliwe/63xApSZCRxdsfZZPxfYPMDhzJVYmOO/FD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--thaisonphan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q73e4g1Z; arc=none smtp.client-ip=209.85.222.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--thaisonphan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q73e4g1Z"
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-97762b21ba3so3455949241.0
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 13:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785788261; x=1786393061; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HbtNx5jGaJ14hHCdhLSGkKNoRBenQm1+VRFQgo8nw1g=;
        b=q73e4g1ZJg2FaF7ChXlS6VRVkheWhccVpSJ/4hVgKo+jchzALepK/IkkirijfY3SHH
         inqc5bO+tVgFwODj2TIl8cVXDWg34PRCcbE/r9mCN+qXqA/Uy0GbJIr4d+lAAcAdbLcX
         F3raxuFuXXtfQitayrpqcCSJwCHX8G1HVTEZcNRIseDhaPh9nmYPo1umwM254FPpEYKo
         2s3xfaOvRA56an27Gx/vlUh5fQdoxRGs4B9gRhaB0Cj4M2k5cAITalxRlnanP1vzd4xZ
         2vTUDvj/CzYD3wnrcAlIkbBwfp0ROta1icroUfC2iLqwhuedKeb1WuHLnMawMW3WMr4Z
         U+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785788261; x=1786393061;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HbtNx5jGaJ14hHCdhLSGkKNoRBenQm1+VRFQgo8nw1g=;
        b=N2ZsxlxhCGxtz2G+WshoVigh7u2uYz0JJEL4uzDeJgKi7B7V37TxIzpgOt51dkmp6v
         C++O3n4PIMVObiJW1YFY1LGWc/vrAXJKKa2MJzAVaaq4P1iFDkzjw0XQ42pa2r0c3lZK
         w5sRuRXmJfkOqR9/M5qho1HwJoiVlhDovMHf5l7znpXflqG3jMP4r3Rtpgu+0mSnZkal
         807G5HkxSOWmJZ1Y1ittnHOtHxFp/Evcf10UHxaBGITkVxuYfBWrihZdpDUAAuXJuEJI
         GiDrXtO8kAvBlFK032w/75NoArVlg4ZTfaxg8xcvgTaS6hziB5YbPbpTSBCFUV4DmZw3
         bhZw==
X-Forwarded-Encrypted: i=1; AHgh+RqkRYZa7U1RxvQsL0YIjgqZGkddt6aP5KGd8OKlhOxdUNqD/CulZzxfJc9DMLeE652pzgTPThY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1K9UIRQJwbrdoQ/V+mB1tp1TO2Ldo14hqQzGgy5dwzxDuF4hk
	PbSUzRZSndrjQjtWqrqBnAldvEAfd53ja0sOvMhj/al/tZepFsWA1zoklCbHQ/oHR3q62OTcQy+
	/un2N56Xt4yqbsVUMNE/yXc9qVA==
X-Received: from vsbcu43.prod.google.com ([2002:a05:6102:162b:b0:745:9ddd:f66a])
 (user=thaisonphan job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:2c86:b0:745:1c72:cf72 with SMTP id ada2fe7eead31-75b2406f27bmr9020454137.13.1785788260838;
 Mon, 03 Aug 2026 13:17:40 -0700 (PDT)
Date: Mon,  3 Aug 2026 20:16:50 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260803201652.2752685-1-thaisonphan@google.com>
Subject: [PATCH net-next 0/2] tools: ynl: update NULL pointer handling in
 generated code
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
code during dump list freeing and memory allocation parsing/setters.

Testing:
- Regenerated all c headers/sources under tools/net/ynl/generated/
- Built libynl, ynltool, and test binaries without errors or warnings
- Ran make target run_tests in tools/net/ynl/tests successfully
- Ran tools/testing/selftests/drivers/net/psp.py in QEMU x86_64
  successfully

Thaison Phan (2):
  tools: ynl: check for null ptr on dump free
  tools: ynl: check malloc/calloc fails in generated code

 tools/net/ynl/pyynl/ynl_gen_c.py | 55 ++++++++++++++++++++++----------
 1 file changed, 38 insertions(+), 17 deletions(-)

-- 
2.55.0.571.g244d577d93-goog

