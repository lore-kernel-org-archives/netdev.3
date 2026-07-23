Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26109472795
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 15:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784821297; cv=pass; b=NGK6Pw7RESNb3CHeXb+ZQLXHH1eqU8dAJhmvtPME94Bk3+aDDBm24OE37UYHTpqDypKvoEa1B8kZUK+42tIhf2MJGD1PPOeC+S2Cq3XUNYuIIuJSnp/Kx2MLyBrDhFyi2Wf2A4+TO5iuQ40iWAykZgkowSoroJeNjootoiBfd/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784821297; c=relaxed/simple;
	bh=pI+5JI9JeW3qaHsHCrOzwnAwIxbzLeEtKURHX1NItgw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FYyOllm7cT5k1fzHkjvwDm3Y/ZZeDHT0ToZdsMj6mayq3VpPtt90owKuCT/UqbffT2/4Vk8kBCEimhTzu2qXtVmKPcvlxPDCm/ywX99YCH1YucPIf6k+M5XsgPBL0geTCv8lw7CswLtjF2kjDNE/noo3h7FS0SRWZZd2q2TauQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B+eYlhsq; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+eYlhsq"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-698c1df9651so175834a12.0
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 08:41:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784821293; cv=none;
        d=google.com; s=arc-20260327;
        b=bW7jgThb7r15vl/yVVmPcca6bMmaXUc49YFXdCesc+JiApyLrLJzAUbXkbgsZ3nKPK
         pYVQQqHJvd4bh6sG+9RxejoNYeR+PsY1kxF9LkAIboGvOms+e7OIgIK0Ff9HnpCtnIi0
         sNBuATqdeR8QSxZuFteuJmFJaVHcYgAdH/ethmsSiwEVpikySbzl4WfX+hR2QfR648mg
         kb5+V7CJMsQ062aWooAJAeZHXeJiAoYHXASBvNSM/LRdUue0cXX0M+N3vyAsFPVXkb2o
         5Bxx3rAL8zJe/DHgu6Ih29EgijEHg9/9Ue5i7MGnkrlK3qnEpBHy/CAJ7j0jPqVb5YUv
         R5ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=pI+5JI9JeW3qaHsHCrOzwnAwIxbzLeEtKURHX1NItgw=;
        fh=z+eXyHOIjgawkQ/DMY85OLGPqUm9i1lok+pnlxE4LS4=;
        b=B8xx9U8RBCHOG4nwOomuLVwufpPh6JPFQrgaMFYTETFCSqNYxoSJXZxZjocProaUU6
         RY3UFBICnj0ifh6WLEjMfY0d9hyQzIP1kD6aVXhZpoP0Mbtz26wKNfiB8AIMbSRxxW3/
         s6xha3EPkvBoVp71/GHE1qSlTAFtNNRU5VHg22FzEl9+8gWOaYahBgX9VTs1ljMzv5v+
         e9NRStQhnHdeSbtzbn7st59m+qez5Bwt6sTvcmQ6iNknz/Y4pRplv5J87U4YSG63zYtM
         vzz8Yqpld4jPchTCqcSyomxefox5aun2ZcTWn525LQmh/w2X3uiNmt0lT29zUKZq+Bta
         KWGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784821293; x=1785426093; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pI+5JI9JeW3qaHsHCrOzwnAwIxbzLeEtKURHX1NItgw=;
        b=B+eYlhsqcRPCBu2CnkJiqDd9Ev79YYDcM5Q9d4bYMPM3AfSjsmGbTx7a0Ch+kPjJ4B
         CtHqrenwqX7TRGVT03w8/HmZwuk2f/Vx2QnZjJ5pcHxg1QvF7EQgHD50UXl8xxo86Chk
         BVRtyObOl+XVoV4eGnQRb9o+yAHqmNkU3OkOD+tAoCoCUASSeFpuh70JVpO5kBDDmYAy
         DIq3BgtDKEmiGZ0HxkYc9hkoz18gquHZrLSUjUIOAgqdbnJZx91aQtGs0O/byaIIvr/y
         PgCBa2+6623xm09PiUL3RKr+qKAUiDSWYuyMwZ8TkERMRfDu8eiFsWvpopG4hplovR2u
         tevQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784821293; x=1785426093;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pI+5JI9JeW3qaHsHCrOzwnAwIxbzLeEtKURHX1NItgw=;
        b=btQq0QchsPc2YoJ3/knaSC71hcHTgBNA6ggLVDZnRO0hKQYk5A4qb8g3sYcQceDfE/
         tSKo5a8CbxRYhOeEquO3X8lzz2bHr2uAxiE0/HouC1CIDV8ast90ZkMW1qofP5PBaOkM
         SyGSTdGMh3y8FhJbgZB19nvZed+snc+5qdsMS0UrNcoK+drfGSSbzN7Gnk5DZ0XtFptQ
         bTl44BQqMpxirrSVciUsE2GWluGtbas1d9wO8v3bH9RAoST+1FX46qWM5ND5S2SpqIV/
         CJR6X1M+JFO+jkllJz/tUb5wJhdqq4zL/WV/y2SjetbJ+TSCv39b42CS/IvbAydyBrli
         HcVA==
