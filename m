Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B094C37FF6A
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 19:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788205979; cv=none; b=Y7HKRJs8pVUvNm6UyBVjl8mzkKmsbZsITMqCVoPCQuY3u3w02B2uRHtAjUIHJ8QlPiVNjVgXy8iVCA19PwHARthHO10HSSOzudLx3yH1UJEhihX62Bh53Am0JiAGZAd3AaQvtZevyavHJlHwj3DkxzJP3yYDBwrw/0lAwAiwyA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788205979; c=relaxed/simple;
	bh=/zl8wY6TVFp7LoblMONX5vOgUc8p+oWSg/xEnWuTjnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BQkDU/E58BVjdcPwyWBQ8btGZXA4Sbdd55qlYMCB21TP1+lLAwlAQkqhnk7zXsRFtJv91JQdHnY4kZxoih3FpcSmYwi2nBTI4gz8olMqvUyOkoSGnPMAy8ZtAgG/wUSbl/IS41pNxpBvFU5HL23Q0k2zNvbtwUrIGyaX3eHzv7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=UjAQUBpZ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="UjAQUBpZ"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ce98cb8165so2802415ad.1
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 12:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1788205977; x=1788810777; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GBtl123r0qPUkYpJ4sDiuLzxWfXta9JzxkaMn6Qm0cs=;
        b=UjAQUBpZ8xUImRey/6SIa2+bQVuy35INcK+FFAfNgrG7kjlTSbf8aoPRaOHTnfIZV/
         ZNLUqr9v+tPzCVgYsLOTsl5oeS3iMJGuyi40w6c/h12psSY3PwBiP6oDkAccHSpAfrFL
         C+Fth0WjhndbOB7pQpxkwB9gIwMxq0yRau8dVuhll2TJRlCUfov0bHrq/NeTEiq3Cb3P
         Dxztaw8lK5Qx1MuQYNCDvgBh87NAU837NHuqz43mLvTIxMIvcxxWUeiQZVjIXwKH9VYY
         QUEXLbQ/OOzH0SKJBZmbT6gVhySDwP+dqLHzAkLAdQIrr5UpxhvQVMXUR1KE4KVINwXk
         vlEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788205977; x=1788810777;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GBtl123r0qPUkYpJ4sDiuLzxWfXta9JzxkaMn6Qm0cs=;
        b=eGb8C6iKWfvQ4sSW/eTI0NdsMwr8/5JN6XIfIUWTPifyUKBPGR2jMQ0JNWsF3Vf0VS
         mV2A6FKOGDIuoNURXULm/2LUsS4oMBBF4OSUlRQ8DBBzntZixeiohW9Y1CwCLHoOI9cL
         yC+VUT65iM02NoqhqNWDxNvsSSfafbGcamegwq+YPYo2Jyfw7zEbrEOgJQUTpK3YgMaW
         PV8dTywQqfEX/VJf78Yn6l0ONrIjDtwClX5posLZzsVbg+HsjsV/wNK1oSeldvudlBh7
         lC3WRt5EeY3TzxdTsAdxecuir8grY8p/p23IB7bYon4VKEh+fjwUs8Ut1W1ktj3GOwno
         gUxg==
X-Forwarded-Encrypted: i=1; AKwUvBzk9DGAISRohIUoYKE7yJS81xYREcRISr/DU+m831hEme5gUNe6x+wyuf/UOJ5AiU6e3lx+pvo=@vger.kernel.org
X-Gm-Message-State: AFuF++lsd5nnWRFpL0XJ52Mb+jM2aBnr+n5bz3PVq3h0bF/4/s7bwOE/
	Q59x6KWh0BioM7UraINXHA1BzML0UoC+2RPLo2/lIc1TsuzJp59KUlpDaYFgDlcXAKo=
X-Gm-Gg: AYBFou1Eh3B/LZMSQ2jr7DVWvPcEjXnRYEwIEWWQ2m4GOxW49guBgsh6KpR+b0FNLRI
	/7S8hG9VVSFP76Oxw2sytw2TQsaYTBfrXcnULBtdWqkN4UZtqKZwgLR7MxP2+8rizZ6RliU8V4V
	/nIVSUIjaKFrnnEB4KxmWehJ8FavhyZcOrqNFh4/7ss8p58Tj5aod62NCqSoeY+vX1IrdYzD8q4
	kpC41w//EHClmWXSaNydJdeHfd9Yz1l6B9Nh47KbLMhvmBCZ76LypF0axGOs6WgN6sOJ/TIe+Bn
	aWWlM9OJDtDTAY8hthcSh+XSbilfrnQpG3qO83ATBiJxmqbSTu7sFP/9uu79EYXkQ71Q8jIwpwa
	zoq4qE4n452ZLDWQ4SOrSWDHVbXESsDTyVkCzKSS5+ZbDnzFP2Wa+/P7gyTTHA7WTnt4qkiI6OA
	iGssnWM8YuR2epplte9Cn3rGCXfcU+5RZVTQmEhYpcgEYMddTfYKXrrQ==
X-Received: by 2002:a17:903:2a8e:b0:2ce:b3cd:7539 with SMTP id d9443c01a7336-2d9527fcb10mr4767035ad.6.1788205977086;
        Mon, 31 Aug 2026 12:52:57 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:40::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d8fdf63db8sm27557455ad.27.2026.08.31.12.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 12:52:56 -0700 (PDT)
Date: Mon, 31 Aug 2026 12:52:55 -0700
From: Joe Damato <joe@dama.to>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shuah@kernel.org, willemb@google.com, petrm@nvidia.com,
	linux-kselftest@vger.kernel.org, noren@nvidia.com
Subject: Re: [PATCH net-next 1/3] selftests: drv-net: hw: rename gro_hw.py to
 gro_stats.py
Message-ID: <apXblw7gc6yZs9G6@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
	willemb@google.com, petrm@nvidia.com,
	linux-kselftest@vger.kernel.org, noren@nvidia.com
References: <20260831163734.1121891-1-kuba@kernel.org>
 <20260831163734.1121891-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831163734.1121891-2-kuba@kernel.org>

On Mon, Aug 31, 2026 at 09:37:32AM -0700, Jakub Kicinski wrote:
> We need to free up the gro_hw.py name for the HW-GRO half of gro.py,
> which we need to split by mode (sw / hw / lro). The file checks mostly
> qstat counters, so name it after stats.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  tools/testing/selftests/drivers/net/hw/Makefile                 | 2 +-
>  .../selftests/drivers/net/hw/{gro_hw.py => gro_stats.py}        | 0
>  2 files changed, 1 insertion(+), 1 deletion(-)
>  rename tools/testing/selftests/drivers/net/hw/{gro_hw.py => gro_stats.py} (100%)

Reviewed-by: Joe Damato <joe@dama.to>
