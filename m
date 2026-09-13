Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF82283FDC
	for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 03:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789270365; cv=none; b=llAJTriVr/anfiJN7OZFlCXdpwBvfnbuj84Spl0Ch9O5SMv7uMESWORr62NeadmXQqTZPZQqNNAalt3CiqIXC831jScT7D/WZ9k8dAWMVl3W8ruTLYWPLU3qKU+bIe6JXQAsDwGTBzmT5NtHHpOc6O1wX6UdkSJyTh19EGYXsYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789270365; c=relaxed/simple;
	bh=kCvbVwZC83we+errokyP7K643YD3vh2QxPQNw/0AuPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sO2J4y9hUY+GVl87hsKxcU6NanoGVZQ38Ebwix+/Hi2SO86OSj7YomwOmIfu4rme1sL1uYMXJ2rZIooHbnAfZtzEwdgoevMova5pt04nUUB80RgTx2RP7Vd1GjEM0BnMZpQgzFlEPL0UNH8bRukwxHaOrhWjHWzsZyfkjDUM0Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YxzJVUzP; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YxzJVUzP"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3a49d2b18d5so16620751fa.3
        for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 20:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789270362; x=1789875162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zMZTr/1imyQVYMPCbe2CDQylZItl7GAC+PPMeDYEaLA=;
        b=YxzJVUzPcOQO3IPLgJihQI2ShRUZ9nIZriqRkItz3cW5PrtidhOdIP1UI3ICDRwuz0
         RfWHzWKQtASqBjKJ+9OEHRBdEeOu6Q08YPpfMfaV8VoJBTylgqTK6ZrEZv5ml22ELsO9
         SkSNooaMJPzSdOmtSOg25zOWT9/l1JziyaAVkHsoTguN42t2zJbCHBeJqGxDpkAcfs2I
         jriUsr+BNIVeoZVDdElg+RghWAcImwCbBtVi0ZZVlipZXogecGtPvRJAbnTPQMBGYFXk
         tYX3hg0vYQn28RSUInppjeoadW7q37kxAwcbNoW9PNOzOAX0LLDEvN+QMzDVOSUtAy2d
         BYgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789270362; x=1789875162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zMZTr/1imyQVYMPCbe2CDQylZItl7GAC+PPMeDYEaLA=;
        b=VnvPI3dmK/paXN/+qo72MlhSNV/98Yf9VUX0t7iTahXRFeiGqMs1FzXmHoVRHTvYPh
         +hIRWwhUWrgnFOAdWjADkrNX2SrrrQGLOszAqlLYI7xyD4oEsNolStt3eVZknWCXWW1E
         71N3a3vTgwkvWOZ5C5ELD6tvnqrcHZdpIyMUjD4QhD5TH38cIK1Lr6Pwa8OOmRtiKNas
         b8FJWlcoN9UqzAkK4qMhY/L8XoFIOkpc+qP8yHgpMCr3Bel17rnsloRftyw2zAT/jW5F
         pB+yKU1x6LkZqQFkIFn0XhRk0z27hO3V2l/J2IWwtQhoNYp6yRthL8q3RVmjxWBVLlmh
         wAsw==
X-Gm-Message-State: AFuF++nztMeYCix6fgX8hPjCtTOH1CuoO6AuLUaN06taK0uLJtMgz+Lr
	+KpZqo7pazZl1GqIebw4mJ1DP7TJWroNdjnHdD4xaQlxg9bagSUlVcky
X-Gm-Gg: AYBFou3RJONKakCwln8UX/mLsOLJG+txUVlemC3mjx5/F13KyAJUCQdHXaq2R04R14x
	40AUtAmOAKCc+r/ExhvRbWMDpKrwC6PPfj7MThMq2cHF9T7aWVWxdSrv5MuDHc+UDhHQy1On9VM
	eeBIyyYnVA/Vnvf2ZSNG/hiIXxLN2P/rq4nVKv6HmWvpxeq8bFzqkVl33oQX1mP8+PWst8jpz25
	5euOJ+iuuFFc9rqnQX51OArKH/q9xI634yrXwDE0jLTt6bQlwTabE6C89sysRvOdAEy0RjyYY9+
	U/IEhALNatp1KhJzvBxFZtowAhOdVh9H+lTeY/r2dugCUIP8oYG4/RgTwvdTbwJB0B9S50WrWy6
	uOKmlQd1sdfAg7X8ffqUJ2xlANTMuAPL5zC1QeCo8MXe66EZY2DZErFoy135n/Lvmri23HO/9QD
	eYrtbXUJocuQqXOnoD+aYJ45TSSpqH/yWqov6C8s6nlDLDxY01K0MGuTgYANe0XDO8G8eUrvzEA
	2g35nUilg//EA7HdpLVG2lTbpqpI7/d7cxQwThieu4A
X-Received: by 2002:a05:651c:19a0:b0:3a4:d4de:bad0 with SMTP id 38308e7fff4ca-3a5a5022d47mr13760621fa.19.1789270361516;
        Sat, 12 Sep 2026 20:32:41 -0700 (PDT)
Received: from dau-home-pc.. ([95.139.134.117])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a5a33a1cd1sm17024041fa.42.2026.09.12.20.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 20:32:39 -0700 (PDT)
From: Anton Danilov <littlesmilingcloud@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 01/11] ip_tunnel: add drop reasons to the generic RX path
Date: Sun, 13 Sep 2026 06:31:52 +0300
Message-ID: <20260913033213.873609-2-littlesmilingcloud@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260902184718.64ddca2d@kernel.org>
References: <20260831215137.549324-1-littlesmilingcloud@gmail.com> <20260831215137.549324-2-littlesmilingcloud@gmail.com> <20260902184718.64ddca2d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 2 Sep 2026 18:47:18 -0700 Jakub Kicinski wrote:
> > +	SKB_DROP_REASON_IP_TUNNEL_CFG_OPTS_MISMATCH,  
> 
> This name is way too long, maybe
> 
> 	SKB_DROP_REASON_TNL_CFG_MISMATCH,
> 
> or
> 
> 	SKB_DROP_REASON_TNL_OPT_MISMATCH,

It was the longest name in the whole list, so fair enough.

Took TNL_OPT_MISMATCH in v2: what gets compared is the options the
packet carries against the ones the tunnel is configured for, not the
configuration as a whole.

I also renamed the two other reasons this series adds for the generic
paths, IP_TUNNEL_OLD_SEQ and IP_TUNNEL_ENCAP, to TNL_OLD_SEQ and
TNL_ENCAP, so that the three do not end up split over two prefixes.
The GRE specific ones keep the GRE_ prefix, next to the VXLAN_ ones.
