Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE234331A6E
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 11:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779191039; cv=none; b=gszAQ3iVHSdks5oiATg2h1VvX34uSRHI+wDbmUY6UrwsdHJdN6wRnaAM7W48uUvRzGGwao9R4hDHvcBOGwos/Uy3SAvheA+hF4OVDP+r2Kbh9qXPUSU9xobBQcuUgqRKsQYjhRVGb9Y5INjznGxmPczwYXi3BjfCa/ZteV/f9Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779191039; c=relaxed/simple;
	bh=j0n2i1qqb7QEx6yBlpknzaa36RFp90V6VCOjjqk1Ils=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=EsHtqP1UMtZyimy+0yzSp8ZK+DnywrXuu855g9Z1Iko5f2qZtAVmfN8/a7T4LlbbmYMFmS3ionA/G1MaEOURN+9cMVammzAK4QHh8KZYZKRG6qt19YL0ggfoEQNzpNsLx/EtxCCqEw+9zAZPvl50tXkjFWzLLWLlJ2CLTiWz6tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nCRDMiUG; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nCRDMiUG"
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-514d2b22e7fso18579141cf.0
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 04:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779191037; x=1779795837; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0VV0Co+RmezWRKvG4qKGgjPEjU48Ujf0A5MCPMGpp0g=;
        b=nCRDMiUGhYDrjsKwD9W2DrSgBGueUKJkwV/qTT75ztyCZFBbUzw6gbksDeN3aJE6Ye
         +GFPQuntre9I56xwFsdauxDym65uSasn9iKRIaUadATME2u750OUidU4ezfEFxHtbRGl
         BOOaSEqO2n41LdbZNNORWtBNSbchfpHYglZxHhyERAy+3MgXURzXpeTV8A9GrQmnJYv+
         t2R+jFQ0SpQddB1YqM7AfbBCuLTMwsaMQU7r1hNqhKchOgV567rFJHKGZWK/YHMfVsce
         PQlrtWHLBmdMOCsowBCmfvzDFxmO+VtohQIvw3MV4IVtISqqZ/tRFEybV+wJ6xp/OePG
         L6Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779191037; x=1779795837;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0VV0Co+RmezWRKvG4qKGgjPEjU48Ujf0A5MCPMGpp0g=;
        b=ej722MGYIHfpl8b3Jpt6CWqJhG4tVUCrVamjATOAHMhbH4AZIahbskVzxk0NgOO8Ot
         Hl+PMPP2p2n9xlvqfPwY+JbdAf9qm7RewAKgKtG58rotlnwRkckyQ5fU+1Pc//owvjVy
         IEion0zmDu20H5KTCOa/nDh0nwlTrpvfLAiWO+Fr2qTIWuN14MaxCGTZcjW3kbMAaJC/
         bpDCOuexwtY7rVMWSmY/3fASEkyNCJovEwikWbXrzaOXdoAgQcz9upUI3jR45YQvbfeP
         Xwwr8VcJSY1/YmwU0xv5At2UofHuYonbT7HZq+GaTie98LKH+cNfbV8NPkEh42Quya/Q
         wgnA==
X-Forwarded-Encrypted: i=1; AFNElJ8JT/nkqS2xQpc1LMWkLS75iDN5sq/ALzfcTqzR6TwS8JI2laB2XSGauFuYenrQ+vWypZNG/Gc=@vger.kernel.org
X-Gm-Message-State: AOJu0YysE0Go4elbOIh/wBlBUVOLNxaibLB1tYPt5AiR+yCK7KsLpL4u
	jaA2bHoZguzjTWblMOVP1YM17QpS2ncdmovPO6GJBVDtdfdI+VOK2NvHktXCFcT2iqI1YU6oq7B
	HcJ91JvXH8rOJTw==
X-Received: from qtny14.prod.google.com ([2002:ac8:524e:0:b0:50f:d9ae:6d00])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:6a92:b0:50e:5ffd:deb9 with SMTP id d75a77b69052e-5165a27681fmr185686131cf.31.1779191036618;
 Tue, 19 May 2026 04:43:56 -0700 (PDT)
Date: Tue, 19 May 2026 11:43:53 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260519114355.2769474-1-edumazet@google.com>
Subject: [PATCH v2 net-next 0/2] rtnetlink: RTNL avoidance in rtnl_getlink()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Many shell scripts invoke iproute2 commands specifying a device by
its name.

This series improves their performance avoiding RTNL acquisition
for their (repeated) name->index conversion.

Eric Dumazet (2):
  rtnetlink: use nla_nest_end_safe() in rtnl_fill_prop_list()
  rtnetlink: do not acquire RTNL for RTM_GETLINK with
    RTEXT_FILTER_NAME_ONLY

 net/core/rtnetlink.c | 76 ++++++++++++++++++++++++++++++++------------
 1 file changed, 55 insertions(+), 21 deletions(-)

-- 
2.54.0.563.g4f69b47b94-goog

