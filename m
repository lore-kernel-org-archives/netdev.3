Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD86E54B
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 00:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790210577; cv=none; b=r2kcA5ugUVDujzjaAc/Jmt7l/M8a996qQmtGUx/DwsybedfHnvWKHuphhsZN2CNy+UAnUkLzIYapW64W2kfnM6e8kHyfiQ3EJwvItKoz0OoEB3sjir4z3naKDirW7y0sstij5s71CpJ0V3fg00z4EWb9KogEtqrITaIV84X/bXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790210577; c=relaxed/simple;
	bh=oipWMhD3lYrGKztP8ae6UKOMS66rh+UTv3TPc0H29mM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=rbgP6GOOfkom5NaaVINLmGvARAjcbxOX9z/oMLNTN4bt+XkbBPpZHQTZZSMOViiqmiDQ8eXD1gQdFW9IDxWzq7WfC7T6jn4Gxau09/Uyde+1v53B77XYJjINsDIBcMwZ2UVbIhsJntvmRFuWqsITnBym1tIOih45blziUupQhdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oF7QjynT; arc=none smtp.client-ip=209.85.222.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oF7QjynT"
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93a1e564fd5so265390085a.1
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 17:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790210574; x=1790815374; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+Tq4M+V9Pll65dWV8svp6whCx7yX1BSx1HAOtCFMnC0=;
        b=oF7QjynTjxVZZCzlcQULMicU8qLt83EBJFnD+zLE+HGejO2teeHeZtlZezIQDYm4fZ
         DyXwyg3VpreKxwa5GB0JY8VZqailqcLpQo5wIfkSkwZqiVKcMyN6ZwhDZltbq6YOzjJ1
         cByrbl7zpAQr0xdGP3/vRp4hYz00Ww7JkiHD2hL8cdn2JEldWfbwhSKPtvKVYufFxzS6
         C0j/ZRkiGLDN2pyT/KbgXmnO2oSvINAxbHte6J/CW8hPSi1XLJFa9VtUukBESdylH95E
         cDlS7ecBVFNsNBYxMEW9PpqbaV22jafqA+ehV5K88oXlREovEdDeypaIT+qHFG2jptCB
         Sguw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790210574; x=1790815374;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+Tq4M+V9Pll65dWV8svp6whCx7yX1BSx1HAOtCFMnC0=;
        b=z9ufrFx7Fu7+mKMkZyuHmnZmPJDCPjz+ErraB9zDAJN4UcY3RLd9es8tKBOWtlfR1s
         Rp7DxGnh6KlyqTppcTiIkl4jGo88NYcAkHonvD9BgB12OyjSginH+LnzRH1VI04P2QQ6
         /6k6BAPthKwgzFWuo061K4xnw0R4KSQJSMBtzmrzayGoUfyyG/swUZ2ijS0Q0yW69xu0
         tDr5ugUurJ058nXjE22Afv1ZhK7ApOAWU2gUEznMXtBKyMJHMDIqC5hLmy+S7O0Lzqn6
         1KKvX1wcS8vxCvr+GGA+35yigrAARnD6jQqSk7WgNvNBm5CzsGUPgMGIBL0GGz/1kNmW
         Atsw==
X-Forwarded-Encrypted: i=1; AKwUvBypdUeJrNd82WE0vUJnrzBThk/U9E8bNfY2g7GAym9MLmmsVJ2G6a4Z9vMF9tnwJekj+/YeFas=@vger.kernel.org
X-Gm-Message-State: AFuF++lWrgXzOnA5NTNiWg/WnnkcE+E/4+U9P/SGLyLZjSl/c/9sZk5+
	7KRGjULurikdGDsf82fzXnupQjAJkpCYo+KLEyeytUODy0TAIBZBhKJmLfJOB2r4JFnSWCB72u1
	4tMqyUYASluecmQ==
X-Received: from qvuk3.prod.google.com ([2002:ad4:4503:0:b0:914:a0e:b069])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:d8e:b0:93b:fbf0:8791 with SMTP id af79cd13be357-93c362d4e3amr64333285a.29.1790210574170;
 Wed, 23 Sep 2026 17:42:54 -0700 (PDT)
Date: Thu, 24 Sep 2026 00:42:50 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20260924004252.1196328-1-edumazet@google.com>
Subject: [PATCH net 0/2] gve: DQO: fix handling of out of range TSO MSS
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Eddie Phillips <eddiephillips@google.com>, Ankit Garg <nktgrg@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Joshua Washington <joshwash@google.com>, 
	Willem de Bruijn <willemb@google.com>, edumazet@kernel.org, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

The DQO TX path assumes that the MSS of a TSO packet is within the
range supported by the device, [88, 9728].

This holds for locally generated traffic, but not for packets coming
from a tap or from a packet socket: virtio_net_hdr_to_skb() takes
gso_size from user space and only enforces a minimum, layer 2
forwarding does not check the MTU of GSO packets, and
gso_features_check() bounds skb->len and gso_segs but never gso_size.

Patch 1, from Eddie Phillips, deals with the lower bound. It moves the
existing test out of gve_prep_tso() into gve_features_check_dqo(), so
that these packets are segmented in software instead of being dropped.

Patch 2 deals with the upper bound, which is currently not checked at
all. gve_tx_fill_tso_ctx_desc() stores gso_size into a 14 bits wide
field, so that an MSS of 16384 silently becomes zero. Falling back to
software segmentation is not an option here, because skb_segment()
splits at gso_size regardless of the MTU, and would only replace an
invalid TSO packet by non TSO packets larger than the 9728 bytes the
device supports. These packets are dropped instead.

As noted in patch 2, oversized non TSO packets can still reach the
device whenever the stack segments in software. This is not specific
to gve and is better fixed in the core, so a patch for
__is_skb_forwardable() will be sent separately for net-next.

Eddie Phillips (1):
  gve: fix TX drop when GSO MSS is too small for hw

Eric Dumazet (1):
  gve: DQO: reject TSO packets with an out of range MSS

 .../net/ethernet/google/gve/gve_desc_dqo.h    |  5 +++
 drivers/net/ethernet/google/gve/gve_tx_dqo.c  | 32 ++++++++++++++-----
 2 files changed, 29 insertions(+), 8 deletions(-)

-- 
2.56.0.rc1.310.g51773c2048-goog

