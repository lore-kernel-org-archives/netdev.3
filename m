Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5083D76
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 00:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783468933; cv=none; b=su9yM3YctzewxZmyxFCI7bat/0muyiu5t82HDvBjBO6FJeQw45wP/2j+tH/1K9WP/74sTU8JJQ9H4TsGrZ2EQrDdOWLwgS3pzKhZI9Qd0zF4HshAqZVEoVdEg2ExALYCWlp4SmVMpuWSnb/+JbdahbwOwrWvKdRTTp8waI/hvhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783468933; c=relaxed/simple;
	bh=95wHC6qiN8TEdVa3LrFPnphM5FluRSTsvofXefR9K7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hBdQOKFCaqgZT6AIluUuQkfrAveBHhUvaeXMdj8nmOzDSpA5Fl+lgSkpj0SVey+9tV268ChFhcwSrnbYwRxEZxJvbfcTINSfDh6zYGSTDACe2WgnGH2SVFDl3RctXVka/MnPqSN8W1ETZFgZgM+ZYB8Jql1vrtzi0J0IzZGFKzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jB1wnKn6; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jB1wnKn6"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47362928f65so78367f8f.2
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 17:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783468930; x=1784073730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4AjRvNEy8d9TAoUQfvbBJahv1OiUfmk2jEl3+xOC7sw=;
        b=jB1wnKn67pd58f8Wy0QuoSQc1hzvTjb1Qjm8tgGJYsvhVgiTymF26waY86rFDmW1wO
         yl6OqMcJycRxenBCnyJTdPIdw6EqCkLkQJGw4nkbbwsi4/5obIEmsdm8Oq//ilnO4ZjU
         daXfbZ+biNHF62gC1Dy69MTUaH8bNfKsKjhp0at4LO9PxCqlhvongXupSTqI3t6dsItr
         K1h3rxaPfF7EmSp0HUykreAK66sSBd7WbhnwcOmux+jYl6fnvlTkmcKp9wIt2EW1TOZM
         VWkEc2lwtXtaT7Fgxu1Q8AOscjyR1Xxp4T0xuPKchPantyY8kKAkmUdry4X5+ulOgMgC
         /y/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783468930; x=1784073730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4AjRvNEy8d9TAoUQfvbBJahv1OiUfmk2jEl3+xOC7sw=;
        b=jdYquCahT2ZsvPQRJdAmewDw51WbKill/lE1D4+NrzjOu6DEhS8pZVaptakHH8dfk+
         ENlOvDjELej/MrgkOWT2elzzYAdLfP6zZXLfNs8HEgYPjBEEAH5IOL5/WL40zDhn8vKa
         CiSewvUkdQccYxGyGHA3V3K/EMXED9ZaWIv8AZr56Uc4dM0B7QIvr1rsI5cblFS+TsfR
         hEaxWoQRzHCF5cqI4cMFjk7BDCdtq2RtI+JgqdF546LB6G4TAtUJwYGgQOnhiS7I/+Ae
         UbctFODFZw5JqRMc8xvWRQmD5CkDfFLP6Sa/jAdJuH7w5TCprddNvvfnQbztFXuEZ7jr
         ZyEw==
X-Forwarded-Encrypted: i=1; AHgh+Rp4UgDdC+fCfG+EgWzOT0tV5xb0Zt24uvQ6Og6EbEsNSJxW7xvFj2CdnsEh+cEOBxMmpOB3Mpw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBwEtKc95MIUk6GI52c3ulIHBjFZ+N+Ir7iKVBQBo4/kZ3/sq3
	Ri89DnhDRpBbpNVdr3n+lOdkYMF1p110oLAkC83vahtnzAtIRmpsVOj1
X-Gm-Gg: AfdE7clwDYavFkvRU/yVf12Rca9uYGqX3aO5nQz0miODR7qA3VMoKk4Frd6AA+6eswV
	BkNNRpnkOHfsJckHiAH14S9BPHrfRV4IWVPGnIJcM9xSDIehFrB2CguUS12Mz3l0bTooCP2dgcj
	6w1IgLqLW4JE6wKu3IzHwKosdBplnLbDMt7FnVOpqyeBbmZXgudsdnIGmptbm9RHcJK5s48N8k8
	pXQaGYtaGIDxddzyS9fSoOy0TOplhwx1fXlhozEsxZZGMnSl6o6eUjvO9OyTzFSYwZ9v8028qJC
	ULPvAJIToiGCx9+2prtDCCXD1NLvKI4HBGI7EZ3/pS39XkydgqbigkEqJk0LK3c1cG6f7Fs+bqs
	0UN79bM3KpJ/eegU0beHpGCy1ZjvTX8WqOWq6IiN2ggBcCCtWSvImikHgrUq+qydKyULk0z+KQk
	6ig/BWbqm6KWwVKkvT1s6yho2SzzLoSwESZR/NZVsNac+EICeX
X-Received: by 2002:a5d:4a0f:0:b0:473:b32:ff28 with SMTP id ffacd0b85a97d-47de6644b7dmr6091302f8f.34.1783468930316;
        Tue, 07 Jul 2026 17:02:10 -0700 (PDT)
Received: from localhost.localdomain ([151.189.113.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0a558easm37682394f8f.27.2026.07.07.17.02.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 07 Jul 2026 17:02:09 -0700 (PDT)
From: Nils Juenemann <nils.juenemann@gmail.com>
To: rjethwani@everpuredata.com
Cc: borisp@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	leon@kernel.org,
	mbloch@nvidia.com,
	netdev@vger.kernel.org,
	nils.juenemann@gmail.com,
	pabeni@redhat.com,
	saeedm@nvidia.com,
	sd@queasysnail.net,
	tariqt@nvidia.com
Subject: Re: [PATCH net-next v14 0/9] tls: Add TLS 1.3 hardware offload support
Date: Wed,  8 Jul 2026 02:02:07 +0200
Message-ID: <20260708000207.64401-1-nils.juenemann@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260707232325.61396-1-nils.juenemann@gmail.com>
References: <20260707232325.61396-1-nils.juenemann@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Jul 8, 2026 at 1:23 AM Nils Juenemann <nils.juenemann@gmail.com> wrote:
>
> ... so I cannot run the crash> struct queries against it.

Follow-up -- I recovered enough of the truncated dump to read sk after
all:

    skc_state     = 0x01   TCP_ESTABLISHED
    skc_family    = 0x0a   AF_INET6
    skc_num       = 0x1bb  (443)
    skc_dport     = 0x0ba2
    icsk_ulp_ops  = 0x0
    icsk_ulp_data = 0x0

Both ULP pointers are NULL with the socket still ESTABLISHED, so the
NULL at the fault site was not just a transient register value. Does
this point to RX resync racing tcp_cleanup_ulp(), with the resync path
holding no reference that keeps the ULP alive?

Thanks,
Nils
