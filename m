Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4862A37FF50
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 00:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791851737; cv=none; b=B7GuLHRsn3S2bzzES/CqaM+uUvlxtTV35ZzHqNbzvqH3TFJM4Z5pOhie9C7jv7CVPpfnsQskIuonhAF8IVs3veHSM9HKaINPmW9i2CkKaEqPvW2/LQHqFqcm0UUxes5Qcj2LwD1Fsz+fO+pLF9tmKp34SWjbXM3px/HTixil7/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791851737; c=relaxed/simple;
	bh=QQJSpZvnZuZRZv3AqYwjsMuTYwK7FWOLYPbNAlqNiSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TPDoA92+l2jVlwGLct9ftFgNHgDLktreW4ak5zRuDpL6ROsnv62zGuk+FlMYrQ7VuHINR/zcZWxZ7PqbmoFd1eVgrSuDTqSRx/PtpM0Ihr/aff57PoZW2Icv2/qhE+hce7NwcU+uTTUl64YKfQmqutTpUEx+t8tx2m3qjhvfquI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=nekJe6Jr; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="nekJe6Jr"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2dd9cbb661bso17249015ad.3
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 17:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1791851735; x=1792456535; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xp7ffet+WAoBGgrfCoR70F5a0BhOnrVYQ7AyIEEd7TY=;
        b=nekJe6Jrd8kySyVbMHszppaK0MW/Lj8uKeS6l6xS6uHwIv6gytzzbZWtALDqBwGoWp
         IEXYvelFTYbuWjtENfXvwjtHEL3KC6kwenMfuv3YUrZYhSKKKX0XWBEE4Dff00GpNGgx
         9qW9L0TKWl8r5Gb8MUoRO/XJeAwdU+IvMxiV3mSLF1A4LvGmrx7e/0hPil8htWal6+wN
         f/hMF3kxLIBsRN2E2vxLl6iS0ewy0a/7zoId5p/jMsLdvn5Q1Tw341hmuSowX633UG1F
         VWs/y394xhTtFNz14rayAcTJZmFzyS7iiAzkreoLSAr/1p49rA3jHyzRt5SpRRCCRtpp
         d+vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791851735; x=1792456535;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xp7ffet+WAoBGgrfCoR70F5a0BhOnrVYQ7AyIEEd7TY=;
        b=ppEXqT3SdB4UJytmy2J4ek/1Yq+b0tOaBjREYpOvoYz/gklPXIiReysZNobJYA+vIJ
         4MIFmGT4CClzqdtNOaLulcNNT/sEsvjMQs6CuePc4Hdb6pRpGYaa+VLeqHv/xAwTVrYG
         8LIpKk5N9ZSQV1+nEMgOMYQmvoK1lfvQnvvkkAf94Q3zDuEQQe4d8hyWtoV9nT1iLeXZ
         LZwYXxmJF8Qckmz6AiTnJwxwqAYFziUDKBlumsP4qfGyaEF4IBWdhhuZHzAcmeZOyHiD
         2sCXCwaVhQ/e/b+J6KEMNpJaJmNACvxFGkxmtwfTNTDqANaDwwyk6Wvr4J7j8OoQW8yK
         aB2g==
X-Forwarded-Encrypted: i=1; AKwUvByXy3lMh3ZkURHHbRd9MXwYQolH3DsUNIlxghvWZ0PJv6b7V7zado8gx5468h5PgO03F8YL+LY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIdb4RKKbIaSMsIh/zNC75JzMhBUPobyu7sErKFYxTv3uWJHPoW
	u7SnUIBfiUUeDhZeIavIA6lsz5oGVg8LZAwkNwVJYCdCxK56pkf/f6FpmgIG1sDGLqQ=
X-Gm-Gg: AYBFou2F25BAt6KsVrP88BFPTMiWqDqQHusWWIiS0XtVcUhkUdmyeqIcm9lP3mS4o08
	9ZRRTDmNKwMAossUKKvmrAYwCPOBZftqD6CGjyG9ajxbpRT8ah9moaofm3S930lAliDrNiRlZts
	Pyxkbag1RThG1bGq0okWIBBi5o7W/6q//bAoI1Rp22XguiBpVuA18bwoGent41VfaBGVH77ZYMo
	zRvHMJljC/rZdTxzV0SZr5Qz6+LfzPAgloHmZhFtyWjfRR0kPpMm5p6bJUrrGXFSXibfWjXVTzq
	EEPk1WoJ00nSDmAXDl8f0/KY7rLvC9fUBZzZGAdAOzUv/9t0sY6aUaEA9myUlDWttuxovWjkCgj
	9d0d7CQj2y8huzwbi/LZXWZ+dl7Sx/9gP27a0MP3tQZpgG/2+QuSXSBxjWEHfvKKDJ4mRyzm5SW
	QskNphYOv4mCGmWDON+3Uh0b0bwl+4mD4C1UyVbc4nrASMZcADiL0RWlYBOKnn1TSrgrEObXBOl
	tDtUMt52vOdKiHVJ3Bia4U=
X-Received: by 2002:a17:903:228c:b0:2e2:d83d:5004 with SMTP id d9443c01a7336-2e842cd79e8mr104518335ad.58.1791851735521;
        Mon, 12 Oct 2026 17:35:35 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:48::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e84219e8c9sm47795995ad.23.2026.10.12.17.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 17:35:34 -0700 (PDT)
Date: Mon, 12 Oct 2026 17:35:34 -0700
From: Joe Damato <joe@dama.to>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com
Subject: Re: [PATCH net-next v3 6/7] bnxt_en: Remove support for the old
 NITRO A0 chip
Message-ID: <as181oePAEaIBj2s@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Michael Chan <michael.chan@broadcom.com>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
References: <20261012220827.340998-1-michael.chan@broadcom.com>
 <20261012220827.340998-7-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012220827.340998-7-michael.chan@broadcom.com>

On Mon, Oct 12, 2026 at 03:08:26PM -0700, Michael Chan wrote:
> Nitro A0 was a very old pre-production chip that requires significant
> workarounds.  For example, it requires an extra (hidden) RX ring and CP
> ring to work, adding a lot of complexity.  The workaround code is very
> buggy and breaks in many cases, including ethtool ring changes
> initiated by the user.
> 
> Remove all Nitro A0 workaround code completely.  Print an error and
> abort if the chip is detected.  This will simplify the next patch that
> fixes ring accounting bugs.
> 
> Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 185 ++----------------
>  drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  11 +-
>  .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  12 +-
>  3 files changed, 19 insertions(+), 189 deletions(-)

Reviewed-by: Joe Damato <joe@dama.to>
