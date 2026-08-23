Received: from mail-oa1-f67.google.com (mail-oa1-f67.google.com [209.85.160.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82111351C0B
	for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 05:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787464413; cv=none; b=GdYxywm3AJ9kxCvdOitTF2OAS1FjuCpKsWQIOF/dWrspt+umWrJefP1G0MiUQf1+DM4Ffp/5hQQQ0EPXHcce25PxdAGL1QPklA06OpJZkBODdHsY349T7D3CQBm4PQ94oDJAEJ1WxPFDymw4gS+Flt8P61pmd1bxxqSj98swPWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787464413; c=relaxed/simple;
	bh=JfqXRx8JxA6qPctLPEMsVO4C6pDFgeqjl6rhl7NgLvs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JVE1K/cZMXpLWfZ6RxON7KZPXOq2H3BdjnBp8AThL+j7spvCrbW5Uf9OlOH9NpKz4PMVQLUuoCJGu4fULhCChBOKHlrK8wVMnxkhRSF1p5wCfeDbY1+d8iiHRrphWXWGVkN84aeTl/BJdEz4CGNGAl2fLJNMX7KfVSMYslerom8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p7EkG0DW; arc=none smtp.client-ip=209.85.160.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p7EkG0DW"
Received: by mail-oa1-f67.google.com with SMTP id 586e51a60fabf-448cf99c133so3367508fac.1
        for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 22:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787464411; x=1788069211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZwsQZAUG+S/BjqVWHNHMZh9+biN0VXGTHnyl6NsuJJM=;
        b=p7EkG0DW1Ys2XPtcQMw1r0ZucjR1KmoEka2z2zemSbivIDwGO1HeRuurmzY6mjeX/P
         M2Z+VPNs6YXtyrl/ExbTYcQ918sQPBNBUgizNrOyvRYU2L7HqTbqF3wT0VA5OiShUJxv
         to2/EtEtghdRp7sPcHnFgui2HzB/OgP3EFWlb6m1T4F0/jLP6V+cZHtwHMsiwSHOWvOe
         8DU3VC3/KLLnBoB7epxlnEX7t3LCCOfk5kTtptswG18589iVnwcnqu37GiME24FMbGwP
         +P8PvcgQm5u45cPIJcsNqVwZvNlTq+rNcafQxxdsMnozt0oMaqQBq5op+U+dJ7H9CcIK
         gFHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787464411; x=1788069211;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZwsQZAUG+S/BjqVWHNHMZh9+biN0VXGTHnyl6NsuJJM=;
        b=Skgyb7XL/jHJw5qAORkORHhslb32nrSNlnrNz5u0e6G8+SBGS78LTZARTgQmLCqYPj
         n7X1UteCZjsPwl+NJ0BiOHrrGBquBjdz4lynrn1x1JCxGaIlKU1BCNtoEQr2X2rvcjCX
         H6xAGYg8/xFwZn/8AmxyQPexL6uE5N6ywySaqJR93MaoJAxUAsXlCvxHLHxw1Pg2d/u0
         B0dPvWOWHHndgbM/2LzJ4tO1oDDXWydkliD1NDGewKZSfIXsZKoaaMP8VUrqDfMK/Mm3
         FqQ/SuGs5c7JNHVPXnwY820a/suXiu6oUWb3RjygXHxptsHqjnnWGLvg2ezCLHmFzlKI
         ks2w==
X-Gm-Message-State: AFuF++kwdV+DwW1qOZvRMfss4JrgT7EZ7J1Ih+B0ERH6JnRKnGg96J4t
	lfEetNYeJJ8uX82g2bFgHItbpv/DFVGzyNqWW+zcdckHlEXNlS93SG1ziyIQsix/dJU=
X-Gm-Gg: AR+sD10fVYreNMzWGMJbQApZKm1gCHNKE/t7mhJqVPbawkJkbuhAK63zWFK7+yFXQ5D
	7zOyqhOQk1VXSYWzhB/Y8bAAsMxXxynUc75DKBWCNkMQe5kVaXjGyAZCLXH0Yz9dKBS0aXIKhzD
	3Dggd9+33PwPIzuwGHwpH886jT0R3HIt1LRo5APu44R3QGU5ptgKAVg0Qci3hQF6SBsxGc9a145
	IWCiA9no8GgU9+GqsNED4yD0BHCl54wNqUBmiYubph8H5t4GNddRJZeC3rXltev0hW5RJt7Ai2S
	QX51xXG9/XruLK2XbxOE31+xL/MD4nDQulv+HYiFE4Sq4vIdlu0Am8dBgLsNhjhhlmfH0kzRE/a
	+BJjwHKfwiTLGS0rbeAdp9wCz+BZaPhvFS545cEaafT+LezEkMJsYwJtPq7m/l/pfeiwWTf+QPL
	9DJYBa6NFw4HCXQSkOerT6SdGUXo+MBI5QgoUPpWqRaA51q0QuqPx+j4BvcNlwXXPBLlG1w+PJT
	2C6dd+sShsda0sY+QC+e3MmVA==
X-Received: by 2002:a05:6820:8486:b0:6b0:b3df:5eb8 with SMTP id 006d021491bc7-6b1492ab7f8mr16732152eaf.18.1787464411324;
        Sat, 22 Aug 2026 22:53:31 -0700 (PDT)
Received: from localhost.localdomain ([14.22.11.161])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4638313340dsm2791832fac.2.2026.08.22.22.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 22:53:29 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>
Subject: [PATCH 0/3] rxrpc: fix three bugs found by autokbug fuzzing
Date: Sun, 23 Aug 2026 13:53:15 +0800
Message-ID: <20260823055318.371374-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These three patches fix independent rxrpc bugs found by the autokbug
dynamic kernel fuzzer at Tencent Yunding Lab.

  [1/3] Stack OOB read in TLP soft-ACK processing. A malicious peer
        can deterministically trigger it over an unencrypted
        (security-none) AF_RXRPC association - an immediate KASAN
        stack-out-of-bounds report even at the minimum offset.

  [2/3] kernel BUG in netns teardown: the conn_proc_list assertion
        in rxrpc_destroy_all_connections() races with connection
        destructors deferred to system_wq and fires on a healthy
        state, killing the cleanup_net kworker. Unprivileged
        userns+netns reachable.

  [3/3] WARN_ON in rxrpc_alloc_txqueue(): the TX_NO_MORE entry check
        from commit ae4f89989479 ("rxrpc: Fix ability to add more
        data to a call once MSG_MORE deasserted") is not re-done
        after sleeping in wait_for_space, so a racing sendmsg on the
        same call reaches the WARN on a legal finalized-call state
        (spurious splat and -ENOMEM; panic_on_warn DoS).

Thanks,
Henry

Henry Martin (3):
  rxrpc: fix stack OOB read in TLP soft-ACK processing
  rxrpc: wait for deferred conn destruction before conn_proc_list check
  rxrpc: recheck RXRPC_CALL_TX_NO_MORE after sleeping in rxrpc_send_data()

 net/rxrpc/ar-internal.h | 3 ++-
 net/rxrpc/conn_object.c | 10 ++++++----
 net/rxrpc/sendmsg.c     | 8 ++++++++
 3 files changed, 16 insertions(+), 5 deletions(-)

-- 
2.43.0