X-Forwarded-Encrypted: i=1; AHgh+Rr90dEHbVZBrBHuaW6/XHo06/dNaUfBMKiCRjCyULracWVW2L2YglSOEgHoCkLUsNljHaObZJI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3y4tplkTmr/pNsY9WP8s91BXqaR2KOK4v13Dh1sWvK1L012Gx
	Dp/XLY77fO7nXxoMOjPNZC72ZP3jZ6bLObjmRT4ZwI5/SbMiKoapQkOrMx4brzuSg3XqJWVSCwS
	qYz4KmUDNsXEHUS14Ff51a5EMw182+RQTNRvaMkKPSQ==
X-Gm-Gg: AR+sD11QvjjBQOSyzDgddu/m0YlQB5xkTgbisORcj5u88SpkzOoj142HJyba+hN314X
	eIIBA8lOqprJh7B06GrnBpmFS4AJojtTXEl3axGbDQddG23uiiqu4q9OHTTv2sNWCw30rtQIl8l
	Xaq8a3SZR++1aow3efI6b6I4mMJEPMQ34+Ws9tHebvarm7LShXL8ON0jIRwenU1O7hlerztP9PZ
	AunhoigRLRiJbjqBrooyqBCnxSBR+OVMDc5SejHwRTYjYVAKHtcwAMtDxWpa6aMeDehWv6qguNy
	UQalZ8SBJjKVFYg=
X-Received: by 2002:a05:6402:1ecd:b0:697:ee01:9a0e with SMTP id
 4fb4d7f45d1cf-69f6ab3881bmr979483a12.5.1784821292913; Thu, 23 Jul 2026
 08:41:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260719161630.2901208-1-nicoyip.dev@gmail.com> <DK3O81WR05WI.ZR3AJUCCX424@etsalapatis.com>
In-Reply-To: <DK3O81WR05WI.ZR3AJUCCX424@etsalapatis.com>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Thu, 23 Jul 2026 23:41:19 +0800
X-Gm-Features: AUfX_mwzqO4WBcNnVnNaBug6wKkdEpx8B7ntUhhI5hwB56M1TW0WBGtfi_e10H8
Message-ID: <CAAo+4rVPJMDiX776OHu22KCfL7WnLG30p9r28NZYYgQZya8-OQ@mail.gmail.com>
Subject: Re: [PATCH] bpf, sockmap: Fix cork use-after-free in tcp_bpf_sendmsg()
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, John Fastabend <john.fastabend@gmail.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, Jiayuan Chen <jiayuan.chen@linux.dev>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, 
	"open list:BPF [L7 FRAMEWORK] (sockmap)" <bpf@vger.kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear Emil,

Thanks for your effort in reviewing the patch! I have sent a new v2 patch
to address the Sashiko comments on that function. I will wait until later to
see if any more related issues are flagged by Sashiko.
