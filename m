Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FBF2765ED
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 01:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787708404; cv=none; b=fLIxWz/OqPMqmcS6ziH9420gKh8m9bHprNjP1Y81sNeIy5PIYNy+IJEbwY8PX3J9bHED+ydP3l5zi96ty+4wLIFlDPZN+w42SARRC/b/GOtykfTZb6sWMFzpT7yUVGhSKAckI5QeMjTEqny8QNIMftw0nCKrUXML776URLzcDNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787708404; c=relaxed/simple;
	bh=xddEwg9RunMRuvB/k049ds1rBCYLv2ELWCpHxLMwfus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bfoHCWjZbW8LBDVL0/ZIyG+QBZ9Elp2gYqHipg+LZRgW6/0q5O6cUZ9T9VDJ4BaZG+yKNYU14QQ2RYBlHUZCI0Z8993A4Z8/qwdH8y6nW/DGw8rUUW+pby7unlH8lqqmrL4Ox0gWFSZF2H+UASii3JpFVTvnTZapVZQ59oRkB9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YFoWZiby; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFoWZiby"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3965d3d9ab8so463223a91.3
        for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 18:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787708402; x=1788313202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9D0ya7fAGHD4mh1WhP+JBRzlt0nXa7uSYqgCddP+Sco=;
        b=YFoWZibyJ9THs0OTsUudD2LnUXl4W3tn0eE9KBlZVzb95U94ymGYhGfYtC3Z5hTI2f
         jLymFKwlMIoHwur59BfZeR21MqmI7o7WaAt6lMh+XifUk9B1usC0CszpVUufpG7etk/I
         uucNDtjhL7r/fLhR2JrpPQeGxgePxmhAftqmJvsjq6Iu3soavwL8BEjs0Q+KFS/XyM+p
         pEn6iFi8ZhFRwJ6mPCE/ZY4T+mhGL+VAOzhkW6VrF2k3lh5ED4RK9lKnDllaY7wYRErx
         TfkyrSJjM1JvwxJAipciqVPy85DFpSAOGZp/P4uxJfuuWNfB4q/4CncH3A5dalyqZvDa
         KHlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787708402; x=1788313202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9D0ya7fAGHD4mh1WhP+JBRzlt0nXa7uSYqgCddP+Sco=;
        b=pm+bN566yvPJkmNQHAcwPwZ2vS/+8XvrM6g2Ot5BAcV40/h9iCEY4rAmgwlXcseMLN
         5p1uVYkTtIpiaOV71y09B9+3ABjRvehygl+Mgfsa344k+0wk9syXNNVJywyFbDUDbmf5
         6Fb8VzakgYMKEJC6hoIuKuhXYvGj8C+WuFhpu1AZcrVEG5e2RdYKqH30iZ5rWUprHoWo
         xtX7ULJK5SKCUSI3RR6Ny5WU/gRmFSI7zrmDno4KjRVp3e1zaDL2icnN8HCB+Cygys8A
         WWYROdyRf9hxjzrSVf8E9Fysgnf2IPk3YDQ6yztwM4EguLCWwowHGHB43k8+jfIBWbnG
         1Vbg==
X-Forwarded-Encrypted: i=1; AHgh+Rr7ffJ/hh81PAKAPsW64CtU50iY0OIqmWtpqil/Cu/vqomTrchv+ADBV6bn2zTe4tylOzUcQXo=@vger.kernel.org
X-Gm-Message-State: AFuF++k5Uc2WIr7BLwkXhp9wgqHFs0D2esvNM3oOUaIZA2iOjfxYmFKL
	8t1/71curBvC1I4MhsJQ7mZN30JBKU/p/52J6pDE/YzYsoj5tkr/BNFi
X-Gm-Gg: AR+sD13/Tckak+dOumOJFo3LbyueIYZWTqOsBew/kxjmDBjNxq80FrKKKlasf9X0lk8
	7T++z3kCyR5icuH3H2nCM61BXRJDkV3G0/ZGi1n+O7gH01HOVIdx7Y+DxcBzcJus5N0rR+r/VFk
	AN0m2osON+9GeFd0UvRn3VRMIZpFMPJWluErnEdV3MTSrvaVlLd0lmgvlqWs3X5GDyiCk5upcXx
	C5qRbhiUfNzDFcpgcByO9cBp3hw+0WHUpu3gLuwJOHjxPYWYRVxEaNlp1W9pwkx0l/lC4719uFk
	qX35wjoAR5MUm0YOBtp2KrGJlsmsEJ14eQOcb4ivgL6WQHabuvtzyrsqD9JdPpcKpreZFiBKJbZ
	xpcntEbJ8u9LPxSoBQfE2xKWLTl07nMuZiXjp0G/G9j7zutEWRxygnuoXksWhjcPq1GzoW0/e0y
	9D56l4OHthDuKXjs/rgJNOBhW+OiTUqd5s+Fq01qJTyWEfQJh37njxPm7aBupl5bv41hElw0RO
X-Received: by 2002:a17:90b:3cc3:b0:38f:18f9:785 with SMTP id 98e67ed59e1d1-3966d20cde1mr7186084a91.8.1787708402417;
        Tue, 25 Aug 2026 18:40:02 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3965d119724sm3674887a91.2.2026.08.25.18.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 18:40:01 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Hagen Paul Pfeifer <hagen@jauu.net>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/secretmem: properly account locked pages
Date: Wed, 26 Aug 2026 10:39:48 +0900
Message-ID: <20260826013948.1325213-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260822-secretmem-accounting-v2-1-fe445a7c6eb1@kernel.org>
References: <20260822-secretmem-accounting-v2-1-fe445a7c6eb1@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Lorenzo,

I tested the exact v2 from this Message-ID on its stated base with an x86_64
KASAN kernel. The supplied memfd_secret selftest passed 6/6 in three boots,
and my accounting-boundary suite also passed in three boots. I saw no
patch-attributable KASAN report, warning, Oops, or panic.

A v1/v2 differential also confirms that v2 fixes the CAP_IPC_LOCK creator
delegation issue Mike identified:

  v1: CAP_DELEGATION creator_cap_ipc_lock=1 receiver_uid=2001 receiver_pages=2
  v2: CAP_DELEGATION creator_cap_ipc_lock=1 receiver_uid=2001 receiver_pages=1

I have one policy question before adding Tested-by. With a one-page soft and
hard RLIMIT_MEMLOCK, a non-root task whose only effective and permitted
capability was CAP_IPC_LOCK produced this on v2:

  CAP_ONLY uid=2002 cap_ipc_lock=1 mlock_two_pages=1 faulted_pages=1 raise_hard_rc=-1 raise_hard_errno=1

Thus ordinary mlock() of two pages succeeded, while only one secretmem page
could be faulted. Raising the hard limit failed with EPERM because that
requires CAP_SYS_RESOURCE. Is this divergence from ordinary mlock() the
intended consequence of removing the CAP_IPC_LOCK exemption for secretmem?

I saw the planned selftest split and cleanup in the follow-up discussion. I
will retest the revised patch before adding Tested-by.

Thanks,
Daehyeon
