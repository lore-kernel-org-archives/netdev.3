Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793077228;
	b=thDEXbV88rhHFOvlqTfuUpqsTChNGMjHAY2OTHOPd0vmjJoaJuwgX75Q21WOvLz5vGBr
	 0J26Oo9+odCxB+qHwHN0r+PHIa/l/gy4HYAITmPg6rMZ2D+ylVV7+eFF0Ucxt7oYRvRi4
	 i2CqqPkO74i1Fr5wrupNr6Q5wnxS9ke/4sEbAeGgSsqirqI5c+ECxaQP7tyz4WtDi+MhT
	 rqsE5NzT6ZkIYlqJjiKEY7witR+yglo5IA+rqrkoAgz86nstw9pG+rgXBB3WOS4lFZqTk
	 6aM75Zq3yUzJSIZXxB8lVkDogscKVABPADQIlL2iuVug2OEiOPDg4AzhimFZqY5sORA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793077228;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=VKlzwEOGjd3COIGAE0R3tUx4IhOQwWvT6uNl6vvO1FU=;
	b=fQ+trKJhIky35/0WywvSj3WkzSp7rkwODgI5HTpdtYVNfJCcXLsco1L2Tm1beeeDAcR9
	 JURCXOSMtJCI9gCHa/OCV/NTNUpy0gfTKqIbbF5nZtAv9C7itbej4DoR/wlkHlwoOFP/L
	 9KurnTVFy9Ms2bwjsYuF0nv9v0ZnzqwM85wBCEjZksLjirAJ52Qmcs+iVt6CxJiaYc3xU
	 1YosUkSSdcQV+jzcHpCg1IW8g1GcOatvzEervhLsU+jB8pNjjFV8a5l9/cmtlsUllMCxZ
	 73iKGwait0HCyKTyLYD0DvkAJGh724OUXzsDlFR/Wc14emdPCcARa4KwaNNTINwGPSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=VHMy86sm;
	arc=none smtp.remote-ip=209.85.214.197
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9730606A31A
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 05:00:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9730606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=VHMy86sm
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2e9572e892dso31046735ad.1
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 22:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793077227; x=1793682027; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VKlzwEOGjd3COIGAE0R3tUx4IhOQwWvT6uNl6vvO1FU=;
        b=VHMy86smowF3rsQFe4WjOhKRk+rU/7dhV+NlV0rtV9NpvDmaiQHwh4r7HkYqPfFy1d
         sNPYVEk0Xv/MWEcOna+Q6DPa8nrXy2IAesqttpdRKF7ndhEZR3RV50XYuOi+oDIal8+K
         iKBJuS0yOTqi4PZ2S6KrxQLHWY1vuS0PtkHletoTYCjJXSHRhR3XMePS/SzoWrmpAWoV
         HqmTA5g5UDh/NxZpaT6Pt7eVIQMqt9Pb8zTj2puLSpCYsQfoie7o3n6A4vnJ6pLsTro5
         Fb2BTNhQwxZM93qKAk6Z+cnVNCWyhLt5UscPjndfKr0w1d3B/INqWUHqKLhEzmcBl0h/
         ReBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793077227; x=1793682027;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VKlzwEOGjd3COIGAE0R3tUx4IhOQwWvT6uNl6vvO1FU=;
        b=EIr/AjSlnQjxhh4U41zVfSgaqMIHGcvE+nabZ7I4Nk9jknb06q3ZNVGgZQnKmHmzh+
         at3N+g7NWW1U2dH/AKNYEmjfdtc4ALSKLLnCGK7m2LBZ0DBXwBH8jAUn0jGb/E/x1JXS
         rRN+N0Gqv91rPk7dQUGdUCfVB+K26ArlZKFrcLWtnnDEe6MuhaJ9p/4qblegY3y7xTRm
         qs/chmG13w9IXK0clJIBqC1rHOMxNMI1mL4oOceav11MrzqjInDboa/aKl0hmd8YDSd8
         VN30IqkdytfNv/ZLnBgpnE4aTmifNRFlab6FaXjxHwJo6mim7HPLWmztEE4sf9R0J7wn
         xh4Q==
X-Forwarded-Encrypted: i=1; AKwUvByXZzym7ShXlKDHuDrre2SJ9dr90/w/D/xZSyyCfDQoc1zbGbMCxnz+d+8+NPFfWOySinEL1es=@vger.kernel.org
X-Gm-Message-State: AFq9FYK879Q6AY3F1VsI8Ka7jFNEPSvlgSSzdZnNjWh6lonMpsJi6vTb
	xObRd+zTSu1qY2tXjUxXgliIvmZ8k0IlNHVfAQQYqcsZ3DhU0QqwgWsPZSStWVN+jT+UL8sVKV+
	GJRRs8w==
X-Received: from plhv13.prod.google.com ([2002:a17:903:238d:b0:2e5:6ae7:d701])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a2b:b0:2e9:64b9:a330
 with SMTP id d9443c01a7336-2ea9c6c33f5mr81544755ad.11.1793077227063; Mon, 26
 Oct 2026 22:00:27 -0700 (PDT)
Date: Tue, 27 Oct 2026 05:00:26 +0000
In-Reply-To: <71c142b2d45af6a2fe7fc6cd4a5ca52c53afbe23.1793075984.git.zhilinz@nebusec.ai>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <71c142b2d45af6a2fe7fc6cd4a5ca52c53afbe23.1793075984.git.zhilinz@nebusec.ai>
Message-ID: <auAv3AoY0FkcXIEr@google.com>
Subject: Re: [PATCH net v2 1/1] tcp: check congestion control restriction first
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Zhiling Zou <zhilinz@nebusec.ai>
Cc: edumazet@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	ncardwell@google.com, davem@davemloft.net, pabeni@redhat.com, 
	horms@kernel.org, jonathon.reinhart@gmail.com, vega@nebusec.ai
Content-Type: text/plain; charset="us-ascii"

On Tue, 27 Oct 2026 12:46:49 +0800, Zhiling Zou wrote:
> tcp_set_default_congestion_control() takes a reference to an algorithm
> before checking whether a non-init network namespace may select it. A
> rejected request returns -EPERM without dropping the reference.
> 
> This affects module-backed algorithms too; BPF is not required. For
> example, after root loads tcp_bbr, a user with CAP_NET_ADMIN in a
> non-init network namespace can repeatedly request it as the default
> although it is not in tcp_allowed_congestion_control. Each rejected
> write leaks a module reference. Since module->refcnt is an atomic_t,
> 2^31 such writes can make it negative; later module_put() calls warn,
> and rmmod can hit the BUG_ON() in try_release_module_ref().
> 
> Check the namespace restriction before acquiring the reference, as
> tcp_set_congestion_control() already does.
> 
> Fixes: 8d432592f30f ("net: Only allow init netns to set default tcp cong to a restricted algo")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Suggested-by: Eric Dumazet <edumazet@kernel.org>
> Assisted-by: LLM
> Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
