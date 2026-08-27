Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2233927603A
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 01:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787793285; cv=none; b=HV2Sytmj2ymHc131u/EsT1owtVkxuZ4VdIAQmuvKDNE7kUxN6AVcZRz5sDB1Y8JbhK8UKAgL2k2ev71w+BSVD2/+nqsFvqGj3QsnrcrFPBqW7WOqI35hy2/nEx0WdIw340xyfTPyZ/m1ZaIpRe2A1Ul9kqbQSWHKab5KgDzQuRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787793285; c=relaxed/simple;
	bh=NBuM7Z8qJAkYuoJEbItk8rVmqNQCo+qHFYrg0x2wOxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A5b2GimV9FsHoGcB/dEKtdpBxHDg7ALHahMcg19VbauvtPqC53ELCFBHYL1luYoCVJp/beDaVWwFAiAYp2/cbBTK6LYvZbD7O/3vSodvVAuVgp9A9rSWbvyJD+rZZz/wL5nMXJzMk8aMkujuLcz7Is2wB81azkC0p87EwgZ0laU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N3AgovGt; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3AgovGt"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38dc69c74b8so1965914a91.0
        for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 18:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787793283; x=1788398083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NBuM7Z8qJAkYuoJEbItk8rVmqNQCo+qHFYrg0x2wOxk=;
        b=N3AgovGtE9a0FM6k1D9Z0Mqy5BbLhs7cDn9YJaPp/kCN9grQdyxmRfBPsYHnxUSMEw
         LmKE62+YO0t4Nl1MPDeFUVWXF0W2K7frcGLGQqij9ELdNmkpTpD+KdCnjgBFJkmRx6L+
         I93lOezFDNFa8TEHtfJ95tLFCom9TPZoXCbBDvvCHtGf/Et0o7hJbXSILwLWmjHgUwKy
         RXGFj74ahisT41Vr0iehUg1Fslrw9Hd5f9CZjb0cdkasbPOKvWs0TpYPdvPG/ycKiMRg
         SMJj2a+FLtvjUwBCXeiNe6d8gJCihOrr0tBlCSe/bZhks9GAvTdekaqNok8MtQmfrCTG
         ctCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787793283; x=1788398083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NBuM7Z8qJAkYuoJEbItk8rVmqNQCo+qHFYrg0x2wOxk=;
        b=LTVCbc4oezWqPYUNez6vtdtzyfupfqttiwU9c4QuPbEIGgDjTq22AXyfPcD/TOEMR/
         nnGR8irlh0uDUaEEjcnnPcbbKyrOZ4rNByBjrDiexLqye7S6gWP06FoaxwOrZDwLdHEl
         Fh932Xh1I3eq/Hsx0BwrhhSrt0wZeJ66ZoCdB8r5kd9z+QBRDEAB8Fa02uA8igDJMU/l
         1MPhoseca23BYhvreJvvDHf7v0WQ+mvRJAXU9sPOQHSDs99yDTTytDqXkBQlNLQTGH/C
         gvHWdlOCY4mDhTHrXMCl58d1FXr6UDK/FU+Vr4ucfNxXNQtVlo4VsWzK2q55CxpAENUh
         xPnA==
X-Forwarded-Encrypted: i=1; AHgh+RoHTyZXxW4o2aCpAWxOGXQw8Q1pSVk3nsm/OxfflxLodmCS8OsJNZFJYK5lop5Ld5Kx6R3yg44=@vger.kernel.org
X-Gm-Message-State: AFuF++mZYy4pt84CBrmB45Cawdrpt0W3KXAK+/CZh22Dp1XH9grt+VRl
	iKjOHjzlv0SQtsMx3kw8oLKr7oVOW32RqbWsVYjTL45Scc9NadBdFult
X-Gm-Gg: AR+sD13QWtjw/kOSJx0A/6gy+PamE8gbQ+PVEIs6XMsNalKI1PMw+HOAZDDUNBvHw+f
	qJ5YACYEMytDG+t7/CceCPcG4Ju/i6PdyBJUbjM+i3ThoNnbnCfshCjjRTC8sONKJzUWEQJXyA3
	Bea4efeOhEKpcINcTdGO2VtNCkBX/Zb0RhPpJGEnvlL1iD08o+As+Yyv3msX25IegUL8rcy7sNN
	nxIY/cqiK7hkjIBaGDiyVktV4IJdADoVaTleo8HrCrMNz07J5cgtF016lf94BLp1ASmAMpGrZ3q
	YKof75a5+Vo3BzMspJB0DYUUWUl/vwQi2kPiLs6rP6rehG7AQflAIHW0XPmfGfi5SCafC1KI/RA
	emhpL6HjNXxKR9nmqBMKuwcZ7E8l1kogzqomSqC4/YDUqkaj/B4zrGESOia/zK58pfm6IpySp1M
	ePGpr1hLcHIl7OCszmJupUQm7S7hfPMzlKQ0q+4UP6FG51JMH/5/12u4wMo8tBW5wdnaHdWaTU
X-Received: by 2002:a17:90a:e70f:b0:38e:11ba:992c with SMTP id 98e67ed59e1d1-3966d4587b7mr23563979a91.12.1787793283407;
        Wed, 26 Aug 2026 18:14:43 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396b0fd5c34sm461051a91.8.2026.08.26.18.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 18:14:42 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hagen Paul Pfeifer <hagen@jauu.net>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] mm/secretmem: properly account locked pages
Date: Thu, 27 Aug 2026 10:14:29 +0900
Message-ID: <20260827011429.1516473-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260826-secretmem-accounting-v3-1-94cb04399510@kernel.org>
References: <20260826-secretmem-accounting-v3-1-94cb04399510@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Lorenzo,

I tested the exact v3 from this Message-ID on its stated base with an x86_64
KASAN kernel. The supplied selftest passed 5/5 in three boots. My independent
accounting-boundary and capability/delegation suites also passed in three
boots each, with no patch-attributable KASAN report, warning, Oops, or panic.

The independent suites retain the mlock-limit and fd-delegation coverage
removed from the supplied selftest in v3. This tag applies to the v3 fix; I
will treat the planned separate upstream selftest patch independently.

Tested-by: Daehyeon Ko <4ncienth@gmail.com>

Thanks,
Daehyeon
